extends Node2D

@export var game_over : bool = false;
@export var in_menu : bool = true;

var score : int = 0;
var point_speed_multiplier : float = 0.1;
var capsule_spawned : bool = false;
var _button_held_time : float = -1;
var _button_threshold_time : float = 0.5; # Button must be held for this many seconds to toggle mute

func _ready():
	AudioManager.music();

func _process(delta) -> void:
	
	# Hold button for 1 whole second -> AudioManager.toggle_mute(), do not start game
	# Release button before that 1 whole second -> game.start()
	
	if in_menu && (Input.is_action_pressed("button_gamepad") || Input.is_action_pressed("button_keyboard") || Input.is_action_pressed("button_mouse")):
		if (_button_held_time == -1):
			_button_held_time = 0;
		_button_held_time += delta;
	
	if in_menu && (Input.is_action_just_released("button_gamepad") || Input.is_action_just_released("button_keyboard") || Input.is_action_just_released("button_mouse")):
		if (_button_held_time < _button_threshold_time && _button_held_time > 0):
			_start_game();
		else:
			_mute_toggle();
			_button_held_time = -1;
		
	
	if game_over && (Input.is_action_just_pressed("button_gamepad") || Input.is_action_just_pressed("button_keyboard") || Input.is_action_just_pressed("button_mouse")):
		_restart();

func _start_game() -> void:
	in_menu = false;
	$Menu/AudioMenu.visible = false;
	$Menu/start.visible = false;
	$Player.visible = true;
	$Level/scoreboard.visible = true;
	$Level/SpawnTimer.start();
	

func end_game() -> void:
	if (!self.game_over):
		AudioManager.death();
	self.game_over = true;
	$Level/SpawnTimer.stop();
	$Menu/start.visible = true;
	

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
	

func _mute_toggle() -> void:
	AudioManager.mute_toggle();
	swap_audio_menus();

func swap_audio_menus() -> void:
	if (AudioManager.muted):
		$Menu/AudioMenu/current_audio.play("mute1");
		$Menu/AudioMenu/current_audio2.play("sound");
	
	else:
		$Menu/AudioMenu/current_audio.play("sound");
		$Menu/AudioMenu/current_audio2.play("mute1");

func _on_spawn_timer_timeout():
	if (capsule_spawned):
		return;
	
	var _spawner_roll : int = randi_range(1, 2);
	
	if (_spawner_roll == 1):
		$Level/SpawnArea3DLeft.spawn_random_capsule();
	else:
		$Level/SpawnArea3DRight.spawn_random_capsule();
