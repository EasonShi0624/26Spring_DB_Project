from flask import Flask, render_template, request
import os
import sqlite3
from pathlib import Path

app = Flask(__name__)

BASE_DIR = Path(__file__).resolve().parent
DATABASE = BASE_DIR / "last_resort.db"
SNAPSHOT_DATE = "2026-04-28"
SNAPSHOT_TIMESTAMP = "2026-04-28 18:00:00"
DEFAULT_START_DATE = "2026-04-28"
DEFAULT_END_DATE = "2026-04-30"
UPCOMING_START = "2026-04-24"
UPCOMING_END = "2026-04-30"


def get_db_connection():
    conn = sqlite3.connect(DATABASE)
    conn.row_factory = sqlite3.Row
    return conn


@app.route("/", methods=["GET"])
def home():
    start_date = request.args.get("start", DEFAULT_START_DATE).strip() or DEFAULT_START_DATE
    end_date = request.args.get("end", DEFAULT_END_DATE).strip() or DEFAULT_END_DATE

    if start_date > end_date:
        start_date, end_date = end_date, start_date

    conn = get_db_connection()

    available_rooms = conn.execute(
        """
        WITH latest_status AS (
            SELECT rs.roomId, rs.statusType
            FROM room_status rs
            WHERE rs.startTime <= ?
              AND (rs.endTime IS NULL OR rs.endTime >= ?)
        )
        SELECT
            r.roomId,
            r.roomNum,
            w.wingCode,
            l.levelNumber,
            CASE
                WHEN ct.capabilityCode = 'SUITE' THEN 'Suite'
                ELSE 'Sleeping'
            END AS roomUse,
            rc.capacity,
            rc.baseRate,
            COALESCE(ls.statusType, 'READY') AS currentStatus
        FROM room r
        JOIN level l ON l.levelId = r.levelId
        JOIN wing w ON w.wingId = l.wingId
        JOIN room_capability rc ON rc.roomId = r.roomId
        JOIN capability_type ct ON ct.capabilityTypeId = rc.capabilityTypeId
        LEFT JOIN latest_status ls ON ls.roomId = r.roomId
        WHERE ct.capabilityCode IN ('SLEEPING', 'SUITE')
          AND NOT EXISTS (
              SELECT 1
              FROM stay_room_assignment sra
              WHERE sra.roomId = r.roomId
                AND sra.assignmentStatus IN ('RESERVED', 'OCCUPIED')
                AND sra.assignedStartDate < ?
                AND COALESCE(sra.assignedEndDate, '9999-12-31') > ?
          )
          AND NOT EXISTS (
              SELECT 1
              FROM room_status rs
              WHERE rs.roomId = r.roomId
                AND rs.statusType IN ('OCCUPIED', 'RENOVATION', 'RECONSTRUCTION', 'OUT_OF_SERVICE')
                AND rs.startTime < ? || ' 23:59:59'
                AND COALESCE(rs.endTime, '9999-12-31 23:59:59') >= ? || ' 00:00:00'
          )
        ORDER BY w.wingCode, r.roomNum
        """,
        (
            SNAPSHOT_TIMESTAMP,
            SNAPSHOT_TIMESTAMP,
            end_date,
            start_date,
            end_date,
            start_date,
        ),
    ).fetchall()

    room_status_summary = conn.execute(
        """
        WITH current_status AS (
            SELECT rs.roomId, rs.statusType
            FROM room_status rs
            WHERE rs.startTime <= ?
              AND (rs.endTime IS NULL OR rs.endTime >= ?)
        )
        SELECT
            statusType,
            COUNT(*) AS roomCount
        FROM current_status
        GROUP BY statusType
        ORDER BY roomCount DESC, statusType
        """,
        (SNAPSHOT_TIMESTAMP, SNAPSHOT_TIMESTAMP),
    ).fetchall()

    current_guests = conn.execute(
        """
        WITH active_assignments AS (
            SELECT sra.stayAssignmentId, sra.roomId
            FROM stay_room_assignment sra
            WHERE sra.assignedStartDate <= ?
              AND COALESCE(sra.assignedEndDate, '9999-12-31') > ?
              AND sra.assignmentStatus = 'OCCUPIED'
        )
        SELECT
            g.guestId,
            p.firstName || ' ' || p.lastName AS guestName,
            r.roomNum,
            w.wingCode,
            COALESCE(group_concat(DISTINCT o.organizationName), 'Independent') AS affiliations,
            COALESCE(group_concat(DISTINCT e.eventName), 'No linked event this week') AS events
        FROM active_assignments aa
        JOIN stay_room_guest srg ON srg.stayAssignmentId = aa.stayAssignmentId
        JOIN guest g ON g.guestId = srg.guestId
        JOIN person p ON p.personId = g.personId
        JOIN room r ON r.roomId = aa.roomId
        JOIN level l ON l.levelId = r.levelId
        JOIN wing w ON w.wingId = l.wingId
        LEFT JOIN organization_member om ON om.personId = p.personId
        LEFT JOIN organization o ON o.organizationId = om.organizationId
        LEFT JOIN event_guest eg ON eg.guestId = g.guestId
        LEFT JOIN event e ON e.eventId = eg.eventId
            AND e.startDate BETWEEN ? AND ?
        GROUP BY g.guestId, p.firstName, p.lastName, r.roomNum, w.wingCode
        ORDER BY w.wingCode, r.roomNum, guestName
        """,
        (SNAPSHOT_DATE, SNAPSHOT_DATE, UPCOMING_START, UPCOMING_END),
    ).fetchall()

    upcoming_events = conn.execute(
        """
        SELECT
            e.eventId,
            e.eventName,
            e.startDate,
            e.endDate,
            CASE
                WHEN hp.partyType = 'PERSON' THEN host_person.firstName || ' ' || host_person.lastName
                ELSE host_org.organizationName
            END AS hostName,
            CASE
                WHEN bp.partyType = 'PERSON' THEN bill_person.firstName || ' ' || bill_person.lastName
                ELSE bill_org.organizationName
            END AS billedPartyName,
            e.estimatedAttendance,
            COALESCE(group_concat(DISTINCT r.roomNum || ' (' || eru.usageSlot || ')'), 'No rooms assigned yet') AS scheduledRooms
        FROM event e
        LEFT JOIN party hp ON hp.partyId = e.hostPartyId
        LEFT JOIN person host_person ON host_person.personId = hp.personId
        LEFT JOIN organization host_org ON host_org.organizationId = hp.organizationId
        JOIN party bp ON bp.partyId = e.billedPartyId
        LEFT JOIN person bill_person ON bill_person.personId = bp.personId
        LEFT JOIN organization bill_org ON bill_org.organizationId = bp.organizationId
        LEFT JOIN event_room_usage eru ON eru.eventId = e.eventId
        LEFT JOIN room r ON r.roomId = eru.roomId
        WHERE e.startDate BETWEEN ? AND ?
        GROUP BY
            e.eventId,
            e.eventName,
            e.startDate,
            e.endDate,
            hp.partyType,
            host_person.firstName,
            host_person.lastName,
            host_org.organizationName,
            bp.partyType,
            bill_person.firstName,
            bill_person.lastName,
            bill_org.organizationName,
            e.estimatedAttendance
        ORDER BY e.startDate, e.eventName
        """,
        (UPCOMING_START, UPCOMING_END),
    ).fetchall()

    reservation_trends = conn.execute(
        """
        SELECT
            substr(r.plannedCheckInDate, 1, 7) AS stayMonth,
            COUNT(*) AS reservationCount,
            ROUND(SUM(julianday(r.plannedCheckOutDate) - julianday(r.plannedCheckInDate)), 1) AS roomNights,
            SUM(rp.numGuests) AS expectedGuests
        FROM reservation r
        JOIN reservation_preference rp ON rp.reservationId = r.reservationId
        WHERE r.plannedCheckInDate BETWEEN ? AND ?
        GROUP BY stayMonth
        ORDER BY stayMonth
        """,
        ("2026-02-01", "2026-04-30"),
    ).fetchall()

    conn.close()

    maintenance_statuses = {"RENOVATION", "RECONSTRUCTION", "OUT_OF_SERVICE"}
    maintenance_count = sum(
        row["roomCount"] for row in room_status_summary if row["statusType"] in maintenance_statuses
    )

    summary_cards = [
        {"label": "Active Guests", "value": len(current_guests)},
        {"label": "Available Rooms", "value": len(available_rooms)},
        {"label": "Upcoming Events", "value": len(upcoming_events)},
        {"label": "Maintenance Rooms", "value": maintenance_count},
    ]

    return render_template(
        "index.html",
        summaryCards=summary_cards,
        roomStatusSummary=room_status_summary,
        availableRooms=available_rooms,
        currentGuests=current_guests,
        upcomingEvents=upcoming_events,
        reservationTrends=reservation_trends,
        startDate=start_date,
        endDate=end_date,
        snapshotDate=SNAPSHOT_DATE,
        pageTitle="Hotel Dashboard",
    )


@app.route("/billing", methods=["GET"])
def billing():
    requested_account_id = request.args.get("accountId", type=int)
    requested_guest_id = request.args.get("guestId", type=int)

    conn = get_db_connection()

    account_balances = conn.execute(
        """
        WITH charge_summary AS (
            SELECT accountId, SUM(amount) AS totalCharges
            FROM charge
            GROUP BY accountId
        ),
        payment_summary AS (
            SELECT accountId, SUM(amount) AS totalPayments
            FROM payment
            GROUP BY accountId
        ),
        responsibility_summary AS (
            SELECT
                ar.accountId,
                group_concat(
                    CASE
                        WHEN p.partyType = 'PERSON' THEN person.firstName || ' ' || person.lastName
                        ELSE organization.organizationName
                    END || ' (' || ar.responsibilityType ||
                    COALESCE(' ' || printf('%.0f%%', ar.responsibilityPercent), '') || ')'
                ) AS responsibleParties
            FROM account_responsibility ar
            JOIN party p ON p.partyId = ar.partyId
            LEFT JOIN person ON person.personId = p.personId
            LEFT JOIN organization ON organization.organizationId = p.organizationId
            GROUP BY ar.accountId
        )
        SELECT
            a.accountId,
            a.accountName,
            a.accountStatus,
            COALESCE(cs.totalCharges, 0) AS totalCharges,
            COALESCE(ps.totalPayments, 0) AS totalPayments,
            COALESCE(cs.totalCharges, 0) - COALESCE(ps.totalPayments, 0) AS balanceDue,
            COALESCE(rs.responsibleParties, 'No responsible party listed') AS responsibleParties
        FROM account a
        LEFT JOIN charge_summary cs ON cs.accountId = a.accountId
        LEFT JOIN payment_summary ps ON ps.accountId = a.accountId
        LEFT JOIN responsibility_summary rs ON rs.accountId = a.accountId
        ORDER BY (a.accountStatus = 'OPEN') DESC, balanceDue DESC, a.accountId
        """
    ).fetchall()

    revenue_breakdown = conn.execute(
        """
        SELECT
            chargeType,
            COUNT(*) AS chargeLines,
            ROUND(SUM(amount), 2) AS totalAmount,
            ROUND(AVG(amount), 2) AS avgChargeAmount,
            ROUND(100.0 * SUM(amount) / (SELECT SUM(amount) FROM charge), 1) AS pctOfRevenue
        FROM charge
        GROUP BY chargeType
        ORDER BY totalAmount DESC, chargeType
        """
    ).fetchall()

    guest_contacts = conn.execute(
        """
        WITH last_swipe AS (
            SELECT guestId, MAX(swipeTime) AS lastSwipeTime
            FROM card_swipe_log
            WHERE guestId IS NOT NULL
            GROUP BY guestId
        ),
        swipe_detail AS (
            SELECT
                ls.guestId,
                ls.lastSwipeTime,
                r.readerName,
                r.locationDescription
            FROM last_swipe ls
            JOIN card_swipe_log csl
                ON csl.guestId = ls.guestId
               AND csl.swipeTime = ls.lastSwipeTime
            JOIN reader r ON r.readerId = csl.readerId
        ),
        last_message AS (
            SELECT guestId, MAX(messageTime) AS lastMessageTime
            FROM guest_message
            GROUP BY guestId
        ),
        message_detail AS (
            SELECT
                lm.guestId,
                lm.lastMessageTime,
                gm.messageContent
            FROM last_message lm
            JOIN guest_message gm
                ON gm.guestId = lm.guestId
               AND gm.messageTime = lm.lastMessageTime
        )
        SELECT
            g.guestId,
            p.firstName || ' ' || p.lastName AS guestName,
            g.isConfidential,
            sd.lastSwipeTime,
            CASE
                WHEN g.isConfidential = 1 THEN 'Confidential - contact through front desk'
                WHEN sd.readerName IS NULL THEN 'No recent swipe recorded'
                ELSE sd.readerName || ' - ' || sd.locationDescription
            END AS lastKnownLocation,
            md.lastMessageTime,
            COALESCE(md.messageContent, 'No recent guest message') AS messageContent,
            CASE
                WHEN g.isConfidential = 1 THEN 'Front desk only'
                ELSE COALESCE(p.phoneNumber, 'No phone on file')
            END AS contactMethod
        FROM guest g
        JOIN person p ON p.personId = g.personId
        LEFT JOIN swipe_detail sd ON sd.guestId = g.guestId
        LEFT JOIN message_detail md ON md.guestId = g.guestId
        WHERE sd.lastSwipeTime IS NOT NULL OR md.lastMessageTime IS NOT NULL
        ORDER BY COALESCE(sd.lastSwipeTime, md.lastMessageTime) DESC, guestName
        """
    ).fetchall()

    if account_balances:
        valid_account_ids = {row["accountId"] for row in account_balances}
        selected_account_id = requested_account_id if requested_account_id in valid_account_ids else account_balances[0]["accountId"]
    else:
        selected_account_id = None

    if guest_contacts:
        valid_guest_ids = {row["guestId"] for row in guest_contacts}
        selected_guest_id = requested_guest_id if requested_guest_id in valid_guest_ids else guest_contacts[0]["guestId"]
    else:
        selected_guest_id = None

    selected_account = next(
        (row for row in account_balances if row["accountId"] == selected_account_id),
        None,
    )

    selected_guest = next(
        (row for row in guest_contacts if row["guestId"] == selected_guest_id),
        None,
    )

    account_line_items = conn.execute(
        """
        SELECT
            c.chargeType,
            c.description,
            c.amount,
            c.chargeTime,
            COALESCE(person.firstName || ' ' || person.lastName, 'Shared or master charge') AS usedByGuest
        FROM charge c
        LEFT JOIN guest g ON g.guestId = c.usedByGuestId
        LEFT JOIN person ON person.personId = g.personId
        WHERE c.accountId = ?
        ORDER BY c.chargeTime
        """,
        (selected_account_id,),
    ).fetchall() if selected_account_id is not None else []

    guest_related_accounts = conn.execute(
        """
        SELECT DISTINCT
            a.accountId,
            a.accountName,
            a.accountStatus
        FROM guest g
        JOIN person p ON p.personId = g.personId
        JOIN party guest_party
            ON guest_party.personId = p.personId
           AND guest_party.partyType = 'PERSON'
        JOIN reservation r
            ON r.bookedByPartyId = guest_party.partyId
            OR r.billingPartyId = guest_party.partyId
        JOIN account a ON a.reservationId = r.reservationId
        WHERE g.guestId = ?
        ORDER BY a.accountId
        """,
        (selected_guest_id,),
    ).fetchall() if selected_guest_id is not None else []

    conn.close()

    return render_template(
        "billing.html",
        accountBalances=account_balances,
        revenueBreakdown=revenue_breakdown,
        guestContacts=guest_contacts,
        selectedAccount=selected_account,
        selectedGuest=selected_guest,
        accountLineItems=account_line_items,
        guestRelatedAccounts=guest_related_accounts,
        selectedAccountId=selected_account_id,
        selectedGuestId=selected_guest_id,
        snapshotDate=SNAPSHOT_DATE,
        pageTitle="Billing and Guest View",
    )


@app.errorhandler(Exception)
def handle_error(error):
    return render_template("error.html", error=error, pageTitle="Error"), 500


if __name__ == "__main__":
    port = int(os.environ.get("PORT", 8080))
    app.run(host="0.0.0.0", port=port, debug=True)
