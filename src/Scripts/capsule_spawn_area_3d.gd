extends Area2D

# Game Manager
var game : Node2D;

@export var send_right : bool = true;
var can_spawn : bool = false;
var point_speed_multiplier : float;

# Entities
const Capsule_Entity : PackedScene = preload("res://src/Scenes/Capsule.tscn");
@export var initial_capsule_speed : float = 50.0;
const Fast_Capsule_Entity : PackedScene = preload("res://src/Scenes/Fast_Capsule.tscn");
@export var initial_fast_capsule_speed : float = initial_capsule_speed * 1.2;

func _ready() -> void:
	game = get_tree().get_current_scene();
	point_speed_multiplier = game.point_speed_multiplier;

func _process(delta):
	pass;

func _point_speed_multiplier(currentScore : float, speed : float) -> float:
	return speed * (clamp(currentScore, 1, INF) * point_speed_multiplier);

func spawn_random_capsule() -> void:
	
	# If 5, Fast Capsule will be spawned, 20% chance
	var _capsule_roll : int = randi_range(1, 5);
	
	# Generate a random point within the spawn area
	var _spawn_area_height : float = $CollisionShape2D.shape.extents.y * 2;
	
	var _spawn_pos : Vector2 = Vector2(
		$CollisionShape2D.global_position.x,
		randf_range(self.global_position.y, self.global_position.y - _spawn_area_height)
	);
	
	var entity : CharacterBody2D;
	
	# Spawn Regular Capsule
	if (_capsule_roll < 5):
		entity = Capsule_Entity.instantiate();
		entity.position = _spawn_pos;
		if (send_right):
			entity.speed = _point_speed_multiplier(game.score, entity.speed);
		else:
			entity.speed = _point_speed_multiplier(game.score, -entity.speed);
	else:
		entity = Fast_Capsule_Entity.instantiate();
		entity.position = _spawn_pos;
		if (send_right):
			entity.speed = _point_speed_multiplier(game.score, entity.speed);
		else:
			entity.speed = _point_speed_multiplier(game.score, -entity.speed);
	
	$"..".add_child(entity);
	game.capsule_spawned = true;
