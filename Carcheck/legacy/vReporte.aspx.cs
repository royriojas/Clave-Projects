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
using AjaxPro;
using CarCheck.Gestores;

public partial class vReporte : System.Web.UI.Page
{
  public int num = 1;


  protected void Page_Load(object sender, EventArgs e)
  {

  }
  protected void cbxCliente_DataBound(object sender, EventArgs e)
  {
    GestorCombos.BlockClientDropDownList(this.cbxCliente);
  }
  protected void cbxAseguradora_DataBound(object sender, EventArgs e)
  {
    GestorCombos.BlockAseguradoraDropDownList(this.cbxAseguradora);
  }

  protected void cbxBroker_DataBound(object sender, EventArgs e)
  {
    GestorCombos.BlockBrokerDropDownList(this.cbxBroker);
  }

  protected void odsSolicitudLista_Selected(object sender, ObjectDataSourceStatusEventArgs e)
  {
    DataTable dt = (DataTable)(e.ReturnValue);
    if (dt != null)
    {
      this.lblLista.Text = "Lista de Solicitudes (" + dt.Rows.Count + ")";
    }
  }
}
