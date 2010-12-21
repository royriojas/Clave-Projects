using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Collections;

namespace CarCheck.Gestores
{
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
    public static Boolean isValidUser(String User, String Password, out UserData ud)
    {
      ud = new UserData();
      Hashtable uData = null;
      bool isValidUser = ADM_DAL.dsSYS.isValidUserForAppplication(User, Password, ConfigurationManager.AppSettings["ApplicationId"], out uData);

      if (uData != null && isValidUser)
      {
        ud.CiaName = (string)uData["cia"];
        ud.CiaId = Convert.ToDecimal(uData["ciaId"]);

        ud.Persona = (string)uData["persona"];
        ud.PersonaId = Convert.ToDecimal(uData["personaId"]);

        ud.UserRolName = (string)uData["rol"];
        ud.UserRolNameId = (string)uData["rolId"];

        ud.UserName = (string)uData["usuario"];
        ud.UserId = Convert.ToDecimal(uData["usuarioId"]);

        return true;
      }

      ud = null;


      return false;
    }
    public static bool hasPermision(UserData ud, String funcionalidadId)
    {
      if (ud == null) return false;
      return ADM_DAL.dsSYS.hasPermission(Convert.ToInt32(ud.UserId), funcionalidadId, ConfigurationManager.AppSettings["ApplicationId"]);
    }

    public static bool hasPermision(string Funcionalidad)
    {
      return hasPermision((UserData)HttpContext.Current.Session["userData"], Funcionalidad);
    }

    public static UserData getUserData()
    {
      return (UserData)HttpContext.Current.Session["userData"];
    }

    [AjaxPro.AjaxMethod]
    public string keepSessionAlive()
    {
      try
      {
        HttpContext.Current.Session["lastTry"] = HttpContext.Current.Session["userName"].ToString() +" | " + DateTime.Now.ToString();
        return HttpContext.Current.Session["lastTry"].ToString();//DateTime.Now.ToString();
      }
      catch (Exception ex)
      {
        LoggerFacade.LogException(ex);
        return "[ Error ] : " + ex.Message;
        
      }
    }
  }

}