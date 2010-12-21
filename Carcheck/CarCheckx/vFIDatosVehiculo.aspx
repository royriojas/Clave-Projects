<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vFIDatosVehiculo.aspx.cs"
  Inherits="vFIDatosVehiculo" EnableEventValidation="false" %>

<%@ Register Src="ucAnularInspeccion.ascx" TagName="ucAnularInspeccion" TagPrefix="uc3" %>
<%@ Register Assembly="CustomPanelWebControl" Namespace="xWebControl" TagPrefix="cc3" %>
<%@ Register Assembly="AutoSuggestBox" Namespace="ASB" TagPrefix="cc1" %>
<%@ Register Src="ucHeader.ascx" TagName="ucHeader" TagPrefix="uc1" %>
<%@ Register Src="~/ucControlTab.ascx" TagName="ControlTab" TagPrefix="uc2" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
  <title>
    <%=CCSOL.Utiles.Utilidades.GetSystemNameAndVersion() %>
    | Inspección | Datos Vehículo</title>
  <link href="Css/layout.css" rel="stylesheet" type="text/css" />
  <link href="Css/layoutTabs.css" rel="stylesheet" type="text/css" />
  <!-- la libreria x.js ya esta incluida en el header!!!-->

  <script type="text/javascript" src="Scripts/lib/x.js"></script>

  <script type="text/javascript" src="Scripts/lib/x_common.js"></script>

  <script type="text/javascript" src="Scripts/lib/xDropDownMenu.js"></script>

  <script type="text/javascript">		
//CCSOL.Utiles.LoadScript("./Scripts/lib/xDropDownToolTip.js");
//CCSOL.Utiles.LoadScript("./Scripts/lib/x_especialTooltip.js");
//CCSOL.Utiles.LoadCSS("./Scripts/x_info/xInfo.css");
//CCSOL.Utiles.LoadScript("./Scripts/lib/xInfoSystem.js");
CCSOL.Utiles.LoadScript("./Scripts/lib/xForms.js");

//function activateInfo() {
//  var info = new infoSystem('holder_info','DivContainer','tt_help_info','tt_title','tt_text');
//}
//xAddEventListener(window,'load', activateInfo,false);



var isValidAmount = true;
function isValidAmountOfMoney() {
  $('imgValorInspector').style.display = 'none';
  
  var castigo = $('frmDatosVehiculo_txtCastigo').value;
  if (castigo == '') castigo = 0;
  
  if (($('frmDatosVehiculo_txtValorComercial').value != '' && ($('frmDatosVehiculo_txtValorComercial').value > 0))
    && ($('frmDatosVehiculo_txtValorInspector').value != '') ) {
    isValidAmount = false;
    var valorComercial =  $('frmDatosVehiculo_txtValorComercial').value;
    var valorComercialId = $('frmDatosVehiculo_cbxMonedaValorComercial').value;
    var valorInspector =  $('frmDatosVehiculo_txtValorInspector').value;
    var valorInspectorId = $('frmDatosVehiculo_cbxMonedaValorInspector').value;
    
    /*alert(CCSOL.Utiles.StringFormat('Valor Comercial : {0} | ValorComercialId : {1} | Valor Inspector : {2} | ValorInspectorId {3}',
     valorComercial,valorComercialId,valorInspector,valorInspectorId));*/
    
    isValidAmount = vFIDatosVehiculo.isValidAmountOfMoney(
      valorComercial, valorComercialId,
      valorInspector, valorInspectorId,
    castigo).value == 'CV';
    
    $('imgValorInspector').style.display = 'block';
    if (isValidAmount) {
      $('imgValorInspector').src = 'Images/btnsListas/icon_ok.jpg';
      CCSOL.DOM.x_SetAttribute($('imgValorInspector'),'tt_text','El monto cumple con ser menor al valor comercial menos el castigo');
      CCSOL.DOM.x_SetAttribute($('imgValorInspector'),'tt_title','MONTO VALIDO');
    }
    else {
      $('imgValorInspector').src = 'Images/btnsListas/icon_delete.jpg';
      CCSOL.DOM.x_SetAttribute($('imgValorInspector'),'tt_text','El valor Inspector no debe ser mayor que el valor comercial menos el castigo');
      CCSOL.DOM.x_SetAttribute($('imgValorInspector'),'tt_title','ERROR EN MONTO');
    }
  }
}

/****************************************************************************
seteaValorCastigo:
 ****************************************************************************/
function setValorCastigo() {
  switch($('frmDatosVehiculo_cbxCalificacion').value) {
    case 'BUENO' :
      $('frmDatosVehiculo_txtCastigo').value = 0;
    break;
    case 'MALO' :
      $('frmDatosVehiculo_txtCastigo').value = 60;
    break;
    case 'REGULAR' :
      $('frmDatosVehiculo_txtCastigo').value = 30;
    break;
    default:
      $('frmDatosVehiculo_txtCastigo').value = 0;
    break;
  }
  isValidAmountOfMoney();
}

var isValidPunra = false;
function validaPlaca() {
  var response;
  
  $('imgPlacaOk').style.display = 'none';
  response = vFIDatosVehiculo.isValidPunra($('frmDatosVehiculo_txtPlaca').value).value;
  
  if (response[0] != '1') {
    //ocurrio un error en el formato de la placa o del punra
    //alert(response[1]);
    isValidPunra = false;
    $('imgPlacaOk').src = 'Images/btnsListas/icon_delete.jpg';
    CCSOL.DOM.x_SetAttribute($('imgPlacaOk'),'tt_text',response[1]);
    CCSOL.DOM.x_SetAttribute($('imgPlacaOk'),'tt_title','PLACA NO VALIDA');
  }
  else {
    $('frmDatosVehiculo_txtUbigeoInscripcionId').value = response[2];
    $('frmDatosVehiculo_txtInscripcion').value = response[3];
    var cbxClase = $('frmDatosVehiculo_cbxClase');
    var claseId = cbxClase.options[cbxClase.selectedIndex].value;
    if (claseId != response[4]) {
      isValidPunra = false;
      $('imgPlacaOk').src = 'Images/btnsListas/icon_delete.jpg';
      CCSOL.DOM.x_SetAttribute($('imgPlacaOk'),'tt_text','La clase seleccionada no corresponde a la placa ingresada');
      CCSOL.DOM.x_SetAttribute($('imgPlacaOk'),'tt_title','PLACA NO VALIDA');
    }
    else {
      $('imgPlacaOk').src = 'Images/btnsListas/icon_ok.jpg';
      isValidPunra = true;
      CCSOL.DOM.x_SetAttribute($('imgPlacaOk'),'tt_text','La placa ingresada es válida');
      CCSOL.DOM.x_SetAttribute($('imgPlacaOk'),'tt_title','PLACA VALIDA');
      
    }
  }
  $('imgPlacaOk').style.display = 'block';
}

function setValueOfMarcaModelo () {
  $('frmDatosVehiculo_txtMarcaVehiculoId').value = $('frmDatosVehiculo_cbxMarca').value;
  $('frmDatosVehiculo_txtModeloVehiculoId').value = $('frmDatosVehiculo_cbxModelo').value;
}


function getMarcasFromAjax() {
  var cbxClase = $('frmDatosVehiculo_cbxClase');
  var claseId = cbxClase.options[cbxClase.selectedIndex].value;
  vFIDatosVehiculo.getMarcasVehiculo(claseId,getMarcas_handler);
  clearOptions('frmDatosVehiculo_cbxMarca');
  clearOptions('frmDatosVehiculo_cbxModelo');
  addOption('frmDatosVehiculo_cbxModelo','[ - Elija - ]','-1',true);
  CCSOL.DOM.xShowLoadingMessage();
  xRemoveEventListener($('frmDatosVehiculo_cbxMarca'),'change',getModelosFromAjax,false);
  
}

function getMarcas_handler(res) {
  try {
    var arr = res.value;
    addOptions('frmDatosVehiculo_cbxMarca',res.value);
    xAddEventListener($('frmDatosVehiculo_cbxMarca'),'change',getModelosFromAjax,false);
    CCSOL.DOM.xHideLoadingMessage();
  }
  catch(e) {
    alert('res_handler : ' + e.message);
  }
}

function getModelosFromAjax() {
  var cbxClase = $('frmDatosVehiculo_cbxClase');
  var claseId = cbxClase.options[cbxClase.selectedIndex].value;
  
  var cbxMarca = $('frmDatosVehiculo_cbxMarca');
  var marcaId = cbxMarca.options[cbxMarca.selectedIndex].value;
  
  vFIDatosVehiculo.getModelosVehiculo(claseId,marcaId,getModelos_handler);
  clearOptions('frmDatosVehiculo_cbxModelo');
  CCSOL.DOM.xShowLoadingMessage();
}

function getModelos_handler(res) {
  try {
    var arr = res.value;
    addOptions('frmDatosVehiculo_cbxModelo',res.value);
    CCSOL.DOM.xHideLoadingMessage();
  }
  catch(e) {
    alert('res_handler : ' + e.message);
  }
}


function protectFormSend(e) {
  validaPlaca();
  isValidAmountOfMoney();
  
  if (isValidPunra && isValidAmount) {
    if (Page_ClientValidate()) {
      CCSOL.DOM.xShowLoadingMessage('Actualizando');
      CCSOL.Utiles.RegenerateViewState();
      CCSOL.DOM.xLockBackground();
      return true;
    }
  }
  else {
    xPreventDefault(e);
    return false;
  }
}

function initFieldValidations() {
  xAddEventListener($('frmDatosVehiculo_rbGuardadoCochera_0'),'click',activateFields,false);
  xAddEventListener($('frmDatosVehiculo_rbGuardadoCochera_1'),'click',deActivateFields,false);
  xAddEventListener($('frmDatosVehiculo_rbGuardadoCochera_2'),'click',activateFields,false);
  
  if ($('frmDatosVehiculo_rbGuardadoCochera_0').checked ||
    $('frmDatosVehiculo_rbGuardadoCochera_2').checked ) {    
    activateFields();
  }
  else {
    deActivateFields();
  }    
}
function activateFields() {
  $('frmDatosVehiculo_txtDireccion').readOnly = false;
  $('frmDatosVehiculo_asbDistrito').readOnly = false;
  xRemoveClass($('frmDatosVehiculo_asbDistrito'),'deshabilitado');
  xRemoveClass($('frmDatosVehiculo_txtDireccion'),'deshabilitado');
}

function deActivateFields() {
  $('frmDatosVehiculo_txtDireccion').value = '';
  $('frmDatosVehiculo_asbDistrito').value = '';
  $('frmDatosVehiculo_asbDistrito_SelectedValue').value = '';
  
  $('frmDatosVehiculo_txtDireccion').readOnly = true;
  $('frmDatosVehiculo_asbDistrito').readOnly = true;
  
  xAddClass($('frmDatosVehiculo_asbDistrito'),'deshabilitado');
  xAddClass($('frmDatosVehiculo_txtDireccion'),'deshabilitado');
}



window.onload = function () {
  /*var autoComplete = new cargaDropDownList('myText','mySelect');*/
  var dropDownTitle = new xDropDownToolTip('aDropDownWithTitle',null);
  if (<%= InspeccionIsEditable().ToString().ToLower() %>)  {
    xAddEventListener($('frmDatosVehiculo_cbxClase'),'change',getMarcasFromAjax,false);
    xAddEventListener($('frmDatosVehiculo_cbxMarca'),'change',getModelosFromAjax,false);
    xAddEventListener($('frmDatosVehiculo_txtPlaca'),'blur',validaPlaca,false);  
    
    xAddEventListener($('frmDatosVehiculo_cbxMarca'),'change',setValueOfMarcaModelo,false);
    xAddEventListener($('frmDatosVehiculo_cbxModelo'),'change',setValueOfMarcaModelo,false);
    xAddEventListener($('frmDatosVehiculo_cbxCalificacion'),'change',setValorCastigo,false);
    
    xAddEventListener($('frmDatosVehiculo_txtValorComercial'),'change',isValidAmountOfMoney,false);  
    xAddEventListener($('frmDatosVehiculo_txtValorInspector'),'blur',isValidAmountOfMoney,false);  
    xAddEventListener($('frmDatosVehiculo_txtAnho'),'blur',getValorcomercial,false);    
    
    setValorCastigo();
    validaPlaca();
  }
  $('frmDatosVehiculo_txtCastigo').readOnly = true;
  $('frmDatosVehiculo_txtValorComercial').readOnly = true;
  $('frmDatosVehiculo_txtInscripcion').readOnly = true;  
    
  initFieldValidations();   

  //isValidAmountOfMoney();
}


function getValorcomercial()
{
  var shouldDoAjaxCall = false;
  var mensaje = '';
  var cbxClase = $('frmDatosVehiculo_cbxClase');
  var claseId = cbxClase.options[cbxClase.selectedIndex].value;
  if (claseId == '-1') mensaje += 'Debe elegir una clase\n';
  var cbxMarca = $('frmDatosVehiculo_cbxMarca');
  var marcaId = cbxMarca.options[cbxMarca.selectedIndex].value;
  if (marcaId == '-1') mensaje += 'Debe elegir una marca\n';
  var cbxModelo = $('frmDatosVehiculo_cbxModelo');
  var modeloId = cbxModelo.options[cbxModelo.selectedIndex].value;
  if (modeloId == '-1') mensaje += 'Debe elegir un modelo\n';
  var anho = $('frmDatosVehiculo_txtAnho').value;
  if (anho == '') mensaje += 'Debe ingresar un año válido\n';
  shouldDoAjaxCall = mensaje == '';
  var isValidYear = false;
  
  if ((anho >= 1940) && (anho <= 2060)) {
    isValidYear = true;
  }
  if (shouldDoAjaxCall && isValidYear)
  {
    vFIDatosVehiculo.getValorComercial(claseId,marcaId,modeloId,anho,getValor_handler);
    CCSOL.DOM.xShowLoadingMessage('Buscando Valores');
  }
  else
  {
    alert(mensaje);
  }
  return false;
}
function getValor_handler(res)
{
  try
  {
    var vc = res.value;
    if (vc.valor != '')
    {
      $('frmDatosVehiculo_txtValorComercial').value = vc.valor;
      $('frmDatosVehiculo_cbxMonedaValorComercial').value = vc.monedaId;
    }
    else
    {
      $('frmDatosVehiculo_txtValorComercial').value = '';      
    }
    CCSOL.DOM.xHideLoadingMessage();
  }
  catch(e)
  {
    alert('res_handler : ' + e.message);
  }
}

  
     function GenerarInforme(vehiculoId, observado)
        {
          window.top.showPopWin('generarStatus.aspx?VehiculoId='+vehiculoId+'&observado='+observado, 229, 75, null);         
        }

  </script>

  <link href="/asb_includes/AutoSuggestBox.css" rel="stylesheet" type="text/css" />
  <link href="css/layout.css" rel="stylesheet" type="text/css" />
  <link href="Css/layoutTabs.css" rel="stylesheet" type="text/css" />
  <link href="css/layout.css" rel="stylesheet" type="text/css" />
  <link href="./Scripts/x_info/xInfo.css" rel="stylesheet" type="text/css" />
</head>
<body>
  <form id="form1" runat="server">
    <div id='DivContainer' class="Blockable">
      <table id="Data" border="0" cellpadding="0" cellspacing="0" align="center">
        <tr>
          <td>
            <uc1:ucHeader ID="UcHeader1" runat="server" PageFunctionalityToCheck="INS_DATOSVEHICULO_VER" />
            <uc2:ControlTab ID="ControlTab1" TabActual="DatosVehiculo" runat="server" LabelText="Inspección: INS - 001 - XXX" />
            <div class="DataContent">
              <div class="DataContentRight" style="padding-top: 1px">
                <div class="PanelStyle" style="margin-top: 4px">
                  <div class="PanelEncabezado">
                    <asp:Label ID="lblDatosSolicitud" runat="server" Style="cursor: default" Text="Datos del Vehículo"></asp:Label>
                    <img id="Img1" alt="Mostrar / Ocultar Panel" class="MakeClear" src="Images/IconHide16Dark.gif"
                      style="margin-top: 3px" title="Mostrar/Ocultar" />
                  </div>
                  <asp:FormView ID="frmDatosVehiculo" runat="server" DataSourceID="odsVehiculo" DataKeyNames="vehiculoId"
                    DefaultMode="Edit" OnDataBound="FormView1_DataBound" OnItemUpdating="frmDatosVehiculo_ItemUpdating"
                    OnItemUpdated="frmDatosVehiculo_ItemUpdated">
                    <EditItemTemplate>
                      <div class="DataTable">
                        <table border="0" cellpadding="0" cellspacing="0">
                          <tr>
                            <td style="width: 120px;">
                              Clase
                            </td>
                            <td>
                              <asp:DropDownList ID="cbxClase" runat="server" CssClass="FormText tt_help_info aDropDownWithTitle"
                                Width="204px" DataSourceID="odsClase" DataTextField="claseVehiculo" DataValueField="claseVehiculoId"
                                AppendDataBoundItems="True" SelectedValue='<%# Bind("claseVehiculoId") %>'>
                                <asp:ListItem Value="-1" Selected="True">[ - Elija - ]</asp:ListItem>
                              </asp:DropDownList></td>
                            <td style="width: 20px;">
                            </td>
                            <td style="width: 180px;">
                              Color</td>
                            <td style="width: 208px;">
                              <asp:TextBox ID="txtColor" runat="server" CssClass="FormText" Width="200px" Text='<%# Bind("colorVehiculo") %>'></asp:TextBox></td>
                            <td style="width: 20px">
                            </td>
                          </tr>
                          <tr>
                            <td>
                              Marca</td>
                            <td>
                              <asp:DropDownList ID="cbxMarca" runat="server" CssClass="FormText tt_help_info aDropDownWithTitle"
                                Width="204px" AppendDataBoundItems="True">
                                <asp:ListItem Value="-1" Selected="True">[ - Elija - ]</asp:ListItem>
                              </asp:DropDownList></td>
                            <td style="width: 10px">
                            </td>
                            <td>
                              Inscripción</td>
                            <td style="width: 208px">
                              <asp:TextBox ID="txtInscripcion" runat="server" CssClass="FormText" Width="200px"
                                Text='<%# Eval("inscripcion") %>'></asp:TextBox></td>
                            <td style="width: 20px">
                            </td>
                          </tr>
                          <tr>
                            <td>
                              Modelo</td>
                            <td>
                              <asp:DropDownList ID="cbxModelo" runat="server" CssClass="FormText tt_help_info aDropDownWithTitle"
                                Width="204px" AppendDataBoundItems="True">
                                <asp:ListItem Value="-1" Selected="True">[ - Elija - ]</asp:ListItem>
                              </asp:DropDownList></td>
                            <td style="width: 10px">
                            </td>
                            <td>
                              Número de Motor</td>
                            <td style="width: 208px">
                              <asp:TextBox ID="txtNumMotor" runat="server" CssClass="FormText" Width="200px" Text='<%# Bind("motor") %>'></asp:TextBox></td>
                            <td style="width: 20px">
                            </td>
                          </tr>
                          <tr>
                            <td>
                              Placa</td>
                            <td>
                              <asp:TextBox ID="txtPlaca" runat="server" CssClass="FormText" Width="200px" Text='<%# Bind("placa") %>'></asp:TextBox></td>
                            <td style="width: 10px">
                              <img alt="" tt_title='' tt_text='' id="imgPlacaOk" src="Images/btnsListas/icon_ok.jpg"
                                style="display: none" class="tt_help_info" /></td>
                            <td>
                              Número de Serie / Chassis</td>
                            <td style="width: 208px">
                              <asp:TextBox ID="txtNumSerie" runat="server" CssClass="FormText" Width="200px" Text='<%# Bind("chasis") %>'></asp:TextBox></td>
                            <td style="width: 20px">
                            </td>
                          </tr>
                          <tr>
                            <td style="height: 18px">
                              Año &nbsp;
                              <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtAnho"
                                ErrorMessage="Ingrese un año en el formato correcto" ValidationExpression="[0-9][0-9][0-9][0-9]"
                                Font-Bold="False" SetFocusOnError="True" ToolTip="Ingrese un año en el formato correcto"
                                ValidationGroup="UpdateVehiculo">[Año Invalido]</asp:RegularExpressionValidator></td>
                            <td style="height: 18px">
                              <asp:TextBox ID="txtAnho" runat="server" CssClass="FormText ENTERO" Width="200px"
                                Text='<%# Eval("anhoFabricacion", "{0:yyyy}") %>'></asp:TextBox></td>
                            <td style="height: 18px; width: 10px;">
                            </td>
                            <td style="height: 18px">
                              <asp:RangeValidator ID="rvYears" runat="server" ControlToValidate="txtAnho" ErrorMessage="[Año Fuera del Rango]"
                                MaximumValue="2100" MinimumValue="1989" Type="Integer"></asp:RangeValidator></td>
                            <td style="height: 18px; width: 208px;">
                            </td>
                            <td style="width: 20px">
                            </td>
                          </tr>
                        </table>
                      </div>
                      <div class="DataTable" style="margin-top: 5px;">
                        <table border="0" cellpadding="0" cellspacing="0">
                          <tr>
                            <td style="width: 120px">
                              Cabina<asp:CompareValidator ID="CompareValidator2" runat="server" ControlToValidate="cbxCabina"
                                ErrorMessage="Elija Cabina" Operator="NotEqual" ValidationGroup="UpdateVehiculo"
                                ValueToCompare="-1">(*)</asp:CompareValidator></td>
                            <td>
                              <asp:DropDownList ID="cbxCabina" runat="server" CssClass="FormText" Width="204px"
                                DataSourceID="odsCabina" DataTextField="cabina" DataValueField="cabinaId" AppendDataBoundItems="True"
                                SelectedValue='<%# Bind("cabinaId") %>'>
                                <asp:ListItem Value="-1">[ - Elija - ]</asp:ListItem>
                              </asp:DropDownList>
                            </td>
                            <td style="width: 20px">
                            </td>
                            <td style="width: 180px">
                              Combustible<asp:CompareValidator ID="CompareValidator8" runat="server" ControlToValidate="cbxCombustible"
                                ErrorMessage="Elija un estado" Operator="NotEqual" ValidationGroup="UpdateVehiculo"
                                ValueToCompare="-1">(*)</asp:CompareValidator></td>
                            <td style="width: 208px">
                              <asp:DropDownList ID="cbxCombustible" runat="server" CssClass="FormText tt_help_info aDropDownWithTitle"
                                Width="204px" DataSourceID="odsCombustible" DataTextField="combustible" DataValueField="combustibleId"
                                AppendDataBoundItems="True" SelectedValue='<%# Bind("combustibleId") %>'>
                                <asp:ListItem Value="-1">[ - Elija - ]</asp:ListItem>
                              </asp:DropDownList>
                            </td>
                            <td style="width: 20px">
                            </td>
                          </tr>
                          <tr>
                            <td>
                              Carrocería<asp:CompareValidator ID="CompareValidator3" runat="server" ControlToValidate="cbxCarroceria"
                                ErrorMessage="Elija Carrocería" Operator="NotEqual" ValidationGroup="UpdateVehiculo"
                                ValueToCompare="-1">(*)</asp:CompareValidator></td>
                            <td>
                              <asp:DropDownList ID="cbxCarroceria" runat="server" CssClass="FormText tt_help_info aDropDownWithTitle"
                                Width="204px" DataSourceID="odsCarroceria" DataTextField="carroceria" DataValueField="carroceriaId"
                                AppendDataBoundItems="True" SelectedValue='<%# Bind("carroceriaId") %>'>
                                <asp:ListItem Value="-1">[ - Elija - ]</asp:ListItem>
                              </asp:DropDownList>
                            </td>
                            <td style="width: 10px">
                            </td>
                            <td>
                              Cambios<asp:CompareValidator ID="CompareValidator9" runat="server" ControlToValidate="cbxCambios"
                                ErrorMessage="Elija un estado" Operator="NotEqual" ValidationGroup="UpdateVehiculo"
                                ValueToCompare="-1">(*)</asp:CompareValidator></td>
                            <td style="width: 208px">
                              <asp:DropDownList ID="cbxCambios" runat="server" CssClass="FormText" Width="204px"
                                DataSourceID="odsCambios" DataTextField="transmision" DataValueField="transmisionId"
                                AppendDataBoundItems="True" SelectedValue='<%# Bind("transmisionId") %>'>
                                <asp:ListItem Value="-1">[ - Elija - ]</asp:ListItem>
                              </asp:DropDownList>
                            </td>
                            <td style="width: 20px">
                            </td>
                          </tr>
                          <tr>
                            <td>
                              N° de Puertas</td>
                            <td>
                              <asp:TextBox ID="txtNumPuertas" runat="server" CssClass="FormText ENTERO" Width="200px"
                                Text='<%# Bind("numepuertas") %>'></asp:TextBox></td>
                            <td style="width: 10px">
                            </td>
                            <td>
                              Sistema de tracción<asp:CompareValidator ID="CompareValidator10" runat="server" ControlToValidate="cbxTraccion"
                                ErrorMessage="Elija un estado" Operator="NotEqual" ValidationGroup="UpdateVehiculo"
                                ValueToCompare="-1">(*)</asp:CompareValidator></td>
                            <td style="width: 208px">
                              <asp:DropDownList ID="cbxTraccion" runat="server" CssClass="FormTextNoUpperCase"
                                Width="204px" DataSourceID="odsTraccion" DataTextField="traccion" DataValueField="traccionId"
                                AppendDataBoundItems="True" SelectedValue='<%# Bind("traccionId") %>'>
                                <asp:ListItem Value="-1" Selected="True">[ - Elija - ]</asp:ListItem>
                              </asp:DropDownList>
                            </td>
                            <td style="width: 20px">
                            </td>
                          </tr>
                          <tr>
                            <td>
                              Kilómetros / Millas</td>
                            <td>
                              <asp:TextBox ID="txtMagnitudKmMillas" runat="server" CssClass="FormText REAL" Width="80px"
                                Text='<%# Bind("recorrido") %>'></asp:TextBox>
                              <asp:RadioButtonList ID="rdTipoMedida" runat="server" CssClass="FormRadio" RepeatDirection="Horizontal"
                                Style="position: absolute; margin: -2px 0px 0px -2px" DataSourceID="odsTmedicion"
                                DataTextField="tmedicionRecorridoId" DataValueField="tmedicionRecorridoId" SelectedValue='<%# Bind("tmedicionRecorridoId") %>'>
                              </asp:RadioButtonList>
                            </td>
                            <td style="width: 10px">
                            </td>
                            <td>
                              Tipo de Tracción<asp:CompareValidator ID="CompareValidator11" runat="server" ControlToValidate="cbxTipoTraccion"
                                ErrorMessage="Elija un estado" Operator="NotEqual" ValidationGroup="UpdateVehiculo"
                                ValueToCompare="-">(*)</asp:CompareValidator></td>
                            <td style="width: 208px">
                              <asp:DropDownList ID="cbxTipoTraccion" runat="server" CssClass="FormText" Width="204px"
                                AppendDataBoundItems="True" DataSourceID="odsTipoTraccion" DataTextField="Text"
                                DataValueField="Value" SelectedValue='<%# Bind("ttraccion") %>'>
                                <asp:ListItem Value="-" Selected="True">[ - Elija - ]</asp:ListItem>
                              </asp:DropDownList></td>
                            <td style="width: 20px">
                            </td>
                          </tr>
                          <tr>
                            <td>
                              N° de Cilindros</td>
                            <td>
                              <asp:TextBox ID="txtNumCilindros" runat="server" CssClass="FormText ENTERO" Width="200px"
                                Text='<%# Bind("numecilindros") %>'></asp:TextBox></td>
                            <td style="width: 10px;">
                            </td>
                            <td>
                              Sistema de Dirección<asp:CompareValidator ID="CompareValidator13" runat="server"
                                ControlToValidate="cbxSistema" ErrorMessage="Elija un estado" Operator="NotEqual"
                                ValidationGroup="UpdateVehiculo" ValueToCompare="-1">(*)</asp:CompareValidator></td>
                            <td style="width: 208px;">
                              <asp:DropDownList ID="cbxSistema" runat="server" CssClass="FormText" Width="204px"
                                DataSourceID="odsDireccion" DataTextField="direccion" DataValueField="direccionId"
                                AppendDataBoundItems="True" SelectedValue='<%# Bind("direccionId") %>'>
                                <asp:ListItem Value="-1">[ - Elija - ]</asp:ListItem>
                              </asp:DropDownList>
                            </td>
                            <td style="width: 20px">
                            </td>
                          </tr>
                          <tr>
                            <td>
                              Cilindrada</td>
                            <td>
                              <asp:TextBox ID="txtCilindrada" runat="server" CssClass="FormText ENTERO" Width="200px"
                                Text='<%# Bind("cilindrada") %>'></asp:TextBox></td>
                            <td style="width: 10px">
                            </td>
                            <td>
                              Tipo de Timón<asp:CompareValidator ID="CompareValidator12" runat="server" ControlToValidate="cbxTipoTimon"
                                ErrorMessage="Elija un estado" Operator="NotEqual" ValidationGroup="UpdateVehiculo"
                                ValueToCompare="-">(*)</asp:CompareValidator></td>
                            <td style="width: 208px">
                              <asp:DropDownList ID="cbxTipoTimon" runat="server" CssClass="FormText" Width="204px"
                                AppendDataBoundItems="True" DataSourceID="odsTipoTimon" DataTextField="Text" DataValueField="Value"
                                SelectedValue='<%# Bind("ttimon") %>'>
                                <asp:ListItem Value="-" Selected="True">[ - Elija - ]</asp:ListItem>
                              </asp:DropDownList></td>
                            <td style="width: 20px">
                            </td>
                          </tr>
                          <tr>
                            <td>
                              HP</td>
                            <td>
                              <asp:TextBox ID="txtHp" runat="server" CssClass="FormText ENTERO" Width="200px" Text='<%# Bind("HP") %>'></asp:TextBox></td>
                            <td style="width: 10px">
                            </td>
                            <td>
                            </td>
                            <td style="width: 208px">
                            </td>
                            <td style="width: 20px">
                            </td>
                          </tr>
                        </table>
                      </div>
                      <div class="DataTable" style="margin-top: 5px;">
                        <table border="0" cellpadding="0" cellspacing="0">
                          <tr>
                            <td style="width: 120px;">
                              Uso del Vehículo<asp:CompareValidator ID="CompareValidator4" runat="server" ControlToValidate="cbxUsoVehiculo"
                                ErrorMessage="Elija Uso" Operator="NotEqual" ValidationGroup="UpdateVehiculo" ValueToCompare="-1">(*)</asp:CompareValidator></td>
                            <td>
                              <asp:DropDownList ID="cbxUsoVehiculo" AppendDataBoundItems="True" runat="server"
                                CssClass="FormText tt_help_info aDropDownWithTitle" Width="204px" DataSourceID="odsUsoVehiculo"
                                DataTextField="usovehiculo" DataValueField="usovehiculoId" SelectedValue='<%# Bind("usoVehiculoId") %>'>
                                <asp:ListItem Value="-1">[ - Elija - ]</asp:ListItem>
                              </asp:DropDownList>
                            </td>
                            <td style="width: 20px;">
                            </td>
                            <td style="width: 180px;">
                              Procedencia<asp:CompareValidator ID="CompareValidator5" runat="server" ControlToValidate="cbxProcedencia"
                                ErrorMessage="Elija una Procedencia" Operator="NotEqual" ValidationGroup="UpdateVehiculo"
                                ValueToCompare="-1">(*)</asp:CompareValidator></td>
                            <td style="width: 208px;">
                              <asp:DropDownList ID="cbxProcedencia" runat="server" CssClass="FormText tt_help_info aDropDownWithTitle"
                                Width="204px" DataSourceID="odsProcedencia" DataTextField="procedencia" DataValueField="procedenciaId"
                                AppendDataBoundItems="True" SelectedValue='<%# Bind("procedenciaId") %>'>
                                <asp:ListItem Value="-1">[ - Elija - ]</asp:ListItem>
                              </asp:DropDownList>
                            </td>
                            <td style="width: 20px">
                            </td>
                          </tr>
                          <tr>
                            <td style="width: 120px">
                              Peso Seco</td>
                            <td>
                              <asp:TextBox ID="txtPesoSeco" runat="server" CssClass="FormText REAL" Width="200px"
                                Text='<%# Bind("pesoSeco") %>'></asp:TextBox></td>
                            <td style="width: 9px">
                            </td>
                            <td>
                              Guardado en cochera</td>
                            <td style="width: 208px; padding-top: 2px;" valign="top">
                              <asp:RadioButtonList ID="rbGuardadoCochera" runat="server" RepeatDirection="Horizontal"
                                CssClass="FormRadio" SelectedValue='<%# Bind("flagCochera") %>'>
                                <asp:ListItem Value="1">Si</asp:ListItem>
                                <asp:ListItem Value="2">No</asp:ListItem>
                                <asp:ListItem Value="3">Condominio</asp:ListItem>
                              </asp:RadioButtonList></td>
                            <td style="width: 20px" valign="top">
                            </td>
                          </tr>
                          <tr>
                            <td style="width: 120px">
                              Peso Bruto</td>
                            <td>
                              <asp:TextBox ID="txtPesoBruto" runat="server" CssClass="FormText REAL" Width="200px"
                                Text='<%# Bind("pesoBruto") %>'></asp:TextBox></td>
                            <td style="width: 9px">
                            </td>
                            <td>
                              Dirección</td>
                            <td style="width: 208px">
                              <asp:TextBox ID="txtDireccion" runat="server" CssClass="FormText" Width="200px" Text='<%# Bind("direccionCochera") %>'></asp:TextBox></td>
                            <td style="width: 20px">
                            </td>
                          </tr>
                          <tr>
                            <td style="width: 120px">
                              Carga (Tara)</td>
                            <td>
                              <asp:TextBox ID="txtTara" runat="server" CssClass="FormText REAL" Width="200px" Text='<%# Bind("carga") %>'></asp:TextBox></td>
                            <td style="width: 9px">
                            </td>
                            <td>
                              Departamento/Provincia/Distrito</td>
                            <td style="width: 208px">
                              <cc1:AutoSuggestBox ID="asbDistrito" runat="server" CssClass="FormText" DataType="Distrito"
                                ResourcesDir="./Scripts/asb_includes" Width="200px" IncludeMoreMenuItem="False"
                                KeyPressDelay="300" MaxSuggestChars="5" MenuCSSClass="asbMenu" MenuItemCSSClass="asbMenuItem"
                                MoreMenuItemLabel="..." NoValueSelectedCSSClass="asbNonValueSelected" NumMenuItems="10"
                                OnFocusShowAll="False" SelectedValue='<%# Bind("cocheraUbigeodId") %>' SelMenuItemCSSClass="asbSelMenuItem"
                                Text='<%# Eval("distitoroCochera") %>' UseIFrame="True" WarnNoValueSelected="False"></cc1:AutoSuggestBox>
                            </td>
                            <td style="width: 20px">
                            </td>
                          </tr>
                          <tr>
                            <td style="width: 120px">
                              Tarjeta a Nombre de
                            </td>
                            <td>
                              <asp:TextBox ID="txtTarjetaANombre" runat="server" CssClass="FormText" Width="200px"
                                Text='<%# Bind("tarjetaPropietario") %>'></asp:TextBox></td>
                            <td style="width: 9px">
                            </td>
                            <td>
                              Valor Solicitado<asp:CompareValidator ID="CompareValidator6" runat="server" ControlToValidate="cbxMonedaValorSolicitado"
                                ErrorMessage="Elija una Moneda" Operator="NotEqual" ValidationGroup="UpdateVehiculo"
                                ValueToCompare="-1">(*)</asp:CompareValidator></td>
                            <td style="width: 208px">
                              <asp:TextBox ID="txtValorSolicitado" runat="server" CssClass="FormText REAL" Width="130px"
                                Text='<%# Bind("valorSolicitado") %>'></asp:TextBox>&nbsp;<asp:DropDownList ID="cbxMonedaValorSolicitado"
                                  runat="server" CssClass="FormText" Width="65px" AppendDataBoundItems="True" DataSourceID="odsMoneda"
                                  DataTextField="simbolo" DataValueField="monedaId" SelectedValue='<%# Bind("valorSolicitadoMonedaId") %>'>
                                  <asp:ListItem Value="-1">[Elija]</asp:ListItem>
                                </asp:DropDownList></td>
                            <td style="width: 20px">
                            </td>
                          </tr>
                          <tr>
                            <td style="width: 120px; height: 24px;">
                              N° de Tarjeta</td>
                            <td style="height: 24px">
                              <asp:TextBox ID="txtNumTarjeta" runat="server" CssClass="FormText" Width="200px"
                                Text='<%# Bind("tarjetaNumero") %>'></asp:TextBox></td>
                            <td style="width: 9px; height: 24px;">
                            </td>
                            <td style="height: 24px">
                              Valor Comercial</td>
                            <td style="width: 208px; height: 24px;">
                              <asp:TextBox ID="txtValorComercial" runat="server" CssClass="FormText REAL" Width="130px"
                                Text='<%# Bind("valorComercial") %>'></asp:TextBox>&nbsp;<asp:DropDownList ID="cbxMonedaValorComercial"
                                  runat="server" CssClass="FormText" Width="65px" AppendDataBoundItems="True" DataSourceID="odsMoneda"
                                  DataTextField="simbolo" DataValueField="monedaId" SelectedValue='<%# Bind("valorComercialMonedaId") %>'>
                                </asp:DropDownList></td>
                            <td style="width: 20px">
                            </td>
                          </tr>
                          <tr>
                            <td style="width: 120px" valign="top">
                              Calificación estado del Vehiculo<asp:CompareValidator ID="CompareValidator1" runat="server"
                                ControlToValidate="cbxCalificacion" ErrorMessage="Elija un estado" Operator="NotEqual"
                                ValidationGroup="UpdateVehiculo" ValueToCompare="-1">(*)</asp:CompareValidator></td>
                            <td style="width: 208px" valign="top">
                              <asp:DropDownList ID="cbxCalificacion" runat="server" CssClass="FormText" Width="100px"
                                DataSourceID="odsEstadoVehiculo" DataTextField="estadoVehiculo" DataValueField="estadoVehiculoId"
                                AppendDataBoundItems="True" SelectedValue='<%# Bind("estadoVehiculoId") %>' valorcastigo='<%# Eval("castigo") %>'>
                                <asp:ListItem Value="-1">[Elija]</asp:ListItem>
                              </asp:DropDownList>
                              Castigo(%) &nbsp;<asp:TextBox ID="txtCastigo" runat="server" CssClass="FormText NUMBER"
                                Width="25px" Text='<%# Bind("castigo") %>'></asp:TextBox></td>
                            <td style="width: 9px" valign="top">
                            </td>
                            <td style="padding-top: 2px" valign="top">
                              Valor Inspector<asp:CompareValidator ID="CompareValidator7" runat="server" ControlToValidate="cbxMonedaValorInspector"
                                ErrorMessage="Elija una Moneda" Operator="NotEqual" ValidationGroup="UpdateVehiculo"
                                ValueToCompare="-1">(*)</asp:CompareValidator></td>
                            <td style="width: 208px" valign="top">
                              <asp:TextBox ID="txtValorInspector" runat="server" CssClass="FormText REAL" Width="130px"
                                Text='<%# Bind("valorInspector") %>'></asp:TextBox>&nbsp;<asp:DropDownList ID="cbxMonedaValorInspector"
                                  runat="server" CssClass="FormText" Width="65px" AppendDataBoundItems="True" DataSourceID="odsMoneda"
                                  DataTextField="simbolo" DataValueField="monedaId" SelectedValue='<%# Bind("valorInspectorMonedaId") %>'>
                                  <asp:ListItem Value="-1">[Elija]</asp:ListItem>
                                </asp:DropDownList></td>
                            <td style="width: 20px" valign="top">
                              <img alt="" tt_title='' tt_text='' id="imgValorInspector" src="Images/btnsListas/icon_ok.jpg"
                                style="display: none" class="tt_help_info" /></td>
                          </tr>
                          <tr>
                            <td style="width: 120px">
                            </td>
                            <td>
                              &nbsp;&nbsp;
                              <asp:TextBox Style="display: none;" ID="txtClaseVehiculoId" runat="server" CssClass="FormText"
                                Width="22px" Text='<%# Eval("claseVehiculoId") %>'></asp:TextBox>
                              <asp:TextBox Style="display: none;" ID="txtMarcaVehiculoId" runat="server" CssClass="FormText"
                                Width="22px" Text='<%# Bind("marcaVehiculoId") %>'></asp:TextBox>
                              <asp:TextBox Style="display: none;" ID="txtModeloVehiculoId" runat="server" CssClass="FormText"
                                Width="22px" Text='<%# Bind("modeloVehiculoId") %>'></asp:TextBox>
                              <asp:TextBox Style="display: none;" ID="txtUbigeoInscripcionId" runat="server" CssClass="FormText"
                                Text='<%# Bind("ubigeoInspcripcionId") %>' Width="22px"></asp:TextBox></td>
                            <td style="width: 9px">
                            </td>
                            <td>
                              &nbsp;</td>
                            <td style="width: 208px">
                            </td>
                            <td style="width: 20px">
                            </td>
                          </tr>
                        </table>
                      </div>
                    </EditItemTemplate>
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
            <div id="controlPanel" width="100%">
              <div class="DataTop">
                <div class="DataTopLeft">
                </div>
                <div class="DataTopRight">
                </div>
              </div>
              <div class="DataContent">
                <div class="DataContentRight" style="">
                  <div style="float: left">
                    <cc3:xWebPanelControl ID="XWebPanelControl1" Style="display: inline;" runat="server"
                      PermissionToCheck="INS_GRABAR">
                      <asp:ImageButton ID="guardarImageButton" runat="server" ImageUrl="~/Images/IconSave48Dark.gif"
                        ToolTip="Guardar Datos" CssClass="MakeClear" OnClientClick="return protectFormSend();"
                        OnClick="btnSave_Click" />
                    </cc3:xWebPanelControl>
                    <cc3:xWebPanelControl ID="XWebPanelControl2" Style="display: inline;" runat="server"
                      PermissionToCheck="INS_ANULAR">
                      <asp:ImageButton MenuDropDownType="anular" doShow="show" ID="anularImageButton" OnClientClick='return false;'
                        runat="server" ImageUrl="~/Images/IconAnul48Dark.jpg" ToolTip="Anular Inspección"
                        CssClass="MakeClear" />
                    </cc3:xWebPanelControl>
                  </div>
                  <div style="float: right; position: relative;">
                    <cc3:xWebPanelControl Style="display: inline;" ID="XWebPanelControl3" runat="server"
                      PermissionToCheck="INS_PREVIEW">
                      <asp:ImageButton ID="btnVistaPrevia" runat="server" ImageUrl="~/Images/btnPrevisualizar.jpg"
                        ToolTip="Preview Inspección" CssClass="MakeClear" OnClientClick="doPreview(); return false;" />
                    </cc3:xWebPanelControl>
                    <cc3:xWebPanelControl Style="display: inline;" ID="XWebPanelControl4" runat="server"
                      PermissionToCheck="INS_TERMINAR">
                      <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/Images/btnTerminarInspeccion.jpg"
                        ToolTip="Terminar Inspección" CssClass="MakeClear" OnClick="ImageButton1_Click"
                        Visible="False" />
                    </cc3:xWebPanelControl>
                    <cc3:xWebPanelControl Style="display: inline;" ID="XWebPanelControl5" runat="server"
                      PermissionToCheck="INS_APROBAR">
                      <asp:ImageButton ID="aprobarImageButton" OnClientClick='GenerateInform(0);return false;'
                        runat="server" ImageUrl="~/Images/IconApprove48.jpg" ToolTip="Aprobar Inspección"
                        CssClass="MakeClear" Visible="False" />
                    </cc3:xWebPanelControl>
                    <cc3:xWebPanelControl Style="display: inline;" ID="XWebPanelControl6" runat="server"
                      PermissionToCheck="INS_APROBAR">
                      <asp:ImageButton ID="desaprobarImageButton" runat="server" ImageUrl="~/Images/IconReject48.jpg"
                        ToolTip="Aprobar Inspección sin pago a ajustador" CssClass="MakeClear" OnClientClick="GenerateInform(1);return false;"
                        Visible="False" />
                    </cc3:xWebPanelControl>
                  </div>
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
            </div>
          </td>
        </tr>
      </table>
    </div>
    <asp:ObjectDataSource ID="odsUsoVehiculo" runat="server" OldValuesParameterFormatString="original_{0}"
      SelectMethod="GetData" TypeName="dsComboTableAdapters.UsoVehiculoComboTableAdapter">
      <SelectParameters>
        <asp:Parameter Name="estado" Type="String" />
      </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="odsMoneda" runat="server" OldValuesParameterFormatString="original_{0}"
      SelectMethod="GetData" TypeName="ADM_DAL.dsDropDownListTableAdapters.MonedaLoadDropDownTableAdapter">
      <SelectParameters>
        <asp:Parameter Name="estado" Type="String" />
      </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="odsDireccion" runat="server" OldValuesParameterFormatString="original_{0}"
      SelectMethod="GetData" TypeName="dsComboTableAdapters.DireccionComboTableAdapter">
      <SelectParameters>
        <asp:Parameter Name="estado" Type="String" />
      </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="odsTipoTraccion" runat="server" SelectMethod="tipoTraccionCombo"
      TypeName="CarCheck.Gestores.GestorCombos"></asp:ObjectDataSource>
    <asp:ObjectDataSource ID="odsTipoTimon" runat="server" OldValuesParameterFormatString="original_{0}"
      SelectMethod="tipoTimonCombo" TypeName="CarCheck.Gestores.GestorCombos"></asp:ObjectDataSource>
    <asp:ObjectDataSource ID="odsCabina" runat="server" OldValuesParameterFormatString="original_{0}"
      SelectMethod="GetData" TypeName="dsComboTableAdapters.CabinaComboTableAdapter">
      <SelectParameters>
        <asp:Parameter Name="estado" Type="String" />
      </SelectParameters>
    </asp:ObjectDataSource>
    <uc3:ucAnularInspeccion ID="UcAnularInspeccion1" runat="server" TriggerId="anularImageButton" />
    <asp:ObjectDataSource ID="odsTraccion" runat="server" OldValuesParameterFormatString="original_{0}"
      SelectMethod="GetData" TypeName="dsComboTableAdapters.TraccionComboTableAdapter">
      <SelectParameters>
        <asp:Parameter Name="estado" Type="String" />
      </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="odsClase" runat="server" OldValuesParameterFormatString="original_{0}"
      SelectMethod="GetData" TypeName="ADM_DAL.dsDropDownListTableAdapters.ClaseVehiculoLoadDropDownTableAdapter">
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="odsCarroceria" runat="server" OldValuesParameterFormatString="original_{0}"
      SelectMethod="GetData" TypeName="dsComboTableAdapters.CarroceriaComboTableAdapter">
      <SelectParameters>
        <asp:Parameter Name="estado" Type="String" />
      </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="odsCombustible" runat="server" OldValuesParameterFormatString="original_{0}"
      SelectMethod="GetData" TypeName="dsComboTableAdapters.CombustibleComboTableAdapter">
      <SelectParameters>
        <asp:Parameter Name="estado" Type="String" />
      </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="odsCambios" runat="server" OldValuesParameterFormatString="original_{0}"
      SelectMethod="GetData" TypeName="dsComboTableAdapters.TransmisionComboTableAdapter">
      <SelectParameters>
        <asp:Parameter Name="estado" Type="String" />
      </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="odsProcedencia" runat="server" OldValuesParameterFormatString="original_{0}"
      SelectMethod="GetData" TypeName="dsComboTableAdapters.ProcedenciaComboTableAdapter">
      <SelectParameters>
        <asp:Parameter Name="estado" Type="String" />
      </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="odsEstadoVehiculo" runat="server" OldValuesParameterFormatString="original_{0}"
      SelectMethod="GetData" TypeName="dsComboTableAdapters.EstadoVehiculoComboTableAdapter">
      <SelectParameters>
        <asp:Parameter Name="estado" Type="String" />
      </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="odsTmedicion" runat="server" OldValuesParameterFormatString="original_{0}"
      SelectMethod="GetData" TypeName="dsComboTableAdapters.TMedicionRecorridoComboTableAdapter">
      <SelectParameters>
        <asp:Parameter DefaultValue="A" Name="estado" Type="String" />
      </SelectParameters>
    </asp:ObjectDataSource>
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
        <asp:Parameter Name="cocheraUbigeodId" Type="String" />
        <asp:Parameter Name="valorSolicitado" Type="Decimal" />
        <asp:Parameter Name="valorSolicitadoMonedaId" Type="String" />
        <asp:Parameter Name="valorComercial" Type="Decimal" />
        <asp:Parameter Name="valorComercialMonedaId" Type="String" />
        <asp:Parameter Name="valorInspector" Type="Decimal" />
        <asp:Parameter Name="valorInspectorMonedaId" Type="String" />
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
  </form>
</body>
</html>
