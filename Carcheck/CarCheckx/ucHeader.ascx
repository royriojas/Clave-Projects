<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ucHeader.ascx.cs" Inherits="ucHeader" %>
<link href="css/layout.css" rel="stylesheet" type="text/css" />
<%--<script type="text/javascript" src="Scripts/lib/x.js"></script>

<script type="text/javascript" src="Scripts/lib/x_common.js"></script>--%>

<script type="text/javascript" src="Scripts/lib/xDomReady.js"></script>

<script type="text/javascript" src="./Scripts/lib/xCaseFormatter.js"></script>

<script type="text/javascript" src="./Scripts/lib/x_imageEffects.js"></script>

<script type="text/javascript" src="./Scripts/lib/xTable.js"></script>

<script type="text/javascript" src="./Scripts/lib/CollapsibleDiv.js"></script>

<script type="text/javascript" src="./Scripts/lib/xKeyEvents.js"></script>

<script type="text/javascript">
	
	 
//	if (typeof(domReady) != 'function')   {
//		CCSOL.Utiles.LoadScript('./Scripts/lib/xDomReady.js');
//	}      
    //Estilos globales comunes, deben siempre cargarse luego del x_common.js    
    CCSOL.Utiles.LoadCSS("./Scripts/xCommon/xCommon.css");
   
//    //debugger; 
//    //inicializaciones comunes a todas las p�ginas con dataEntry
//    //permite poner en may�sculas o min�sculas los textboxes seg�n se haya definido.
//    CCSOL.Utiles.LoadScript('./Scripts/lib/xCaseFormatter.js');
//    
//    //para poner el efecto mouseOver de Aldo sobre las im�genes, agregandole la clase MakeClear a 
//    //todas las im�genes que necesiten el efecto
//    CCSOL.Utiles.LoadScript('./Scripts/lib/x_imageEffects.js');    
//    
//    //Permite obtener el efecto de rollOver sobre una grilla, adem�s de dejar seleccionada la fila a la que se le hizo click
//    CCSOL.Utiles.LoadScript("./Scripts/lib/xTable.js");   
//    
//    //Este Script permite cargar los collapsibles est� deprecado en favor de xCollapsibleSystem
//    CCSOL.Utiles.LoadScript("Scripts/lib/CollapsibleDiv.js");
//    
//    //Este Script permite ponerle shortCuts a los elementos que realizan acciones a trav�s de clicks
//    CCSOL.Utiles.LoadScript("Scripts/lib/xKeyEvents.js");
//    
//    //CCSOL.DOM.xShowLoadingMessage('Cargando... por favor espere');

</script>

<!--SCRIPTS VENTANA POPUP-->

<script type="text/javascript" src="./Scripts/lib/xpopup.js"></script>

<link href="./Scripts/xPopUpCSS/fen.css" rel="stylesheet" type="text/css" />

<script type="text/javascript">                                           
    //CCSOL.Utiles.LoadScript('./Scripts/lib/xpopup.js');  
    //CCSOL.Utiles.LoadCSS('./Scripts/xPopUpCSS/fen.css');  
    //xAddEventListener(window,'load',__initPopUpWindow,false);
	domReady(__initPopUpWindow);
    var ventana = null;
    function __initPopUpWindow() {
      ventana = new xPopUp(0,'./loading.html',true);	              
      //ventana.showPopUpModal o ventana.showPopUp 
      //showPopUpModal (url, ancho, alto)      
    }      
    function hidePopWin() {
      if (ventana != null) ventana.hide();
    }
</script>

<!--FIN SCRIPTS VENTANA POPUP-->
<!-- tooltip System -->

<script type="text/javascript" src="./Scripts/lib/x_especialTooltip.js"></script>

<script type="text/javascript" src="./Scripts/lib/xInfoSystem.js"></script>

<link href="./Scripts/x_info/xInfo.css" rel="stylesheet" type="text/css" />

<script type="text/javascript">
//    CCSOL.Utiles.LoadScript("./Scripts/lib/x_especialTooltip.js");
//    CCSOL.Utiles.LoadScript("./Scripts/lib/xInfoSystem.js");
    //CCSOL.Utiles.LoadCSS("./Scripts/x_info/xInfo.css");
     
    function __activateInfo()
    {
      var info = new infoSystem('holder_info', 'DivContainer', 'tt_help_info', 'tt_title', 'tt_text');       
    }    
    //xAddEventListener(window, 'load', __activateInfo, false);
	domReady(__activateInfo);
</script>

<!-- end tooltip System -->
<!-- tooltips de los selects -->

<script type="text/javascript" src="./Scripts/lib/xDropDownToolTip.js"></script>

<script type="text/javascript">    
    //CCSOL.Utiles.LoadScript("./Scripts/lib/xDropDownToolTip.js");  

    function __aDropDownInit() {
      var dropDownTitle = new xDropDownToolTip('aDropDownWithTitle', null);
    }
    //xAddEventListener(window,'load',__aDropDownInit,false);    
	domReady(__aDropDownInit);
</script>

<!-- end tooltips de los selects -->

<script type="text/javascript">
    function _keepSessionHandler(res) 
    {
      try {
        var lastTryMessage = res.value;
        //addOptions('frmDatosVehiculo_cbxModelo',res.value);
        window.status = ":: Sesi�n Renovada :: | " + lastTryMessage;
        CCSOL.DOM.xHideLoadingMessage();
      }
      catch(e) {
        alert('[ _keepSessionHandler ]: ' + e.message);
      }
    }
    function __keepAlive() {
      CCSOL.DOM.xShowLoadingMessage(':: Refrescando la Sesi�n ::');
      CarCheck.Gestores.GestorSeguridad.keepSessionAlive(_keepSessionHandler);
    }
    function __KeepSessionAlive() {
        setInterval("__keepAlive()",150000); //cada 2.5 minutos se refresca la sesi�n.
    }
    //xAddEventListener(window,'load',__KeepSessionAlive,false);    
	domReady(__KeepSessionAlive);
</script>

<script type="text/javascript">
  
  function _HideMessage() {
    $('divLoading').style.visibility = 'hidden';
  }
  xAddEventListener(window,'load',_HideMessage,true);
  
</script>

<script type="text/javascript">
	function VerAgenda()
	{
		window.open("vAgenda.aspx?action=ShowSearch&nocache=" + CCSOL.Utiles.AvoidInstantCache(),'Agenda','scrollbars=yes,resizable=yes,menubar=no,status=yes,directories=no,location=no');
	}
</script>

<table id="TableHeader" width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td width="230">
      <div class="HeaderLeft" style="position: relative;">
        <asp:Label Style="position: absolute; left: 174px; top: 10px;" ID="versionLabel"
          runat="server" Text="Versi�n 1.1" Font-Size="10px" ForeColor="Maroon" Height="8px"
          Width="85px"></asp:Label>
        <asp:Label ID="lblUserName" runat="server" Font-Bold="False" Font-Names="Arial" Font-Size="10px"
          ForeColor="Maroon" Height="9px" Style="left: 33px; position: absolute; top: 36px"
          Text="Usuario" Width="549px"></asp:Label>
        <asp:Label ID="lblCia" runat="server" Font-Bold="False" Font-Names="Arial" Font-Size="10px"
          ForeColor="Maroon" Height="8px" Style="left: 33px; position: absolute; top: 49px"
          Text="Cia" Width="571px"></asp:Label>
        <asp:Image CssClass="tt_help_info" tt_title="Datos del Usuario" tt_text="<b>Usuario</b>: "
          Style="position: absolute; left: 11px; top: 38px;" ID="userIco" runat="server"
          ImageUrl="~/Images/userico.jpg" TabIndex="45" />
      </div>
    </td>
    <td align="right" valign="top">
      <div class="HeaderRight">
      </div>
      <!-- object codeBase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0"
				height="69" width="500" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000">
				<param name="_cx" value="13229" />
				<param name="_cy" value="1826" />
				<param name="FlashVars" value="" />
				<param name="Movie" value="flash/ProcHeader.swf" />
				<param name="Src" value="flash/ProcHeader.swf" />
				<param name="WMode" value="Window" />
				<param name="Play" value="-1" />
				<param name="Loop" value="-1" />
				<param name="Quality" value="High" />
				<param name="SAlign" value="" />
				<param name="Menu" value="-1" />
				<param name="Base" value="" />
				<param name="AllowScriptAccess" value="always" />
				<param name="Scale" value="ShowAll" />
				<param name="DeviceFont" value="0" />
				<param name="EmbedMovie" value="0" />
				<param name="BGColor" value="" />
				<param name="SWRemote" value="" />
				<param name="MovieData" value="" />
				<param name="SeamlessTabbing" value="1" />
				<embed src="flash/ProcHeader.swf" quality="high" pluginspage="http://www.macromedia.com/shockwave/download/index.cgi?P1_Prod_Version=ShockwaveFlash"
					type="application/x-shockwave-flash" width="373" height="69"> </embed>
			</object -->
    </td>
  </tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0" id="TableMenuLink">
  <tr>
    <td>
      <div id="MenuLink" style="margin-right: 2px;">
        <div>
          <img id="MenuImgLeft" src="images/MainLeft.gif" alt="" />
        </div>
        <div>
          <asp:HyperLink ID="lnkListaSolicitudes" runat="server" NavigateUrl="~/vListaSolicitud.aspx"
            ToolTip="Bandeja de Solicitudes" TabIndex="1">Solicitudes</asp:HyperLink>
        </div>
        <div id="SepSolicitud" class="separador" runat="server">
        </div>
        <div>
          <asp:HyperLink ID="lnkListaInspecciones" runat="server" NavigateUrl="~/vListaInspeccion.aspx"
            ToolTip="Bandeja de Inspecciones" TabIndex="5">Inspecciones</asp:HyperLink>
        </div>
        <div id="SepInspeccion" class="separador" runat="server">
        </div>
        <div>
          <asp:HyperLink ID="lnkAgenda" runat="server" NavigateUrl="###" onclick='VerAgenda();return false'
            Style="cursor: pointer;" ToolTip="ver la Agenda de Inspecciones" TabIndex="10">Agenda</asp:HyperLink>
        </div>
        <div id="SepAgenda" class="separador" runat="server">
        </div>
        <!-- +++++++++++++++++++++++++++++++++++++++esto es lo que tengo que liberar luego de la demo
            <div>
              <asp:HyperLink ID="lnkValores" runat="server" NavigateUrl="~/vValorComercial.aspx"
                ToolTip="ver B�squeda del Valor Comercial de los Veh�culos" TabIndex="15">Valores Comerciales</asp:HyperLink></div>
            <div id="SepValores" class="separador" runat="server">
            </div>
            <div>
              <asp:HyperLink ID="lnkAmpliatorios" runat="server" NavigateUrl="~/vGetAmpliatorio.aspx"
                ToolTip="B�squeda de Ampliatorios" TabIndex="20">Ampliatorios</asp:HyperLink></div>
            <div id="SepAmpliatorios" class="separador" runat="server">
            </div>
            <div>
              <asp:HyperLink ID="lnkReportes" runat="server" NavigateUrl="~/vReporte.aspx" ToolTip="Ver Reportes"
                TabIndex="25">Reportes</asp:HyperLink></div>
            <div id="SepReportes" class="separador" runat="server">
            </div>
            <div>
              <asp:HyperLink ID="lnkEstadistica" runat="server" NavigateUrl="~/vEstadisticas.aspx"
                ToolTip="Ver Estad�sticas" TabIndex="30">Estadisticas</asp:HyperLink></div>
            <div id="SepEstadisticas" class="separador" runat="server">
            </div>
            <div>
              <asp:HyperLink ID="lnkPanelDeControl" runat="server" NavigateUrl="vPanelControl.aspx"
                ToolTip="Panel de Control" TabIndex="35">Opciones</asp:HyperLink></div>
            <div id="SepPanelControl" class="separador" runat="server">
            </div>
        <!-->
        <asp:LinkButton ID="lnkLogOut" runat="server" OnClick="logoutLinkButton_Click" ToolTip="Cerrar la Sesi�n actual"
          CausesValidation="False" TabIndex="40">Cerrar Sesi�n</asp:LinkButton>
        <div id="SepSesion" class="separador" runat="server">
        </div>
        <div style="float: right">
          <img src="images/MainRight.gif" alt="" /></div>
      </div>
    </td>
  </tr>
</table>
<div id='divLoading' class="summary" style="position: absolute; right: 10px; top: 10px;
  background-color: Red; padding: 5px; font: 12px/12px Arial,Verdana; color: #FFFFFF;
  font-weight: bold; width: auto; height: 15px">
  Cargando... espere por favor</div>
