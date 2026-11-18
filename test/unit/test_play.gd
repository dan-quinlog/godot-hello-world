extends GutTest

const PlayScene := preload("res://scenes/play.tscn")

var _play: Control
var _rig: Control


func before_each() -> void:
	_play = partial_double(PlayScene).instantiate()
	stub(_play, "go_to_scene").to_do_nothing()
	add_child_autofree(_play)
	# Let containers lay out so the rig has its real size and position.
	await wait_process_frames(2)
	_rig = _play.get_node("%BoxRig")


func test_box_starts_centered() -> void:
	var rig_center := _rig.position + _rig.size / 2.0
	assert_almost_eq(rig_center, _play.size / 2.0, Vector2.ONE, "box rig should start centered")


func test_each_arrow_pushes_box_one_step() -> void:
	var cases := {
		"%UpButton": Vector2.UP,
		"%DownButton": Vector2.DOWN,
		"%LeftButton": Vector2.LEFT,
		"%RightButton": Vector2.RIGHT,
	}
	for button_path in cases:
		var before := _rig.position
		_play.get_node(button_path).pressed.emit()
		var expected: Vector2 = before + cases[button_path] * _play.PUSH_DISTANCE
		assert_eq(_rig.position, expected, "%s should push one step" % button_path)


func test_box_stays_on_screen() -> void:
	for i in 200:
		_play.push(Vector2.LEFT)
		_play.push(Vector2.UP)
	assert_eq(_rig.position, Vector2.ZERO, "box should stop at the top-left edge")

	for i in 200:
		_play.push(Vector2.RIGHT)
		_play.push(Vector2.DOWN)
	assert_eq(_rig.position, _play.size - _rig.size, "box should stop at the bottom-right edge")


func test_return_goes_to_main_menu() -> void:
	_play.get_node("%ReturnButton").pressed.emit()
	assert_called(_play, "go_to_scene", ["res://scenes/main_menu.tscn"])
