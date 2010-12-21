<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ucListaComunicaciones.ascx.cs" Inherits="ucListaComunicaciones" %>
<div id='scripts' runat="server">

  <script type="text/javascript">    
    var __ucListaComunicacionxMenu;            
    
    function __uc_cleaningFunction() {
      $('<%=ClientID %>_divGridComunicacion').innerHTML = '';
    }
    function __uc_createDropDownMenu() {
      __ucListaComunicacionxMenu = new xDropDownMenu(
                      '<%= ClientID %>_ToolTipInspeccion',       //el div que aparecerá en el punto de click
								      '<%= TriggerBtn %>', //el "map" area que contiene los hotspots que provocarán que aparezca el PopUpForm
								      'context',		 //Se muestra en el punto de click ('d' = dropDownMenu,null = en el punto de click, 'context' = menu contextual
								      'click',			 //el evento al que queremos asociar la aparición del Div
								      null,			 	 //posicion en la que queremos que aparezca el div, 'left', 'right' o null solo tiene sentido cuando el menu es tipo 'd'
								      ucLista_onDisplayMenu,
								      null,
								      null,
								      __uc_cleaningFunction								      
								      );//,	onAutoHide);
    }    
        
    function ucLista_onDisplayMenu(e,xMenu){
			xMenu.doShow = false;
			var xE = new xEvent(e);
  		var theTrigger = xE.target;
  		if (CCSOL.DOM.x_GetAttribute(theTrigger,'notooltip') != null) {
  		  if (CCSOL.DOM.x_GetAttribute(theTrigger,'notooltip') == 'notooltip') {
  		    xMenu.doShow = false;
  		    return;
  		  }   		   	
  		}
  		if ( CCSOL.DOM.x_GetAttribute(theTrigger.parentNode,'notooltip') != null )  
  		{
  		  xMenu.doShow = false;
  		  return false;
  		}
  		
  		
  		
  		var customRow = __getRow(theTrigger, 5);
  		var inspeccionId = CCSOL.DOM.x_GetAttribute(customRow,'inspeccionId');
  		var contacto = CCSOL.DOM.x_GetAttribute(customRow,'contacto');
  		
  		if (CCSOL.DOM.x_GetAttribute(customRow,'action') == null)  {
  		  xMenu.doShow = false;
  		  return;
  		}
  		if (CCSOL.DOM.x_GetAttribute(customRow,'action')== 'showcomunicacion') {
  		  xMenu.doShow = true;
  		}
  		else {
  		  return;
  		}
  		
  		
  		var context;// = '<div><strong style="font-size: 11px">Contacto de Inspección : ' + contacto + '</strong><br/></div>';
   
  		   // alert(contacto);
			<%=this.Page.ClientScript.GetCallbackEventReference(this.callback_gridComunicacion, "inspeccionId", "__doCallback_Comunicacion", "context", "__HandleError", false) %>;       
		}
		
		function __getRow(elemento, maximo){
			if(maximo > 0){
				if(elemento.parentNode.tagName == "TR")
					return elemento.parentNode;
				else
					return __getRow(elemento.parentNode, maximo - 1);
			}
			else
				return null;
		}
	   	  
       
    function __doCallback_Comunicacion(result, context)
    {
      CCSOL.DOM.xHideLoadingMessage();
                  
      var linea=new String(result);            
//      var linea2=new String(context);  
      
      var divGridContainer = $('<%=ClientID %>_divGridComunicacion');
      divGridContainer.innerHTML = linea; 
//      var d = $('<%=ClientID %>_descripcionLabel');
//      d.innerHTML = linea2;                        
            
    }
        
    function __HandleError(message)
    {
      CCSOL.DOM.xHideLoadingMessage();
      alert("[Error] : " + message);
    }
	  
	  xAddEventListener(window,'load',__uc_createDropDownMenu,false);
  </script>

</div>


<div runat="server" id="ToolTipInspeccion" class="ToolTip" style="font-size:10px;position: absolute; width: 280px;">     
      <div id="divGridComunicacion" runat="server">
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
          <HeaderStyle BorderColor="Black" BorderWidth="1px" BorderStyle="Solid" Font-Bold="True"
            Font-Names="Arial" Font-Size="8pt" ForeColor="Black" />
          <RowStyle BorderColor="Black" />
        </asp:GridView>
      </div>
    </div>
    
    