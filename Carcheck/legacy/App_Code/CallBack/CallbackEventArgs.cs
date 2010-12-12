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

namespace AjaxCanales.Utiles
{
  /// <summary>
  /// Summary description for CallBackEventArgs
  /// </summary>
  public class CallbackEventArgs : EventArgs
  {
    private ArrayList arrArgumentos;
    public CallbackEventArgs()
    {
      arrArgumentos = new ArrayList();

      int a = 1;
      //
      // TODO: Add constructor logic here
      //
    }

    public CallbackEventArgs(string eventArgument)
    {
      string[] arg = eventArgument.Split('~');
      arrArgumentos = new ArrayList();
      //for (int i = 0; i < arg.Length - 1; i++)
      for (int i = 0; i < arg.Length; i++)
      {
        arrArgumentos.Add(arg[i]);
      }
    }

    public void Add(string cadena)
    {
      arrArgumentos.Add(cadena);
    }

    public ArrayList Parameters
    {
      get
      {
        return arrArgumentos;
      }
    }
  }
}
