# godot-hello-world

Hello world in Godot 4.7 (GDScript): a main menu (Start / Exit) and a play screen where arrow buttons push a box, with a Return button. Global git and testing rules in ~/.claude/CLAUDE.md also apply.

## Stack
- Godot 4.7.x, standard (non-.NET) build. Stay current on 4.7 patch releases.
- Language: GDScript only. Use static types (`var x: int`, `-> void`).
- Tests: GUT 9.7.x in `addons/gut` (MIT, from github.com/bitwes/Gut). Upgrade it together with Godot.
- Renderer: Mobile.

## Layout
- `scenes/`: `.tscn` scenes. `main_menu.tscn` is the main scene.
- `scripts/`: one script per scene.
- `test/unit/`: GUT tests, named `test_<script>.gd`.
- Commit `*.uid` and `*.import` files. `.godot/` is ignored.

## Conventions
- Find nodes by unique name (`%Name`) and connect signals in `_ready()`, not in the scene file.
- Wrap scene changes and quitting in methods (`go_to_scene`, `quit_game`) so tests can stub them with `partial_double`.
- Hand-edit `.tscn` files only for small text changes, and tell me so I can check them in the editor.

## Commands
Godot is installed in `C:\outterspacebar\Godot\Godot_v4.7.2-stable_win64\`. It has two executables:
- `Godot_v4.7.2-stable_win64.exe`: the editor and normal runs.
- `Godot_v4.7.2-stable_win64_console.exe`: headless commands and tests, because it prints output to the terminal.

`GODOT` = `/c/outterspacebar/Godot/Godot_v4.7.2-stable_win64/Godot_v4.7.2-stable_win64_console.exe` (Git Bash path)
- First run on a fresh clone (builds the `.godot/` cache): `"$GODOT" --headless --path . --import`
- Run the game: `"$GODOT" --path .`
- Narrow tests (only the test files for changed scripts): `"$GODOT" --headless --path . -s addons/gut/gut_cmdln.gd -gconfig= -gexit -gtest=res://test/unit/test_<name>.gd`
  - `-gconfig=` skips `.gutconfig.json`. Without it, `-gtest` adds to the config's folders and the whole suite runs.
  - For several files, repeat `-gtest=` or separate the paths with commas.
- Smoke-run the game headless (catches script errors): `"$GODOT" --headless --path . --quit-after 300`
- Full suite (promotions only): `"$GODOT" --headless --path . -s addons/gut/gut_cmdln.gd` (settings from `.gutconfig.json`)
