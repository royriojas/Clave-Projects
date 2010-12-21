using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;


namespace CarCheck.Gestores
{
  /// <summary>
  /// Summary description for GestorSolicitud
  /// </summary>
  public class GestorSolicitud
  {
    public GestorSolicitud()
    {
      //
      // TODO: Add constructor logic here
      //
    }

    private static dsSolicitud.SolicitudLoadByPrimaryKeyDataTable GetSolDT(decimal SolicitudId)
    {
      dsSolicitudTableAdapters.SolicitudLoadByPrimaryKeyTableAdapter solTa = new dsSolicitudTableAdapters.SolicitudLoadByPrimaryKeyTableAdapter();

      dsSolicitud.SolicitudLoadByPrimaryKeyDataTable solDT = solTa.GetData(SolicitudId);
      return solDT;
    }
    private static dsSolicitud.SolicitudLoadByPrimaryKeyRow getRow(decimal SolicitudId)
    {
      dsSolicitud.SolicitudLoadByPrimaryKeyDataTable solDT = GetSolDT(SolicitudId);

      if (solDT.Rows.Count > 0)
      {
        dsSolicitud.SolicitudLoadByPrimaryKeyRow row = (dsSolicitud.SolicitudLoadByPrimaryKeyRow)solDT.Rows[0];
        return row;
      }
      return null;
    }
    public static string getEstadoSolicitud(decimal SolicitudId)
    {
      dsSolicitud.SolicitudLoadByPrimaryKeyRow arow = getRow(SolicitudId);
      if (arow != null)
      {
        return arow.estadoSolicitudId;
      }

      return null;
    }

    public static decimal SolicitudCreateNew(UserData ud)
    {
      decimal? solicitudId = -1;
      dsSolicitudTableAdapters.SolicitudInspeccionListaTableAdapter insertNuevo = new dsSolicitudTableAdapters.SolicitudInspeccionListaTableAdapter();

      insertNuevo.SolicitudNuevoInsert(ref solicitudId, ud.UserId, ud.UserName);

      if (solicitudId != null)
      {
        return solicitudId.Value;
      }
      else
      {
        return -1;
      }
    }

    [AjaxPro.AjaxMethod]
    public bool doAnexoDelete(string anexoId)
    {
      int anexoId_d = 0;
      if (int.TryParse(anexoId, out anexoId_d))
      {
        return doAnexoDelete(anexoId_d);
      }
      return false;
    }

    public bool doAnexoDelete(int? anexoId)
    {
      dsAnexosTableAdapters.AnexoTableAdapter myTa = new dsAnexosTableAdapters.AnexoTableAdapter();
      return myTa.Delete(anexoId) > 1;
    }


    public static void cerrarSolicitud(decimal solicituId)
    {
      dsSolicitudTableAdapters.SolicitudLoadByPrimaryKeyTableAdapter myTa = new dsSolicitudTableAdapters.SolicitudLoadByPrimaryKeyTableAdapter();
      myTa.proc_Car_SolicitudCerrarBySolicitudId(solicituId, GestorSeguridad.getUserData().UserName);
    }

    public static bool solicitudCerrada(decimal solicituId)
    {

      dsSolicitudTableAdapters.SolicitudCabeceraTableAdapter qTa = new dsSolicitudTableAdapters.SolicitudCabeceraTableAdapter();

      return Convert.ToInt32(qTa.IsSolicitudCerrada(solicituId)) != 0;

    }

    public static void EnviaSolicitud(string solicitudId)
    {
      setEstadoSolicitud(Convert.ToDecimal(solicitudId), EstadoSolicitud.EN_ATENCION);

    }
    internal static void SetProgresoAtencion(decimal solicitudId)
    {
      //hacer un count de todas las inspecciones de esa solicitud
      int total = 0;
      int atendidas = 0;

      GestorInspeccion.getInspeccionesCountBySolicitudId(solicitudId, out total, out atendidas);
      //si el numero de inspecciones terminadas es cero = en Atencion
      if (atendidas == 0)
      {
        setEstadoSolicitud(solicitudId, EstadoSolicitud.EN_ATENCION);
      }
      //si el numero de inspecciones terminadas y aprobadas es menor que el total es atendida parcialmente
      if (atendidas < total)
      {
        setEstadoSolicitud(solicitudId, EstadoSolicitud.ATENDIDA_PARCIALMENTE);
      }
      //si el numero de inspecciones terminadas y aprobadas = total de inspecciones es atendida completamente      
      if (atendidas == total)
      {
        setEstadoSolicitud(solicitudId, EstadoSolicitud.ATENDIDA_COMPLETAMENTE);
        cerrarSolicitud(solicitudId);
      }
    }

    public static void setEstadoSolicitud(
      System.Nullable<decimal> solicitudId, string estadoSolicitudId, System.Nullable<decimal> motivoId, string observacion, string ucrea
      )
    {
      dsSolicitudTableAdapters.QueriesTableAdapter myTa = new dsSolicitudTableAdapters.QueriesTableAdapter();
      myTa.proc_Car_Solicitud_SetEstado(solicitudId, estadoSolicitudId, motivoId, observacion, ucrea);
    }
    public static void setEstadoSolicitud(
      System.Nullable<decimal> solicitudId,
      string estadoSolicitudId
    )
    {
      dsSolicitudTableAdapters.QueriesTableAdapter myTa = new dsSolicitudTableAdapters.QueriesTableAdapter();
      myTa.proc_Car_Solicitud_SetEstado(solicitudId, estadoSolicitudId, EstadoSolicitud.Motivo.CAMBIO_AUTOMATICO_DE_ESTADO, SettingManager.MSG_AUTOMATIC_STATE_CHANGE, GestorSeguridad.getUserData().UserName);
    }

    public static void AnularSolicitud(decimal solicitudId, string MotivoId, string Observacion)
    {
      setEstadoSolicitud((decimal?)solicitudId,
        EstadoSolicitud.ANULADA,
        (decimal?)Convert.ToDecimal(MotivoId),
        Observacion,
        GestorSeguridad.getUserData().UserName
      );
    }

    public static void BorrarSolicitud(decimal solicitudId)
    {
      dsSolicitudTableAdapters.SolicitudLoadByPrimaryKeyTableAdapter myTa = new dsSolicitudTableAdapters.SolicitudLoadByPrimaryKeyTableAdapter();
      myTa.proc_Car_SolicitudLogicalDelete(solicitudId, GestorSeguridad.getUserData().UserName);            
    }

    public static void Borrar(decimal solicitudId)
    {
      if (GestorSolicitud.getEstadoSolicitud(solicitudId) == EstadoSolicitud.REGISTRADA) // en este estado siempre se puede borrar la solicitud, la anulación procede a borrarla
      {
        GestorSolicitud.BorrarSolicitud(solicitudId);
      }
    }

    public static void Anular(decimal solicitudId, String Motivo, String Observacion)
    {      
      if (GestorSeguridad.hasPermision(Funcionalidades.SOLICITUD_ANULAR))
      {        
        GestorSolicitud.AnularSolicitud(solicitudId, Motivo, Observacion);
      }
    }

    public static string getNumeroSolicitud(string solicitudId)
    {
      return getRow(Convert.ToDecimal(solicitudId)).numeSolicitud; 
    }
  }

}