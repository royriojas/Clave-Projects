<%@ Page Language="C#" AutoEventWireup="true" CodeFile="testAutoSuggest.aspx.cs"
  Inherits="test_testAutoSuggest" %>

<%@ Register Assembly="AutoSuggestBox" Namespace="ASB" TagPrefix="cc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
  <title>Untitled Page</title>
  <link href="/asb_includes/AutoSuggestBox.css" rel="stylesheet" type="text/css" />
  <link href="../Scripts/asb_includes/AutoSuggestBox.css" rel="stylesheet" type="text/css" />

  <script type="text/javascript" src="../Scripts/lib/x.js"></script>

  <script type="text/javascript" src="../Scripts/lib/x_common.js"></script>
  <script type="text/javascript">
    function traceValue() {
      alert('here');
      CCSOL.Utiles.Trace('value : ' + $('AutoSuggestBox1').value);
    }
    window.onload = function () {
      xAddEventListener($('AutoSuggestBox1'),'change',traceValue,false);
      xAddEventListener($('Text1'),'change',traceValue,false);
    }
  </script>

</head>
<body>
  <form id="form1" runat="server">
    <div>
      brokers :
      <br />
      <cc1:AutoSuggestBox ID="AutoSuggestBox1" runat="server" Width="556px" DataType="Broker"
        ResourcesDir="../Scripts/asb_includes"></cc1:AutoSuggestBox>&nbsp;<br />
      <br />
      <div id='trace'>
      </div>
      <div>
        <asp:TextBox ID="txtASBTrace" runat="server" Rows="20" TextMode="MultiLine" Width="557px"></asp:TextBox></div>
      <input id="Text1"  type="text" />
    </div>
  </form>
</body>
</html>
