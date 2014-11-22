Week 3 - Angular.js
===================

Day 1 
-----

First example for data binding

    open public/index-basic.html

Start and Test the sinatra app

    ruby app.rb 
    rspec app_test.rb

Start example

    open http://localhost:4567

 and then select base


 Run Tests

    open http://localhost:4567/index-test.html

Tests are in public/app/base/app-test.js.

### Day 1 Self-Study
####Find: The AngularJS API Documentation

https://docs.angularjs.org/api

* This is version 1.3.3 undersea-arithmetic. 
* Downloaded 1.3.3 version from https://code.angularjs.org/1.3.3/
* Jasmine is also on a newer version, but it is a major (2.1) 
    * http://jasmine.github.io/
    * http://jasmine.github.io/2.0/upgrading.html

Decided to install newest Jasmin version as well. followed these steps: 

    git clone https://github.com/pivotal/jasmine.git
    mv dist/jasmine-standalone-2.1.2.zip ../7web-myversion/angularjs/public/lib/jasmine-2.1.2/
    unzip jasmine-standalone-2.1.2.zip

run tests seems no longer needed, got this error: https://docs.angularjs.org/error/ng/btstrpd - and fixed it by changing a bootstrap call in concepts.js

####Find: Two other ways to define services besides service and factory
* Providers http://stackoverflow.com/questions/15666048/service-vs-provider-vs-factory

from https://docs.angularjs.org/guide/services:

"Application developers are free to define their own services by registering the service's name and service factory function, with an Angular module."


https://docs.angularjs.org/api/ng/type/angular.Module
- are all these Angular.js services as well? I think so, that is 
filter, animation are two other ways to define services. 
Maybe provider as described on the Stackoverflow page is another possibility.

####Find: The angular-seed project

... which you can use as a template for your AngularJS applications
* https://github.com/angular/angular-seed

    git clone --depth=1 https://github.com/angular/angular-seed.git angular-own-    eded
    npm install
    npm start
    open http://localhost:8000/app/index.html



### Do: Take advantage of the REST API from our Sinatra server and write a service that retrieves bookmarks with tags using the /bookmarks/:tag URI

* created test file /app/base/app-test-tags-day1.js
* $resource documentation: https://docs.angularjs.org/api/ngResource/service/$resource

### Do: Write Jasmine tests that verify the behaviour of your sevice and run them in your browser

### Do: 



 

