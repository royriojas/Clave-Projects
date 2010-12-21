<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vFIDamage.aspx.cs" Inherits="vFIDamage" %>

<%@ Register Src="ucAnularInspeccion.ascx" TagName="ucAnularInspeccion" TagPrefix="uc3" %>
<%@ Register Assembly="CustomPanelWebControl" Namespace="xWebControl" TagPrefix="cc3" %>
<%@ Register Src="ucHeader.ascx" TagName="ucHeader" TagPrefix="uc1" %>
<%@ Register Src="~/ucControlTab.ascx" TagName="ControlTab" TagPrefix="uc2" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
  <title>
    <%=CCSOL.Utiles.Utilidades.GetSystemNameAndVersion() %>
    | Inspección | Daños</title>
  <link href="Css/layout.css" rel="stylesheet" type="text/css" />
  <link href="Css/layoutTabs.css" rel="stylesheet" type="text/css" />

  <script type="text/javascript" src="Scripts/lib/x.js"></script>

  <script type="text/javascript" src="Scripts/lib/x_common.js"></script>

  <script type="text/javascript" src="Scripts/lib/xDropDownMenu.js"></script>

  <script type="text/javascript" src="./Scripts/Draw/wz_jsgraphics.js"></script>

  <script type="text/javascript">
	
	
	function XY_coords(str_coords) {
	  this.X_array = new Array();
		this.Y_array = new Array();
		
		var XY_arr = str_coords.split(",");
		if (XY_arr) {
		  var count = 0;
		  if (XY_arr.length & 2 == 0) {
				  count = XY_arr.length 
			  }
			  else {
				  count = XY_arr.length - 1;
			  }
		  for (var ix = 0; ix < count; ix++) {
				  if (ix % 2) {
					  var theY = parseInt(XY_arr[ix]);
					  this.Y_array.push(theY);					
				  }
				  else {
					  var theX = parseInt(XY_arr[ix]);
  					this.X_array.push(theX);
				  }				
			  }
		}		
	}
	
	
	var lastMap = null;
	function doMouseOver(e) {
		var xe = new xEvent(e);
		if (xe.target.nodeName == 'AREA') {
			if (lastMap != xe.target) jg.clear();
			lastMap = xe.target;
			var coords = CCSOL.DOM.x_GetAttribute(xe.target,'coords');
			createOver(coords,jg,'#FF0000');
		}
		else 
			lastMap = null;
		
	}
	function XY_Array(str_coords) {
		/*this.X_array = new Array();
		this.Y_array = new Array();*/
		this.x = null;
		this.y = null;
		
		var XY_arr = str_coords.split(",");
		if (XY_arr) {
			var top = 100000;
			var left = 100000;
			var l_top = 0;
			var l_left = 0;
			var count = 0;
			if (XY_arr.length & 2) {
				count = XY_arr.length 
			}
			else {
				count = XY_arr.length - 1;
			}			
			for (var ix = 0; ix < count; ix++) {
				if (ix % 2) {
					var theY = parseInt(XY_arr[ix]);
					if (theY < top) {
						top = theY;	
					}	
					if (theY > l_top) {
						l_top = theY;
					} 					
				}
				else {
					var theX = parseInt(XY_arr[ix]);
					if (theX < left) {
						left = theX;	
					}
					if (theX > l_left) {
						l_left = theX;	
					}
				}				
			}
			this.x = left + parseInt(Math.abs(l_left - left) / 2);
			this.y = top + parseInt(Math.abs(l_top - top) / 2);
			CCSOL.Utiles.Trace('Las Coordenadas menores son : ' + this.x + ',' + this.y);
		}								
	}
	
	function markAllMaps() {
	  var xMaps = null;
	  jg2.clear();
		var xMaps = xGetElementsByTagName('AREA',$('damageMap'));
		if (xMaps != null) {
			for (var ix = 0; ix < xMaps.length; ix++) {
				var isFilled = CCSOL.DOM.x_GetAttribute(xMaps[ix],'descripcion');
				
				if (isFilled != '') {
					var coords = CCSOL.DOM.x_GetAttribute(xMaps[ix],'coords');
					createOver(coords,jg2);
				}
			}
		}
	}
	
	var jg = null;
	var jg2 = null;
	function initGraphics() {
	    jg = new jsGraphics("theCanvas");
		  jg2 = new jsGraphics("theCanvas");
		/*  jg.setColor("#ff0000"); // red
		  jg.drawLine(0, 0, 10, 10); // co-ordinates related to "myCanvas"
		  ; // blue
		  jg.fillRect(10, 10, 20, 20);*/
		 
		  /*var coords='225,189,351,187,355,216,356,234,354,255,347,280,248,281,223,276,219,250,220,220,158';
		   
		  createOver(coords,jg);*/
		 	
		  xAddEventListener($('theCanvas'),'mouseover',doMouseOver,true);		  
		  markAllMaps();
	}
	function createOver(coords,jg,color) {
		 //if (!color) color = '#00FF00'
		 if (jg != null) {
			 var XY_arr = new XY_Array(coords);
//			 
//			  jg.setStroke(2); 	  
//			  /*jg.setColor("#FFFFCC")
//			  jg.fillEllipse(XY_arr.x, XY_arr.y, 10, 10); */
////(XY_arr.X_array, XY_arr.Y_array); 
//			  jg.setColor(color);
//			  jg.drawEllipse(XY_arr.x, XY_arr.y, 10, 10);
////(XY_arr.X_array, XY_arr.Y_array);
//				
//			  jg.paint();
        //jg.setStroke(3); 	  
			  //jg.setColor(color)
//			  jg.fillEllipse(XY_arr.x, XY_arr.y, 10, 10); */
////(XY_arr.X_array, XY_arr.Y_array); 
//			  jg.setColor(color);
//			  jg.drawEllipse(XY_arr.x, XY_arr.y, 10, 10);
////(XY_arr.X_array, XY_arr.Y_array);
				//var XY_arr = new XY_coords(coords);
				//jg.drawPolygon(XY_arr.X_array, XY_arr.Y_array);
				
				if (color) jg.drawImage("./Scripts/Draw/pointer.png", XY_arr.x, XY_arr.y, 10, 10);
				else       jg.drawImage("./Scripts/Draw/pointer_bad.png", XY_arr.x, XY_arr.y, 10, 10); 

				
        jg.paint();

		  }
	}
	xAddEventListener(window,'load',initGraphics,false);	
	
  </script>

  <script type="text/javascript">
	
    /***************************************************************************/
	/* damageFormViewValid(accion) : Pide confirmacion en caso se esté
	        pretendiendo borrar el registro
	/****************************************************************************/ 
    function damageFormViewValid(accion){
      if(accion == 'Delete'){
        return confirm('Se eliminara el registro. ¿Desea proseguir?.');
      }else{
        if($('damageFormView_descripcionTextBox').value != ''){
          $('damageFormView_descripcionRFV').style.display = 'none';
          return true;
        }else{
          $('damageFormView_descripcionRFV').style.display = 'inline';
          return false;
        }
      }
    }
    
    /***************************************************************************/
	/* damageListBind : llamada al metodo CallBack que actualizará 
	        la lista de daños
	/****************************************************************************/ 
    function DamageAccion(accion, e){
      if(damageFormViewValid(accion)){
         
        var result;
        var ubicacionDamageId;
         
        if(accion == 'Update'){
			      ubicacionDamageId = $('damageFormView_ubicacionDamageIdCombo').value;
            result = CarCheck.Gestores.GestorInspeccion.DamageUpdate('<%= vehiculoId %>', ubicacionDamageId, $('damageFormView_descripcionTextBox').value.toUpperCase(), '<%= Session["userName"] %>');
                        
            if ($('popUpForm').data != null) $('popUpForm').data.descripcion = $('damageFormView_descripcionTextBox').value;
           
        }
        else if (accion == 'Insert') {
			ubicacionDamageId = $('damageFormView_ubicacionDamageIdCombo').value;
            result = CarCheck.Gestores.GestorInspeccion.DamageInsert('<%= vehiculoId %>', ubicacionDamageId, $('damageFormView_descripcionTextBox').value.toUpperCase(), '<%= Session["userName"] %>');
            if ($('popUpForm').data != null) $('popUpForm').data.descripcion = $('damageFormView_descripcionTextBox').value;
        }
        else if(accion == 'Delete'){
		    xE = new xEvent(e);
		        ubicacionDamageId = CCSOL.DOM.x_GetAttribute(xE.target,'ubicacionDamageId');
            result = CarCheck.Gestores.GestorInspeccion.DamageDelete('<%= vehiculoId %>', ubicacionDamageId);
			      if ($('popUpForm').data != null) $('popUpForm').data.descripcion = '';
        }
        
        result = null;      
        $('popUpForm').style.display  = 'none';
        try {           
        
		      CCSOL.DOM.x_SetAttribute($('Area_' + ubicacionDamageId),'descripcion', $('popUpForm').data.descripcion);
		    }
		    catch(e) {
		      //alert(e.message);
		    }
        
        damageListBind();
      }
    }    
    /***************************************************************************/
	/* damageListBind : llamada al metodo CallBack que actualizará 
	        la lista de daños
	/****************************************************************************/        
    function damageListBind(){
      var context = 'damageGridViewBind';
     CCSOL.DOM.xShowLoadingMessage();
      var arg = '';
      <%= ClientScript.GetCallbackEventReference(damageListCallBack, "arg", "damageListBindResult", "context", "HandleError", false) %>
    }    
    /***************************************************************************/
	/* damageListBindResult : handler para los resultados de la llamada al 
	    CallBack damageListBind 
	/****************************************************************************/        
    function damageListBindResult(result, context){
      CCSOL.DOM.xHideLoadingMessage();
      $('damageListPanel').innerHTML = result;
      //markAllMaps();
      setTimeout('markAllMaps()',500);
    }
    
    /***************************************************************************/
	/* CloseDamagePanel : Cierra el MenuEmergente 
	/****************************************************************************/    
    function CloseDamagePanel(){			
        $('popUpForm').style.display  = 'none';
    }
        
    /***************************************************************************/
	/* HandleError (message): de una llamada a un CallBack que no logre su objetivo
	/****************************************************************************/
    function HandleError(message) {
        alert("[Unhandled error from a CallBack] : \n\n" + message);
    }    
	/***************************************************************************/
	/* damageFormViewBind(damageUbicacionId) : 
	        funcion que realizará la actualizacion del formulario del MenuEmergente.
	        Hace uso de una llamada a un CallBack.
	/****************************************************************************/
	function damageFormViewBind(damageUbicacionId){
          var context = 'damageFormViewBind';
          var arg = damageUbicacionId;
          CCSOL.DOM.xShowLoadingMessage("Obteniendo datos");
          <%= ClientScript.GetCallbackEventReference(damageCallBack, "arg", "damageFormViewBindResult", "context", "HandleError", false) %>
    }
    /***************************************************************************/
	/* damageFormViewBindResult(result, context) : funcion que se ejecuta como
	       resultado de la llamada CallBack damageFormViewBind
	/***************************************************************************/	    
    function damageFormViewBindResult(result, context){
    
          CCSOL.DOM.xHideLoadingMessage();
          $('damagePanel').innerHTML        = result;
		      $('damagePanel').style.display    = 'inline';
		  
		  /* volvemos a poner el loadingPanel oculto y con el texto por defecto */
		     $('damageLoadingLabel').innertText    = 'Obteniendo datos...';
		     $('damageLoadingPanel').style.display = 'none';
		  
		  //guardamos en el objeto data los valores que necesitamos que se queden en memoria para accesarlos 
		  //después desde otros métodos podemos recuperar el ultimo valor guardado en este objeto
		     if (!$('popUpForm').data) $('popUpForm').data = new Object();
		  
		  //Guardamos en el objeto data los datos que nos pueden ser relevantes para validar si ocurrió un cambio 
		  //En el formulario del MenuEmergente
        $('popUpForm').data.ubicacionDamageId = $('damageFormView_ubicacionDamageIdCombo').value;
        $('popUpForm').data.descripcion       = $('damageFormView_descripcionTextBox').value;
        
        //agregamosel comportamiento de cambiar a mayúsculas lo que se escriba en este campo.        
		//alert(typeof(_TextBoxFormats));
		
		if ((_TextBoxFormats != null) && (typeof(_TextBoxFormats) != 'undefined')) _TextBoxFormats.AddTextBoxToWatch('damageFormView_descripcionTextBox');
    }
	/****************************************************************************/
	/* onDisplayMenu(e) : se Ejecuta al Mostrar el MenuEmergente, permite 
	                      ejecutar cualquier funcion o manipular el DOM al 
	                      mostrar el menu.
	/****************************************************************************/
	function onDisplayMenu(e) {
		  var xE = new xEvent(e);		
		  //sobre q elemento se ha hecho click
		  var theTrigger = xE.target;
		  	
		  
		  $('damagePanel').style.display = 'none';
		  $('damageLoadingPanel').style.display = 'inline';
		  try {
		    damageFormViewBind(CCSOL.DOM.x_GetAttribute(theTrigger,'ubicacionDamageId'));
		  }
		  catch(e) {
		    alert('error');
		  }
	}	      
    /***************************************************************************/
	/* onAutoHide(e) : se ejecuta al perder el foco sobre el MenuEmergente, 
	                   si se retorna : true  -> el MenuEmergente se autocerrará
	                                   false -> el MenuEmergente no se autocerrará
	/****************************************************************************/	  		 	    
    function onAutoHide(e) {
    try {
	    if($('popUpForm').data.descripcion == $('damageFormView_descripcionTextBox').value)
			  return true;
	    else
	    	  return false;
	  }
	  catch(e) {
	   
	  }
	  return true;
	}		
	/***************************************************************************/
	/* onToolTipDisplay(e)  : se ejecuta al mostrar el ToolTip, 
	                          permite cambiar el valor del Mensaje que se muestra 
	                          con alguna accion personalizada propia
	/****************************************************************************/	  		 	
	function onToolTipDisplay(e) {		
	try {	
	   
  		var xE = new xEvent(e);
		  $('ubicacionDamageLabel').innerText = CCSOL.DOM.x_GetAttribute(xE.target,'ubicacionDamage');				
		  $('ubicacionDamageLabel').style.textTransform  = 'uppercase';
		  var descripcion = CCSOL.DOM.x_GetAttribute(xE.target,'descripcion');				
		  $('descripcionLabel').style.display = (descripcion != '')?'inline':'none';			
		  $('descripcionLabel').innerText = descripcion;	
		   //$('descripcionLabel').style.textTransform  = 'uppercase';
  }
  catch(e) {
    
  }
					
	}		  
	/***************************************************************************/
	/* onMouseClicFromHotSpots(e) : elimina el efecto de los hotSpots
	/****************************************************************************/	  
	function onMouseClic(e) {	
	  //anulo la función de los links normales	
	  xStopPropagation(e);
	  xPreventDefault(e);
	  return false;
	}	  

   
   CCSOL.Utiles.LoadScript("Scripts/lib/xDropDownMenu.js");
	/********************************************************************************/
	/* window.onload() : función que dispara los objetos javascript en esta página:
	                     Es útil y conveniente hacerlo en este evento, porque en este
	                     punto el navegador ya ha creado todos los objetos del DOM
	/********************************************************************************/	  
    function __InitPage() {
       try {
		      /*
		      asignamos un listener para anular la acción normal de los HOTSPOTS, 
		      de manera normal se comportan como links. Por lo que hay que evitar 
		      que hagan que la página se vaya a algun lado		
		      */		
		      xAddEventListener($('damageMap'),'click',onMouseClic,false);
      		
		      /*
		      Creamos el objeto DropDownMenu, por defecto este objeto se puede usar para mostrar un div, 
		      ya sea como un menu dropdown, o uno contextual, o como en este caso uno que aparece en el punto
		      en que se ha hecho click en la página
		      */
		      if (<%= IsEditable.ToString().ToLower() %>) {
		        var xMenu = new xDropDownMenu('popUpForm',	    // el div que aparecerá en el punto de click
									        'damageMap',	                  // el "map" area que contiene los hotspots que provocarán que aparezca el PopUpForm
									        'context',			                // Se muestra en el punto de click ('d' = dropDownMenu,null = en el punto de click, 'context' = menu contextual
									        'click',			                  // el evento al que queremos asociar la aparición del Div
									        null,			 	                    // posicion en la que queremos que aparezca el div, 'left', 'right' o null solo tiene sentido cuando el menu es tipo 'd'
									        onDisplayMenu,	                // evento que se ejecuta al mostrarse el div
										      onAutoHide                      // evento que se llama al ocurrir un mouseout 
									        );

          }
             /*
             Creamos el objeto que mostrara el tooltip sobre las áreas que se habrán de utilizar como HotSpots
             el último parámetro de este objeto es una funcion que se ejecutara cuando el toolTip este siendo mostrado
             Esto nos permitira, de acuerdo al tooltip sobre el que nos encontremos mostrar la descripcion correspondiente.
             */
    	     var xdamageToolTip = new x_ToolTip('area','damageMap',10,10,'damageToolTip',onToolTipDisplay);
      		 
             /* 
             xCollapsibleDiv : crea un colapsible, para mostrar u ocultar un area al pulsar sobre un botón
             TODO:             Esto fue una buena idea inicialmente pero ya no es tan práctico, pues como pueden haber varios collapsibles en una 
                                   página es más práctico definir un nueva forma de activar los collapsibles, quiza manejandolo con atributos personalizados                                            
             */
             danosCollapsible      = new CollapsibleDiv('damageImage', 'damageData', null, null);
             danosLabCollapsible   = new CollapsibleDiv('damageLabel', 'damageData', null, null);
        }
        catch (e){
             alert('[Error en el evento OnLoad de la página] : ' + e.message);
        }
	}
	xAddEventListener(window,'load',__InitPage,false);
  </script>

  <link href="css/layout.css" rel="stylesheet" type="text/css" />
  <link href="Css/layoutTabs.css" rel="stylesheet" type="text/css" />

  <link href="./Scripts/x_info/xInfo.css" rel="stylesheet" type="text/css" />
</head>
<body>
  <form id="form1" runat="server">
    <div class="Blockable">
      <table id="Data" border="0" cellpadding="0" cellspacing="0" align="center">
        <tr>
          <td>
            <uc1:ucHeader MainFormName="form1" ID="UcHeader1" PageFunctionalityToCheck="INS_DAMAGE_VER"
              runat="server" />
            <uc2:ControlTab ID="ControlTab1" runat="server" LabelText="Inspección: INS - 001 - XXX"
              TabActual="Damage" />
            <div class="DataContent">
              <div class="DataContentRight" style="padding-top: 1px">
                <div class="PanelStyle">
                  <div class="PanelEncabezado">
                    <asp:Label ID="damageLabel" runat="server" Text="Daños"></asp:Label>
                    <img id="damageImage" alt="Mostrar / Ocultar Panel" class="MakeClear" src="Images/IconHide16Dark.gif"
                      title="Mostrar / Ocultar Panel" /></div>
                  <div align="center" id="damageData" style="background-color: White;height:480px;" class="PanelInset">
                    <div id='theCanvas' style="width: 640px; position: relative;">
                      <img src='<%=getImageClase() %>' usemap="#damageMap" alt="" style="border: 0px" />
                    </div>
                  </div>
                  <map id="damageMap" name="damageMap">
                    <asp:Repeater ID="RepeaterCoordenadas" runat="server" DataSourceID="odsDamageCoordenadas">
                      <ItemTemplate>
                        <area id='Area_<%# Eval("ubicacionDamageId") %>' ubicaciondamageid='<%# Eval("ubicacionDamageId") %>'
                          ubicaciondamage='<%# Eval("ubicacionDamage") %>' descripcion='<%# Eval("descripcion") %>'
                          shape="poly" alt="" coords='<%# Eval("coordenada") %>' href="#" />
                      </ItemTemplate>
                    </asp:Repeater>
                  </map>
                </div>
                <div class="PanelEncabezado" style="margin-top: 10px">
                  <asp:Label ID="damageListaLabel" runat="server" Style="cursor: default" Text="Lista de daños"></asp:Label>
                </div>
                <div class="hr">
                </div>
                <div id="damageListPanel">
                  <asp:GridView ID="damageGridView" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                    BorderStyle="Solid" CssClass="GridLista" EmptyDataText="No se encontraron ocurrencias"
                    DataSourceID="odsDamageLista">
                    <RowStyle CssClass="ItemStyle" />
                    <PagerStyle CssClass="PagerStyle" />
                    <HeaderStyle CssClass="HeaderStyle" />
                    <Columns>
                      <asp:BoundField DataField="ubicacionDamage" HeaderText="Ubicaci&#243;n" SortExpression="ubicacionDamage">
                        <ItemStyle Width="200px" />
                      </asp:BoundField>
                      <asp:BoundField DataField="descripcion" HeaderText="Descripci&#243;n" SortExpression="descripcion">
                        <ItemStyle Width="400px" />
                      </asp:BoundField>
                      <asp:TemplateField HeaderText="Acci&#243;n">
                        <ItemStyle HorizontalAlign="Center" />
                        <HeaderStyle Width="50px" />
                        <ItemTemplate>
                          <asp:Image ID="deleteImage" Visible='<%# ShowBeVisibleDeleteImage() %>' runat="server" onClick="javascript:DamageAccion('Delete', event)"
                            Style="cursor: pointer" ubicacionDamageId='<%# Eval("ubicacionDamageId") %>' ImageUrl="~/Images/IconDelete.gif"
                            ToolTip="Eliminar registro" />
                        </ItemTemplate>
                      </asp:TemplateField>
                    </Columns>
                  </asp:GridView>
                  <asp:ObjectDataSource ID="odsDamageCoordenadas" runat="server" OldValuesParameterFormatString="original_{0}"
                    SelectMethod="GetData" TypeName="dsDamageTableAdapters.DamageCoordenadasTableAdapter"
                    OnSelecting="odsDamageCoordenadas_Selecting">
                    <SelectParameters>
                      <asp:Parameter DefaultValue="1" Name="claseVehiculoId" Type="Decimal" />
                      <asp:QueryStringParameter DefaultValue="" Name="vehiculoId" QueryStringField="VehiculoId"
                        Type="Decimal" />
                    </SelectParameters>
                  </asp:ObjectDataSource>
                  <asp:ObjectDataSource ID="odsDamageLista" runat="server" DeleteMethod="Delete" InsertMethod="Insert"
                    OldValuesParameterFormatString="original_{0}" SelectMethod="GetDamageVehiculo"
                    TypeName="dsVehiculoTableAdapters.DamageVehiculoTableAdapter" UpdateMethod="Update">
                    <DeleteParameters>
                      <asp:Parameter Name="Original_vehiculoId" Type="Decimal" />
                      <asp:Parameter Name="Original_ubicacionDamageId" Type="Decimal" />
                    </DeleteParameters>
                    <UpdateParameters>
                      <asp:Parameter Name="Original_vehiculoId" Type="Decimal" />
                      <asp:Parameter Name="Original_ubicacionDamageId" Type="Decimal" />
                      <asp:Parameter Name="uupdate" Type="String" />
                      <asp:Parameter Name="descripcion" Type="String" />
                    </UpdateParameters>
                    <SelectParameters>
                      <asp:QueryStringParameter Name="vehiculoId" QueryStringField="VehiculoId" Type="Decimal" />
                    </SelectParameters>
                    <InsertParameters>
                      <asp:Parameter Name="vehiculoId" Type="Decimal" />
                      <asp:Parameter Name="ubicacionDamageId" Type="Decimal" />
                      <asp:Parameter Name="uupdate" Type="String" />
                      <asp:Parameter Name="descripcion" Type="String" />
                    </InsertParameters>
                  </asp:ObjectDataSource>
                </div>
                <br />
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
                    <cc3:xWebPanelControl ID="XWebPanelControl2" Style="display: inline;" runat="server"
                      PermissionToCheck="INS_ANULAR">
                      <asp:ImageButton ID="anularImageButton" MenuDropDownType="anular" doShow="show" OnClientClick='return false;'
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
            <div id="popUpForm" class="popUpForm" style="padding: 2px; width: 250px; height: 130px;
              text-align: left; display: none">
              <div id="damageLoadingPanel" style="display: none">
                <table border="0" cellpadding="0" cellspacing="0" class="DataTable">
                  <tr>
                    <td>
                      <img src="Images/i_animated_loading_32_2.gif" alt="Obteniendo datos..." />
                    </td>
                    <td id="damageLoadingLabel">
                      Obteniendo datos...</td>
                  </tr>
                </table>
              </div>
              <div id="damagePanel">
                <asp:FormView ID="damageFormView" runat="server" DataKeyNames="vehiculoId,ubicacionDamageId"
                  DataSourceID="odsDamage" DefaultMode="Edit">
                  <EditItemTemplate>
                    <table border="0" cellpadding="0" cellspacing="0" class="DataTable">
                      <tr>
                        <td align="left">
                          <asp:Label ID="ubicacionDamageLabel" runat="server" CssClass="FormLabel" Font-Bold="True"
                            Text='<%# Eval("ubicacionDamage") %>'></asp:Label></td>
                      </tr>
                      <tr>
                        <td align="left" style="height: 18px" valign="bottom">
                          <asp:Label ID="descripcionLabel" runat="server" CssClass="FormLabel" Style="text-transform: none"
                            Text="Descripción del daño"></asp:Label>
                          <asp:Label ID="descripcionRFV" runat="server" Font-Bold="True" ForeColor="Red" Text="(*)"
                            Style="display: none"></asp:Label></td>
                      </tr>
                      <tr>
                        <td align="left">
                          <asp:TextBox ID="descripcionTextBox" runat="server" CssClass="FormText MAYUSC" Rows="6"
                            Text='<%# Bind("descripcion") %>' TextMode="MultiLine" Width="240px"></asp:TextBox></td>
                      </tr>
                      <tr>
                        <td align="right" style="height: 20px">
                          <input runat="server" id="guardarButton" class="FormButton" style="width: 110px"
                            type="button" value="Actualizar daño" onclick="DamageAccion('Update');" />
                          <input id="cancelarButton" class="FormButton" type="button" value="Cancelar" onclick="CloseDamagePanel();"
                            size="20" />
                        </td>
                      </tr>
                    </table>
                    <asp:DropDownList ID="ubicacionDamageIdCombo" runat="server" DataSourceID="odsDamageUbicacion"
                      AppendDataBoundItems="True" DataTextField="ubicacionDamage" DataValueField="ubicacionDamageId"
                      SelectedValue='<%# Bind("ubicacionDamageId") %>' Width="100px" Style="display: none">
                      <asp:ListItem></asp:ListItem>
                    </asp:DropDownList>
                    <asp:ObjectDataSource ID="odsDamageUbicacion" runat="server" OldValuesParameterFormatString="original_{0}"
                      SelectMethod="GetData" TypeName="dsComboTableAdapters.DamageUbicacionComboTableAdapter">
                    </asp:ObjectDataSource>
                  </EditItemTemplate>
                  <InsertItemTemplate>
                    <table border="0" cellpadding="0" cellspacing="0" class="DataTable">
                      <tr>
                        <td align="left">
                          <asp:Label ID="ubicacionDamageLabel" runat="server" CssClass="FormLabel" Font-Bold="True"
                            Text="Ubicacion del daño"></asp:Label></td>
                      </tr>
                      <tr>
                        <td align="left" style="height: 18px" valign="bottom">
                          <asp:Label ID="descripcionLabel" runat="server" CssClass="FormLabel" Style="text-transform: none"
                            Text="Descripción del daño"></asp:Label>
                          <asp:Label ID="descripcionRFV" runat="server" Font-Bold="True" ForeColor="Red" Text="(*)"
                            Style="display: none"></asp:Label></td>
                      </tr>
                      <tr>
                        <td align="left">
                          <asp:TextBox ID="descripcionTextBox" runat="server" CssClass="FormText" Rows="6"
                            Text='<%# Bind("ubicacionDamage") %>' TextMode="MultiLine" Width="240px"></asp:TextBox></td>
                      </tr>
                      <tr>
                        <td align="right" style="height: 20px">
                          <input id="agregarButton" class="FormButton" style="width: 110px" type="button" value="Agregar daño"
                            onclick="DamageAccion('Insert');" />
                          <input id="cancelarButton" class="FormButton" type="button" value="Cancelar" onclick="CloseDamagePanel();"
                            size="20" />
                        </td>
                      </tr>
                    </table>
                    <asp:DropDownList ID="ubicacionDamageIdCombo" runat="server" DataSourceID="odsDamageUbicacion"
                      AppendDataBoundItems="true" DataTextField="ubicacionDamage" DataValueField="ubicacionDamageId"
                      SelectedValue='<%# Bind("ubicacionDamageId") %>' Width="100px" Style="display: none">
                      <asp:ListItem></asp:ListItem>
                    </asp:DropDownList>
                    <asp:ObjectDataSource ID="odsDamageUbicacion" runat="server" OldValuesParameterFormatString="original_{0}"
                      SelectMethod="GetData" TypeName="dsComboTableAdapters.DamageUbicacionComboTableAdapter">
                    </asp:ObjectDataSource>
                  </InsertItemTemplate>
                </asp:FormView>
                <asp:ObjectDataSource ID="odsDamage" runat="server" OldValuesParameterFormatString="original_{0}"
                  SelectMethod="GetData" TypeName="dsVehiculoTableAdapters.DamageVehiculoTableAdapter"
                  OnSelecting="odsDamage_Selecting" DeleteMethod="Delete" InsertMethod="Insert" UpdateMethod="Update">
                  <SelectParameters>
                    <asp:QueryStringParameter Name="vehiculoId" QueryStringField="VehiculoId" Type="Decimal" />
                    <asp:Parameter Name="ubicacionDamageId" Type="Decimal" />
                  </SelectParameters>
                  <DeleteParameters>
                    <asp:Parameter Name="Original_vehiculoId" Type="Decimal" />
                    <asp:Parameter Name="Original_ubicacionDamageId" Type="Decimal" />
                  </DeleteParameters>
                  <UpdateParameters>
                    <asp:Parameter Name="Original_vehiculoId" Type="Decimal" />
                    <asp:Parameter Name="Original_ubicacionDamageId" Type="Decimal" />
                    <asp:Parameter Name="uupdate" Type="String" />
                    <asp:Parameter Name="descripcion" Type="String" />
                  </UpdateParameters>
                  <InsertParameters>
                    <asp:Parameter Name="vehiculoId" Type="Decimal" />
                    <asp:Parameter Name="ubicacionDamageId" Type="Decimal" />
                    <asp:Parameter Name="uupdate" Type="String" />
                    <asp:Parameter Name="descripcion" Type="String" />
                  </InsertParameters>
                </asp:ObjectDataSource>
              </div>
            </div>
          </td>
        </tr>
      </table>
    </div>
    <br />
    <div id="damageToolTip" class="ToolTip">
      <h5 id="ubicacionDamageLabel">
      </h5>
      <p id="descripcionLabel">
      </p>
    </div>
    <uc3:ucAnularInspeccion ID="UcAnularInspeccion1" runat="server" TriggerId="anularImageButton" />
  </form>
</body>
</html>
