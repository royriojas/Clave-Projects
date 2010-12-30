using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.IO;
using System.Collections.Generic;

/// <summary>
/// Summary description for Utiles
/// </summary>
/// 
namespace CCSOL.Utiles
{
  public class Utilidades
  {
    public static string ResolveUrl(string url )
    {
        Label ctx = new Label();
        return ctx.ResolveUrl(url);
    }

      public static decimal ConvertToDecimal(object obj) 
    {
      decimal aValue = -1;
      try
      {
        aValue = Convert.ToDecimal(obj);        
      }
      catch (Exception ex)
      {
        LoggerFacade.LogException(ex);
      }
      return aValue;
    }


    /// <summary>
    /// Obtiene un arreglo de BYTES que representan el contenido binario de un archivo para enviarlo directamente a una BD o hacer algun trabajo con él.
    /// </summary>
    /// <param name="f">FileInfo f del archivo del cual se quiere obtener el arreglo de bytes</param>
    /// <returns>arreglo de bytes para hacer algun trabajo con el.</returns>

    public static byte[] getBytesFromFile(FileInfo f)
    {
      byte[] buffer = null;

      try
      {
        buffer = new byte[f.OpenRead().Length];
        f.OpenRead().Read(buffer, 0, (int)f.OpenRead().Length);
      }
      catch (Exception ex)
      {
        LoggerFacade.LogException(ex);
        buffer = null;
      }
      return buffer;
    }

    /// <summary>
    /// Reemplaza las tíldes y otros símbolos por sus respectivas codificaciones HTML 
    /// </summary>
    /// <param name="s">Cadena de donde se obtienen los valores a reemplazar</param>
    /// <returns>Cadena con los valores cambiados</returns>
    public static String encodeStringToHTMLSimbols(String s)
    {
      String html_reporte = s;

      html_reporte = html_reporte.Replace("á", "&aacute;");
      html_reporte = html_reporte.Replace("Á", "&Aacute;");

      html_reporte = html_reporte.Replace("é", "&eacute;");
      html_reporte = html_reporte.Replace("É", "&Eacute;");

      html_reporte = html_reporte.Replace("í", "&iacute;");
      html_reporte = html_reporte.Replace("Í", "&Iacute;");

      html_reporte = html_reporte.Replace("ó", "&oacute;");
      html_reporte = html_reporte.Replace("Ó", "&Oacute;");

      html_reporte = html_reporte.Replace("ú", "&uacute;");
      html_reporte = html_reporte.Replace("Ú", "&Uacute;");

      html_reporte = html_reporte.Replace("$", "US$");

      html_reporte = html_reporte.Replace("ñ", "&ntilde;");
      html_reporte = html_reporte.Replace("Ñ", "&Ntilde;");

      return html_reporte;
    }

    /// <summary>
    /// Añade un item no "bound" a un combobox, util para añadir el texto "elija" o "todos" a los comboboxes
    /// </summary>
    /// <param name="sender">DropDownList al que se le quiere agregar un item</param>
    /// <param name="text">Texto que se mostrará</param>
    /// <param name="value">Valor que tendrá</param>
    /// <param name="posbackFlag">bandera para saber si agregar o no el item dependiendo del isPostBack</param>
    public static void addItemTodos(Object sender, String text, String value, Boolean posbackFlag)
    {
      if (!posbackFlag)
      {
        ((DropDownList)sender).ClearSelection();
        ListItem todosItem = new ListItem(text, value);
        ((DropDownList)sender).Items.Insert(0, todosItem);
      }
    }
    /// <summary>
    /// Devuelve el valor de la propiedad Text de un TextBox contenido dentro de un FormView.
    /// </summary>
    /// <param name="f">FormView del cual se quiere sacar el valor del campo de texto</param>
    /// <param name="Id">String Id del TextBox dentro del FormView</param>
    /// <returns>El valor de la propiedad Text del TextBox pasado como parametro o null si no lo encuentra.</returns>
    public static String getInternalValueFromForm(FormView f, String Id)
    {
      TextBox t = (TextBox)f.FindControl(Id);
      if (t != null)
      {
        return t.Text;
      }
      else return null;
    }
    /// <summary>
    /// Devuelve el valor de la propiedad Text de un TextBox contenido dentro de un FormView o un valor por defecto en caso no encontrarlo.
    /// </summary>
    /// <param name="f">FormView del cual se quiere sacar el valor del campo de texto</param>
    /// <param name="Id">String Id del TextBox dentro del FormView</param>
    /// <param name="DefaultValue">El valor por defecto en caso de no encontrar el DropDownList en el FormView</param>
    /// <returns>El valor de la propiedad Text del TextBox pasado como parametro o null si no lo encuentra.</returns>
    public static String getInternalValueFromForm(FormView f, String Id, String DefaultValue)
    {
      TextBox t = (TextBox)f.FindControl(Id);
      if (t != null)
      {
        return t.Text;
      }
      else return DefaultValue;
    }

    /// <summary>
        /// Devuelve el valor de la propiedad Text de un CheckBox contenido dentro de un FormView.
        /// </summary>
        /// <param name="f">FormView del cual se quiere sacar el valor del campo de texto</param>
        /// <param name="Id">String Id del TextBox dentro del FormView</param>
        /// <returns>El valor de la propiedad Text del CheckBox pasado como parametro o null si no lo encuentra.</returns>
        public static Boolean getInternalValueFromFormCheckBox(FormView f, String Id)
        {
          CheckBox t = (CheckBox)f.FindControl(Id);
          if (t != null)
          {
            return t.Checked;
          }
          else return false;
        }

    /// <summary>
    /// Devuelve el valor de la propiedad SelectedValue de un DropDownList contenido en un FormView
    /// </summary>
    /// <param name="frm">FormView que contiene el DropDownList</param>
    /// <param name="cbxName">Id del DropDownList contenido en el FormView</param>
    /// <returns>El valor de la propiedad SelectedValue o cadena vacía en caso no encontrarlo</returns>
    public static String getInternalValueFromDropDownList(FormView frm, string cbxName)
    {
      DropDownList cbx = (DropDownList)frm.FindControl(cbxName);
      if (cbx != null) return cbx.SelectedValue;
      else return null;
    }

    /// <summary>
    /// Devuelve el valor de la propiedad Text del Item Seleccionado de un DropDownList contenido en un FormView
    /// </summary>
    /// <param name="frm">FormView que contiene el DropDownList</param>
    /// <param name="cbxName">Id del DropDownList contenido en el FormView</param>
    /// <returns>El valor de la propiedad Text o null</returns>
    public static String getInternalTextFromDropDownList(FormView frm, string cbxName)
    {
      DropDownList cbx = (DropDownList)frm.FindControl(cbxName);
      if (cbx != null) return cbx.SelectedItem.Text;
      else return null;
    }
   
    /// <summary>
    /// Devuelve el valor de la propiedad SelectedValue de un DropDownList contenido en un FormView o un valor por defecto
    /// </summary>
    /// <param name="frm">FormView que contiene el DropDownList</param>
    /// <param name="cbxName">Id del DropDownList contenido en el FormView</param>      
    /// <param name="DefaultValue">El valor por defecto a devolver en caso no encontrar el componente</param>
    /// <returns>El valor de la propiedad SelectedValue o cadena vacía en caso no encontrarlo</returns>
    public static String getInternalValueFromDropDownList(FormView frm, string cbxName, String DefaultValue)
    {
      DropDownList cbx = (DropDownList)frm.FindControl(cbxName);
      if (cbx != null) return cbx.SelectedValue;
      else return DefaultValue;
    }

    public static bool IsNumeric(string s)
    {
      try
      {
        Int32.Parse(s);
      }
      catch
      {
        return false;
      }
      return true;
    }
    /// <summary>
    /// Devuelve el valor de la expresión parametro_GET, siempre que no sea null, devuelve un Valor por Omisión en caso contrario
    /// </summary>
    /// <param name="parametro_GET">el valor del parametro a analizar</param>
    /// <param name="valorPorOmision">valor a devolver en caso la cadena sea vacia o null</param>
    /// <returns>el valor del parametro_GET o el valorPorOmision en caso parametro_GET sea null o vacío</returns>
    public static String isNull(String parametro_GET, String valorPorOmision)
    {
      return (!string.IsNullOrEmpty(parametro_GET)) ? parametro_GET : valorPorOmision;
    }

    public static string isNullGet(String parametro_GET, String valorPorOmision)
    {
      return isNull(HttpContext.Current.Request.QueryString[parametro_GET], valorPorOmision);
    }

    public static void setInternalValue(String TextBoxId, String value, FormView frm)
    {
      TextBox t = frm.FindControl(TextBoxId) as TextBox;

      if (t != null)
      {
        t.Text = value;
      }
    }

      public static void setInternalValueCheckBox(String CheckBoxId, Boolean value, FormView frm)
      {
        CheckBox t = (CheckBox)frm.FindControl(CheckBoxId);

        if (t != null)
        {
          t.Checked = value;
        }
      }

      public static void setInternalValueASB(String ASBId, String value, FormView frm)
      {
        ASB.AutoSuggestBox t = null;
        try
        {
          t = (ASB.AutoSuggestBox)frm.FindControl(ASBId);
        }
        catch (Exception ex)
        {
          LoggerFacade.LogException(ex);
          t = null;
        }

        if (t != null)
        {
          t.SelectedValue = value;
        }
      }

    public static String getHTML(Repeater r)
    {
      StringWriter sr = new StringWriter();
      HtmlTextWriter writer = new HtmlTextWriter(sr);
      r.RenderControl(writer);
      writer.Dispose();
      return sr.ToString();

    }
    public static String getHTML(WebControl aControl)
    {
      StringWriter sr = new StringWriter();
      HtmlTextWriter writer = new HtmlTextWriter(sr);
      aControl.RenderControl(writer);
      writer.Dispose();
      return sr.ToString();
    }

    public static void redirectToUrlWhenIsNull(object UserSessionData, String urlActual, string path)
    {

      if (UserSessionData == null)
      {
        try
        {
          HttpContext.Current.Response.Redirect(String.Format("{2}/vLogIn.aspx?urlDest={0}", urlActual,path));
          HttpContext.Current.Response.End();
        }
        catch (Exception ex)
        {
          LoggerFacade.LogException(ex);
        }
      }
    }

    public static void redirectToUrlWhenIsNull(object UserSessionData, String urlActual, bool isCallBack)
    {
      if (!isCallBack) redirectToUrlWhenIsNull(UserSessionData, urlActual);
    }

    public static void redirectToUrlAndShowMessage(String urlActual, String message)
    {
      try
      {
        HttpContext.Current.Response.Redirect(String.Format("vLogIn.aspx?urlDest={0}&msg={1}", urlActual,message));
        HttpContext.Current.Response.End();
      }
      catch (Exception ex)
      {
        LoggerFacade.LogException(ex);
      }
    }


    public static void redirectToUrlWhenIsNull(object UserSessionData, String urlActual)
    {
      if (UserSessionData == null)
      {
        try
        {
          HttpContext.Current.Response.Redirect(String.Format("vLogIn.aspx?urlDest={0}", urlActual));
          HttpContext.Current.Response.End();
        }
        catch (Exception ex)
        {
            LoggerFacade.LogException(ex);
        }
      }
    }

    public static void SetSelectedValue(DropDownList ComboBox, string SelectedValue)
    {      
      ListItem SelectedItem = ComboBox.Items.FindByValue(SelectedValue);
      if (SelectedItem != null)
      {
        ComboBox.ClearSelection();
        SelectedItem.Selected = true;
        ComboBox.Enabled = false;
      }
    }

    public static string GetSystemNameAndVersion()
    {
      return ConfigurationManager.AppSettings["SYSTEM_NAME"] + " " + ConfigurationManager.AppSettings["SYSTEM_VERSION"];
    }

    public static void setValuesForASB(ASB.AutoSuggestBox autoSuggestBox, decimal selectedValue, string Text)
    {
      autoSuggestBox.SelectedValue = selectedValue.ToString();
      autoSuggestBox.Text = Text;
    }

    public static void redirectToUrlAndShowMessage(string url, string mensaje, string Path)
    {
      try
      {
        HttpContext.Current.Response.Redirect(String.Format("{2}/vLogIn.aspx?urlDest={0}&msg={1}", url, mensaje, Path));
        HttpContext.Current.Response.End();
      }
      catch (Exception ex)
      {
        LoggerFacade.LogException(ex);
      }
    }
  }
}
