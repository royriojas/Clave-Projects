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

public partial class vViewImage : System.Web.UI.Page
{
    public String pageName;
    protected void Page_Load(object sender, EventArgs e)
    {
        this.HyperLink1.ImageUrl = "vGetImageGrande.aspx?SolicitudId=" + Request.QueryString["SolicitudId"] + "&AnexoId=" + Request.QueryString["AnexoId"] + "&imagen=grande";
    }
}
