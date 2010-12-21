using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;
using System.IO;
using CarCheck.Gestores;

/// <summary>
/// Summary description for GetPdf
/// </summary>

namespace CarCheck.Reportes
{
  public class GetPdf
  {


    public GetPdf()
    {
      //
      // TODO: Add constructor logic here
      //

    }

    public static void GenerarInforme(decimal vehiculoId, bool estadoValidacion, bool observado, string usuario, string ApplicationPath)
    {
      decimal? inspeccionId = CarCheck.Gestores.GestorInspeccion.getInspeccionId(vehiculoId);

      ReportDocument informe = getInforme(vehiculoId, ApplicationPath);

      //string nombreInforme = CarCheck.Gestores.GestorInspeccion.getInspeccionNumber(vehiculoId.ToString()) + "-" + DateTime.Now.Day + DateTime.Now.Month + DateTime.Now.Year + DateTime.Now.Hour + DateTime.Now.Minute + DateTime.Now.Second + DateTime.Now.Millisecond + ".pdf";
      string nombreInforme = CarCheck.Gestores.GestorInspeccion.getInspeccionNumber(vehiculoId.ToString()) + ".pdf";
      saveToFileSytem(informe, nombreInforme, ApplicationPath);
      dsReporteTableAdapters.InformeTableAdapter tainforme = new dsReporteTableAdapters.InformeTableAdapter();
      tainforme.Insert(inspeccionId, nombreInforme, ApplicationPath + "\\informes\\" + nombreInforme, estadoValidacion, observado, usuario);

      // Aprobar el informe
      if (observado)
        Gestores.GestorInspeccion.Aprobar(inspeccionId,TipoAprobacion.APROBADO_PAGO);
      else
        Gestores.GestorInspeccion.Aprobar(inspeccionId, TipoAprobacion.APROBADO_NO_PAGO);
    }


    public static void GenerarAmpliatorio(decimal inspeccionId, decimal ampliatorioId, string usuario, string ApplicationPath)
    {
      ReportDocument informe = getAmpliatorio(inspeccionId,ampliatorioId, ApplicationPath);

      string nombreInforme = CarCheck.Gestores.GestorInspeccion.getInspeccionNumber(inspeccionId) + "-A-" + DateTime.Now.Day + DateTime.Now.Month + DateTime.Now.Year + DateTime.Now.Hour + DateTime.Now.Minute + DateTime.Now.Second + DateTime.Now.Millisecond + ".pdf";
      
      saveToFileSytem(informe, nombreInforme, ApplicationPath);

      dsReporteTableAdapters.AmpliatorioTableAdapter ta = new dsReporteTableAdapters.AmpliatorioTableAdapter();
      ta.Update(ampliatorioId, ApplicationPath + "\\informes\\" + nombreInforme, nombreInforme, usuario);
    
    }


    private static void saveToFileSytem(ReportDocument informe, string nombreInforme, string ApplicationPath)
    {
      ExportOptions informeOpcion = new ExportOptions();
      informeOpcion.ExportFormatType = ExportFormatType.PortableDocFormat;
      informeOpcion.ExportDestinationType = ExportDestinationType.DiskFile;
      DiskFileDestinationOptions destino = new DiskFileDestinationOptions();

      destino.DiskFileName = ApplicationPath + "\\informes\\" + nombreInforme;

      informeOpcion.ExportDestinationOptions = destino;

      try
      {
        informe.Export(informeOpcion);
      }
      catch (Exception ex)
      {
        LoggerFacade.LogException(ex);
      }
    }

    public static byte[] GetInformeNow(decimal vehiculoId, string ApplicationPath)
    {
      ReportDocument informeBasico = getInforme(vehiculoId, ApplicationPath);

      MemoryStream oStream;
      oStream = (MemoryStream)informeBasico.ExportToStream(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat);
      return oStream.ToArray();
    }

    private static ReportDocument getInforme(decimal vehiculoId, string ApplicationPath)
    {                         
      decimal? inspeccionId = CarCheck.Gestores.GestorInspeccion.getInspeccionId(vehiculoId);

      // Instancia del reporte
      String reportPath = ApplicationPath + "\\Reportes\\crInforme.rpt";

      ReportDocument informe = new ReportDocument();
      informe.Load(reportPath);

      dsReporteTableAdapters.CabeceraTableAdapter dtCabecera = new dsReporteTableAdapters.CabeceraTableAdapter();
      try
      {
        DataTable cabecera = (DataTable)dtCabecera.GetData(Convert.ToInt32(vehiculoId));
        informe.OpenSubreport("crCabecera.rpt").SetDataSource(cabecera);

      }
      catch (Exception Ex)
      {
        Console.Write(Ex.Message);
      }

      dsReporteTableAdapters.DatosGeneralesTableAdapter dtDatosGenerales = new dsReporteTableAdapters.DatosGeneralesTableAdapter();
      try
      {
        DataTable datosGenerales = (DataTable)dtDatosGenerales.GetData(Convert.ToInt32(inspeccionId));
        informe.OpenSubreport("crDatosGenerales.rpt").SetDataSource(datosGenerales);

      }
      catch (Exception Ex)
      {
        Console.Write(Ex.Message);
      }

      dsReporteTableAdapters.VehiculoTableAdapter dtVehiculo = new dsReporteTableAdapters.VehiculoTableAdapter();
      DataTable vehiculo = (DataTable)dtVehiculo.GetData(Convert.ToInt32(vehiculoId));
      informe.OpenSubreport("crDatosVehiculo.rpt").SetDataSource(vehiculo);


      dsReporteTableAdapters.CaracteristicasExterioresTableAdapter dtCaracteristicasExteriores = new dsReporteTableAdapters.CaracteristicasExterioresTableAdapter();
      DataTable caracteristicasExteriores = (DataTable)dtCaracteristicasExteriores.GetData(Convert.ToInt32(vehiculoId));
      if (caracteristicasExteriores.Rows.Count > 0)
        informe.OpenSubreport("crCaracteristicasExteriores.rpt").SetDataSource(caracteristicasExteriores);
      else
        informe.ReportDefinition.Sections["CaracteristicasExteriores"].SectionFormat.EnableSuppress = true;

      dsReporteTableAdapters.CaracteristicasSalonTableAdapter dtCaracteristicasSalon = new dsReporteTableAdapters.CaracteristicasSalonTableAdapter();
      DataTable caracteristicasSalon = (DataTable)dtCaracteristicasSalon.GetData(Convert.ToInt32(vehiculoId));
      if (caracteristicasSalon.Rows.Count > 0)
        informe.OpenSubreport("crCaracteristicasSalon.rpt").SetDataSource(caracteristicasSalon);
      else
        informe.ReportDefinition.Sections["CaracteristicasSalon"].SectionFormat.EnableSuppress = true;

      dsReporteTableAdapters.EquipoSonidoTableAdapter dtEquipo = new dsReporteTableAdapters.EquipoSonidoTableAdapter();
      DataTable equipo = (DataTable)dtEquipo.GetData(Convert.ToInt32(vehiculoId));
      if (equipo.Rows.Count > 0)
        informe.OpenSubreport("crEquipoSonido.rpt").SetDataSource(equipo);
      else
        informe.ReportDefinition.Sections["EquipoSonido"].SectionFormat.EnableSuppress = true;


      dsReporteTableAdapters.CaracteristicasAudioTableAdapter dtAudio = new dsReporteTableAdapters.CaracteristicasAudioTableAdapter();
      DataTable accesoriosSonido = (DataTable)dtAudio.GetData(Convert.ToInt32(vehiculoId));
      if (accesoriosSonido.Rows.Count > 0)
        informe.OpenSubreport("crAccesoriosAudio.rpt").SetDataSource(accesoriosSonido);
      else
        informe.ReportDefinition.Sections["AccesoriosAudio"].SectionFormat.EnableSuppress = true;

      if ((accesoriosSonido.Rows.Count == 0) && (equipo.Rows.Count == 0))
      {
        informe.ReportDefinition.Sections["tituloAudioVideo"].SectionFormat.EnableSuppress = true;
      }

      dsReporteTableAdapters.OtrosAccesoriosTableAdapter dtAccesorios = new dsReporteTableAdapters.OtrosAccesoriosTableAdapter();
      DataTable accesorios = (DataTable)dtAccesorios.GetData(Convert.ToInt32(vehiculoId));
      if (accesorios.Rows.Count > 0)
        informe.OpenSubreport("crAccesorios.rpt").SetDataSource(accesorios);
      else
        informe.ReportDefinition.Sections["Accesorios"].SectionFormat.EnableSuppress = true;

      dsReporteTableAdapters.LlantasTableAdapter dtLlantas = new dsReporteTableAdapters.LlantasTableAdapter();
      DataTable llantas = (DataTable)dtLlantas.GetData(Convert.ToInt32(vehiculoId));
      if (llantas.Rows.Count > 0)
        informe.OpenSubreport("crLlantas.rpt").SetDataSource(llantas);
      else
        informe.ReportDefinition.Sections["llantas"].SectionFormat.EnableSuppress = true;


      dsReporteTableAdapters.DamagesTableAdapter dtDamage = new dsReporteTableAdapters.DamagesTableAdapter();
      DataTable damages = (DataTable)dtDamage.GetData(Convert.ToInt32(vehiculoId));
      if (damages.Rows.Count > 0)
        informe.OpenSubreport("crDaños.rpt").SetDataSource(damages);
      else
        informe.ReportDefinition.Sections["Danos"].SectionFormat.EnableSuppress = true;

      dsReporteTableAdapters.AlarmaTableAdapter dtAlarma = new dsReporteTableAdapters.AlarmaTableAdapter();
      DataTable alarma = (DataTable)dtAlarma.GetData(Convert.ToInt32(vehiculoId));
      if (alarma.Rows.Count > 0)
        informe.OpenSubreport("crAlarma.rpt").SetDataSource(alarma);
      else
        informe.ReportDefinition.Sections["Alarma"].SectionFormat.EnableSuppress = true;


      dsReporteTableAdapters.IdenticarTableAdapter dtIdenticar = new dsReporteTableAdapters.IdenticarTableAdapter();
      DataTable identicar = (DataTable)dtIdenticar.GetData(Convert.ToInt32(vehiculoId));
      if (identicar.Rows.Count > 0)
        informe.OpenSubreport("crIdenticar.rpt").SetDataSource(identicar);
      else
        informe.ReportDefinition.Sections["identicar"].SectionFormat.EnableSuppress = true;


      dsReporteTableAdapters.CaracteristicasSeguridadTableAdapter dtSeguridad = new dsReporteTableAdapters.CaracteristicasSeguridadTableAdapter();
      DataTable seguridad = (DataTable)dtSeguridad.GetData(Convert.ToInt32(vehiculoId));
      if (seguridad.Rows.Count > 0)
        informe.OpenSubreport("crSeguridad.rpt").SetDataSource(seguridad);
      else
        informe.ReportDefinition.Sections["Seguridad"].SectionFormat.EnableSuppress = true;

      if ((alarma.Rows.Count == 0) && (identicar.Rows.Count == 0) && (seguridad.Rows.Count == 0))
      {
        informe.ReportDefinition.Sections["tituloSeguridad"].SectionFormat.EnableSuppress = true;
      }


      dsReporteTableAdapters.ImagenesTableAdapter dtImagenes = new dsReporteTableAdapters.ImagenesTableAdapter();
      DataTable imagenes = (DataTable)dtImagenes.GetData(Convert.ToInt32(vehiculoId));
      if (imagenes.Rows.Count > 0)
        informe.OpenSubreport("crIBImagen.rpt").SetDataSource(imagenes);
      else
        informe.ReportDefinition.Sections["Imagenes"].SectionFormat.EnableSuppress = true;

      dsReporteTableAdapters.ImagenesDocumentosTableAdapter dtImagenesDocumentos = new dsReporteTableAdapters.ImagenesDocumentosTableAdapter();
      DataTable imagenesDocumentos = (DataTable)dtImagenesDocumentos.GetData(Convert.ToInt32(vehiculoId));
      if (imagenesDocumentos.Rows.Count > 0)
        informe.OpenSubreport("crImagenesDocumentos").SetDataSource(imagenesDocumentos);
      else
        informe.ReportDefinition.Sections["ImagenesDocumentos"].SectionFormat.EnableSuppress = true;

      dsReporteTableAdapters.CabeceraDetalleTableAdapter cabeceraAdapter = new dsReporteTableAdapters.CabeceraDetalleTableAdapter();
      informe.SetDataSource((DataTable)cabeceraAdapter.GetData(Convert.ToInt32(inspeccionId)));
      return informe;
    }

    private static ReportDocument getAmpliatorio(decimal inspeccionId, decimal ampliatorioId , string ApplicationPath)
    {
        decimal vehiculoId = GestorInspeccion.getVehiculoId(inspeccionId);
      // Instancia del reporte
      String reportPath = ApplicationPath + "\\Reportes\\crAmpliatorio.rpt";

      ReportDocument informe = new ReportDocument();
      informe.Load(reportPath);

      dsReporteTableAdapters.CabeceraTableAdapter dtCabecera = new dsReporteTableAdapters.CabeceraTableAdapter();
      try
      {
          DataTable cabecera = (DataTable)dtCabecera.GetData(vehiculoId);
          informe.OpenSubreport("crCabecera.rpt").SetDataSource(cabecera);

      }
      catch (Exception Ex)
      {
          Console.Write(Ex.Message);
      }

      dsReporteTableAdapters.DatosGeneralesTableAdapter dtDatosGenerales = new dsReporteTableAdapters.DatosGeneralesTableAdapter();
      try
      {
          DataTable datosGenerales = (DataTable)dtDatosGenerales.GetData(inspeccionId);
          informe.OpenSubreport("crDatosGenerales.rpt").SetDataSource(datosGenerales);

      }
      catch (Exception Ex)
      {
          Console.Write(Ex.Message);
      }

      dsReporteTableAdapters.InformeAmpliatorioTableAdapter dtDatosAmpliatorio = new dsReporteTableAdapters.InformeAmpliatorioTableAdapter();
      try
      {
          DataTable ContenidoAmpliatorio = (DataTable)dtDatosAmpliatorio.GetData(ampliatorioId);
          informe.OpenSubreport("crContenido.rpt").SetDataSource(ContenidoAmpliatorio);

      }
      catch (Exception Ex)
      {
          Console.Write(Ex.Message);
      }

      dsReporteTableAdapters.AmpliatorioImagenesTableAdapter dtImagenes = new dsReporteTableAdapters.AmpliatorioImagenesTableAdapter();
      DataTable imagenes = (DataTable)dtImagenes.GetData(ampliatorioId);
      if (imagenes.Rows.Count > 0)
          informe.OpenSubreport("crIBImagen.rpt").SetDataSource(imagenes);
      else
          informe.ReportDefinition.Sections["Imagenes"].SectionFormat.EnableSuppress = true;

      dsReporteTableAdapters.CabeceraDetalleTableAdapter cabeceraAdapter = new dsReporteTableAdapters.CabeceraDetalleTableAdapter();
      informe.SetDataSource((DataTable)cabeceraAdapter.GetData(Convert.ToInt32(inspeccionId)));
      return informe;
    }
  }
}