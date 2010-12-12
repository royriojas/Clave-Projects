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

public partial class vReporte : System.Web.UI.Page
{
    public int num=1;
    private string url_destino;  
    
    protected void Page_Load(object sender, EventArgs e)
    {

        //Redirigir al Editor de Solicitudes

        url_destino = " vInspecciones.aspx?action=editar";            
        
    }  

    protected void btnBuscar_Click(object sender, ImageClickEventArgs e)
    {
      
    }

    #region cargaCombos
    protected void cbxTipoRequerimiento_DataBound(object sender, EventArgs e)
    {
        CCSOL.Utiles.Utilidades.addItemTodos(sender, "[ TODOS ]", "", IsPostBack);
    }
    protected void cbxPrioridad_DataBound(object sender, EventArgs e)
    {
        CCSOL.Utiles.Utilidades.addItemTodos(sender, "[ TODOS ]", "", IsPostBack);
    }
    protected void cbxEstado_DataBound(object sender, EventArgs e)
    {
        CCSOL.Utiles.Utilidades.addItemTodos(sender, "[ TODOS ]", "", IsPostBack);
    }
    protected void cbxCanal_DataBound(object sender, EventArgs e)
    {
        CCSOL.Utiles.Utilidades.addItemTodos(sender, "[ TODOS ]", "", IsPostBack);
    }
    protected void cbxTipoRequerimiento_SelectedIndexChanged(object sender, EventArgs e)
    {
        CCSOL.Utiles.Utilidades.addItemTodos(sender, "[ TODOS ]", "", IsPostBack);
    }
    protected void cbxAseguradora_DataBound(object sender, EventArgs e)
    {
        CCSOL.Utiles.Utilidades.addItemTodos(sender, "[ TODOS ]", "", IsPostBack);
    }
    protected void cbxBroker_DataBound(object sender, EventArgs e)
    {
        CCSOL.Utiles.Utilidades.addItemTodos(sender, "[ TODOS ]", "", IsPostBack);
    }
    #endregion
    protected void ListaSolicitudGridView_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DataRowView AuxRow = (DataRowView)e.Row.DataItem;
            e.Row.Attributes.Add("id", e.Row.ClientID);
            e.Row.Attributes.Add("onMouseOver", "MouseOver('" + e.Row.ClientID + "');");
            e.Row.Attributes.Add("onMouseOut", "MouseOut('" + e.Row.ClientID + "');");
            e.Row.Attributes.Add("onClick", "javascript:Redirect('" + this.url_destino + "&SolicitudId=" + AuxRow["solicitudId"].ToString() + "');");
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
}
