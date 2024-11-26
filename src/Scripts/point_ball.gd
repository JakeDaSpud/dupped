extends Area2D

var game : Node2D;
@export var value : int = 1;

func _ready() -> void:
	game = get_tree().get_current_scene();

func _on_body_entered(_body) -> void:
	if (game.game_over):
		return;
	
	game.add_points(self.value);
	self.queue_free();
