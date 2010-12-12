<%@ Page Language="C#" AutoEventWireup="true" CodeFile="upFile.aspx.cs" Inherits="test_upFile" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>>
    <script type="text/javascript">
        function doUpload(FileName) {
            alert(document.getElementById('FileUpload1').value);
            document.getElementById('FileUpload1').value = 'c:\\a04.pdf';
            alert(document.getElementById('FileUpload1').value);
        }
    </script>
</head>
<body>    
    <form id="form1" runat="server">
    <div>
        <asp:FileUpload ID="FileUpload1" runat="server" Width="340px" />
        <br />
        <br />
        <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Button" /></div>
        <button onclick = 'doUpload()' id='btn'>do Upload</button>
    </form>
</body>
</html>
