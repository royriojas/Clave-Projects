<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ucFrustrar.ascx.cs" Inherits="ucFrustrar" %>


<div id="divScripts" runat="server">
    <script type="text/javascript"> 
    
    function FrustrarInspeccion() {
      return true;
    }
    
    function hideFrustrarDropDown() {
      __xMenuFrustrar.hide();
    }  
    function __onDisplayMenuFrustrar(e, theMenu)
    {
      var xE = new xEvent(e);

      //asumimos que no siempre es posible mostrar el menu
      theMenu.doShow = false;
      //asumimos que por defecto queremos que se ejecute la acción por defecto de los links
      theMenu.doReturn = false;
      //sobre q elemento se ha hecho click
      var theTrigger = xE.target;

      if (theTrigger.parentNode.tagName == "A")
        theTrigger = theTrigger.parentNode;

      var doShow = CCSOL.DOM.x_GetAttribute(theTrigger, 'doShow');
      var isAnular =  CCSOL.DOM.x_GetAttribute(theTrigger, 'MenuDropDownType') == 'frustrar';
      
      $('<%=ClientID %>_hdfInspeccionId').value = CCSOL.DOM.x_GetAttribute(theTrigger, 'InsId');
      $('<%=ClientID %>_hdfSolicitudId').value = CCSOL.DOM.x_GetAttribute(theTrigger, 'SolId');
      $('<%=ClientID %>_hdfCitaId').value = CCSOL.DOM.x_GetAttribute(theTrigger, 'CitaId');
      
      if (doShow == 'show'  && isAnular)
      {
        theMenu.doShow = true;
        theMenu.doReturn = false;
        theMenu.isModal = true;
      }                        
      
    }
    function __onAutoHideFrustrar(e, menu)
    {
      return false;
    }
    var __xMenuFrustrar;

    function __createFrustrarDropDownMenu()
    {
      __xMenuFrustrar = new xDropDownMenu('dropDownFrustrar',   //el div que aparecerá en el punto de click
                                        '<%= TriggerId %>', //el "map" area que contiene los hotspots que provocarán que aparezca el PopUpForm
                                        'context',          //Se muestra en el punto de click ('d' = dropDownMenu,null = en el punto de click, 'context' = menu contextual
                                        'click',            //el evento al que queremos asociar la aparición del Div
                                        null,               //posicion en la que queremos que aparezca el div, 'left', 'right' o null solo tiene sentido cuando el menu es tipo 'd'
                                        __onDisplayMenuFrustrar,    //evento que se ejecuta al mostrarse el div
                                        __onAutoHideFrustrar        //evento que se llama al ocurrir un mouseout 
                        );
    }
    xAddEventListener(window,'load',__createFrustrarDropDownMenu,false);
    </script>
</div>  

<div id="dropDownFrustrar" class="popUpForm" style="padding: 2px; width: 250px; text-align: left;
      display: none; position: absolute; z-index: 104;">
  <table border="0" cellpadding="0" cellspacing="0" class="DataTable">
    <tr>
      <td align="left" style="font-weight: bold;font-size:10px; height: 12px;">
        Motivo</td>
    </tr>
    <tr>
      <td align="left">
        <asp:DropDownList ID="cbxMotivo" runat="server" Width="244px" DataSourceID="odsMotivo" DataTextField="motivo" DataValueField="motivoId" CssClass="FormText NOHIDE">
        </asp:DropDownList></td>
    </tr>
    <tr>
      <td align="left" style=" font-weight: bold;font-size:10px; " valign="bottom">
        Observación</td>
    </tr>
    <tr>
      <td align="left">
        <asp:TextBox ID="txtObservacion" runat="server" CssClass="FormText" Rows="6" TextMode="MultiLine"
          Width="240px"></asp:TextBox></td>
    </tr>
    <tr>
      <td align="right" style="height: 20px">
        <asp:Button ID="btnAnular" runat="server" Text="Frustrar Inspección " OnClientClick="return FrustrarInspeccion(); " OnClick="btnAnular_Click" CssClass="FormButton" />
        
        <input id="cancelarButton" onclick="hideFrustrarDropDown();return false;" class="FormButton"
          type="button" value="Cancelar" />
      </td>
    </tr>
  </table>
    <asp:ObjectDataSource ID="odsMotivo" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsComboTableAdapters.MotivoComboTableAdapter">
    <SelectParameters>
      <asp:Parameter DefaultValue="F" Name="tipo" Type="String" />
      <asp:Parameter DefaultValue="A" Name="estado" Type="String" />
    </SelectParameters>
  </asp:ObjectDataSource>
  <asp:HiddenField ID="hdfInspeccionId" runat="server" />
  <asp:HiddenField ID="hdfSolicitudId" runat="server" /><asp:HiddenField ID="hdfCitaId" runat="server" />
</div>
    
