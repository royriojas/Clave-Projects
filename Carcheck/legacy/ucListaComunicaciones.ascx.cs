using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using AjaxCanales.Utiles;
using CCSOL.Utiles;
using CarCheck.Gestores;

public partial class ucListaComunicaciones : System.Web.UI.UserControl
{

  private string _triggerBtn;
  public string TriggerBtn
  {
    get
    {
      return _triggerBtn;
    }
    set
    {
      _triggerBtn = value;
    }
  }


  #region CallBacks
  public EventControl callback_gridComunicacion = new EventControl();

  protected void Page_Init(object sender, EventArgs e)
  {
    callback_gridComunicacion.ScriptCallback += new EventControl.delScriptCallBack(cargar_gridComunicacion_ScriptCallback);
    this.AddParsedSubObject(callback_gridComunicacion);
  }

  public string cargar_gridComunicacion_ScriptCallback(CallbackEventArgs eventArgument)
  {
    string inspeccionId = (string)eventArgument.Parameters[0];
    return GestorInspeccion.getDatosCita(inspeccionId, this.comunicacionGridView);


  }


  #endregion

  protected void Page_Load(object sender, EventArgs e)
  {

  }
}
