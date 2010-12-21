<%@ Page Language="C#" AutoEventWireup="true" CodeFile="webCalendarTest.aspx.cs" Inherits="test_webCalendarTest" %>

<%@ Register Assembly="WebCalendarControl" Namespace="WebCalendarControl" TagPrefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
  <link href="../Scripts/wcc_includes/calendar-blue.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <div style="margin-left:auto;margin-right:auto;width:95%;position:relative;">
    <div style="margin:10px;">    
      <div style="height: 100px; margin-left:215px;">
       <span><cc1:WebCalendar ID="WebCalendar1" runat="server" GenerateBtn="True" WcResourcesDir="../Scripts/wcc_includes"></cc1:WebCalendar>     </span>
      </div>
    </div>
    
    </div>
    </form>
</body>
</html>
