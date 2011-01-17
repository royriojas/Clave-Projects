(function ($) {
  $.registerAPI({
    apiObjects: [
					{
					  funcs: ["ContactsByName", "ContactById"],
					  objName: 'Carcheck.Service'
					}],
    urlHandler: '/CarCheckx/Handler/Service.ashx', /* TODO: Change this when the virtual folder is changed */
    timeout: 60000
  });
})(jQuery);