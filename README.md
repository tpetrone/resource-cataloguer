![Build Status](https://gitlab.com/smart-city-software-platform/resource-cataloguer/badges/master/build.svg)

Resource Cataloguer API
====================

Environment Setup
-----------------

* Install RVM
* Run on terminal: ```$ rvm install 2.3.1```
* In the project directory, run:
  * ```$ gem install bundle```
  * ```$ bundle install```
  * ```$ bundle exec rake db:create```
  * ```$ bundle exec rake db:migrate```
* Run the tests:
  * ```$ bundle exec rspec```

You should see all tests passing =)

Docker Setup
------------

* Install Docker: (google it)
* Run on terminal:
  * ```$ script/setup```
  * ```$ script/development start``` # start the container
  * ```$ script/development stop```  # stop the container

When the container is running you can access the application on
http://localhost:3000

To execute commands into the started container you can run:

```$ scripts/development exec <command>```

## Workaround

Please, try the following approaches to fix possible errors raised when 
trying to start docker services:

### Bind problem

If you have bind errors while trying to start a docker service, try
to remove the docker-network **platform** and create it again. If this not fix
the problem, run the following commands:

* Stop docker deamon: ```sudo service docker stop```
* Remova o arquivo local-kv: ```sudo rm /var/lib/docker/network/files/local-kv.db```
* Start docker deamon: ```sudo service docker start```
* Create the network again: ```sudo docker network create platform```
* Run the container: ```./script/development start```

### Name problem

If get any name conflicts while trying to run a docker container, try to 
follow these steps:

* Stop current container: ```./script/development stop```
* Start the container: ```./script/development start```

Provides
--------

* POST /resources
* PUT /resources/:uuid
* GET /resources/:uuid
* GET /resources/sensors
* GET /resources/actuators
* GET /resources/search

Needs
-----

* resources GET /status
* consumers POST /resources/
* consumers PUT /resources/:uuid


Useful links
============

* [Project description](https://social.stoa.usp.br/poo2016/projeto/projeto-plataforma-cidades-inteligentes)
* [Resources caralog service description](https://gitlab.com/smart-city-software-platform/resource-cataloguer/wikis/home) 
* [Group Repository](https://gitlab.com/groups/smart-city-software-platform)
* [email list](https://groups.google.com/forum/#!forum/pci-lideres-equipe-de-organizacao-poo-ime-2016)

Design questions
==============

* Should we notify external services upon resource creation or wait for them to query for new resources? We could notify the service right after its creation.
