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
using AjaxCanales.Utiles;
using System.IO;
using CCSOL.Utiles;

public partial class vListaInspeccion : System.Web.UI.Page
{
  public int num = 1;

  protected void Page_Load(object sender, EventArgs e)
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


  #region CallBacks
  public EventControl callback_gridComunicacion = new EventControl();

  protected void Page_Init(object sender, EventArgs e)
  {
    callback_gridComunicacion.ScriptCallback += new EventControl.delScriptCallBack(cargar_gridComunicacion_ScriptCallback);
    this.AddParsedSubObject(callback_gridComunicacion);
  }

  public string cargar_gridComunicacion_ScriptCallback(CallbackEventArgs eventArgument)
  {
    string inspeccionId = (string)eventArgument.Parameters[0];
    dsInspeccionesTableAdapters.ComunicacionInspeccionTableAdapter dsCom = new dsInspeccionesTableAdapters.ComunicacionInspeccionTableAdapter();
    this.comunicacionGridView.DataSource = dsCom.GetData(Convert.ToInt32(inspeccionId));
    this.comunicacionGridView.DataBind();
    return Utilidades.getHTML(this.comunicacionGridView);

  }


  #endregion

  protected void ListaInspeccionGridView_RowDataBound(object sender, GridViewRowEventArgs e)
  {
    if (e.Row.RowType == DataControlRowType.DataRow)
    {
      DataRowView AuxRow = (DataRowView)e.Row.DataItem;
      e.Row.Attributes.Add("id", e.Row.ClientID);
      e.Row.Attributes.Add("contacto", AuxRow["contacto"].ToString());
      e.Row.Attributes.Add("inspeccionId", AuxRow["inspeccionId"].ToString());
      e.Row.Attributes.Add("VehiculoId", AuxRow["vehiculoId"].ToString());
      e.Row.Attributes.Add("estadoInspeccionId", AuxRow["estadoInspeccionId"].ToString());
    }
  }

  protected void odsInspeccionLista_Selected(object sender, ObjectDataSourceStatusEventArgs e)
  {
    DataTable dt = (DataTable)(e.ReturnValue);
    if (dt != null)
    {

      this.lblLista.Text = "Lista de Inspeccones (" + dt.Rows.Count + ")";

    }
  }

}
