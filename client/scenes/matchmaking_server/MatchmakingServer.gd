extends Node


signal server_list_updated

const DEFAULT_HOST: String = "localhost"
const DEFAULT_PORT: String = "10001"

const GAMESERVER_RESOURCE_PATH: String = "gameserver"

onready var _fetch_gameservers_req: HTTPRequest = $FetchGameServers setget _noset
onready var _fetch_gameserver_details_req: HTTPRequest = $FetchGameServerDetails setget _noset

var _server_host: String setget _noset
var _server_port: String setget _noset
var _available_servers: Dictionary setget _noset


# readonly field setter
func _noset(_val) -> void:
	pass


func _ready() -> void:
	_server_host = OS.get_environment("MATCHMAKING_HOST")
	_server_port = OS.get_environment("MATCHMAKING_PORT")
	
	if not _server_host:
		_server_host = DEFAULT_HOST
	if not _server_port:
		_server_port = DEFAULT_PORT
	
	fetch_gameserver_details("asdf")


func fetch_gameservers(page: int = 0) -> void:
	var url: String = "http://%s:%s/%s?page=%s" % [_server_host, _server_port, GAMESERVER_RESOURCE_PATH, page]
	_fetch_gameservers_req.request(url)


func fetch_gameserver_details(server_id: String) -> void:
	var url: String = "http://%s:%s/%s/%s" % [_server_host, _server_port, GAMESERVER_RESOURCE_PATH, server_id]
	print(url)
	_fetch_gameserver_details_req.request(url)


func _on_FetchGameServers_request_completed(result, response_code, headers, body):
	var response_json = parse_json(body.get_string_from_utf8())
	print(response_json)


func _on_FetchGameServerDetails_request_completed(result, response_code, headers, body):
	var response_json = parse_json(body.get_string_from_utf8())
	print(response_json)
