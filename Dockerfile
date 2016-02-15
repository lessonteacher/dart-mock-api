FROM google/dart

# Add env for api
ENV MOCK_API localhost

WORKDIR /app

ADD pubspec.* /app/
RUN pub get
ADD . /app
RUN pub get --offline

# The api is running here
EXPOSE 8000

CMD []
ENTRYPOINT ["/usr/bin/dart", "bin/server.dart"]
