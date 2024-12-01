extends CharacterBody2D

var game : Node2D;

@export var speed : float = 100.0;

func _ready() -> void:
	game = get_tree().get_current_scene();
	$left_wall/AnimatedSprite2D.play("default");
	$right_wall/AnimatedSprite2D.play("default");

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	if (self.position.x < -104 || self.position.x > 744):
		game.capsule_spawned = false;
		self.queue_free();
	
	velocity.x += delta * speed;
	move_and_slide();

func _on_wall_touched(body) -> void:
	game.end_game();
