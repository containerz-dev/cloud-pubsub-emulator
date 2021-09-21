FROM adoptopenjdk/openjdk11:alpine-jre

ARG PUBSUB_EMULATOR_BUILD_NUMBER
RUN set -eux; \
	wget -q -O- https://dl.google.com/dl/cloudsdk/channels/rapid/components/google-cloud-sdk-pubsub-emulator-${PUBSUB_EMULATOR_BUILD_NUMBER}.tar.gz | tar xfz - --strip-components=1 -C /

ENV PATH /pubsub-emulator/bin:${PATH}

EXPOSE 8085/tcp
ENTRYPOINT ["cloud-pubsub-emulator"]
