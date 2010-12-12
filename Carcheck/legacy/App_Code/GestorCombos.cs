using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using AjaxPro;
using System.Collections;
using ADM_DAL.dsDropDownListTableAdapters;
using System.Collections.Generic;
/// <summary>
/// Summary description for GestorCombos
/// </summary>
/// 
public class OptionItem
{
  public string value;
  public string Value
  {
    get
    {
      return value;
    }
    set
    {
    	this.value = value;
    }
  }
  public string text;
  public string Text
  {
    get
    {
      return text;
    }
    set
    {
    	this.text = value;
    }
  }

  public OptionItem()
  {

  }
}


namespace CarCheck.Gestores
{


  public class GestorCombos
  {
    public GestorCombos()
    {
      //
      // TODO: Add constructor logic here
      //     
    }

    public static OptionItem[] getMarcasVehiculo(string claseId)
    {
      decimal d_claseId;
      ArrayList items = new ArrayList();

      OptionItem FirsItem = new OptionItem();
      FirsItem.text = "[ - Elija - ]";
      FirsItem.value = "-1";
      items.Add(FirsItem);

      if (decimal.TryParse(claseId, out d_claseId))
      {
        MarcaVehiculoLoadDropDownTableAdapter taa = new MarcaVehiculoLoadDropDownTableAdapter();
        try
        {
          ADM_DAL.dsDropDownList.MarcaVehiculoLoadDropDownDataTable dataTable = taa.GetData(d_claseId);


          if (dataTable.Rows.Count > 0)
          {
            foreach (ADM_DAL.dsDropDownList.MarcaVehiculoLoadDropDownRow item in dataTable)
            {
              OptionItem aItem = new OptionItem();
              aItem.text = item.marcaVehiculo;
              aItem.value = item.marcaVehiculoId.ToString();
              items.Add(aItem);
            }
          }
        }
        catch (Exception ex)
        {

        }
      }
      return (OptionItem[])items.ToArray(Type.GetType("OptionItem"));
    }

    public static ADM_DAL.dsDropDownList.MarcaVehiculoLoadDropDownDataTable getMarcasVehiculoDataTable(string claseId)
    {
      ADM_DAL.dsDropDownList.MarcaVehiculoLoadDropDownDataTable dataTable = null;
      decimal d_claseId;
      if (decimal.TryParse(claseId, out d_claseId))
      {
        MarcaVehiculoLoadDropDownTableAdapter taa = new MarcaVehiculoLoadDropDownTableAdapter();
        dataTable = taa.GetData(d_claseId);
      }
      else
      {
        throw new System.FormatException("No se puede convertir el String Clase a un valor decimal");
      }
      return dataTable;
    }

    public static OptionItem[] getModelosVehiculo(string claseId, string marcaId)
    {
      decimal d_claseId;
      decimal d_marcaId;
      ArrayList items = new ArrayList();

      OptionItem FirsItem = new OptionItem();
      FirsItem.text = "[ - Elija - ]";
      FirsItem.value = "-1";
      items.Add(FirsItem);

      if (decimal.TryParse(claseId, out d_claseId))
      {
        if (decimal.TryParse(marcaId, out d_marcaId))
        {

          ModeloVehiculoLoadDropDownTableAdapter taa = new ModeloVehiculoLoadDropDownTableAdapter();
          try
          {
            ADM_DAL.dsDropDownList.ModeloVehiculoLoadDropDownDataTable dataTable = taa.GetData(d_claseId, d_marcaId);


            if (dataTable.Rows.Count > 0)
            {
              foreach (ADM_DAL.dsDropDownList.ModeloVehiculoLoadDropDownRow item in dataTable)
              {
                OptionItem aItem = new OptionItem();
                aItem.text = item.modeloVehiculo;
                aItem.value = item.modeloVehiculoId.ToString();
                items.Add(aItem);
              }
            }
          }
          catch (Exception ex)
          {

          }
        }
      }
      return (OptionItem[])items.ToArray(Type.GetType("OptionItem"));
    }

    public static ADM_DAL.dsDropDownList.ModeloVehiculoLoadDropDownDataTable getModelosVehiculoDataTable(string claseId, string marcaId)
    {
      decimal d_claseId;
      decimal d_marcaId;
      ADM_DAL.dsDropDownList.ModeloVehiculoLoadDropDownDataTable dataTable = null;
      if (decimal.TryParse(claseId, out d_claseId))
      {
        if (decimal.TryParse(marcaId, out d_marcaId))
        {

          ModeloVehiculoLoadDropDownTableAdapter taa = new ModeloVehiculoLoadDropDownTableAdapter();
          dataTable = taa.GetData(d_claseId, d_marcaId);
        }
        else
        {
          throw new System.FormatException("No se puede convertir el String Clase a un valor decimal");
        }
      }
      else
      {
        throw new System.FormatException("No se puede convertir el String Clase a un valor decimal");
      }
      return dataTable;

    }

    [System.ComponentModel.DataObjectMethod(System.ComponentModel.DataObjectMethodType.Select)]
    public List<OptionItem> tipoTraccionCombo()
    {
      List<OptionItem> items = new List<OptionItem>();
     
      OptionItem item = new OptionItem();
      item.value = "D";
      item.text = "DELANTERA";
      items.Add(item);

      item = new OptionItem();
      item.value = "P";
      item.text = "POSTERIOR";
      items.Add(item);

      return items;
    }
    
    [System.ComponentModel.DataObjectMethod(System.ComponentModel.DataObjectMethodType.Select)]
    public List<OptionItem> tipoTimonCombo()
    {
      List<OptionItem> items = new List<OptionItem>();

      OptionItem item = new OptionItem();
      item.value = "O";
      item.text = "ORIGINAL";
      items.Add(item);

      item = new OptionItem();
      item.value = "C";
      item.text = "CAMBIADO";
      items.Add(item);

      return items;
    }
  }
}
