/*
	RRRM : 17-10-2006
	Descripción: Objeto para mostrar un tooltip dependiendo de los objetos en los que se encuentre
	//el ClasName del Tooltip que se creará
*/

function infoSystem(tt_ClassName, 										
					str_DivThatContainTheInfos,		//el id del div que contiene los objetos de tipo Info
					help_info_class,				//el className de los objetos del tipo Info
					tt_title_atr,					//utilizar este atributo como titulo
					tt_text_atr)					//utilizar este atributo como texto
{
		function createTheTooltip(theClassName) {
			var html = "<div class='tt_title' style='font-size:10px;font-weight:bold;color:black;' id='tt_title'>here goes a title</div><div class='tt_text' style='color:black;' id='tt_text'>here goes the text</div>"
			var body  = document.getElementsByTagName("body").item(0);		
			var theTooltip = document.createElement('div');
			theTooltip.innerHTML = html;
			theTooltip.id='theTooltip';
			theTooltip.style.display = 'none';
			theTooltip.align = 'left';
			theTooltip.className = theClassName;			
			body.appendChild(theTooltip);	
		}
		function theOnDisplay(e) {
			var xe = new xEvent(e);
			var theTrigger = xe.target;
			var theTitle = unescape(CCSOL.DOM.x_GetAttribute(theTrigger,tt_title_atr));
			var theText = unescape(CCSOL.DOM.x_GetAttribute(theTrigger,tt_text_atr));
			
			if (theTitle == 'undefined') {
				theTitle = 'info';
			}			
			if (theText == 'undefined') {
				theText = unescape(CCSOL.DOM.x_GetAttribute(theTrigger,'title'));
			}
			$('tt_title').innerHTML = theTitle;
			$('tt_text').innerHTML = theText;	
			//alert ($('tt_text').innerHTML);
			window.status = "[valor] : " + theText;
		}
		
		//creamos el tooltipHandler
		createTheTooltip(tt_ClassName);
		
		var t = new x_ToolTip('div', //will be overriden by the last parameter
							  str_DivThatContainTheInfos,
							  10,
							  10,
							  'theTooltip',
							  theOnDisplay,
							  help_info_class); //if use helpinfo it will override the first parameter
		
	}