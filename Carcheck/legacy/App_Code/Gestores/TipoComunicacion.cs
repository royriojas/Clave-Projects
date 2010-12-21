using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using AjaxPro;
using System.Collections.Generic;
using CCSOL.Utiles;

namespace CarCheck.Gestores
{

  public class TipoComunicacion
  {
    public static string DUMMY = "DUMMY";
    public static string EMAIL = "EMAIL";
    public static string FAX = "FAX";
    public static string LLAMADA = "LLAMADA";
    public static string PERSONAL = "PERSONAL";
  }

}
