extends Node


const DEFAULT_PORT: int = 10002
const DEFAULT_PLAYER_LIMIT: int = 20

var _players: Dictionary = {} setget _noset
var _players_ready: Array = [] setget _noset
var _players_level_loaded: Array = [] setget _noset


# dummy setter for readonly fields
func _noset(value) -> void:
	pass


func _ready() -> void:
	# warning-ignore:return_value_discarded
	get_tree().connect("network_peer_connected", self, "_on_player_connected")
	# warning-ignore:return_value_discarded
	get_tree().connect("network_peer_disconnected", self, "_on_player_disconnected")
	
	var server_port: int = int(OS.get_environment(""))
	var player_limit: int = int(OS.get_environment(""))
	
	if not server_port:
		server_port = DEFAULT_PORT
	if not player_limit:
		player_limit = DEFAULT_PLAYER_LIMIT
	
	_start_server(server_port, player_limit)


func _start_server(port: int, max_players: int) -> void:
	var peer: NetworkedMultiplayerENet = NetworkedMultiplayerENet.new()
	var _err: int = peer.create_server(port, max_players)
	get_tree().network_peer = peer
	print("server started")


func _on_player_connected(id: int) -> void:
	rpc_id(id, "_send_player_info")


func _on_player_disconnected(id: int) -> void:
	var _err: int = _players.erase(id)
	print(_players)
	rpc("_player_left", id)


remote func _return_send_player_info(info: Dictionary) -> void:
	var sender_id: int = get_tree().get_rpc_sender_id()
	_players[sender_id] = info
	print(_players)
	rpc("_player_joined", sender_id)
