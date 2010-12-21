// xTabPanelGroup, Copyright 2005-2006 Michael Foster (Cross-Browser.com)
// Part of X, a Cross-Browser Javascript Library, Distributed under the terms of the GNU LGPL

function xTabPanelGroup(id, w, h, th, clsTP, clsTG, clsTD, clsTS) // object prototype
{
  // Private Methods

  function onClick() //r7
  {
    paint(this);
    return false;
  }
  function onFocus() //r7
  {
    paint(this);
  }
  function paint(tab)
  {
    tab.className = clsTS;
    xZIndex(tab, highZ++);
    xDisplay(panels[tab.xTabIndex], 'block'); //r6
    if (selectedIndex != tab.xTabIndex) {
      xDisplay(panels[selectedIndex], 'none'); //r6
      tabs[selectedIndex].className = clsTD;
      selectedIndex = tab.xTabIndex;
    }
  }

  // Private Properties

  var panelGrp, tabGrp, panels, tabs, highZ, selectedIndex;
  
  // Public Methods

  this.select = function(n) //r7
  {
    if (n && n <= tabs.length) {
      var t = tabs[n-1];
      if (t.focus) t.focus();
      else t.onclick();
    }
  };
  this.onUnload = function()
  {
    if (xIE4Up) for (var i = 0; i < tabs.length; ++i) {tabs[i].onfocus = tabs[i].onclick = null;}
  };
  this.onResize = function(newW, newH) //r9
  {
    var x = 0, i;
    // [r9
    if (newW) {
      w = newW;
      xWidth(panelGrp, w);
    }
    else w = xWidth(panelGrp);
    if (newH) {
      h = newH;
      xHeight(panelGrp, h);
    }
    else h = xHeight(panelGrp);
    // r9]
    xResizeTo(tabGrp[0], w, th);
    xMoveTo(tabGrp[0], 0, 0);
    w -= 2; // remove border widths
    var tw = w / tabs.length;
    for (i = 0; i < tabs.length; ++i) {
      xResizeTo(tabs[i], tw, th); 
      xMoveTo(tabs[i], x, 0);
      x += tw;
      tabs[i].xTabIndex = i;
      tabs[i].onclick = onClick;
      tabs[i].onfocus = onFocus; //r7
      xDisplay(panels[i], 'none'); //r6
      xResizeTo(panels[i], w, h - th - 2); // -2 removes border widths
      xMoveTo(panels[i], 0, th);
    }
    highZ = i;
    tabs[selectedIndex].onclick(); //r9
  };

  // Constructor Code

  panelGrp = xGetElementById(id);
  if (!panelGrp) { return null; }
  panels = xGetElementsByClassName(clsTP, panelGrp);
  tabs = xGetElementsByClassName(clsTD, panelGrp);
  tabGrp = xGetElementsByClassName(clsTG, panelGrp);
  if (!panels || !tabs || !tabGrp || panels.length != tabs.length || tabGrp.length != 1) { return null; }
  selectedIndex = 0;
  this.onResize(w, h); //r9
}
