// JScript File

function xImageEffect(strCssClass) {
  var xImgs = xGetElementsByClassName(strCssClass);  
  
  for (i = 0; i < xImgs.length; i++) {
    xAddEventListener(xImgs[i],'mouseover',doMouseOver,false);
    xAddEventListener(xImgs[i],'mouseout',doMouseOut,false);    
  }
  
  function doMouseOver(e) {
    var xe = new xEvent(e);
    var img = xe.target;
    
    CCSOL.DOM.MakeClear(img,1);
      
  }
  function doMouseOut(e) {
    var xe = new xEvent(e);
    var img = xe.target;
    
    CCSOL.DOM.MakeClear(img,0);
      
  }    
}

if (typeof(domReady) == 'function') 
{
	domReady(__doWindowLoad);
}
else {
	xAddEventListener(window,'load',__doWindowLoad,false);
}

function __doWindowLoad() {
  var xImgTags = new xImageEffect('MakeClear');
}