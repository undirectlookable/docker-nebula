FROM --platform=${TARGETPLATFORM} alpine:latest
LABEL maintainer="undirectlookable@users.noreply.github.com"

WORKDIR /root
ARG TARGETPLATFORM
ARG TAG
COPY nebula.sh /root/nebula.sh

RUN set -ex \
	&& apk add --no-cache wget ca-certificates iptables \
	&& chmod +x /root/nebula.sh \
	&& /root/nebula.sh "${TARGETPLATFORM}" "${TAG}"

VOLUME /etc/nebula
CMD [ "/usr/local/bin/nebula", "-config", "/etc/nebula/config.yaml" ]
