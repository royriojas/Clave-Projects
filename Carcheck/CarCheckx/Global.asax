<%@ Application Language="C#" %>

<script RunAt="server">
    
    
  void Application_Start(object sender, EventArgs e)
  {
	LoggerFacade.resolveRelativePath();
    LoggerFacade.writeLog("La Aplicación se ha iniciado!!!!!");
  }

  void Application_End(object sender, EventArgs e)
  {
    LoggerFacade.writeLog("La Aplicación ha finalizado!!!!!");
  }

  void Application_Error(object sender, EventArgs e)
  {
    Exception exx = Server.GetLastError();
    if (exx != null)
    {
      LoggerFacade.LogException(exx);
      try
      {
        if (HttpContext.Current.Session != null)
        {
          HttpContext.Current.Session.Remove("CustomError");
          HttpContext.Current.Session.Add("CustomError", exx);
        }
      }
      catch (Exception ex)
      {
        LoggerFacade.LogException(ex);
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

