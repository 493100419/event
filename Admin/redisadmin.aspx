<%@ Page Language="VB" AutoEventWireup="false" CodeFile="redisadmin.aspx.vb" Inherits="redisadmin" %>
<% If Session("Login") <> Server.HtmlDecode("OK") Then
        Session("forward") = Request.RawUrl
        Response.Redirect("login.aspx")
    End If%>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <style>
         #div_image{
    width:600px; height:400px;
    }</style>
   
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <asp:DropDownList ID="DropDownList3" runat="server" DataSourceID="SqlDataSource1" DataTextField="Name" DataValueField="EventId" AppendDataBoundItems="True">
            <asp:ListItem Selected="True" Value="0">請選擇</asp:ListItem>
        </asp:DropDownList>
        <asp:Button ID="Button1" runat="server" Text="設定" />
        
        <asp:Button ID="Button3" runat="server" Text="清除" />
        <br />
        <br />
        <asp:HyperLink ID="HyperLink1" runat="server" Target="_blank">活動連結</asp:HyperLink>
        <br />
        <br />
        <asp:DropDownList ID="DropDownList1" runat="server">
            <asp:ListItem Value="0">票種 / 金額 / 剩餘數量</asp:ListItem>
        </asp:DropDownList>
        &nbsp;
        <asp:TextBox ID="TextBox1" runat="server" Width="66px"></asp:TextBox>
        
            <asp:Button ID="Button2" runat="server" Text="重設庫存量" />
        <br />
        <div id ="div_image" runat="server"></div>
    <asp:Label ID="Label_name" runat="server" style="font-size: xx-large; " ></asp:Label>
                    <br />
                    <asp:Label ID="Label_Introduction" runat="server"></asp:Label>
                    <br />
                    活動日期：<asp:Label ID="Label_EventDate" runat="server"></asp:Label>
                    <br />
                    活動地點：<asp:Label ID="Label_Location" runat="server"></asp:Label>
                    <asp:HyperLink ID="HyperLinkmap" runat="server" ForeColor="Blue" Target="_blank">地圖</asp:HyperLink>
                    <br />
                    主辦單位：<asp:Label ID="Label_Host" runat="server"></asp:Label>
                    <br />
                    每人限購數量：<asp:Label ID="Label_Quantities" runat="server"></asp:Label>
                    <br />
                    開賣日期：<asp:Label ID="Label_StartDate" runat="server" ></asp:Label>
                    ~<asp:Label ID="Label_EndDate" runat="server"></asp:Label>
                    <br />

        <asp:Label ID="Label_Feature" runat="server" ViewStateMode="Disabled"></asp:Label>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:eventsConnectionString %>" SelectCommand="SELECT * FROM [Event]" DataSourceMode="DataReader">
            </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" CacheDuration="60" ConnectionString="<%$ ConnectionStrings:eventsConnectionString %>" SelectCommand="SELECT * FROM [Ticket] WHERE ([EventId] = @EventId)" DataSourceMode="DataReader">
            <SelectParameters>
                <asp:ControlParameter ControlID="DropDownList3" Name="EventId" PropertyName="SelectedValue" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
    </form>
</body>
</html>
