<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vContacto.aspx.cs" Inherits="Control_vContacto" %>

<%@ Register Src="../Mantenimientos/ucContacto.ascx" TagName="ucContacto" TagPrefix="uc1" %>
<%@ Register Src="../ucSecurityController.ascx" TagName="ucSecurityController" TagPrefix="uc2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
  <title>
    <%=CCSOL.Utiles.Utilidades.GetSystemNameAndVersion() %>
    | Contacto </title>

  <script type="text/javascript" src="../Scripts/lib/x.js"></script>

  <script type="text/javascript" src="../Scripts/lib/x_common.js"></script>

  <script type="text/javascript" src="../Scripts/lib/xDomReady.js"></script>

  <script type="text/javascript" src="../Scripts/lib/xCaseFormatter.js"></script>

  <script type="text/javascript" src="../Scripts/lib/x_imageEffects.js"></script>

  <script type="text/javascript" src="../Scripts/lib/xTable.js"></script>

  <script type="text/javascript" src="../Scripts/lib/xCollapsibleSystem.js"></script>

  <script type="text/javascript">
      CCSOL.Utiles.LoadCSS("../Scripts/xCommon/xCommon.css");
  </script>

  <link href="../Css/layout.css" rel="stylesheet" type="text/css" />
</head>
<body>
  <form id="form1" runat="server">
    <div style="text-align:left;">
      <uc2:ucSecurityController ID="UcSecurityController1" runat="server" MainFormName="form1" PageFunctionalityToCheck="CONTACTO_EDITOR_VER" Path=".." />
      <uc1:ucContacto ID="UcContacto1" runat="server" />
    </div>
  </form>
</body>
</html>
