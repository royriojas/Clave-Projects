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
using System.IO;
using CarCheck.Gestores;

public partial class vFIDamage : System.Web.UI.Page
{
  public EventControl damageCallBack = new EventControl();
  public EventControl damageListCallBack = new EventControl();
  private CallbackEventArgs eventArguments = new CallbackEventArgs();
  public String vehiculoId = null;
  Decimal claseVehiculoId = 0;


  public bool IsEditable = true;
  public bool IsAnulada = false;

  public bool ShowBeVisibleDeleteImage()
  {
    return IsEditable && GestorSeguridad.hasPermision(Funcionalidades.FI_DAMAGE_DELETE);
  }

  protected void Page_Load(object sender, EventArgs e)
  {
    AjaxPro.Utility.RegisterTypeForAjax(typeof(CarCheck.Gestores.GestorInspeccion));

    //if (!IsPostBack)
    //    CarCheck.Gestores.GestorInspeccion.SeguridadInspeccion(Request.QueryString["uid"], controlPanel);

    vehiculoId = Request.QueryString["VehiculoId"].ToString();
    decimal? inspId = GestorInspeccion.getInspeccionId(Convert.ToDecimal(vehiculoId));
    anularImageButton.Attributes.Add("InsId", inspId.ToString());
    anularImageButton.Attributes.Add("SolId", GestorInspeccion.getSolicitudId(inspId).ToString());

    IsEditable = GestorInspeccion.couldModify(inspId.ToString());

    this.anularImageButton.Visible =
      this.btnVistaPrevia.Visible = IsEditable;

    IsAnulada = GestorInspeccion.InspeccionIsAnulada(inspId.ToString());

    dameClase();
  }

  #region ScriptCallBacks
  protected void Page_Init(object sender, EventArgs e)
  {
    damageCallBack.ScriptCallback += new EventControl.delScriptCallBack(damageCallBack_ScriptCallback);
    AddParsedSubObject(damageCallBack);
    damageListCallBack.ScriptCallback += new EventControl.delScriptCallBack(damageListCallBack_ScriptCallback);
    AddParsedSubObject(damageListCallBack);
  }

  string damageListCallBack_ScriptCallback(CallbackEventArgs eventArgument)
  {
    StringWriter sr = new StringWriter();
    HtmlTextWriter writer = new HtmlTextWriter(sr);
    damageGridView.DataBind();
    damageGridView.RenderControl(writer);
    writer.Dispose();
    return sr.ToString();
  }

  string damageCallBack_ScriptCallback(CallbackEventArgs eventArgument)
  {
    String result = "";
    eventArguments = eventArgument;
    damageFormView.DataBind();

    if (damageFormView.DataItem == null)
    {
      try
      {
        damageFormView.ChangeMode(FormViewMode.Insert);
        damageFormView.DataBind();
        ListItem ubicacionDamageIdItem = ((DropDownList)damageFormView.FindControl("ubicacionDamageIdCombo")).Items.FindByValue((string)eventArguments.Parameters[0]);
        if (ubicacionDamageIdItem != null)
        {
          ubicacionDamageIdItem.Selected = true;
          ((Label)damageFormView.FindControl("ubicacionDamageLabel")).Text = ubicacionDamageIdItem.Text;
        }
      }
      catch (Exception ex)
      {
        LoggerFacade.LogException(ex);
      }

    }

    StringWriter sr = new StringWriter();
    HtmlTextWriter writer = new HtmlTextWriter(sr);
    damageFormView.RenderControl(writer);
    writer.Dispose();
    result = sr.ToString();

    return result;
  }

  #endregion

  protected void odsDamage_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
  {
    if (eventArguments.Parameters.Count > 0)
      e.InputParameters["ubicacionDamageId"] = (string)eventArguments.Parameters[0];
  }
  public String getImageClase()
  {
    String Ruta = null;
    string RutaNoDisponible = "./Damage/clasenodisponible.jpg";
    if (IsAnulada)
    {
      return RutaNoDisponible;
    }

    dameClase();

    dsDamageTableAdapters.VehiculoDamageTableAdapter TA = new dsDamageTableAdapters.VehiculoDamageTableAdapter();

    object aImagenClaseObject = TA.GetImagenClase(claseVehiculoId);


    if (!(aImagenClaseObject is System.DBNull))
    {
      String imagenClase = (String)aImagenClaseObject;


      Ruta = String.Format("./Damage/{0}", imagenClase);

      if (!File.Exists(Server.MapPath(Ruta)))
      {
        Ruta = RutaNoDisponible;
      }
    }
    else
    {
      Ruta = RutaNoDisponible;
    }

    return Ruta;

  }

  private void dameClase()
  {
    dsDamageTableAdapters.VehiculoDamageTableAdapter TA = new dsDamageTableAdapters.VehiculoDamageTableAdapter();

    object aClaseVehiculoObject = TA.GetClaseVehiculoIdByVehiculoId(Convert.ToDecimal(this.vehiculoId));

    if (!(aClaseVehiculoObject is System.DBNull))
    {
      claseVehiculoId = Convert.ToDecimal(aClaseVehiculoObject);
    }

  }
  protected void odsDamageCoordenadas_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
  {

    if (IsAnulada)
    {
      claseVehiculoId = -1;
      vehiculoId = "-1";
    }

    e.InputParameters.Clear();
    e.InputParameters.Add("claseVehiculoId", claseVehiculoId);
    e.InputParameters.Add("vehiculoId", vehiculoId);
  }
  protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
  {
    GestorInspeccion.TerminarInspeccion(Convert.ToDecimal(vehiculoId));
    Response.Redirect("vListaInspeccion.aspx");
  }

}
