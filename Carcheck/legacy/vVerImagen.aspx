<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vVerImagen.aspx.cs" Inherits="vVerImagen" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
	<title>Untitled Page</title>
	<link href="Css/layout.css" type="text/css" rel="stylesheet" />

	<script type="text/javascript" src="Scripts/lib/x.js"></script>

	<script type="text/javascript" src="Scripts/lib/x_common.js"></script>
	<script type="text/javascript" src="Scripts/lib/xCaseFormatter.js"></script>
	<script type="text/javascript" src="Scripts/lib/x_imageEffects.js"></script>

	<script type="text/javascript" src="Scripts/functions.js"></script>

	<script type="text/javascript">
	
   
	
		function ImagenCompleta(){
			if($('registroImage').style.height == 'auto')
			{
				$('registroImage').style.height = '400px';
				  var WinWidth = 800;
	        var WinHeight = 500;
				  var Xpos = (screen.width/2) - (WinWidth/2) + 6;
				  var Ypos = (screen.height/2) - (WinHeight/2) + 30;
				  window.moveTo(Xpos,Ypos);
				  if (document.all) {
					  top.window.resizeTo(WinWidth,WinHeight);
				  }
				  else if (document.layers||document.getElementById) {
					  if (top.window.outerHeight<WinHeight||top.window.outerWidth<WinWidth){
						  top.window.outerHeight = WinHeight;
						  top.window.outerWidth = WinWidth;
					  }
				  }
				  $('zoomImage').src = 'Images/IconFullImage32.gif';
			}
			else
			{
				$('registroImage').style.height = 'auto';
				window.moveTo(0,0);
				if (document.all) {
					top.window.resizeTo(screen.availWidth,screen.availHeight);
				}
				else if (document.layers||document.getElementById) {
					if (top.window.outerHeight<screen.availHeight||top.window.outerWidth<screen.availWidth){
						top.window.outerHeight = screen.availHeight;
						top.window.outerWidth = screen.availWidth;
					}
				}
				$('zoomImage').src = 'Images/IconSmallImage32.gif';
			}
		}
  
    window.onload = function(){
      //MaximizeWindow();
      if (<%= refreshParent %>) window.opener.doRefresh();
    }    


	</script>

</head>
<body>
	<form id="form1" runat="server">
		<table id="mainTable" border="0" cellpadding="0" cellspacing="0" style="width: 100%;
			height: 100%">
			<tr>
				<td height="7">
					<div class="DataTop">
						<div class="DataTopLeft">
						</div>
						<div class="DataTopRight">
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="DataContent" id="registroDataContent" style="height: 100%">
						<div class="DataContentRight" id="registroDataContentRight" style="height: 100%">
							<table id="registroTable" border="0" cellpadding="0" cellspacing="2" style="width: 100%">
								<tr>
									<td align="center" rowspan="2">
										<div style="border-color: #FFE0C0; border-width: 1px; border-style: Inset; width: auto;">
											<asp:Image ID="registroImage" Style="margin: 0px" runat="server" Height="400" ImageUrl="~/Images/xVehiculo001.jpg">
											</asp:Image>
										</div>
									</td>
									<td style="width: 200px; padding: 1px; height: 365px;" valign="top">
                    <asp:FormView ID="frmImagen" runat="server" DataKeyNames="vehiculoId,imagenId" DataSourceID="odsImagen" DefaultMode="Edit" OnItemUpdating="frmImagen_ItemUpdating">
                      <EditItemTemplate>
										<div class="DataTable">
											<table border="0" cellpadding="0" cellspacing="0" style="width: 100%">
												<tr>
													<td>
														Correspondiente a</td>
												</tr>
												<tr>
													<td>
														<asp:DropDownList ID="DropDownList1" runat="server" CssClass="FormText" Width="197px" DataSourceID="odsImagenCorrespondenciaCombo" DataTextField="imagenCorrespondencia" DataValueField="imagenCorrespondenciaId" SelectedValue='<%# Bind("imagenCorrespondenciaId") %>'>
															<asp:ListItem></asp:ListItem>
															<asp:ListItem>Exterior</asp:ListItem>
															<asp:ListItem>Interior</asp:ListItem>
															<asp:ListItem>Impronta</asp:ListItem>
															<asp:ListItem>Da&#241;os</asp:ListItem>
															<asp:ListItem>Documentos</asp:ListItem>
															<asp:ListItem>otros</asp:ListItem>
														</asp:DropDownList></td>
												</tr>
												<tr>
													<td style="height: 20px" valign="bottom">
														Título de la imagen</td>
												</tr>
												<tr>
													<td>
														<asp:TextBox ID="TextBox1" runat="server" CssClass="FormText" Width="193px" Text='<%# Bind("titulo") %>'></asp:TextBox></td>
												</tr>
												<tr>
													<td style="height: 20px" valign="bottom">
														Observación</td>
												</tr>
												<tr>
													<td>
														<asp:TextBox ID="TextBox2" runat="server" CssClass="FormText" Rows="15" TextMode="MultiLine"
															Width="193px" Text='<%# Bind("observacion") %>'></asp:TextBox></td>
												</tr>
												<tr>
													<td>
													</td>
												</tr>
												<tr>
													<td>
													</td>
												</tr>
											</table>
										</div>
                        <asp:ObjectDataSource ID="odsImagenCorrespondenciaCombo" runat="server" OldValuesParameterFormatString="original_{0}"
                          SelectMethod="GetData" TypeName="dsImagesTableAdapters.ImagenCorrespondenciaLoadDropDownTableAdapter">
                          <SelectParameters>
                            <asp:Parameter DefaultValue="A" Name="estado" Type="String" />
                          </SelectParameters>
                        </asp:ObjectDataSource>
                        <br />
                      </EditItemTemplate>                      
                    </asp:FormView>
                    <asp:ObjectDataSource ID="odsImagen" runat="server" DeleteMethod="Delete" InsertMethod="Insert" SelectMethod="GetDataBy"
                      TypeName="dsImagesTableAdapters.ImagenTableAdapter" UpdateMethod="Update" OnSelected="odsImagen_Selected">
                      <DeleteParameters>
                        <asp:QueryStringParameter Name="imagenId" QueryStringField="ImagenId" Type="Int32" />
                        <asp:QueryStringParameter Name="vehiculoId" QueryStringField="VehiculoId" Type="Decimal" />
                      </DeleteParameters>
                      <UpdateParameters>
                        <asp:Parameter Name="vehiculoId" Type="Decimal" />
                        <asp:Parameter Name="imagenId" Type="Int32" />
                        <asp:Parameter Name="imagenCorrespondenciaId" Type="String" />
                        <asp:Parameter Name="titulo" Type="String" />
                        <asp:Parameter Name="observacion" Type="String" />
                        <asp:Parameter Name="uupdate" Type="String" />
                        <asp:Parameter Name="pc" Type="String" />
                        <asp:Parameter Name="incluirEnInforme" Type="Boolean" />
                      </UpdateParameters>
                      <SelectParameters>
                        <asp:QueryStringParameter Name="imagenId" QueryStringField="ImagenId" Type="Int32" />
                        <asp:QueryStringParameter Name="vehiculoId" QueryStringField="VehiculoId" Type="Decimal" />
                      </SelectParameters>
                      <InsertParameters>
                        <asp:Parameter Name="vehiculoId" Type="Decimal" />
                        <asp:Parameter Direction="InputOutput" Name="imagenId" Type="Object" />
                        <asp:Parameter Name="imagenCorrespondenciaId" Type="String" />
                        <asp:Parameter Name="titulo" Type="String" />
                        <asp:Parameter Name="observacion" Type="String" />
                        <asp:Parameter Name="imagen" Type="Object" />
                        <asp:Parameter Name="ucrea" Type="String" />
                        <asp:Parameter Name="pc" Type="String" />
                        <asp:Parameter Name="thumbnail" Type="Object" />
                        <asp:Parameter Name="incluirEnInforme" Type="Boolean" />
                      </InsertParameters>
                    </asp:ObjectDataSource>
										
										
									</td>
								</tr>
								<tr>
									<td align="right" valign="bottom">
                    &nbsp;<asp:ImageButton ID="imgBtnDelete" runat="server" CssClass="MakeClear" ImageUrl="Images/IconDelete32Dark.gif"
                      OnClick="imgBtnDelete_Click" OnClientClick="return confirm('Desea eliminar la imagen');" />
                    &nbsp; &nbsp;<img class="MakeClear" id="zoomImage" src="Images/IconFullImage32.gif" title="Guardar registro" onclick="ImagenCompleta();"
											  style="cursor: pointer" />
                    &nbsp;
                    <asp:ImageButton ID="imgBtnSave" runat="server" CssClass="MakeClear" ImageUrl="Images/IconSave32Dark.gif"
                      OnClick="imgBtnSave_Click" />&nbsp; &nbsp;<img class="MakeClear" src="Images/IconExit32Dark.gif" title="Salir" 
											 style="cursor: pointer" onclick="window.close();" id="IMG1" /></td>
								</tr>
							</table>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td height="7">
					<div class="DataBottom">
						<div class="DataBottomLeft">
						</div>
						<div class="DataBottomRight">
						</div>
					</div>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>
