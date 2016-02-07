# UI5 Backend API

This is a simple backend api in Dart via Redstone which serves data from a
RethinkDB database. To use the API you will need to have RethinkDB setup.
You can do this manually or use Docker. I suggest using Docker as things will be
a lot easier.

## Data Initial Setup

The database is RethinkDB, the data is in a repo so if you are starting from
scratch you can do these steps. (Requires Docker).

1. Navigate to some desired dir ```cd /path/to/dir```.

2. Clone the git DB git repo to the location.

    ```code
    git clone https://github.com/lessonteacher/ui5-playground-data.git
    ```

3. Run RethinkDB via docker and mount the cloned repo location to the internal
```/data``` location.

    ```code
    docker run --name rethinkdb -v /full/path/to/dir/ui5-playground-data:/data -p 28000:8080 -p 28015 -p 29015 -d rethinkdb
    ```

4. You can validate that the container is running with ```docker ps -l``` to
show the latest created container

## API Usage

You can run the API in two ways, via docker or with dart. In either case you will need to clone the repo

```code
git clone git@bitbucket.org:FairConsultingGroup/ui5-playground-backend.git
```

Navigate into the folder e.g. ```cd ui5-playground-backend```

### Using Docker

This is the recommended way when you just want the API running.

1. Build the docker image to run the API (take note of the ```.``` which is
intentional).

    ```code
    docker build -t ui5-backend .
    ```

2. Run the API by running the newly created docker image

    ```code
    docker run -p 8080:8080 -d ui5-backend
    ```

### Using Dart

This is the optimal way to run when testing code changes with dart. I actually
use the [Atom][f6ac2ac8] text editor in combination with the [dartlang][72e4f24d]
package

Assuming that you are still inside the cloned project folder and you have
installed the [Dart SDK][af1ffb47]

1. Run pub get to get the dependencies for the project with the command

    ```code
    pub get
    ```

2. Assuming that worked without error, run the server.dart file via pub with:

    ```code
    pub run bin/server.dart
    ```

As mentioned, if you just use the editor recommended earlier you can do this
from within it.

## Verify

To check that RethinkDB is running navigate to ```localhost:28000``` and ensure
that the dashboard is there. You can explore that if you like, in fact you can
directly manage the database in this.

To check that the API is running you can check ```localhost:8080``` and ensure
the obvious joyous message shows.

  [f6ac2ac8]: https://atom.io/ "Atom"
  [72e4f24d]: https://atom.io/packages/dartlang "dartlang"
  [af1ffb47]: https://www.dartlang.org/ "dartsdk"
