#!/bin/bash

print_help() {
  cat <<EOF
  Usage: $0 [command] [params]

  commands:
    post uri
      HTTP POST request
      this creates a new resource
      you MUST pass a uri here (this is a unique value for each resource)

    put
      HTTP PUT request
      this updates a resource

    put-no-cap
      HTTP PUT request without passing a capability
      this updates a resource
EOF
}

if [ "$1" == post ]; then
  if [ "$#" -eq 1 ]; then
    print_help
    exit 1
  fi
curl -X POST -H "Content-Type: application/json" -d "{\"data\": {\"capabilities\":[\"teste\"], \"lat\":2, \"lon\":2, \"description\":\"desc\", \"status\":\"running\",\"uri\":\"$2\",\"collect_interval\":5}}" http://localhost:3000/resources

elif [ "$1" == put ]; then
curl -X PUT -H "Content-Type: application/json" -d "{\"data\": {\"capabilities\":[\"teste\"], \"lat\":33, \"lon\":1111, \"description\":\"desc\", \"status\":\"running\",\"uri\":\"localhost:12345\",\"collect_interval\":5}}" http://localhost:3000/resources/ba3391a4-9eb9-42a3-a302-93eefa8fbf97

elif [ "$1" == put-no-cap ]; then
curl -X PUT -H "Content-Type: application/json" -d "{\"data\": {\"lat\":33, \"lon\":1111, \"description\":\"desc\", \"status\":\"running\",\"uri\":\"localhost:12345\",\"collect_interval\":5}}" http://localhost:3000/resources/ba3391a4-9eb9-42a3-a302-93eefa8fbf97

else 
  print_help
fi

