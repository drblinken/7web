7web Week 3 - Angular.js
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
* added bookmarksWithTags Factory in app.js

### Do: Write Jasmine tests that verify the behaviour of your service and run them in your browser

* written the tests first.

Day 2
-----

Start Example

    open http://localhost:4567

Chapter explains the two way data binding for editing bookmarks, main point is to refer to a shared object instance (formBookmark.bookmark) from both state and $scope.

Second part discusses end to end tests (system tests) started with

    open http://localhost:4567/e2e-test-runner.html

### Day 2 Self-Study

####Find: AngularJS directives

    [https://docs.angularjs.org/api/ng/directive](https://docs.angularjs.org/api/ng/directive)


####Find: The API for the AngularJS end-to-end testing library

*   https://docs.angularjs.org/guide/e2e-testing
(easily found from the url given in the test cases, but that was outdated)

Angular Scenario Runner is Outdated and has been replaced by Protractor.

https://code.angularjs.org/1.2.16/docs/guide/e2e-testing

I guess I have to rewrite the test examples with Protractor.

this is the link to the Angular.js E2E test runner: 
    * https://code.angularjs.org/1.2.16/docs/guide/e2e-testing
    * this is the link given in the test examples of the book: http://docs.angularjs.org/guide/dev_guide.e2e-testing

#####Switch E2E tests to Protractor

as described in the E2E test section in the angular-seed readme.md

* copied bower.json, and e2e-tests dir 
* copied package.json and then was able to run 

    ```
    npm run update-webdriver
    ```

Protractor Tests can then be started with

    ```
    npm run protractor
    ```

* http://angular.github.io/protractor/#/tutorial

####Do: Try using different view directivess and verify the results in your browser. For example, us ng-mouseenter and ng-mouseleave to show and hid a bookmark's tags when moving the mouse.

####Do: Write end-to-end tests to verify the behaviour of the view directives.

####Do: run your tests with Karma, a test runner created by the AngularJS team.

* http://karma-runner.github.io/0.12/index.html



####Do:
