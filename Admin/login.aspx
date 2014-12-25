<%@ Page Language="VB" AutoEventWireup="false" CodeFile="login.aspx.vb" Inherits="login" %>
<% If Session("Login") = Server.HtmlDecode("OK") Then
        Response.Redirect("admin.aspx")
    End If%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>風谷購票網</title>

</head>
<body>
    <p>
        請登入</p>
    <form id="form1" runat="server">
    <p>
       帳號:<asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
        <asp:Literal ID="Literal1" runat="server"></asp:Literal>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBox1" ErrorMessage="必須要有資料"></asp:RequiredFieldValidator>
    </p>
    <p>
        密碼:<asp:TextBox ID="TextBox2" runat="server" TextMode="Password"></asp:TextBox>
&nbsp;&nbsp;
        <asp:Button ID="Button1" runat="server" Text=" Login " />
    </p>
    </form>
 
</body>
</html>
