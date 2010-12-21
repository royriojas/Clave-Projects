<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="test_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
  <title>Untitled Page</title>
  <link href="../Css/layout.css" rel="stylesheet" type="text/css" />
</head>
<body>
  <form id="form1" runat="server">
    <div>
      <div class="DataTop">
        <div class="DataTopLeft">
        </div>
        <div class="DataTopRight">
        </div>
      </div>
      <div class="DataContent">
        <div class="DataContentRight">
          <div class="PanelEncabezado" style="left: 0px; top: 0px">
            <asp:Label ID="solicitudLabel" runat="server" Text="Contacto" Font-Size="14pt" ToolTip="Mostrar / Ocultar Panel"
              Font-Names="Arial"></asp:Label>
            <img id="imgCollapse" alt="Mostrar / Ocultar Panel" src="../Images/IconHide16Dark.gif"
              title="Mostrar/Ocultar" style="margin-top: 3px;" class="MakeClear" />
          </div>
        </div>
      </div>
      <div class="DataBottom">
        <div class="DataBottomLeft">
        </div>
        <div class="DataBottomRight">
        </div>
      </div>
    </div>
  </form>
</body>
</html>
