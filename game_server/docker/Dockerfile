FROM leiterjakab/godot-server-alpine

COPY --chown=godot:godot game-server.pck /godot/game-server.pck

WORKDIR /godot
USER godot
EXPOSE 10002

CMD ["./godot", "--main-pack", "game-server.pck"]
