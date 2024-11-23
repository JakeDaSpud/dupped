extends CharacterBody2D

@export var _max_speed : float = 400.0;
@export var _acceleration : float = 50.0;

func _physics_process(delta):
	
	velocity += (get_gravity() * -up_direction) * (delta * _acceleration);
	velocity.y = clamp(velocity.y, -_max_speed, _max_speed);

	# Flip Gravity
	if Input.is_action_just_pressed("button_keyboard") || Input.is_action_just_pressed("button_mouse") || Input.is_action_just_pressed("button_gamepad"):
		self.up_direction = -self.up_direction;
	
	move_and_slide()
