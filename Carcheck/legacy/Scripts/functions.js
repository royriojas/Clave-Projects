function MakeClear(img,flag){
	if (flag==0){ img.style.filter='alpha(opacity=100,enabled=1)'}
	else{ img.style.filter='alpha(opacity=75,enabled=1)'}
}

function txtCuenta(Control, Maximo){
	if(Control.value.length > Maximo){
		Control.value = Control.value.substring(0, Maximo);
	}
}

function WinPopUp(Url,WinNombre,WinWidth,WinHeight){
	var Xpos = (screen.width/2) - (WinWidth/2);
	var Ypos = (screen.height/2) - (WinHeight/2);
	window.open(Url,WinNombre,'width='+WinWidth+',height='+WinHeight+', left='+Xpos+', top='+Ypos+', toolbar=no,scrollbars=0,resizable=0,menubar=0,status=yes,directories=no,location=no');
}

function WinPopUpMax(Url){
	window.open(Url,'','toolbar=no,scrollbars=1,resizable=1,menubar=0,status=1,directories=0,location=0');
}

function ShowReport(Url){

	var WinWidth = 700;
	var WinHeight = 450;
	var Xpos = (screen.width/2) - (WinWidth/2);
	var Ypos = (screen.height/2) - (WinHeight/2);
	//window.open('vInformePDF.aspx?'+Url,'vInformePDF','width=700,height=450,toolbar=no,scrollbars=0,resizable=1,menubar=no,status=yes,directories=no,location=no');
	window.open(Url,'','width='+WinWidth+',height='+WinHeight+', left='+Xpos+', top='+Ypos+',scrollbars=0,resizable=1,menubar=no,status=yes,directories=no,location=no');
}

function rtrim(argvalue) {
  while (1) {
    if (argvalue.substring(argvalue.length - 1, argvalue.length) != " ")
      break;
    argvalue = argvalue.substring(0, argvalue.length - 1);
  }
  return argvalue;
}

function MouseOver(elemento)
{
    //    eval(elemento + ".className = 'HeaderStyle'");
    var fila = document.getElementById(elemento);
    fila.className = 'ItemStyleOver';
    
}

function MouseOut(elemento)
{
//    eval(elemento + ".className = 'ItemStyle'");
    var fila = document.getElementById(elemento);
    fila.className = 'ItemStyle';

}

function Redirect(url)
{
    document.location.href = url;
}
function reload() {
    var anterior = document.location.href;
    document.location.href = anterior;
}


function muestraVentanaPopUrl(urlName) {
    WinPopUpMax(urlName);
    return false;
}
function muestraVentanaPop(ele) {
	WinPopUpMax(ele.href);
	return false;
}
        
//llamada al metodo winOnLoad de la página vEditorCasoAjuste    
function recargaVentanaPadre() {
    //alert('llamando al padre');
    try {
        window.parent.winOnLoad();
    }
    catch (e) {
        alert(e.message);
    }
}



/*
  oculta la ventana PopUpDiv que de la ventana padre
*/	  
function xclose() {
    try {
         window.parent.hidePopWin(false);    
    }
    catch(ex) {
        
    }
}

/*
 abre la ventana actual como una ventana popUp tradicional
*/
function openInTraditionalPopUpWindow() {
    WinPopUpMax(document.location.href);
    //setTimeout(xclose,3000);
    return false;
}



//esta function depende del metodo showPopWin definido en SubModal.js
function showPopUpWin(ele, w, h) {
	try {
		//alert(ele.href);
		showPopWin(ele.href,w,h,false);
		return false;
	}
	catch(e) {
		alert(e.message);
		return false;
	}
}

