<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vSolicitud.aspx.cs" Inherits="vSolicitud" %>

<%@ Register Src="ucHeader.ascx" TagName="ucHeader" TagPrefix="uc1" %>
<%@ Register Assembly="AutoSuggestBox" Namespace="ASB" TagPrefix="cc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
  <title>Solicitud</title>
  <link href="css/layout.css" rel="stylesheet" type="text/css" />
  <link href="Scripts/xCommon/xCommon.css" rel="stylesheet" type="text/css" />
  <link href="Scripts/popUpWin/css/style.css" rel="stylesheet" type="text/css" />
  <link href="Scripts/popUpWin/css/subModal.css" rel="stylesheet" type="text/css" />

  <script type='text/javascript' src="Scripts/lib/x.js"></script>
  <script type='text/javascript' src="Scripts/lib/x_common.js"></script>
  
  <script type="text/javascript" src="Scripts/lib/xDropDownMenu.js"></script>
  <script type="text/javascript" src="Scripts/lib/x_checkAll.js"></script>
  <script type="text/javascript" src="Scripts/lib/CollapsibleDiv.js"></script>
  <script type="text/javascript" src="Scripts/lib/x_imageEffects.js"></script>
  
  <script type="text/javascript" src="Scripts/lib/xpopup.js"></script>  
  <script type="text/javascript">  
  CCSOL.Utiles.LoadCSS('./Scripts/xPopUpCSS/fen.css');
  xAddEventListener(window,'load',__initPopUpWindow,false);
  var ventana = null;
  function __initPopUpWindow() {
    ventana = new xPopUp(1,'./loading.html');	        
    aDropDownInit();
  }
  
  </script>
  
  
  <script type="text/javascript">
    
    		
				
    function validaEnvio()
    {
        if ($('NewInspeccionDiv').style.display == 'block')
        {
            return confirm('Aún no ha grabado la última inspección. \n¿Desea enviar la solicitud?');
        }
        else
        {
            return confirm('¿Desea enviar la solicitud?');
        }
    }

    function validaInsercionBlancos()
    {

        //NO HA SELECCIONADO NINGUNO
        if (($('frmViewNewInspeccion_asbAsegurado_SelectedValue').value == '') && 
            ($('frmViewNewInspeccion_asbAsegurado').value == ''))
        {
            alert('No ha seleccionado ningun contrante, ni especificado un nombre para el campo Asegurado');
            return false;
        }

        //HA SELECCIONADO UN ASEGURADO DEL AUTOSUGGEST
        if (($('frmViewNewInspeccion_asbAsegurado_SelectedValue').value != "") && 
            ($('frmViewNewInspeccion_asbAsegurado').value != ''))
        {
            return true;
        }

        //HA INGRESADO UN NUEVO ASEGURADO
        if (($('frmViewNewInspeccion_asbAsegurado_SelectedValue').value == "") && 
            ($('frmViewNewInspeccion_asbAsegurado').value != ''))
        {
            return confirm('Ha decidido cambiar el nombre del asegurado por uno que NO ESTÁ registrado,\nsi continua se CREARÁ UN NUEVO ASEGURADO con el nombre proporcionado');
        }


    }


    function showNewInspeccionForm()
    {

        try
        {
            if ($('NewInspeccionDiv').style.display == 'block')
            {
                return validaInsercionBlancos();
            }
            else
            {
                $('NewInspeccionDiv').style.display = 'block';
            }

        }
        catch (e)
        {
            alert(e.message);
        }
        return false;
    }               
    </script>


<script type="text/javascript">
    
  function perfomDataSearch()
  {
    try
    {
      vSolicitud.performDataSearch($
        ('frmvContratante_asbContratante_SelectedValue').value,
        showPersonData_CallBack);
    }
    catch (e)
    {
      alert(e.message);
    }
  }

  function showPersonData_CallBack(res)
  {
    try
    {
      p = res.value;
      if (xDef(p))
      {

        $('frmvContratante_txtDireccion').value = p.direccion;
        $('frmvContratante_asbDistrito').value = p.ubigeo;
        $('frmvContratante_txtEmail').value = p.email;
        $('frmvContratante_txtNumDocumento').value = p.docid;
        $('frmvContratante_cbxTipoDocumento').value = p.tdoidId;
        $('frmvContratante_txtTelefono').value = p.tfijo;
        $('frmvContratante_txtFax').value = p.tfax;

      }
    }
    catch (e){}
  }

  function perfomDataContacto()
  {
    try
    {
      vSolicitud.performDataContacto($('frmvContacto_asbContacto_SelectedValue')
        .value, showPersonDataContacto_CallBack);
    }
    catch (e)
    {
      alert(e.message);
    }
  }

  function showPersonDataContacto_CallBack(res)
  {
    try
    {

      p = res.value;

      $('frmvContacto_txtTelefono1').value = p.telefono1;
      $('frmvContacto_txtTelefono2').value = p.telefono2;
      $('frmvContacto_txtEmailContacto').value = p.email;
    }
    catch (e)
    {
      alert('Error al Asignar datos al contacto : ' + e.message);
    }
  }
  </script>

  <script type="text/javascript">
  
  CCSOL.Utiles.LoadCSS("./Scripts/xCommon/xCommon.css");
  CCSOL.Utiles.LoadScript("./Scripts/lib/xDropDownToolTip.js");
  CCSOL.Utiles.LoadScript("./Scripts/lib/x_especialTooltip.js");
  CCSOL.Utiles.LoadCSS("./Scripts/x_info/xInfo.css");
  CCSOL.Utiles.LoadScript("./Scripts/lib/xInfoSystem.js");
  CCSOL.Utiles.LoadScript("./Scripts/lib/xTable.js");
  

  function activateInfo()
  {
    var info = new infoSystem('holder_info', 'DivContainer', 'tt_help_info',
      'tt_title', 'tt_text');       
  }
  function aDropDownInit() {
    var dropDownTitle = new xDropDownToolTip('aDropDownWithTitle', null);
  }

  xAddEventListener(window, 'load', activateInfo, false);


  function showAdjuntarAnexo(e)
  {
    var solicitudId_s = '<%=solicitudId %>';
    ventana.showPopUpModal('vRegistroAnexo.aspx?SolicitudId=' + solicitudId_s, 410, 200);

    xStopPropagation(e);
    return false;
  }


  function doDeleteFile(AnexoId, filename)
  {
    var doDelete = false;
    doDelete = confirm('Desea Eliminar el archivo ' + filename);
    if (doDelete)
    {
      CarCheck.Gestores.GestorSolicitud.doAnexoDelete('' + AnexoId);
      doRefresh();
    }

  }

  function doRefresh()
  {
    var arg;
    var context;
    CCSOL.DOM.xShowLoadingMessage(":: Actualizando ::");

     <%= ClientScript.GetCallbackEventReference(this.cckhandler, "arg","doCallback_Refresh", "context", "HandleError", false) %> ;
  }

  function doCallback_Refresh(result, context)
  {

    CCSOL.DOM.xHideLoadingMessage();
    //$('theLoadingMessage').style.display = 'none';

    var linea = new String(result);
    //alert(linea);            
    var divGridContainer = $('gridFiles');
    divGridContainer.innerHTML = linea;
    activateInfo();

  }

  function HandleError(message)
  {
    CCSOL.DOM.xHideLoadingMessage();
    alert("[Error] : " + message);
  }

</script>
<script type="text/javascript">
	var cid = "<%=cid %>";
  var est = "<%=est %>";


  function doCallback_Comunicacion(result, context)
  {
    CCSOL.DOM.xHideLoadingMessage();
    //$('theLoadingMessage').style.display = 'none';
    
    var linea = new String(result);
    var divGridContainer = $('informacion');
    divGridContainer.innerHTML = linea;
    
  }

  function cleaningFunction() {
//    alert('here');
    var divGridContainer = $('informacion');
    divGridContainer.innerHTML = '';
  }
  function HandleError(message)
  {
    CCSOL.DOM.xHideLoadingMessage();
    alert("[Error] : " + message);
  }

  function onDisplayMenu(e){
    xMenu.doShow = false;
    var xE = new xEvent(e);
    var theTrigger = xE.target;
    var customRow = getRow(theTrigger, 5);
    var inspeccionId = CCSOL.DOM.x_GetAttribute(customRow,'inspeccionId');
    var vehiculoId = CCSOL.DOM.x_GetAttribute(customRow,'vehiculoId');
    var url = CCSOL.DOM.x_GetAttribute(customRow,'url');
    var hurl = $('urlHiddenField');
    if(inspeccionId != undefined){
      customRow.inspeccionId = inspeccionId;
      customRow.estado = CCSOL.DOM.x_GetAttribute(customRow,'estado');
      hurl.value = url;
      MostrarHistorico(customRow.inspeccionId);      
    }
  }

  function irUrl()
  {
    var hurl = $('urlHiddenField');
    if (hurl.value !='' )
    {
      window.parent.location = hurl.value;
      return true;
    }
    return false;
  }

  function MostrarHistorico(inspeccionId){
    xMenu.doShow = true;
    xMenu.doReturn = false;
    var context;
    <%=ClientScript.GetCallbackEventReference(this.callback_gridComunicacion, "inspeccionId", "doCallback_Comunicacion", "context", "HandleError", false) %>;
  }

  function Editar(inspeccionId){
    xMenu.doShow = false;
    xMenu.doReturn = true;
    alert("se procede con la edicion");
  }

  function Eliminar(inspeccionId){
    xMenu.doShow = false;
    xMenu.doReturn = true;
    if(confirm("Se eliminara el registro.\n\n¿Desea proseguir?"))
      alert("se procede con la eliminacion");
  }

  function getRow(elemento, maximo){
    if(maximo > 0){
      if(elemento.parentNode.tagName == "TR")
        return elemento.parentNode;
      else
        return getRow(elemento.parentNode, maximo - 1);
    }else
    return null;
  }

  function inspeccionGridView_onMouseClick(e) {
    //anulo la función de los links normales
    xStopPropagation(e);
    return false;
  }

  function xMenuNotificacion_onAutoHide() {
    return false;
  }

  var xMenu = null;
  var xMenuNotificacion = null;
  var xMenuAnular = null;
  function createDropDownMenu() {
    try {
      if($('notificarImageButton')) {
        xMenuNotificacion = new xDropDownMenu('dropDownNotificacion',       //el div que aparecerá en el punto de click
          'notificarImageButton', //el "map" area que contiene los hotspots que provocarán que aparezca el PopUpForm
          'context',		 //Se muestra en el punto de click ('d' = dropDownMenu,null = en el punto de click, 'context' = menu contextual
          'click',			 //el evento al que queremos asociar la aparición del Div
          null,			 	 //posicion en la que queremos que aparezca el div, 'left', 'right' o null solo tiene sentido cuando el menu es tipo 'd'
          null,	 //evento que se ejecuta al mostrarse el div
          
          xMenuNotificacion_onAutoHide,             //evento que se llama al ocurrir un mouseout
          true
        );
      }
    }
    catch(e) {
      alert(e.message);
    }
    
    try {
      xMenuAnular = new xDropDownMenu('dropDownAnular',       //el div que aparecerá en el punto de click
        'anularImageButton', //el "map" area que contiene los hotspots que provocarán que aparezca el PopUpForm
        'context',		 //Se muestra en el punto de click ('d' = dropDownMenu,null = en el punto de click, 'context' = menu contextual
        'click',			 //el evento al que queremos asociar la aparición del Div
        null,			 	 //posicion en la que queremos que aparezca el div, 'left', 'right' o null solo tiene sentido cuando el menu es tipo 'd'
        null,	 //evento que se ejecuta al mostrarse el div
        xMenuNotificacion_onAutoHide,            //evento que se llama al ocurrir un mouseout
        true
      );
      //xMenu = new xDropDownMenu('customToolTip', 'inspeccionGridView', 'context', 'click', null, onDisplayMenu, null);//, onAutoHide);
    }
    catch(e) {
      //alert(e.message);
    }
    try{
      xMenu = new xDropDownMenu('ToolTipInspeccion',       //el div que aparecerá en el punto de click
        'inspeccionGridView', //el "map" area que contiene los hotspots que provocarán que aparezca el PopUpForm
        'context',		 //Se muestra en el punto de click ('d' = dropDownMenu,null = en el punto de click, 'context' = menu contextual
        'click',			 //el evento al que queremos asociar la aparición del Div
        null,			 	 //posicion en la que queremos que aparezca el div, 'left', 'right' o null solo tiene sentido cuando el menu es tipo 'd'
        onDisplayMenu,
        null,
        false,
        cleaningFunction
      );//,	onAutoHide);
    }
    catch(e) {
      
    }
  }




  window.onload = function() {
    
    try {
      xAddEventListener($('frmvContratante_asbContratante'),'blur',perfomDataSearch,true);
      xAddEventListener($('frmvContacto_asbContacto'),'blur',perfomDataContacto,true);
    }
    catch(e)
    {
      alert(e.message);
    }
    
    
    
    createDropDownMenu();
    
    try {
      xCollapsible = new CollapsibleDiv('btnTrigger', 'solicitudPanel', null, null);
      yCollapsible = new CollapsibleDiv('solicitudLabel', 'solicitudPanel', null, null);
    }
    catch (e) {
      
      alert(e.message);
    }
    xAddEventListener($('frmvContacto_btnAgregar'),'click',showAdjuntarAnexo, false);
    
    var xtable = new xTable('inspeccionGridView',   //el Identificador de la tabla
				                    'ItemStyleSelected',            //el Style ItemSeleccionado
				                    'ItemStyleOver');       //el Style Over
                    		
    
    
  }	
  function hidePopWin() {
    if (ventana != null) ventana.hide();
  }
  </script>

  
 
  <link href="css/layout.css" rel="stylesheet" type="text/css" />
  <link href="./Scripts/asb_includes/AutoSuggestBox.css" rel="stylesheet" type="text/css" />

</head>
<body>
  <form id="form1" runat="server">
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
                  <asp:Label ID="solicitudLabel" runat="server" Text="Solicitud de Inspección" Font-Size="14pt"
                    ToolTip="Mostrar / Ocultar Panel" Font-Names="Arial"></asp:Label>
                  <img id="btnTrigger" alt="Mostrar / Ocultar Panel" src="Images/IconHide16Dark.gif"
                    title="Mostrar / Ocultar Panel" style="margin-top: 3px;" 
                     />
                </div>
                <div id="solicitudPanel">
                  <div class="PanelStyle" style="margin-top: 4px">
                    <div class="PanelEncabezado">
                      <asp:Label ID="lblDatosSolicitud" runat="server" Text="Datos de la Solicitud" Style="cursor: default"></asp:Label>
                    </div>
                    <div class="DataTable">
                      <asp:FormView ID="frmvCabeceraSolicitud" runat="server" DefaultMode="Edit" DataSourceID="odsSolicitud" OnDataBound="frmvCabeceraSolicitud_DataBound" DataKeyNames="solicitudId">
                        <EditItemTemplate>
                      <table border="0" cellpadding="0" cellspacing="0">
                        <tr>
                          <td style="width: 85px; ">
                            Usuario</td>
                          <td style=" ;">
                            <asp:TextBox ID="txtUsuario" runat="server" CssClass="FormText" Width="180px" TabIndex="100" Text='<%# Eval("usuario") %>' ReadOnly="True"></asp:TextBox></td>
                          <td style="width: 110px; ">
                            Solicitado por</td>
                          <td>
                            <asp:TextBox ID="txtSolicitadoPor" runat="server" CssClass="FormText" Width="180px"
                              TabIndex="120" Text='<%# Bind("solicitadopor") %>'></asp:TextBox></td>
                          <td style="width: 140px; ">
                            N&uacute;mero solicitud
                          </td>
                          <td>
                            <asp:TextBox ID="txtNumSolicitud" runat="server" CssClass="FormText" Width="180px"
                              TabIndex="140" Text='<%# Bind("numeSolicitudCliente") %>'></asp:TextBox></td>
                        </tr>
                        <tr>
                          <td>
                            Cliente</td>
                          <td style="">
                            <asp:DropDownList ID="cbxCliente" runat="server" CssClass="FormText tt_help_info aDropDownWithTitle" Width="184px"
                              TabIndex="105" AppendDataBoundItems="True" DataSourceID="odsCliente" DataTextField="persona"
                              DataValueField="personaId" SelectedValue='<%# Bind("clienteId") %>'>
                              <asp:ListItem Value="-1">[ - Elija - ]</asp:ListItem>
                            </asp:DropDownList></td>
                          <td>
                            Tipo requerimiento</td>
                          <td>
                            <asp:DropDownList ID="cbxTipoRequerimiento" runat="server" CssClass="FormText tt_help_info aDropDownWithTitle" Width="184px"
                              TabIndex="125" DataSourceID="odsTRequerimiento" DataTextField="trequerimiento"
                              DataValueField="trequerimientoId" AppendDataBoundItems="True" SelectedValue='<%# Bind("trequerimientoId") %>'>
                              <asp:ListItem Value="-1">[ - Elija - ]</asp:ListItem>
                            </asp:DropDownList></td>
                          <td>
                            Estado</td>
                          <td>
                            <asp:TextBox ID="txtEstado" runat="server" CssClass="FormText" Width="180px" TabIndex="145" Text='<%# Eval("estadoSolicitud") %>' ReadOnly="True"></asp:TextBox></td>
                        </tr>
                        <tr>
                          <td>
                            Aseguradora</td>
                          <td>
                            <asp:DropDownList ID="cbxAseguradora" runat="server" CssClass="FormText tt_help_info aDropDownWithTitle" Width="184px"
                              TabIndex="110" AppendDataBoundItems="True" DataSourceID="odsAseguradora" DataTextField="persona"
                              DataValueField="personaId" SelectedValue='<%# Bind("aseguradoraId") %>'>
                              <asp:ListItem Value="-1">[ - Elija - ]</asp:ListItem>
                            </asp:DropDownList></td>
                          <td>
                            Prioridad</td>
                          <td>
                            <asp:DropDownList ID="cbxPrioridad" runat="server" CssClass="FormText tt_help_info aDropDownWithTitle" Width="184px"
                              TabIndex="130" DataSourceID="odsPrioridad" DataTextField="prioridad" DataValueField="prioridadId"
                              AppendDataBoundItems="True" SelectedValue='<%# Bind("prioridadId") %>'>
                              <asp:ListItem Value="-1">[ - Elija - ]</asp:ListItem>
                            </asp:DropDownList>
                          </td>
                          <td>
                            Fecha/Hora actualización</td>
                          <td>
                            <asp:TextBox ID="txtFechaActualizacion" runat="server" CssClass="FormText" Width="180px"
                              TabIndex="150" Text='<%# Eval("fupdate") %>' ReadOnly="True"></asp:TextBox></td>
                        </tr>
                        <tr>
                          <td>
                            Broker</td>
                          <td>
                            <asp:DropDownList ID="cbxBroker" runat="server" CssClass="FormText tt_help_info aDropDownWithTitle" Width="184px"
                              TabIndex="115" AppendDataBoundItems="True" DataSourceID="odsBroker" DataTextField="persona"
                              DataValueField="personaId" SelectedValue='<%# Bind("brokerId") %>'>
                              <asp:ListItem Value="-1">[ - Elija - ]</asp:ListItem>
                            </asp:DropDownList></td>
                          <td>
                            Canal</td>
                          <td>
                            <asp:DropDownList ID="cbxCanal" runat="server" CssClass="FormText tt_help_info aDropDownWithTitle" Width="184px"
                              TabIndex="135" DataSourceID="odsCanal" DataTextField="canal" DataValueField="canalId"
                              AppendDataBoundItems="True" SelectedValue='<%# Bind("canalId") %>'>
                              <asp:ListItem Value="-1">[ - Elija - ]</asp:ListItem>
                            </asp:DropDownList></td>
                          <td>
                            Fecha/Hora solicitud</td>
                          <td>
                            <asp:TextBox ID="txtFechaSolicitud" runat="server" CssClass="FormText" Width="180px"
                              TabIndex="155" Text='<%# Eval("fsolicitud") %>' ReadOnly="True"></asp:TextBox></td>
                        </tr>
                        <tr  style="display:none">
                          <td>
                          </td>
                          <td>
                            <asp:TextBox ID="txtObservacion" runat="server" Width="8px" Text='<%# Bind("observacion") %>'></asp:TextBox>
                            <asp:CheckBox ID="chkClienteVIP" runat="server" Width="96px" Checked='<%# Bind("clienteVIP") %>' /></td>
                          <td>
                          </td>
                          <td>
                            <asp:TextBox ID="txtNumVehiculos"  runat="server" Width="24px" Text='<%# Bind("numeVehiculos") %>'></asp:TextBox>
                            <asp:TextBox ID="txtContactoId" runat="server"  Text='<%# Bind("contactoId") %>'
                              Width="24px"></asp:TextBox>
                            <asp:TextBox ID="txtContratanteId" runat="server"  Text='<%# Bind("contratanteId") %>'
                              Width="24px"></asp:TextBox>
                            <asp:TextBox ID="txtUsuarioId" runat="server" Text='<%# Bind("usuarioId") %>' Width="24px"></asp:TextBox></td>
                          <td>
                          </td>
                          <td>
                              <asp:HiddenField ID="hfEstadoSolicitud" runat="server" Value='<%# Eval("estadoSolicitud") %>' />
                          </td>
                        </tr>
                      </table>
                        </EditItemTemplate>
                      </asp:FormView>
                      </div>
                  </div>
                  <div class="PanelStyle" style="margin-bottom: 4px;z-index:500">
                    <div class="PanelEncabezado">
                      <asp:Label ID="Label3" runat="server" Style="cursor: default" Text="Asegurado / Contratante / Contacto"></asp:Label>
                    </div>
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                      <tr>
                        <td style="width: 535px;" valign="top" class="ItemStyle">
                          <asp:FormView ID="frmvContratante" runat="server" DataSourceID="odsContratante" DefaultMode="Edit">
                            <EditItemTemplate>
                              <div class="DataTable">
                              <table border="0" cellpadding="0" cellspacing="0">
                                <!--DWLayoutTable-->
                                <tr>
                                  <td style="width: 85px">
                                    Raz&oacute;n Social</td>
                                  <td>
                                    <cc1:AutoSuggestBox ID="asbContratante" runat="server" CssClass="FormText" DataType="Contratante"
                                      IncludeMoreMenuItem="False" KeyPressDelay="300" MaxSuggestChars="8" MenuCSSClass="asbMenu"
                                      MenuItemCSSClass="asbMenuItem" MoreMenuItemLabel="..." NoValueSelectedCSSClass="asbNonValueSelected"
                                      NumMenuItems="15" OnFocusShowAll="True" ResourcesDir="./Scripts/asb_includes" SelMenuItemCSSClass="asbSelMenuItem"
                                      Style="position: static" Text='<%# Bind("persona") %>' UseIFrame="False" WarnNoValueSelected="False"
                                      Width="180px" SelectedValue='<%# Bind("personaid") %>'></cc1:AutoSuggestBox></td>
                                  <td>
                                    N&deg; Doc.</td>
                                  <td>
                                    <asp:DropDownList ID="cbxTipoDocumento" runat="server" CssClass="FormText" Width="94px"
                                      AppendDataBoundItems="True" DataSourceID="odsTipoDoc" DataTextField="tdocid" DataValueField="tdocidId" SelectedValue='<%# Bind("TDocumentoIdentidad") %>'>
                                      <asp:ListItem Selected="True" Value="-1">[ - Elija - ]</asp:ListItem>
                                    </asp:DropDownList></td>
                                  <td style="width: 103px">
                                    <asp:TextBox ID="txtNumDocumento" runat="server" CssClass="FormText" Width="94px" Text='<%# Bind("DocumentoIdentidad") %>'></asp:TextBox></td>
                                </tr>
                                <tr>
                                  <td>
                                    Direcci&oacute;n</td>
                                  <td>
                                    <asp:TextBox ID="txtDireccion" runat="server" CssClass="FormText" Width="180px" Text='<%# Bind("direccionTrabajo") %>'></asp:TextBox></td>
                                  <td>
                                    Tel&eacute;fono</td>
                                  <td>
                                    <asp:TextBox ID="txtTelefono" runat="server" CssClass="FormText" Width="90px" Text='<%# Bind("TelefonoFijo1") %>'></asp:TextBox></td>
                                  <td style="width: 103px">
                                    Fax
                                    <asp:TextBox ID="txtFax" runat="server" CssClass="FormText" Width="70px" Text='<%# Bind("Fax") %>'></asp:TextBox></td>
                                </tr>
                                <tr>
                                  <td>
                                    Ubigeo</td>
                                  <td>
                                    <cc1:AutoSuggestBox ID="asbDistrito" runat="server" CssClass="FormText" DataType="Distrito"
                                      IncludeMoreMenuItem="True" KeyPressDelay="300" MaxSuggestChars="15" MenuCSSClass="asbMenu"
                                      MenuItemCSSClass="asbMenuItem" MoreMenuItemLabel="..." NoValueSelectedCSSClass="asbNonValueSelected"
                                      NumMenuItems="15" OnFocusShowAll="False" ResourcesDir="./Scripts/asb_includes"
                                      SelectedValue='<%# Bind("ubigeoIdTrabajo") %>' SelMenuItemCSSClass="asbSelMenuItem"
                                      Text='<%# Eval("distritoTrabajo") %>' UseIFrame="True" WarnNoValueSelected="False"
                                      Width="180px"></cc1:AutoSuggestBox></td>
                                  <td>
                                    E-mail</td>
                                  <td colspan="2" valign="top" style="padding-top:1px">
                                    <asp:TextBox ID="txtEmail" runat="server" CssClass="FormText" Width="147px" Text='<%# Bind("email") %>' ToolTip='<%# Eval("email") %>'></asp:TextBox>
                                    <asp:CheckBox ID="vipCheckBox" runat="server" CssClass="FormCheck" Text="VIP " TextAlign="Left"
                                     />
                                  </td>
                                </tr>
                                <tr>
                                  <td style="padding-top: 1px" valign="top">
                                    Observaciones</td>
                                  <td colspan="6">
                                    <asp:TextBox ID="txtObservacion" runat="server" CssClass="FormText" TextMode="MultiLine"
                                      Width="435px" Rows="3"></asp:TextBox></td>
                                </tr>
                              </table>
                            </div>
                            </EditItemTemplate>
                          </asp:FormView>
                        </td>
                        <td style="width: 4px" valign="top">
                        </td>
                        <td valign="top" class="ItemStyle">
                          <div class="DataTable">
                            <asp:FormView ID="frmvContacto" runat="server" DataSourceID="odsContacto" DefaultMode="Edit">
                              <EditItemTemplate>
                            <table border="0" cellpadding="0" cellspacing="0">
                              <tr>
                                <td>
                                  Contacto</td>
                                <td colspan="2">
                                  <cc1:AutoSuggestBox ID="asbContacto" runat="server" CssClass="FormText" DataType="Contacto"
                                    IncludeMoreMenuItem="False" KeyPressDelay="300" MaxSuggestChars="8" MenuCSSClass="asbMenu"
                                    MenuItemCSSClass="asbMenuItem" MoreMenuItemLabel="..." NoValueSelectedCSSClass="asbNonValueSelected"
                                    NumMenuItems="15" OnFocusShowAll="True" ResourcesDir="./Scripts/asb_includes" SelMenuItemCSSClass="asbSelMenuItem"
                                    Style="position: static" Text='<%# Bind("contacto") %>' UseIFrame="False" WarnNoValueSelected="False"
                                    Width="225px" SelectedValue='<%# Bind("contactoId") %>'></cc1:AutoSuggestBox></td>
                              </tr>
                              <tr>
                                <td style="height: 18px">
                                  Tel&eacute;fonos</td>
                                <td style="height: 18px">
                                  <asp:TextBox ID="txtTelefono1" runat="server" CssClass="FormText" Width="103px" Text='<%# Bind("telefono1") %>'></asp:TextBox></td>
                                <td align="right" style="height: 18px">
                                  <asp:TextBox ID="txtTelefono2" runat="server" CssClass="FormText" Width="113px" Text='<%# Bind("telefono2") %>'></asp:TextBox></td>
                              </tr>
                              <tr>
                                <td style="height: 18px">
                                  E-mail</td>
                                <td colspan="2" style="height: 18px">
                                  <asp:TextBox ID="txtEmailContacto" runat="server" CssClass="FormText" Width="225px" Text='<%# Bind("email") %>'></asp:TextBox></td>
                              </tr>
                              <tr>
                                <td style="padding-top: 2px" valign="top">
                                  Nro. vehículos</td>
                                <td colspan="2" style="padding-top: 1px">
                                  <asp:TextBox ID="txtNroVehiculos" runat="server" CssClass="FormText" Width="32px"
                                    Style="float: left"></asp:TextBox>
                                  <asp:Button ID="btnAgregar" runat="server" CssClass="FormButton" Text="Agregar Archivo"  Style="FLOAT: right; WIDTH: 117px; HEIGHT: 16px" OnClientClick="return false;"/></td>
                              </tr>
                            </table>
                              </EditItemTemplate>
                            </asp:FormView>
                            <table border="0" cellpadding="0" cellspacing="0" style="width: 320px">
                              <tr>
                                <td align="right" colspan="4" valign="bottom">
                                  <div id="gridFiles">
                                      <asp:DataList ID="DataList1" runat="server" DataKeyField="AnexoId" DataSourceID="odsListaAnexos">
                                      
                                        <HeaderTemplate>
                                          <table border="0" cellpadding="0" cellspacing="0">
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                          <tr>
                                            <td align="right">
                                              <asp:HyperLink ID="lnkFileName" runat="server" ForeColor="Blue" Target="_blank" CssClass="tt_help_info"
                                                tt_title="Observación" tt_text='<%# Eval("observacion") %>' NavigateUrl='<%# getAnexoUrl(Eval("AnexoId")) %>'
                                                Text='<%# Eval("filename") %>'></asp:HyperLink>
                                            </td>
                                            <td>
                                              <asp:HyperLink ID="HyperLink10" runat="server" ImageUrl="~/Images/IconDeleteAttach.gif"
                                                NavigateUrl="#" onclick='<%# getAnexoDeleteCommand(Eval("AnexoId"),Eval("filename")) %>'>Eliminar ajunto</asp:HyperLink>
                                            </td>
                                          </tr>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                          </table>
                                        </FooterTemplate>
                                      </asp:DataList>
                                    </div>
                                </td>
                              </tr>
                            </table>
                          </div>
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
            <div class="DataTop">
              <div class="DataTopLeft">
              </div>
              <div class="DataTopRight">
              </div>
            </div>
            <div class="DataContent">
              <div class="DataContentRight" style="position:relative;">
                <div class="PanelEncabezado" style="height: 23px;">
                  <asp:Label ID="Label1" runat="server" Text="Lista de Inspecciones" Font-Bold="True"
                    Font-Names="Arial" Font-Size="14pt"></asp:Label>
                  <div id="panelBtns" style="float: right; margin-top: 3px">
                    <asp:ImageButton ID="nuevaInspeccionImageButton" runat="server" ImageUrl="~/Images/btnNuevaInspeccion.jpg" OnClick="nuevaInspeccionImageButton_Click" OnClientClick="return showNewInspeccionForm();" />
                    <asp:ImageButton ID="agendarImageButton" runat="server" ImageUrl="~/Images/btnAgendar.jpg" />
                  </div>
                </div>
                <div class="hr" style="margin-top: -4px">
                </div>
                <div id="GridInspecciones" runat="server">
                  <asp:GridView ID="inspeccionGridView" runat="server" AutoGenerateColumns="False"
                    CssClass="GridLista" DataSourceID="odsInspecciones" AllowSorting="True" BorderStyle="Solid" OnRowDataBound="inspeccionGridView_RowDataBound">
                    <Columns>
                      <asp:TemplateField HeaderText="N&#186;">
                        <ItemStyle Width="10px" HorizontalAlign="Center" />
                        <ItemTemplate>
                          <asp:Label ID="lblNum" runat="server" ForeColor="#000000" Text="<%# num++ %>"></asp:Label>
                        </ItemTemplate>
                      </asp:TemplateField>
                      <asp:BoundField DataField="numeInspeccion" HeaderText="N&#186; Insp." SortExpression="numeInspeccion">
                        <ItemStyle Width="90px" HorizontalAlign="Center" />
                      </asp:BoundField>
                      <asp:BoundField DataField="persona" HeaderText="Asegurado" SortExpression="persona">
                        <ItemStyle Width="200px" HorizontalAlign="Center" />
                      </asp:BoundField>
                      <asp:BoundField DataField="contacto" HeaderText="Contacto" SortExpression="contacto">
                        <ItemStyle Width="200px" HorizontalAlign="Center" />
                      </asp:BoundField>
                      <asp:BoundField DataField="marcaVehiculo" HeaderText="Marca" SortExpression="marcaVehiculo">
                        <ItemStyle Width="90px" HorizontalAlign="Center" />
                      </asp:BoundField>
                      <asp:BoundField DataField="modeloVehiculo" HeaderText="Modelo" SortExpression="modeloVehiculo">
                        <ItemStyle Width="90px" HorizontalAlign="Center" />
                      </asp:BoundField>
                      <asp:BoundField DataField="anhoFabricacion" DataFormatString="{0:yyyy}" HeaderText="A&#241;o"
                        SortExpression="anhoFabricacion" HtmlEncode="False">
                        <ItemStyle Width="60px" HorizontalAlign="Center" />
                      </asp:BoundField>
                      <asp:BoundField DataField="placa" HeaderText="Placa" SortExpression="placa">
                        <ItemStyle Width="60px" HorizontalAlign="Center" />
                      </asp:BoundField>
                      <asp:BoundField DataField="chasis" HeaderText="Chasis/Serie" SortExpression="chasis">
                        <ItemStyle Width="60px" HorizontalAlign="Center" />
                      </asp:BoundField>
                      <asp:BoundField DataField="colorVehiculo" HeaderText="Color" SortExpression="colorVehiculo">
                        <ItemStyle Width="60px" HorizontalAlign="Center" />
                      </asp:BoundField>
                      <asp:TemplateField HeaderText="Valor">
                        <ItemStyle Width="60px" HorizontalAlign="Center" />
                        <ItemTemplate> 
                        <table cellpadding="0" border="0" cellspacing="0">
                          <tr class="noMouseOver">
                            <td style="width:20px;text-align:left;"><asp:Label ID="l" runat="server" Text='<%# Eval("simbolo") %>'></asp:Label></td>
                            <td><asp:Label ID="Label4" runat="server"  Text='<%# Eval("valor") %>'></asp:Label></td>
                          </tr>
                        </table>                                                    
                          </div>
                        </ItemTemplate>
                      </asp:TemplateField>
                      <asp:BoundField DataField="estadoInspeccionId" HeaderText="Estado" SortExpression="estadoInspeccionId">
                        <ItemStyle Width="80px" HorizontalAlign="Center" />
                      </asp:BoundField>
                      <asp:BoundField DataField="fcrea" DataFormatString="{0:dd-MM-yyyy}" HeaderText="Fecha Estado"
                        SortExpression="fcrea">
                        <ItemStyle Width="60px" HorizontalAlign="Center" />
                      </asp:BoundField>
                      <asp:TemplateField HeaderText="Accion">
                        <EditItemTemplate>
                          <asp:ImageButton ID="ImageButton1" runat="server" CausesValidation="True" CommandName="Update"
                            ImageUrl="~/Images/btnsListas/icon_ok.jpg" Text="Update" />&nbsp;<asp:ImageButton
                              ID="ImageButton2" runat="server" CausesValidation="False" CommandName="Cancel"
                              ImageUrl="~/Images/btnsListas/icon_exit.jpg" Text="Cancel" />
                        </EditItemTemplate>
                        <ItemStyle Width="40px" HorizontalAlign="Center" />
                        <ItemTemplate>
                          <div style="z-index: 105; left: 100px; width: 100px; position: absolute; top: 100px;
                            height: 100px">
                          </div>
                          <table>
                            <tr>
                              <td>
                          <asp:ImageButton ID="ImageButton3" runat="server" CommandName="Delete" ImageUrl="~/Images/IconDelete.gif"
                            OnClientClick="return confirm('Desea Eliminar el registro elegido???');" /></td>
                            </tr>
                          </table>
                        </ItemTemplate>
                      </asp:TemplateField>
                      <asp:BoundField DataField="vehiculoId" HeaderText="vehiculoId" InsertVisible="False"
                        ReadOnly="True" SortExpression="vehiculoId" Visible="False" />
                      <asp:BoundField DataField="inspeccionId" HeaderText="inspeccionId" InsertVisible="False"
                        ReadOnly="True" SortExpression="inspeccionId" Visible="False" />
                      <asp:BoundField DataField="estadoInspeccionId" HeaderText="estadoInspeccionId" SortExpression="estadoInspeccionId"
                        Visible="False" />
                      <asp:BoundField DataField="aseguradoId" HeaderText="aseguradoId" SortExpression="aseguradoId"
                        Visible="False" />
                      <asp:BoundField DataField="marcaVehiculoId" HeaderText="marcaVehiculoId" SortExpression="marcaVehiculoId"
                        Visible="False" />
                      <asp:BoundField DataField="contactoId" HeaderText="contactoId" SortExpression="contactoId"
                        Visible="False" />
                      <asp:BoundField DataField="solicitudId" HeaderText="solicitudId" SortExpression="solicitudId"
                        Visible="False" />
                      <asp:BoundField DataField="valorId" HeaderText="valorId" InsertVisible="False" ReadOnly="True"
                        SortExpression="valorId" Visible="False" />
                      <asp:BoundField DataField="valor" HeaderText="valor" SortExpression="valor" Visible="False" />
                      <asp:BoundField DataField="moneda" HeaderText="moneda" SortExpression="moneda" Visible="False" />
                    </Columns>
                    <RowStyle CssClass="ItemStyle" />
                    <HeaderStyle CssClass="HeaderStyle" />
                  </asp:GridView>
                  <div id="NewInspeccionDiv" style="position:relative;" runat="server">
                         <table id="newInspeccionHeader" runat="server" border="1" cellspacing="0" rules="all"
                    style="width: 1008px; border-collapse: collapse">
                    <tr class="HeaderStyle">
                      <th scope="col" style="width: 10px">
                        N°</th>
                      <th class="invisible" scope="col">
                        detalleSolicitudId</th>
                      <th scope="col" style="width: 90px">
                        N&deg; Insp.</th>
                      <th scope="col" style="width: 200px">
                        Asegurado</th>
                      <th scope="col" style="width: 200px">
                        Contacto</th>
                      <th scope="col" style="width: 90px">
                        Marca</th>
                      <th scope="col" style="width: 90px">
                        Modelo</th>
                      <th scope="col" style="width: 60px">
                        A&ntilde;o</th>
                      <th scope="col" style="width: 60px">
                        Placa</th>
                      <th scope="col" style="width: 60px">
                        Chasis</th>
                      <th scope="col" style="width: 60px">
                        Color</th>
                      <th scope="col" style="width: 60px">
                        Valor</th>
                      <th scope="col" style="width: 80px">
                        Estado</th>
                      <th scope="col" style="width: 60px">
                        Fecha Estado</th>
                      <th scope="col" style="width: 40px">
                        Acción</th>
                    </tr>
                  </table>
                  <asp:FormView ID="frmViewNewInspeccion" runat="server" BorderWidth="0px" CellPadding="0"
                    DataKeyNames="solicitudId,inspeccionId" DefaultMode="Insert" Width="1008px" DataSourceID="odsInspecciones" OnItemInserted="frmViewNewInspeccion_ItemInserted" OnItemInserting="frmViewNewInspeccion_ItemInserting">
                    <InsertItemTemplate>
                      <table id="Table2" border="1" cellspacing="0" rules="all" style="width: 1008px; border-collapse: collapse">
                        <tr class="ItemStyle">
                          <td align="center" style="width: 20px">
                            --
                          </td>
                          <td class="invisible">
                            </td>
                          <td style="width: 90px">
                            &lt;AUTO&gt;</td>
                          <td style="width: 180px">
                            <cc1:AutoSuggestBox ID="asbAsegurado" runat="server" CssClass="FormText" DataType="Contratante"
                              IncludeMoreMenuItem="False" KeyPressDelay="300" MaxSuggestChars="8" MenuCSSClass="asbMenu"
                              MenuItemCSSClass="asbMenuItem" MoreMenuItemLabel="..." NoValueSelectedCSSClass="asbNonValueSelected"
                              NumMenuItems="15" OnFocusShowAll="True" ResourcesDir="./Scripts/asb_includes" SelectedValue='<%# Bind("aseguradoId") %>'
                              SelMenuItemCSSClass="asbSelMenuItem" Style="position: static" Text='<%# Bind("persona") %>'
                              UseIFrame="False" WarnNoValueSelected="False" Width="140px"></cc1:AutoSuggestBox></td>
                          <td style="width: 180px">
                            <cc1:AutoSuggestBox ID="asbContacto" runat="server" CssClass="FormText" DataType="Contacto"
                              IncludeMoreMenuItem="False" KeyPressDelay="300" MaxSuggestChars="8" MenuCSSClass="asbMenu"
                              MenuItemCSSClass="asbMenuItem" MoreMenuItemLabel="..." NoValueSelectedCSSClass="asbNonValueSelected"
                              NumMenuItems="15" OnFocusShowAll="True" ResourcesDir="./Scripts/asb_includes" SelectedValue='<%# Bind("contactoId") %>'
                              SelMenuItemCSSClass="asbSelMenuItem" Style="position: static" Text='<%# Bind("contacto") %>'
                              UseIFrame="False" WarnNoValueSelected="False" Width="140px"></cc1:AutoSuggestBox></td>
                          <td style="width: 100px">
                            <asp:DropDownList ID="cbxMarca" runat="server" AppendDataBoundItems="True" CssClass="FormText"
                              DataSourceID="odsMarca" DataTextField="marcaVehiculo" DataValueField="marcaVehiculoId"
                              Width="80px">
                              <asp:ListItem Value="-1" Selected="True">[ Elija ]</asp:ListItem>
                            </asp:DropDownList></td>
                          <td style="width: 100px">
                            <asp:TextBox ID="ModeloTextBox" runat="server" CssClass="FormText" Width="100px" Text='<%# Bind("modeloVehiculo") %>'></asp:TextBox></td>
                          <td style="width: 60px">
                            <asp:TextBox ID="anhoTextBox" runat="server" CssClass="FormText" Width="53px" Text='<%# Eval("anhoFabricacion", "{0:yyyy}") %>'></asp:TextBox></td>
                          <td style="width: 60px">
                            <asp:TextBox ID="placaTextBox" runat="server" CssClass="FormText" Width="53px" Text='<%# Bind("placa") %>'></asp:TextBox></td>
                          <td style="width: 60px">
                            <asp:TextBox ID="txtChasis" runat="server" CssClass="FormText" Width="50px" Text='<%# Bind("chasis") %>'></asp:TextBox></td>
                          <td style="width: 60px">
                            <asp:TextBox ID="txtColor" runat="server" CssClass="FormText" Text='<%# Bind("colorVehiculo") %>'
                              Width="50px"></asp:TextBox></td>
                          <td style="width: 71px">
                            <asp:DropDownList ID="cbxMoneda" runat="server" DataSourceID="odsMoneda" DataTextField="simbolo"
                              DataValueField="monedaId" SelectedValue='<%# Bind("monedaId") %>' Width="32px">
                            </asp:DropDownList>
                            <asp:TextBox ID="txtValor" runat="server" CssClass="FormText " Width="60px" Text='<%# Bind("valor") %>'></asp:TextBox></td>
                          <td align="center" style="width: 15px">
                            <asp:ImageButton ID="ingBtnSave" runat="server" CommandName="Insert" ImageUrl="~/Images/btnGuardarGrilla.jpg"
                              OnClientClick="return validaInsercionBlancos();" ToolTip="GRABAR" />&nbsp;</td>
                        </tr>
                      </table>                      
                    </InsertItemTemplate>
                  </asp:FormView>              
                                    
                  </div>
               
                  <br />
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
                <div class="DataContentRight" style="height: 52px;">
                  <div style="float: left">
                    <asp:ImageButton ID="guardarImageButton" runat="server" ImageUrl="~/Images/IconSave48Dark.gif"
                      ToolTip="Guardar Datos" CssClass="MakeClear" 
                       OnClick="guardarImageButton_Click" />
                  </div>
                  <div style="float: right">
                    <asp:ImageButton ID="anularImageButton" runat="server" ImageUrl="~/Images/btnAnularSolicitud.jpg"
                      ToolTip="Anular Solicitud" CssClass="MakeClear"   />
                    <asp:ImageButton ID="notificarImageButton" runat="server" ImageUrl="~/Images/btnNotificar.jpg"
                      ToolTip="Enviar notificación" CssClass="MakeClear"   />
                    <asp:ImageButton ID="enviarImageButton" runat="server" ImageUrl="~/Images/btnEnviarSolicitud.jpg"
                      ToolTip="Enviar Solicitud"  
                      Visible="False" CssClass="MakeClear" />
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
            <asp:ObjectDataSource ID="odsTRequerimiento" runat="server" OldValuesParameterFormatString="original_{0}"
              SelectMethod="GetData" TypeName="dsComboTableAdapters.TipoRequerimientoComboTableAdapter">
              <SelectParameters>
                <asp:Parameter Name="estado" Type="String" />
              </SelectParameters>
            </asp:ObjectDataSource>
            <asp:ObjectDataSource ID="odsPrioridad" runat="server" OldValuesParameterFormatString="original_{0}"
              SelectMethod="GetData" TypeName="dsComboTableAdapters.PrioridadComboTableAdapter">
              <SelectParameters>
                <asp:Parameter Name="estado" Type="String" />
              </SelectParameters>
            </asp:ObjectDataSource>
            <asp:ObjectDataSource ID="odsCanal" runat="server" OldValuesParameterFormatString="original_{0}"
              SelectMethod="GetData" TypeName="dsComboTableAdapters.CanalComboTableAdapter">
              <SelectParameters>
                <asp:Parameter Name="estado" Type="String" />
              </SelectParameters>
            </asp:ObjectDataSource>
            <asp:ObjectDataSource ID="odsTipoDoc" runat="server" OldValuesParameterFormatString="original_{0}"
              SelectMethod="GetData" TypeName="ADM_DAL.dsDropDownListTableAdapters.TDocIdLoadDropDownTableAdapter">
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
            <asp:ObjectDataSource ID="odsAseguradora" runat="server" OldValuesParameterFormatString="original_{0}"
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
            <asp:ObjectDataSource ID="odsSolicitud" runat="server"
              SelectMethod="GetData" TypeName="dsSolicitudTableAdapters.SolicitudCabeceraTableAdapter"
              UpdateMethod="Update" OnSelected="odsSolicitud_Selected">
              <UpdateParameters>
                <asp:Parameter Name="solicitudId" Type="Decimal" />
                <asp:Parameter Name="numeSolicitudCliente" Type="String" />
                <asp:Parameter Name="clienteId" Type="Decimal" />
                <asp:Parameter Name="aseguradoraId" Type="Decimal" />
                <asp:Parameter Name="brokerId" Type="Decimal" />
                <asp:Parameter Name="canalId" Type="Int32" />
                <asp:Parameter Name="fsolicitud" Type="DateTime" />
                <asp:Parameter Name="solicitadopor" Type="String" />
                <asp:Parameter Name="trequerimientoId" Type="String" />
                <asp:Parameter Name="prioridadId" Type="String" />
                <asp:Parameter Name="observacion" Type="String" />
                <asp:Parameter Name="usuarioId" Type="Int32" />
                <asp:Parameter Name="uupdate" Type="String" />
                <asp:Parameter Name="numeVehiculos" Type="Int32" />
                <asp:Parameter Name="clienteVIP" Type="Boolean" />
                <asp:Parameter Name="contactoId" Type="Decimal" />
                <asp:Parameter Name="contratanteId" Type="Decimal" />
              </UpdateParameters>
              <SelectParameters>
                <asp:QueryStringParameter DefaultValue="3" Name="solicitudId" QueryStringField="SolicitudId"
                  Type="Decimal" />
              </SelectParameters>
            </asp:ObjectDataSource>
            <asp:ObjectDataSource ID="odsContratante" runat="server"
              SelectMethod="GetData" TypeName="dsSolicitudTableAdapters.ContratanteSolicitudTableAdapter"
              UpdateMethod="Update" OnUpdated="odsContratante_Updated" OnUpdating="odsContratante_Updating">
              <UpdateParameters>
                <asp:Parameter Name="solicitudId" Type="Decimal" />
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
              </UpdateParameters>
              <SelectParameters>
                <asp:QueryStringParameter DefaultValue="3" Name="solicitudId" QueryStringField="SolicitudId"
                  Type="Decimal" />
              </SelectParameters>
            </asp:ObjectDataSource>
            <asp:ObjectDataSource ID="odsContacto" runat="server"
              SelectMethod="GetData" TypeName="dsSolicitudTableAdapters.ContactoSolicitudTableAdapter"
              UpdateMethod="Update" OnUpdated="odsContacto_Updated" OnUpdating="odsContacto_Updating">
              <UpdateParameters>
                <asp:Parameter Name="solicitudId" Type="Decimal" />
                <asp:Parameter Direction="InputOutput" Name="contactoId" Type="Object" />
                <asp:Parameter Name="contacto" Type="String" />
                <asp:Parameter Name="email" Type="String" />
                <asp:Parameter Name="telefono1" Type="String" />
                <asp:Parameter Name="telefono2" Type="String" />
              </UpdateParameters>
              <SelectParameters>
                <asp:QueryStringParameter DefaultValue="3" Name="solicitudId" QueryStringField="SolicitudId"
                  Type="Decimal" />
              </SelectParameters>
            </asp:ObjectDataSource>
            <asp:ObjectDataSource ID="odsInspecciones" runat="server" DeleteMethod="Delete" InsertMethod="Insert" SelectMethod="GetData" TypeName="dsSolicitudTableAdapters.InspecionesSolicitudTableAdapter" OnSelected="odsInspecciones_Selected">
              <DeleteParameters>
                <asp:Parameter Name="inspeccionId" Type="Decimal" />
              </DeleteParameters>
              <SelectParameters>
                <asp:QueryStringParameter DefaultValue="3" Name="solicitudId" QueryStringField="SolicitudId"
                  Type="Decimal" />
              </SelectParameters>
              <InsertParameters>
                <asp:Parameter Direction="InputOutput" Name="inspeccionId" Type="Object" />
                <asp:Parameter Name="solicitudId" Type="Decimal" />
                <asp:Parameter Name="aseguradoId" Type="Int32" />
                <asp:Parameter Name="persona" Type="String" />
                <asp:Parameter Name="contactoId" Type="Decimal" />
                <asp:Parameter Name="contacto" Type="String" />
                <asp:Parameter Name="marcaVehiculo" Type="String" />
                <asp:Parameter Name="modeloVehiculo" Type="String" />
                <asp:Parameter Name="anhoFabricacion" Type="DateTime" />
                <asp:Parameter Name="placa" Type="String" />
                <asp:Parameter Name="chasis" Type="String" />
                <asp:Parameter Name="colorVehiculo" Type="String" />
                <asp:Parameter Name="valor" Type="Decimal" />
                <asp:Parameter Name="monedaId" Type="String" />
                <asp:Parameter Name="ucrea" Type="String" />
              </InsertParameters>
            </asp:ObjectDataSource>
            <asp:ObjectDataSource ID="odsMoneda" runat="server" OldValuesParameterFormatString="original_{0}"
              SelectMethod="GetData" TypeName="ADM_DAL.dsDropDownListTableAdapters.MonedaLoadDropDownTableAdapter">
              <SelectParameters>
                <asp:Parameter DefaultValue="A" Name="estado" Type="String" />
              </SelectParameters>
            </asp:ObjectDataSource>
                      <asp:ObjectDataSource ID="odsMarca" runat="server" OldValuesParameterFormatString="original_{0}"
                        SelectMethod="GetData" TypeName="ADM_DAL.dsDropDownListTableAdapters.MarcaVehiculoLoadDropDownTableAdapter">
                        <SelectParameters>
                          <asp:Parameter Name="claseVehiculoId" Type="Decimal" />
                        </SelectParameters>
                      </asp:ObjectDataSource>            
              <asp:HiddenField ID="urlHiddenField" runat="server" />
          <asp:ObjectDataSource ID="odsListaAnexos" runat="server" DeleteMethod="Delete"
                                        InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData"
                                        TypeName="dsAnexosTableAdapters.AnexoTableAdapter">
                                        <DeleteParameters>
                                          <asp:Parameter Name="AnexoId" Type="Int32" />
                                        </DeleteParameters>
                                        <SelectParameters>
                                          <asp:QueryStringParameter DefaultValue="" Name="solicitudId" QueryStringField="SolicitudId"
                                            Type="Decimal" />
                                        </SelectParameters>
                                        <InsertParameters>
                                          <asp:Parameter Direction="InputOutput" Name="AnexoId" Type="Object" />
                                          <asp:Parameter Name="filename" Type="String" />
                                          <asp:Parameter Name="observacion" Type="String" />
                                          <asp:Parameter Name="binarydata" Type="Object" />
                                          <asp:Parameter Name="ucrea" Type="String" />
                                          <asp:Parameter Name="solicitudId" Type="Decimal" />
                                        </InsertParameters>
                                      </asp:ObjectDataSource>
          </td>
        </tr>
      </table>
    </div>
    <div id="ToolTipInspeccion" class="ToolTip" style="z-index: 106;">
      <strong style="font-size: 11px">Fecha de la Cita de Inspección: &nbsp;</strong>
      <asp:Button ID="btnGoTo" runat="server" CssClass="FormButton" Style="right: 2px;
                  position: absolute; top: 2px" Text="Ir a" Width="80px" Visible="true" OnClientClick="irUrl();return false;" />
      <div id="informacion">          
          <div id="divCita" style="font-weight: bold" > 
          <strong style="font-size: 11px">Inspección</strong>              
          </div>          
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
                        <HeaderStyle BorderColor="Black" BorderWidth="1px" BorderStyle="Solid"  Font-Bold="True" Font-Names="Arial" Font-Size="8pt" ForeColor="Black" />
                        <RowStyle BorderColor="Black" />                    
                    </asp:GridView>
          </div>
      </div>
    </div>
    <div id="dropDownNotificacion" class="popUpForm" style="padding: 2px; width: 450px;
      display: none; text-align: left; position: absolute; z-index: 103;">
      <table border="0" cellpadding="0" cellspacing="0" class="DataTable" style="font-size: 10px;">
        <tr>
          <td align="left" style=" font-weight: bold;" valign="bottom" colspan="2">
            Mensaje</td>
        </tr>
        <tr>
          <td align="left" colspan="2">
            <textarea name="TextBox2" rows="10" cols="20" id="Textarea1" class="FormText" style="width: 440px;"></textarea></td>
        </tr>
        <tr>
          <td colspan="2" style="font-weight: bold; height: 16px" valign="bottom">
            Notificar a...</td>
        </tr>
        <tr>
          <td>
            <span class="FormCheck">
              <input id="CheckBox1" type="checkbox" name="CheckBox1" /><label for="CheckBox1">Administrador</label></span></td>
          <td align="right" valign="bottom" style="width: 316px">
            <input name="TextBox3" type="text" id="Text1" class="FormText" style="width: 300px;" /></td>
        </tr>
        <tr>
          <td>
            <span class="FormCheck">
              <input id="CheckBox2" type="checkbox" name="CheckBox2" /><label for="CheckBox2">Solicitante</label></span></td>
          <td align="right" valign="bottom" style="width: 316px">
            <input name="TextBox4" type="text" id="Text2" class="FormText" style="width: 300px;" /></td>
        </tr>
        <tr>
          <td>
            <span class="FormCheck">
              <input id="CheckBox3" type="checkbox" name="CheckBox3" /><label for="CheckBox3">Aseguradora</label></span></td>
          <td align="right" valign="bottom" style="width: 316px">
            <input name="TextBox5" type="text" id="Text3" class="FormText" style="width: 300px;" /></td>
        </tr>
        <tr>
          <td align="right" style="padding-top: 2px; height: 19px;" colspan="2">
            <input name="Button5" type="button" onclick="xMenuNotificacion.hide();return false;"
              id="Button5" class="FormButton" style="width: 71px" value="Notificar" />
            <input id="Button6" class="FormButton" onclick="xMenuNotificacion.hide();return false;"
              type="button" value="Cancelar" />
          </td>
        </tr>
      </table>
    </div>
    <div id="dropDownAnular" class="popUpForm" style="padding: 2px; width: 250px; text-align: left;
      display: none; position: absolute; z-index: 104;">
      <table border="0" cellpadding="0" cellspacing="0" class="DataTable">
        <tr>
          <td align="left" style="font-weight: bold; height: 12px;">
            Motivo</td>
        </tr>
        <tr>
          <td align="left">
            <select name="DropDownList1" id="DropDownList1" class="FormText NOHIDE" style="width: 244px;">
              <option value=""></option>
              <option value="DESISTIMIENTO DEL SOLICITANTE">DESISTIMIENTO DEL SOLICITANTE</option>
            </select>
          </td>
        </tr>
        <tr>
          <td align="left" style=" font-weight: bold;" valign="bottom">
            Observación</td>
        </tr>
        <tr>
          <td align="left">
            <textarea name="descripcionTextBox" rows="6" cols="20" id="descripcionTextBox" class="FormText"
              style="width: 240px;"></textarea></td>
        </tr>
        <tr>
          <td align="right" style="height: 20px">
            <input name="guardarButton" type="button" onclick="xMenuAnular.hide();return false;"
              id="guardarButton" class="FormButton" style="width: 130px" value="Anular Inspección" />
            <input id="cancelarButton" onclick="xMenuAnular.hide();return false;" class="FormButton"
              type="button" value="Cancelar" />
          </td>
        </tr>
      </table>
    </div>
  </form> 
</body>
</html>
