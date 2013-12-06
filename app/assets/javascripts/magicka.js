(function($) {

    var maskDiv = '<div style="position: fixed;_position: absolute;width: 100%;height: 100%;_height: 100000px;top: 0px;left: 0px;z-index: 10100;background: #000;filter: alpha(opacity=90);opacity: 0.9;"></div>';

    var Magicka = function(options) {
        this.opts = options || {};
        this.mask = null;
    };

    Magicka.prototype.bindActions = function() {
        var _this = this;
        this.bind('click', function(e) {
            if (_this.opts['isActive']()) {
                e.preventDefault();
                var img = _this.findImage(this);
                _this.placeImage(img.data('url'));
            }
        });
    };

    Magicka.prototype.findImage = function(elem) {
        var _$elem = $(elem);
        return _$elem.is('img') ? _$elem : _$elem.find('img');
    };

    Magicka.prototype.placeImage = function(src) {
        var
            img = new Image(), _this = this,
            beforeLoad = _this.opts['load'] && _this.opts['load']['before'],
            afterLoad  = _this.opts['load'] && _this.opts['load']['after'];
        img.src = src;
        img.className = _this.opts['className'];
        if (_this.opts['mask']) _this.insertMask();
        beforeLoad && beforeLoad.call(this);
        if (img.complete)
            afterLoad && afterLoad.call(this, img);
        else
            img.onload = function() { afterLoad && afterLoad.call(this, img); };
        return _this;
    };

    Magicka.prototype.insertMask = function() {
        if (this.mask) {
            this.mask.remove();
            this.mask = null;
        }
        this.mask = $(maskDiv).appendTo('body');
    };

    $.fn.$magicka = function() {
        var
            hasProp = Object.prototype.hasOwnProperty,
            __prop__ = Magicka.prototype;
        Magicka.apply(this, arguments);
        for (var prop in __prop__) if (hasProp.call(__prop__, prop))
            this[prop] = __prop__[prop];
        this.bindActions();
        return this;
    };

}(jQuery));

$(function() {
    // !($('#pic-gallery-signal').hasClass('show') || $('#taskbar').sidebar('is open'))
    $('.add_pic img').$magicka({
        isActive: function() {
            return true;
        },
        className: 'a b c',
        load: {
            before: function() {
            },
            after: function(img) {
                $(img).modal('show');
            }
        }
    });
});