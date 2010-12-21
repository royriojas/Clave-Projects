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
using System.Collections.Generic;

public partial class ucNotifier : System.Web.UI.UserControl
{

  private string _triggerID;
  public string TriggerID
  {
    get
    {
      return _triggerID;
    }
    set
    {
      _triggerID = value;
    }
  }

  public string ControlClientId
  {
    get
    {
      return this.ClientID;
    }
  }


  #region CallBacks

  public EventControl callback_mailer = new EventControl();

  protected void Page_Init(object sender, EventArgs e)
  {
    callback_mailer.ScriptCallback += new EventControl.delScriptCallBack(callback_mailer_ScriptCallback);
    this.AddParsedSubObject(callback_mailer);
  }

  public string callback_mailer_ScriptCallback(CallbackEventArgs eventArgument)
  {
    performSend();
    return "done";
  }

  private void performSend()
  {
    char[] splitter = { ';', ',' };

    String[] dirsPara = this.txtPara.Text.Split(splitter, StringSplitOptions.RemoveEmptyEntries);
    String[] dirsCC = this.txtCC.Text.Split(splitter, StringSplitOptions.RemoveEmptyEntries);
    List<String> direcciones = new List<String>();
    direcciones.AddRange(dirsPara);
    direcciones.AddRange(dirsCC);

    if (this.chkAdminMail.Checked)
    {
      String[] dirsAdmin = this.txtAdminMail.Text.Split(splitter, StringSplitOptions.RemoveEmptyEntries);
      direcciones.AddRange(dirsAdmin);      
    }

    SimpleMailer.MailerFacade.MailerFacade.sendMail(direcciones, "notificación", this.txtBodyMail.Text);
      
  }


  #endregion



  protected void Page_Load(object sender, EventArgs e)
  {
    this.txtAdminMail.Text = ConfigurationManager.AppSettings["ADMIN_MAIL"];
    this.chkAdminMail.Attributes["ctrl_to_enable"] = this.txtAdminMail.ClientID;
  }
}
