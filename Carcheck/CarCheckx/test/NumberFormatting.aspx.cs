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

public partial class test_NumberFormatting : System.Web.UI.Page
{
  protected void Page_Load(object sender, EventArgs e)
  {
    double d = 10000000;
    this.TextBox1.Text = String.Format("{0:###,###.00}",d);//d.ToString("###,###.00",); 
  }
}
