extends CharacterBody2D

var game : Node2D;

@export var speed : float = 150.0;

func _ready() -> void:
	game = get_tree().get_current_scene();

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	velocity.x += delta * speed;
	move_and_slide();

func _on_wall_touched(body) -> void:
	game.end_game();
