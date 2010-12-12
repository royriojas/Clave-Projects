<%@ Page Language="C#" EnableViewState="true" EnableEventValidation="false" AutoEventWireup="true"
    CodeFile="vListaSolicitud.aspx.cs" Inherits="vListaSolicitud" %>

<%@ Register Assembly="WebCalendarControl" Namespace="WebCalendarControl" TagPrefix="cc1" %>
<%@ Register Src="ucHeader.ascx" TagName="ucHeader" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>CarCheck | Lista de Solicitudes</title>

    <script type="text/javascript" src="Scripts/lib/x.js"></script>

    <script type="text/javascript" src="Scripts/lib/CollapsibleDiv.js"></script>

    <script type="text/javascript" src="Scripts/functions.js"></script>

    <script type="text/javascript">
    
    
    
    
    window.onload = function () {
        try {
            var b = new CollapsibleDiv ('imgCollapse',
						 'frmBusqueda',
						 true,
						 null
						) 	
        }
        catch(e)
        {
            alert(e.message);
        }
    }
    
    </script>

    <link href="css/layout.css" rel="stylesheet" type="text/css" />
  <link href="css/layout.css" rel="stylesheet" type="text/css" />
  <link href="css/layout.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" method="post" runat="server">
        <div>
            <table id="Data" border="0" cellpadding="0" cellspacing="0" align="center">
                <tr>
                    <td>
                        <uc1:ucHeader ID="UcHeader1" runat="server" TabActual="listaSolicitudes" />
                        <div class="DataTop">
                            <div class="DataTopLeft">
                            </div>
                            <div class="DataTopRight">
                            </div>
                        </div>
                        <div class="DataContent" style="margin-bottom: -4px">
                            <div class="DataContentRight">
                                <div class="PanelEncabezado">
                                    <asp:Label ID="solicitudLabel" runat="server" Text="Búsqueda" Font-Size="14pt" ToolTip="Mostrar / Ocultar Panel"
                                        Font-Names="Arial"></asp:Label>
                                    <img id="imgCollapse" alt="Mostrar / Ocultar Panel" src="Images/IconHide16Dark.gif"
                                        title="Mostrar/Ocultar" style="margin-top: 3px;" onmouseout="MakeClear(this,0)"
                                        onmouseover="MakeClear(this,1);" />
                                </div>
                                <div id="frmBusqueda" class="DataTable">
                                    <table border="0" cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td style="width: 110px">
                                                Placa</td>
                                            <td>
                                                <asp:TextBox ID="txtPlaca" runat="server" CssClass="FormText" Width="136px" TabIndex="8"></asp:TextBox></td>
                                            <td style="width: 115px">
                                                Aseguradora</td>
                                            <td>
                                                <asp:DropDownList ID="cbxAseguradora" runat="server" CssClass="FormText" Width="140px"
                                                    TabIndex="9" DataSourceID="odsAseguradoras" DataTextField="persona" DataValueField="personaId"
                                                     AppendDataBoundItems="True">
                                                     <asp:ListItem Value="-1">[ - Elija - ]</asp:ListItem>
                                                </asp:DropDownList></td>
                                            <td style="width: 115px">
                                                Fecha/Hora Solicitud</td>
                                            <td>
                                                <asp:TextBox ID="txtFechaHoraSolicitud" runat="server" CssClass="FormText" TabIndex="10"
                                                    Width="136px"></asp:TextBox></td>
                                            <td rowspan="5" style="padding-left: 3px" valign="top">
                                                <asp:ImageButton ID="btnBuscar" onmouseover="MakeClear(this,1);" onmouseout="MakeClear(this,0)" runat="server" ImageUrl="~/Images/btnBuscar.gif" AlternateText="Buscar Solicitudes">
                                                </asp:ImageButton>
                                              <asp:ImageButton ID="imgBtnNuevaSolcitud" runat="server" ImageUrl="~/Images/btnNuevaSolicitud.jpg"
                                                OnClick="imgBtnNuevaSolcitud_Click" /></td>
                                        </tr>
                                        <tr>
                                            <td>
                                                Nº Solicitud Cliente</td>
                                            <td>
                                                <asp:TextBox ID="txtNumSolicitudCia" runat="server" CssClass="FormText" Width="136px"
                                                    TabIndex="6"></asp:TextBox></td>
                                            <td style="width: 115px">
                                                Broker</td>
                                            <td>
                                                <asp:DropDownList ID="cbxBroker" runat="server" CssClass="FormText" Width="140px"
                                                    TabIndex="9" DataSourceID="odsBroker" DataTextField="persona" DataValueField="personaId"
                                                     AppendDataBoundItems="True">
                                                     <asp:ListItem Value="-1">[ - Elija - ]</asp:ListItem>
                                                </asp:DropDownList></td>
                                            <td>
                                                Solicitado por</td>
                                            <td>
                                                <asp:TextBox ID="txtSolicitadoPor" runat="server" CssClass="FormText" Width="136px"
                                                    TabIndex="11"></asp:TextBox></td>
                                        </tr>
                                        <tr>
                                            <td style="height: 18px">
                                                Nº Solicitud Clave</td>
                                            <td style="height: 18px">
                                                <asp:TextBox ID="txtNumSolicitudClave" runat="server" CssClass="FormText" TabIndex="8"
                                                    Width="136px"></asp:TextBox></td>
                                            <td style="width: 115px; height: 18px;">
                                                Canal</td>
                                            <td style="height: 18px">
                                                <asp:DropDownList ID="cbxCanal" runat="server" CssClass="FormText" Width="140px"
                                                    TabIndex="9" DataSourceID="odsCanal" DataTextField="canal" DataValueField="canalId"
                                                     AppendDataBoundItems="True">
                                                     <asp:ListItem Value="-1">[ - Elija - ]</asp:ListItem>
                                                </asp:DropDownList></td>
                                            <td style="height: 18px">
                                                Tipo Requerimiento
                                            </td>
                                            <td style="height: 18px">
                                                <asp:DropDownList ID="cbxTipoRequerimiento" runat="server" CssClass="FormText" Width="140px"
                                                    TabIndex="2" DataSourceID="odsTipoRequerimiento" DataTextField="trequerimiento"
                                                    DataValueField="trequerimientoId" 
                                                     AppendDataBoundItems="True">
                                                     <asp:ListItem Value="">[ - Elija - ]</asp:ListItem>
                                                </asp:DropDownList></td>
                                        </tr>
                                        <tr>
                                            <td>
                                                Nº Inspección</td>
                                            <td>
                                                <asp:TextBox ID="txtNumInspeccion" runat="server" CssClass="FormText" Width="136px"
                                                    TabIndex="7"></asp:TextBox></td>
                                            <td style="width: 115px">
                                                Contratante</td>
                                            <td>
                                                <asp:TextBox ID="txtContratante" runat="server" CssClass="FormText" Width="136px"
                                                    TabIndex="10"></asp:TextBox></td>
                                            <td>
                                                Estado Solicitud</td>
                                            <td>
                                                <asp:DropDownList ID="cbxEstado" runat="server" CssClass="FormText" Width="140px"
                                                    TabIndex="5" DataSourceID="odsEstado" DataTextField="estadoSolicitud" DataValueField="estadoSolicitudId"
                                                     AppendDataBoundItems="True">
                                                     <asp:ListItem Value="">[ - Elija - ]</asp:ListItem>
                                                </asp:DropDownList></td>
                                        </tr>
                                        <tr>
                                            <td>
                                                Cliente</td>
                                            <td>
                                                <asp:DropDownList ID="cbxCliente" runat="server" CssClass="FormText" Width="140px"
                                                    TabIndex="9" DataSourceID="odsCliente" DataTextField="persona" DataValueField="personaId"
                                                     AppendDataBoundItems="True">
                                                    <asp:ListItem Value="-1">[ - Elija - ]</asp:ListItem>
                                                </asp:DropDownList></td>
                                            <td>
                                                Asegurado</td>
                                            <td>
                                                <asp:TextBox ID="txtAsegurado" runat="server" CssClass="FormText" TabIndex="10" Width="136px"></asp:TextBox></td>
                                            <td>
                                                Prioridad</td>
                                            <td>
                                                <asp:DropDownList ID="cbxPrioridad" runat="server" CssClass="FormText" Width="90px"
                                                    TabIndex="3" DataSourceID="odsPrioridad" DataTextField="prioridad" DataValueField="prioridadId"
                                                    AppendDataBoundItems="True">
                                                     <asp:ListItem Value="">[ - Elija - ]</asp:ListItem>
                                                </asp:DropDownList>
                                                <asp:CheckBox ID="chkClienteVip" runat="server" TabIndex="4" CssClass="FormCheck"
                                                    Text="VIP  " TextAlign="Left" /></td>
                                        </tr>
                                    </table>
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
                            <div class="DataContentRight">
                                <asp:Label ID="lblLista" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="14pt"
                                    Text="Lista de Solicitudes"></asp:Label>
                                <div class="hr">
                                </div>                                
                                <asp:GridView ID="ListaSolicitudGridView" runat="server" CssClass="GridLista" AutoGenerateColumns="False"
                                    PageSize="15" EmptyDataText="No se encontraron ocurrencias" AllowPaging="True"
                                    BorderStyle="Solid" Width="898px" DataSourceID="odsSolicitudLista" OnRowDataBound="ListaSolicitudGridView_RowDataBound"
                                    AllowSorting="True">
                                    <HeaderStyle CssClass="HeaderStyle" />
                                    <RowStyle CssClass="ItemStyle" />
                                    <PagerStyle CssClass="PagerStyle" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="N&#186;">
                                            <ItemTemplate>
                                                <asp:Label ID="Label1" runat="server" Text="<%# num++ %>" ForeColor="Black"></asp:Label>
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="numeVehiculos" HeaderText="N&#186; de Vehiculos" SortExpression="numeVehiculos">
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="numeSolicitudCliente" HeaderText="N&#176; Solicitud Cliente"
                                            SortExpression="numeSolicitudCliente">
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="fsolicitud" HeaderText="Fecha/Hora Solicitud" SortExpression="fsolicitud"
                                            DataFormatString="{0:dd-MM-yyyy}" HtmlEncode="False" NullDisplayText="--">
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="numeSolicitud" HeaderText="N&#186; Solicitud Clave"
                                            SortExpression="numeSolicitud">
                                            <ItemStyle HorizontalAlign="Center" />
                                            <HeaderStyle Width="100px" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="contratante" HeaderText="Contratante" SortExpression="contratante">
                                            <ItemStyle HorizontalAlign="Center" Width="150px" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="asegurado" HeaderText="Asegurado" SortExpression="asegurado"
                                            Visible="False">
                                            <ItemStyle HorizontalAlign="Center" Width="150px" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="broker" HeaderText="Broker" SortExpression="broker">
                                            <ItemStyle HorizontalAlign="Center" Width="150px" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="trequerimiento" HeaderText="Tipo Requerimiento" SortExpression="trequerimiento">
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="prioridad" HeaderText="Prioridad" SortExpression="prioridad">
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="canal" HeaderText="Canal" SortExpression="canal">
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="estadoSolicitud" HeaderText="Estado" SortExpression="estadoSolicitud">
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="fechaCambio" HeaderText="Fecha/Hora Estado" SortExpression="fechaCambio"
                                            DataFormatString="{0:dd-MM-yyyy}" NullDisplayText="--" HtmlEncode="False" />
                                        <asp:BoundField DataField="solicitadopor" HeaderText="Solicitado" SortExpression="solicitadopor"
                                            Visible="False">
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:BoundField>
                                        <asp:CheckBoxField DataField="clienteVIP" HeaderText="VIP" SortExpression="clienteVIP"
                                            Visible="False">
                                            <ItemStyle HorizontalAlign="Center" Width="15px" />
                                        </asp:CheckBoxField>
                                        <asp:BoundField DataField="observacion" HeaderText="observacion" SortExpression="observacion"
                                            Visible="False" />
                                        <asp:BoundField DataField="solicitudId" HeaderText="solicitudId" InsertVisible="False"
                                            ReadOnly="True" SortExpression="solicitudId" Visible="False" />
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
                        <asp:ValidationSummary ID="listaSolicitudVS" runat="server" DisplayMode="List" ShowMessageBox="True"
                            ShowSummary="False" />
                        <asp:ObjectDataSource ID="odsSolicitudLista" runat="server" OldValuesParameterFormatString="original_{0}"
                            SelectMethod="GetData" TypeName="dsSolicitudTableAdapters.SolicitudInspeccionListaTableAdapter"
                            OnSelected="odsSolicitudLista_Selected">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="txtPlaca" Name="placa" PropertyName="Text" Type="String" />
                                <asp:ControlParameter ControlID="txtNumSolicitudCia" Name="numSolicitudCliente" PropertyName="Text"
                                    Type="String" />
                                <asp:ControlParameter ControlID="txtNumSolicitudClave" Name="numeroSolicitud" PropertyName="Text"
                                    Type="String" />
                                <asp:ControlParameter ControlID="txtNumInspeccion" Name="numeroinspeccion" PropertyName="Text"
                                    Type="String" />
                                <asp:ControlParameter ControlID="cbxAseguradora" Name="aseguradoraId" PropertyName="SelectedValue"
                                    Type="Decimal" />
                                <asp:ControlParameter ControlID="cbxCliente" Name="clienteId" PropertyName="SelectedValue"
                                    Type="Decimal" />
                                <asp:ControlParameter ControlID="cbxBroker" Name="brokerId" PropertyName="SelectedValue"
                                    Type="Decimal" />
                                <asp:ControlParameter ControlID="cbxCanal" Name="canalId" PropertyName="SelectedValue"
                                    Type="Decimal" />
                                <asp:ControlParameter ControlID="txtFechaHoraSolicitud" Name="fechasolicitud" PropertyName="Text"
                                    Type="DateTime" />
                                <asp:ControlParameter ControlID="txtContratante" Name="contratante" PropertyName="Text"
                                    Type="String" />
                                <asp:ControlParameter ControlID="txtAsegurado" Name="asegurado" PropertyName="Text"
                                    Type="String" />
                                <asp:ControlParameter ControlID="txtSolicitadoPor" Name="solitadopor" PropertyName="Text"
                                    Type="String" />
                                <asp:ControlParameter ControlID="cbxTipoRequerimiento" Name="tiporequerimientoId"
                                    PropertyName="SelectedValue" Type="String" />
                                <asp:ControlParameter ControlID="cbxPrioridad" DefaultValue="" Name="prioridadId"
                                    PropertyName="SelectedValue" Type="String" />
                                <asp:ControlParameter ControlID="cbxEstado" Name="estadoId" PropertyName="SelectedValue"
                                    Type="String" />
                                <asp:ControlParameter ControlID="chkClienteVip" Name="clienteVIP" PropertyName="Checked"
                                    Type="Boolean" />
                            </SelectParameters>
                        </asp:ObjectDataSource>
                        <asp:ObjectDataSource ID="odsTipoRequerimiento" runat="server" OldValuesParameterFormatString="original_{0}"
                            SelectMethod="GetData" TypeName="dsComboTableAdapters.TipoRequerimientoComboTableAdapter">
                          <SelectParameters>
                            <asp:Parameter DefaultValue="A" Name="estado" Type="String" />
                          </SelectParameters>
                        </asp:ObjectDataSource>
                        <asp:ObjectDataSource ID="odsEstado" runat="server" OldValuesParameterFormatString="original_{0}"
                            SelectMethod="GetData" TypeName="dsComboTableAdapters.EstadoSolicitudComboTableAdapter">
                          <SelectParameters>
                            <asp:Parameter DefaultValue="A" Name="estado" Type="String" />
                          </SelectParameters>
                        </asp:ObjectDataSource>
                        <asp:ObjectDataSource ID="odsCanal" runat="server" OldValuesParameterFormatString="original_{0}"
                            SelectMethod="GetData" TypeName="dsComboTableAdapters.CanalComboTableAdapter">
                          <SelectParameters>
                            <asp:Parameter DefaultValue="A" Name="estado" Type="String" />
                          </SelectParameters>
                        </asp:ObjectDataSource>
                        <asp:ObjectDataSource ID="odsPrioridad" runat="server" OldValuesParameterFormatString="original_{0}"
                            SelectMethod="GetData" TypeName="dsComboTableAdapters.PrioridadComboTableAdapter">
                          <SelectParameters>
                            <asp:Parameter DefaultValue="A" Name="estado" Type="String" />
                          </SelectParameters>
                        </asp:ObjectDataSource>
                        <asp:ObjectDataSource ID="odsAseguradoras" runat="server" OldValuesParameterFormatString="original_{0}"
                            SelectMethod="GetData" TypeName="ADM_DAL.dsDropDownListTableAdapters.AseguradoraLoadDropDownTableAdapter">
                          <SelectParameters>
                            <asp:Parameter DefaultValue="A" Name="estado" Type="String" />
                          </SelectParameters>
                        </asp:ObjectDataSource>
                        <asp:ObjectDataSource ID="odsBroker" runat="server" OldValuesParameterFormatString="original_{0}"
                            SelectMethod="GetData" TypeName="ADM_DAL.dsDropDownListTableAdapters.BrokerLoadDropDownTableAdapter">
                          <SelectParameters>
                            <asp:Parameter DefaultValue="A" Name="estado" Type="String" />
                          </SelectParameters>
                        </asp:ObjectDataSource>
                      <asp:ObjectDataSource ID="odsCliente" runat="server" OldValuesParameterFormatString="original_{0}"
                        SelectMethod="GetData" TypeName="ADM_DAL.dsDropDownListTableAdapters.ClienteLoadDropDownTableAdapter">
                        <SelectParameters>
                          <asp:Parameter DefaultValue="A" Name="estado" Type="String" />
                        </SelectParameters>
                      </asp:ObjectDataSource>
                    </td>
                </tr>
            </table>
        </div>
        <br />
    </form>
</body>
</html>
