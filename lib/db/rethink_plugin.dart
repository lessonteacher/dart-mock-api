part of api;

// The DB library comes with the rethink class defined globally
final Rethinkdb r = new Rethinkdb();

class RethinkDBManager extends DatabaseManager {
  String _dbName;
  int _port;

  RethinkDBManager({String dbName: 'test', int port: 28015}) {
    _dbName = dbName;
    _port = port;
  }

  Future<Connection> getConnection() {
    return r.connect(db: _dbName,port: _port);
  }

  void closeConnection(Connection connection, {dynamic error}) {
     connection.close();
  }
}
