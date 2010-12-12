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

/// <summary>
/// Summary description for GestorInspeccion
/// </summary>
/// 

namespace CarCheck.Gestores
{
  public class valorComerical
  {
    public string valor = "";
    public string moneda = "";
    public string monedaId = "";
  }

  public class GestorInspeccion
  {
    public GestorInspeccion()
    {
      //
      // TODO: Add constructor logic here
      //
    }

    /// <summary>
    /// Determina la visualización de las opciones disponibles para el usuario
    /// </summary>
    /// <param name="uid">Identificacion del usuario</param>
    /// <param name="controlPanel">Panel donde se ubican los controles a determinar su presentacion</param>
    public static void SeguridadInspeccion(Object uid, Panel controlPanel)
    {
      if (uid != null)
      {
        int uidValue = int.Parse((string)uid);
        if (uidValue == 1)
        {
          ((ImageButton)controlPanel.FindControl("anularImageButton")).Visible = false;
          ((ImageButton)controlPanel.FindControl("aprobarImageButton")).Visible = false;
          ((ImageButton)controlPanel.FindControl("desaprobarImageButton")).Visible = false;
          ((ImageButton)controlPanel.FindControl("terminarImageButton")).Visible = true;
        }
        else if (uidValue == 2)
        {
          controlPanel.Visible = false;
        }
      }
    }

    public static string getInspeccionNumber(string VehiculoId)
    {
      decimal dec_VehiculoId;
      if (decimal.TryParse(VehiculoId, out dec_VehiculoId))
      {
        dsInspeccionesTableAdapters.QueriesTableAdapter myTa = new dsInspeccionesTableAdapters.QueriesTableAdapter();
        string num_inspeccion = "";
        myTa.GetInspeccionNumber(dec_VehiculoId,ref num_inspeccion);
        return num_inspeccion.ToString();
      }
      return "";
    }

    [AjaxMethod]
    public string DamageInsert(string vehiculoId, string ubicacionDamageId, string descripcion, string uupdate)
    {
      string result = "";
      try
      {
        dsVehiculoTableAdapters.DamageVehiculoTableAdapter damageAdapter = new dsVehiculoTableAdapters.DamageVehiculoTableAdapter();
        damageAdapter.Insert(decimal.Parse(vehiculoId), decimal.Parse(ubicacionDamageId), uupdate, descripcion);
      }
      catch (Exception Ex)
      {
        result = Ex.Message;
      }

      return result;
    }

    [AjaxMethod]
    public string DamageUpdate(string vehiculoId, string ubicacionDamageId, string descripcion, string uupdate)
    {
      string result = "";
      try
      {
        dsVehiculoTableAdapters.DamageVehiculoTableAdapter damageAdapter = new dsVehiculoTableAdapters.DamageVehiculoTableAdapter();
        damageAdapter.Update(decimal.Parse(vehiculoId), decimal.Parse(ubicacionDamageId), uupdate, descripcion);
      }
      catch (Exception Ex)
      {
        result = Ex.Message;
      }

      return result;
    }

    [AjaxMethod]
    public string DamageDelete(string vehiculoId, string ubicacionDamageId)
    {
      string result = "";
      try
      {
        dsVehiculoTableAdapters.DamageVehiculoTableAdapter damageAdapter = new dsVehiculoTableAdapters.DamageVehiculoTableAdapter();
        damageAdapter.Delete(decimal.Parse(vehiculoId), decimal.Parse(ubicacionDamageId));
      }
      catch (Exception Ex)
      {
        result = Ex.Message;
      }

      return result;
    }


    [AjaxMethod]
    public string PropertyInsert(string vehiculoId, string masterPropiedadId, CaracteristicaVehiculo[] parametros, string uupdate)
    {
      string result = "";
      decimal? propiedadId = null;

      List<CaracteristicaVehiculo> caracteristicasList = new List<CaracteristicaVehiculo>();

      caracteristicasList.AddRange(parametros);

      if (caracteristicasList.Count > 1) caracteristicasList.Sort(new CaracteristicaVehiculoComparer());

      //parametros = caracteristicasList.ToArray();



      CaracteristicaVehiculo[] caracteristicas = new CaracteristicaVehiculo[parametros.Length - 1];
      CaracteristicaVehiculo observacion = new CaracteristicaVehiculo();
      int i = 0;
      foreach (CaracteristicaVehiculo caracteristica in caracteristicasList)
      {
        if (caracteristica.caracteristicaId == "0")
          observacion.valor = caracteristica.valor;
        else
        {
          caracteristicas[i] = caracteristica;
          i++;
        }
      }

      PropiedadVehiculoTableAdapters.PropiedadSelectTableAdapter propiedadAdapter = new PropiedadVehiculoTableAdapters.PropiedadSelectTableAdapter();
      propiedadAdapter.PropiedadInsert(ref propiedadId, decimal.Parse(vehiculoId), observacion.valor, decimal.Parse(masterPropiedadId), uupdate);

      foreach (CaracteristicaVehiculo caracteristica in caracteristicas)
      {
        int resultado;
        try
        {
          if (caracteristica.valorCaracteristicaId == null)
          {
            resultado = propiedadAdapter.CaracteristicaVehiculoInsert(propiedadId, decimal.Parse(vehiculoId), decimal.Parse(caracteristica.valor), decimal.Parse(caracteristica.caracteristicaId), decimal.Parse(masterPropiedadId), caracteristica.valor, uupdate);
          }
          else
          {
            resultado = propiedadAdapter.CaracteristicaVehiculoInsert(propiedadId, decimal.Parse(vehiculoId), decimal.Parse(caracteristica.valorCaracteristicaId), decimal.Parse(caracteristica.caracteristicaId), decimal.Parse(masterPropiedadId), caracteristica.valor, uupdate);
          }

        }
        catch (Exception exception)
        {
          string mensaje = exception.Message;
        }
      }
      return result;
    }

    [AjaxMethod]
    public string PropertyDelete(string vehiculoId, string masterPropiedadId)
    {
      string result = "";

      PropiedadVehiculoTableAdapters.PropiedadSelectTableAdapter propiedadAdapter = new PropiedadVehiculoTableAdapters.PropiedadSelectTableAdapter();
      propiedadAdapter.PropiedadVehiculoDelete(decimal.Parse(vehiculoId), decimal.Parse(masterPropiedadId));

      return result;
    }

  }
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

