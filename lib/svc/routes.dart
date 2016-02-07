part of api;

@api.Route('/:resource',methods: const [api.GET])
getResource(@api.Attr() dbConn,String resource) => _getAll(dbConn,resource);

@api.Route('/users/:id',methods: const [api.GET])
getResourceId(@api.Attr() dbConn,String id) => _get(dbConn,'users',id);

// @api.Route('/users',methods: const [api.POST])
// createUser(@api.Attr() dbConn,@api.Body(api.JSON) json) => _create(dbConn,'users',json);
//
// @api.Route('/users/:id',methods: const [api.PUT])
// updateUser(@api.Attr() dbConn,@api.Body(api.JSON) json,id) => _update(dbConn,'users',id,json);
//
// @api.Route('/users/:id',methods: const [api.DELETE])
// deleteUser(@api.Attr() dbConn,@api.Body(api.JSON) Map json,id) => _delete(dbConn,'users',id,json);
