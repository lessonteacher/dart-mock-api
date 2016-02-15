## Mock API

This is a basic api style thing that can update any 'resource' as
long as the path is simple at least for now, for example:

``` sh
GET localhost:8000/resource
GET localhost:8000/resource/id
POST localhost:8000/resource
... etc
```

You can use it by cloning the repo and running the bin/server.dart file... and going to localhost:8000

By default if a resource doesn't exist it will be created
ie if you literally pass 'resource' the table resource will be created.

## Dependencies

This project requires rethinkdb right now running somewhere, I suggest in a docker container which you named rethinkdb. For example perhaps you can run something like

``` sh
docker run --name rethinkdb -v /some/data:/data -p 8080:8080 -p 28015:28015 -p 29015:29015 -d rethinkdb
```

## Docker

There is a docker file, you can use this to build and run for example you can `cd dart-mock-api` and `docker build -t mock-api .`

After doing that (and assuming you have a rethinkdb container) you can run with

``` sh
docker run -p 8000:8000 --link rethinkdb:rethinkdb -d mock-api
```

If you have rethinkdb installed locally you should be able to use the environment variable MOCK_DB (hopefully) like:

``` sh
docker run --name mock-api -p 8000:8000 -e MOCK_DB=localhost -d mock-api
```

## Docker image

Now the easiest way ever... to use this api you can just use the built image from docker hub. Just run:

```sh
docker run -p 8000:8000 -p 8080:8080 -d lessonteacher/mock-api
```

If you want to not lose your data when the container is removed you might want to use some kind of mount volume like

```sh
docker run -p 8000:8000 -v ~/mount:/data -p 8080:8080 -d lessonteacher/mock-api
```
