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

public partial class generarInforme : System.Web.UI.Page
{
  protected void Page_Load(object sender, EventArgs e)
  {
    string vehiculoId = Request.QueryString["VehiculoId"];
    bool observado = Convert.ToBoolean(int.Parse(Request.QueryString["Observado"]));
    bool estadoValidacion = true;

    CarCheck.Reportes.GetPdf.GenerarInforme(decimal.Parse(vehiculoId), estadoValidacion, observado, Session["userName"].ToString() , Server.MapPath(""));

    //Actualizar los estados de la inspección 

    if (GestorSeguridad.hasPermision(Funcionalidades.INSPECCION_INFORME_APROBAR))
    {
      if (observado)
        CarCheck.Gestores.GestorInspeccion.AprobarInspeccion(decimal.Parse(vehiculoId), "APROBADO_NO_PAGO");
      else
        CarCheck.Gestores.GestorInspeccion.AprobarInspeccion(decimal.Parse(vehiculoId), "APROBADO_PAGO");
    }
        
    //Page.ClientScript.RegisterStartupScript(this.GetType(), "ScriptGeneracionInforme", "alert('el Informe ha sido creado');window.top.hidePopWin(true);", true);
  }
}
