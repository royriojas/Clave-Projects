// JScript File


  var __KeyhandlerArray = null;
  
  function KeyHandler(kc,ele) {
    this.keyCode = kc;
    this.ctrlEle = ele;
  }
  
  function lookForTheKeyPressed(keyCode,e) {
    if (__KeyhandlerArray != null) {    
      for (var ix = 0; ix < __KeyhandlerArray.length; ix++) {
        try {
          if (keyCode == __KeyhandlerArray[ix].keyCode) {                
            __KeyhandlerArray[ix].ctrlEle.click();
            xPreventDefault(e);
            break;
          }        
        }
        catch(e) {
          alert(e.message);
        }
      }
    }
  }
  function __enableShortCuts(e) {
    
    var xe = new xEvent(e);        
    if (e.ctrlKey) {
      lookForTheKeyPressed(e.keyCode,e);
    }    
  }        
  function __initKeyEvents() {
    
    __KeyhandlerArray = new Array();
    var aForm = document;//xGetElementsByTagName('FORM')[0];
    var elementsWithShortCuts = xGetElementsByClassName('SHORTCUT');
    try {
      if (elementsWithShortCuts != null) {
        for (var ix = 0; ix < elementsWithShortCuts.length; ix++) {
          __KeyhandlerArray.push(
            new KeyHandler(
              CCSOL.DOM.x_GetAttribute(elementsWithShortCuts[ix],'keycode'),
              elementsWithShortCuts[ix]
            )
          );          
        }
      }
    }
    catch(e) {
      alert('ERROR : ' + e.message + ' ');
    }
    
    if (aForm != null) {      
      xAddEventListener(aForm,'keypress',__enableShortCuts,true);
    }
  }
  
  if (typeof(domReady) != 'undefined') {
    domReady(__initKeyEvents);
  }
  else {
    xAddEventListener(window,'load',__initKeyEvents, true);
  }