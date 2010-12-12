
function xCheckAll(str_chk_id, str_divArea_id, str_classname) {
		
		var chk = xGetElementById(str_chk_id);
		var area = xGetElementById(str_divArea_id);
		var arrChecks = xGetElementsByClassName(str_classname,area);	    
		
		xAddEventListener(chk,'click',checkMe,true);
		  
		//metodo privado
		function checkMe(evt) {
			
			var myEvent = new xEvent(evt);
			
			for (var i = 0; i < arrChecks.length; i++) {
				arrChecks[i].checked = myEvent.target.checked == true;
			}			
		}		
		
}

//14-05-2006 RRRM
// Solución rápida para que funcione la clase xCheckAll con .NET
// .NET agrega un span al CheckBox por lo que la clase la tiene el span y no el CheckBox mismo
// TODO: preguntar si es nulo str_classname para utilizar el nodeName del str_chk_id

function xCheckAllN(str_chk_id,str_divArea,str_style,str_styleOver) {
		var chk = xGetElementById(str_chk_id);
		var area = xGetElementById(str_divArea);
		var arrChecks = xGetElementsByTagName(chk.nodeName,area);	    
		
		xAddEventListener(chk,'click',checkMe,true);
	   	
		setListeners();
		
		try {
			xAddEventListener(window,'unload',unloadAll,false);
		}
		catch(e) {
			alert(e.message);
		}
		
		function doBackgroundPlay(evt) {
			var xevent = new xEvent(evt);
			var theitem = xevent.target;;
			if (xevent.target.id ==	str_chk_id) return true;
			
			if (xevent.target.checked) {
				//if (xDef(str_styleOver)) 
				var times = 0;
				
				do {
				    theitem = theitem.parentNode;
				    
				    times++;
				}while ((theitem.tagName.toUpperCase() != 'TR') && (times <= 4)) ;
				
				theitem.className = str_styleOver;
				
			}
			else {
				var times = 0;
				do {
				    theitem = theitem.parentNode;
				    times++;
				}while ((theitem.tagName.toUpperCase() != 'TR') && (times <= 4)) ;
				
				theitem.className = str_style;
			}
			
		}
		
		function setListeners() {
			for (var i = 0; i < arrChecks.length; i++) {
					if (arrChecks[i].type == 'checkbox') {
					    if (arrChecks[i].id != str_chk_id) {						  
						    arrChecks[i].realBackgroundStyle = str_style;
							
							xAddEventListener(arrChecks[i],'click',doBackgroundPlay,false);
						}
					}
				}			
		}
		function removeListeners() {
			for (var i = 0; i < arrChecks.length; i++) {
					if (arrChecks[i].type == 'checkbox') {
					    if (arrChecks[i].id != str_chk_id) {						  
						    arrChecks[i].realBackgroundStyle = str_style;
							
							xRemoveEventListener(arrChecks[i],'click',doBackgroundPlay,false);
						}
					}
				}			
		}
		
		//metodo privado
		function checkMe(evt) {
			
			var myEvent = new xEvent(evt);
			if (myEvent.target.checked) {				
				for (var i = 0; i < arrChecks.length; i++) {
					if (arrChecks[i].type == 'checkbox') {
					    if (arrChecks[i].id != str_chk_id) {
						    if (!arrChecks[i].checked) arrChecks[i].click();
						    arrChecks[i].checked = true;
							//arrChecks[i].onclick();
						}
					}
				}				
			}
			else {
				for (var i = 0; i < arrChecks.length; i++) {
					if (arrChecks[i].type == 'checkbox') {
					    if (arrChecks[i].id != str_chk_id) {
						    if (arrChecks[i].checked) arrChecks[i].click();
						    arrChecks[i].checked = false;
							//arrChecks[i].onclick();
						}
					}
				}				
				
			}
			
	}			
	this.allEmptyChecks = function() {
	    var todosVacios = true;
	    for(var i = 0; i < arrChecks.length; i++) {
	        if (arrChecks[i].type == 'checkbox') {
	            if (arrChecks[i].id != str_chk_id) {
	                if (arrChecks[i].checked) { 
	                    todosVacios = false;
	                    break;
	                }
	            }
	        }
	    }
	    return todosVacios;
	}
	this.unload = function () {
		unloadAll();		
	}
	function unloadAll() {
		xRemoveEventListener(chk,'click',checkMe,true);
		removeListeners();
		chk = area = arrChecks = null;	  
	}
	this.getArray = function() {
		return arrChecks;				
	}
}
/*
x_checkAll.js
Autor : Roy Riojas Montenegro

parámetros de creación 

str_chk_id			id del checkbox a utilizar como desencadenador del evento para hacer check a todos, 
str_divArea_id		id del elemento (<div>, <span> u otro) que servira de filtro para escoger solo los checks de ese rango, 
str_classname		nombre de la clase CSS que debe tener el elememnto para ser escogido.

asigna a un objeto del tipo checkBox la posibilidad de marcar automáticamente un conjunto de Checks que tengan la clase
pasada como parametro y bajo un mismo padre.

*/
