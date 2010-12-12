using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

namespace CarCheck.Gestores
{
  /// <summary>
  /// Summary description for GestorUsuarios
  /// </summary>
  /// 
  public class GestorUsuarios
  {
    public GestorUsuarios()
    {
      //
      // TODO: Add constructor logic here
      //
    }
    public static Boolean isValidUser(String User, String Password, out UserData ud)
    {
      
      //ud = null;
      //bool isValidUser = ADM_DAL.SecurityManager.isValidUserForSystem(User,Password,"CARCHECK_APP") {
      // if ( isValidUser ) {
      //    ud = new UserData();         
      // }
       
      //
      
      ud = new UserData();
      ud.CiaId = 38;
      ud.CiaName = "Clave-1";
      ud.Persona = "Emanuel Soto Huerta";
      ud.UserId = 3;
      ud.PersonaId = 67;
      ud.UserName = "ursula.s";

      ud.UserRolName = "ADMINISTRADOR_CCK";            

      return true;
    }

  }
}
