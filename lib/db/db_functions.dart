part of api;

bool createTables;
List knownTables = [];

// Read a collection of data (allows basic filter)
dynamic _getAll(dbConn, name, parms) async {
  await _checkTable(dbConn, name); // Create if required

  return parms.isEmpty
      ? r.table(name).limit(50).run(dbConn).then((c) => c.toList()).catchError((err) => print(err.message))
      : r
          .table(name)
          .filter(parms)
          .limit(50)
          .run(dbConn)
          .then((c) => c.toList())
          .catchError((err) => print(err.message));
}

// Read a single entry
dynamic _get(dbConn, name, id) async {
  await _checkTable(dbConn, name);
  var result = await r.table(name).get(id).run(dbConn).catchError((err) => print(err.message));
  return result != null ? result : _raiseError('No entry exists for that id');
}

// Update a single entry
dynamic _update(dbConn, name, id, json) async {
  await _checkTable(dbConn, name);
  Map result = await r.table(name).get(id).update(json).run(dbConn).catchError((err) => print(err.message));
  return result['errors'] == 0 ? result : _raiseError(result['first_error']);
}

// Create a new entry
dynamic _create(dbConn, name, json) async {
  await _checkTable(dbConn, name);
  Map result = await r.table(name).insert(json).run(dbConn).catchError((err) => print(err.message));
  return result['errors'] == 0 ? result : _raiseError(result['first_error']);
}

// Delete a single entry
dynamic _delete(dbConn, name, id, Map json) async {
  await _checkTable(dbConn, name);
  Map result = await r.table(name).delete(json).run(dbConn).catchError((err) => print(err.message));
  return result['errors'] == 0 ? result : _raiseError(result['first_error']);
}

// Check a table for existance and create is setting is true
_checkTable(dbConn, table) async {
  if (!createTables || knownTables.contains(table)) return; // Setting disabled, exit

  var result = await r.tableList().run(dbConn);

  if (!result.contains(table)) {
    print('Creating table: $table');
    await r.tableCreate(table).run(dbConn);
  }

  knownTables.add(table); // Avoid doing this check again
}

// Find the first match
// dynamic _find(dbConn,name,parms) async { }

// Find all matches
// dynamic _findAll(dbConn,name,parms) async {  }

// Just raise as 404 not found for now
shelf.Response _raiseError(String text) => new shelf.Response.notFound(text);
