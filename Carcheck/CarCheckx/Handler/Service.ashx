<%@ WebHandler Language="C#" Class="Service" %>

using System;
using System.Collections.Generic;
using System.Web;
using CarCheck.Gestores;
using CCSOL.Utiles;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

public enum Methods
{
  ContactsByName,
  ContactById
}

public class Service : IHttpHandler
{
  private const string Json = "json";
  private const string Method = "method";

  public void ProcessRequest(HttpContext context)
  {
    HttpResponse response = context.Response;
    HttpRequest request = context.Request;

    response.ContentType = "application/json";
    
    string method = Utilidades.isNull(request.Params[Method], string.Empty);
    string json = Utilidades.isNull(request.Params[Json], string.Empty);

    string jsonRespone = ProcessMethod(method, json);

    response.Write(jsonRespone);

  }

  private static string ProcessMethod(string method, string json)
  {
    string outString = string.Empty;
    if (!string.IsNullOrEmpty(method) && !string.IsNullOrEmpty(json))
    {
      JObject o = JObject.Parse(json);
      if (o != null && Enum.IsDefined(typeof(Methods), method))
      {
        object outObj = null;
        Methods currentMethod = (Methods)Enum.Parse(typeof(Methods), method, true);
        switch (currentMethod)
        {
          case Methods.ContactsByName:
            string type = (string)o["type"];
            string startsWith = (string)o["startsWith"];

            IList<ContactoDto> contactos = GestorContactos.FindByNameAndType(type, startsWith);
            outObj = contactos;
            break;
          case Methods.ContactById:
            string contactId = (string)o["conctactId"];
            int cId;
            if (Int32.TryParse(contactId, out cId))
            {
              ContactoDto contacto = GestorContactos.FindById(cId);
              outObj = contacto;
            }
            
            break;
          
        }

        if (outObj != null) outString = JavaScriptConvert.SerializeObject(outObj);
      }
    }
    return outString;
  }

  public bool IsReusable
  {
    get
    {
      return false;
    }
  }

}