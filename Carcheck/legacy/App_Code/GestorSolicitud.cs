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
    public static decimal SolicitudCreateNew(UserData ud)
    {
      //
      // TODO: Implementar el método que crea una nueva solicitud Insertandole solo el campo N° Solicitud
      //
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

  }

}