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

public partial class Mantenimientos_ucContacto : System.Web.UI.UserControl
{
  protected void Page_Load(object sender, EventArgs e)
  {

  }
  protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
  {
    if (e.Row.RowType == DataControlRowType.DataRow)
    {
      if (e.Row.Cells[7].Text.ToString().ToUpper() == "S")
      {
        try
        {
          ImageButton imgbtn1 = (ImageButton)e.Row.FindControl("ImageButton1");
          imgbtn1.Visible = false;
          ImageButton imgbtn2 = (ImageButton)e.Row.FindControl("ImageButton2");
          imgbtn2.Visible = false;
        }
        catch (Exception ex)
        {
          LoggerFacade.LogException(ex);
        }
      }
    }
  }
  protected void GridView1_RowDeleted(object sender, GridViewDeletedEventArgs e)
  {
    if (e.Exception != null)
    {
      LoggerFacade.LogException(e.Exception);
      this.Page.ClientScript.RegisterStartupScript(this.GetType(), "OnLoadMessage", String.Format("window.alert('Ocurrió un error al borrar el registro{0}Parece ser que está siendo referenciado desde una Solicitud o Inspección{0}Elimina las referencias e inténtelo nuevamente');{1}","\\n",Environment.NewLine), true);
      e.ExceptionHandled = true;
    }
  }
}
