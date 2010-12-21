using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

/// <summary>
/// Summary description for EstadoInspeccion
/// </summary>
/// 
namespace CarCheck.Gestores
{
  public class EstadoInspeccion
  {
    public static string ANULADA = "ANULADA";
    public static string COORDINADA = "COORDINADA";
    public static string PENDIENTE = "PENDIENTE";
    public static string REPROGRAMADA = "REPROGRAMADA";
    public static string TERMINADA = "TERMINADA";
    public static string REGISTRADA = "REGISTRADA";
    public static string FRUSTRADA = "FRUSTRADA";

    public class Motivo
    {
      public static int CAMBIO_AUTOMATICO_DE_ESTADO = 7; // EL ID 7 CORRESPONDE A UN CAMBIO DE ESTADO AUTOMÁTICO DENTRO DE LA TABLA CAR_MOTIVO EN CARCHECK
    }

    public EstadoInspeccion()
    {
      //
      // TODO: Add constructor logic here
      //
    }
  }
  public class EstadoSolicitud
  {
    public static string ANULADA = "ANULADA";
    public static string ATENDIDA_COMPLETAMENTE = "ATNCMP";
    public static string ATENDIDA_PARCIALMENTE = "ATNPAR";
    public static string EN_ATENCION = "ENATEN";
    public static string REGISTRADA = "REGSTR";

    public class Motivo
    {
      public static int CAMBIO_AUTOMATICO_DE_ESTADO = 7; 
    }
  }
}
