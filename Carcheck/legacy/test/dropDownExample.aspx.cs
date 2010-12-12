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

public partial class test_dropDownExample : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        AjaxPro.Utility.RegisterTypeForAjax(typeof(test_dropDownExample));
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
}
