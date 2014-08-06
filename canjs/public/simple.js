/***
 * Tryout for Week 2 Day 1 - Doing
 * Dr. Blinken
 ***/



doit = function() {
  // Use can for CanJS
  var $result = $("#object");
  var $name = $("#name");
  var $value = $("#value");
  var $log = $("#log");
  object = new can.Observe({name: "myName", value: "myValue"});
  // better: new can.Map
  $name.append(object.attr("name"));
  $value.append(object.attr("value"));

object.bind('change', function(event, attr, how, newVal, oldVal) {
$log.append(attr+" changed");
if (attr == "value"){
  $value.append(" changed to: "+newVal);
}
if (attr == "name"){
  $name.append(" changed to: "+newVal);
}
attr; // 'perPage'
how; // 'set'
newVal; // 30
oldVal; // 50
});
// this could be copied to the console:
  object.attr("value","newValue");

this.object = object;
    var $canView = $("#canView");
    $canView.append("this...");
    $canView.append(can.view('canViewView', {
                object: this.object
            }));
}
$(document).ready(doit);

$(document).ready(function() {
    Dummy = can.Control({
        init: function(element, options) {
            this.counter = new can.Observe({
                click: 0
            });
            this.element.append(can.view('dummyMustache', {
                counter: this.counter
            }));
        },
        'a click': function(el, ev) {
            var newCount = this.counter.attr('click') + 1
            this.counter.attr('click', newCount);
        }
    });

    new Dummy('#dummy');
})();
