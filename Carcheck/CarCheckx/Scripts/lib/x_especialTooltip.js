// JavaScript Document
//RRRM 06-09-2006

//RRRM 10-12-2006
/*
NOTES:
if you define the className it will override the TagName definition, it means this object will 
use as trigger elements the elements with that ClassName 
in spite of the element with that tagName.
*/

function x_ToolTip(strTagName,    //the tagName for elements that trigger the popup
                   strDivName,    //Div that containts the tags triggers or the elements with the class
                   offsetX,       //offset x to show the tooltip
                   offsetY,       //offset y to show the tooltip
                   strTooltipDiv, //the layer with the Tooltip or content to show when are over an element
                   onDisplay,     //the event that is call when the Tooltip is being showing;
                   className)			//the class name of the elements that trigger the display
{
  var all_links = xGetElementsByTagName(strTagName, $(strDivName));
  var theTooltipDiv;
  var me = this;

  if (className)
    all_links = xGetElementsByClassName(className, $(strDivName));

  try
  {
    theTooltipDiv = $(strTooltipDiv);
  }
  catch (e)
  {
    alert('error no encuentro el Tooltip Div ' + e.message);
  }

  var isBeingDisplay = false;

  //alert (xDef(theTooltipDiv.style.display));
  try
  {

    //alert(theTooltipDiv.style.display);
    theTooltipDiv.style.display = 'none';
  }
  catch (e)
  {
    alert('error : no existe la propiedad display del tooltip. ' + e.message + ' elemento : ' + strTooltipDiv);
  }

  try
  {
    for (var i = 0; i < all_links.length; i++)
    {
      //CCSOL.Utiles.Trace(CCSOL.DOM.x_GetAttribute(all_links[i],'imagenid') + '<br />');
      xAddEventListener(all_links[i], 'mousemove', moveLayer, false);
      xAddEventListener(all_links[i], 'mouseout', hideLayer, false);
    }
  }
  catch (e)
  {
    alert('error en la asignacion de eventos ' + e.message);
  }

  xAddEventListener(window, 'unload', onunload, false);
  /*
  xAddEventListener($(strDivName),'mousemove',moveLayer,false);
  xAddEventListener($(strDivName),'mouseout',hideLayer,false);
  */
  function onunload()
  {
    me.unload();
  }

  this.unload = function()
  {
    try
    {
      for (var i = 0; i < all_links.length; i++)
      {
        //CCSOL.Utiles.Trace(CCSOL.DOM.x_GetAttribute(all_links[i],'imagenid') + '<br />');
        xRemoveEventListener(all_links[i], 'mousemove', moveLayer, false);
        xRemoveEventListener(all_links[i], 'mouseout', hideLayer, false);
      //all_links[i] = null;
      }
    }
    catch (e)
    {
    }

    all_links = null;
  }

  function hideLayer(e)
  {
    try
    {
      theTooltipDiv.style.display = 'none';
      window.status = '';
    }
    catch (e)
    {
      CCSOL.Utiles.TraceError(e);
    }

    isBeingDisplay = false;
  }

  function moveLayer(e)
  {
    var xE = new xEvent(e);

    try
    {
      theTooltipDiv.style.display = 'block';

      if ((onDisplay) && (!isBeingDisplay))
      {
        isBeingDisplay = true;
        var show = onDisplay(e);

        if (xDef(show))
        {
          theTooltipDiv.style.display = (show) ? 'block' : 'none';
          isBeingDisplay = show;
        }
      }
    }
    catch (e)
    {
      CCSOL.Utiles.TraceError(e);
    }

    var posx = (xClientWidth() + xScrollLeft() - (xE.pageX + offsetX + xWidth(theTooltipDiv)) > 0)
            ? xE.pageX + offsetX : xClientWidth() + xScrollLeft() - (offsetX + xWidth(theTooltipDiv));
    var posy = (xClientHeight() + xScrollTop() - (xE.pageY + offsetY + xHeight(theTooltipDiv)) > 0)
            ? xE.pageY + offsetY : xClientHeight() + xScrollTop() - (offsetY + xHeight(theTooltipDiv));
    xMoveTo(theTooltipDiv, posx, posy);
  }
}
