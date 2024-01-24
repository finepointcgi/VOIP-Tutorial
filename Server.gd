extends Node

var peer = ENetMultiplayerPeer.new()
@export var playerScene : PackedScene
var serverIsReady : bool

@export var gameSpawnLocation : NodePath
# Called when the node enters the scene tree for the first time.
func _ready():
	if "--server" in OS.get_cmdline_args():
		_on_host_button_down()
		print("hosting on " + str(8910))
	multiplayer.peer_connected.connect(peerConnected)
	multiplayer.peer_disconnected.connect(peerDisconnected)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if serverIsReady:
		peer.poll()
	pass
	

func peerConnected(id):

	print("peer connected! " + str(id))
	#var p = playerScene.instantiate()
	#add_child(p)
	#p.name = str(id)
	#p.get_node("AudioManager").setupAudio(id)

func peerDisconnected(id):
	print("peer disconnected! " + str(id))

func _on_host_button_down():
	var error = peer.create_server(8910)
	if error:
		print("we have an error for server: " + error)
	multiplayer.multiplayer_peer = peer
	
	var p = playerScene.instantiate()
	get_node(gameSpawnLocation).add_child(p)
	p.name = str(1)
	p.get_node("AudioManager").setupAudio(1)
	serverIsReady = true
	pass # Replace with function body.
