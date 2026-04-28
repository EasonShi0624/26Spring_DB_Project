import sqlite3
from pathlib import Path

BASE_DIR = Path(__file__).resolve().parent
DB_PATH = BASE_DIR / "last_resort.db"


def main() -> None:
    if DB_PATH.exists():
        DB_PATH.unlink()

    connection = sqlite3.connect(DB_PATH)

    try:
        connection.executescript((BASE_DIR / "createTables.sql").read_text(encoding="utf-8"))
        connection.executescript((BASE_DIR / "insertRows.sql").read_text(encoding="utf-8"))
        connection.commit()
    finally:
        connection.close()

    print("last_resort.db created.")


if __name__ == "__main__":
    main()
