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
using CarCheck.Gestores;

public partial class vVerImagen : System.Web.UI.Page
{

  public String refreshParent = "false";

    protected void Page_Load(object sender, EventArgs e)
  {
    int ImagenId;
    decimal VehiculoId;

    if (int.TryParse(Request.QueryString["ImagenId"], out ImagenId))
    {
      if (decimal.TryParse(Request.QueryString["VehiculoId"], out VehiculoId))
      {
        registroImage.ImageUrl = String.Format("vGetImage.aspx?VehiculoId={0}&ImagenId={1}&OriginalSize=true", VehiculoId, ImagenId);
      }
    }
    decimal? inspId = GestorInspeccion.getInspeccionId(Convert.ToDecimal(Request.QueryString["VehiculoId"]));

    this.imgBtnDelete.Visible = this.imgBtnSave.Visible = GestorInspeccion.couldModify(inspId.ToString());
  }
  protected void frmImagen_ItemUpdating(object sender, FormViewUpdateEventArgs e)
  {
    e.NewValues.Add("uupdate", "SYSTEM");
    e.NewValues.Add("incluirEnInforme", true);    
  }
  protected void imgBtnSave_Click(object sender, ImageClickEventArgs e)
  {
    try
    {
      this.frmImagen.UpdateItem(true);
      this.refreshParent = "true";
    }
    catch (Exception ex)
    {
      LoggerFacade.LogException(ex);
    }
  }

  protected void odsImagen_Selected(object sender, ObjectDataSourceStatusEventArgs e)
  {
    try
    {
      this.Title = "Visor de Imágenes : " + ((dsImages.ImagenRow)((dsImages.ImagenDataTable)e.ReturnValue).Rows[0]).titulo;
    }
    catch (Exception ex)
    {
      this.Title = "Visor de Imágenes";
      LoggerFacade.LogException(ex);
    }

  }
  protected void imgBtnDelete_Click(object sender, ImageClickEventArgs e)
  {
    this.odsImagen.Delete();    
    refreshParent = "true";
    this.ClientScript.RegisterStartupScript(this.GetType(), "cerrar", "function  doClose (){ alert('la imagen ha sido eliminada');window.close();} setTimeout('doClose()',500);", true);
  }
}
