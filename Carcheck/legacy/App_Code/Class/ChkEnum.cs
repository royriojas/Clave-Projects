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
/// Summary description for ChkEnum
/// </summary>
namespace CarCheck.Enums
{
  public enum HeaderLinks : int
  {
    listaSolicitudes = 1,
    listaInspecciones = 2,
    valoresComerciales = 3,
    agenda = 4,
    reportes = 5,
    estadistica = 6,
    opciones = 7,
    ampliatorios = 8
  }
  public enum CCK_TabLink
  {
    DatosPersonales,
    DatosVehiculo,
    Caracteristicas,
    Llantas,
    Damage,
    Imagenes
  }
  
}