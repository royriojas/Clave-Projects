<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vValorComercial.aspx.cs"
  Inherits="vValorComercial" %>

<%@ Register Src="ucHeader.ascx" TagName="ucHeader" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
  <title>
    <%=CCSOL.Utiles.Utilidades.GetSystemNameAndVersion() %>
    | Valores Comerciales</title>
  <link href="Css/layout.css" rel="stylesheet" type="text/css" />
  <!-- la libreria x.js ya esta incluida en el header!!!-->

  <script type="text/javascript" src="Scripts/lib/x.js"></script>

  <script type="text/javascript" src="Scripts/lib/x_common.js"></script>

  <script type="text/javascript">		

	CCSOL.Utiles.LoadScript("./Scripts/lib/xForms.js");			
	window.onload = function () {
		xAddEventListener($('cbxClase'),'change',getMarcasFromAjax,false);		
		xAddEventListener($('imgSearch'),'click',getValorcomercial,false);
		xAddEventListener($('txtAnho'),'keypress',doKeyPress,false);		
	}    
	function doKeyPress(evt) {
	  var xE = new xEvent(evt);
	  if (xE.keyCode == 13) $('imgSearch').click();
	}
  function getMarcasFromAjax() {
    var cbxClase = $('cbxClase');
    var claseId = cbxClase.options[cbxClase.selectedIndex].value;
    vValorComercial.getMarcasVehiculo(claseId,getMarcas_handler);
    clearOptions('cbxMarca');
    clearOptions('cbxModelo');
    CCSOL.DOM.xShowLoadingMessage();
    xRemoveEventListener($('cbxMarca'),'change',getModelosFromAjax,false);
  }	
    
  function getMarcas_handler(res) {	    	    	      
	    try {
	        var arr = res.value;
	        addOptions('cbxMarca',res.value);
	        xAddEventListener($('cbxMarca'),'change',getModelosFromAjax,false);
	        CCSOL.DOM.xHideLoadingMessage();
	    }
	    catch(e) {
	        alert('res_handler : ' + e.message);
	    }
	}
    
    function getModelosFromAjax() {
        var cbxClase = $('cbxClase');
        var claseId = cbxClase.options[cbxClase.selectedIndex].value;
        
        var cbxMarca = $('cbxMarca');
        var marcaId = cbxMarca.options[cbxMarca.selectedIndex].value;

        vValorComercial.getModelosVehiculo(claseId,marcaId,getModelos_handler);        
        clearOptions('cbxModelo');  
        CCSOL.DOM.xShowLoadingMessage();                      
        
    }
    function getValorcomercial(){
    
        $('txtValorComercial').value = '';
        
        var shouldDoAjaxCall = false;
        var mensaje = '';
        
        var cbxClase = $('cbxClase');
        var claseId = cbxClase.options[cbxClase.selectedIndex].value;
        
        if (claseId == '-1') mensaje += 'Debe elegir una clase\n';
        
        var cbxMarca = $('cbxMarca');
        var marcaId = cbxMarca.options[cbxMarca.selectedIndex].value;
        
        if (marcaId == '-1') mensaje += 'Debe elegir una marca\n';
        
        var cbxModelo = $('cbxModelo');
        var modeloId = cbxModelo.options[cbxModelo.selectedIndex].value;
        
        if (modeloId == '-1') mensaje += 'Debe elegir un modelo\n';
        
        var anho = $('txtAnho').value;
        
        if (anho == '') mensaje += 'Debe ingresar un año válido\n';
        
        shouldDoAjaxCall = mensaje == '';
        
        isValidPage = Page_ClientValidate();
        
        if (!isValidPage) mensaje += 'verifique el formato del año';
        if (shouldDoAjaxCall && isValidPage) {
          vValorComercial.getValorComercial(claseId,marcaId,modeloId,anho,getValor_handler);    
          CCSOL.DOM.xShowLoadingMessage('Buscando Valores');     
        }
        else {
          alert(mensaje);                    
        }
        
        return false;            
    }
    function getValor_handler(res){
      try {
	        var vc = res.value;
	        if (vc.valor != ''){
            $('txtValorComercial').value = vc.valor;        
          }
          else { 
            $('txtValorComercial').value = 'Valor No Registrado';
          }
           CCSOL.DOM.xHideLoadingMessage();   
	    }
	    catch(e) {
	        alert('res_handler : ' + e.message);
	    }        
    }
    function getModelos_handler(res) {
         try {
	        var arr = res.value;
	        addOptions('cbxModelo',res.value);	 
	        CCSOL.DOM.xHideLoadingMessage();       
	    }
	    catch(e) {
	        alert('res_handler : ' + e.message);
	    }
    }
    
	
	
  </script>

  <link href="css/layout.css" rel="stylesheet" type="text/css" />
</head>
<body>
  <form id="form1" runat="server">
    <div>
      <table id="Data" border="0" cellpadding="0" cellspacing="0" align="center">
        <tr>
          <td>
            <uc1:ucHeader ID="UcHeader1" runat="server" TabActual="valoresComerciales" PageFunctionalityToCheck="VALOR_COMERCIAL_VER" />
            <div class="DataTop">
              <div class="DataTopLeft">
              </div>
              <div class="DataTopRight">
              </div>
            </div>
            <div class="DataContent">
              <div class="DataContentRight" style="padding-top: 1px">
                <div class="PanelEncabezado">
                  <asp:Label ID="lblTitulo" runat="server" Style="cursor: default" Text="Valores Comerciales"></asp:Label>
                  <img id="Img1" alt="Mostrar / Ocultar Panel" class="MakeClear" src="Images/IconHide16Dark.gif"
                    style="margin-top: 3px" title="Mostrar/Ocultar" />
                </div>
                <div class="PanelStyle" style="margin-top: 4px">
                  <div class="DataTable" style="position:relative">
                    <table border="0" cellpadding="0" cellspacing="0">
                      <tr>
                        <td style="height: 18px; width: 136px;">
                          Clase
                        </td>
                        <td colspan="3" style="height: 18px; width: 156px;">
                          <asp:DropDownList ID="cbxClase" runat="server" CssClass="FormText tt_help_info aDropDownWithTitle"
                            Width="154px" DataSourceID="odsClase" DataTextField="claseVehiculo" DataValueField="claseVehiculoId"
                            AppendDataBoundItems="True">
                            <asp:ListItem Selected="True" Value="-1">[ - Elija - ]</asp:ListItem>
                          </asp:DropDownList></td>
                        <td colspan="1" style="width: 62px; height: 18px">
                        </td>
                      </tr>
                      <tr>
                        <td style="height: 18px; width: 136px;">
                          Marca</td>
                        <td colspan="3" style="height: 18px; width: 156px;">
                          <asp:DropDownList ID="cbxMarca" runat="server" CssClass="FormText tt_help_info aDropDownWithTitle"
                            Width="154px" AppendDataBoundItems="True">
                            <asp:ListItem Selected="True" Value="-1">[ - Elija - ]</asp:ListItem>
                          </asp:DropDownList></td>
                        <td colspan="1" style="width: 62px; height: 18px">
                        </td>
                      </tr>
                      <tr>
                        <td style="height: 18px; width: 136px;">
                          Modelo</td>
                        <td colspan="3" style="height: 18px; width: 156px;">
                          <asp:DropDownList ID="cbxModelo" runat="server" CssClass="FormText tt_help_info aDropDownWithTitle"
                            Width="154px" AppendDataBoundItems="True">
                            <asp:ListItem Selected="True" Value="-1">[ - Elija - ]</asp:ListItem>
                          </asp:DropDownList></td>
                        <td colspan="1" style="width: 62px; height: 18px">
                        </td>
                      </tr>
                      <tr>
                        <td style="height: 18px; width: 136px;">
                          Año
                          <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtAnho"
                            ErrorMessage="(*)" ToolTip="ingrese un año válido" ValidationExpression="[0-9][0-9][0-9][0-9]"
                            ValidationGroup="grpSeach">(*)</asp:RegularExpressionValidator></td>
                        <td colspan="3" style="width: 156px; height: 18px">
                          <asp:TextBox ID="txtAnho" runat="server" CssClass="FormText" Style="position: static"
                            Text='' Width="150px"></asp:TextBox>&nbsp;</td>
                        <td colspan="1" style="width: 62px; height: 18px">
                          <asp:ImageButton ID="imgSearch" runat="server" ImageUrl="~/Images/btnsListas/icon_search.jpg"
                            ToolTip="Buscar el valor comercial" ValidationGroup="grpSeach" /></td>
                      </tr>
                      <tr>
                        <td style="height: 18px; width: 136px;">
                          Valor Comercial ($)
                        </td>
                        <td colspan="3" style="width: 156px; height: 18px">
                          <asp:TextBox ID="txtValorComercial" runat="server" CssClass="FormText" Style="position: static"
                            Width="150px"></asp:TextBox></td>
                        <td colspan="1" style="width: 62px; height: 18px">
                        </td>
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
            <asp:Panel ID="controlPanel" runat="server" Width="100%">
              <div class="DataTop">
                <div class="DataTopLeft">
                </div>
                <div class="DataTopRight">
                </div>
              </div>
              <div class="DataContent">
                <div class="DataContentRight" style="height: 24px;">
                  <div style="float: right">
                    &nbsp;&nbsp;
                  </div>
                </div>
              </div>
              <div class="DataBottom">
                <div class="DataBottomLeft">
                </div>
                <div class="DataBottomRight">
                </div>
              </div>
            </asp:Panel>
          </td>
        </tr>
      </table>
    </div>
    <asp:ObjectDataSource ID="odsVehiculo" runat="server" DeleteMethod="Delete" InsertMethod="Insert"
      SelectMethod="GetData" TypeName="dsVehiculoTableAdapters.VehiculoTableAdapter"
      UpdateMethod="Update">
      <DeleteParameters>
        <asp:Parameter Name="vehiculoId" Type="Decimal" />
      </DeleteParameters>
      <UpdateParameters>
        <asp:Parameter Name="vehiculoId" Type="Decimal" />
        <asp:Parameter Name="claseVehiculoId" Type="Int32" />
        <asp:Parameter Name="marcaVehiculoId" Type="Int32" />
        <asp:Parameter Name="modeloVehiculoId" Type="Int32" />
        <asp:Parameter Name="modeloVehiculo" Type="String" />
        <asp:Parameter Name="placa" Type="String" />
        <asp:Parameter Name="anhoFabricacion" Type="DateTime" />
        <asp:Parameter Name="colorVehiculo" Type="String" />
        <asp:Parameter Name="ubigeoInspcripcionId" Type="String" />
        <asp:Parameter Name="motor" Type="String" />
        <asp:Parameter Name="chasis" Type="String" />
        <asp:Parameter Name="cabinaId" Type="String" />
        <asp:Parameter Name="carroceriaId" Type="String" />
        <asp:Parameter Name="numepuertas" Type="Decimal" />
        <asp:Parameter Name="recorrido" Type="Decimal" />
        <asp:Parameter Name="tmedicionRecorridoId" Type="String" />
        <asp:Parameter Name="numecilindros" Type="Decimal" />
        <asp:Parameter Name="cilindrada" Type="Decimal" />
        <asp:Parameter Name="HP" Type="String" />
        <asp:Parameter Name="combustibleId" Type="Decimal" />
        <asp:Parameter Name="transmisionId" Type="Int32" />
        <asp:Parameter Name="traccionId" Type="String" />
        <asp:Parameter Name="ttraccion" Type="String" />
        <asp:Parameter Name="direccionId" Type="Int32" />
        <asp:Parameter Name="ttimon" Type="String" />
        <asp:Parameter Name="usoVehiculoId" Type="Int32" />
        <asp:Parameter Name="pesoSeco" Type="Decimal" />
        <asp:Parameter Name="pesoBruto" Type="Decimal" />
        <asp:Parameter Name="carga" Type="Decimal" />
        <asp:Parameter Name="tarjetaNumero" Type="String" />
        <asp:Parameter Name="tarjetaPropietario" Type="String" />
        <asp:Parameter Name="procedenciaId" Type="Int32" />
        <asp:Parameter Name="flagCochera" Type="String" />
        <asp:Parameter Name="direccionCochera" Type="String" />
        <asp:Parameter Name="valorSolicitado" Type="Decimal" />
        <asp:Parameter Name="valorComercial" Type="Decimal" />
        <asp:Parameter Name="valorInspector" Type="Decimal" />
        <asp:Parameter Name="estadoVehiculoId" Type="String" />
        <asp:Parameter Name="castigo" Type="Decimal" />
        <asp:Parameter Name="uupdate" Type="String" />
        <asp:Parameter Name="pc" Type="String" />
      </UpdateParameters>
      <SelectParameters>
        <asp:QueryStringParameter DefaultValue="1" Name="vehiculoId" QueryStringField="VehiculoId"
          Type="Decimal" />
      </SelectParameters>
      <InsertParameters>
        <asp:Parameter Direction="InputOutput" Name="vehiculoId" Type="Object" />
        <asp:Parameter Name="claseVehiculoId" Type="Int32" />
        <asp:Parameter Name="marcaVehiculoId" Type="Int32" />
        <asp:Parameter Name="modeloVehiculoId" Type="Int32" />
        <asp:Parameter Name="modeloVehiculo" Type="String" />
        <asp:Parameter Name="placa" Type="String" />
        <asp:Parameter Name="anhoFabricacion" Type="DateTime" />
        <asp:Parameter Name="colorVehiculo" Type="String" />
        <asp:Parameter Name="ubigeoInspcripcionId" Type="String" />
        <asp:Parameter Name="motor" Type="String" />
        <asp:Parameter Name="chasis" Type="String" />
        <asp:Parameter Name="cabinaId" Type="String" />
        <asp:Parameter Name="carroceriaId" Type="String" />
        <asp:Parameter Name="numepuertas" Type="Decimal" />
        <asp:Parameter Name="recorrido" Type="Decimal" />
        <asp:Parameter Name="tmedicionRecorridoId" Type="String" />
        <asp:Parameter Name="numecilindros" Type="Decimal" />
        <asp:Parameter Name="cilindrada" Type="Decimal" />
        <asp:Parameter Name="HP" Type="String" />
        <asp:Parameter Name="combustibleId" Type="Decimal" />
        <asp:Parameter Name="transmisionId" Type="Int32" />
        <asp:Parameter Name="traccionId" Type="String" />
        <asp:Parameter Name="ttraccion" Type="String" />
        <asp:Parameter Name="direccionId" Type="Int32" />
        <asp:Parameter Name="ttimon" Type="String" />
        <asp:Parameter Name="usoVehiculoId" Type="Int32" />
        <asp:Parameter Name="pesoSeco" Type="Decimal" />
        <asp:Parameter Name="pesoBruto" Type="Decimal" />
        <asp:Parameter Name="carga" Type="Decimal" />
        <asp:Parameter Name="tarjetaNumero" Type="String" />
        <asp:Parameter Name="tarjetaPropietario" Type="String" />
        <asp:Parameter Name="procedenciaId" Type="Int32" />
        <asp:Parameter Name="flagCochera" Type="String" />
        <asp:Parameter Name="direccionCochera" Type="String" />
        <asp:Parameter Name="valorSolicitado" Type="Decimal" />
        <asp:Parameter Name="valorComercial" Type="Decimal" />
        <asp:Parameter Name="valorInspector" Type="Decimal" />
        <asp:Parameter Name="estadoVehiculoId" Type="String" />
        <asp:Parameter Name="castigo" Type="Decimal" />
        <asp:Parameter Name="ucrea" Type="String" />
        <asp:Parameter Name="pc" Type="String" />
      </InsertParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="odsClase" runat="server" OldValuesParameterFormatString="original_{0}"
      SelectMethod="GetData" TypeName="ADM_DAL.dsDropDownListTableAdapters.ClaseVehiculoLoadDropDownTableAdapter">
    </asp:ObjectDataSource>
  </form>
</body>
</html>
