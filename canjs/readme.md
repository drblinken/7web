---
layout: bento
title: 7web | Week 2
---

Seven Web Frameworks in Seven Weeks, Week 2: canJS
===================

Week 2, Day 1
--------------------------

### jQuery
* [http://jquery.com/](http://jquery.com/)
* The [Learning Center](http://learn.jquery.com/) includes a [JavaScript 101](http://learn.jquery.com/javascript-101/)

* [Manipulation](http://api.jquery.com/category/manipulation/) shows more things you can to with the jQuery object.

### Source Code

Define a Model: [https://github.com/drblinken/7web/blob/master/canjs/public/app/base/app.js](https://github.com/drblinken/7web/blob/master/canjs/public/app/base/app.js) -
which REST method is missing? Probably the one that gets a single bookmark / findOne.


### Links

* [Jasmine Spec](http://jasmine.github.io/)

### Self-Study

#### Urls to open

* open example: [http://localhost:4567/example/base](http://localhost:4567/example/base)

#### Find:
* The main CanJS forum: [https://forum.javascriptmvc.com/canjs](https://forum.javascriptmvc.com/canjs)
* [CanJS API Doc](http://canjs.com/2.1/docs/) (this is 2.1, included in this examples is 1.1.8, downloaded the 2.1.2 to the lib dir)
* [CanJS implementation of TodoMVC](http://todomvc.com/architecture-examples/canjs/) - [TodoMVC](http://todomvc.com/)

#### Do:

* Set up a simple CanJS page with an observe. Change the observe in your browser's JavaScript constole and see the view update itself automatically.
see [https://github.com/drblinken/7web/blob/master/canjs/public/simple.html](https://github.com/drblinken/7web/blob/master/canjs/public/simple.html)
* Experiment with CanJS on jsFiddle withthe CanJS jQuery Template:
[http://jsfiddle.net/qYdwR/](http://jsfiddle.net/qYdwR/)
    * forked the fiddle to [http://jsfiddle.net/drblinken/5C2u6/](http://jsfiddle.net/drblinken/5C2u6/)

Week 2, Day 2
--------------------------

### Source Code

Start:

* start sinatra app:

        .../7web/canjs (master)$ ruby app.rb

* open example: [http://localhost:4567/example/base](http://localhost:4567/example/base)

### Self-Study

#### Find:
* Documentation: probably this, [http://canjs.com/docs/can.Control.html](http://canjs.com/docs/can.Control.html), but skipped

#### Do:
* Experiment (skipped)
* why is bind(this) needed? - instead of
bookmark.bind("destroyed",this.clearForm)
    - this is a call to function.bind - although it seems to work without it.
[see this](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function/bind
)
* change bookmark list: use icons for edit and delete
    * [icon source](https://www.iconfinder.com/iconsets/flat-ui-icons-24-px)
    * just included icons and used the same css classes (edit delete) in [bookmark_list.mustache](https://github.com/drblinken/7web/blob/master/canjs/public/app/base/bookmark_list.mustache)


Week 2, Day 3
--------------------------

### Source Code



### Links

### Self-Study

#### Find:
#### Do:
## Urls to open
