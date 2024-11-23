extends Node2D

@export var _game_over : bool = false;
@export var _mute_audio : bool = false;
@export var _in_menu : bool = true;

#func _ready():
	

func _process(delta):
	if _in_menu && (Input.is_action_just_pressed("button_gamepad") || Input.is_action_just_pressed("button_keyboard") || Input.is_action_just_pressed("button_mouse")):
		_in_menu = false;
	
	if _game_over && (Input.is_action_just_pressed("button_gamepad") || Input.is_action_just_pressed("button_keyboard") || Input.is_action_just_pressed("button_mouse")):
		get_tree().reload_current_scene();
	
