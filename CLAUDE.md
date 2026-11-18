# godot-hello-world

Hello world in Godot 4.7 (GDScript): a main menu (Start / Exit) and a play screen where arrow buttons push a box, with a Return button. Shared Godot rules (engine paths, conventions, GUT commands) are in the parent folder's CLAUDE.md; global git and testing rules in ~/.claude/CLAUDE.md also apply.

## Project
- Renderer: Mobile.
- Main scene: `scenes/main_menu.tscn`. Play screen: `scenes/play.tscn`.
- Tests: GUT 9.7.1 in `addons/gut`; tests in `test/unit/`.

## Commands
Same as the parent Godot CLAUDE.md, run from this folder:
- Narrow tests: `"$GODOT" --headless --path . -s addons/gut/gut_cmdln.gd -gconfig= -gexit -gtest=res://test/unit/test_<name>.gd`
- Full suite (promotions only): `"$GODOT" --headless --path . -s addons/gut/gut_cmdln.gd`
- Smoke run: `"$GODOT" --headless --path . --quit-after 300`
