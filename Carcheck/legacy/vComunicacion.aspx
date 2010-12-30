<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vComunicacion.aspx.cs" Inherits="vComunicacion" %>

<%@ Register Assembly="WebCalendarControl" Namespace="WebCalendarControl" TagPrefix="cc2" %>
<%@ Register Assembly="AutoSuggestBox" Namespace="ASB" TagPrefix="cc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
  <title>
    <%= CCSOL.Utiles.Utilidades.GetSystemNameAndVersion() %>
    | Comunicaciones</title>
  <link href="Css/layout.css" rel="stylesheet" type="text/css" />
  <link href="Css/layoutTabs.css" rel="stylesheet" type="text/css" />
  <link href="Scripts/jTabs/jTabs.css" rel="stylesheet" type="text/css" />

  <script type="text/javascript" src="Scripts/lib/x.js"></script>

  <script type="text/javascript" src="Scripts/lib/x_common.js"></script>

  <script type="text/javascript" src="../Scripts/lib/xDomReady.js"></script>

  <script type="text/javascript" src="Scripts/lib/xTab.js"></script>

  <script type="text/javascript" src="Scripts/lib/xCaseFormatter.js"></script>

  <script type="text/javascript">
     
    CCSOL.Utiles.LoadCSS("./Scripts/xCommon/xCommon.css");
    
                
    function doValidateInspector(sender, args) {
      args.IsValid = $('asbInspector').value != '' && $('asbInspector_SelectedValue').value != '';
    }                
                
    var estadoComunicacion = '';
    
    function isValidInspectionDate(sender, args) {      
       args.IsValid = vComunicacion.isValidDateTime($('wccFechaComunicacion').value).value;       
    }
    
    function isValidDateCita(sender, args) {
      if ($('horaInicioTextBox').value == '' || $('wccFechaInspeccion').value == '')  {
        args.IsValid = false;
        return;
      }
      args.IsValid = vComunicacion.isValidDateTimeForUser($('wccFechaInspeccion').value + ' ' + $('horaInicioTextBox').value).value;
    }
    
	  function GuardarComunicacion()
	  {
//      debugger;
	    var estadoComunicacion = $("estadoComunicacionRadioButton_0");
	    if(Page_ClientValidate() ) 
	     {
	     
	      if ( checkAll.allEmptyChecks()) 
	      {
	          alert("Debe Seleccionar algun vehiculo");
	          return false;
	      }
//	      if(estadoComunicacion.checked == false)
//	      {
//	        //alert("Se procede a guardar la comunicacion relacionada a los vehiculos seleccionados.\n\nSi se agendaron todos los vehiculos se cerrara la ventana");	           
//        }
// 	      else{
//	        //alert("Se guarda la comunicacion no exitosa para todos los registros de vehiculos y se cerrará la ventana de comunicación");
//	        //doRefresh();
//	      }	
        
        CCSOL.DOM.xLockBackground();
        
	      return true; 
	     }   
	     return false;
	  }
	
	  function EstadoChange(estadoIdCombo)
	  {
	    var displayInspeccion = "none";
	    var validatorEnabled = false;
	    estadoComunicacion = '';
	    
	    
	    $('observacionDiv').style.display = 'block';
	    
	    if(estadoIdCombo == "E"){
	      displayInspeccion = "block";
	      validatorEnabled = true;
	      estadoComunicacion = 'EXITOSA';	      
	      $('observacionDiv').style.display = 'none';  
	    }
	      
	    //$("separadorColumn").style.display = 'block';
	    $("inspeccionExitosaDiv").style.display = displayInspeccion;
	    
	    ValidatorEnable(observacionRFV, !validatorEnabled);
	    
//	    ValidatorEnable(finspeccionRFV, validatorEnabled);
//	    ValidatorEnable(horaInicioRFV, validatorEnabled);
//	    ValidatorEnable(horaFinRFV, validatorEnabled);
	    ValidatorEnable(contactoInspeccionRFV, validatorEnabled);
	    ValidatorEnable(direccionRFV, validatorEnabled);
	    ValidatorEnable(ubigeoIdRFV, validatorEnabled);
//	    ValidatorEnable(checkRFV, validatorEnabled);
	  }
	  
	  function VehiculoCheckChanged(vehiculoCheckBox)
	  {
	    var checkTextBox  = $("checkTextBox");
	    if(vehiculoCheckBox.checked)
	      checkTextBox.value = checkTextBox.value + vehiculoCheckBox.id + ";";
	    else
	      checkTextBox.value = Trim(checkTextBox.value, vehiculoCheckBox.id + ";");
	  }
	  
	  function Trim(originalString, trimString)
	  {
	    var indexIni = originalString.indexOf(trimString);
	    var indexFin = indexIni + trimString.length;
	    return originalString.substring(0, indexIni) + originalString.substring(indexFin, originalString.length);
	  }
	
	  CCSOL.Utiles.LoadScript('Scripts/lib/x_checkAll.js');
	  
	  function doTimeCalculations() {
       var numItems = checkAll.getNumberOfCheckedItems();

       if (numItems == 0) { 
        alert('Debe Seleccionar al menos una inspección');	    
        return false;
       }
       if ($('horaInicioTextBox').value == '') return false;
       if ($('wccFechaInspeccion').value == '') return false;
       
       if (numItems == -1) return false;              
       
	     vComunicacion.doTimeCalculations($('wccFechaInspeccion').value,$('horaInicioTextBox').value,numItems,doTimeCalculationsCallBack);
	  }
	  function doTimeCalculationsCallBack(res) {
	    if (res.value == '--')  { 
	      alert('No se pudo calcular la hora de finalización \nquizá la fecha de la inspección no tiene el formato correcto\nAsegurese que la fecha esté en el formato dd/mm/yyyy \ny que la hora esté en el formato HH:mm');
	      $('horaInicioTextBox').focus();
	    }
	    else {
	      $('horaFinTextBox').value = res.value;
	    }
	  }
	  var checkAll = null;	  	  
		window.onload = function () {
			var t = new xTab('theTabPanel','itemCenterTab');
			checkAll = new xCheckAllN('GridViewInspeciones_ctl01_CheckBoxTodos','inspeccionPanel','ItemStyle','ItemStyleOver',checkAll_OnItemsChange);
			xAddEventListener($('horaInicioTextBox'),'blur',doTimeCalculations,false);
			$('horaFinTextBox').readOnly = true;
		}
		
		function checkAll_OnItemsChange(xCheckAllObj) 
		{
		  //alert('algo ha cambiado');
		  doTimeCalculations();
		}
		
	
  </script>

  <link href="./Scripts/wcc_includes/calendar-brown.css" rel="stylesheet" type="text/css" />
  <link href="./Scripts/wcc_includes/calendar-brown.css" rel="stylesheet" type="text/css" />
  <link href="./Scripts/wcc_includes/calendar-brown.css" rel="stylesheet" type="text/css" />
</head>
<body>
  <form id="form1" runat="server">
    <div class="DataTop">
      <div class="DataTopLeft">
      </div>
      <div class="DataTopRight">
      </div>
    </div>
    <div class="DataContent" id="registroDataContent" style="z-index:1000">
      <div class="DataContentRight" id="registroDataContentRight">
        <div class="PanelEncabezado">
          <asp:Label ID="comuniacionLabel" runat="server" Style="cursor: default" Text="Comunicación"></asp:Label>
        </div>
        <div class="hr">
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%">
          <tr>
            <td style="width: 265px" valign="top" class="DataTable">
              <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                  <td style="width: 100px">
                    Fecha / Hora
                    <asp:CustomValidator ID="CustomValidator1" runat="server" ClientValidationFunction="isValidInspectionDate"
                      ControlToValidate="contactoTextBox" ErrorMessage="Fecha Inválida" ToolTip="Ingrese una fecha/hora con el formato dd/mm/yyyy HH:mm" Font-Bold="True">(*)</asp:CustomValidator></td>
                  <td>
                    <cc2:WebCalendar ID="wccFechaComunicacion" runat="server" BtnCalendarImage="./Scripts/wcc_includes/img/cal.gif"
                      CssClass="FormText" GenerateBtn="True" WcResourcesDir="./Scripts/wcc_includes"
                      WcStyleSheet="calendar-brown.css" Width="131px" IfFormat="%d/%m/%Y %H:%M" ShowsTime="True"></cc2:WebCalendar></td>
                </tr>
                <tr>
                  <td style="width: 86px; height: 18px;">
                    Contacto<asp:RequiredFieldValidator ID="contactoRFV" runat="server" ControlToValidate="contactoTextBox"
                      ErrorMessage="Ingrese el nombre del contacto de la comunicación" Font-Bold="True">(*)</asp:RequiredFieldValidator></td>
                  <td style="height: 18px">
                    <asp:TextBox ID="contactoTextBox" runat="server" CssClass="FormText" Width="150px"></asp:TextBox></td>
                </tr>
                <tr>
                  <td style="width: 86px">
                    Tipo Actividad<asp:RequiredFieldValidator ID="tActividadIdRFV" runat="server" ControlToValidate="tActividadIdCombo"
                      ErrorMessage="Especifique el tipo de comunicación" Font-Bold="True" CssClass="DataValidator">(*)</asp:RequiredFieldValidator></td>
                  <td style="padding-top: 1px">
                    <asp:DropDownList ID="tActividadIdCombo" runat="server" CssClass="FormText" Width="153px"
                      AppendDataBoundItems="True" DataSourceID="odsTipoComunicacion" DataTextField="tcomunicacion"
                      DataValueField="tcomunicacionId">
                      <asp:ListItem Value="-1">[- Elija -]</asp:ListItem>
                    </asp:DropDownList></td>
                </tr>
                <tr>
                  <td style="width: 86px">
                    Resultado</td>
                  <td style="padding-top: 2px">
                    <asp:RadioButtonList ID="estadoComunicacionRadioButton" runat="server" RepeatDirection="Horizontal">
                      <asp:ListItem Selected="True" Value="N" onclick="EstadoChange(this.value);">No Exitoso</asp:ListItem>
                      <asp:ListItem Value="E" onclick="EstadoChange(this.value);">Exitoso</asp:ListItem>
                    </asp:RadioButtonList></td>
                </tr>
                <tr>
                  <td style="padding-top: 2px; height: 36px;" colspan="2">
                    <input id="Button2" class="FormButton" style="float: right; width: 60px" type="button"
                      value="Salir" onclick="window.top.hidePopWindow();" />
                    <asp:Button ID="btnGuardar" Style="float: right" runat="server" CssClass="FormButton"
                      Text="Guardar Comunicación" Width="182px" OnClick="Button3_Click" OnClientClick="return GuardarComunicacion();" /></td>
                </tr>
              </table>
            </td>
            <td valign="top" id="separadorColumn" runat="server" width="10" style="display: block">
            </td>
            <td valign="top" class="DataTable">
              <div runat="server" id="inspeccionExitosaDiv" style="display: block;z-index:6000;">
                <table border="0" cellpadding="0" cellspacing="0">
                  <tr>
                    <td style="width: 90px">
                      Fecha Ins.
                      <asp:CustomValidator ID="CustomValidator2" runat="server" ClientValidationFunction="isValidDateCita"
                        ControlToValidate="horaInicioTextBox" ErrorMessage="Ha ocurrido un error: la fecha tiene un formato inválido o es válido pero es una fecha menor a la fecha actual y no tiene el permiso necesario para registrar fechas inferiores a la de hoy"
                        ToolTip="Ha ocurrido un error: la fecha tiene un formato inválido o es válido pero es una fecha menor a la fecha actual y no tiene el permiso necesario para registrar fechas inferiores a la de hoy" Font-Bold="True">(*)</asp:CustomValidator></td>
                    <td>
                      <cc2:WebCalendar ID="wccFechaInspeccion" runat="server" BtnCalendarImage="./Scripts/wcc_includes/img/cal.gif"
                        CssClass="FormText" GenerateBtn="True" WcResourcesDir="./Scripts/wcc_includes"
                        WcStyleSheet="calendar-brown.css" Width="90px"></cc2:WebCalendar>De
                      <asp:TextBox ID="horaInicioTextBox" runat="server" CssClass="FormText" Width="50px"></asp:TextBox>
                      a
                      <asp:TextBox ID="horaFinTextBox" runat="server" CssClass="FormText readOnly" Width="50px"></asp:TextBox>
                      hrs</td>
                  </tr>
                  <tr>
                    <td style="width: 90px">
                      Contacto<asp:RequiredFieldValidator ID="contactoInspeccionRFV" runat="server" ControlToValidate="contactoInspeccionTextBox"
                        ErrorMessage="Ingrese el contacto para la inspeccón" Font-Bold="True" Enabled="False">(*)</asp:RequiredFieldValidator></td>
                    <td>
                      <asp:TextBox ID="contactoInspeccionTextBox" runat="server" CssClass="FormText" Width="160px"></asp:TextBox>&nbsp;
                      Telf.
                      <asp:TextBox ID="telefonoTextBox" runat="server" CssClass="FormText" Width="74px"></asp:TextBox>
                    </td>
                  </tr>
                  <tr>
                    <td style="width: 90px">
                      Dirección<asp:RequiredFieldValidator ID="direccionRFV" runat="server" ControlToValidate="direccionTextBox"
                        ErrorMessage="Ingrese la dirección de la inspección" Font-Bold="True" Enabled="False">(*)</asp:RequiredFieldValidator></td>
                    <td>
                      <asp:TextBox ID="direccionTextBox" runat="server" CssClass="FormText" Width="276px"></asp:TextBox></td>
                  </tr>
                  <tr>
                    <td style="width: 90px">
                      Ubigeo<asp:RequiredFieldValidator ID="ubigeoIdRFV" runat="server" ControlToValidate="asbDistrito"
                        ErrorMessage="Ingrese el ubigeo de la inspección" Font-Bold="True" Enabled="False">(*)</asp:RequiredFieldValidator></td>
                    <td>
                      <cc1:AutoSuggestBox ID="asbDistrito" runat="server" CssClass="FormText" DataType="Distrito"
                        IncludeMoreMenuItem="True" KeyPressDelay="300" MaxSuggestChars="15" MenuCSSClass="asbMenu"
                        MenuItemCSSClass="asbMenuItem" MoreMenuItemLabel="..." NoValueSelectedCSSClass="asbNonValueSelected"
                        NumMenuItems="15" OnFocusShowAll="False" ResourcesDir="./Scripts/asb_includes"
                        SelectedValue='<%# Bind("ubigeoIdTrabajo") %>' SelMenuItemCSSClass="asbSelMenuItem"
                        Text='<%# Eval("distritoTrabajo") %>' UseIFrame="True" WarnNoValueSelected="False"
                        Width="275px"></cc1:AutoSuggestBox>
                    </td>
                  </tr>
                  <tr>
                    <td style="height: 19px; width: 90px;">
                      Inspector<asp:CustomValidator ID="CustomValidator3" runat="server" ClientValidationFunction="doValidateInspector"
                        ControlToValidate="asbInspector" ErrorMessage="Seleccione un Inspector de la Lista"
                        Font-Bold="True" ToolTip="Seleccione un Inspector de la Lista">(*)</asp:CustomValidator></td>
                    <td style="padding-top: 1px; height: 19px;">
                      <cc1:AutoSuggestBox ID="asbInspector" runat="server" CssClass="FormText" DataType="Inspector"
                        MaxSuggestChars="15" OnFocusShowAll="True" ResourcesDir="./Scripts/asb_includes"
                        Width="275px"></cc1:AutoSuggestBox></td>
                  </tr>
                </table>
              </div>
              <div id="observacionDiv" runat="server">
                <table border="0" cellpadding="0" cellspacing="0">
                  <tr>
                    <td style="width: 90px; padding-top: 2px;" valign="top">
                      Observación<asp:RequiredFieldValidator ID="observacionRFV" runat="server" ControlToValidate="observacionTextBox"
                        ErrorMessage="Ingrese una observación" Font-Bold="True">(*)</asp:RequiredFieldValidator></td>
                    <td style="padding-top: 1px;">
                      <asp:TextBox ID="observacionTextBox" runat="server" CssClass="FormText" Rows="4"
                        TextMode="MultiLine" Width="275px" Height="48px"></asp:TextBox></td>
                  </tr>
                </table>
              </div>
            </td>
          </tr>
        </table>
      </div>
    </div>
    <div class="DataBottom">
      <div class="DataBottomLeft">
      </div>
      <div class="DataBottomRight">
      </div>
    </div>
    <div id="theTabPanel">
      <div id="Div1" runat="server" class="mainTab xTabHeader">
        <div runat="server" id="tab1" enableviewstate="true" class="itemTab">
          <div class="itemLeftBackTab">
          </div>
          <a runat="server" id="lnkTab1" onclick="return false;" class="itemCenterBackTab tabTrigger"
            href="##">Inspecciones</a>
          <div class="itemRightBackTab">
          </div>
        </div>
        <div runat="server" id="tab2" enableviewstate="true" class="itemTab">
          <div class="itemLeftBackTab">
          </div>
          <a runat="server" id="lnkTab2" onclick="return false;" class="itemCenterBackTab tabTrigger"
            href="##">Comunicaciones</a>
          <div class="itemRightBackTab">
          </div>
        </div>
      </div>
      <div class="DataContent" >
        <div class="DataContentRight">
          <div class="tabContainer" style="position:relative;">
            <div id="inspeccionPanel" style="height: 200px;position:relative;z-index:100;" class="PanelInset">
              <asp:GridView ID="GridViewInspeciones" runat="server" AutoGenerateColumns="False"
                CssClass="DataTable" DataSourceID="odsInspecciones" Width="630px" OnRowDataBound="GridViewInspeciones_RowDataBound">
                <Columns>
                  <asp:BoundField DataField="solicitudId" HeaderText="solicitudId" InsertVisible="False"
                    ReadOnly="True" SortExpression="solicitudId" Visible="False" />
                  <asp:BoundField DataField="inspeccionId" HeaderText="inspeccionId" InsertVisible="False"
                    ReadOnly="True" SortExpression="inspeccionId">
                    <ItemStyle CssClass="invisible" />
                    <HeaderStyle CssClass="invisible" />
                  </asp:BoundField>
                  <asp:BoundField DataField="claseVehiculo" HeaderText="claseVehiculo" SortExpression="claseVehiculo"
                    Visible="False" />
                  <asp:TemplateField>
                    <ItemStyle Width="10px" HorizontalAlign="Center" />
                    <ItemTemplate>
                      <asp:CheckBox ID="chk" Text="" runat="server" />
                    </ItemTemplate>
                    <HeaderTemplate>
                      <asp:CheckBox ID="CheckBoxTodos" Text="" runat="server" />
                    </HeaderTemplate>
                    <HeaderStyle Width="10px" />
                  </asp:TemplateField>
                  <asp:BoundField DataField="placa" HeaderText="Placa" SortExpression="placa">
                    <ItemStyle HorizontalAlign="Center" />
                  </asp:BoundField>
                  <asp:BoundField DataField="marcaVehiculo" HeaderText="Marca" SortExpression="marcaVehiculo">
                    <ItemStyle HorizontalAlign="Center" />
                  </asp:BoundField>
                  <asp:BoundField DataField="modeloVehiculo" HeaderText="Modelo" SortExpression="modeloVehiculo">
                    <ItemStyle HorizontalAlign="Center" />
                  </asp:BoundField>
                  <asp:BoundField DataField="estadoInspeccion" HeaderText="Estado" SortExpression="estadoInspeccion">
                    <ItemStyle HorizontalAlign="Center" />
                  </asp:BoundField>
                  <asp:TemplateField HeaderText="Contacto" SortExpression="contacto">
                    <EditItemTemplate>
                      <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("contacto") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                      <table border='0' cellpadding='0' cellspacing='0' width='100%'>
                        <tr>
                          <td style="padding-right: 1px; padding-left: 1px; padding-bottom: 1px; padding-top: 1px"
                            colspan="3">
                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("contacto") %>' Font-Bold="True"></asp:Label></td>
                        </tr>
                        <tr>
                          <td style="padding-right: 1px; padding-left: 1px; padding-bottom: 1px; padding-top: 1px">
                            <asp:Label ID="Label5" runat="server" Font-Bold="True" Text="Teléfonos"></asp:Label></td>
                          <td style="padding-right: 1px; padding-left: 1px; padding-bottom: 1px; padding-top: 1px">
                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("telefono1") %>'></asp:Label>
                          </td>
                          <td style="padding-right: 1px; padding-left: 1px; padding-bottom: 1px; padding-top: 1px">
                            <asp:Label ID="Label3" runat="server" Text='<%# Bind("telefono2") %>'></asp:Label></td>
                        </tr>
                        <tr>
                          <td style="padding-right: 1px; padding-left: 1px; padding-bottom: 1px; padding-top: 1px">
                            <asp:Label ID="Label6" runat="server" Font-Bold="True" Text="Email:"></asp:Label></td>
                          <td colspan="2" style="padding-right: 1px; padding-left: 1px; padding-bottom: 1px;
                            padding-top: 1px">
                            <asp:Label ID="Label4" runat="server" Text='<%# Bind("email") %>'></asp:Label></td>
                        </tr>
                      </table>
                    </ItemTemplate>
                    <ItemStyle Width="180px" />
                  </asp:TemplateField>
                </Columns>
                <HeaderStyle CssClass="HeaderStyle" />
                <RowStyle CssClass="ItemStyle" />
                <EmptyDataTemplate>
                  <div style="padding: 5px;">
                    <asp:Label ID="Label7" runat="server" Font-Bold="True" Font-Size="14px" ForeColor="SaddleBrown"
                      Text="No hay registros para mostrar"></asp:Label><br />
                    <br />
                    ES POSIBLE QUE NO HAYA INSPECCIONES QUE PUEDAN SER AGENDADAS A TRAVÉS DE ESTA FUNCIONALIDAD
                  </div>
                </EmptyDataTemplate>
              </asp:GridView>
              <br />
              <br />
            </div>
          </div>
          <div class="tabContainer">
            <div id="comunicacionPanel" style="height: 200px;" class="PanelInset">
              <asp:GridView ID="GridViewComunicacion" runat="server" AutoGenerateColumns="False"
                CssClass="DataTable" DataSourceID="odsComunicaciones" Width="630px">
                <Columns>
                  <asp:BoundField DataField="numeInspeccion" HeaderText="N&#176; Inspecci&#243;n"
                    SortExpression="numeInspeccion" />
                  <asp:BoundField DataField="solicitudId" HeaderText="solicitudId" InsertVisible="False"
                    ReadOnly="True" SortExpression="solicitudId" Visible="False" />
                  <asp:BoundField DataField="inspeccionId" HeaderText="inspeccionId" InsertVisible="False"
                    ReadOnly="True" SortExpression="inspeccionId" Visible="False" />
                  <asp:BoundField DataField="contacto" HeaderText="Contacto" SortExpression="contacto">
                    <ItemStyle Width="200px" />
                  </asp:BoundField>
                  <asp:BoundField DataField="fcomunicacion" DataFormatString="{0:dd-MM-yyyy HH:mm}"
                    HeaderText="Fecha/Hora" SortExpression="fcomunicacion" HtmlEncode="False">
                    <ItemStyle Width="110px" />
                  </asp:BoundField>
                  <asp:TemplateField HeaderText="Resultado">
                    <ItemTemplate>
                      <asp:Label ID="Label1" runat="server" Text='<%# muestraResultado(Eval("resultado")) %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle CssClass="ItemStyle" Width="60px" />
                  </asp:TemplateField>
                  <asp:BoundField DataField="observacion" HeaderText="Observaci&#243;n" SortExpression="observacion" />
                </Columns>
                <HeaderStyle CssClass="HeaderStyle" />
                <EmptyDataTemplate>
                  <div style="padding: 5px;">
                    <asp:Label ID="Label7" runat="server" Font-Bold="True" Font-Size="14px" ForeColor="SaddleBrown"
                      Text="No hay registros para mostrar"></asp:Label>&nbsp;</div>
                </EmptyDataTemplate>
              </asp:GridView>
              &nbsp;<br />
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
    </div>
  </form>
  <asp:ObjectDataSource ID="odsInspecciones" runat="server" OldValuesParameterFormatString="original_{0}"
    SelectMethod="GetData" TypeName="dsAgendaTableAdapters.InspeccionesPendientesTableAdapter"
    OnSelecting="odsInspecciones_Selecting" OnSelected="odsInspecciones_Selected">
    <SelectParameters>
      <asp:QueryStringParameter Name="solicitudId" QueryStringField="SolicitudId" Type="Decimal" />
    </SelectParameters>
  </asp:ObjectDataSource>
  <asp:ObjectDataSource ID="odsComunicaciones" runat="server" OldValuesParameterFormatString="original_{0}"
    SelectMethod="GetData" TypeName="dsAgendaTableAdapters.ComunicacionesPorInspeccionesPendientesTableAdapter"
    OnSelecting="odsComunicaciones_Selecting">
    <SelectParameters>
      <asp:QueryStringParameter Name="solicitudId" QueryStringField="solicitudId" Type="Decimal" />
    </SelectParameters>
  </asp:ObjectDataSource>
  <asp:ObjectDataSource ID="odsTipoComunicacion" runat="server" OldValuesParameterFormatString="original_{0}"
    SelectMethod="GetData" TypeName="dsComboTableAdapters.TComunicacionComboTableAdapter">
    <SelectParameters>
      <asp:Parameter DefaultValue="A" Name="estado" Type="String" />
    </SelectParameters>
  </asp:ObjectDataSource>
</body>
</html>
