using System;
using System.Data;
using System.Data.OleDb;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;



using ASB;
using System.Collections.Generic;
using ADM_DAL.dsDropDownListTableAdapters;
using ADM_DAL;


public partial class GetAutoSuggestData : System.Web.UI.Page
{
  private string msTextBoxID;
  private string msMenuDivID;
  private string msDataType;
  private int mnNumMenuItems;
  private bool mbIncludeMoreMenuItem;
  private string msMenuItemCSSClass;
  private string msMoreMenuItemLabel;
  private string msKeyword;

  private List<String> msFilters;
  private Boolean msOnFocusShowAll;

  //Generate menu and return it
  private void Page_Load(object sender, System.EventArgs e)
  {

    //Turn off cache
    Response.Cache.SetCacheability(HttpCacheability.NoCache);

    msTextBoxID = Request.QueryString["TextBoxID"];
    msMenuDivID = Request.QueryString["MenuDivID"];
    msDataType = Request.QueryString["DataType"];
    mnNumMenuItems = Convert.ToInt32(Request.QueryString["NumMenuItems"]);
    mbIncludeMoreMenuItem = Convert.ToBoolean(Request.QueryString["IncludeMoreMenuItem"]);
    msMoreMenuItemLabel = Request.QueryString["MoreMenuItemLabel"];
    msMenuItemCSSClass = Request.QueryString["MenuItemCSSClass"];
    msKeyword = Request.QueryString["Keyword"];


    //RRRM - 13-08-2006
    //la combinación de campos de DATATYPE y FILTERS nos permite manejar el caso que se quiera hacer un select filtrando algo por algunos criterios
    //queda de todos modos bajo criterio del programador conocer el orden de los parámetros y el tipo de los mismos.
    this.msFilters = new List<string>();
    if (!String.IsNullOrEmpty(Request.QueryString["Filters"]))
    {
      String[] tempFilters = Request.QueryString["Filters"].Trim().Split(new char[] { ',', ';', '|' }, StringSplitOptions.RemoveEmptyEntries);
      foreach (String s in tempFilters)
      {
        this.msFilters.Add(s);
      }
    }

    msOnFocusShowAll = Convert.ToBoolean(Request.QueryString["OnFocusShowAll"]);

    //Get menu item labels and values
    ArrayList aMenuItems = LoadMenuItems();

    //Generate html and write it to the page
    string sHtml = AutoSuggestBox.GenMenuItemsHtml(aMenuItems,
                                                    msTextBoxID,
                                                    mnNumMenuItems,
                                                    mbIncludeMoreMenuItem,
                                                    msMoreMenuItemLabel,
                                                    msMenuItemCSSClass);
    Response.Write(sHtml);
  }


  /// <summary>Get all cities that contain specified keyword</summary>
  /// <param name="sKeyword">Keyword to use in a query</param>
  /// <returns></returns>


  private ArrayList loadUbigeo()
  {
    ArrayList aOut = new ArrayList();

    ASBMenuItem oMenuItem;
    UbigeoAutoCompleteTableAdapter ubigeoTA = new UbigeoAutoCompleteTableAdapter();
    dsDropDownList.UbigeoAutoCompleteDataTable ubigeoDataTable = ubigeoTA.GetData(msKeyword.Replace("'", "''"), mnNumMenuItems);

    foreach (dsDropDownList.UbigeoAutoCompleteRow distrito in ubigeoDataTable)
    {
      oMenuItem = new ASBMenuItem();
      oMenuItem.Label = distrito.ubigeo;
      oMenuItem.Value = distrito.ubigeoId.ToString();

      aOut.Add(oMenuItem);

    }

    return aOut;

  }


  private ArrayList loadBrokers()
  {

    ArrayList aOut = new ArrayList();

    ADM_DAL.dsDropDownListTableAdapters.BrokerAutoCompleteByNameTableAdapter myTa = new BrokerAutoCompleteByNameTableAdapter();
    ADM_DAL.dsDropDownList.BrokerAutoCompleteByNameDataTable myDT = myTa.GetData(msKeyword.Replace("'", "''"), mnNumMenuItems);

    ASBMenuItem oMenuItem;

    foreach (ADM_DAL.dsDropDownList.BrokerAutoCompleteByNameRow fila in myDT)
    {
      oMenuItem = new ASBMenuItem();
      oMenuItem.Label = fila.persona;
      oMenuItem.Value = fila.personaId.ToString();
      aOut.Add(oMenuItem);
    }


    /*
            dsComboTableAdapters.brokerPorNombreTableAdapter asTa = new dsComboTableAdapters.brokerPorNombreTableAdapter();
            dsCombo.brokerPorNombreDataTable asDt = asTa.GetData(msKeyword.Replace("'", "''"));

            ASBMenuItem oMenuItem;

            foreach (dsCombo.brokerPorNombreRow fila in asDt)
            {
                oMenuItem = new ASBMenuItem();
                oMenuItem.Label = fila.persona;
                oMenuItem.Value = fila.personaId.ToString();

                aOut.Add(oMenuItem);

            }
    */
    return aOut;
  }
  private ArrayList loadAsegurados()
  {
    ArrayList aOut = new ArrayList();

    /*
    dsComboTableAdapters.AseguradoPorNombreTableAdapter asTa = new dsComboTableAdapters.AseguradoPorNombreTableAdapter();
    dsCombo.AseguradoPorNombreDataTable asDt = asTa.GetData(msKeyword.Replace("'", "''"));
    */

    dsASBTableAdapters.ASEGURADOTableAdapter asTa = new dsASBTableAdapters.ASEGURADOTableAdapter();
    dsASB.ASEGURADODataTable asDt = asTa.GetDataBy(msKeyword.Replace("'", "''"));


    ASBMenuItem oMenuItem;

    foreach (dsASB.ASEGURADORow fila in asDt)
    {
      oMenuItem = new ASBMenuItem();
      oMenuItem.Label = fila.persona;
      oMenuItem.Value = fila.personaId.ToString();

      aOut.Add(oMenuItem);

    }

    return aOut;

  }

  /// <summary>Load array of ASBMenuItems for a specific data type</summary>
  /// <param name="sDataType"></param>
  /// <param name="sKeyword"></param>
  /// <returns></returns>
  private ArrayList LoadMenuItems()
  {
    ArrayList aMenuItems;

    switch (msDataType)
    {
      case "Distrito":
        aMenuItems = this.loadUbigeo();
        break;
      case "Asegurado":
        aMenuItems = this.loadAsegurados();
        break;
      case "Contratante":
        aMenuItems = this.loadContratantes();
        break;

      case "Contacto":
        aMenuItems = this.loadContactos();
        break;

      case "Broker":
        aMenuItems = this.loadBrokers();
        break;

      case "Inspector":
        aMenuItems = this.loadInspectores();
        break;

      case "MarcaVehiculo":
        aMenuItems = this.loadMarcaVehiculos();
        break;
      default:
        throw new Exception("GetAutoSuggestData  Type '" + msDataType + "' is not supported.");
        break;
    }

    return aMenuItems;
  }

  private ArrayList loadMarcaVehiculos()
  {
    ArrayList aOut = new ArrayList();

    MarcaVehiculoAutoCompleteByNameTableAdapter myTa = new MarcaVehiculoAutoCompleteByNameTableAdapter();
    dsDropDownList.MarcaVehiculoAutoCompleteByNameDataTable myDt = myTa.GetData(msKeyword.Replace("'", "''"), mnNumMenuItems);

    ASBMenuItem oMenuItem;

    foreach (ADM_DAL.dsDropDownList.MarcaVehiculoAutoCompleteByNameRow row in myDt)
    {
      oMenuItem = new ASBMenuItem();
      oMenuItem.Label = row.marcaVehiculo;
      oMenuItem.Value = row.marcaVehiculoId.ToString();

      aOut.Add(oMenuItem);

    }

    return aOut;
  }

  private ArrayList loadInspectores()
  {
    ArrayList aOut = new ArrayList();

    dsASBTableAdapters.INSPECTORTableAdapter asTa = new dsASBTableAdapters.INSPECTORTableAdapter();
    dsASB.INSPECTORDataTable asDt = asTa.GetData(msKeyword.Replace("'", "''"));


    ASBMenuItem oMenuItem;

    foreach (dsASB.INSPECTORRow fila in asDt)
    {
      oMenuItem = new ASBMenuItem();
      oMenuItem.Label = fila.persona;
      oMenuItem.Value = fila.PersonaId.ToString();

      aOut.Add(oMenuItem);

    }

    return aOut;
  }

  private ArrayList loadContactos()
  {
    ArrayList aOut = new ArrayList();
    dsASBTableAdapters.CONTACTOTableAdapter ContactoTa = new dsASBTableAdapters.CONTACTOTableAdapter();
    dsASB.CONTACTODataTable ContactoDT = ContactoTa.GetData(msKeyword.Replace("'", "''"), mnNumMenuItems);

    ASBMenuItem oMenuItem;

    foreach (dsASB.CONTACTORow contacto in ContactoDT)
    {
      oMenuItem = new ASBMenuItem();
      oMenuItem.Label = contacto.contacto;
      oMenuItem.Value = contacto.contactoId.ToString();

      aOut.Add(oMenuItem);

    }

    return aOut;

  }

  private ArrayList loadContratantes()
  {
    ArrayList aOut = new ArrayList();

    PersonaAutoCompleteByNameTableAdapter contratanteTA = new PersonaAutoCompleteByNameTableAdapter();
    dsDropDownList.PersonaAutoCompleteByNameDataTable contratanteDT = contratanteTA.GetData(msKeyword.Replace("'", "''"), mnNumMenuItems);
    ASBMenuItem oMenuItem;

    foreach (dsDropDownList.PersonaAutoCompleteByNameRow contratatante in contratanteDT)
    {
      oMenuItem = new ASBMenuItem();
      oMenuItem.Label = contratatante.persona;
      oMenuItem.Value = contratatante.personaId.ToString();

      aOut.Add(oMenuItem);

    }

    return aOut;

  }

}
