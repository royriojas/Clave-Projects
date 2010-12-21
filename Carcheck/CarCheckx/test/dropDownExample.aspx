<%@ Page Language="C#" AutoEventWireup="true" CodeFile="dropDownExample.aspx.cs"
    Inherits="test_dropDownExample" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Prueba de DropDownList</title>

    <script type="text/javascript" src="../Scripts/lib/x.js"></script>

    <script type="text/javascript" src="../Scripts/lib/x_common.js"></script>

    <script type="text/javascript">	
	
	CCSOL.Utiles.LoadScript("../Scripts/lib/x_especialTooltip.js");
	CCSOL.Utiles.LoadCSS("../Scripts/x_info/xInfo.css");
	CCSOL.Utiles.LoadScript("../Scripts/lib/xInfoSystem.js");
	
	function activateInfo() {			
		var info = new infoSystem('holder_info','DivContainer','tt_help_info','tt_title','tt_text');
	}
	xAddEventListener(window,'load', activateInfo,false);
    </script>

    <script type="text/javascript" src="../Scripts/jsAutoComplete/autocomplete.js"></script>

    <script type="text/javascript">
   /* Estos Objetos deben pasar a su propio ARCHIVO .x no lo olvides!!!!!!!!!!!!!!!!!!!!!! */    
	function cargaDropDownList(textField,dropField) {
		var aTextField = $(textField);
		var aDropField = $(dropField);
		try {
			xAddEventListener(aTextField,'keyup',onKeyUpHandler,true);
			xAddEventListener(aDropField,'change',onChangeHandler,true);
		}
		catch(e) {
			alert(e.message);
		}
		
		function onKeyUpHandler(evt) {
			autoComplete (aTextField, aDropField, 'text', true);
		}
		
		function onChangeHandler(evt) {
			try {
				aTextField.value = aDropField.options[aDropField.selectedIndex].text;
			}
			catch(e) {
				alert(e.message);
			}
		}
		
		
	}	
	</script>
	<script type="text/javascript">
	CCSOL.Utiles.LoadScript("../Scripts/lib/xForms.js");	
	window.onload = function () {
		/*var autoComplete = new cargaDropDownList('myText','mySelect');*/
		/*var dropDownTitle = new xDropDownToolTip('aDropDownWithTitle',null);*/
		xAddEventListener($('cbxClase'),'change',getMarcasFromAjax,false);
		
	}    
    function getMarcasFromAjax() {
        var cbxClase = $('cbxClase');
        var claseId = cbxClase.options[cbxClase.selectedIndex].value;
        test_dropDownExample.getMarcasVehiculo(claseId,getMarcas_handler);
        clearOptions('cbxMarca');
        clearOptions('cbxModelo');
        CCSOL.DOM.xShowLoadingMessage();
        xRemoveEventListener($('cbxMarca'),'change',getModelosFromAjax,false);
    }	
    
    function getMarcas_handler(res) {	    	    	      
	    try {
	        var arr = res.value;
	        addOptions('cbxMarca',res.value);
	        xAddEventListener($('cbxMarca'),'change',getModelosFromAjax,false);
	        CCSOL.DOM.xHideLoadingMessage();
	    }
	    catch(e) {
	        alert('res_handler : ' + e.message);
	    }
	}
    
    function getModelosFromAjax() {
        var cbxClase = $('cbxClase');
        var claseId = cbxClase.options[cbxClase.selectedIndex].value;
        
        var cbxMarca = $('cbxMarca');
        var marcaId = cbxMarca.options[cbxMarca.selectedIndex].value;
        
        test_dropDownExample.getModelosVehiculo(claseId,marcaId,getModelos_handler);        
        clearOptions('cbxModelo');  
        CCSOL.DOM.xShowLoadingMessage();                      
        
    }
    function getModelos_handler(res) {
         try {
	        var arr = res.value;
	        addOptions('cbxModelo',res.value);	 
	        CCSOL.DOM.xHideLoadingMessage();       
	    }
	    catch(e) {
	        alert('res_handler : ' + e.message);
	    }
    }
    
	
	
    </script>

</head>
<body>
    <form id="form1" runat="server">
        <div id='DivContainer'>
            clase<br />
            <asp:DropDownList ID="cbxClase" runat="server" AppendDataBoundItems="True" CssClass="aDropDownWithTitle tt_help_info"
                DataSourceID="odsClase" DataTextField="claseVehiculo" DataValueField="claseVehiculoId"
                Width="157px">
                <asp:ListItem Selected="True" Value="-1">[ - Elija - ]</asp:ListItem>
            </asp:DropDownList><br />
            <br />
            &nbsp;marca<br />
            <div id='resultado'>
                <asp:DropDownList ID="cbxMarca" runat="server" Width="156px">
                    <asp:ListItem Value="-1">[ - Elija - ]</asp:ListItem>
                </asp:DropDownList><br />
                <br />
                modelo<br />
                <asp:DropDownList ID="cbxModelo" runat="server" Width="154px">
                    <asp:ListItem Value="-1">[ - Elija - ]</asp:ListItem>
                </asp:DropDownList>
                <br />
                <br />
                <asp:ObjectDataSource ID="odsClase" runat="server" OldValuesParameterFormatString="original_{0}"
                SelectMethod="GetData" TypeName="ADM_DAL.dsDropDownListTableAdapters.ClaseVehiculoLoadDropDownTableAdapter">
            </asp:ObjectDataSource>
                &nbsp;<br />
                <br />
            </div>
        </div>
    </form>
</body>
</html>
