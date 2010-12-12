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
using AjaxPro;
using CCSOL.Utiles;
using CarCheck.Gestores;
using AjaxCanales.Utiles;
using System.IO;
using CCSOL.Utiles;

public partial class vSolicitud : System.Web.UI.Page
{
  public string cid = "";
  public string est = "";
  public int num = 1;
  private String contratante;
  private String contratanteId;
  private String contacto;
  private String contactoId;
  private UserData ud;
  public String solicitudId = "";

  private String numInspecciones = "0";



  #region CallBacks

  public EventControl callback_gridComunicacion = new EventControl();

  protected void Page_Init(object sender, EventArgs e)
  {
    callback_gridComunicacion.ScriptCallback += new EventControl.delScriptCallBack(cargar_gridComunicacion_ScriptCallback);
    this.AddParsedSubObject(callback_gridComunicacion);

    cckhandler.ScriptCallback += new EventControl.delScriptCallBack(cckhandler_ScriptCallback);
    this.AddParsedSubObject(cckhandler);
  }

  public string cargar_gridComunicacion_ScriptCallback(CallbackEventArgs eventArgument)
  {
    string inspeccionId = (string)eventArgument.Parameters[0];
    string datosCita;
    dsInspeccionesTableAdapters.ComunicacionInspeccionTableAdapter dsCom = new dsInspeccionesTableAdapters.ComunicacionInspeccionTableAdapter();
    this.comunicacionGridView.DataSource = dsCom.GetData(Convert.ToInt32(inspeccionId));
    this.comunicacionGridView.DataBind();
    datosCita = "<div><strong>" + Convert.ToString(dsCom.DatosCitaInspeccion(Convert.ToDecimal(inspeccionId))) + "</strong></div>";
    return "<div>" + datosCita + Utilidades.getHTML(this.comunicacionGridView) + "</div>";

  }

  #endregion

  protected void Page_Load(object sender, EventArgs e)
  {
    isValidRequest();
    AjaxPro.Utility.RegisterTypeForAjax(typeof(CarCheck.Gestores.GestorSolicitud));
    Utility.RegisterTypeForAjax(typeof(vSolicitud));

    evaluateActions();
    this.NewInspeccionDiv.Style.Add(HtmlTextWriterStyle.Display, "none");

  }

  private void isValidRequest()
  {
    try
    {
      solicitudId = Request.QueryString["SolicitudId"].ToString();
    }
    catch (Exception ex)
    {
      Response.Redirect("vLogIn.aspx", true);
    }


  }

  private void evaluateActions()
  {
    string action = Utilidades.isNull(Request.QueryString["action"], "nuevo");

    switch (action)
    {
      case "nuevo": doNewActions();
        break;
      case "editar": doEditActions();
        break;
      case "ver": doViewActions();
        break;
    }

  }

  private void doViewActions()
  {

  }

  private void doEditActions()
  {

  }

  private void doNewActions()
  {

  }


  private void blockDropDownListByCiaId()
  {
    ud = (UserData)Session["userData"];
    cid = ud.CiaId.ToString();
    if (cid != null)
    {
      Utilidades.SetSelectedValue((DropDownList)this.frmvCabeceraSolicitud.FindControl("cbxCliente"), cid);
      Utilidades.SetSelectedValue((DropDownList)this.frmvCabeceraSolicitud.FindControl("cbxAseguradora"), cid);
      Utilidades.SetSelectedValue((DropDownList)this.frmvCabeceraSolicitud.FindControl("cbxBroker"), cid);
    }
  }
  protected void frmvCabeceraSolicitud_DataBound(object sender, EventArgs e)
  {
    try
    {

      //forzamos la carga de la data en los formularios Contratante y Contacto
      frmvContratante.DataBind();
      frmvContacto.DataBind();

      //guardamos el estado de la solicitud.
      this.est = ((HiddenField)this.frmvCabeceraSolicitud.FindControl("hfEstadoSolicitud")).Value.ToString();

      //estos datos han sido obtenidos mediante el select del frmvCabeceraSolicitud
      //por eso es necesario asignar sus valores a los campos que por cuestión de diseño han sido colocados dentro  
      //de otros formviews
      Utilidades.setInternalValue("txtObservacion",
                                  Utilidades.getInternalValueFromForm(frmvCabeceraSolicitud, "txtObservacion"),
                                  frmvContratante);
      Utilidades.setInternalValueCheckBox("vipCheckBox",
                                  Utilidades.getInternalValueFromFormCheckBox(frmvCabeceraSolicitud, "chkClienteVIP"),
                                  frmvContratante);
      Utilidades.setInternalValue("txtNroVehiculos",
                                  Utilidades.getInternalValueFromForm(frmvCabeceraSolicitud, "txtNumVehiculos"),
                                  frmvContacto);


      //if (GestorSeguridad(ud,"solicitud_chooseOtherClients")
      blockDropDownListByCiaId();
    }
    catch (Exception ex)
    {

    }



  }
  protected void guardarImageButton_Click(object sender, ImageClickEventArgs e)
  {
    try
    {
      frmvContratante.UpdateItem(true);
      frmvContacto.UpdateItem(true);
      frmvCabeceraSolicitud.UpdateItem(true);
    }
    catch (Exception ex)
    {
      Exception exx = new Exception("Ocurrión un error al intentar grabar la solicitud, Revise la InnerException", ex);
      
      throw exx;
    }
    this.frmvCabeceraSolicitud.DataBind();
  }

  protected void odsContratante_Updated(object sender, ObjectDataSourceStatusEventArgs e)
  {
    decimal personaId;
    if (decimal.TryParse(e.OutputParameters["personaId"].ToString(), out personaId))
    {
      Utilidades.setInternalValue("txtContratanteId", personaId.ToString(), frmvCabeceraSolicitud);
    }
  }
  protected void odsContacto_Updated(object sender, ObjectDataSourceStatusEventArgs e)
  {
    decimal contactoId;
    if (decimal.TryParse(e.OutputParameters["contactoId"].ToString(), out contactoId))
    {
      Utilidades.setInternalValue("txtContactoId", contactoId.ToString(), frmvCabeceraSolicitud);
    }
  }

  #region ajaxMethods
  [AjaxMethod]
  public static DatosPersona performDataSearch(string personaId)
  {

    decimal personaId_decimal = -1;
    try
    {
      personaId_decimal = decimal.Parse(personaId);
    }
    catch (Exception ex)
    {
      personaId_decimal = -1;
    }
    DatosPersona p = GestorPersonas.performDataSearch(personaId_decimal);
    return p;
  }
  [AjaxMethod]
  public static Contacto performDataContacto(string contactoId)
  {

    decimal contactoId_decimal = -1;
    try
    {
      contactoId_decimal = decimal.Parse(contactoId);
    }
    catch (Exception ex)
    {
      contactoId_decimal = -1;
    }
    Contacto p = GestorPersonas.performDataContacto(contactoId_decimal);
    return p;
  }

  #endregion

  protected void odsContratante_Updating(object sender, ObjectDataSourceMethodEventArgs e)
  {
    Utilidades.setInternalValue("txtObservacion", Utilidades.getInternalValueFromForm(frmvContratante, "txtObservacion"), frmvCabeceraSolicitud);
    Utilidades.setInternalValueCheckBox("chkClienteVIP", Utilidades.getInternalValueFromFormCheckBox(frmvContratante, "vipCheckBox"), frmvCabeceraSolicitud);
  }
  protected void odsContacto_Updating(object sender, ObjectDataSourceMethodEventArgs e)
  {

    

    Utilidades.setInternalValue("txtNumVehiculos", Utilidades.getInternalValueFromForm(frmvContacto, "txtNroVehiculos"), frmvCabeceraSolicitud);
    //Utilidades.setInternalValue("txtNumVehiculos",this.numInspecciones, frmvCabeceraSolicitud);
  }
  protected void frmViewNewInspeccion_ItemInserted(object sender, FormViewInsertedEventArgs e)
  {
    if (e.Exception == null)
    {
      Response.Redirect(Request.RawUrl,true);
    }

  }
  protected void frmViewNewInspeccion_ItemInserting(object sender, FormViewInsertEventArgs e)
  {
    e.Values.Add("solicitudId", Request.QueryString["SolicitudId"]);
    e.Values.Add("ucrea", "SYSTEM");
    //
    DropDownList marca = (DropDownList)this.frmViewNewInspeccion.FindControl("cbxMarca");
    e.Values.Add("marcaVehiculo", marca.SelectedItem.Text);


    int anho;

    if (int.TryParse(Utilidades.getInternalValueFromForm(this.frmViewNewInspeccion, "anhoTextBox"), out anho))
    {
      DateTime d = new DateTime(anho, 1, 1);
      e.Values.Add("anhoFabricacion", d);
    }




  }
  protected void odsInspecciones_Selected(object sender, ObjectDataSourceStatusEventArgs e)
  {
    try
    {
      int numRows = ((System.Data.DataTable)e.ReturnValue).Rows.Count;
      if (numRows > 0)
      {
        this.newInspeccionHeader.Visible = false;
        //this.numInspecciones = numRows.ToString();
        Utilidades.setInternalValue("txtNroVehiculos",numRows.ToString(), frmvContacto);


      }

    }
    catch (Exception ex)
    {

    }
  }
  protected void odsSolicitud_Selected(object sender, ObjectDataSourceStatusEventArgs e)
  {
    if (((System.Data.DataTable)e.ReturnValue).Rows.Count > 0)
    {
      System.Data.DataRow d = ((System.Data.DataTable)e.ReturnValue).Rows[0];

      this.contratanteId = ((dsSolicitud.SolicitudCabeceraRow)(d)).contratanteId.ToString();
      this.contratante = ((dsSolicitud.SolicitudCabeceraRow)(d)).persona;

      this.contactoId = ((dsSolicitud.SolicitudCabeceraRow)(d)).contactoId.ToString();
      this.contacto = ((dsSolicitud.SolicitudCabeceraRow)(d)).contacto;

      this.putValuesToASBAsegurado(this.contratante, this.contratanteId);
      this.putValuesToASBContacto(this.contacto, this.contactoId);
    }
  }
  private void putValuesToASBAsegurado(String nombre, String id)
  {
    ASB.AutoSuggestBox asbAsegurado = this.frmViewNewInspeccion.FindControl("asbAsegurado") as ASB.AutoSuggestBox;

    if (asbAsegurado != null)
    {
      asbAsegurado.Text = nombre;
      asbAsegurado.SelectedValue = id;
    }

  }
  private void putValuesToASBContacto(String nombre, String id)
  {
    ASB.AutoSuggestBox asbContacto = this.frmViewNewInspeccion.FindControl("asbContacto") as ASB.AutoSuggestBox;

    if (asbContacto != null)
    {
      asbContacto.Text = nombre;
      asbContacto.SelectedValue = id;
    }

  }

  protected void nuevaInspeccionImageButton_Click(object sender, ImageClickEventArgs e)
  {
    this.frmViewNewInspeccion.InsertItem(true);
  }

  protected void inspeccionGridView_RowDataBound(object sender, GridViewRowEventArgs e)
  {
    if (e.Row.RowType == DataControlRowType.DataRow)
    {
      DataRowView AuxRow = (DataRowView)e.Row.DataItem;
      String url;
      String estadoInspeccion = AuxRow["estadoInspeccionId"].ToString();
      String strvehiculoId = AuxRow["vehiculoId"].ToString();

     
        
      e.Row.Attributes.Add("inspeccionId", AuxRow["inspeccionId"].ToString());
      e.Row.Attributes.Add("vehiculoId", strvehiculoId);
      e.Row.Attributes.Add("estado", estadoInspeccion);
      
      //e.Row.Attributes.Add("id", e.Row.ClientID);
      //e.Row.Attributes.Add("onMouseOver", "MouseOver('" + e.Row.ClientID + "');");
      //e.Row.Attributes.Add("onMouseOut", "MouseOut('" + e.Row.ClientID + "');");

      if (GestorSeguridad.hasPermision(ud, "EDITAR_INSPECCION_INSPECTOR"))
      {
        url = "vFIDatosPersonales.aspx?VehiculoId=" + strvehiculoId;
      }
      else if (GestorSeguridad.hasPermision(ud, "EDITAR_INSPECCION")
              && (estadoInspeccion.CompareTo("TERMINADA") == 0 ||
                  estadoInspeccion.CompareTo("APROBADA") == 0))
      {
        url = "vFIDatosPersonales.aspx?VehiculoId=" + strvehiculoId;
      }
      else if (!(GestorSeguridad.hasPermision(ud, "EDITAR_INSPECCION")
              && (estadoInspeccion.CompareTo("TERMINADA") == 0 ||
                  estadoInspeccion.CompareTo("APROBADA") == 0)) &&
              GestorSeguridad.hasPermision(ud, "EDITAR_AGENDA"))
      {
        url = "vAgenda.aspx?VehiculoID=" + strvehiculoId + "&accion=E";
      }
      else if (GestorSeguridad.hasPermision(ud, "VER_INSPECCION")
              && estadoInspeccion.CompareTo("TERMINADA") == 0)
      {
        url = "vFIDatosPersonales.aspx?VehiculoId=" + strvehiculoId;
      }
      else
      {
        url = "";
        this.btnGoTo.Visible = false;
      }
      e.Row.Attributes.Add("url", url);
    }
  }



  //aqui va el codigo de los anexos 

  #region CallBacksAnexos

  public EventControl cckhandler = new EventControl();

  /*
    protected void Page_Init(object sender, EventArgs e)
    {
      cckhandler.ScriptCallback += new EventControl.delScriptCallBack(cckhandler_ScriptCallback);
      this.AddParsedSubObject(cckhandler);
    }
  */

  public string cckhandler_ScriptCallback(CallbackEventArgs eventArgument)
  {
    this.DataList1.DataBind();
    return Utilidades.getHTML(this.DataList1);
  }
  #endregion

  #region AuxiliarMethods

  public string getAnexoUrl(object AnexoId)
  {
    return String.Format("vGetBinary.aspx?AnexoId={0}&SolicitudId={1}", Convert.ToString(AnexoId),Request.QueryString["SolicitudId"]);
  }
  public string getAnexoDeleteCommand(object AnexoId, object filename)
  {
    return String.Format("doDeleteFile({0},'{1}');return false;", Convert.ToString(AnexoId), Convert.ToString(filename));
  }

  #endregion
  
}
