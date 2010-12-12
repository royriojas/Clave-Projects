using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using CarCheck.Gestores;

/// <summary>
/// Summary description for GestorSeguridad
/// </summary>
public class GestorSeguridad
{
  public GestorSeguridad()
  {
    //
    // TODO: Add constructor logic here
    //
  }
  public static bool hasPermision(UserData ud, String permision)
  {
    //
    // TODO: Add method logic here
    //
      if (permision.CompareTo("EDITAR_INSPECCION_INSPECTOR")==0)
      {
          return false;
      }
      else if (permision.CompareTo("EDITAR_INSPECCION")==0)
      {
          return false;
      }
      else if (permision.CompareTo("VER_INSPECCION")==0)
      {
          return false;
      }
    return false;
  }
}
