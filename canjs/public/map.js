/***
 * adapted from http://jsfiddle.net/KQpe9/
 **/


$(function() {
    $('.red-box').slider();
});
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
