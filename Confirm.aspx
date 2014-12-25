<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Confirm.aspx.vb" Inherits="Confirm" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <p>
        輸入預約號碼<br />
            <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
            <asp:Button ID="Button1" runat="server" CausesValidation="False" Text="確認" />
            <asp:Label ID="Label2" runat="server"></asp:Label>
        </p>
    <div>
    
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:eventsConnectionString %>" SelectCommand="SELECT * FROM [Event]"></asp:SqlDataSource>
    
    </div>
    </form>
</body>
</html>
