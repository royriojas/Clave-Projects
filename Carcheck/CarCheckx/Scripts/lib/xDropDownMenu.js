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
/*
function xCreateDropDown(params) {
  function param_default(pname, def) { if (typeof params[pname] == "undefined") { params[pname] = def; } };
    
  param_default("str_menu_id",     null);
	param_default("str_trigger_id",    null);
	
    
}*/


function xDropDownMenu(str_menu_id,      //Id del Div que se mostrará al ejecutar algun evento sobre el trigger element
                       str_trigger_id,   //elemento que desencadena la aparición del div.
                       str_tipo_menu,    //d = DropDown, context = contextual, en el punto de click;
                       str_event_name,   //evento sobre el trigger
                       position,         //posición relativa al trigger donde se quiere hacer aparecer al elemento.
                       onDisplay,        //funcion que se ejecuta antes de mostrar el Div
                       onAutoHide,       //funcion que debe devolver la decisión de cerrar o mantener visible el Div cuando este pierde el foco.
                       isModalDisplay,   //debe bloquearse el fondo???? true o false
                       cleaningFunction, //Puntero a una función que sirva para limpiar la data si se necesita.
                       HidingFunction,   //funcion que se ejecuta al ocultar el Div 
                       UseEnterToClose,  //al presionar enter se debe ocultar el Div???
                       OnShownFunction   //funcion que se ejecuta luego que el div ha sido mostrado.
  )
{
  function keyDownHandler(e)
  {
    if ((me.isBeingDisplayed) && e.keyCode == 9)
      return false;
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
  this.hidingFunction = HidingFunction;
  this.useEnterToClose = UseEnterToClose;
  this.onShownFunction = OnShownFunction;

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

  function doNothing(e)
  {    
    //xPreventDefault(e);
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

    xAddEventListener(menu_contextual, 'keydown', _evalHide, false);
    xAddEventListener(trigger_element, 'keydown', _evalHide, false);
  }

  function _evalHide(evt)
  {
    var xe = new xEvent(evt);

    if (xe.keyCode == 27)
    {
      if (typeof (me.hidingFunction) == 'function')
      {
        me.hidingFunction(evt, me);
      }

      me.hide();
    }

    if (me.useEnterToClose && (xe.keyCode == 13 || xe.keyCode == 9))
    {
      if (typeof (me.hidingFunction) == 'function')
      {
        me.hidingFunction(evt, me);
      }

      me.hide();
    }
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

        if (!xDef(ev.pageX))
        {
          var pos = CCSOL.Utiles.xGetAbsolutePosition(trigger_element);
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
          if (!xHasPoint(menu_contextual, posx, posy))
          {
            if (typeof (me.hidingFunction) == 'function')
            {
              me.hidingFunction(evt, me);
            }

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
    if (typeof (cleaningFunction) == 'function')
    {
      cleaningFunction();
    }

    if (me.isModal)
      CCSOL.DOM.xUnLockBackground();
  }

  this.show = function(x, y, evt)
  {
    if (typeof (me.onDisplay) == 'function')
    {
      onDisplay(evt, me);
    }
  
    
    if (!me.doShow) {
      if (!me.doReturn) xPreventDefault(evt);  
      return me.doReturn;
    }

    //var ev = new xEvent(evt);			
    menu_contextual.style.display = 'block';
    menu_contextual.style.zIndex = '3005'

    if (me.isModal)
      CCSOL.DOM.xLockBackground();

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

    if (typeof (me.onShownFunction) == 'function')
    {
      me.onShownFunction(evt, me);
    }   
    
    if (!me.doReturn) xPreventDefault(evt);
    return me.doReturn;
  }

  function showMenu(evt)
  {
    var ev = new xEvent(evt);       
    return me.show(ev.pageX, ev.pageY, evt)   
  }

  function showContextMenu(evt)
  {
    var ev = new xEvent(evt);
    var pos = CCSOL.Utiles.xGetAbsolutePos($(ev.target.id));
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
