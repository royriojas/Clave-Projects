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

public partial class vGenericError : System.Web.UI.Page
{
  protected void Page_Load(object sender, EventArgs e)
  {
    Exception ex = (Exception)Session["CustomError"];

    if (ex != null)
    {
      this.lblTitulo.Text = "Error : ";
      this.txtDetalle.Text = "Ha ocurrido un error que la aplicación no ha podido procesar correctamente, por favor contacte con Sistemas. Detalle de Error : " + ex.Message;

    }
  }
}
