using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using CarCheck.Gestores;

/// <summary>
/// Summary description for GestorAgenda
/// </summary>
/// 
namespace CarCheck.Gestores
{
  public class GestorAgenda
  {
    public GestorAgenda()
    {
      //
      // TODO: Add constructor logic here
      //
    }

    public static decimal? RegistrarComunicacion(
      string tcomunicacionId,
      DateTime fComunicacion,
      string resultado,
      string observacion,
      string contacto,
      string estadoInspeccion,
      decimal? inspeccionId,
      decimal? solicitudId,
      bool exito)
    {
      decimal? comunicacionId = -1;

      try
      {
        dsAgendaTableAdapters.proc_Car_ComunicacionLoadAllTableAdapter comTa = new dsAgendaTableAdapters.proc_Car_ComunicacionLoadAllTableAdapter();
        comTa.Insert(ref comunicacionId, tcomunicacionId, fComunicacion, resultado, observacion, GestorSeguridad.getUserData().UserName, "", contacto);

        dsAgendaTableAdapters.proc_Car_ComunicacionInspeccionLoadAllTableAdapter comInsTa = new dsAgendaTableAdapters.proc_Car_ComunicacionInspeccionLoadAllTableAdapter();
        comInsTa.Insert(comunicacionId, inspeccionId, solicitudId, exito, GestorSeguridad.getUserData().UserName, "", estadoInspeccion);
      }
      catch (Exception ex)
      {
        LoggerFacade.LogException(ex);
      }

      return comunicacionId;
    }

    public static decimal? RegistrarCita(decimal? inspeccionId, decimal? solicitudId, decimal? comunicacionId, DateTime fcitaInicio, DateTime fcitaFin, string direccion, string ubigeoId, decimal? inspectorId,string contacto, string telefonocontacto, string observacion)
    {
      decimal? citaId = -1;

      try
      {
        dsAgendaTableAdapters.proc_Car_CitaLoadAllTableAdapter citaTa = new dsAgendaTableAdapters.proc_Car_CitaLoadAllTableAdapter();
        citaTa.Insert(ref citaId, comunicacionId, fcitaInicio, fcitaFin, direccion, ubigeoId, inspectorId, "", observacion, GestorSeguridad.getUserData().UserName, "", contacto, telefonocontacto, false);

        dsAgendaTableAdapters.proc_Car_CitaInspeccionLoadAllTableAdapter citaInsTa = new dsAgendaTableAdapters.proc_Car_CitaInspeccionLoadAllTableAdapter();
        citaInsTa.Insert(citaId, inspeccionId, solicitudId, GestorSeguridad.getUserData().UserName, "", false);
        
        citaInsTa.proc_Car_CitaInspeccionSincronize(inspeccionId);

        GestorInspeccion.setEstadoInspeccion(inspeccionId, EstadoInspeccion.COORDINADA, Convert.ToDecimal(solicitudId));

        dsAgendaTableAdapters.QueriesTableAdapter qTa = new dsAgendaTableAdapters.QueriesTableAdapter();

        qTa.proc_Car_ComunicacionInspeccionUpdate_cck(comunicacionId, inspeccionId,solicitudId, GestorSeguridad.getUserData().UserName, EstadoInspeccion.COORDINADA);
        qTa.proc_Car_InspeccionUpdate_Inspector(inspeccionId, solicitudId, inspectorId, fcitaInicio, GestorSeguridad.getUserData().UserName);

      }
      catch (Exception ex)
      {
        LoggerFacade.LogException(ex);
      }

      return citaId;
    }
  }
}
