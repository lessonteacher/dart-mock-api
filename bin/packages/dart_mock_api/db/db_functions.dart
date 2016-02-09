part of api;

bool createTables = false;

// Read a collection of data (allows basic filter)
dynamic _getAll(dbConn, name, Map<String, String> parms) async {
  return parms.isEmpty
      ? r.table(name).run(dbConn).then((c) => c.toList()).catchError((err) => print(err.toString()))
      : r.table(name).filter(parms).run(dbConn).then((c) => c.toList()).catchError((err) => print(err.toString()));
}

// Read a single entry
dynamic _get(dbConn, name, id) async {
  var result = await r.table(name).get(id).run(dbConn).catchError((err) => print(err.toString()));
  return result != null ? result : _raiseError('No entry exists for that id');
}

// Update a single entry
dynamic _update(dbConn, name, id, json) async {
  Map result = await r.table(name).get(id).update(json).run(dbConn).catchError((err) => print(err.toString()));
  return result['errors'] == 0 ? result : _raiseError(result['first_error']);
}

// Create a new entry
dynamic _create(dbConn, name, json) async {
  Map result = await r.table(name).insert(json).run(dbConn).catchError((err) => print(err.toString()));
  return result['errors'] == 0 ? result : _raiseError(result['first_error']);
}

// Delete a single entry
dynamic _delete(dbConn, name, id, Map json) async {
  Map result = await r.table(name).delete(json).run(dbConn).catchError((err) => print(err.toString()));
  return result['errors'] == 0 ? result : _raiseError(result['first_error']);
}

// Check a table for existance and create is setting is true
_checkTable(dbConn, table) async {
  if (!createTables) return; // Setting disabled, exit

  if (await r.tableList().contains(table).run(dbConn)) return; // Table exists, exit

  // Create
  await r.tableCreate(table).run(dbConn);
}

// Find the first match
// dynamic _find(dbConn,name,parms) async { }

// Find all matches
// dynamic _findAll(dbConn,name,parms) async {  }

// Just raise as 404 not found for now
shelf.Response _raiseError(String text) => new shelf.Response.notFound(text);
