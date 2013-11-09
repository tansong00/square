(function($) {

    var closeIcon = 'data:image/png;base64,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';
    var
        paneDiv = '<div class="square pie" style="position:fixed;z-index:11111;top:0;min-width:300px;margin:0;word-break:break-all;min-height:0;padding:0;left:50%;display:none;max-width:50%;"></div>',
        closeDiv = '<div><img style="position:absolute;bottom:10px;right:10px;cursor:pointer;" src="' + closeIcon + '"/></div>',
        maskDiv = '<div style="position: fixed;_position: absolute;width: 100%;height: 100%;_height: 100000px;top: 0px;left: 0px;z-index: 10100;background: #000;filter: alpha(opacity=80);opacity: 0.8;"></div>',
        $pane, $mask, animating = false, $this;

    $.fn.$pop = function() {
        $this = $(this);
        if ($pane != null) return $this;
        initPane($this.clone(true, true));
        $(closeDiv).appendTo($pane).css({height: '35px', width: '100%'}).find('img').bind('click', popOut);
        popIn();
        return $this;
    };

    function initPane(content) {
        $pane = $(paneDiv);
        $pane.html(content);
        $pane.appendTo('body').css({marginLeft: -($pane.width() / 2), marginTop: -$pane.height()}).show();
        return $pane;
    }

    function popIn() {
        if (animating) return;
        animating = true;
        $mask = $(maskDiv).appendTo('body');
        $pane.animate({marginTop: 0}, 'fast', function() {
            animating = false;
        });
        $this.trigger('shown');
    }

    function popOut() {
        if (animating) return;
        animating = true;
        if ($pane != null) {
            $pane.animate({marginTop: -$pane.height()}, function() {
                $pane.remove();
                $mask.remove();
                $pane = $mask = null;
                animating = false;
            });
            $this.trigger('hidden');
            $this = null;
        }
    }

}(jQuery));
