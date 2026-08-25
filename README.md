# Checkmate & Ruin

A tactics-RPG played on the board itself. Standard chess rules, but capture is replaced with combat: every piece has hit points, deals a damage range, levels up, and can survive to fight again next round. Move a company of chess pieces through a branching campaign map, region by region, toward each region's boss.

Chess supplies the board and the geometry of movement. The RPG supplies everything chess refuses to have: hit points, growth, and consequence that isn't instant.

## Playing it

It's a single self-contained HTML file with no build step and no server-side code. Open `index.html` directly in a browser, or serve the folder with anything static:

```
python3 -m http.server 8000
```

then visit `http://localhost:8000/`.

It can also be installed to a phone's home screen ("Add to Home Screen" in the browser menu) and runs full-screen from there, since it's meant to be played mostly on Android.

Progress (your current run and your all-time Hall of Champions record) is saved to the browser's local storage, per device. There's no account and no server, so progress doesn't sync across devices.

## What's in it

- **Chess, unmodified.** Every piece keeps its exact legal moves. The only rule that changes is what happens when a move lands on an occupied square: a fight, not an instant capture.
- **A 7-region campaign**, each with a named boss, its own enemy roster, and its own flavor and lore. A branching map between fights offers rest stops, shrines, relic caches, and wayfarer encounters.
- **Growth and promotion.** Surviving pieces gain experience and level up; a pawn that reaches the far rank promotes into a chosen class instead of an automatic queen.
- **A Chronicle tab** that tells the campaign's story in-game, unlocking each region's lore as your own save actually reaches it.
- **Achievements and a Hall of Champions**, tracked locally across runs.
- Light/dark themes, reduced-motion support, and keyboard/screen-reader-accessible play.

## Credits

Piece artwork is the "cburnett" chess set by [Colin M.L. Burnett](https://en.wikipedia.org/wiki/User:Cburnett), used under [GPLv2+](https://www.gnu.org/licenses/old-licenses/gpl-2.0.html) as published by [lichess.org](https://github.com/lichess-org/lila).

Fonts (Cinzel, Crimson Pro, JetBrains Mono) are loaded from Google Fonts.
