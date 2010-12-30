<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vGetAmpliatorio.aspx.cs"
  Inherits="vGetAmpliatorio" %>

<%@ Register Src="ucHeader.ascx" TagName="ucHeader" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
  <title>
    <%= CCSOL.Utiles.Utilidades.GetSystemNameAndVersion() %>
    | Ampliatorios</title>
  <link href="css/layout.css" rel="stylesheet" type="text/css" />

  <script type="text/javascript" src="Scripts/lib/x.js"></script>

  <script type="text/javascript" src="Scripts/lib/x_common.js"></script>

  <script type="text/javascript">
	  CCSOL.Utiles.LoadScript("Scripts/lib/xDropDownMenu.js");
  </script>

</head>
<body>
  <form id="form1" method="post" runat="server">
    <div>
      <table id="Data" border="0" cellpadding="0" cellspacing="0" align="center">
        <tr>
          <td>
            <uc1:ucHeader PageFunctionalityToCheck="AMPLIATORIO_LISTA_VER" ID="UcHeader1" runat="server"
              TabActual="ampliatorios" />
            <div class="DataTop">
              <div class="DataTopLeft">
              </div>
              <div class="DataTopRight">
              </div>
            </div>
            <div class="DataContent" style="margin-bottom: -4px">
              <div class="DataContentRight">
                <div class="PanelEncabezado">
                  <asp:Label ID="solicitudLabel" runat="server" Text="Buscar Inspección" Font-Size="14pt"
                    Font-Names="Arial"></asp:Label>&nbsp;
                </div>
                <div id="frmBusqueda" class="DataTable">
                  <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                      <td style="width: 143px; height: 24px;">
                        Número de Inspección<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                          ErrorMessage="Debe ingresar el numero de Inspección" ControlToValidate="txtNumInspeccion">(*)</asp:RequiredFieldValidator></td>
                      <td style="height: 24px">
                        <asp:TextBox ID="txtNumInspeccion" runat="server" CssClass="FormText" TabIndex="1"
                          Width="136px" Text='<%# Eval("Cliente") %>'></asp:TextBox></td>
                      <td style="width: 130px; height: 24px;">
                        <asp:ImageButton ID="btnBuscar" runat="server" AlternateText="Buscar Solicitudes"
                          CssClass="MakeClear" ImageUrl="~/Images/btnBuscar.gif" OnClick="btnBuscar_Click" />
                      </td>
                      <td style="height: 24px">
                      </td>
                    </tr>
                    <tr>
                      <td style="height: 17px; width: 143px;">
                      </td>
                      <td style="height: 17px" valign="bottom">
                        &nbsp;</td>
                      <td style="height: 17px; width: 130px;">
                      </td>
                      <td style="height: 17px">
                      </td>
                    </tr>
                  </table>
                  &nbsp;
                  <asp:Label ID="lblMensaje" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="12pt"
                    ForeColor="Black" Text="Label" Width="664px"></asp:Label></div>
              </div>
            </div>
            <div class="DataBottom">
              <div class="DataBottomLeft">
              </div>
              <div class="DataBottomRight">
              </div>
            </div>
            <div class="DataContent">
              <div class="DataContentRight">
                &nbsp;
                <br />
              </div>
            </div>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
          </td>
        </tr>
      </table>
    </div>
    &nbsp; &nbsp;&nbsp;<br />
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
      ShowSummary="False" />
    &nbsp;
  </form>
</body>
</html>
