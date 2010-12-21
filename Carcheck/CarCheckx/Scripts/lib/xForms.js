// JScript File

function clearOptions(selectId) {
		$(selectId).options.length = 0;
	}
	
	function addOption(selectId,text,value,selected) {
		$(selectId).options.add(new Option(text,value,false,selected));
	}
	
	function addOptions(selectId,opArr) {
	    clearOptions(selectId);
		var aSelect = $(selectId);
		try {
			for (i = 0; i < opArr.length; i++) {
				aSelect.options.add(new Option(opArr[i].text,opArr[i].value));
			}
		}
		catch(e) {
			alert('addOptions: '+ e.message);
		}
	}

  function clearFormElementsInDiv(strDiv) {
	    try {
	      var arrInputs = xGetElementsByClassName('FormText',$(strDiv),'INPUT');
	      var arrSelects = xGetElementsByClassName('FormText',$(strDiv),'SELECT');
	      var arrTextAreas = xGetElementsByClassName('FormText',$(strDiv),'TEXTAREA');
  	    
	      for (ini = 0; ini < arrInputs.length ; ini++) {
	        arrInputs[ini].value = '';
	      }
  	    
	      for (ini = 0; ini < arrSelects.length ; ini++) {
	        arrSelects [ini].selectedIndex = 0;
	      }
  	    
	      for (ini = 0; ini < arrTextAreas.length ; ini++) {
	        arrTextAreas[ini].value = '';
	      }
	    }
	    catch(e) {
	      alert("[Error al Limpiar el formualrio] : "+ e.message);
	    }
	    
	  }