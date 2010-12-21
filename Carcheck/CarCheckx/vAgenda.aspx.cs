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
using System.Collections.Generic;
using CCSOL.Utiles;
using CarCheck.Gestores;


public partial class vAgenda : System.Web.UI.Page
{
  private string createWindow = "false";
  public string solicitudId = "";

  public int num = 0;

  #region CallBacks
  public EventControl cckhandler = new EventControl();
  public EventControl cckhandler_gridInspeccion = new EventControl();


  protected void Page_Init(object sender, EventArgs e)
  {
    cckhandler.ScriptCallback += new EventControl.delScriptCallBack(cckhandler_ScriptCallback);
    cckhandler_gridInspeccion.ScriptCallback += new EventControl.delScriptCallBack(cckhandler_gridInspeccion_ScriptCallback);

    this.AddParsedSubObject(cckhandler);
    this.AddParsedSubObject(cckhandler_gridInspeccion);
  }

  //public string cckhandler_doSave_ScriptCallback(CallbackEventArgs eventArgument)
  //{
  //  /*int index = this.GridView1.EditIndex;
  //  this.GridView1.UpdateRow(this.GridView1.EditIndex, false);*/
  //  this.GridView1.EditIndex = -1;
  //  this.GridView1.DataBind();
  //  return CCSOL.Utiles.Utilidades.getHTML(this.GridView1);
  //}

  public string cckhandler_gridInspeccion_ScriptCallback(CallbackEventArgs eventArgument)
  {
    //this.GridView1.EditIndex = Convert.ToInt16(eventArgument.Parameters[0]);
    char[] splitter = { '$' };

    string[] parms = Convert.ToString(eventArgument.Parameters[0]).Split(splitter);
    string action = parms[0];
    try
    {
      if (action == "Edit")
      {
        this.GridView1.EditIndex = Convert.ToInt32(parms[1]);
      }
      if (action == "Update")
      {
        this.GridView1.UpdateRow(Convert.ToInt32(parms[1]), true);
      }
      if (action == "Cancel")
      {
        this.GridView1.EditIndex = -1;
      }
    }
    catch (Exception ex)
    {
      LoggerFacade.LogException(ex);
    }


    this.GridView1.DataBind();
    string result = CCSOL.Utiles.Utilidades.getHTML(this.GridView1);


    //result = result.Replace("<link href='./Scripts/asb_includes/AutoSuggestBox.css' type='text/css' rel='stylesheet'>", "");
    //result = result.Replace("<script type='text/javascript' language='JavaScript' src='./Scripts/asb_includes/AutoSuggestBox.js'></script>","");

    if (action == "Edit")
    {
      return result + "$$$$_$$$$" + this.GridView1.Rows[Convert.ToInt32(parms[1])].ClientID;
    }
    else
    {
      return result;
    }
  }

  public string cckhandler_ScriptCallback(CallbackEventArgs eventArgument)
  {
    string action = eventArgument.Parameters[0].ToString();
    if (action == "yesterday")
    {
      this.wccDateToShow.Text = Convert.ToDateTime(this.wccDateToShow.Text).AddDays(-1).ToShortDateString();
    }
    if (action == "tomorrow")
    {
      this.wccDateToShow.Text = Convert.ToDateTime(this.wccDateToShow.Text).AddDays(1).ToShortDateString();
    }
    DateTime d;
    if (DateTime.TryParse(this.wccDateToShow.Text, out d))
    {
      this.Schedule1.TimeScaleInterval = Convert.ToInt32(this.cbxIntervalo.SelectedValue);
      this.odsAgenda.SelectParameters.Clear();
      this.odsAgenda.SelectParameters.Add("inspectorId", this.asbInspectores.SelectedValue);
      this.odsAgenda.SelectParameters.Add("fecha", TypeCode.DateTime, d.ToString());
    }

    this.odsAgenda.DataBind();
    this.Schedule1.DataBind();

    return CCSOL.Utiles.Utilidades.getHTML(this.Schedule1) + "$$$$_$$$$" + "Agenda del Día " + d.ToLongDateString() + "$$$$_$$$$" + d.ToShortDateString();
  }

  #endregion

  protected void Page_Load(object sender, EventArgs e)
  {
    solicitudId = Utilidades.isNull(Request.QueryString["SolicitudId"], "-1");
    processAction();
  }

  public void processAction()
  {
    String action = CCSOL.Utiles.Utilidades.isNull(Request.QueryString["action"], "showAgenda");
    switch (action)
    {
      case "showAgenda": doShowAgenda();
        break;
      case "sASol": doShowAgendaForSolicitud(); //ShowAgendaForSolicitud
        break;
      default: doShowAgenda();
        break;
    }

  }

  private void doShowAgendaForSolicitud()
  {
    if (!IsPostBack)
    {
      this.inspecionesPanel.Style.Value = "display:block";
      
      this.agendaLabel.Text = "Agenda del Día " + DateTime.Today.ToLongDateString();
      this.asbInspectores.Text = "- TODOS -";
      this.asbInspectores.SelectedValue = "-1";

      this.wccDateToShow.Text = DateTime.Today.ToShortDateString();
      this.GridView1.DataBind();
    }
    this.createWindow = GestorSeguridad.hasPermision(Funcionalidades.AGENDA_REGISTRAR_CITA_COMUNICACION).ToString().ToLower();
  }

  public string shouldCreateWindow()
  {
    return createWindow;
  }
  
  private void doShowAgenda()
  {
    this.createWindow = "false";
    if (!IsPostBack)
    {
      this.inspecionesPanel.Style.Value = "display:none";
    
      this.agendaLabel.Text = "Agenda del Día " + DateTime.Today.ToLongDateString();
      this.asbInspectores.Text = "- TODOS -";
      this.asbInspectores.SelectedValue = "-1";

      this.wccDateToShow.Text = DateTime.Today.ToShortDateString();

      //this.GridView1.HeaderRow.Attributes.Add("notooltip", "notooltip");

      this.GridView1.DataBind();

    }

  }

  public String Helper1(Object o)
  {
    DateTime d = Convert.ToDateTime(o);
    return d.ToShortDateString();
  }

  public String Helper2(Object o)
  {
    DateTime d = Convert.ToDateTime(o);
    return d.ToString("HH:mm");

  }

  protected void Button5_Click(object sender, EventArgs e)
  {

  }

  public string getEventTime(object ini, object fin)
  {
    DateTime d_ini = Convert.ToDateTime(ini);
    DateTime d_fin = Convert.ToDateTime(fin);

    return d_ini.ToString("HH:mm") + " a " + d_fin.ToString("HH:mm");
  }

  protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
  {
    // TODO Tenemos que hacer que cada una de las lineas tenga la logica de negocio


    //if (e.Row.RowType == DataControlRowType.DataRow)
    //{
    //  e.Row.Attributes.Add("inspeccionId", "1");
    //  e.Row.Cells[9].Attributes.Add("notooltip", "notooltip");
    //  //DataRowView AuxRow = (DataRowView)e.Row.DataItem;
    //  CarCheck.Gestores.Inspeccion AuxRow = (CarCheck.Gestores.Inspeccion)e.Row.DataItem;

    //  //if (AuxRow["Estado"].ToString().ToUpper() == "AGENDADO")
    //  if (AuxRow.Estado.ToUpper() == "AGENDADO")
    //  {

    //    try //necesario porque cuando una de las filas está en modo edición los controles aqui apuntados no existen!!!!
    //    {
    //      ((ImageButton)e.Row.FindControl("editarImageButton")).Visible = true;
    //      ((HyperLink)e.Row.FindControl("frustrarHyperLink")).Visible = true;
    //      ((HyperLink)e.Row.FindControl("reprogramarHyperLink")).Visible = true;
    //    }
    //    catch (Exception ex)
    //    {

    //    }
    //  }
    //}    

    if (e.Row.RowType == DataControlRowType.DataRow)
    {
      //e.Row.Attributes.Add(inspeccionId,)
      e.Row.Cells[4].Attributes.Add("notooltip", "notooltip");
      DataRowView auxRow = (DataRowView)e.Row.DataItem;

      dsAgenda.proc_Car_InspeccionesPorSolicitudParaAgendarRow row = (dsAgenda.proc_Car_InspeccionesPorSolicitudParaAgendarRow)auxRow.Row;
      e.Row.Attributes.Add("inspeccionId", row.inspeccionId.ToString());
      e.Row.Attributes.Add("contacto", row.contacto);
      e.Row.Attributes.Add("action", "showcomunicacion");


      if (row.estadoInspeccionId == EstadoInspeccion.COORDINADA)
      {
        if (this.GridView1.EditIndex == -1)
        {
          //no estoy editando
          try //necesario porque cuando una de las filas está en modo edición los controles aqui apuntados no existen!!!!
          {
            ((ImageButton)e.Row.FindControl("editarImageButton")).Visible = EstadoInspeccion.FRUSTRADA != row.estadoInspeccion;
            ((HyperLink)e.Row.FindControl("frustrarHyperLink")).Visible = true;
            ((HyperLink)e.Row.FindControl("reprogramarHyperLink")).Visible = true;
          }
          catch (Exception ex)
          {
            LoggerFacade.LogException(ex);
          }
        }
      }

    }

  }

  protected void asbInspectores_TextChanged(object sender, EventArgs e)
  {
    if (asbInspectores.Text == "")
    {
      this.asbInspectores.Text = "- TODOS -";
      this.asbInspectores.SelectedValue = "-1";
    }
  }

  protected void ImageButton2_Click(object sender, ImageClickEventArgs e)
  {
    DateTime diaSiguiente = Convert.ToDateTime(wccDateToShow.Text);
    diaSiguiente = diaSiguiente.AddDays(1);//new DateTime(diaSiguiente.Year, diaSiguiente.Month, diaSiguiente.Day + 1);
    wccDateToShow.Text = diaSiguiente.ToShortDateString();
    this.agendaLabel.Text = "Agenda del Día " + diaSiguiente.ToLongDateString();
    Schedule1.DataBind();

  }

  protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
  {
    DateTime diaAnterior = Convert.ToDateTime(wccDateToShow.Text);
    diaAnterior = diaAnterior.AddDays(-1); //new DateTime(diaAnterior.Year, diaAnterior.Month, diaAnterior.Day - 1);

    wccDateToShow.Text = diaAnterior.ToShortDateString();
    this.agendaLabel.Text = "Agenda del Día " + diaAnterior.ToLongDateString();
    Schedule1.DataBind();
  }

  protected void odsInspecciones_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
  {
    e.InputParameters["solicitudId"] = solicitudId;
  }

  protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
  {
    e.NewValues["inspectorId"] = Request.Form[this.GridView1.Rows[e.RowIndex].UniqueID + "$asbInspector_SelectedValue"];
    e.NewValues["ubigeoId"] = Request.Form[this.GridView1.Rows[e.RowIndex].UniqueID + "$asbUbigeo_SelectedValue"];
    e.NewValues["Direccion"] = Request.Form[this.GridView1.Rows[e.RowIndex].UniqueID + "$txtDireccion"]; 
    
    e.NewValues["citaId"] = Request.Form[this.GridView1.Rows[e.RowIndex].UniqueID + "$hdfCitaId"];
    e.NewValues["inspeccionId"] = Request.Form[this.GridView1.Rows[e.RowIndex].UniqueID + "$hdfInspeccionId"]; 

    e.NewValues["uupdate"] = GestorSeguridad.getUserData().UserName ;
    
  }

  protected void odsInspecciones_Selected(object sender, ObjectDataSourceStatusEventArgs e)
  {
    try
    {
      string action = CCSOL.Utiles.Utilidades.isNull(Request.QueryString["action"], "showAgenda");

      if (action == "sASol")
      {
        this.inspeccionesLabel.Text = String.Format("Inspecciones ({0}) - Solicitud N° {1}", ((System.Data.DataTable)e.ReturnValue).Rows.Count, GestorSolicitud.getNumeroSolicitud(Request.QueryString["SolicitudId"]));
      }
      else
      {
        this.inspeccionesLabel.Text = String.Format("Inspecciones ({0}", ((System.Data.DataTable)e.ReturnValue).Rows.Count);
      }
    }
    catch (Exception ex)
    {
      LoggerFacade.LogException(ex);
    }
  }

  public string GetCssClass(object frustrada) 
  {
    bool isFrustrada = Convert.ToBoolean(frustrada);
    return isFrustrada ? "frustradaHeader" : "normal2";
  }

  protected void Schedule1_ItemDataBound(object sender, rw.ScheduleItemEventArgs e)
  {
    //e.Item.CssClass = ((dsAgenda.CitasCoordinadasRow)(e.Item.DataItem)).frustrada ? "frustrada" : "normal2";
    if (e.Item.ItemType == rw.ScheduleItemType.Item || e.Item.ItemType == rw.ScheduleItemType.AlternatingItem)
    {
      e.Item.CssClass = ((dsAgenda.CitasCoordinadasRow)((System.Data.DataRowView)e.Item.DataItem).Row).frustrada ? "frustrada" : "normal";
    }
  }
 
  protected void Schedule1_ItemCommand1(object sender, rw.ScheduleCommandEventArgs e)
  {
    if (e.CommandName == "showAgendaForSolicitud")
    {
      Response.Redirect("vAgenda.aspx?action=sASol&SolicitudId=" + GestorInspeccion.getSolicitudId(Convert.ToDecimal(e.CommandArgument)));
    }
  }
}
