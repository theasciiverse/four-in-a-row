# Four in a Row

Drop discs, line up four, in the terminal.

Take turns dropping a disc into one of the columns; it falls to the
lowest free place. The first to line up four of their own, across, up or
on a slant, wins. Fill the board without a line and it's a draw.

## Play

```bash
cargo run --release                      # the menu
cargo run --release -- --level master    # pick the computer's level first
cargo run --release -- --two             # two players at one keyboard
cargo run --release -- --watch           # the computer plays itself
cargo run --release -- --help            # everything else
```

Or with av: `av install four-in-a-row`, then start it from av's list.

- **← →** (or A D, H L, the mouse) choose a column; **Space**, **Enter**,
  **↓** or a click drops. **1** to **9** and **0** drop straight into a column.
- **U** (or a right click) takes your move back, and the computer's answer.
- **M** sound on or off, **Esc** back to the menu, **Q** quits from the menu.
- Gamepad: d-pad left and right, **A** drops, **X** takes back, **Start** for the menu.

## The computer

Four levels: Easy misjudges quiet positions but never misses a win or a
block in one; Normal looks five moves ahead; Hard eight; Master searches as
deep as two and a half seconds allow. Who starts alternates from game to
game. Games won and lost against each level are kept in
`~/.local/share/four-in-a-row/state`.

## Boards

- **Classic**: 7 columns, 6 rows, four in a row
- **Wide**: 8 by 7
- **Grand**: 9 by 7
- **Five**: 10 by 8, and it takes five in a row

## Logging

`RUST_LOG=debug four-in-a-row 2>four-in-a-row.log` writes every key,
click, move, the computer's scores and a snapshot each second.

## Licence

MIT. An original Asciiverse game.
