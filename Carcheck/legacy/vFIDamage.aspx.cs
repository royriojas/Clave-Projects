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

public partial class vFIDamage : System.Web.UI.Page
{
    public EventControl damageCallBack = new EventControl();
    public EventControl damageListCallBack = new EventControl();
    private CallbackEventArgs eventArguments = new CallbackEventArgs();
    public String vehiculoId = null;


    protected void Page_Load(object sender, EventArgs e)
    {
        AjaxPro.Utility.RegisterTypeForAjax(typeof(CarCheck.Gestores.GestorInspeccion));

        if (!IsPostBack)
            CarCheck.Gestores.GestorInspeccion.SeguridadInspeccion(Request.QueryString["uid"], controlPanel);

        vehiculoId = Request.QueryString["VehiculoId"].ToString();
    }

    #region ScriptCallBacks
    protected void Page_Init(object sender, EventArgs e)
    {
        damageCallBack.ScriptCallback += new EventControl.delScriptCallBack(damageCallBack_ScriptCallback);
        AddParsedSubObject(damageCallBack);
        damageListCallBack.ScriptCallback += new EventControl.delScriptCallBack(damageListCallBack_ScriptCallback);
        AddParsedSubObject(damageListCallBack);
    }

    string damageListCallBack_ScriptCallback(CallbackEventArgs eventArgument)
    {
        StringWriter sr = new StringWriter();
        HtmlTextWriter writer = new HtmlTextWriter(sr);
        damageGridView.DataBind();
        damageGridView.RenderControl(writer);
        writer.Dispose();
        return sr.ToString();
    }

    string damageCallBack_ScriptCallback(CallbackEventArgs eventArgument)
    {
        String result = "";
        eventArguments = eventArgument;
        damageFormView.DataBind();

        if (damageFormView.DataItem == null)
        {
            try
            {   
                damageFormView.ChangeMode(FormViewMode.Insert);
                damageFormView.DataBind();
                ListItem ubicacionDamageIdItem = ((DropDownList)damageFormView.FindControl("ubicacionDamageIdCombo")).Items.FindByValue((string)eventArguments.Parameters[0]);
                if (ubicacionDamageIdItem != null)
                {
                    ubicacionDamageIdItem.Selected = true;
                    ((Label)damageFormView.FindControl("ubicacionDamageLabel")).Text = ubicacionDamageIdItem.Text;
                }
            }
            catch (Exception ex) 
            {
 
            }
            
        }

        StringWriter sr = new StringWriter();
        HtmlTextWriter writer = new HtmlTextWriter(sr);
        damageFormView.RenderControl(writer);
        writer.Dispose();
        result = sr.ToString();

        return result;
    }

    #endregion

    protected void odsDamage_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
    {
        if (eventArguments.Parameters.Count > 0)
            e.InputParameters["ubicacionDamageId"] = (string)eventArguments.Parameters[0];
    }
}
