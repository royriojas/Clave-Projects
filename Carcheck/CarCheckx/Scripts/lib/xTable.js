// JavaScript Document

function xTable(theTableId,           //el Identificador de la tabla
                theItemSelectedStyle, //el Style ItemSeleccionado
                theItemOverStyle,     //el Style Over Style
                bIncludeHeader,       //bool debo incluir el header???
                bMakeHeaderFixed      //bool debo hacer que la cabecera se quede fija? 
                )     
{
  var theTRs = xGetElementsByTagName('TR', $(theTableId));
  if (theTRs == null || theTRs.legth == 0) return;
  
  var actualElement = null;
  var lastTR = null;  
  xAddEventListener(theTableId, 'mouseover', doMouseOver, false);
  //xAddEventListener(theTableId, 'mouseout', doMouseOut, false);
  xAddEventListener(theTableId, 'click', doMouseClick, false);

  var ix = 0;
  if (!bIncludeHeader) ix = 1;
  //if (bMakeHeaderFixed) theTRs[0].style.position = 'fixed';
  //para no escoger la cabecera empezamos desde 1 y no desde 0
  for (ix; ix < theTRs.length; ix++)
  {
    theTRs[ix].baseStyle = theTRs[ix].className;
  }
  
  this.doUnload = function () {
	  xRemoveEventListener(theTableId, 'mouseover', doMouseOver, true);
	  //xRemoveEventListener(theTableId, 'mouseout', doMouseOut, true);
	  xRemoveEventListener(theTableId, 'click', doMouseClick, true);	  	
  }
  function findTR(ele)
  {
    var contador = 0;
    var tempEle = ele;

    while ((contador < 5) && (tempEle.tagName.toUpperCase() != 'TR'))
    {
      tempEle = tempEle.parentNode;
      contador++;
    }

    if (tempEle.tagName.toUpperCase() == 'TR')
      return tempEle;

    else
      return null;
  }

  function doMouseOver(e)
  {
    var xe = new xEvent(e);  
    var trElement = findTR(xe.target);
 	
 	  if (lastTR != null) { 	    
 	    if (lastTR != trElement) putOldStyle(lastTR);
 	    else return;
 	  }
 	  lastTR = trElement;
 	  
    if (trElement != null)
    {	  	  	  
      if (!trElement.baseStyle) return;
      if (trElement.baseStyle != 'noMouseOver') {
        if (trElement != actualElement)
          trElement.className = theItemOverStyle;		  
      }
    }
  }

  function doMouseOut(e)
  {
    var xe = new xEvent(e);
	xPreventDefault(e);
	xStopPropagation(e);
    //alert(xe.target.parentNode.tagName);
    //.tagName);
    //alert('fila ' + xe.target.tagName);
    var trElement = findTR(xe.target);
   	
    if (trElement != null)
    { 	       
      if (!trElement.baseStyle) return;
      if (trElement.baseStyle != 'noMouseOver') {
        if (trElement != actualElement)
         trElement.className = trElement.baseStyle;
      }
    }
  }
  
  
  function putOldStyle(trElement) {
    if (trElement != null)
    { 	       
      if (!trElement.baseStyle) return;
      if (trElement.baseStyle != 'noMouseOver') {
        if (trElement != actualElement)
         trElement.className = trElement.baseStyle;
      }
    }
  }
  
  function doMouseClick(e)
  {
    var xe = new xEvent(e);
    //alert(xe.target.parentNode.tagName);
    //.tagName);
    //alert('fila ' + xe.target.tagName);
    var trElement = findTR(xe.target);
    
    if (trElement != null)
    {
      if (!trElement.baseStyle) return;
      trElement.className = theItemSelectedStyle;

      if (actualElement != trElement)
      {
        if (trElement.baseStyle != 'noMouseOver') {
          if (actualElement != null)
            actualElement.className = actualElement.baseStyle;

          actualElement = trElement;
        }
      }
    }
  }
}
