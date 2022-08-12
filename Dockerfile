# syntax=docker/dockerfile-upstream:1.4

ARG OPENJDK_VERSION
FROM --platform=${BUILDPLATFORM} amazoncorretto:${OPENJDK_VERSION} AS cloud-pubsub-emulator

ARG PUBSUB_EMULATOR_BUILD_NUMBER
ENV PUBSUB_EMULATOR_URL="https://dl.google.com/dl/cloudsdk/channels/rapid/components/google-cloud-sdk-pubsub-emulator-${PUBSUB_EMULATOR_BUILD_NUMBER}.tar.gz"
RUN set -eux; \
	wget -q -O- ${PUBSUB_EMULATOR_URL} | tar xfz - --strip-components=1 -C /

WORKDIR /pubsub-emulator/bin
EXPOSE 8085/tcp
ENTRYPOINT ["cloud-pubsub-emulator"]

LABEL org.opencontainers.image.authors       "The containerz authors"
LABEL org.opencontainers.image.url           "https://github.com/containerz-dev/cloud-pubsub-emulator"
LABEL org.opencontainers.image.source        "https://github.com/containerz-dev/cloud-pubsub-emulator/Dockerfile"
LABEL org.opencontainers.image.documentation "Cloud SDK less cloud pubsub emulator container image"
LABEL org.opencontainers.image.base.name     "adoptopenjdk/openjdk11:${OPENJDK_TAG}"
LABEL org.opencontainers.image.version       "${PUBSUB_EMULATOR_BUILD_NUMBER}"
LABEL org.opencontainers.image.licenses      "BSD-3-Clause"
