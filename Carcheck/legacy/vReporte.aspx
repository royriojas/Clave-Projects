<%@ Page Language="C#" EnableViewState="true" EnableEventValidation="false" AutoEventWireup="true"
    CodeFile="vReporte.aspx.cs" Inherits="vReporte" %>

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
                                    <asp:Label ID="solicitudLabel" runat="server" Text="Filtros" Font-Size="14pt" ToolTip="Mostrar / Ocultar Panel"
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
                                                <asp:DropDownList ID="DropDownList1" runat="server" CssClass="FormText" Width="140px"
                                                    TabIndex="9" DataSourceID="odsBroker" DataTextField="persona" DataValueField="personaId"
                                                    OnDataBound="cbxBroker_DataBound">
                                                </asp:DropDownList></td>
                                            <td style="width: 115px">
                                                Fecha/Hora Solicitud</td>
                                            <td>
                                                <asp:TextBox ID="txtFechaHoraSolicitud" runat="server" CssClass="FormText" TabIndex="10"
                                                    Width="136px"></asp:TextBox></td>
                                            <td rowspan="5" style="padding-left: 3px" valign="top">
                                                <asp:ImageButton ID="btnBuscar" onmouseover="MakeClear(this,1);" onmouseout="MakeClear(this,0)"
                                                    OnClick="btnBuscar_Click" runat="server" ImageUrl="~/Images/btnBuscar.gif" AlternateText="Buscar Solicitudes">
                                                </asp:ImageButton>
                                                <asp:HyperLink ID="btmExportar" runat="server" ImageUrl="~/Images/btnExportar.jpg" onmouseout="MakeClear(this,0)" onmouseover="MakeClear(this,1);">Exportar</asp:HyperLink></td>
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
                                                    OnDataBound="cbxBroker_DataBound">
                                                </asp:DropDownList></td>
                                            <td>
                                                Solicitado por</td>
                                            <td>
                                                <asp:TextBox ID="txtSolicitadoPor" runat="server" CssClass="FormText" Width="136px"
                                                    TabIndex="11"></asp:TextBox></td>
                                        </tr>
                                        <tr>
                                            <td>
                                                Nº Solicitud Clave</td>
                                            <td>
                                                <asp:TextBox ID="txtNumSolicitudClave" runat="server" CssClass="FormText" TabIndex="8"
                                                    Width="136px"></asp:TextBox></td>
                                            <td style="width: 115px">
                                                Canal</td>
                                            <td>
                                                <asp:DropDownList ID="cbxCanal" runat="server" CssClass="FormText" Width="140px"
                                                    TabIndex="9" DataSourceID="odsCanal" DataTextField="canal" DataValueField="canalId"
                                                    OnDataBound="cbxCanal_DataBound">
                                                </asp:DropDownList></td>
                                            <td>
                                                Tipo Requerimiento
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="cbxTipoRequerimiento" runat="server" CssClass="FormText" Width="140px"
                                                    TabIndex="2" DataSourceID="odsTipoRequerimiento" DataTextField="tiporequerimiento"
                                                    DataValueField="tiporequerimientoId" OnDataBound="cbxTipoRequerimiento_DataBound"
                                                    OnSelectedIndexChanged="cbxTipoRequerimiento_SelectedIndexChanged">
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
                                                Estado</td>
                                            <td>
                                                <asp:DropDownList ID="cbxEstado" runat="server" CssClass="FormText" Width="140px"
                                                    TabIndex="5" DataSourceID="odsEstado" DataTextField="estadosolicitud" DataValueField="estadoId"
                                                    OnDataBound="cbxEstado_DataBound">
                                                </asp:DropDownList></td>
                                        </tr>
                                        <tr>
                                            <td>
                                                Cliente</td>
                                            <td>
                                                <asp:DropDownList ID="cbxAseguradora" runat="server" CssClass="FormText" Width="140px"
                                                    TabIndex="9" DataSourceID="odsAseguradoras" DataTextField="persona" DataValueField="personaId"
                                                    OnDataBound="cbxAseguradora_DataBound">
                                                </asp:DropDownList></td>
                                            <td style="width: 115px">
                                                Asegurado</td>
                                            <td>
                                                <asp:TextBox ID="txtAsegurado" runat="server" CssClass="FormText" TabIndex="10" Width="136px"></asp:TextBox></td>
                                            <td>
                                                Prioridad</td>
                                            <td>
                                                <asp:DropDownList ID="cbxPrioridad" runat="server" CssClass="FormText" Width="90px"
                                                    TabIndex="3" DataSourceID="odsPrioridad" DataTextField="prioridad" DataValueField="prioridadId"
                                                    OnDataBound="cbxPrioridad_DataBound">
                                                </asp:DropDownList>
                                                &nbsp;<asp:CheckBox ID="chkClienteVip" runat="server" TabIndex="4" CssClass="FormCheck"
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
                                                <asp:Label ID="Label1" runat="server" Text="<%# num++ %>" ForeColor="#000000"></asp:Label>
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="NumInsp" HeaderText="N&#186; de Vehiculos" SortExpression="NumInsp">
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="numSolicitudCliente" HeaderText="N&#176; Solicitud Cliente"
                                            SortExpression="numSolicitudCliente">
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="fechasolicitud" HeaderText="Fecha/Hora Solicitud" SortExpression="fechasolicitud"
                                            DataFormatString="{0:dd-MM-yyyy}" HtmlEncode="False" NullDisplayText="--">
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="numeroSolicitud" HeaderText="N&#186; Solicitud Clave"
                                            SortExpression="numeroSolicitud">
                                            <ItemStyle HorizontalAlign="Center" />
                                            <HeaderStyle Width="100" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Contratante" HeaderText="Contratante" SortExpression="Contratante">
                                            <ItemStyle HorizontalAlign="Center" Width="150px" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Asegurado" HeaderText="Asegurado" SortExpression="Asegurado"
                                            Visible="False">
                                            <ItemStyle HorizontalAlign="Center" Width="150px" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Broker" HeaderText="Broker" SortExpression="Broker">
                                            <ItemStyle HorizontalAlign="Center" Width="150px" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="tiporequerimiento" HeaderText="Tipo Requerimiento" SortExpression="tiporequerimiento">
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="prioridad" HeaderText="Prioridad" SortExpression="Prioridad">
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="canal" HeaderText="Canal" SortExpression="canal">
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="estadosolicitud" HeaderText="Estado" SortExpression="estadosolicitud">
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="FechaCambio" HeaderText="Fecha/Hora Estado" SortExpression="FechaCambio"
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
                        </asp:ObjectDataSource>
                        <asp:ObjectDataSource ID="odsEstado" runat="server" OldValuesParameterFormatString="original_{0}"
                            SelectMethod="GetData" TypeName="dsComboTableAdapters.EstadoSolicitudComboTableAdapter">
                        </asp:ObjectDataSource>
                        <asp:ObjectDataSource ID="odsCanal" runat="server" OldValuesParameterFormatString="original_{0}"
                            SelectMethod="GetData" TypeName="dsComboTableAdapters.CanalComboTableAdapter"></asp:ObjectDataSource>
                        <asp:ObjectDataSource ID="odsPrioridad" runat="server" OldValuesParameterFormatString="original_{0}"
                            SelectMethod="GetData" TypeName="dsComboTableAdapters.PrioridadComboTableAdapter">
                        </asp:ObjectDataSource>
                        <asp:ObjectDataSource ID="odsAseguradoras" runat="server" OldValuesParameterFormatString="original_{0}"
                            SelectMethod="GetData" TypeName="dsComboTableAdapters.ASEGURADORAComboTableAdapter">
                        </asp:ObjectDataSource>
                        <asp:ObjectDataSource ID="odsBroker" runat="server" OldValuesParameterFormatString="original_{0}"
                            SelectMethod="GetData" TypeName="dsComboTableAdapters.BROKERComboTableAdapter"></asp:ObjectDataSource>
                    </td>
                </tr>
            </table>
        </div>
        <br />
    </form>
</body>
</html>
