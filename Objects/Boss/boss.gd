class_name Boss extends Node2D

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var head: Sprite2D = $BossRigidBody/Body/Head
@onready var capture: AudioEffectCapture = AudioServer.get_bus_effect(AudioServer.get_bus_index("Boss"), 0)

var free: bool = true

const HELLO_IM_YOUR_BOSS = preload("res://Assets/Lines/One Liners/Hello Im Your Boss.wav")



func _process(delta: float) -> void:
	var frames = capture.get_buffer(capture.get_frames_available())
	var value = calculate_volume(frames)
	if frames.size() > 0:
		head.rotation = value * -5


func calculate_volume(frames: PackedVector2Array) -> float:
	var sum: float = 0.0
	for frame in frames:
		var mono = (frame.x + frame.y) * 0.5
		sum += mono * mono
	return sqrt(sum / frames.size())


func idle() -> void:
	if free:
		if randi_range(0, 5) == 0:
			print("IDLE - LONG")
		else:
			print("IDLE")
	# use awaits to mark when free


func time_warning() -> void:
	free = false
	# perminent free is false
	print("TIME WARNING")


func game_over(score: int) -> void:
	if score > 15:
		print("SCORE - GOOD")
	elif score > 5:
		print("SCORE - OKAY")
	else:
		print("SCORE - BAD")


func open() -> void:
	print("OPENER")
	# use await
