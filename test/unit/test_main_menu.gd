extends GutTest

const MainMenuScene := preload("res://scenes/main_menu.tscn")

var _menu: Control


func before_each() -> void:
	_menu = partial_double(MainMenuScene).instantiate()
	stub(_menu, "go_to_scene").to_do_nothing()
	stub(_menu, "quit_game").to_do_nothing()
	add_child_autofree(_menu)


func test_start_opens_play_screen() -> void:
	_menu.get_node("%StartButton").pressed.emit()
	assert_called(_menu, "go_to_scene", ["res://scenes/play.tscn"])


func test_exit_quits() -> void:
	_menu.get_node("%ExitButton").pressed.emit()
	assert_called(_menu, "quit_game")


func test_play_scene_exists() -> void:
	assert_true(ResourceLoader.exists(_menu.PLAY_SCENE), "play scene path should resolve")
