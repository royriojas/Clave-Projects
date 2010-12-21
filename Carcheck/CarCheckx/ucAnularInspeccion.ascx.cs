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

public partial class ucAnularInspeccion : System.Web.UI.UserControl
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

  }
  protected void btnAnular_Click(object sender, EventArgs e)
  {
    if (GestorInspeccion.AnularInspeccion(Convert.ToDecimal(this.hdfInspeccionId.Value), Convert.ToDecimal(this.hdfSolicitudId.Value), Convert.ToDecimal(this.cbxMotivo.SelectedItem.Value), txtObservacion.Text, Session["userName"].ToString()))
    {
      Response.Redirect(this.Request.RawUrl, true);
    }


  }
}
