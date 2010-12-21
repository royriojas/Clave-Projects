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
using CCSOL.Utiles;
using CarCheck.Gestores;

public partial class vFILlantas : System.Web.UI.Page
{
  #region CallBacks
  public EventControl nuevaLlantaInsertCallBack = new EventControl();

  protected void Page_Init(object sender, EventArgs e)
  {
    nuevaLlantaInsertCallBack.ScriptCallback += new EventControl.delScriptCallBack(nuevaLlantaInsertCallBack_ScriptCallback);

    AddParsedSubObject(nuevaLlantaInsertCallBack);
  }

  string nuevaLlantaInsertCallBack_ScriptCallback(CallbackEventArgs eventArgument)
  {
    int cantidad = 0;
    string cantidadStr = Utilidades.getInternalValueFromForm(this.frmLlanta, "txtCantidad");

    if (!String.IsNullOrEmpty(cantidadStr))
    {
      if (Int32.TryParse(cantidadStr, out cantidad))
      {
        for (int i = 0; i < cantidad; i++)
        {
          try
          {
            this.frmLlanta.InsertItem(true);
          }
          catch (Exception ex)
          {
            LoggerFacade.LogException(ex);
          }
        }
      }
    }

    return "";// grillaDataBind(eventArgument.Parameters[0].ToString());

  }
  string grillaDataBind(String vehiculoIdQueryString)
  {

    try
    {
      this.odsLlanta.SelectParameters.Clear();
      this.odsLlanta.SelectParameters.Add("vehiculoId", vehiculoIdQueryString);
      llantaGridView.DataBind();
    }
    catch (Exception ex)
    {
      LoggerFacade.LogException(ex);

    }

    return Utilidades.getHTML(this.llantaGridView);
  }

  #endregion

  public decimal vehiculoId;

  public bool shouldBeVisibleEdit()
  {    
    return IsEditable && GestorSeguridad.hasPermision(Funcionalidades.FI_LLANTA_EDIT);
  }

  public bool shouldBeVisibleDelete()
  {   
    return IsEditable && GestorSeguridad.hasPermision(Funcionalidades.FI_LLANTA_DELETE);
  }

  public bool IsEditable = true;

  protected void Page_Load(object sender, EventArgs e)
  {
    AjaxPro.Utility.RegisterTypeForAjax(typeof(CarCheck.Gestores.GestorInspeccion));

    vehiculoId = Convert.ToDecimal(Request.QueryString["VehiculoId"]);

    decimal? inspId = GestorInspeccion.getInspeccionId(Convert.ToDecimal(vehiculoId));
    anularImageButton.Attributes.Add("InsId", inspId.ToString());
    anularImageButton.Attributes.Add("SolId", GestorInspeccion.getSolicitudId(inspId).ToString());

    IsEditable = GestorInspeccion.couldModify(inspId.ToString());
    this.btnVistaPrevia.Visible =
    this.anularImageButton.Visible = IsEditable;
  }
       
  public String muestraTipoLlanta(object tllanta)
  {

    String tipoLlanta = "";
    try
    {
      tipoLlanta = Convert.ToString(tllanta);

      if (tipoLlanta == "P")
      {
        return "PRINCIPAL";
      }
      else if (tipoLlanta == "R")
      {
        return "REPUESTO";
      }
    }
    catch
    {
      tipoLlanta = "";
    }
    return tipoLlanta;
  }

  public String muestraEstado(object estado)
  {

    String estadoAro = "";
    try
    {
      estadoAro = Convert.ToString(estado);

      if (estadoAro == "B")
      {
        return "BUENO";
      }
      else if (estadoAro == "M")
      {
        return "MALO";
      }
      else if (estadoAro == "R")
      {
        return "REGULAR";
      }
    }
    catch
    {
      estadoAro = "";
    }
    return estadoAro;
  }

  public String muestraVasoCopa(object dato)
  {

    String vasoCopa = "";
    try
    {
      vasoCopa = Convert.ToString(dato);

      if (vasoCopa == "N")
      {
        return "NINGUNO";
      }
      else if (vasoCopa == "V")
      {
        return "CON VASO";
      }
      else if (vasoCopa == "C")
      {
        return "CON COPA";
      }
    }
    catch
    {
      vasoCopa = "";
    }
    return vasoCopa;
  }

  protected void FormView1_ItemInserting(object sender, FormViewInsertEventArgs e)
  {
    e.Values.Add("marcaLlanta", Utilidades.getInternalValueFromForm(this.frmLlanta, "txtMarcaLlanta"));
    e.Values.Add("modeloLlanta", Utilidades.getInternalValueFromForm(this.frmLlanta, "txtModeloLlanta"));
    e.Values.Add("desgaste", Utilidades.getInternalValueFromForm(this.frmLlanta, "txtDesgasteLlanta"));
    e.Values.Add("materialAroId", Utilidades.getInternalValueFromDropDownList(this.frmLlanta, "cbxMaterialAro"));
    e.Values.Add("estadoAro", Utilidades.getInternalValueFromDropDownList(this.frmLlanta, "cbxEstadoAro"));
    e.Values.Add("tllanta", Utilidades.getInternalValueFromDropDownList(this.frmLlanta, "cbxTLlanta"));
    e.Values.Add("vasocopa", Utilidades.getInternalValueFromDropDownList(this.frmLlanta, "cbxVasocopa"));
    e.Values.Add("marcaAro", Utilidades.getInternalValueFromForm(this.frmLlanta, "txtMarcaAro"));
    e.Values.Add("modeloAro", Utilidades.getInternalValueFromForm(this.frmLlanta, "txtModeloAro"));
    e.Values.Add("medidaAro", Utilidades.getInternalValueFromForm(this.frmLlanta, "txtMedidaAro"));
    e.Values.Add("observacion", Utilidades.getInternalValueFromForm(this.frmLlanta, "txtObservacion"));

    e.Values.Add("ucrea", Utilidades.getInternalValueFromForm(this.frmLlanta, Session["userName"].ToString()));


  }

  protected void llantaGridView_RowUpdating(object sender, GridViewUpdateEventArgs e)
  {
    /*e.NewValues.Add("marcaLlanta", Utilidades.getInternalValueFromForm(this.frmLlanta, "txtMarcaLlanta"));
    e.NewValues.Add("modeloLlanta", Utilidades.getInternalValueFromForm(this.frmLlanta, "txtModeloLlanta"));
    e.NewValues.Add("desgaste", Utilidades.getInternalValueFromForm(this.frmLlanta, "txtDesgasteLlanta"));
    e.NewValues.Add("materialAroId", Utilidades.getInternalValueFromDropDownList(this.frmLlanta, "cbxMaterialAro"));
    e.NewValues.Add("estadoAro", Utilidades.getInternalValueFromDropDownList(this.frmLlanta, "cbxEstadoAro"));
    e.NewValues.Add("tllanta", Utilidades.getInternalValueFromDropDownList(this.frmLlanta, "cbxTLlanta"));
    e.NewValues.Add("vasocopa", Utilidades.getInternalValueFromDropDownList(this.frmLlanta, "cbxVasocopa"));
    e.NewValues.Add("marcaAro", Utilidades.getInternalValueFromForm(this.frmLlanta, "txtMarcaAro"));
    e.NewValues.Add("modeloAro", Utilidades.getInternalValueFromForm(this.frmLlanta, "txtModeloAro"));
    e.NewValues.Add("medidaAro", Utilidades.getInternalValueFromForm(this.frmLlanta, "txtMedidaAro"));
    e.NewValues.Add("observacion", Utilidades.getInternalValueFromForm(this.frmLlanta, "txtObservacion"));

    e.NewValues.Add("ucrea", Utilidades.getInternalValueFromForm(this.frmLlanta, "SYSTEM"));*/
  }

  public String getImageTraccion()
  {
    String Ruta = null;

    //dsVehiculoTableAdapters.LlantaVehiculoTableAdapter TA = new dsVehiculoTableAdapters.LlantaVehiculoTableAdapter();
    dsVehiculoTableAdapters.VehiculoTableAdapter TA = new dsVehiculoTableAdapters.VehiculoTableAdapter();

    string traccionId = (string)TA.GetTraccionByVehiculoId(this.vehiculoId);

    Ruta = "./images/Carcheck/Traccion" + traccionId + ".gif";

    if (!File.Exists(Server.MapPath(Ruta)))
    {
      Ruta = "./images/Carcheck/TraccionNodisponible.gif";
    }

    return Ruta;
  }

  protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
  {
    GestorInspeccion.TerminarInspeccion(Convert.ToDecimal(vehiculoId));
    Response.Redirect("vListaInspeccion.aspx");
  }

  protected void frmLlanta_ItemInserted(object sender, FormViewInsertedEventArgs e)
  {
    //Response.Redirect(Request.RawUrl, true);
  }
  public bool showBeVisibleBtnAgregarLlanta()
  {   
    return IsEditable && GestorSeguridad.hasPermision(Funcionalidades.FI_LLANTA_ADD);
  }
}
