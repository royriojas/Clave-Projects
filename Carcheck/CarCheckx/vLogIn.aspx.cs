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
using CCSOL.Utiles;
using CarCheck;

public partial class vLogIn : System.Web.UI.Page
{
  protected void Page_Load(object sender, EventArgs e)
  {
    if ((Utilidades.isNull(Request.QueryString["msg"], "") != ""))
    {
      this.Label1.Text = HttpUtility.HtmlEncode(Request.QueryString["msg"]);
      this.Label1.Visible = true;
    }
  }

  internal void btnIngresar_Click(object sender, EventArgs e)
  {
    UserData ud = null;
    Boolean usuarioValido = GestorSeguridad.isValidUser(this.usuarioTextBox.Text, this.claveTextBox.Text, out ud);
    if ((ud != null) && (usuarioValido))
    {
      Session["userData"] = ud;
      Session["userName"] = ud.UserName;

      if (!String.IsNullOrEmpty(Request.QueryString["urlDest"]))
      {
        Response.Redirect(Request.QueryString["urlDest"], true);
      }

      if (ud.UserRolNameId == SettingManager.INSPECTOR_ROL_ID)
      {
        Response.Redirect("vListaInspeccion.aspx");
      }

      if (ud.UserRolNameId == SettingManager.ADMINISTRADOR_ROL_ID)
      {
        Response.Redirect("vListaSolicitud.aspx");
      }
      else
      {
        Response.Redirect("vListaSolicitud.aspx");
      }
    }
    else
    {
      this.Label1.Text = "Usuario o Contraseña no válidos";
      this.Label1.Visible = true;
    }

  }
}
