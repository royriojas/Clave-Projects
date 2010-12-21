<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vAgenda.aspx.cs" Inherits="vAgenda" %>

<%@ Register Assembly="CustomPanelWebControl" Namespace="xWebControl" TagPrefix="cc3" %>
<%@ Register Src="ucListaComunicaciones.ascx" TagName="ucListaComunicaciones" TagPrefix="uc5" %>
<%@ Register Src="ucSecurityController.ascx" TagName="ucSecurityController" TagPrefix="uc4" %>
<%@ Register Src="ucFrustrar.ascx" TagName="ucFrustrar" TagPrefix="uc3" %>
<%@ Register Src="ucReprogramarInspeccion.ascx" TagName="ucReprogramarInspeccion"
  TagPrefix="uc2" %>
<%@ Register Src="ucAnularInspeccion.ascx" TagName="ucAnularInspeccion" TagPrefix="uc1" %>
<%@ Register Assembly="schedule2" Namespace="rw" TagPrefix="rw" %>
<%@ Register Assembly="AutoSuggestBox" Namespace="ASB" TagPrefix="cc1" %>
<%@ Register Assembly="WebCalendarControl" Namespace="WebCalendarControl" TagPrefix="cc2" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
  <title>
    <%= CCSOL.Utiles.Utilidades.GetSystemNameAndVersion() %>
    | Agenda</title>
  <link href="Scripts/xCommon/xCommon.css" type="text/css" rel="Stylesheet" />

  <script type="text/javascript" src="Scripts/lib/x.js"></script>

  <script type="text/javascript" src="Scripts/lib/x_common.js"></script>

  <script type="text/javascript" src="Scripts/lib/xDomReady.js"></script>

  <script type="text/javascript" src="Scripts/lib/x_checkAll.js"></script>

  <script type="text/javascript" src="Scripts/lib/xpopup.js"></script>

  <script type="text/javascript" src="Scripts/lib/CollapsibleDiv.js"></script>

  <script type="text/javascript" src="Scripts/lib/x_especialTooltip.js"></script>

  <script type="text/javascript" src="Scripts/lib/xDropDownMenu.js"></script>

  <script type="text/javascript" src="Scripts/lib/x_ImageEffects.js"></script>

  <script type="text/javascript" src="Scripts/lib/xCaseFormatter.js"></script>

  <script type="text/javascript" src="Scripts/lib/xTable.js"></script>

  <script type="text/javascript" src="Scripts/lib/xASB.js"></script>

  <script type="text/javascript">
  
  function doReloadPage() {
     window.location.href = window.location.href + '';
  }
  
  function hidePopWindow() {    
    if (winPop != null) winPop.hide();
    doReloadPage();
  }
  
  function createAsbs(ctrlId) {
  
    //alert($(ctrlId+'_asbUbigeoDiv'));
    
    createAnAutoSuggest(ctrlId+'_asbInspector','Inspector',ctrlId + '_asbInspectorDiv');
    createAnAutoSuggest(ctrlId+'_asbUbigeo','Distrito',ctrlId + '_asbUbigeoDiv');
  }
  
 
  </script>

  <script type="text/javascript">
  function doCommand (action) {   
    var context;
    var arg = action;
    CCSOL.Utiles.RegenerateViewState();
            
    //var arg = 'un argumento~dos argumentos';
    //alert(arg);
    //if (!arg) var arg = $('txtPropiedadId').value;
    //document.getElementById('theLoadingMessage').style.display = 'block';
    CCSOL.DOM.xShowLoadingMessage();

            //$('pnlAgenda').innerHTML = '';
    <%=ClientScript.GetCallbackEventReference(this.cckhandler, "arg", "doCallback_Refresh", "context", "HandleError", false) %>;           
  }
  </script>

  <script type="text/javascript">
    
    
        /**********************************************************************************************************************************        
          INICIO DE LAS FUNCIONES DE MANEJO DE LA GRILLA DE INSPECCIONES        
        ***********************************************************************************************************************************/
    
    
        function CommandArgument(a,ri) {
          this.action = a;
          this.rowIndex = ri;
        }
        
        function getRowCommand(e) {
          var xe = new xEvent(e);
          var theTrigger = xe.target;
          var rowIndex = CCSOL.DOM.x_GetAttribute(theTrigger,'rowIndex');
          var action = CCSOL.DOM.x_GetAttribute(theTrigger,'action');                    
                    
          return (new CommandArgument(action,rowIndex));          
        }
        
        function doGridCommand(e)
        {            
            var context;            
            var rowCommand = getRowCommand(e);
            var arg;
            
            if (rowCommand != null) {
              arg = rowCommand.action + '$' + rowCommand.rowIndex;
            }
            
            CCSOL.Utiles.RegenerateViewState();
            
            CCSOL.DOM.xShowLoadingMessage();
            <%=ClientScript.GetCallbackEventReference(this.cckhandler_gridInspeccion, "arg", "doGridCommand_CallBack", "context", "HandleError", false) %>;       
        }
        
        
        
        function doGridCommand_CallBack(result, context) {
            CCSOL.DOM.xHideLoadingMessage();
            var linea=new String(result);                  
            var lista = linea.split("$$$$_$$$$");                                                                
            $('inspeccionesGrid').innerHTML = lista[0];                                                                     
            if (typeof(lista[1]) != 'undefined') {
              createAsbs(lista[1]);
            }
            createOverEffect();
            setTimeout('doRefresh()',500);
        }                       
        
        
        /**********************************************************************************************************************************        
          FIN DE LAS FUNCIONES DE MANEJO DE LA GRILLA DE INSPECCIONES        
        ***********************************************************************************************************************************/
    
    
    
        function doRefresh()
        {        
            var arg = $('cbxIntervalo').value; ;
            var context;
           
            CCSOL.DOM.xShowLoadingMessage();

           <%=ClientScript.GetCallbackEventReference(this.cckhandler, "arg", "doCallback_Refresh", "context", "HandleError", false) %>;       
        }
    
        function doRefreshTimeInterval()
        {        
            var context;
            var arg;
            CCSOL.Utiles.RegenerateViewState();
            
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
            var lista=new String(result);      
            var lista = lista.split("$$$$_$$$$");      
                                
            var theScheduleDiv = $('pnlAgenda');
            theScheduleDiv.innerHTML = lista[0];
            
            $('agendaLabel').innerHTML = lista[1];
            $('wccDateToShow').value = lista[2];
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
            doRefreshTimeInterval(cbxTrigger.value);
            
        }   
    
    
    function _setValue(strSpanId,value,theTrigger) {
       $(strSpanId).innerHTML = CCSOL.DOM.x_GetAttribute(theTrigger,value);
       //var action = CCSOL.DOM.x_GetAttribute(theTrigger,'action'); 
    }
    
    function onToolTipCitaDisplay(e) 
    {
      var xe = new xEvent(e);
      
      var theTrigger = xe.target;                 
      if (theTrigger.nodeName == 'A') theTrigger = theTrigger.parentNode;
      _setValue('sp_numsol','numesolicitud',theTrigger);
      _setValue('sp_asegurado','asegurado',theTrigger);
      _setValue('sp_contacto','contacto',theTrigger);
      _setValue('sp_telef','telefono',theTrigger);
      _setValue('sp_direccion','direccion',theTrigger);
      _setValue('sp_distrito','distrito',theTrigger);
      
      //$('sp_distrito').innerHTML = theTrigger.nodeName;
                        
    }
    
    
    
//  
//    function inspecionesPanelShow() {
//        $('inspecionesPanel').style.display = 'block';
//    }
//    
		function VehiculoCheckChanged(check)
		{
		}
	
		function Itinerario()
		{
			var WinWidth = 700;
			var WinHeight = 450;
			var Xpos = (screen.width/2) - (WinWidth/2);
			var Ypos = (screen.height/2) - (WinHeight/2);
			window.open('vItinerario.aspx?Fecha='+ $('wccDateToShow').value+ '&nocache=' + CCSOL.Utiles.AvoidInstantCache(),'Itinerario','width='+WinWidth+',height='+WinHeight+', left='+Xpos+', top='+Ypos+',scrollbars=yes,resizable=yes,menubar=no,status=yes,directories=no,location=no');
		}
		
    var xCheckAll;		
    var winPop = null;  //the window
    
    function createWinPopUp()
    {
      try {
        if (winPop == null)  winPop = new xPopUp(1,'./loading.html',false,doReloadPage);        
        winPop.showPopUp("vComunicacion.aspx?SolicitudId=<%=solicitudId%>&nocache=" + CCSOL.Utiles.AvoidInstantCache(),670,446);
        //winPop.minimizeWindow();
      }
      catch(e) {
        alert(e.message);
      }
    }
    
    function hide() 
    {
      winPop.hide();
      doRefresh();
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
        t = new x_ToolTip('div',
						  'pnlAgenda',
						  10,
						  10,
						  'tooltipcita',
						  onToolTipCitaDisplay,
						  'INSTOOLTIP');
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
		
		    //createToolTips();
		
		    createToolTips();
        
        //if(shouldCreateWindow()) window.setTimeout('createWinPopUp()',2000);
        
        //al ultimo para evitar que muera antes por esta razón
        //xCheckAll = new xCheckAllN('chkAll','inspeccionGridView','ItemStyle','ItemStyleOver');
                
        xAddEventListener('cbxIntervalo','change',doCbxChange,false);            
        //xAddEventListener('wccDateToShow','change',doRefreshTimeInterval,false);
        //createToolTips2();                
        
        //createDropDownMenu();
        createOverEffect();
        
     }
     catch(e)
     {     
       alert(e.message);
     }		
   }   
   
   var xtable 
   function createOverEffect() {
      try { 
        if (xtable != null) xtable.doUnload();
         xtable = new xTable('GridView1',   //el Identificador de la tabla
				                      'ItemStyleSelected',    //el Style ItemSeleccionado
				                      'ItemStyleOver',
				                      false,
				                      true);
				}
				catch(ex) {
				  //alert(ex.message);
				}
   }
          
   function Button2_onclick() {
        if (winPop == null) {
            createWinPopUp();
        }
        else {
            winPop.showPopUp('vComunicacion.aspx?solicitudId=<%=solicitudId%>&nocache=' + CCSOL.Utiles.AvoidInstantCache(),680,480);
//            window.open("vAgenda.aspx?action=sASol&SolicitudId=<%=solicitudId%>",'Agenda','scrollbars=yes,resizable=yes,menubar=no,status=yes,directories=no,location=no');
        }
   }

  </script>

  <link href="./Scripts/xPopUpCSS/fen.css" rel="stylesheet" type="text/css" />
  <link href="Css/layout.css" rel="stylesheet" type="text/css" />
  <link href="Scripts/xSpecialToolTip/xSpecialtoolTip.css" type="text/css" rel="stylesheet" />
  <link href="Css/agenda.css" type="text/css" rel="stylesheet" />
</head>
<body>
  <form id="form1" runat="server">
    <uc4:ucSecurityController ID="UcSecurityController1" runat="server" MainFormName="form1"
      PageFunctionalityToCheck="AGENDA_VER" />
    <table id="mainTable" border="0" cellpadding="0" cellspacing="0" style="width: 100%;">
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
                  <img id="inspeccionesImage" alt="Mostrar / Ocultar Panel" class="MakeClear" src="Images/IconHide16Dark.gif"
                    title="Mostrar / Ocultar Panel" /></div>
                <div id="inspeccionesData">
                  <div id='inspeccionesGrid' class="PanelInset" style="height: 150px">
                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="DataTable"
                      DataSourceID="odsInspecciones" OnRowDataBound="GridView1_RowDataBound" BorderStyle="Solid"
                      Width="876px" OnRowUpdating="GridView1_RowUpdating">
                      <Columns>
                        <asp:TemplateField HeaderText="Inspecci&#243;n" SortExpression="numeInspeccion">
                          <ItemStyle Width="300px" />
                          <ItemTemplate>
                            <div style="padding: 1px;">
                              <table border="0" cellpadding="0" cellspacing="0" style="width: 300px">
                                <tr>
                                  <td style="font-weight: bold; width: 43px">
                                    Código</td>
                                  <td colspan="3">
                                    <asp:Label ID="Label4" runat="server" Text='<%# Eval("numeInspeccion") %>'></asp:Label></td>
                                </tr>
                                <tr>
                                  <td style="font-weight: bold; width: 43px">
                                    Placa</td>
                                  <td style="width: 65px">
                                    <asp:Label ID="Label5" runat="server" Text='<%# Eval("placa") %>'></asp:Label></td>
                                  <td style="font-weight: bold; width: 40px">
                                    Estado</td>
                                  <td style="width: 129px">
                                    <asp:Label ID="Label6" runat="server" Text='<%# Eval("estadoInspeccion") %>'></asp:Label></td>
                                </tr>
                                <tr>
                                  <td style="font-weight: bold; width: 43px">
                                    Fecha</td>
                                  <td style="width: 65px">
                                    <asp:Label ID="Label7" runat="server" Text='<%# Eval("finspeccion", "{0:d}") %>'></asp:Label></td>
                                  <td style="width: 40px">
                                    <asp:Label ID="Label8" runat="server" Text='<%# Eval("HoraInicio", "{0:HH:mm}") %>'></asp:Label></td>
                                  <td style="width: 129px">
                                    <asp:Label ID="Label9" runat="server" Text='<%# Eval("HoraFin", "{0:HH:mm}") %>'></asp:Label></td>
                                </tr>
                              </table>
                            </div>
                          </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Inspector" SortExpression="Inspector">
                          <EditItemTemplate>
                            <asp:TextBox ID="asbInspector" notooltip="notooltip" autocomplete="off" runat="server"
                              CssClass="FormText" Width="180px" Text='<%# Eval("persona") %>'></asp:TextBox><br />
                            <div class="asbMenu" style="visibility: hidden" id="asbInspectorDiv" runat="server">
                            </div>
                            <asp:HiddenField ID="asbInspector_SelectedValue" runat="server" Value='<%# Bind("inspectorId") %>' />
                            <asp:HiddenField ID="hdfCitaId" runat="server" Value='<%# Bind("citaId") %>' />
                            <asp:HiddenField ID="hdfInspeccionId" runat="server" Value='<%# Bind("inspeccionId") %>' />
                          </EditItemTemplate>
                          <ItemTemplate>
                            <asp:Label ID="Label3" runat="server" Text='<%# Eval("persona") %>'></asp:Label>
                          </ItemTemplate>
                          <HeaderStyle Width="120px" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Direcci&#243;n" SortExpression="Direccion">
                          <EditItemTemplate>
                            <asp:TextBox notooltip="notooltip" ID="txtDireccion" runat="server" CssClass="FormText"
                              Text='<%# Bind("direccion") %>' Width="180px"></asp:TextBox>
                          </EditItemTemplate>
                          <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("Direccion") %>'></asp:Label>
                          </ItemTemplate>
                          <HeaderStyle Width="150px" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Ubigeo" SortExpression="UbigeoText">
                          <EditItemTemplate>
                            <asp:TextBox ID="asbUbigeo" notooltip="notooltip" runat="server" autocomplete="off"
                              CssClass="FormText" Text='<%# Eval("depprodis") %>' Width="180px"></asp:TextBox><br />
                            <div class="asbMenu" style="visibility: hidden" id="asbUbigeoDiv" runat="server">
                            </div>
                            <asp:HiddenField ID="asbUbigeo_SelectedValue" runat="server" Value='<%# Bind("ubigeoId") %>' />
                          </EditItemTemplate>
                          <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Eval("depprodis") %>'></asp:Label>
                          </ItemTemplate>
                          <HeaderStyle Width="150px" />
                        </asp:TemplateField>
                        <asp:TemplateField ShowHeader="False" HeaderText="Acci&#243;n">
                          <EditItemTemplate>
                            <asp:ImageButton ID="ImageButton5" OnClientClick="doGridCommand();return false" action="Update"
                              rowIndex='<%# num %>' CommandName="Update" notooltip="notooltip" runat="server"
                              ImageUrl="~/Images/btnGuardarGrilla.jpg" />
                            <asp:ImageButton OnClientClick="doGridCommand();return false" action="Cancel" rowIndex='<%# num++ %>'
                              ID="exitImageButton" notooltip="notooltip" runat="server" ImageUrl="~/Images/IconExit.gif"
                              CommandName="Cancel" />
                          </EditItemTemplate>
                          <ItemTemplate>
                            <asp:ImageButton OnClientClick="doGridCommand();return false" action="Edit" rowIndex='<%# num++ %>'
                              ID="editarImageButton" notooltip="notooltip" runat="server" CommandName="Edit"
                              ImageUrl="~/Images/IconEdit.gif" ToolTip="Editar Inspección" Visible="False" />
                            <asp:HyperLink notooltip="notooltip" ID="frustrarHyperLink" doShow='show' MenuDropDownType='frustrar'
                              InsId='<%# Eval("inspeccionId") %>' SolId='<%# Eval("solicitudId") %>' CitaId='<%# Eval("citaId") %>'
                              runat="server" ImageUrl="~/Images/IconFrustrar.gif" Visible="False" NavigateUrl="#">Frustrar Inspección</asp:HyperLink>
                            <asp:HyperLink notooltip="notooltip" doShow='show' MenuDropDownType='reprogramar'
                              InsId='<%# Eval("inspeccionId") %>' SolId='<%# Eval("solicitudId") %>' ID="reprogramarHyperLink"
                              insp='<%# Eval("persona") %>' inspId='<%# Eval("inspectorId") %>' contacto='<%# Eval("contacto") %>'
                              telefonocontacto='<%# Eval("telefonocontacto") %>' runat="server" fInsp='<%# Eval("finspeccion", "{0:d}") %>'
                              hIni='<%# Eval("HoraInicio", "{0:HH:mm}") %>' hFin='<%# Eval("HoraFin", "{0:HH:mm}") %>'
                              ubigeoId='<%# Eval("ubigeoId") %>' ubigeo='<%# Eval("depprodis") %>' direccion='<%# Eval("Direccion") %>'
                              ImageUrl="~/Images/IconProgramar.gif" Visible="False" NavigateUrl="#">Reprogramar Inspección</asp:HyperLink>
                            <asp:HyperLink notooltip="notooltip" doShow='show' MenuDropDownType='anular' InsId='<%# Eval("inspeccionId") %>'
                              SolId='<%# Eval("solicitudId") %>' ID="anularHyperLink" runat="server" ImageUrl="~/Images/IconAnular.gif"
                              NavigateUrl="#" onclick="return false;">Anular Inspección</asp:HyperLink>
                          </ItemTemplate>
                          <ItemStyle HorizontalAlign="Right" />
                        </asp:TemplateField>
                      </Columns>
                      <RowStyle CssClass="ItemStyle" />
                      <HeaderStyle CssClass="HeaderStyle" />
                    </asp:GridView>
                  </div>
                  <cc3:xWebPanelControl PermissionToCheck="AGENDA_REGISTRAR_CITA_COMUNICACION" ID="XWebPanelControl1"
                    runat="server">
                    <div id="accionPanel" style="margin-top: 3px">
                      <input id="Button2" class="FormButton" type="button" value="Agendar inspecciones"
                        onclick="return Button2_onclick()" />
                    </div>
                  </cc3:xWebPanelControl>
                </div>
                <asp:ObjectDataSource ID="odsInspecciones" runat="server" SelectMethod="GetData"
                  TypeName="dsAgendaTableAdapters.proc_Car_InspeccionesPorSolicitudParaAgendarTableAdapter"
                  OldValuesParameterFormatString="" OnSelecting="odsInspecciones_Selecting" UpdateMethod="Update"
                  OnSelected="odsInspecciones_Selected">
                  <SelectParameters>
                    <asp:QueryStringParameter Name="solicitudId" QueryStringField="SolicitudId" Type="Decimal" />
                  </SelectParameters>
                  <UpdateParameters>
                    <asp:Parameter Name="citaId" Type="Decimal" />
                    <asp:Parameter Name="inspectorId" Type="Decimal" />
                    <asp:Parameter Name="direccion" Type="String" />
                    <asp:Parameter Name="ubigeoId" Type="String" />
                    <asp:Parameter Name="inspeccionId" Type="Decimal" />
                    <asp:Parameter Name="uupdate" Type="String" />
                  </UpdateParameters>
                </asp:ObjectDataSource>
              </div>
              <div id="agendaPanel" class="PanelStyle" style="margin-top: 4px;" runat="server">
                <div class="PanelEncabezado">
                  <asp:Label ID="agendaLabel" runat="server" Text="Agenda - Martes 10 de Octubre de 2006"
                    Style="cursor: default" ToolTip="Mostrar / Ocultar Panel"></asp:Label>
                  <img id="agendaImage" alt="Mostrar / Ocultar Panel" class="MakeClear" src="Images/IconHide16Dark.gif"
                    title="Mostrar / Ocultar Panel" /></div>
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
                            Width="80px" WcStyleSheet="calendar-brown.css" ShowOthers="True" WeekNumbers="True"></cc2:WebCalendar>
                          <asp:Button ID="btnGo" runat="server" CssClass="FormButton" Text="Ir" ToolTip="Ir al Día señalado"
                            OnClientClick="doRefreshTimeInterval();return false;" /></td>
                        <td style="width: 35px; height: 17px;">
                          <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/Images/Previous.gif"
                            ToolTip="Ver un día anterior" OnClick="ImageButton1_Click" OnClientClick="doCommand('yesterday');return false;" />
                          <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="~/Images/Next.gif" ToolTip="Ver siguiente día"
                            OnClientClick="doCommand('tomorrow');return false;" OnClick="ImageButton2_Click" /></td>
                        <td style="width: 83px; height: 17px">
                          &nbsp;<asp:DropDownList ID="cbxIntervalo" runat="server" CssClass="FormText" Height="16px"
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
                            OnFocusShowAll="True" ResourcesDir="./Scripts/asb_includes" Width="200px" OnTextChanged="asbInspectores_TextChanged"
                            MaxSuggestChars="15"></cc1:AutoSuggestBox></td>
                        <td style="height: 17px">
                          <input id="Button3" class="FormButton" type="button" value="Filtrar" onclick="doRefreshTimeInterval();return false;" />
                        </td>
                        <td style="height: 17px">
                          <input id="Button4" class="FormButton" type="button" value="Imprimir itinerarios"
                            onclick="Itinerario();" />
                        </td>
                      </tr>
                    </table>
                  </div>
                  <div>
                    <div id='pnlAgenda' class="PanelInset" style="padding: 5px; position: relative; height: 431px;">
                      <rw:ScheduleGeneral ID="Schedule1" runat="server" GridLines="None" DataRangeStartField="BeginTime"
                        DataRangeEndField="EndTime" TitleField="Inspector" Layout="Vertical" CellSpacing="0"
                        DataSourceID="odsAgenda" EndOfTimeScale="20:00:00" HorizontalAlign="NotSet" ItemStyleField=""
                        StartOfTimeScale="09:00:00" DataKeyNames="ID" FullTimeScale="True" OnItemDataBound="Schedule1_ItemDataBound"
                        OnItemCommand="Schedule1_ItemCommand1">
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
                          <div class="<%# GetCssClass(Eval("frustrada")) %> INSTOOLTIP" frustrada='<%# Eval("frustrada") %>'
                            numesolicitud='<%#Eval("numeSolicitud")%>' contacto='<%#Eval("contacto") %>' telefono='<%#Eval("telefonocontacto") %>'
                            direccion='<%#Eval("direccion") %>' asegurado='<%#Eval("CitaCon")%>' distrito='<%#Eval("depprodis") %>'
                            style="height: 400%; width: 100%; vertical-align: top;">
                            <asp:LinkButton ID="link" runat="server" CommandArgument='<%# Eval("InspeccionId") %>'
                              CommandName="showAgendaForSolicitud" InspeccionId='<%#Eval("InspeccionId")%>'>
                              <%#Eval("CitaCon")%> - <%# getEventTime(Eval("BeginTime"),Eval("EndTime")) %> </asp:LinkButton>
                          </div>
                        </ItemTemplate>
                        <EmptyDataTemplate>
                          No hay citas registradas para esta fecha
                        </EmptyDataTemplate>
                      </rw:ScheduleGeneral>
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
    <uc1:ucAnularInspeccion ID="UcAnularInspeccion1" runat="server" TriggerId="inspeccionesGrid">
    </uc1:ucAnularInspeccion>
    <div id="tooltipcita" class="holder">
      <table border="0" cellpadding="1" cellspacing="0">
        <tr>
          <td style="font-weight: bold;">
            Nº Solicitud</td>
          <td style="font-weight: bold">
            :</td>
          <td>
            <span id='sp_numsol'>NUMSOL</span></td>
        </tr>
        <tr>
          <td style="font-weight: bold">
            Asegurado</td>
          <td style="font-weight: bold">
            :</td>
          <td>
            <span id='sp_asegurado'>asegurado</span></td>
        </tr>
        <tr>
          <td style="font-weight: bold; height: 14px;">
            Contacto</td>
          <td style="font-weight: bold; height: 14px;">
            :</td>
          <td style="height: 14px">
            <span id='sp_contacto'>contacto</span></td>
        </tr>
        <tr>
          <td style="font-weight: bold">
            Teléfono</td>
          <td style="font-weight: bold">
            :</td>
          <td>
            <span id='sp_telef'>telefono</span></td>
        </tr>
        <tr>
          <td style="font-weight: bold">
            Dirección</td>
          <td style="font-weight: bold">
            :</td>
          <td>
            <span id='sp_direccion'>direccion</span></td>
        </tr>
        <tr>
          <td style="font-weight: bold">
            Ubigeo</td>
          <td style="font-weight: bold">
            :</td>
          <td>
            <span id='sp_distrito'>NUMSOL</span></td>
        </tr>
      </table>
    </div>
    <asp:ObjectDataSource ID="odsAgenda" runat="server" OldValuesParameterFormatString="original_{0}"
      SelectMethod="GetData" TypeName="dsAgendaTableAdapters.CitasCoordinadasTableAdapter">
      <SelectParameters>
        <asp:ControlParameter ControlID="asbInspectores" DefaultValue="1" Name="inspectorId"
          PropertyName="SelectedValue" Type="Int32" />
        <asp:ControlParameter ControlID="wccDateToShow" DefaultValue="10/01/2007" Name="fecha"
          PropertyName="Text" Type="DateTime" />
      </SelectParameters>
    </asp:ObjectDataSource>
    <uc3:ucFrustrar ID="UcFrustrar1" runat="server" TriggerId="inspeccionesGrid" />
    <uc2:ucReprogramarInspeccion ID="UcReprogramarInspeccion1" runat="server" TriggerId="inspeccionesGrid">
    </uc2:ucReprogramarInspeccion>
    <uc5:ucListaComunicaciones ID="UcListaComunicaciones1" runat="server" TriggerBtn="inspeccionesGrid" />
  </form>
</body>
</html>
