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
using CarCheck.Gestores;

public partial class ucControlTab : System.Web.UI.UserControl
{
  private CCK_TabLink tabActual = CCK_TabLink.DatosPersonales;
  private String labelText;
  public string VehiculoId;

  public String LabelText
  {
    get { return labelText; }
    set { labelText = value; }
  }

  public CCK_TabLink TabActual
  {
    get { return tabActual; }
    set { tabActual = value; }
  }
  private void setNavigationRoutes()
  {
    this.DatosPersonalesCenterTab.Attributes["onclick"] = String.Format("CCSOL.Utiles.Redirect('vFIDatosPersonales.aspx?VehiculoId={0}');", VehiculoId);
    this.DatosVehiculoCenterTab.Attributes["onclick"] = String.Format("CCSOL.Utiles.Redirect('vFIDatosVehiculo.aspx?VehiculoId={0}');", VehiculoId);
    this.CaracteristicasCenterTab.Attributes["onclick"] = String.Format("CCSOL.Utiles.Redirect('vFICaracteristicas.aspx?VehiculoId={0}');", VehiculoId);
    this.LlantasCenterTab.Attributes["onclick"] = String.Format("CCSOL.Utiles.Redirect('vFILlantas.aspx?VehiculoId={0}');", VehiculoId);
    this.DamageCenterTab.Attributes["onclick"] = String.Format("CCSOL.Utiles.Redirect('vFIDamage.aspx?VehiculoId={0}');", VehiculoId);
    this.ImagenesCenterTab.Attributes["onclick"] = String.Format("CCSOL.Utiles.Redirect('vFIImages.aspx?VehiculoId={0}');", VehiculoId);
  }
  protected void Page_Load(object sender, EventArgs e)
  {
    this.VehiculoId = Request.QueryString["VehiculoId"];
    setTabActual();
    //this.InspeccionLabel.Text = this.labelText;

    this.InspeccionLabel.Text = "Inspección : " + GestorInspeccion.getInspeccionNumber(VehiculoId);

    if (!String.IsNullOrEmpty(VehiculoId))
    {
      setNavigationRoutes();

      this.divIsAnulada.Visible = getIsAnulada();
      
    }
  }

  private void setTabActual()
  {

    switch (TabActual)
    {


      case CCK_TabLink.DatosPersonales:
        this.DatosPersonalesCenterTab.Attributes["class"] = "itemCenterTab";
        this.DatosPersonalesLeftTab.Attributes["class"] = "itemLeftTab";
        this.DatosPersonalesRightTab.Attributes["class"] = "itemRightTab";
        break;
      case CCK_TabLink.DatosVehiculo:
        this.DatosVehiculoCenterTab.Attributes["class"] = "itemCenterTab";
        this.DatosVehiculoLeftTab.Attributes["class"] = "itemLeftTab";
        this.DatosVehiculoRightTab.Attributes["class"] = "itemRightTab";


        break;
      case CCK_TabLink.Caracteristicas:
        this.CaracteristicasCenterTab.Attributes["class"] = "itemCenterTab";
        this.CaracteristicasLeftTab.Attributes["class"] = "itemLeftTab";
        this.CaracteristicasRightTab.Attributes["class"] = "itemRightTab";



        break;
      case CCK_TabLink.Llantas:
        this.LlantasCenterTab.Attributes["class"] = "itemCenterTab";
        this.LlantasLeftTab.Attributes["class"] = "itemLeftTab";
        this.LlantasRightTab.Attributes["class"] = "itemRightTab";



        break;
      case CCK_TabLink.Damage:
        this.DamageCenterTab.Attributes["class"] = "itemCenterTab";
        this.DamageLeftTab.Attributes["class"] = "itemLeftTab";
        this.DamageRightTab.Attributes["class"] = "itemRightTab";




        break;
      case CCK_TabLink.Imagenes:
        this.ImagenesCenterTab.Attributes["class"] = "itemCenterTab";
        this.ImagenesLeftTab.Attributes["class"] = "itemLeftTab";
        this.ImagenesRightTab.Attributes["class"] = "itemRightTab";



        break;

    }
  }
  public bool getIsAnulada()
  {
    decimal vId = Convert.ToDecimal(VehiculoId);
    decimal? InsId = GestorInspeccion.getInspeccionId(vId);

    return (GestorInspeccion.getEstadoInspeccion(Convert.ToDecimal(InsId)) == EstadoInspeccion.ANULADA); 
  }
}
