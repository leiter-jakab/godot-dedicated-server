FROM leiterjakab/alpine-glibc

COPY Godot_v3.2.3-stable_linux_server.64 /godot/godot

RUN apk add --no-cache --virtual .build-deps binutils \
	&& strip /godot/godot \
	&& apk del .build-deps \
	&& addgroup godot \
	&& adduser -G godot -D godot \
	&& chown -R godot:godot /godot

