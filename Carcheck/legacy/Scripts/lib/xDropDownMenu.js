function xGetAbsolutePos(el)
{
  var SL = 0;
  var ST = 0;
  var is_div = /^div$/i.test(el.tagName);

  if (is_div && el.scrollLeft)
  {
    SL = el.scrollLeft;
  }

  if (is_div && el.scrollTop)
  {
    ST = el.scrollTop;
  }

  var r = { x: el.offsetLeft - SL, y: el.offsetTop - ST };

  if (el.offsetParent)
  {
    var tmp = xGetAbsolutePos(el.offsetParent);
    r.x += tmp.x;
    r.y += tmp.y;
  }

  return r;
}
function xGetBounds(ele)
{
  var offset = xGetAbsolutePos(ele);
  var width = ele.offsetWidth;
  var height = ele.offsetHeight;

  return { left: offset.left, top: offset.top, width: width, height: height
  };
}

/*
        TODO: agregar un tercer parametro que reciba un array asociativo, con los titulos de los menus, 
        y sus respectivas llamadas a funciones o urls to show
        
        var arrMenuItems = xGetElementsByClassName('MenuItem',menu_contextual,null,null);
        for(var i = 0; i < arrMenuItems.length; i++) {			
          
        }
        
str_menu_id 	: id del elemento div que se mostrará como menu dropdown
str_trigger_id  : elemento sobre el cual se debe mostrar el menu, 
                  null = window, es decir se mostraría como un menu contextual en cualquier parte de la ventana.
str_tipo_menu	: tipo de menu a mostrar dropDownMenu o Contextual
                  d = dropDownMenu
                  c = Contextual
str_event_name	: nombre del evento que desencadena la aparicion del menu cuando el tipo es dropDownMenu


*/

function xDropDownMenu(str_menu_id, 
                       str_trigger_id, 
                       str_tipo_menu, 
                       str_event_name, 
                       position, 
                       onDisplay, 
                       onAutoHide,
                       isModalDisplay,
                       cleaningFunction    //Puntero a una función que sirva para limpiar la data si se necesita.
                       )
{
  function keyDownHandler(e)
  {
    if ((me.isBeingDisplayed) && e.keyCode == 9)
      return false;
  }

  // For IE.  Go through predefined tags and disable tabbing into them.
  function disableTabIndexes()
  {
    if (document.all)
    {
      var i = 0;

      for (var j = 0; j < gTabbableTags.length; j++)
      {
        var tagElements = document.getElementsByTagName(gTabbableTags[j]);

        for (var k = 0; k < tagElements.length; k++)
        {
          gTabIndexes[i] = tagElements[k].tabIndex;
          tagElements[k].tabIndex = "-1";
          i++;
        }
      }
    }
  }

  // For IE. Restore tab-indexes.
  function restoreTabIndexes()
  {
    if (document.all)
    {
      var i = 0;

      for (var j = 0; j < gTabbableTags.length; j++)
      {
        var tagElements = document.getElementsByTagName(gTabbableTags[j]);

        for (var k = 0; k < tagElements.length; k++)
        {
          tagElements[k].tabIndex = gTabIndexes[i];
          tagElements[k].tabEnabled = true;
          i++;
        }
      }
    }
  }

  /**
  * Hides all drop down form select boxes on the screen so they do not appear above the mask layer.
  * IE has a problem with wanted select form tags to always be the topmost z-index or layer
  *
  * Thanks for the code Scott!
  */
  function hideSelectBoxes()
  {
    /*for(var i = 0; i < document.forms.length; i++) {
        for(var e = 0; e < document.forms[i].length; e++){
            if(document.forms[i].elements[e].tagName == "SELECT") {
                document.forms[i].elements[e].style.visibility="hidden";
            }
        }
    }*/
    var pageSelects = xGetElementsByTagName('SELECT');

    for (var i = 0; i < pageSelects.length; i++)
    {
      if (!(pageSelects[i].className.indexOf('NOHIDE') > - 1))
      {
        pageSelects[i].style.visibility = "hidden";
      }
    }
  }

  /**
  * Makes all drop down form select boxes on the screen visible so they do not reappear after the dialog is closed.
  * IE has a problem with wanted select form tags to always be the topmost z-index or layer
  */
  function displaySelectBoxes()
  {
    /*	for(var i = 0; i < document.forms.length; i++) {
            for(var e = 0; e < document.forms[i].length; e++){
                if(document.forms[i].elements[e].tagName == "SELECT") {
                document.forms[i].elements[e].style.visibility="visible";
                }
            }
        }*/
    var pageSelects = xGetElementsByTagName('SELECT');

    for (var i = 0; i < pageSelects.length; i++)
    {
      if (!(pageSelects[i].className.indexOf('NOHIDE') > - 1))
      {
        pageSelects[i].style.visibility = "visible";
      }
    }
  }

  var gHideSelects = false;
  var gTabIndexes = new Array();
  // Pre-defined list of tags we want to disable/enable tabbing into
  var gTabbableTags = new Array("A", "BUTTON", "TEXTAREA", "INPUT", "IFRAME");

  var brsVersion = parseInt(window.navigator.appVersion.charAt(0), 10);

  if (brsVersion <= 6 && window.navigator.userAgent.indexOf("MSIE") > - 1)
  {
    gHideSelects = true;
  }

  // If using Mozilla or Firefox, use Tab-key trap.
  if (! document.all)
  {
    document.onkeypress = keyDownHandler;
  }

  /*alert(navigator.userAgent.toLowerCase());*/
  var menu_contextual, trigger_element;
  var doEventBinding = true;
  this.onDisplay = onDisplay;
  this.onAutoHide = onAutoHide;
  this.doShow = true;
  this.doReturn = false;
  this.isBeingDisplayed = false;
  this.isModal = isModalDisplay;

  try
  {
    menu_contextual = $(str_menu_id);
    trigger_element = document;

    if (str_trigger_id != null)
    {
      trigger_element = $(str_trigger_id);
    }
  }
  catch (e)
  {
    alert(e.message);
    doEventBinding = false;
  }

  var me = this;

  function doNothing()
  {
    return false;
  }

  if (doEventBinding)
  {
    menu_contextual.style.display = "none";

    if ((str_tipo_menu != null) && (str_tipo_menu == 'd'))
    {
      if (str_event_name)
      {
        //alert(str_event_name);
        xAddEventListener(trigger_element, str_event_name, showContextMenu, false);
      }

      else
      {
        xAddEventListener(trigger_element, 'mouseover', showContextMenu, false);
      }
    }

    else
    {
      if (str_tipo_menu == 'context')
      {
        trigger_element.onclick = doNothing;
        xAddEventListener(trigger_element, 'click', showMenu, false);
      }

      else
      {
        trigger_element.oncontextmenu = doNothing;
        xAddEventListener(trigger_element, 'contextmenu', showMenu, false);
        xAddEventListener(document, 'click', hideMenu, false);
      }
    }

    xAddEventListener(menu_contextual, 'mouseout', hideMenu, false);
    xAddEventListener(trigger_element, 'mouseout', hideMenu, false);
  }

  function hideMenu(evt)
  {
    CCSOL.Utiles.Trace(CCSOL.Utiles.StringFormat('isBeingDisplayed = {0}', me.isBeingDisplayed));

    if (me.isBeingDisplayed)
    {
      var doIt = true;

      if (typeof (me.onAutoHide) == 'function')
      {
        doIt = me.onAutoHide(evt);
        CCSOL.Utiles.Trace(CCSOL.Utiles.StringFormat('type of onAutoHide == function - onAutoHide = {0}', doIt));
      }

      if (doIt)
      {
        var ev = new xEvent(evt);
        var posx, posy;

        if (! xDef(ev.pageX))
        {
          var pos = xGetAbsolutePosition(trigger_element);
          posx = pos.x;
          posy = pos.y;
        }

        else
        {
          posx = ev.pageX;
          posy = ev.pageY;
        }

        if ((str_event_name != 'click') || (ev.target.id != trigger_element.id))
        {
          if (! xHasPoint(menu_contextual, posx, posy))
          {
            me.hide();
          }
        }
      }
    }
  }

  this.hide = function()
  {
    //hideMenu();
    menu_contextual.style.display = 'none';
    CCSOL.Utiles.Trace(CCSOL.Utiles.StringFormat('isBeingDisplayed is changing = {0}', me.isBeingDisplayed));
    me.isBeingDisplayed = false;
    /*restoreTabIndexes();*/
    if (typeof (cleaningFunction) == 'function') {
        cleaningFunction();
    }
    
    if (me.isModal) {
      CCSOL.DOM.xUnLockBackground();    
    }
    else
    {
      if (gHideSelects == true)
      {
        displaySelectBoxes();
      }
    }
  }

  this.show = function(x, y, evt)
  {
    if (typeof (me.onDisplay) == 'function')
    {
      onDisplay(evt, me);
    }

    if (! me.doShow)
      return me.doReturn;

    //var ev = new xEvent(evt);			
    menu_contextual.style.display = 'block';
    menu_contextual.style.zIndex = '3005'

    if (me.isModal)
      CCSOL.DOM.xLockBackground();

    else
    {
      if (gHideSelects == true)
      {
        hideSelectBoxes();
      }
    }

    var posy = y;

    if (y - xHeight(menu_contextual) > 0)
    {
      posy = y - xHeight(menu_contextual);
    }

    var posx = x;

    if (x - xWidth(menu_contextual) > 0)
    {
      posx = x - xWidth(menu_contextual);
    }

    xMoveTo(menu_contextual, posx, posy);
    me.isBeingDisplayed = true;
    /*
    disableTabIndexes();
       // for IE
    if (gHideSelects == true) {		  
        hideSelectBoxes();
    }*/

    return me.doReturn;
  }

  function showMenu(evt)
  {
    var ev = new xEvent(evt);
    me.show(ev.pageX, ev.pageY, evt)
    return me.doReturn;
  }

  function showContextMenu(evt)
  {
    var ev = new xEvent(evt);
    var pos = xGetAbsolutePos($(ev.target.id));
    var posx = pos.x; //xLeft($(ev.target.id));
    var posy = pos.y; //xTop($(ev.target.id));

    if (xDef(position))
    {
      //alert(position);
      if (position == 'right')
      {
        //alert(menu_contextual);					
        var menuWidth = xWidth(menu_contextual);
        var itemTriggerWidth = xWidth(trigger_element);
        //alert(menuWidth + ' ' + itemTriggerWidth );					
        posx = posx - (menuWidth - itemTriggerWidth);
      //alert(posx);

      }

      if (position == 'dMenuRight')
      {
        var itemTriggerWidth = xWidth(trigger_element);
        //alert(menuWidth + ' ' + itemTriggerWidth );					
        posx = posx + itemTriggerWidth;
      }
    }

    me.show(posx, posy + xHeight($(ev.target.id)), evt);
  }
}
