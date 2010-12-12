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
using CCSOL.Utiles;
using CarCheck.Gestores;

public partial class vFIDatosPersonales : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Utility.RegisterTypeForAjax(typeof(vFIDatosPersonales));
        if (!IsPostBack)
            CarCheck.Gestores.GestorInspeccion.SeguridadInspeccion(Request.QueryString["uid"], controlPanel);
        

    }
    protected void UcHeader1_Load(object sender, EventArgs e)
    {

    }
    protected void odsContratante_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
    {

    }
    protected void guardarImageButton_Click(object sender, ImageClickEventArgs e)
    {
        
        frmvAlertas.UpdateItem(true);
          
        TextBox txbCambio = (TextBox)frmvAsegurado.FindControl("txtCambio");
        TextBox txbAseguId = (TextBox)frmvAsegurado.FindControl("txtAseguradoId");
        dsAseguradoTableAdapters.AseguradoTableAdapter aseguradoTA = new dsAseguradoTableAdapters.AseguradoTableAdapter();
        if ((txbCambio.Text == "1") && txbAseguId.Text == "")
        {
            //inserta nuevo asegurado
            this.frmvAsegurado.ChangeMode(FormViewMode.Insert);
            frmvAsegurado.InsertItem(true);
            this.frmvAsegurado.ChangeMode(FormViewMode.Edit);
            //Actualiza el nuevo asegurado a la inspeccion
            string inspeccion = Request.QueryString["vehiculoId"];
            string personaId = (string)Session["personaId"];
            aseguradoTA.UpdateInspeccion(Convert.ToInt32(personaId) , Convert.ToDecimal(inspeccion));
        }
        else 
            if ((txbCambio.Text == "1") && txbAseguId.Text != "")
            {
                //Update aseg y update formview
                this.frmvAsegurado.ChangeMode(FormViewMode.Edit);
                this.frmvAsegurado.UpdateItem(true);
                string inspeccion = Request.QueryString["vehiculoId"];
                aseguradoTA.UpdateInspeccion(Convert.ToInt32(txbAseguId.Text), Convert.ToDecimal(inspeccion));
            }
            else
                if ((txbCambio.Text == "0") && txbAseguId.Text != "")
                { 
                    this.frmvAsegurado.UpdateItem(true);
                    string inspeccion = Request.QueryString["vehiculoId"];
                    aseguradoTA.UpdateInspeccion(Convert.ToInt32(txbAseguId.Text), Convert.ToDecimal(inspeccion));
                }
    }
    /*
     *Metodo que realiza la busqueda de de las informacion del contratante seleccionado en el autosuggestbox
     *<param><personaId> id de la persona que fue seleccionada
     *<return><p> una clase persona con los datos conseguoidos de la persona
     */
    [AjaxMethod]
    public static Asegurado performDataSearch(string personaId)
    {

        decimal personaId_decimal = -1;
        try
        {
            personaId_decimal = decimal.Parse(personaId);
        }
        catch (Exception ex)
        {
            personaId_decimal = -1;
        }
        Asegurado p = GestorPersonas.performDataSearchAsegurado(personaId_decimal);
        return p;
    }

    protected void odsContratante_Inserted(object sender, ObjectDataSourceStatusEventArgs e)
    {
        string persona = e.OutputParameters["personaId"].ToString();
        Session.Add("personaId", persona);
    }
    protected void odsAsegurado_Inserted(object sender, ObjectDataSourceStatusEventArgs e)
    {
        string persona = e.OutputParameters["personaId"].ToString();
        Session.Add("personaId", persona);
    }
    
}
