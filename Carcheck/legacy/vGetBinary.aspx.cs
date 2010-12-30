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

public partial class vGetBinary : System.Web.UI.Page
{
  protected void Page_Load(object sender, EventArgs e)
  {
    decimal? SolicitudId = decimal.Parse(Request.QueryString["SolicitudId"]);
    int? AnexoId = int.Parse(Request.QueryString["AnexoId"]);

    dsAnexosTableAdapters.AnexoDownloadTableAdapter myTa = new dsAnexosTableAdapters.AnexoDownloadTableAdapter();
    dsAnexos.AnexoDownloadDataTable myDt = myTa.GetData(AnexoId, SolicitudId);
    if (myDt.Rows.Count > 0)
    {

      dsAnexos.AnexoDownloadRow fileRow = (dsAnexos.AnexoDownloadRow)myDt.Rows[0];

      MemoryStream AuxStream = new MemoryStream(fileRow.binarydata);

      Response.AddHeader("Content-disposition", "attachment; filename=" + fileRow.filename);
      Response.ContentType = "application/octet-stream";
      Response.BinaryWrite(AuxStream.ToArray());
    }
  }
}
