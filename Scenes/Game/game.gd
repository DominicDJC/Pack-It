class_name Game extends Node2D

@export var background_data: BackgroundData
@onready var background: Background = $Background


func _ready() -> void:
	background.set_background(background_data)
