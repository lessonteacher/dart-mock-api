#!/bin/bash

# Run rethinkdb
 rethinkdb --bind all &

 # Run the dart api
 /usr/bin/dart bin/server.dart
