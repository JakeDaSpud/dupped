extends Node2D

@export var game_over : bool = false;
@export var _mute_audio : bool = false;
@export var _in_menu : bool = true;

var score : int = 0;

func _process(delta) -> void:
	if _in_menu && (Input.is_action_just_pressed("button_gamepad") || Input.is_action_just_pressed("button_keyboard") || Input.is_action_just_pressed("button_mouse")):
		_in_menu = false;
	

func end_game() -> void:
	self.game_over = true;

func _restart() -> void:
	get_tree().reload_current_scene();

func add_points(points_to_add : int) -> void:
	self.score = self.score + points_to_add;
