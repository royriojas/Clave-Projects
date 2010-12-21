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
using CarCheck.Gestores;

public partial class Control_vMantenimientoImagenes : System.Web.UI.Page
{
  protected void Page_Load(object sender, EventArgs e)
  {
    string vehiculoId = Utilidades.isNullGet("VehiculoId", "");
    if (vehiculoId != "")
    {
      decimal vehiculoId_d = 0;
      if (decimal.TryParse(vehiculoId, out vehiculoId_d))
      {
        this.lblImagenxInspeccion.Text = "Imágenes de la Inspección : " + GestorInspeccion.getInspeccionNumber(vehiculoId);
      }
    }
  }
  protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
  {
    foreach (RepeaterItem item in this.repeaterOtros.Items)
    {
      CheckBox chk = (CheckBox)item.FindControl("chk");
      Label lblImagenId = (Label)item.FindControl("lblImagenId");
      if (chk != null)
      {

        // Object dIt = item.DataItem;
        decimal imagenId;
        if (decimal.TryParse(lblImagenId.Text, out imagenId))
        {
          GestorImagen.IncluirEnInforme(imagenId, chk.Checked);
        }
        else
        {
          LoggerFacade.writeLog("No se encontró el ID de la Imagen");
        }

      }
    }
  }
}
