using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Collections;

namespace CarCheck.Gestores
{
  public class Funcionalidades
  {

    public static string FI_DAMAGE_DELETE = "FI_DAMAGE_DELETE";
    public static string FI_CARACTERISTICA_DELETE = "FI_CARACTERISTICA_DELETE";
    public static string FI_CARACTERISTICA_ADD = "FI_CARACTERISTICA_ADD";
    public static string FI_LLANTA_EDIT = "FI_LLANTA_EDIT";
    public static string FI_LLANTA_DELETE = "FI_LLANTA_DELETE";

    public static string FI_LLANTA_ADD = "FI_LLANTA_ADD";
    public static string INSPECCION_BORRAR_EVEN_WHEN_IS_PENDENT = "INSPECCION_BORRAR_EVEN_WHEN_IS_PENDENT";

    public static string VALOR_COMERCIAL_VER = "VALOR_COMERCIAL_VER";
    public static string ESTADISTICAS_VER = "ESTADISTICAS_VER";
    public static string AMPLIATORIO_LISTA_VER = "AMPLIATORIO_LISTA_VER";
    public static string REPORTES_VER = "REPORTES_VER";
    public static string PANEL_DE_CONTROL_VER = "PANEL_DE_CONTROL_VER";

    public static string INSPECCION_LISTA_VER = "INSPECCION_LISTA_VER";
    public static string SOLICITUD_LISTA_VER = "SOLICITUD_LISTA_VER";

    public static string AGENDA_REGISTRAR_CITA_COMUNICACION = "AGENDA_REGISTRAR_CITA_COMUNICACION"; 

    public static string CITA_REG_WITHOUT_DATE_CHECKING = "CITA_REG_WITHOUT_DATE_CHECKING";

    public static string SOLICITUD_ANULAR_EVEN_WHEN_IS_ALREADY_SENT = "SOLICITUD_ANULAR_EVEN_WHEN_IS_ALREADY_SENT";
    public static string SOLICITUD_SAVE_EVEN_WHEN_IS_ALREADY_SENT = "SOLICITUD_SAVE_EVEN_WHEN_IS_ALREADY_SENT";
    public static string INSPECTOR_REG_ALL = "INSPECTOR_REG_ALL";
    public static string INSPECCION_INFORME_APROBAR = "INS_APROBAR";
    public static string SOLICITUD_BORRAR = "SOLICITUD_BORRAR";


    public static string INSPECCION_ADD_NEW_EVEN_WHEN_IS_ALREADY_SENT = "INSPECCION_ADD_NEW_EVEN_WHEN_IS_ALREADY_SENT";

    public static string SAVE_CHANGES_SOLICITUD_STATE = "SAVE_CHANGES_SOLICITUD_STATE";

    public static string CONEXIONSISTEMA = "CONEXION_SISTEMA";
    public static string SOLICITUD_REG_ALL_CLIENTS = "SOLICITUD_REG_ALL_CLIENTS";
    public static string SOLICITUD_REG_ALL_BROKERS = "SOLICITUD_REG_ALL_BROKERS";
    public static string SOLICITUD_REG_ALL_ASEGURADORAS = "SOLICITUD_REG_ALL_ASEGURADORAS";
    public static string SOLICITUD_ENVIAR = "SOLICITUD_ENVIAR";
    public static string SOLICITUD_ANULAR = "SOLICITUD_ANULAR";
    public static string SOLICITUD_ANULAR_EVEN_IT_HAS_BEEN_REGISTERED_BY_DIFFERENT_USER = "SOLICITUD_ANULAR_EVEN_IT_HAS_BEEN_REGISTERED_BY_DIFFERENT_USER";



    public static string INSPECCION_EDITAR_INSPECTOR = "INSPECCION_EDITAR_INSPECTOR";
    public static string INSPECCION_EDITAR = "INSPECCION_EDITAR";
    public static string INSPECCION_BORRAR = "INSPECCION_BORRAR";
    public static string INSPECCION_ANULAR = "INSPECCION_ANULAR";
    public static string INSPECCION_ANULAR_EVEN_WHEN_IS_BEEN_ATTENDED = "INSPECCION_ANULAR_EVEN_WHEN_IS_BEEN_ATTENDED";
    public static string INSPECCION_CREATE_AS_PENDENT = "INSPECCION_CREATE_AS_PENDENT";
    public static string INSPECCION_VER = "INSPECCION_VER";

    public static string AGENDA_VER = "AGENDA_VER";

    public static string AGENDA_CONSULTAR_CITA = "AGENDA_CONSULTAR_CITA";

    public static string INSPECCION_PROGRAMAR_CITA = "INSPECCION_PROGRAMAR_CITA";

  }

}
