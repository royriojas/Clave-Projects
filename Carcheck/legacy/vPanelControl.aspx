<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vPanelControl.aspx.cs" Inherits="vPanelControl" %>

<%@ Register Src="ucHeader.ascx" TagName="ucHeader" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
  <title>
    <%=CCSOL.Utiles.Utilidades.GetSystemNameAndVersion() %>
    | Panel de Control</title>

  <script type="text/javascript" src="Scripts/lib/x.js"></script>

  <script type="text/javascript" src="Scripts/lib/x_common.js"></script>

  <script type="text/javascript">
    CCSOL.Utiles.LoadCSS("./Scripts/xCommon/xCommon.css");
  </script>

  <script type="text/javascript">

    function getValueFromTrigger (e) {
      var xe = new xEvent(e);      
      var tn = CCSOL.DOM.x_GetAttribute(xe.target,'TableName');
      return tn;     
    }
    function __showTable(e) {
    
      var tn = getValueFromTrigger(e);
      if (tn == 'contacto') ventana.showPopUpModal('./control/vContacto.aspx',730,440);
      
      xPreventDefault(e);
    }
    
    function initOnclickHandlers() {
      xAddEventListener($('MainTables'),'click',__showTable,false);
    }
    xAddEventListener(window,'load',initOnclickHandlers,false);
  </script>

  <link href="css/layout.css" rel="stylesheet" type="text/css" />
  <link href="./Scripts/x_info/xInfo.css" rel="stylesheet" type="text/css" />
</head>
<body>
  <form id="form1" runat="server">
    <div>
      <uc1:ucHeader ID="UcHeader1" TabActual="opciones" PageFunctionalityToCheck="CARCHECK_OPCIONES"
        runat="server" />
      <div>
        <div class="DataTop">
          <div class="DataTopLeft">
          </div>
          <div class="DataTopRight">
          </div>
        </div>
        <div class="DataContent">
          <div class="DataContentRight">
            <div class="PanelEncabezado">
              <asp:Label ID="solicitudLabel" runat="server" Text="Tablas Maestras" Font-Size="14pt"
                ToolTip="Mostrar / Ocultar Panel" Font-Names="Arial"></asp:Label>
              <img id="imgCollapse" alt="Mostrar / Ocultar Panel" src="Images/IconHide16Dark.gif"
                title="Mostrar/Ocultar" style="margin-top: 3px;" class="MakeClear" />
            </div>
            <div id='MainTables' class="DataTable" style="padding: 5px;">
              <div style="clear:both"></div>
              <div class="MainTableDiv">
                <table border="0" cellpadding="0" cellspacing="0">
                  <tr>
                    <td>
                      <asp:ImageButton TableName='contacto' ID="tblContacto" runat="server" ImageUrl="~/Images/Tables/tableIco.jpg" /></td>
                    <td>
                      Contactos</td>
                  </tr>
                </table>
              </div>
              <div class="MainTableDiv">
                <table border="0" cellpadding="0" cellspacing="0">
                  <tr>
                    <td>
                      <asp:ImageButton TableName='contacto' ID="ImageButton1" runat="server" ImageUrl="~/Images/Tables/tableIco.jpg" /></td>
                    <td>
                      Contactos</td>
                  </tr>
                </table>
              </div>
              <div class="MainTableDiv">
                <table border="0" cellpadding="0" cellspacing="0">
                  <tr>
                    <td>
                      <asp:ImageButton TableName='contacto' ID="ImageButton2" runat="server" ImageUrl="~/Images/Tables/tableIco.jpg" /></td>
                    <td>
                      Contactos</td>
                  </tr>
                </table>
              </div>
              <div class="MainTableDiv">
                <table border="0" cellpadding="0" cellspacing="0">
                  <tr>
                    <td>
                      <asp:ImageButton TableName='contacto' ID="ImageButton3" runat="server" ImageUrl="~/Images/Tables/tableIco.jpg" /></td>
                    <td>
                      Contactos</td>
                  </tr>
                </table>
              </div>
              <div class="MainTableDiv">
                <table border="0" cellpadding="0" cellspacing="0">
                  <tr>
                    <td>
                      <asp:ImageButton TableName='contacto' ID="ImageButton4" runat="server" ImageUrl="~/Images/Tables/tableIco.jpg" /></td>
                    <td>
                      Contactos</td>
                  </tr>
                </table>
              </div>
              <div class="MainTableDiv">
                <table border="0" cellpadding="0" cellspacing="0">
                  <tr>
                    <td>
                      <asp:ImageButton TableName='contacto' ID="ImageButton5" runat="server" ImageUrl="~/Images/Tables/tableIco.jpg" /></td>
                    <td>
                      Contactos</td>
                  </tr>
                </table>
              </div>
              <div class="MainTableDiv">
                <table border="0" cellpadding="0" cellspacing="0">
                  <tr>
                    <td>
                      <asp:ImageButton TableName='contacto' ID="ImageButton6" runat="server" ImageUrl="~/Images/Tables/tableIco.jpg" /></td>
                    <td>
                      Contactos</td>
                  </tr>
                </table>
              </div>
              <div class="MainTableDiv">
                <table border="0" cellpadding="0" cellspacing="0">
                  <tr>
                    <td>
                      <asp:ImageButton TableName='contacto' ID="ImageButton7" runat="server" ImageUrl="~/Images/Tables/tableIco.jpg" /></td>
                    <td>
                      Contactos</td>
                  </tr>
                </table>
              </div>
              <div class="MainTableDiv">
                <table border="0" cellpadding="0" cellspacing="0">
                  <tr>
                    <td>
                      <asp:ImageButton TableName='contacto' ID="ImageButton8" runat="server" ImageUrl="~/Images/Tables/tableIco.jpg" /></td>
                    <td>
                      Contactos</td>
                  </tr>
                </table>
              </div>
              <div class="MainTableDiv">
                <table border="0" cellpadding="0" cellspacing="0">
                  <tr>
                    <td>
                      <asp:ImageButton TableName='contacto' ID="ImageButton9" runat="server" ImageUrl="~/Images/Tables/tableIco.jpg" /></td>
                    <td>
                      Contactos</td>
                  </tr>
                </table>
              </div>
              <div class="MainTableDiv">
                <table border="0" cellpadding="0" cellspacing="0">
                  <tr>
                    <td>
                      <asp:ImageButton TableName='contacto' ID="ImageButton10" runat="server" ImageUrl="~/Images/Tables/tableIco.jpg" /></td>
                    <td>
                      Contactos</td>
                  </tr>
                </table>
              </div>
              <div class="MainTableDiv">
                <table border="0" cellpadding="0" cellspacing="0">
                  <tr>
                    <td>
                      <asp:ImageButton TableName='contacto' ID="ImageButton11" runat="server" ImageUrl="~/Images/Tables/tableIco.jpg" /></td>
                    <td>
                      Contactos</td>
                  </tr>
                </table>
              </div>
             
              <div style="clear: both">
              </div>
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
    </div>
  </form>
</body>
</html>
