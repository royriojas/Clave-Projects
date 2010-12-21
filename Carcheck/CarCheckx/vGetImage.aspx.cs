using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.IO;
using CCSOL.Utiles;

public partial class vGetImage : System.Web.UI.Page
{
  protected void Page_Load(object sender, EventArgs e)
  {
    int ImagenId;
    decimal VehiculoId;

    if (int.TryParse(Request.QueryString["ImagenId"], out ImagenId))
    {
      if (decimal.TryParse(Request.QueryString["VehiculoId"], out VehiculoId))
      {
        byte[] imagenThumb = null;

        bool foundImageData = false;

        string originalSize = Utilidades.isNull(Request.QueryString["OriginalSize"], "thumb");
        if (originalSize == "thumb")
        {
          dsImagesTableAdapters.BinaryImageDataFromImageTableAdapter tAdpt = new dsImagesTableAdapters.BinaryImageDataFromImageTableAdapter();
          dsImages.BinaryImageDataFromImageDataTable BynaryTable = tAdpt.GetData(ImagenId, VehiculoId, false);

          if (BynaryTable.Rows.Count > 0)
          {
            imagenThumb = ((dsImages.BinaryImageDataFromImageRow)BynaryTable.Rows[0]).binaryData;
            foundImageData = true;
          }
          
        }
        else
        {
          dsImagesTableAdapters.BinaryImageDataFromImageTableAdapter tAdpt = new dsImagesTableAdapters.BinaryImageDataFromImageTableAdapter();
          dsImages.BinaryImageDataFromImageDataTable BynaryTable = tAdpt.GetData(ImagenId, VehiculoId, true);
          if (BynaryTable.Rows.Count > 0)
          {
            imagenThumb = ((dsImages.BinaryImageDataFromImageRow)BynaryTable.Rows[0]).binaryData;
            foundImageData = true;
          }
          
        }

        if (!foundImageData)
        {
          FileInfo fInfo = new FileInfo(Server.MapPath("./Images/IconNoImageAvailable.jpg"));
          if (fInfo.Exists)
          {
            imagenThumb = Utilidades.getBytesFromFile(fInfo);
          }
        }
        if (imagenThumb != null)
        {
          MemoryStream auxStream = new MemoryStream(imagenThumb);

          Response.ContentType = "image/jpeg";

          Response.BinaryWrite(auxStream.ToArray());
        }
      }
    }




  }
}
