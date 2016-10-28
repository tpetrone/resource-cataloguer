# Requests with curl

* Create resource:
> curl -H "Content-Type: application/json" -X POST -d '{"data":{"uri":"example2.com","lat":-23.559616,"lon":-46.731386,"status":"stopped","collect_interval":5,"description":"A simple resource in São Paulo","capabilities":["temperature"]}}' http://localhost:3000/resources | json_pp

