module.exports = function(config){
  config.set({
    port: 1234,
    basePath : './',

    files : [
      'public/lib/angularjs/1.3.3/angular.js',
      'public/lib/angularjs/1.3.3/angular-resource.js',
      'public/lib/angularjs/1.3.3/angular-mocks.js',
      'public/lib/jasmine-2.1.2/lib/jasmine-2.1.2/jasmine.js',      
      'public/app/base/app.js',
      'public/app/base/app-test.js',
      'public/app/base/app-test-all.js',
      'public/app/base/app-test-tags-day1.js',
      'public/concepts/concepts-test-karma.js'
     
    ],

    autoWatch : true,

    frameworks: ['jasmine'],

    browsers : ['Firefox'],

    plugins : [
            'karma-firefox-launcher',
            'karma-jasmine',
            'karma-junit-reporter'
            ],

    junitReporter : {
      outputFile: 'test_out/unit.xml',
      suite: 'unit'
    }

  });
};
