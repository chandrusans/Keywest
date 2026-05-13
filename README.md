# Florida Keys Trip Planner 🌴

A live, real-time-synced trip planner for our family Florida Keys getaway, May 22–27, 2026.

**Live site:** https://chandrusans.github.io/Keywest/

Every change anyone makes — logging an expense, checking off the bucket list,
editing an activity — appears on everyone else's screen within ~1 second.

## What's inside

- **Itinerary** — 6 pre-loaded days with times, activities, planned costs, and tolls
- **Expenses** — Log spending as it happens, auto-categorized and graphed
- **Bucket List** — 15 Keys-specific things to do, tap to check off
- **Overview** — Budget dial, category breakdown, trip-at-a-glance stats
- **Real-time sync** — All devices stay in sync via Supabase

## First-time setup (5 minutes, one-time)

The planner uses [Supabase](https://supabase.com) (free tier) as a shared database.
You only need to do this once — everyone else just visits the URL.

### Step 1 — Create a free Supabase project (2 min)

1. Go to [supabase.com](https://supabase.com) and click **Start your project**
2. Sign in with GitHub (easiest) or email
3. Click **New project**
   - Name: `keys-trip` (or anything)
   - Database password: anything strong (you won't need it again)
   - Region: pick the one closest to you (e.g., `us-east-1`)
4. Wait ~1 minute for the project to spin up

### Step 2 — Run the database setup SQL (30 seconds)

1. In your new Supabase project, click **SQL Editor** in the left sidebar
2. Click **New query**
3. Open `supabase_setup.sql` from this repo, copy everything, paste into the editor
4. Click **Run** (or `Cmd/Ctrl + Enter`)
5. You should see "Success. No rows returned" — that's right

### Step 3 — Grab your two values (1 min)

1. In Supabase, click **Settings** (gear icon, bottom left)
2. Click **API**
3. Copy two values:
   - **Project URL** (looks like `https://abcd1234.supabase.co`)
   - **anon public** key (long string starting with `eyJhbG...`)

### Step 4 — Open the planner and paste them in (30 seconds)

1. Open https://chandrusans.github.io/Keywest/
2. A setup screen appears on first load
3. Paste your Project URL and anon key
4. Click **Connect & sync**

You should see a green **"Live · synced"** pill in the top-right corner. Done!

### Step 5 — Share with the other family (1 min)

Send them three things:
1. The site URL: https://chandrusans.github.io/Keywest/
2. The Project URL
3. The anon key

They paste the same two values into their setup screen and they're synced.

> **Tip**: send them this README and they can follow Step 4 only — they don't need
> to create their own Supabase account or run the SQL.

## Day-to-day use

Open the URL on your phone or laptop. Every edit saves automatically — no save button.
Watch the **sync pill** at the top:

- 🟢 **Live · synced** — All good, changes sync to everyone in ~1 second
- 🟡 **Local only** — Setup not complete or you clicked "Skip"; changes save just on this device
- 🔴 **Sync error** — Network issue or Supabase config is off; changes still save locally

Click the sync pill anytime to re-enter your Supabase settings.

**Pro tip — add to home screen.** On iOS or Android, open the page in a browser and tap
"Add to Home Screen". You get an app icon (the sun) that opens straight to the planner
with no browser chrome.

## How the sync works

- One row in a `trip_data` table holds the entire trip state as JSON
- The planner subscribes to Postgres realtime changes on that row
- Any edit triggers a write within 400ms (debounced)
- Other devices receive the change via WebSocket and update their UI
- If two people edit simultaneously, last write wins (rare for a trip planner)
- The site also caches everything to your browser's localStorage so it works offline

## Local development

Just open `index.html` in any browser. No build step, no `npm install`.

You can also test locally before pushing:
```bash
python3 -m http.server 8000
# visit http://localhost:8000
```

## Tech stack

- **Frontend**: Vanilla HTML/CSS/JS, no framework. Single file.
- **Backend**: Supabase (Postgres + realtime), free tier.
- **Hosting**: GitHub Pages, free.
- **Fonts**: Google Fonts (Fraunces + DM Sans)

## Privacy & security note

The Supabase anon key is embedded in your browser's localStorage after setup. Anyone
who has both the site URL **and** can guess your Supabase project URL+key could read or
modify trip data. For a family trip planner this is fine — the URLs aren't public and
the data isn't sensitive. Don't reuse this pattern for anything you'd be upset to leak.

## Trip details

- **Travelers**: 7 (2 families: 2+2 kids, 2+1 teen)
- **Dates**: Fri May 22 – Wed May 27, 2026
- **Resort**: Amara Cay, Islamorada (MM 80)
- **Budget**: $3,700 (food + activities, excluding flights/hotel/car)
