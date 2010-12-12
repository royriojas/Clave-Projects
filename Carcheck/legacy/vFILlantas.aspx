<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vFILlantas.aspx.cs" Inherits="vFILlantas" %>

<%@ Register Src="ucHeader.ascx" TagName="ucHeader" TagPrefix="uc1" %>
<%@ Register Src="~/ucControlTab.ascx" TagName="ControlTab" TagPrefix="uc2" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
  <title>Carcheck | Inspección | Llantas</title>
  <style type="text/css">
		.BorderBottom{border-bottom: solid white 1px; }
		.BorderLeft{border-left: solid #541C01 1px; }
		.BorderLeftRight{border-left: solid #541C01 1px; border-right: solid #541C01 1px; }
		.BorderRight{border-right: solid #541C01 1px; }
	</style>
  <link href="Css/layout.css" rel="stylesheet" type="text/css" />
  <link href="Css/layoutTabs.css" rel="stylesheet" type="text/css" />

  <script type="text/javascript" src="Scripts/lib/CollapsibleDiv.js"></script>

  <script type="text/javascript" src="Scripts/lib/x.js"></script>

  <script type="text/javascript" src="Scripts/lib/x_common.js"></script>

  <script type="text/javascript" src="Scripts/lib/xForms.js"></script>

  <script type="text/javascript" src="Scripts/lib/xCaseFormatter.js"></script>

  <script type="text/javascript">
	
	  function doNuevaLlantaInsert() {
	   
	   if (Page_ClientValidate()) {
	      CCSOL.DOM.xShowLoadingMessage("Procesando");
	      CCSOL.Utiles.RegenerateViewState();
        var context = 'nuevaLlantaInsert';
        var arg = '<%= Request.QueryString["VehiculoId"] %>';
        <%= ClientScript.GetCallbackEventReference(nuevaLlantaInsertCallBack, "arg", "doNuevaLlantaInsert_Callback", "context", "HandleError", false) %>           	    
      }
	  }
	  function doCallBackResult(){
	   
	    
	  }
	  var theResult;
	  function doNuevaLlantaInsert_Callback(result,context) {	   
	     CCSOL.DOM.xHideLoadingMessage();
	    $('llantaListPanel').innerHTML = result;
	    
	    clearFormElementsInDiv('nuevaLlanta');
	    //colapsar el panel
	    $('nuevaLlantaData').style.display = 'none';
	  }
		    
    function Editar(llantaId)
    {
			alert("se procede con la edición");
    }
    
    function Eliminar(llantaId)
    {
			if(confirm("Se eliminará el registro.\n\n¿Desea proseguir?"))
				alert("se procede con la eliminación");
    }

    function HandleError(message)
    {
      alert("Unhandled error:\n\n" + message);
    }
  
    var llantaLabel;
    var llantaImage;
    window.onload = function () {
      try {
        llantaLabel = new CollapsibleDiv ('nuevaLlantaLabel', 'nuevaLlantaData', true, null);
        llantaImage = new CollapsibleDiv ('nuevaLlantaImage', 'nuevaLlantaData', true, null);
        
        //añadimos el evento insert para el frmLlanta_txtCantidad       
       
      }
      catch(e)
      {
        alert(e.message);
      }
    } 
  </script>

  <link href="css/layout.css" rel="stylesheet" type="text/css" />
  <link href="Css/layoutTabs.css" rel="stylesheet" type="text/css" />
  <link href="css/layout.css" rel="stylesheet" type="text/css" />
  <link href="css/layout.css" rel="stylesheet" type="text/css" />
  <link href="Css/layoutTabs.css" rel="stylesheet" type="text/css" />
</head>
<body>
  <form id="form1" runat="server">
    <div>
      <table id="Data" border="0" cellpadding="0" cellspacing="0" align="center">
        <tr>
          <td>
            <uc1:ucHeader ID="UcHeader1" runat="server" />
            <uc2:ControlTab ID="ControlTab1" runat="server" LabelText="Inspección: INS - 001 - XXX"
              TabActual="Llantas" />
            <div class="DataContent">
              <div class="DataContentRight" style="padding-top: 1px">
                <div class="PanelStyle" style="margin-top: 4px">
                  <div class="PanelEncabezado">
                    <asp:Label ID="nuevaLlantaLabel" ToolTip="Mostrar / Ocultar Panel" runat="server"
                      Style="cursor: pointer" Text="Registro de llantas"></asp:Label>
                    <img id="nuevaLlantaImage" alt="Mostrar / Ocultar Panel" onmouseout="MakeClear(this,0)"
                      onmouseover="MakeClear(this,1);" src="Images/IconHide16Dark.gif" /></div>
                  <div id="nuevaLlantaData" class="DataTable">
                    <asp:FormView ID="frmLlanta" runat="server" DataKeyNames="vehiculoId,llantaId" DataSourceID="odsLlanta"
                      DefaultMode="Insert" OnItemInserting="FormView1_ItemInserting" CellPadding="0">
                      <InsertItemTemplate>
                        <table id="nuevaLlanta" runat="server" border="0" cellpadding="0" cellspacing="0"
                          visible="true">
                          <tr>
                            <td align="center" colspan="2">
                              <strong>LLANTA</strong></td>
                            <td align="center" colspan="2" class="BorderLeft">
                              <strong>ARO</strong></td>
                            <td align="center" colspan="4" class="BorderLeftRight">
                              <strong>OBSERVACIONES</strong></td>
                            <td align="center" colspan="1">
                              <strong>TRACCION</strong></td>
                          </tr>
                          <tr>
                            <td style="width: 55px">
                              Marca<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtMarcaLlanta"
                                ErrorMessage="Este valor es requerido" ToolTip="Este valor es requerido" ValidationGroup="NuevaLlantaGroup">(*)</asp:RequiredFieldValidator></td>
                            <td>
                              <asp:TextBox ID="txtMarcaLlanta" runat="server" CssClass="FormText" Width="110px"
                                TabIndex="400" Text='<%# Bind("marcaLlanta") %>'></asp:TextBox>&nbsp;</td>
                            <td style="width: 55px" class="BorderLeft">
                              &nbsp;Marca<asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server"
                                ControlToValidate="txtMarcaAro" ErrorMessage="Este valor es requerido" ToolTip="Este valor es requerido"
                                ValidationGroup="NuevaLlantaGroup">(*)</asp:RequiredFieldValidator></td>
                            <td style="width: 118px">
                              <asp:TextBox ID="txtModeloLlanta" runat="server" CssClass="FormText" TabIndex="420"
                                Text='<%# Bind("marcaAro") %>'></asp:TextBox></td>
                            <td colspan="4" rowspan="3" valign="top" class="BorderLeftRight">
                              &nbsp;<asp:TextBox ID="txtObservacion" runat="server" CssClass="FormText" Rows="3"
                                TextMode="MultiLine" Width="250px" Height="48px" TabIndex="445" Text='<%# Bind("observacion") %>'></asp:TextBox>&nbsp;</td>
                            <td colspan="1" rowspan="5" valign="top" style="padding-left: 5px">
                              <img alt="" class="FormText" src='<%# getImageTraccion() %>'  id="imgTraccion" /></td>
                          </tr>
                          <tr>
                            <td>
                              Modelo
                              <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtModeloLlanta"
                                ErrorMessage="Este valor es requerido" ToolTip="Este valor es requerido" ValidationGroup="NuevaLlantaGroup">(*)</asp:RequiredFieldValidator></td>
                            <td>
                              <asp:TextBox ID="txtMarcaAro" runat="server" CssClass="FormText" TabIndex="405" Text='<%# Bind("modeloLlanta") %>'></asp:TextBox></td>
                            <td class="BorderLeft">
                              &nbsp;Modelo<asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server"
                                ControlToValidate="txtModeloAro" ErrorMessage="Este valor es requerido" ToolTip="Este valor es requerido"
                                ValidationGroup="NuevaLlantaGroup">(*)</asp:RequiredFieldValidator></td>
                            <td>
                              <asp:TextBox ID="txtModeloAro" runat="server" CssClass="FormText" TabIndex="425"
                                Text='<%# Bind("modeloAro") %>'></asp:TextBox></td>
                          </tr>
                          <tr>
                            <td style="height: 18px">
                              Desgaste<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtdesgasteLlanta"
                                ErrorMessage="Este valor es requerido" ToolTip="Este valor es requerido" ValidationGroup="NuevaLlantaGroup">(*)</asp:RequiredFieldValidator></td>
                            <td style="height: 18px">
                              <asp:TextBox ID="txtdesgasteLlanta" runat="server" CssClass="FormText ENTERO" Width="50px"
                                TabIndex="410" Text='<%# Bind("desgaste") %>'></asp:TextBox>
                              %</td>
                            <td class="BorderLeft" style="height: 18px">
                              &nbsp;Medida<asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server"
                                ControlToValidate="txtMedidaAro" ErrorMessage="Este valor es requerido" ToolTip="Este valor es requerido"
                                ValidationGroup="NuevaLlantaGroup">(*)</asp:RequiredFieldValidator></td>
                            <td style="height: 18px">
                              <asp:TextBox ID="txtMedidaAro" runat="server" CssClass="FormText ENTERO" Width="50px" TabIndex="430"
                                Text='<%# Bind("medidaAro") %>'></asp:TextBox></td>
                          </tr>
                          <tr>
                            <td style="height: 18px">
                              Vaso/Copa<asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="cbxVasocopa"
                                ErrorMessage="Por favor elija un favor" Operator="NotEqual" ToolTip="Por favor elija un favor"
                                ValidationGroup="NuevaLlantaGroup" ValueToCompare="-1">(*)</asp:CompareValidator></td>
                            <td style="height: 18px">
                              <asp:DropDownList ID="cbxVasocopa" runat="server" CssClass="FormText" Width="114px"
                                TabIndex="415" AppendDataBoundItems="True">
                                <asp:ListItem Value="-1">[ - Elija - ]</asp:ListItem>
                                <asp:ListItem Value="N">NINGUNO</asp:ListItem>
                                <asp:ListItem Value="V">CON VASO</asp:ListItem>
                                <asp:ListItem Value="C">CON COPA</asp:ListItem>
                              </asp:DropDownList></td>
                            <td class="BorderLeft" style="height: 18px">
                              &nbsp;Estado<asp:CompareValidator ID="CompareValidator2" runat="server" ControlToValidate="cbxEstadoAro"
                                ErrorMessage="Por favor elija un favor" Operator="NotEqual" ToolTip="Por favor elija un favor"
                                ValidationGroup="NuevaLlantaGroup" ValueToCompare="-1">(*)</asp:CompareValidator></td>
                            <td style="height: 18px">
                              <asp:DropDownList ID="cbxEstadoAro" runat="server" CssClass="FormText" Width="114px"
                                TabIndex="435" AppendDataBoundItems="True">
                                <asp:ListItem Selected="True" Value="-1">[ - Elija - ]</asp:ListItem>
                                <asp:ListItem Value="B">BUENO</asp:ListItem>
                                <asp:ListItem Value="R">REGULAR</asp:ListItem>
                                <asp:ListItem Value="M">MALO</asp:ListItem>
                              </asp:DropDownList></td>
                            <td class="BorderLeft" style="height: 18px">
                              &nbsp;Tipo
                              <asp:CompareValidator ID="CompareValidator4" runat="server" ControlToValidate="cbxTLlanta"
                                ErrorMessage="Por favor elija un favor" Operator="NotEqual" ToolTip="Por favor elija un favor"
                                ValidationGroup="NuevaLlantaGroup" ValueToCompare="-1">(*)</asp:CompareValidator></td>
                            <td style="height: 18px">
                              <asp:DropDownList ID="cbxTLlanta" runat="server" CssClass="FormText" Width="90px"
                                TabIndex="450" AppendDataBoundItems="True">
                                <asp:ListItem Selected="True" Value="-1">[ - Elija - ]</asp:ListItem>
                                <asp:ListItem Value="P">PRINCIPAL</asp:ListItem>
                                <asp:ListItem Value="R">REPUESTO</asp:ListItem>
                              </asp:DropDownList></td>
                            <td style="height: 18px">
                              Cantidad<asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="txtCantidad"
                                ErrorMessage="Este valor es requerido" ToolTip="Este valor es requerido" ValidationGroup="NuevaLlantaGroup">(*)</asp:RequiredFieldValidator></td>
                            <td align="right" class="BorderRight" style="height: 18px">
                              <asp:TextBox ID="txtCantidad" runat="server" CssClass="FormText ENTERO" Width="50px" TabIndex="455">1</asp:TextBox>&nbsp;</td>
                          </tr>
                          <tr>
                            <td style="height: 22px">
                            </td>
                            <td style="height: 22px">
                            </td>
                            <td class="BorderLeft" style="height: 22px">
                              &nbsp;Material<asp:CompareValidator ID="CompareValidator3" runat="server" ControlToValidate="cbxMaterialAro"
                                ErrorMessage="Por favor elija un favor" Operator="NotEqual" ToolTip="Por favor elija un favor"
                                ValidationGroup="NuevaLlantaGroup" ValueToCompare="-1">(*)</asp:CompareValidator></td>
                            <td style="padding-top: 1px; height: 22px;">
                              <asp:DropDownList ID="cbxMaterialAro" runat="server" CssClass="FormText" Width="114px"
                                TabIndex="440" DataSourceID="odsMaterialAro" DataTextField="materialAro" DataValueField="materialAroId"
                                AppendDataBoundItems="True">
                                <asp:ListItem Selected="True" Value="-1">[ - Elija - ]</asp:ListItem>
                              </asp:DropDownList></td>
                            <td align="right" colspan="4" class="BorderLeftRight" style="height: 22px">
                              <asp:Button ID="btnAgregarLlanta" runat="server" CssClass="FormButton" Text="Agregar Llanta"
                                OnClientClick=" doNuevaLlantaInsert();return false;" ValidationGroup="NuevaLlantaGroup" />&nbsp;</td>
                          </tr>
                        </table>
                      </InsertItemTemplate>
                    </asp:FormView>
                    &nbsp;</div>
                </div>
                <div class="PanelEncabezado" style="margin-top: 10px">
                  <asp:Label ID="llantaListaLabel" runat="server" Style="cursor: default" Text="Lista de llantas"></asp:Label>
                </div>
                <div class="hr">
                </div>
                <div id="llantaListPanel">
                  <asp:GridView ID="llantaGridView" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                    BorderStyle="Solid" CssClass="GridLista" EmptyDataText="No se encontraron ocurrencias"
                    DataSourceID="odsLlanta" OnRowUpdating="llantaGridView_RowUpdating" DataKeyNames="vehiculoId,llantaId">
                    <Columns>
                      <asp:TemplateField HeaderText="Tipo">
                        <HeaderStyle Width="65px" />
                        <ItemTemplate>
                          <asp:Label ID="lblTipoLlanta" runat="server" Text='<%# muestraTipoLlanta((Eval("tllanta"))) %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                          <asp:DropDownList ID="cbxTLlanta" runat="server" CssClass="FormText" Width="90px"
                            TabIndex="450" AppendDataBoundItems="True" SelectedValue='<%# Bind("tllanta") %>'>
                            <asp:ListItem Selected="True" Value="P">PRINCIPAL</asp:ListItem>
                            <asp:ListItem Value="R">REPUESTO</asp:ListItem>
                          </asp:DropDownList>
                        </EditItemTemplate>
                      </asp:TemplateField>
                      <asp:TemplateField HeaderText="Caracter&#237;sticas">
                        <ItemTemplate>
                          <table border="0" cellpadding="0" cellspacing="0" class="DataTable">
                            <tr>
                              <td class="BorderBottom" style="height: 16px">
                                <img src="Images/IconTire16.gif" /></td>
                              <td class="BorderBottom">
                                <strong>Llanta</strong></td>
                              <td style="width: 35px" class="BorderBottom">
                                <strong>Marca</strong></td>
                              <td style="width: 110px" class="BorderBottom">
                                <asp:Label ID="Label1" runat="server" Text='<%# Eval("marcaLlanta") %>'></asp:Label></td>
                              <td class="BorderBottom">
                                <strong>Modelo</strong></td>
                              <td style="width: 110px" class="BorderBottom">
                                <asp:Label ID="Label2" runat="server" Text='<%# Eval("modeloLlanta") %>'></asp:Label></td>
                              <td class="BorderBottom">
                                <strong>Desgaste</strong></td>
                              <td style="width: 40px" class="BorderBottom">
                                <asp:Label ID="Label3" runat="server" Text='<%# Eval("desgaste") %>'></asp:Label></td>
                              <td style="width: 60px" class="BorderBottom">
                                <strong>Vaso/Copa</strong></td>
                              <td class="BorderBottom" colspan="3">
                                <asp:Label ID="Label4" runat="server" Text='<%# muestraVasoCopa(Eval("vasocopa")) %>'></asp:Label>
                                &nbsp;</td>
                            </tr>
                            <tr>
                              <td class="BorderBottom" style="height: 16px">
                                <img src="Images/IconWheel16.gif" /></td>
                              <td class="BorderBottom">
                                <strong>Aro</strong></td>
                              <td class="BorderBottom">
                                <strong>Marca</strong></td>
                              <td class="BorderBottom">
                                <asp:Label ID="Label5" runat="server" Text='<%# Eval("marcaAro") %>'></asp:Label></td>
                              <td class="BorderBottom">
                                <strong>Modelo</strong></td>
                              <td class="BorderBottom">
                                <asp:Label ID="Label6" runat="server" Text='<%# Eval("modeloAro") %>'></asp:Label></td>
                              <td class="BorderBottom">
                                <strong>Medida</strong></td>
                              <td class="BorderBottom">
                                <asp:Label ID="Label7" runat="server" Text='<%# Eval("medidaAro") %>'></asp:Label></td>
                              <td class="BorderBottom">
                                <strong>Estado</strong></td>
                              <td style="padding-top: 1px" class="BorderBottom">
                                <asp:Label ID="Label8" runat="server" Text='<%# muestraEstado(Eval("estadoAro")) %>'></asp:Label></td>
                              <td class="BorderBottom" style="padding-top: 1px">
                                <strong>Material</strong></td>
                              <td class="BorderBottom" style="padding-top: 1px">
                                <asp:Label ID="Label10" runat="server" Text='<%# Eval("materialAro") %>'></asp:Label></td>
                            </tr>
                            <tr>
                              <td colspan="3" style="padding-top: 2px" valign="top">
                                <strong>Observaciones</strong></td>
                              <td colspan="9" style="padding-top: 2px;">
                                <asp:Label ID="Label9" runat="server" Text='<%# Eval("observacion") %>'></asp:Label></td>
                            </tr>
                          </table>
                        </ItemTemplate>
                        <EditItemTemplate>
                          <table border="0" cellpadding="0" cellspacing="0" class="DataTable">
                            <tr>
                              <td class="BorderBottom" style="height: 16px">
                                <img src="Images/IconTire16.gif" /></td>
                              <td class="BorderBottom">
                                <strong>Llanta</strong></td>
                              <td style="width: 35px" class="BorderBottom">
                                <strong>Marca</strong></td>
                              <td style="width: 110px" class="BorderBottom">
                                <asp:TextBox ID="marcaLlantaTextBox" runat="server" CssClass="FormText" TabIndex="400"
                                  Width="80px" Text='<%# Bind("marcaLlanta") %>'></asp:TextBox></td>
                              <td class="BorderBottom" style="font-weight: bold">
                                Modelo</td>
                              <td style="width: 110px" class="BorderBottom">
                                <asp:TextBox ID="marcaAroTextBox" runat="server" CssClass="FormText" TabIndex="405"
                                  Width="80px" Text='<%# Bind("modeloLlanta") %>'></asp:TextBox></td>
                              <td class="BorderBottom" style="width: 59px">
                                <strong>Desgaste (%)&nbsp;</strong></td>
                              <td style="width: 40px" class="BorderBottom">
                                <asp:TextBox ID="desgasteLlantaTextBox" runat="server" CssClass="FormText" TabIndex="410"
                                  Width="50px" Text='<%# Bind("desgaste") %>'></asp:TextBox>
                              </td>
                              <td style="width: 60px; font-weight: bold;" class="BorderBottom">
                                Vaso/Copa</td>
                              <td class="BorderBottom" colspan="3">
                                <strong>
                                  <asp:DropDownList ID="vasocopaCombo" runat="server" CssClass="FormText" Width="88px"
                                    TabIndex="415" SelectedValue='<%# Bind("vasocopa") %>'>
                                    <asp:ListItem Value="N">NINGUNO</asp:ListItem>
                                    <asp:ListItem Value="V">CON VASO</asp:ListItem>
                                    <asp:ListItem Value="C">CON COPA</asp:ListItem>
                                  </asp:DropDownList></strong></td>
                            </tr>
                            <tr>
                              <td class="BorderBottom" style="height: 16px">
                                <img src="Images/IconWheel16.gif" /></td>
                              <td class="BorderBottom">
                                <strong>Aro</strong></td>
                              <td class="BorderBottom">
                                <strong>Marca</strong></td>
                              <td class="BorderBottom">
                                <asp:TextBox ID="modeloLlantaTextBox" runat="server" CssClass="FormText" TabIndex="420"
                                  Width="80px" Text='<%# Bind("marcaAro") %>'></asp:TextBox></td>
                              <td class="BorderBottom">
                                <strong>Modelo</strong></td>
                              <td class="BorderBottom">
                                <asp:TextBox ID="modeloAroTextBox" runat="server" CssClass="FormText" TabIndex="425"
                                  Width="80px" Text='<%# Bind("modeloAro") %>'></asp:TextBox></td>
                              <td class="BorderBottom" style="width: 59px">
                                <strong>Medida</strong></td>
                              <td class="BorderBottom">
                                <asp:TextBox ID="medidaAroTextBox" runat="server" CssClass="FormText" TabIndex="430"
                                  Width="50px" Text='<%# Bind("medidaAro") %>'></asp:TextBox></td>
                              <td class="BorderBottom">
                                <strong>Estado</strong></td>
                              <td style="padding-top: 1px" class="BorderBottom">
                                <asp:DropDownList ID="estadoAroCombo" runat="server" CssClass="FormText" Width="88px"
                                  TabIndex="435" SelectedValue='<%# Bind("estadoAro") %>'>
                                  <asp:ListItem Value="B">BUENO</asp:ListItem>
                                  <asp:ListItem Value="R">REGULAR</asp:ListItem>
                                  <asp:ListItem Value="M">MALO</asp:ListItem>
                                </asp:DropDownList></td>
                              <td class="BorderBottom" style="padding-top: 1px">
                                <strong>Material</strong></td>
                              <td class="BorderBottom" style="padding-top: 1px">
                                <asp:DropDownList ID="materialAroCombo" runat="server" CssClass="FormText" Width="80px"
                                  TabIndex="440" DataSourceID="odsMaterialAro" DataTextField="materialAro" DataValueField="materialAroId"
                                  SelectedValue='<%# Bind("materialAroId") %>'>
                                  <asp:ListItem>ALUMINIO</asp:ListItem>
                                </asp:DropDownList></td>
                            </tr>
                            <tr>
                              <td colspan="3" style="padding-top: 2px" valign="top">
                                <strong>Observaciones</strong></td>
                              <td colspan="9" style="padding-top: 2px;">
                                <asp:TextBox ID="observacionTextBox" runat="server" CssClass="FormText" Height="48px"
                                  Rows="3" TabIndex="445" TextMode="MultiLine" Width="400px" Text='<%# Bind("observacion") %>'></asp:TextBox></td>
                            </tr>
                          </table>
                        </EditItemTemplate>
                      </asp:TemplateField>
                      <asp:TemplateField HeaderText="Acci&#243;n">
                        <ItemStyle HorizontalAlign="Center" />
                        <HeaderStyle Width="50px" />
                        <ItemTemplate>
                          &nbsp;<asp:ImageButton ID="ImageButton1" runat="server" CommandName="Edit" ImageUrl="~/Images/IconEdit.gif" />
                          <asp:ImageButton ID="ImageButton3" runat="server" CommandName="Delete" ImageUrl="~/Images/IconDelete.gif"
                            OnClientClick="return confirm('Desea Eliminar el registro elegido???');" />
                        </ItemTemplate>
                        <EditItemTemplate>
                          <asp:ImageButton ID="ImageButton1" runat="server" CausesValidation="True" CommandName="Update"
                            ImageUrl="~/Images/btnsListas/icon_ok.jpg" Text="Update" />&nbsp;<asp:ImageButton
                              ID="ImageButton2" runat="server" CausesValidation="False" CommandName="Cancel"
                              ImageUrl="~/Images/btnsListas/icon_exit.jpg" Text="Cancel" />
                        </EditItemTemplate>
                      </asp:TemplateField>
                      <asp:BoundField DataField="vehiculoId" HeaderText="vehiculoId" ReadOnly="True" SortExpression="vehiculoId">
                        <ItemStyle CssClass="invisible" />
                        <HeaderStyle CssClass="invisible" />
                      </asp:BoundField>
                    </Columns>
                    <RowStyle CssClass="ItemStyle" />
                    <PagerStyle CssClass="PagerStyle" />
                    <HeaderStyle CssClass="HeaderStyle" />
                  </asp:GridView>
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
                      onmouseover="MakeClear(this,1);" OnClientClick="return false;" />
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
            <asp:ObjectDataSource ID="odsMaterialAro" runat="server" OldValuesParameterFormatString="original_{0}"
              SelectMethod="GetData" TypeName="dsComboTableAdapters.MaterialAroComboTableAdapter">
              <SelectParameters>
                <asp:Parameter Name="estado" Type="String" />
              </SelectParameters>
            </asp:ObjectDataSource>
            <asp:ObjectDataSource ID="odsLlanta" runat="server" DeleteMethod="Delete" InsertMethod="Insert"
              SelectMethod="GetData" TypeName="dsVehiculoTableAdapters.LlantaVehiculoTableAdapter"
              UpdateMethod="Update" OldValuesParameterFormatString="original_{0}">
              <DeleteParameters>
                <asp:Parameter Name="llantaId" Type="Decimal" />
                <asp:Parameter Name="vehiculoId" Type="Decimal" />
              </DeleteParameters>
              <UpdateParameters>
                <asp:Parameter Name="vehiculoId" Type="Decimal" />
                <asp:Parameter Name="llantaId" Type="Decimal" />
                <asp:Parameter Name="tllanta" Type="String" />
                <asp:Parameter Name="marcaLlanta" Type="String" />
                <asp:Parameter Name="modeloLlanta" Type="String" />
                <asp:Parameter Name="desgaste" Type="Decimal" />
                <asp:Parameter Name="vasocopa" Type="String" />
                <asp:Parameter Name="marcaAro" Type="String" />
                <asp:Parameter Name="modeloAro" Type="String" />
                <asp:Parameter Name="medidaAro" Type="Decimal" />
                <asp:Parameter Name="estadoAro" Type="String" />
                <asp:Parameter Name="materialAroId" Type="Int32" />
                <asp:Parameter Name="observacion" Type="String" />
                <asp:Parameter Name="uupdate" Type="String" />
                <asp:Parameter Name="pc" Type="String" />
              </UpdateParameters>
              <SelectParameters>
                <asp:QueryStringParameter Name="vehiculoId" QueryStringField="VehiculoId" Type="Decimal" />
              </SelectParameters>
              <InsertParameters>
                <asp:QueryStringParameter Name="vehiculoId" QueryStringField="VehiculoId" Type="Decimal" />
                <asp:Parameter Name="tllanta" Type="String" />
                <asp:Parameter Name="marcaLlanta" Type="String" />
                <asp:Parameter Name="modeloLlanta" Type="String" />
                <asp:Parameter Name="desgaste" Type="Decimal" />
                <asp:Parameter Name="vasocopa" Type="String" />
                <asp:Parameter Name="marcaAro" Type="String" />
                <asp:Parameter Name="modeloAro" Type="String" />
                <asp:Parameter Name="medidaAro" Type="Decimal" />
                <asp:Parameter Name="estadoAro" Type="String" />
                <asp:Parameter Name="materialAroId" Type="Int32" />
                <asp:Parameter Name="observacion" Type="String" />
                <asp:Parameter Name="ucrea" Type="String" />
                <asp:Parameter Name="pc" Type="String" />
              </InsertParameters>
            </asp:ObjectDataSource>
          </td>
        </tr>
        <tr>
          <td>
          </td>
        </tr>
      </table>
    </div>
    <br />
  </form>
</body>
</html>
