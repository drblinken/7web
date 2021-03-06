/***
 * Excerpted from "Seven Web Frameworks in Seven Weeks",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/7web for more book information.
***/

doit = function() {
  // Use can for CanJS
  var $result = $("#result");
  can.each(["One", "Two", "Three"], function(it) {
    $result.append(it).append(" - ");
  });
  $result.append("Go CanJS!");
  // $ is shortcut for jQuery
  var $more = jQuery("#more");
  $more.append("me was here");

  $old = $("#oldtext");
  $old.text("jö der neue text");
}

$(document).ready(doit);

$.fn.slider = function() {
    return this.each(function() {
        var $el = $(this);
        $el.css('top', 0);
        var dragging = false;
        var startY = 0;
        var startT = 0;
        $el.mousedown(function(ev) {
            dragging = true;
            startY = ev.clientY;
            startT = $el.css('top');
        });
        $(window).mousemove(function(ev) {
            if (dragging) {
                // calculate new top
                var newTop = parseInt(startT) + (ev.clientY - startY);

                //stay in parent
                var maxTop =  $el.parent().height()-$el.height();
                newTop = newTop<0?0:newTop>maxTop?maxTop:newTop;
                $el.css('top', newTop );
            }
        }).mouseup(function() {
            dragging = false;
        });
    });
}
