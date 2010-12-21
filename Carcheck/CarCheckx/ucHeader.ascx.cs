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
using CarCheck.Enums;
using CCSOL.Utiles;
using CarCheck.Gestores;
using CarCheck;
using AjaxPro;


public partial class ucHeader : System.Web.UI.UserControl
{

  #region properties





  public HeaderLinks TabActual
  {
    get
    {
      return this.tabActual;
    }
    set
    {
      this.tabActual = value;
    }
  }
  private HeaderLinks tabActual = HeaderLinks.listaInspecciones;



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

  #endregion

  protected void Page_Load(object sender, EventArgs e)
  {
    AjaxPro.Utility.RegisterTypeForAjax(typeof(GestorSeguridad));
    PutUserDataLabels();
    isAValidUserSession();
    #region setActualTab
    switch (TabActual)
    {
      case HeaderLinks.listaSolicitudes: this.lnkListaSolicitudes.CssClass = "MenuItemOver";
        break;
      case HeaderLinks.listaInspecciones: this.lnkListaInspecciones.CssClass = "MenuItemOver";
        break;
      case HeaderLinks.valoresComerciales: this.lnkValores.CssClass = "MenuItemOver";
        break;
      case HeaderLinks.agenda: this.lnkAgenda.CssClass = "MenuItemOver";
        break;
      case HeaderLinks.reportes: this.lnkReportes.CssClass = "MenuItemOver";
        break;
      case HeaderLinks.estadistica: this.lnkEstadistica.CssClass = "MenuItemOver";
        break;
      case HeaderLinks.opciones: this.lnkEstadistica.CssClass = "MenuItemOver";
        break;
      case HeaderLinks.ampliatorios: this.lnkAmpliatorios.CssClass = "MenuItemOver";
        break;

      default:
        break;
    }
    #endregion
    checkVisibleOptions();

    if (!IsPostBack) verifyPermission();

    verifyPageElementsPermission();
  }

  private void checkVisibleOptions()
  {
    this.lnkAgenda.Visible =
     this.SepAgenda.Visible = GestorSeguridad.hasPermision(Funcionalidades.AGENDA_VER);

    this.lnkListaSolicitudes.Visible =
    this.SepSolicitud.Visible = GestorSeguridad.hasPermision(Funcionalidades.SOLICITUD_LISTA_VER);

    this.lnkListaInspecciones.Visible =
    this.SepInspeccion.Visible = GestorSeguridad.hasPermision(Funcionalidades.INSPECCION_LISTA_VER);

    this.lnkPanelDeControl.Visible =
      this.SepPanelControl.Visible = GestorSeguridad.hasPermision(Funcionalidades.PANEL_DE_CONTROL_VER);

    this.lnkValores.Visible =
       this.SepValores.Visible = GestorSeguridad.hasPermision(Funcionalidades.VALOR_COMERCIAL_VER);

    this.lnkReportes.Visible =
    this.SepReportes.Visible = GestorSeguridad.hasPermision(Funcionalidades.REPORTES_VER);


    this.lnkAmpliatorios.Visible =
      this.SepAmpliatorios.Visible = GestorSeguridad.hasPermision(Funcionalidades.AMPLIATORIO_LISTA_VER);

    this.lnkEstadistica.Visible =
      this.SepEstadisticas.Visible = GestorSeguridad.hasPermision(Funcionalidades.ESTADISTICAS_VER);



  }

  private void PutUserDataLabels()
  {
    try
    {
      UserData ud = GestorSeguridad.getUserData();
      this.lblCia.Text = ud.CiaName;
      this.lblUserName.Text = ud.Persona;// +"   |   " + ud.UserRolName;

      string DatosDeUsuarioTable = "<TABLE STYLE=\"FONT-SIZE:10PX;COLOR:#993300;\" WIDTH=\"300\" BORDER=\"0\" CELLSPACING=\"0\" CELLPADDING=\"0\"><TR><TD HEIGHT='13PX;' WIDTH=\"70\" ALIGN=\"LEFT\" VALIGN=\"TOP\"><STRONG>NOMBRE</STRONG></TD><TD WIDTH=\"10\" ALIGN=\"LEFT\" VALIGN=\"TOP\" ><STRONG>:</STRONG></TD><TD WIDTH=\"290\" ALIGN=\"LEFT\" VALIGN=\"TOP\" >{0}</TD></TR><TR><TD HEIGHT='13PX;' ALIGN=\"LEFT\" VALIGN=\"TOP\"><STRONG>USUARIO </STRONG></TD><TD ALIGN=\"LEFT\" VALIGN=\"TOP\"><STRONG>:</STRONG></TD><TD ALIGN=\"LEFT\" VALIGN=\"TOP\">{1}</TD></TR><TR><TD HEIGHT='13PX;' ALIGN=\"LEFT\" VALIGN=\"TOP\"><STRONG>ROL</STRONG></TD><TD ALIGN=\"LEFT\" VALIGN=\"TOP\"><STRONG>:</STRONG></TD><TD ALIGN=\"LEFT\" VALIGN=\"TOP\">{2}</TD></TR><TR><TD ALIGN=\"LEFT\" VALIGN=\"TOP\"><STRONG>COMPA&Ntilde;&Iacute;A</STRONG></TD><TD ALIGN=\"LEFT\" VALIGN=\"TOP\"><STRONG>:</STRONG></TD><TD ALIGN=\"LEFT\" VALIGN=\"TOP\">{3}</TD></TR></TABLE>";

      this.userIco.Attributes["tt_title"] = "<div  style='margin:2px; width:300px;font-weight:bold;font-size:10px; height:15px;color:#993300;'>DATOS DE USUARIO</div>";
      this.userIco.Attributes["tt_text"] = String.Format(DatosDeUsuarioTable, ud.Persona, ud.UserName, ud.UserRolName, ud.CiaName);

    }
    catch (Exception ex)
    {
      LoggerFacade.LogException(ex);
      this.lblCia.Visible = this.lblUserName.Visible = false;
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

  private void verifyPermission()
  {
    if (!GestorSeguridad.hasPermision(this.PageFunctionalityToCheck))
    {
      Utilidades.redirectToUrlAndShowMessage(this.Request.RawUrl, SettingManager.ERR_MSG_USER_HAS_NO_PERMISSION);
    }
  }

  private void isAValidUserSession()
  {
    UserData ud = (UserData)Session["userData"];
    Utilidades.redirectToUrlWhenIsNull(ud, this.Request.RawUrl);
  }

  protected void logoutLinkButton_Click(object sender, EventArgs e)
  {
    Session.Abandon();
    Response.Redirect("vLogIn.aspx", true);
  }



}
