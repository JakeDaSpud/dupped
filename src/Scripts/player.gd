extends CharacterBody2D

var game : Node2D;

@export var _max_speed : int = 400;
@export var _acceleration : int = 50;
@export var _rotation_speed : int = 5;

func _ready() -> void:
	game = get_tree().get_current_scene();

func _physics_process(delta) -> void:
	
	if (game.in_menu):
		return;
	
	if (game.game_over):
		self.rotation += delta * _rotation_speed;
		return;
	
	velocity += (get_gravity() * -up_direction) * (delta * _acceleration);
	velocity.y = clamp(velocity.y, -_max_speed, _max_speed);

	# Flip Gravity
	if Input.is_action_just_pressed("button_keyboard") || Input.is_action_just_pressed("button_mouse") || Input.is_action_just_pressed("button_gamepad"):
		self.up_direction = -self.up_direction;
	
	move_and_slide()
