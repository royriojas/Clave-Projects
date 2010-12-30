<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vTempDesign.aspx.cs" Inherits="vTempDesign" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
  <title>Interfaces CarCheck</title>
  <link href="Css/layout.css" rel="stylesheet" type="text/css" />
</head>
<body>
  <form id="form1" runat="server">
    <!-- Interfaz de Anulación de Inspección -->
    <div id="popUpForm" class="popUpForm" style="padding: 2px; width: 250px; text-align: left;
      display: block; position: fixed">
      <table border="0" cellpadding="0" cellspacing="0" class="DataTable">
        <tr>
          <td align="left" style="font-weight: bold">
            Motivo</td>
        </tr>
        <tr>
          <td align="left">
            <asp:DropDownList ID="DropDownList1" runat="server" CssClass="FormText" Width="244px">
              <asp:ListItem></asp:ListItem>
              <asp:ListItem>DESISTIMIENTO DEL SOLICITANTE</asp:ListItem>
              <asp:ListItem>MAXIMO DE FRUSTRACIONES</asp:ListItem>
            </asp:DropDownList></td>
        </tr>
        <tr>
          <td align="left" style="height: 18px; font-weight: bold;" valign="bottom">
            Observación</td>
        </tr>
        <tr>
          <td align="left">
            <asp:TextBox ID="descripcionTextBox" runat="server" CssClass="FormText" Rows="6"
              TextMode="MultiLine" Width="240px"></asp:TextBox></td>
        </tr>
        <tr>
          <td align="right" style="height: 20px">
            <input runat="server" id="guardarButton" class="FormButton" style="width: 130px"
              type="button" value="Anular Inspección" />
            <input id="cancelarButton" class="FormButton" type="button" value="Cancelar" />
          </td>
        </tr>
      </table>
    </div>
    <br />
    <!-- Interfaz de Frustración de Inspección -->
    <div id="Div1" class="popUpForm" style="padding: 2px; width: 250px; text-align: left;
      display: block; position: fixed">
      <table border="0" cellpadding="0" cellspacing="0" class="DataTable">
        <tr>
          <td align="left" style="font-weight: bold">
            Motivo</td>
        </tr>
        <tr>
          <td align="left">
            <asp:DropDownList ID="DropDownList2" runat="server" CssClass="FormText" Width="244px">
              <asp:ListItem></asp:ListItem>
              <asp:ListItem>POR REPROGRAMACION</asp:ListItem>
              <asp:ListItem Value="NO ATENDIERON LA VisITA">NO ATENDIERON LA VISITA</asp:ListItem>
            </asp:DropDownList></td>
        </tr>
        <tr>
          <td align="left" style="height: 18px; font-weight: bold;" valign="bottom">
            Observación</td>
        </tr>
        <tr>
          <td align="left">
            <asp:TextBox ID="TextBox1" runat="server" CssClass="FormText" Rows="6" TextMode="MultiLine"
              Width="240px"></asp:TextBox></td>
        </tr>
        <tr>
          <td align="right" style="padding-top: 2px;">
            <input runat="server" id="Button1" class="FormButton" style="width: 130px" type="button"
              value="Frustrar Inspección" />
            <input id="Button2" class="FormButton" type="button" value="Cancelar" />
          </td>
        </tr>
      </table>
    </div>
    <br />
    <!-- Interfaz de Reprogramación de Inspección -->
    <div id="Div2" class="popUpForm" style="padding: 2px; text-align: left; width: 380px;
      display: block; position: fixed">
      <table border="0" cellpadding="0" cellspacing="0" class="DataTable">
        <tr>
          <td style="width: 115px">
            Fecha Inspección<asp:RequiredFieldValidator ID="finspeccionRFV" runat="server" ControlToValidate="finspeccionTextBox"
              CssClass="DataValidator" Display="Dynamic" Enabled="false" ErrorMessage="Ingrese la fecha de la inspección"
              Font-Bold="True">(*)</asp:RequiredFieldValidator><asp:RequiredFieldValidator ID="horaInicioRFV"
                runat="server" ControlToValidate="horaInicioTextBox" CssClass="DataValidator" Display="Dynamic"
                Enabled="false" ErrorMessage="Ingrese la hora de inicio de inspección" Font-Bold="True">(*)</asp:RequiredFieldValidator><asp:RequiredFieldValidator
                  ID="horaFinRFV" runat="server" ControlToValidate="horaFinTextBox" CssClass="DataValidator"
                  Display="Dynamic" Enabled="false" ErrorMessage="Ingrese la hora de fin de inspección"
                  Font-Bold="True">(*)</asp:RequiredFieldValidator>
          </td>
          <td>
            <asp:TextBox ID="finspeccionTextBox" runat="server" CssClass="FormText" Width="80px"></asp:TextBox>
            De
            <asp:TextBox ID="horaInicioTextBox" runat="server" CssClass="FormText" Width="50px"></asp:TextBox>
            a
            <asp:TextBox ID="horaFinTextBox" runat="server" CssClass="FormText" Width="50px"></asp:TextBox>
            hrs.</td>
        </tr>
        <tr>
          <td>
            Contacto<asp:RequiredFieldValidator ID="contactoInspeccionRFV" runat="server" ControlToValidate="contactoInspeccionTextBox"
              Enabled="False" ErrorMessage="Ingrese el contacto para la inspeccón" Font-Bold="True">(*)</asp:RequiredFieldValidator></td>
          <td>
            <asp:TextBox ID="contactoInspeccionTextBox" runat="server" CssClass="FormText" Width="135px"></asp:TextBox>&nbsp;
            Telf.
            <asp:TextBox ID="telefonoTextBox" runat="server" CssClass="FormText" Width="74px"></asp:TextBox>
          </td>
        </tr>
        <tr>
          <td>
            Dirección<asp:RequiredFieldValidator ID="direccionRFV" runat="server" ControlToValidate="direccionTextBox"
              Enabled="False" ErrorMessage="Ingrese la dirección de la inspección" Font-Bold="True">(*)</asp:RequiredFieldValidator></td>
          <td>
            <asp:TextBox ID="direccionTextBox" runat="server" CssClass="FormText" Width="250px"></asp:TextBox></td>
        </tr>
        <tr>
          <td>
            Ubigeo<asp:RequiredFieldValidator ID="ubigeoIdRFV" runat="server" ControlToValidate="ubigeoIdTextBox"
              Enabled="False" ErrorMessage="Ingrese el ubigeo de la inspección" Font-Bold="True">(*)</asp:RequiredFieldValidator></td>
          <td>
            <asp:TextBox ID="ubigeoIdTextBox" runat="server" CssClass="FormText" Width="250px"></asp:TextBox></td>
        </tr>
        <tr>
          <td>
            Inspector</td>
          <td style="padding-top: 1px; height: 19px">
            <asp:DropDownList ID="inspectorIdCombo" runat="server" CssClass="FormText" Width="254px">
              <asp:ListItem></asp:ListItem>
              <asp:ListItem>EDER QUISPE</asp:ListItem>
              <asp:ListItem>EDER VELASCO</asp:ListItem>
              <asp:ListItem>JUAN CARLOS</asp:ListItem>
              <asp:ListItem>LUIS MOLINA</asp:ListItem>
              <asp:ListItem>MARIO VILLEGAS</asp:ListItem>
            </asp:DropDownList></td>
        </tr>
        <tr>
          <td style="padding-top: 2px" valign="top">
            Observación</td>
          <td style="padding-top: 1px; height: 19px">
            <asp:TextBox ID="observacionTextBox" runat="server" CssClass="FormText" Rows="4"
              TextMode="MultiLine" Width="250px"></asp:TextBox></td>
        </tr>
        <tr>
          <td align="right" colspan="2" style="padding-top: 2px">
            <input runat="server" id="Button3" class="FormButton" style="width: 160px" type="button"
              value="Reprogramar Inspección" />
            <input id="Button4" class="FormButton" type="button" value="Cancelar"/></td>
        </tr>
      </table>
    </div>
    <br />
    <!-- Interfaz de Notificación -->
    <div id="Div3" class="popUpForm" style="padding: 2px; width: 450px; text-align: left;
      display: block; position: fixed">
      <table border="0" cellpadding="0" cellspacing="0" class="DataTable">
        <tr>
          <td align="left" style="height: 18px; font-weight: bold;" valign="bottom" colspan="2">
            Mensaje</td>
        </tr>
        <tr>
          <td align="left" colspan="2">
            <asp:TextBox ID="TextBox2" runat="server" CssClass="FormText" Rows="10" TextMode="MultiLine"
              Width="440px"></asp:TextBox></td>
        </tr>
        <tr>
          <td colspan="2" style="font-weight: bold; height: 16px" valign="bottom">
            Notificar a...</td>
        </tr>
        <tr>
          <td>
            <asp:CheckBox ID="CheckBox1" runat="server" CssClass="FormCheck" Text="Administrador" /></td>
          <td align="right" valign="bottom">
            <asp:TextBox ID="TextBox3" runat="server" CssClass="FormText" Width="300px"></asp:TextBox></td>
        </tr>
        <tr>
          <td>
            <asp:CheckBox ID="CheckBox2" runat="server" CssClass="FormCheck" Text="Solicitante" /></td>
          <td align="right" valign="bottom">
            <asp:TextBox ID="TextBox4" runat="server" CssClass="FormText" Width="300px"></asp:TextBox></td>
        </tr>
        <tr>
          <td>
            <asp:CheckBox ID="CheckBox3" runat="server" CssClass="FormCheck" Text="Aseguradora" /></td>
          <td align="right" valign="bottom">
            <asp:TextBox ID="TextBox5" runat="server" CssClass="FormText" Width="300px"></asp:TextBox></td>
        </tr>
        <tr>
          <td align="right" style="padding-top: 2px;" colspan="2">
            <input runat="server" id="Button5" class="FormButton" style="width: 71px" type="button"
              value="Notificar" />
            <input id="Button6" class="FormButton" type="button" value="Cancelar" />
          </td>
        </tr>
      </table>
    </div>
    <br />
    <!-- ToolTipInspeccion -->
    <div id="damageToolTip" class="ToolTip" style="display: block; position: fixed; width: 280px;">
      <p id="descripcionLabel" style="margin-bottom: 2px">
        <strong style="font-size: 11px">
        Contacto:</strong> Alberto Perez Rodriguez<br />
      </p>
        <table border="1" cellpadding="0" cellspacing="0">
          <tr>
            <td style="font-weight: bold; font-size: 11px; text-transform: capitalize; width: 100px; padding-left: 4px;">
              Fecha / hora</td>
            <td style="font-weight: bold; font-size: 11px; text-transform: capitalize; width: 100px; padding-left: 4px;">
              Actividad</td>
            <td style="font-weight: bold; font-size: 11px; text-transform: capitalize; width: 100px; padding-left: 4px;">
              Estado</td>
          </tr>
          <tr>
            <td style="padding-left: 2px">
              19/10/2006 13:00</td>
            <td style="padding-left: 2px">
              LLAMADA</td>
            <td style="padding-left: 2px">
              REPROGRAMADO</td>
          </tr>
          <tr>
            <td style="padding-left: 2px">
              19/10/2006 09:10</td>
            <td style="padding-left: 2px">
              LLAMADA</td>
            <td style="padding-left: 2px">
              AGENDADO</td>
          </tr>
          <tr>
            <td style="padding-left: 2px">
              18/10/2006 18:25</td>
            <td style="padding-left: 2px">
              E-MAIL</td>
            <td style="padding-left: 2px">
              PENDIENTE</td>
          </tr>
        </table>
    </div>
    <br />
  </form>
</body>
</html>
