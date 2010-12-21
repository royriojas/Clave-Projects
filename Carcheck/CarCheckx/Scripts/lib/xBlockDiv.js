// JScript File

function xBlockDiv(aDivToBlock) 
	{
		function blockElement(eleId) {
			eleId.disabled = true;			
			xAddClass(eleId,'readOnly');
		}
		var theElementDiv = $(aDivToBlock);
		
		var arrInputs = xGetElementsByTagName('INPUT',theElementDiv);			
		var arrSelects = xGetElementsByTagName('SELECT',theElementDiv);
		var arrTextArea = xGetElementsByTagName('textarea',theElementDiv)
		try {
//			var msj = '';
			for (var ix = 0; ix < arrInputs.length; ix++) {
//				msj += arrInputs[ix].id + '<br />';
				blockElement(arrInputs[ix]);
			}
//			msj += '<br />';
			for (var ix = 0; ix < arrSelects.length; ix++) {
//				msj += arrSelects[ix].id + '<br />';
				blockElement(arrSelects[ix]);
				
			}
//			msj +='<br />';
			for (var ix = 0; ix < arrTextArea.length; ix++) {
//				msj += arrTextArea[ix].id + '<br />';
				blockElement(arrTextArea[ix]);
				
			}
//			CCSOL.Utiles.Trace(msj);
		}
		catch(e) {
			alert('error xBlockDiv : ' + e.message);
		}
	}
	function xBlockDivs() {
		
		try {
			for (var ix = 0; ix < arguments.length; ix++) {
				xBlockDiv(arguments[ix]);				
			}
		}
		catch(e) {
			alert('error xBlockDivs : ' + e.message);
		}
	}
	
	function xBlockDivsByClassName(str_className) {
		
		try {
      var divs = xGetElementsByClassName(str_className);
      		  
			for (var ix = 0; ix < divs.length; ix++) {
				xBlockDiv(divs[ix]);				
			}
		}
		catch(e) {
			alert('error xBlockDivs : ' + e.message);
		}
	}