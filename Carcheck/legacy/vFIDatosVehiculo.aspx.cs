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
using CarCheck.Gestores;
using CCSOL.Utiles;

public partial class vFIDatosVehiculo : System.Web.UI.Page
{
  protected void Page_Load(object sender, EventArgs e)
  {
    AjaxPro.Utility.RegisterTypeForAjax(typeof(vFIDatosVehiculo));


    //CarCheck.Gestores.GestorInspeccion.SeguridadInspeccion(Request.QueryString["uid"], controlPanel);
    // -> llamada al metodo que checkea la seguridad del panel

  }
  #region AjaxMethods

  [AjaxPro.AjaxMethod]
  public valorComerical getValorComercial(string claseId, string marcaId, string modelo, string anhoFabricacion)
  {

    valorComerical salida = new valorComerical();
    ADM_DAL.dsADMTableAdapters.ValorComercialTableAdapter vcTa = new ADM_DAL.dsADMTableAdapters.ValorComercialTableAdapter();
    ADM_DAL.dsADM.ValorComercialDataTable vcDt = new ADM_DAL.dsADM.ValorComercialDataTable();
    DateTime fecha = new DateTime(Convert.ToInt32(anhoFabricacion), 1, 1);
    try
    {
      vcDt = vcTa.GetData(fecha, Convert.ToInt32(marcaId), Convert.ToInt32(modelo), Convert.ToInt32(claseId));
      if (vcDt.Rows.Count > 0)
      {

        ADM_DAL.dsADM.ValorComercialRow row = (ADM_DAL.dsADM.ValorComercialRow)vcDt.Rows[0];
        salida.valor = "" + row.valorComercial;
        salida.moneda = "" + row.simbolo;
        salida.monedaId = "" + row.monedaId;

      }
    }
    catch (Exception ex)
    {
    }
    return salida;
  }

  [AjaxPro.AjaxMethod]
  public OptionItem[] getMarcasVehiculo(string claseId)
  {
    return GestorCombos.getMarcasVehiculo(claseId);
  }
  [AjaxPro.AjaxMethod]
  public OptionItem[] getModelosVehiculo(string claseId, string marcaId)
  {
    return GestorCombos.getModelosVehiculo(claseId, marcaId);
  }

  [AjaxPro.AjaxMethod]
  public string[] isValidPunra(string nroPlaca)
  {
    int? resultadoOut = 0;
    string mensaje = "";
    string ubigeoId = "";
    string Ubigeo = "";
    int? claseVehiculoIdOut = null;

    ADM_DAL.dsADMTableAdapters.Querys myTa = new ADM_DAL.dsADMTableAdapters.Querys();
    myTa.PunraCheck(nroPlaca, ref resultadoOut, ref mensaje, ref ubigeoId, ref Ubigeo, ref claseVehiculoIdOut);

    string[] resultado = new string[5];

    resultado[0] = resultadoOut.ToString();
    resultado[1] = mensaje;
    resultado[2] = ubigeoId;
    resultado[3] = Ubigeo;
    resultado[4] = claseVehiculoIdOut.ToString();

    return resultado;
  }

  [AjaxPro.AjaxMethod]
  public string isValidAmountOfMoney(string valorComercial,
                          string valorComercialId,
                          string valorInspector,
                          string valorInspectorId,
                          string castigo)
  {
    string result = "NV";
    if (String.IsNullOrEmpty(valorComercial) || String.IsNullOrEmpty(valorComercialId) || String.IsNullOrEmpty(valorInspector) || String.IsNullOrEmpty(valorInspectorId))
      return result;

    decimal moneyComercial;
    decimal moneyInspector;
    decimal moneyCastigo;
    bool result_out = false;

     
    if (decimal.TryParse(valorComercial, out moneyComercial))
    {
      if (decimal.TryParse(valorInspector, out moneyInspector))
      {
        if (decimal.TryParse(castigo, out moneyCastigo))

          try
          {
            decimal? moneyInspectorSoles = (moneyInspector * ADM_DAL.dsADM.getTipoCambioByMonedaId(valorInspectorId));
            decimal? moneyComercialSoles = moneyComercial * ADM_DAL.dsADM.getTipoCambioByMonedaId(valorComercialId);
            result_out = moneyInspectorSoles <= ((moneyComercialSoles) - ((moneyCastigo / 100) * moneyComercialSoles));

          }
          catch (Exception ex)
          {
            result = ex.Message;
          }
      }
      if (result_out)
      {
        result = "CV"; //cantidad Valida
      }

    }
    return result;
  }

  #endregion

  private void cbxUpdateClaseMarcaModelo()
  {
    try
    {
      DropDownList cbxMarca = (DropDownList)this.frmDatosVehiculo.FindControl("cbxMarca");

      string ClaseVehiculoId = Utilidades.getInternalValueFromForm(this.frmDatosVehiculo, "txtClaseVehiculoId");
      if (ClaseVehiculoId != "-1")
      {
        //Asignamos el origen de Marcas dependiendo de la clase seleccionada.
        cbxMarca.DataSource = GestorCombos.getMarcasVehiculoDataTable(ClaseVehiculoId);
        cbxMarca.DataValueField = "marcaVehiculoId";
        cbxMarca.DataTextField = "marcaVehiculo";
        cbxMarca.DataBind();

        //Asignamos el SelectedValue al valor que está obtenido en el frmDatosVehiculo
        string MarcaVehiculoId = Utilidades.getInternalValueFromForm(this.frmDatosVehiculo, "txtMarcaVehiculoId");

        cbxMarca.ClearSelection();
        cbxMarca.Items.FindByValue(MarcaVehiculoId).Selected = true;


        // ahora procedemos a verificar que la marca sea también diferente de -1 para poder hacer exactamente lo mismo
        // que con la marcaVehiculoId
        if (MarcaVehiculoId != "-1")
        {
          DropDownList cbxModelo = (DropDownList)this.frmDatosVehiculo.FindControl("cbxModelo");
          cbxModelo.DataSource = GestorCombos.getModelosVehiculoDataTable(ClaseVehiculoId, MarcaVehiculoId);
          cbxModelo.DataValueField = "modeloVehiculoId";
          cbxModelo.DataTextField = "modeloVehiculo";
          cbxModelo.DataBind();
          //Asignamos el SelectedValue al valor que está obtenido en el frmDatosVehiculo
          string ModeloVehiculoId = Utilidades.getInternalValueFromForm(this.frmDatosVehiculo, "txtModeloVehiculoId");

          cbxModelo.ClearSelection();
          cbxModelo.Items.FindByValue(ModeloVehiculoId).Selected = true;

        }

      }
    }
    catch (Exception ex)
    {
      //Response.Write(ex.Message);
    }
  }

  protected void FormView1_DataBound(object sender, EventArgs e)
  {

    cbxUpdateClaseMarcaModelo();

  }

  protected void btnSave_Click(object sender, ImageClickEventArgs e)
  {
    frmDatosVehiculo.UpdateItem(true);
    Response.Redirect(Request.RawUrl, true);
  }

  protected void frmDatosVehiculo_ItemUpdating(object sender, FormViewUpdateEventArgs e)
  {
    int year;
    if (int.TryParse(Utilidades.getInternalValueFromForm(this.frmDatosVehiculo, "txtAnho"), out year))
    {
      DateTime d = new DateTime(year, 1, 1);
      e.NewValues.Add("anhoFabricacion", d);

      try
      {
        UserData ud = (UserData)Session["UserData"];
        e.NewValues.Add("uupdate", ud.UserName);
      }
      catch (Exception ex)
      {
        Response.Write(ex.Message);
      }

      e.NewValues.Add("modeloVehiculo", Utilidades.getInternalTextFromDropDownList(this.frmDatosVehiculo, "cbxModelo"));
    }

  }



}
