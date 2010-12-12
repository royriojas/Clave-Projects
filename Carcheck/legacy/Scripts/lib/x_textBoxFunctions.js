// x_textBoxFunctions

//function EventHandler
function copiavalorcampo(evt) {
    var evento = new xEvent(evt);
	var textbox = evento.target;
    //alert(textbox.value != "");
	if (textbox.value == "") {    
	   textbox.value = xGetElementById(textbox.nombreCampoACopiar).value;
	   textbox.select();
	}
	
}
function textboxCopyValue(str_campoOrigen,str_campoDestino,str_evento){
		    
    //para copiar la dirección del campo de texto lugarDelSiniestro
    var txtDirReu = xGetElementById(str_campoDestino);
    txtDirReu.nombreCampoACopiar = str_campoOrigen;
    if (!xDef(str_evento)) str_evento = 'focus';
    xAddEventListener(txtDirReu,str_evento,copiavalorcampo,true);
            
}


