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

public partial class vAmpliatorios : System.Web.UI.Page
{
    public String InspeccionId = null;
    protected void Page_Load(object sender, EventArgs e)
    {
      InspeccionId = Request.QueryString["InspeccionId"].ToString();
    }

  protected void ListaInspeccionGridView_RowDataBound(object sender, GridViewRowEventArgs e)
  {
    if (e.Row.RowType == DataControlRowType.DataRow)
    {
      DataRowView AuxRow = (DataRowView)e.Row.DataItem;
      HyperLink informeHyperLink = (HyperLink)e.Row.FindControl("ampliatorioHyperLink");
      informeHyperLink.NavigateUrl = "javascript:VerInforme(" + AuxRow["inspeccionId"].ToString() + ", " + AuxRow["ampliatorioId"].ToString() + ");";
      
    }
  }
  protected void odsListaAmpliatorio_Deleting(object sender, ObjectDataSourceMethodEventArgs e)
  {
      e.InputParameters.Add("uupdate", Session["userName"]);
  }
}
