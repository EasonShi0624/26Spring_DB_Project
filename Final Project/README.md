# Last Resort Hotel Final Project

This folder follows the same workflow as the course bookstore examples:

- `createTables.sql` creates the SQLite tables
- `insertRows.sql` inserts quarter-long sample data
- `seed.py` rebuilds `last_resort.db`
- `app.py` runs the Flask website
- `templates/` stores the Jinja pages
- `static/css/main.css` stores all page styles

## Rebuild the database

Run this command from `Final Project/hotel_src`:

```bash
python seed.py
```

This deletes any old `last_resort.db` file and recreates it from the SQL scripts.

## Run the Flask app

```bash
python app.py
```

Then open the local URL shown in the terminal, usually:

```text
http://127.0.0.1:8080
```

## Included final-project features

- A quarter of reservation, event, billing, and tracking data
- Reader locations for card swipe logs
- `hostPartyId` for events so hosts and billed parties use the same party model
- A dashboard page for room availability, status, current guests, and event activity
- A billing page for account balances, revenue summaries, and guest contact information
