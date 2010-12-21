<%@ Page Language="C#" AutoEventWireup="true" CodeFile="generarInforme.aspx.cs" Inherits="generarInforme" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <title>Untitled Page</title>

  <script type="text/javascript" src="Scripts/lib/x.js"></script>

  <script type="text/javascript" src="Scripts/lib/x_common.js"></script>

  <script type="text/javascript">
    
    function doPreview() {
       ShowReport('vViewPdf.aspx?VehiculoId=<%= Request.QueryString["VehiculoId"] %>&TI=FILE');
    }
  </script>

</head>
<body>
  <form id="form1" runat="server">
    <table id="myTable" style="width: 395px; background-color: lightgoldenrodyellow;"
      border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td style="width: 56px; height: 38px;" align="center" valign="middle">
          <asp:ImageButton ID="ImageButton1" OnClientClick="doPreview();return false;" runat="server"
            ImageUrl="~/Images/Informe/informe.jpg" /></td>
        <td style="font-family: Verdana; font-size: 10px; font-weight: bold; color: Teal;
          height: 38px;">
          El informe ha sido generado.<br /> Haga click en el Ícono para visualizarlo.</td>
      </tr>
    </table>
  </form>
</body>
</html>
