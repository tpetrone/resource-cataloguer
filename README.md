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
  * ```$ rspec```

You should see all tests passing =)

Provides
--------

* POST /resources
* PUT /resources/:id
* GET /resources/:id
* GET /resources/sensors
* GET /resources/actuators
* GET /resources/search - Not implemented yet

Needs
-----

* resources GET /status
* consumers POST /resources/:id
* consumers PUT /resources/:id


Useful links
============

* [Project description](https://social.stoa.usp.br/poo2016/projeto/projeto-plataforma-cidades-inteligentes) @ STOA
* [Resources caralog service description](https://social.stoa.usp.br/poo2016/projeto/grupo-2-servico-de-catalogo-de-recursos) @ STOA
* [Group Repository](https://gitlab.com/groups/smart-city-platform)
* [email list](https://groups.google.com/forum/#!forum/pci-lideres-equipe-de-organizacao-poo-ime-2016)

Design questions
==============

* Should we notify external services upon resource creation or wait for them to query for new resources? We could notify the service right after its creation.
