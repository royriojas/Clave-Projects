//============================
//AutoSuggestBox version 1.5.3
//============================


//Global variable and methods that keeps track of all ASB 
//javascript objects on the page
var g_ASBObjects;

function asbAddObj(sTextBoxID, oJSAutoSuggestBox)
{
	if (typeof(g_ASBObjects) == "undefined")
		g_ASBObjects=new Array();
			
	g_ASBObjects[sTextBoxID]=oJSAutoSuggestBox;
}


function asbGetObj(sTextBoxID)
{
	//JSAutoSuggestBox.TRACE("asbGetObj : " + g_ASBObjects[sTextBoxID].msTextBoxID);
	return g_ASBObjects[sTextBoxID];
}


///////////////////////////////////////////////////
//Class that stores all auto suggest box properties
///////////////////////////////////////////////////

function JSAutoSuggestBox()
{	
	//Class properties
	var msTextBoxID;
	var msMenuDivID;
	var msDataType;
	var mnMaxSuggestChars;
	var mnKeyPressDelay;
	var mnNumMenuItems;
	var mbIncludeMoreMenuItem;
	var msMoreMenuItemLabel;
	var msMenuCSSClass;
	var msMenuItemCSSClass;
	var msSelMenuItemCSSClass;
	var mbUseIFrame;
	
	//RRRM
	var msFilters;

	var msResourceDir;
	var mbHasFocus;


	//Internal attributes
	var mnSelMenuItem = 0;	
	var mbCancelSubmit;
	var msOldTextBoxValue="";
	

	//Class methods
	this.GetKey				=GetKey;
	this.GetTextBoxCtrl		=GetTextBoxCtrl;
	this.GetMenuDiv			=GetMenuDiv;
	
	this.GetXmlHttp			=GetXmlHttp;
	this.GetDataFromServer	=GetDataFromServer;
	
	this.SetSelectedValue	=SetSelectedValue;
	this.SetTextBoxValue	=SetTextBoxValue;
	this.GetTextBoxValue	=GetTextBoxValue;
	
    this.OnMouseClick		=OnMouseClick;
	this.OnMouseOver		=OnMouseOver;
 
 	this.OnKeyDown			=OnKeyDown;
	this.OnKeyPress			=OnKeyPress;
	this.OnKeyUp			=OnKeyUp;
    
    this.OnBlur				=OnBlur;
    
    this.GetSelMenuItemDiv	=GetSelMenuItemDiv;
    this.GetMenuItemDivID	=GetMenuItemDivID;
    this.GetMenuItemDiv		=GetMenuItemDiv;
    
    this.MoveUp				=MoveUp;
    this.MoveDown			=MoveDown;
    
    this.SelectMenuItem		=SelectMenuItem;
    this.UnselectMenuItem	=UnselectMenuItem;
    
    this.IsVisibleMenuDiv	=IsVisibleMenuDiv;
	this.MoveMenuDivIfAbsolutePos	=MoveMenuDivIfAbsolutePos;
	this.ShowMenuDiv		=ShowMenuDiv;
	this.HideMenuDiv		=HideMenuDiv;
	
	this.GetSelectedValue  = GetSelectedValue;
		

	//Detects what key was pressed
	function GetKey(evt)
	{
		evt = (evt) ? evt : (window.event) ? event : null;
		if (evt)
		{
			var cCode = (evt.charCode) ? evt.charCode :
					((evt.keyCode) ? evt.keyCode :
					((evt.which) ? evt.which : 0));
			return cCode; 
		}
	}
	
	
	function GetTextBoxCtrl()
	{
		return document.getElementById(this.msTextBoxID);
	}
	
	
	function GetMenuDiv()
	{
		return document.getElementById(this.msMenuDivID);
	}
	
	
	//Create and return XmlHttp object
	function GetXmlHttp()
	{
		var oXmlHttp=false;
		
		// -----> This method was provided from Jim Ley's website 
		/*@cc_on @*/
		/*@if (@_jscript_version >= 5)
		// JScript gives us Conditional compilation, we can cope with old IE versions.
		// and security blocked creation of the objects.
		try {
			oXmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
		} catch (e) {
		try {
			oXmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
		} catch (E) {
			oXmlHttp = false;
		}
		}
		/*@end @*/
	
		if (!oXmlHttp && typeof XMLHttpRequest!='undefined') 
		{
			oXmlHttp = new XMLHttpRequest();
		}
		
		return oXmlHttp;
	}	
	


	
	

  	// Make a call back to our server side page and return the results from our query 
	// to a DIV tag sitting under the text box
	function GetDataFromServer(sValue)
	{
		var sUrl;
		sUrl=this.msResourcesDir + 
				"/GetAutoSuggestData.aspx?TextBoxID=" + encodeURIComponent(this.msTextBoxID) + 
										"&MenuDivID=" + encodeURIComponent(this.msMenuDivID) + 
										"&DataType=" + encodeURIComponent(this.msDataType) + 
										"&NumMenuItems=" + this.mnNumMenuItems + 
										"&IncludeMoreMenuItem=" + this.mbIncludeMoreMenuItem + 
										"&MoreMenuItemLabel=" + encodeURIComponent(this.msMoreMenuItemLabel) + 
										"&MenuItemCSSClass=" + encodeURIComponent(this.msMenuItemCSSClass) + 
										"&Keyword=" + encodeURIComponent(sValue) + 		
																																						
										"&Filters=" + encodeURIComponent(this.msFilters) + 
										"&WarnNoValueSelected=" + encodeURIComponent(this.msWarnNoValueSelected) + 
										"&NoValueSelectedCSSClass=" + encodeURIComponent(this.msNoValueSelectedCSSClass) +
										"&OnFocusShowAll=" + encodeURIComponent(this.msOnFocusShowAll);										
										//RRRM 13-08-2006
				
		TRACE("GetDataFromServer: " + sUrl);
	
		var oXmlHttp=GetXmlHttp();
		oXmlHttp.open("GET", sUrl, true);
		
		var me=this;	//Use it to be able to access ShowMenuDiv and HideMenuDiv in the function()
		oXmlHttp.onreadystatechange=function()
		{
			if (oXmlHttp.readyState==4) 
			{
				if (oXmlHttp.responseText!="")
				{
					if (me.mbHasFocus)
					{
						me.ShowMenuDiv(oXmlHttp.responseText);
					}
				}				
				else
				{	
					me.HideMenuDiv()
				}
			}
		}
		
		oXmlHttp.send(null)
	}


	
	function SetSelectedValue(sValue)
	{
		TRACE("SetSelectedValue: " + sValue);
	
		var hdnSelectedValue=document.getElementById(this.msTextBoxID + "_SelectedValue");
		hdnSelectedValue.value=sValue;
	}

    function GetSelectedValue() {
		var hdnSelectedValue=document.getElementById(this.msTextBoxID + "_SelectedValue");
		return hdnSelectedValue.value;
	}

	function SetTextBoxValue()
	{
		var divMenuItem=this.GetSelMenuItemDiv();
			
		if(divMenuItem)
		{
			var sValue=divMenuItem.getAttribute('value');
			TRACE("SetTextBoxValue : Set selected item to " + sValue);
		
			//Set selected value of control to the value of selected menu item
			this.SetSelectedValue(sValue);
				
			var txtCtrl=this.GetTextBoxCtrl();
			txtCtrl.value = GetInnerHtml(divMenuItem);
		}
	}


	function GetTextBoxValue()
	{
		var txtCtrl=this.GetTextBoxCtrl();
		return(txtCtrl.value);
	}
	
	
				
	function OnMouseClick(nMenuIndex)
	{
		this.mnSelMenuItem=nMenuIndex;
	
		this.SetTextBoxValue();
		this.HideMenuDiv();
	}
	


	function OnMouseOver(nMenuIndex)
	{
		this.SelectMenuItem(nMenuIndex);
	}
	
	
		
	function OnKeyDown(evt)
	{
		TRACE("OnKeyDown : " + this.GetKey(evt) + ", " + this.msTextBoxID);
	
		//Indicate that control has focus
		this.mbHasFocus=true;
		
		//Save current text box value before key press takes affect
		this.msOldTextBoxValue=this.GetTextBoxValue();
		TRACE("OnKeyDown : old text box value='" + this.msOldTextBoxValue + "'");
		
		var nKey;
		nKey=this.GetKey(evt);
				
		TRACE("OnKeyDown : Key is " + nKey);
				
		//Detect if the user is using the down button
		if(nKey==38) //Up arrow
		{
			this.MoveDown()
		}
		else if(nKey==40) //Down arrow
		{
			this.MoveUp()
		}
		else if(nKey==13) //Enter
		{
			TRACE("OnKeyDown : IsVisibleMenuDiv - " + this.IsVisibleMenuDiv());
			if (this.IsVisibleMenuDiv())
			{
				this.HideMenuDiv();
				
				evt.cancelBubble = true;
				
				if (evt.returnValue) evt.returnValue = false;
				if (evt.stopPropagation) evt.stopPropagation();
				
				this.mbCancelSubmit=true;
     		}
     		else
     		{
     			this.mbCancelSubmit=false;
     		}
		}
		else
		{
			this.HideMenuDiv();
		}
				
		return true;
	}
	
	
	function OnKeyPress(evt)
	{
		TRACE("OnKeyPress : " + this.GetKey(evt));
		if ((this.GetKey(evt)==13) && (this.mbCancelSubmit)) 
		{
			return false;
		}
			
		return true;
	}
	
	this.doRequest = function(sNewValue) {
	    if (sNewValue == "")
		{
			TRACE("DoRequest : Getting data for '" + sNewValue + "'");
					
			var divMenu = this.GetMenuDiv();
			if (divMenu.timer) window.clearTimeout(divMenu.timer);
			
			//Add escape char to single quote
			sNewValue=sNewValue.replace(/\'/, "\\\'");
				
			//Set timer to update div.  If user types quickly return suggestions when he stops.  
			var sFunc="asbGetObj('" + this.msTextBoxID + "').GetDataFromServer('" + sNewValue + "')";
			TRACE("DoRequest : " + sFunc);
							
			divMenu.timer = window.setTimeout(sFunc, this.mnKeyPressDelay);
		}								
	}
	
	//RRRM
	this.OnFocus = function() {
		if (this.msOnFocusShowAll) {
			this.mbHasFocus = true;
			var sNewValue;
			sNewValue=this.GetTextBoxValue();
				
			//alert(sNewValue == "");
			//si ha recibido el foco y el texto es ""
			this.doRequest(sNewValue);
		}
		
	}
	
	
	function OnKeyUp(evt)
	{
		var nKey;
		nKey=this.GetKey(evt);
		
		TRACE("OnKeyUp : " + nKey);
		
		
		//Skip up/down/enter
		if ((nKey!=38) && (nKey!=40) && (nKey!=13))
		{
			var sNewValue;
			sNewValue=this.GetTextBoxValue();
			
			if ((this.msOnFocusShowAll) && (sNewValue == '')) {
			    this.doRequest(sNewValue);
			}
			else {						
			//Limit num of characters to display suggestions	
			    if ((sNewValue.length <= this.mnMaxSuggestChars) && (sNewValue.length > 0))
			    {
				    TRACE("OnKeyUp : Getting data for '" + sNewValue + "'");
    				
				    var divMenu = this.GetMenuDiv();
				    if (divMenu.timer) window.clearTimeout(divMenu.timer);
    				
				    //Add escape char to single quote
				    sNewValue=sNewValue.replace(/\'/, "\\\'");
    				
				    //Set timer to update div.  If user types quickly return suggestions when he stops.  
				    var sFunc="asbGetObj('" + this.msTextBoxID + "').GetDataFromServer('" + sNewValue + "')";
				    TRACE("OnKeyUp : " + sFunc);
    							
				    divMenu.timer = window.setTimeout(sFunc, this.mnKeyPressDelay);
			    }
    		
    		
			    if (this.msOldTextBoxValue!=sNewValue)
			    {
				    this.SetSelectedValue("");
			    }
			}
		}
	}
		
	
	function OnBlur()
	{
		TRACE("OnBlur");
	
		this.HideMenuDiv();
		this.mbHasFocus=false;
		
		if (this.msWarnNoValueSelected) {
		    this.OnNoValueSelected();
		}
	}
	
	this.OnNoValueSelected = function() {
	    if ((this.GetTextBoxValue() !='') && (this.GetSelectedValue() == '')) {
			this.GetTextBoxCtrl().className = this.replaceAll(this.GetTextBoxCtrl().className,[[' '+this.msNoValueSelectedCSSClass,'']]);
			this.GetTextBoxCtrl().className += ' '+this.msNoValueSelectedCSSClass; ;
		}
		else {
			this.GetTextBoxCtrl().className = this.replaceAll(this.GetTextBoxCtrl().className,[[' '+this.msNoValueSelectedCSSClass,'']]);
		}
	}
	
	this.replaceAll = function ( str, replacements ) {
        for ( i = 0; i < replacements.length; i++ ) {
            var idx = str.indexOf( replacements[i][0] );

            while ( idx > -1 ) {
                str = str.replace( replacements[i][0], replacements[i][1] ); 
                idx = str.indexOf( replacements[i][0] );
            }
        }
        return str;
}
	
	
		
	function GetSelMenuItemDiv()
	{
		return this.GetMenuItemDiv(this.mnSelMenuItem);
	}
			
			
	function GetMenuItemDivID(nMenuItem)
	{
		return (this.msTextBoxID + "_mi_" + nMenuItem);
	}
	
		
	function GetMenuItemDiv(nMenuItem)
	{
		var sDivMenuItemID=this.GetMenuItemDivID(nMenuItem);
		return document.getElementById(sDivMenuItemID)
	}
		

	function MoveUp()
	{
		var nMenuItem;
		nMenuItem=this.mnSelMenuItem+1;
		
		//Check if menu item exists
		if(this.GetMenuItemDiv(nMenuItem))
		{
			this.SelectMenuItem(nMenuItem)
		}
	}


	function MoveDown()
	{
		var nMenuItem;
		nMenuItem=this.mnSelMenuItem-1;
		
		if(nMenuItem!=0)
		{
			this.SelectMenuItem(nMenuItem)
		}
	}


	//Highlights a div
	function SelectMenuItem(nMenuItem)
	{
		var divMenuItem=this.GetMenuItemDiv(nMenuItem)
					
		if(divMenuItem)
		{
			if (nMenuItem!=this.mnSelMenuItem)
			{
				this.UnselectMenuItem();
				
				this.mnSelMenuItem=nMenuItem;
				this.SetTextBoxValue();
						
				divMenuItem.className=this.msSelMenuItemCSSClass;
			}
		}
	}


	//unhighlights a div
	function UnselectMenuItem()
	{
		var divMenuItem=this.GetSelMenuItemDiv()
	
		if(divMenuItem)
		{
			divMenuItem.className=this.msMenuItemCSSClass;
		}
	}


	
	function IsVisibleMenuDiv()
	{
		if (this.GetMenuDiv().style.visibility == 'hidden')
		{
			return false;
		}
		else
		{
			return true;
		}
	}
	
	
	
	function MoveMenuDivIfAbsolutePos()
	{
		var txtCtrl=this.GetTextBoxCtrl();
		var divMenu=this.GetMenuDiv();
				
		if (txtCtrl.style.position!="absolute")
			return;
			
		TRACE("MoveMenuDivIfAbsolutePos Moving absolute");
		
		
		//Move menu right under text box
		divMenu.style.left	=txtCtrl.offsetLeft;
		divMenu.style.top	=txtCtrl.offsetTop + txtCtrl.offsetHeight;
	}
	
	
	
	function ShowMenuDiv(sDivContent)
	{
		this.MoveMenuDivIfAbsolutePos();
		
		TRACE("ShowMenuDiv : " + this.msTextBoxID);
	
		var divMenu=this.GetMenuDiv();
		var sInnerHtml;

		//Use IFrame of the same size as div		
		if (IsIE() && this.mbUseIFrame) 
		{
			sInnerHtml = "<div id='" + this.msMenuDivID + "_content'>";
			sInnerHtml += sDivContent;
			sInnerHtml += "</div>";
			
			var sBlankPage=this.msResourcesDir + "/Blank.html";	//Use blank page to hide 'nonsecure items' message in IE when using HTTPS
			sInnerHtml += "<iframe id='" + this.msMenuDivID + "_iframe' src='" + sBlankPage  + "' frameborder='1' scrolling='no'></iframe>";
		}
		else
		{
			sInnerHtml=sDivContent;
		}
		
		
		divMenu.innerHTML = sInnerHtml;
		
		
		if (IsIE() && this.mbUseIFrame) 
		{
			var divContent;
			divContent=document.getElementById(this.msMenuDivID + "_content");
			
			var divIframe;
			divIframe=document.getElementById(this.msMenuDivID + "_iframe");
					
			//Remember display type
			divContent.className=this.msMenuCSSClass;
			divMenu.className="asbMenuBase";
				
			divIframe.style.width = divContent.offsetWidth + 'px';
			divIframe.style.height = divContent.offsetHeight + 'px';
			divIframe.marginTop = "-" + divContent.offsetHeight + 'px';

		}	
		
		divMenu.style.visibility = 'visible';
	}
	

				
	function HideMenuDiv()
	{
		this.GetMenuDiv().style.visibility = 'hidden';
		this.mnSelMenuItem=0;
	}
	
	
	//Utility functions	(don't need this.)
	function IsIE()
	{
		return ( navigator.appName=="Microsoft Internet Explorer" ); 
	}
	

	function IsNav()
	{
		return ( navigator.appName=="Netscape" );
	}
	
	
	function GetInnerHtml(oItem)
	{
		var sOut;
		if (oItem.innerText)
		{
			sOut=oItem.innerText;   // IE
		}
		else if (oItem.textContent)
		{
			sOut=oItem.textContent; // Mozilla
		}
		return (sOut);
	} 


	function TRACE(sText)
	{
		var txtTrace=document.getElementById("txtASBTrace");
		if (txtTrace!=null)
			txtTrace.value = txtTrace.value + sText + "\n";
	}
}
