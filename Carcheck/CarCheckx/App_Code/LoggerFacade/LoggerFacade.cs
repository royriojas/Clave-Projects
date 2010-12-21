using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using CCSOL.Utiles.Logger;
//using System.Reflection;

/// <summary>
/// Summary description for LoggerFacade
/// </summary>
public class LoggerFacade
{
  public static void resolveRelativePath()
  {
    LoggerManager.logger.FileName = HttpContext.Current.Server.MapPath(LoggerManager.logger.FileName);
  }
	public LoggerFacade()
	{
		//
		// TODO: Add constructor logic here
		//    
	}
  public static void writeLog(string mensaje)
  {
    LoggerManager.AddLogEntry(mensaje);
    //if (HttpContext.Current.Application["logger"] != null)
    //{
    //  CCSOL.Utiles.Logger.Logger logger = (CCSOL.Utiles.Logger.Logger)HttpContext.Current.Application.Get("logger");
    //  CCSOL.Utiles.Logger.Logger.addLogItem((logger), mensaje);
    //  CCSOL.Utiles.Logger.Logger.writeLog(logger);
    //}
  }
  public static void LogException(Exception ex)
  {                                             
    //writeLog("[ EXCEPCTION : ]" + ListProperties(ex));
    try
    {
      LoggerManager.LogException(ex);
    }
    catch (Exception e)
    {
      //last chanche we cannot do anything
    }
  }

  //public static string ListProperties(object objectToInspect)
  //{
  //  string returnString = "";

  //  //To use reflection on an object, you 
  //  // first need to get an instance
  //  // of that object's type.
  //  Type objectType = objectToInspect.GetType();

  //  //After you have the object's type, you can get 
  //  // information on that type. In this case, we're 
  //  // asking the type to tell us all the
  //  // properties that it contains.
  //  PropertyInfo[] properties = objectType.GetProperties();

  //  //You can then use the PropertyInfo array 
  //  // to loop through each property of the type.
  //  foreach (PropertyInfo property in properties)
  //  {
  //    //The interest part of this code 
  //    // is the GetValue method. This method
  //    // returns the value of the property.
  //    returnString += property.Name + ": " +
  //           property.GetValue(objectToInspect, null) + "\r\n";
  //  }

  //  return returnString;
  //}
}
