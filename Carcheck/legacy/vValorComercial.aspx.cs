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
using AjaxPro;
using CarCheck.Gestores;
using CCSOL.Utiles;
using CarCheck;

public partial class vValorComercial : System.Web.UI.Page
{
  protected void Page_Load(object sender, EventArgs e)
  {
    AjaxPro.Utility.RegisterTypeForAjax(typeof(vValorComercial));   
  }

  [AjaxPro.AjaxMethod]
  public OptionItem[] getMarcasVehiculo(string claseId)
  {
    return GestorCombos.getMarcasVehiculo(claseId);
  }
  [AjaxPro.AjaxMethod]
  public valorComerical getValorComercial(string claseId, string marcaId, string modelo, string anhoFabricacion)
  {

    valorComerical salida = new valorComerical();
    ADM_DAL.dsADMTableAdapters.ValorComercialTableAdapter vcTa = new ADM_DAL.dsADMTableAdapters.ValorComercialTableAdapter();
    ADM_DAL.dsADM.ValorComercialDataTable vcDt = new ADM_DAL.dsADM.ValorComercialDataTable();
    DateTime fecha = new DateTime(Convert.ToInt32(anhoFabricacion), 1, 1);
    try
    {
      vcDt = vcTa.GetData(fecha, Convert.ToInt32(marcaId), Convert.ToInt32(modelo), Convert.ToInt32(claseId));
      if (vcDt.Rows.Count > 0)
      {

        ADM_DAL.dsADM.ValorComercialRow row = (ADM_DAL.dsADM.ValorComercialRow)vcDt.Rows[0];
        salida.valor = "" + row.valorComercial;
        salida.moneda = "" + row.simbolo;
        salida.monedaId = "" + row.monedaId;

      }
    }
    catch (Exception ex)
    {
      LoggerFacade.LogException(ex);
    }
    return salida;
  }
  
  [AjaxPro.AjaxMethod]
  public OptionItem[] getModelosVehiculo(string claseId, string marcaId)
  {    
    return GestorCombos.getModelosVehiculo(claseId, marcaId);
  }

}
