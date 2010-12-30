<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vViewPdf.aspx.cs" Inherits="vViewPdf" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>CarCheck / Visualización de PDF</title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<LINK href="css/layout.css" type="text/css" rel="stylesheet">
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<table cellpadding="0" cellspacing="0" border="0" width="100%" height="100%">
				<tr>
					<td height="6">
						<DIV class="DataTop">
							<DIV class="DataTopLeft"></DIV>
							<DIV class="DataTopRight"></DIV>
						</DIV>
                        <strong><span style="font-size: 14pt">INFORME DE INSPECCIÓn</span></strong></td>
				</tr>
				<tr>
					<td align="center">
						<div class="DataContent" style="HEIGHT:100%">
							<div class="DataContentRight" style="VERTICAL-ALIGN: middle; HEIGHT: 100%; TEXT-ALIGN: center">
                                El archivo no se encuentra disponible</div>
						</div>
					</td>
				</tr>
				<tr>
					<td height="6">
						<DIV class="DataBottom">
							<DIV class="DataBottomLeft"></DIV>
							<DIV class="DataBottomRight"></DIV>
						</DIV>
                        <asp:ObjectDataSource ID="odsInformeBasico" runat="server" OldValuesParameterFormatString="original_{0}"
                            SelectMethod="GetData" TypeName="dsReporteTableAdapters.TieneInformeBasicoTableAdapter">
                            <SelectParameters>
                                <asp:QueryStringParameter Name="ajusteId" QueryStringField="AjusteId"
                                    Type="Decimal" />
                            </SelectParameters>
                        </asp:ObjectDataSource>
                        &nbsp; &nbsp;
                    </td>
				</tr>
			</table>
		</form>
	</body>
</HTML>