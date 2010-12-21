using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

namespace AjaxCanales.Utiles
{
  /// <summary>
  /// Summary description for EventControl
  /// </summary>
  public class EventControl : Control, ICallbackEventHandler
  {
    public delegate string delScriptCallBack(CallbackEventArgs eventArgument);

    public event delScriptCallBack ScriptCallback;
    string result;

    #region ICallbackEventHandler Members

    public string GetCallbackResult()
    {
      //throw new Exception("The method or operation is not implemented.");
      return result;
    }

    public void RaiseCallbackEvent(string eventArgument)
    {
      if (this.ScriptCallback != null)
      {
        CallbackEventArgs arg = new CallbackEventArgs(eventArgument);
        result = ScriptCallback(arg);
      }
      else
        throw new Exception("The method or operation is not implemented.");
    }

    #endregion
  }
}
