<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vAgenda.aspx.cs" Inherits="vAgenda" %>

<%@ Register Assembly="schedule2" Namespace="rw" TagPrefix="rw" %>
<%@ Register Assembly="AutoSuggestBox" Namespace="ASB" TagPrefix="cc1" %>
<%@ Register Assembly="WebCalendarControl" Namespace="WebCalendarControl" TagPrefix="cc2" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
  <title>CarCheck / Agenda</title>
  <link href="Scripts/xCommon/xCommon.css" type="text/css" rel="Stylesheet" />

  <script type="text/javascript" src="Scripts/lib/x.js"></script>

  <script type="text/javascript" src="Scripts/lib/x_common.js"></script>

  <script type="text/javascript" src="Scripts/functions.js"></script>

  <script type="text/javascript" src="Scripts/lib/x_checkAll.js"></script>

  <script type="text/javascript" src="Scripts/lib/xpopup.js"></script>

  <script type="text/javascript" src="Scripts/lib/CollapsibleDiv.js"></script>

  <script type="text/javascript" src="Scripts/lib/x_especialTooltip.js"></script>

  <script type="text/javascript" src="Scripts/lib/xDropDownMenu.js"></script>

  <script type="text/javascript">
    
    
    
        function doCallBackSave() {
            doSaveRefresh();
        }
    
    
        function doSaveRefresh()
        {            
            var context;
            var arg = 'saving';
            //alert(arg);
            //if (!arg) var arg = $('txtPropiedadId').value;
            //document.getElementById('theLoadingMessage').style.display = 'block';
            //$('inspeccionesGrid').innerHTML = '';
            CCSOL.DOM.xShowLoadingMessage();
            <%=ClientScript.GetCallbackEventReference(this.cckhandler_doSave, "arg", "doCallback_SaveRefresh", "context", "HandleError", false) %>;       
        }
        
        function doCallback_SaveRefresh(result, context)
        {
            CCSOL.DOM.xHideLoadingMessage();
            //$('theLoadingMessage').style.display = 'none';            
            var linea=new String(result);            
            //alert(linea);                        
            $('inspeccionesGrid').innerHTML = linea;
            //createToolTips();
            createToolTips2();
            
        }                       
    
        function doGridInspeccionesRefresh(e) {
            var xe = new xEvent(e);
            var theTrigger = xe.target;
            var attr = CCSOL.DOM.x_GetAttribute(theTrigger,'attr');
            doGridInspeccionesRefresh_hnd(attr);
        }
    
    
        function doGridInspeccionesRefresh_hnd(arg)
        {            
            var context;
            //var arg = 'un argumento~dos argumentos';
            //alert(arg);
            //if (!arg) var arg = $('txtPropiedadId').value;
            //document.getElementById('theLoadingMessage').style.display = 'block';
            //$('inspeccionesGrid').innerHTML = '';
            CCSOL.DOM.xShowLoadingMessage();

            <%=ClientScript.GetCallbackEventReference(this.cckhandler_gridInspeccion, "arg", "doCallback_Refresh_hnd", "context", "HandleError", false) %>;       
        }
        
        function doCallback_Refresh_hnd(result, context)
        {
            CCSOL.DOM.xHideLoadingMessage();
            //$('theLoadingMessage').style.display = 'none';            
            var linea=new String(result);            
            //alert(linea);                        
            $('inspeccionesGrid').innerHTML = linea;
            //createToolTips();
            createToolTips2();
            
        }                       
    
    
        function doRefresh(arg)
        {            
            var context;
            //var arg = 'un argumento~dos argumentos';
            //alert(arg);
            //if (!arg) var arg = $('txtPropiedadId').value;
            //document.getElementById('theLoadingMessage').style.display = 'block';
            CCSOL.DOM.xShowLoadingMessage();

            //$('pnlAgenda').innerHTML = '';
            <%=ClientScript.GetCallbackEventReference(this.cckhandler, "arg", "doCallback_Refresh", "context", "HandleError", false) %>;       
        }
        
        function doCallback_Refresh(result, context)
        {
            CCSOL.DOM.xHideLoadingMessage();
            //$('theLoadingMessage').style.display = 'none';            
            var linea=new String(result);            
            //alert(linea);            
            var theScheduleDiv = $('pnlAgenda');
            theScheduleDiv.innerHTML = linea;
            createToolTips();
            
            
        }
        
        function HandleError(message)
        {
            CCSOL.DOM.xHideLoadingMessage();
            alert("[Error] : " + message);
        }
    
    
        function doCbxChange(e) 
        {
            var xe = new xEvent(e);
            var cbxTrigger = xe.target;
            
            //alert (cbxTrigger.value);
            doRefresh(cbxTrigger.value);
            
        }   
    
  
    function inspecionesPanelShow() {
        $('inspecionesPanel').style.display = 'block';
    }
    
		function VehiculoCheckChanged(check)
		{
		}
	
		function Itinerario()
		{
			var WinWidth = 700;
			var WinHeight = 450;
			var Xpos = (screen.width/2) - (WinWidth/2);
			var Ypos = (screen.height/2) - (WinHeight/2);
			window.open('vItinerario.aspx','','width='+WinWidth+',height='+WinHeight+', left='+Xpos+', top='+Ypos+',scrollbars=yes,resizable=yes,menubar=no,status=yes,directories=no,location=no');
		}
		
    var xCheckAll;		
    var winPop = null;  //the window
    
    function createWinPopUp()
    {
      try {
        winPop = new xPopUp(1,'./loading.html');
        winPop.showPopUp('vComunicacion.aspx',640,480);
        winPop.minimizeWindow();
      }
      catch(e) {
        alert(e.message);
      }
    }
    
    function initPage() {
	     window.moveTo(0,0);
	      if (document.all) {
		    top.window.resizeTo(screen.availWidth,screen.availHeight);
	      }
	      else if (document.layers||document.getElementById) {
		    if (top.window.outerHeight<screen.availHeight||top.window.outerWidth<screen.availWidth){
			    top.window.outerHeight = screen.availHeight;
			    top.window.outerWidth = screen.availWidth;
		    }
	      }
	}
	function showIMGAttribute(imgId) {	
		//$('the_id').innerHTML = imgId;
	}
	var aTimeOutHnd;
	function onToolTipDisplay(e) {		
		var xE = new xEvent(e);
		clearTimeout(aTimeOutHnd);
		//simulando una llamada a un metodo AJAX
	
		
		var theTrigger = xE.target;//(xE.target.tagName != 'DIV')?xE.target.parentNode:xE.target;		
		if(theTrigger.tagName == "IMG")  {		 
		  theTrigger = theTrigger.parentNode;
		  //alert(CCSOL.DOM.x_GetAttribute(theTrigger,'doShow'));
		}
		
	  if ((CCSOL.DOM.x_GetAttribute(theTrigger,'doShow') == 'show')
	      || (CCSOL.DOM.x_GetAttribute(theTrigger,'notooltip') == 'notooltip')
	  ) return false;
	  return true;
	
		
		
	}
	function showInfo(cita)  {
	    //$('the_id').innerHTML = cita;
	}
	
	var t = null;
	function createToolTips() {
	    if (t != null) t.unload();
        t = new x_ToolTip('A',
						  'pnlAgenda',
						  10,
						  10,
						  'theTooltip',
						  null,
						  'normal2');
	}
	 var insToolTip = null
    function createToolTips2() {
         if (insToolTip != null) insToolTip.unload();
         insToolTip = new x_ToolTip(
                          'TR',
						              'inspeccionesGrid',
						              10,
						              10,
						              'theTooltip2',
						              onToolTipDisplay//llamada al metodo que hace la actualización del contenido del div
						              );
    }
  
  
  
  function onDisplayMenu(e,theMenu) {
		xE = new xEvent(e);		
		
		//asumimos que no siempre es posible mostrar el menu
		theMenu.doShow = false;
		//asumimos que por defecto queremos que se ejecute la acción por defecto de los links
		theMenu.doReturn = false;
		//sobre q elemento se ha hecho click
		var theTrigger = xE.target;
		
		if(theTrigger.parentNode.tagName == "A") theTrigger = theTrigger.parentNode;
		var doShow = CCSOL.DOM.x_GetAttribute(theTrigger,'doShow');				
		//si es un tipo link y tiene el atributo doRedirect 
		
		if (doShow  == 'show') {
			theMenu.doShow = true;
			theMenu.doReturn = false;
		}
//		if (theTrigger.type == 'checkbox') { 			
//			//alert(theTrigger.type);
//			theMenu.doShow = false;	
//			theMenu.doReturn = true;
////			theTrigger.check();	
//		}
//		
		
		
//		//copiamos los valores que tiene el elemento en los atributos que se le han asignado
//		$('damagedZone').value = CCSOL.DOM.x_GetAttribute(theTrigger,'desc');
//		
//		//guardamos en el objeto data los valores que necesitamos que se queden en memoria para accesarlos 
//		//después desde otros métodos podemos recuperar el ultimo valor guardado en este objeto
//		if (!$('popUpForm').data) $('popUpForm').data = new Object();
//		$('popUpForm').data.damageId = CCSOL.DOM.x_GetAttribute(theTrigger,'damageId');
		
		var tipo = CCSOL.DOM.x_GetAttribute(theTrigger,'tipoaccion');
		theMenu.isModal = true;
		
		var cadena = getHTML(tipo);		
		if (cadena == 'no tipo') theMenu.doShow = false;
		$('popUpForm').innerHTML = cadena;		
		
				
	}
	
	function getHTML(tipo) {
	  var str = '';
    switch(tipo) {
      case  'anular' : 
           str = '<div style="padding: 2px; width: 250px; text-align: left;display: block; position: fixed;">';
           str+= '<table border="0" cellpadding="0" cellspacing="0" class="DataTable" style="font-size: 10px;"><tr><td align="left" style="font-weight: bold">';
           str+= 'Motivo</td></tr><tr><td align="left"><select name="DropDownList1" id="DropDownList1" class="FormText NOHIDE" style="width:244px;">';
           str+= '<option value=""></option><option value="DESISTIMIENTO DEL SOLICITANTE">DESISTIMIENTO DEL SOLICITANTE</option>';
           str+= '<option value="MAXIMO DE FRUSTRACIONES">MAXIMO DE FRUSTRACIONES</option></select></td> </tr>';
           str+= '<tr> <td align="left" style="height: 18px; font-weight: bold;" valign="bottom"> Observación</td> ';
           str+= '</tr> <tr> <td align="left"> <textarea name="descripcionTextBox" rows="6" cols="20" id="descripcionTextBox"';
           str+= 'class="FormText" style="width:240px;"></textarea></td> </tr> <tr> <td align="right" style="height: 20px">';
           str+= '<input name="guardarButton" onclick="xMenu.hide();return false;" type="button" id="guardarButton" class="FormButton" style="width: 130px" value="Anular Inspección" />';
           str+= '<input id="cancelarButton" onclick="xMenu.hide();return false;" class="FormButton" type="button" value="Cancelar" /> </td> </tr> </table> </div>';                                
      break;
      case 'frustar' : 
           str = '<div id="Div1" style="padding: 2px; width: 250px; text-align: left;display: block; position: fixed">';
           str += '<table border="0" cellpadding="0" cellspacing="0" class="DataTable" style="font-size:10px;"><tr><td align="left" style="font-weight: bold">Motivo</td>';
           str += '</tr><tr><td align="left"><select name="DropDownList2" id="DropDownList2" class="FormText NOHIDE" style="width:244px;"><option value="">';
           str += '</option><option value="POR REPROGRAMACION">POR REPROGRAMACION</option><option value="NO ATENDIERON LA VisITA">NO ATENDIERON LA VISITA</option></select></td>';
           str += '</tr><tr><td align="left" style="height: 18px; font-weight: bold;" valign="bottom">Observación</td></tr><tr><td align="left">';
           str += '<textarea name="TextBox1" rows="6" cols="20" id="TextBox1" class="FormText" style="width:240px;"></textarea></td>';
           str += '</tr><tr><td align="right" style="padding-top: 2px;"><input name="Button1" type="button" id="Button1" class="FormButton" onclick="xMenu.hide();return false;" style="width: 130px" value="Frustrar Inspección" /><input id="Button2" onclick="xMenu.hide();return false;" class="FormButton" type="button" value="Cancelar" /></td></tr></table></div>';
      break;
      case 'reprogramar' :
           //$('popUpForm').style.width = '400px';
           str = $('reprogramarform').innerHTML;                                             
      break;
      default: str = 'no tipo';
      break;      
    }	  
    return str;
	}
	
	function onAutoHide(evt) {
		//return false to aovid the window be auto hidden on mouseout
		//return true to enable the auto hide feature;
		return false;
	}
  
  
  var xMenu;
  function createDropDownMenu() {
      xMenu = new xDropDownMenu('popUpForm',       //el div que aparecerá en el punto de click
									    'inspeccionesGrid', //el "map" area que contiene los hotspots que provocarán que aparezca el PopUpForm
									    'context',		 //Se muestra en el punto de click ('d' = dropDownMenu,null = en el punto de click, 'context' = menu contextual
									    'click',			 //el evento al que queremos asociar la aparición del Div
									    null,			 	 //posicion en la que queremos que aparezca el div, 'left', 'right' o null solo tiene sentido cuando el menu es tipo 'd'
									    onDisplayMenu,	 //evento que se ejecuta al mostrarse el div

									    onAutoHide             //evento que se llama al ocurrir un mouseout 
									    );
  }
	window.onload = function(){				
      try {
    
     	initPage();
     	/*
        var insToolTip = new x_ToolTip('TR',
						  'inspeccionesGrid',
						  10,
						  10,
						  'theTooltip',
						  onToolTipDisplay,
						  );
        
         */
        var inspLabel = new CollapsibleDiv ('inspeccionesLabel', 'inspeccionesData', true, null);
        var inspImage = new CollapsibleDiv ('inspeccionesImage', 'inspeccionesData', true, null);
        var agenLabel = new CollapsibleDiv ('agendaLabel', 'agendaData', true, null);
        var agenImage = new CollapsibleDiv ('agendaImage', 'agendaData', true, null);
		
		createToolTips();
		
        
        if(<%= shouldCreateWindow() %>) window.setTimeout('createWinPopUp()',2000);
        
        //al ultimo para evitar que muera antes por esta razón
        //xCheckAll = new xCheckAllN('chkAll','inspeccionGridView','ItemStyle','ItemStyleOver');
        
        //Evento : onchange 
        //Trigger : DropDownList1        
        xAddEventListener('DropDownList1','change',doCbxChange,false);
        
    
        createToolTips2();
        
        
        createDropDownMenu();
        
     }
     catch(e)
     {     
       alert(e.message);
     }		
   }          
   function Button2_onclick() {
        if (winPop == null) {
            createWinPopUp();
        }
        else {
            winPop.showPopUp('vComunicacion.aspx',680,480);
        }
   }

  </script>

  <link href="./Scripts/xPopUpCSS/fen.css" rel="stylesheet" type="text/css" />
  <link href="Css/layout.css" rel="stylesheet" type="text/css" />
  <link href="Scripts/xSpecialToolTip/xSpecialtoolTip.css" type="text/css" rel="stylesheet" />
  <link href="Scripts/xPopUpCSS/fen.css" rel="stylesheet" type="text/css" />
  <link href="Css/agenda.css" type="text/css" rel="stylesheet" />
</head>
<body>
  <form id="form1" runat="server">
    <table id="mainTable" border="0" cellpadding="0" cellspacing="0" style="width: 100%;
      height: 100%">
      <tr>
        <td style="height: 7px">
          <div class="DataTop">
            <div class="DataTopLeft">
            </div>
            <div class="DataTopRight">
            </div>
          </div>
        </td>
      </tr>
      <tr>
        <td>
          <div class="DataContent" id="registroDataContent" style="height: 100%;">
            <div class="DataContentRight" id="registroDataContentRight" style="height: 100%">
              <div id="inspecionesPanel" class="PanelStyle" style="margin-top: 4px" runat="server">
                <div class="PanelEncabezado">
                  <asp:Label ID="inspeccionesLabel" runat="server" Text="Inspecciones" Style="cursor: default"
                    ToolTip="Mostrar / Ocultar Panel"></asp:Label>
                  <img id="inspeccionesImage" alt="Mostrar / Ocultar Panel" onmouseout="MakeClear(this,0)"
                    onmouseover="MakeClear(this,1);" src="Images/IconHide16Dark.gif" title="Mostrar / Ocultar Panel" /></div>
                <div id="inspeccionesData">
                  <div id='inspeccionesGrid' class="PanelInset" style="height: 150px">
                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="DataTable"
                      DataSourceID="odsInspecciones" OnRowDataBound="GridView1_RowDataBound" BorderStyle="Solid">
                      <Columns>
                        <asp:BoundField DataField="CodigoInspeccion" HeaderText="CodigoInspeccion" InsertVisible="False"
                          ReadOnly="True" SortExpression="CodigoInspeccion" Visible="False" />
                        <asp:BoundField DataField="Placa" HeaderText="Placa" ReadOnly="True" SortExpression="Placa">
                          <HeaderStyle Width="60px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Estado" HeaderText="Estado" ReadOnly="True" SortExpression="Estado">
                          <HeaderStyle Width="90px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="FInspeccion" DataFormatString="{0:dd-MM-yyyy}" HeaderText="Fecha Inspecci&#243;n"
                          HtmlEncode="False" ReadOnly="True" SortExpression="FInspeccion">
                          <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="HInicio" DataFormatString="{0:HH:mm}" HeaderText="Inicio"
                          HtmlEncode="False" ReadOnly="True" SortExpression="HInicio" />
                        <asp:BoundField DataField="HFin" DataFormatString="{0:HH:mm}" HeaderText="Fin" HtmlEncode="False"
                          ReadOnly="True" SortExpression="HFin" />
                        <asp:TemplateField HeaderText="Inspector" SortExpression="Inspector">
                          <EditItemTemplate>
                            <asp:TextBox ID="TextBox3" runat="server" notooltip='notooltip' CssClass="FormText"
                              Text='<%# Bind("Inspector") %>' Width="120px"></asp:TextBox>
                          </EditItemTemplate>
                          <ItemTemplate>
                            <asp:Label ID="Label3" runat="server" Text='<%# Bind("Inspector") %>'></asp:Label>
                          </ItemTemplate>
                          <HeaderStyle Width="120px" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Direcci&#243;n" SortExpression="Direccion">
                          <EditItemTemplate>
                            <asp:TextBox ID="TextBox2" runat="server" CssClass="FormText" notooltip='notooltip'
                              Text='<%# Bind("Direccion") %>'></asp:TextBox>
                          </EditItemTemplate>
                          <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("Direccion") %>'></asp:Label>
                          </ItemTemplate>
                          <HeaderStyle Width="150px" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Ubigeo" SortExpression="UbigeoText">
                          <EditItemTemplate>
                            <asp:TextBox ID="TextBox1" runat="server" notooltip='notooltip' CssClass="FormText"
                              Text='<%# Bind("UbigeoText") %>'></asp:TextBox>
                          </EditItemTemplate>
                          <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("UbigeoText") %>'></asp:Label>
                          </ItemTemplate>
                          <HeaderStyle Width="150px" />
                        </asp:TemplateField>
                        <asp:TemplateField ShowHeader="False" HeaderText="Acci&#243;n">
                          <EditItemTemplate>
                            <asp:ImageButton ID="ImageButton5" notooltip="notooltip" runat="server" ImageUrl="~/Images/btnGuardarGrilla.jpg"
                              OnClientClick="doCallBackSave();return false;" />
                            <asp:ImageButton ID="exitImageButton" notooltip="notooltip" runat="server" ImageUrl="~/Images/IconExit.gif"
                              CommandName="Cancel" />
                          </EditItemTemplate>
                          <ItemTemplate>
                            <asp:ImageButton ID="editarImageButton" notooltip="notooltip" runat="server" attr='<%# Eval("CodigoInspeccion") %>'
                              OnClientClick="doGridInspeccionesRefresh();return false;" CommandName="Edit" ImageUrl="~/Images/IconEdit.gif"
                              ToolTip="Editar Inspección" Visible="False" />
                            <asp:HyperLink ID="frustrarHyperLink" doShow='show' tipoaccion='frustar' runat="server"
                              ImageUrl="~/Images/IconFrustrar.gif" Visible="False" NavigateUrl="javascript:InspeccionFrustrar();">Frustrar Inspección</asp:HyperLink>
                            <asp:HyperLink doShow='show' tipoaccion='reprogramar' ID="reprogramarHyperLink" runat="server"
                              ImageUrl="~/Images/IconProgramar.gif" Visible="False" NavigateUrl="javascript:InspeccionReprogramar();">Reprogramar Inspección</asp:HyperLink>
                            <asp:HyperLink doShow='show' tipoaccion='anular' ID="anularHyperLink" runat="server"
                              ImageUrl="~/Images/IconAnular.gif" NavigateUrl="javascript:InspeccionAnular();">Anular Inspección</asp:HyperLink>
                          </ItemTemplate>
                          <ItemStyle HorizontalAlign="Right" />
                        </asp:TemplateField>
                      </Columns>
                      <RowStyle CssClass="ItemStyle" />
                      <HeaderStyle CssClass="HeaderStyle" />
                    </asp:GridView>
                  </div>
                  <div id="accionPanel" style="margin-top: 3px">
                    <input id="Button1" class="FormButton" type="button" value="Guardar datos" />
                    <input id="Button2" class="FormButton" type="button" value="Agendar inspecciones"
                      onclick="return Button2_onclick()" />
                  </div>
                </div>
                <asp:ObjectDataSource ID="odsInspecciones" runat="server" SelectMethod="getInspecciones"
                  TypeName="Carcheck.Gestores.GInspeccion_temp"></asp:ObjectDataSource>
              </div>
              <div id="agendaPanel" class="PanelStyle" style="margin-top: 4px;" runat="server">
                <div class="PanelEncabezado">
                  <asp:Label ID="agendaLabel" runat="server" Text="Agenda - Martes 10 de Octubre de 2006"
                    Style="cursor: default" ToolTip="Mostrar / Ocultar Panel"></asp:Label>
                  <img id="agendaImage" alt="Mostrar / Ocultar Panel" onmouseout="MakeClear(this,0)"
                    onmouseover="MakeClear(this,1);" src="Images/IconHide16Dark.gif" title="Mostrar / Ocultar Panel" /></div>
                <div id="agendaData">
                  <div class="DataTable" style="padding: 5px;">
                    <table border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td style="height: 17px">
                          Fecha&nbsp;
                        </td>
                        <td style="width: 120px; height: 17px;">
                          <cc2:WebCalendar ID="wccDateToShow" runat="server" BtnCalendarImage="./Scripts/wcc_includes/img/cal.gif"
                            CssClass="FormText" GenerateBtn="True" WcResourcesDir="./Scripts/wcc_includes"
                            Width="80px" WcStyleSheet="calendar-brown.css"></cc2:WebCalendar>&nbsp;<asp:Button
                              ID="btnGo" runat="server" CssClass="FormButton" Text="Ir" ToolTip="Ir al Día señalado" /></td>
                        <td style="width: 35px; height: 17px;">
                          <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/Images/Previous.gif"
                            ToolTip="Ver un día anterior" />
                          <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="~/Images/Next.gif" ToolTip="Ver siguiente día" /></td>
                        <td style="width: 83px; height: 17px">
                          &nbsp;<asp:DropDownList ID="DropDownList1" runat="server" CssClass="FormText" Height="16px"
                            Width="70px">
                            <asp:ListItem Value="10">10 min</asp:ListItem>
                            <asp:ListItem Value="15">15 min</asp:ListItem>
                            <asp:ListItem Value="30">30 min</asp:ListItem>
                            <asp:ListItem Selected="True" Value="60">1 Hora</asp:ListItem>
                          </asp:DropDownList></td>
                        <td style="width: 65px; height: 17px;" align="right">
                          Inspector&nbsp;
                        </td>
                        <td style="height: 17px">
                          <cc1:AutoSuggestBox DataType="Inspector" ID="asbInspectores" runat="server" CssClass="FormText"
                            OnFocusShowAll="True" ResourcesDir="./Scripts/asb_includes" Width="200px"></cc1:AutoSuggestBox></td>
                        <td style="height: 17px">
                          <input id="Button3" class="FormButton" type="button" value="Filtrar" onclick="return Button3_onclick()" />
                        </td>
                        <td style="height: 17px">
                          <input id="Button4" class="FormButton" type="button" value="Imprimir itinerarios"
                            onclick="Itinerario();" />
                        </td>
                      </tr>
                    </table>
                  </div>
                  <div>
                    <div id='pnlAgenda' style="padding: 5px; position: relative;">
                      <rw:ScheduleGeneral ID="Schedule1" runat="server" GridLines="None" DataRangeStartField="BeginTime"
                        DataRangeEndField="EndTime" TitleField="Inspector" Layout="Vertical" CellSpacing="0"
                        ShowValueMarks="True" DataSourceID="AccessDataSource1" EndOfTimeScale="23:00:00"
                        HorizontalAlign="NotSet" ItemStyleField="" StartOfTimeScale="07:00:00" DataKeyNames="ID"
                        FullTimeScale="True">
                        <TitleStyle CssClass="heading"></TitleStyle>
                        <ItemStyle CssClass="normal"></ItemStyle>
                        <AlternatingItemStyle CssClass="normal"></AlternatingItemStyle>
                        <BackgroundStyle CssClass="empty"></BackgroundStyle>
                        <RangeHeaderStyle CssClass="heading"></RangeHeaderStyle>
                        <DateHeaderTemplate>
                          <%#Helper1(Container.DataItem)%>
                        </DateHeaderTemplate>
                        <RangeHeaderTemplate>
                          <%#Helper2(Container.DataItem)%>
                        </RangeHeaderTemplate>
                        <ItemTemplate>
                          <div class="normal2" style="height: 400%; width: 100%; vertical-align: top;" cita_con='<%#Eval("CitaCon")%>'>
                            <asp:LinkButton ID="link" runat="server" OnClientClick="inspecionesPanelShow();return false;"
                              InspeccionId='<%#Eval("InspeccionId")%>'><%#Eval("CitaCon")%> - <%# getEventTime(Eval("BeginTime"),Eval("EndTime")) %> </asp:LinkButton>
                          </div>
                        </ItemTemplate>
                      </rw:ScheduleGeneral>
                      <asp:AccessDataSource ID="AccessDataSource1" runat="server" DataFile="~/App_Data/schedule.mdb"
                        SelectCommand="SELECT * FROM [demo3] WHERE (((demo3.[fecha])=#10/4/2006#))"></asp:AccessDataSource>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </td>
      </tr>
      <tr>
        <td height="7">
          <div class="DataBottom">
            <div class="DataBottomLeft">
            </div>
            <div class="DataBottomRight">
            </div>
          </div>
        </td>
      </tr>
    </table>
    <div id="theToolTip2" class="ToolTip" style="display: block; position: absolute;
      width: 280px;">
      <p id="descripcionLabel" style="margin-bottom: 2px">
        <strong style="font-size: 11px">Contacto:</strong> Alberto Perez Rodriguez<br />
      </p>
      <table border="1" cellpadding="0" cellspacing="0" style="font-size: 10px; color: Black;">
        <tr>
          <td style="font-weight: bold; font-size: 11px; text-transform: capitalize; width: 100px;
            padding-left: 4px;">
            Fecha / hora</td>
          <td style="font-weight: bold; font-size: 11px; text-transform: capitalize; width: 100px;
            padding-left: 4px;">
            Actividad</td>
          <td style="font-weight: bold; font-size: 11px; text-transform: capitalize; width: 100px;
            padding-left: 4px;">
            Estado</td>
        </tr>
        <tr>
          <td style="padding-left: 2px">
            19/10/2006 13:00</td>
          <td style="padding-left: 2px">
            LLAMADA</td>
          <td style="padding-left: 2px">
            REPROGRAMADO</td>
        </tr>
        <tr>
          <td style="padding-left: 2px">
            19/10/2006 09:10</td>
          <td style="padding-left: 2px">
            LLAMADA</td>
          <td style="padding-left: 2px">
            AGENDADO</td>
        </tr>
        <tr>
          <td style="padding-left: 2px">
            18/10/2006 18:25</td>
          <td style="padding-left: 2px">
            E-MAIL</td>
          <td style="padding-left: 2px">
            PENDIENTE</td>
        </tr>
      </table>
    </div>
    <div id="theTooltip" class="holder">
      <table border="0" cellpadding="1" cellspacing="0">
        <tr>
          <td style="font-weight: bold;">
            Nº Siniestro</td>
          <td style="font-weight: bold">
            :</td>
          <td>
            SOL-416-2006</td>
        </tr>
        <tr>
          <td style="font-weight: bold">
            Asegurado</td>
          <td style="font-weight: bold">
            :</td>
          <td>
            Javier Marquina Taso</td>
        </tr>
        <tr>
          <td style="font-weight: bold">
            Contacto</td>
          <td style="font-weight: bold">
            :</td>
          <td>
            Juan Carlos López</td>
        </tr>
        <tr>
          <td style="font-weight: bold">
            Teléfono</td>
          <td style="font-weight: bold">
            :</td>
          <td>
            9931558</td>
        </tr>
        <tr>
          <td style="font-weight: bold">
            Dirección</td>
          <td style="font-weight: bold">
            :</td>
          <td>
            Jr. Cascas 232 Lima</td>
        </tr>
        <tr>
          <td style="font-weight: bold">
            Ubigeo</td>
          <td style="font-weight: bold">
            :</td>
          <td>
            Lima / Lima / lima</td>
        </tr>
      </table>
    </div>
  </form>
  <div id="popUpForm" class="popUpForm">
    <div class="FormHeader" style="margin-bottom: 5px; background-color: #FEF4E7; padding: 3px;">
      Registro de Zona ...
      <button onclick="closeThis();">
        close</button>
    </div>
    <div style="padding: 2px;">
      <table width="69%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="30%">
            Zona Da&ntilde;ada
          </td>
        </tr>
        <tr>
          <td valign="top" style="padding-top: 2px;">
            <input id='damagedZone' name="textfield" type="text" class="FormText" style="width: 200px;" /></td>
        </tr>
        <tr>
          <td>
            <span style="padding-top: 2px;">Descripci&oacute;n</span></td>
        </tr>
        <tr>
          <td>
            <textarea name="textarea" rows="4" class="FormText" style="width: 200px;"></textarea></td>
        </tr>
        <tr>
          <td>
            <img src="../Images/IconSave24.gif" onclick="doSaveDamage();return false;" style="cursor: pointer;"
              width="24" height="24" /></td>
        </tr>
      </table>
    </div>
  </div>
  <div id='reprogramarform' style="padding: 2px; text-align: left; width: 380px; display: none;
    position: absolute">
    <table border="0" cellpadding="0" cellspacing="0" class="DataTable" style="font-size: 10px;">
      <tr>
        <td style="width: 115px">
          Fecha Inspección<span id="finspeccionRFV" class="DataValidator" style="color: Red;
            font-weight: bold; display: none;">(*)</span><span id="horaInicioRFV" class="DataValidator"
              style="color: Red; font-weight: bold; display: none;">(*)</span><span id="horaFinRFV"
                class="DataValidator" style="color: Red; font-weight: bold; display: none;">(*)</span>
        </td>
        <td>
          <input name="finspeccionTextBox" type="text" id="finspeccionTextBox" class="FormText"
            style="width: 80px;" />
          De
          <input name="horaInicioTextBox" type="text" id="horaInicioTextBox" class="FormText"
            style="width: 50px;" />
          a
          <input name="horaFinTextBox" type="text" id="horaFinTextBox" class="FormText" style="width: 50px;" />
          hrs.</td>
      </tr>
      <tr>
        <td>
          Contacto<span id="contactoInspeccionRFV" style="color: Red; font-weight: bold; visibility: hidden;">(*)</span></td>
        <td>
          <input name="contactoInspeccionTextBox" type="text" id="contactoInspeccionTextBox"
            class="FormText" style="width: 135px;" />&nbsp; Telf.
          <input name="telefonoTextBox" type="text" id="telefonoTextBox" class="FormText" style="width: 74px;" />
        </td>
      </tr>
      <tr>
        <td>
          Dirección<span id="direccionRFV" style="color: Red; font-weight: bold; visibility: hidden;">(*)</span></td>
        <td>
          <input name="direccionTextBox" type="text" id="direccionTextBox" class="FormText"
            style="width: 250px;" /></td>
      </tr>
      <tr>
        <td>
          Ubigeo<span id="ubigeoIdRFV" style="color: Red; font-weight: bold; visibility: hidden;">(*)</span></td>
        <td>
          <input name="ubigeoIdTextBox" type="text" id="ubigeoIdTextBox" class="FormText" style="width: 250px;" /></td>
      </tr>
      <tr>
        <td>
          Inspector</td>
        <td style="padding-top: 1px; height: 19px">
          <select name="inspectorIdCombo" id="inspectorIdCombo" class="FormText NOHIDE" style="width: 254px;">
            <option value=""></option>
            <option value="EDER QUISPE">EDER QUISPE</option>
            <option value="EDER VELASCO">EDER VELASCO</option>
            <option value="JUAN CARLOS">JUAN CARLOS</option>
            <option value="LUIS MOLINA">LUIS MOLINA</option>
            <option value="MARIO VILLEGAS">MARIO VILLEGAS</option>
          </select>
        </td>
      </tr>
      <tr>
        <td style="padding-top: 2px" valign="top">
          Observación</td>
        <td style="padding-top: 1px; height: 19px">
          <textarea name="observacionTextBox" rows="4" cols="20" id="observacionTextBox" class="FormText"
            style="width: 250px;"></textarea></td>
      </tr>
      <tr>
        <td align="right" colspan="2" style="padding-top: 2px">
          <input name="Button3" type="button" onclick='xMenu.hide();return false;' id="Button5"
            class="FormButton" style="width: 160px" value="Reprogramar Inspección" />
          <input id="Button6" class="FormButton" onclick='xMenu.hide();return false;' type="button"
            value="Cancelar" /></td>
      </tr>
    </table>
  </div>
</body>
</html>
