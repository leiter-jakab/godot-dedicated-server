extends Node


const DEFAULT_HOST: String = "127.0.0.1"
const DEFAULT_PORT: int = 10002


func _ready():
	var server_host: String = OS.get_environment("GAME_SERVER_HOST")
	var server_port: int = int(OS.get_environment("GAME_SERVER_PORT"))
	
	if not server_host:
		server_host = DEFAULT_HOST
	if not server_port:
		server_port = DEFAULT_PORT
	
	join_server(server_host, server_port)


func join_server(server_ip: String, port: int) -> void:
	var peer: NetworkedMultiplayerENet = NetworkedMultiplayerENet.new()
	var _error: int = peer.create_client(server_ip, port)
	get_tree().network_peer = peer


remote func _player_joined(id: int) -> void:
	print("player joined: " + str(id))


remote func _player_left(id: int) -> void:
	print("player left: " + str(id))


remote func _send_player_info() -> void:
	rpc_id(1, "_return_send_player_info", {"name": "dummy"})
