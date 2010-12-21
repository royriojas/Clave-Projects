// JScript File

var __count = 0;
function ___initCollpasibles() {
  if (__count++ == 0) {
    var __xcollapsible = new xCollapsibleSystem('xCollapsible') ;
  }
}

function xCollapsibleSystem(className) {
  var arr = xGetElementsByClassName(className);     
  try {    
    if (arr.length) {
      for (ix = 0; ix < arr.length; ix ++) {
        createCollapsibles(arr[ix]);        
      }
    }
  }
  catch (e) {
    alert('[ xCollapsible ] : ' + e.message);    
  }
  
  function createCollapsibles(ele) {    
          
    var elementToHideId = CCSOL.DOM.x_GetAttribute(ele,'elementToHide');
    if (elementToHideId != ele.id) {
      ele.style.cursor= 'pointer';
      var auxElement = CCSOL.DOM.x_GetAttribute(ele,'auxElement');                    
      var eth_isvisible = CCSOL.DOM.x_GetAttribute(ele,'eth_isvisible');
      
      if (eth_isvisible != null) {
        $(elementToHideId).style.display = (eth_isvisible == 'true')?'block': 'none';        
      }
      
	  if ($(auxElement)) CCSOL.DOM.x_SetAttribute($(auxElement),'elementToHide', elementToHideId);
      
      xAddEventListener(ele, 'click', _doShowHideElementFromEvt,false);
    /*  xAddEventListener(ele, 'mouseover',_doMouseOver ,false);
      xAddEventListener(ele, 'mouseout',_doMouseOut ,false);*/
      
      if (auxElement) { 
        xAddEventListener($(auxElement),'click',_doShowHideElementFromEvt,false);
        $(auxElement).style.cursor= 'pointer';
      }
      
    }
    
  }
  function _doShowHideElementFromEvt(evt) {	 
    var xeve = new xEvent(evt);
    var triggger = xeve.target;
    var elementToHideId = CCSOL.DOM.x_GetAttribute(triggger,'elementToHide');
    //alert(triggger.id);
    if (elementToHideId != null) {
      _doShowHideElement($(elementToHideId));
    }
  }
  function _doShowHideElement(ele) {
    if (ele.style.display == 'none') {
      ele.style.display = 'block';
    }
    else {
      ele.style.display = 'none';
    }
  }
  
  function _doMouseOver(e) {
    var xe = new xEvent(e);
    var img = xe.target;
    
    CCSOL.DOM.MakeClear(img,1);
      
  }
  function _doMouseOut(e) {
    var xe = new xEvent(e);
    var img = xe.target;
    
    CCSOL.DOM.MakeClear(img,0);
      
  }    
  
  
}
if (typeof(domReady) == 'function') {
	domReady(___initCollpasibles);
}
xAddEventListener(window,'load',___initCollpasibles,false);