library server;

import 'package:redstone/redstone.dart' as server;
import 'package:redstone_mapper/plugin.dart';

import '../lib/api.dart';

main() {
  createTables = true; // Create any non existent tables

  // Setup some random logging
  server.setupConsoleLog();
  // Add plugin manager
  server.addPlugin(getMapperPlugin(new RethinkDBManager()));

  // Start the server on localhost:8080
  server.start();
}
