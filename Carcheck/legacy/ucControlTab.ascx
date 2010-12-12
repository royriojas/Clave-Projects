<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ucControlTab.ascx.cs"
    Inherits="ucControlTab" %>
<link href="Css/layoutTabs.css" rel="stylesheet" type="text/css" />

<div id="mainTab" class="mainTab">
    <div style="text-align:left;">
        <asp:Label ID="InspeccionLabel" runat="server" Height="18px" Style="margin: 0px;
            padding: 2px 10px 0px 2px" Font-Bold="True" Font-Names="Tahoma"
            Font-Size="12px" ForeColor="Gold">Solicitud: INS-001-XXX</asp:Label>
    </div>    
    <br />
    <div runat="server" id="DatosPersonalesTab" enableviewstate="true" class="itemTab">
        <div runat="server" id="DatosPersonalesLeftTab" class="itemLeftBackTab">
        </div>
        <div runat="server" id="DatosPersonalesCenterTab" class="itemCenterBackTab" onclick="CCSOL.Utiles.Redirect('vFIDatosPersonales.aspx');">
            Datos Personales</div>
        <div runat="server" id="DatosPersonalesRightTab" class="itemRightBackTab">
        </div>
    </div>
    <div runat="server" id="DatosVehiculoTab" enableviewstate="true" class="itemTab">
        <div runat="server" id="DatosVehiculoLeftTab" class="itemLeftBackTab">
        </div>
        <div runat="server" id="DatosVehiculoCenterTab" class="itemCenterBackTab"   onclick="CCSOL.Utiles.Redirect('vFIDatosVehiculo.aspx');">
            Datos Vehículo</div>
        <div runat="server" id="DatosVehiculoRightTab" class="itemRightBackTab">
        </div>
    </div>
    <div runat="server" id="CaracteristicasTab" enableviewstate="true" class="itemTab">
        <div runat="server" id="CaracteristicasLeftTab" class="itemLeftBackTab">
        </div>
        <div runat="server" id="CaracteristicasCenterTab" class="itemCenterBackTab" onclick="CCSOL.Utiles.Redirect('vFICaracteristicas.aspx');">
            Características</div>
        <div runat="server" id="CaracteristicasRightTab" class="itemRightBackTab">
        </div>
    </div>
    <div runat="server" id="LlantasTab" enableviewstate="true" class="itemTab">
        <div runat="server" id="LlantasLeftTab" class="itemLeftBackTab">
        </div>
        <div runat="server" id="LlantasCenterTab" class="itemCenterBackTab"         onclick="CCSOL.Utiles.Redirect('vFILlantas.aspx');">
            Llantas</div>
        <div runat="server" id="LlantasRightTab" class="itemRightBackTab">
        </div>
    </div>
    <div runat="server" id="DamageTab" enableviewstate="true" class="itemTab">
        <div runat="server" id="DamageLeftTab" class="itemLeftBackTab">
        </div>
        <div runat="server" id="DamageCenterTab" class="itemCenterBackTab"          onclick="CCSOL.Utiles.Redirect('vFIDamage.aspx');">
            Daños</div>
        <div runat="server" id="DamageRightTab" class="itemRightBackTab">
        </div>
    </div>
    <div runat="server" id="ImagenesTab" enableviewstate="true" class="itemTab">
        <div runat="server" id="ImagenesLeftTab" class="itemLeftBackTab">
        </div>
        <div runat="server" id="ImagenesCenterTab" class="itemCenterBackTab"        onclick="CCSOL.Utiles.Redirect('vFIImages.aspx');">
            Imágenes</div>
        <div runat="server" id="ImagenesRightTab" class="itemRightBackTab">
        </div>
    </div>
    <div runat="server" id="rightTab" class="rightTab">
    </div>
</div>
