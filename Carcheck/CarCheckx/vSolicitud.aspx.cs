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
using CarCheck;


public partial class vSolicitud : System.Web.UI.Page
{
  #region properties

  public int num = 1;
  private string contratante;
  private string contratanteId;
  private string contacto;
  private string contactoId;
  private UserData ud;
  private string estadoSolicitud;
  public string solicitudId = "";
  public string numrows = "0";
  public int numOfInspecciones = 0;
  public bool Inspeccion_couldDelete = false;
  public bool Inspeccion_couldAnular = false;
  public string showHeader = "none";
  public bool IsAnulada = false;

  #endregion

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
    return GestorInspeccion.getDatosCita(inspeccionId, this.comunicacionGridView);

  }

  #endregion

  #region CallBacksAnexos

  public EventControl cckhandler = new EventControl();

  public string cckhandler_ScriptCallback(CallbackEventArgs eventArgument)
  {
    this.DataList1.DataBind();
    return Utilidades.getHTML(this.DataList1);
  }
  #endregion

  #region ajaxMethods
  private void RegisterTypesForAjax()
  {
    AjaxPro.Utility.RegisterTypeForAjax(typeof(CarCheck.Gestores.GestorSolicitud));
    Utility.RegisterTypeForAjax(typeof(vSolicitud));
  }
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
      LoggerFacade.LogException(ex);
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
      LoggerFacade.LogException(ex);
    }
    Contacto p = GestorPersonas.performDataContacto(contactoId_decimal);
    return p;
  }

  #endregion

  #region MethodHandlers
  protected void frmvCabeceraSolicitud_DataBound(object sender, EventArgs e)
  {
    doSolicitudDataBound(e);
  }
  protected void guardarImageButton_Click(object sender, ImageClickEventArgs e)
  {
    performSave(true);
  }
  protected void odsContratante_Updated(object sender, ObjectDataSourceStatusEventArgs e)
  {
    doContratanteAfterUpdate(e);
  }
  protected void odsContacto_Updated(object sender, ObjectDataSourceStatusEventArgs e)
  {
    doContactoAfterUpdate(e);
  }
  protected void odsContratante_Updating(object sender, ObjectDataSourceMethodEventArgs e)
  {
    doContratanteBeforeUpdate(e);
  }
  protected void odsContacto_Updating(object sender, ObjectDataSourceMethodEventArgs e)
  {
    doContactoBeforeUpdated(e);
  }
  protected void frmViewNewInspeccion_ItemInserted(object sender, FormViewInsertedEventArgs e)
  {
    doInspeccionAfterInserted(e);

  }
  protected void frmViewNewInspeccion_ItemInserting(object sender, FormViewInsertEventArgs e)
  {
    doNewInspeccionBeforeInsert(e);
  }
  protected void odsInspecciones_Selected(object sender, ObjectDataSourceStatusEventArgs e)
  {
    doGridViewInspeccionAfterSelected(e);
  }
  protected void odsSolicitud_Selected(object sender, ObjectDataSourceStatusEventArgs e)
  {
    doSolicitudAfterSelected(e);
  }
  protected void nuevaInspeccionImageButton_Click(object sender, ImageClickEventArgs e)
  {
    this.performInspeccionSave();
  }
  protected void inspeccionGridView_RowDataBound(object sender, GridViewRowEventArgs e)
  {
    this.doActionsPerRow(e);
  }
  private void eliminarInspeccion(CommandEventArgs e)
  {
    performInspeccionDelete(e);
  }
  protected void ImageButton3_Command(object sender, CommandEventArgs e)
  {
    eliminarInspeccion(e);
  }
  protected void btnAnularSolicitud_Click(object sender, EventArgs e)
  {
    this.solicitudAnular();
  }
  protected void ImageButton4_Command(object sender, CommandEventArgs e)
  {
    eliminarInspeccion(e);
  }
  protected void imgBtnBorrarInspeccion_Click(object sender, ImageClickEventArgs e)
  {
    this.borrarSolicitud();
  }
  protected void enviarImageButton_Click(object sender, ImageClickEventArgs e)
  {
    performSend();
  }
  protected void Button1_Click(object sender, EventArgs e)
  {
    doInspeccionAnular(e);
  }


  protected void inspeccionGridView_RowUpdating(object sender, GridViewUpdateEventArgs e)
  {
    //LoggerFacade.LogException(e.)
  }
  protected void frmvCabeceraSolicitud_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
  {
    if (e.Exception != null)
    {
      LoggerFacade.LogException(e.Exception);
    }
  }
  protected void frmvContratante_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
  {
    if (e.Exception != null)
    {
      LoggerFacade.LogException(e.Exception);
    }
  }
  protected void frmvContacto_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
  {
    if (e.Exception != null)
    {
      LoggerFacade.LogException(e.Exception);
    }
  }
  protected void odsSolicitud_Updated(object sender, ObjectDataSourceStatusEventArgs e)
  {
    if (e.Exception != null)
    {
      LoggerFacade.LogException(e.Exception);
    }
  }
  protected void agendarImageButton_Click(object sender, ImageClickEventArgs e)
  {
    beforeShowTheAgenda();
  }
  #endregion

  #region AuxiliarMethods
  private void blockDropDownListByCiaId()
  {
    ud = GestorSeguridad.getUserData();
    if (ud != null)
    {
      string cid = ud.CiaId.ToString();
      if (cid != null)
      {
        if (!GestorSeguridad.hasPermision(Funcionalidades.SOLICITUD_REG_ALL_CLIENTS))
        {
          Utilidades.SetSelectedValue((DropDownList)this.frmvCabeceraSolicitud.FindControl("cbxCliente"), cid);
        }
        if (!GestorSeguridad.hasPermision(Funcionalidades.SOLICITUD_REG_ALL_ASEGURADORAS))
        {
          Utilidades.SetSelectedValue((DropDownList)this.frmvCabeceraSolicitud.FindControl("cbxAseguradora"), cid);
        }
        if (!GestorSeguridad.hasPermision(Funcionalidades.SOLICITUD_REG_ALL_BROKERS) && (GestorPersonas.IsBroker(Convert.ToInt32(ud.CiaId), CarCheck.Gestores.GestorPersonas.TipoPersona.Broker)))
        {
          /*Utilidades.SetSelectedValue((DropDownList)this.frmvCabeceraSolicitud.FindControl("cbxBroker"), cid);*/

          Utilidades.setValuesForASB((ASB.AutoSuggestBox)this.frmvCabeceraSolicitud.FindControl("asbBroker"), ud.CiaId, ud.CiaName);
          ((ASB.AutoSuggestBox)this.frmvCabeceraSolicitud.FindControl("asbBroker")).ReadOnly = true;
          ((ASB.AutoSuggestBox)this.frmvCabeceraSolicitud.FindControl("asbBroker")).CssClass = "FormText readOnly";
        }
      }
    }
  }
  public string getIsAnulada()
  {
    bool showBlockHeader = false;
    if (!IsAnulada)
    {
      if (estadoSolicitud == EstadoSolicitud.REGISTRADA || estadoSolicitud == EstadoSolicitud.EN_ATENCION)
      {
        showBlockHeader = false;
      }
      else
      {
        showBlockHeader = !(GestorSeguridad.hasPermision(Funcionalidades.SOLICITUD_SAVE_EVEN_WHEN_IS_ALREADY_SENT));
      }
    }
    else
    {
      showBlockHeader = (IsAnulada);
    }
    //&& (
    return showBlockHeader.ToString().ToLower();
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

  public string isNotAnuladaAndAtLeastOneRow()
  {
    bool aBoolValue = (numOfInspecciones > 0) && (this.estadoSolicitud != EstadoSolicitud.ANULADA);
    return aBoolValue.ToString().ToLower();
  }
  public string getAnexoUrl(object AnexoId)
  {
    return String.Format("vGetBinary.aspx?AnexoId={0}&SolicitudId={1}", Convert.ToString(AnexoId), Request.QueryString["SolicitudId"]);
  }
  public string getAnexoDeleteCommand(object AnexoId, object filename)
  {
    return String.Format("doDeleteFile({0},'{1}');return false;", Convert.ToString(AnexoId), Convert.ToString(filename));
  }
  public Boolean evaluateShowProperty(object estadoInspeccionId)
  {
    //si no puede Borrar, porque no tiene el permiso ya no importa el estado de la Inspección
    if (!this.Inspeccion_couldDelete) return false;

    String estadoInspeccion_str = Convert.ToString(estadoInspeccionId);
    //SI LA INSPECCIÓN ESTÁ EN ESTADO PENDIENTE O REGISTRADA, NO PROCEDE LA ANULACIÓN SINO LA ELIMINACIÓN O BORRADO
    //bool couldBeDeleateable = (estadoInspeccion_str == EstadoInspeccion.PENDIENTE) || (estadoInspeccion_str == EstadoInspeccion.REGISTRADA);
    if ((estadoInspeccion_str == EstadoInspeccion.REGISTRADA)) return true;
    if (estadoInspeccion_str == EstadoInspeccion.PENDIENTE)
    {
      return GestorSeguridad.hasPermision(Funcionalidades.INSPECCION_BORRAR_EVEN_WHEN_IS_PENDENT);
    }
    else
    {
      return false;
    }

  }
  public Boolean evaluateShowPropertyAnular(object estadoInspeccionId)
  {
    //si no puede Anular, porque no tiene el permiso ya no importa el estado de la Inspección
    if (!this.Inspeccion_couldAnular) return false;

    String estadoInspeccion_str = Convert.ToString(estadoInspeccionId);
    //SI LA INSPECCIÓN NO ESTÁ EN ESTADO REGISTRADA, PENDIENTE, NI ANULADA YA LO QUE PROCEDE ENTONCES ES LA ANULACIÓN DE LA INSPECCIÓN
    return (estadoInspeccion_str != EstadoInspeccion.PENDIENTE) && (estadoInspeccion_str != EstadoInspeccion.ANULADA) && (estadoInspeccion_str != EstadoInspeccion.REGISTRADA) && GestorSeguridad.hasPermision(Funcionalidades.INSPECCION_ANULAR_EVEN_WHEN_IS_BEEN_ATTENDED);
  }

  public Boolean shouldBeVisibleBtnEnviar()
  {
    return Convert.ToInt32(this.numrows) > 0 && (this.estadoSolicitud == EstadoSolicitud.REGISTRADA);
  }

  public Boolean EstadoSolicitudIsNotAnulada()
  {
    return !IsAnulada;//EstadoSolicitud.ANULADA != this.estadoSolicitud;
  }

  //esta función se llama desde un DataBind en el Botón mismo en el markup de esta página
  public Boolean shouldBeVisibleNuevaInspeccion()
  {
    if (GestorSeguridad.hasPermision(Funcionalidades.INSPECCION_ADD_NEW_EVEN_WHEN_IS_ALREADY_SENT))
    {
      return (!GestorSolicitud.solicitudCerrada(Convert.ToDecimal(this.solicitudId))) && (estadoSolicitud != EstadoSolicitud.ANULADA) && (estadoSolicitud != EstadoSolicitud.ATENDIDA_COMPLETAMENTE);
    }
    else
    {
      return (!GestorSolicitud.solicitudCerrada(Convert.ToDecimal(this.solicitudId))) && (estadoSolicitud == EstadoSolicitud.REGISTRADA);
    }
  }

  #endregion

  #region Initializations
  protected void Page_Load(object sender, EventArgs e)
  {
    isValidRequest();

    RegisterTypesForAjax();

    whatUserCouldDo();
  }

  private void whatUserCouldDo()
  {
    //obtenemos el estado de la solicitud. Nos sirve para verificar que cosas son posibles hacer por cada estado
    estadoSolicitud = GestorSolicitud.getEstadoSolicitud(Convert.ToDecimal(solicitudId));

    //Averiguamos si la solicitud está anulada
    IsAnulada = estadoSolicitud == EstadoSolicitud.ANULADA;


    //Mostramos un mensaje que nos indica que la solicitud fue anulada.
    this.divIsAnulada.Visible = IsAnulada;

    //inicialmente asumimos que el botón no se debe mostrar
    //solo se mostrará cuando hayan inspecciones en estado Pendiente o Registrada, esto se verificará mientras se carga la grilla.
    this.agendarImageButton.Visible = false;

    this.Inspeccion_couldDelete = GestorSeguridad.hasPermision(Funcionalidades.INSPECCION_BORRAR);
    this.Inspeccion_couldAnular = GestorSeguridad.hasPermision(Funcionalidades.INSPECCION_ANULAR);

    //this.frmvCabeceraSolicitud.DataBind();

    this.inspeccionGridView.DataBind();


    this.imgBtnBorrarInspeccion.Visible = estadoSolicitud == EstadoSolicitud.REGISTRADA;
    this.enviarImageButton.Visible = shouldBeVisibleBtnEnviar();

    //Los datos de la solicitud de Inspección solo pueden ser modificados cuando la solicitud está registrada o la solicitud está recién en atención.

    if (GestorSeguridad.hasPermision(Funcionalidades.SOLICITUD_SAVE_EVEN_WHEN_IS_ALREADY_SENT))
    {
      this.guardarImageButton.Visible = (estadoSolicitud == EstadoSolicitud.REGISTRADA || estadoSolicitud == EstadoSolicitud.EN_ATENCION) && (!GestorSolicitud.solicitudCerrada(Convert.ToDecimal(solicitudId)));
    }
    else
    {
      this.guardarImageButton.Visible = (estadoSolicitud == EstadoSolicitud.REGISTRADA) && (!GestorSolicitud.solicitudCerrada(Convert.ToDecimal(solicitudId)));
    }

    this.notificarImageButton.Visible = !IsAnulada;


    //EstadoSolicitud.ANULADA != estadoSolicitud;

    //asumimos que el formulario debe estar siempre oculto primero
    this.NewInspeccionDiv.Style.Add(HtmlTextWriterStyle.Display, "none");

    this.enviarImageButton.DataBind();
    this.nuevaInspeccionImageButton.DataBind();



  }

  private void isValidRequest()
  {
    try
    {
      solicitudId = Request.QueryString["SolicitudId"].ToString();
    }
    catch (Exception ex)
    {
      LoggerFacade.LogException(ex);
      Response.Redirect("vListaSolicitud.aspx", true);
    }


  }
  #endregion

  #region GrabarEnviarSolicitud
  private void performSave()
  {
    try
    {
      frmvContratante.UpdateItem(true);
      frmvContacto.UpdateItem(true);
      frmvCabeceraSolicitud.UpdateItem(true);
      //solo si la solicitud está en estado REGISTRADA PUEDE PASAR A ESTADO EN ATENCIÓN.

      if (estadoSolicitud == EstadoSolicitud.REGISTRADA && (numOfInspecciones > 0) && GestorSeguridad.hasPermision(Funcionalidades.SAVE_CHANGES_SOLICITUD_STATE))
      {
        GestorSolicitud.setEstadoSolicitud(Convert.ToDecimal(this.solicitudId), EstadoSolicitud.EN_ATENCION);
      }
      MarkAsPendientes();

    }
    catch (Exception ex)
    {
      Exception exx = new Exception("Ocurrión un error al intentar grabar la solicitud, Revise la InnerException", ex);
      LoggerFacade.LogException(exx);
    }
    this.frmvCabeceraSolicitud.DataBind();
    this.GridInspecciones.DataBind();
    //if (doUpdate) Response.Redirect(Request.RawUrl, true);
  }
  private void performSave(bool doUpdate)
  {
    try
    {
      frmvContratante.UpdateItem(true);
      frmvContacto.UpdateItem(true);
      frmvCabeceraSolicitud.UpdateItem(true);
      //solo si la solicitud está en estado REGISTRADA PUEDE PASAR A ESTADO EN ATENCIÓN.

      if (doUpdate)
      {
        if (estadoSolicitud == EstadoSolicitud.REGISTRADA && (numOfInspecciones > 0) && GestorSeguridad.hasPermision(Funcionalidades.SAVE_CHANGES_SOLICITUD_STATE))
        {
          GestorSolicitud.setEstadoSolicitud(Convert.ToDecimal(this.solicitudId), EstadoSolicitud.EN_ATENCION);
        }
        MarkAsPendientes();
      }
    }
    catch (Exception ex)
    {
      Exception exx = new Exception("Ocurrión un error al intentar grabar la solicitud, Revise la InnerException", ex);
      LoggerFacade.LogException(exx);
    }
    //this.frmvCabeceraSolicitud.DataBind();
    if (doUpdate) Response.Redirect(Request.RawUrl, true);
  }

  private void MarkAsPendientes()
  {
    if (GestorSeguridad.hasPermision(Funcionalidades.INSPECCION_CREATE_AS_PENDENT))
    {
      foreach (GridViewRow row in this.inspeccionGridView.Rows)
      {
        decimal? inspeccionId = (decimal?)Convert.ToDecimal((row.Cells[0].Text));
        decimal? solicitudId = (decimal?)Convert.ToDecimal(row.Cells[2].Text);
        string estadoInspeccionId = Convert.ToString(row.Cells[1].Text);
        if (EstadoInspeccion.REGISTRADA == estadoInspeccionId) // solo si está en estado Registrada podrá pasarse al siguiente estado
        {
          GestorInspeccion.setEstadoInspeccion(inspeccionId,
            EstadoInspeccion.PENDIENTE,
            solicitudId,
            EstadoInspeccion.Motivo.CAMBIO_AUTOMATICO_DE_ESTADO,
            SettingManager.MSG_AUTOMATIC_STATE_CHANGE,
            Session["userName"].ToString());
        }
      }
    }
  }
  private void performSend()
  {
    try
    {
      if (GestorSeguridad.hasPermision(Funcionalidades.SOLICITUD_ENVIAR))
      {
        //Enviar la solicitud pone la solicitud de Registrada a Atendida Parcialmente, una vez que se ha enviado, ya no hay marcha atrás
        GestorSolicitud.EnviaSolicitud(this.solicitudId);

        //PasaLasInspeccionesAlEstado(EstadoInspeccion.PENDIENTE);
        foreach (GridViewRow row in this.inspeccionGridView.Rows)
        {
          decimal? inspeccionId = (decimal?)Convert.ToDecimal((row.Cells[0].Text));
          decimal? solicitudId = (decimal?)Convert.ToDecimal(row.Cells[2].Text);
          string estadoInspeccionId = Convert.ToString(row.Cells[1].Text);
          if (EstadoInspeccion.REGISTRADA == estadoInspeccionId) // solo si está en estado Registrada podrá pasarse al siguiente estado
          {
            GestorInspeccion.setEstadoInspeccion(inspeccionId,
              EstadoInspeccion.PENDIENTE,
              solicitudId
             );
          }
        }
        Response.Redirect("vListaSolicitud.aspx", true);
      }
    }
    catch (Exception ex)
    {
      LoggerFacade.LogException(ex);
    }
  }
  #endregion

  #region Contacto

  private void doContactoAfterUpdate(ObjectDataSourceStatusEventArgs e)
  {
    decimal contactoId;
    if (decimal.TryParse(e.OutputParameters["contactoId"].ToString(), out contactoId))
    {
      Utilidades.setInternalValue("txtContactoId", contactoId.ToString(), frmvCabeceraSolicitud);
    }
  }
  private void doContactoBeforeUpdated(ObjectDataSourceMethodEventArgs e)
  {
    Utilidades.setInternalValue("txtNumVehiculos", Utilidades.getInternalValueFromForm(frmvContacto, "txtNroVehiculos"), frmvCabeceraSolicitud);
    //Utilidades.setInternalValue("txtNumVehiculos",this.numInspecciones, frmvCabeceraSolicitud);
  }

  #endregion

  #region Contratante
  private void doContratanteAfterUpdate(ObjectDataSourceStatusEventArgs e)
  {
    decimal personaId;
    if (decimal.TryParse(e.OutputParameters["personaId"].ToString(), out personaId))
    {
      Utilidades.setInternalValue("txtContratanteId", personaId.ToString(), frmvCabeceraSolicitud);
    }
  }
  private void doContratanteBeforeUpdate(ObjectDataSourceMethodEventArgs e)
  {
    Utilidades.setInternalValue("txtObservacion", Utilidades.getInternalValueFromForm(frmvContratante, "txtObservacion"), frmvCabeceraSolicitud);
    Utilidades.setInternalValueCheckBox("chkClienteVIP", Utilidades.getInternalValueFromFormCheckBox(frmvContratante, "vipCheckBox"), frmvCabeceraSolicitud);

  }

  #endregion

  #region NewInspeccion

  private void performInspeccionSave()
  {
    this.frmViewNewInspeccion.InsertItem(true);
  }
  private void doInspeccionAfterInserted(FormViewInsertedEventArgs e)
  {
    if (e.Exception == null)
    {
      /*performSave();*/
      Response.Redirect(Request.RawUrl, true);
      //this.inspeccionGridView.DataBind();
    }
  }
  private void doNewInspeccionBeforeInsert(FormViewInsertEventArgs e)
  {
    if ((estadoSolicitud == EstadoSolicitud.REGISTRADA || estadoSolicitud == EstadoSolicitud.EN_ATENCION)) performSave(false);

    e.Values.Add("solicitudId", Request.QueryString["SolicitudId"]);
    e.Values.Add("ucrea", Session["userName"]);

    int anho;

    string anho_str = Utilidades.getInternalValueFromForm(this.frmViewNewInspeccion, "anhoTextBox");
    if (!String.IsNullOrEmpty(anho_str))
    {
      if (int.TryParse(anho_str, out anho))
      {
        if ((anho > 1900) && (anho < 2100))
        {
          DateTime d = new DateTime(anho, 1, 1);
          e.Values.Add("anhoFabricacion", d);
        }
        else
        {
          e.Cancel = true;
        }
      }
      else
      {
        e.Cancel = true;
        this.Page.ClientScript.RegisterStartupScript(this.GetType(), "alerta", "alert('el año de creación debe estar en el formato YYYY, por ejemplo: 2000');", true);
      }
    }
    else
    {
      e.Values.Add("anhoFabricacion", "");
    }
  }
  #endregion

  #region AnularBorrarInspeccion
  private void performInspeccionDelete(CommandEventArgs e)
  {
    int inspeccionId = -1;
    try
    {
      inspeccionId = Convert.ToInt32(e.CommandArgument);
      if (inspeccionId != -1)
      {
        Boolean borrado = GestorInspeccion.DeleteInspeccion(inspeccionId);
        if (!borrado)
        {
          this.Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "maviso", "alert('Una INSPECCIÓN solo puede borrarse si está en estado PENDIENTE o REGISTRADA')", true);
        }
        else
        {
          //solo se considera qeu se puede guardar los datos de la solicitud si el estado es.. 
          if ((estadoSolicitud == EstadoSolicitud.REGISTRADA || estadoSolicitud == EstadoSolicitud.EN_ATENCION)) performSave(false);
          //this.GridInspecciones.DataBind();
          Response.Redirect(Request.RawUrl, true);
        }
      }
    }
    catch (Exception ex)
    {
      LoggerFacade.LogException(ex);
    }
  }

  private void doInspeccionAnular(EventArgs e)
  {
    try
    {
      decimal? inspeccionId = Convert.ToDecimal(this.txtInspeccionId.Text);
      decimal? solicitudId = Convert.ToDecimal(this.txtSolicitudId.Text);
      decimal? motivoId = Convert.ToDecimal(this.cbxMotivo.SelectedItem.Value);

      GestorInspeccion.AnularInspeccion(inspeccionId, solicitudId, motivoId, this.txtObservacionAnulacionInspeccion.Text, Session["userName"].ToString());

      if ((estadoSolicitud == EstadoSolicitud.REGISTRADA || estadoSolicitud == EstadoSolicitud.EN_ATENCION)) performSave(false);
      //this.GridInspecciones.DataBind();
      Response.Redirect(Request.RawUrl, true);
    }
    catch (Exception ex)
    {
      LoggerFacade.LogException(ex);
    }
  }

  #endregion

  #region AnularBorrarSolicitud
  private void PasaLasInspeccionesAlEstado(string estadoInspeccion)
  {
    foreach (GridViewRow row in this.inspeccionGridView.Rows)
    {
      decimal? inspeccionId = (decimal?)Convert.ToDecimal((row.Cells[0].Text));
      decimal? solicitudId = (decimal?)Convert.ToDecimal(row.Cells[2].Text);
      string estadoInspeccionId = Convert.ToString(row.Cells[1].Text);
      GestorInspeccion.setEstadoInspeccion(inspeccionId,
        estadoInspeccion,
        solicitudId
       );

    }
  }
  private void solicitudAnular()
  {
    try
    {
      //TODO: Verificar si en este punto sería más conveniente pasar toda esta lógica a un stored Procedure
      // las ventajas de bajar esto a un Stored Procedure serían:
      // 1. Ahorro de tiempo (solo viaja un parametro, la solicitudId)
      // 2. Se encapsula todo en una transacción. Implementar las transacciones en el Stored Procedure es más sencillo que con los tableAdapters
      GestorSolicitud.Anular(Convert.ToDecimal(this.solicitudId), this.cbxMotivoAnulacion.SelectedItem.Value, this.txtAnularObservacion.Text);
      PasaLasInspeccionesAlEstado(EstadoInspeccion.ANULADA);
      Response.Redirect("vListaSolicitud.aspx", true);
    }
    catch (Exception ex)
    {
      LoggerFacade.LogException(ex);
    }
  }

  private void borrarSolicitud()
  {
    try
    {
      //TODO: Verificar si en este punto sería más conveniente pasar toda esta lógica a un stored Procedure
      // las ventajas de bajar esto a un Stored Procedure serían:
      // 1. Ahorro de tiempo (solo viaja un parametro, la solicitudId)
      // 2. Se encapsula todo en una transacción. Implementar las transacciones en el Stored Procedure es más sencillo que con los tableAdapters
      GestorSolicitud.Borrar(Convert.ToDecimal(this.solicitudId));//, this.cbxMotivoAnulacion.SelectedItem.Value, this.txtAnularObservacion.Text);
      BorrarLasInspecciones();

      Response.Redirect("vListaSolicitud.aspx", true);

    }
    catch (Exception ex)
    {
      LoggerFacade.LogException(ex);
    }
  }

  private void BorrarLasInspecciones()
  {
    foreach (GridViewRow row in this.inspeccionGridView.Rows)
    {
      int inspeccionId = Convert.ToInt32((row.Cells[0].Text));
      decimal? solicitudId = (decimal?)Convert.ToDecimal(row.Cells[2].Text);
      string estadoInspeccionId = Convert.ToString(row.Cells[1].Text);

      GestorInspeccion.DeleteInspeccion(inspeccionId);
    }
  }
  #endregion

  #region AfterSelectOrDataBoundsMethods
  private void doGridViewInspeccionAfterSelected(ObjectDataSourceStatusEventArgs e)
  {
    try
    {
      int numRows = ((System.Data.DataTable)e.ReturnValue).Rows.Count;
      if (numRows > 0)
      {
        Utilidades.setInternalValue("txtNroVehiculos", numRows.ToString(), frmvContacto);
        this.numrows = numRows.ToString();
        numOfInspecciones = numRows;

      }
      else
      {
        this.inspeccionGridView.Attributes.Add("style", "border:none;");
        this.showHeader = "block";

      }
      this.enviarImageButton.Visible = numRows > 0;

    }
    catch (Exception ex)
    {
      LoggerFacade.LogException(ex);

    }
  }

  private void setAnularSolicitudVisible()
  {
    bool UserHasCreatedThisSolicitud = Utilidades.getInternalValueFromForm(frmvCabeceraSolicitud, "txtUsuario") == GestorSeguridad.getUserData().UserName;

    if (GestorSeguridad.hasPermision(Funcionalidades.SOLICITUD_ANULAR_EVEN_WHEN_IS_ALREADY_SENT))
    {
      this.anularImageButton.Visible = !IsAnulada;
    }
    else
    {
      this.anularImageButton.Visible = !IsAnulada && ((estadoSolicitud == EstadoSolicitud.REGISTRADA) || (estadoSolicitud == EstadoSolicitud.EN_ATENCION));
    }

    if (!GestorSeguridad.hasPermision(Funcionalidades.SOLICITUD_ANULAR_EVEN_IT_HAS_BEEN_REGISTERED_BY_DIFFERENT_USER))
    {
      this.anularImageButton.Visible = this.anularImageButton.Visible && UserHasCreatedThisSolicitud;
    }
  }

  private void doSolicitudAfterSelected(ObjectDataSourceStatusEventArgs e)
  {
    if (((System.Data.DataTable)e.ReturnValue).Rows.Count > 0)
    {
      System.Data.DataRow d = ((System.Data.DataTable)e.ReturnValue).Rows[0];

      this.contratanteId = ((dsSolicitud.SolicitudCabeceraRow)(d)).contratanteId.ToString();
      this.contratante = ((dsSolicitud.SolicitudCabeceraRow)(d)).persona;

      this.contactoId = ((dsSolicitud.SolicitudCabeceraRow)(d)).contactoId.ToString();
      this.contacto = ((dsSolicitud.SolicitudCabeceraRow)(d)).contacto;

      setAnularSolicitudVisible();

      this.putValuesToASBAsegurado(this.contratante, this.contratanteId);
      this.putValuesToASBContacto(this.contacto, this.contactoId);
    }
  }

  private void doSolicitudDataBound(EventArgs e)
  {
    try
    {
      //forzamos la carga de la data en los formularios Contratante y Contacto
      frmvContratante.DataBind();
      frmvContacto.DataBind();

      //guardamos el estado de la solicitud.
      //this.estadoSolicitud = ((HiddenField)this.frmvCabeceraSolicitud.FindControl("hfEstadoSolicitud")).Value.ToString();

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
      blockDropDownListByCiaId();

      //copyActualValueFromDropDownsToAutoCompletionText();

      //this.txtPickAseguradora.Text = Utilidades.getInternalTextFromDropDownList(frmvCabeceraSolicitud, "cbxAseguradora");
      /*this.txtPickBroker.Text = Utilidades.getInternalTextFromDropDownList(frmvCabeceraSolicitud, "cbxBroker");*/
      //this.txtPickCliente.Text = Utilidades.getInternalTextFromDropDownList(frmvCabeceraSolicitud, "cbxCliente");


    }
    catch (Exception ex)
    {
      LoggerFacade.LogException(ex);
    }

  }

  private bool IsOrActsLikeAnInspector()
  {
    //sin importar que estado tuviera el inspector siempre debe ir a las fichas de Inspección
    return GestorSeguridad.hasPermision(Funcionalidades.INSPECCION_EDITAR_INSPECTOR);
  }
  private bool IsOrActsLikeAClient(DataRowView AuxRow, String estadoInspeccion)
  {
    return GestorSeguridad.hasPermision(Funcionalidades.INSPECCION_VER) &&
           GestorInspeccion.InspeccionIsAprobada(AuxRow["inspeccionId"].ToString());
  }
  private bool IsOrActsLikeACoordinador(DataRowView AuxRow, String estadoInspeccion)
  {
    return (GestorSeguridad.hasPermision(Funcionalidades.INSPECCION_PROGRAMAR_CITA) &&
            !GestorInspeccion.InspeccionIsAprobada(AuxRow["inspeccionId"].ToString())
           );
  }
  private void setButtonGoUrl(GridViewRowEventArgs e, DataRowView AuxRow, String estadoInspeccion, String strvehiculoId)
  {
    String url;

    if (IsOrActsLikeAnInspector())
    {
      url = "vFIDatosPersonales.aspx?VehiculoId=" + strvehiculoId;
    }
    else
      if (IsOrActsLikeAClient(AuxRow, estadoInspeccion))
      {
        url = "vFIDatosPersonales.aspx?VehiculoId=" + strvehiculoId;
      }
      else
        if (IsOrActsLikeACoordinador(AuxRow, estadoInspeccion))
        {
          url = "vAgenda.aspx?SolicitudId=" + solicitudId + "&action=sASol";
          e.Row.Attributes.Add("action", "agendar");
        }
        else
        {
          url = "";
          this.btnGoTo.Visible = false;
        }

    e.Row.Attributes.Add("url", url);
  }
  private void doActionsPerRow(GridViewRowEventArgs e)
  {
    if (e.Row.RowType == DataControlRowType.DataRow)
    {
      DataRowView AuxRow = (DataRowView)e.Row.DataItem;
      String estadoInspeccion = AuxRow["estadoInspeccionId"].ToString();
      String strvehiculoId = AuxRow["vehiculoId"].ToString();
      bool doShowReport = (estadoInspeccion == EstadoInspeccion.TERMINADA) && (GestorInspeccion.InspeccionIsAprobada(AuxRow["inspeccionId"].ToString()));

      e.Row.Attributes.Add("inspeccionId", AuxRow["inspeccionId"].ToString());
      e.Row.Attributes.Add("vehiculoId", strvehiculoId);
      e.Row.Attributes.Add("estado", estadoInspeccion);
      e.Row.Attributes.Add("showReport", doShowReport.ToString().ToLower());
      e.Row.Attributes.Add("numAmpliatorios",AuxRow["numAmpliatorios"].ToString());

      if (estadoInspeccion == EstadoInspeccion.PENDIENTE || estadoInspeccion == EstadoInspeccion.REGISTRADA || GestorSeguridad.hasPermision("SHOW_AGENDA_EVEN_WHEN_ALL_INSPECTIONS_ARE_COORDINATED"))
      {
        this.agendarImageButton.Visible = true;
      }

      setButtonGoUrl(e, AuxRow, estadoInspeccion, strvehiculoId);
    }
    //el botón de agendar debe estar visible, si no está anulada la solicitud, y si el botón está visible luego de revisar los estados de las inspecciones 
    this.agendarImageButton.Visible = !IsAnulada && this.agendarImageButton.Visible;
  }

  #endregion

  #region AgendaTrigger

  private void beforeShowTheAgenda()
  {
    if (!IsAnulada)
    {
      this.performSave();
      //this.Page.ClientScript.re  
      if (!this.Page.ClientScript.IsStartupScriptRegistered("AgendaShow"))
      {
        this.Page.ClientScript.RegisterStartupScript(this.GetType(), "AgendaShow", "xAddEventListener(window,'load',_verAgenda,false);", true);
      }
    }
  }
  #endregion

}
