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

#region HelperClass

public class CCK_treeNode : TreeNode, IPostBackDataHandler, INamingContainer
{
  private String radioName;
  public String RadioName
  {
    get { return radioName; }
    set { radioName = value; }
  }
  private String CCK_onClick;
  public String CCK_OnClick
  {
    get { return CCK_onClick; }
    set { CCK_onClick = value; }
  }
  private String uniqueId = "";
  public String UniqueId
  {
    get { return uniqueId; }
    set { uniqueId = value; }
  }

  public CCK_treeNode()
    : base()
  {
  }
  public CCK_treeNode(String text, String value)
    : base(text, value)
  {

  }
  protected override void LoadViewState(object state)
  {
    base.LoadViewState(state);
  }
  protected override object SaveViewState()
  {

    //ViewState["radioName"] = this.RadioName;


    return base.SaveViewState();
  }

  /*
  protected override void LoadViewState(Object savedState)
  {
      if (savedState != null)
      {
          object[] myState = (object[])savedState;
          if (myState[0] != null)
              base.LoadViewState(myState[0]);
          if (myState[1] != null)
              showImageButton = (bool)myState[1];
      }
  }

  protected override Object SaveViewState()
  {
      object baseState = base.SaveViewState();
      object[] allStates = new object[2];
      allStates[0] = baseState;
      allStates[1] = showImageButton;
      return allStates;
  }

  */
  protected override void RenderPreText(HtmlTextWriter writer)
  {
    String temp_UniqueId = this.UniqueId;
    if (String.IsNullOrEmpty(this.UniqueId))
    {
      temp_UniqueId = "node_id_" + this.Value;
    }

    if (!String.IsNullOrEmpty(this.CCK_OnClick))
    {
      writer.WriteLine("<input id='{0}' name=\"{1}\" onclick=\"{2}\" type='radio' value='{3}' />", temp_UniqueId, this.radioName, this.CCK_OnClick, this.Value);
    }
    else
    {
      writer.WriteLine("<input id='{0}' name=\"{1}\" type='radio' value='{2}' />", temp_UniqueId, this.radioName, this.Value);
    }

    writer.WriteLine("<a href='###' onclick='doClickInput(this);' >");

    base.RenderPreText(writer);
  }
  protected override void RenderPostText(HtmlTextWriter writer)
  {
    base.RenderPostText(writer);
    writer.WriteLine("</a>");
  }

  #region Miembros de IPostBackDataHandler

  public bool LoadPostData(string postDataKey, System.Collections.Specialized.NameValueCollection postCollection)
  {
    throw new Exception("The method or operation is not implemented.");
  }

  public void RaisePostDataChangedEvent()
  {
    throw new Exception("The method or operation is not implemented.");
  }

  #endregion
}


#endregion

public partial class vFICaracteristicas : System.Web.UI.Page
{
  public EventControl cckhandler = new EventControl();
  public decimal vehiculoId;

  protected void Page_Load(object sender, EventArgs e)
  {
    AjaxPro.Utility.RegisterTypeForAjax(typeof(CarCheck.Gestores.GestorInspeccion));
    if (Request.QueryString["VehiculoId"] != null) vehiculoId = decimal.Parse(Request.QueryString["VehiculoId"]);
    else Response.Redirect("vLogin.aspx");
    
  }

  protected void Page_Init(object sender, EventArgs e)
  {
    cckhandler.ScriptCallback += new EventControl.delScriptCallBack(cckhandler_ScriptCallback);
    this.AddParsedSubObject(cckhandler);
  }

  string cckhandler_ScriptCallback(CallbackEventArgs eventArgument)
  {
    decimal PropId = Convert.ToDecimal(eventArgument.Parameters[0]);

    this.UcPnlPropiedadesVehiculo.PropiedadId = PropId;

    string results;

    StringWriter sr = new StringWriter();
    HtmlTextWriter writer = new HtmlTextWriter(sr);
    UcPnlPropiedadesVehiculo.RenderControl(writer);
    writer.Dispose();
    results = sr.ToString();

    return results + "$$$$_$$$$" + Cargar_Grilla(PropId, decimal.Parse(Request.QueryString["VehiculoId"]));
  }

  protected string Cargar_Grilla(decimal masterPropiedadId, decimal vehiculoId)
  {
    string results = "No se han registrados estas caracteristicas";
    //Saco los registros para esa propiedad
    PropiedadVehiculoTableAdapters.PropiedadSelectTableAdapter propiedadAdapter = new PropiedadVehiculoTableAdapters.PropiedadSelectTableAdapter();    
    PropiedadVehiculo.PropiedadSelectDataTable dtCaracteristica = new PropiedadVehiculo.PropiedadSelectDataTable();
    dtCaracteristica = propiedadAdapter.GetData(masterPropiedadId, vehiculoId);
    int numePropiedadesRegistradas = dtCaracteristica.Rows.Count;

    if (numePropiedadesRegistradas > 0)
    {
      Table table = new Table();
      table.BorderStyle = BorderStyle.Solid;
      table.CellPadding = 0;
      table.CellSpacing = 1;
      table.BorderWidth = 1;

      //Saco los titulos que corresponde para esa propiedad
      PropiedadVehiculoTableAdapters.CaracteristicasDePropiedadTableAdapter caracteristicaAdapter = new PropiedadVehiculoTableAdapters.CaracteristicasDePropiedadTableAdapter();
      PropiedadVehiculo.CaracteristicasDePropiedadDataTable caracteristicaTabla = new PropiedadVehiculo.CaracteristicasDePropiedadDataTable();
      caracteristicaTabla = caracteristicaAdapter.GetData(masterPropiedadId);
      int numeCaracteristicas = caracteristicaTabla.Rows.Count;

      TableRow headerRow = new TableRow();
      headerRow.Attributes.Add("class", "HeaderStyle");

      foreach (PropiedadVehiculo.CaracteristicasDePropiedadRow caracteristicaRow in caracteristicaTabla.Rows)
      {
        TableCell cell = new TableCell();
        cell.Text = caracteristicaRow.caracteristica;
        cell.Width = 100;
        headerRow.Cells.Add(cell);
      }

      TableCell cellColumnObservacion = new TableCell();
      cellColumnObservacion.Text = "OBSERVACIÓN";
      cellColumnObservacion.Style.Value = "width:300px;";
      cellColumnObservacion.HorizontalAlign = HorizontalAlign.Center; 
      headerRow.Cells.Add(cellColumnObservacion);

      TableCell cellColumnAccion = new TableCell();
      cellColumnAccion.Text = "ACCIÓN";
      cellColumnAccion.HorizontalAlign = HorizontalAlign.Center;  

      headerRow.Cells.Add(cellColumnAccion);

      table.Rows.Add(headerRow);

      decimal numeroFilas = numePropiedadesRegistradas / numeCaracteristicas;
      int j = 0;
      for (int i = 0; i < numeroFilas; i++)
      {
        TableRow dataRow = new TableRow();
        dataRow.Attributes.Add("class", "ItemStyle");
        decimal propiedadId = 0;
        string observacion;

        
        for (int k = 0; k < numeCaracteristicas; k++)
        {
          PropiedadVehiculo.PropiedadSelectRow propiedadRow = (PropiedadVehiculo.PropiedadSelectRow)dtCaracteristica.Rows[j];
          TableCell cellPropiedad = new TableCell();
          
          cellPropiedad.Text = propiedadRow.valorCaracteristica.ToUpper() == "CUALQUIERA" ? propiedadRow.valor : propiedadRow.valorCaracteristica;
          if (propiedadRow.valorCaracteristica == "1") cellPropiedad.Text = "SÍ";
          if (propiedadRow.valorCaracteristica == "0") cellPropiedad.Text = "NO";

          dataRow.Cells.Add(cellPropiedad);
          propiedadId = propiedadRow.propiedadId;
          j++;
        }

        observacion = null;
        propiedadAdapter.GetObservacion(propiedadId, ref observacion);

        TableCell cellObservacion = new TableCell();
        cellObservacion.Text = observacion;
        cellObservacion.Style.Value = "width:300px;";
        dataRow.Cells.Add(cellObservacion);





        TableCell cellAccion = new TableCell();
        cellAccion.HorizontalAlign = HorizontalAlign.Center;
        HyperLink deleteHyperLink = new HyperLink();
        deleteHyperLink.Text = "Eliminar registro";
        deleteHyperLink.ImageUrl = "Images/IconDelete.gif";
        deleteHyperLink.NavigateUrl = string.Format("javascript:Eliminar('{0}')", propiedadId.ToString());
        cellAccion.Controls.Add(deleteHyperLink);

        dataRow.Cells.Add(cellAccion);

        table.Rows.Add(dataRow);
      }

      StringWriter sr = new StringWriter();
      HtmlTextWriter writer = new HtmlTextWriter(sr);
      table.RenderControl(writer);
      writer.Dispose();
      results = sr.ToString();
    }

    return results;
  }

  protected override void OnPreRender(EventArgs e)
  {
    decimal PropId = Convert.ToDecimal(Request.QueryString["PropiedadId"]);

    this.UcPnlPropiedadesVehiculo.PropiedadId = PropId;
    //Session["PropiedadesControl"] = this.UcPnlPropiedadesVehiculo;

    if (!IsPostBack) this.createTreeViewStructure();

    base.OnPreRender(e);

  }

  #region treeView

  private void createTreeViewStructure()
  {
    //creando el nodo principal
    /* TreeNode rootNode = new TreeNode();
     rootNode.SelectAction = TreeNodeSelectAction.Expand;
     rootNode.Text = "Características";
     this.treeViewPropiedadesVehiculo.Nodes.Add(rootNode);
     */

    PropiedadVehiculoTableAdapters.CATEGORIATableAdapter ta = new PropiedadVehiculoTableAdapters.CATEGORIATableAdapter();
    PropiedadVehiculo.CATEGORIADataTable dt = ta.GetData();

    foreach (PropiedadVehiculo.CATEGORIARow row in dt)
    {

      CCK_treeNode aSimpleNode = new CCK_treeNode();
      aSimpleNode.SelectAction = TreeNodeSelectAction.None;
      aSimpleNode.Text = "<strong>" + row.categoria + "</strong>";
      aSimpleNode.Value = row.categoriaId.ToString();
      aSimpleNode.UniqueId = "Categoria_Id_" + row.categoriaId.ToString();
      aSimpleNode.RadioName = "CategoriaNode";
      aSimpleNode.CCK_OnClick = "";
      aSimpleNode.Expanded = false;
      this.treeViewPropiedadesVehiculo.Nodes.Add(aSimpleNode);
      creaNodosPropiedades(aSimpleNode);

    }

  }

  private void creaNodosPropiedades(CCK_treeNode aSimpleNode)
  {
    PropiedadVehiculoTableAdapters.M_PROPIEDADTableAdapter ta = new PropiedadVehiculoTableAdapters.M_PROPIEDADTableAdapter();
    PropiedadVehiculo.M_PROPIEDADDataTable dt = ta.GetData(Convert.ToDecimal(aSimpleNode.Value));

    if (dt.Rows.Count > 0)
    {
      foreach (PropiedadVehiculo.M_PROPIEDADRow row in dt)
      {
        CCK_treeNode otherNode = new CCK_treeNode();
        otherNode.SelectAction = TreeNodeSelectAction.None;
        otherNode.Text = row.masterPropiedad;
        otherNode.Value = row.masterPropiedadId.ToString();
        otherNode.RadioName = "PropiedadNode";
        otherNode.CCK_OnClick = String.Format("doClickCategoria('{0}');doRefresh(this,{1});", aSimpleNode.UniqueId, row.masterPropiedadId);
        aSimpleNode.ChildNodes.Add(otherNode);

      }
    }
  }

  #endregion
}
