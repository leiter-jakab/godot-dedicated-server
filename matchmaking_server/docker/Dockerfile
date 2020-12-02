FROM leiterjakab/godot-server-alpine

COPY matchmaking.pck /godot/matchmaking.pck
RUN chown godot:godot /godot/matchmaking.pck

WORKDIR /godot
USER godot
EXPOSE 9999

CMD ["./godot", "--main-pack", "matchmaking.pck"]
