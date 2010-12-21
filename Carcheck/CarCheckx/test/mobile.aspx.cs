using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.Mobile;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.MobileControls;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

public partial class test_mobile : System.Web.UI.MobileControls.MobilePage
{
  protected void Page_Load(object sender, EventArgs e)
  {
    if (!IsPostBack)
    {
      this.List1.Items.Add(new MobileListItem("Guía-455-1", "458"));
      this.List1.Items.Add(new MobileListItem("Guía-455-2", "459"));
      this.List1.Items.Add(new MobileListItem("Guía-455-3", "460"));
      this.List1.Items.Add(new MobileListItem("Guía-455-4", "461"));
      this.List1.Items.Add(new MobileListItem("Guía-455-5", "462"));
      this.List1.Items.Add(new MobileListItem("Guía-455-6", "463"));
      this.List1.ItemCommand += new ListCommandEventHandler(List1_ItemCommand);
    }
  }

  void List1_ItemCommand(object sender, ListCommandEventArgs e)
  {
    this.TextBox1.Text = e.ListItem.Text;
  }
  protected void btnSayHello_Click(object sender, EventArgs e)
  {
    
  }
}
