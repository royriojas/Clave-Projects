<%@ WebHandler Language="C#" Class="Contactos" %>

using System;
using System.Collections.Generic;
using System.Globalization;
using System.Web;
using CarCheck.Gestores;
using Newtonsoft.Json.Linq;


public class Contactos : IHttpHandler
{

  public void ProcessRequest(HttpContext context)
  {
    context.Response.ContentType = "application/json";

    string method = CCSOL.Utiles.Utilidades.isNull(context.Request.Params["method"], "");
    string data = CCSOL.Utiles.Utilidades.isNull(context.Request.Params["data"], "");
    string JsonOutput = "";
    if (!String.IsNullOrEmpty(method) && !String.IsNullOrEmpty(data))
    {
      JObject o = JObject.Parse(data);
      switch (method)
      {
        case "ContactsByName":

          string type = (string)o["type"];
          string startsWith = (string)o["startsWith"];

          IList<ContactoDto> contactos = GestorContactos.FindByNameAndType(type, startsWith);
          JsonOutput = Newtonsoft.Json.JavaScriptConvert.SerializeObject(contactos);
          break;
        case "ContactById":
          string contactId = (string) o["conctactId"];

          int cId;
          if (Int32.TryParse(contactId,out cId))
          {
            ContactoDto contacto = GestorContactos.FindById(cId);
          }
          break;
      }
    }
    context.Response.Write(JsonOutput);

  }

  public bool IsReusable
  {
    get
    {
      return false;
    }
  }

}