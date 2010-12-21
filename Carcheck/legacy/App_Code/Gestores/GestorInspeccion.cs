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

/// <summary>
/// Summary description for GestorInspeccion
/// </summary>
/// 

namespace CarCheck.Gestores
{
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
        myTa.GetInspeccionNumber(dec_VehiculoId, ref num_inspeccion);
        return num_inspeccion.ToString();
      }
      return "";
    }


    public static string getInspeccionNumber(decimal inspeccionId)
    {

      dsInspeccionesTableAdapters.QueriesTableAdapter myTa = new dsInspeccionesTableAdapters.QueriesTableAdapter();
      string num_inspeccion = "";
      myTa.proc_Car_Inspeccion_getInspeccionNumber(inspeccionId, ref num_inspeccion);
      return num_inspeccion.ToString();

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


    public static Boolean DeleteInspeccion(int inspeccionId)
    {
      bool success = false;
      dsSolicitudTableAdapters.InspecionesSolicitudTableAdapter myTa = new dsSolicitudTableAdapters.InspecionesSolicitudTableAdapter();
      //obtenemos el estado 
      string estadoInspeccion = (string)myTa.GetUltimoEstadoInspeccion(Convert.ToDecimal(inspeccionId));

      if (estadoInspeccion == EstadoInspeccion.PENDIENTE || estadoInspeccion == EstadoInspeccion.REGISTRADA)
      {
        //este es un borrado fisico, posible solo cuando el estado de la inspección es pendiente o registrada
        success = myTa.Delete(Convert.ToDecimal(inspeccionId)) > 0;
      }
      return success;
    }

    public static Boolean setEstadoInspeccion(
            System.Nullable<decimal> inspeccionId,
            string estadoInspeccionId,
            System.Nullable<decimal> solicitudId,
            System.Nullable<decimal> motivoId,
            string observacion,
            string ucrea
      )
    {
      dsInspeccionesTableAdapters.QueriesTableAdapter qTa = new dsInspeccionesTableAdapters.QueriesTableAdapter();
      return qTa.setEstadoInspeccion(inspeccionId, estadoInspeccionId, solicitudId, motivoId, observacion, ucrea) > 0;
    }


    public static Boolean setEstadoInspeccion(
        System.Nullable<decimal> inspeccionId,
        string estadoInspeccionId,
        System.Nullable<decimal> solicitudId
  )
    {
      dsInspeccionesTableAdapters.QueriesTableAdapter qTa = new dsInspeccionesTableAdapters.QueriesTableAdapter();
      return qTa.setEstadoInspeccion(inspeccionId, estadoInspeccionId, solicitudId, EstadoInspeccion.Motivo.CAMBIO_AUTOMATICO_DE_ESTADO, SettingManager.MSG_AUTOMATIC_STATE_CHANGE, GestorSeguridad.getUserData().UserName) > 0;
    }


    public static Boolean AnularInspeccion(System.Nullable<decimal> inspeccionId,
            System.Nullable<decimal> solicitudId,
            System.Nullable<decimal> motivoId,
            string observacion,
            string ucrea)
    {

      bool isAnulada = GestorInspeccion.setEstadoInspeccion(inspeccionId, EstadoInspeccion.ANULADA, solicitudId, motivoId, observacion, ucrea);
      if (isAnulada)
      {
        //deben cancelarse todas las citas de la inspección
        GestorInspeccion.borraLasCitas(inspeccionId, solicitudId);
      }
      return isAnulada;
    }

    private static void borraLasCitas(decimal? inspeccionId, decimal? solicitudId)
    {
      dsAgendaTableAdapters.proc_Car_CitaLoadAllTableAdapter myTa = new dsAgendaTableAdapters.proc_Car_CitaLoadAllTableAdapter();
      myTa.proc_Car_CitasLogicalDeleteByInspeccionId(inspeccionId, GestorSeguridad.getUserData().UserName);
    }







    public static bool InspeccionIsAprobada(string inspeccionId)
    {
      decimal? inspeccionId_d = (decimal?)Convert.ToDecimal(inspeccionId);
      dsInspeccionesTableAdapters.QueriesTableAdapter qTa = new dsInspeccionesTableAdapters.QueriesTableAdapter();
      return Convert.ToBoolean(qTa.uf_Car_Inspeccion_IsSolicitudAprobada(inspeccionId_d));

    }

    public static decimal? getInspeccionId(decimal vehiculoId)
    {
      dsInspeccionesTableAdapters.QueriesTableAdapter qTa = new dsInspeccionesTableAdapters.QueriesTableAdapter();
      return Convert.ToDecimal(qTa.uf_getInspeccionIdByVehiculoId(vehiculoId));
    }

    public static decimal getVehiculoId(decimal inspeccionId)
    {
      dsInspeccionesTableAdapters.QueriesTableAdapter qTa = new dsInspeccionesTableAdapters.QueriesTableAdapter();
      return Convert.ToDecimal(qTa.uf_getVehiculoIdByInspeccionId(inspeccionId));
    }

    public static decimal getSolicitudId(decimal? inspeccionId)
    {
      dsInspeccionesTableAdapters.QueriesTableAdapter qTa = new dsInspeccionesTableAdapters.QueriesTableAdapter();
      return Convert.ToDecimal(qTa.uf_getSolicitudIdByInspeccionId(inspeccionId));
    }

    public static void ActualizarTAprobacionInspeccion(decimal inspeccionId, string tAprobacion)
    {
      dsInspeccionesTableAdapters.QueriesTableAdapter qTa = new dsInspeccionesTableAdapters.QueriesTableAdapter();
      qTa.proc_Car_AprobarInspeccion(inspeccionId, tAprobacion, GestorSeguridad.getUserData().UserName);
    }

    public static void Aprobar(decimal? inspeccionId, string tAprobacion)
    {
      decimal solicitudId = getSolicitudId(inspeccionId);

      if (GestorSeguridad.hasPermision(Funcionalidades.INSPECCION_INFORME_APROBAR))
      {
        //actualizar el campo del informe a Aprobado
        ActualizarFechaControlCalidad(inspeccionId);
        //actualizar el registro inspeccion tAprobacionId         
        ActualizarTAprobacionInspeccion(Convert.ToDecimal(inspeccionId), tAprobacion);
        //cambiar el estado a Terminado
        GestorInspeccion.setEstadoInspeccion(inspeccionId,
            EstadoInspeccion.TERMINADA,
            solicitudId,
            EstadoInspeccion.Motivo.CAMBIO_AUTOMATICO_DE_ESTADO,
            SettingManager.MSG_AUTOMATIC_STATE_CHANGE,
            GestorSeguridad.getUserData().UserName);

        // verificamos el estatus de la solicitud
        GestorSolicitud.SetProgresoAtencion(solicitudId);

      }
    }


    public static string getDatosCita(string inspeccionId, GridView comunicacionGridView)
    {
      try
      {
        string datosCita;
        dsInspeccionesTableAdapters.ComunicacionInspeccionTableAdapter dsCom = new dsInspeccionesTableAdapters.ComunicacionInspeccionTableAdapter();
        comunicacionGridView.DataSource = dsCom.GetData(Convert.ToInt32(inspeccionId));
        comunicacionGridView.DataBind();
        datosCita = "<div>" + Convert.ToString(dsCom.DatosCitaInspeccion(Convert.ToDecimal(inspeccionId))) + "</div>";
        string estadoIns = GestorInspeccion.getEstadoInspeccion(Convert.ToDecimal(inspeccionId));
        if (estadoIns == EstadoInspeccion.COORDINADA || estadoIns == EstadoInspeccion.REPROGRAMADA || estadoIns == EstadoInspeccion.TERMINADA)
        {
          return "<div>" + datosCita + Utilidades.getHTML(comunicacionGridView) + "</div>";
        }
        else
        {
          return "<div>" + datosCita + "</div>";
        }
      }
      catch (Exception ex)
      {
        LoggerFacade.LogException(ex);
        return "ERROR DURANTE LA LLAMADA A UN MÉTODO DEL SERVER";
      }
    }

    public static string getEstadoInspeccion(decimal inspeccionId)
    {
      return getEstadoInspeccion(inspeccionId, getSolicitudId(inspeccionId));
    }

    private static void ActualizarFechaControlCalidad(decimal? inspeccionId)
    {
      dsInspeccionesTableAdapters.QueriesTableAdapter qTa = new dsInspeccionesTableAdapters.QueriesTableAdapter();
      qTa.proc_Car_ActualizarFechaControlCalidadInspeccion(inspeccionId, GestorSeguridad.getUserData().UserName);
    }

    public static void TerminarInspeccion(decimal vehiculoId)
    {
      //Update sobre el campo terminadoInspector 
      //Update sobre la fecha en que esto ocurre
      dsInspeccionesTableAdapters.QueriesTableAdapter qTa = new dsInspeccionesTableAdapters.QueriesTableAdapter();
      qTa.proc_Car_InspeccionTerminadaInspector(getInspeccionId(vehiculoId), GestorSeguridad.getUserData().UserName);

    }

    public static void AprobarInspeccion(decimal vehiculoId, String tAprobacionId)
    {
      //Update sobre el campo aprobada
      //Update fecha control calidad
      //Update sobre aprobar la cita
      /*dsInspeccionesTableAdapters.QueriesTableAdapter qTa = new dsInspeccionesTableAdapters.QueriesTableAdapter();
      qTa.proc_Car_AprobarInspeccion(getInspeccionId(vehiculoId), tAprobacionId, GestorSeguridad.getUserData().UserName);*/

      Aprobar(getInspeccionId(vehiculoId), tAprobacionId);
    }

    internal static void getInspeccionesCountBySolicitudId(decimal solicitudId, out int total, out int atendidas)
    {
      dsInspeccionesTableAdapters.QueriesTableAdapter qTa = new dsInspeccionesTableAdapters.QueriesTableAdapter();

      total = Convert.ToInt32(qTa.uf_getNumeroInspeccionesBySolicitudId(solicitudId));
      atendidas = Convert.ToInt32(qTa.uf_getNumeroInspeccionesTerminadasBySolicitudId(solicitudId));
    }

    public static void ReprogramarSolicitud()
    {

    }

    public static bool FrustrarInspeccion(decimal citaId, decimal inspeccionId, decimal solicitudId, decimal motivoId, string observacion)
    {
      bool aValue = false;
      try
      {
        dsAgendaTableAdapters.QueriesTableAdapter qTa = new dsAgendaTableAdapters.QueriesTableAdapter();

        //frustramos la cita en cuestión 
        qTa.proc_Car_CitaFrustrada(citaId, inspeccionId, GestorSeguridad.getUserData().UserName);

        GestorInspeccion.setEstadoInspeccion(inspeccionId, EstadoInspeccion.FRUSTRADA, solicitudId);
        aValue = true;
      }
      catch (Exception ex)
      {
        LoggerFacade.LogException(ex);
      }
      return aValue;

    }

    public static void ReprogramarSolicitud(
      decimal inspeccionId,
      decimal solicitudId,
      string contacto,
      string direccion,
      string ubigeoId,
      string telefonocontacto,
      decimal inspectorId,
      DateTime fInicio,
      DateTime fFin,
      string observacion)
    {
      //frustramos todas las citas referidas a esta inspeccion
      dsAgendaTableAdapters.proc_Car_CitaInspeccionLoadAllTableAdapter myTa = new dsAgendaTableAdapters.proc_Car_CitaInspeccionLoadAllTableAdapter();
      myTa.proc_Car_CitasFrustradasParaReprogramar(inspeccionId, GestorSeguridad.getUserData().UserName);

      //insertamos la nueva cita, en car_cita y en car_citaInspeccion
      decimal? cId = GestorAgenda.RegistrarComunicacion(TipoComunicacion.DUMMY, DateTime.Now, "E", observacion, contacto, EstadoInspeccion.REPROGRAMADA, inspeccionId, solicitudId, true);
      GestorAgenda.RegistrarCita(inspeccionId, solicitudId, cId, fInicio, fFin, direccion, ubigeoId, inspectorId, contacto, telefonocontacto, observacion);
    }

    private static dsInspecciones.proc_Car_InspeccionLoadAllRow GetRow(decimal inspeccionId, decimal solicitudId)
    {
      dsInspeccionesTableAdapters.proc_Car_InspeccionLoadAllTableAdapter myTa = new dsInspeccionesTableAdapters.proc_Car_InspeccionLoadAllTableAdapter();
      dsInspecciones.proc_Car_InspeccionLoadAllDataTable myDt = myTa.GetDataByPrimaryKey(inspeccionId, solicitudId);
      dsInspecciones.proc_Car_InspeccionLoadAllRow row = null;
      if (myDt.Rows.Count > 0)
      {
        row = (dsInspecciones.proc_Car_InspeccionLoadAllRow)myDt.Rows[0];
      }
      return row;
    }
    public static string getEstadoInspeccion(decimal inspeccionId, decimal solicitudId)
    {
      dsInspecciones.proc_Car_InspeccionLoadAllRow row = GetRow(inspeccionId, solicitudId);
      if (row != null)
        return row.estadoInspeccionId;
      else return null;
    }

    public static bool InspeccionIsAnulada(string inspId)
    {
      decimal inspId_d = -1;
      if (decimal.TryParse(inspId, out inspId_d))
      {
        return getEstadoInspeccion(inspId_d) == EstadoInspeccion.ANULADA;
      }
      else
      {
        return true;
      }
    }

    public static bool InspeccionIsTerminada(string inspId)
    {
      return getEstadoInspeccion(Convert.ToDecimal(inspId)) == EstadoInspeccion.TERMINADA;
    }

    public static bool couldGenerateInformPreview(string inspId)
    {
      return couldModify(inspId);
    }

    public static bool couldModify(string inspId)
    {
      return !GestorInspeccion.InspeccionIsAprobada(inspId) && !GestorInspeccion.InspeccionIsAnulada(inspId) && !GestorInspeccion.InspeccionIsTerminada(inspId);
    }

    public static bool couldModifyInspeccion(string inspId)
    {
      return couldModify(inspId);
    }

    public static bool couldAproveInspeccion(string inspId)
    {
      return couldModify(inspId);
    }

    public static bool IsTerminadaByInspector(string inspId)
    {
      decimal? inspId_d = (decimal?) Convert.ToDecimal(inspId);

      dsInspeccionesTableAdapters.QueriesTableAdapter qTa = new dsInspeccionesTableAdapters.QueriesTableAdapter();
      return Convert.ToBoolean(qTa.uf_Car_Inspeccion_IsTerminadaByInspector(inspId_d));
    }

  }

}

