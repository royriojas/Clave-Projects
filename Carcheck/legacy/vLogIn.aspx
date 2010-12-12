<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vLogIn.aspx.cs" Inherits="vLogIn" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
  <title>CarCheck / Inicio de Sesión</title>
  <link href="css/layout.css" type="text/css" rel="stylesheet" />
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
            <table cellspacing="0" cellpadding="1" width="220" border="0">
              <tr>
                <td width="90">
                  Usuario</td>
                <td style="text-align: right">
                  <asp:TextBox ID="usuarioTextBox" runat="server" CssClass="FormText" Style="text-transform: none"></asp:TextBox></td>
              </tr>
              <tr>
                <td>
                  Contraseña</td>
                <td style="text-align: right">
                  <asp:TextBox ID="claveTextBox" runat="server" CssClass="FormText" TextMode="Password"
                    Style="text-transform: none"></asp:TextBox></td>
              </tr>
              <tr valign="top">
                <td height="25">
                  <asp:Button ID="Submit" runat="server" CssClass="FormButton" Text="Ingresar" Width="90"
                    OnClick="Submit_Click"></asp:Button></td>
                <td style="text-align: right">
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
        &nbsp;
        <asp:Label ID="resultadoLabel" runat="server" Width="304px" Visible="False" Font-Bold="True"
          Font-Size="11px" ForeColor="#FFCC00">Su usuario y/o Contraseña no son válidos</asp:Label>
        <asp:RequiredFieldValidator ID="FRVstuserpassword" Style="text-align: center" runat="server"
          Width="304px" ForeColor="#FFCC00" Display="None" ErrorMessage="Ingrese su Contraseña"
          ControlToValidate="claveTextBox" Font-Size="12px">Ingrese su Contraseña</asp:RequiredFieldValidator>
        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
          ShowSummary="False" />
        <asp:RequiredFieldValidator ID="RFVstusername" Style="text-align: center" runat="server"
          Width="304px" ForeColor="#FFCC00" Display="None" ErrorMessage="Ingrese su Nombre de Usuario"
          ControlToValidate="usuarioTextBox">Ingrese su Nombre de Usuario</asp:RequiredFieldValidator></div>
    </form>
  </center>

  <script type="text/javascript">document.getElementById("usuarioTextBox").focus();</script>

</body>
</html>
