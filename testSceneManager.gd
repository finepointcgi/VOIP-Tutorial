extends Node2D

@export var Character : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	var s = Character.instantiate()
	add_child(s)
	s.get_node("AudioManager").setupAudio(multiplayer.get_unique_id())
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
