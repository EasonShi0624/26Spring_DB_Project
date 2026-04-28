PRAGMA foreign_keys = ON;

INSERT INTO hotel (hotelId, name) VALUES
(1, 'Last Resort Hotel');

INSERT INTO building (buildingId, hotelId, buildingName) VALUES
(1, 1, 'Main Building');

INSERT INTO wing (
    wingId, buildingId, wingCode, wingOrder,
    nearIndoorPool, nearOutdoorPool, nearParking, handicapAccess
) VALUES
(1, 1, 'A', 1, 1, 0, 1, 1),
(2, 1, 'B', 2, 0, 1, 0, 1);

INSERT INTO level (levelId, wingId, levelNumber, isSmoking) VALUES
(1, 1, 1, 0),
(2, 1, 2, 0),
(3, 2, 1, 1),
(4, 2, 2, 0);

INSERT INTO room (roomId, levelId, roomNum, isSmokingOverride) VALUES
(1, 1, '101', NULL),
(2, 1, '102', NULL),
(3, 1, '103', NULL),
(4, 1, '104', NULL),
(5, 1, '105', NULL),
(6, 2, '201', NULL),
(7, 2, '202', NULL),
(8, 2, '203', NULL),
(9, 2, '204', NULL),
(10, 2, '205', NULL),
(11, 3, 'B101', 1),
(12, 3, 'B102', 1),
(13, 3, 'B103', 1),
(14, 3, 'B104', 1),
(15, 3, 'B105', 1),
(16, 4, 'B201', NULL),
(17, 4, 'B202', NULL),
(18, 4, 'B203', NULL),
(19, 4, 'B204', NULL),
(20, 4, 'B205', NULL);

INSERT INTO capability_type (capabilityTypeId, capabilityCode) VALUES
(1, 'SLEEPING'),
(2, 'MEETING'),
(3, 'SUITE');

INSERT INTO fixture_type (fixtureTypeId, fixtureCode) VALUES
(1, 'TOILET_BATH'),
(2, 'EXTRA_MEETING_SPACE'),
(3, 'OUTDOOR_SPACE');

INSERT INTO bed_type (bedTypeId, bedCode, size, isPermanent) VALUES
(1, 'QUEEN_STD', 'QUEEN', 1),
(2, 'KING_STD', 'KING', 1),
(3, 'TWIN_STD', 'TWIN', 1),
(4, 'ROLLAWAY', 'ROLLAWAY', 0);

INSERT INTO room_capability (roomId, capabilityTypeId, capacity, baseRate, isAssignable) VALUES
(1, 1, 2, 180.00, 1),
(2, 1, 2, 180.00, 1),
(3, 1, 3, 210.00, 1),
(4, 1, 2, 185.00, 1),
(5, 1, 1, 150.00, 1),
(6, 1, 2, 195.00, 1),
(7, 1, 2, 195.00, 1),
(8, 1, 4, 240.00, 1),
(11, 1, 2, 170.00, 1),
(12, 1, 2, 170.00, 1),
(13, 1, 2, 175.00, 1),
(16, 1, 2, 200.00, 1),
(17, 1, 2, 200.00, 1),
(20, 1, 1, 145.00, 1),
(9, 3, 4, 320.00, 1),
(10, 3, 5, 380.00, 1),
(18, 3, 4, 330.00, 1),
(14, 2, 20, 250.00, 1),
(15, 2, 60, 600.00, 1),
(19, 2, 12, 180.00, 1),
(9, 2, 8, 120.00, 1),
(10, 2, 10, 140.00, 1),
(18, 2, 8, 120.00, 1);

INSERT INTO room_fixture (roomId, fixtureTypeId) VALUES
(1, 1), (2, 1), (3, 1), (4, 1), (5, 1),
(6, 1), (7, 1), (8, 1), (9, 1), (10, 1),
(11, 1), (12, 1), (13, 1), (16, 1), (17, 1),
(18, 1), (20, 1),
(9, 2), (10, 2), (18, 2),
(10, 3), (18, 3);

INSERT INTO room_bed (roomId, bedTypeId, quantity) VALUES
(1, 1, 1),
(2, 1, 1),
(3, 3, 2),
(4, 2, 1),
(5, 3, 1),
(6, 1, 1),
(7, 2, 1),
(8, 1, 2),
(9, 2, 1),
(10, 2, 1),
(10, 4, 1),
(11, 1, 1),
(12, 3, 2),
(13, 2, 1),
(16, 1, 1),
(17, 2, 1),
(18, 2, 1),
(20, 3, 1);

INSERT INTO adjacent (roomId1, roomId2, doorType) VALUES
(1, 2, 'PRIVATE_DOOR'),
(3, 4, 'PRIVATE_DOOR'),
(9, 10, 'MOVABLE_WALL_DOOR'),
(14, 15, 'MOVABLE_WALL_DOOR'),
(16, 17, 'PRIVATE_DOOR');

INSERT INTO person (personId, firstName, lastName, emailAddress, phoneNumber) VALUES
(1, 'Emma', 'Lee', 'emma.lee@email.com', '917-555-0101'),
(2, 'Noah', 'Kim', 'noah.kim@email.com', '917-555-0102'),
(3, 'Olivia', 'Patel', 'olivia.patel@email.com', '917-555-0103'),
(4, 'Liam', 'Garcia', 'liam.garcia@email.com', '917-555-0104'),
(5, 'Ava', 'Chen', 'ava.chen@email.com', '917-555-0105'),
(6, 'Ethan', 'Wong', 'ethan.wong@email.com', '917-555-0106'),
(7, 'Mia', 'Brown', 'mia.brown@email.com', '917-555-0107'),
(8, 'Lucas', 'Smith', 'lucas.smith@email.com', '917-555-0108'),
(9, 'Sophia', 'Davis', 'sophia.davis@email.com', '917-555-0109'),
(10, 'James', 'Wilson', 'james.wilson@email.com', '917-555-0110'),
(11, 'Chloe', 'Martinez', 'chloe.martinez@email.com', '917-555-0111'),
(12, 'Benjamin', 'Hall', 'benjamin.hall@email.com', '917-555-0112'),
(13, 'Grace', 'Nguyen', 'grace.nguyen@email.com', '917-555-0113'),
(14, 'Daniel', 'Rivera', 'daniel.rivera@email.com', '917-555-0114'),
(15, 'Harper', 'Johnson', 'harper.johnson@email.com', '917-555-0115'),
(16, 'Zoe', 'Turner', 'zoe.turner@email.com', '917-555-0116'),
(17, 'Mason', 'Clark', 'mason.clark@email.com', '917-555-0117'),
(18, 'Isla', 'Moore', 'isla.moore@email.com', '917-555-0118'),
(19, 'Ella', 'Brooks', 'ella.brooks@email.com', '917-555-0119'),
(20, 'Owen', 'Parker', 'owen.parker@email.com', '917-555-0120');

INSERT INTO organization (organizationId, organizationName) VALUES
(1, 'NYU Shanghai'),
(2, 'BluePeak Consulting'),
(3, 'Sunrise Health Group'),
(4, 'Hudson Arts Council'),
(5, 'East Coast Robotics');

INSERT INTO guest (guestId, personId, pinCode, isConfidential) VALUES
(1, 1, '4829', 0),
(2, 2, '1357', 0),
(3, 3, '7712', 0),
(4, 4, '8841', 0),
(5, 5, '6620', 1),
(6, 6, '9021', 0),
(7, 11, '3184', 0),
(8, 12, '4561', 0),
(9, 13, '2918', 0),
(10, 14, '5502', 0),
(11, 16, '7764', 0),
(12, 17, '8331', 0),
(13, 18, '9042', 0),
(14, 19, '6104', 0),
(15, 20, '7208', 0);

INSERT INTO employee (employeeId, personId, jobTitle) VALUES
(1, 7, 'Front Desk Clerk'),
(2, 8, 'Maintenance Supervisor'),
(3, 9, 'Sales Manager'),
(4, 10, 'Housekeeping Lead'),
(5, 15, 'Concierge');

INSERT INTO organization_member (organizationId, personId) VALUES
(1, 3),
(1, 17),
(2, 4),
(2, 14),
(3, 5),
(3, 12),
(4, 19),
(5, 13),
(5, 20);

INSERT INTO party (partyId, partyType, personId, organizationId, authorizedRepPersonId) VALUES
(1, 'PERSON', 1, NULL, NULL),
(2, 'PERSON', 2, NULL, NULL),
(3, 'PERSON', 3, NULL, NULL),
(4, 'PERSON', 4, NULL, NULL),
(5, 'PERSON', 5, NULL, NULL),
(6, 'PERSON', 6, NULL, NULL),
(7, 'PERSON', 11, NULL, NULL),
(8, 'PERSON', 12, NULL, NULL),
(9, 'PERSON', 13, NULL, NULL),
(10, 'PERSON', 14, NULL, NULL),
(11, 'PERSON', 16, NULL, NULL),
(12, 'PERSON', 17, NULL, NULL),
(13, 'PERSON', 18, NULL, NULL),
(14, 'PERSON', 19, NULL, NULL),
(15, 'PERSON', 20, NULL, NULL),
(16, 'ORGANIZATION', NULL, 1, 3),
(17, 'ORGANIZATION', NULL, 2, 4),
(18, 'ORGANIZATION', NULL, 3, 5),
(19, 'ORGANIZATION', NULL, 4, 19),
(20, 'ORGANIZATION', NULL, 5, 13);

INSERT INTO reader (readerId, readerName, readerType, roomId, locationDescription) VALUES
(1, 'Front Desk Podium', 'FACILITY', NULL, 'Front desk check-in area'),
(2, 'Health Club Entrance', 'FACILITY', NULL, 'Health club and spa corridor'),
(3, 'Garden Restaurant Host Stand', 'FACILITY', NULL, 'Main restaurant entrance'),
(4, 'Wing A Lobby Reader', 'ENTRY', NULL, 'Wing A lobby and elevators'),
(5, 'Wing B Lobby Reader', 'ENTRY', NULL, 'Wing B lobby and elevators'),
(6, 'Room 201 Door Reader', 'ROOM', 6, 'Wing A level 2 room 201'),
(7, 'Suite 204 Door Reader', 'ROOM', 9, 'Wing A level 2 suite 204'),
(8, 'Suite 205 Door Reader', 'ROOM', 10, 'Wing A level 2 suite 205'),
(9, 'Room B101 Door Reader', 'ROOM', 11, 'Wing B level 1 room B101'),
(10, 'Room B205 Door Reader', 'ROOM', 20, 'Wing B level 2 room B205'),
(11, 'Boardroom B204 Reader', 'MEETING_ROOM', 19, 'Wing B small meeting room B204'),
(12, 'Ballroom B105 Reader', 'MEETING_ROOM', 15, 'Wing B ballroom B105'),
(13, 'Meeting Room B104 Reader', 'MEETING_ROOM', 14, 'Wing B meeting room B104'),
(14, 'Suite B203 Door Reader', 'ROOM', 18, 'Wing B level 2 suite B203'),
(15, 'Main Entrance Reader', 'ENTRY', NULL, 'Hotel main entrance');

INSERT INTO reservation (
    reservationId, bookedByPartyId, billingPartyId, bookingDate,
    plannedCheckInDate, plannedCheckOutDate, reservationStatus, advanceDeposit
) VALUES
(1, 1, 1, '2026-02-01', '2026-02-20', '2026-02-23', 'CHECKED_OUT', 100.00),
(2, 2, 2, '2026-02-10', '2026-03-02', '2026-03-05', 'CHECKED_OUT', 80.00),
(3, 3, 16, '2026-02-25', '2026-03-12', '2026-03-16', 'CHECKED_OUT', 150.00),
(4, 4, 17, '2026-03-01', '2026-03-18', '2026-03-21', 'CHECKED_OUT', 120.00),
(5, 5, 5, '2026-03-05', '2026-03-31', '2026-04-02', 'CHECKED_OUT', 200.00),
(6, 6, 18, '2026-03-20', '2026-04-05', '2026-04-07', 'CHECKED_OUT', 90.00),
(7, 7, 7, '2026-04-01', '2026-04-18', '2026-04-22', 'CHECKED_OUT', 120.00),
(8, 8, 8, '2026-04-10', '2026-04-24', '2026-04-29', 'CHECKED_IN', 150.00),
(9, 9, 20, '2026-04-12', '2026-04-25', '2026-04-30', 'CHECKED_IN', 180.00),
(10, 10, 17, '2026-04-15', '2026-04-27', '2026-05-01', 'CHECKED_IN', 100.00),
(11, 11, 11, '2026-04-18', '2026-04-28', '2026-04-30', 'CHECKED_IN', 75.00),
(12, 1, 1, '2026-04-14', '2026-04-26', '2026-04-30', 'CHECKED_IN', 130.00),
(13, 12, 16, '2026-04-16', '2026-04-29', '2026-05-02', 'BOOKED', 110.00),
(14, 13, 13, '2026-04-20', '2026-04-30', '2026-05-03', 'BOOKED', 95.00),
(15, 5, 18, '2026-02-18', '2026-02-28', '2026-03-03', 'CHECKED_OUT', 175.00),
(16, 15, 15, '2026-04-05', '2026-04-15', '2026-04-17', 'CANCELLED', 0.00);

INSERT INTO reservation_preference (
    preferenceId, reservationId, numGuests, smokingPref, proximityPref, notes
) VALUES
(1, 1, 2, 0, 'near parking', 'quiet room if possible'),
(2, 2, 1, 0, 'near indoor pool', NULL),
(3, 3, 2, 0, 'high floor', 'queen bed preferred'),
(4, 4, 1, 1, 'near outdoor pool', NULL),
(5, 5, 2, 0, 'suite if available', 'late checkout requested'),
(6, 6, 1, 0, 'quiet room', NULL),
(7, 7, 3, 0, 'adjacent rooms', 'traveling with children'),
(8, 8, 1, 0, 'near health club', NULL),
(9, 9, 2, 0, 'near parking', 'corporate retreat attendees'),
(10, 10, 1, 0, 'near meeting rooms', NULL),
(11, 11, 1, 0, 'quiet floor', NULL),
(12, 12, 1, 0, 'suite if available', 'guest may need room move flexibility'),
(13, 13, 1, 0, 'near event rooms', NULL),
(14, 14, 1, 0, 'high floor', NULL),
(15, 15, 2, 0, 'quiet room', 'split room and incidentals'),
(16, 16, 1, 0, 'near parking', 'cancelled before arrival');

INSERT INTO reservation_bed_preference (preferenceId, bedTypeId, preferredQuantity) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 1, 1),
(4, 3, 1),
(5, 2, 1),
(6, 1, 1),
(7, 1, 2),
(8, 2, 1),
(9, 2, 1),
(10, 1, 1),
(11, 3, 1),
(12, 2, 1),
(13, 1, 1),
(14, 3, 1),
(15, 2, 1),
(15, 4, 1),
(16, 1, 1);

INSERT INTO stay_room_assignment (
    stayAssignmentId, reservationId, roomId, assignedStartDate, assignedEndDate, assignmentStatus
) VALUES
(1, 1, 1, '2026-02-20', '2026-02-23', 'RELEASED'),
(2, 2, 6, '2026-03-02', '2026-03-05', 'RELEASED'),
(3, 3, 7, '2026-03-12', '2026-03-16', 'RELEASED'),
(4, 4, 11, '2026-03-18', '2026-03-21', 'RELEASED'),
(5, 5, 10, '2026-03-31', '2026-04-02', 'RELEASED'),
(6, 6, 16, '2026-04-05', '2026-04-07', 'RELEASED'),
(7, 7, 8, '2026-04-18', '2026-04-22', 'RELEASED'),
(8, 8, 6, '2026-04-24', '2026-04-29', 'OCCUPIED'),
(9, 9, 10, '2026-04-25', '2026-04-30', 'OCCUPIED'),
(10, 10, 11, '2026-04-27', '2026-05-01', 'OCCUPIED'),
(11, 11, 20, '2026-04-28', '2026-04-30', 'OCCUPIED'),
(12, 12, 8, '2026-04-26', '2026-04-27', 'RELEASED'),
(13, 12, 9, '2026-04-27', '2026-04-30', 'OCCUPIED'),
(14, 13, 7, '2026-04-29', '2026-05-02', 'RESERVED'),
(15, 14, 16, '2026-04-30', '2026-05-03', 'RESERVED'),
(16, 15, 18, '2026-02-28', '2026-03-03', 'RELEASED');

INSERT INTO stay_room_guest (stayAssignmentId, guestId, occupantRole) VALUES
(1, 1, 'PRIMARY'),
(1, 4, 'SHARER'),
(2, 2, 'PRIMARY'),
(3, 3, 'PRIMARY'),
(3, 12, 'SHARER'),
(4, 4, 'PRIMARY'),
(5, 5, 'PRIMARY'),
(5, 6, 'SHARER'),
(6, 6, 'PRIMARY'),
(7, 7, 'PRIMARY'),
(7, 14, 'SHARER'),
(7, 15, 'SHARER'),
(8, 8, 'PRIMARY'),
(9, 9, 'PRIMARY'),
(9, 14, 'SHARER'),
(10, 10, 'PRIMARY'),
(11, 11, 'PRIMARY'),
(12, 1, 'PRIMARY'),
(13, 1, 'PRIMARY'),
(14, 12, 'PRIMARY'),
(15, 13, 'PRIMARY'),
(16, 5, 'PRIMARY'),
(16, 15, 'SHARER');

INSERT INTO room_extension (extensionId, stayAssignmentId, extensionHours, surchargeAmount) VALUES
(1, 5, 3, 60.00),
(2, 13, 4, 75.00);

INSERT INTO room_status (
    statusId, roomId, statusType, startTime, endTime, employeeId, notes
) VALUES
(1, 1, 'READY', '2026-04-23 10:00:00', NULL, 4, 'Vacant clean room'),
(2, 2, 'READY', '2026-04-23 10:00:00', NULL, 4, 'Vacant clean room'),
(3, 3, 'DIRTY', '2026-04-28 09:00:00', NULL, 4, 'Checkout pending cleaning'),
(4, 4, 'READY', '2026-04-28 08:00:00', NULL, 4, 'Vacant clean room'),
(5, 5, 'READY', '2026-04-28 08:00:00', NULL, 4, 'Vacant clean room'),
(6, 6, 'OCCUPIED', '2026-04-24 15:30:00', NULL, 1, 'Benjamin Hall checked in'),
(7, 7, 'READY', '2026-04-28 10:00:00', NULL, 4, 'Held for next-day arrival'),
(8, 8, 'OCCUPIED', '2026-04-18 15:00:00', '2026-04-22 12:00:00', 1, 'Family stay checked in'),
(9, 8, 'DIRTY', '2026-04-22 12:10:00', '2026-04-22 18:00:00', 4, 'Post-checkout cleaning'),
(10, 8, 'READY', '2026-04-22 18:30:00', '2026-04-26 15:00:00', 4, 'Returned to inventory'),
(11, 8, 'OCCUPIED', '2026-04-26 15:00:00', '2026-04-27 12:00:00', 1, 'Emma Lee initial assignment'),
(12, 8, 'READY', '2026-04-27 12:30:00', NULL, 4, 'Guest moved to suite 204'),
(13, 9, 'OCCUPIED', '2026-04-27 15:10:00', NULL, 1, 'Emma Lee reassigned due to HVAC issue'),
(14, 10, 'OCCUPIED', '2026-04-25 15:10:00', NULL, 1, 'Grace Nguyen checked in'),
(15, 11, 'OCCUPIED', '2026-04-27 15:45:00', NULL, 1, 'Daniel Rivera checked in'),
(16, 12, 'OUT_OF_SERVICE', '2026-04-20 08:00:00', '2026-04-29 18:00:00', 2, 'Plumbing repair in progress'),
(17, 13, 'READY', '2026-04-20 09:00:00', NULL, 4, 'Vacant clean room'),
(18, 14, 'READY', '2026-04-20 07:00:00', NULL, 4, 'Meeting room available'),
(19, 15, 'READY', '2026-04-20 07:00:00', NULL, 4, 'Ballroom available'),
(20, 16, 'READY', '2026-04-28 09:00:00', NULL, 4, 'Reserved for future arrival'),
(21, 17, 'RENOVATION', '2026-04-12 08:00:00', '2026-04-30 18:00:00', 2, 'Bathroom remodel'),
(22, 18, 'READY', '2026-04-20 09:00:00', NULL, 4, 'Suite available'),
(23, 19, 'READY', '2026-04-20 07:00:00', NULL, 4, 'Boardroom available'),
(24, 20, 'OCCUPIED', '2026-04-28 15:20:00', NULL, 1, 'Zoe Turner checked in'),
(25, 1, 'DIRTY', '2026-02-23 12:10:00', '2026-02-23 17:30:00', 4, 'Historical turnover cleaning');

INSERT INTO event (
    eventId, eventName, hostPartyId, billedPartyId,
    startDate, endDate, estimatedAttendance, estimatedGuestCount
) VALUES
(1, 'Winter Board Lunch', 1, 16, '2026-02-22', '2026-02-22', 12, 4),
(2, 'Consulting Workshop', 17, 17, '2026-03-05', '2026-03-05', 35, 2),
(3, 'Health Networking Mixer', 5, 18, '2026-03-19', '2026-03-19', 70, 3),
(4, 'Spring Alumni Dinner', 16, 16, '2026-04-10', '2026-04-10', 60, 12),
(5, 'Wellness Retreat Kickoff', 18, 18, '2026-04-18', '2026-04-18', 45, 10),
(6, 'Cross-Org Planning Session', 17, 17, '2026-04-27', '2026-04-27', 18, 4),
(7, 'Investor Breakfast', 4, 17, '2026-04-28', '2026-04-28', 20, 3),
(8, 'Admissions Weekend Reception', 16, 16, '2026-04-29', '2026-04-29', 85, 15),
(9, 'Arts Council Banquet', 19, 19, '2026-04-30', '2026-04-30', 120, 18);

INSERT INTO event_guest (eventId, guestId, roleName) VALUES
(1, 1, 'HOST'),
(1, 2, 'ATTENDEE'),
(1, 4, 'ATTENDEE'),
(2, 4, 'SPEAKER'),
(2, 3, 'ATTENDEE'),
(3, 5, 'HOST'),
(3, 6, 'ATTENDEE'),
(3, 1, 'ATTENDEE'),
(4, 3, 'HOST'),
(4, 12, 'ATTENDEE'),
(4, 14, 'ATTENDEE'),
(5, 5, 'HOST'),
(5, 8, 'ATTENDEE'),
(5, 9, 'ATTENDEE'),
(6, 9, 'ATTENDEE'),
(6, 10, 'ATTENDEE'),
(7, 4, 'HOST'),
(7, 8, 'ATTENDEE'),
(7, 10, 'ATTENDEE'),
(8, 3, 'HOST'),
(8, 12, 'ATTENDEE'),
(8, 1, 'ATTENDEE'),
(9, 14, 'HOST'),
(9, 15, 'ATTENDEE');

INSERT INTO event_organization (eventId, organizationId, roleName) VALUES
(1, 1, 'SPONSOR'),
(2, 2, 'HOST_ORG'),
(3, 3, 'SPONSOR'),
(4, 1, 'HOST_ORG'),
(5, 3, 'HOST_ORG'),
(6, 2, 'HOST_ORG'),
(6, 5, 'PARTNER'),
(7, 2, 'SPONSOR'),
(8, 1, 'HOST_ORG'),
(9, 4, 'HOST_ORG');

INSERT INTO event_room_usage (
    usageId, eventId, roomId, usageDate, usageSlot, isEatingUsage
) VALUES
(1, 1, 19, '2026-02-22', 'LUNCH', 1),
(2, 2, 14, '2026-03-05', 'MORNING', 0),
(3, 2, 14, '2026-03-05', 'AFTERNOON', 0),
(4, 3, 15, '2026-03-19', 'EVENING', 1),
(5, 3, 18, '2026-03-19', 'AFTERNOON', 0),
(6, 4, 19, '2026-04-10', 'SUPPER', 1),
(7, 5, 15, '2026-04-18', 'MORNING', 0),
(8, 5, 15, '2026-04-18', 'LUNCH', 1),
(9, 6, 14, '2026-04-27', 'AFTERNOON', 0),
(10, 7, 19, '2026-04-28', 'BREAKFAST', 1),
(11, 7, 14, '2026-04-28', 'MORNING', 0),
(12, 8, 15, '2026-04-29', 'EVENING', 1),
(13, 9, 15, '2026-04-30', 'SUPPER', 1),
(14, 9, 18, '2026-04-30', 'AFTERNOON', 0);

INSERT INTO account (
    accountId, reservationId, eventId, accountName, accountStatus, openedAt, closedAt
) VALUES
(1, 1, NULL, 'Emma Lee February Stay', 'CLOSED', '2026-02-20 15:00:00', '2026-02-23 12:30:00'),
(2, 2, NULL, 'Noah Kim March Stay', 'CLOSED', '2026-03-02 16:00:00', '2026-03-05 11:45:00'),
(3, 5, NULL, 'Ava Chen March Suite', 'CLOSED', '2026-03-31 15:30:00', '2026-04-02 12:40:00'),
(4, NULL, 1, 'Winter Board Lunch Master Bill', 'CLOSED', '2026-02-10 09:00:00', '2026-02-22 14:00:00'),
(5, NULL, 2, 'Consulting Workshop Master Bill', 'CLOSED', '2026-02-20 10:00:00', '2026-03-05 17:30:00'),
(6, NULL, 3, 'Health Networking Mixer Master Bill', 'CLOSED', '2026-03-10 12:00:00', '2026-03-19 22:30:00'),
(7, 8, NULL, 'Benjamin Hall Stay', 'OPEN', '2026-04-24 15:30:00', NULL),
(8, 9, NULL, 'Grace Nguyen Room and Tax', 'OPEN', '2026-04-25 15:10:00', NULL),
(9, 9, NULL, 'Grace Nguyen Incidentals', 'OPEN', '2026-04-25 15:10:00', NULL),
(10, 10, NULL, 'Daniel Rivera Corporate Stay', 'OPEN', '2026-04-27 15:45:00', NULL),
(11, 11, NULL, 'Zoe Turner Stay', 'OPEN', '2026-04-28 15:20:00', NULL),
(12, 12, NULL, 'Emma Lee Spring Visit', 'OPEN', '2026-04-26 15:10:00', NULL),
(13, NULL, 6, 'Cross-Org Planning Session Master Bill', 'CLOSED', '2026-04-20 09:00:00', '2026-04-27 17:00:00'),
(14, NULL, 7, 'Investor Breakfast Master Bill', 'OPEN', '2026-04-24 10:00:00', NULL),
(15, NULL, 8, 'Admissions Reception Master Bill', 'OPEN', '2026-04-20 09:00:00', NULL),
(16, NULL, 9, 'Arts Council Banquet Master Bill', 'OPEN', '2026-04-21 11:00:00', NULL),
(17, 15, NULL, 'Ava Corporate Room Charges', 'CLOSED', '2026-02-28 15:05:00', '2026-03-03 12:15:00'),
(18, 15, NULL, 'Ava Corporate Incidentals', 'CLOSED', '2026-02-28 15:05:00', '2026-03-03 12:15:00'),
(19, 3, NULL, 'Olivia Patel Conference Stay', 'CLOSED', '2026-03-12 15:00:00', '2026-03-16 12:10:00'),
(20, 4, NULL, 'Liam Garcia Workshop Stay', 'CLOSED', '2026-03-18 15:00:00', '2026-03-21 11:50:00'),
(21, 6, NULL, 'Ethan Wong Retreat Stay', 'CLOSED', '2026-04-05 15:10:00', '2026-04-07 12:00:00'),
(22, 7, NULL, 'Chloe Martinez Family Stay', 'CLOSED', '2026-04-18 15:00:00', '2026-04-22 12:10:00'),
(23, 13, NULL, 'Mason Clark Upcoming Stay', 'OPEN', '2026-04-29 15:00:00', NULL),
(24, 14, NULL, 'Isla Moore Upcoming Stay', 'OPEN', '2026-04-30 15:00:00', NULL);

INSERT INTO account_responsibility (
    accountId, partyId, responsibilityType, responsibilityPercent
) VALUES
(1, 1, 'FULL', 100.00),
(2, 2, 'FULL', 100.00),
(3, 5, 'FULL', 100.00),
(4, 16, 'FULL', 100.00),
(5, 17, 'FULL', 100.00),
(6, 18, 'FULL', 100.00),
(7, 8, 'FULL', 100.00),
(8, 20, 'FULL', 100.00),
(9, 9, 'FULL', 100.00),
(10, 17, 'FULL', 100.00),
(11, 11, 'FULL', 100.00),
(12, 1, 'FULL', 100.00),
(13, 17, 'FULL', 100.00),
(14, 17, 'FULL', 100.00),
(15, 16, 'FULL', 100.00),
(16, 19, 'FULL', 100.00),
(17, 18, 'FULL', 100.00),
(18, 18, 'SPLIT', 50.00),
(18, 5, 'SPLIT', 50.00),
(19, 16, 'FULL', 100.00),
(20, 17, 'FULL', 100.00),
(21, 18, 'FULL', 100.00),
(22, 7, 'FULL', 100.00),
(23, 16, 'FULL', 100.00),
(24, 13, 'FULL', 100.00);

INSERT INTO charge (
    chargeId, accountId, chargeType, description, amount, chargeTime,
    usedByGuestId, stayAssignmentId, eventId, createdByEmployeeId
) VALUES
(1, 1, 'ROOM_RATE', 'Night 1 room charge', 180.00, '2026-02-20 18:00:00', NULL, 1, NULL, 1),
(2, 1, 'ROOM_RATE', 'Night 2 room charge', 180.00, '2026-02-21 18:00:00', NULL, 1, NULL, 1),
(3, 1, 'ROOM_RATE', 'Night 3 room charge', 180.00, '2026-02-22 18:00:00', NULL, 1, NULL, 1),
(4, 1, 'ROOM_SERVICE', 'Dinner order', 36.00, '2026-02-21 20:15:00', 1, 1, NULL, 1),
(5, 1, 'PHONE', 'International call', 12.00, '2026-02-22 08:10:00', 1, 1, NULL, 1),
(6, 2, 'ROOM_RATE', 'Night 1 room charge', 195.00, '2026-03-02 18:30:00', NULL, 2, NULL, 1),
(7, 2, 'ROOM_RATE', 'Night 2 room charge', 195.00, '2026-03-03 18:30:00', NULL, 2, NULL, 1),
(8, 2, 'ROOM_RATE', 'Night 3 room charge', 195.00, '2026-03-04 18:30:00', NULL, 2, NULL, 1),
(9, 2, 'HEALTH_CLUB', 'Gym day pass', 20.00, '2026-03-04 19:00:00', 2, 2, NULL, 1),
(10, 3, 'ROOM_RATE', 'Suite night 1', 380.00, '2026-03-31 18:00:00', NULL, 5, NULL, 1),
(11, 3, 'ROOM_RATE', 'Suite night 2', 380.00, '2026-04-01 18:00:00', NULL, 5, NULL, 1),
(12, 3, 'ROOM_SURCHARGE', 'Late checkout extension', 60.00, '2026-04-01 11:00:00', NULL, 5, NULL, 1),
(13, 3, 'ROOM_SERVICE', 'Breakfast service', 35.00, '2026-04-01 08:30:00', 5, 5, NULL, 1),
(14, 4, 'FOOD_BEVERAGE', 'Catered lunch', 240.00, '2026-02-22 12:00:00', NULL, NULL, 1, 3),
(15, 4, 'MEETING_ROOM', 'Boardroom rental', 180.00, '2026-02-22 12:00:00', NULL, NULL, 1, 3),
(16, 5, 'MEETING_ROOM', 'Workshop room rental', 500.00, '2026-03-05 09:00:00', NULL, NULL, 2, 3),
(17, 5, 'BUSINESS_SERVICE', 'Projector and print package', 85.00, '2026-03-05 09:15:00', NULL, NULL, 2, 3),
(18, 6, 'MEETING_ROOM', 'Ballroom rental', 900.00, '2026-03-19 17:00:00', NULL, NULL, 3, 3),
(19, 6, 'FOOD_BEVERAGE', 'Mixer catering', 1200.00, '2026-03-19 18:00:00', NULL, NULL, 3, 3),
(20, 7, 'ROOM_RATE', 'Night 1 room charge', 195.00, '2026-04-24 18:00:00', NULL, 8, NULL, 1),
(21, 7, 'ROOM_RATE', 'Night 2 room charge', 195.00, '2026-04-25 18:00:00', NULL, 8, NULL, 1),
(22, 7, 'ROOM_RATE', 'Night 3 room charge', 195.00, '2026-04-26 18:00:00', NULL, 8, NULL, 1),
(23, 7, 'ROOM_RATE', 'Night 4 room charge', 195.00, '2026-04-27 18:00:00', NULL, 8, NULL, 1),
(24, 7, 'RETAIL', 'Lobby market purchase', 28.00, '2026-04-27 20:20:00', 8, 8, NULL, 5),
(25, 8, 'ROOM_RATE', 'Night 1 suite charge', 380.00, '2026-04-25 18:00:00', NULL, 9, NULL, 1),
(26, 8, 'ROOM_RATE', 'Night 2 suite charge', 380.00, '2026-04-26 18:00:00', NULL, 9, NULL, 1),
(27, 8, 'ROOM_RATE', 'Night 3 suite charge', 380.00, '2026-04-27 18:00:00', NULL, 9, NULL, 1),
(28, 8, 'ROOM_RATE', 'Night 4 suite charge', 380.00, '2026-04-28 18:00:00', NULL, 9, NULL, 1),
(29, 9, 'ROOM_SERVICE', 'Late dinner tray', 42.00, '2026-04-26 21:00:00', 9, 9, NULL, 1),
(30, 9, 'PHONE', 'Client conference call', 18.00, '2026-04-27 08:40:00', 9, 9, NULL, 1),
(31, 10, 'ROOM_RATE', 'Night 1 room charge', 170.00, '2026-04-27 18:00:00', NULL, 10, NULL, 1),
(32, 10, 'ROOM_RATE', 'Night 2 room charge', 170.00, '2026-04-28 18:00:00', NULL, 10, NULL, 1),
(33, 10, 'BUSINESS_SERVICE', 'Express printing', 24.00, '2026-04-28 20:10:00', 10, 10, NULL, 5),
(34, 11, 'ROOM_RATE', 'Night 1 room charge', 145.00, '2026-04-28 18:00:00', NULL, 11, NULL, 1),
(35, 12, 'ROOM_RATE', 'Night 1 visit charge', 320.00, '2026-04-26 18:00:00', NULL, 12, NULL, 1),
(36, 12, 'ROOM_RATE', 'Night 2 visit charge', 320.00, '2026-04-27 18:00:00', NULL, 13, NULL, 1),
(37, 12, 'ROOM_RATE', 'Night 3 visit charge', 320.00, '2026-04-28 18:00:00', NULL, 13, NULL, 1),
(38, 12, 'ROOM_SERVICE', 'Evening tea service', 48.00, '2026-04-28 21:20:00', 1, 13, NULL, 1),
(39, 12, 'ROOM_SURCHARGE', 'Late checkout approved surcharge', 75.00, '2026-04-30 12:30:00', NULL, 13, NULL, 1),
(40, 13, 'MEETING_ROOM', 'Planning session room rental', 260.00, '2026-04-27 15:00:00', NULL, NULL, 6, 3),
(41, 13, 'FOOD_BEVERAGE', 'Coffee and snacks', 140.00, '2026-04-27 15:15:00', NULL, NULL, 6, 3),
(42, 14, 'MEETING_ROOM', 'Breakfast room rental', 210.00, '2026-04-28 08:00:00', NULL, NULL, 7, 3),
(43, 14, 'FOOD_BEVERAGE', 'Continental breakfast buffet', 180.00, '2026-04-28 08:10:00', NULL, NULL, 7, 3),
(44, 15, 'MEETING_ROOM', 'Reception ballroom rental', 550.00, '2026-04-29 18:00:00', NULL, NULL, 8, 3),
(45, 15, 'FOOD_BEVERAGE', 'Reception catering', 640.00, '2026-04-29 18:15:00', NULL, NULL, 8, 3),
(46, 16, 'MEETING_ROOM', 'Banquet ballroom rental', 950.00, '2026-04-30 18:00:00', NULL, NULL, 9, 3),
(47, 16, 'FOOD_BEVERAGE', 'Banquet catering', 1350.00, '2026-04-30 18:20:00', NULL, NULL, 9, 3),
(48, 17, 'ROOM_RATE', 'Night 1 corporate room charge', 330.00, '2026-02-28 18:00:00', NULL, 16, NULL, 1),
(49, 17, 'ROOM_RATE', 'Night 2 corporate room charge', 330.00, '2026-03-01 18:00:00', NULL, 16, NULL, 1),
(50, 17, 'ROOM_RATE', 'Night 3 corporate room charge', 330.00, '2026-03-02 18:00:00', NULL, 16, NULL, 1),
(51, 18, 'ROOM_SERVICE', 'Late snack tray', 30.00, '2026-03-01 08:00:00', 5, 16, NULL, 1),
(52, 18, 'HEALTH_CLUB', 'Massage appointment', 25.00, '2026-03-02 17:15:00', 5, 16, NULL, 1),
(53, 19, 'ROOM_RATE', 'Night 1 conference charge', 195.00, '2026-03-12 18:00:00', NULL, 3, NULL, 1),
(54, 19, 'ROOM_RATE', 'Night 2 conference charge', 195.00, '2026-03-13 18:00:00', NULL, 3, NULL, 1),
(55, 19, 'ROOM_RATE', 'Night 3 conference charge', 195.00, '2026-03-14 18:00:00', NULL, 3, NULL, 1),
(56, 19, 'ROOM_RATE', 'Night 4 conference charge', 195.00, '2026-03-15 18:00:00', NULL, 3, NULL, 1),
(57, 20, 'ROOM_RATE', 'Night 1 workshop stay charge', 170.00, '2026-03-18 18:00:00', NULL, 4, NULL, 1),
(58, 20, 'ROOM_RATE', 'Night 2 workshop stay charge', 170.00, '2026-03-19 18:00:00', NULL, 4, NULL, 1),
(59, 20, 'ROOM_RATE', 'Night 3 workshop stay charge', 170.00, '2026-03-20 18:00:00', NULL, 4, NULL, 1),
(60, 21, 'ROOM_RATE', 'Night 1 retreat stay charge', 200.00, '2026-04-05 18:00:00', NULL, 6, NULL, 1),
(61, 21, 'ROOM_RATE', 'Night 2 retreat stay charge', 200.00, '2026-04-06 18:00:00', NULL, 6, NULL, 1),
(62, 22, 'ROOM_RATE', 'Night 1 family stay charge', 240.00, '2026-04-18 18:00:00', NULL, 7, NULL, 1),
(63, 22, 'ROOM_RATE', 'Night 2 family stay charge', 240.00, '2026-04-19 18:00:00', NULL, 7, NULL, 1),
(64, 22, 'ROOM_RATE', 'Night 3 family stay charge', 240.00, '2026-04-20 18:00:00', NULL, 7, NULL, 1),
(65, 22, 'ROOM_RATE', 'Night 4 family stay charge', 240.00, '2026-04-21 18:00:00', NULL, 7, NULL, 1);

INSERT INTO payment (
    paymentId, accountId, paidByPartyId, paymentMethod, amount, paymentTime, referenceNumber
) VALUES
(1, 1, 1, 'VISA', 588.00, '2026-02-23 11:55:00', 'AUTH2001'),
(2, 2, 2, 'MASTERCARD', 605.00, '2026-03-05 11:35:00', 'AUTH2002'),
(3, 3, 5, 'AMEX', 855.00, '2026-04-02 12:05:00', 'AUTH2003'),
(4, 4, 16, 'BANK_TRANSFER', 420.00, '2026-02-20 10:00:00', 'BT3001'),
(5, 5, 17, 'BANK_TRANSFER', 585.00, '2026-03-03 09:45:00', 'BT3002'),
(6, 6, 18, 'BANK_TRANSFER', 2100.00, '2026-03-18 16:00:00', 'BT3003'),
(7, 7, 8, 'VISA', 300.00, '2026-04-24 15:35:00', 'AUTH2004'),
(8, 8, 20, 'ACH', 800.00, '2026-04-25 15:15:00', 'ACH4001'),
(9, 9, 9, 'VISA', 20.00, '2026-04-26 09:15:00', 'AUTH2005'),
(10, 10, 17, 'CORPORATE_CARD', 200.00, '2026-04-27 15:50:00', 'CORP5001'),
(11, 11, 11, 'VISA', 75.00, '2026-04-28 15:25:00', 'AUTH2006'),
(12, 12, 1, 'VISA', 400.00, '2026-04-26 15:20:00', 'AUTH2007'),
(13, 13, 17, 'ACH', 400.00, '2026-04-27 17:05:00', 'ACH4002'),
(14, 17, 18, 'BANK_TRANSFER', 990.00, '2026-02-28 15:20:00', 'BT3004'),
(15, 18, 18, 'BANK_TRANSFER', 27.50, '2026-03-02 18:10:00', 'BT3005'),
(16, 18, 5, 'AMEX', 27.50, '2026-03-03 10:30:00', 'AUTH2008'),
(17, 19, 16, 'BANK_TRANSFER', 780.00, '2026-03-16 10:30:00', 'BT3006'),
(18, 20, 17, 'BANK_TRANSFER', 510.00, '2026-03-21 11:20:00', 'BT3007'),
(19, 21, 18, 'BANK_TRANSFER', 400.00, '2026-04-07 10:50:00', 'BT3008'),
(20, 22, 7, 'VISA', 960.00, '2026-04-22 11:45:00', 'AUTH2009');

INSERT INTO card_swipe_log (
    logId, readerId, guestId, employeeId, direction, swipeTime
) VALUES
(1, 15, 1, NULL, 'IN', '2026-02-20 15:02:00'),
(2, 1, NULL, 1, 'IN', '2026-02-20 14:45:00'),
(3, 3, 1, NULL, 'OUT', '2026-02-21 08:30:00'),
(4, 11, 1, NULL, 'IN', '2026-02-22 11:55:00'),
(5, 6, 2, NULL, 'IN', '2026-03-02 16:01:00'),
(6, 2, 2, NULL, 'IN', '2026-03-04 07:20:00'),
(7, 12, 5, NULL, 'IN', '2026-03-19 17:45:00'),
(8, 14, 5, NULL, 'OUT', '2026-03-02 13:10:00'),
(9, 4, NULL, 4, 'IN', '2026-04-22 12:05:00'),
(10, 15, 7, NULL, 'IN', '2026-04-18 15:06:00'),
(11, 6, 8, NULL, 'IN', '2026-04-24 15:33:00'),
(12, 8, 9, NULL, 'IN', '2026-04-25 15:12:00'),
(13, 9, 10, NULL, 'IN', '2026-04-27 15:47:00'),
(14, 7, 1, NULL, 'IN', '2026-04-27 16:05:00'),
(15, 13, 10, NULL, 'IN', '2026-04-27 16:30:00'),
(16, 2, 9, NULL, 'IN', '2026-04-27 18:40:00'),
(17, 11, 8, NULL, 'IN', '2026-04-28 07:55:00'),
(18, 13, 4, NULL, 'IN', '2026-04-28 08:02:00'),
(19, 10, 11, NULL, 'IN', '2026-04-28 15:21:00'),
(20, 1, NULL, 5, 'IN', '2026-04-28 16:05:00'),
(21, 7, 1, NULL, 'OUT', '2026-04-28 17:10:00'),
(22, 8, 9, NULL, 'OUT', '2026-04-28 17:35:00'),
(23, 9, 10, NULL, 'OUT', '2026-04-28 17:50:00'),
(24, 12, 14, NULL, 'IN', '2026-04-30 17:40:00');

INSERT INTO guest_message (messageId, guestId, messageContent, messageTime) VALUES
(1, 1, 'Package waiting at front desk.', '2026-02-21 17:30:00'),
(2, 5, 'Late checkout approved until 2 PM.', '2026-04-01 09:00:00'),
(3, 3, 'Shuttle to conference center leaves at 8 AM.', '2026-03-12 20:00:00'),
(4, 8, 'Dry cleaning is ready at the front desk.', '2026-04-26 19:15:00'),
(5, 9, 'Robotics team packets were delivered to suite 205.', '2026-04-27 21:05:00'),
(6, 10, 'Breakfast vouchers are available at concierge.', '2026-04-28 19:00:00'),
(7, 11, 'Airport car confirmed for 11 AM checkout.', '2026-04-28 20:10:00'),
(8, 5, 'Please call the sales manager regarding the sponsor invoice.', '2026-03-19 16:45:00'),
(9, 1, 'Moved to suite 204 due to HVAC issue in room 203.', '2026-04-27 14:20:00'),
(10, 12, 'Your room will be ready after 4 PM on arrival day.', '2026-04-28 13:10:00');
