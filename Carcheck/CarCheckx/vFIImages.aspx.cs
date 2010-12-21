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
using dsImagesTableAdapters;

public partial class vFIImages : System.Web.UI.Page
{
  #region CallBacks

  public EventControl cckhandler = new EventControl();

  protected void Page_Init(object sender, EventArgs e)
  {
    cckhandler.ScriptCallback += new EventControl.delScriptCallBack(cckhandler_ScriptCallback);

    this.AddParsedSubObject(cckhandler);
  }

  public string cckhandler_ScriptCallback(CallbackEventArgs eventArgument)
  {
    this.repaterExterior.DataBind();
    this.repeaterInterior.DataBind();
    this.repeaterImpronta.DataBind();
    this.repeaterDamage.DataBind();
    this.repeaterDocumentos.DataBind();
    this.repeaterOtros.DataBind();

    String result = CCSOL.Utiles.Utilidades.getHTML(this.repaterExterior) + "$$$$_$$$$" +
                    CCSOL.Utiles.Utilidades.getHTML(this.repeaterInterior) + "$$$$_$$$$" +
                    CCSOL.Utiles.Utilidades.getHTML(this.repeaterImpronta) + "$$$$_$$$$" +
                    CCSOL.Utiles.Utilidades.getHTML(this.repeaterDamage) + "$$$$_$$$$" +
                    CCSOL.Utiles.Utilidades.getHTML(this.repeaterDocumentos) + "$$$$_$$$$" +
                    CCSOL.Utiles.Utilidades.getHTML(this.repeaterOtros);

    return result;
  }
  #endregion

  


  public string encondeString(object str)
  {
    string s = Convert.ToString(str);

    return Server.HtmlEncode(s);

  }

  public decimal VehiculoId;
  public string getProgramParameters()
  {
    string result = "";
    if (decimal.TryParse(Request.QueryString["VehiculoId"], out VehiculoId))
    {
      GetInspeccionByVehiculoIdTableAdapter myTa = new GetInspeccionByVehiculoIdTableAdapter();
      dsImages.GetInspeccionByVehiculoIdDataTable myDt = myTa.GetData(VehiculoId);

      if (myDt.Rows.Count > 0)
      {
        dsImages.GetInspeccionByVehiculoIdRow row = (dsImages.GetInspeccionByVehiculoIdRow)myDt.Rows[0];
        string ucrea = GestorSeguridad.getUserData().UserName;
        try
        {
          result = String.Format(" \"{0}\" \"{1}\" \"{2}\" \"{3}\" \"{4}\"", VehiculoId, row.placa, row.numeInspeccion, row.persona, ucrea);
        }
        catch (Exception ex)
        {
          result = "";
        }
      }
    }
    return result;

  }
  protected void Page_Load(object sender, EventArgs e)
  {

    //if (!IsPostBack)
    //  GestorInspeccion.SeguridadInspeccion(Request.QueryString["uid"], controlPanel);
    string vehiculoId = Request.QueryString["VehiculoId"].ToString();
    decimal? inspId = GestorInspeccion.getInspeccionId(Convert.ToDecimal(vehiculoId));
    anularImageButton.Attributes.Add("InsId", inspId.ToString());
    anularImageButton.Attributes.Add("SolId", GestorInspeccion.getSolicitudId(inspId).ToString());

    bool flagEditable = GestorInspeccion.couldModify(inspId.ToString());
    this.fotoImageButton.Visible =
    this.imgBtnPickImageBtn.Visible =
    this.btnVistaPrevia.Visible =
    this.aprobarImageButton.Visible = 
    this.desaprobarImageButton.Visible =
    this.anularImageButton.Visible = flagEditable;


    this.imgTerminarInspeccion.Visible = !GestorInspeccion.IsTerminadaByInspector(inspId.ToString()) && flagEditable;





  }
  protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
  {
    GestorInspeccion.TerminarInspeccion(Convert.ToDecimal(Request.QueryString["VehiculoId"]));
    Response.Redirect("vListaInspeccion.aspx");
  }
}
