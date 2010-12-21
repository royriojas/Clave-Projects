// JavaScript Document
/*
	Autor 		: RRRM 
	Nombre 		: xTab
	Descripcion : Crea un objeto TabPanelGroup a partir de un Div que se le pasa como Id, 
				  y una clase CSS para resaltar los tabs actualmente seleccionados
	
	Constructor	: 
				var tabGroup = new xTab('theTabPanel',  //el id del div que contiene al tabpanelgroup
										'itemTabOver'   //clase css para denotar los tabs seleccionados
										)								
	Metodos P�blicos:
				
				selectTab(num) //num : el n�mero del Tab a mostrar indexado desde 0 ("como todo buen arreglo") 
				
				descripci�n : Selecciona el Tab de acuerdo al n�mero pasado
				
	Notas		:
	
				Si el numero de "tabs" no corresponden con el n�mero "tabsContainer" se lanzara un error y no se crear� el tabGroup de manera correcta
				
	
*/
function xTab (
				str_div_id,
				str_class_tab_over							
			)
	{
		this.selectTab = function (num) {
			if (num < theTabContainerDivs.length) {							
				for (var i = 0; i < theTabContainerDivs.length; i++) {
					theTabContainerDivs[i].style.display = (i == num)?'block':'none';
					theTriggers[i].className = (i == num)?theTriggers[i].overClassName:theTriggers[i].normalClassName;
				}	
			}
			else {
				alert ('El Indice del Tab seleccionado est� fuera del rango, el numero de tabContainers es ' + theTabContainerDivs.length);
			}
		}		
	    var me = this;
		var theMainDiv  = $(str_div_id);
		var theTriggers = xGetElementsByClassName('tabTrigger',theMainDiv);				
		var theTabContainerDivs = xGetElementsByClassName('tabContainer',theMainDiv);
		
		if (theTriggers.length == theTabContainerDivs.length) {
			for (var i = 0; i < theTriggers.length; i++) {
				theTriggers[i].theDivToHide = i;
				theTriggers[i].normalClassName = theTriggers[i].className;
				theTriggers[i].overClassName = str_class_tab_over;
				xAddEventListener(theTriggers[i],'click',showTab,false);								
			}
			me.selectTab(0);
		}
		else {
			alert('El n�mero de tabs no coincide con el numero de contenedores, corrijalo');
		}
		
		function showTab(evt) {
			var xe = new xEvent(evt);
			//alert(xe.target.theDivToHide.className);
			me.selectTab(xe.target.theDivToHide);
		}			
	}