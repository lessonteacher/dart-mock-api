part of api;

/*
 * Most basic possible api just to be able to do simple functions, no nested sets
 * */
@api.Route('/')
welcome() => 'Welcome to Api Town!';

@api.Route('/:resource', methods: const [api.GET]) // Get the collection
getResource(@api.Attr() dbConn, String resource) {
  // Just sort this favico issue here temporarily, need to create an interceptor for this on all paths
  return resource == 'favicon.ico'
      ? throw new api.ErrorResponse(404, {"error": "Unsupported resource"})
      : _getAll(dbConn, resource, api.request.requestedUri.queryParameters);
}

@api.Route('/:resource/:id', methods: const [api.GET]) // Get an individual entry
getResourceId(@api.Attr() dbConn, String resource, String id) => _get(dbConn, resource, id);

@api.Route('/:resource', methods: const [api.POST]) // Create from body at resource
createResource(@api.Attr() dbConn, String resource, @api.Body(api.JSON) json) => _create(dbConn, resource, json);

@api.Route('/:resource/:id', methods: const [api.PUT]) // Update a single entry
updateResource(@api.Attr() dbConn, String resource, @api.Body(api.JSON) json, id) =>
    _update(dbConn, resource, id, json);

@api.Route('/:resource/:id', methods: const [api.DELETE]) // Delete a single entry
deleteResource(@api.Attr() dbConn, String resource, @api.Body(api.JSON) Map json, id) =>
    _delete(dbConn, resource, id, json);

/* Add in interceptors */
@api.Interceptor(r'/.*')
handleCORS() async {
  if (api.request.method != 'OPTIONS') await api.chain.next();

  return api.response
    .change(
      headers: {
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Headers':' X-Requested-With, Content-Type, Content-Length',
        'Access-Control-Allow-Methods': 'GET,PUT,POST,DELETE,OPTIONS'
      });
}
