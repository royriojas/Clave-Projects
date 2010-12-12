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
using System.Threading;
using CarCheck.Gestores;

public partial class vLogIn : System.Web.UI.Page
{
  protected void Page_Load(object sender, EventArgs e)
  {

  }

  protected void Submit_Click(object sender, EventArgs e)
  {

    UserData ud = null;
    Boolean usuarioValido = GestorUsuarios.isValidUser(this.usuarioTextBox.Text, this.claveTextBox.Text, out ud);
    if ((usuarioValido) && (ud != null))
    {
      Session["userData"] = ud;
      Session["userName"] = ud.UserName;

      if (!String.IsNullOrEmpty(Request.QueryString["urlDest"]))
      {
        Response.Redirect(Request.QueryString["urlDest"],true);
      }

      switch (ud.UserRolNameId)
      {
        case "ADMINISTRADOR_CCK":
          Response.Redirect("vListaSolicitud.aspx");
          break;
        default:
          Response.Redirect("vListaSolicitud.aspx");
          break;
      }

    }
  }
}
