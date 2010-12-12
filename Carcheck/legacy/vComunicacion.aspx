<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vComunicacion.aspx.cs" Inherits="vComunicacion" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
	<title>CarCheck | Comunicaciones</title>
	<link href="Css/layout.css" rel="stylesheet" type="text/css" />
	<link href="Css/layoutTabs.css" rel="stylesheet" type="text/css" />
	<link href="Scripts/jTabs/jTabs.css" rel="stylesheet" type="text/css" />

	<script type="text/javascript" src="Scripts/functions.js"></script>

	<script type="text/javascript" src="Scripts/lib/x_common.js"></script>

	<script type="text/javascript" src="Scripts/lib/x.js"></script>

	<script type="text/javascript" src="Scripts/lib/xTab.js"></script>

	<script type="text/javascript">
    var estadoComunicacion = '';
    
	  function GuardarComunicacion()
	  {
	    if(Page_ClientValidate()){
	      //var estadoIdCombo = $("estadoIdCombo");
	    
	      if(estadoComunicacion == "EXITOSA"){
	        alert("Se procede a guardar la comunicacion relacionada a los vehiculos seleccionados.\n\nSi se agendaron todos los vehiculos se cerrara la ventana");
	        // Proceso de grabado mediante CallBack
	        // Bloquedo de campos de la comunicacion
	        $("fcomunicacionTextBox").disabled= true;  
	        $("contactoTextBox").disabled     = true;  
	        $("tActividadIdCombo").disabled   = true;  
	        $("estadoComunicacionRadioButton_0").disabled       = true;  
	        $("estadoComunicacionRadioButton_1").disabled       = true;  
	        // Blanqueado de los campos de la inspección
	        $("finspeccionTextBox").value       = "";  
	        $("horaInicioTextBox").value        = "";  
	        $("horaFinTextBox").value           = "";  
	        $("contactoInspeccionTextBox").value= "";  
	        $("direccionTextBox").value         = "";  
	        $("ubigeoIdTextBox").value          = "";  
	        $("inspectorIdCombo").value         = "";
	        // Blanqueado de vehiculos seleccionados
	        var vehiculoArray = $("checkTextBox").value.split(";");
	        for(var i = 0; i < vehiculoArray.length; i++){
	          if(vehiculoArray[i] != ""){
	            $(vehiculoArray[i] + "Row").style.display = "none";
	          }
	        }
	        $("checkTextBox").value = "";
	        // ------------------------------------
	        
	      }else{
	        alert("Se guarda la comunicacion no exitosa para todos los registros de vehiculos y se cerrará la ventana de comunicación");
	      }
	    }
	  }
	
	  function EstadoChange(estadoIdCombo)
	  {
	    var displayInspeccion = "none";
	    var validatorEnabled = false;
	    estadoComunicacion = '';
	    
	    
	    $('observacionDiv').style.display = 'block';
	    
	    if(estadoIdCombo == "1"){
	      displayInspeccion = "block";
	      validatorEnabled = true;
	      estadoComunicacion = 'EXITOSA';	      
	      $('observacionDiv').style.display = 'none';  
	    }
	      
	    //$("separadorColumn").style.display = 'block';
	    $("inspeccionExitosaDiv").style.display = displayInspeccion;
	    
	    ValidatorEnable(observacionRFV, !validatorEnabled);
	    
	    ValidatorEnable(finspeccionRFV, validatorEnabled);
	    ValidatorEnable(horaInicioRFV, validatorEnabled);
	    ValidatorEnable(horaFinRFV, validatorEnabled);
	    ValidatorEnable(contactoInspeccionRFV, validatorEnabled);
	    ValidatorEnable(direccionRFV, validatorEnabled);
	    ValidatorEnable(ubigeoIdRFV, validatorEnabled);
	    ValidatorEnable(checkRFV, validatorEnabled);
	  }
	  
	  function VehiculoCheckChanged(vehiculoCheckBox)
	  {
	    var checkTextBox  = $("checkTextBox");
	    if(vehiculoCheckBox.checked)
	      checkTextBox.value = checkTextBox.value + vehiculoCheckBox.id + ";";
	    else
	      checkTextBox.value = Trim(checkTextBox.value, vehiculoCheckBox.id + ";");
	  }
	  
	  function Trim(originalString, trimString)
	  {
	    var indexIni = originalString.indexOf(trimString);
	    var indexFin = indexIni + trimString.length;
	    return originalString.substring(0, indexIni) + originalString.substring(indexFin, originalString.length);
	  }
	
		window.onload = function () {
			var t = new xTab('theTabPanel','itemCenterTab');
		}
		
	</script>

</head>
<body>
	<form id="form1" runat="server">
		<div class="DataTop">
			<div class="DataTopLeft">
			</div>
			<div class="DataTopRight">
			</div>
		</div>
		<div class="DataContent" id="registroDataContent">
			<div class="DataContentRight" id="registroDataContentRight">
				<div class="PanelEncabezado">
					<asp:Label ID="comuniacionLabel" runat="server" Style="cursor: default" Text="Comunicación"></asp:Label>
				</div>
				<div class="hr">
				</div>
				<table border="0" cellpadding="0" cellspacing="0" width="100%">
					<tr>
						<td style="width: 265px" valign="top" class="DataTable">
							<table border="0" cellpadding="0" cellspacing="0">
								<tr>
									<td style="width: 100px">
										Fecha / Hora<asp:RequiredFieldValidator ID="fcomunicacionRFV" runat="server" ControlToValidate="fcomunicacionTextBox"
											ErrorMessage="Ingrese la fecha / hora de la comunicación" Font-Bold="True">(*)</asp:RequiredFieldValidator></td>
									<td>
										<asp:TextBox ID="fcomunicacionTextBox" runat="server" CssClass="FormText" Width="150px"></asp:TextBox></td>
								</tr>
								<tr>
									<td style="width: 86px">
										Contacto<asp:RequiredFieldValidator ID="contactoRFV" runat="server" ControlToValidate="contactoTextBox"
											ErrorMessage="Ingrese el nombre del contacto de la comunicación" Font-Bold="True">(*)</asp:RequiredFieldValidator></td>
									<td>
										<asp:TextBox ID="contactoTextBox" runat="server" CssClass="FormText" Width="150px"></asp:TextBox></td>
								</tr>
								<tr>
									<td style="width: 86px">
										Tipo Actividad<asp:RequiredFieldValidator ID="tActividadIdRFV" runat="server" ControlToValidate="tActividadIdCombo"
											ErrorMessage="Especifique el tipo de comunicación" Font-Bold="True" CssClass="DataValidator">(*)</asp:RequiredFieldValidator></td>
									<td style="padding-top: 1px">
										<asp:DropDownList ID="tActividadIdCombo" runat="server" CssClass="FormText" Width="153px">
											<asp:ListItem></asp:ListItem>
											<asp:ListItem>LLAMADA</asp:ListItem>
											<asp:ListItem>E-MAIL</asp:ListItem>
											<asp:ListItem>PERSONAL</asp:ListItem>
											<asp:ListItem>FAX</asp:ListItem>
										</asp:DropDownList></td>
								</tr>
								<tr>
									<td style="width: 86px">
										Resultado</td>
									<td style="padding-top: 2px">
										<asp:RadioButtonList ID="estadoComunicacionRadioButton" runat="server" RepeatDirection="Horizontal">
											<asp:ListItem Selected="True" Value="0" onclick="EstadoChange(this.value);">No Exitoso</asp:ListItem>
											<asp:ListItem Value="1" onclick="EstadoChange(this.value);">Exitoso</asp:ListItem>
										</asp:RadioButtonList></td>
								</tr>
								<tr>
									<td style="padding-top: 2px;" colspan="2">
										<input id="Button1" class="FormButton" type="button" value="Guardar comunicación"
											onclick="GuardarComunicacion();" style="float: left" />
										<input id="Button2" class="FormButton" style="float: right; width: 60px" type="button"
											value="Salir" onclick="alert('Se cierra la ventana sin guardar datos.');" /></td>
								</tr>
							</table>
							<asp:RequiredFieldValidator ID="checkRFV" runat="server" ControlToValidate="checkTextBox"
								Enabled="False" ErrorMessage="Debe seleccionar al menos un vehículo para la inspección"
								Font-Bold="True" Display="None">(*)</asp:RequiredFieldValidator><asp:TextBox ID="checkTextBox"
									runat="server" CssClass="FormText" Width="40px" Style="display: none"></asp:TextBox></td>
						<td valign="top" id="separadorColumn" runat="server" width="10" style="display: block">
						</td>
						<td valign="top" class="DataTable">
							<div runat="server" id="inspeccionExitosaDiv" style="display: block">
								<table border="0" cellpadding="0" cellspacing="0">
									<tr>
										<td style="width: 115px">
											Fecha Inspección<asp:RequiredFieldValidator ID="finspeccionRFV" runat="server" ControlToValidate="finspeccionTextBox"
												CssClass="DataValidator" Display="Dynamic" ErrorMessage="Ingrese la fecha de la inspección"
												Font-Bold="True" Enabled="false">(*)</asp:RequiredFieldValidator><asp:RequiredFieldValidator
													ID="horaInicioRFV" runat="server" ControlToValidate="horaInicioTextBox" CssClass="DataValidator"
													Display="Dynamic" ErrorMessage="Ingrese la hora de inicio de inspección" Font-Bold="True"
													Enabled="false">(*)</asp:RequiredFieldValidator><asp:RequiredFieldValidator ID="horaFinRFV"
														runat="server" ControlToValidate="horaFinTextBox" CssClass="DataValidator" Display="Dynamic"
														ErrorMessage="Ingrese la hora de fin de inspección" Font-Bold="True" Enabled="false">(*)</asp:RequiredFieldValidator>
										</td>
										<td>
											<asp:TextBox ID="finspeccionTextBox" runat="server" CssClass="FormText" Width="80px"></asp:TextBox>
											De
											<asp:TextBox ID="horaInicioTextBox" runat="server" CssClass="FormText" Width="50px"></asp:TextBox>
											a
											<asp:TextBox ID="horaFinTextBox" runat="server" CssClass="FormText" Width="50px"></asp:TextBox>
											hrs.</td>
									</tr>
									<tr>
										<td>
											Contacto<asp:RequiredFieldValidator ID="contactoInspeccionRFV" runat="server" ControlToValidate="contactoInspeccionTextBox"
												ErrorMessage="Ingrese el contacto para la inspeccón" Font-Bold="True" Enabled="False">(*)</asp:RequiredFieldValidator></td>
										<td>
											<asp:TextBox ID="contactoInspeccionTextBox" runat="server" CssClass="FormText" Width="135px"></asp:TextBox>&nbsp;
											Telf.
											<asp:TextBox ID="telefonoTextBox" runat="server" CssClass="FormText" Width="74px"></asp:TextBox>
										</td>
									</tr>
									<tr>
										<td>
											Dirección<asp:RequiredFieldValidator ID="direccionRFV" runat="server" ControlToValidate="direccionTextBox"
												ErrorMessage="Ingrese la dirección de la inspección" Font-Bold="True" Enabled="False">(*)</asp:RequiredFieldValidator></td>
										<td>
											<asp:TextBox ID="direccionTextBox" runat="server" CssClass="FormText" Width="250px"></asp:TextBox></td>
									</tr>
									<tr>
										<td>
											Ubigeo<asp:RequiredFieldValidator ID="ubigeoIdRFV" runat="server" ControlToValidate="ubigeoIdTextBox"
												ErrorMessage="Ingrese el ubigeo de la inspección" Font-Bold="True" Enabled="False">(*)</asp:RequiredFieldValidator></td>
										<td>
											<asp:TextBox ID="ubigeoIdTextBox" runat="server" CssClass="FormText" Width="250px"></asp:TextBox></td>
									</tr>
									<tr>
										<td style="height: 19px">
											Inspector</td>
										<td style="padding-top: 1px; height: 19px;">
											<asp:DropDownList ID="inspectorIdCombo" runat="server" CssClass="FormText" Width="254px">
												<asp:ListItem></asp:ListItem>
												<asp:ListItem>EDER QUISPE</asp:ListItem>
												<asp:ListItem>EDER VELASCO</asp:ListItem>
												<asp:ListItem>JUAN CARLOS</asp:ListItem>
												<asp:ListItem>LUIS MOLINA</asp:ListItem>
												<asp:ListItem>MARIO VILLEGAS</asp:ListItem>
											</asp:DropDownList></td>
									</tr>
								</table>
							</div>
							<div id="observacionDiv" runat="server">
								<table border="0" cellpadding="0" cellspacing="0">
									<tr>
										<td style="width: 115px; padding-top: 2px;" valign="top">
											Observación<asp:RequiredFieldValidator ID="observacionRFV" runat="server" ControlToValidate="observacionTextBox" ErrorMessage="Ingrese una observación" Font-Bold="True">(*)</asp:RequiredFieldValidator></td>
										<td style="padding-top: 1px;">
											<asp:TextBox ID="observacionTextBox" runat="server" CssClass="FormText" Rows="4"
												TextMode="MultiLine" Width="250px"></asp:TextBox></td>
									</tr>
								</table>
							</div>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div class="DataBottom">
			<div class="DataBottomLeft">
			</div>
			<div class="DataBottomRight">
			</div>
		</div>
		<div id="theTabPanel">
			<div id="Div1" runat="server" class="mainTab xTabHeader">
				<div runat="server" id="tab1" enableviewstate="true" class="itemTab">
					<div class="itemLeftBackTab">
					</div>
					<a runat="server" id="lnkTab1" onclick="return false;" class="itemCenterBackTab tabTrigger"
						href="##">Inspecciones</a>
					<div class="itemRightBackTab">
					</div>
				</div>
				<div runat="server" id="tab2" enableviewstate="true" class="itemTab">
					<div class="itemLeftBackTab">
					</div>
					<a runat="server" id="lnkTab2" onclick="return false;" class="itemCenterBackTab tabTrigger"
						href="##">Comunicaciones</a>
					<div class="itemRightBackTab">
					</div>
				</div>
			</div>
			<div class="DataContent">
				<div class="DataContentRight" style="padding-top: 5px; height: 205px">
					<div class="tabContainer">
						<div id="inspeccionPanel" style="height: 200px; margin-top: 0px" class="PanelInset">
							<table id="inspeccionGridView" runat="server" border="1" cellpadding="0" cellspacing="0"
								class="DataTable" style="border-top-style: solid; border-right-style: solid; border-left-style: solid;
								border-collapse: collapse; border-bottom-style: solid;">
								<tr class="HeaderStyle">
									<td align="center" scope="col" width="25" style="text-align: center">
									</td>
									<td scope="col" width="90">
										Placa</td>
									<td scope="col" width="154">
										Marca</td>
									<td scope="col" width="250">
										Modelo</td>
									<td scope="col" width="100">
										Estado</td>
								</tr>
								<tr id="CheckBox1Row" class="ItemStyle">
									<td style="text-align: center">
										<asp:CheckBox ID="CheckBox1" runat="server" CssClass="FormCheck" onClick="VehiculoCheckChanged(this);" /></td>
									<td>
										AQM-1234</td>
									<td>
										TOYOTA</td>
									<td>
										CORONA XE</td>
									<td>
										PENDIENTE</td>
								</tr>
								<tr id="CheckBox2Row" class="ItemStyle">
									<td style="text-align: center">
										<asp:CheckBox ID="CheckBox2" runat="server" CssClass="FormCheck" onClick="VehiculoCheckChanged(this);" /></td>
									<td>
										AQM-1235</td>
									<td>
										TOYOTA</td>
									<td>
										CORONA XE</td>
									<td>
										PENDIENTE</td>
								</tr>
								<tr id="CheckBox3Row" class="ItemStyle">
									<td style="text-align: center">
										<asp:CheckBox ID="CheckBox3" runat="server" CssClass="FormCheck" onClick="VehiculoCheckChanged(this);" /></td>
									<td>
										AQM-1236</td>
									<td>
										TOYOTA</td>
									<td>
										CORONA XE</td>
									<td>
										PENDIENTE</td>
								</tr>
								<tr id="CheckBox4Row" class="ItemStyle">
									<td style="text-align: center">
										<asp:CheckBox ID="CheckBox4" runat="server" CssClass="FormCheck" onClick="VehiculoCheckChanged(this);" /></td>
									<td>
										AQM-1237</td>
									<td>
										TOYOTA</td>
									<td>
										CORONA XE</td>
									<td>
										FRUSTRADA</td>
								</tr>
								<tr id="CheckBox5Row" class="ItemStyle">
									<td style="text-align: center">
										<asp:CheckBox ID="CheckBox5" runat="server" CssClass="FormCheck" onClick="VehiculoCheckChanged(this);" /></td>
									<td>
										AQM-1238</td>
									<td>
										TOYOTA</td>
									<td>
										CORONA XE</td>
									<td>
										FRUSTRADA</td>
								</tr>
								<tr class="ItemStyle">
									<td style="text-align: center">
									</td>
									<td>
									</td>
									<td>
									</td>
									<td>
									</td>
									<td>
									</td>
								</tr>
								<tr class="ItemStyle">
									<td style="text-align: center">
									</td>
									<td>
									</td>
									<td>
									</td>
									<td>
									</td>
									<td>
									</td>
								</tr>
								<tr class="ItemStyle">
									<td style="text-align: center">
									</td>
									<td>
									</td>
									<td>
									</td>
									<td>
									</td>
									<td>
									</td>
								</tr>
								<tr class="ItemStyle">
									<td style="text-align: center">
									</td>
									<td>
									</td>
									<td>
									</td>
									<td>
									</td>
									<td>
									</td>
								</tr>
								<tr class="ItemStyle">
									<td style="text-align: center">
									</td>
									<td>
									</td>
									<td>
									</td>
									<td>
									</td>
									<td>
									</td>
								</tr>
								<tr class="ItemStyle">
									<td style="text-align: center">
									</td>
									<td>
									</td>
									<td>
									</td>
									<td>
									</td>
									<td>
									</td>
								</tr>
								<tr class="ItemStyle">
									<td style="text-align: center">
									</td>
									<td>
									</td>
									<td>
									</td>
									<td>
									</td>
									<td>
									</td>
								</tr>
								<tr class="ItemStyle">
									<td style="text-align: center">
									</td>
									<td>
									</td>
									<td>
									</td>
									<td>
									</td>
									<td>
									</td>
								</tr>
							</table>
						</div>
					</div>
					<div class="tabContainer">
						<div id="comunicacionPanel" style="height: 200px;" class="PanelInset">
							<table id="Table1" runat="server" border="1" cellpadding="0" cellspacing="0" class="DataTable"
								style="border-top-style: solid; border-right-style: solid; border-left-style: solid;
								border-collapse: collapse; border-bottom-style: solid;">
								<tr class="HeaderStyle">
									<td scope="col" align="center" width="110">
										Fecha / Hora</td>
									<td scope="col" width="400">
										Contacto</td>
									<td scope="col" width="100">
										Resultado</td>
								</tr>
								<tr class="ItemStyle">
									<td align="center" style="width: 129px">
										13/10/2006 16:40</td>
									<td>
										ALBERTO ROJAS</td>
									<td>
										EXITOSA</td>
								</tr>
								<tr class="ItemStyle">
									<td align="center" style="width: 129px">
										13/10/2006 10:00</td>
									<td>
										ALBERTO ROJAS</td>
									<td>
										EN PROCESO</td>
								</tr>
								<tr class="ItemStyle">
									<td align="center" style="width: 129px">
										12/10/2006 17:00</td>
									<td>
										ALBERTO ROJAS</td>
									<td>
										EN PROCESO</td>
								</tr>
								<tr class="ItemStyle">
									<td align="center" style="width: 129px">
										10/10/2006 13:10</td>
									<td>
										ALBERTO ROJAS</td>
									<td>
										EN PROCESO</td>
								</tr>
								<tr class="ItemStyle">
									<td align="center" style="width: 129px">
										07/10/2006 09:30</td>
									<td>
										ALBERTO ROJAS</td>
									<td>
										FRUSTRADA</td>
								</tr>
								<tr class="ItemStyle">
									<td align="center" style="width: 129px">
									</td>
									<td>
									</td>
									<td>
									</td>
								</tr>
								<tr class="ItemStyle">
									<td align="center" style="width: 129px">
									</td>
									<td>
									</td>
									<td>
									</td>
								</tr>
								<tr class="ItemStyle">
									<td align="center" style="width: 129px">
									</td>
									<td>
									</td>
									<td>
									</td>
								</tr>
								<tr class="ItemStyle">
									<td align="center" style="width: 129px">
									</td>
									<td>
									</td>
									<td>
									</td>
								</tr>
								<tr class="ItemStyle">
									<td align="center" style="width: 129px">
									</td>
									<td>
									</td>
									<td>
									</td>
								</tr>
								<tr class="ItemStyle">
									<td align="center" style="width: 129px">
									</td>
									<td>
									</td>
									<td>
									</td>
								</tr>
								<tr class="ItemStyle">
									<td align="center" style="width: 129px">
									</td>
									<td>
									</td>
									<td>
									</td>
								</tr>
								<tr class="ItemStyle">
									<td align="center" style="width: 129px">
									</td>
									<td>
									</td>
									<td>
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
			<asp:ValidationSummary ID="comunicacionVS" runat="server" HeaderText="Para guardar la comunicación tenga en cuenta lo siguiente"
				ShowMessageBox="True" ShowSummary="False" />
		</div>
	</form>
</body>
</html>
