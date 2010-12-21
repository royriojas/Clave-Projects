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
  /// Summary description for GestorImagenes
  /// </summary>
  public class GestorImagen
  {
    public GestorImagen()
    {
      //
      // TODO: Add constructor logic here
      //
    }
    public static int doUploadImage(decimal? vehiculoId, string imagenCorrespondenciaId, string titulo, string observacion, byte[] imagen, string ucrea, bool resize, int targetSize)
    {

      dsImagesTableAdapters.ImagenTableAdapter myTa = new dsImagesTableAdapters.ImagenTableAdapter();
      if (resize)
      {
        imagen = ImgHdl.ImgResize.ResizeImageFile(imagen, targetSize, ImgHdl.Horientation.Landscape);
      }
      byte[] thumbnail = ImgHdl.ImgResize.ResizeImageFile(imagen, 70, ImgHdl.Horientation.Portrait);

      byte[] thumbForInforme = ImgHdl.ImgResize.ResizeImageFile(imagen, 640, ImgHdl.Horientation.Landscape);

      int? imagenId = null;

      return myTa.Insert(vehiculoId, ref imagenId, imagenCorrespondenciaId, titulo, observacion, imagen, ucrea, "", thumbnail, true, thumbForInforme);

    }

    public static int doUploadImageAmpliatorio(decimal? ampliatorioId, string titulo, string observacion, byte[] imagen, string ucrea, bool resize, int targetSize)
    {

      dsImagesTableAdapters.ImagenAmpliatorioTableAdapter myTa = new dsImagesTableAdapters.ImagenAmpliatorioTableAdapter();
      if (resize)
      {
        imagen = ImgHdl.ImgResize.ResizeImageFile(imagen, targetSize, ImgHdl.Horientation.Landscape);
      }
      byte[] thumbnail = ImgHdl.ImgResize.ResizeImageFile(imagen, 70, ImgHdl.Horientation.Portrait);

      byte[] thumbForInforme = ImgHdl.ImgResize.ResizeImageFile(imagen, 640, ImgHdl.Horientation.Landscape);

      int? imagenId = null;

      return myTa.Insert(ampliatorioId, ref imagenId, titulo, observacion, imagen, ucrea, "", thumbnail,thumbForInforme);

    }


    public static void IncluirEnInforme(decimal imagenId, bool incluir)
    {
      dsImagesTableAdapters.proc_Car_ImagenLoadAll_MaintenanceTableAdapter myTa = new dsImagesTableAdapters.proc_Car_ImagenLoadAll_MaintenanceTableAdapter();
      myTa.proc_car_Imagen_setBitIncluirEnInforme(imagenId, incluir);
    }
  }
}