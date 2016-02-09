part of api;

// The DB library comes with the rethink class defined globally
final Rethinkdb r = new Rethinkdb();

class RethinkDBManager extends DatabaseManager {
  final String db;
  final String host;
  final int port;

  // Construct DB manager
  RethinkDBManager({String this.db: 'test', String this.host: "localhost", int this.port: 28015}) {
    print('DB Manager setup for $host:$port');
    // api.redstoneLogger.info('DB Manager setup for $host:$port');
  }

  // @override // Get connection from DatabaseManager
  Future<Connection> getConnection() => r.connect(db: db, host: host, port: port);

  // Close the connection
  void closeConnection(Connection connection, {dynamic error}) => connection.close();
}
