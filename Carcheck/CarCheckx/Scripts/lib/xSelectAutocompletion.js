// JScript File

function xSelectAutocompletion(textField,dropField) {
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
			//CCSOL.Utiles.RegenerateViewState();
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