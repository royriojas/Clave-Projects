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
using CarCheck.Gestores;
using CarCheck;
using CCSOL.Utiles;

public partial class ucSecurityController : System.Web.UI.UserControl
{
  private string _mainFormName = "form1";
  public string MainFormName
  {
    get
    {
      return _mainFormName;
    }
    set
    {
      _mainFormName = value;
    }
  }
  public string PageFunctionalityToCheck
  {
    get
    {
      return pageFunctionalityToCheck;
    }
    set
    {
      pageFunctionalityToCheck = value;
    }
  }
  private string pageFunctionalityToCheck;

  private string _path = null;
  public string Path
  {
    get
    {
      return _path;
    }
    set
    {
      _path = value;
    }
  }

  public string GetRelativePath(object scriptPath)
  {
    if (string.IsNullOrEmpty(Path)) return scriptPath.ToString();
    else return String.Format("{0}/{1}", Path, scriptPath.ToString());
  }

  protected void Page_Load(object sender, EventArgs e)
  {
    AjaxPro.Utility.RegisterTypeForAjax(typeof(GestorSeguridad));

    isAValidUserSession();
    if (!IsPostBack) verifyPermission();
    verifyPageElementsPermission();
  }


  private void isAValidUserSession()
  {
    UserData ud = (UserData)Session["userData"];
    if (String.IsNullOrEmpty(Path)) Utilidades.redirectToUrlWhenIsNull(ud, this.Request.RawUrl);
    else Utilidades.redirectToUrlWhenIsNull(ud, this.Request.RawUrl, Path);
  }

  private void verifyPermission()
  {
    if (!GestorSeguridad.hasPermision(this.PageFunctionalityToCheck))
    {
      if (String.IsNullOrEmpty(Path)) Utilidades.redirectToUrlAndShowMessage(this.Request.RawUrl, SettingManager.ERR_MSG_USER_HAS_NO_PERMISSION);
      else Utilidades.redirectToUrlAndShowMessage(this.Request.RawUrl, SettingManager.ERR_MSG_USER_HAS_NO_PERMISSION, Path);
    }
  }



  private void iterateThrowControls(ControlCollection ctrlCollection)
  {
    foreach (Control c in ctrlCollection)
    {
      if (c.GetType().ToString() == "xWebControl.xWebPanelControl")
      {
        xWebControl.xWebPanelControl wp = (xWebControl.xWebPanelControl)c;

        verifyElementPermission(wp);
      }
      else
      {
        if (c.HasControls())
        {
          iterateThrowControls(c.Controls);
        }
      }
    }
  }
  private void verifyPageElementsPermission()
  {
    if (this.MainFormName != "")
    {
      try
      {
        ControlCollection ctrlCollection = this.Parent.FindControl(this.MainFormName).Controls;
        iterateThrowControls(ctrlCollection);
      }
      catch (Exception ex)
      {
        LoggerFacade.LogException(ex);
      }
    }
  }

  private void verifyElementPermission(xWebControl.xWebPanelControl xWebPanelControl)
  {
    if (xWebPanelControl.PermissionToCheck != "") xWebPanelControl.Visible = GestorSeguridad.hasPermision((UserData)Session["userData"], xWebPanelControl.PermissionToCheck);
  }

}
