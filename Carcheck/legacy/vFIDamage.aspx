<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vFIDamage.aspx.cs" Inherits="vFIDamage" %>

<%@ Register Src="ucHeader.ascx" TagName="ucHeader" TagPrefix="uc1" %>
<%@ Register Src="~/ucControlTab.ascx" TagName="ControlTab" TagPrefix="uc2" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
	<title>Carcheck | Inspección | Daños</title>
	<link href="Css/layout.css" rel="stylesheet" type="text/css" />
	<link href="Css/layoutTabs.css" rel="stylesheet" type="text/css" />

	<script type="text/javascript" src="Scripts/lib/CollapsibleDiv.js"></script>

	<script type="text/javascript" src="Scripts/lib/x.js"></script>

	<script type="text/javascript" src="Scripts/lib/x_common.js"></script>

	<script type="text/javascript" src="Scripts/lib/x_especialTooltip.js"></script>

	<script type="text/javascript" src="Scripts/lib/xDropDownMenu.js"></script>

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
            result = CarCheck.Gestores.GestorInspeccion.DamageUpdate('<%= vehiculoId %>', ubicacionDamageId, $('damageFormView_descripcionTextBox').value, 'AYOPLAC');
        }
        else if (accion == 'Insert') {
			ubicacionDamageId = $('damageFormView_ubicacionDamageIdCombo').value;
            result = CarCheck.Gestores.GestorInspeccion.DamageInsert('<%= vehiculoId %>', ubicacionDamageId, $('damageFormView_descripcionTextBox').value, 'AYOPLAC');
        }
        else if(accion == 'Delete'){
		    xE = new xEvent(e);
		    ubicacionDamageId = CCSOL.DOM.x_GetAttribute(xE.target,'ubicacionDamageId');
            result = CarCheck.Gestores.GestorInspeccion.DamageDelete('<%= vehiculoId %>', ubicacionDamageId);
			$('popUpForm').data.descripcion = '';
        }
        
        result = null;      
        $('popUpForm').style.display  = 'none';
		CCSOL.DOM.x_SetAttribute($('area_' + ubicacionDamageId),'descripcion', $('popUpForm').data.descripcion);
        
        damageListBind();
      }
    }    
    /***************************************************************************/
	/* damageListBind : llamada al metodo CallBack que actualizará 
	        la lista de daños
	/****************************************************************************/        
    function damageListBind(){
      var context = 'damageGridViewBind';
      var arg = '';
      <%= ClientScript.GetCallbackEventReference(damageListCallBack, "arg", "damageListBindResult", "context", "HandleError", false) %>
    }    
    /***************************************************************************/
	/* damageListBindResult : handler para los resultados de la llamada al 
	    CallBack damageListBind 
	/****************************************************************************/        
    function damageListBindResult(result, context){
      $('damageListPanel').innerHTML = result;
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
          <%= ClientScript.GetCallbackEventReference(damageCallBack, "arg", "damageFormViewBindResult", "context", "HandleError", false) %>
    }
    /***************************************************************************/
	/* damageFormViewBindResult(result, context) : funcion que se ejecuta como
	       resultado de la llamada CallBack damageFormViewBind
	/***************************************************************************/	    
    function damageFormViewBindResult(result, context){
          $('damagePanel').innerHTML        = result;
		  $('damagePanel').style.display        = 'inline';
		  
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
    }
	/****************************************************************************/
	/* onDisplayMenu(e) : se Ejecuta al Mostrar el MenuEmergente, permite 
	                      ejecutar cualquier funcion o manipular el DOM al 
	                      mostrar el menu.
	/****************************************************************************/
	function onDisplayMenu(e) {
		  xE = new xEvent(e);		
		  //sobre q elemento se ha hecho click
		  var theTrigger = xE.target;
		  	
		  
		  $('damagePanel').style.display = 'none';
		  $('damageLoadingPanel').style.display = 'inline';
		  
		  damageFormViewBind(CCSOL.DOM.x_GetAttribute(theTrigger,'ubicacionDamageId'));
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
  		var xE = new xEvent(e);
		$('ubicacionDamageLabel').innerText = CCSOL.DOM.x_GetAttribute(xE.target,'ubicacionDamage');				
		var descripcion = CCSOL.DOM.x_GetAttribute(xE.target,'descripcion');				
		$('descripcionLabel').style.display = (descripcion != '')?'inline':'none';			
		$('descripcionLabel').innerText = descripcion;	
					
	}		  
	/***************************************************************************/
	/* onMouseClicFromHotSpots(e) : elimina el efecto de los hotSpots
	/****************************************************************************/	  
	function onMouseClic(e) {	
	  //anulo la función de los links normales	
	  xStopPropagation(e);
	  return false;
	}	  

	/********************************************************************************/
	/* window.onload() : función que dispara los objetos javascript en esta página:
	                     Es útil y conveniente hacerlo en este evento, porque en este
	                     punto el navegador ya ha creado todos los objetos del DOM
	/********************************************************************************/	  
    window.onload = function () {
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
		      var xMenu = new xDropDownMenu('popUpForm',	    // el div que aparecerá en el punto de click
									        'damageMap',	    // el "map" area que contiene los hotspots que provocarán que aparezca el PopUpForm
									        'context',			// Se muestra en el punto de click ('d' = dropDownMenu,null = en el punto de click, 'context' = menu contextual
									        'click',			// el evento al que queremos asociar la aparición del Div
									        null,			 	// posicion en la que queremos que aparezca el div, 'left', 'right' o null solo tiene sentido cuando el menu es tipo 'd'
									        onDisplayMenu,	    // evento que se ejecuta al mostrarse el div
										    onAutoHide          // evento que se llama al ocurrir un mouseout 
									        );

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
	</script>

</head>
<body>
	<form id="form1" runat="server">
		<div>
			<table id="Data" border="0" cellpadding="0" cellspacing="0" align="center">
				<tr>
					<td>
						<uc1:ucHeader ID="UcHeader1" runat="server" />
						<uc2:ControlTab ID="ControlTab1" runat="server" LabelText="Inspección: INS - 001 - XXX"
							TabActual="Damage" />
						<div class="DataContent">
							<div class="DataContentRight" style="padding-top: 1px">
								<div class="PanelStyle">
									<div class="PanelEncabezado">
										<asp:Label ID="damageLabel" runat="server" Text="Daños"></asp:Label>
										<img id="damageImage" alt="Mostrar / Ocultar Panel" onmouseout="MakeClear(this,0)"
											onmouseover="MakeClear(this,1);" src="Images/IconHide16Dark.gif" title="Mostrar / Ocultar Panel" /></div>
									<div id="damageData" style="background-color: White; text-align: center; height: 100%;"
										class="PanelInset">
										<img src="Images/AutoDamage.jpg" usemap="#damageMap" alt="" style="border: 0px" />
									</div>
									<map id="damageMap" name="damageMap">
										<area id="area_1" ubicaciondamageid="1" ubicaciondamage="Parabrisas delatero" descripcion=""
											shape="poly" coords="249,263,251,275,248,302,307,306,310,295,317,282,315,266,249,263"
											href="#" />
										<area id="area_2" ubicaciondamageid="2" ubicaciondamage="Parabrisas posterior" descripcion=""
											shape="poly" coords="181,255,178,279,192,302,246,305,248,287,248,274,243,261,190,258,181,255"
											href="#" />
										<area id="area_3" ubicaciondamageid="3" ubicaciondamage="Parachoque delantero" descripcion=""
											shape="poly" coords="320,301,321,294,326,288,332,283,339,282,346,283,352,288,357,294,358,301,357,308,352,314,346,319,339,320,332,319,326,314,321,308,320,301,320,301"
											href="#" />
										<area id="area_4" ubicaciondamageid="4" ubicaciondamage="Parachoque posterior" descripcion=""
											shape="circle" coords="166,300, 20" href="#" />
										<area id="area_5" ubicaciondamageid="5" ubicaciondamage="" descripcion="" shape="poly"
											coords="185,230,180,236,183,250,189,254,217,257,236,258,230,232,185,230" href="#" />
										<area id="area_6" ubicaciondamageid="6" ubicaciondamage="" descripcion="" shape="poly"
											coords="240,232,248,259,311,263,312,256,289,243,256,231,240,232" href="#" />
										<area id="area_7" ubicaciondamageid="12" ubicaciondamage="" descripcion="" shape="poly"
											coords="266,128,266,195,321,212,337,186,338,155,337,135,330,118,322,111,266,128"
											href="#" />
										<area id="area_8" ubicaciondamageid="8" ubicaciondamage="" descripcion="" shape="poly"
											coords="142,118,144,209,163,198,164,125,142,118" href="#" />
										<area id="area_9" ubicaciondamageid="9" ubicaciondamage="" descripcion="" shape="poly"
											coords="63,212,65,227,75,225,76,213,63,212" href="#" />
										<area id="area_10" ubicaciondamageid="10" ubicaciondamage="" descripcion="" shape="poly"
											coords="63,91,62,105,72,110,80,98,63,91" href="#" />
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
													<asp:Image ID="deleteImage" runat="server" onClick="javascript:DamageAccion('Delete', event)"
														Style="cursor: pointer" ubicacionDamageId='<%# Eval("ubicacionDamageId") %>' ImageUrl="~/Images/IconDelete.gif"
														ToolTip="Eliminar registro" />
												</ItemTemplate>
											</asp:TemplateField>
										</Columns>
									</asp:GridView>
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
											<asp:QueryStringParameter Name="vehiculoId" QueryStringField="VehiculoId"
												Type="Decimal" />
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
						<asp:Panel ID="controlPanel" runat="server" Width="100%">
							<div class="DataTop">
								<div class="DataTopLeft">
								</div>
								<div class="DataTopRight">
								</div>
							</div>
							<div class="DataContent">
								<div class="DataContentRight" style="height: 24px;">
									<div style="float: left">
										<asp:ImageButton ID="guardarImageButton" runat="server" ImageUrl="~/Images/IconSave48Dark.gif"
											ToolTip="Guardar Datos" CssClass="Button48Left" onmouseout="MakeClear(this,0)"
											onmouseover="MakeClear(this,1);" />
										<asp:ImageButton ID="anularImageButton" runat="server" ImageUrl="~/Images/IconAnul48Dark.jpg"
											ToolTip="Anular Inspección" CssClass="Button48Left" onmouseout="MakeClear(this,0)"
											onmouseover="MakeClear(this,1);" />
									</div>
									<div style="float: right">
										<asp:ImageButton ID="terminarImageButton" runat="server" ImageUrl="~/Images/btnTerminarInspeccion.jpg"
											ToolTip="Terminar Inspección" onmouseout="MakeClear(this,0)" onmouseover="MakeClear(this,1);"
											Visible="False" />
										<asp:ImageButton ID="aprobarImageButton" runat="server" ImageUrl="~/Images/IconApprove48.jpg"
											ToolTip="Aprobar Inspección" onmouseout="MakeClear(this,0)" onmouseover="MakeClear(this,1);" />
										<asp:ImageButton ID="desaprobarImageButton" runat="server" ImageUrl="~/Images/IconReject48.jpg"
											ToolTip="Aprobar Inspección sin pago a ajustador" onmouseout="MakeClear(this,0)"
											onmouseover="MakeClear(this,1);" />
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
													<asp:TextBox ID="descripcionTextBox" runat="server" CssClass="FormText" Rows="6"
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
										<asp:QueryStringParameter DefaultValue="1" Name="vehiculoId" QueryStringField="vid"
											Type="Decimal" />
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
				This is a holder for a value
			</h5>
			<p id="descripcionLabel" style="text-transform: lowercase">
				This div is supposed to be floating all over the page, where you pass your mouse
				over a image on a link tag ('a')</p>
		</div>
	</form>
</body>
</html>
