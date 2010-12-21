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


public partial class generarStatus : System.Web.UI.Page
{
  protected void Page_Load(object sender, EventArgs e)
  {

    string action = Utilidades.isNullGet("action", "GI");

    switch (action)
    {
      case "GI": //Generar Informe
        doGenerateInform();
        break;
      case "PV":
        doPreviewInform();
        break;
    }



  }

  private void doPreviewInform()
  {
    //string pagina = "'vViewPdf.aspx?VehiculoId={0}&TI=NOW'";
    string vehiculoId = Request.QueryString["VehiculoId"];
    //string observado = Request.QueryString["Observado"];
    string script = String.Format("window.document.location = 'vViewPdf.aspx?VehiculoId={0}&TI=NOW'", vehiculoId);
    Page.ClientScript.RegisterStartupScript(this.GetType(), "ScriptGeneracionInforme", script, true);
  }

  private void doGenerateInform()
  {
    string vehiculoId = Request.QueryString["VehiculoId"];
    string observado = Request.QueryString["Observado"];
    string script = "window.document.location = 'generarInforme.aspx?VehiculoId=" + vehiculoId + "&Observado=" + observado + "'";
    Page.ClientScript.RegisterStartupScript(this.GetType(), "ScriptGeneracionInforme", script, true);
  }
}
