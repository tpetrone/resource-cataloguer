![Build Status](https://gitlab.com/smart-city-platform/resources-catalog/badges/master/build.svg)

Resources Catalog API
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
    * ```$ docker pull debian:unstable```
	* ```$ docker build -t smart-cities/resource-cataloguer . ```
	* ```$ docker run -d -v <path_to_your_source_code>:/resource-cataloguer/ -p 3000:3000 smart-cities/resource-cataloguer```

Docker flags:

* -d : run the container as a daemon
* -v : mount a volume from your host to container (share your source code with container)
* -p : map the exposed port to your host (<host_port>:<container_port>)

Now you can access the application on http://localhost:3000


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

* [Project description](https://social.stoa.usp.br/poo2016/projeto/projeto-plataforma-cidades-inteligentes) @ STOA
* [Resources caralog service description](https://social.stoa.usp.br/poo2016/projeto/grupo-2-servico-de-catalogo-de-recursos) @ STOA
* [Group Repository](https://gitlab.com/groups/smart-city-platform)
* [email list](https://groups.google.com/forum/#!forum/pci-lideres-equipe-de-organizacao-poo-ime-2016)

Design questions
==============

* Should we notify external services upon resource creation or wait for them to query for new resources? We could notify the service right after its creation.
