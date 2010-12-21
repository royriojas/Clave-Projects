function CollapsibleDiv (
						 str_elementoId,
						 str_elementoidAOcultar,
						 bln_mostrarInicialmente,
						 str_urlImagen
						) 						
{
	//constructor
	var elementoOrigen = xGetElementById(str_elementoId);
	if (elementoOrigen == null) alert('error no hay elementoOrigen');
	var imagen_inicial_src = (elementoOrigen.nodeType == 1)?elementoOrigen.src:null;
	elementoOrigen.style.cursor = "pointer";
	
	var imagen_paraCambiar_src = (str_urlImagen)? str_urlImagen:null;
	var elementoAOcultar = xGetElementById(str_elementoidAOcultar);
	
	//elementoOrigen.onclick = img_onClick;
	xAddEventListener(elementoOrigen,'click',img_onClick,false);
	if (bln_mostrarInicialmente != null) setVisible(bln_mostrarInicialmente);
	
	var me = this;
	
	//métodos privados
	//handler al hacer click sobre la imagen
	function img_onClick()
	{	
		if (elementoAOCultarVisible()) {
			setVisible(false);			
		}
		else {
			setVisible(true);			
		}					
	}
	
	function elementoAOCultarVisible() {
		return elementoAOcultar.style.display != "none";
	}
	
	this.getElementVisible = function () {
	   return elementoAOcultar.style.display != "none";
	}
	
	function setVisible(bln_visible) {		
		elementoAOcultar.style.display = (bln_visible)?"block":"none";		
		if (imagen_paraCambiar_src != null) {
			elementoOrigen.src = (bln_visible)?imagen_inicial_src:imagen_paraCambiar_src;
		}
	}
	this.displayDiv = function (bln_visible) {
	  me.setVisible(bln_visible);
	}
	this.UnLoad = function () {
		xRemoveEventListener(elementoOrigen,'click',img_onClick,false);
		//elementoOrigen.onclick = null;
	}
}