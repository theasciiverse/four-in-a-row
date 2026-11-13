# Four in a Row

The vertical four-in-a-row game, for the Asciiverse catalog. Rust + Ratatui,
our own code, MIT. Started 2026-11-13 (David picked the genre from a gap in
the catalog; neither open terminal version found was more than a
prompt-and-Enter exercise: vronadev/connect-four.rs, Sondrems09/FourInARust).

**Status:** 0.5.0, playable: four computer levels, two players, watch and
demo, four boards, mouse, gamepad, sound. Own git repo, private at
github.com/theasciiverse/four-in-a-row, folder `games/four-in-a-row`.

## Name

Listed as **Four in a Row**, never Connect Four or Connect 4: Hasbro holds
CONNECT 4 (US Reg. 3335741, Class 28, games). Same rule as Ninuki (PENTE)
and Bastet (never Tetris). Rules of the game itself are free to use.

## Code

- `board.rs`: two bitboards (`cur` = side to move, `mask` = all), `h + 1`
  bits per column with an always-empty sentinel on top, so lines never wrap
  between columns. Any size up to 10x8 (90 bits of a u128). Lines of n by
  shift-and (`m &= m >> d`, n - 1 times) in four directions; `winning_cells`
  walks the runs for the highlight. Tests compare against a plain scan on
  random games for every board, every possible window, and the edges.
- `engine.rs`: negamax, alpha-beta, a 2^18 transposition table, iterative
  deepening with a clock, centre-first order. Wins now and forced blocks
  are found before searching; two threats at once is a loss. The leaf
  evaluation counts windows with only one side's discs (weights by how
  close they are to a line). At the root only the best is searched exactly
  (alpha = best - 1), so ties still come out exact and are picked at random.
  Levels: Easy (depth 2, noise on quiet scores), Normal (5), Hard (8, 0.6 s),
  Master (as deep as 2.5 s allow). `cargo test --release ladder -- --ignored
  --nocapture` plays each level against the one below.
- `app.rs`: title menu, match, falling disc (gravity 90 rows/s²), the
  computer in its own thread with a minimum 0.45 s think so moves can be
  followed, undo (back to the last human turn), rematch (the other colour
  starts). Red is colour 0 and is always you against the computer; board
  player p has colour `p ^ starter`.
- `render.rs`: picks the largest disc that fits (6x3, 4x2, 3x1 cells),
  blue frame, the column in play lit, the winning line pulsing, others
  dimmed. `geom` is shared with the mouse code in main.rs.
- `audio.rs`: square, triangle and noise notes made in code (1D-Pong's).
- `store.rs`: level, board, mute and won/lost per level, in
  `$XDG_DATA_HOME/four-in-a-row/state`.

## Logging

Session logging per the Asciiverse convention: every key, click, command,
move, game over, the engine's depth, node count and root scores, and a
snapshot each second. `RUST_LOG=debug four-in-a-row 2>four-in-a-row.log`.

## Preview

`asciiverse/record-preview.sh` records `asciiverse/four-in-a-row.cast` at
100x30 with hub's castrec: `--demo` (the computer against itself, Normal,
Classic board), 45 s.

## Ideas not done

Pop Out (take a disc of yours out of the bottom), a 5-in-a-row on a
bigger board with more than two players, network play over iroh.
