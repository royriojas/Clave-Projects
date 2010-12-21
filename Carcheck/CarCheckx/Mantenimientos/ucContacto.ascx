<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ucContacto.ascx.cs" Inherits="Mantenimientos_ucContacto" %>
<link href="../Css/layout.css" rel="stylesheet" type="text/css" />
<div style="overflow:auto;width:730px;height:400px;position:relative;">
  <div class="DataTop">
    <div class="DataTopLeft">
    </div>
    <div class="DataTopRight">
    </div>
  </div>
  <div class="DataContent">
    <div class="DataContentRight">
      <div class="PanelEncabezado">
        <span id="Label1" title="Mostrar / Ocultar Panel">Nuevo </span>
        <img auxelement='Label1' eth_isvisible='false' elementtohide="DivNewElement" id="img1"
          alt="Mostrar / Ocultar Panel" src="../Images/IconHide16Dark.gif" title="Mostrar/Ocultar"
          style="margin-top: 3px;" class="xCollapsible MakeClear" />
      </div>
      <div id='DivNewElement' class="DataTable">
        <asp:FormView ID="FormView1" runat="server" DataKeyNames="contactoId" DataSourceID="odsContacto"
          DefaultMode="Insert">
          <InsertItemTemplate>
            <table border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td style="width: 96px">
                  Contacto:
                </td>
                <td style="width: 96px">
                  <asp:TextBox ID="contactoTextBox" runat="server" CssClass="FormText" Text='<%# Bind("contacto") %>'
                    Width="200px"></asp:TextBox></td>
                <td style="width: 74px">
                  Teléfono 1:
                </td>
                <td>
                  <asp:TextBox ID="telefono1TextBox" runat="server" CssClass="FormText" Text='<%# Bind("telefono1") %>'
                    Width="200px"></asp:TextBox></td>
              </tr>
              <tr>
                <td style="width: 96px">
                  Email:
                </td>
                <td style="width: 96px">
                  <asp:TextBox ID="emailTextBox" runat="server" CssClass="FormText" Text='<%# Bind("email") %>'
                    Width="200px"></asp:TextBox></td>
                <td style="width: 74px">
                  Teléfono 2:
                </td>
                <td>
                  <asp:TextBox ID="telefono2TextBox" runat="server" CssClass="FormText" Text='<%# Bind("telefono2") %>'
                    Width="200px"></asp:TextBox></td>
              </tr>
              <tr>
                <td style="width: 96px">
                  Oficina</td>
                <td style="width: 96px">
                  <asp:TextBox ID="oficinaTextBox" runat="server" CssClass="FormText" Text='<%# Bind("oficina") %>'
                    Width="200px"></asp:TextBox></td>
                <td style="width: 96px">
                  Cargo:
                </td>
                <td>
                  <asp:TextBox ID="cargoTextBox" runat="server" CssClass="FormText" Text='<%# Bind("cargo") %>'
                    Width="200px"></asp:TextBox></td>
              </tr>
            </table>
            <asp:ImageButton ID="ImageButton3" runat="server" CommandName="Insert" CssClass="MakeClear"
              ImageUrl="~/Images/btnsListas/btnSaveCaracteristica.jpg" />
          </InsertItemTemplate>
        </asp:FormView>
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
      <div class="DataContentRight">
        <div class="PanelEncabezado">
          <span id="Label2" title="Mostrar / Ocultar Panel">Filtros </span>
          <img auxelement='Label2' eth_isvisible='false' elementtohide='divFiltros' id="img2"
            alt="Mostrar / Ocultar Panel" src="../Images/IconHide16Dark.gif" title="Mostrar/Ocultar"
            style="margin-top: 3px;" class="xCollapsible MakeClear" />
        </div>
        <div id='divFiltros' class="DataTable">
          <table border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td>
                &nbsp;Contacto:</td>
              <td>
                <asp:TextBox ID="TextBox1" runat="server" CssClass="FormText" Width="200px"></asp:TextBox></td>
              <td>
                <asp:ImageButton ID="ImageButton4" runat="server" ImageUrl="~/Images/btnsListas/icon_search.jpg" /></td>
            </tr>
          </table>
        </div>
      </div>
    </div>
    <div class="DataBottom">
      <div class="DataBottomLeft">
      </div>
      <div class="DataBottomRight">
      </div>
    </div>
  </div>
  <div class="DataTop">
    <div class="DataTopLeft">
    </div>
    <div class="DataTopRight">
    </div>
  </div>
  <div class="DataContent">
    <div class="DataContentRight">
      <div class="PanelEncabezado">
        <span id="Label3" title="Mostrar / Ocultar Panel">Contactos </span>
        <img auxelement='Label3' eth_isvisible='true' elementtohide='gridResults' id="imgCollapse"
          alt="Mostrar / Ocultar Panel" src="../Images/IconHide16Dark.gif" title="Mostrar/Ocultar"
          style="margin-top: 3px;" class="xCollapsible MakeClear" />
      </div>
      <div id='gridResults' class='PanelInset DataTable' style="text-align: left; padding-right: 2px;
        padding-left: 2px; padding-bottom: 2px; padding-top: 2px; height: 289px; width: 683px;">
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="contactoId"
          DataSourceID="odsContacto" AllowPaging="True" AllowSorting="True" OnRowDataBound="GridView1_RowDataBound" OnRowDeleted="GridView1_RowDeleted">
          <Columns>
            <asp:BoundField DataField="contactoId" HeaderText="contactoId" InsertVisible="False"
              ReadOnly="True" SortExpression="contactoId" Visible="False" />
            <asp:BoundField DataField="contacto" HeaderText="Contacto" SortExpression="contacto">
              <ItemStyle Width="200px" />
              <ControlStyle CssClass="FormText" Width="200px" />
            </asp:BoundField>
            <asp:BoundField DataField="telefono1" HeaderText="Tel&#233;fono 1" SortExpression="telefono1">
              <ControlStyle CssClass="FormText" />
            </asp:BoundField>
            <asp:BoundField DataField="telefono2" HeaderText="Tel&#233;fono 2" SortExpression="telefono2">
              <ControlStyle CssClass="FormText" />
            </asp:BoundField>
            <asp:BoundField DataField="email" HeaderText="E-mail" SortExpression="email">
              <ItemStyle Width="150px" />
              <ControlStyle CssClass="FormText" Width="150px" />
            </asp:BoundField>
            <asp:BoundField DataField="oficina" HeaderText="Direcci&#243;n Oficina" SortExpression="oficina">
              <ControlStyle CssClass="FormText" />
            </asp:BoundField>
            <asp:BoundField DataField="cargo" HeaderText="Cargo" SortExpression="cargo">
              <ControlStyle CssClass="FormText" />
            </asp:BoundField>
            <asp:BoundField DataField="estado" HeaderText="A/I" SortExpression="estado">
              <ControlStyle CssClass="FormText" />
              <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:TemplateField ShowHeader="False">
              <EditItemTemplate>
                <asp:ImageButton ID="ImageButton1" runat="server" CausesValidation="True" CommandName="Update"
                  ImageUrl="~/Images/btnsListas/icon_ok.jpg" Text="Update" />&nbsp;<asp:ImageButton
                    ID="ImageButton2" runat="server" CausesValidation="False" CommandName="Cancel"
                    ImageUrl="~/Images/btnsListas/icon_exit.jpg" Text="Cancel" />
              </EditItemTemplate>
              <ItemTemplate>
                <asp:ImageButton ID="ImageButton1" runat="server" CausesValidation="False" CommandName="Edit"
                  ImageUrl="~/Images/btnsListas/icon_edit.jpg" Text="Edit" />&nbsp;<asp:ImageButton
                    ID="ImageButton2" runat="server" CausesValidation="False" CommandName="Delete"
                    ImageUrl="~/Images/btnsListas/icon_delete.jpg" Text="Delete" />
              </ItemTemplate>
            </asp:TemplateField>
          </Columns>
          <RowStyle CssClass="ItemStyle" />
          <HeaderStyle CssClass="HeaderStyle" />
          <EmptyDataTemplate>
            No hay Datos para mostrar que coincidan con el criterio buscado. Intente nuevamente
            con otros valores.
          </EmptyDataTemplate>
        </asp:GridView>
      </div>
    </div>
  </div>
  <div class="DataBottom">
    <div class="DataBottomLeft">
    </div>
    <div class="DataBottomRight">
    </div>
  </div>
</div>
<asp:ObjectDataSource ID="odsContacto" runat="server" DeleteMethod="Delete" InsertMethod="Insert"
  SelectMethod="GetDataByContacto" TypeName="dsMantenimientosTableAdapters.proc_Car_Contacto_Load_AllTableAdapter"
  UpdateMethod="Update">
  <DeleteParameters>
    <asp:Parameter Name="contactoId" Type="Decimal" />
  </DeleteParameters>
  <UpdateParameters>
    <asp:Parameter Name="contactoId" Type="Decimal" />
    <asp:Parameter Name="contacto" Type="String" />
    <asp:Parameter Name="email" Type="String" />
    <asp:Parameter Name="telefono1" Type="String" />
    <asp:Parameter Name="telefono2" Type="String" />
    <asp:Parameter Name="oficina" Type="String" />
    <asp:Parameter Name="cargo" Type="String" />
    <asp:SessionParameter DefaultValue="" Name="uupdate" SessionField="userName" Type="String" />
    <asp:Parameter Name="pc" Type="String" />
    <asp:Parameter Name="estado" Type="String" />
  </UpdateParameters>
  <SelectParameters>
    <asp:ControlParameter ControlID="TextBox1" Name="contacto" PropertyName="Text" Type="String" />
  </SelectParameters>
  <InsertParameters>
    <asp:Parameter Direction="InputOutput" Name="contactoId" Type="Object" />
    <asp:Parameter Name="contacto" Type="String" />
    <asp:Parameter Name="email" Type="String" />
    <asp:Parameter Name="telefono1" Type="String" />
    <asp:Parameter Name="telefono2" Type="String" />
    <asp:Parameter Name="oficina" Type="String" />
    <asp:Parameter Name="cargo" Type="String" />
    <asp:SessionParameter Name="ucrea" SessionField="userName" Type="String" />
    <asp:Parameter Name="pc" Type="String" />
  </InsertParameters>
</asp:ObjectDataSource>
