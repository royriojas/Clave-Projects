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
using CustomItem;


public partial class ucPnlPropiedades : System.Web.UI.UserControl
{
  private decimal propiedadId;
  public String Identifier;

  public Decimal PropiedadId
  {
    get
    {
      return propiedadId;
    }
    set
    {
      propiedadId = value;
    }
  }

  protected void Page_Load(object sender, EventArgs e)
  {

  }

  public void doGeneration()
  {

    generaCamposDelFormulario();
  }
  protected void Panel1_PreRender(object sender, EventArgs e)
  {
    this.Identifier = this.ID + "_";
    //doGeneration();
  }

  protected override void Render(HtmlTextWriter writer)
  {
    doGeneration();
    base.Render(writer);
  }

  private void generaCamposDelFormulario()
  {
    PropiedadVehiculoTableAdapters.CaracteristicasDePropiedadTableAdapter taCaracteristicas = new PropiedadVehiculoTableAdapters.CaracteristicasDePropiedadTableAdapter();
    PropiedadVehiculo.CaracteristicasDePropiedadDataTable dtValoresCaracteristicas = taCaracteristicas.GetData(propiedadId);

    int contador = 0;
    if (dtValoresCaracteristicas.Rows.Count > 0)
    {
      PropiedadVehiculo.CaracteristicasDePropiedadRow myRow = (PropiedadVehiculo.CaracteristicasDePropiedadRow)dtValoresCaracteristicas.Rows[0];

      this.lblTituloPropiedad.Text = myRow.masterPropiedad;
      this.propiedadPanel.Attributes.Add("propiedadId", this.PropiedadId.ToString());

      foreach (PropiedadVehiculo.CaracteristicasDePropiedadRow row in dtValoresCaracteristicas)
      {
        WebCustomItem control = new WebCustomItem();
        control.TControl = TipoControl.textBox;
        isCombo(row.masterCaracteristicaId, propiedadId, control,contador++);
        control.Label = row.caracteristica;
        this.pnlContainer.Controls.Add(control);
      }
    }



  }

  private void isCombo(decimal caracteristicaId, decimal propiedadId, WebCustomItem control,int contador)
  {
    PropiedadVehiculoTableAdapters.ValoresCaracteristicaTableAdapter ta = new PropiedadVehiculoTableAdapters.ValoresCaracteristicaTableAdapter();
    PropiedadVehiculo.ValoresCaracteristicaDataTable dt = ta.GetData(propiedadId, caracteristicaId);
    
    if (dt.Rows.Count > 1)
    {

      if (shouldBeCheckBox(dt))
      {
        control.TControl = TipoControl.checkBox;
        control.CheckBoxEle = new CheckBox();
        control.CheckBoxEle.CssClass = "FormCheck";
        control.CheckBoxEle.InputAttributes.Add("isValidControl", "isValidControl");
        control.CheckBoxEle.InputAttributes.Add("nombrecampoId", ((PropiedadVehiculo.ValoresCaracteristicaRow)dt.Rows[0]).masterCaracteristicaId.ToString());

        //por convención debería ingresarse en la tabla valoresCaracteristicas primero el valor del 0 a toda aquella característica que se quiera sea checkbox
        // WARNING : ESTO FALLARÁ EN CASO NO SE RESPETE QUE PARA UNA MISMA CARACTACTERISTICA TIPO CHECKBOX SOLO VALE 1 Ó 0
        decimal theIdOfValueOn = ((PropiedadVehiculo.ValoresCaracteristicaRow)dt.Rows[0]).valorCaracteristica == "1" ? ((PropiedadVehiculo.ValoresCaracteristicaRow)dt.Rows[0]).valorCaracteristicaId : ((PropiedadVehiculo.ValoresCaracteristicaRow)dt.Rows[1]).valorCaracteristicaId;
        decimal theIdOfValueOff = ((PropiedadVehiculo.ValoresCaracteristicaRow)dt.Rows[0]).valorCaracteristica == "0" ? ((PropiedadVehiculo.ValoresCaracteristicaRow)dt.Rows[0]).valorCaracteristicaId : ((PropiedadVehiculo.ValoresCaracteristicaRow)dt.Rows[1]).valorCaracteristicaId;


       
        control.CheckBoxEle.InputAttributes.Add("valueOn", theIdOfValueOn.ToString() );
        control.CheckBoxEle.InputAttributes.Add("valueOff", theIdOfValueOff.ToString());

        control.CheckBoxEle.InputAttributes.Add("order",contador.ToString());


      }
      else
      {

        control.TControl = TipoControl.dropDownList;
        control.DropDownEle = new DropDownList();
        control.DropDownEle.Width = 174;
        control.DropDownEle.CssClass = "FormText";
        control.DropDownEle.Attributes["isValidControl"] = "isValidControl";
        control.DropDownEle.Attributes.Add("order", contador.ToString());
        control.DropDownEle.Attributes["nombrecampoId"] = ((PropiedadVehiculo.ValoresCaracteristicaRow)dt.Rows[0]).masterCaracteristicaId.ToString();
        control.DropDownEle.Items.Add(new ListItem("- Elija -", "-1"));

        foreach (PropiedadVehiculo.ValoresCaracteristicaRow row in dt)
        {
          control.DropDownEle.Items.Add(new ListItem(row.valorCaracteristica.ToString(), row.valorCaracteristicaId.ToString()));
        }
      }     
    }
    else
    {
      if (dt.Rows.Count > 0)
      {
        control.TControl = TipoControl.textBox;
        control.TextBoxEle = new TextBox();
        control.TextBoxEle.Width = 170;
        control.TextBoxEle.CssClass = "FormText MAYUSC";
        control.TextBoxEle.Attributes.Add("order", contador.ToString());
        control.TextBoxEle.Attributes["isValidControl"] = "isValidControl";
        control.TextBoxEle.Attributes["nombrecampoId"] = ((PropiedadVehiculo.ValoresCaracteristicaRow)dt.Rows[0]).masterCaracteristicaId.ToString();
        control.TextBoxEle.Attributes["valorCaracteristicaId"] = ((PropiedadVehiculo.ValoresCaracteristicaRow)dt.Rows[0]).valorCaracteristicaId.ToString();
      }
    }


  }

  private bool shouldBeCheckBox(PropiedadVehiculo.ValoresCaracteristicaDataTable dt)
  {
    Boolean isCheck = ((((PropiedadVehiculo.ValoresCaracteristicaRow)(dt.Rows[0])).valorCaracteristica == "0") || (((PropiedadVehiculo.ValoresCaracteristicaRow)(dt.Rows[0])).valorCaracteristica == "1"))
                &&
                ((((PropiedadVehiculo.ValoresCaracteristicaRow)(dt.Rows[1])).valorCaracteristica == "0") || (((PropiedadVehiculo.ValoresCaracteristicaRow)(dt.Rows[1])).valorCaracteristica == "1"));
    return isCheck;
  }
  public String getIdentifier()
  {
    return this.Identifier;
  }
}
