using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using AjaxCanales.Utiles;

public partial class test_testWebFormUpdateByCallBack : System.Web.UI.Page
{
  #region callbacks

  public EventControl handlerForCallBacks = new EventControl();
  public int num = 0;

  protected void Page_Init(object sender, EventArgs e)
  {
    handlerForCallBacks.ScriptCallback += new EventControl.delScriptCallBack(handlerForCallBacks_ScriptCallback);
    this.AddParsedSubObject(handlerForCallBacks);
  }

  public string handlerForCallBacks_ScriptCallback(CallbackEventArgs eventArgument)
  {
    char[] splitter = { '$' };

    string[] parms = Convert.ToString(eventArgument.Parameters[0]).Split(splitter);
    string action = parms[0];
    try
    {
      if (action == "Edit")
      {
        this.GridView1.EditIndex = Convert.ToInt32(parms[1]);
      }
      if (action == "Update")
      {
        this.GridView1.UpdateRow(Convert.ToInt32(parms[1]), true);
      }
      if (action == "Delete")
      {
        this.GridView1.DeleteRow(Convert.ToInt32(parms[1]));
      }
      if (action == "Cancel")
      {
        this.GridView1.EditIndex = -1;
      }
    }
    catch (Exception ex)
    {
      LoggerFacade.LogException(ex);
    }

    this.GridView1.DataBind();
    return CCSOL.Utiles.Utilidades.getHTML(this.GridView1);

  }

  #endregion

  protected void Page_Load(object sender, EventArgs e)
  {

  }
  protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
  {
    string giro = Request.Form[this.GridView1.Rows[e.RowIndex].UniqueID + "$txtOcupacionGiro"];
    e.NewValues["ocupacionGiro"] = giro;
  }
}
