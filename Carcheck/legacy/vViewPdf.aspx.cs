
using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.IO;
using CarCheck.Reportes;

public partial class vViewPdf : System.Web.UI.Page
{
  protected decimal inspeccionId;
  protected decimal vehiculoId;
  protected decimal informeId;
  protected string tipoInforme;

  private void Page_Load(object sender, System.EventArgs e)
  {
  
    if (Request.QueryString["InspeccionId"] != null)
    {
      this.inspeccionId = decimal.Parse(Request.QueryString["InspeccionId"]);
      vehiculoId = CarCheck.Gestores.GestorInspeccion.getVehiculoId(inspeccionId);
    }

    if (Request.QueryString["VehiculoId"] != null)
    {
      this.vehiculoId = decimal.Parse(Request.QueryString["VehiculoId"]);
      inspeccionId = Convert.ToDecimal(CarCheck.Gestores.GestorInspeccion.getInspeccionId(vehiculoId));

    }
    if (Request.QueryString["InformeId"] != null) this.informeId = decimal.Parse(Request.QueryString["InformeId"]);
    if (Request.QueryString["TI"] != null) this.tipoInforme = Request.QueryString["TI"];



    MemoryStream AuxStream;

    switch (tipoInforme)
    {
      case "NOW":
        AuxStream = new MemoryStream(GetPdf.GetInformeNow(vehiculoId, Server.MapPath("")));
        GetNOW(AuxStream);
        break;

      case "A":
        GetAmpliatorioFromDB(inspeccionId, informeId);
        break;

      case "FILE":
        GetFromFileSystem(CarCheck.Gestores.GestorInspeccion.getInspeccionNumber(vehiculoId.ToString()) + ".pdf");
        break;
      default:
        GetFromDB(inspeccionId, informeId);
        break;
    }
  }
  #region GetAmpliatorioFromDB
  private void GetAmpliatorioFromDB(decimal inspeccionId, decimal informeId)
  {
    //  /*SERVER PATH SOLO CON EL NOMBRE QUE OBTIENE DE LA BASE DE DATOS*/

    dsAmpliatoriosTableAdapters.AmpliatiorioTableAdapter ampliatorioAdapter = new dsAmpliatoriosTableAdapters.AmpliatiorioTableAdapter();
    dsAmpliatorios.AmpliatiorioDataTable ampliatorioTable = (dsAmpliatorios.AmpliatiorioDataTable)ampliatorioAdapter.GetData(inspeccionId, informeId);
    dsAmpliatorios.AmpliatiorioRow ampliatorioRow = (dsAmpliatorios.AmpliatiorioRow)ampliatorioTable.Rows[0];

    GetFromFileSystem(ampliatorioRow.nombre);
  }

  #endregion

  #region GetFromDB
  private void GetFromDB(decimal inspeccionId, decimal informeId)
  {
    /*SERVER PATH SOLO CON EL NOMBRE QUE OBTIENE DE LA BASE DE DATOS*/

    dsReporteTableAdapters.InformeDataTableAdapter informeAdapter = new dsReporteTableAdapters.InformeDataTableAdapter();
    dsReporte.InformeDataDataTable informeTable = (dsReporte.InformeDataDataTable)informeAdapter.GetData(inspeccionId, informeId);
    dsReporte.InformeDataRow informeRow = (dsReporte.InformeDataRow)informeTable.Rows[0];

    GetFromFileSystem(informeRow.nombre);
  }
  #endregion

  #region GetFromFileSystem
  private void GetFromFileSystem(string fileName)
  {
    FileInfo archivo = new FileInfo(Server.MapPath("Informes") + "\\" + fileName);
    if (archivo.Exists)
    {
      Response.Clear();
      Response.ContentType = "application/pdf";
      Response.WriteFile(archivo.FullName);
      Response.End();
    }
  }
  #endregion

  #region GetNOW
  private void GetNOW(MemoryStream AuxStream)
  {
    Response.Clear();
    Response.Buffer = true;
    Response.ContentType = "application/pdf";
    Response.BinaryWrite(AuxStream.ToArray());
    Response.End();
  }
  #endregion


}