using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using AjaxPro;
using System.Collections.Generic;
using CCSOL.Utiles;

namespace CarCheck.Gestores
{

  public class CaracteristicaVehiculo
  {
    public int order;
    public string caracteristicaId = null;
    public string valor = null;
    public string valorCaracteristicaId = null;

    public CaracteristicaVehiculo()
    {
    }

  }

}
