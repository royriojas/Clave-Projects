<%@ Page Language="C#" AutoEventWireup="true" CodeFile="borrar_Anular_Solicitud.aspx.cs" Inherits="borrar_Anular_Solicitud" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
   
    <div id="dropDownAnular" class="popUpForm" style="padding: 2px; width: 250px; text-align: left;
      display: none; position: absolute; z-index: 104;">
      <table border="0" cellpadding="0" cellspacing="0" class="DataTable">
        <tr>
          <td align="left" style="font-weight: bold; height: 12px;">
            Motivo</td>
        </tr>
        <tr>
          <td align="left">
            <select name="DropDownList1" id="DropDownList1" class="FormText NOHIDE" style="width: 244px;">
              <option value=""></option>
              <option value="DESISTIMIENTO DEL SOLICITANTE">DESISTIMIENTO DEL SOLICITANTE</option>
            </select>
          </td>
        </tr>
        <tr>
          <td align="left" style=" font-weight: bold;" valign="bottom">
            Observación</td>
        </tr>
        <tr>
          <td align="left">
            <textarea name="descripcionTextBox" rows="6" cols="20" id="descripcionTextBox" class="FormText"
              style="width: 240px;"></textarea></td>
        </tr>
        <tr>
          <td align="right" style="height: 20px">
            <input name="guardarButton" type="button" onclick="xMenuAnular.hide();return false;"
              id="guardarButton" class="FormButton" style="width: 130px" value="Anular Inspección" />
            <input id="cancelarButton" onclick="xMenuAnular.hide();return false;" class="FormButton"
              type="button" value="Cancelar" />
          </td>
        </tr>
      </table>
    </div>
    
    </form>
</body>
</html>
