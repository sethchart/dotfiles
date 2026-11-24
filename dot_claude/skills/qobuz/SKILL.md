---
name: qobuz
description: Search the Qobuz catalog, build or edit the user's Qobuz playlists, and add or remove favorites with the local `qobuz` CLI (qobuz-cli). Use whenever the user asks to find music, make a playlist ("20 minutes of X", "add these to Qobuz"), list their playlists/favorites, look up an album or artist, or play something on Qobuz.
---

# Qobuz via `qobuz` CLI

The user's own Rust client, installed at `~/.cargo/bin/qobuz` (source: `~/workspace/qobuz-cli`, README there has full detail). It is already signed in, so there's no need to rediscover it or re-check `--help`.

## Output conventions

- TSV with the **ID in column 1**. Add `--json` for NDJSON (pipe to `jq`).
- `-` as an argument reads IDs from stdin. Single-item commands use the first line; `append`/`queue` use every line.
- Exit codes: `0` ok, `1` error, `2` usage, `3` login required. On `3`, ask the user to run `! qobuz login` (or `! qobuz player login` for playback).

## Commands and their columns

| Command | Output columns |
|---|---|
| `qobuz search -t track -n 5 <query>` | track_id, artist, title, album, duration (m:ss), quality |
| `qobuz search [-t album] -n 5 <query>` | album_id, artist, title, year, track_count, quality |
| `qobuz search -t artist <query>` | artist_id, name, album_count |
| `qobuz search -t playlist <query>` | playlist_id, … |
| `qobuz album <album_id>` | the album's tracks (same columns as a track search) |
| `qobuz artist <artist_id>` | the artist's releases |
| `qobuz playlists` | playlist_id, name, owner, track_count |
| `qobuz playlist <playlist_id>` | the playlist's tracks (same columns as a track search) |
| `qobuz favorites [list] -t track\|album\|artist` | the user's favorites (same columns as that kind's search) |
| `qobuz whoami` | user_id, email, name, country, … |

`search` defaults to **albums** and a limit of 50, so pass `-t track -n 5` when looking for tracks.

## Changing the account (only these commands do this)

- `qobuz append "<exact playlist name>" <track_id>...`: adds the tracks to that playlist, **creating it if it doesn't exist**, and skips tracks it already holds, so it's safe to re-run. Prints `playlist_id  name  owner  count`. Track order follows the argument order. Nothing can remove or reorder tracks; if a change needs that, tell the user to do it in the app.
- `qobuz queue <track_id>...`: **replaces** the private "qobuz-cli queue" playlist.
- `qobuz favorites add|remove [-t album|track|artist] <id>...|-`: adds or removes favorites. The type defaults to album and goes **after** `add`/`remove`. It's idempotent and prints nothing, so confirm with `qobuz favorites -t <kind>`. Track and artist IDs are numbers; album IDs are alphanumeric.

## Playback (interactive, so the user runs it)

`qobuz play album|playlist <id>` is an interactive TUI (space, n, p, q). Don't run it through Bash. Give the user the command, e.g. `! qobuz play playlist 74026909`. `qobuz chain` checks the audio path of whatever is playing.

## Playlist-building workflow

1. Draft candidate tracks from your own knowledge, aiming for the requested length or mood.
2. Run all the searches in **one** Bash call so they resolve together:
   `for q in "Artist Title" ...; do echo "== $q"; qobuz search -t track -n 5 $q; done`
3. Choose the **original album** version over remixes, DJ-mix edits, covers and compilations, unless the user asks otherwise. Use the real durations from column 5. If a track is missing, swap in another one.
4. Check the total length:
   `printf '%s\n' 4:19 4:51 | awk -F: '{s+=$1*60+$2} END{printf "%d:%02d\n", s/60, s%60}'`
5. `qobuz append "<Name>" id1 id2 ...`, then confirm with `qobuz playlist <id>`.
6. Report a table (artist, track, length), the total, the playlist name and ID, and the play command.

Before appending to a playlist that **already exists** (check `qobuz playlists`), confirm with the user, unless they asked to add to it.
