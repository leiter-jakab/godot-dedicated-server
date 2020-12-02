FROM leiterjakab/godot-server-alpine

COPY game-server.pck /godot/game-server.pck
RUN chown godot:godot /godot/game-server.pck

WORKDIR /godot
USER godot
EXPOSE 9999

CMD ["./godot", "--main-pack", "game-server.pck"]
