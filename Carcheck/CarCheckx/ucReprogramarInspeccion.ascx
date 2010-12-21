<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ucReprogramarInspeccion.ascx.cs"
  Inherits="ucReprogramarInspeccion" %>
  <%@ Register Assembly="AutoSuggestBox" Namespace="ASB" TagPrefix="cc1" %>

<%@ Register Assembly="WebCalendarControl" Namespace="WebCalendarControl" TagPrefix="cc1" %>
<link href="Css/layout.css" rel="stylesheet" type="text/css" />
<link href="./Scripts/wcc_includes/calendar-brown.css" rel="stylesheet" type="text/css" />
<link href="./Scripts/wcc_includes/calendar-brown.css" rel="stylesheet" type="text/css" />
<link href="./Scripts/asb_includes/AutoSuggestBox.css" rel="stylesheet" type="text/css" />

<div id="divScripts" runat="server">

  <script type="text/javascript"> 
    
    function __doDatesValidation(sender,args) {
      try {
       var fini =  $('<%=ClientID %>_wcFechaInicio').value + ' '  +   $('<%=ClientID %>_txtHoraIni').value;
       var ffin =  $('<%=ClientID %>_wcFechaInicio').value + ' '  +   $('<%=ClientID %>_txtHoraFin').value;      
       
       args.IsValid = ucReprogramarInspeccion.datesAreValid(fini,ffin).value;//ucReprogramarInspeccion.isValidDateTimeForUser(fini).value && ucReprogramarInspeccion.isValidDateTime(ffin).value 
      }
      catch(e) {
        alert(e);
        args.IsValid = false;
      }
    }
    
    function ReprogramarInspeccion() {
      return Page_ClientValidate('grpReprogramar');
    }
    
    function hideReprogramarDropDown() {
      __xMenuReprogramar.hide();
    }  
    function __onDisplayMenuReprogramar(e, theMenu)
    {
      var xE = new xEvent(e);

      //asumimos que no siempre es posible mostrar el menu
      theMenu.doShow = false;
      //asumimos que por defecto queremos que se ejecute la acción por defecto de los links
      theMenu.doReturn = false;
      //sobre q elemento se ha hecho click
      var theTrigger = xE.target;

      if (theTrigger.parentNode.tagName == "A")
        theTrigger = theTrigger.parentNode;

      var doShow = CCSOL.DOM.x_GetAttribute(theTrigger, 'doShow');
      var isAnular =  CCSOL.DOM.x_GetAttribute(theTrigger, 'MenuDropDownType') == 'reprogramar';
      
      $('<%=ClientID %>_hdfInspeccionId').value = CCSOL.DOM.x_GetAttribute(theTrigger, 'InsId');
      $('<%=ClientID %>_hdfSolicitudId').value = CCSOL.DOM.x_GetAttribute(theTrigger, 'SolId');
      
      
      
      $('<%=ClientID %>_asbInspector').value = CCSOL.DOM.x_GetAttribute(theTrigger, 'insp');
      $('<%=ClientID %>_asbInspector_SelectedValue').value = CCSOL.DOM.x_GetAttribute(theTrigger, 'inspId');
      $('<%=ClientID %>_asbDistrito').value = CCSOL.DOM.x_GetAttribute(theTrigger, 'ubigeo');
      $('<%=ClientID %>_asbDistrito_SelectedValue').value = CCSOL.DOM.x_GetAttribute(theTrigger, 'ubigeoId');
      $('<%=ClientID %>_txtContacto').value = CCSOL.DOM.x_GetAttribute(theTrigger, 'contacto');
      $('<%=ClientID %>_txtTelefono').value = CCSOL.DOM.x_GetAttribute(theTrigger, 'telefonocontacto');
      $('<%=ClientID %>_txtDireccion').value = CCSOL.DOM.x_GetAttribute(theTrigger, 'direccion');
      
      $('<%=ClientID %>_wcFechaInicio').value = CCSOL.DOM.x_GetAttribute(theTrigger, 'fInsp');
      $('<%=ClientID %>_txtHoraIni').value = CCSOL.DOM.x_GetAttribute(theTrigger, 'hIni');
      $('<%=ClientID %>_txtHoraFin').value = CCSOL.DOM.x_GetAttribute(theTrigger, 'hFin');
      
      
      if (doShow == 'show'  && isAnular)
      {
        theMenu.doShow = true;
        theMenu.doReturn = false;
        theMenu.isModal = true;
      }                        
      
    }
    function __onAutoHideReprogramar(e, menu)
    {
      return false;
    }
    var __xMenuReprogramar;

    function __createReprogramarDropDownMenu()
    {
      __xMenuReprogramar = new xDropDownMenu('dropDownReprogramar',   //el div que aparecerá en el punto de click
                                        '<%= TriggerId %>', //el "map" area que contiene los hotspots que provocarán que aparezca el PopUpForm
                                        'context',          //Se muestra en el punto de click ('d' = dropDownMenu,null = en el punto de click, 'context' = menu contextual
                                        'click',            //el evento al que queremos asociar la aparición del Div
                                        null,               //posicion en la que queremos que aparezca el div, 'left', 'right' o null solo tiene sentido cuando el menu es tipo 'd'
                                        __onDisplayMenuReprogramar,    //evento que se ejecuta al mostrarse el div
                                        __onAutoHideReprogramar        //evento que se llama al ocurrir un mouseout 
                        );
       //Calendar.setZIndex(1000);                 
      
    }
    xAddEventListener(window,'load',__createReprogramarDropDownMenu,false);
  </script>

</div>
<div id="dropDownReprogramar" class="popUpForm" style="padding: 2px; width: 409px;
  text-align: left; display: none; position: absolute; z-index: 104; ">
  <table border="0" cellpadding="0" cellspacing="0" class="DataTable" style="font-size: 10px">
    <tr>
      <td colspan="2" style="font-weight: bold; border-bottom: #652101 1px solid; height: 21px">
        Reprogramar</td>
    </tr>
    <tr>
      <td style="width: 182px; padding-top: 2px;">
        Fecha Ins.<asp:CustomValidator ID="CustomValidator3" runat="server" ClientValidationFunction="__doDatesValidation"
          ControlToValidate="txtHoraFin" ErrorMessage="CustomValidator" ValidationGroup="grpReprogramar" ToolTip="El Formato de la fecha es inválido o la fecha de la cita es inferior a la del día de hoy y usted no tiene el permiso necesario para registrar fechas inferiores a las de hoy">(*)</asp:CustomValidator></td>
      <td style="width: 321px; padding-top: 2px;">
        <cc1:WebCalendar style="z-index:105;" ID="wcFechaInicio" runat="server" BtnCalendarImage="./Scripts/wcc_includes/img/cal.gif"
          CssClass="FormText" GenerateBtn="True" WcResourcesDir="./Scripts/wcc_includes"
          WcStyleSheet="calendar-brown.css" Width="115px" TabIndex="300"></cc1:WebCalendar>
        De
        <asp:TextBox ID="txtHoraIni" runat="server" CssClass="FormText" Width="52px" TabIndex="310"></asp:TextBox>
        a
        <asp:TextBox ID="txtHoraFin" runat="server" CssClass="FormText" Width="52px" TabIndex="320"></asp:TextBox>
        hrs.</td>
    </tr>
    <tr>
      <td style="width: 182px">
        Contacto<asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtContacto" ToolTip="Ingrese un Contacto" ValidationGroup="grpReprogramar">(*)</asp:RequiredFieldValidator>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtTelefono"
          ToolTip="Ingrese el Teléfono del Contacto" ValidationGroup="grpReprogramar">(*)</asp:RequiredFieldValidator></td>
      <td style="width: 321px">
        <asp:TextBox ID="txtContacto" runat="server" CssClass="FormText" Width="186px" TabIndex="340"></asp:TextBox>&nbsp; Telf.&nbsp;
        <asp:TextBox ID="txtTelefono" runat="server" CssClass="FormText" Width="73px" TabIndex="350"></asp:TextBox></td>
    </tr>
    <tr>
      <td style="width: 182px">
        Dirección<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtDireccion" ToolTip="Ingrese la Dirección" ValidationGroup="grpReprogramar">(*)</asp:RequiredFieldValidator><span id="direccionRFV" style="font-weight: bold; visibility: hidden; color: red"></span></td>
      <td style="width: 321px">
        <asp:TextBox ID="txtDireccion" runat="server" CssClass="FormText" Width="300px" TabIndex="360"></asp:TextBox></td>
    </tr>
    <tr>
      <td style="height: 18px; width: 182px;">
        Ubigeo<asp:CustomValidator ID="CustomValidator1" runat="server" ControlToValidate="asbDistrito"
          ErrorMessage="CustomValidator" ToolTip="Ingrese el Distrito" ValidationGroup="grpReprogramar">(*)</asp:CustomValidator></td>
      <td style="width: 321px; height: 18px">
        <cc1:AutoSuggestBox ID="asbDistrito" runat="server" CssClass="FormText" DataType="Distrito"
          MaxSuggestChars="15" OnFocusShowAll="True" 
          ResourcesDir="./Scripts/asb_includes" Width="300px" TabIndex="370"></cc1:AutoSuggestBox></td>
    </tr>
    <tr>
      <td style="width: 182px">
        Inspector<asp:CustomValidator ID="CustomValidator2" runat="server" ControlToValidate="asbInspector"
          ErrorMessage="CustomValidator" ToolTip="Ingrese el Inspector" ValidationGroup="grpReprogramar">(*)</asp:CustomValidator></td>
      <td style="padding-top: 1px; height: 19px; width: 321px;">
        <cc1:AutoSuggestBox id="asbInspector" runat="server" CssClass="FormText"
          DataType="Inspector" MaxSuggestChars="15" OnFocusShowAll="True" 
          ResourcesDir="./Scripts/asb_includes" Width="300px" TabIndex="380"></cc1:AutoSuggestBox></td>
    </tr>
    <tr>
      <td style="padding-top: 2px; width: 182px;" valign="top">
        Observación</td>
      <td style="padding-top: 1px; height: 19px; width: 321px;">
        <asp:TextBox ID="txtObservacion" runat="server" CssClass="FormText" Rows="4" TextMode="MultiLine"
          Width="300px" TabIndex="390"></asp:TextBox></td>
    </tr>
    <tr>
      <td style="padding-top: 2px; width: 182px; height: 19px;" valign="top">
      </td>
      <td align="right" style="padding-top: 1px; height: 19px; width: 321px;">
        &nbsp;</td>
    </tr>
    <tr>
      <td style="width: 182px; padding-top: 2px" valign="top">
      </td>
      <td align="right" style="width: 321px; padding-top: 1px; height: 19px">
        <asp:Button ID="btnReprogramar" runat="server" CssClass="FormButton" OnClick="btnAnular_Click"
          OnClientClick="return ReprogramarInspeccion();xPreventDefault(e);" Text="Reprogramar" TabIndex="400" ValidationGroup="grpReprogramar" />
        <input id="cancelarButton" runat="server" class="FormButton" onclick="hideReprogramarDropDown();xPreventDefault(e);return false;"
          type="button" value="Cancelar" tabindex="410" /></td>
    </tr>
  </table>
  <asp:HiddenField ID="hdfInspeccionId" runat="server">       
  </asp:HiddenField>
  <asp:HiddenField ID="hdfSolicitudId" runat="server" />
  &nbsp;
 
</div>
