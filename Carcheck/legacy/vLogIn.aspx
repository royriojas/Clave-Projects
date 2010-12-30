<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vLogIn.aspx.cs" Inherits="vLogIn" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
  <title><%= CCSOL.Utiles.Utilidades.GetSystemNameAndVersion() %> | Inicio de Sesión</title>
  <link href="css/layout.css" type="text/css" rel="stylesheet" />
  <link href="Css/code.css" rel="stylesheet" type="text/css" />
</head>
<body>
  <center>
    <form id="form1" runat="server">
      <div class="Data" style="width: 304px">
        <div id="LoginImage">
        </div>
        <div class="DataTop">
          <div class="DataTopLeft">
          </div>
          <div class="DataTopRight">
          </div>
        </div>
        <div class="DataContent">
          <div class="DataContentRight" style="text-align: center">
            <h2>
              Inicio de Sesión</h2>
            <div class="hr">
            </div>
            <table cellspacing="0" cellpadding="1" border="0" style="width: 236px">
              <tr>
                <td style="width: 101px; text-align: left">
                  Usuario<asp:RequiredFieldValidator ID="rfvUserName" runat="server" ControlToValidate="usuarioTextBox"
                    ErrorMessage="Ingrese su Usuario">(*)</asp:RequiredFieldValidator></td>
                <td style="text-align: left">
                  <asp:TextBox ID="usuarioTextBox" runat="server" CssClass="FormText" Style="text-transform: none"></asp:TextBox></td>
              </tr>
              <tr>
                <td style="width: 101px; text-align: left">
                  Contraseña<asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="claveTextBox"
                    ErrorMessage="Ingrese su Contraseña">(*)</asp:RequiredFieldValidator></td>
                <td style="text-align: left">
                  <asp:TextBox ID="claveTextBox" runat="server" CssClass="FormText" TextMode="Password"
                    Style="text-transform: none"></asp:TextBox></td>
              </tr>
              <tr valign="top">
                <td height="25" style="width: 101px; text-align: left">
                  <asp:Button ID="btnIngresar" runat="server" CssClass="FormButton" OnClick="btnIngresar_Click"
                    Text="Ingresar" Width="102px" /></td>
                <td style="text-align: left">
                  <input class="FormButton" id="Reset" style="width: 114px" type="reset" value="Limpiar Campos" /></td>
              </tr>
            </table>
          </div>
        </div>
        <div class="DataBottom">
          <div class="DataBottomLeft">
          </div>
          <div class="DataBottomRight">
          </div>          
        </div>
        <div id="message" style="padding:5px;">
          &nbsp;<asp:Label ID="Label1" runat="server" CssClass="summary" Font-Bold="True" ForeColor="Yellow"
            Text="msg" Visible="False"></asp:Label>
          <asp:ValidationSummary ID="vSummary" runat="server" CssClass="summary" Height="40px" />
          </div>
        </div>
    </form>
  </center>

  <script type="text/javascript">document.getElementById("usuarioTextBox").focus();</script>

</body>
</html>
