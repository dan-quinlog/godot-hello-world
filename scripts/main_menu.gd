extends Control
## Main menu: Start opens the play screen, Exit quits the game.

const PLAY_SCENE := "res://scenes/play.tscn"


func _ready() -> void:
	%StartButton.pressed.connect(_on_start_pressed)
	%ExitButton.pressed.connect(_on_exit_pressed)
	%StartButton.grab_focus()


func _on_start_pressed() -> void:
	go_to_scene(PLAY_SCENE)


func _on_exit_pressed() -> void:
	quit_game()


## Wrapped so tests can stub scene changes.
func go_to_scene(path: String) -> void:
	get_tree().change_scene_to_file(path)


## Wrapped so tests can stub quitting.
func quit_game() -> void:
	get_tree().quit()
