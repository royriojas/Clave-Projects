function xImagenCambiante(str_imagen_id,str_url_imagen_cambiante,boolean_rollOver) {
		var imagen = xGetElementById(str_imagen_id);
		var str_url_antigua = imagen.src;
		var str_url_nueva = str_url_imagen_cambiante;
		var div_dias_internos = xGetElementById(str_imagen_id + '_div');
		
		if (boolean_rollOver) {
		    xAddEventListener(imagen,'mouseover',rotaImagenes,true);
		    xAddEventListener(imagen,'mouseout',rotaImagenes,true);
		}
		function rotaImagenes(evt) {
			var myEvent = new xEvent(evt);
			myEvent.target.src =(myEvent.target.src == str_url_antigua)? str_url_nueva:str_url_antigua;
		}
		this.imgActiva= function () {
			imagen.src = str_url_nueva;
		}
		this.imgInactiva = function () {
			imagen.src = str_url_antigua;
		}
		
		this.setDiasEstado= function(num_dias) {
			div_dias_internos.innerHTML = ''+num_dias;	
		}
	}
