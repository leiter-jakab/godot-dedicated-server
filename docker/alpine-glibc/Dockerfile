FROM alpine

ARG APK_GLIBC_VERSION=2.29-r0
ARG APK_GLIBC_FILE="glibc-${APK_GLIBC_VERSION}.apk"
ARG APK_GLIBC_BIN_FILE="glibc-bin-${APK_GLIBC_VERSION}.apk"
ARG APK_GLIBC_BASE_URL="https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${APK_GLIBC_VERSION}"

RUN apk add --no-cache --virtual .build-dependencies wget ca-certificates libstdc++ \
	&& wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub \
	&& wget "${APK_GLIBC_BASE_URL}/${APK_GLIBC_FILE}" \
	&& apk --no-cache add "${APK_GLIBC_FILE}" \
	&& wget "${APK_GLIBC_BASE_URL}/${APK_GLIBC_BIN_FILE}" \
	&& apk --no-cache add "${APK_GLIBC_BIN_FILE}" \
	&& rm glibc-* \
	&& apk del .build-dependencies

