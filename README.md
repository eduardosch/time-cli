# time-cli

> A tiny collection of bash scripts that turns your terminal into a big, blocky clock.

```
    ██    ██████      ██████  ██  ██      ██████  ██████
    ██        ██  ██      ██  ██  ██  ██  ██      ██    
    ██    ██████      ██████  ██████      ██████  ██████
    ██    ██      ██      ██      ██  ██      ██  ██  ██
    ██    ██████      ██████      ██      ██████  ██████
                        powered by github.com/eduardosch
```

No dependencies. No npm install. No Docker. Just bash and a love for oversized pixels.

---

## Why?

Because sometimes you need to know what time it is from across the room,  
and because building a clock in pure bash using block characters (`██`) is  
genuinely a fun puzzle.

Each digit is a 3×5 grid of on/off bits hardcoded in `clock_lib.sh`. The whole  
rendering engine is under 50 lines of shell script.

---

## Scripts

| Script | What it does |
|---|---|
| `watch.sh` | Live clock — shows the current time, updates every second |
| `stopwatch.sh` | Counts up from zero; press `ENTER` to stop |
| `timer.sh hh:mm` | Counts down from the given time; rings an alarm at zero |
| `help.sh` | Shows the command reference alongside a running live clock |

---

## Quick start

Clone the repo and run any script directly:

```bash
git clone https://github.com/eduardosch/time-cli.git
cd time-cli

bash watch.sh          # current time, big and live
bash stopwatch.sh      # count up from zero
bash timer.sh 0:25     # 25-minute Pomodoro timer
bash help.sh           # help screen with a live clock in the corner
```

All scripts accept `-h` / `--help` for usage details.

---

## Controls

| Key | Action |
|---|---|
| `CTRL+C` | Exit any script |
| `ENTER` | Stop the stopwatch |

---

## How the digits work

`clock_lib.sh` encodes digits 0–9 as 15-bit bitmaps (3 columns × 5 rows).  
Each bit maps to either `██` (on) or two spaces (off).  
The colon separator blinks on rows 1 and 3.  
That's literally it.

---

## Curiosities

- The entire renderer fits in ~50 lines of bash with zero external dependencies.
- `tput` handles cursor hiding and in-place refresh — no `clear` flickering.
- The timer uses wall-clock subtraction (`date +%s`) instead of a sleep loop, so it stays accurate even if the system is under load.
- `read -t 0.1` is the refresh tick — it doubles as a non-blocking key listener.

---

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for the full version history.
