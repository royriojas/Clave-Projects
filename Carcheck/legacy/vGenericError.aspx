<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vGenericError.aspx.cs" Inherits="vGenericError" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
  <title>Carcheck | Error </title>
  <link href="css/layout.css" rel="stylesheet" type="text/css" />
</head>
<body>
  <form id="form1" runat="server">
    <div>
      <table>
        <tr>
          <td style="width: 358px">
            <img alt='' src="Images/bg_ErrorPage.jpg" /></td>
        </tr>
        <tr>
          <td style="height: 163px; width: 358px;padding-left:5px;padding-right:5px;" valign="top">
            <div>
              <div class="DataTop">
                <div class="DataTopLeft">
                </div>
                <div class="DataTopRight">
                </div>
              </div>
              <div class="DataContent">
                <div class="DataContentRight">
                  <div id="aseguradoEncabezado" class="PanelEncabezado">
                    <asp:Label ID="lblTitulo" runat="server" Font-Bold="True" Text="Detalle del Error"></asp:Label>
                  </div>
                  <div class="hr">
                  </div>
                  <div class="DataTable" style="padding: 5px;">
                    <asp:TextBox ID="txtDetalle" runat="server" Height="201px" TextMode="MultiLine" Width="320px"
                      CssClass="FormText"></asp:TextBox>
                  </div>
                  <div class="hr">
                  </div>
                  <input id="btnGoToLogin" type="button" value="Iniciar Sesión" class="FormButton" onclick="document.location.href = 'vLogin.aspx';return false;"/>
                </div>
              </div>
              <div class="DataBottom">
                <div class="DataBottomLeft">
                </div>
                <div class="DataBottomRight">
                </div>
              </div>
            </div>
          </td>
        </tr>
      </table>
    </div>
  </form>
</body>
</html>
