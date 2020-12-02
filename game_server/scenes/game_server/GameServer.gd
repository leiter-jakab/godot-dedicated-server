extends Node


const PORT: int = 9876
const MAX_PLAYERS: int = 20

var players: Dictionary = {}
var players_ready: Array = []
var players_level_loaded: Array = []


func _ready() -> void:
	# warning-ignore:return_value_discarded
	get_tree().connect("network_peer_connected", self, "_on_player_connected")
	# warning-ignore:return_value_discarded
	get_tree().connect("network_peer_disconnected", self, "_on_player_disconnected")
	
	_start_server(PORT, MAX_PLAYERS)


func _start_server(port: int, max_players: int) -> void:
	var peer: NetworkedMultiplayerENet = NetworkedMultiplayerENet.new()
	var _err: int = peer.create_server(port, max_players)
	get_tree().network_peer = peer
	print("server started")


func _on_player_connected(id: int) -> void:
	rpc_id(id, "_send_player_info")


func _on_player_disconnected(id: int) -> void:
	var _err: int = players.erase(id)
	print(players)
	rpc("_player_left", id)


remote func _recieve_player_info(info: Dictionary) -> void:
	var sender_id: int = get_tree().get_rpc_sender_id()
	players[sender_id] = info
	print(players)
	rpc("_player_joined", sender_id)
