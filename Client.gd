extends Node

var peer = ENetMultiplayerPeer.new()
@export var playerScene : PackedScene
var clientConnected : bool
@export var gameSpawnLocation : NodePath
# Called when the node enters the scene tree for the first time.
func _ready():
	multiplayer.peer_connected.connect(peerConnected)
	multiplayer.peer_disconnected.connect(peerDisconnected)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if clientConnected:
		peer.poll()
	pass

func peerConnected(id):
	print("peer connected! " + str(id))
	var p = playerScene.instantiate()
	get_node(gameSpawnLocation).add_child(p)
	p.name = str(id)
	p.get_node("AudioManager").setupAudio(id)

func peerDisconnected(id):
	print("peer disconnected! " + str(id))

func _on_connect_to_server_button_down():
	peer.create_client("204.48.28.159", 8910)
	
	multiplayer.multiplayer_peer = peer
	
	var p = playerScene.instantiate()
	get_node(gameSpawnLocation).add_child(p)
	p.name = str(multiplayer.get_unique_id())
	p.get_node("AudioManager").setupAudio(multiplayer.get_unique_id())
	clientConnected = true
	pass # Replace with function body.
