<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ucPnlPropiedades.ascx.cs"
  Inherits="ucPnlPropiedades" %>

<script type="text/javascript">
    
   
    
    var errorMessage ='';
    function showMeAllFields() {
        
        CCSOL.Utiles.ClearTrace();
        if (isValidForm()) {
            
            TraceAllFields();
        }
        else {
            CCSOL.Utiles.Trace('<strong>NO PUEDE DEJAR NINGÚN COMBOBOX SIN ELEGIR O NINGÚN CAMPO EN BLANCO. ASEGÚRESE DE LLENAR TODOS LOS CAMPOS!!!.<br /><br />EL ÚNICO CAMPO QUE PUEDE QUEDAR EN BLANCO ES EL CAMPO OBSERVACIÓN </strong>',true);
        }
    }
    function isValidForm() {
        var IsValid = true;
        var xTextFields = xGetElementsByTagName('INPUT',$('pnlContainerAll'));
        var xSelectFields = xGetElementsByTagName('SELECT',$('pnlContainerAll'));
        
        for (var i = 0; i < xTextFields.length; i++) {
            if (xTextFields[i].type == 'text') {
                if (xTextFields[i].value == '') {
                    IsValid = false;                    
                }
            }
        }
        
        for (var i = 0; i < xSelectFields.length; i++) {
            if (xSelectFields[i].value == '-1') {
                IsValid = false;
                
            }
        }       
        
        return IsValid;
    }
    
    function TraceAllFields() {
      var xTextFields = xGetElementsByTagName('INPUT',$('pnlContainerAll'));
      var xSelectFields = xGetElementsByTagName('SELECT',$('pnlContainerAll'));        
      var xTextAreaFields = xGetElementsByTagName('TEXTAREA',$('pnlContainerAll'));

     
      var xAllFields = new Array();
      
      //añadiendo los INPUTS
      for (var i = 0; i < xTextFields.length; i++) {
          xAllFields[xAllFields.length] = xTextFields[i];
      }
      //añadiendo los SELECTS
      for (var i = 0; i < xSelectFields.length; i++) {
          xAllFields[xAllFields.length] = xSelectFields[i];
      }
      //añadiendo los TextFields;
      for (var i = 0; i < xTextAreaFields.length; i++) {
          xAllFields[xAllFields.length] = xTextAreaFields[i];
      }
      
      var parameterArray = new Array();
      

      for (var i = 0; i < xAllFields.length; i++) {        
          if (xAllFields[i].getAttribute('isValidControl') == 'isValidControl') {
            var caracteristica = new Object();
            caracteristica.caracteristicaId = xAllFields[i].getAttribute('nombrecampoId');            
            caracteristica.valor = xAllFields[i].value;
            caracteristica.order = xAllFields[i].getAttribute('order') * 1;
           
            if (xAllFields[i].type.toUpperCase() == 'CHECKBOX') {             
              caracteristica.valor = (xAllFields[i].checked)?xAllFields[i].getAttribute('valueOn'):xAllFields[i].getAttribute('valueOff');              
            }
            if (xAllFields[i].type.toUpperCase() == 'TEXT') {
              caracteristica.valorCaracteristicaId =  xAllFields[i].getAttribute('valorCaracteristicaId');
            }
            
            parameterArray[parameterArray.length] = caracteristica;
            
              
//              CCSOL.Utiles.Trace(
//                  CCSOL.Utiles.StringFormat('Id de la característica : {0}, valorId : {1}, valor : {2}, order : {3}',
//                      xAllFields[i].getAttribute('nombrecampoId'),
//                      xAllFields[i].value,
//                      (xAllFields[i].options)?xAllFields[i].options[xAllFields[i].selectedIndex].text:
//                      (xAllFields[i].type=="checkbox"?xAllFields[i].checked:'{campo texto}'), xAllFields[i].getAttribute('order') * 1)
//             );
         }
      }
      
      CarCheck.Gestores.GestorInspeccion.PropertyInsert('<%=Request.QueryString["VehiculoId"] %>', CCSOL.DOM.x_GetAttribute($('UcPnlPropiedadesVehiculo_propiedadPanel'),'propiedadId'), parameterArray, '<%= Session["usuario"] %>',refreshAll);      
    }      
    function refreshAll() {      
      
      CCSOL.Utiles.ClearTrace();
      CCSOL.Utiles.Trace('<strong>CARACTERÍSTICA AGREGADA</strong>')      
      doSingleRefresh(thePropiedadId,true);
    }    
    
</script>

<div id="propiedadPanel" runat="server" class="PanelStyle" >
  <div class="PanelEncabezado">
    <asp:Label ID="lblTituloPropiedad" runat="server" Text="PROPIEDAD : "></asp:Label>
  </div>
  <div id="pnlContainerAll" class="DataTable" style="padding: 5px;">
    <table style="width: 490px" border="0" cellpadding="0" cellspacing="0" class="DataTable">
      <tr>
        <td rowspan="2" style="width: 300px" valign="top">
          <div id="pnlContainer" runat="server" onprerender="Panel1_PreRender">
          </div>
        </td>
        <td rowspan="5" style="width: 259px" valign="top" align="left">
         <div id="trace" style="background-color:Red;padding:5px;display:none;color:White;width:auto;">
 </div></td>
      </tr>
      <tr>
      </tr>
      <tr>
        <td rowspan="1" style="width: 300px; height: 5px" valign="top">
        </td>
      </tr>
      <tr>
        <td rowspan="1" style="width: 300px" valign="top">
          OBSERVACIÓN</td>
      </tr>
      <tr>
        <td rowspan="1" style="width: 300px" valign="top">
          <asp:TextBox isValidControl="isValidControl" nombrecampoId="0" ID="txtObservacion"
            runat="server" CssClass="FormText MAYUSC" Rows="3" TextMode="MultiLine" Width="296px"></asp:TextBox></td>
      </tr>
    </table>
    <br />
    <asp:ImageButton ID="ImageButton1" OnClientClick="showMeAllFields();return false;" runat="server" ImageUrl="~/Images/btnsListas/btnSaveCaracteristica.jpg" /></div>
 
    </div>
    
  
