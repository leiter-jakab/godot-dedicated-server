extends Node


signal server_list_updated

const DEFAULT_HOST: String = "127.0.0.1"
const DEFAULT_PORT: String = "10001"
const RESOURCE_PATH: String = "gameserver"

onready var _matchmaker_request: HTTPRequest = $HTTPRequest setget _noset

var _server_host: String setget _noset
var _server_port: String setget _noset
var _server_id: String setget _noset
var _resource_url: String setget _noset


# readonly field setter
func _noset(_val) -> void:
	pass


func _ready() -> void:
	_server_host = OS.get_environment("MATCHMAKING_HOST")
	_server_port = OS.get_environment("MATCHMAKING_PORT")
	_server_id = OS.get_environment("SERVER_ID")
	
	if Engine.editor_hint:
		_server_id = "qwrekjh132532kj53hj4g2kh3"
	
	if not _server_host:
		_server_host = DEFAULT_HOST
	if not _server_port:
		_server_port = DEFAULT_PORT
	
	_resource_url = "http://%s:%s/%s/%s" % [
		_server_host, _server_port, RESOURCE_PATH, _server_id]


func players_changed(players: Dictionary) -> void:
	var _err: int = _matchmaker_request.request(
		_resource_url, [], true, HTTPClient.METHOD_PATCH,
		str({"players": players}))


func server_done() -> void:
	var _err: int = _matchmaker_request.request(
		_resource_url, [], true, HTTPClient.METHOD_DELETE)
