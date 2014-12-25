<%@ Page Language="VB" AutoEventWireup="false" CodeFile="admin.aspx.vb" Inherits="admin" %>
<% If Session("Login") <> Server.HtmlDecode("OK") Then
        Session("forward") = Request.RawUrl
        Response.Redirect("login.aspx")
    End If%>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div style="margin: auto; width: 1000px;">
        <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataKeyNames="EventId" DataSourceID="SqlDataSource1" CellPadding="4" ForeColor="#333333" GridLines="None" Width="901px">
           <%-- <AlternatingRowStyle BackColor="Gray" ForeColor="#284775" />--%>
            <Columns>
                <asp:TemplateField ShowHeader="False">
                    <ItemTemplate>
                        <asp:Button ID="Button1" runat="server" CausesValidation="False" CommandName="Delete" OnClientClick="return confirm('確認刪除?')" Text="刪除" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:HyperLinkField DataNavigateUrlFields="EventId" DataNavigateUrlFormatString="adminproduct.aspx?id={0}" DataTextField="Name" HeaderText="活動名稱" >
                <ItemStyle Width="400px" />
                </asp:HyperLinkField>
                <asp:BoundField DataField="EventDate" HeaderText="活動日期" SortExpression="EventDate" DataFormatString="{0:yyyy/MM/dd HH:mm}" />
                <asp:BoundField DataField="StartDate" HeaderText="開賣日期" SortExpression="StartDate" DataFormatString="{0:yyyy/MM/dd HH:mm}" />
                <asp:BoundField DataField="EndDate" HeaderText="結束日期" SortExpression="EndDate" DataFormatString="{0:yyyy/MM/dd HH:mm}" />
            </Columns>
            <EditRowStyle BackColor="#999999" />
            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#E9E7E2" />
            <SortedAscendingHeaderStyle BackColor="#506C8C" />
            <SortedDescendingCellStyle BackColor="#FFFDF8" />
            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:eventsConnectionString %>" SelectCommand="SELECT [EventId], [Name], [StartDate], [EndDate], [EventDate] FROM [Event]" DeleteCommand="DELETE FROM [Event] WHERE [EventId] = @EventId" InsertCommand="INSERT INTO [Event] ([Name], [StartDate], [EndDate], [EventDate]) VALUES (@Name, @StartDate, @EndDate, @EventDate)" UpdateCommand="UPDATE [Event] SET [Name] = @Name, [StartDate] = @StartDate, [EndDate] = @EndDate, [EventDate] = @EventDate WHERE [EventId] = @EventId">
            <DeleteParameters>
                <asp:Parameter Name="EventId" Type="Int16" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="Name" Type="String" />
                <asp:Parameter Name="StartDate" Type="DateTime" />
                <asp:Parameter Name="EndDate" Type="DateTime" />
                <asp:Parameter Name="EventDate" Type="DateTime" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="Name" Type="String" />
                <asp:Parameter Name="StartDate" Type="DateTime" />
                <asp:Parameter Name="EndDate" Type="DateTime" />
                <asp:Parameter Name="EventDate" Type="DateTime" />
                <asp:Parameter Name="EventId" Type="Int16" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:Button ID="Button1" runat="server" Text="新增活動" />
        <br />
        <br />
        <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="redisadmin.aspx" Target="_blank">設定高流量活動</asp:HyperLink>
        <label id="Q1" title="為高流量活動設定專用的高速記憶體快取網頁，必須先建立活動資料">
        [?]</label></div>
    </form>
</body>
</html>
