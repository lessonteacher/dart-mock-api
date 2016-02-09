library server;

import 'dart:io';
import 'package:redstone/redstone.dart' as server;
import 'package:redstone_mapper/plugin.dart';

import '../lib/api.dart';

final String DOCKER_HOST = _getDockerHost();
// final String DOCKER_HOST = '192.168.99.100';

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
  String host, env = Platform.environment['DOCKER_HOST'];

  if (env != null) {
    Uri uri = Uri.parse(env);

    host = uri.host;
  } else {
    if (Platform.isLinux) return 'localhost';

    // Finally try to get from here in case of Windows or Mac
    host = Process.runSync('docker-machine', ['ip', 'default']).stdout.trim();
  }

  return host != null ? host : throw 'No DB host specified';
}
