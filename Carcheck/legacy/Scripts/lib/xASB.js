// JavaScript Document

 function createAnAutoSuggest(controlId,DataType,divMenuId)
  {
    var oJSAutoSuggestBox;
    oJSAutoSuggestBox = new JSAutoSuggestBox();
    oJSAutoSuggestBox.msTextBoxID = controlId;
    oJSAutoSuggestBox.msMenuDivID = divMenuId;
    oJSAutoSuggestBox.msDataType = DataType;
    oJSAutoSuggestBox.mnMaxSuggestChars = 15;
    oJSAutoSuggestBox.mnKeyPressDelay = 300;
    oJSAutoSuggestBox.mnNumMenuItems = 10;
    oJSAutoSuggestBox.mbIncludeMoreMenuItem = false;
    oJSAutoSuggestBox.msMoreMenuItemLabel = '...';
    oJSAutoSuggestBox.msMenuCSSClass = 'asbMenu';
    oJSAutoSuggestBox.msMenuItemCSSClass = 'asbMenuItem';
    oJSAutoSuggestBox.msSelMenuItemCSSClass = 'asbSelMenuItem';
    oJSAutoSuggestBox.mbUseIFrame = true;
    oJSAutoSuggestBox.msResourcesDir = './Scripts/asb_includes';
    oJSAutoSuggestBox.msFilters = '';
    oJSAutoSuggestBox.msNoValueSelectedCSSClass = 'asbNonValueSelected';
    oJSAutoSuggestBox.msWarnNoValueSelected = false;
    oJSAutoSuggestBox.msOnFocusShowAll = true;
    asbAddObj(controlId, oJSAutoSuggestBox);					
	
	  xAddEventListener($(controlId),'blur',OnBlurASBEvent,false);
	  xAddEventListener($(controlId),'keydown',OnKeyDownASBEvent,false);
	  xAddEventListener($(controlId),'keypress',OnKeyPressASBEvent,false);
	  xAddEventListener($(controlId),'keyup',OnKeyUpASBEvent,false);
	  xAddEventListener($(controlId),'focus',OnFocusASBEvent,false);
	
  }
  
  function OnBlurASBEvent(e) {
	  var xe = new xEvent(e);
	  asbGetObj(xe.target.id).OnBlur();
  }
  function OnKeyDownASBEvent(e) {
	  var xe = new xEvent(e);
	  asbGetObj(xe.target.id).OnKeyDown(e);
  }
  function OnKeyPressASBEvent(e) {
    var xe = new xEvent(e);
	  asbGetObj(xe.target.id).OnKeyPress(e);
  }  
  function OnKeyUpASBEvent(e) {
	  var xe = new xEvent(e);
	  asbGetObj(xe.target.id).OnKeyUp(e);
  }
  function OnFocusASBEvent(e) {
    var xe = new xEvent(e);
	  asbGetObj(xe.target.id).OnFocus();
  }
  