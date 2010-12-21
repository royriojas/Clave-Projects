<%@ Page Language="C#" AutoEventWireup="true" CodeFile="testWebFormUpdateByCallBack.aspx.cs"
  Inherits="test_testWebFormUpdateByCallBack" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
  <title>Untitled Page</title>

  <script type="text/javascript" src="../Scripts/lib/x.js"></script>

  <script type="text/javascript" src="../Scripts/lib/x_common.js"></script>

  <script type="text/javascript" src="../Scripts/lib/xDomReady.js"></script>

  <script type="text/javascript">
     //Estilos globales comunes, deben siempre cargarse luego del x_common.js    
    CCSOL.Utiles.LoadCSS("./Scripts/xCommon/xCommon.css");
  </script>

  <script type="text/javascript">
    window.onload = function () {
      xTrapPostBackFunction();      
    }
    function xTrapPostBackFunction()
    {
      try
      {
        if (typeof __doPostBack == 'function')
        {
          old_doPostBack = __doPostBack;
          __doPostBack = function(controlId, value)
          {
            if (controlId == 'GridView1')
            {
              CCSOL.Utiles.RegenerateViewState();
              var arg = value;
              var context;
              CCSOL.DOM.xShowLoadingMessage(":: Procesando ::");

              <%=ClientScript.GetCallbackEventReference(this.handlerForCallBacks, "arg", "doCallback_Refresh", "context", "HandleError", false) %>;              
            }
            else
            {
              old_doPosBack(controlId, value);
            }
          }
        }
      }
      catch (e)
      {
      }
      return false;
    }
    function doCallback_Refresh(result, context)
    {

      CCSOL.DOM.xHideLoadingMessage();
      //$('theLoadingMessage').style.display = 'none';

      var linea = new String(result);
      //alert(linea);            
      var divGridContainer = $('DivGridAsegurados');
      divGridContainer.innerHTML = linea;      
    }

    function HandleError(message)
    {
      CCSOL.DOM.xHideLoadingMessage();
      alert("[Error] : " + message);
    }
  </script>

  <script type="text/javascript">
    function doCommand(e) {
      CCSOL.Utiles.RegenerateViewState();
      var xe = new xEvent(e);
      var indice = CCSOL.DOM.x_GetAttribute(xe.target,'attr');
      var carg = CCSOL.DOM.x_GetAttribute(xe.target,'carg');
      var arg = carg + '$' + indice;
      var context;
      CCSOL.DOM.xShowLoadingMessage(":: Procesando ::");
      <%=ClientScript.GetCallbackEventReference(this.handlerForCallBacks, "arg", "doCallback_Refresh", "context", "HandleError", false) %>;              
    }           
  </script>

</head>
<body>
  <form id="form1" runat="server">
    <div>
      Prueba de Edición de personas<br />
      <div id='DivGridAsegurados'>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="personaId"
          DataSourceID="odsAsegurados" OnRowUpdating="GridView1_RowUpdating">
          <Columns>
            <asp:BoundField DataField="personaId" HeaderText="personaId" ReadOnly="True" SortExpression="personaId" />
            <asp:BoundField DataField="brevete" HeaderText="brevete" SortExpression="brevete" />
            <asp:BoundField DataField="brevetefExpedicion" HeaderText="brevetefExpedicion" SortExpression="brevetefExpedicion" />
            <asp:BoundField DataField="brevetefVencimiento" HeaderText="brevetefVencimiento"
              SortExpression="brevetefVencimiento" />
            <asp:BoundField DataField="breveteCategoria" HeaderText="breveteCategoria" SortExpression="breveteCategoria" />
            <asp:TemplateField HeaderText="ocupacionGiro" SortExpression="ocupacionGiro">
              <EditItemTemplate>
                <asp:TextBox ID="txtOcupacionGiro" runat="server" Text='<%# Bind("ocupacionGiro") %>'></asp:TextBox>
              </EditItemTemplate>
              <ItemTemplate>
                <asp:Label ID="Label1" runat="server" Text='<%# Bind("ocupacionGiro") %>'></asp:Label>
              </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField ShowHeader="False">
              <EditItemTemplate>
                <asp:ImageButton OnClientClick='doCommand();return false;' carg='Update' ID="ImageButton1" runat="server"
                  attr='<%# num++ %>' CausesValidation="True" CommandName="Update" ImageUrl="~/Images/btnsListas/icon_ok.jpg"
                  Text="Update" />&nbsp;
                <asp:ImageButton ID="ImageButton2" runat="server" carg='Cancel' CausesValidation="False" CommandName="Cancel"
                  OnClientClick='doCommand();return false' ImageUrl="~/Images/btnsListas/icon_exit.jpg"
                  Text="Cancel" />
              </EditItemTemplate>
              <ItemTemplate>
                <asp:ImageButton ID="ImageButton1" carg='Edit' runat="server" CausesValidation="False" CommandName="Edit"
                  attr='<%# num %>' OnClientClick='doCommand();return false;' ImageUrl="~/Images/btnsListas/icon_edit.jpg"
                  Text="Edit" />&nbsp;
                <asp:ImageButton attr='<%# num++ %>'  ID="ImageButton2" carg='Delete' runat="server" CausesValidation="False" CommandName="Delete"
                  ImageUrl="~/Images/btnsListas/icon_delete.jpg" Text="Delete" OnClientClick="doCommand();return false" />
              </ItemTemplate>
            </asp:TemplateField>
          </Columns>
        </asp:GridView>
      </div>
      <asp:ObjectDataSource ID="odsAsegurados" runat="server" DeleteMethod="Delete" InsertMethod="Insert"
        OldValuesParameterFormatString="{0}" SelectMethod="GetData" TypeName="dsAseguradoTableAdapters.proc_Car_AseguradoLoadAllTableAdapter"
        UpdateMethod="Update">
        <DeleteParameters>
          <asp:Parameter Name="personaId" Type="Int32" />
          <asp:Parameter Name="uupdate" Type="String" />
        </DeleteParameters>
        <UpdateParameters>
          <asp:Parameter Name="personaId" Type="Int32" />
          <asp:Parameter Name="brevete" Type="String" />
          <asp:Parameter Name="brevetefExpedicion" Type="DateTime" />
          <asp:Parameter Name="brevetefVencimiento" Type="DateTime" />
          <asp:Parameter Name="breveteCategoria" Type="String" />
          <asp:Parameter Name="uupdate" Type="String" />
          <asp:Parameter Name="pc" Type="String" />
          <asp:Parameter Name="ocupacionGiro" Type="String" />
        </UpdateParameters>
        <InsertParameters>
          <asp:Parameter Name="personaId" Type="Int32" />
          <asp:Parameter Name="brevete" Type="String" />
          <asp:Parameter Name="brevetefExpedicion" Type="DateTime" />
          <asp:Parameter Name="brevetefVencimiento" Type="DateTime" />
          <asp:Parameter Name="breveteCategoria" Type="String" />
          <asp:Parameter Name="ucrea" Type="String" />
          <asp:Parameter Name="pc" Type="String" />
          <asp:Parameter Name="ocupacionGiro" Type="String" />
        </InsertParameters>
      </asp:ObjectDataSource>
    </div>
  </form>
</body>
</html>
