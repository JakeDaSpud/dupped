extends Node2D

var muted : bool = false;
@export var default_music_volume : float = 1.0;
@export var default_point_volume : float = 0.8;
@export var default_death_volume : float = 0.2;
@export var default_flip_volume : float = 0.9;

var musicStream : AudioStreamPlayer2D;
var pointStream : AudioStreamPlayer2D;
var deathStream : AudioStreamPlayer2D;
var flipStreams : Array[AudioStreamPlayer2D];

func _ready():
	musicStream = $Music;
	pointStream = $Collect_Point;
	deathStream = $Player_Die;
	flipStreams = [$Flip, $Flip2, $Flip3];
	
	musicStream.volume_db = linear_to_db(default_music_volume);
	pointStream.volume_db = linear_to_db(default_point_volume);
	deathStream.volume_db = linear_to_db(default_death_volume);
	for fs in flipStreams:
		fs.volume_db = linear_to_db(default_flip_volume);

func mute_toggle() -> void:
	if (!muted):
		musicStream.volume_db = linear_to_db(0);
		pointStream.volume_db = linear_to_db(0);
		deathStream.volume_db = linear_to_db(0);
		for fs in flipStreams:
			fs.volume_db = linear_to_db(0);
		muted = true;
	
	else:
		musicStream.volume_db = linear_to_db(default_music_volume);
		pointStream.volume_db = linear_to_db(default_point_volume);
		deathStream.volume_db = linear_to_db(default_death_volume);
		for fs in flipStreams:
			fs.volume_db = linear_to_db(default_flip_volume);
		muted = false;

func music() -> void:
	musicStream.play();

func collect_point() -> void:
	pointStream.play();

func death() -> void:
	deathStream.play();

func flip() -> void:
	if (!flipStreams[0].playing):
		flipStreams[0].play();
	elif (!flipStreams[1].playing):
		flipStreams[1].play();
	elif (!flipStreams[2].playing):
		flipStreams[2].play();
