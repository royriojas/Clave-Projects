// xPopUp es una variación del original objeto xFenster de la libreria X
// libreria X - www.cross-browser.com
// TODO: especificar que cambios con respecto a xFenster hay aqui
// TODO: añadir el método showPopUpModalDialog()

function xPopUp(elementId, //identificador del elemento creado (para poder crear más de un objeto de este tipo			
				default_url_to_show //the loading url
				) // object prototype
{

 // Public Methods
  this.onunload = function()
  {
    if (xIE4Up) { // clear cir refs
      xDisableDrag(_bar);
      xDisableDrag(rBtn);
      mBtn.onclick = ele.onmousedown = null;
      me = ele = rBtn = mBtn = popup = _bar = null;
	  
    }
  }
  this.paint = function()
  {	 
    myH = xHeight(ele) - (xHeight(_bar) + xHeight(rBtn) + 5);
	  myH = (myH>0)?myH:0;
	  myW = (xWidth(ele));
	  myW = (myW>0)?myW:0; 	
	  xResizeTo(myIfrm,myW,myH);
  }
  this.showPopUpModal = function (url,xw,xh) {
	  xGetElementById('popupMask'+elementId).style.display = "block";
	  winOnResize_d();
	  me.showPopUp(url,xw,xh);
	  disableTabIndexes();
	  // for IE
	  if (gHideSelects == true) {		  
		 hideSelectBoxes();
	  }
		
  }
  this.showPopUp = function (url,xw,xh) {
	 
	  if (xw) {	
	    ele.style.width = xw;
		ele.style.height = xh;
		//xResizeTo(ele,xw,xh);		
		xMoveTo(ele,xScrollLeft()+ (xClientWidth()-xWidth(ele)) / 2 ,xScrollTop() + (xClientHeight()-xHeight(ele)) / 2 ,700);		  	
	  }
	  else {			  	
		 minimize = true;
		 collapse();
	  }
	 try {
		 myIfrm.src = url;
	 }
	 catch(e) {
		 alert(e.message);
	 }	 
	 xShow(ele);
	 me.paint();
  }
  function Hide() {
	  xGetElementById('popupMask'+elementId).style.display = "none";
      minimize = false;	 
	  xHide(ele);	  	  	  
	  myIfrm.src = default_url_to_show;	  
	  restoreTabIndexes();
	  if (gHideSelects == true) {
		displaySelectBoxes();
	  }
  }
  this.hide = function(){
	  Hide();
  }
  // Private Event Listeners
  function barOnDrag(e, mdx, mdy)
  {	
	 var _x = xLeft(ele) + mdx;
	 var _y = xTop(ele) + mdy;
	 
	 if ((_y > 0) && (_x + xWidth(ele) < xClientWidth())) {
	    xMoveTo(ele, xLeft(ele) + mdx, xTop(ele) + mdy);
	 }
  } 
  function resOnDrag(e, mdx, mdy)
  {
     _resOnDrag(mdx,mdy);
  }
  function _resOnDrag(mdx,mdy) 
  {
	  if ((xWidth(ele) >= 100) && (xHeight(ele) >= xHeight(_bar) + xHeight(rBtn) + 3)) {
		xResizeTo(ele, xWidth(ele) + mdx, xHeight(ele) + mdy);
	  }	
    me.paint();
  }
  function fenOnMousedown()
  {
    xZIndex(ele, xPopUp.z++);
  }
  function maxOnClick()
  {
    if (maximized) {
      maximized = false;
      xResizeTo(ele, w, h);
      xMoveTo(ele, x, y);
    }
    else {
      w = xWidth(ele);
      h = xHeight(ele);
      x = xLeft(ele);
      y = xTop(ele);
      xMoveTo(ele, xScrollLeft(), xScrollTop());
      maximized = true;
      xResizeTo(ele, xClientWidth(), xClientHeight());
    }
    me.paint();
  }
  
  function winOnScroll_d() {	
		winOnResize_d()
		var y = xScrollTop();
	  
		y += xClientHeight() - xHeight(ele);
	  
		xSlideTo(ele, 0, y, 700);
		
	
  }
  function winOnResize_d() {
	  	var fullHeight = xClientHeight();
		var fullWidth = xClientWidth();
		
		var theBody = document.documentElement;
		
		var scTop = parseInt(theBody.scrollTop,10);
		var scLeft = parseInt(theBody.scrollLeft,10);
		
		var gPopupMask = xGetElementById('popupMask'+elementId)
		gPopupMask.style.height = fullHeight + "px";
		gPopupMask.style.width = fullWidth + "px";
		gPopupMask.style.top = scTop + "px";
		gPopupMask.style.left = scLeft + "px";
		
		
  }
  
  function collapse() {	
	if (!minimize) {
		xResizeTo(ele,100,xHeight(_bar) + xHeight(rBtn));
		winOnScroll_d();		
	}
	else {
		xResizeTo(ele,640,480);
		var y = xScrollTop()
		xMoveTo(ele,(xClientWidth()-xWidth(ele)) / 2 ,y + (xClientHeight()-xHeight(ele)) / 2 ,700);			
	}
	minimize = !minimize;
	me.paint();
  }
  this.minimizeWindow = function () {
    minimize = false;
    collapse();
  }
  function createElementDiv() {
	var mask = xCreateElement('DIV');
	mask.id = 'popupMask'+elementId;
	mask.style.display = 'none';
	mask.className = 'popupMask';
	xAppendChild(document.body,mask);
	
	var popup = xCreateElement('DIV');
	popup.innerHTML = "<div id='fen"+elementId+"' class='fenster' style='z-index:400;visibility:hidden;'><div id='fenClose"+elementId+"' class='fenClose' title='Cerrar'>&nbsp;</div><div id='fenMaxBtn"+elementId+"' class='fenMaxBtn' title='Click para Maximizar/Restarurar'>&nbsp;</div><div id='btnMinimize"+elementId+"' class='btnMinimize' title='Click para Minimizar'>&nbsp;</div><div id='fenBar"+elementId+"' class='fenBar' title='Arrastre para mover la ventana'><span style='position:relative;font-weight:bold;left:3px;top:3px;'></span></div><div class='fenContent"+elementId+"'><iframe id='myIframe"+elementId+"' style='' frameborder='0' src=''></iframe></div><div class='status'>&nbsp;</div><div id='fenResBtn"+elementId+"' class='fenResBtn' alt='redimensionar'>&nbsp;</div></div>";
	xAppendChild(document.body,popup);

  }
  
  this.winResizeTo = function (w,h) {
  	xResizeTo(ele,w,h);
  }    

  function onunload_d() {
	  me.onunload();
  }



	// Tab key trap. iff popup is shown and key was [TAB], suppress it.
	// @argument e - event - keyboard event that caused this function to be called.
	function keyDownHandler(e) {
		if ((ele.style.display == 'block') && e.keyCode == 9)  return false;
	}
		
	
		// For IE.  Go through predefined tags and disable tabbing into them.
	function disableTabIndexes() {
		if (document.all) {
			var i = 0;
			for (var j = 0; j < gTabbableTags.length; j++) {
				var tagElements = document.getElementsByTagName(gTabbableTags[j]);
				for (var k = 0 ; k < tagElements.length; k++) {
					gTabIndexes[i] = tagElements[k].tabIndex;
					tagElements[k].tabIndex="-1";
					i++;
				}
			}
		}
	}
	
	// For IE. Restore tab-indexes.
	function restoreTabIndexes() {
		if (document.all) {
			var i = 0;
			for (var j = 0; j < gTabbableTags.length; j++) {
				var tagElements = document.getElementsByTagName(gTabbableTags[j]);
				for (var k = 0 ; k < tagElements.length; k++) {
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
	function hideSelectBoxes() {
		/*for(var i = 0; i < document.forms.length; i++) {
			for(var e = 0; e < document.forms[i].length; e++){
				if(document.forms[i].elements[e].tagName == "SELECT") {
					document.forms[i].elements[e].style.visibility="hidden";
				}
			}
		}*/
		var pageSelects = xGetElementsByTagName('SELECT');
		for (var i = 0; i < pageSelects.length; i++) {
			pageSelects[i].style.visibility = "hidden";
		}
	}
	
	/**
	* Makes all drop down form select boxes on the screen visible so they do not reappear after the dialog is closed.
	* IE has a problem with wanted select form tags to always be the topmost z-index or layer
	*/
	function displaySelectBoxes() {
	/*	for(var i = 0; i < document.forms.length; i++) {
			for(var e = 0; e < document.forms[i].length; e++){
				if(document.forms[i].elements[e].tagName == "SELECT") {
				document.forms[i].elements[e].style.visibility="visible";
				}
			}
		}*/
		var pageSelects = xGetElementsByTagName('SELECT');
		for (var i = 0; i < pageSelects.length; i++) {
			pageSelects[i].style.visibility = "visible";
		}
	}

	
	
	var gHideSelects = false;
	var gTabIndexes = new Array();
	// Pre-defined list of tags we want to disable/enable tabbing into
	var gTabbableTags = new Array("A","BUTTON","TEXTAREA","INPUT","IFRAME");	
	
	var brsVersion = parseInt(window.navigator.appVersion.charAt(0), 10);
	if (brsVersion <= 6 && window.navigator.userAgent.indexOf("MSIE") > -1) {
		gHideSelects = true;
	}
	
	
	// If using Mozilla or Firefox, use Tab-key trap.
	if (!document.all) {
		document.onkeypress = keyDownHandler;
	}


	



  var minimize = false;
  var popup;
  createElementDiv();
  // Private Properties
  var me = this;  
  
  var ele = xGetElementById('fen' + elementId);
  var rBtn = xGetElementById('fenResBtn' + elementId);
  var mBtn = xGetElementById('fenMaxBtn' + elementId);
  /*
  	RRRM
  */
  var miniBtn = xGetElementById('btnMinimize' + elementId);
  var myIfrm = xGetElementById('myIframe'  + elementId);
  var btnClose = xGetElementById('fenClose' + elementId);
  
  xAddEventListener(btnClose,'click',Hide,false);
//  btnClose= this.hide();
  
  var _bar = xGetElementById('fenBar'+ elementId);
  
  xAddEventListener(_bar,'dblclick',collapse);
  
  myIfrm.src = (default_url_to_show)?default_url_to_show:null;
  
  
  var x, y, w, h, maximized = false;
  
  x = 100;
  y = 100;
  // Constructor Code
  xPopUp.z = ele.style.zindex;
  xMoveTo(ele, x, y);
  this.paint();
  xEnableDrag(_bar, null, barOnDrag, null);
  xEnableDrag(rBtn, null, resOnDrag, null);
  mBtn.onclick = maxOnClick;
  ele.onmousedown = fenOnMousedown;
  //xShow(ele);
  
  //this.winResizeTo(640,480);
  
  xAddEventListener(miniBtn,'click',collapse,false);
  xAddEventListener(window, 'scroll', winOnScroll_d, false);
  xAddEventListener(window,'resize',winOnResize_d,false);
  xAddEventListener(window,'unload',onunload_d,false);
  xHide(ele);  
  
} // end xFenster object prototype

xPopUp.z = 0; // xFenster static property