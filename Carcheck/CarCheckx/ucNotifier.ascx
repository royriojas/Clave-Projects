<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ucNotifier.ascx.cs" Inherits="ucNotifier" %>
<link href="Css/layout.css" rel="stylesheet" type="text/css" />



<div id="dropDownNotificacion" class="popUpForm" style="padding: 2px; width: 423px;
  display: none; text-align: left; position: absolute; z-index: 600;">
  <table border="0" cellpadding="0" cellspacing="0" class="DataTable" style="font-size: 10px;">
    <tr>
      <td align="left" style="font-weight: bold; height: 17px; border-bottom: #660033 1px solid;" valign="middle" colspan="2">
        Herramienta de Notificación</td>
    </tr>
    <tr>
      <td style="height: 18px; padding-bottom: 1px; padding-top: 1px;">
        <span class="FormCheck">
          <label for="chkAdminMail">
            &nbsp;Para</label></span></td>
      <td align="right" valign="bottom" style="height: 18px; padding-bottom: 1px; padding-top: 1px;">
        <asp:TextBox ID="txtPara" runat="server" CssClass="FormTextNoUpperCase" Width="300px"></asp:TextBox></td>
    </tr>
    <tr>
      <td style="padding-bottom: 2px; padding-top: 2px; height: 18px;">
        &nbsp;Con copia &nbsp;a</td>
      <td align="right" valign="bottom" style="padding-bottom: 1px; padding-top: 1px; height: 18px;">
        <asp:TextBox ID="txtCC" runat="server" CssClass="FormTextNoUpperCase" Width="300px"></asp:TextBox></td>
    </tr>
    <tr>
      <td style="padding-bottom: 2px; padding-top: 1px; height: 18px;">
        <span class="FormCheck">
          <input id="chkAdminMail" class="X_CHECK_ENABLER" type="checkbox" name="chkAdminMail" runat="server" /><label for="chkAdminMail">Administrador</label></span>
      </td>
      <td align="right" valign="bottom" style="padding-bottom: 2px; padding-top: 1px; height: 18px;">
        <asp:TextBox ID="txtAdminMail" runat="server" CssClass="FormTextNoUpperCase" Width="300px"></asp:TextBox></td>
    </tr>
    <tr>
      <td style="width: 316px; border-top: #993300 1px double; text-align: left">
        &nbsp;
      </td>
      <td align="right" style="width: 316px; border-top: #993300 1px double; text-align: left"
        valign="bottom">
        &nbsp;
      </td>
    </tr>
    <tr>
      <td align="left" style="font-weight: bold; height: 17px;" colspan="2">
        Mensaje
      </td>
    </tr>
    <tr>
      <td align="right" colspan="2" style="padding-top: 2px; height: 24px">
        <asp:TextBox ID="txtBodyMail" CssClass="FormTextNoUpperCase" runat="server" Rows="6" TextMode="MultiLine" Width="411px"></asp:TextBox></td>
    </tr>
    <tr>
      <td align="right" colspan="2" style="padding-top: 2px; height: 24px">
        <input name="Button5" type="button" onclick="__doRefresh();xPreventDefault(e);return false;"
          id="Button5" class="FormButton" style="width: 71px" value="Notificar" /><input id="Button6" class="FormButton" onclick="xMenuNotificacion.hide();return false;"
          type="button" value="Cancelar" /></td>
    </tr>
  </table>
</div>

<div id='scriptsDiv' runat="server">
<script type="text/javascript">
  function __mailIsValid() {
    return $('<%=ControlClientId %>_txtBodyMail').value !='' && $('<%=ControlClientId %>_txtPara').value != '';
    
  }
  function __doRefresh()
  {    
    if (!__mailIsValid()) { 
      alert('Revise que todos los campos estén correctamente llenados y contengan direcciones de correo válidas');
      return false;
    }
    var arg;
    var context;
    CCSOL.DOM.xShowLoadingMessage(":: Enviando Mensaje ::");
    
    CCSOL.Utiles.RegenerateViewState();
    
     <%= this.Page.ClientScript.GetCallbackEventReference(this.callback_mailer, "arg","__doRefreshCallback", "context", "__doRefreshHandleError", false) %> ;
     
    xMenuNotificacion.hide();
  }

  function __cleanMensajeEnviado() {
    CCSOL.DOM.xHideLoadingMessage();
  }
  
  function __doRefreshCallback(result, context)
  {

    //CCSOL.DOM.xHideLoadingMessage();
    CCSOL.DOM.xShowLoadingMessage(":: Mensaje Enviado con éxito ::",null,null,null,'#FFCC00' ,'#003399');
    
    setTimeout('__cleanMensajeEnviado()',2000);
    
    
    //$('theLoadingMessage').style.display = 'none';
    $('<%=ControlClientId %>_txtBodyMail').value =''; 
    

  }

  function __doRefreshHandleError(message)
  {
    CCSOL.DOM.xShowLoadingMessage(":: Ocurrió un error al enviar el mensaje ::");
    
    setTimeout('__cleanMensajeEnviado()',2000);
    
    //CCSOL.DOM.xHideLoadingMessage();
    //alert("[Error] : " + message);
  }
  
</script>

<script type="text/javascript">
   var xMenuNotificacion = null;
   
  function xMenuNotificacion_onAutoHide() {
    return false;
  }
   
    //Para los menus que aparecen en contexto    
    CCSOL.Utiles.LoadScript("./Scripts/lib/xDropDownMenu.js");    
    CCSOL.Utiles.LoadScript('./Scripts/lib/x_CheckHabilitador.js');
	  CCSOL.Utiles.LoadScript('./Scripts/lib/xCheckEnablerSystem.js');
     
  function __createNotifierPopUpMenu() 
  {
     try
     {
        if ($('<%=TriggerID %>'))
        {
          xMenuNotificacion = new xDropDownMenu('dropDownNotificacion',       //el div que aparecerá en el punto de click
                                                '<%=TriggerID %>',       //el "map" area que contiene los hotspots que provocarán que aparezca el PopUpForm
                                                'context',                    //Se muestra en el punto de click ('d' = dropDownMenu,null = en el punto de click, 'context' = menu contextual
                                                'click',                      //el evento al que queremos asociar la aparición del Div
                                                null,                         //posicion en la que queremos que aparezca el div, 'left', 'right' o null solo tiene sentido cuando el menu es tipo 'd'
                                                null,                         //evento que se ejecuta al mostrarse el div
                                                xMenuNotificacion_onAutoHide, //evento que se llama al ocurrir un mouseout
                                                true);
        }
      }
      catch (e)
      {
        alert(e.message);
      }
   }
   
   domReady(__createNotifierPopUpMenu);
   
</script>
</div>