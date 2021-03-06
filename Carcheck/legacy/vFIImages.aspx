<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vFIImages.aspx.cs" Inherits="vFIImages" %>

<%@ Register Src="ucAnularInspeccion.ascx" TagName="ucAnularInspeccion" TagPrefix="uc3" %>
<%@ Register Assembly="CustomPanelWebControl" Namespace="xWebControl" TagPrefix="cc3" %>
<%@ Register Src="ucHeader.ascx" TagName="ucHeader" TagPrefix="uc1" %>
<%@ Register Src="~/ucControlTab.ascx" TagName="ControlTab" TagPrefix="uc2" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
  <title>
    <%= CCSOL.Utiles.Utilidades.GetSystemNameAndVersion() %>
    | Inspecci�n | Im�genes</title>
  <link href="Css/layout.css" rel="stylesheet" type="text/css" />
  <link href="Css/layoutTabs.css" rel="stylesheet" type="text/css" />

  <script type="text/javascript" src="Scripts/lib/x.js"></script>

  <script type="text/javascript" src="Scripts/lib/x_common.js"></script>

  <script type="text/javascript" src="Scripts/lib/xDomReady.js"></script>

  <script type="text/javascript" src="Scripts/lib/xDropDownMenu.js"></script>

  <script type="text/javascript">
    
    function pickImages() {
      if (ventana == null) {
		    ventana = new xPopUp(1,'loading.html',true);
		   
		  }
		   ventana.OnHide = function (v) {
		      doRefresh();		      
		    }
		  ventana.showPopUpModal('./control/vMantenimientoImagenes.aspx?noCache='+ CCSOL.Utiles.AvoidInstantCache() +'&VehiculoId=<%=Request.QueryString["VehiculoId"]%>',630,436);
		  xPreventDefault(e);
    }
    
		function closePopUp() {
		  if (ventana != null)  {
		    ventana.OnHide= function (v) {
		      doRefresh();
		    }
		    ventana.hide();
		    //doRefresh();
		  }
		}
		function UploadImagen(VehiculoId){
		  if (ventana == null) {
		    ventana = new xPopUp(1,'loading.html',true);		   
		  }
		   ventana.OnHide = function (v) {
		      doRefresh();	      
		    }
		  ventana.showPopUpModal('vUploadFile.aspx?noCache='+ CCSOL.Utiles.AvoidInstantCache() +'&VehiculoId='+VehiculoId,685,375);
		  xPreventDefault(e);
		}

		function runProgram() {
		  CCSOL.DOM.xLockBackground();
		  CCSOL.DOM.xShowLoadingMessage('Lanzando Aplicaci�n');
		  var couldRun = CCSOL.Utiles.RunProgram("fileUploader.exe",'<%=getProgramParameters() %>');
		  //la segunda cadena que se le pasa al fileUploader debe reemplazarse
		  CCSOL.DOM.xHideLoadingMessage();
		  CCSOL.DOM.xUnLockBackground();
		  
		  if (!couldRun) {
		    UploadImagen(<%= Request.QueryString["VehiculoId"] %>);
		  }      		  
		  doRefresh();
		  xPreventDefault(e);
		  return false;
		}


		function doRefresh()
		{
		  var context;
		  var arg;
		  CCSOL.DOM.xShowLoadingMessage();
		  <%=ClientScript.GetCallbackEventReference(this.cckhandler, "arg", "doCallback_Refresh", "context", "HandleError", false) %>;
		}

		function doCallback_Refresh(result, context)
		{
		  CCSOL.DOM.xHideLoadingMessage();
		  
		  
		  var linea=new String(result);
		  var lista = linea.split("$$$$_$$$$");
		  
		  
		  
		  $('exteriorData').innerHTML = lista[0];
		  $('interiorData').innerHTML = lista[1];
		  $('improntaData').innerHTML = lista[2];
		  $('damageData').innerHTML = lista[3];
		  $('documentosData').innerHTML = lista[4];
		  $('otrosData').innerHTML = lista[5];
		  
		  
		  destroyOldTooltips();
		  createToolTips();
		  setPanelsWidth();
		}

		function HandleError(message)
		{
		  CCSOL.DOM.xHideLoadingMessage();
		  alert("[Error] : " + message);
		}


		function VerImagen(ImagenId,VehiculoId){
  
		 var WinWidth = 790;
		 var WinHeight = 440;
		 var Xpos = (screen.width/2) - (WinWidth/2);
		 var Ypos = (screen.height/2) - (WinHeight/2);
		 window.open('vVerImagen.aspx?ImagenId='+ImagenId+'&VehiculoId='+VehiculoId,'','width='+WinWidth+',height='+WinHeight+', left='+Xpos+', top='+Ypos+',scrollbars=1,resizable=1,menubar=no,status=yes,directories=no,location=no');
		 
		 xPreventDefault(e);
		}

		function onToolTipDisplay(e) {
		  var xE = new xEvent(e);
		  $('imageTitulo').innerText = '';
		  $('imageObservacion').innerText = '';
		  var imageTittle = CCSOL.DOM.x_GetAttribute(xE.target,'titulo');
		  $('imageTitulo').innerText = imageTittle;
		  
		  var imageObservacionText = CCSOL.DOM.x_GetAttribute(xE.target,'observacion');
		  $('imageObservacion').innerText = imageObservacionText;
		}

		function destroyOldTooltips() {
			if (t1 != null) t1.unload();
			if (t2 != null) t2.unload();
			if (t3 != null) t3.unload();
			if (t4 != null) t4.unload();
			if (t5 != null) t5.unload();
			if (t6 != null) t6.unload();
		}
		function createToolTips() {
		  t1 = new x_ToolTip('img','exteriorData',10,10,'imagenToolTip',onToolTipDisplay);
		  t2 = new x_ToolTip('img','damageData',10,10,'imagenToolTip',onToolTipDisplay);
		  t3 = new x_ToolTip('img','interiorData',10,10,'imagenToolTip',onToolTipDisplay);
		  t4 = new x_ToolTip('img','improntaData',10,10,'imagenToolTip',onToolTipDisplay);
		  t5 = new x_ToolTip('img','otrosData',10,10,'imagenToolTip',onToolTipDisplay);
		  t6 = new x_ToolTip('img','documentosData',10,10,'imagenToolTip',onToolTipDisplay);
		}


		var t1 = null;
		var t2 = null;
		var t3 = null;
		var t4 = null;
		var t5 = null;
		var t6 = null;
	
		domReady(function() {
		  try {
		    exteriorCollapsible   = new CollapsibleDiv('exteriorImage', 'exteriorDataPanel', null, null);
		    exteriorLabCollapsible= new CollapsibleDiv('exteriorLabel', 'exteriorDataPanel', null, null);
		    interiorCollapsible   = new CollapsibleDiv('interiorImage', 'interiorDataPanel', null, null);
		    interiorLabCollapsible= new CollapsibleDiv('interiorLabel', 'interiorDataPanel', null, null);
		    improntaCollapsible   = new CollapsibleDiv('improntaImage', 'improntaDataPanel', null, null);
		    improntaLabCollapsible= new CollapsibleDiv('improntaLabel', 'improntaDataPanel', null, null);
		    danosCollapsible      = new CollapsibleDiv('damageImage', 'damageDataPanel', null, null);
		    danosLabCollapsible   = new CollapsibleDiv('damageLabel', 'damageDataPanel', null, null);
		    documentCollapsible   = new CollapsibleDiv('documentosImage', 'documentosDataPanel', null, null);
		    documentLabCollapsible= new CollapsibleDiv('documentosLabel', 'documentosDataPanel', null, null);
		    otrosCollapsible      = new CollapsibleDiv('otrosImage', 'otrosDataPanel', null, null);
		    otrosLabCollapsible   = new CollapsibleDiv('otrosLabel', 'otrosDataPanel', null, null);
		    
				//creamos los tooltips que se mostrar�n al pasar por encima de los im�genes, dado que el contenido se refresca habr� que hacerlo 
		    createToolTips();
				
		    //creamos el objeto que mostrar� la ventana xPopUp necesaria para la carga individual de im�genes al fallar el lanzamiento de la aplicaci�n de carga masiva
//		    ventana = new xPopUp(1,'loading.html');
//		       
		    
		  }
		  catch (e){
		    alert(e.message);
		  }
		});
		
		function setPanelsWidth() {
		    setImagePanelWidth('exteriorData');
		    setImagePanelWidth('interiorData');
		    setImagePanelWidth('improntaData');
		    setImagePanelWidth('damageData');
		    setImagePanelWidth('documentosData');
		    setImagePanelWidth('otrosData');
		}
		
		function setImagePanelWidth(panelId) {
		  var arr = xGetElementsByTagName('IMG',$(panelId));
		  if (arr != null) {
		    var pwidth = arr.length * 103;
		    $(panelId).style.width = pwidth + 'px';
		  }
		  
		}
  </script>

  <link href="Css/layoutTabs.css" rel="stylesheet" type="text/css" />
  <link href="css/layout.css" rel="stylesheet" type="text/css" />
  <link href="./Scripts/x_info/xInfo.css" rel="stylesheet" type="text/css" />
  <link href="css/layout.css" rel="stylesheet" type="text/css" />
  <link href="./Scripts/x_info/xInfo.css" rel="stylesheet" type="text/css" />
</head>
<body>
  <form id="form1" runat="server">
    <div class="Blockable">
      <table id="Data" border="0" cellpadding="0" cellspacing="0" align="center">
        <tr>
          <td>
            <uc1:ucHeader ID="UcHeader1" runat="server" PageFunctionalityToCheck="INS_IMAGENES_VER" />
            <uc2:ControlTab ID="ControlTab1" runat="server" LabelText="Inspecci�n: INS - 001 - XXX"
              TabActual="Imagenes" />
            <div class="DataContent">
              <div class="DataContentRight" style="padding-top: 1px">
                <div class="PanelStyle" style="margin-top: 8px;">
                  <div class="PanelEncabezado">
                    <asp:Label ID="exteriorLabel" runat="server" Style="cursor: default" Text="Exterior Veh�culo"
                      ToolTip="Mostrar / Ocultar Panel"></asp:Label>
                    <img id="exteriorImage" alt="Mostrar / Ocultar Panel" src="Images/IconHide16Dark.gif" /></div>
                  <div class="PanelInset" id="exteriorDataPanel" style="overflow: auto; width: 960px;
                    height: 100px;">
                    <div id="exteriorData">
                      <asp:Repeater ID="repaterExterior" runat="server" DataSourceID="odsImagesExterior">
                        <ItemTemplate>
                          <img id="Image_<%#DataBinder.Eval(Container.DataItem, "imagenId")%>" src="vGetImage.aspx?VehiculoId=<%#DataBinder.Eval(Container.DataItem, "vehiculoId")%>&ImagenId=<%#DataBinder.Eval(Container.DataItem, "imagenId")%>"
                            class="thumbs" onclick="VerImagen(<%#DataBinder.Eval(Container.DataItem, "imagenId")%>,<%#DataBinder.Eval(Container.DataItem, "vehiculoId")%>);"
                            titulo="<%#DataBinder.Eval(Container.DataItem, "titulo")%>" observacion="<%#DataBinder.Eval(Container.DataItem, "observacion")%>" />
                        </ItemTemplate>
                      </asp:Repeater>
                      <asp:ObjectDataSource ID="odsImagesExterior" runat="server" DeleteMethod="Delete"
                        InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData"
                        TypeName="dsImagesTableAdapters.ImagenTableAdapter" UpdateMethod="Update">
                        <DeleteParameters>
                          <asp:Parameter Name="imagenId" Type="Int32" />
                          <asp:Parameter Name="vehiculoId" Type="Decimal" />
                          <asp:Parameter Name="uupdate" Type="String" />
                        </DeleteParameters>
                        <UpdateParameters>
                          <asp:Parameter Name="vehiculoId" Type="Decimal" />
                          <asp:Parameter Name="imagenId" Type="Int32" />
                          <asp:Parameter Name="imagenCorrespondenciaId" Type="String" />
                          <asp:Parameter Name="titulo" Type="String" />
                          <asp:Parameter Name="observacion" Type="String" />
                          <asp:Parameter Name="uupdate" Type="String" />
                          <asp:Parameter Name="pc" Type="String" />
                          <asp:Parameter Name="incluirEnInforme" Type="Boolean" />
                        </UpdateParameters>
                        <SelectParameters>
                          <asp:QueryStringParameter Name="vehiculoId" QueryStringField="VehiculoId" Type="Decimal" />
                          <asp:Parameter DefaultValue="EXTERIOR" Name="imagenCorrespondenciaId" Type="String" />
                        </SelectParameters>
                        <InsertParameters>
                          <asp:Parameter Name="vehiculoId" Type="Decimal" />
                          <asp:Parameter Direction="InputOutput" Name="imagenId" Type="Object" />
                          <asp:Parameter Name="imagenCorrespondenciaId" Type="String" />
                          <asp:Parameter Name="titulo" Type="String" />
                          <asp:Parameter Name="observacion" Type="String" />
                          <asp:Parameter Name="imagen" Type="Object" />
                          <asp:Parameter Name="ucrea" Type="String" />
                          <asp:Parameter Name="pc" Type="String" />
                          <asp:Parameter Name="thumbnail" Type="Object" />
                          <asp:Parameter Name="incluirEnInforme" Type="Boolean" />
                        </InsertParameters>
                      </asp:ObjectDataSource>
                    </div>
                  </div>
                </div>
                <div class="PanelStyle">
                  <div class="PanelEncabezado">
                    <asp:Label ID="interiorLabel" runat="server" Style="cursor: default" Text="Interior Veh�culo"
                      ToolTip="Mostrar / Ocultar Panel"></asp:Label>
                    <img id="interiorImage" alt="Mostrar / Ocultar Panel" src="Images/IconHide16Dark.gif" /></div>
                  <div id='interiorDataPanel' class="PanelInset" style="overflow: auto; width: 960px;
                    height: 100px; display: none;">
                    <div id="interiorData">
                      <asp:Repeater ID="repeaterInterior" runat="server" DataSourceID="odsImagesInterior">
                        <ItemTemplate>
                          <img id="Image_<%#DataBinder.Eval(Container.DataItem, "imagenId")%>" src="vGetImage.aspx?VehiculoId=<%#DataBinder.Eval(Container.DataItem, "vehiculoId")%>&ImagenId=<%#DataBinder.Eval(Container.DataItem, "imagenId")%>"
                            class="thumbs" onclick="VerImagen(<%#DataBinder.Eval(Container.DataItem, "imagenId")%>,<%#DataBinder.Eval(Container.DataItem, "vehiculoId")%>);"
                            titulo="<%#DataBinder.Eval(Container.DataItem, "titulo")%>" observacion="<%#DataBinder.Eval(Container.DataItem, "observacion")%>" />
                        </ItemTemplate>
                      </asp:Repeater>
                      <asp:ObjectDataSource ID="odsImagesInterior" runat="server" DeleteMethod="Delete"
                        InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData"
                        TypeName="dsImagesTableAdapters.ImagenTableAdapter" UpdateMethod="Update">
                        <DeleteParameters>
                          <asp:Parameter Name="imagenId" Type="Int32" />
                          <asp:Parameter Name="vehiculoId" Type="Decimal" />
                          <asp:Parameter Name="uupdate" Type="String" />
                        </DeleteParameters>
                        <UpdateParameters>
                          <asp:Parameter Name="vehiculoId" Type="Decimal" />
                          <asp:Parameter Name="imagenId" Type="Int32" />
                          <asp:Parameter Name="imagenCorrespondenciaId" Type="String" />
                          <asp:Parameter Name="titulo" Type="String" />
                          <asp:Parameter Name="observacion" Type="String" />
                          <asp:Parameter Name="uupdate" Type="String" />
                          <asp:Parameter Name="pc" Type="String" />
                          <asp:Parameter Name="incluirEnInforme" Type="Boolean" />
                        </UpdateParameters>
                        <SelectParameters>
                          <asp:QueryStringParameter Name="vehiculoId" QueryStringField="VehiculoId" Type="Decimal" />
                          <asp:Parameter DefaultValue="INTERIOR" Name="imagenCorrespondenciaId" Type="String" />
                        </SelectParameters>
                        <InsertParameters>
                          <asp:Parameter Name="vehiculoId" Type="Decimal" />
                          <asp:Parameter Direction="InputOutput" Name="imagenId" Type="Object" />
                          <asp:Parameter Name="imagenCorrespondenciaId" Type="String" />
                          <asp:Parameter Name="titulo" Type="String" />
                          <asp:Parameter Name="observacion" Type="String" />
                          <asp:Parameter Name="imagen" Type="Object" />
                          <asp:Parameter Name="ucrea" Type="String" />
                          <asp:Parameter Name="pc" Type="String" />
                          <asp:Parameter Name="thumbnail" Type="Object" />
                          <asp:Parameter Name="incluirEnInforme" Type="Boolean" />
                        </InsertParameters>
                      </asp:ObjectDataSource>
                    </div>
                  </div>
                </div>
                <div class="PanelStyle">
                  <div class="PanelEncabezado">
                    <asp:Label ID="improntaLabel" runat="server" Style="cursor: default" Text="Impronta"
                      ToolTip="Mostrar / Ocultar Panel"></asp:Label>
                    <img id="improntaImage" alt="Mostrar / Ocultar Panel" src="Images/IconHide16Dark.gif" /></div>
                  <div id='improntaDataPanel' class="PanelInset" style="overflow: auto; width: 960px;
                    height: 100px; display: none;">
                    <div id="improntaData">
                      <asp:Repeater ID="repeaterImpronta" runat="server" DataSourceID="odsImpronta">
                        <ItemTemplate>
                          <img id="Image_<%#DataBinder.Eval(Container.DataItem, "imagenId")%>" src="vGetImage.aspx?VehiculoId=<%#DataBinder.Eval(Container.DataItem, "vehiculoId")%>&ImagenId=<%#DataBinder.Eval(Container.DataItem, "imagenId")%>"
                            class="thumbs" onclick="VerImagen(<%#DataBinder.Eval(Container.DataItem, "imagenId")%>,<%#DataBinder.Eval(Container.DataItem, "vehiculoId")%>);"
                            titulo="<%#DataBinder.Eval(Container.DataItem, "titulo")%>" observacion="<%#DataBinder.Eval(Container.DataItem, "observacion")%>" />
                        </ItemTemplate>
                      </asp:Repeater>
                      <asp:ObjectDataSource ID="odsImpronta" runat="server" DeleteMethod="Delete" InsertMethod="Insert"
                        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsImagesTableAdapters.ImagenTableAdapter"
                        UpdateMethod="Update">
                        <DeleteParameters>
                          <asp:Parameter Name="imagenId" Type="Int32" />
                          <asp:Parameter Name="vehiculoId" Type="Decimal" />
                          <asp:Parameter Name="uupdate" Type="String" />
                        </DeleteParameters>
                        <UpdateParameters>
                          <asp:Parameter Name="vehiculoId" Type="Decimal" />
                          <asp:Parameter Name="imagenId" Type="Int32" />
                          <asp:Parameter Name="imagenCorrespondenciaId" Type="String" />
                          <asp:Parameter Name="titulo" Type="String" />
                          <asp:Parameter Name="observacion" Type="String" />
                          <asp:Parameter Name="uupdate" Type="String" />
                          <asp:Parameter Name="pc" Type="String" />
                          <asp:Parameter Name="incluirEnInforme" Type="Boolean" />
                        </UpdateParameters>
                        <SelectParameters>
                          <asp:QueryStringParameter Name="vehiculoId" QueryStringField="VehiculoId" Type="Decimal" />
                          <asp:Parameter DefaultValue="IMPRONTA" Name="imagenCorrespondenciaId" Type="String" />
                        </SelectParameters>
                        <InsertParameters>
                          <asp:Parameter Name="vehiculoId" Type="Decimal" />
                          <asp:Parameter Direction="InputOutput" Name="imagenId" Type="Object" />
                          <asp:Parameter Name="imagenCorrespondenciaId" Type="String" />
                          <asp:Parameter Name="titulo" Type="String" />
                          <asp:Parameter Name="observacion" Type="String" />
                          <asp:Parameter Name="imagen" Type="Object" />
                          <asp:Parameter Name="ucrea" Type="String" />
                          <asp:Parameter Name="pc" Type="String" />
                          <asp:Parameter Name="thumbnail" Type="Object" />
                          <asp:Parameter Name="incluirEnInforme" Type="Boolean" />
                        </InsertParameters>
                      </asp:ObjectDataSource>
                    </div>
                  </div>
                </div>
                <div class="PanelStyle">
                  <div class="PanelEncabezado">
                    <asp:Label ID="damageLabel" runat="server" Style="cursor: default" Text="Da�os" ToolTip="Mostrar / Ocultar Panel"></asp:Label>
                    <img id="damageImage" alt="Mostrar / Ocultar Panel" src="Images/IconHide16Dark.gif" /></div>
                  <div id='damageDataPanel' class="PanelInset" style="overflow: auto; width: 960px;
                    height: 100px; display: none;">
                    <div id="damageData">
                      <asp:Repeater ID="repeaterDamage" runat="server" DataSourceID="odsDamage">
                        <ItemTemplate>
                          <img alt="<%#DataBinder.Eval(Container.DataItem, "titulo")%>" id="Image_<%#DataBinder.Eval(Container.DataItem, "imagenId")%>"
                            src="vGetImage.aspx?VehiculoId=<%#DataBinder.Eval(Container.DataItem, "vehiculoId")%>&ImagenId=<%#DataBinder.Eval(Container.DataItem, "imagenId")%>"
                            class="thumbs" onclick="VerImagen(<%#DataBinder.Eval(Container.DataItem, "imagenId")%>,<%#DataBinder.Eval(Container.DataItem, "vehiculoId")%>);"
                            titulo="<%#DataBinder.Eval(Container.DataItem, "titulo")%>" observacion="<%#encondeString(DataBinder.Eval(Container.DataItem, "observacion"))%>" />
                        </ItemTemplate>
                      </asp:Repeater>
                      <asp:ObjectDataSource ID="odsDamage" runat="server" DeleteMethod="Delete" InsertMethod="Insert"
                        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsImagesTableAdapters.ImagenTableAdapter"
                        UpdateMethod="Update">
                        <DeleteParameters>
                          <asp:Parameter Name="imagenId" Type="Int32" />
                          <asp:Parameter Name="vehiculoId" Type="Decimal" />
                          <asp:Parameter Name="uupdate" Type="String" />
                        </DeleteParameters>
                        <UpdateParameters>
                          <asp:Parameter Name="vehiculoId" Type="Decimal" />
                          <asp:Parameter Name="imagenId" Type="Int32" />
                          <asp:Parameter Name="imagenCorrespondenciaId" Type="String" />
                          <asp:Parameter Name="titulo" Type="String" />
                          <asp:Parameter Name="observacion" Type="String" />
                          <asp:Parameter Name="uupdate" Type="String" />
                          <asp:Parameter Name="pc" Type="String" />
                          <asp:Parameter Name="incluirEnInforme" Type="Boolean" />
                        </UpdateParameters>
                        <SelectParameters>
                          <asp:QueryStringParameter Name="vehiculoId" QueryStringField="VehiculoId" Type="Decimal" />
                          <asp:Parameter DefaultValue="DAMAGE" Name="imagenCorrespondenciaId" Type="String" />
                        </SelectParameters>
                        <InsertParameters>
                          <asp:Parameter Name="vehiculoId" Type="Decimal" />
                          <asp:Parameter Direction="InputOutput" Name="imagenId" Type="Object" />
                          <asp:Parameter Name="imagenCorrespondenciaId" Type="String" />
                          <asp:Parameter Name="titulo" Type="String" />
                          <asp:Parameter Name="observacion" Type="String" />
                          <asp:Parameter Name="imagen" Type="Object" />
                          <asp:Parameter Name="ucrea" Type="String" />
                          <asp:Parameter Name="pc" Type="String" />
                          <asp:Parameter Name="thumbnail" Type="Object" />
                          <asp:Parameter Name="incluirEnInforme" Type="Boolean" />
                        </InsertParameters>
                      </asp:ObjectDataSource>
                    </div>
                  </div>
                </div>
                <div class="PanelStyle">
                  <div class="PanelEncabezado">
                    <asp:Label ID="documentosLabel" runat="server" Style="cursor: default" Text="Documentos"
                      ToolTip="Mostrar / Ocultar Panel"></asp:Label>
                    <img id="documentosImage" alt="Mostrar / Ocultar Panel" src="Images/IconHide16Dark.gif" /></div>
                  <div id='documentosDataPanel' class="PanelInset" style="overflow: auto; width: 960px;
                    height: 100px; display: none;">
                    <div id="documentosData">
                      <asp:Repeater ID="repeaterDocumentos" runat="server" DataSourceID="odsDocumentos">
                        <ItemTemplate>
                          <img id="Image_<%#DataBinder.Eval(Container.DataItem, "imagenId")%>" src="vGetImage.aspx?VehiculoId=<%#DataBinder.Eval(Container.DataItem, "vehiculoId")%>&ImagenId=<%#DataBinder.Eval(Container.DataItem, "imagenId")%>"
                            class="thumbs" onclick="VerImagen(<%#DataBinder.Eval(Container.DataItem, "imagenId")%>,<%#DataBinder.Eval(Container.DataItem, "vehiculoId")%>);"
                            titulo="<%#DataBinder.Eval(Container.DataItem, "titulo")%>" observacion="<%#DataBinder.Eval(Container.DataItem, "observacion")%>" />
                        </ItemTemplate>
                      </asp:Repeater>
                      <asp:ObjectDataSource ID="odsDocumentos" runat="server" DeleteMethod="Delete" InsertMethod="Insert"
                        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsImagesTableAdapters.ImagenTableAdapter"
                        UpdateMethod="Update">
                        <DeleteParameters>
                          <asp:Parameter Name="imagenId" Type="Int32" />
                          <asp:Parameter Name="vehiculoId" Type="Decimal" />
                          <asp:Parameter Name="uupdate" Type="String" />
                        </DeleteParameters>
                        <UpdateParameters>
                          <asp:Parameter Name="vehiculoId" Type="Decimal" />
                          <asp:Parameter Name="imagenId" Type="Int32" />
                          <asp:Parameter Name="imagenCorrespondenciaId" Type="String" />
                          <asp:Parameter Name="titulo" Type="String" />
                          <asp:Parameter Name="observacion" Type="String" />
                          <asp:Parameter Name="uupdate" Type="String" />
                          <asp:Parameter Name="pc" Type="String" />
                          <asp:Parameter Name="incluirEnInforme" Type="Boolean" />
                        </UpdateParameters>
                        <SelectParameters>
                          <asp:QueryStringParameter Name="vehiculoId" QueryStringField="VehiculoId" Type="Decimal" />
                          <asp:Parameter DefaultValue="DOCUMENTOS" Name="imagenCorrespondenciaId" Type="String" />
                        </SelectParameters>
                        <InsertParameters>
                          <asp:Parameter Name="vehiculoId" Type="Decimal" />
                          <asp:Parameter Direction="InputOutput" Name="imagenId" Type="Object" />
                          <asp:Parameter Name="imagenCorrespondenciaId" Type="String" />
                          <asp:Parameter Name="titulo" Type="String" />
                          <asp:Parameter Name="observacion" Type="String" />
                          <asp:Parameter Name="imagen" Type="Object" />
                          <asp:Parameter Name="ucrea" Type="String" />
                          <asp:Parameter Name="pc" Type="String" />
                          <asp:Parameter Name="thumbnail" Type="Object" />
                          <asp:Parameter Name="incluirEnInforme" Type="Boolean" />
                        </InsertParameters>
                      </asp:ObjectDataSource>
                    </div>
                  </div>
                </div>
                <div class="PanelStyle">
                  <div class="PanelEncabezado">
                    <asp:Label ID="otrosLabel" runat="server" Style="cursor: default" Text="Otros" ToolTip="Mostrar / Ocultar Panel"></asp:Label>
                    <img id="otrosImage" alt="Mostrar / Ocultar Panel" src="Images/IconHide16Dark.gif" /></div>
                  <div id='otrosDataPanel' class="PanelInset" style="overflow: auto; width: 960px;
                    height: 100px; display: none;">
                    <div id="otrosData">
                      <asp:Repeater ID="repeaterOtros" runat="server" DataSourceID="odsOtros">
                        <ItemTemplate>
                          <img id="Image_<%#DataBinder.Eval(Container.DataItem, "imagenId")%>" src="vGetImage.aspx?VehiculoId=<%#DataBinder.Eval(Container.DataItem, "vehiculoId")%>&ImagenId=<%#DataBinder.Eval(Container.DataItem, "imagenId")%>"
                            class="thumbs" onclick="VerImagen(<%#DataBinder.Eval(Container.DataItem, "imagenId")%>,<%#DataBinder.Eval(Container.DataItem, "vehiculoId")%>);"
                            titulo="<%#DataBinder.Eval(Container.DataItem, "titulo")%>" observacion="<%#DataBinder.Eval(Container.DataItem, "observacion")%>" />
                        </ItemTemplate>
                      </asp:Repeater>
                      <asp:ObjectDataSource ID="odsOtros" runat="server" DeleteMethod="Delete" InsertMethod="Insert"
                        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsImagesTableAdapters.ImagenTableAdapter"
                        UpdateMethod="Update">
                        <DeleteParameters>
                          <asp:Parameter Name="imagenId" Type="Int32" />
                          <asp:Parameter Name="vehiculoId" Type="Decimal" />
                          <asp:Parameter Name="uupdate" Type="String" />
                        </DeleteParameters>
                        <UpdateParameters>
                          <asp:Parameter Name="vehiculoId" Type="Decimal" />
                          <asp:Parameter Name="imagenId" Type="Int32" />
                          <asp:Parameter Name="imagenCorrespondenciaId" Type="String" />
                          <asp:Parameter Name="titulo" Type="String" />
                          <asp:Parameter Name="observacion" Type="String" />
                          <asp:Parameter Name="uupdate" Type="String" />
                          <asp:Parameter Name="pc" Type="String" />
                          <asp:Parameter Name="incluirEnInforme" Type="Boolean" />
                        </UpdateParameters>
                        <SelectParameters>
                          <asp:QueryStringParameter Name="vehiculoId" QueryStringField="VehiculoId" Type="Decimal" />
                          <asp:Parameter DefaultValue="OTROS" Name="imagenCorrespondenciaId" Type="String" />
                        </SelectParameters>
                        <InsertParameters>
                          <asp:Parameter Name="vehiculoId" Type="Decimal" />
                          <asp:Parameter Direction="InputOutput" Name="imagenId" Type="Object" />
                          <asp:Parameter Name="imagenCorrespondenciaId" Type="String" />
                          <asp:Parameter Name="titulo" Type="String" />
                          <asp:Parameter Name="observacion" Type="String" />
                          <asp:Parameter Name="imagen" Type="Object" />
                          <asp:Parameter Name="ucrea" Type="String" />
                          <asp:Parameter Name="pc" Type="String" />
                          <asp:Parameter Name="thumbnail" Type="Object" />
                          <asp:Parameter Name="incluirEnInforme" Type="Boolean" />
                        </InsertParameters>
                      </asp:ObjectDataSource>
                    </div>
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
            <div id="controlPanel" >
              <div class="DataTop">
                <div class="DataTopLeft">
                </div>
                <div class="DataTopRight">
                </div>
              </div>
              <div class="DataContent">
                <div class="DataContentRight" style="">
                  <div style="float: left">
                    <cc3:xWebPanelControl ID="XWebPanelControl7" Style="display: inline;" runat="server"
                      PermissionToCheck="INS_SUBIR_IMAGENES">
                      <asp:ImageButton ID="fotoImageButton" runat="server" ImageUrl="~/Images/IconProcPhoto.jpg"
                        ToolTip="Cargar Im�genes" CssClass="MakeClear" OnClientClick="return runProgram();return false;" />
                    </cc3:xWebPanelControl><cc3:xWebPanelControl ID="XWebPanelControl1" Style="display: inline;" runat="server"
                      PermissionToCheck="INS_ELEGIR_IMAGENES_INFORME">
                      <asp:ImageButton ID="imgBtnPickImageBtn" runat="server" ImageUrl="~/Images/PickImagesIco.jpg"
                        ToolTip="Escoger Im�genes para Informe" CssClass="MakeClear" OnClientClick="pickImages();return false;" />
                    </cc3:xWebPanelControl>
                    <cc3:xWebPanelControl ID="XWebPanelControl2" Style="display: inline;" runat="server"
                      PermissionToCheck="INS_ANULAR">
                      <asp:ImageButton MenuDropDownType="anular" doShow="show" ID="anularImageButton" OnClientClick='return false;'
                        runat="server" ImageUrl="~/Images/IconAnul48Dark.jpg" ToolTip="Anular Inspecci�n"
                        CssClass="MakeClear" />
                    </cc3:xWebPanelControl>
                  </div>
                  <div style="float: right; position: relative;">
                    <cc3:xWebPanelControl Style="display: inline;" ID="XWebPanelControl3" runat="server"
                      PermissionToCheck="INS_PREVIEW">
                      <asp:ImageButton ID="btnVistaPrevia" runat="server" ImageUrl="~/Images/btnPrevisualizar.jpg"
                        ToolTip="Preview Inspecci�n" CssClass="MakeClear" OnClientClick="doPreview(); return false;" />
                    </cc3:xWebPanelControl>
                    <cc3:xWebPanelControl Style="display: inline;" ID="XWebPanelControl4" runat="server"
                      PermissionToCheck="INS_TERMINAR">
                      <asp:ImageButton ID="imgTerminarInspeccion" runat="server" ImageUrl="~/Images/btnTerminarInspeccion.jpg"
                        ToolTip="Terminar Inspecci�n" CssClass="MakeClear" OnClick="ImageButton1_Click" />
                    </cc3:xWebPanelControl>
                    <cc3:xWebPanelControl Style="display: inline;" ID="XWebPanelControl5" runat="server"
                      PermissionToCheck="INS_APROBAR">
                      <asp:ImageButton ID="aprobarImageButton" OnClientClick='GenerateInform(0);return false;'
                        runat="server" ImageUrl="~/Images/IconApprove48.jpg" ToolTip="Aprobar Inspecci�n"
                        CssClass="MakeClear" />
                    </cc3:xWebPanelControl>
                    <cc3:xWebPanelControl Style="display: inline;" ID="XWebPanelControl6" runat="server"
                      PermissionToCheck="INS_APROBAR">
                      <asp:ImageButton ID="desaprobarImageButton" runat="server" ImageUrl="~/Images/IconReject48.jpg"
                        ToolTip="Aprobar Inspecci�n sin pago a ajustador" CssClass="MakeClear" OnClientClick="GenerateInform(1);return false;" />
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
    <br />
    <div id="imagenToolTip" class="ToolTip" style="left: 0px; top: -15px">
      <h5 id="imageTitulo">
        This is a holder for a value
      </h5>
      <p id='imageObservacion' style="text-align: left;">
        This div is supposed to be floating all over the page, where you pass your mouse
        over a image on a link tag ('a')</p>
    </div>
    <uc3:ucAnularInspeccion ID="UcAnularInspeccion1" runat="server" TriggerId="anularImageButton" />
  </form>

  <script type="text/javascript">
    setPanelsWidth();		
  </script>

</body>
</html>
