<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vItinerario.aspx.cs" Inherits="vItinerario" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
	<title>CarCheck | Itinerarios</title>
	<!--SCRIPT LANGUAGE=VBSCRIPT>

Sub GO()

	'Create the ASPPrinter object
	Set Prn=CreateObject("ASPPrinterCOM.ASPPrinter")

	'Call the GetPrinters method
	Printers=Prn.GetPrinters(PrintersCount)

	P = PrintersCount & " printers were detected on your system:" & vbcrlf & vbcrlf
	
	For i=0 To Ubound(Printers)
		P=P & Printers(i) & vbcrlf
	Next

	Set Prn=Nothing
	
	'Show the names of detected printers
	MsgBox P,,"ASP Printer COM"

End Sub
</SCRIPT-->

	<script type="text/javascript">
	function Go()
	{
		var PrinterCount = 0;
		var Printer = new ActiveXObject("ASPPrinterCOM.ASPPrinter");
		var Printers = Printer.GetPrinters(PrinterCount);
		var PrinterMessage = PrinterCount + " Impresoras han sido detetadas en su sistema:\n\n";
		for(var i = 0; i < PrinterCount; i++)
		{
			PrinterMessage = PrinterMessage + Printers[i] + "\n";
		}
		
		//alert(PrinterMessage);
		alert(Printer.PrintQuality);
	}
	
	window.onload = function()
	{
	}
	</script>

</head>
<body>
	<!--object id="ASPPrinter" classid="CLSID:48CB850F-41FF-4EE6-B87D-FB9EC26D193F" codebase="ASPPrinter.CAB#version=2,1,0,0">
	</object-->
	<form id="form1" runat="server">
		<div>
			<table border="0" cellpadding="0" cellspacing="0" width="100%">
				<tr>
					<td>
						<asp:DropDownList ID="inspectorIdCombo" runat="server" Style="border: none White 0px"
							Font-Bold="True" Font-Names="Arial" Font-Size="16px" Width="250px">
							<asp:ListItem>TODOS</asp:ListItem>
							<asp:ListItem>Eder Quispe</asp:ListItem>
							<asp:ListItem>Eder Velasco</asp:ListItem>
							<asp:ListItem>Juan Carlos</asp:ListItem>
							<asp:ListItem>Luis Molina</asp:ListItem>
							<asp:ListItem>Mario Villegas</asp:ListItem>
						</asp:DropDownList></td>
				</tr>
				<tr>
					<td>
						&nbsp;</td>
				</tr>
				<tr>
					<td style="font-size: 12px; font-family: Arial">
						<table border="1" cellpadding="1" cellspacing="0" bordercolor="#999999">
							<tr>
								<td width="75" style="font-weight: bold">
									Nº Solicitud</td>
								<td width="200">
									01215000</td>
								<td style="font-weight: bold" width="75">
									Fecha / Hora</td>
								<td width="200">
									19/10/2006 13:00</td>
							</tr>
							<tr>
								<td style="font-weight: bold">
									Dirección</td>
								<td>
									Av. Aviación 4023</td>
								<td style="font-weight: bold">
									Ubigeo</td>
								<td>
									San Borja</td>
							</tr>
							<tr>
								<td style="font-weight: bold">
									Contacto</td>
								<td>
									Gilberto Machado</td>
								<td style="font-weight: bold">
									Teléfono</td>
								<td>
									4569723</td>
							</tr>
							<tr>
								<td style="font-weight: bold">
									Asegurado</td>
								<td colspan="3">
									Pedro Gonzales Reyes</td>
							</tr>
							<tr>
								<td style="font-weight: bold" valign="top">
									Vehículos</td>
								<td colspan="3">
									<table border="0" cellpadding="1" cellspacing="0">
										<tr>
											<td style="font-weight: bold" width="75">
												Placa</td>
											<td style="font-weight: bold" width="150">
												Marca</td>
											<td style="font-weight: bold" width="200">
												Modelo</td>
										</tr>
										<tr>
											<td width="75">
												AQ-0983</td>
											<td width="150">
												TOYOTA</td>
											<td width="200">
												COROLLA</td>
										</tr>
										<tr>
											<td>
												AQ-0922</td>
											<td>
												TOYOTA</td>
											<td>
												COROLLA</td>
										</tr>
										<tr>
											<td>
												AQ-1029</td>
											<td>
												TOYOTA</td>
											<td>
												COROLLA</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
						<br />
						<table border="1" cellpadding="1" cellspacing="0" bordercolor="#999999">
							<tr>
								<td width="75" style="font-weight: bold">
									Nº Solicitud</td>
								<td width="200">
									01215010</td>
								<td style="font-weight: bold" width="75">
									Fecha / Hora</td>
								<td width="200">
									19/10/2006 13:00</td>
							</tr>
							<tr>
								<td style="font-weight: bold">
									Dirección</td>
								<td>
									Av. Aviación 4023</td>
								<td style="font-weight: bold">
									Ubigeo</td>
								<td>
									San Borja</td>
							</tr>
							<tr>
								<td style="font-weight: bold">
									Contacto</td>
								<td>
									Alberto Gomez</td>
								<td style="font-weight: bold">
									Teléfono</td>
								<td>
									4569723</td>
							</tr>
							<tr>
								<td style="font-weight: bold">
									Asegurado</td>
								<td colspan="3">
									Alberto Gomez &nbsp;</td>
							</tr>
							<tr>
								<td style="font-weight: bold" valign="top">
									Vehículos</td>
								<td colspan="3">
									<table border="0" cellpadding="1" cellspacing="0">
										<tr>
											<td style="font-weight: bold" width="75">
												Placa</td>
											<td style="font-weight: bold" width="150">
												Marca</td>
											<td style="font-weight: bold" width="200">
												Modelo</td>
										</tr>
										<tr>
											<td width="75">
												AQM-1023</td>
											<td width="150">
												NISSAN</td>
											<td width="200">
												SENTRA</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<input id="Button1" type="button" value="button" onclick="Go();" /></div>
	</form>
</body>
</html>
