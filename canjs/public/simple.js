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
  object.attr("value","newValue")
}
$(document).ready(doit);

