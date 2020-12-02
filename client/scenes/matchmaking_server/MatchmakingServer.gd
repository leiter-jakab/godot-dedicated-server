extends Node


signal server_list_updated

const PORT: int = 9999
const SERVER_IP: String = "127.0.0.1"

var available_servers: Dictionary


func _ready() -> void:
	# warning-ignore:return_value_discarded
	get_tree().connect("connected_to_server", self, "_on_connection_success")
	
	join_server(SERVER_IP, PORT)


func join_server(server_ip: String, port: int) -> void:
	var peer: NetworkedMultiplayerENet = NetworkedMultiplayerENet.new()
	var _err: int = peer.create_client(server_ip, port)
	get_tree().network_peer = peer
	print("joined server: " + str(peer))


func fetch_servers() -> void:
	rpc_id(1, "_send_servers")


func _on_connection_success() -> void:
	fetch_servers()


remote func _recieve_servers(servers: Dictionary) -> void:
	available_servers = servers
	emit_signal("server_list_updated")
	print(available_servers)
