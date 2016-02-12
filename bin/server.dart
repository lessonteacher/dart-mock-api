library server;

import 'dart:io';
import 'package:redstone/redstone.dart' as server;
import 'package:redstone_mapper/plugin.dart';

import '../lib/api.dart';

// final String DOCKER_HOST = _getDockerHost();
final String DOCKER_HOST = 'rethinkdb';

main() {
  // Setup some random logging
  server.setupConsoleLog();

  // Add plugin manager (for now assume using docker)
  server.addPlugin(getMapperPlugin(new RethinkDBManager(host: DOCKER_HOST)));

  // Start the server on localhost:8080
  server.start();
}

// Hack in to get the docker ip from annoying docker-machine else return localhost
String _getDockerHost() {
  // if (Platform.isLinux) return 'localhost';

  // Just assume on docker for now
  // var host = Process.runSync('docker-machine', ['ip', 'default']).stdout.trim();

  // return host != null ? host : throw 'No DB host specified';
}
