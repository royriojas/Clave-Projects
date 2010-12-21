<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vItinerario.aspx.cs" Inherits="vItinerario" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
	<title><%= CCSOL.Utiles.Utilidades.GetSystemNameAndVersion() %> | Itinerarios</title>


	<script type="text/javascript">
	

    function Print(){ 

      // escondemos el botón de impresión, mandamos a imprimir, y los mostramos de nuevo
      document.getElementById('btnImprimir').style.display='none'; 
      window.print(); 
      document.getElementById('btnImprimir').style.display=''; 
    }
	  function Go()
	  {
  		
	  }
  	
	  window.onload = function()
	  {
	  }
	</script>

</head>
<body>

	<form id="form1" runat="server">
		<div>
			<table border="0" cellpadding="0" cellspacing="0" width="100%">
				<tr>
					<td>
						<asp:DropDownList ID="inspectorIdCombo" runat="server" Style="border: none White 0px"
							Font-Bold="False" Width="250px" AppendDataBoundItems="True" AutoPostBack="True" DataSourceID="odsInspectores" DataTextField="persona" DataValueField="PersonaId" CssClass="FormText">
							<asp:ListItem Value="-1">- TODOS -</asp:ListItem>
						</asp:DropDownList><asp:ObjectDataSource ID="odsInspectores" runat="server" OldValuesParameterFormatString="original_{0}"
              SelectMethod="GetData" TypeName="dsComboTableAdapters.InspectorComboTableAdapter">
              <SelectParameters>
                <asp:Parameter DefaultValue="A" Name="estado" Type="String" />
              </SelectParameters>
            </asp:ObjectDataSource>
          </td>
				</tr>
        <tr>
          <td>
          </td>
        </tr>
				<tr>
					<td style="font-size: 12px; font-family: Arial">
            <asp:GridView ID="gvItinerario" runat="server" AutoGenerateColumns="False"
              DataSourceID="odsItinerario" ShowHeader="False">
              <Columns>
                <asp:TemplateField>
                  <ItemTemplate>
						<table border="1" cellpadding="1" cellspacing="0" bordercolor="#999999">
							<tr>
								<td width="75" style="font-weight: bold; height: 19px;">
									Nº Solicitud</td>
								<td width="200" style="height: 19px">
                  <asp:Label ID="numSolicitud" runat="server" Text='<%# Eval("numeSolicitud") %>'></asp:Label></td>
								<td style="font-weight: bold; height: 19px;" width="75">
									Fecha / Hora</td>
								<td width="200" style="height: 19px">
                  <asp:Label ID="Fecha" runat="server" Text='<%# Eval("fcitaInicio", "{0:dd/MM/yyyy HH:mm}") %>'></asp:Label></td>
							</tr>
							<tr>
								<td style="font-weight: bold">
									Dirección</td>
								<td>
                  <asp:Label ID="Direccion" runat="server" Text='<%# Eval("direccion") %>'></asp:Label></td>
								<td style="font-weight: bold">
									Ubigeo</td>
								<td>
                  <asp:Label ID="Ubigeo" runat="server" Text='<%# Eval("ubigeo") %>'></asp:Label></td>
							</tr>
							<tr>
								<td style="font-weight: bold">
									Contacto</td>
								<td>
                  <asp:Label ID="Contacto" runat="server" Text='<%# Eval("contacto") %>'></asp:Label></td>
								<td style="font-weight: bold">
                  Teléfonos</td>
								<td>
                  <asp:Label ID="Teléfono" runat="server" Text='<%# Eval("telefonocontacto") %>'></asp:Label></td>
							</tr>
							<tr>
								<td style="font-weight: bold">
									Asegurado</td>
								<td colspan="3">
                  <asp:Label ID="Asegurado" runat="server" Text='<%# Eval("asegurado") %>'></asp:Label></td>
							</tr>
							<tr>
								<td style="font-weight: bold" valign="top">
                  Vehículo</td>
								<td colspan="3">
									<table border="0" cellpadding="1" cellspacing="0">
										<tr>
											<td style="font-weight: bold" width="75">
												Placa</td>
											<td style="font-weight: bold" width="150">
												Marca</td>
											<td style="font-weight: bold" width="200">
												Modelo</td>
										</tr>
										<tr>
											<td width="75">
                        <asp:Label ID="Placa" runat="server" Text='<%# Eval("placa") %>'></asp:Label></td>
											<td width="150">
                        <asp:Label ID="Marca" runat="server" Text='<%# Eval("marcaVehiculo") %>'></asp:Label></td>
											<td width="200">
                        <asp:Label ID="Modelo" runat="server" Text='<%# Eval("modeloVehiculo") %>'></asp:Label></td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
                  </ItemTemplate>
                </asp:TemplateField>
              </Columns>
              <EmptyDataTemplate>
                No existe Itinerario para el Inspector en la Fecha Seleccionada
              </EmptyDataTemplate>
            </asp:GridView>
            &nbsp;<br />
					</td>
				</tr>
			</table>
			<input type="button" onclick="javascript: Print();" value="Imprimir" name="btnImprimir" id="btnImprimir" />


      <asp:ObjectDataSource ID="odsItinerario" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetData" TypeName="dsAgendaTableAdapters.ItinerarioInspeccionesTableAdapter">
        <SelectParameters>
          <asp:QueryStringParameter DefaultValue="10-01-2007" Name="fecha" QueryStringField="Fecha"
            Type="String" />
          <asp:ControlParameter ControlID="inspectorIdCombo" DefaultValue="1" Name="inspectorId"
            PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
      </asp:ObjectDataSource>
    </div>
	</form>
</body>
</html>
