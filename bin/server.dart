library server;

import 'dart:io';
import 'package:redstone/redstone.dart' as server;
import 'package:redstone_mapper/plugin.dart';

import '../lib/api.dart';

main() {
  createTables = true; // Auto create any tables

  // Setup some random logging
  server.setupConsoleLog();

  // Add plugin manager (for now assume using docker)
  server.addPlugin(getMapperPlugin(new RethinkDBManager(host: mockDbHost)));

  // Start the server on localhost:8080
  server.start();
}

/**
 * This method will check for some env variable called MOCK_DB for a host, e.g. localhost
 * If not found it will check if dockerized and assume there is a linked container
 * Lastly it will return localhost in other cases
 */
get mockDbHost {
  // Try to get the mock_db environment var in case it has been set
  var host = Platform.environment['MOCK_DB'];

  if (host != null) return host; // Return the host from env if it is set

  if (_isDockerized()) return 'rethinkdb'; // If dockerized, hope that a rethinkdb container has been linked

  return 'localhost'; // Just return the localhost here
}

// This insane method will determine if the api is inside a docker container or not
_isDockerized() {
  var result = Process.runSync('bash', ['-c', 'cat /proc/1/cgroup | grep docker']).stdout.trim();
  return (result != ''); // Return true if there is something returned
}
