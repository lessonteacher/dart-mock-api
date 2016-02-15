# Use rethinkdb as the base
FROM rethinkdb

RUN apt-get update && apt-get install -y apt-transport-https curl \
    && sh -c 'curl https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -' \
    && sh -c 'curl https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list' \
    && apt-get update \
    && apt-get install dart \
    && rm -rf /var/lib/apt/lists/*

# Add dart env variables
ENV DART_SDK /usr/lib/dart
ENV PATH $DART_SDK/bin:$PATH
RUN echo $PATH

# Add env for api
ENV MOCK_API localhost

# Add the app data
WORKDIR /app
ADD pubspec.* /app/
RUN pub get
ADD . /app
RUN pub get --offline

EXPOSE 8000 8181 5858

ENTRYPOINT ["./docker_start.sh"]
