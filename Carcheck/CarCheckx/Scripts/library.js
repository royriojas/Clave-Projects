(function ($) {
  $.ns = function () {
    
  };
  $.registerAPI = function (opts) {
    $.each(opts.apiObjects, function () {
      var apiObject = this;
      var namespace = $.ns(apiObject.objName);

      $.each(apiObject.funcs.split(','), function (i, val) {
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

          var _data = { className: apiObject.className };

          if (_json) {
            _data.json = _json;
          }
          _data.method = val;

          var ajaxOpts = {
            url: $.stringFormat('{0}/{1}/{2}', opts.urlHanlder, _data.className, _data.method),
            dataType: "jsonp",
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
