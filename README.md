# Chess Battlefield — 3D Battle Chess

A full 3D chess game in the browser where every piece is a living warrior and every
capture is an execution, fought in a jungle clearing.

## How to run

**Option A (recommended):** serve the folder and open it in any browser:

```
npx http-server -p 8423 .
```

then visit http://localhost:8423

**Option B:** just double-click `index.html` (works in Chrome / Edge — the page is a
single self-contained file; Three.js loads from a CDN, so you need internet access).

## The armies

| Piece  | Who they are | How they kill |
|--------|--------------|---------------|
| King   | Crowned, caped monarch (real rigged model) | **Draws the katana from his back**, raises it overhead and slashes down — the victim is launched flying — then **sheathes it** again. Real skeletal animation. |
| Queen  | A rigged warrior-queen with a weapon | **Swings her weapon** (her own attack animation) — the victim is cut down |
| Knight | A **real horse** | Rears up onto its hind legs and **slams its hooves** down — victim kicked flying |
| Rook   | A **rigged war elephant** | **Wraps the victim in its trunk**, hoists it off the ground, and **flings it** off the board — using the model's own pick/throw animations (the victim physically rides the trunk) |
| Bishop | Robed swordsman (real model) | A fast horizontal **neck-high slash** — the victim topples |
| Pawn   | Human foot-soldier with a **sword** (real rigged model) | A trained diagonal **sword slash** across the neck. Real skeletal animation. |

Each piece has its own unique kill. The **king and pawn are fully rigged** — they
walk with real articulated legs and arms (proper stride: heel-strike, knee-bend,
counter-swinging arms) and swing their weapons with their actual skeletons. The
queen, bishop, elephant and horse are single-mesh models (no skeleton), so their
kills are choreographed through dramatic whole-body motion and the victim's
trajectory — the queen physically lifts and throws her prey. Boneless pieces get
a subtle weight-shift sway when walking so they stride rather than glide.

On **checkmate**, every enemy piece attacking the king converges and executes him
in a cinematic close-up — each using its own kill move.

## Checkmate = Execution

When a king is checkmated, the game doesn't just end: every enemy piece that is
attacking the king marches across the board, surrounds him, and strikes him in
turn while the camera drops into a slow close-up orbit. The final blow kills him
(mace / hooves / hammer send him flying; blades and claws drop him where he stands).

## War-zone ambience

No butterflies here: smoke columns rise from distant fires, embers drift up,
carrion birds wheel overhead (flap–glide cycles), war banners of both kingdoms
sway behind the armies, and the ground near the arena is churned to mud and
littered with the swords, shields and felled logs of earlier battles.

## Real models already included

This repo ships with real downloaded models, already wired in:

- `models/p_w.glb` / `p_b.glb` — **rigged soldier** (three.js sample, skinned) as
  the pawns; plays its real *Idle* clip standing and *Walk* clip when marching.
  The black army is automatically tinted obsidian-dark.
- `models/n_w.glb` / `n_b.glb` — **animated horse** (three.js sample) as the
  knights; plays its real gallop clip while moving.
- `assets/trees/jacaranda.glb` — **photoscanned jacaranda tree** (Poly Haven,
  CC0), decimated from a 203 MB scan to 4 MB / 50k triangles (plus a 1.5 MB
  low version used by the Low/Medium quality tiers). A ring of them surrounds
  the arena; count scales with quality.

Delete any of these files to fall back to the procedural warriors.

## Swapping in better models (photoreal characters / horses)

To go further (e.g. medieval knights from Mixamo or Sketchfab), drop glTF
binary files into the `models/` folder — they're picked up automatically at
start:

| File | Replaces |
|------|----------|
| `models/p_w.glb`, `models/p_b.glb` | white / black pawns |
| `models/n_w.glb`, `models/n_b.glb` | knights (horse + rider) |
| `models/b_w.glb`, `models/b_b.glb` | bishops |
| `models/r_w.glb`, `models/r_b.glb` | rooks |
| `models/q_w.glb`, `models/q_b.glb` | queens |
| `models/k_w.glb`, `models/k_b.glb` | kings |

Models are auto-scaled to the right piece height (skinning-aware, so Mixamo
bone scaling is handled) and grounded; if the file contains animation clips,
*idle* and *walk/run/gallop* clips are detected by name and played
automatically. They keep the walking, turning, lunging, fly-off and collapse
motion. If a model walks backwards, flip its entry in `MODEL_YAW` inside
`index.html` (glTF standard is +Z forward; some models face -Z).

**Where to get great free models:**

- **Mixamo (mixamo.com)** — free Adobe service. Realistic rigged human warriors
  (search "Knight", "Paladin", "Warrior", "Swordsman", "Maw") + hundreds of
  animations (sword slash, mace swing, deaths). Export FBX → convert to GLB with
  Blender (File → Export → glTF 2.0) and drop in `models/`.
- **Sketchfab (sketchfab.com)** — filter by *Downloadable* + license **CC0 / CC-BY**.
  Search "realistic horse rigged", "medieval knight", "realistic tree". Download
  as glTF/GLB directly.
- **Poly Haven (polyhaven.com)** — CC0 photoreal PBR textures (bark, forest
  floor, moss) and some tree models.
- **Quaternius / Kenney / Poly Pizza** — free stylized packs if you want lighter
  files.
- Three.js also ships sample rigged models (`Soldier.glb`, animated `Horse.glb`)
  on its CDN, useful for quick tests.

Tip: keep each GLB under ~5–10 MB and prefer models with baked textures, or
low-end GPUs will struggle.

## Views

- **Classic** — the way people play, behind your army
- **Top-Down** — traditional board view
- **Cinematic** — slow auto-orbit around the battle
- **Battlefield** — low ground-level angle
- Free orbit any time: drag to rotate, scroll to zoom

## Graphics quality

Low / Medium / High / Ultra — selectable at start and switchable live in-game.
Low runs without shadows at reduced resolution for integrated GPUs; Ultra adds
4K shadows, dense jungle, god rays, fireflies and butterflies. The whole jungle
is GPU-instanced, so even Ultra costs only ~10 draw calls of vegetation.

## Rules

Full chess: legal-move highlighting, check / checkmate / stalemate, castling
(both pieces march simultaneously), en passant, promotion (with model swap).
Play hot-seat against a friend, or against the computer — powered by a real
**Stockfish** chess engine (WebAssembly, bundled locally in `lib/`, ~650 KB).
Three strengths: **Easy** (simple built-in AI, beatable), **Medium**
(Stockfish skill 5), **Grandmaster** (full strength). If the engine can't
load, the built-in AI takes over automatically.

**Time controls:** Unlimited, 1+0 Bullet, 3+0 / 3+2 / 5+0 Blitz, 10+0 /
15+10 Rapid, 30+0 Classical. Clocks flank the turn banner, the active side
glows, under 20 seconds pulses red, and running out loses the game on time.
The clock pauses during battle animations so cinematic kills don't eat your
thinking time.
Synthesized sound effects (hooves, sword whooshes, mace clangs) — no audio files.

Everything is procedural in one `index.html` — no build step, no downloads, no assets.
