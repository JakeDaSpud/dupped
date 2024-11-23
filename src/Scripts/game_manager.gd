extends Node2D

@export var game_over : bool = false;
@export var _mute_audio : bool = false;
@export var in_menu : bool = true;

var score : int = 0;

func _process(delta) -> void:
	if in_menu && (Input.is_action_just_pressed("button_gamepad") || Input.is_action_just_pressed("button_keyboard") || Input.is_action_just_pressed("button_mouse")):
		_start_game();
	
	if game_over && (Input.is_action_just_pressed("button_gamepad") || Input.is_action_just_pressed("button_keyboard") || Input.is_action_just_pressed("button_mouse")):
		_restart();

func _start_game() -> void:
	in_menu = false;
	$Menu.visible = false;
	$Player.visible = true;
	$Level/scoreboard.visible = true;

func end_game() -> void:
	self.game_over = true;

func _restart() -> void:
	get_tree().reload_current_scene();

func add_points(points_to_add : int) -> void:
	if (self.score < 999):
		self.score = self.score + points_to_add;
	_draw_score();

func _draw_score() -> void:
	var s : String = str(score);
	
	var s1 = s.substr(0, -3);
	var s2 = s.substr(0, -2);
	var s3 = s.substr(0, -1);
	
	$Level/scoreboard/score1.frame = int(s1);
	$Level/scoreboard/score2.frame = int(s2);
	$Level/scoreboard/score3.frame = int(s3);
	
