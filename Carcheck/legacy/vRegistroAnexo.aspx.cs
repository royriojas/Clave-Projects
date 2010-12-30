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
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;
using System.Security.AccessControl;
using System.ComponentModel;

public partial class vRegistroAnexo : System.Web.UI.Page
{
  public String deboCerrar = "false";
  public String SolicitudId_s = "";
  protected void Page_Load(object sender, EventArgs e)
  {

  }
  private void addFile()
  {
    int BinLength = fupArchivo.PostedFile.ContentLength;

    if (BinLength > 0)
    {
      string mensaje = "";
      dsAnexosTableAdapters.AnexoTableAdapter myTa = new dsAnexosTableAdapters.AnexoTableAdapter();
      int? anexoId = null;
      SolicitudId_s = Request.QueryString["SolicitudId"];
      decimal SolicitudId = 0;
      if (decimal.TryParse(SolicitudId_s, out SolicitudId))
      {
        if (myTa.Insert(ref anexoId, fupArchivo.FileName, this.txtDescripcion.Text, fupArchivo.FileBytes, "SYSTEM", SolicitudId) > 0)
        {
          deboCerrar = "true";
        }
        else
        {
          mensaje = "Ocurrió un error, no se pudo subir el archivo";
          this.ClientScript.RegisterClientScriptBlock(this.GetType(), "cerrar", "<script language='javascript'>alert('" + mensaje + "');</script>");
        }
      }
      else
      {
        mensaje = "Ocurrió un error, no se pudo subir el archivo";
        this.ClientScript.RegisterClientScriptBlock(this.GetType(), "cerrar", "<script language='javascript'>alert('" + mensaje + "');</script>");
      }
    }
  }

  protected void AddFile_Click(object sender, EventArgs e)
  {
    addFile();
  }
}
