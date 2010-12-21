<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vAddImagesToAmpliatorio.aspx.cs"
  Inherits="vAddImagesToAmpliatorio" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
  <title>Subir imagen al Sistema</title>
  <link href="Css/layout.css" rel="stylesheet" type="text/css" />

  <script type="text/javascript" src="Scripts/lib/x.js"></script>

  <script type="text/javascript" src="Scripts/lib/x_common.js"></script>

  <script type="text/javascript" src="Scripts/lib/x_CheckHabilitador.js"></script>

  <script type="text/javascript">
  
  
  function doCallCloseWindow() 
  {
    window.parent.hidePopWin();
    window.top.location.href = window.top.location.href;
    
  }
        
  function PreView() {
    $("preImg").style.display = "none";  
    if($('fupArchivo').value != ""){					
					$("preImg").style.display = "inline";					
					$("preImg").src					  = $('fupArchivo').value;
				}        
    }
    
  window.onload = function() {
    $("preImg").style.display = "none";  
    
    var x = new xCheckHabilitador('chkResize','txtNewWidth','deshabilitado');
    
    
  }
  </script>

</head>
<body>
  <form id="form1" runat="server">
    <div class="DataContent">
      <div class="DataContentRight">
        <div id="ContratantePanel">
          <div id="divAnexo" class="PanelEncabezado" style="height: 28px">
            <span style="font-size: 14pt; margin-top: 5px;">Anexar Imagen</span></div>
          <div class="DataTable" style="padding: 5px; padding-top: 10px;">
            <table border="0" cellpadding="0" cellspacing="0" id="Table3">
              <tr>
                <td colspan="2" rowspan="3" valign="top">
                  <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                      <td style="height: 18px" colspan="2">
                        Archivo
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="fupArchivo"
                          ErrorMessage="Adjunte el archivo" ValidationGroup="btnAdd">(*)</asp:RequiredFieldValidator></td>
                    </tr>
                    <tr>
                      <td colspan="2">
                        <asp:FileUpload onpropertychange="if(event.propertyName=='value'){PreView();}" ID="fupArchivo"
                          runat="server" CssClass="FormText" Width="285px" /></td>
                    </tr>
                    <tr>
                      <td style="height: 18px" colspan="2">
                        Título</td>
                    </tr>
                    <tr>
                      <td colspan="2">
                        <asp:TextBox ID="txtTitulo" runat="server" CssClass="FormText" Width="280px"></asp:TextBox></td>
                    </tr>
                    <tr>
                      <td colspan="2" style="height: 18px">
                        Descripción<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                          ControlToValidate="txtTitulo" ErrorMessage="Ingrese el título" ToolTip="Ingrese el título"
                          ValidationGroup="btnAdd">(*)</asp:RequiredFieldValidator></td>
                    </tr>
                    <tr>
                      <td colspan="2">
                        <asp:TextBox ID="txtDescripcion" runat="server" CssClass="FormText" TextMode="MultiLine"
                          Width="280px" Rows="6"></asp:TextBox></td>
                    </tr>
                    <tr>
                      <td colspan="2" style="height: 14px">
                      </td>
                    </tr>
                    <tr>
                      <td colspan="2" style="height: 16px">
                        <asp:CheckBox ID="chkResize" runat="server" CssClass="FormCheck" Text="Redimensionar a" />&nbsp;
                        <asp:TextBox ID="txtNewWidth" runat="server" CssClass="FormText" Width="48px"></asp:TextBox>
                        px de ancho
                        <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="txtNewWidth"
                          ErrorMessage="Elija valores entre 320 y 800" MaximumValue="800" MinimumValue="320"
                          ToolTip="Elija valores entre 320 y 800" ValidationGroup="btnAdd">(*)</asp:RangeValidator></td>
                    </tr>
                    <tr>
                      <td colspan="2" style="height: 14px">
                      </td>
                    </tr>
                    <tr>
                      <td colspan="2">
                        <asp:Button ID="BtnAddFile" runat="server" CssClass="FormButton" OnClick="AddFile_Click"
                          Text="Agregar" ValidationGroup="btnAdd" /></td>
                    </tr>
                  </table>
                </td>
                <td rowspan="3" valign="top">
                  <table border="0" cellpadding="0" cellspacing="0" style="width: 300px">
                    <tr>
                      <td style="height: 15px; width: 332px;">
                        VISTA PREVIA</td>
                    </tr>
                    <tr>
                      <td style="width: 320px">
                        <img alt='' id="preImg" src="" style="width: 320px; height: 240px" /></td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr>
              </tr>
              <tr>
              </tr>
            </table>
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
    <div class="DataTop">
      <div class="DataTopLeft">
      </div>
      <div class="DataTopRight">
      </div>
    </div>
    <div class="DataContent">
      <div class="DataContentRight" style="height: 58px; left: 0px; top: 0px;">
        <asp:ImageButton Style="position: absolute; left: 4px; top: 4px;" ID="guardarImageButton"
          runat="server" ImageUrl="~/Images/IconApprove48.jpg" ToolTip="Guardar Datos" CssClass="MakeClear"
          OnClick="guardarImageButton_Click" />
        <div style="clear: both">
        </div>
      </div>
    </div>
    <div class="DataBottom">
      <div class="DataBottomLeft">
      </div>
      <div class="DataBottomRight">
      </div>
    </div>
  </form>
</body>
</html>
