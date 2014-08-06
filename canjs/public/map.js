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
        var startX = 0;
        var startT = 0;
        var startL = 0;
        $el.mousedown(function(ev) {
            dragging = true;
            startY = ev.clientY;
            startT = $el.css('top');
            startX = ev.clientX;
            startL = $el.css('left');
            startL = parseInt(startL)
            if (isNaN(startL)){
              startL = 0
           }
           //$('#xy').append(startL);

        });
        $(window).mousemove(function(ev) {
            if (dragging) {
                // calculate new top
                var newTop = parseInt(startT) + (ev.clientY - startY);
                var newLeft = parseInt(startL) + (ev.clientX - startX);
                //stay in parent
                var maxTop =  $el.parent().height()-$el.height();
                var maxLeft = $el.parent().width()-$el.width();
                newTop = newTop<0?0:newTop>maxTop?maxTop:newTop;
                newLeft = newLeft<0?0:newLeft>maxLeft?maxLeft:newLeft;

                $el.css('top', newTop );
                $el.css('left', newLeft);
            }
        }).mouseup(function() {
            dragging = false;
        });
    });
}
