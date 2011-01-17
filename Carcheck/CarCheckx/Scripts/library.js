(function ($) {
  $.ns = function (str) {
    var nsParts = str.split(".");
    var root = window;
    for (var i = 0, len = nsParts.length; i < len; i++) {
      if (typeof root[nsParts[i]] == "undefined") {
        root[nsParts[i]] = {};
      }
      root = root[nsParts[i]];
    }
    return root;
  };

  $.sFormat = function () {
    var pattern = /\{\d+\}/g;
    var args = arguments;
    var s = Array.prototype.shift.apply(args);
    return s.replace(pattern, function (c) {
      return args[c.match(/\d+/)];
    });
  };

  $.registerAPI = function (opts) {
    $.each(opts.apiObjects, function () {
      var apiObject = this;
      var namespace = $.ns(apiObject.objName);

      namespace.serviceURL = opts.urlHandler;

      $.each(apiObject.funcs, function (i, val) {
        val = $.trim(val);
        namespace[val] = function (obj, callback) {
          if (obj != null && !callback) {
            callback = obj;
            obj = null;
          }
          callback = callback || function (result) { };

          var _json = null;
          if (obj != null) {
            _json = JSON.stringify(obj);
          }

          var _data = { };

          if (_json) {
            _data.json = _json;
          }
          _data.method = val;

          var ajaxOpts = {
            url: namespace.serviceURL, //$.sFormat('{0}/{1}/{2}', namespace.urlHandler, _data.className, _data.method),
            dataType: "json",
            data: _data,
            success: function (dt) {
              var sc = dt != null;
              if (dt != null && dt.Error) {
                sc = false;
              }
              callback({
                success: sc,
                "data": dt
              });
            },
            error: function (statu, e) {
              // TODO: Add message;
              callback({
                success: false,

                reason: 'Error',
                status: statu,
                excep: e
              });
            },

            timeout: opts.timeout,
            type: "POST"
          };

          return $.ajax(ajaxOpts);
        };
      });
    });
  };
})(jQuery);
