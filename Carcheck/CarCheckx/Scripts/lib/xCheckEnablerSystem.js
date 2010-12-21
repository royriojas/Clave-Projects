function __init_xCheckEnablerSystem() {
	var classDisable = 'deshabilitado';
	//get all the checks that have this className
	var checks = xGetElementsByClassName('X_CHECK_ENABLER');
	
	for (var ix = 0; ix < checks.length; ix++) {
		var a = new xCheckEnabler(checks[ix],
							  CCSOL.DOM.x_GetAttribute(checks[ix],'ctrl_to_enable'),
							  classDisable);
							  
	}
	
}

if (typeof(domReady) == 'function') 
{	
	domReady(__init_xCheckEnablerSystem);
}
else 
{
	xAddEventListener(window,'load',__init_xCheckEnablerSystem, true);
}