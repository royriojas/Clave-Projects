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


public partial class test_test_Tree : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        TreeNode root = new TreeNode();
        root.Text = "<p onclick=\"alert('hola desde root');\">click me I'm root</p>";
        root.Value = "1";
       

        root.SelectAction = TreeNodeSelectAction.None;

        TreeView1.Nodes.Add(root);
        TreeView1.ShowLines = true;

        TreeNode aNode = new TreeNode();
        aNode.Text = "i'm up";
        aNode.Value = "up";

        root.ChildNodes.Add(aNode);

        aNode = new TreeNode();
        aNode.Text = "i'm down";
        aNode.Value = "down";

        root.ChildNodes.Add(aNode);


        aNode.PopulateOnDemand = true;


    }
}
