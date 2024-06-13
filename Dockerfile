# syntax=docker/dockerfile-upstream:master-labs

FROM --platform=$BUILDPLATFORM cgr.dev/chainguard/jdk:latest AS cloud-pubsub-emulator
ARG PUBSUB_EMULATOR_BUILD_NUMBER

LABEL org.opencontainers.image.authors="The containerz authors"
LABEL org.opencontainers.image.url="https://github.com/containerz-dev/cloud-pubsub-emulator"
LABEL org.opencontainers.image.source="https://github.com/containerz-dev/cloud-pubsub-emulator/Dockerfile"
LABEL org.opencontainers.image.documentation="Cloud SDK less Cloud Pub/Sub emulator container"
LABEL org.opencontainers.image.base.name="cgr.dev/chainguard/jdk:latest"
LABEL org.opencontainers.image.version="${PUBSUB_EMULATOR_BUILD_NUMBER}"
LABEL org.opencontainers.image.licenses="BSD-3-Clause"

ENV PUBSUB_EMULATOR_URL="https://dl.google.com/dl/cloudsdk/channels/rapid/components/google-cloud-sdk-pubsub-emulator-${PUBSUB_EMULATOR_BUILD_NUMBER}.tar.gz"
ADD --chown=java:java ${PUBSUB_EMULATOR_URL} /home/build
RUN tar xfz /home/build/google-cloud-sdk-pubsub-emulator-${PUBSUB_EMULATOR_BUILD_NUMBER}.tar.gz --strip-components=1 -C /home/build

EXPOSE 8085/tcp
ENTRYPOINT ["/home/build/pubsub-emulator/bin/cloud-pubsub-emulator", "--host=0.0.0.0", "--port=8085"]
