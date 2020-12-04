FROM alpine as builder

ARG GODOT_VERSION=3.2.3

RUN apk add --no-cache binutils curl unzip \
  && curl -O "https://downloads.tuxfamily.org/godotengine/${GODOT_VERSION}/Godot_v${GODOT_VERSION}-stable_linux_server.64.zip" \
  && unzip "/Godot_v${GODOT_VERSION}-stable_linux_server.64.zip" \
	&& strip "/Godot_v${GODOT_VERSION}-stable_linux_server.64"


FROM leiterjakab/alpine-glibc

RUN addgroup godot \
	&& adduser -G godot -D godot

COPY --from=builder --chown=godot:godot /Godot_v3.2.3-stable_linux_server.64 /godot/godot

