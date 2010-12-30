<%@ Page Language="C#" EnableViewState="true" EnableEventValidation="false" AutoEventWireup="true"
  CodeFile="vListaSolicitud.aspx.cs" Inherits="vListaSolicitud" %>

<%@ Register Assembly="CustomPanelWebControl" Namespace="xWebControl" TagPrefix="cc2" %>
<%@ Register Assembly="WebCalendarControl" Namespace="WebCalendarControl" TagPrefix="cc1" %>
<%@ Register Src="ucHeader.ascx" TagName="ucHeader" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
  <title>
    <%= CCSOL.Utiles.Utilidades.GetSystemNameAndVersion() %>
    | Lista de Solicitudes</title>

  <script type="text/javascript" src="Scripts/lib/x.js"></script>

  <link href="Css/code.css" rel="stylesheet" type="text/css" />

  <script type="text/javascript" src="Scripts/lib/x_common.js"></script>

  <script type="text/javascript">
  
  //llamandose ahora desde el Header
//      //Permite obtener el efecto de rollOver sobre una grilla, además de dejar seleccionada la fila a la que se le hizo click
//    CCSOL.Utiles.LoadScript("./Scripts/lib/xTable.js");   
    function createTableOverEffect() { 
      if (true) //SOLO CREAMOS EL EFECTO OVER CUANDO HAYA AL MENOS UNA FILA
      {   
        var xtable = new xTable('ListaSolicitudGridView',   //el Identificador de la tabla
				                        'ItemStyleSelected',    //el Style ItemSeleccionado
				                        'ItemStyleOver');       //el Style Over
      }
      
    } 
    window.onload = function () {
        try {
            var b = new CollapsibleDiv ('imgCollapse',
						 'frmBusqueda',
						 true,
						 null
						) 
						createTableOverEffect(); 	
        }
        catch(e)
        {
            alert(e.message);
        }
     $('txtPlaca').focus();
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
            <uc1:ucHeader ID="UcHeader1" MainFormName="form1" PageFunctionalityToCheck="SOLICITUD_LISTA_VER"
              runat="server" TabActual="listaSolicitudes" />
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
                    title="Mostrar/Ocultar" style="margin-top: 3px;" class="MakeClear" />
                </div>
                <div id="frmBusqueda" class="DataTable">
                  <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                      <td style="width: 110px">
                        Placa</td>
                      <td>
                        <asp:TextBox ID="txtPlaca" runat="server" CssClass="FormText" Width="136px" TabIndex="100"></asp:TextBox></td>
                      <td style="width: 115px">
                        Aseguradora</td>
                      <td>
                        <asp:DropDownList ID="cbxAseguradora" runat="server" CssClass="FormText tt_help_info aDropDownWithTitle" Width="140px"
                          TabIndex="125" DataSourceID="odsAseguradoras" DataTextField="persona" DataValueField="personaId"
                          AppendDataBoundItems="True" OnDataBound="cbxAseguradora_DataBound">
                          <asp:ListItem Value="-1">[ - Elija - ]</asp:ListItem>
                        </asp:DropDownList></td>
                      <td style="width: 115px">
                        Fecha/Hora Solicitud</td>
                      <td>
                        <asp:TextBox ID="txtFechaHoraSolicitud" runat="server" CssClass="FormText" TabIndex="150"
                          Width="136px"></asp:TextBox></td>
                      <td rowspan="5" style="padding-left: 3px" valign="top">
                        <asp:ImageButton ID="btnBuscar" keycode='2' CssClass="MakeClear SHORTCUT" runat="server" ImageUrl="~/Images/btnBuscar.gif"
                          AlternateText="Buscar Solicitudes"></asp:ImageButton>
                        <cc2:xWebPanelControl PermissionToCheck="SOLICITUD_CREAR" ID="XWebPanelControl1"
                          runat="server">
                          <asp:ImageButton CssClass="MakeClear SHORTCUT" keycode='14' ID="imgBtnNuevaSolcitud" runat="server" ImageUrl="~/Images/btnNuevaSolicitud.jpg"
                            OnClick="imgBtnNuevaSolcitud_Click" OnClientClick="return confirm('¿Confirma que desea crear una nueva Solicitud?');" />
                        </cc2:xWebPanelControl>
                      </td>
                    </tr>
                    <tr>
                      <td>
                        Nº Solicitud Cliente</td>
                      <td>
                        <asp:TextBox ID="txtNumSolicitudCia" runat="server" CssClass="FormText" Width="136px"
                          TabIndex="105"></asp:TextBox></td>
                      <td style="width: 115px">
                        Broker</td>
                      <td>
                        <asp:DropDownList ID="cbxBroker" runat="server" CssClass="FormText tt_help_info aDropDownWithTitle"
                          Width="140px" TabIndex="130" DataSourceID="odsBroker" DataTextField="persona" DataValueField="personaId"
                          AppendDataBoundItems="True" OnDataBound="cbxBroker_DataBound">
                          <asp:ListItem Value="-1">[ - Elija - ]</asp:ListItem>
                        </asp:DropDownList></td>
                      <td>
                        Solicitado por</td>
                      <td>
                        <asp:TextBox ID="txtSolicitadoPor" runat="server" CssClass="FormText" Width="136px"
                          TabIndex="155"></asp:TextBox></td>
                    </tr>
                    <tr>
                      <td style="height: 18px">
                        Nº Solicitud Clave</td>
                      <td style="height: 18px">
                        <asp:TextBox ID="txtNumSolicitudClave" runat="server" CssClass="FormText" TabIndex="110"
                          Width="136px"></asp:TextBox></td>
                      <td style="width: 115px; height: 18px;">
                        Canal</td>
                      <td style="height: 18px">
                        <asp:DropDownList ID="cbxCanal" runat="server" CssClass="FormText tt_help_info aDropDownWithTitle"
                          Width="140px" TabIndex="135" DataSourceID="odsCanal" DataTextField="canal" DataValueField="canalId"
                          AppendDataBoundItems="True">
                          <asp:ListItem Value="-1">[ - Elija - ]</asp:ListItem>
                        </asp:DropDownList></td>
                      <td style="height: 18px">
                        Tipo Requerimiento
                      </td>
                      <td style="height: 18px">
                        <asp:DropDownList ID="cbxTipoRequerimiento" runat="server" CssClass="FormText tt_help_info aDropDownWithTitle"
                          Width="140px" TabIndex="160" DataSourceID="odsTipoRequerimiento" DataTextField="trequerimiento"
                          DataValueField="trequerimientoId" AppendDataBoundItems="True">
                          <asp:ListItem Value="-1">[ - Elija - ]</asp:ListItem>
                        </asp:DropDownList></td>
                    </tr>
                    <tr>
                      <td>
                        Nº Inspección</td>
                      <td>
                        <asp:TextBox ID="txtNumInspeccion" runat="server" CssClass="FormText" Width="136px"
                          TabIndex="115"></asp:TextBox></td>
                      <td style="width: 115px">
                        Contratante</td>
                      <td>
                        <asp:TextBox ID="txtContratante" runat="server" CssClass="FormText" Width="136px"
                          TabIndex="140"></asp:TextBox></td>
                      <td>
                        Estado Solicitud</td>
                      <td>
                        <asp:DropDownList ID="cbxEstado" runat="server" CssClass="FormText tt_help_info aDropDownWithTitle"
                          Width="140px" TabIndex="165" DataSourceID="odsEstado" DataTextField="estadoSolicitud"
                          DataValueField="estadoSolicitudId" AppendDataBoundItems="True">
                          <asp:ListItem Value="-1">[ - Elija - ]</asp:ListItem>
                        </asp:DropDownList></td>
                    </tr>
                    <tr>
                      <td>
                        Cliente</td>
                      <td>
                        <asp:DropDownList ID="cbxCliente" runat="server" CssClass="FormText tt_help_info aDropDownWithTitle"
                          Width="140px" TabIndex="120" DataSourceID="odsCliente" DataTextField="persona" DataValueField="personaId"
                          AppendDataBoundItems="True" OnDataBound="cbxCliente_DataBound">
                          <asp:ListItem Value="-1">[ - Elija - ]</asp:ListItem>
                        </asp:DropDownList></td>
                      <td>
                        Asegurado</td>
                      <td>
                        <asp:TextBox ID="txtAsegurado" runat="server" CssClass="FormText" TabIndex="145" Width="136px"></asp:TextBox></td>
                      <td>
                        Prioridad</td>
                      <td>
                        <asp:DropDownList ID="cbxPrioridad" runat="server" CssClass="FormText tt_help_info aDropDownWithTitle"
                          Width="90px" TabIndex="170" DataSourceID="odsPrioridad" DataTextField="prioridad"
                          DataValueField="prioridadId" AppendDataBoundItems="True">
                          <asp:ListItem Value="-1">[ - Elija - ]</asp:ListItem>
                        </asp:DropDownList>
                        <asp:CheckBox ID="chkClienteVip" runat="server" TabIndex="175" CssClass="FormCheck"
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
                  BorderStyle="Solid" OnRowDataBound="ListaSolicitudGridView_RowDataBound"
                  AllowSorting="True" DataSourceID="odsSolicitudLista">
                  <HeaderStyle CssClass="HeaderStyle" />
                  <RowStyle CssClass="ItemStyle" />
                  <PagerStyle CssClass="PagerStyle" />
                  <Columns>
                    <asp:TemplateField HeaderText="N&#186;">
                      <ItemStyle HorizontalAlign="Center" Width="10px" />
                      <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text="<%# num++ %>"></asp:Label>
                      </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="numeVehiculos" HeaderText="N&#186; V." SortExpression="numeVehiculos">
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
                    <asp:BoundField DataField="numeSolicitud" HeaderText="N&#186; Solicitud Clave" SortExpression="numeSolicitud">
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
