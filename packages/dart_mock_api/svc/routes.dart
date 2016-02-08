part of api;

/*
 * Most basic possible api just to be able to do simple functions, no nested sets
 * */
@api.Route('/')
welcome() => 'Welcome to Api Town!';

@api.Route('/:resource', methods: const [api.GET]) // Get the collection
getResource(@api.Attr() dbConn, String resource) => _getAll(dbConn, resource);

@api.Route('/:resource/:id', methods: const [api.GET]) // Get an individual entry
getResourceId(@api.Attr() dbConn, String resource, String id) => _get(dbConn, resource, id);

@api.Route('/:resource', methods: const [api.POST]) // Create a single entry
createResource(@api.Attr() dbConn, String resource, @api.Body(api.JSON) json) => _create(dbConn, resource, json);

@api.Route('/:resource', methods: const [api.PUT]) // Update a single entry
updateResource(@api.Attr() dbConn, String resource, @api.Body(api.JSON) json, id) =>
    _update(dbConn, resource, id, json);

@api.Route('/:resource/:id', methods: const [api.DELETE]) // Delete a single entry
deleteResource(@api.Attr() dbConn, String resource, @api.Body(api.JSON) Map json, id) =>
    _delete(dbConn, resource, id, json);
