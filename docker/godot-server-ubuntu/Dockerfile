FROM ubuntu

COPY Godot_v3.2.3-stable_linux_server.64 /godot-server/godot

RUN groupadd godot \
	&& useradd -g godot godot \
	&& chown -R godot:godot /godot-server

