FROM adoptopenjdk/openjdk11:alpine-jre

ARG PUBSUB_EMULATOR_BUILD_NUMBER
RUN set -eux; \
	wget -q -O- https://dl.google.com/dl/cloudsdk/channels/rapid/components/google-cloud-sdk-pubsub-emulator-${PUBSUB_EMULATOR_BUILD_NUMBER}.tar.gz | tar xfz - --strip-components=1 -C /

ENV PATH /pubsub-emulator/bin:${PATH}

LABEL org.opencontainers.image.authors "The containerz authors"
LABEL org.opencontainers.image.url "https://github.com/containerz-dev/cloud-pubsub-emulator"
LABEL org.opencontainers.image.source "https://github.com/containerz-dev/cloud-pubsub-emulator"
LABEL org.opencontainers.image.licenses "BSD-3-Clause"

EXPOSE 8085/tcp
ENTRYPOINT ["cloud-pubsub-emulator"]
