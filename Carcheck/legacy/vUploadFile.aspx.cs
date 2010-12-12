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

public partial class vUploadFile : System.Web.UI.Page
{
  protected void Page_Load(object sender, EventArgs e)
  {

  }
  protected void AddFile_Click(object sender, EventArgs e)
  {
    performUpload();
  }

  private void performUpload()
  {
    string VehiculoId = Utilidades.isNull(Request.QueryString["VehiculoId"], "");
    if (!string.IsNullOrEmpty(VehiculoId))
    {
      decimal vid = 0;
      if (decimal.TryParse(VehiculoId, out vid))
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
          CarCheck.Gestores.GestorImagen.doUploadImage(vid, this.cbxImagenCorrespondencia.SelectedValue, this.txtTitulo.Text, this.txtDescripcion.Text, this.fupArchivo.FileBytes, ucrea, this.chkResize.Checked, newSize);
          this.ClientScript.RegisterStartupScript(this.GetType(), "close", "window.parent.closePopUp();", true);
        }
      }
    }

  }
}
