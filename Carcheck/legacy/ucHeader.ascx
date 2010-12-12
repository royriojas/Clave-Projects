<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ucHeader.ascx.cs" Inherits="ucHeader" %>
<link href="css/layout.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="Scripts/functions.js"></script>
<script type="text/javascript" src="Scripts/lib/x.js"></script>
<script type="text/javascript">
	function VerAgenda()
	{
		window.open("vAgenda.aspx",'Agenda','scrollbars=yes,resizable=yes,menubar=no,status=yes,directories=no,location=no');
	}
</script>
<table id="TableHeader" width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td width="230">
      <div class="HeaderLeft">
        <br />
        <br />
        <br />
        <br />
        <asp:Label ID="versionLabel" runat="server" Text="Versión 1.1" Font-Size="10px"></asp:Label>
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
        <div><img id="MenuImgLeft" src="images/MainLeft.gif" alt="" /></div>
        <div><asp:HyperLink ID="lnkListaSolicitudes" runat="server" NavigateUrl="~/vListaSolicitud.aspx" ToolTip="Bandeja de Solicitudes">Solicitudes</asp:HyperLink></div>
        <div id="SepSolicitud" class="separador" runat="server"></div>                                
        <div><asp:HyperLink ID="lnkListaInspecciones" runat="server" NavigateUrl="~/vListaInspeccion.aspx" ToolTip="Bandeja de Inspecciones">Inspecciones</asp:HyperLink></div>
        <div id="SepInspeccion" class="separador" runat="server"></div>
        <div><asp:HyperLink ID="lnkAgenda" runat="server" NavigateUrl="###" onclick='VerAgenda();return false' style="cursor:pointer;" ToolTip="ver la Agenda de Inspecciones">Agenda</asp:HyperLink></div>
        <div id="SepAgenda" class="separador" runat="server"></div>
        
        <div><asp:HyperLink ID="lnkValores" runat="server" NavigateUrl="~/vValorComercial.aspx" ToolTip="ver Búsqueda del Valor Comercial de los Vehículos">Valores Comerciales</asp:HyperLink></div>
        <div id="SepValores" class="separador" runat="server"></div>
        
        <div><asp:HyperLink ID="lnkReportes" runat="server" NavigateUrl="~/vReporte.aspx" ToolTip="Ver Reportes">Reportes</asp:HyperLink></div>
        <div id="SepReportes" class="separador" runat="server"></div>
        <div><asp:HyperLink ID="lnkEstadistica" runat="server" NavigateUrl="~/vEstadisticas.aspx" ToolTip="Ver Estadísticas">Estadisticas</asp:HyperLink></div>
        <div id="SepEstadisticas" class="separador" runat="server"></div>
        <div><asp:HyperLink ID="lnkPanelDeControl" runat="server" NavigateUrl="vPanelControl.aspx" ToolTip="Panel de Control">Opciones</asp:HyperLink></div>
        <div id="SepPanelControl" class="separador" runat="server"></div>
        <asp:LinkButton ID="lnkLogOut" runat="server" OnClick="logoutLinkButton_Click" ToolTip="Cerrar la Sesión actual" CausesValidation="False">Cerrar Sesión</asp:LinkButton>
        <div id="SepSesion" class="separador" runat="server"></div>
        <div style="float: right"><img src="images/MainRight.gif" alt="" /></div>
      </div>
    </td>
  </tr>
</table>
