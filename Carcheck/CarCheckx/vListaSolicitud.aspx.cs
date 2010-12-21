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
using AjaxPro;
using AjaxCanales.Utiles;
using System.IO;
using CarCheck.Gestores;
using CCSOL.Utiles;

public partial class vListaSolicitud : System.Web.UI.Page
{
  public int num = 1;
  private string url_destino;
  private UserData ud;


  protected void Page_Load(object sender, EventArgs e)
  {
    //Redirigir al Editor de Solicitudes
    url_destino = "vSolicitud.aspx?action=editar";
    ud = (UserData)Session["userData"]; 
    
       
  }  

  protected void ListaSolicitudGridView_RowDataBound(object sender, GridViewRowEventArgs e)
  {
    if (e.Row.RowType == DataControlRowType.DataRow)
    {
      DataRowView AuxRow = (DataRowView)e.Row.DataItem;
      //e.Row.Attributes.Add("onMouseOver", "MouseOver('" + e.Row.ClientID + "');");
      //e.Row.Attributes.Add("onMouseOut", "MouseOut('" + e.Row.ClientID + "');");
      e.Row.Attributes.Add("onClick", "javascript:CCSOL.Utiles.Redirect('" + this.url_destino + "&SolicitudId=" + AuxRow["solicitudId"].ToString() + "');");
    }
  }

  protected void odsSolicitudLista_Selected(object sender, ObjectDataSourceStatusEventArgs e)
  {
    DataTable dt = (DataTable)(e.ReturnValue);
    if (dt != null)
    {
      this.lblLista.Text = "Lista de Solicitudes (" + dt.Rows.Count + ")";
    }
  }


  protected void imgBtnNuevaSolcitud_Click(object sender, ImageClickEventArgs e)
  {
    decimal solicitudId = GestorSolicitud.SolicitudCreateNew(ud);
    if (solicitudId != -1) Response.Redirect(String.Format("vSolicitud.aspx?SolicitudId={0}&action={1}", solicitudId, "nuevo"), true);
  }
  protected void cbxCliente_DataBound(object sender, EventArgs e)
  {
    GestorCombos.BlockClientDropDownList(this.cbxCliente);
  }
  protected void cbxAseguradora_DataBound(object sender, EventArgs e)
  {
    GestorCombos.BlockAseguradoraDropDownList(this.cbxAseguradora);
  }

  protected void cbxBroker_DataBound(object sender, EventArgs e)
  {
    GestorCombos.BlockBrokerDropDownList(this.cbxBroker);
  }
}
