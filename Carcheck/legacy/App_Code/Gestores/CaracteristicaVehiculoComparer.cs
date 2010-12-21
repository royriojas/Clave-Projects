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

  public class CaracteristicaVehiculoComparer : IComparer<CaracteristicaVehiculo>
  {
    #region IComparer<CaracteristicaVehiculo> Members

    int IComparer<CaracteristicaVehiculo>.Compare(CaracteristicaVehiculo x, CaracteristicaVehiculo y)
    {
      return x.order - y.order;
    }

    #endregion
  }

}
