<%@  EnableEventValidation="false" Language="C#" AutoEventWireup="true" CodeFile="vSolicitud.aspx.cs"
  Inherits="vSolicitud" %>
<%@ Register Src="ucNotifier.ascx" TagName="ucNotifier" TagPrefix="uc2" %>
<%@ Register Assembly="CustomPanelWebControl" Namespace="xWebControl" TagPrefix="cc2" %>
<%@ Register Src="ucHeader.ascx" TagName="ucHeader" TagPrefix="uc1" %>
<%@ Register Assembly="AutoSuggestBox" Namespace="ASB" TagPrefix="cc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
  <title>
    <%= CCSOL.Utiles.Utilidades.GetSystemNameAndVersion() %>
    | Solicitud</title>
  <link href="css/layout.css" rel="stylesheet" type="text/css" />

  <!-- Begin BaseLibrarys -->
  <script type="text/javascript" src="Scripts/lib/x.js"></script>
  <script type="text/javascript" src="Scripts/lib/x_common.js"></script>
  <script type="text/javascript" src="Scripts/lib/xDomReady.js"></script>  
  <!-- End BaseLibrarys -->

  <script type="text/javascript">   
  function viewAmpliatorios(e)
  {
    var xE = new xEvent(e);
    var inspId = CCSOL.DOM.x_GetAttribute(xE.target, 'inspeccionId');
    window.location.href = 'vAmpliatorios.aspx?InspeccionId=' + inspId;
    xPreventDefault(e);
    xStopPropagation(e);
  }

  function doPreview(e)
  {
    var VehiculoId;
    var xE = new xEvent(e);

    VehiculoId = CCSOL.DOM.x_GetAttribute(xE.target, 'VehiculoId');
    ShowReport('vViewPdf.aspx?VehiculoId=' + VehiculoId + '&TI=FILE');

    xPreventDefault(e);
    xStopPropagation(e);

    return false;
  } </script>

  <script type="text/javascript">
      function __blockDivs() {
        if (<%=getIsAnulada() %>) xBlockDivs('DivHeader','solicitudPanel');
      }
      if (<%=getIsAnulada() %>) {
        CCSOL.Utiles.LoadScript('Scripts/lib/xBlockDiv.js');
        //xAddEventListener(window,'load',__blockDivs,false);
        //domReady(__blockDivs);
      }
  </script>

  <script type="text/javascript">
  /*************************************************************************************
  *	manejo de la nueva Inspección, el formulario que se muestra al pie de la grilla    
  /*************************************************************************************/
  function validaEnvio()
  {    
    if ($('NewInspeccionDiv').style.display == 'block')
    {
      return confirm('Aún no ha grabado la última inspección. \n¿Desea enviar la solicitud?');
    }

    else
    {
      return confirm('¿Desea enviar la solicitud?');
    }
  }
  var aReturnValueToDeleteInspeccion = false;
  function validaEliminacionInspeccion() 
  {   
    aReturnValueToDeleteInspeccion = confirm('Desea Eliminar el registro elegido???');          
    return aReturnValueToDeleteInspeccion;
  }
  
  function validaInsercionBlancos()
  {

    //NO HA SELECCIONADO NINGUNO ASEGURADO
    if (($('frmViewNewInspeccion_asbAsegurado_SelectedValue').value == '') && ($('frmViewNewInspeccion_asbAsegurado').value == ''))
    {
      alert('No ha seleccionado ningun contrante, ni especificado un nombre para el campo Asegurado');
      return false;
    }

    //HA SELECCIONADO UN ASEGURADO DEL AUTOSUGGEST Y ESTE NO ES EL DUMMY
    if (($('frmViewNewInspeccion_asbAsegurado_SelectedValue').value != "") && ($('frmViewNewInspeccion_asbAsegurado').value != ''))
    {
      return true;
    }

    //HA INGRESADO UN NUEVO ASEGURADO
    if (($('frmViewNewInspeccion_asbAsegurado_SelectedValue').value == "") && ($('frmViewNewInspeccion_asbAsegurado').value != ''))
    {
      return confirm('Ha decidido cambiar el nombre del asegurado por uno que NO ESTÁ registrado,\nsi continua se CREARÁ UN NUEVO ASEGURADO con el nombre proporcionado');
    }
  }
  
  function isValidContratanteAndContacto() {
    if (Page_ClientValidate()) {
         if (($('frmvContratante_asbContratante_SelectedValue').value == "") || 
             ($('frmvContacto_asbContacto_SelectedValue').value == "")) 
         {
             alert('debe grabar primero la solicitud para guardar los datos del Contratante o del Contacto que aún no han sido guardados');
             return false;             
         }         
         if ( !checkIfStillDummies(true) ) 
         {
            return false;
         } 
         
         return true;
    }
    return false;
  }
  
  function checkIfStillDummies(NoDoBlock) 
  {
    var msj = '';
    if ( $('frmvContratante_asbContratante_SelectedValue').value == "0" ) 
    {
      msj += 'debe elegir un Contratante Válido\n';      
    }
    if ($('frmvContacto_asbContacto_SelectedValue').value == "0") 
    {
      msj += 'debe elegir un Contacto Válido';  
    }
    
    if (msj != '') 
    {
      alert(msj);
      return false;
    }
    else {
      var isValid = Page_ClientValidate();
      if (isValid) {
        if (!NoDoBlock) CCSOL.DOM.xLockBackground();
      }
      return isValid;
    }
  }
  
  function showNewInspeccionForm(e)
  {  
    if (isValidContratanteAndContacto()) {
      try
      {
        if ($('NewInspeccionDiv').style.display == 'block')
        {
          if (validaInsercionBlancos()) {            
            return true;
          }
          else {
            xPreventDefault(e);
            return false;
          }
        }   
        else
        {
          $('NewInspeccionDiv').style.display = 'block';
          xPreventDefault(e);          
        }
      }
      catch (e)
      {
        alert(e.message);
      }
      xPreventDefault(e);
      return false;
    }
    else {
      xPreventDefault(e);
      return false;
    }
    
  }           
  </script>

  <script type="text/javascript">
  /*
    busqueda de la data de contactos, contratantes, asegurados, mediante metodos AJAX
  */      
  function perfomDataSearch()
  {
    try
    {
      CCSOL.DOM.xShowLoadingMessage(' Buscando... ');
      vSolicitud.performDataSearch($
        ('frmvContratante_asbContratante_SelectedValue').value,
        showPersonData_CallBack);
    }
    catch (e)
    {
      alert("[ Error en perfomDataSearch ] :" + e.message);
    }
  }

  function showPersonData_CallBack(res)
  {
    try
    {
      var p = res.value;
      if (xDef(p))
      {
        CCSOL.DOM.xHideLoadingMessage();
        $('frmvContratante_txtDireccion').value = p.direccion;
        $('frmvContratante_asbDistrito').value = p.ubigeo;
        $('frmvContratante_txtEmail').value = p.email;
        $('frmvContratante_txtNumDocumento').value = p.docid;
        $('frmvContratante_cbxTipoDocumento').value = p.tdoidId;
        $('frmvContratante_txtTelefono').value = p.tfijo;
        $('frmvContratante_txtFax').value = p.tfax;
        
        //copiamos los nuevos valores a la grilla de inserción de nuevas inspecciones
        if ($('frmvContratante_asbContratante_SelectedValue').value != '') 
        {
          $('frmViewNewInspeccion_asbAsegurado_SelectedValue').value = $('frmvContratante_asbContratante_SelectedValue').value;
        }
        if ( $('frmvContratante_asbContratante').value != '') 
        {
          $('frmViewNewInspeccion_asbAsegurado').value = $('frmvContratante_asbContratante').value;
        }
      }
      else {
        CCSOL.DOM.xShowLoadingMessage(' Persona no encontrada ', null,null,null,'#FFCC00',null,true);
      }
      
    }
    catch (e){
      alert("[ Error en ShowPersonaData ] : " + e.message);
    }
  }

  function perfomDataContacto()
  {
    try
    {
      vSolicitud.performDataContacto($('frmvContacto_asbContacto_SelectedValue').value, showPersonDataContacto_CallBack);
    }
    catch (e)
    {
      alert("[ Error en perfomDataContacto ] : " + e.message);
    }
  }

  function showPersonDataContacto_CallBack(res)
  {
    try
    {  
      p = res.value;

      $('frmvContacto_txtTelefono1').value = p.telefono1;
      $('frmvContacto_txtTelefono2').value = p.telefono2;
      $('frmvContacto_txtEmailContacto').value = p.email;
      
      //copiamos los nuevos valores a la grilla de inserción de nuevas inspecciones
      if ($('frmvContacto_asbContacto_SelectedValue').value != '') 
      {
        $('frmViewNewInspeccion_asbContacto_SelectedValue').value = $('frmvContacto_asbContacto_SelectedValue').value;
      }
      if ( $('frmvContacto_asbContacto').value != '') 
      {
        $('frmViewNewInspeccion_asbContacto').value = $('frmvContacto_asbContacto').value;
      }
    }
    catch (e)
    {
      alert('[ Error en showPersonDataContacto_CallBack ] : ' + e.message);
    }
  }
  </script>

  <script type="text/javascript">
  /*
  subir archivos a la solicitud
  */
  function showAdjuntarAnexo(e)
  {
    var solicitudId_s = '<%=solicitudId %>';
    ventana.showPopUpModal('vRegistroAnexo.aspx?SolicitudId=' + solicitudId_s, 410, 200);

    //xStopPropagation(e);
    xPreventDefault(e);
    return false;
  }


  function doDeleteFile(AnexoId, filename)
  {
    var doDelete = false;
    doDelete = confirm('Desea Eliminar el archivo ' + filename);
    if (doDelete)
    {
      CarCheck.Gestores.GestorSolicitud.doAnexoDelete('' + AnexoId);
      doRefresh();
    }

  }

  function doRefresh()
  {
    var arg;
    var context;
    CCSOL.DOM.xShowLoadingMessage(":: Actualizando ::");

     <%= ClientScript.GetCallbackEventReference(this.cckhandler, "arg","doCallback_Refresh", "context", "HandleError", false) %> ;
  }

  function doCallback_Refresh(result, context)
  {

    CCSOL.DOM.xHideLoadingMessage();
    //$('theLoadingMessage').style.display = 'none';

    var linea = new String(result);
    //alert(linea);            
    var divGridContainer = $('gridFiles');
    divGridContainer.innerHTML = linea;
    //reload the infos!!!
    __activateInfo();

  }

  function HandleError(message)
  {
    CCSOL.DOM.xHideLoadingMessage();
    alert("[Error] : " + message);
  }

  </script>

  <script type="text/javascript">  
  function doCallback_Comunicacion(result, context)
  {
    CCSOL.DOM.xHideLoadingMessage();    
    var linea = new String(result);
    var divGridContainer = $('informacion');
    divGridContainer.innerHTML = linea;    
  }

  function cleaningFunction() {
    var divGridContainer = $('informacion');
    divGridContainer.innerHTML = '';
  }

  function onDisplayMenu(e,theMenu){
    
    var xE = new xEvent(e);
    var theTrigger = xE.target;
    
    //debugger;
    
   
    //asumimos que no siempre es posible mostrar el menu
		theMenu.doShow = false;
		//asumimos que por defecto queremos que se ejecute la acción por defecto de los links
		theMenu.doReturn = true;
    
    if (theTrigger.className == 'doAnularAction') {
     	theMenu.doReturn = false;
      return;
    }
    var doAction = theTrigger.className == 'doAction';    
    if (doAction) 
    {
      theMenu.doShow = false;	      
      //retornamos el valor del mensaje de confirmación seteado en la variable global aReturnValueToDeleteInspeccion
		  theMenu.doReturn = aReturnValueToDeleteInspeccion;
		  return false;
    }
    
    var customRow = getRow(theTrigger, 5);
    var inspeccionId = CCSOL.DOM.x_GetAttribute(customRow,'inspeccionId');
    var vehiculoId = CCSOL.DOM.x_GetAttribute(customRow,'vehiculoId');
    var url = CCSOL.DOM.x_GetAttribute(customRow,'url');
    
    var showReport = CCSOL.DOM.x_GetAttribute(customRow,'showReport');
    var numAmp = 0;
   
    try {
      numAmp = CCSOL.DOM.x_GetAttribute(customRow,'numAmpliatorios');
      if (numAmp == '' || numAmp == null) numAmp = 0;
      
  		$('imgAmpliatorios').style.display = (numAmp > 0)? 'block':'none';
  		$('imgAmpliatorios').src = 'vGetImageAmpliatorio.aspx?canAmpl=' + numAmp;
  		CCSOL.DOM.x_SetAttribute($('imgAmpliatorios'),'inspeccionId',inspeccionId);    		
      
      if (showReport == 'true') {
         $('ImgViewReport').style.display = 'block';
      }
      else {
        $('ImgViewReport').style.display = 'none';
      }
      
      CCSOL.DOM.x_SetAttribute($('ImgViewReport'),'VehiculoId',vehiculoId);
    }
    catch(e) {
    }
    
    var hurl = $('urlHiddenField');
    hurl.value = '';
    
    var hagendar = $('agendarHiddenField');    
    hagendar.value = '';      
    
    var agendar = CCSOL.DOM.x_GetAttribute(customRow,'action');
    
    if(inspeccionId != 'undefined' && customRow != null){
      customRow.inspeccionId = inspeccionId;
      customRow.estado = CCSOL.DOM.x_GetAttribute(customRow,'estado');
      hurl.value = url;            
      
      if (agendar != null || agendar != '')  {
        hagendar.value = agendar;
      }
      
      theMenu.doShow = true;
      theMenu.doReturn = false;
      MostrarHistorico(customRow.inspeccionId);      
    }           
  }
  
  function onDisplayAnularInspeccionMenu(e,theMenu) {
    var xE = new xEvent(e);
    var theTrigger = xE.target;
    
    cleaningFunctionAnularInspeccion();
    //asumimos que no siempre es posible mostrar el menu
		theMenu.doShow = false;
		//asumimos que por defecto queremos que se ejecute la acción por defecto de los links
		theMenu.doReturn = true;
    
    var doAction = theTrigger.className == 'doAnularAction';
    if (doAction) 
    {
      
      $('txtSolicitudId').value =  CCSOL.DOM.x_GetAttribute(theTrigger,'solicitudid');
      $('txtInspeccionId').value = CCSOL.DOM.x_GetAttribute(theTrigger,'inspeccionid');
      theMenu.doShow = true;	
      //retornamos el valor del mensaje de confirmación seteado en la variable global aReturnValueToDeleteInspeccion
		  theMenu.doReturn = false;
		  return false;
    }
  }
  

  function irUrl()
  {
    var hurl = $('urlHiddenField');
    if (hurl.value != '' )
    {
      if ($('agendarHiddenField').value == 'agendar') {
         _doWindowOpen(hurl.value);        
      }
      else {
        window.location.href = hurl.value;                
      }      
    }
     xStopPropagation(e);
     xPreventDefault(e);        
    return false;
  }

  function MostrarHistorico(inspeccionId){   
    var context;
    CCSOL.DOM.xShowLoadingMessage("Actualizando Información de la Inspección");
    <%=ClientScript.GetCallbackEventReference(this.callback_gridComunicacion, "inspeccionId", "doCallback_Comunicacion", "context", "HandleError", false) %>;
  }

  function Editar(inspeccionId){
    xMenu.doShow = false;
    xMenu.doReturn = true;
    alert("se procede con la edicion");
  }

  function Eliminar(inspeccionId){
    xMenu.doShow = false;
    xMenu.doReturn = true;
    if(confirm("Se eliminara el registro.\n\n¿Desea proseguir?"))
      alert("se procede con la eliminacion");
  }

  function getRow(elemento, maximo){
    if(maximo > 0){
      if(elemento.parentNode.tagName == "TR")
        return elemento.parentNode;
      else
        return getRow(elemento.parentNode, maximo - 1);
    }else
    return null;
  }

  function inspeccionGridView_onMouseClick(e) {
    //anulo la función de los links normales
    xStopPropagation(e);
    return false;
  }

 

  function cleaningFunctionAnularInspeccion() {
     $('txtObservacionAnulacionInspeccion').value = '';
     $('cbxMotivo').value = '-1';         
  } 
  
  function onAutoHideAnularInspeccionMenu(evt) {
    return false;
  }       
    
  /*
  //Para los menus selects autocompletables
  CCSOL.Utiles.LoadScript("./Scripts/jsAutoComplete/autocomplete.js");  
  CCSOL.Utiles.LoadScript("./Scripts/lib/xSelectAutocompletion.js");
  */
  
  //Para los menus que aparecen en contexto    
  CCSOL.Utiles.LoadScript("./Scripts/lib/xDropDownMenu.js");       
    
  /*
  var xAutoCompletionCliente = null; 
  var xAutoCompletionBroker = null;
  var xAutoCompletionAseguradora = null;
    
  function xAutoCompletionShow(e,xMenu) {
    $('frmvCabeceraSolicitud_cbxTipoRequerimiento').style.display = 'none';
    $('frmvCabeceraSolicitud_cbxPrioridad').style.display = 'none';
    $('frmvCabeceraSolicitud_cbxCanal').style.display = 'none';
    
    //hide the other autoCompletion
    
    if (xAutoCompletionCliente != xMenu) {
      xAutoCompletionCliente.hide();
    }
//    if (xAutoCompletionBroker != xMenu) {
//      xAutoCompletionBroker.hide();
//    }
    if (xAutoCompletionAseguradora != xMenu) {
      xAutoCompletionAseguradora.hide();
    }
    
  }
  
  function xAutoCompletionOnShownFunction(e,xMenu) {
    if (xAutoCompletionCliente == xMenu) {
      $('txtPickCliente').focus();
    }
//    if (xAutoCompletionBroker == xMenu) {
//      $('txtPickBroker').focus();
//    }
    if (xAutoCompletionAseguradora == xMenu) {
      $('txtPickAseguradora').focus();
    }
  }
  
  function xAutoCompletionHide(e,xMenu) {    
    return true;
  }
  function xAutoCompletionHiding(e,xMenu) {
    $('frmvCabeceraSolicitud_cbxTipoRequerimiento').style.display = 'block';
    $('frmvCabeceraSolicitud_cbxPrioridad').style.display = 'block';
    $('frmvCabeceraSolicitud_cbxCanal').style.display = 'block';
  }
  
  function createAutoCompletionSelects() {
    
    //creamos los autoCompletions
    var ac1 = new xSelectAutocompletion('txtPickAseguradora','frmvCabeceraSolicitud_cbxAseguradora');
    var ac2 = new xSelectAutocompletion('txtPickCliente','frmvCabeceraSolicitud_cbxCliente');
    //var ac3 = new xSelectAutocompletion('txtPickBroker','frmvCabeceraSolicitud_cbxBroker');
    
    $('frmvCabeceraSolicitud_btnPickCliente').disabled = $('frmvCabeceraSolicitud_cbxCliente').disabled;
    $('frmvCabeceraSolicitud_btnPickAseguradora').disabled = $('frmvCabeceraSolicitud_cbxAseguradora').disabled;
    //$('frmvCabeceraSolicitud_btnPickBroker').disabled = $('frmvCabeceraSolicitud_cbxBroker').disabled;
    
    //creamos ahora los divMenus
    if ($('frmvCabeceraSolicitud_btnPickCliente'))
      {
        xAutoCompletionCliente = new xDropDownMenu('divPickCliente',       //el div que aparecerá en el punto de click
                                              'frmvCabeceraSolicitud_btnPickCliente',       //el "map" area que contiene los hotspots que provocarán que aparezca el PopUpForm
                                              'd',                    //Se muestra en el punto de click ('d' = dropDownMenu,null = en el punto de click, 'context' = menu contextual
                                              'click',                      //el evento al que queremos asociar la aparición del Div
                                              null,                         //posicion en la que queremos que aparezca el div, 'left', 'right' o null solo tiene sentido cuando el menu es tipo 'd'
                                              xAutoCompletionShow,                         //evento que se ejecuta al mostrarse el div
                                              xAutoCompletionHide, //evento que se llama al ocurrir un mouseout
                                              false,
                                              null,
                                              xAutoCompletionHiding,
                                              true,
                                              xAutoCompletionOnShownFunction
                                              );               
      }

    if ($('frmvCabeceraSolicitud_btnPickAseguradora'))
      {
        xAutoCompletionAseguradora = new xDropDownMenu('divPickAseguradora',       //el div que aparecerá en el punto de click
                                              'frmvCabeceraSolicitud_btnPickAseguradora',       //el "map" area que contiene los hotspots que provocarán que aparezca el PopUpForm
                                              'd',                    //Se muestra en el punto de click ('d' = dropDownMenu,null = en el punto de click, 'context' = menu contextual
                                              'click',                      //el evento al que queremos asociar la aparición del Div
                                              null,                         //posicion en la que queremos que aparezca el div, 'left', 'right' o null solo tiene sentido cuando el menu es tipo 'd'
                                              xAutoCompletionShow,                         //evento que se ejecuta al mostrarse el div
                                              xAutoCompletionHide, //evento que se llama al ocurrir un mouseout
                                              false,
                                              null,
                                              xAutoCompletionHiding,
                                              true,
                                              xAutoCompletionOnShownFunction);               //modal
               
      }
    
//    
//    if ($('frmvCabeceraSolicitud_btnPickBroker'))
//      {
//        xAutoCompletionBroker = new xDropDownMenu('divPickBroker',       //el div que aparecerá en el punto de click
//                                              'frmvCabeceraSolicitud_btnPickBroker',       //el "map" area que contiene los hotspots que provocarán que aparezca el PopUpForm
//                                              'd',                    //Se muestra en el punto de click ('d' = dropDownMenu,null = en el punto de click, 'context' = menu contextual
//                                              'click',                      //el evento al que queremos asociar la aparición del Div
//                                              null,                         //posicion en la que queremos que aparezca el div, 'left', 'right' o null solo tiene sentido cuando el menu es tipo 'd'
//                                              xAutoCompletionShow,                         //evento que se ejecuta al mostrarse el div
//                                              xAutoCompletionHide, //evento que se llama al ocurrir un mouseout
//                                              false,
//                                              null,
//                                              xAutoCompletionHiding,
//                                              true,
//                                              xAutoCompletionOnShownFunction);               //modal
//      
//      }

    
  }
    
        */
    
    
  var xMenu = null;
 
  var xMenuAnular = null;
  var xMenuAnularInspeccion = null;
  
  function createDropDownMenu()
  {
    

    try
    {
      if ($('anularImageButton'))
      {
        xMenuAnular = new xDropDownMenu('dropDownAnular',             //el div que aparecerá en el punto de click
                                        'anularImageButton',          //el "map" area que contiene los hotspots que provocarán que aparezca el PopUpForm
                                        'context',                    //Se muestra en el punto de click ('d' = dropDownMenu,null = en el punto de click, 'context' = menu contextual
                                        'click',                      //el evento al que queremos asociar la aparición del Div
                                        null,                         //posicion en la que queremos que aparezca el div, 'left', 'right' o null solo tiene sentido cuando el menu es tipo 'd'
                                        null,                         //evento que se ejecuta al mostrarse el div
                                        xMenuNotificacion_onAutoHide, //evento que se llama al ocurrir un mouseout
                                        true);
      //xMenu = new xDropDownMenu('customToolTip', 'inspeccionGridView', 'context', 'click', null, onDisplayMenu, null);//, onAutoHide);
      }
    }
    catch (e)
    {
    //alert(e.message);
    }

    
    try
    {
      if (<%=isNotAnuladaAndAtLeastOneRow() %> ) //SOLO MOSTRAMOS EL TOOLTIP SI EL NÚMERO DE FILAS ES MAYOR A 0
      {
        xMenu = new xDropDownMenu('ToolTipInspeccion',  //el div que aparecerá en el punto de click
                                  'inspeccionGridView', //el "map" area que contiene los hotspots que provocarán que aparezca el PopUpForm
                                  'context',            //Se muestra en el punto de click ('d' = dropDownMenu,null = en el punto de click, 'context' = menu contextual
                                  'click',              //el evento al que queremos asociar la aparición del Div
                                  null,                 //posicion en la que queremos que aparezca el div, 'left', 'right' o null solo tiene sentido cuando el menu es tipo 'd'
                                  onDisplayMenu,
                                  null,
                                  false,
                                  cleaningFunction);   
                                  
        xMenuAnularInspeccion = new xDropDownMenu('dropDownAnulaInspeccion',      //el div que aparecerá en el punto de click
									                                'inspeccionGridView',   //el "map" area que contiene los hotspots que provocarán que aparezca el PopUpForm
									                                'context',             //'context',		 //Se muestra en el punto de click ('d' = dropDownMenu,null = en el punto de click, 'context' = menu contextual
									                                'click',			    //el evento al que queremos asociar la aparición del Div
									                                 null,			 	      //posicion en la que queremos que aparezca el div, 'left', 'right' o null solo tiene sentido cuando el menu es tipo 'd'
									                                 onDisplayAnularInspeccionMenu,	  //evento que se ejecuta al mostrarse el div
									                                 onAutoHideAnularInspeccionMenu,              //evento que se llama al ocurrir un mouseout 
									                                 true,
									                                 null
									                                 );
        
      }
    }
    catch (e)
    {
    }
    
    
    //create here the dropDowMenus to allow the selects to be selectable via autocompletion
    //createAutoCompletionSelects();
    
    
    
  }

  function initAsbs() {
    //if (isAbleToChangeContratante&Contacto)
     try {
      xAddEventListener($('frmvContratante_asbContratante'),'blur',perfomDataSearch,true);
      xAddEventListener($('frmvContacto_asbContacto'),'blur',perfomDataContacto,true);
    }
    catch(e)
    {
      alert(e.message);
    }            
  }
  
  //sobreviviente de RGEN, primer objeto hecho, permite definir colapsibles, tiene que ser reemplazado
  //por un nuevo objeto que haga la vida más fácil.
  //CCSOL.Utiles.LoadScript('Scripts/lib/CollapsibleDiv.js');
  function createColapsibles() {
    try {
      xCollapsible = new CollapsibleDiv('btnTrigger', 'solicitudPanel', null, null);
      yCollapsible = new CollapsibleDiv('solicitudLabel', 'solicitudPanel', null, null);
    }
    catch (e) {      
      alert(e.message);
    }
  }
  
  //Permite obtener el efecto de rollOver sobre una grilla, además de dejar seleccionada la fila a la que se le hizo click
  //CCSOL.Utiles.LoadScript("./Scripts/lib/xTable.js");   
  function createTableOverEffect() { 
    if (<%=isNotAnuladaAndAtLeastOneRow()  %>) //SOLO CREAMOS EL EFECTO OVER CUANDO HAYA AL MENOS UNA FILA
    {   
      var xtable = new xTable('inspeccionGridView',   //el Identificador de la tabla
				                      'ItemStyleSelected',    //el Style ItemSeleccionado
				                      'ItemStyleOver');       //el Style Over
    }    
  }
  
  
  window.onload = function() {
      //alert('DOM ready');
     
      initAsbs();   
      createDropDownMenu();    
      createColapsibles();    
      createTableOverEffect();
      xAddEventListener($('frmvContacto_btnAgregar'),'click',showAdjuntarAnexo, false);   
      
      //setTheFocusTo First Cbx
      if ($('frmvCabeceraSolicitud_cbxCliente').enabled) $('frmvCabeceraSolicitud_cbxCliente').focus();                       		    
      //xAddEventListener($('form1'),'keypress',enableShortCuts,true);
      
      //xAddEventListener($('frmvCabeceraSolicitud_asbBroker'),'focus',selectAllText,true);
      xAddEventListener($('frmvCabeceraSolicitud_asbBroker'),'blur',setToolTip,true);
  }
  
  function selectAllText() {
    $('frmvCabeceraSolicitud_asbBroker').select();    
  }
  function setToolTip() {
    $('frmvCabeceraSolicitud_asbBroker').tt_text = $('frmvCabeceraSolicitud_asbBroker').value;
  }
//  function enableShortCuts(e) {
//    var xe = new xEvent(e);
//    if (e.ctrlKey && e.keyCode == 19) {
//      $('guardarImageButton').click();
//    }    
//  }
  
  function doBrokerValidate(sender,args){
    
      //args.IsValid = false;   
        
      var asbValue = asbGetObj('frmvCabeceraSolicitud_asbBroker').GetSelectedValue() ;
      args.IsValid = (asbValue != "" && asbValue != '-1' ) && $('frmvCabeceraSolicitud_asbBroker').value != '';
      
      
  }
  
  function doErase() {
    var doDelete = confirm("¿Desea Eliminar la Solicitud? \nEsto Eliminará todas las Inspecciones que haya registrado en esta solicitud también.");
    if (doDelete) CCSOL.DOM.xLockBackground();
    return doDelete;
  }
  
  function _verAgenda()
	{	  
	  CCSOL.DOM.xShowLoadingMessage(":: Abriendo la Agenda ::");
		var aWindow = window.open("vAgenda.aspx?action=sASol&SolicitudId=<%=solicitudId%>",'Agenda','scrollbars=yes,resizable=yes,menubar=no,status=yes,directories=no,location=no');
		if (aWindow == null) alert('Parece que tiene habilitado un bloqueador de popups, por favor configúrelo para permitir popups de este sitio');
		CCSOL.DOM.xHideLoadingMessage();
	}
 
 function _doWindowOpen(url) 
 { 
    CCSOL.DOM.xShowLoadingMessage(":: Abriendo la Agenda ::");
    window.open(url,'Agenda','scrollbars=yes,resizable=yes,menubar=no,status=yes,directories=no,location=no');   
    CCSOL.DOM.xHideLoadingMessage();
    return false;
 }
 
 function validaSend() {
  if (confirm('Una vez enviada la solicitud está ya no será editable. ¿Desea Enviar la Solicitud Ahora?')) {
    return checkIfStillDummies();
  }
  else {
    return false;
  }
 }
  
  </script>

  <link href="./Scripts/asb_includes/AutoSuggestBox.css" rel="stylesheet" type="text/css" />
  <link href="css/layout.css" rel="stylesheet" type="text/css" />
</head>
<body>
  <form id="form1" runat="server">
    <div>
      <table id="Data" border="0" cellpadding="0" cellspacing="0" align="center">
        <tr>
          <td style="width: 1088px">
            <uc1:ucHeader ID="UcHeader1" runat="server" TabActual="listaSolicitudes" PageFunctionalityToCheck="SOLICITUD_VER" />
            <div class="DataTop">
              <div class="DataTopLeft">
              </div>
              <div class="DataTopRight">
              </div>
            </div>
            <div class="DataContent" style="margin-bottom: -4px">
              <div class="DataContentRight">
                <div class="PanelEncabezado">
                  <asp:Label ID="solicitudLabel" runat="server" Text="Solicitud de Inspección" Font-Size="14pt"
                    ToolTip="Mostrar / Ocultar Panel" Font-Names="Arial"></asp:Label>
                  <img id="btnTrigger" alt="Mostrar / Ocultar Panel" src="Images/IconHide16Dark.gif"
                    title="Mostrar / Ocultar Panel" style="margin-top: 3px;" />
                  <asp:ValidationSummary ID="ValidationSummary1" CssClass="summaryWarm" runat="server"
                    ForeColor="Yellow" ValidationGroup="SolicitudSave" />
                </div>
                <div id="solicitudPanel">
                  <div class="PanelStyle" style="margin-top: 4px" id="DivHeader">
                    <div class="PanelEncabezado">
                      <asp:Label ID="lblDatosSolicitud" runat="server" Text="Datos de la Solicitud" Style="cursor: default"></asp:Label>
                      <div id='divIsAnulada' runat="server" class="alertMessage">
                        Esta Solicitud se encuentra anulada
                      </div>
                    </div>
                    <div class="DataTable" style="position: relative;">
                      <asp:FormView ID="frmvCabeceraSolicitud" runat="server" DefaultMode="Edit" DataSourceID="odsSolicitud"
                        OnDataBound="frmvCabeceraSolicitud_DataBound" DataKeyNames="solicitudId" OnItemUpdated="frmvCabeceraSolicitud_ItemUpdated">
                        <EditItemTemplate>
                          <table border="0" cellpadding="0" cellspacing="0">
                            <tr>
                              <td style="width: 85px;">
                                Usuario</td>
                              <td>
                                <asp:TextBox ID="txtUsuario" runat="server" CssClass="FormText readOnly" Width="180px"
                                  Text='<%# Eval("usuario") %>' ReadOnly="True"></asp:TextBox></td>
                              <td style="width: 110px;">
                                Solicitado por</td>
                              <td>
                                <asp:TextBox ID="txtSolicitadoPor" runat="server" CssClass="FormText" Width="180px"
                                  TabIndex="130" Text='<%# Bind("solicitadopor") %>'></asp:TextBox></td>
                              <td style="width: 140px;">
                                N&uacute;mero solicitud
                              </td>
                              <td>
                                <asp:TextBox ID="txtNumSolicitud" runat="server" CssClass="FormText" Width="180px"
                                  TabIndex="150" Text='<%# Bind("numeSolicitudCliente") %>'></asp:TextBox></td>
                            </tr>
                            <tr>
                              <td style="height: 18px">
                                Cliente<asp:CompareValidator ID="CompareValidator4" runat="server" ControlToValidate="cbxCliente"
                                  Operator="NotEqual" ToolTip="Por Favor Elija una opción" ValidationGroup="SolicitudSave"
                                  ValueToCompare="-1" ErrorMessage="Elija un Cliente">(*)</asp:CompareValidator></td>
                              <td style="height: 18px">
                                <asp:DropDownList ID="cbxCliente" runat="server" CssClass="FormText tt_help_info aDropDownWithTitle"
                                  Width="185px" TabIndex="100" AppendDataBoundItems="True" DataSourceID="odsCliente"
                                  DataTextField="persona" DataValueField="personaId" SelectedValue='<%# Bind("clienteId") %>'>
                                  <asp:ListItem Value="-1">[ - Elija - ]</asp:ListItem>
                                </asp:DropDownList></td>
                              <td style="height: 18px">
                                Tipo requerimiento<asp:CompareValidator ID="CompareValidator3" runat="server" ControlToValidate="cbxTipoRequerimiento"
                                  Operator="NotEqual" ToolTip="Por Favor Elija una opción" ValidationGroup="SolicitudSave"
                                  ValueToCompare="-1" ErrorMessage="Elija un Tipo de Requerimiento">(*)</asp:CompareValidator></td>
                              <td style="height: 18px">
                                <asp:DropDownList ID="cbxTipoRequerimiento" runat="server" CssClass="FormText tt_help_info aDropDownWithTitle"
                                  Width="184px" TabIndex="135" DataSourceID="odsTRequerimiento" DataTextField="trequerimiento"
                                  DataValueField="trequerimientoId" AppendDataBoundItems="True" SelectedValue='<%# Bind("trequerimientoId") %>'>
                                  <asp:ListItem Value="-1">[ - Elija - ]</asp:ListItem>
                                </asp:DropDownList></td>
                              <td style="height: 18px">
                                Estado</td>
                              <td style="height: 18px">
                                <asp:TextBox ID="txtEstado" runat="server" CssClass="FormText readOnly" Width="180px"
                                  Text='<%# Eval("estadoSolicitud") %>' ReadOnly="True" TabIndex="155"></asp:TextBox></td>
                            </tr>
                            <tr>
                              <td>
                                Aseguradora<asp:CompareValidator ID="CompareValidator5" runat="server" ControlToValidate="cbxAseguradora"
                                  Operator="NotEqual" ToolTip="Por Favor Elija una opción" ValidationGroup="SolicitudSave"
                                  ValueToCompare="-1" ErrorMessage="Elija una Aseguradora">(*)</asp:CompareValidator></td>
                              <td>
                                <asp:DropDownList ID="cbxAseguradora" runat="server" CssClass="FormText tt_help_info aDropDownWithTitle"
                                  Width="185px" TabIndex="110" AppendDataBoundItems="True" DataSourceID="odsAseguradora"
                                  DataTextField="persona" DataValueField="personaId" SelectedValue='<%# Bind("aseguradoraId") %>'>
                                  <asp:ListItem Value="-1">[ - Elija - ]</asp:ListItem>
                                </asp:DropDownList></td>
                              <td>
                                Prioridad<asp:CompareValidator ID="CompareValidator2" runat="server" ControlToValidate="cbxPrioridad"
                                  Operator="NotEqual" ToolTip="Por Favor Elija una opción" ValidationGroup="SolicitudSave"
                                  ValueToCompare="-1" ErrorMessage="Elija una Prioridad">(*)</asp:CompareValidator></td>
                              <td>
                                <asp:DropDownList ID="cbxPrioridad" runat="server" CssClass="FormText tt_help_info aDropDownWithTitle"
                                  Width="184px" TabIndex="140" DataSourceID="odsPrioridad" DataTextField="prioridad"
                                  DataValueField="prioridadId" AppendDataBoundItems="True" SelectedValue='<%# Bind("prioridadId") %>'>
                                  <asp:ListItem Value="-1">[ - Elija - ]</asp:ListItem>
                                </asp:DropDownList>
                              </td>
                              <td>
                                Fecha/Hora actualización</td>
                              <td>
                                <asp:TextBox ID="txtFechaActualizacion" runat="server" CssClass="FormText readOnly"
                                  Width="180px" Text='<%# Eval("fupdate") %>' ReadOnly="True" TabIndex="160"></asp:TextBox></td>
                            </tr>
                            <tr>
                              <td>
                                Broker
                                <asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="Debe Elegir un Broker de la Lista AutoCompletable"
                                  ClientValidationFunction="doBrokerValidate" ControlToValidate="asbBroker" ValidationGroup="SolicitudSave">(*)</asp:CustomValidator><%-- <asp:CompareValidator ID="CompareValidator6" runat="server" ControlToValidate="cbxBroker"
                              Operator="NotEqual" ToolTip="Por Favor Elija una opción" ValidationGroup="SolicitudSave"
                              ValueToCompare="-1" ErrorMessage="Elija un Broker">(*)</asp:CompareValidator>--%></td>
                              <td>
                                <cc1:AutoSuggestBox ID="asbBroker" runat="server" CssClass="FormText tt_help_info"
                                  DataType="Broker" IncludeMoreMenuItem="False" KeyPressDelay="300" MaxSuggestChars="5"
                                  MenuCSSClass="asbMenu" MenuItemCSSClass="asbMenuItem" MoreMenuItemLabel="..." NoValueSelectedCSSClass="asbNonValueSelected"
                                  NumMenuItems="10" OnFocusShowAll="False" ResourcesDir="Scripts/asb_includes" SelectedValue='<%# Bind("brokerId") %>'
                                  SelMenuItemCSSClass="asbSelMenuItem" TabIndex="120" Text='<%# Eval("Broker") %>'
                                  UseIFrame="True" WarnNoValueSelected="True" Width="180px"></cc1:AutoSuggestBox></td>
                              <td>
                                Canal<asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="cbxCanal"
                                  Operator="NotEqual" ToolTip="Por Favor Elija una opción" ValidationGroup="SolicitudSave"
                                  ValueToCompare="-1" ErrorMessage="Elija un Canal">(*)</asp:CompareValidator></td>
                              <td>
                                <asp:DropDownList ID="cbxCanal" runat="server" CssClass="FormText tt_help_info aDropDownWithTitle"
                                  Width="184px" TabIndex="145" DataSourceID="odsCanal" DataTextField="canal" DataValueField="canalId"
                                  AppendDataBoundItems="True" SelectedValue='<%# Bind("canalId") %>'>
                                  <asp:ListItem Value="-1">[ - Elija - ]</asp:ListItem>
                                </asp:DropDownList></td>
                              <td>
                                Fecha/Hora solicitud</td>
                              <td>
                                <asp:TextBox ID="txtFechaSolicitud" runat="server" CssClass="FormText readOnly" Width="180px"
                                  Text='<%# Eval("fsolicitud") %>' ReadOnly="True" TabIndex="165"></asp:TextBox></td>
                            </tr>
                            <tr style="display: none">
                              <td>
                              </td>
                              <td>
                                <asp:TextBox ID="txtObservacion" runat="server" Width="8px" Text='<%# Bind("observacion") %>'></asp:TextBox>
                                <asp:CheckBox ID="chkClienteVIP" runat="server" Width="96px" Checked='<%# Bind("clienteVIP") %>' /></td>
                              <td>
                              </td>
                              <td>
                                <asp:TextBox ID="txtNumVehiculos" runat="server" Width="24px" Text='<%# Bind("numeVehiculos") %>'></asp:TextBox>
                                <asp:TextBox ID="txtContactoId" runat="server" Text='<%# Bind("contactoId") %>' Width="24px"></asp:TextBox>
                                <asp:TextBox ID="txtContratanteId" runat="server" Text='<%# Bind("contratanteId") %>'
                                  Width="24px"></asp:TextBox>
                                <asp:TextBox ID="txtUsuarioId" runat="server" Text='<%# Bind("usuarioId") %>' Width="24px"></asp:TextBox></td>
                              <td>
                              </td>
                              <td>
                                <asp:HiddenField ID="hfEstadoSolicitud" runat="server" Value='<%# Eval("estadoSolicitud") %>' />
                              </td>
                            </tr>
                          </table>
                        </EditItemTemplate>
                      </asp:FormView>
                    </div>
                  </div>
                  <div class="PanelStyle" style="margin-bottom: 4px; z-index: 500">
                    <div class="PanelEncabezado">
                      <asp:Label ID="Label3" runat="server" Style="cursor: default" Text="Asegurado / Contratante / Contacto"></asp:Label>
                    </div>
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                      <tr>
                        <td style="width: 535px;" valign="top" class="ItemStyle">
                          <asp:FormView ID="frmvContratante" runat="server" DataSourceID="odsContratante" DefaultMode="Edit"
                            OnItemUpdated="frmvContratante_ItemUpdated">
                            <EditItemTemplate>
                              <div class="DataTable">
                                <table border="0" cellpadding="0" cellspacing="0">
                                  <!--DWLayoutTable-->
                                  <tr>
                                    <td style="width: 85px">
                                      Raz&oacute;n Social</td>
                                    <td>
                                      <cc1:AutoSuggestBox ID="asbContratante" runat="server" CssClass="FormText" DataType="Contratante"
                                        IncludeMoreMenuItem="False" KeyPressDelay="300" MaxSuggestChars="8" MenuCSSClass="asbMenu"
                                        MenuItemCSSClass="asbMenuItem" MoreMenuItemLabel="..." NoValueSelectedCSSClass="asbNonValueSelected"
                                        NumMenuItems="15" OnFocusShowAll="True" ResourcesDir="./Scripts/asb_includes" SelMenuItemCSSClass="asbSelMenuItem"
                                        Style="position: static" Text='<%# Bind("persona") %>' UseIFrame="True" WarnNoValueSelected="False"
                                        Width="180px" SelectedValue='<%# Bind("personaid") %>' TabIndex="200"></cc1:AutoSuggestBox></td>
                                    <td>
                                      N&deg; Doc.</td>
                                    <td>
                                      <asp:DropDownList ID="cbxTipoDocumento" runat="server" CssClass="FormText" Width="94px"
                                        AppendDataBoundItems="True" DataSourceID="odsTipoDoc" DataTextField="tdocid" DataValueField="tdocidId"
                                        SelectedValue='<%# Bind("TDocumentoIdentidad") %>' TabIndex="205">
                                        <asp:ListItem Selected="True" Value="-1">[ - Elija - ]</asp:ListItem>
                                      </asp:DropDownList></td>
                                    <td style="width: 103px">
                                      <asp:TextBox ID="txtNumDocumento" runat="server" CssClass="FormText" Width="94px"
                                        Text='<%# Bind("DocumentoIdentidad") %>' TabIndex="210"></asp:TextBox></td>
                                  </tr>
                                  <tr>
                                    <td>
                                      Direcci&oacute;n</td>
                                    <td>
                                      <asp:TextBox ID="txtDireccion" runat="server" CssClass="FormText" Width="180px" Text='<%# Bind("direccionTrabajo") %>'
                                        TabIndex="215"></asp:TextBox></td>
                                    <td>
                                      Tel&eacute;fono</td>
                                    <td>
                                      <asp:TextBox ID="txtTelefono" runat="server" CssClass="FormText" Width="90px" Text='<%# Bind("TelefonoFijo1") %>'
                                        TabIndex="220"></asp:TextBox></td>
                                    <td style="width: 103px">
                                      Fax
                                      <asp:TextBox ID="txtFax" runat="server" CssClass="FormText" Width="70px" Text='<%# Bind("Fax") %>'
                                        TabIndex="225"></asp:TextBox></td>
                                  </tr>
                                  <tr>
                                    <td>
                                      Ubigeo</td>
                                    <td>
                                      <cc1:AutoSuggestBox ID="asbDistrito" runat="server" CssClass="FormText" DataType="Distrito"
                                        IncludeMoreMenuItem="True" KeyPressDelay="300" MaxSuggestChars="15" MenuCSSClass="asbMenu"
                                        MenuItemCSSClass="asbMenuItem" MoreMenuItemLabel="..." NoValueSelectedCSSClass="asbNonValueSelected"
                                        NumMenuItems="15" OnFocusShowAll="False" ResourcesDir="./Scripts/asb_includes"
                                        SelectedValue='<%# Bind("ubigeoIdTrabajo") %>' SelMenuItemCSSClass="asbSelMenuItem"
                                        Text='<%# Eval("distritoTrabajo") %>' UseIFrame="True" WarnNoValueSelected="False"
                                        Width="180px" TabIndex="230"></cc1:AutoSuggestBox></td>
                                    <td>
                                      E-mail</td>
                                    <td colspan="2" valign="top" style="padding-top: 1px">
                                      <asp:TextBox ID="txtEmail" runat="server" CssClass="EmailCase FormText MINUSC" Width="147px"
                                        Text='<%# Bind("email") %>' ToolTip='<%# Eval("email") %>' TabIndex="235"></asp:TextBox>
                                      <asp:CheckBox ID="vipCheckBox" runat="server" CssClass="FormCheck" Text="VIP " TextAlign="Left"
                                        TabIndex="240" />
                                    </td>
                                  </tr>
                                  <tr>
                                    <td style="padding-top: 1px" valign="top">
                                      Observaciones</td>
                                    <td colspan="6">
                                      <asp:TextBox ID="txtObservacion" runat="server" CssClass="FormText" TextMode="MultiLine"
                                        Width="435px" Rows="3" TabIndex="245"></asp:TextBox></td>
                                  </tr>
                                </table>
                              </div>
                            </EditItemTemplate>
                          </asp:FormView>
                        </td>
                        <td style="width: 4px" valign="top">
                        </td>
                        <td valign="top" class="ItemStyle">
                          <div class="DataTable">
                            <asp:FormView ID="frmvContacto" runat="server" DataSourceID="odsContacto" DefaultMode="Edit"
                              OnItemUpdated="frmvContacto_ItemUpdated">
                              <EditItemTemplate>
                                <table border="0" cellpadding="0" cellspacing="0">
                                  <tr>
                                    <td>
                                      Contacto</td>
                                    <td colspan="2">
                                      <cc1:AutoSuggestBox ID="asbContacto" runat="server" CssClass="FormText" DataType="Contacto"
                                        IncludeMoreMenuItem="False" KeyPressDelay="300" MaxSuggestChars="8" MenuCSSClass="asbMenu"
                                        MenuItemCSSClass="asbMenuItem" MoreMenuItemLabel="..." NoValueSelectedCSSClass="asbNonValueSelected"
                                        NumMenuItems="15" OnFocusShowAll="True" ResourcesDir="./Scripts/asb_includes" SelMenuItemCSSClass="asbSelMenuItem"
                                        Style="position: static" Text='<%# Bind("contacto") %>' UseIFrame="False" WarnNoValueSelected="False"
                                        Width="225px" SelectedValue='<%# Bind("contactoId") %>' TabIndex="250"></cc1:AutoSuggestBox></td>
                                  </tr>
                                  <tr>
                                    <td style="height: 18px">
                                      Tel&eacute;fonos</td>
                                    <td style="height: 18px">
                                      <asp:TextBox ID="txtTelefono1" runat="server" CssClass="FormText" Width="103px" Text='<%# Bind("telefono1") %>'
                                        TabIndex="255"></asp:TextBox></td>
                                    <td align="right" style="height: 18px">
                                      <asp:TextBox ID="txtTelefono2" runat="server" CssClass="FormText" Width="113px" Text='<%# Bind("telefono2") %>'
                                        TabIndex="260"></asp:TextBox></td>
                                  </tr>
                                  <tr>
                                    <td style="height: 18px">
                                      E-mail</td>
                                    <td colspan="2" style="height: 18px">
                                      <asp:TextBox ID="txtEmailContacto" runat="server" CssClass="EmailCase FormText MINUSC"
                                        Width="225px" Text='<%# Bind("email") %>' TabIndex="265"></asp:TextBox></td>
                                  </tr>
                                  <tr>
                                    <td style="padding-top: 2px" valign="top">
                                      Nro. vehículos</td>
                                    <td colspan="2" style="padding-top: 1px">
                                      <asp:TextBox ID="txtNroVehiculos" runat="server" CssClass="FormText" Width="32px"
                                        Style="float: left" TabIndex="270"></asp:TextBox>
                                      <asp:Button ID="btnAgregar" keycode='25' Visible="<%# EstadoSolicitudIsNotAnulada() %>"
                                        runat="server" CssClass="FormButton SHORTCUT" Text="Agregar Archivo" Style="float: right;
                                        width: 117px; height: 16px" OnClientClick="return false;" TabIndex="275" /></td>
                                  </tr>
                                </table>
                              </EditItemTemplate>
                            </asp:FormView>
                            <table border="0" cellpadding="0" cellspacing="0" style="width: 320px">
                              <tr>
                                <td align="right" colspan="4" valign="bottom">
                                  <div id="gridFiles">
                                    <asp:DataList ID="DataList1" runat="server" DataKeyField="AnexoId" DataSourceID="odsListaAnexos">
                                      <HeaderTemplate>
                                        <table border="0" cellpadding="0" cellspacing="0">
                                      </HeaderTemplate>
                                      <ItemTemplate>
                                        <tr>
                                          <td align="right">
                                            <asp:HyperLink ID="lnkFileName" runat="server" ForeColor="Blue" Target="_blank" CssClass="tt_help_info"
                                              tt_title="Observación" tt_text='<%# Eval("observacion") %>' NavigateUrl='<%# getAnexoUrl(Eval("AnexoId")) %>'
                                              Text='<%# Eval("filename") %>'></asp:HyperLink>
                                          </td>
                                          <td>
                                            <asp:HyperLink ID="HyperLink10" runat="server" ImageUrl="~/Images/IconDeleteAttach.gif"
                                              NavigateUrl="#" onclick='<%# getAnexoDeleteCommand(Eval("AnexoId"),Eval("filename")) %>'>Eliminar ajunto</asp:HyperLink>
                                          </td>
                                        </tr>
                                      </ItemTemplate>
                                      <FooterTemplate>
                                        </table>
                                      </FooterTemplate>
                                    </asp:DataList>
                                  </div>
                                </td>
                              </tr>
                            </table>
                          </div>
                        </td>
                      </tr>
                    </table>
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
            <div class="DataTop">
              <div class="DataTopLeft">
              </div>
              <div class="DataTopRight">
              </div>
            </div>
            <div class="DataContent">
              <div class="DataContentRight" style="position: relative;">
                <div class="PanelEncabezado" style="height: 23px;">
                  <asp:Label ID="Label1" runat="server" Text="Lista de Inspecciones" Font-Bold="True"
                    Font-Names="Arial" Font-Size="14pt"></asp:Label>
                  <div id="panelBtns" style="margin-top: 3px; float: right">
                    <cc2:xWebPanelControl ID="XWebPanelControl1" runat="server" Style="display: inline;"
                      Height="12px" PermissionToCheck="INSPECCION_CREAR" Width="90px">
                      <asp:ImageButton ID="nuevaInspeccionImageButton" keycode='10' Visible='<%# shouldBeVisibleNuevaInspeccion() %>'
                        runat="server" ImageUrl="~/Images/btnNuevaInspeccion.jpg" OnClick="nuevaInspeccionImageButton_Click"
                        OnClientClick="return showNewInspeccionForm();" CssClass="MakeClear SHORTCUT" TabIndex="300" />
                    </cc2:xWebPanelControl>
                    <cc2:xWebPanelControl ID="XWebPanelControl2" runat="server" Style="display: inline;"
                      Height="23px" PermissionToCheck="INSPECCION_AGENDAR" Width="85px">
                      <asp:ImageButton ID="agendarImageButton" runat="server" keycode='11' ImageUrl="~/Images/btnAgendar.jpg"
                        CssClass="MakeClear SHORTCUT" TabIndex="305" OnClick="agendarImageButton_Click" />
                    </cc2:xWebPanelControl>
                  </div>
                </div>
                <div class="hr" style="margin-top: -4px">
                </div>
                <div id="GridInspecciones" runat="server" class="PanelInset" style="height: 250px">
                  <asp:GridView ID="inspeccionGridView" runat="server" AutoGenerateColumns="False"
                    CssClass="GridLista" DataSourceID="odsInspecciones" AllowSorting="True" BorderStyle="Solid"
                    OnRowDataBound="inspeccionGridView_RowDataBound" DataKeyNames="inspeccionId" OnRowUpdating="inspeccionGridView_RowUpdating">
                    <Columns>
                      <asp:BoundField DataField="inspeccionId" HeaderText="inspeccionId" InsertVisible="False"
                        ReadOnly="True" SortExpression="inspeccionId">
                        <ItemStyle CssClass="invisible" />
                        <HeaderStyle CssClass="invisible" />
                        <FooterStyle CssClass="invisible" />
                      </asp:BoundField>
                      <asp:BoundField DataField="estadoInspeccionId" HeaderText="estadoInspeccionId" SortExpression="estadoInspeccionId">
                        <ItemStyle CssClass="invisible" />
                        <HeaderStyle CssClass="invisible" />
                        <FooterStyle CssClass="invisible" />
                      </asp:BoundField>
                      <asp:BoundField DataField="solicitudId" HeaderText="solicitudId" SortExpression="solicitudId">
                        <ItemStyle CssClass="invisible" />
                        <HeaderStyle CssClass="invisible" />
                        <FooterStyle CssClass="invisible" />
                      </asp:BoundField>
                      <asp:TemplateField HeaderText="N&#186;">
                        <ItemStyle Width="10px" HorizontalAlign="Center" />
                        <ItemTemplate>
                          <asp:Label ID="lblNum" runat="server" ForeColor="#000000" Text="<%# num++ %>"></asp:Label>
                        </ItemTemplate>
                      </asp:TemplateField>
                      <asp:BoundField DataField="numeInspeccion" HeaderText="N&#186; Insp." SortExpression="numeInspeccion">
                        <ItemStyle Width="90px" HorizontalAlign="Center" />
                      </asp:BoundField>
                      <asp:BoundField DataField="persona" HeaderText="Asegurado" SortExpression="persona">
                        <ItemStyle Width="200px" HorizontalAlign="Center" />
                      </asp:BoundField>
                      <asp:BoundField DataField="contacto" HeaderText="Contacto" SortExpression="contacto">
                        <ItemStyle Width="200px" HorizontalAlign="Center" />
                      </asp:BoundField>
                      <asp:BoundField DataField="marcaVehiculo" HeaderText="Marca" SortExpression="marcaVehiculo">
                        <ItemStyle Width="90px" HorizontalAlign="Center" />
                      </asp:BoundField>
                      <asp:BoundField DataField="modeloVehiculo" HeaderText="Modelo" SortExpression="modeloVehiculo">
                        <ItemStyle Width="90px" HorizontalAlign="Center" />
                      </asp:BoundField>
                      <asp:BoundField DataField="anhoFabricacion" DataFormatString="{0:yyyy}" HeaderText="A&#241;o"
                        SortExpression="anhoFabricacion" HtmlEncode="False">
                        <ItemStyle Width="60px" HorizontalAlign="Center" />
                      </asp:BoundField>
                      <asp:BoundField DataField="placa" HeaderText="Placa" SortExpression="placa">
                        <ItemStyle Width="60px" HorizontalAlign="Center" />
                      </asp:BoundField>
                      <asp:BoundField DataField="chasis" HeaderText="Chasis/Serie" SortExpression="chasis">
                        <ItemStyle Width="60px" HorizontalAlign="Center" />
                      </asp:BoundField>
                      <asp:BoundField DataField="colorVehiculo" HeaderText="Color" SortExpression="colorVehiculo">
                        <ItemStyle Width="60px" HorizontalAlign="Center" />
                      </asp:BoundField>
                      <asp:TemplateField HeaderText="Valor">
                        <ItemStyle Width="60px" HorizontalAlign="Center" />
                        <ItemTemplate>
                          <table cellpadding="0" border="0" cellspacing="0">
                            <tr class="noMouseOver">
                              <td style="width: 20px; text-align: left;">
                                <asp:Label ID="l" runat="server" Text='<%# Eval("simbolo") %>'></asp:Label></td>
                              <td>
                                <asp:Label ID="Label4" runat="server" Text='<%# Eval("valor") %>'></asp:Label></td>
                            </tr>
                          </table>
                          <div>
                          </div>
                        </ItemTemplate>
                      </asp:TemplateField>
                      <asp:BoundField DataField="estadoInspeccion" HeaderText="Estado" SortExpression="estadoInspeccion">
                        <ItemStyle HorizontalAlign="Center" />
                      </asp:BoundField>
                      <asp:BoundField DataField="estadoInspeccionId" HeaderText="Estado" SortExpression="estadoInspeccionId"
                        Visible="False">
                        <ItemStyle Width="80px" HorizontalAlign="Center" />
                      </asp:BoundField>
                      <asp:BoundField DataField="fechaCambio" DataFormatString="{0:dd-MM-yyyy}" HeaderText="Fecha Estado"
                        SortExpression="fechaCambio" HtmlEncode="False">
                        <ItemStyle Width="90px" HorizontalAlign="Center" />
                      </asp:BoundField>
                      <asp:TemplateField HeaderText="Acci&#243;n">
                        <EditItemTemplate>
                          &nbsp;
                        </EditItemTemplate>
                        <ItemStyle Width="40px" HorizontalAlign="Center" />
                        <ItemTemplate>
                          <table border="0" cellpadding="0" cellspacing="0">
                            <tr>
                              <td>
                                <asp:ImageButton ID="ImageButton4" runat="server" ImageUrl="~/Images/IconDelete.gif"
                                  OnClientClick="return validaEliminacionInspeccion();" CssClass="doAction" CommandArgument='<%# Eval("inspeccionId") %>'
                                  OnCommand="ImageButton4_Command" Visible='<%# evaluateShowProperty(Eval("estadoInspeccionId")) %>' />
                                <asp:ImageButton ID="ImageButton3" noshow="noshow" runat="server" ImageUrl="~/Images/IconDelete.gif"
                                  OnClientClick="return false;" CssClass="doAnularAction" solicitudid='<%# Eval("solicitudId") %>'
                                  inspeccionid='<%# Eval("inspeccionId") %>' Visible='<%# evaluateShowPropertyAnular(Eval("estadoInspeccionId")) %>' />
                              </td>
                            </tr>
                          </table>
                        </ItemTemplate>
                      </asp:TemplateField>
                      <asp:BoundField DataField="vehiculoId" HeaderText="vehiculoId" InsertVisible="False"
                        ReadOnly="True" SortExpression="vehiculoId" Visible="False" />
                      <asp:BoundField DataField="aseguradoId" HeaderText="aseguradoId" SortExpression="aseguradoId"
                        Visible="False" />
                      <asp:BoundField DataField="marcaVehiculoId" HeaderText="marcaVehiculoId" SortExpression="marcaVehiculoId"
                        Visible="False" />
                      <asp:BoundField DataField="contactoId" HeaderText="contactoId" SortExpression="contactoId"
                        Visible="False" />
                      <asp:BoundField DataField="valorId" HeaderText="valorId" InsertVisible="False" ReadOnly="True"
                        SortExpression="valorId" Visible="False" />
                      <asp:BoundField DataField="valor" HeaderText="valor" SortExpression="valor" Visible="False" />
                      <asp:BoundField DataField="moneda" HeaderText="moneda" SortExpression="moneda" Visible="False" />
                    </Columns>
                    <RowStyle CssClass="ItemStyle" />
                    <HeaderStyle CssClass="HeaderStyle" />
                  </asp:GridView>
                  <div id="NewInspeccionDiv" runat="server" style="text-align: left;">
                    <asp:FormView ID="frmViewNewInspeccion" runat="server" BorderWidth="0px" CellPadding="0"
                      DataKeyNames="solicitudId,inspeccionId" DefaultMode="Insert" DataSourceID="odsInspecciones"
                      OnItemInserted="frmViewNewInspeccion_ItemInserted" OnItemInserting="frmViewNewInspeccion_ItemInserting">
                      <InsertItemTemplate>
                        <table id="Table2" border="1" cellspacing="0" rules="all" style="border-collapse: collapse"
                          width="100%">
                          <tr class="HeaderStyle" style="display: <%=showHeader %>;">
                            <th scope="col">
                              N°</th>
                            <th scope="col">
                              N° Insp.</th>
                            <th scope="col">
                              Asegurado</th>
                            <th scope="col">
                              Contacto</th>
                            <th scope="col">
                              Marca</th>
                            <th scope="col">
                              Modelo</th>
                            <th scope="col">
                              Año</th>
                            <th scope="col">
                              Placa</th>
                            <th scope="col">
                              Chasis</th>
                            <th scope="col">
                              Color</th>
                            <th scope="col" colspan="2">
                              Valor</th>
                            <th scope="col">
                              Fecha Estado</th>
                            <th scope="col">
                              Acción</th>
                          </tr>
                          <tr class="ItemStyle">
                            <td align="left" style="width: 19px;">
                              &nbsp;</td>
                            <td align="center" style="width: 72px;">
                              &lt;AUTO&gt;&nbsp;</td>
                            <td align="left" style="width: 155px;">
                              <cc1:AutoSuggestBox ID="asbAsegurado" runat="server" CssClass="FormText" DataType="Contratante"
                                IncludeMoreMenuItem="False" KeyPressDelay="300" MaxSuggestChars="8" MenuCSSClass="asbMenu"
                                MenuItemCSSClass="asbMenuItem" MoreMenuItemLabel="..." NoValueSelectedCSSClass="asbNonValueSelected"
                                NumMenuItems="15" OnFocusShowAll="True" ResourcesDir="./Scripts/asb_includes" SelectedValue='<%# Bind("aseguradoId") %>'
                                SelMenuItemCSSClass="asbSelMenuItem" Style="position: static" Text='<%# Bind("persona") %>'
                                UseIFrame="False" WarnNoValueSelected="False" Width="140px"></cc1:AutoSuggestBox></td>
                            <td align="left" style="width: 150px;">
                              <cc1:AutoSuggestBox ID="asbContacto" runat="server" CssClass="FormText" DataType="Contacto"
                                IncludeMoreMenuItem="False" KeyPressDelay="300" MaxSuggestChars="8" MenuCSSClass="asbMenu"
                                MenuItemCSSClass="asbMenuItem" MoreMenuItemLabel="..." NoValueSelectedCSSClass="asbNonValueSelected"
                                NumMenuItems="15" OnFocusShowAll="True" ResourcesDir="./Scripts/asb_includes" SelectedValue='<%# Bind("contactoId") %>'
                                SelMenuItemCSSClass="asbSelMenuItem" Style="position: static" Text='<%# Bind("contacto") %>'
                                UseIFrame="False" WarnNoValueSelected="False" Width="135px"></cc1:AutoSuggestBox></td>
                            <td style="width: 74px;">
                              <cc1:AutoSuggestBox ID="asbMarca" runat="server" CssClass="FormText" DataType="MarcaVehiculo"
                                IncludeMoreMenuItem="False" KeyPressDelay="300" MaxSuggestChars="5" MenuCSSClass="asbMenu"
                                MenuItemCSSClass="asbMenuItem" MoreMenuItemLabel="..." NoValueSelectedCSSClass="asbNonValueSelected"
                                NumMenuItems="15" OnFocusShowAll="False" ResourcesDir="./Scripts/asb_includes"
                                SelMenuItemCSSClass="asbSelMenuItem" Text='<%# Bind("marcaVehiculo") %>' UseIFrame="True"
                                WarnNoValueSelected="False" Width="55px"></cc1:AutoSuggestBox></td>
                            <td align="center" style="width: 76px;">
                              <asp:TextBox ID="ModeloTextBox" runat="server" CssClass="FormText" Width="60px" Text='<%# Bind("modeloVehiculo") %>'></asp:TextBox></td>
                            <td align="center" style="width: 49px;">
                              <asp:TextBox ID="anhoTextBox" runat="server" CssClass="FormText" Width="40px" Text='<%# Eval("anhoFabricacion", "{0:yyyy}") %>'></asp:TextBox></td>
                            <td align="center" style="width: 53px;">
                              <asp:TextBox ID="placaTextBox" runat="server" CssClass="FormText" Width="43px" Text='<%# Bind("placa") %>'></asp:TextBox></td>
                            <td align="center" style="width: 75px;">
                              <asp:TextBox ID="txtChasis" runat="server" CssClass="FormText" Width="60px" Text='<%# Bind("chasis") %>'></asp:TextBox></td>
                            <td align="center" style="width: 52px;">
                              <asp:TextBox ID="txtColor" runat="server" CssClass="FormText" Text='<%# Bind("colorVehiculo") %>'
                                Width="43px"></asp:TextBox></td>
                            <td align="center" style="width: 52px;">
                              <asp:DropDownList ID="cbxMoneda" runat="server" DataSourceID="odsMoneda" DataTextField="simbolo"
                                DataValueField="monedaId" SelectedValue='<%# Bind("monedaId") %>' Width="34px"
                                CssClass="FormText">
                              </asp:DropDownList>&nbsp;</td>
                            <td align="center" style="width: 61px;">
                              <asp:TextBox ID="txtValor" runat="server" CssClass="FormText " Width="45px" Text='<%# Bind("valor") %>'></asp:TextBox>&nbsp;</td>
                            <td align="center" style="width: 90px;">
                              &nbsp;</td>
                            <td align="center" style="width: 44px;">
                              <asp:ImageButton ID="ingBtnSave" runat="server" CommandName="Insert" ImageUrl="~/Images/btnGuardarGrilla.jpg"
                                OnClientClick="return validaInsercionBlancos();" ToolTip="GRABAR" />&nbsp;</td>
                          </tr>
                        </table>
                      </InsertItemTemplate>
                    </asp:FormView>
                  </div>
                  <br />
                </div>
              </div>
            </div>
            <div class="DataBottom">
              <div class="DataBottomLeft">
              </div>
              <div class="DataBottomRight">
              </div>
            </div>
            <div id="controlPanel">
              <div class="DataTop">
                <div class="DataTopLeft">
                </div>
                <div class="DataTopRight">
                </div>
              </div>
              <div class="DataContent">
                <div class="DataContentRight" style="height: 52px;">
                  <cc2:xWebPanelControl UseDefaultCssClass="true" ID="XWebPanelControl4" PermissionToCheck="SOLICITUD_GRABAR"
                    runat="server" Style="float: left" Width="66px">
                    <asp:ImageButton ID="guardarImageButton" runat="server" ImageUrl="~/Images/IconSave48Dark.gif"
                      ToolTip="Guardar Datos" CssClass="MakeClear SHORTCUT" keycode='19' OnClick="guardarImageButton_Click"
                      ValidationGroup="SolicitudSave" OnClientClick="return checkIfStillDummies();" />
                  </cc2:xWebPanelControl>
                  <cc2:xWebPanelControl UseDefaultCssClass="true" ID="XWebPanelControl56" PermissionToCheck="SOLICITUD_BORRAR"
                    runat="server" Style="float: left">
                    &nbsp;<asp:ImageButton ID="imgBtnBorrarInspeccion" keycode='2' runat="server" CssClass="MakeClear SHORTCUT"
                      ImageUrl="~/Images/IconReject48.jpg" OnClick="imgBtnBorrarInspeccion_Click" OnClientClick="return doErase();" /></cc2:xWebPanelControl>
                  <div style="float: right; width: 400px; text-align: right;">
                    <cc2:xWebPanelControl Style="display: inline;" ID="XWebPanelControl5" PermissionToCheck="SOLICITUD_ANULAR"
                      runat="server" CssClass="divPanelSeguridad">
                      <asp:ImageButton ID="anularImageButton" runat="server" ImageUrl="~/Images/btnAnularSolicitud.jpg"
                        ToolTip="Anular Solicitud" CssClass="MakeClear" />
                    </cc2:xWebPanelControl>
                    <cc2:xWebPanelControl Style="display: inline;" ID="XWebPanelControl" PermissionToCheck="SOLICITUD_NOTIFICAR"
                      runat="server" CssClass="divPanelSeguridad">
                      <asp:ImageButton ID="notificarImageButton" runat="server" ImageUrl="~/Images/btnNotificar.jpg"
                        ToolTip="Enviar notificación" CssClass="MakeClear SHORTCUT" keycode='14' OnClientClick="return false;" />
                    </cc2:xWebPanelControl>
                    <cc2:xWebPanelControl Style="display: inline;" ID="XWebPanelControl3" runat="server"
                      PermissionToCheck="SOLICITUD_ENVIAR">
                      <asp:ImageButton ID="enviarImageButton" runat="server" ImageUrl="~/Images/btnEnviarSolicitud.jpg"
                        ToolTip="Enviar Solicitud" CssClass="MakeClear SHORTCUT" keycode='13' OnClick="enviarImageButton_Click"
                        OnClientClick="return validaSend();" /></cc2:xWebPanelControl>
                    &nbsp;&nbsp;
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
            <asp:ObjectDataSource ID="odsTRequerimiento" runat="server" OldValuesParameterFormatString="original_{0}"
              SelectMethod="GetData" TypeName="dsComboTableAdapters.TipoRequerimientoComboTableAdapter">
              <SelectParameters>
                <asp:Parameter Name="estado" Type="String" />
              </SelectParameters>
            </asp:ObjectDataSource>
            <asp:ObjectDataSource ID="odsPrioridad" runat="server" OldValuesParameterFormatString="original_{0}"
              SelectMethod="GetData" TypeName="dsComboTableAdapters.PrioridadComboTableAdapter">
              <SelectParameters>
                <asp:Parameter Name="estado" Type="String" />
              </SelectParameters>
            </asp:ObjectDataSource>
            <asp:ObjectDataSource ID="odsCanal" runat="server" OldValuesParameterFormatString="original_{0}"
              SelectMethod="GetData" TypeName="dsComboTableAdapters.CanalComboTableAdapter">
              <SelectParameters>
                <asp:Parameter Name="estado" Type="String" />
              </SelectParameters>
            </asp:ObjectDataSource>
            <asp:ObjectDataSource ID="odsTipoDoc" runat="server" OldValuesParameterFormatString="original_{0}"
              SelectMethod="GetData" TypeName="ADM_DAL.dsDropDownListTableAdapters.TDocIdLoadDropDownTableAdapter">
              <SelectParameters>
                <asp:Parameter DefaultValue="A" Name="estado" Type="String" />
              </SelectParameters>
            </asp:ObjectDataSource>
            <asp:ObjectDataSource ID="odsCliente" runat="server" OldValuesParameterFormatString="original_{0}"
              SelectMethod="GetData" TypeName="ADM_DAL.dsDropDownListTableAdapters.ClienteLoadDropDownTableAdapter">
              <SelectParameters>
                <asp:Parameter DefaultValue="A" Name="estado" Type="String" />
              </SelectParameters>
            </asp:ObjectDataSource>
            <asp:ObjectDataSource ID="odsAseguradora" runat="server" OldValuesParameterFormatString="original_{0}"
              SelectMethod="GetData" TypeName="ADM_DAL.dsDropDownListTableAdapters.AseguradoraLoadDropDownTableAdapter">
              <SelectParameters>
                <asp:Parameter DefaultValue="A" Name="estado" Type="String" />
              </SelectParameters>
            </asp:ObjectDataSource>
            <asp:ObjectDataSource ID="odsBroker" runat="server" OldValuesParameterFormatString="original_{0}"
              SelectMethod="GetData" TypeName="ADM_DAL.dsDropDownListTableAdapters.BrokerLoadDropDownTableAdapter">
              <SelectParameters>
                <asp:Parameter DefaultValue="A" Name="estado" Type="String" />
              </SelectParameters>
            </asp:ObjectDataSource>
            <asp:ObjectDataSource ID="odsSolicitud" runat="server" SelectMethod="GetData" TypeName="dsSolicitudTableAdapters.SolicitudCabeceraTableAdapter"
              UpdateMethod="Update" OnSelected="odsSolicitud_Selected" OnUpdated="odsSolicitud_Updated">
              <UpdateParameters>
                <asp:Parameter Name="solicitudId" Type="Decimal" />
                <asp:Parameter Name="numeSolicitudCliente" Type="String" />
                <asp:Parameter Name="clienteId" Type="Decimal" />
                <asp:Parameter Name="aseguradoraId" Type="Decimal" />
                <asp:Parameter Name="brokerId" Type="Decimal" />
                <asp:Parameter Name="canalId" Type="Int32" />
                <asp:Parameter Name="fsolicitud" Type="DateTime" />
                <asp:Parameter Name="solicitadopor" Type="String" />
                <asp:Parameter Name="trequerimientoId" Type="String" />
                <asp:Parameter Name="prioridadId" Type="String" />
                <asp:Parameter Name="observacion" Type="String" />
                <asp:Parameter Name="usuarioId" Type="Int32" />
                <asp:Parameter Name="uupdate" Type="String" />
                <asp:Parameter Name="numeVehiculos" Type="Int32" />
                <asp:Parameter Name="clienteVIP" Type="Boolean" />
                <asp:Parameter Name="contactoId" Type="Decimal" />
                <asp:Parameter Name="contratanteId" Type="Decimal" />
              </UpdateParameters>
              <SelectParameters>
                <asp:QueryStringParameter DefaultValue="3" Name="solicitudId" QueryStringField="SolicitudId"
                  Type="Decimal" />
              </SelectParameters>
            </asp:ObjectDataSource>
            <asp:ObjectDataSource ID="odsContratante" runat="server" SelectMethod="GetData" TypeName="dsSolicitudTableAdapters.ContratanteSolicitudTableAdapter"
              UpdateMethod="Update" OnUpdated="odsContratante_Updated" OnUpdating="odsContratante_Updating">
              <UpdateParameters>
                <asp:Parameter Name="solicitudId" Type="Decimal" />
                <asp:Parameter Direction="InputOutput" Name="personaId" Type="Object" />
                <asp:Parameter Name="persona" Type="String" />
                <asp:Parameter Name="TDocumentoIdentidad" Type="String" />
                <asp:Parameter Name="DocumentoIdentidad" Type="String" />
                <asp:Parameter Name="direccionTrabajo" Type="String" />
                <asp:Parameter Name="ubigeoIdTrabajo" Type="String" />
                <asp:Parameter Name="email" Type="String" />
                <asp:Parameter Name="TelefonoFijo1" Type="String" />
                <asp:Parameter Name="TelefonoFijo2" Type="String" />
                <asp:Parameter Name="Fax" Type="String" />
                <asp:Parameter Name="uupdate" Type="String" />
              </UpdateParameters>
              <SelectParameters>
                <asp:QueryStringParameter DefaultValue="3" Name="solicitudId" QueryStringField="SolicitudId"
                  Type="Decimal" />
              </SelectParameters>
            </asp:ObjectDataSource>
            <asp:ObjectDataSource ID="odsContacto" runat="server" SelectMethod="GetData" TypeName="dsSolicitudTableAdapters.ContactoSolicitudTableAdapter"
              UpdateMethod="Update" OnUpdated="odsContacto_Updated" OnUpdating="odsContacto_Updating">
              <UpdateParameters>
                <asp:Parameter Name="solicitudId" Type="Decimal" />
                <asp:Parameter Direction="InputOutput" Name="contactoId" Type="Object" />
                <asp:Parameter Name="contacto" Type="String" />
                <asp:Parameter Name="email" Type="String" />
                <asp:Parameter Name="telefono1" Type="String" />
                <asp:Parameter Name="telefono2" Type="String" />
              </UpdateParameters>
              <SelectParameters>
                <asp:QueryStringParameter DefaultValue="3" Name="solicitudId" QueryStringField="SolicitudId"
                  Type="Decimal" />
              </SelectParameters>
            </asp:ObjectDataSource>
            <asp:ObjectDataSource ID="odsInspecciones" runat="server" DeleteMethod="Delete" InsertMethod="Insert"
              SelectMethod="GetData" TypeName="dsSolicitudTableAdapters.InspecionesSolicitudTableAdapter"
              OnSelected="odsInspecciones_Selected">
              <DeleteParameters>
                <asp:Parameter Name="inspeccionId" Type="Decimal" />
              </DeleteParameters>
              <SelectParameters>
                <asp:QueryStringParameter DefaultValue="3" Name="solicitudId" QueryStringField="SolicitudId"
                  Type="Decimal" />
              </SelectParameters>
              <InsertParameters>
                <asp:Parameter Direction="InputOutput" Name="inspeccionId" Type="Object" />
                <asp:Parameter Name="solicitudId" Type="Decimal" />
                <asp:Parameter Name="aseguradoId" Type="Int32" />
                <asp:Parameter Name="persona" Type="String" />
                <asp:Parameter Name="contactoId" Type="Decimal" />
                <asp:Parameter Name="contacto" Type="String" />
                <asp:Parameter Name="marcaVehiculo" Type="String" />
                <asp:Parameter Name="modeloVehiculo" Type="String" />
                <asp:Parameter Name="anhoFabricacion" Type="DateTime" />
                <asp:Parameter Name="placa" Type="String" />
                <asp:Parameter Name="chasis" Type="String" />
                <asp:Parameter Name="colorVehiculo" Type="String" />
                <asp:Parameter Name="valor" Type="Decimal" />
                <asp:Parameter Name="monedaId" Type="String" />
                <asp:Parameter Name="ucrea" Type="String" />
              </InsertParameters>
            </asp:ObjectDataSource>
            <asp:ObjectDataSource ID="odsMoneda" runat="server" OldValuesParameterFormatString="original_{0}"
              SelectMethod="GetData" TypeName="ADM_DAL.dsDropDownListTableAdapters.MonedaLoadDropDownTableAdapter">
              <SelectParameters>
                <asp:Parameter DefaultValue="A" Name="estado" Type="String" />
              </SelectParameters>
            </asp:ObjectDataSource>
            <asp:ObjectDataSource ID="odsMarca" runat="server" OldValuesParameterFormatString="original_{0}"
              SelectMethod="GetData" TypeName="ADM_DAL.dsDropDownListTableAdapters.MarcaVehiculoLoadDropDownTableAdapter">
              <SelectParameters>
                <asp:Parameter Name="claseVehiculoId" Type="Decimal" />
              </SelectParameters>
            </asp:ObjectDataSource>
            <asp:HiddenField ID="urlHiddenField" runat="server" />
            <asp:HiddenField ID="agendarHiddenField" runat="server" />
            <asp:ObjectDataSource ID="odsListaAnexos" runat="server" DeleteMethod="Delete" InsertMethod="Insert"
              OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsAnexosTableAdapters.AnexoTableAdapter">
              <DeleteParameters>
                <asp:Parameter Name="AnexoId" Type="Int32" />
              </DeleteParameters>
              <SelectParameters>
                <asp:QueryStringParameter DefaultValue="" Name="solicitudId" QueryStringField="SolicitudId"
                  Type="Decimal" />
              </SelectParameters>
              <InsertParameters>
                <asp:Parameter Direction="InputOutput" Name="AnexoId" Type="Object" />
                <asp:Parameter Name="filename" Type="String" />
                <asp:Parameter Name="observacion" Type="String" />
                <asp:Parameter Name="binarydata" Type="Object" />
                <asp:Parameter Name="ucrea" Type="String" />
                <asp:Parameter Name="solicitudId" Type="Decimal" />
              </InsertParameters>
            </asp:ObjectDataSource>
            <asp:ObjectDataSource ID="odsMotivoCombo" runat="server" OldValuesParameterFormatString="original_{0}"
              SelectMethod="GetData" TypeName="dsComboTableAdapters.MotivoComboTableAdapter">
              <SelectParameters>
                <asp:Parameter DefaultValue="I" Name="tipo" Type="String" />
                <asp:Parameter DefaultValue="A" Name="estado" Type="String" />
              </SelectParameters>
            </asp:ObjectDataSource>
            <asp:ObjectDataSource ID="odsMotivoAnulacion" runat="server" OldValuesParameterFormatString="original_{0}"
              SelectMethod="GetData" TypeName="dsComboTableAdapters.MotivoComboTableAdapter">
              <SelectParameters>
                <asp:Parameter DefaultValue="S" Name="tipo" Type="String" />
                <asp:Parameter DefaultValue="A" Name="estado" Type="String" />
              </SelectParameters>
            </asp:ObjectDataSource>
          </td>
        </tr>
      </table>
    </div>
    <div id="ToolTipInspeccion" class="ToolTip" style="width: 280px;">
      <asp:Button ID="btnGoTo" runat="server" CssClass="FormButton" Style="right: 2px;
        position: absolute; top: 2px" Text="Ir a" Width="35px" Visible="true" OnClientClick="irUrl();return false;" />
      <asp:ImageButton ToolTip="Ver Informe" ID="ImgViewReport" VehiculoId='-1' ImageUrl="~/images/IconPdf16.gif" OnClientClick="doPreview();return false;"
        Style="display: none;position:absolute;top:2px;right:40px;" runat="server" />
     <asp:ImageButton ToolTip="Ver Ampliatorios" ID="imgAmpliatorios" ImageUrl="~/Images/IconAmpl16.gif" OnClientClick="viewAmpliatorios();return false;"
        Style="display: none;position:absolute;top:2px;right:60px;" runat="server" />
        
      <div id="informacion">
        <div id="divCita" style="font-weight: bold">
          <strong style="font-size: 11px">Inspección</strong>
        </div>
        <div id="divGridComunicacion">
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
    </div>
    <div id="dropDownAnular" class="popUpForm" style="display: none;">
      <table border="0" cellpadding="0" cellspacing="0" class="DataTable">
        <tr>
          <td align="left" style="font-weight: bold; height: 12px;">
            Motivo</td>
        </tr>
        <tr>
          <td align="left">
            <asp:DropDownList ID="cbxMotivoAnulacion" runat="server" CssClass="FormText NOHIDE"
              DataSourceID="odsMotivoCombo" DataTextField="motivo" DataValueField="motivoId"
              Width="240px" AppendDataBoundItems="True">
              <asp:ListItem Selected="True" Value="-1">[ Elija ]</asp:ListItem>
            </asp:DropDownList></td>
        </tr>
        <tr>
          <td align="left" style="font-weight: bold;" valign="bottom">
            Observación</td>
        </tr>
        <tr>
          <td align="left">
            <asp:TextBox ID="txtAnularObservacion" runat="server" CssClass="FormText" Rows="3"
              TextMode="MultiLine" Width="240px"></asp:TextBox></td>
        </tr>
        <tr>
          <td align="right" style="height: 17px">
            <asp:Button ID="btnAnularSolicitud" runat="server" CssClass="FormButton" OnClick="btnAnularSolicitud_Click"
              Text="Anular Solicitud" />&nbsp;
            <input id="cancelarButton" onclick="xMenuAnular.hide();return false;" class="FormButton"
              type="button" value="Cancelar" />
          </td>
        </tr>
        <tr>
          <td align="right" style="height: 17px">
            <table border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td valign="top">
                  <asp:Image ID="Image1" runat="server" ImageUrl="~/Images/IconAlert16.gif" />
                </td>
                <td style="text-align: left" valign="top">
                  Al ANULAR UNA SOLICITUD&nbsp;TODAS LAS INSPECCIONES TAMBI&Eacute;N SON ANULADAS</td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
    </div>
    <div id="dropDownAnulaInspeccion" class="popUpForm" style="display: none;">
      <table border="0" cellpadding="0" cellspacing="0" class="DataTable">
        <tr>
          <td align="left" style="font-weight: bold; height: 12px;">
            Motivo</td>
        </tr>
        <tr>
          <td align="left">
            <asp:DropDownList ID="cbxMotivo" runat="server" CssClass="FormText NOHIDE" DataSourceID="odsMotivoCombo"
              DataTextField="motivo" DataValueField="motivoId" Width="240px" AppendDataBoundItems="True">
              <asp:ListItem Selected="True" Value="-1">[ Elija ]</asp:ListItem>
            </asp:DropDownList>
          </td>
        </tr>
        <tr>
          <td align="left" style="font-weight: bold;" valign="bottom">
            Observación<asp:TextBox ID="txtInspeccionId" Style="display: none;" runat="server"
              CssClass="FormText" Width="26px"></asp:TextBox>
            <asp:TextBox ID="txtSolicitudId" Style="display: none;" runat="server" CssClass="FormText"
              Width="26px"></asp:TextBox>
          </td>
        </tr>
        <tr>
          <td align="left">
            <asp:TextBox ID="txtObservacionAnulacionInspeccion" runat="server" Rows="3" TextMode="MultiLine"
              Width="240px" CssClass="FormText"></asp:TextBox></td>
        </tr>
        <tr>
          <td align="right" style="height: 20px">
            <asp:Button ID="Button1" runat="server" CssClass="FormButton" OnClick="Button1_Click"
              Text="Anular Inspección" />
            <input id="btnCancel" onclick="xMenuAnularInspeccion.hide();return false;" class="FormButton"
              type="button" value="Cancelar" />
          </td>
        </tr>
        <tr>
          <td align="right" style="height: 20px">
            <table border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td valign="top">
                  <asp:Image ID="Image2" runat="server" ImageUrl="~/Images/IconAlert16.gif" />
                </td>
                <td style="text-align: left" valign="top">
                  Al ANULAR UNA INSPECCIÓN ESTA YA NO PODRÁ SER MODIFICADA. NI SE PODRÁ EMITIR UN
                  REPORTE SOBRE SU DESARROLLO.</td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
    </div>
<%--    <div id="divPickCliente" class="popUpForm" style="display: none; text-align: left;
      padding: 1px;">
      <asp:TextBox ID="txtPickCliente" TabIndex="107" CssClass="FormText MAYUSC" runat="server"
        Width="307px"></asp:TextBox>
    </div>
    <div id="divPickAseguradora" class="popUpForm" style="display: none; text-align: left;
      left: 0px; top: 0px; padding: 1px;">
      <asp:TextBox ID="txtPickAseguradora" TabIndex="117" CssClass="FormText MAYUSC" runat="server"
        Width="307px"></asp:TextBox>
    </div>
    <div id="divPickBroker" class="popUpForm" style="display: none; text-align: left;
      left: 0px; top: 0px; padding: 1px;">
      <asp:TextBox ID="txtPickBroker" TabIndex="127" CssClass="FormText MAYUSC" runat="server"
        Width="307px"></asp:TextBox>
    </div>--%>
    <uc2:ucNotifier ID="UcNotifier1" runat="server" EnableViewState="true" TriggerID="notificarImageButton" />

    <script type="text/javascript">
    //couldUse domReady but it has been failing this an old aproach, effective, but ugly and messy
    __blockDivs();
    </script>

  </form>
</body>
</html>
