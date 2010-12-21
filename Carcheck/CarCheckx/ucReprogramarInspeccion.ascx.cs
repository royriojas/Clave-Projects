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
using CarCheck.Gestores;
using AjaxPro;

public partial class ucReprogramarInspeccion : System.Web.UI.UserControl
{
  private string _triggerId;
  public string TriggerId
  {
    get
    {
      return _triggerId;
    }
    set
    {
      _triggerId = value;
    }
  }

  protected void Page_Load(object sender, EventArgs e)
  {
     Utility.RegisterTypeForAjax(typeof(ucReprogramarInspeccion));
  }



  protected void btnAnular_Click(object sender, EventArgs e)
  {
    DateTime fIni = DateTime.Now;
    DateTime fFin = DateTime.Now;


    string finspInicio_str = this.wcFechaInicio.Text + " " + this.txtHoraIni.Text;

    string finspFin_str = this.wcFechaInicio.Text + " " + this.txtHoraFin.Text;

    //finspFin_str = wccFechaInspeccion.Text + " " + horaFinTextBox.Text;

    bool DatesAreValid = false;

    if (DateTime.TryParse(finspInicio_str, out fIni))
    {
      if (DateTime.TryParse(finspFin_str, out fFin))
      {
        DatesAreValid = true;
      }
    }

    if (!DatesAreValid)
    {
      this.Page.ClientScript.RegisterStartupScript(this.GetType(), "ErrorScript", "alert('verifique el formato de las fechas');", true);
      return;
    }

    GestorInspeccion.ReprogramarSolicitud(
      Convert.ToDecimal(this.hdfInspeccionId.Value),  //inspeccionId
      Convert.ToDecimal(this.hdfSolicitudId.Value),   //SolicitudId
      /*Datos de la cita*/
      this.txtContacto.Text,
      this.txtDireccion.Text,
      this.asbDistrito.SelectedValue,
      this.txtTelefono.Text,
      Convert.ToDecimal(this.asbInspector.SelectedValue),
      /*Hora de la nueva cita*/
      fIni,
      fFin,

      this.txtObservacion.Text
      );

    Response.Redirect(this.Request.RawUrl, true);
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
  public bool datesAreValid(String fIni, String fFin)
  {
    if (isValidDateTimeForUser(fIni) && isValidDateTimeForUser(fFin))
    {
      DateTime fIniD = DateTime.Now;
      DateTime fFinD = DateTime.Now;

      if (!DateTime.TryParse(fIni, out fIniD)) return false;
      if (!DateTime.TryParse(fFin, out fFinD)) return false;

      return (DateTime.Compare(fIniD, fFinD) < 0); 
    }
    return false;
  }

}
