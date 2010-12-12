<%@ Application Language="C#" %>

<script RunAt="server">
    
    
  void Application_Start(object sender, EventArgs e)
  {
    // Code that runs on application startup
    string path = ConfigurationManager.AppSettings["LoggerDirectory"];
    CCSOL.Utiles.Logger.Logger logger = new CCSOL.Utiles.Logger.Logger(Server.MapPath(path + "/logger.txt"));
    Application.Add("logger", logger);
  }

  void Application_End(object sender, EventArgs e)
  {
    //  Code that runs on application shutdown
    Application.Remove("logger");
  }

  void Application_Error(object sender, EventArgs e)
  {

    CCSOL.Utiles.Logger.Logger logger = (CCSOL.Utiles.Logger.Logger)Application.Get("logger");
    if (logger != null)
    {
      Exception exx = Server.GetLastError();
      if (exx != null)
      {
        int i = 0;
        logger.addLogItem(new CCSOL.Utiles.Logger.LogItem("[INCIO DE LA CADENA DE ERRORES]"));
        //Buscamos el error más bajo en la cadena de excepciones que puede haber provocado el exception
        while (exx.InnerException != null)
        {
          logger.addLogItem(new CCSOL.Utiles.Logger.LogItem("[Error " + i + "] : " + exx.Message));
          exx = exx.InnerException;
          i++;
        }

        try
        {
          if (Session.Contents != null)
          {
            Session.Remove("CustomError");
            Session.Add("CustomError", exx);
          }
        }
        catch (Exception Ex)
        {

        }
        try
        {
          logger.addLogItem(new CCSOL.Utiles.Logger.LogItem("[Error " + i + "] : " + exx.Message));
          logger.writeLog();
        }
        catch (Exception ex)
        {

        }
      }
    }



  }

  void Session_Start(object sender, EventArgs e)
  {
    // Code that runs when a new session is started

  }

  void Session_End(object sender, EventArgs e)
  {


  }
       
</script>

