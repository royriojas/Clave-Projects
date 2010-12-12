<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vListaInspeccion.aspx.cs"
  Inherits="vListaInspeccion" %>

<%@ Register Assembly="WebCalendarControl" Namespace="WebCalendarControl" TagPrefix="cc1" %>
<%@ Register Src="ucHeader.ascx" TagName="ucHeader" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
  <title>CarCheck | Lista de Inspecciones</title>

  <script type="text/javascript" src="Scripts/lib/x.js"></script>

  <script type="text/javascript" src="Scripts/lib/xDropDownMenu.js"></script>

  <script type="text/javascript" src="Scripts/lib/x_common.js"></script>

  <script type="text/javascript" src="Scripts/lib/CollapsibleDiv.js"></script>

  <script type="text/javascript" src="Scripts/lib/x_imageEffects.js"></script>

  <script type="text/javascript" src="Scripts/functions.js"></script>

  <script type="text/javascript">
	  CCSOL.Utiles.LoadCSS("./Scripts/xCommon/xCommon.css");
	 
  </script>

  <script type="text/javascript">		
      CCSOL.Utiles.LoadScript("./Scripts/lib/xDropDownToolTip.js");
	    CCSOL.Utiles.LoadScript("./Scripts/lib/x_especialTooltip.js");
	    CCSOL.Utiles.LoadCSS("./Scripts/x_info/xInfo.css");
	    CCSOL.Utiles.LoadScript("./Scripts/lib/xInfoSystem.js");
    	
	    function activateInfo() {			
		    var info = new infoSystem('holder_info','DivContainer','tt_help_info','tt_title','tt_text');
		    var dropDownTitle = new xDropDownToolTip('aDropDownWithTitle',null);
	    }
	    xAddEventListener(window,'load', activateInfo,false);              
  </script>

  <script type="text/javascript">

		function getRow(elemento, maximo){
			if(maximo > 0){
				if(elemento.parentNode.tagName == "TR")
					return elemento.parentNode;
				else
					return getRow(elemento.parentNode, maximo - 1);
			}else
				return null;
		}
	   	  
       
    function doCallback_Comunicacion(result, context)
    {
            
      CCSOL.DOM.xHideLoadingMessage();
            //$('theLoadingMessage').style.display = 'none';
                        
      var linea=new String(result);            
      var linea2=new String(context);  
            //alert(linea);            
      var divGridContainer = $('divGridComunicacion');
      divGridContainer.innerHTML = linea; 
      var d = $('descripcionLabel');
      d.innerHTML = linea2;                        
            
    }
        
    function HandleError(message)
    {
      CCSOL.DOM.xHideLoadingMessage();
      alert("[Error] : " + message);
    }
	  
	  
	  function cargarInspeccion()
	  {
	    var hvehiculo = $('hflVehisuloID');
	    var hinspeccion = $('hflInspeccionID');
      url = 'vFIDatosPersonales.aspx?VehiculoId=' +hvehiculo.value;
			window.parent.location = url;
			return true;
	  }
	    
	    
		function onDisplayMenu(e){
			xMenu.doShow = true;
			var xE = new xEvent(e);
  		    var theTrigger = xE.target;
  		    var customRow = getRow(theTrigger, 5);
  		    var inspeccionId = CCSOL.DOM.x_GetAttribute(customRow,'inspeccionId');
  		    var vehiculoId = CCSOL.DOM.x_GetAttribute(customRow,'VehiculoId');
  		    var contacto = CCSOL.DOM.x_GetAttribute(customRow,'contacto');
  		    var hvehiculo = $('hflVehisuloID');
  		    hvehiculo.value = vehiculoId;
  		    var hinspeccion = $('hflInspeccionID');
  		    hinspeccion.value = inspeccionId;
  		    var context = '<div><strong style="font-size: 11px">Contacto: ' + contacto + '</strong><br/></div>';
   
			<%=ClientScript.GetCallbackEventReference(this.callback_gridComunicacion, "inspeccionId", "doCallback_Comunicacion", "context", "HandleError", false) %>;       

		}
		  
    var xMenu;
    
    function cleaningFunction() {
      var divGridContainer = $('divGridComunicacion');
      divGridContainer.innerHTML = ''; 
      var d = $('descripcionLabel');
      d.innerHTML = '';         
    }
    
    function createDropDownMenu() {
      xMenu = new xDropDownMenu('ToolTipInspeccion',       //el div que aparecerá en el punto de click
								      'ListaInspeccionGridView', //el "map" area que contiene los hotspots que provocarán que aparezca el PopUpForm
								      'context',		 //Se muestra en el punto de click ('d' = dropDownMenu,null = en el punto de click, 'context' = menu contextual
								      'click',			 //el evento al que queremos asociar la aparición del Div
								      null,			 	 //posicion en la que queremos que aparezca el div, 'left', 'right' o null solo tiene sentido cuando el menu es tipo 'd'
								      onDisplayMenu,
								      null,
								      false,
								      cleaningFunction
								      );//,	onAutoHide);
    }
    
    CCSOL.Utiles.LoadScript("./Scripts/lib/xTable.js");
    window.onload = function () {
      try {
        createDropDownMenu();
        var b = new CollapsibleDiv ('imgCollapse', 'frmBusqueda', true, null);
        
         var xtable = new xTable('ListaInspeccionGridView',   //el Identificador de la tabla
				                         'ItemStyleSelected',            //el Style ItemSeleccionado
				                         'ItemStyleOver');       //el Style Over
                    		
        
      }
      catch(e)
      {
        alert(e.message);
      }
    }
    
  </script>

  <link href="css/layout.css" rel="stylesheet" type="text/css" />
  <link href="css/layout.css" rel="stylesheet" type="text/css" />
</head>
<body>
  <form id="form1" method="post" runat="server">
    <div>
      <table id="Data" border="0" cellpadding="0" cellspacing="0" align="center">
        <tr>
          <td>
            <uc1:ucHeader ID="UcHeader1" runat="server" TabActual="listaInspecciones" />
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
                      <td style="width: 130px">
                        Placa</td>
                      <td>
                        <asp:TextBox ID="txtPlaca" runat="server" CssClass="FormText" TabIndex="1" Width="136px"></asp:TextBox></td>
                      <td style="width: 130px">
                        Aseguradora</td>
                      <td>
                        <asp:DropDownList ID="cbxAseguradora" runat="server" AppendDataBoundItems="True"
                          CssClass="FormText tt_help_info aDropDownWithTitle" DataSourceID="odsAseguradoras"
                          DataTextField="persona" DataValueField="personaId" TabIndex="2" Width="140px">
                          <asp:ListItem Value="-1">[ - Elija - ]</asp:ListItem>
                        </asp:DropDownList></td>
                      <td style="width: 130px">
                        Fecha/Hora Solicitud</td>
                      <td>
                        <asp:TextBox ID="txtFechaHoraSolicitud" runat="server" CssClass="FormText" TabIndex="3"
                          Width="136px"></asp:TextBox></td>
                      <td rowspan="5" style="padding-left: 3px" valign="top">
                        <asp:ImageButton ID="btnBuscar" CssClass="MakeClear" runat="server" AlternateText="Buscar Solicitudes"
                          ImageUrl="~/Images/btnBuscar.gif" />
                      </td>
                    </tr>
                    <tr>
                      <td style="width: 130px">
                        Nº Solicitud Cliente</td>
                      <td>
                        <asp:TextBox ID="txtNumSolicitudCia" runat="server" CssClass="FormText" TabIndex="4"
                          Width="136px"></asp:TextBox></td>
                      <td style="width: 130px">
                        Broker</td>
                      <td>
                        <asp:DropDownList ID="cbxBroker" runat="server" AppendDataBoundItems="True" CssClass="FormText tt_help_info aDropDownWithTitle"
                          DataSourceID="odsBroker" DataTextField="persona" DataValueField="personaId" TabIndex="5"
                          Width="140px">
                          <asp:ListItem Value="-1">[ - Elija - ]</asp:ListItem>
                        </asp:DropDownList></td>
                      <td style="width: 130px">
                        Solicitado por</td>
                      <td>
                        <asp:TextBox ID="txtSolicitadoPor" runat="server" CssClass="FormText" TabIndex="6"
                          Width="136px"></asp:TextBox></td>
                    </tr>
                    <tr>
                      <td style="width: 130px">
                        Nº Solicitud Clave</td>
                      <td style="">
                        <asp:TextBox ID="txtNumSolicitudClave" runat="server" CssClass="FormText" TabIndex="7"
                          Width="136px"></asp:TextBox></td>
                      <td style="width: 130px;">
                        Canal</td>
                      <td style="">
                        <asp:DropDownList ID="cbxCanal" runat="server" AppendDataBoundItems="True" CssClass="FormText tt_help_info aDropDownWithTitle"
                          DataSourceID="odsCanal" DataTextField="canal" DataValueField="canalId" TabIndex="8"
                          Width="140px">
                          <asp:ListItem Value="-1">[ - Elija - ]</asp:ListItem>
                        </asp:DropDownList></td>
                      <td style="width: 130px">
                        Tipo Requerimiento
                      </td>
                      <td style="">
                        <asp:DropDownList ID="cbxTipoRequerimiento" runat="server" AppendDataBoundItems="True"
                          CssClass="FormText tt_help_info aDropDownWithTitle" DataSourceID="odsRequerimiento"
                          DataTextField="trequerimiento" DataValueField="trequerimientoId" TabIndex="9" Width="140px">
                          <asp:ListItem Value="">[ - Elija - ]</asp:ListItem>
                        </asp:DropDownList></td>
                    </tr>
                    <tr>
                      <td style="width: 130px">
                        Nº Inspección</td>
                      <td>
                        <asp:TextBox ID="txtNumInspeccion" runat="server" CssClass="FormText" TabIndex="10"
                          Width="136px"></asp:TextBox></td>
                      <td style="width: 130px">
                        Contratante</td>
                      <td>
                        <asp:TextBox ID="txtContratante" runat="server" CssClass="FormText" TabIndex="11"
                          Width="136px"></asp:TextBox></td>
                      <td style="width: 130px">
                        Estado Solicitud</td>
                      <td>
                        <asp:DropDownList ID="cbxEstado" runat="server" AppendDataBoundItems="True" CssClass="FormText tt_help_info aDropDownWithTitle"
                          DataSourceID="odsEstadoSolicitud" DataTextField="estadoSolicitud" DataValueField="estadoSolicitudId"
                          TabIndex="12" Width="140px">
                          <asp:ListItem Value="">[ - Elija - ]</asp:ListItem>
                        </asp:DropDownList></td>
                    </tr>
                    <tr>
                      <td style="width: 130px">
                        Cliente</td>
                      <td style="">
                        <asp:DropDownList ID="cbxCliente" runat="server" AppendDataBoundItems="True" CssClass="FormText tt_help_info aDropDownWithTitle"
                          DataSourceID="odsCliente" DataTextField="persona" DataValueField="personaId" TabIndex="13"
                          Width="140px">
                          <asp:ListItem Value="-1">[ - Elija - ]</asp:ListItem>
                        </asp:DropDownList></td>
                      <td style="width: 130px;">
                        Asegurado</td>
                      <td style="">
                        <asp:TextBox ID="txtAsegurado" runat="server" CssClass="FormText" TabIndex="14" Width="136px"></asp:TextBox></td>
                      <td style="width: 130px">
                        Prioridad</td>
                      <td style="">
                        <asp:DropDownList ID="cbxPrioridad" runat="server" AppendDataBoundItems="True" CssClass="FormText tt_help_info aDropDownWithTitle"
                          DataSourceID="odsPrioridad" DataTextField="prioridad" DataValueField="prioridadId"
                          TabIndex="15" Width="140px">
                          <asp:ListItem Value="">[ - Elija - ]</asp:ListItem>
                        </asp:DropDownList>
                      </td>
                    </tr>
                    <tr>
                      <td style="height: 17px; width: 130px;">
                      </td>
                      <td style="height: 17px" valign="bottom">
                        <asp:CheckBox ID="chkClienteVip" runat="server" CssClass="FormCheck" TabIndex="16"
                          Text="VIP  " TextAlign="Left" />
                        <asp:CheckBox ID="chkPagada" runat="server" Text="PAGADA" TextAlign="Left" CssClass="FormCheck"
                          TabIndex="17" /></td>
                      <td style="height: 17px; width: 130px;">
                      </td>
                      <td style="height: 17px">
                      </td>
                      <td style="height: 17px; width: 130px;">
                      </td>
                      <td style="height: 17px">
                      </td>
                      <td rowspan="1" style="height: 17px" valign="top">
                      </td>
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
                  Text="Lista de Inspecciones"></asp:Label>
                <div class="hr">
                </div>
                <asp:GridView ID="ListaInspeccionGridView" runat="server" CssClass="GridLista" AutoGenerateColumns="False"
                  PageSize="15" EmptyDataText="No se encontraron ocurrencias" AllowPaging="True"
                  BorderStyle="Solid" DataSourceID="odsListaInspecciones" OnRowDataBound="ListaInspeccionGridView_RowDataBound"
                  AllowSorting="True">
                  <HeaderStyle CssClass="HeaderStyle" />
                  <RowStyle CssClass="ItemStyle" />
                  <PagerStyle CssClass="PagerStyle" />
                  <Columns>
                    <asp:BoundField DataField="solicitudId" HeaderText="N&#186; Solicitud" SortExpression="solicitudId">
                      <HeaderStyle Width="80px" />
                      <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                    </asp:BoundField>
                    <asp:BoundField DataField="numeInspeccion" HeaderText="N&#186; Inspecci&#243;n "
                      SortExpression="numeInspeccion">
                      <HeaderStyle Width="90px" />
                      <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                    </asp:BoundField>
                    <asp:BoundField DataField="fsolicitud" HeaderText="Fecha Solicitud" SortExpression="fsolicitud" />
                    <asp:BoundField DataField="fechaCambio" DataFormatString="{0:dd/MM/yyyy HH:mm}" HeaderText="Fecha Inspecci&#243;n"
                      HtmlEncode="False" SortExpression="fechaCambio">
                      <ItemStyle HorizontalAlign="Center" />
                      <HeaderStyle Width="110px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="aseguradora" HeaderText="Aseguradora" SortExpression="aseguradora" />
                    <asp:BoundField DataField="broker" HeaderText="Broker" SortExpression="broker" />
                    <asp:BoundField DataField="asegurado" HeaderText="Asegurado" SortExpression="asegurado">
                      <HeaderStyle Width="150px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="placa" HeaderText="Placa" SortExpression="placa">
                      <HeaderStyle Width="60px" />
                    </asp:BoundField>
                    <asp:BoundField HeaderText="Marca" DataField="marcaVehiculo" SortExpression="marcaVehiculo" />
                    <asp:BoundField HeaderText="A&#241;o" DataField="anhoFabricacion" SortExpression="anhoFabricacion"
                      DataFormatString="{0:yyyy}" HtmlEncode="False">
                      <HeaderStyle Width="40px" />
                      <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField HeaderText="V. Comercial" DataField="valorComercial" SortExpression="valorComercial">
                      <HeaderStyle Width="80px" />
                    </asp:BoundField>
                    <asp:BoundField HeaderText="Estado" DataField="estadoInspeccionId" SortExpression="estadoInspeccionId" />
                    <asp:BoundField DataField="contacto" HeaderText="contacto" SortExpression="contacto" />
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
            <asp:ObjectDataSource ID="odsCliente" runat="server" OldValuesParameterFormatString="original_{0}"
              SelectMethod="GetData" TypeName="ADM_DAL.dsDropDownListTableAdapters.ClienteLoadDropDownTableAdapter">
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
            &nbsp;
            <asp:ObjectDataSource ID="odsCanal" runat="server" OldValuesParameterFormatString="original_{0}"
              SelectMethod="GetData" TypeName="dsComboTableAdapters.CanalComboTableAdapter">
              <SelectParameters>
                <asp:Parameter DefaultValue="A" Name="estado" Type="String" />
              </SelectParameters>
            </asp:ObjectDataSource>
            <asp:ObjectDataSource ID="odsRequerimiento" runat="server" OldValuesParameterFormatString="original_{0}"
              SelectMethod="GetData" TypeName="dsComboTableAdapters.TipoRequerimientoComboTableAdapter">
              <SelectParameters>
                <asp:Parameter DefaultValue="A" Name="estado" Type="String" />
              </SelectParameters>
            </asp:ObjectDataSource>
            <asp:ObjectDataSource ID="odsEstadoSolicitud" runat="server" OldValuesParameterFormatString="original_{0}"
              SelectMethod="GetData" TypeName="dsComboTableAdapters.EstadoSolicitudComboTableAdapter">
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
            <asp:ObjectDataSource ID="odsListaInspecciones" runat="server" OldValuesParameterFormatString="original_{0}"
              SelectMethod="GetData" TypeName="dsInspeccionesTableAdapters.InspeccionListaFiltrosTableAdapter"
              OnSelected="odsInspeccionLista_Selected">
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
                <asp:ControlParameter ControlID="cbxPrioridad" Name="prioridadId" PropertyName="SelectedValue"
                  Type="String" />
                <asp:ControlParameter ControlID="cbxPrioridad" Name="estadoId" PropertyName="SelectedValue"
                  Type="String" />
                <asp:ControlParameter ControlID="chkClienteVip" Name="clienteVIP" PropertyName="Checked"
                  Type="Boolean" />
                <asp:ControlParameter ControlID="chkPagada" Name="pagado" PropertyName="Checked"
                  Type="Boolean" />
              </SelectParameters>
            </asp:ObjectDataSource>
          </td>
        </tr>
      </table>
    </div>
    <br />
    <div id="ToolTipInspeccion" class="ToolTip" style="position: absolute; width: 280px;">
      <div id="descripcionLabel" style="margin-bottom: 2px; height: 18px; display: block;">
        <strong style="font-size: 11px">Contacto:</strong>
      </div>
      <asp:Button ID="btnGoToInspeccion" runat="server" style="position: absolute; right: 2px;cursor:pointer;
        top: 2px;" CssClass="FormButton" OnClientClick="cargarInspeccion();return false;"
        Text="Inspección" Width="80px" />
      <div id="divGridComunicacion">
        <asp:GridView CssClass="tableGrid" ID="comunicacionGridView" runat="server" AutoGenerateColumns="False"
          DataKeyNames="comunicacionId" BorderStyle="Solid" BorderWidth="1px" Width="281px"
          BorderColor="Black" ForeColor="Black" HorizontalAlign="Left" CellPadding="1">
          <Columns>
            <asp:BoundField DataField="fcomunicacion" HeaderText="Fecha/Hora" SortExpression="Fecha Comunicaci&#243;n"
              DataFormatString="{0:dd/MM/yyyy}">
              <HeaderStyle Font-Bold="True" Font-Overline="False" />
            </asp:BoundField>
            <asp:BoundField DataField="tcomunicacionId" HeaderText="Actividad" SortExpression="tcomunicacionId" />
            <asp:BoundField DataField="estadoInspeccion" HeaderText="Estado" SortExpression="estadoInspeccion" />
          </Columns>
          <HeaderStyle BorderColor="Black" BorderWidth="1px" BorderStyle="Solid" Font-Bold="True"
            Font-Names="Arial" Font-Size="8pt" ForeColor="Black" />
          <RowStyle BorderColor="Black" />
        </asp:GridView>
      </div>
    </div>
    <asp:HiddenField ID="hflVehisuloID" runat="server" />
    <asp:HiddenField ID="hflInspeccionID" runat="server" />
  </form>
</body>
</html>
