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
using CCSOL.Utiles;
using System.Drawing;
using System.Drawing.Imaging;

public partial class vGetImageAmpliatorio : System.Web.UI.Page
{
  protected void Page_Load(object sender, EventArgs e)
  {
    string canAmpl = Utilidades.isNullGet("canAmpl", "0");
    decimal cantidad = 0;

    if (decimal.TryParse(canAmpl, out cantidad))
    {
      string strBasePath = Server.MapPath("Images\\IconAmpl16.gif");

      Bitmap oCounter = new Bitmap(16, 16);
      Graphics oGraphics = Graphics.FromImage(oCounter);

      Bitmap objImage = new Bitmap(strBasePath);
      oGraphics.DrawImage(objImage, 0, 0);

      string stCantidad = canAmpl;
      //string stCantidad = Request.QueryString["cant"].ToString();
      float dbCordenadaX = 3F;
      float dbCordenadaY = 0;
      float dbFontSize = 11;

      if (stCantidad.Length > 1)
      {
        dbCordenadaX = 0;
        dbCordenadaY = 2;
        dbFontSize = 9;
      }

      // Creacion del Font y del Brush
      Font drawFont = new Font("Arial Black", dbFontSize, FontStyle.Regular, GraphicsUnit.Pixel);
      SolidBrush drawBrush = new SolidBrush(Color.Black);
      // Creacion del punto para la esquina superior-isquierda de dibujo
      PointF drawPoint = new PointF(dbCordenadaX, dbCordenadaY);

      oGraphics.DrawString(stCantidad, drawFont, drawBrush, drawPoint);
      oCounter.Save(Response.OutputStream, ImageFormat.Jpeg);

      oCounter.Dispose();
      objImage.Dispose();

    }
  }
}
