(function ($) {

  $.fn.contactSelector = function (options) {
    var opts = {
      type: 'Broker',
      serviceURL: ''
    };

    $.extend(opts, options);

    return this.each(function () {
      var ele = $(this);
      var textField = ele.find('.ContactoName');
      textField.focus(function () {
        var val = textField.val();
        val = $.trim(val);
        if (val != '' && ele.find('.hiddenId').val() != '') {
          if (confirm('¿Desea elegir otro contacto?')) {
            textField.val('');
            ele.find('.hiddenId').val('');
            ele.find('.Telefono1').val('');
            ele.find('.Telefono2').val('');
            ele.find('.Email').val('');
          }
          else {
            textField.blur();
          }
        }
      });
      textField.autocomplete({
        source: function (request, response) {
          Service.contactsByName({}, function (args) {
            if (args.success) {
              
            }
          });
        },
        minLength: 2,
        select: function (event, ui) {
          if (ui.item) {
            textField.select();
            console.log('selecting the value');
            ele.find('.hiddenId').val(ui.item.Id);
            ele.find('.Telefono1').val(ui.item.data.Telefono1);
            ele.find('.Telefono2').val(ui.item.data.Telefono2);
            ele.find('.Email').val(ui.item.data.Email);
          }
        }
      });

    });

  };
})(jQuery);