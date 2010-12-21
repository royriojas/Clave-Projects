function xCheckHabilitador(str_chk_id,str_ctrl_to_habilitar,str_disabled_style) {            
            var chkOrigen = $(str_chk_id);
            var txtControlar = $(str_ctrl_to_habilitar); 
            try {
              var styleOriginal = txtControlar.className;
            }
            catch(e) {
            }
            var styleDeshabilitado = str_disabled_style;            
                        
            //añade un listener al evento click del chk
            xAddEventListener(chkOrigen,'click',doValidationState,true);            
            
            //hago una verificación inicial de los estilos
            doValidationState();
            
            function doValidationState() {
                //alert(txtControlar.id);
                try {
                    txtControlar.disabled = !(chkOrigen.checked);
                    txtControlar.className = (!chkOrigen.checked)?styleDeshabilitado:styleOriginal;
                }
                catch (e)
                {
                    alert(e.message);
                }
            }
            
        }         
        
function xCheckEnabler(chk_ele,str_ctrl_to_habilitar,str_disabled_style) {            
            var chkOrigen = chk_ele;
            var txtControlar = $(str_ctrl_to_habilitar); 
            try {
              var styleOriginal = txtControlar.className;
            }
            catch(e) {
            }
            var styleDeshabilitado = str_disabled_style;            
                        
            //añade un listener al evento click del chk
            xAddEventListener(chkOrigen,'click',doValidationState,true);            
            
            //hago una verificación inicial de los estilos
            doValidationState();
            
            function doValidationState() {
                //alert(txtControlar.id);
                try {
                    txtControlar.disabled = !(chkOrigen.checked);
                    txtControlar.className = (!chkOrigen.checked)?styleDeshabilitado:styleOriginal;
                }
                catch (e)
                {
                    alert(e.message);
                }
            }
            
        }         