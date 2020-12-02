extends Node


const PORT: int = 9876
const SERVER_IP: String = "127.0.0.1"


func _ready():
	join_server(SERVER_IP, PORT)


func join_server(server_ip: String, port: int) -> void:
	var peer: NetworkedMultiplayerENet = NetworkedMultiplayerENet.new()
	var _error: int = peer.create_client(server_ip, port)
	get_tree().network_peer = peer
	print("joined server: " + str(peer))


remote func _player_joined(id: int) -> void:
	print("player joined: " + str(id))


remote func _player_left(id: int) -> void:
	print("player left: " + str(id))


remote func _send_player_info() -> void:
	rpc_id(1, "_recieve_player_info", {"name": "dummy"})
