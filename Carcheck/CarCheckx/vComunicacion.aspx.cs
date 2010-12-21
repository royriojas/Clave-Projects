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
using CCSOL.Utiles;
using AjaxCanales.Utiles;
using CarCheck.Gestores;
using AjaxPro;


public partial class vComunicacion : System.Web.UI.Page
{

  public string solicitudId = "";
  private int num = 0;


  protected void Page_Load(object sender, EventArgs e)
  {
    //separadorColumn.Style[HtmlTextWriterStyle.Display] = "none";

    Utility.RegisterTypeForAjax(typeof(vComunicacion));

    solicitudId = Utilidades.isNull(Request.QueryString["SolicitudId"], "-1");
    inspeccionExitosaDiv.Style[HtmlTextWriterStyle.Display] = "none";
    if (!IsPostBack && !IsCallback)
    {
      this.wccFechaComunicacion.Text = DateTime.Now.ToString("dd/MM/yyyy HH:mm");
      this.wccFechaInspeccion.Text = DateTime.Now.ToShortDateString();



      this.GridViewInspeciones.DataBind();
      this.GridViewComunicacion.DataBind();
    }

  }

  public String muestraResultado(object ResultadoId)
  {
    String Resultado = "";

    try
    {
      Resultado = Convert.ToString(ResultadoId);

      if (Resultado == "E")
      {
        Resultado = "Exitoso";
      }
      else
      {
        Resultado = "No Exitoso";
      }
    }
    catch (Exception ex)
    {
      Resultado = "";
      LoggerFacade.LogException(ex);
    }

    return Resultado;
  }
  protected void odsInspecciones_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
  {
    e.InputParameters["solicitudId"] = solicitudId;
  }
  protected void odsComunicaciones_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
  {
    e.InputParameters["solicitudId"] = solicitudId;
  }




  protected void Button3_Click(object sender, EventArgs e)
  {
    solicitudId = Utilidades.isNull(Request.QueryString["SolicitudId"], "-1");

    decimal? comunicacionId = 0;
    bool DatesAreValid = true;

    //la comuniación fue exitosa???
    bool exito = (estadoComunicacionRadioButton.SelectedValue == "E");

    DateTime fcom = DateTime.Now;//new DateTime(anho, mes, dias);

    if (!DateTime.TryParse(wccFechaComunicacion.Text, out fcom))
    {
      this.Page.ClientScript.RegisterStartupScript(this.GetType(), "alerta", "alert('los campor de fecha tienen un formato invalido, por favor verifique e intente nuevamente');", true);
      return;
    }

    dsAgendaTableAdapters.QueriesTableAdapter qt = new dsAgendaTableAdapters.QueriesTableAdapter();

    DateTime finspInicio = DateTime.Now; //new DateTime(anho, mes, dias, Convert.ToInt32(horaInicioTextBox.Text), 0, 0);
    DateTime finspFin = DateTime.Now;//new DateTime(anho, mes, dias, Convert.ToInt32(horaFinTextBox.Text), 0, 0);
    string finspInicio_str;


    if (exito)
    {
      finspInicio_str = wccFechaInspeccion.Text + " " + horaInicioTextBox.Text;
      //finspFin_str = wccFechaInspeccion.Text + " " + horaFinTextBox.Text;

      if (DateTime.TryParse(finspInicio_str, out finspInicio))
      {
        DatesAreValid = true;
      }

    }

    if (DatesAreValid)
    {

      int num = 0;
      foreach (GridViewRow row in GridViewInspeciones.Rows)
      {

        CheckBox AuxCheckBox = (CheckBox)row.FindControl("chk");

        if (AuxCheckBox.Checked)
        {
          decimal? inspeccionId = Convert.ToDecimal(row.Cells[1].Text);

          comunicacionId = GestorAgenda.RegistrarComunicacion(tActividadIdCombo.SelectedValue, fcom, estadoComunicacionRadioButton.SelectedValue,
            observacionTextBox.Text, contactoTextBox.Text, row.Cells[7].Text, inspeccionId, Convert.ToDecimal(solicitudId), exito);

          if (exito)
          {
            if (num == 0)
            {
              finspFin = finspInicio.AddMinutes(40);
            }
            else
            {
              finspFin = finspInicio.AddMinutes(20);
            }
            GestorAgenda.RegistrarCita(inspeccionId,
              Convert.ToDecimal(solicitudId),
              comunicacionId,
              finspInicio,
              finspFin,
              direccionTextBox.Text,
              asbDistrito.SelectedValue,
              Convert.ToDecimal(asbInspector.SelectedValue),
              contactoInspeccionTextBox.Text,
              telefonoTextBox.Text,
              observacionTextBox.Text);
          }

          finspInicio = finspFin;
          num++;
        }


      }

      this.GridViewComunicacion.DataBind();
      this.GridViewInspeciones.DataBind();

      this.Page.ClientScript.RegisterStartupScript(this.GetType(), "close", "window.top.hidePopWindow();", true);
    }
    else
    {
      this.Page.ClientScript.RegisterStartupScript(this.GetType(), "alerta", "alert('los campor de fecha tienen un formato invalido, por favor verifique e intente nuevamente');", true);
    }


  }
  protected void odsInspecciones_Selected(object sender, ObjectDataSourceStatusEventArgs e)
  {
    DataTable dt = (DataTable)(e.ReturnValue);
    if (dt != null)
    {
      this.btnGuardar.Visible = (dt.Rows.Count > 0);

    }
  }
  protected void GridViewInspeciones_RowDataBound(object sender, GridViewRowEventArgs e)
  {
    if (e.Row.RowType == DataControlRowType.DataRow)
    {
      if (num++ == 0)
      {
        try
        {
          DataRowView auxRow = (DataRowView)e.Row.DataItem;
          dsAgenda.InspeccionesPendientesRow row = (dsAgenda.InspeccionesPendientesRow)auxRow.Row;
          this.contactoTextBox.Text = row.contacto;

          this.contactoInspeccionTextBox.Text = row.contacto;
          if (!String.IsNullOrEmpty(row.telefono1))
          {
            this.telefonoTextBox.Text = row.telefono1;
          }
          else if (!String.IsNullOrEmpty(row.telefono2))
          {
            this.telefonoTextBox.Text = row.telefono2;
          }
          else
          {
            this.telefonoTextBox.Text = "--";
          }
        }
        catch (Exception ex)
        {
          LoggerFacade.LogException(ex);
        }

      }
    }
  }

  [AjaxPro.AjaxMethod]
  public bool isValidDateTimeForUser(String aDate)
  {
    DateTime aRealDateObject = DateTime.Now;
    if (DateTime.TryParse(aDate, out aRealDateObject))
    {
      if (DateTime.Compare(DateTime.Now, aRealDateObject) > 0)
      {
        return (GestorSeguridad.hasPermision(Funcionalidades.CITA_REG_WITHOUT_DATE_CHECKING));
      }
      else
      {
        return true;
      }
    }
    return false;
  }

  [AjaxPro.AjaxMethod]
  public bool isValidDateTime(String aDate)
  {
    DateTime aRealDateObject = DateTime.Now;
    return DateTime.TryParse(aDate, out aRealDateObject);
  }

  [AjaxPro.AjaxMethod]
  public string doTimeCalculations(string aDate, string aTime, int numberOfItemsBeenChecked)
  {
    if (numberOfItemsBeenChecked == 0) return "--";
    DateTime aRealDateObject = DateTime.Now;
    if (DateTime.TryParse(aDate.Trim() + " " + aTime.Trim(), out aRealDateObject))
    {
      DateTime tiempoTotal = aRealDateObject.AddMinutes(20 * numberOfItemsBeenChecked + 20);
      //TimeSpan t = tiempoTotal.Subtract(aRealDateObject);
      return tiempoTotal.ToString("HH:mm");
    }
    else
    {
      return "--";
    }
  }
}
