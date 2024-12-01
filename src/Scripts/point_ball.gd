extends Area2D

var game : Node2D;
@export var value : int = 1;

func _ready() -> void:
	game = get_tree().get_current_scene();
	$Sprite2D.play("default");

func _on_body_entered(_body) -> void:
	if (game.game_over):
		return;
	
	if (_body == get_node("/root/Game/Player")):
		game.add_points(self.value);
		AudioManager.collect_point();
		self.queue_free();
