extends Control
## Play screen: arrow buttons push the box (the buttons travel with it).
## Return goes back to the main menu.

const MAIN_MENU_SCENE := "res://scenes/main_menu.tscn"
## Pixels the box moves per button press.
const PUSH_DISTANCE := 24.0

@onready var _rig: Control = %BoxRig


func _ready() -> void:
	%UpButton.pressed.connect(push.bind(Vector2.UP))
	%DownButton.pressed.connect(push.bind(Vector2.DOWN))
	%LeftButton.pressed.connect(push.bind(Vector2.LEFT))
	%RightButton.pressed.connect(push.bind(Vector2.RIGHT))
	%ReturnButton.pressed.connect(_on_return_pressed)


## Moves the box one step in [param direction], kept fully on screen.
func push(direction: Vector2) -> void:
	var max_position := (size - _rig.size).max(Vector2.ZERO)
	_rig.position = (_rig.position + direction * PUSH_DISTANCE).clamp(Vector2.ZERO, max_position)


func _on_return_pressed() -> void:
	go_to_scene(MAIN_MENU_SCENE)


## Wrapped so tests can stub scene changes.
func go_to_scene(path: String) -> void:
	get_tree().change_scene_to_file(path)
