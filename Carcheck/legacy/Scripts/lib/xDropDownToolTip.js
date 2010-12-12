// JavaScript Document
function xDropDownToolTip(aClass,aParent) {
		var drops = xGetElementsByClassName(aClass,aParent,'SELECT');	
		
		var me = this;
		try {
			for(i = 0; i < drops.length; i++) 
			{				
				xAddEventListener(drops[i],'change',onChangeHandler,false);	
				CCSOL.DOM.x_SetAttribute(drops[i],'title', drops[i].options[drops[i].selectedIndex].text);
			}
			xAddEventListener(window,'unload',_unload,true);
			
		}
		catch(e) {
			
			alert('Error al Crear el xDropDownTitle: ' + e.message);
		}						
		function onChangeHandler(e) {
			
			var evt = new xEvent(e);
			var aDrop = evt.target;
			try {
				aDrop.title = aDrop.options[aDrop.selectedIndex].text;
			}
			catch(e) {
				alert(e.message);
			}
		}
		function _unload() {
			me.unload();
		}
		this.unload = function() {
			try {
				for(i = 0; i < drops.length; i++) 
				{
					xRemoveEventListener(drops[i],'change',onChangeHandler,true);	
				}
				
			}
			catch(e) {
				alert(e.message);
			}
		}
	}