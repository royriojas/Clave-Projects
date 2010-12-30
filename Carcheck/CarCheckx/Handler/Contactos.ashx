<%@ WebHandler Language="C#" Class="Contactos" %>

using System;
using System.Collections.Generic;
using System.Web;
using CarCheck.Gestores;
using Newtonsoft.Json.Linq;


public class Contactos : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "application/json";

        string method = CCSOL.Utiles.Utilidades.isNull(context.Request.QueryString["method"], "");
        string data = CCSOL.Utiles.Utilidades.isNull(context.Request.QueryString["data"], "");
        string JsonOutput = "";
        if (!String.IsNullOrEmpty(method) && !String.IsNullOrEmpty(data))
        {
            switch (method)
            {
                case "ContactsByName":
                    JObject o = JObject.Parse(data);
                    string type = (string) o["type"];
                    string startsWith = (string) o["startsWith"];

                    IList<ContactoDto> contactos = GestorContactos.FindByNameAndType(type, startsWith);
                    JsonOutput = Newtonsoft.Json.JavaScriptConvert.SerializeObject(contactos);
                    break;
                case "ContactById":

                    break;
            }
        }
        context.Response.Write(JsonOutput);

    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}