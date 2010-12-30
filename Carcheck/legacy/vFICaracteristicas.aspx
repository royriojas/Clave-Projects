<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vFICaracteristicas.aspx.cs"
  Inherits="vFICaracteristicas" %>

<%@ Register Src="ucAnularInspeccion.ascx" TagName="ucAnularInspeccion" TagPrefix="uc3" %>
<%@ Register Assembly="CustomPanelWebControl" Namespace="xWebControl" TagPrefix="cc3" %>
<%@ Register Src="ucHeader.ascx" TagName="ucHeader" TagPrefix="uc1" %>
<%@ Register Src="~/ucControlTab.ascx" TagName="ControlTab" TagPrefix="uc2" %>
<%@ Register Src="ucPnlPropiedades.ascx" TagName="ucPnlPropiedades" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
  <title>
    <%=CCSOL.Utiles.Utilidades.GetSystemNameAndVersion() %>
    | Inspección | Características</title>
  <link href="Css/TreeLayout.css" rel="stylesheet" type="text/css" />

  <script type="text/javascript" src="Scripts/lib/x.js"></script>

  <script type="text/javascript" src="Scripts/lib/x_common.js"></script>

  <script type="text/javascript" src="Scripts/lib/xDropDownMenu.js"></script>

  <script type="text/javascript">
       
        function RadioOnClick(e) {
            //alert('a Radio was Clicked');
            var xEvt = new xEvent(e);
            var aLink = xNextSib(xEvt.target,'A');
            aLink.className = 'selected';
        }
        function RadioOnBlur(e) {
            //alert('a Radio was Blured');
            var xEvt = new xEvent(e);
            var aLink = xNextSib(xEvt.target,'A');
            aLink.className = '';
        }
        var _inputs = null;
        function radioSelectedChangeCSSClass() {
          if ($('pnlTreeView') != null) {
              _inputs = xGetElementsByTagName('INPUT',$('pnlTreeView'));
              if (_inputs != null) { 
                for (i = 0; i < _inputs.length; i++) {
                    xAddEventListener(_inputs[i],'click',RadioOnClick,false);
                    xAddEventListener(_inputs[i],'blur',RadioOnBlur,false);
                }
              } 
          }                       
        }
        
        window.onload = function () {
            
            radioSelectedChangeCSSClass();
        }
        
        window.onunload = function () {
            for (i = 0; i < _inputs.length; i++) {
                xRemoveEventListener(_inputs[i],'click',RadioOnClick,false);
                xRemoveEventListener(_inputs[i],'blur',RadioOnBlur,false);
            }   
            _inputs = null;
        }
        
         
        function doClickInput(ele) {
            var inputs = xGetElementsByTagName('INPUT',ele.parentNode);
            if (inputs.length > 0) {
                inputs[0].click();
            }            
        }
        
        
        var thePropiedadId;
        
        function doClickCategoria(ele_id) {
            $(ele_id).click();           
        }
        function doRefresh(ele,arg)
        {     
            thePropiedadId = arg;    
            $('seleccionarLabel').style.display = 'none';
            
            CCSOL.DOM.xShowLoadingMessage(":: Actualizando el formulario ::",99,20,5);
            //$('pnlLoadingMessage').style.display = 'block';
            //$('containerToDoAjaxStuff').innerHTML = '';
            doSingleRefresh(arg);
        }
        
        function doSingleRefresh(arg,showMessage) {
          var context;          
          if (showMessage) CCSOL.DOM.xShowLoadingMessage(':: actualizando propiedades ::',99,20,5);
          <%=ClientScript.GetCallbackEventReference(this.cckhandler, "arg", "doCallback_Refresh", "context", "HandleError", false) %>;          
        }
        
        function doCallback_Refresh(result, context)
        {
                        
            var linea=new String(result);
            var lista = linea.split("$$$$_$$$$"); 

            $('pnlLoadingMessage').style.display = 'none';
            $("containerToDoAjaxStuff").style.display = 'block';
            $("containerToDoAjaxStuff").innerHTML = lista[0];            
            $("grillaPanel").innerHTML = lista[1];
            
            $("grillaPanelContainer").style.display = 'block';
            CCSOL.DOM.xHideLoadingMessage();
            __initCaseFormatter();
            
        }
        
        function HandleError(message)
        {
          CCSOL.Utiles.Trace("Unhandled error:\n\n" + message);
        }
        
        function Eliminar(propiedadId)
        {
          var result;
          if(confirm("Se eliminara el registro\n\n¿Desea proseguir?")) {                      
            CarCheck.Gestores.GestorInspeccion.PropertyDelete('<%= vehiculoId %>', propiedadId,
            Eliminar_CallBack);                                    
          }
        }
        function Eliminar_CallBack() {
          
          doSingleRefresh(thePropiedadId,true);
        }
        
        
  </script>

  <link href="Css/layoutTabs.css" rel="stylesheet" type="text/css" />
  <link href="css/layout.css" rel="stylesheet" type="text/css" />
  <link href="./Scripts/x_info/xInfo.css" rel="stylesheet" type="text/css" />
</head>
<body>
  <form id="form1" runat="server">
    <div class="Blockable">
      <table id="Data" border="0" cellpadding="0" cellspacing="0" align="center">
        <tr>
          <td>
            <uc1:ucHeader ID="UcHeader1" runat="server" PageFunctionalityToCheck="INS_CARACTERISTICAS_VER" />
            <uc2:ControlTab ID="ControlTab1" runat="server" LabelText="Inspección: INS - 001 - XXX"
              TabActual="Caracteristicas" />
            <div class="DataContent">
              <div class="DataContentRight" style="padding-top: 1px">
                <div style="margin-top: 4px">
                  <div>
                    <table border="0" cellspacing="0" cellpadding="0" style="width: 100%">
                      <tr>
                        <td valign="top" style="width: 290px; padding-top: 8px;">
                          <div id="pnlTreeView" style="padding: 5px; width: 282px; height: 360px;" class="TreeViewPanel">
                            <asp:TreeView ShowLines="true" ID="treeViewPropiedadesVehiculo" runat="server">
                            </asp:TreeView>
                          </div>
                        </td>
                        <td style="padding-left: 10px;" valign="top">
                          <span id="seleccionarLabel">
                            <br />
                            Selecione una propiedad del árbol de opciones</span>
                          <div id="pnlLoadingMessage" style="display: none;">
                            <div>
                              <table id="myTable" border="0" cellpadding="0" cellspacing="0" width="225">
                                <tr>
                                  <td style="width: 35px" width="44">
                                    <div align="center">
                                      <img src="Images/i_animated_loading_32_2.gif" /></div>
                                  </td>
                                  <td width="181">
                                    <p>
                                      Actualizando el Formulario...
                                    </p>
                                  </td>
                                </tr>
                              </table>
                            </div>
                          </div>
                          <div id="containerToDoAjaxStuff" style="display: none; width: 636px">
                            <uc1:ucPnlPropiedades ID="UcPnlPropiedadesVehiculo" runat="server" PropiedadId="69">
                            </uc1:ucPnlPropiedades>
                          </div>
                          <div id='grillaPanelContainer' class="PanelInset" style="width: 635px; height: 147px;
                            display: none; left: 0px; top: 0px;">
                            <div id="grillaPanel" style="width: 615px;">
                            </div>
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
                    &nbsp;<cc3:xWebPanelControl ID="XWebPanelControl2" Style="display: inline;" runat="server"
                      PermissionToCheck="INS_ANULAR">
                      <asp:ImageButton MenuDropDownType="anular" doShow="show" ID="anularImageButton" OnClientClick='return false;'
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
                        ToolTip="Terminar Inspección" CssClass="MakeClear" OnClick="ImageButton1_Click" Visible="False" />
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
                        ToolTip="Aprobar Inspección sin pago a ajustador" CssClass="MakeClear" OnClientClick="GenerateInform(1);return false;" Visible="False" />
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
    <uc3:ucAnularInspeccion ID="UcAnularInspeccion1" runat="server" TriggerId="anularImageButton" />
  </form>
</body>
</html>
