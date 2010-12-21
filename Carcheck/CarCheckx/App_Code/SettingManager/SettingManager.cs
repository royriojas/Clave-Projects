using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;


namespace CarCheck
{
  /// <summary>
  /// Summary description for SettingManager
  /// </summary>
  public class SettingManager
  {
    public SettingManager()
    {
      //
      // TODO: Add constructor logic here
      //
    }

    public static string ERR_MSG_USER_HAS_NO_PERMISSION = "[ ERROR ] : El usuario no tiene los permisos necesarios para accesar a esta funcionalidad";

    public static string MSG_AUTOMATIC_STATE_CHANGE = "CAMBIO AUTOMÁTICO DE ESTADO";

    public static string ADMINISTRADOR_ROL_ID = "ADMINISTRADOR";
    public static string INSPECTOR_ROL_ID = "INSPECTOR";
    public static string CLIENTE_ROL_ID = "CLIENTE";
    public static string COORDINADOR_ROL_ID = "COORDINADOR";
    public static string SOPORTE_ROL_ID = "SOPORTE";

    

  }
}
