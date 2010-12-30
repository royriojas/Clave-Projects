<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vAmpliatorios.aspx.cs" Inherits="vAmpliatorios" %>

<%@ Register Src="ucHeader.ascx" TagName="ucHeader" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
  <title>Ampliatorios</title>
  <link href="css/layout.css" rel="stylesheet" type="text/css" />

  <script type="text/javascript" src="Scripts/lib/x.js"></script>

  <script type="text/javascript" src="Scripts/lib/x_common.js"></script>

  <script type="text/javascript">
    function VerNuevoAmpliatorio()
	  {
	    ventana.OnHide = function () {
	      document.location.href = document.location.href  + '';
	    }
		  ventana.showPopUpModal("vNuevoAmpliatorio.aspx?nocache="+ CCSOL.Utiles.AvoidInstantCache() +"&InspeccionId="+ <%= InspeccionId %>,640,470);
	  }
    function VerInforme(inspeccionId, ampliatorioId)
    {
      ShowReport('vViewPdf.aspx?InspeccionId='+ inspeccionId + '&InformeId=' + ampliatorioId + '&TI=A');
    }
  </script>

  <link href="css/layout.css" rel="stylesheet" type="text/css" />
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
                  <asp:Label ID="solicitudLabel" runat="server" Text="Información del Caso" Font-Size="14pt"
                    ToolTip="Mostrar / Ocultar Panel" Font-Names="Arial"></asp:Label>
                  <img id="imgCollapse" alt="Mostrar / Ocultar Panel" src="Images/IconHide16Dark.gif"
                    title="Mostrar/Ocultar" style="margin-top: 3px;" class="MakeClear" />
                </div>
                <div class="hr">
                </div>
                <div id="frmBusqueda" class="DataTable">
                  <asp:FormView ID="FormView1" runat="server" DataSourceID="odsInformacionInspeccion">
                    <ItemTemplate>
                      <table border="0" cellpadding="0" cellspacing="0">
                        <tr>
                          <td style="width: 95px">
                            Cliente</td>
                          <td>
                            <asp:TextBox ID="txtCliente" runat="server" CssClass="FormText" TabIndex="1" Width="160px"
                              Text='<%# Eval("Cliente") %>'></asp:TextBox></td>
                          <td style="width: 110px">
                            Asegurado</td>
                          <td>
                            <asp:TextBox ID="txtAsegurado" runat="server" CssClass="FormText" TabIndex="1" Width="160px"
                              Text='<%# Eval("Asegurado") %>'></asp:TextBox></td>
                          <td style="width: 80px">
                            Clase</td>
                          <td>
                            <asp:TextBox ID="txtClase" runat="server" CssClass="FormText" TabIndex="3" Width="160px"
                              Text='<%# Eval("claseVehiculo") %>'></asp:TextBox></td>
                        </tr>
                        <tr>
                          <td style="width: 95px">
                            Aseguradora</td>
                          <td>
                            <asp:TextBox ID="txtAseguradora" runat="server" CssClass="FormText" TabIndex="4"
                              Width="160px" Text='<%# Eval("Aseguradora") %>'></asp:TextBox></td>
                          <td style="width: 110px">
                            Nº Solicitud Cliente</td>
                          <td>
                            <asp:TextBox ID="txtSolicitudCliente" runat="server" CssClass="FormText" TabIndex="1"
                              Width="160px" Text='<%# Eval("numeSolicitudCliente") %>'></asp:TextBox></td>
                          <td style="width: 80px">
                            Marca</td>
                          <td>
                            <asp:TextBox ID="txtMarca" runat="server" CssClass="FormText" TabIndex="6" Width="160px"
                              Text='<%# Eval("marcaVehiculo") %>'></asp:TextBox></td>
                        </tr>
                        <tr>
                          <td style="width: 95px">
                            Broker</td>
                          <td style="">
                            <asp:TextBox ID="txtBroker" runat="server" CssClass="FormText" TabIndex="7" Width="160px"
                              Text='<%# Eval("Broker") %>'></asp:TextBox></td>
                          <td style="width: 110px;">
                            Nº Inspección</td>
                          <td style="">
                            <asp:TextBox ID="txtNumInspeccion" runat="server" CssClass="FormText" TabIndex="1"
                              Width="160px" Text='<%# Eval("numeInspeccion") %>'></asp:TextBox></td>
                          <td style="width: 80px">
                            Modelo</td>
                          <td style="">
                            <asp:TextBox ID="txtModelo" runat="server" CssClass="FormText" TabIndex="1" Width="160px"
                              Text='<%# Eval("modeloVehiculo") %>'></asp:TextBox></td>
                        </tr>
                        <tr>
                          <td style="width: 95px">
                            Contratante</td>
                          <td>
                            <asp:TextBox ID="txtContratante" runat="server" CssClass="FormText" TabIndex="10"
                              Width="160px" Text='<%# Eval("Contratante") %>'></asp:TextBox></td>
                          <td style="width: 110px">
                            Nº Solicitud Clave1</td>
                          <td>
                            <asp:TextBox ID="txtSolicitudClave" runat="server" CssClass="FormText" TabIndex="11"
                              Width="160px" Text='<%# Eval("numeSolicitud") %>'></asp:TextBox></td>
                          <td style="width: 80px">
                            Placa</td>
                          <td>
                            <asp:TextBox ID="txtPlaca" runat="server" CssClass="FormText" TabIndex="1" Width="160px"
                              Text='<%# Eval("placa") %>'></asp:TextBox></td>
                        </tr>
                        <tr>
                          <td style="width: 95px;">
                          </td>
                          <td valign="bottom">
                            &nbsp;</td>
                          <td style="width: 110px;">
                          </td>
                          <td>
                          </td>
                          <td style="width: 80px;">
                          </td>
                          <td>
                          </td>
                        </tr>
                      </table>
                    </ItemTemplate>
                  </asp:FormView>
                  &nbsp;</div>
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
              <div class="DataContentRight">
                <div class="PanelEncabezado" style="height: 23px;">
                  <asp:Label ID="Label1" runat="server" Text="Lista de Ampliatorios" Font-Bold="True"
                    Font-Names="Arial" Font-Size="14pt"></asp:Label>
                  <div id="panelBtns" style="margin-top: 3px; float: right">
                    <asp:ImageButton ID="nuevaInspeccionImageButton" runat="server" ImageUrl="~/Images/btnNuevoAmpliatorio.jpg"
                      OnClientClick="VerNuevoAmpliatorio();return false" CssClass="MakeClear" />
                  </div>
                </div>
                <div class="hr">
                </div>
                <asp:GridView ID="ListaInspeccionGridView" runat="server" CssClass="GridLista" AutoGenerateColumns="False"
                  PageSize="15" EmptyDataText="No se encontraron ocurrencias" AllowPaging="True"
                  BorderStyle="Solid" AllowSorting="True" DataKeyNames="ampliatorioId" DataSourceID="odsListaAmpliatorio"
                  OnRowDataBound="ListaInspeccionGridView_RowDataBound" Width="803px">
                  <HeaderStyle CssClass="HeaderStyle" />
                  <RowStyle CssClass="ItemStyle" />
                  <PagerStyle CssClass="PagerStyle" />
                  <Columns>
                    <asp:BoundField DataField="motivo" HeaderText="Motivo" SortExpression="motivo">
                      <ItemStyle Width="200px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="contenido" HeaderText="Contenido" SortExpression="contenido">
                      <ItemStyle Width="300px" />
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="PDF">
                      <ItemStyle HorizontalAlign="Center" />
                      <ItemTemplate>
                        <asp:HyperLink ID="ampliatorioHyperLink" runat="server" ImageUrl="~/images/IconPdf16.gif"
                          ToolTip="Ver Ampliatorio">Ver Ampliatorio</asp:HyperLink>
                      </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="fcrea" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Fecha de Creaci&#243;n"
                      SortExpression="fcrea" HtmlEncode="False">
                      <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="Acci&#243;n">
                      <ItemStyle HorizontalAlign="Center" />
                      <ItemTemplate>
                        <asp:ImageButton ID="ImageButton3" runat="server" CommandName="Delete" ImageUrl="~/Images/IconDelete.gif"
                          OnClientClick="return confirm('Desea Eliminar el registro elegido???');" />
                      </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="inspeccionId" HeaderText="inspeccionId" SortExpression="inspeccionId"
                      Visible="False" />
                    <asp:BoundField DataField="ampliatorioId" HeaderText="ampliatorioId" ReadOnly="True"
                      SortExpression="ampliatorioId" Visible="False" />
                  </Columns>
                </asp:GridView>
                <br />
              </div>
            </div>
            <div class="DataBottom">
              <div class="DataBottomLeft">
              </div>
              <div class="DataBottomRight">
              </div>
            </div>
            &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
          </td>
        </tr>
      </table>
    </div>
    <asp:ObjectDataSource ID="odsInformacionInspeccion" runat="server" OldValuesParameterFormatString="original_{0}"
      SelectMethod="GetData" TypeName="dsAmpliatoriosTableAdapters.InformacionInspeccionTableAdapter">
      <SelectParameters>
        <asp:QueryStringParameter Name="inspeccionId" QueryStringField="InspeccionId" Type="Decimal" />
      </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="odsListaAmpliatorio" runat="server" DeleteMethod="Delete"
      OnDeleting="odsListaAmpliatorio_Deleting" SelectMethod="GetData" TypeName="dsAmpliatoriosTableAdapters.AmpliatoriosListaTableAdapter">
      <DeleteParameters>
        <asp:Parameter Name="ampliatorioId" Type="Decimal" />
      </DeleteParameters>
      <SelectParameters>
        <asp:QueryStringParameter Name="inspeccionId" QueryStringField="InspeccionId" Type="Decimal" />
      </SelectParameters>
    </asp:ObjectDataSource>
    &nbsp; &nbsp;&nbsp;<br />
    &nbsp;
  </form>
</body>
</html>
