extends TextureButton

var original_scale = Vector2.ONE
var hover_scale = Vector2(1.12, 1.12)


func _ready():
	original_scale = scale
	self.pivot_offset = get_size() / 2
	self.connect("mouse_entered", Callable(self, "_on_mouse_entered"))
	self.connect("mouse_exited", Callable(self, "_on_mouse_exited"))

func _on_mouse_entered():
	scale = hover_scale

func _on_mouse_exited():
	scale = original_scale
