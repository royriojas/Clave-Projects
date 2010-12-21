<%@ Page Language="C#" AutoEventWireup="true" CodeFile="mobile.aspx.cs" Inherits="test_mobile" %>
<%@ Register TagPrefix="mobile" Namespace="System.Web.UI.MobileControls" Assembly="System.Web.Mobile" %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<body>
    <mobile:Form id="Form1" runat="server" PagerStyle-PageLabel="Hello">&nbsp;<mobile:List
      ID="List1" Runat="server" Decoration="Bulleted">
    </mobile:List> <mobile:TextBox ID="TextBox1" Runat="server">
    </mobile:TextBox></mobile:Form>
</body>
</html>
