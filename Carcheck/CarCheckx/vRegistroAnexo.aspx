<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vRegistroAnexo.aspx.cs" Inherits="vRegistroAnexo" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
  <title>CarCheck/Registro de Anexos</title>
  <link href="Css/layout.css" rel="stylesheet" type="text/css" />  
  <script type="text/javascript" src="Scripts/lib/x.js"></script>
  <script type="text/javascript" src="Scripts/lib/x_common.js"></script>
  <script type="text/javascript" src="Scripts/lib/xCaseFormatter.js"></script>
  
  
  
  <script type="text/javascript">
        if(<%=deboCerrar%>)
        {
          window.parent.hidePopWin();
          window.parent.doRefresh();
        }
    
    window.onload = function () {
      $('fupArchivo').focus();
    }
    </script>
  
</head>
<body>
  <form id="form1" runat="server">
    <div style="width:393px;">
      <div class="DataTop">
        <div class="DataTopLeft">
        </div>
        <div class="DataTopRight">
        </div>
      </div>
      <div class="DataContent">
        <div class="DataContentRight">
          <div id="ContratantePanel">
            <div id="divAnexo" class="PanelEncabezado">
              <span style="font-size: 14pt">Anexar Archivo</span></div>
            <div class="DataTable" style="padding: 5px; padding-top: 10px;">
              <table border="0" cellpadding="0" cellspacing="0" id="Table3">
                <tr>
                  <td>
                    Archivo</td>
                  <td style="height: 18px">
                    <asp:FileUpload ID="fupArchivo" runat="server" CssClass="FormText" Width="285px" /></td>
                </tr>
                <tr>
                  <td style="padding-top: 2px;" valign="top">
                    Descripción</td>
                  <td style="height: 18px">
                    <asp:TextBox ID="txtDescripcion" runat="server" CssClass="FormText" TextMode="MultiLine"
                      Width="280px" Rows="3"></asp:TextBox></td>
                </tr>
                <tr>
                  <td style="width: 73px; height: 25px; text-align: left">
                  </td>
                  <td style="height: 25px" valign="bottom">
                    <asp:Button ID="BtnAddFile" runat="server" CssClass="FormButton" OnClick="AddFile_Click"
                      Text="Agregar" /></td>
                </tr>
              </table>
              <br />
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
  </form>
</body>
</html>
