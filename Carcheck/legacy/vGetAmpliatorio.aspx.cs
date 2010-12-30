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

public partial class vGetAmpliatorio : System.Web.UI.Page
{
  protected void Page_Load(object sender, EventArgs e)
  {
    lblMensaje.Visible = false;
  }
  protected void btnBuscar_Click(object sender, ImageClickEventArgs e)
  {
      dsInspeccionesTableAdapters.QueriesTableAdapter myTa = new dsInspeccionesTableAdapters.QueriesTableAdapter();
      decimal? inspeccionId = 0;
      String destino = null;
      myTa.proc_Car_Inspeccion_getInspeccionIdFor(txtNumInspeccion.Text, ref inspeccionId);

      if (inspeccionId != 0)
      {
        destino = "vAmpliatorios.aspx?InspeccionId=" + inspeccionId.ToString();
        Response.Redirect(destino);
      }
      lblMensaje.Visible = true;
      lblMensaje.Text = "El Número de Inspección ingresado no es correcto";
  }
}
