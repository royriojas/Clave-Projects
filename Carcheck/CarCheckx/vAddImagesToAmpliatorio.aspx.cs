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


public partial class vAddImagesToAmpliatorio : System.Web.UI.Page
{

    string ampliatorioId;
    decimal inspeccionId; 
  
  protected void Page_Load(object sender, EventArgs e)
  {
      inspeccionId = Convert.ToDecimal(Request.QueryString["InspeccionId"].ToString());
      ampliatorioId = Request.QueryString["AmpliatorioId"].ToString();
  }
  protected void AddFile_Click(object sender, EventArgs e)
  {
    performUpload();
  }

  private void performUpload()
  {
    ampliatorioId = Utilidades.isNull(Request.QueryString["AmpliatorioId"], "");

    if (!string.IsNullOrEmpty(ampliatorioId))
    {
      decimal vid = 0;
      if (decimal.TryParse(ampliatorioId, out vid))
      {
        if (this.fupArchivo.FileBytes != null)
        {
          bool useResize = false;
          int newSize = 0;
          if (this.chkResize.Checked)
          {
            useResize = true;
            if (!int.TryParse(this.txtNewWidth.Text, out newSize))
            {
              useResize = false;
            }
          }
          UserData ud = (UserData)Session["userData"];
          string ucrea = "";
          if (ud != null)
          {
            ucrea = ud.UserName;
          }
          CarCheck.Gestores.GestorImagen.doUploadImageAmpliatorio(vid, this.txtTitulo.Text, this.txtDescripcion.Text, this.fupArchivo.FileBytes, ucrea, useResize, newSize);
          
          cleanControls();
        }
      }
    }

  }

  private void cleanControls()
  {
    txtTitulo.Text = "";
    txtDescripcion.Text = "";
    chkResize.Checked = false;
    txtNewWidth.Text = "";
  }
    protected void guardarImageButton_Click(object sender, ImageClickEventArgs e)
    {
        // Generamos el pdf del ampliatorio
        CarCheck.Reportes.GetPdf.GenerarAmpliatorio(inspeccionId, Convert.ToDecimal(ampliatorioId), Session["userName"].ToString(), Server.MapPath(""));
        this.Page.ClientScript.RegisterStartupScript(this.GetType(), "ScriptClose", "doCallCloseWindow();", true);
    }
}
