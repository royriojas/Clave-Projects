<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ucSecurityController.ascx.cs" Inherits="ucSecurityController" %>


<script type="text/javascript">
    function _keepSessionHandler(res) 
    {
      try {
        var lastTryMessage = res.value;
        //addOptions('frmDatosVehiculo_cbxModelo',res.value);
        window.status = ":: Sesión Renovada :: | " + lastTryMessage;
        CCSOL.DOM.xHideLoadingMessage();
      }
      catch(e) {
        alert('[ _keepSessionHandler ]: ' + e.message);
      }
    }
    function __keepAlive() {
      CCSOL.DOM.xShowLoadingMessage(':: Refrescando la Sesión ::');
      CarCheck.Gestores.GestorSeguridad.keepSessionAlive(_keepSessionHandler);
    }
    function __KeepSessionAlive() {
        setInterval("__keepAlive()",150000); //cada 15 minutos se refresca la sesión.
    }
    //xAddEventListener(window,'load',__KeepSessionAlive,false);    
	domReady(__KeepSessionAlive);
</script>

<script type="text/javascript">
  
  function _HideMessage() {
    $('divLoading').style.visibility = 'hidden';
  }
  xAddEventListener(window,'load',_HideMessage,true);
  
</script>

<div id='divLoading' class="summary" style="position: absolute; right: 10px; top: 10px;
  background-color: Red; padding: 5px; font: 12px/12px Arial,Verdana; color: #FFFFFF;
  font-weight: bold; width: auto; height: 15px;z-index:6000">
  Cargando... espere por favor</div>
