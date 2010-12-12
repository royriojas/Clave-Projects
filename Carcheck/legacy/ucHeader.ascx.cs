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
using CarCheck.Enums;
using CCSOL.Utiles;
using CarCheck.Gestores;

public partial class ucHeader : System.Web.UI.UserControl
{
  public HeaderLinks TabActual
  {
    get
    {
      return this.tabActual;
    }
    set
    {
      this.tabActual = value;
    }
  }
  private HeaderLinks tabActual = HeaderLinks.listaSolicitudes;

  protected void Page_Load(object sender, EventArgs e)
  {
    isAValidUserSession();
    switch (TabActual)
    {
      case HeaderLinks.listaSolicitudes: this.lnkListaSolicitudes.CssClass = "MenuItemOver";
        break;
      case HeaderLinks.listaInspecciones: this.lnkListaInspecciones.CssClass = "MenuItemOver";
        break;
      case HeaderLinks.valoresComerciales: this.lnkValores.CssClass = "MenuItemOver";
        break;
      case HeaderLinks.agenda: this.lnkAgenda.CssClass = "MenuItemOver";
        break;
      case HeaderLinks.reportes: this.lnkReportes.CssClass = "MenuItemOver";
        break;
      case HeaderLinks.estadistica: this.lnkEstadistica.CssClass = "MenuItemOver";
        break;
      case HeaderLinks.opciones: this.lnkEstadistica.CssClass = "MenuItemOver";
        break;
      default:
        break;
    }
  }

  private void isAValidUserSession()
  {
    UserData ud = (UserData)Session["userData"];
    Utilidades.redirectToUrlWhenIsNull(ud, this.Response, this.Request.RawUrl);
  }

  protected void logoutLinkButton_Click(object sender, EventArgs e)
  {
    Session.Abandon();
    Response.Redirect("vLogIn.aspx",true);
  }


}
