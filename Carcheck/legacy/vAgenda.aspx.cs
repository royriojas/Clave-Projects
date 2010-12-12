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


public partial class vAgenda : System.Web.UI.Page
{
  private string createWindow = "false";

  #region CallBacks 
  public EventControl cckhandler = new EventControl();
  public EventControl cckhandler_gridInspeccion = new EventControl();
  public EventControl cckhandler_doSave = new EventControl();

  protected void Page_Init(object sender, EventArgs e)
  {
    cckhandler.ScriptCallback += new EventControl.delScriptCallBack(cckhandler_ScriptCallback);
    cckhandler_gridInspeccion.ScriptCallback += new EventControl.delScriptCallBack(cckhandler_gridInspeccion_ScriptCallback);
    cckhandler_doSave.ScriptCallback += new EventControl.delScriptCallBack(cckhandler_doSave_ScriptCallback);

    this.AddParsedSubObject(cckhandler);  
    this.AddParsedSubObject(cckhandler_gridInspeccion);
    this.AddParsedSubObject(cckhandler_doSave);
  }

  public string cckhandler_doSave_ScriptCallback(CallbackEventArgs eventArgument)
  {
    /*int index = this.GridView1.EditIndex;
    this.GridView1.UpdateRow(this.GridView1.EditIndex, false);*/
    this.GridView1.EditIndex = -1;
    this.GridView1.DataBind();
    return CCSOL.Utiles.Utilidades.getHTML(this.GridView1);
  }

  public string cckhandler_gridInspeccion_ScriptCallback(CallbackEventArgs eventArgument)
  {
    this.GridView1.EditIndex = Convert.ToInt16(eventArgument.Parameters[0]);
    this.GridView1.DataBind();
    return CCSOL.Utiles.Utilidades.getHTML(this.GridView1);
  }

  public string cckhandler_ScriptCallback(CallbackEventArgs eventArgument)
  {
    int theTimeInterval = Convert.ToInt16(eventArgument.Parameters[0]);
    this.Schedule1.TimeScaleInterval = theTimeInterval;
    this.Schedule1.DataBind();
    return CCSOL.Utiles.Utilidades.getHTML(this.Schedule1);
}

  #endregion

protected void Page_Load(object sender, EventArgs e)
  {
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
      this.createWindow = "true";
      this.agendaLabel.Text = "Agenda del Día " + DateTime.Today.ToLongDateString();
      this.asbInspectores.Text = "- TODOS -";
      this.asbInspectores.SelectedValue = "-1";

      this.wccDateToShow.Text = DateTime.Today.ToShortDateString();
    }
  }

  public string shouldCreateWindow()
  {
    return createWindow;
  }
  private void doShowAgenda()
  {
    if (!IsPostBack)
    {
      this.inspecionesPanel.Style.Value = "display:none";
      this.createWindow = "false";
      this.agendaLabel.Text = "Agenda del Día " + DateTime.Today.ToLongDateString();
      this.asbInspectores.Text = "- TODOS -";
      this.asbInspectores.SelectedValue = "-1";

      this.wccDateToShow.Text = DateTime.Today.ToShortDateString();

      this.GridView1.HeaderRow.Attributes.Add("notooltip", "notooltip");    
    }
  }

  public String Helper1(Object o)
  {
    DateTime d = Convert.ToDateTime(o);
    //return Microsoft.VisualBasic.DateAndTime.WeekdayName(() + " " + &d.Day & "/" & d.Month;
    return d.ToShortDateString();
  }

  public String Helper2(Object o)
  {
    DateTime d = Convert.ToDateTime(o);
    return d.ToShortTimeString();

  }

  /*  Public Function Helper1(ByVal o As Object) As String
      Dim thisDate As Date = CDate(o)
          Return WeekdayName(thisDate.DayOfWeek, vbSunday) & " " & thisDate.Day & "/" & thisDate.Month
      End Function

      Public Function Helper2(ByVal o As Object) As String
          Dim thisDate As Date = CDate(o)
          Return thisDate.ToShortTimeString()
      End Function     
   */

  protected void Button5_Click(object sender, EventArgs e)
  {

  }

  public string getEventTime(object ini, object fin)
  {
    DateTime d_ini = Convert.ToDateTime(ini);
    DateTime d_fin = Convert.ToDateTime(fin);

    //return d_ini.Hour + ":" + d_ini.Minute + " a " + d_fin.Hour + ":" + d_fin.Minute ;
    return d_ini.ToShortTimeString() + " a " + d_fin.ToShortTimeString();
  }

  protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
  {  
    if (e.Row.RowType == DataControlRowType.DataRow)
    {
      e.Row.Attributes.Add("inspeccionId", "1");
      e.Row.Cells[9].Attributes.Add("notooltip", "notooltip");
      //DataRowView AuxRow = (DataRowView)e.Row.DataItem;
      CarCheck.Gestores.Inspeccion AuxRow = (CarCheck.Gestores.Inspeccion)e.Row.DataItem;

      //if (AuxRow["Estado"].ToString().ToUpper() == "AGENDADO")
      if (AuxRow.Estado.ToUpper() == "AGENDADO")
      {

        try //necesario porque cuando una de las filas está en modo edición los controles aqui apuntados no existen!!!!
        {
          ((ImageButton)e.Row.FindControl("editarImageButton")).Visible = true;
          ((HyperLink)e.Row.FindControl("frustrarHyperLink")).Visible = true;
          ((HyperLink)e.Row.FindControl("reprogramarHyperLink")).Visible = true;
        }
        catch (Exception ex)
        {

        }
      }
    }    
  }
}
