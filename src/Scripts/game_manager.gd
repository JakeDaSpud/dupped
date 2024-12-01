extends Node2D

@export var game_over : bool = false;
@export var _mute_audio : bool = false;
@export var in_menu : bool = true;

var score : int = 0;
var point_speed_multiplier : float = 0.1;
var capsule_spawned : bool = false;

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
	$Level/SpawnTimer.start();
	

func end_game() -> void:
	self.game_over = true;
	$Level/SpawnTimer.stop();

func _restart() -> void:
	get_tree().reload_current_scene();

func add_points(points_to_add : int) -> void:
	if (self.score < 999):
		self.score = self.score + points_to_add;
	_draw_score();

func _draw_score() -> void:
	var s : String = str(score);
	if (s.length() == 1):
		s = "00" + s;
	elif (s.length() == 2):
		s = "0" + s;
	
	$Level/scoreboard/score1.frame = int(s[0]);
	$Level/scoreboard/score2.frame = int(s[1]);
	$Level/scoreboard/score3.frame = int(s[2]);
	

func _on_spawn_timer_timeout():
	if (capsule_spawned):
		return;
	
	var _spawner_roll : int = randi_range(1, 2);
	
	if (_spawner_roll == 1):
		$Level/SpawnArea3DLeft.spawn_random_capsule();
	else:
		$Level/SpawnArea3DRight.spawn_random_capsule();
