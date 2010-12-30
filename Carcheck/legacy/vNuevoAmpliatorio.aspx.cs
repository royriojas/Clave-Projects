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

public partial class vNuevoAmpliatorio : System.Web.UI.Page
{
    public decimal inspeccionId;
    public decimal ampliatorioId;

    protected void Page_Load(object sender, EventArgs e)
    {
      inspeccionId = Convert.ToDecimal(Request.QueryString["inspeccionId"].ToString());
    }
  protected void odsAmpliatorio_Inserting(object sender, ObjectDataSourceMethodEventArgs e)
  {
    e.InputParameters.Add("inspeccionId", inspeccionId);
    e.InputParameters.Add("usuario", Session["userName"]);
  }
  protected void guardarImageButton_Click(object sender, ImageClickEventArgs e)
  {
      frmAmpliatorio.InsertItem(true);

      // Generamos el pdf del ampliatorio
      CarCheck.Reportes.GetPdf.GenerarAmpliatorio(inspeccionId,ampliatorioId, Session["userName"].ToString(), Server.MapPath(""));
      
      this.Page.ClientScript.RegisterStartupScript(this.GetType(), "ScriptConfirm", "doCallWindowAddImages();",true);
     
  }
  protected void odsAmpliatorio_Inserted(object sender, ObjectDataSourceStatusEventArgs e)
  {
      ampliatorioId = Convert.ToDecimal(e.OutputParameters["ampliatorioId"].ToString());
  }
}
