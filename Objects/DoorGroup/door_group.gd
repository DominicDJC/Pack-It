class_name DoorGroup extends Node2D

const KILL_TIME = 10

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var doors: Array[Door] = [$DoorOne, $DoorTwo, $DoorThree]

var time: float = 0

signal finished
signal doors_gone

func _ready() -> void:
	await get_tree().create_timer(1).timeout
	spawn_doors()
	await finished
	for door in doors:
		if !door.opened:
			door.open_door()
		await get_tree().create_timer(0.1).timeout
	leave_doors()
	await animation_player.animation_finished
	doors_gone.emit()
	get_parent().remove_child(self)
	self.queue_free()


func _process(delta: float) -> void:
	time += delta
	if time > KILL_TIME:
		finished.emit()
		return
	for door in doors:
		if !door.opened:
			return
	finished.emit()


func spawn_doors() -> void:
	for door in doors:
		door.enable_collision()
	animation_player.play("spawndoors")


func leave_doors() -> void:
	animation_player.play("leavedoors")
	await animation_player.animation_finished
	finished.emit()


func drop_items() -> void:
	pass
