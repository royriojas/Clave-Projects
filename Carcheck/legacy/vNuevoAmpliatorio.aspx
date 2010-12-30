<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vNuevoAmpliatorio.aspx.cs"
  Inherits="vNuevoAmpliatorio" %>

<%@ Register Src="ucSecurityController.ascx" TagName="ucSecurityController" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
  <title>Registro de Ampliatorio</title>
  <link href="css/layout.css" rel="stylesheet" type="text/css" />

  <script type="text/javascript" src="Scripts/lib/x.js"></script>

  <script type="text/javascript" src="Scripts/lib/x_common.js"></script>

  <script type="text/javascript" src="Scripts/lib/xDomReady.js"></script>

  <script type="text/javascript" src="Scripts/lib/xCaseFormatter.js"></script>

  <script type="Text/javascript">
    
    function doCallWindowAddImages() {
      if (confirm('Desea Agregar Imagenes al Ampliatorio'))  {
        CCSOL.Utiles.Redirect('vAddImagesToAmpliatorio.aspx?AmpliatorioId='+ <%=ampliatorioId %> + '&InspeccionId='+ <%=inspeccionId %>);
      }else 
      {
        window.parent.hidePopWin();
        window.top.location.href = window.top.location.href;        
      }
      
    }
  </script>

</head>
<body>
  <form id="form1" method="post" runat="server">
    <uc1:ucSecurityController ID="UcSecurityController1" PageFunctionalityToCheck="AMPLIATORIOS_REGISTRAR"
      runat="server" />
    <div>
      <div class="DataContent">
        <div class="DataContentRight">
          <div class="PanelEncabezado">
            <asp:Label ID="Label1" runat="server" Font-Names="Arial" Font-Size="14pt" Text="Datos de Ampliatorio"></asp:Label>
            <img id="imgCollapse" alt="Mostrar / Ocultar Panel" class="MakeClear" src="Images/IconHide16Dark.gif"
              style="margin-top: 3px" title="Mostrar/Ocultar" />
          </div>
          <div class='hr'>
          </div>
          <div id="frmBusqueda" class="DataTable">
            <asp:FormView ID="frmAmpliatorio" runat="server" DefaultMode="Insert" DataSourceID="odsAmpliatorio">
              <EditItemTemplate>
                <table border="0" cellpadding="0" cellspacing="0">
                  <tr>
                    <td style="width: 120px">
                      Motivo del&nbsp;
                      <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="cbxMotivo"
                        ErrorMessage="Elija el Motivo del Ampliatorio" ValueToCompare="-1" Operator="NotEqual">(*)</asp:CompareValidator>Ampliatorio</td>
                    <td>
                    </td>
                    <td style="width: 130px">
                      <asp:DropDownList ID="cbxMotivo" runat="server" CssClass="FormSelect" DataSourceID="odsMotivoCombo"
                        DataTextField="motivo" DataValueField="motivoId" Width="408px" AppendDataBoundItems="True"
                        SelectedValue='<%# Bind("motivoId") %>'>
                        <asp:ListItem Value="-1">[- Elija -]</asp:ListItem>
                      </asp:DropDownList>
                    </td>
                    <td>
                    </td>
                    <td>
                    </td>
                    <td rowspan="4" style="padding-left: 3px" valign="top">
                      &nbsp;</td>
                  </tr>
                  <tr>
                    <td style="width: 120px">
                      Contenido
                      <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtContenido"
                        ErrorMessage="Escriba el detalle del ampliatorio">(*)</asp:RequiredFieldValidator></td>
                    <td>
                    </td>
                    <td style="width: 130px" rowspan="3">
                      <asp:TextBox ID="txtContenido" runat="server" Height="248px" TextMode="MultiLine"
                        Width="400px" Text='<%# Bind("contenido") %>'></asp:TextBox></td>
                    <td>
                    </td>
                    <td>
                    </td>
                  </tr>
                  <tr>
                    <td style="width: 120px">
                    </td>
                    <td style="">
                    </td>
                    <td style="">
                    </td>
                    <td style="">
                    </td>
                  </tr>
                  <tr>
                    <td style="width: 120px">
                    </td>
                    <td>
                    </td>
                    <td>
                    </td>
                    <td>
                    </td>
                  </tr>
                  <tr>
                    <td style="height: 17px; width: 120px;">
                    </td>
                    <td style="height: 17px" valign="bottom">
                      &nbsp;</td>
                    <td style="height: 17px; width: 130px;">
                    </td>
                    <td style="height: 17px">
                    </td>
                    <td style="height: 17px">
                    </td>
                    <td rowspan="1" style="height: 17px" valign="top">
                    </td>
                  </tr>
                </table>
              </EditItemTemplate>
              <InsertItemTemplate>
                <table border="0" cellpadding="0" cellspacing="0">
                  <tr>
                    <td style="height:20px;">
                      Motivo del Ampliatorio
                      <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="cbxMotivo"
                        ErrorMessage="Elija el Motivo del Ampliatorio" ValueToCompare="-1" Operator="NotEqual">(*)</asp:CompareValidator></td>
                  </tr>
                  <tr>
                    <td>
                      <asp:DropDownList ID="cbxMotivo" runat="server" CssClass="FormText" DataSourceID="odsMotivoCombo"
                        DataTextField="motivo" DataValueField="motivoId" Width="408px" SelectedValue='<%# Bind("motivoId") %>'
                        AppendDataBoundItems="True">
                        <asp:ListItem Value="-1">[ - Elija - ]</asp:ListItem>
                      </asp:DropDownList></td>
                  </tr>
                  <tr>
                    <td style="height:20px;">
                      Contenido
                      <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtContenido"
                        ErrorMessage="Escriba el detalle del ampliatorio">(*)</asp:RequiredFieldValidator></td>
                  </tr>
                  <tr>
                    <td>
                      <asp:TextBox ID="txtContenido" runat="server" Height="248px" TextMode="MultiLine"
                        Width="403px" Text='<%# Bind("contenido") %>' CssClass="FormText"></asp:TextBox></td>
                  </tr>
                </table>
              </InsertItemTemplate>
            </asp:FormView>
          </div>
        </div>
      </div>
      <div class="DataBottom">
        <div class="DataBottomLeft">
        </div>
        <div class="DataBottomRight">
        </div>
      </div>
      <div>
        <div class="DataTop">
          <div class="DataTopLeft">
          </div>
          <div class="DataTopRight">
          </div>
        </div>
        <div class="DataContent">
          <div class="DataContentRight" style="height: 59px;">
            <asp:ImageButton Style="position: absolute; top: 4px; left: 4px;" ID="guardarImageButton"
              runat="server" ImageUrl="~/Images/IconSave48Dark.gif" ToolTip="Guardar Datos" CssClass="MakeClear"
              OnClick="guardarImageButton_Click" />
          </div>
        </div>
        <div class="DataBottom">
          <div class="DataBottomLeft">
          </div>
          <div class="DataBottomRight">
          </div>
        </div>
      </div>
      <asp:ObjectDataSource ID="odsMotivoCombo" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetData" TypeName="dsComboTableAdapters.MotivoAmpliatorioComboTableAdapter">
        <SelectParameters>
          <asp:Parameter DefaultValue="A" Name="estado" Type="String" />
        </SelectParameters>
      </asp:ObjectDataSource>
    </div>
    <asp:ObjectDataSource ID="odsAmpliatorio" runat="server" InsertMethod="Insert" SelectMethod="GetData"
      TypeName="dsAmpliatoriosTableAdapters.AmpliatorioInspeccionTableAdapter" OnInserting="odsAmpliatorio_Inserting"
      OnInserted="odsAmpliatorio_Inserted">
      <InsertParameters>
        <asp:Parameter Direction="InputOutput" Name="ampliatorioId" Type="Object" />
        <asp:Parameter Name="motivoId" Type="Decimal" />
        <asp:Parameter Name="contenido" Type="String" />
      </InsertParameters>
    </asp:ObjectDataSource>
  </form>
</body>
</html>
