<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vMantenimientoImagenes.aspx.cs"
  Inherits="Control_vMantenimientoImagenes" %>

<%@ Register Src="../ucSecurityController.ascx" TagName="ucSecurityController" TagPrefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
  <title>
    <%=CCSOL.Utiles.Utilidades.GetSystemNameAndVersion() %>
    | Imagenes </title>
  <link href="../Css/gallery.css" rel="stylesheet" type="text/css" />
  <link href="../Css/layout.css" rel="stylesheet" type="text/css" />
  <link href="../Scripts/x_info/xInfo.css" rel="stylesheet" type="text/css" />

  <script type="text/javascript" src="../Scripts/lib/x.js"></script>

  <script type="text/javascript" src="../Scripts/lib/x_common.js"></script>

  <script type="text/javascript" src="../Scripts/lib/xDomReady.js"></script>

  <script type="text/javascript" src="../Scripts/lib/x_especialTooltip.js"></script>
  <script type="text/javascript" src="../Scripts/lib/x_checkAll.js"></script>
  
  <script type="text/javascript">

  function xxxInitCheckAll() {
     var xc = new xCheckAllN('chkAll', 'theGallery', null, null, null,true);
  }
   xAddEventListener(window,'load',xxxInitCheckAll,true);
  </script>

  <script type="text/javascript">
  
  function xxxOnToolTipDisplay(e) {
		  var xE = new xEvent(e);
		  $('xxxTitulo').innerHTML = '';
		  $('xxxObservacion').innerHTML = '';
		  $('xxxCorrespondencia').innerHTML = '';
		  
		  var imageTittle = CCSOL.DOM.x_GetAttribute(xE.target,'titulo');
		  $('xxxTitulo').innerHTML = imageTittle;
		  
		  var imageObservacionText = CCSOL.DOM.x_GetAttribute(xE.target,'observacion');
		  $('xxxObservacion').innerHTML = imageObservacionText;
		  
		  var imageCorrespondencia = CCSOL.DOM.x_GetAttribute(xE.target,'correspondencia');
		  $('xxxCorrespondencia').innerHTML = imageCorrespondencia;
		  
		}
    function xxxInitImageGallery() {
      	var t = new x_ToolTip('A',
							  'theGallery',
							  10,
							  10,
							  'xxxTooltip',
							  xxxOnToolTipDisplay,
							  'xImage');
    }
    xAddEventListener(window,'load',xxxInitImageGallery,true);
  </script>

  <script type="text/javascript">
    function doRefresh() {
      document.location.href = document.location.href + '';
    }
  </script>

  <script type="text/javascript">
	function VerImagen(ImagenId,VehiculoId){
		  var WinWidth = 790;
		  var WinHeight = 440;
		  var Xpos = (screen.width/2) - (WinWidth/2);
		  var Ypos = (screen.height/2) - (WinHeight/2);
		  window.open('../vVerImagen.aspx?ImagenId='+ImagenId+'&VehiculoId='+VehiculoId,'','width='+WinWidth+',height='+WinHeight+', left='+Xpos+', top='+Ypos+',scrollbars=1,resizable=1,menubar=no,status=yes,directories=no,location=no');
		}
  </script>

</head>
<body>
  <form id="form1" runat="server">
   <uc1:ucSecurityController Path=".." PageFunctionalityToCheck="IMAGENES_X_INFORME_VER" ID="UcSecurityController1" runat="server" />
    <div>
      <div class="DataTop">
        <div class="DataTopLeft">
        </div>
        <div class="DataTopRight">
        </div>
       
      </div>
      <div class="DataContent">
        <div class="DataContentRight">
          <div class="PanelEncabezado" style="left: 0px; top: 0px">
            <asp:Label ID="lblImagenxInspeccion" runat="server" Text="Imágenes de la Inspección"
              Font-Size="14pt" ToolTip="Mostrar / Ocultar Panel" Font-Names="Arial"></asp:Label>
            <img id="imgCollapse" alt="Mostrar / Ocultar Panel" src="../Images/IconHide16Dark.gif"
              title="Mostrar/Ocultar" style="margin-top: 3px;" class="MakeClear" />
          </div>
          <div class="DataTable PanelInset" style="height: 280px">
            <div class='theGallery'>
              <asp:Repeater ID="repeaterOtros" runat="server" DataSourceID="odsImagesByVehiculo">
                <ItemTemplate>
                  <div class='galleryHolder'>
                    <table width="100" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td align="center">
                          <img id='Image_<%#DataBinder.Eval(Container.DataItem, "imagenId")%>' class="xImage"
                            observacion='<%#DataBinder.Eval(Container.DataItem, "observacion")%>' onclick='VerImagen(<%#DataBinder.Eval(Container.DataItem, "imagenId")%>,<%#DataBinder.Eval(Container.DataItem, "vehiculoId")%>);'
                            src='../vGetImage.aspx?VehiculoId=<%#DataBinder.Eval(Container.DataItem, "vehiculoId")%>&ImagenId=<%#DataBinder.Eval(Container.DataItem, "imagenId")%>'
                            titulo='<%# DataBinder.Eval(Container.DataItem, "titulo")%>' correspondencia='<%#DataBinder.Eval(Container.DataItem, "imagenCorrespondencia")%>' />
                        </td>
                      </tr>
                      <tr>
                        <td>
                          <asp:Label ID="lblImagenId" style="display:none;" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "imagenId")%>'></asp:Label>
                          <asp:CheckBox Checked='<%# DataBinder.Eval(Container.DataItem, "incluirEnInforme") %>'
                            ID="chk" runat="server" />
                          Informe
                        </td>
                      </tr>
                    </table>
                  </div>
                </ItemTemplate>
                <FooterTemplate>
                  <div style="clear: both">
                  </div>
                </FooterTemplate>
              </asp:Repeater>
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
      <div>
        <div class="DataTop">
          <div class="DataTopLeft">
          </div>
          <div class="DataTopRight">
          </div>
        </div>
        <div class="DataContent">
          <div class="DataContentRight" style="left: 0px; top: 0px">
            <div style="float: right;font-size:10px;">
              <asp:CheckBox CssClass="FormCheck" ID="chkAll" runat="server" Text="Seleccionar Todos" />
            </div>
            <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/Images/IconSave48Dark.gif" OnClick="ImageButton1_Click" />
          </div>
        </div>
        <div class="DataBottom">
          <div class="DataBottomLeft">
          </div>
          <div class="DataBottomRight">
          </div>
        </div>
      </div>
      <asp:ObjectDataSource ID="odsImagesByVehiculo" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetData" TypeName="dsImagesTableAdapters.proc_Car_ImagenLoadAll_MaintenanceTableAdapter">
        <SelectParameters>
          <asp:QueryStringParameter Name="vehiculoId" QueryStringField="VehiculoId" Type="Decimal" />
        </SelectParameters>
      </asp:ObjectDataSource>
      <div id='xxxTooltip' class="ToolTip" style="position: absolute;">
        <table border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td >
              <span style="font-size: 11px; color: Black;" id='xxxTitulo'>asdasda</span></td>
          </tr>
          <tr>
            <td>
              <span style="font-size: 10px; color: Black;" id='xxxObservacion'>asdasd a</span></td>
          </tr>
          <tr>
            <td>
              <span style="font-size: 10px; color: Black;" id='xxxCorrespondencia'>asdasdasda</span></td>
          </tr>
        </table>
      </div>
    </div>
  </form>
</body>
</html>
