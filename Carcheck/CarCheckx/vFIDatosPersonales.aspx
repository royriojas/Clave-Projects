<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vFIDatosPersonales.aspx.cs"
  Inherits="vFIDatosPersonales" %>

<%@ Register Src="ucAnularInspeccion.ascx" TagName="ucAnularInspeccion" TagPrefix="uc3" %>
<%@ Register Assembly="CustomPanelWebControl" Namespace="xWebControl" TagPrefix="cc3" %>
<%@ Register Assembly="WebCalendarControl" Namespace="WebCalendarControl" TagPrefix="cc2" %>
<%@ Register Src="ucHeader.ascx" TagName="ucHeader" TagPrefix="uc1" %>
<%@ Register Assembly="AutoSuggestBox" Namespace="ASB" TagPrefix="cc1" %>
<%@ Register Src="~/ucControlTab.ascx" TagName="ControlTab" TagPrefix="uc2" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
  <title>
    <%=CCSOL.Utiles.Utilidades.GetSystemNameAndVersion() %>
    | Inspección | Datos Personales</title>

  <script type="text/javascript" src="Scripts/lib/x.js"></script>

  <script type="text/javascript" src="Scripts/lib/x_common.js"></script>

  <script type="text/javascript" src="Scripts/lib/xDropDownMenu.js"></script>

  <script type="text/javascript" src="Scripts/lib/x_CheckHabilitador.js"></script>

  <script type="text/javascript">
  
  function _initCheckAlerta() {
    var xCheckAlerta = new xCheckEnabler($('frmvAlertas_chkAlerta'),'frmvAlertas_cbxAlerta','deshabilitado');
  }
  
  xAddEventListener(window,'load',_initCheckAlerta,true);
  
  
  function doValidateAlert(sender, args) 
  {
    if (!$('frmvAlertas_chkAlerta').checked) {
      args.IsValid = true;
      return;
    }
    args.IsValid = (args.Value != -1);
    return;    
  }
  </script>

  <script type="text/javascript">
    
    function xMenuNotificacion_onAutoHide() {
      return false;
    }
    function setCambio(){
      $('frmvAsegurado_txtCambio').value = '1';
    }
    function perfomDataSearch() {
        try 
        {
        vFIDatosPersonales.performDataSearch($('frmvContratante_asbContratante_SelectedValue').value,showPersonData_CallBack);
        }
        catch(e)
        {alert(e.message);}          
    }
    function perfomDataAsegurado() {
      if (<%= couldBeModify().ToString().ToLower() %>) {
        try 
        {
        vFIDatosPersonales.performDataSearch($('frmvAsegurado_asbAsegurado_SelectedValue').value,showPersonAsegurado_CallBack);
        $('frmvAsegurado_txtCambio').value = '0';
        }
        catch(e)
        {alert(e.message);} 
      }         
      else {
        
      }
    }    
    function showPersonData_CallBack(res){
    try {
          var p = res.value;
           if (xDef(p)) {
                              
                $('frmvContratante_txtDireccion').value = p.direccion ;
                $('frmvContratante_AutoSuggestBox1').value = p.ubigeo ;
                $('frmvContratante_txtEmail').value = p.email ;        
                $('frmvContratante_txtNroDocumento').value = p.docid  ;
                $('frmvContratante_cbxTipoDocumento').value = p.tdoidId ;
                $('frmvContratante_txtTelefono').value = p.tfijo ;
                $('frmvContratante_txtFax').value = p.tfax ;
                $('frmvContratante_txtOtroTelefono').value = p.otroTelefono ;
                $('frmvContratante_txtContratanteId').value = p.personaId ;
            }
       }
    catch(e){
    }
    }
   function showPersonAsegurado_CallBack(res){
      try {  
       
            var p = res.value;
             if (xDef(p)) {
                  
                  $('frmvAsegurado_txtDireccionAsegurado').value = p.direccionTrabajo ;
                  $('frmvAsegurado_AutoSuggestBox2').value = p.distritoTrabajo ;
                  $('frmvAsegurado_txtEmailAsegurado').value = p.email ;        
                  $('frmvAsegurado_txtTipoDocumentoAsegurado').value = p.DocumentoIdentidad  ;
                  $('frmvAsegurado_cbxTipoDocumentoAsegurado').value = p.TDocumentoIdentidad ;
                  $('frmvAsegurado_txtTelefonoAsegurado').value = p.TelefonoFijo1 ;
                  $('frmvAsegurado_txtFaxAsegurado').value = p.Fax ;
                  $('frmvAsegurado_txtOtroTelefonoAsegurado').value = p.TelefonoFijo2 ;
                  $('frmvAsegurado_txtOcupacionAsegurado').value = p.ocupacionGiro;
                  $('frmvAsegurado_txtFechaExpedicion').value = p.brevetefExpedicion;
                  $('frmvAsegurado_txtBrevete').value = p.brevete;
                  $('frmvAsegurado_txtFechaVencimiento').value = p.brevetefVencimiento;
                  $('frmvAsegurado_txtAseguradoId').value = p.personaId;
                  
              }
         }
      catch(e)
      {
      
      }
   }    
    CCSOL.Utiles.LoadScript("Scripts/lib/xDropDownMenu.js");
//    var xMenuAnular = null;
    window.onload = function () {
      try {
      
        //xAddEventListener($('frmvContratante_asbContratante'),'blur',perfomDataSearch,true);
        xAddEventListener($('frmvAsegurado_asbAsegurado'),'blur',perfomDataAsegurado,true);
        xAddEventListener($('frmvAsegurado_cbxTipoDocumentoAsegurado'),'keypress',setCambio,true);
        xAddEventListener($('frmvAsegurado_txtTipoDocumentoAsegurado'),'keypress',setCambio,true);
        xAddEventListener($('frmvAsegurado_txtDireccionAsegurado'),'keypress',setCambio,true);
        xAddEventListener($('frmvAsegurado_txtTelefonoAsegurado'),'keypress',setCambio,true);
        xAddEventListener($('frmvAsegurado_AutoSuggestBox2'),'keypress',setCambio,true);
        xAddEventListener($('frmvAsegurado_txtFaxAsegurado'),'keypress',setCambio,true);
        xAddEventListener($('frmvAsegurado_txtFaxAsegurado'),'keypress',setCambio,true);
        xAddEventListener($('frmvAsegurado_txtEmailAsegurado'),'keypress',setCambio,true);
        xAddEventListener($('frmvAsegurado_txtOcupacionAsegurado'),'keypress',setCambio,true);
        xAddEventListener($('frmvAsegurado_txtFechaExpedicion'),'keypress',setCambio,true);
        xAddEventListener($('frmvAsegurado_txtBrevete'),'keypress',setCambio,true);
        xAddEventListener($('frmvAsegurado_txtFechaVencimiento'),'keypress',setCambio,true);
        var dropDownTitle = new xDropDownToolTip('aDropDownWithTitle',null);
        var contLabel = new CollapsibleDiv ('contratanteLabel', 'contratanteData', true, null);
        var contImage = new CollapsibleDiv ('contratanteImage', 'contratanteData', true, null);
        var asegLabel = new CollapsibleDiv ('aseguradoLabel', 'aseguradoData', true, null);
        var asegImage = new CollapsibleDiv ('aseguradoImage', 'aseguradoData', true, null);
        var alerLabel = new CollapsibleDiv ('alertaLabel', 'alertaData', true, null);
        var alerImage = new CollapsibleDiv ('alertaImage', 'alertaData', true, null);
        
//       xMenuAnular = new xDropDownMenu('dropDownAnular',       //el div que aparecerá en el punto de click
//									    'anularImageButton', //el "map" area que contiene los hotspots que provocarán que aparezca el PopUpForm
//									    'context',		 //Se muestra en el punto de click ('d' = dropDownMenu,null = en el punto de click, 'context' = menu contextual
//									    'click',			 //el evento al que queremos asociar la aparición del Div
//									    null,			 	 //posicion en la que queremos que aparezca el div, 'left', 'right' o null solo tiene sentido cuando el menu es tipo 'd'
//									    null,	 //evento que se ejecuta al mostrarse el div

//									    xMenuNotificacion_onAutoHide,//evento que se llama al ocurrir un mouseout 
//									    true
//									    );
        
      }
      catch(e)
      {
        //alert(e.message);
      }
    } 
    
    function doSaving() {
      if (typeof(Page_ClientValidate) == 'function') { 
         if (Page_ClientValidate()) {
            CCSOL.DOM.xShowLoadingMessage('Actualizando');
            CCSOL.DOM.xLockBackground();
            return true;
          }
      }
      return false;                    
    }
    
    
    
   
  </script>

  <link href="Css/layoutTabs.css" rel="stylesheet" type="text/css" />
  <link href="css/layout.css" rel="stylesheet" type="text/css" />
  <link href="./Scripts/asb_includes/AutoSuggestBox.css" rel="stylesheet" type="text/css" />
  <link href="./Scripts/wcc_includes/calendar-brown.css" rel="stylesheet" type="text/css" />
  <link href="./Scripts/x_info/xInfo.css" rel="stylesheet" type="text/css" />
  <link href="Css/layoutTabs.css" rel="stylesheet" type="text/css" />
</head>
<body>
  <form id="form1" runat="server">
    <div id='MainDiv' class="Blockable">
      <table id="Data" border="0" cellpadding="0" cellspacing="0" align="center">
        <tr>
          <td>
            <uc1:ucHeader ID="UcHeader1" runat="server" MainFormName="form1" OnLoad="UcHeader1_Load"
              PageFunctionalityToCheck="INS_DATOSGENERALES_VER" />
            <uc2:ControlTab ID="ControlTab1" TabActual="DatosPersonales" runat="server" LabelText="Inspección : INS - 002-XXX" />
            <div class="DataContent">
              <div class="DataContentRight" style="padding-top: 1px">
                <div class="PanelStyle" style="margin-top: 4px">
                  <div class="PanelEncabezado">
                    <asp:Label ID="contratanteLabel" runat="server" Text="Contratante" Style="cursor: default"
                      ToolTip="Mostrar / Ocultar Panel"></asp:Label>
                    <img id="contratanteImage" alt="Mostrar / Ocultar Panel" src="Images/IconHide16Dark.gif"
                      title="Mostrar / Ocultar Panel" /></div>
                  <div id="contratanteData" class="DataTable" style="position: relative;">
                    <asp:FormView ID="frmvContratante" runat="server" DataKeyNames="personaId" DataSourceID="odsContratante">
                      <EditItemTemplate>
                        <table border="0" cellpadding="0" cellspacing="0">
                          <tr>
                            <td style="width: 150px;">
                              Nombre Razón Social
                            </td>
                            <td style="">
                              <cc1:AutoSuggestBox ID="asbContratante" runat="server" CssClass="FormText" DataType="Contratante"
                                IncludeMoreMenuItem="False" KeyPressDelay="300" MaxSuggestChars="8" MenuCSSClass="asbMenu"
                                MenuItemCSSClass="asbMenuItem" MoreMenuItemLabel="..." NoValueSelectedCSSClass="asbNonValueSelected"
                                NumMenuItems="15" OnFocusShowAll="True" ResourcesDir="./Scripts/asb_includes" SelMenuItemCSSClass="asbSelMenuItem"
                                Style="position: static" Text='<%# Bind("persona") %>' UseIFrame="False" WarnNoValueSelected="False"
                                Width="200px"></cc1:AutoSuggestBox></td>
                            <td style="width: 10px;">
                            </td>
                            <td style="width: 120px;">
                              Tipo de Documento</td>
                            <td style="">
                              <asp:DropDownList ID="cbxTipoDocumento" runat="server" CssClass="FormText tt_help_info aDropDownWithTitle"
                                Width="82px" AppendDataBoundItems="True" DataSourceID="odsTipoDocumentoContratante"
                                DataTextField="tdocid" DataValueField="tdocidId" SelectedValue='<%# Bind("TDocumentoIdentidad") %>'>
                                <asp:ListItem Value="-1">[-Elija-]</asp:ListItem>
                              </asp:DropDownList></td>
                            <td align="right" style="width: 89px;">
                              <asp:TextBox ID="txtNroDocumento" runat="server" CssClass="FormText" Text='<%# Bind("DocumentoIdentidad") %>'
                                Width="115px"></asp:TextBox></td>
                          </tr>
                          <tr>
                            <td style="width: 150px;">
                              Dirección</td>
                            <td style="">
                              <asp:TextBox ID="txtDireccion" runat="server" CssClass="FormText" Text='<%# Bind("direccionTrabajo") %>'
                                Width="200px"></asp:TextBox></td>
                            <td style="">
                            </td>
                            <td style="width: 120px;">
                              Teléfono</td>
                            <td colspan="2" style="">
                              <asp:TextBox ID="txtTelefono" runat="server" CssClass="FormText" Text='<%# Bind("TelefonoFijo1") %>'
                                Width="200px"></asp:TextBox></td>
                          </tr>
                          <tr>
                            <td style="width: 150px;">
                              Distrito
                            </td>
                            <td style="">
                              <cc1:AutoSuggestBox ID="AutoSuggestBox1" runat="server" CssClass="FormText" DataType="Distrito"
                                IncludeMoreMenuItem="True" KeyPressDelay="300" MaxSuggestChars="15" MenuCSSClass="asbMenu"
                                MenuItemCSSClass="asbMenuItem" MoreMenuItemLabel="..." NoValueSelectedCSSClass="asbNonValueSelected"
                                NumMenuItems="15" OnFocusShowAll="False" ResourcesDir="./Scripts/asb_includes"
                                SelectedValue='<%# Bind("ubigeoIdTrabajo") %>' SelMenuItemCSSClass="asbSelMenuItem"
                                Text='<%# Eval("distritoTrabajo") %>' UseIFrame="True" WarnNoValueSelected="False"
                                Width="200px"></cc1:AutoSuggestBox>
                            </td>
                            <td style="">
                            </td>
                            <td style="width: 120px;">
                              Fax</td>
                            <td colspan="2" style="">
                              <asp:TextBox ID="txtFax" runat="server" CssClass="FormText" Text='<%# Bind("Fax") %>'
                                Width="200px"></asp:TextBox></td>
                          </tr>
                          <tr>
                            <td style="width: 150px">
                              Email</td>
                            <td>
                              <asp:TextBox ID="txtEmail" runat="server" CssClass="FormText" Text='<%# Bind("email") %>'
                                Width="200px"></asp:TextBox></td>
                            <td>
                            </td>
                            <td style="width: 120px">
                              Otro Teléfono</td>
                            <td colspan="2">
                              <asp:TextBox ID="txtOtroTelefono" runat="server" CssClass="FormText" Text='<%# Bind("TelefonoFijo2") %>'
                                Width="200px"></asp:TextBox></td>
                          </tr>
                        </table>
                        <asp:ObjectDataSource ID="odsTipoDocumentoContratante" runat="server" OldValuesParameterFormatString="original_{0}"
                          SelectMethod="GetData" TypeName="ADM_DAL.dsDropDownListTableAdapters.TDocIdLoadDropDownTableAdapter">
                          <SelectParameters>
                            <asp:Parameter DefaultValue="A" Name="estado" Type="String" />
                          </SelectParameters>
                        </asp:ObjectDataSource>
                      </EditItemTemplate>
                      <EmptyDataTemplate>
                        <br />
                      </EmptyDataTemplate>
                      <ItemTemplate>
                        <table border="0" cellpadding="0" cellspacing="0" style="position: static">
                          <tr>
                            <td style="width: 150px;">
                              Nombre Razón Social
                            </td>
                            <td style="">
                              <cc1:AutoSuggestBox ID="asbContratante" runat="server" CssClass="FormText" DataType="Contratante"
                                IncludeMoreMenuItem="False" KeyPressDelay="300" MaxSuggestChars="8" MenuCSSClass="asbMenu"
                                MenuItemCSSClass="asbMenuItem" MoreMenuItemLabel="..." NoValueSelectedCSSClass="asbNonValueSelected"
                                NumMenuItems="15" OnFocusShowAll="True" ResourcesDir="./Scripts/asb_includes" SelMenuItemCSSClass="asbSelMenuItem"
                                Style="position: static" Text='<%# Bind("persona") %>' UseIFrame="False" WarnNoValueSelected="False"
                                Width="200px" ReadOnly="True"></cc1:AutoSuggestBox></td>
                            <td style="width: 10px;">
                            </td>
                            <td style="width: 120px;">
                              Tipo de Documento</td>
                            <td style="">
                              <asp:DropDownList ID="cbxTipoDocumento" runat="server" CssClass="FormText tt_help_info aDropDownWithTitle"
                                Width="82px" AppendDataBoundItems="True" DataSourceID="odsTipoDocumentoContratante"
                                DataTextField="tdocid" DataValueField="tdocidId" SelectedValue='<%# Bind("TDocumentoIdentidad") %>'
                                Enabled="False">
                                <asp:ListItem Value="-1">[-Elija-]</asp:ListItem>
                              </asp:DropDownList></td>
                            <td align="right" style="width: 89px;">
                              <asp:TextBox ID="txtNroDocumento" runat="server" CssClass="FormText" Text='<%# Bind("DocumentoIdentidad") %>'
                                Width="115px" ReadOnly="True"></asp:TextBox></td>
                          </tr>
                          <tr>
                            <td style="width: 150px;">
                              Dirección</td>
                            <td style="">
                              <asp:TextBox ID="txtDireccion" runat="server" CssClass="FormText" Text='<%# Bind("direccionTrabajo") %>'
                                Width="200px" ReadOnly="True"></asp:TextBox></td>
                            <td style="">
                            </td>
                            <td style="width: 120px;">
                              Teléfono</td>
                            <td colspan="2" style="">
                              <asp:TextBox ID="txtTelefono" runat="server" CssClass="FormText" Text='<%# Bind("TelefonoFijo1") %>'
                                Width="200px" ReadOnly="True"></asp:TextBox></td>
                          </tr>
                          <tr>
                            <td style="width: 150px;">
                              Distrito
                            </td>
                            <td style="">
                              <cc1:AutoSuggestBox ID="AutoSuggestBox1" runat="server" CssClass="FormText" DataType="Distrito"
                                IncludeMoreMenuItem="True" KeyPressDelay="300" MaxSuggestChars="15" MenuCSSClass="asbMenu"
                                MenuItemCSSClass="asbMenuItem" MoreMenuItemLabel="..." NoValueSelectedCSSClass="asbNonValueSelected"
                                NumMenuItems="15" OnFocusShowAll="False" ResourcesDir="./Scripts/asb_includes"
                                SelectedValue='<%# Bind("ubigeoIdTrabajo") %>' SelMenuItemCSSClass="asbSelMenuItem"
                                Text='<%# Eval("distritoTrabajo") %>' UseIFrame="True" WarnNoValueSelected="False"
                                Width="200px" ReadOnly="True"></cc1:AutoSuggestBox>
                            </td>
                            <td style="">
                            </td>
                            <td style="width: 120px;">
                              Fax</td>
                            <td colspan="2" style="">
                              <asp:TextBox ID="txtFax" runat="server" CssClass="FormText" Text='<%# Bind("Fax") %>'
                                Width="200px" ReadOnly="True"></asp:TextBox></td>
                          </tr>
                          <tr>
                            <td style="width: 150px">
                              Email</td>
                            <td>
                              <asp:TextBox ID="txtEmail" runat="server" CssClass="FormText" Text='<%# Bind("email") %>'
                                Width="200px" ReadOnly="True"></asp:TextBox></td>
                            <td>
                            </td>
                            <td style="width: 120px">
                              Otro Teléfono</td>
                            <td colspan="2">
                              <asp:TextBox ID="txtOtroTelefono" runat="server" CssClass="FormText" Text='<%# Bind("TelefonoFijo2") %>'
                                Width="200px" ReadOnly="True"></asp:TextBox></td>
                          </tr>
                        </table>
                        <asp:ObjectDataSource ID="odsTipoDocumentoContratante" runat="server" OldValuesParameterFormatString="original_{0}"
                          SelectMethod="GetData" TypeName="ADM_DAL.dsDropDownListTableAdapters.TDocIdLoadDropDownTableAdapter">
                          <SelectParameters>
                            <asp:Parameter DefaultValue="A" Name="estado" Type="String" />
                          </SelectParameters>
                        </asp:ObjectDataSource>
                      </ItemTemplate>
                    </asp:FormView>
                  </div>
                </div>
                <div class="PanelStyle" style="margin-bottom: 4px">
                  <div class="PanelEncabezado">
                    <asp:Label ID="aseguradoLabel" runat="server" Style="cursor: default" Text="Asegurado"
                      ToolTip="Mostrar / Ocultar Panel"></asp:Label>
                    <img id="aseguradoImage" alt="Mostrar / Ocultar Panel" src="Images/IconHide16Dark.gif"
                      title="Mostrar / Ocultar Panel" /></div>
                  <div id="aseguradoData" class="DataTable">
                    <asp:FormView ID="frmvAsegurado" runat="server" DataSourceID="odsAsegurado" DefaultMode="Edit">
                      <EditItemTemplate>
                        <table border="0" cellpadding="0" cellspacing="0">
                          <tr>
                            <td style="width: 150px;">
                              Nombre Razón Social
                            </td>
                            <td style="">
                              <cc1:AutoSuggestBox ID="asbAsegurado" runat="server" CssClass="FormText" DataType="Asegurado"
                                IncludeMoreMenuItem="False" KeyPressDelay="300" MaxSuggestChars="8" MenuCSSClass="asbMenu"
                                MenuItemCSSClass="asbMenuItem" MoreMenuItemLabel="..." NoValueSelectedCSSClass="asbNonValueSelected"
                                NumMenuItems="15" OnFocusShowAll="True" ResourcesDir="./Scripts/asb_includes" SelMenuItemCSSClass="asbSelMenuItem"
                                Style="position: static" Text='<%# Bind("persona") %>' UseIFrame="False" WarnNoValueSelected="False"
                                Width="200px"></cc1:AutoSuggestBox></td>
                            <td style="width: 10px;">
                            </td>
                            <td style="width: 120px;">
                              Tipo de Documento</td>
                            <td style="">
                              <asp:DropDownList ID="cbxTipoDocumentoAsegurado" runat="server" CssClass="FormText tt_help_info aDropDownWithTitle"
                                Width="82px" AppendDataBoundItems="True" DataSourceID="odsTipoDocumentoAsegurado"
                                DataTextField="tdocidId" DataValueField="tdocidId" SelectedValue='<%# Bind("TDocumentoIdentidad") %>'>
                                <asp:ListItem Value="-1">[-Elija-]</asp:ListItem>
                              </asp:DropDownList></td>
                            <td align="right" style="">
                              <asp:TextBox ID="txtTipoDocumentoAsegurado" runat="server" CssClass="FormText" Text='<%# Bind("DocumentoIdentidad") %>'
                                Width="115px"></asp:TextBox></td>
                          </tr>
                          <tr>
                            <td style="width: 150px">
                              Dirección</td>
                            <td style="">
                              <asp:TextBox ID="txtDireccionAsegurado" runat="server" CssClass="FormText" Text='<%# Bind("direccionTrabajo") %>'
                                Width="200px"></asp:TextBox></td>
                            <td style="">
                            </td>
                            <td style="">
                              Teléfono</td>
                            <td colspan="2" style="">
                              <asp:TextBox ID="txtTelefonoAsegurado" runat="server" CssClass="FormText" Text='<%# Bind("TelefonoFijo1") %>'
                                Width="200px"></asp:TextBox></td>
                          </tr>
                          <tr>
                            <td style="width: 150px">
                              Distrito</td>
                            <td style="">
                              <cc1:AutoSuggestBox ID="AutoSuggestBox2" runat="server" CssClass="FormText" DataType="Distrito"
                                IncludeMoreMenuItem="True" KeyPressDelay="300" MaxSuggestChars="15" MenuCSSClass="asbMenu"
                                MenuItemCSSClass="asbMenuItem" MoreMenuItemLabel="..." NoValueSelectedCSSClass="asbNonValueSelected"
                                NumMenuItems="15" OnFocusShowAll="False" ResourcesDir="./Scripts/asb_includes"
                                SelectedValue='<%# Bind("ubigeoIdTrabajo") %>' SelMenuItemCSSClass="asbSelMenuItem"
                                Text='<%# Eval("distritoTrabajo") %>' UseIFrame="True" WarnNoValueSelected="False"
                                Width="200px"></cc1:AutoSuggestBox></td>
                            <td style="">
                            </td>
                            <td style="">
                              Fax</td>
                            <td colspan="2" style="">
                              <asp:TextBox ID="txtFaxAsegurado" runat="server" CssClass="FormText" Text='<%# Bind("Fax") %>'
                                Width="200px"></asp:TextBox></td>
                          </tr>
                          <tr>
                            <td style="width: 150px">
                              Email</td>
                            <td style="">
                              <asp:TextBox ID="txtEmailAsegurado" runat="server" CssClass="EmailCase FormText"
                                Text='<%# Bind("email") %>' Width="200px"></asp:TextBox></td>
                            <td style="">
                            </td>
                            <td style="">
                              Otro Teléfono</td>
                            <td colspan="2" style="">
                              <asp:TextBox ID="txtOtroTelefonoAsegurado" runat="server" CssClass="FormText" Text='<%# Bind("TelefonoFijo2") %>'
                                Width="200px"></asp:TextBox></td>
                          </tr>
                          <tr>
                            <td style="width: 150px">
                              Ocupación / Giro</td>
                            <td style="">
                              <asp:TextBox ID="txtOcupacionAsegurado" runat="server" CssClass="FormText" Text='<%# Bind("ocupacionGiro") %>'
                                Width="200px"></asp:TextBox></td>
                            <td style="">
                            </td>
                            <td style="">
                              Fecha de Expedición</td>
                            <td colspan="2" style="">
                              <cc2:WebCalendar ID="txtFechaExpedicion" runat="server" Align="Br" BtnCalendarImage="./Scripts/wcc_includes/img/cal.gif"
                                BtnClassStyle="trigger_btn_class" Cache="False" CssClass="FormText" Date="2006-11-30"
                                Electric="False" EventName="click" FirstDay="0" GenerateBtn="True" HAlign="right"
                                IfFormat="%d/%m/%Y" IsFlat="False" JsScriptCalendarLanguage="calendar-es.js" MaxYear="2999"
                                MinYear="1900" Position="0, 0" Range="[1900,2999]" ShowOthers="False" ShowsTime="False"
                                SingleClick="True" Step="0" Text='<%# Bind("brevetefExpedicion", "{0:d}") %>' TimeFormat="TwentyFour"
                                UsePosition="False" VAlign="BottomTop" WcResourcesDir="./Scripts/wcc_includes/"
                                WcStyleSheet="calendar-brown.css" WeekNumbers="False" Width="182px"></cc2:WebCalendar>
                            </td>
                          </tr>
                          <tr>
                            <td style="width: 150px">
                              Brevete</td>
                            <td style="">
                              <asp:TextBox ID="txtBrevete" runat="server" CssClass="FormText" Text='<%# Bind("brevete") %>'
                                Width="200px"></asp:TextBox></td>
                            <td style="">
                            </td>
                            <td style="">
                              Fecha de Vencimiento</td>
                            <td colspan="2" style="">
                              <cc2:WebCalendar ID="txtFechaVencimiento" runat="server" Align="Br" BtnCalendarImage="./Scripts/wcc_includes/img/cal.gif"
                                BtnClassStyle="trigger_btn_class" Cache="False" CssClass="FormText" Date="2006-11-30"
                                Electric="False" EventName="click" FirstDay="0" GenerateBtn="True" HAlign="right"
                                IfFormat="%d/%m/%Y" IsFlat="False" JsScriptCalendarLanguage="calendar-es.js" MaxYear="2999"
                                MinYear="1900" Position="0, 0" Range="[1900,2999]" ShowOthers="False" ShowsTime="False"
                                SingleClick="True" Step="0" Text='<%# Bind("brevetefVencimiento", "{0:d}") %>'
                                TimeFormat="TwentyFour" UsePosition="False" VAlign="BottomTop" WcResourcesDir="./Scripts/wcc_includes"
                                WcStyleSheet="calendar-brown.css" WeekNumbers="False" Width="182px"></cc2:WebCalendar>
                            </td>
                          </tr>
                        </table>
                        <asp:TextBox ID="txtAseguradoId" runat="server" CssClass="FormText" Style="position: static;
                          display: none;" Text='<%# Bind("personaid") %>' Width="50px"></asp:TextBox>
                        <asp:TextBox ID="txtCambio" runat="server" CssClass="FormText" Style="position: static;
                          display: none;" Width="50px"></asp:TextBox>
                        <asp:ObjectDataSource ID="odsTipoDocumentoAsegurado" runat="server" OldValuesParameterFormatString="original_{0}"
                          SelectMethod="GetData" TypeName="ADM_DAL.dsDropDownListTableAdapters.TDocIdLoadDropDownTableAdapter">
                          <SelectParameters>
                            <asp:Parameter DefaultValue="A" Name="estado" Type="String" />
                          </SelectParameters>
                        </asp:ObjectDataSource>
                      </EditItemTemplate>
                      <ItemTemplate>
                        <table border="0" cellpadding="0" cellspacing="0">
                          <tr>
                            <td style="width: 120px;">
                              Nombre Razón Social
                            </td>
                            <td style="">
                              <asp:TextBox ID="txtRazonSocialAsegurado" runat="server" CssClass="FormText" Width="140px"
                                Text='<%# Bind("persona") %>'></asp:TextBox></td>
                            <td style="width: 10px;">
                            </td>
                            <td style="width: 120px;">
                              Tipo de Documento</td>
                            <td style="">
                              <asp:DropDownList ID="cbxTipoDocumentoAsegurado" runat="server" CssClass="FormText tt_help_info aDropDownWithTitle"
                                Width="60px" AppendDataBoundItems="True" DataSourceID="odsTipoDocumentoAsegurado"
                                DataTextField="tdocidId" DataValueField="tdocidId" SelectedValue='<%# Bind("TDocumentoIdentidad") %>'>
                                <asp:ListItem Value="-1">[-Elija-]</asp:ListItem>
                              </asp:DropDownList></td>
                            <td align="right" style="">
                              <asp:TextBox ID="txtTipoDocumentoAsegurado" runat="server" CssClass="FormText" Width="80px"
                                Text='<%# Bind("DocumentoIdentidad") %>'></asp:TextBox></td>
                          </tr>
                          <tr>
                            <td style="">
                              Dirección</td>
                            <td style="">
                              <asp:TextBox ID="txtDireccionAsegurado" runat="server" CssClass="FormText" Width="140px"
                                Text='<%# Bind("direccionTrabajo") %>'></asp:TextBox></td>
                            <td style="">
                            </td>
                            <td style="">
                              Teléfono</td>
                            <td colspan="2" style="">
                              <asp:TextBox ID="txtTelefonoAsegurado" runat="server" CssClass="FormText" Width="145px"
                                Text='<%# Bind("TelefonoFijo1") %>'></asp:TextBox></td>
                          </tr>
                          <tr>
                            <td style="">
                              Distrito</td>
                            <td style="">
                              <asp:TextBox ID="txtDistritoAsegurado" runat="server" CssClass="FormText" Width="140px"
                                Text='<%# Bind("distritoTrabajo") %>'></asp:TextBox></td>
                            <td style="">
                            </td>
                            <td style="">
                              Fax</td>
                            <td colspan="2" style="">
                              <asp:TextBox ID="txtFaxAsegurado" runat="server" CssClass="FormText" Width="145px"
                                Text='<%# Bind("Fax") %>'></asp:TextBox></td>
                          </tr>
                          <tr>
                            <td>
                              Email</td>
                            <td>
                              <asp:TextBox ID="txtEmailAsegurado" runat="server" CssClass="FormText EmailCase MINUSC"
                                Width="140px" Text='<%# Bind("email") %>'></asp:TextBox></td>
                            <td>
                            </td>
                            <td>
                              Otro Teléfono</td>
                            <td colspan="2">
                              <asp:TextBox ID="txtOtroTelefonoAsegurado" runat="server" CssClass="FormText" Width="145px"
                                Text='<%# Bind("TelefonoFijo2") %>'></asp:TextBox></td>
                          </tr>
                          <tr>
                            <td style="">
                              Ocupación / Giro</td>
                            <td style="">
                              <asp:TextBox ID="txtOcupacionAsegurado" runat="server" CssClass="FormText" Width="140px"
                                Text='<%# Bind("ocupacionGiro") %>'></asp:TextBox></td>
                            <td style="">
                            </td>
                            <td style="">
                              Fecha de Nacimiento</td>
                            <td colspan="2" style="">
                              <cc2:WebCalendar ID="txtFechaExpedicion" runat="server" Align="Br" BtnCalendarImage="./Scripts/wcc_includes/img/cal.gif"
                                BtnClassStyle="trigger_btn_class" Cache="False" CssClass="FormText" Date="2006-11-30"
                                Electric="False" EventName="click" FirstDay="0" GenerateBtn="True" HAlign="right"
                                IfFormat="%d/%m/%Y" IsFlat="False" JsScriptCalendarLanguage="calendar-es.js" MaxYear="2999"
                                MinYear="1900" Position="0, 0" Range="[1900,2999]" ShowOthers="False" ShowsTime="False"
                                SingleClick="True" Step="0" Text='<%# Bind("brevetefExpedicion", "{0:d}") %>' TimeFormat="TwentyFour"
                                UsePosition="False" VAlign="BottomTop" WcResourcesDir="./Scripts/wcc_includes/"
                                WcStyleSheet="calendar-brown.css" WeekNumbers="False" Width="128px"></cc2:WebCalendar></td>
                          </tr>
                          <tr>
                            <td style="">
                              Brevete</td>
                            <td style="">
                              <asp:TextBox ID="txtBrevete" runat="server" CssClass="FormText" Width="140px" Text='<%# Bind("brevete") %>'></asp:TextBox></td>
                            <td style="">
                            </td>
                            <td style="">
                              Fecha de Expedición</td>
                            <td colspan="2" style="">
                              <cc2:WebCalendar ID="txtFechaVencimiento" runat="server" Align="Br" BtnCalendarImage="./Scripts/wcc_includes/img/cal.gif"
                                BtnClassStyle="trigger_btn_class" Cache="False" CssClass="FormText" Date="2006-11-30"
                                Electric="False" EventName="click" FirstDay="0" GenerateBtn="True" HAlign="right"
                                IfFormat="%d/%m/%Y" IsFlat="False" JsScriptCalendarLanguage="calendar-es.js" MaxYear="2999"
                                MinYear="1900" Position="0, 0" Range="[1900,2999]" ShowOthers="False" ShowsTime="False"
                                SingleClick="True" Step="0" Text='<%# Bind("brevetefVencimiento", "{0:d}") %>'
                                TimeFormat="TwentyFour" UsePosition="False" VAlign="BottomTop" WcResourcesDir="./Scripts/wcc_includes"
                                WcStyleSheet="calendar-brown.css" WeekNumbers="False" Width="128px"></cc2:WebCalendar></td>
                          </tr>
                        </table>
                        <asp:ObjectDataSource ID="odsTipoDocumentoAsegurado" runat="server" OldValuesParameterFormatString="original_{0}"
                          SelectMethod="GetData" TypeName="ADM_DAL.dsDropDownListTableAdapters.TDocIdLoadDropDownTableAdapter">
                          <SelectParameters>
                            <asp:Parameter DefaultValue="A" Name="estado" Type="String" />
                          </SelectParameters>
                        </asp:ObjectDataSource>
                      </ItemTemplate>
                    </asp:FormView>
                  </div>
                </div>
                <div class="PanelStyle">
                  <div class="PanelEncabezado">
                    <asp:Label ID="alertaLabel" runat="server" Style="cursor: default" Text="Alertas y Observaciones"
                      ToolTip="Mostrar / Ocultar Panel"></asp:Label>
                    <img id="alertaImage" alt="Mostrar / Ocultar Panel" src="Images/IconHide16Dark.gif"
                      title="Mostrar / Ocultar Panel" /></div>
                  <div id="alertaData" class="DataTable">
                    <asp:FormView ID="frmvAlertas" runat="server" DataSourceID="odsAlertas" DefaultMode="Edit"
                      DataKeyNames="vehiculoId,inspeccionId" OnItemUpdating="frmvAlertas_ItemUpdating">
                      <EditItemTemplate>
                        <table border="0" cellpadding="0" cellspacing="0">
                          <tr>
                            <td style="padding-top: 2px; width: 150px;" valign="top">
                              Estado de Alerta</td>
                            <td>
                              <table border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                  <td style="height: 18px">
                                    <asp:CheckBox ID="chkAlerta" runat="server" CssClass="FormCheck" Style="margin-left: -2px"
                                      Checked='<%# Bind("alerta") %>' /></td>
                                  <td style="width: 90px; height: 18px;">
                                    Tipo de Alerta</td>
                                  <td style="height: 18px">
                                    <asp:DropDownList ID="cbxAlerta" runat="server" CssClass="FormText tt_help_info aDropDownWithTitle"
                                      Width="235px" AppendDataBoundItems="True" DataSourceID="odsTipoAlerta" DataTextField="talerta"
                                      DataValueField="talertaId" SelectedValue='<%# Bind("talertaId") %>'>
                                      <asp:ListItem Value="-1" Selected="True">[- ELIJA -]</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:CustomValidator ID="CustomValidator1" runat="server" ClientValidationFunction="doValidateAlert"
                                      ControlToValidate="cbxAlerta" ErrorMessage="Debe Elegir un tipo de Alerta">(*)</asp:CustomValidator></td>
                                </tr>
                              </table>
                            </td>
                          </tr>
                          <tr>
                            <td style="padding-top: 2px; width: 150px;" valign="top">
                              Observación</td>
                            <td>
                              <asp:TextBox ID="txtObservacion" runat="server" CssClass="FormText" Width="350px"
                                Rows="3" TextMode="MultiLine" Text='<%# Bind("observacion") %>'></asp:TextBox></td>
                          </tr>
                        </table>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("inspeccionId") %>' CssClass="invisible"></asp:Label>
                      </EditItemTemplate>
                    </asp:FormView>
                    &nbsp;</div>
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
                        ToolTip="Guardar Datos" CssClass="MakeClear" OnClick="guardarImageButton_Click"
                        OnClientClick="return doSaving();" />
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
            &nbsp;&nbsp;&nbsp;&nbsp;
            <uc3:ucAnularInspeccion ID="UcAnularInspeccion1" runat="server" TriggerId="anularImageButton" />
            &nbsp;&nbsp;
          </td>
        </tr>
      </table>
    </div>    
    <asp:ObjectDataSource ID="odsTipoAlerta" runat="server" OldValuesParameterFormatString="original_{0}"
      SelectMethod="GetData" TypeName="dsComboTableAdapters.TipoAlertaComboTableAdapter">
      <SelectParameters>
        <asp:Parameter DefaultValue="A" Name="estado" Type="String" />
      </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="odsContratante" runat="server" InsertMethod="Insert" SelectMethod="GetDataByVehiculoId"
      TypeName="dsContratanteTableAdapters.ContratanteTableAdapter" UpdateMethod="Update"
      OnInserted="odsContratante_Inserted" OldValuesParameterFormatString="original_{0}">
      <UpdateParameters>
        <asp:Parameter Name="personaId" Type="Int32" />
        <asp:Parameter Name="persona" Type="String" />
        <asp:Parameter Name="TDocumentoIdentidad" Type="String" />
        <asp:Parameter Name="DocumentoIdentidad" Type="String" />
        <asp:Parameter Name="direccionTrabajo" Type="String" />
        <asp:Parameter Name="ubigeoIdTrabajo" Type="String" />
        <asp:Parameter Name="email" Type="String" />
        <asp:Parameter Name="TelefonoFijo1" Type="String" />
        <asp:Parameter Name="TelefonoFijo2" Type="String" />
        <asp:Parameter Name="Fax" Type="String" />
        <asp:Parameter Name="uupdate" Type="String" />
      </UpdateParameters>
      <SelectParameters>
        <asp:QueryStringParameter DefaultValue="1" Name="vehiculoId" QueryStringField="VehiculoId"
          Type="Decimal" />
      </SelectParameters>
      <InsertParameters>
        <asp:Parameter Direction="InputOutput" Name="personaId" Type="Object" />
        <asp:Parameter Name="persona" Type="String" />
        <asp:Parameter Name="TDocumentoIdentidad" Type="String" />
        <asp:Parameter Name="DocumentoIdentidad" Type="String" />
        <asp:Parameter Name="direccionTrabajo" Type="String" />
        <asp:Parameter Name="ubigeoIdTrabajo" Type="String" />
        <asp:Parameter Name="email" Type="String" />
        <asp:Parameter Name="TelefonoFijo1" Type="String" />
        <asp:Parameter Name="TelefonoFijo2" Type="String" />
        <asp:Parameter Name="Fax" Type="String" />
        <asp:Parameter Name="ucrea" Type="String" />
      </InsertParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="odsAsegurado" runat="server" SelectMethod="GetDataByVehiculoId"
      TypeName="dsAseguradoTableAdapters.AseguradoTableAdapter" UpdateMethod="Update"
      InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" OnInserted="odsAsegurado_Inserted">
      <UpdateParameters>
        <asp:Parameter Name="personaId" Type="Int32" />
        <asp:Parameter Name="persona" Type="String" />
        <asp:Parameter Name="TDocumentoIdentidad" Type="String" />
        <asp:Parameter Name="DocumentoIdentidad" Type="String" />
        <asp:Parameter Name="direccionTrabajo" Type="String" />
        <asp:Parameter Name="ubigeoIdTrabajo" Type="String" />
        <asp:Parameter Name="email" Type="String" />
        <asp:Parameter Name="TelefonoFijo1" Type="String" />
        <asp:Parameter Name="TelefonoFijo2" Type="String" />
        <asp:Parameter Name="Fax" Type="String" />
        <asp:Parameter Name="uupdate" Type="String" />
        <asp:Parameter Name="brevete" Type="String" />
        <asp:Parameter Name="brevetefExpedicion" Type="DateTime" />
        <asp:Parameter Name="brevetefVencimiento" Type="DateTime" />
        <asp:Parameter Name="ocupacionGiro" Type="String" />
      </UpdateParameters>
      <SelectParameters>
        <asp:QueryStringParameter DefaultValue="1" Name="vehiculoId" QueryStringField="VehiculoId"
          Type="Decimal" />
      </SelectParameters>
      <InsertParameters>
        <asp:Parameter Direction="InputOutput" Name="personaId" Type="Object" />
        <asp:Parameter Name="persona" Type="String" />
        <asp:Parameter Name="TDocumentoIdentidad" Type="String" />
        <asp:Parameter Name="DocumentoIdentidad" Type="String" />
        <asp:Parameter Name="direccionTrabajo" Type="String" />
        <asp:Parameter Name="ubigeoIdTrabajo" Type="String" />
        <asp:Parameter Name="email" Type="String" />
        <asp:Parameter Name="TelefonoFijo1" Type="String" />
        <asp:Parameter Name="TelefonoFijo2" Type="String" />
        <asp:Parameter Name="Fax" Type="String" />
        <asp:Parameter Name="uupdate" Type="String" />
        <asp:Parameter Name="brevete" Type="String" />
        <asp:Parameter Name="brevetefExpedicion" Type="DateTime" />
        <asp:Parameter Name="brevetefVencimiento" Type="DateTime" />
        <asp:Parameter Name="ocupacionGiro" Type="String" />
      </InsertParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="odsAlertas" runat="server" SelectMethod="GetData" TypeName="dsInspeccionesTableAdapters.AlertasInspeccionTableAdapter"
      UpdateMethod="Update">
      <UpdateParameters>
        <asp:Parameter Name="inspeccionId" Type="Decimal" />
        <asp:Parameter Name="vehiculoId" Type="Decimal" />
        <asp:Parameter Name="alerta" Type="Boolean" />
        <asp:Parameter Name="talertaId" Type="Int32" />
        <asp:Parameter Name="observacion" Type="String" />
      </UpdateParameters>
      <SelectParameters>
        <asp:QueryStringParameter Name="vehiculoId" QueryStringField="VehiculoId" Type="Decimal" />
      </SelectParameters>
    </asp:ObjectDataSource>
  </form>
</body>
</html>
