var pathToScripts = './Scripts';


function $$(name_tag) {
	var arrEle;
	try {
		arrEle = xGetElementsByTagName(name_tag);
	}
	catch (e) {
		arrEle = null;
	}
	return arrEle;
}


//RRRM 15-05-2006
function $(name_ele) {
            var ele;
            try {
                ele = xGetElementById(name_ele);
            }
            catch(e) {
                ele = null;
            }
            return ele;
}

function replaceAll( str, replacements ) {
        for ( i = 0; i < replacements.length; i++ ) {
            var idx = str.indexOf( replacements[i][0] );

            while ( idx > -1 ) {
                str = str.replace( replacements[i][0], replacements[i][1] ); 
                idx = str.indexOf( replacements[i][0] );
            }
        }
        return str;
}

// number formatting function
// copyright Stephen Chapman 24th March 2006
// permission to use this function is granted provided
// that this copyright notice is retained intact
//formatNumber(mynum,2,',','.','£ ','','',' CR') 
//http://javascript.about.com/library/blnumfmt.htm

function formatNumber(num,dec,thou,pnt,curr1,curr2,n1,n2) {
	var x = Math.round(num * Math.pow(10,dec));
	if (x >= 0) n1=n2='';
	var y = (''+Math.abs(x)).split('');
	var z = y.length - dec;y.splice(z, 0, pnt);
	while (z > 3) {
		z-=3; y.splice(z,0,thou);
	}
	var r = curr1+n1+y.join('')+n2+curr2;
	return r;
}


//var string = "{6} 123 Main St {7} Vancouver CA {3}";

//string = replaceAll( string, [["{6}", "#"], [ "{7}", "," ],["{3}", " "]]  );

//alert( string );
    
//añadiendo a la clase String un metodo similar al de C#
//funciona solo en algunos browsers!!!!!!!!!!
String.format = function(s){
		for(var i=1; i<arguments.length; i++){
			//s = s.replace("{" + (i -1) + "}", arguments[i]);
			s = replaceAll(s,[["{"+(i -1)+ "}", arguments[i]]]);
			
		}
		return s;
	};
	
////addNamespaces (para evitar conflictos de nombres en las funciones y clases a crear;
//RRRM
if(!window.addNamespace) {
	window.addNamespace = function(ns) 
	{		
		var nsParts = ns.split(".");
		var root = window;

		for(var i=0; i<nsParts.length; i++) 
		{
			if(typeof root[nsParts[i]] == "undefined") 
				root[nsParts[i]] = {};
			root = root[nsParts[i]];				
		}
	}
}


function ShowReport(Url){

	var WinWidth = 700;
	var WinHeight = 450;
	var Xpos = (screen.width/2) - (WinWidth/2);
	var Ypos = (screen.height/2) - (WinHeight/2);
	//window.open('vInformePDF.aspx?'+Url,'vInformePDF','width=700,height=450,toolbar=no,scrollbars=0,resizable=1,menubar=no,status=yes,directories=no,location=no');
	window.open(Url,'','width='+WinWidth+',height='+WinHeight+', left='+Xpos+', top='+Ypos+',scrollbars=0,resizable=1,menubar=no,status=yes,directories=no,location=no');
}



window.addNamespace("CCSOL.Utiles");
CCSOL.Utiles = {
   ScriptsBeenLoading: 0,
   _javascriptFiles : new Array(),
   Redirect : function (url)
   {
        document.location.href = url;
   },
   RunProgram : function(stProgram,stCommand){ 
		var theProgramaExist;
		var fso;
		var couldRunProgram = false;
		
		try
		{
			fso = new ActiveXObject("Scripting.FileSystemObject");

			if(fso.FileExists("C:/Windows/System32/" + stProgram)){
				theProgramaExist = true;
			}
			if(fso.FileExists("C:/WINNT/System32/" + stProgram)){
				theProgramaExist = true;
			}
			if(fso.FileExists("D:/Windows/System32/" + stProgram)){
				theProgramaExist = true;
			}
			if(fso.FileExists("D:/WINNT/System32/" + stProgram)){
				theProgramaExist = true;
			}
		}
		catch(e)
		{
			alert(e.message);            
			theProgramaExist = false;
		}

		if(theProgramaExist){
			try {
				var shell = new ActiveXObject("WScript.shell");
				shell.run(stProgram + stCommand, 1, true); 
				couldRunProgram = true;
			}
			catch(e) {
				alert('Error al Iniciar la aplicación : ' + e.message);
				couldRunProgram = false;
			}			
		}else{
		  couldRunProgram = false;
		}
		return couldRunProgram;
	}	
   ,    
    RegenerateViewState : function () {
        try {
             __theFormPostData = "";
             __theFormPostData = new Array();
             try {
				 WebForm_InitCallback();
			 }
			 catch(e) {
				 
			 }
         }
         catch(ex) {
            alert("[Error] al regenerar el viewstate para la llamada al callback : " + ex.message);
         }
    },
    
	InitCSS : function () {
					CCSOL.Utiles.LoadCSS(pathToScripts + 'core/xCommon/xCommon.css');
	},
    //Imprime una cadena al estilo C#
    StringFormat : function (s) {
                    for(var i=1; i<arguments.length; i++){
			            //s = s.replace("{" + (i -1) + "}", arguments[i]);
			            s = replaceAll(s,[["{"+(i -1)+ "}", arguments[i]]]);
            			
		            }
		            return s;
    },
    //RRRM funcion a usar dentro de los traces
    TraceError : function (e) {
                      if (!e) return 'no object find';
                      var msg = '';
                      msg += 'Error    : {0},\n';
                      msg += 'Number   : {1}';                                                                                                                             
                      //msg += 'Error : {0}\n,';
                      return CCSOL.Utiles.StringFormat(msg,e.message,e.number);
                 },					
  AlreadyLoaded : function (script) {
    var alreadyLoaded = false;
    for (var ix = 0; ix < CCSOL.Utiles._javascriptFiles.length ; ix++) {
      alreadyLoaded = CCSOL.Utiles._javascriptFiles[ix] == script;
      if (alreadyLoaded) break;
    }
    return alreadyLoaded;
  },
	//RRRM funcion estatica para cargar un script a la página				 
	LoadScript : function (file) {
						// Create script DOM element
						var script = document.createElement('script');
						script.type = 'text/javascript';
						script.src = file;
						
						/*if (CCSOL.Utiles.AlreadyLoaded(file)) return;
						
						CCSOL.Utiles._javascriptFiles.push(file);
						
						CCSOL.Utiles.ScriptsBeenLoading++;*/
					
						// Alert when the script is loaded
						if (typeof(script.onreadystatechange) == 'undefined') // W3C
							script.onload = function(){ 
							 /* if (CCSOL.Utiles.ScriptsBeenLoading > 0) CCSOL.Utiles.ScriptsBeenLoading--;*/
							  this.onload = null; 
							  //alert('Script loaded'); 
						  }
						  else // IE
							  script.onreadystatechange = function(){ 
							    if (this.readyState != 'loaded' && this.readyState != 'complete') return; 							    
							    this.onreadystatechange = null; 
							    /*if (CCSOL.Utiles.ScriptsBeenLoading > 0) CCSOL.Utiles.ScriptsBeenLoading--;*/
							    
								//alert('Script loaded'); 
							}; // Unset onreadystatechange, leaks mem in IE
					
						  // Add script DOM element to document tree
						  document.getElementsByTagName('head')[0].appendChild(script);
				    },
				    
	Trace : function (val,makeApeear) {
	    try {
	      if (makeApeear) {
	        $('trace').style.display = 'block';
	      }
		    $('trace').innerHTML += val + '<br />';
		}
		catch(e) {
		    CCSOL.Utiles.TraceError(e);		    
		}
			},
	ClearTrace : function() {
		try {
		    $('trace').innerHTML ='';
		}
		catch(e) {
		    CCSOL.Utiles.TraceError(e);		    
		}					
	},
	AvoidInstantCache : function () {
		var today = new Date();
		var month = today.getMonth() + 1;
		var day = today.getDate();
		var year = today.getFullYear();
		
		var semilla = month + day +  year + today.getHours() + today.getMinutes() + today.getSeconds();
		
		return semilla;
	},
	
	AvoidCache : function () {
		var today = new Date();
		var month = today.getMonth() + 2;
		var day = today.getDate();
		var year = today.getFullYear();
		var semilla = month + day +  year + today.getHours();
		
		return semilla;
	},
	
	LoadCSS: /*static*/ function (url_, /*optional*/ media_) {

                // We are preventing loading a file already loaded
                var _links = document.getElementsByTagName("link");
                if (_links.length > 0 && _links["href"] == url_) return;

                // Optional parameters check
                var _media = media_ === undefined || media_ === null ? "all" : media_;
               
                var _elstyle = document.createElement("link");
                _elstyle.setAttribute("rel", "stylesheet");
                _elstyle.setAttribute("type", "text/css");
                _elstyle.setAttribute("media", _media);
                _elstyle.setAttribute("href", url_);

                var _head = document.getElementsByTagName("head")[0];
                _head.appendChild(_elstyle);

        },
		
	xGetAbsolutePos : function  (el) {
		var SL = 0;
		var ST = 0;
		var is_div = /^div$/i.test(el.tagName);
		if (is_div && el.scrollLeft) {
			SL = el.scrollLeft;
		}
		if (is_div && el.scrollTop) {
			ST = el.scrollTop;
		}
		var r = { x: el.offsetLeft - SL, y: el.offsetTop - ST };
		if (el.offsetParent) {
			var tmp = CCSOL.Utiles.xGetAbsolutePos(el.offsetParent);
			r.x += tmp.x;
			r.y += tmp.y;
		}
		return r;
	},
	xGetBounds : function(ele) {
		 
			var offset = CCSOL.Utiles.xGetAbsolutePos(ele);
			var width = ele.offsetWidth;
			var height = ele.offsetHeight;
	
			return {left:offset.left, top:offset.top, width:width, height:height};	
	}
	
	


};

window.addNamespace("CCSOL.Cookie");
CCSOL.Cookie = {
	/**
	 * Read the JavaScript cookies tutorial at:
	 *   http://www.netspade.com/articles/javascript/cookies.xml
	 */
	
	/**
	 * Sets a Cookie with the given name and value.
	 *
	 * name       Name of the cookie
	 * value      Value of the cookie
	 * [expires]  Expiration date of the cookie (default: end of current session)
	 * [path]     Path where the cookie is valid (default: path of calling document)
	 * [domain]   Domain where the cookie is valid
	 *              (default: domain of calling document)
	 * [secure]   Boolean value indicating if the cookie transmission requires a
	 *              secure transmission
	 */
	setCookie: function (name, value, expires, path)
				{
					document.cookie= name + "=" + escape(value) +
						((expires) ? "; expires=" + expires.toGMTString() : "") +
						((path) ? "; path=" + path : ""); /*+
						((domain) ? "; domain=" + domain : "") +
						((secure) ? "; secure" : "");*/
				},

	/**
	 * Gets the value of the specified cookie.
	 *
	 * name  Name of the desired cookie.
	 *
	 * Returns a string containing value of specified cookie,
	 *   or null if cookie does not exist.
	 */
	getCookie: function (cookieName)
	{
		/*var dc = document.cookie;
		var prefix = name + "=";
		var begin = dc.indexOf("; " + prefix);
		if (begin == -1)
		{
			begin = dc.indexOf(prefix);
			if (begin != 0) return null;
		}
		else
		{
			begin += 2;
		}
		var end = document.cookie.indexOf(";", begin);
		if (end == -1)
		{
			end = dc.length;
		}
		return unescape(dc.substring(begin + prefix.length, end));*/
		var theCookie=""+document.cookie;
		 var ind=theCookie.indexOf(cookieName);
		 if (ind==-1 || cookieName=="") return ""; 
		 var ind1=theCookie.indexOf(';',ind);
		 if (ind1==-1) ind1=theCookie.length; 
		 return unescape(theCookie.substring(ind+cookieName.length+1,ind1));

	},

	/**
	 * Deletes the specified cookie.
	 *
	 * name      name of the cookie
	 * [path]    path of the cookie (must be same as path used to create cookie)
	 * [domain]  domain of the cookie (must be same as domain used to create cookie)
	 */
	deleteCookie: function (name, path, domain)
	{
		if (CCSOL.Cookie.getCookie(name))
		{
			document.cookie = name + "=" + 
				((path) ? "; path=" + path : "") +
				((domain) ? "; domain=" + domain : "") +
				"; expires=Thu, 01-Jan-70 00:00:01 GMT";
		}
	}

};

window.addNamespace("CCSOL.DOM");

CCSOL.DOM = {
	
   DisableEnterKey: function (evt,prefix) {
		if (!prefix) prefix = 'btn';
		xeve = new xEvent(evt);
		if (xeve.keyCode == 13) {
		    var re = new RegExp('\\b'+prefix+'[a-z]*\\b','i');	            
		    if (xeve.target.id.search(re)!= -1) {
	        	return true;
			}
			else {
			   return false;
			}
	  }
  },
  MakeClear : function(img,flag){
	  if (flag==0){ img.style.filter='alpha(opacity=100,enabled=1)'}
	  else{ img.style.filter='alpha(opacity=75,enabled=1)'}
  },
	/*función obtenida de prototype*/
	GetAbsolutePos : function(el) {
		var SL = 0;
		var ST = 0;
		var is_div = /^div$/i.test(el.tagName);
		if (is_div && el.scrollLeft) {
			SL = el.scrollLeft;
		}
		if (is_div && el.scrollTop) {
			ST = el.scrollTop;
		}
		var r = { x: el.offsetLeft - SL, y: el.offsetTop - ST };
		if (el.offsetParent) {
			var tmp = xGetAbsolutePos(el.offsetParent);
			r.x += tmp.x;
			r.y += tmp.y;
		}
		return r;
	},

	/*función obtenida de prototype*/
	GetBounds : function (ele) {	 
		var offset = xGetAbsolutePos(ele);
		var width = ele.offsetWidth;
		var height = ele.offsetHeight;

		return {left:offset.left, top:offset.top, width:width, height:height};	
	},
	
	x_GetAttribute : function (ele,sAtt) {
	  try  {
		  var a = ele.getAttribute(sAtt);
		  if (!a) {
			  a = ele[sAtt];
		  }
		  return a;
		}
		catch(e) {
		   return '';
		}
	},
	
	x_SetAttribute : function (ele, attribute, value){
		var a = ele.getAttribute(attribute);
		if(a)
			ele.setAttribute(attribute, value);
		else
			ele[attribute] = value;
			
		return a;
	},
	xWindowEventAttached : false,
	xLockBackground : function () {
				
		if ($('__popupMask') == null) {
			var mask = xCreateElement('DIV');
			mask.id = '__popupMask';
			mask.style.display = 'none';
			mask.className = 'xpopupMask';
			xAppendChild(document.body,mask);						
		}
		if (!CCSOL.DOM.xWindowEventAttached) {
			CCSOL.DOM.xWindowEventAttached = true;
			xAddEventListener(window,'scroll',CCSOL.DOM.xLockBackground,false);
			xAddEventListener(window,'resize',CCSOL.DOM.xLockBackground,false);	
		}

		
		var gPopupMask = $('__popupMask');		
		gPopupMask.style.display = "block";

		
		var fullHeight = xClientHeight();
		var fullWidth = xClientWidth();
		
		var theBody = document.documentElement;
		
		var scTop = xScrollTop()//parseInt(theBody.scrollTop,10);
		var scLeft = xScrollLeft()//parseInt(theBody.scrollLeft,10);
		
		gPopupMask.style.height = fullHeight + "px";
		gPopupMask.style.width = fullWidth + "px";
		gPopupMask.style.top = scTop + "px";
		gPopupMask.style.left = scLeft + "px";		
		
		
		xAddEventListener(document,'keypress',CCSOL.DOM.xKeyDownHandler,false);
		if (CCSOL.DOM.xIsIe6()) {
			CCSOL.DOM.xDisableTabIndexes();
			CCSOL.DOM.xHideSelectBoxes();
		}
		
		
	},
	xUnLockBackground : function () {				

		var gPopupMask = $('__popupMask');		
		if (gPopupMask != null) {
			gPopupMask.style.display = "none";						
		}
		if (CCSOL.DOM.xWindowEventAttached) {
			xRemoveEventListener(window,'scroll',CCSOL.DOM.xLockBackground,false);
			xRemoveEventListener(window,'resize',CCSOL.DOM.xLockBackground,false);	
			xRemoveEventListener(document,'keypress',CCSOL.DOM.xKeyDownHandler,false);
			
			if (CCSOL.DOM.xIsIe6()) {
				CCSOL.DOM.xRestoreTabIndexes();
				CCSOL.DOM.xDisplaySelectBoxes();
			}
			CCSOL.DOM.xWindowEventAttached = false;
		}
	},
	xKeyDownHandler: function(e) {
		var ele =  $('__popupMask');
		if (ele != null) {
			if ((ele.style.display == 'block') && e.keyCode == 9)  return false;
		}
	},
	xDisableTabIndexes: function () {
		if (document.all) {
		var i = 0;
		for (var j = 0; j < CCSOL.DOM.xTabbableTags.length; j++) {
			var tagElements = document.getElementsByTagName(CCSOL.DOM.xTabbableTags[j]);
			for (var k = 0 ; k < tagElements.length; k++) {
					CCSOL.DOM.xTabIndexes[i] = tagElements[k].tabIndex;
					tagElements[k].tabIndex="-1";
					i++;
				}
			}
		}
	},
	xRestoreTabIndexes: function () {
		if (document.all) {
			var i = 0;
			for (var j = 0; j < CCSOL.DOM.xTabbableTags.length; j++) {
				var tagElements = document.getElementsByTagName(CCSOL.DOM.xTabbableTags[j]);
				for (var k = 0 ; k < tagElements.length; k++) {
					tagElements[k].tabIndex = CCSOL.DOM.xTabIndexes[i];
					tagElements[k].tabEnabled = true;
					i++;
				}
			}
		}
	},
	xHideSelectBoxes: function () {
		var pageSelects = xGetElementsByTagName('SELECT');
		for (var i = 0; i < pageSelects.length; i++) {
			if (!(pageSelects[i].className.indexOf('NOHIDE') > -1)) {
				//pageSelects[i].style.
				pageSelects[i].style.visibility = "hidden";
			}
		}
	},
	xDisplaySelectBoxes : function() {
		var pageSelects = xGetElementsByTagName('SELECT');						
		for (var i = 0; i < pageSelects.length; i++) {
			if (!(pageSelects[i].className.indexOf('NOHIDE') > -1)) {
				//pageSelects[i].style.display = "block";
				pageSelects[i].style.visibility = "visible";
			}
		}
	},
	xHideSelects : false,
	xTabIndexes : new Array(),
	xTabbableTags : new Array("A","BUTTON","TEXTAREA","INPUT","IFRAME"),
	
	xIsIe6 : function () {
		var brsVersion = parseInt(window.navigator.appVersion.charAt(0), 10);
		if (brsVersion <= 6 && window.navigator.userAgent.indexOf("MSIE") > -1) {
			return true;
		}
		return false;
	},
	xShowLoadingMessage: function (mensaje,top,right,padding,color, fontColor,autoHide, secondsToHide) {	
		if (!mensaje) { 
			mensaje = ':: Procesando ::'; 
		}
		if (!right){
		  right = 20;
		}
		if (!top){
		  top = 20;
		}
		if (!color){
		  color = '#FF0000';
		}
		if (!fontColor) {
			fontColor = '#FFFFFF';
		}
		if(!padding){
		  padding = 5;
		}
		if (!autoHide) {
		  autoHide = false;
		}
		if (!secondsToHide) {
		  secondsToHide = 4;
		}
		if (autoHide) {
		  setTimeout('CCSOL.DOM.xHideLoadingMessage()',secondsToHide * 1000);
		}
		//alert(CCSOL.Utiles.StringFormat('top : {0},  right : {1}, color : {2}, padding : {3}',top,right,color,padding));
	  if ($('xxxdivLoadingMessage') == null) {
	    var divLoadingMessage = xCreateElement('DIV');
	    divLoadingMessage.style.display = 'block';
	    divLoadingMessage.innerHTML = '<div id="xxxdivLoadingMessage" style="position:absolute;right:'+right+'px;top:'+top+'px; background-color:'+color+'; padding:'+padding+'px; font:12px/12px Arial,Verdana; color:#FFFFFF; font-weight:bold; width: auto; height: 15px;">' + mensaje + '</div>';	    
	    xAppendChild(document.body,divLoadingMessage);
	  } else {
	      var aDiv = $('xxxdivLoadingMessage');
        aDiv.innerHTML = mensaje;			    
			  aDiv.style.top = top;
			  aDiv.style.right = right;
			  aDiv.style.padding = padding;
				aDiv.style.color = fontColor;
			  aDiv.style.backgroundColor = color;			    
	      aDiv.style.display = 'block';
	  }
		xTop($('xxxdivLoadingMessage'),xScrollTop() + top);
		
	},
	xHideLoadingMessage: function () {
	    if ($('xxxdivLoadingMessage') != null) $('xxxdivLoadingMessage').style.display = 'none';
	}
	
}	






	



window.addNamespace("CCSOL.Draw");
CCSOL.Draw.ColorRGB = function (R,G,B) {
	if (R) this.R = R;
	if (G) this.G = G;
	if (B) this.B = B;
	me = this;
	this.toHexColorString = function () {
		return  '#'+ CCSOL.MathUtils.ColorHexValue(me.R) + '' + 
				CCSOL.MathUtils.ColorHexValue(me.G) + '' +
				CCSOL.MathUtils.ColorHexValue(me.B) + '';
	}
	this.createFromHex = function (HexValue) {		
		if (HexValue.indexOf('#') > -1) {
			HexValue = HexValue.substring(1);
			if (HexValue.length > 6) {
				alert('el color en hexadecimal no esta correctamente formateado');
			}
			else {
				me.R = CCSOL.MathUtils.ColorDecValue(HexValue.substring(0,2));
				me.G = CCSOL.MathUtils.ColorDecValue(HexValue.substring(2,4));
				me.B = CCSOL.MathUtils.ColorDecValue(HexValue.substring(4,6));
			}
		}
	}
}


/*
http://www.yvg.com/twrs/RGBConverter.html 
copyright 1997 Thomas Gehrke


RRRM HexValue and DecValue was taken from that website, is a cool implementation!!!!!!!!


*/
window.addNamespace("CCSOL.MathUtils");
CCSOL.MathUtils = {		
	//Cadena de valores en base 16
	HexCharacters : "0123456789ABCDEF",
	
	//Take a decimal value and returns a Hex value String like this 'FF'
	ColorHexValue : function (decimal)
			   {
				 return CCSOL.MathUtils.HexCharacters.charAt((decimal>>4)&0xf) + CCSOL.MathUtils.HexCharacters.charAt(decimal&0xf)
			   },
	//Take a Hex Value String and returns it value in decimal format		  
	ColorDecValue : function (hexadecimal)
  			   {
				 return parseInt(hexadecimal.toUpperCase(),16)
			   },			   
	randomFromTo :  function (from,to){ 			 
		if (from > to) {
			alert('the range is not well formed');
			return;
		}
			aleat = Math.random() * (to - from);
			aleat = Math.floor(aleat);
			return parseInt(from) + aleat;
	} 
	,
	

 IsNumeric: function (sText)
{
   var ValidChars = "0123456789.";
   var IsNumber=true;
   var Char;
 
   for (i = 0; i < sText.length && IsNumber == true; i++) 
      { 
      Char = sText.charAt(i); 
      if (ValidChars.indexOf(Char) == -1) 
         {
         IsNumber = false;
         }
      }
   return IsNumber;   
}  

};