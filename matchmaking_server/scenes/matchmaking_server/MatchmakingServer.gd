extends Node


const PORT: int = 9999
const MAX_PLAYERS: int = 1000


func _ready() -> void:
	_start_server(PORT, MAX_PLAYERS)


func _start_server(port: int, max_players: int) -> void:
	var peer: NetworkedMultiplayerENet = NetworkedMultiplayerENet.new()
	var _err: int = peer.create_server(port, max_players)
	get_tree().network_peer = peer
	print("matchmaking server started")


remote func _send_servers() -> void:
	var sender_id: int = get_tree().get_rpc_sender_id()
	rpc_id(sender_id, "_recieve_servers", {"0": {"name": "MyServer", "player_count": 3, "game_mode": "deathmetch"} })
