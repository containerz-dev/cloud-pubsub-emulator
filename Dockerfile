# syntax=docker/dockerfile-upstream:1-labs

FROM --platform=${BUILDPLATFORM} debian:bullseye-slim AS cloud-pubsub-emulator
ARG PUBSUB_EMULATOR_BUILD_NUMBER

LABEL org.opencontainers.image.authors       "The containerz authors"
LABEL org.opencontainers.image.url           "https://github.com/containerz-dev/cloud-pubsub-emulator"
LABEL org.opencontainers.image.source        "https://github.com/containerz-dev/cloud-pubsub-emulator/Dockerfile"
LABEL org.opencontainers.image.documentation "Cloud SDK less cloud pubsub emulator container image"
LABEL org.opencontainers.image.base.name     "debian:bullseye-slim"
LABEL org.opencontainers.image.version       "${PUBSUB_EMULATOR_BUILD_NUMBER}"
LABEL org.opencontainers.image.licenses      "BSD-3-Clause"

ENV PUBSUB_EMULATOR_URL="https://dl.google.com/dl/cloudsdk/channels/rapid/components/google-cloud-sdk-pubsub-emulator-${PUBSUB_EMULATOR_BUILD_NUMBER}.tar.gz"
RUN apt-get update && \
  apt-get -y install \
    curl \
    bash \
    openjdk-11-jre-headless && \
	\
	curl -sSL ${PUBSUB_EMULATOR_URL} | tar xfz - --strip-components=1 -C /

EXPOSE 8085/tcp
ENTRYPOINT ["/pubsub-emulator/bin/cloud-pubsub-emulator"]
