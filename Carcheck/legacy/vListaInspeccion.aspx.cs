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
using CarCheck.Gestores;

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
    return GestorInspeccion.getDatosCita(inspeccionId, this.comunicacionGridView);
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
      e.Row.Attributes.Add("numAmpliatorios", AuxRow["numAmpliatorios"].ToString());
    }
  }

  protected void odsInspeccionLista_Selected(object sender, ObjectDataSourceStatusEventArgs e)
  {
    DataTable dt = (DataTable)(e.ReturnValue);
    if (dt != null)
    {

      this.lblLista.Text = "Lista de Inspecciones (" + dt.Rows.Count + ")";

    }
  }

  protected void cbxCliente_DataBound(object sender, EventArgs e)
  {
    GestorCombos.BlockClientDropDownList(this.cbxCliente);
    //if (this.cbxCliente.)
    
  }
  protected void cbxAseguradora_DataBound1(object sender, EventArgs e)
  {
    GestorCombos.BlockAseguradoraDropDownList(this.cbxAseguradora);
  }
  protected void cbxBroker_DataBound1(object sender, EventArgs e)
  {
    GestorCombos.BlockBrokerDropDownList(this.cbxBroker);
  }
  protected void btnBuscar_Click(object sender, ImageClickEventArgs e)
  {

  }
  protected void cbxInspector_DataBound(object sender, EventArgs e)
  {
    GestorCombos.BlockInspectorDropDownList(this.cbxInspector);
  }


  public bool showBeVisibleInformIcon(Object inspeccionId, object estadoInspeccionId)
  {
    bool showBeVisible = GestorInspeccion.InspeccionIsAprobada(inspeccionId.ToString());
    return showBeVisible && EstadoInspeccion.TERMINADA == estadoInspeccionId.ToString();
  }

  public bool shouldBeVisibleAmpliatorioIcon(Object num)
  {
    return Utilidades.ConvertToDecimal(num) > 0;
  }

  public string getCorrectUrl(object num) {
    //string num_s = num.ToString();
    return String.Format("vGetImageAmpliatorio.aspx?canAmpl={0}", num);
  }
}
