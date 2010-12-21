function liberaEstiloVacio(e){
	var evento = new xEvent(e);
	var textbox = evento.target;

			if (textbox.value != "") {				
				var entre = false;
				if (textbox.className.indexOf("MAYUSC") > 0) {
					textbox.className = 'FormText MAYUSC';	  
					entre = true;
				}
				if (textbox.className.indexOf("MINUSC") > 0) {
					textbox.className = 'FormText MINUSC';	  
					entre = true;
				}
				if (textbox.className.indexOf("ORACION") > 0) {
					textbox.className = 'FormText ORACION';	  
					entre = true;
				}
				if (!entre) {
					textbox.className = 'FormText';
				}
			}
			else  
			{
				var entre = false;
				if (textbox.className.indexOf("MAYUSC") > 0) {
					textbox.className = 'FormTextVacio MAYUSC';	  
					entre = true;
				}
				if (textbox.className.indexOf("MINUSC") > 0) {
					textbox.className = 'FormTextVacio MINUSC';	
					entre = true;
				}
				if (textbox.className.indexOf("ORACION") > 0) {
					textbox.className = 'FormTextVacio ORACION';	
					entre = true;
				}	
				if (!entre) {
					textbox.className = 'FormTextVacio';
				}
			}
}
function limpiaCamposLlenados() {
	var arr_textbox = xGetElementsByClassName('FormTextVacio',document,'INPUT');
	for (i=0; i < arr_textbox.length; i++) {
		//if (arr_textbox[i].nodeType == 1) {
			var textbox = arr_textbox[i];		
			
			if (textbox.value != "") {				
				var entre = false;
				if (textbox.className.indexOf("MAYUSC") > 0) {
					textbox.className = 'FormText MAYUSC';	  
					entre = true;
				}
				if (textbox.className.indexOf("MINUSC") > 0) {
					textbox.className = 'FormText MINUSC';	  
					entre = true;
				}
				if (textbox.className.indexOf("ORACION") > 0) {
					textbox.className = 'FormText ORACION';	  
					entre = true;
				}
				if (!entre) {
					textbox.className = 'FormText';
				}
			}
			else  
			{
				var entre = false;
				if (textbox.className.indexOf("MAYUSC") > 0) {
					textbox.className = 'FormTextVacio MAYUSC';	  
					entre = true;
				}
				if (textbox.className.indexOf("MINUSC") > 0) {
					textbox.className = 'FormTextVacio MINUSC';	
					entre = true;
				}
				if (textbox.className.indexOf("ORACION") > 0) {
					textbox.className = 'FormTextVacio ORACION';	
					entre = true;
				}	
				if (!entre) {
					textbox.className = 'FormTextVacio';
				}
			}
		//}				
	}
		
}
function seteaValoresCero() {			
    //TODO: hacer parámetro solo el estilo al que se quiere cambiar cuando este vacio el campo
    //    : se puede guardar el nombre del estilo actual del campo para no alterarlo.
	var arr_textbox = xGetElementsByClassName('FormText',document,'INPUT');
	for (i=0; i < arr_textbox.length; i++) {
		//if (arr_textbox[i].nodeType == 1) {
			var textbox = arr_textbox[i];
			xAddEventListener(textbox,'blur',liberaEstiloVacio);
					
			if (textbox.value != "") {				
				var entre = false;
				if (textbox.className.indexOf("MAYUSC") > 0) {
					textbox.className = 'FormText MAYUSC';	  
					entre = true;
				}
				if (textbox.className.indexOf("MINUSC") > 0) {
					textbox.className = 'FormText MINUSC';	  
					entre = true;
				}
				if (textbox.className.indexOf("ORACION") > 0) {
					textbox.className = 'FormText ORACION';	  
					entre = true;
				}
				if (!entre) {
					textbox.className = 'FormText';
				}
			}
			else  
			{
				var entre = false;
				if (textbox.className.indexOf("MAYUSC") > 0) {
					textbox.className = 'FormTextVacio MAYUSC';	  
					entre = true;
				}
				if (textbox.className.indexOf("MINUSC") > 0) {
					textbox.className = 'FormTextVacio MINUSC';	
					entre = true;
				}
				if (textbox.className.indexOf("ORACION") > 0) {
					textbox.className = 'FormTextVacio ORACION';	
					entre = true;
				}	
				if (!entre) {
					textbox.className = 'FormTextVacio';
				}
			}
			
		//}				
	}			
}	

	