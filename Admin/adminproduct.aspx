<%@ Page Language="VB" AutoEventWireup="false" CodeFile="adminproduct.aspx.vb" Inherits="admin" ValidateRequest="False" MaintainScrollPositionOnPostback="True" %>
<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>
<% If Session("Login") <> Server.HtmlDecode("OK") Then
        Session("forward") = Request.RawUrl
        Response.Redirect("login.aspx")
    End If%>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
<script src="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.9/jquery-ui.js" type="text/javascript"></script>
    <script src="../js/jquery-ui-timepicker-addon.js"></script>
    <script src="../js/jquery.colourPicker.js"></script>
    <link href="../js/jquery.colourPicker.css" rel="stylesheet" />
<link href="../js/jquery-ui.css" rel="stylesheet" type="text/css" />
    <title></title>
    <script type="text/javascript">
        $(function () {
            var opt1 = {dateFormat: 'yy/mm/dd'};
            $("#FormView1_EventDateTextBox").datetimepicker(opt1);
            $("#FormView1_StartDateTextBox").datetimepicker(opt1);
            $("#FormView1_EndDateTextBox").datetimepicker(opt1);
            $('#jquery-colour-picker-example select').colourPicker({
                ico: '../Image/jquery.colourPicker.gif',
                title: false
            });
        });
    </script>
    <style type="text/css">
        .ui-timepicker-div .ui-widget-header { margin-bottom: 8px; }
.ui-timepicker-div dl { text-align: left; }
.ui-timepicker-div dl dt { float: left; clear:left; padding: 0 0 0 5px; }
.ui-timepicker-div dl dd { margin: 0 10px 10px 45%; }
.ui-timepicker-div td { font-size: 90%; }
.ui-tpicker-grid-label { background: none; border: none; margin: 0; padding: 0; }

.ui-timepicker-rtl{ direction: rtl; }
.ui-timepicker-rtl dl { text-align: right; padding: 0 5px 0 0; }
.ui-timepicker-rtl dl dt{ float: right; clear: right; }
.ui-timepicker-rtl dl dd { margin: 0 45% 10px 10px; }
        </style>
</head>
    
<body>
    <form id="form1" runat="server">
    <div style="margin: auto; width: 1000px;">
    
        <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="admin.aspx">回目錄</asp:HyperLink>
&nbsp;<asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='~/default.aspx?id={0}' Target="_blank">活動連結</asp:HyperLink>
        &nbsp;<br />
        </div>
        <div style="margin: auto; width: 1000px;">
            <asp:FormView ID="FormView1" runat="server" BackColor="White" BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataKeyNames="EventId" DataSourceID="SqlDataSource1" GridLines="Horizontal" Height="443px" Width="1000px">
                <EditItemTemplate>
                    EventId:
                    <asp:Label ID="EventIdLabel1" runat="server" Text='<%# Eval("EventId") %>' />
                    <br />
                    活動名稱:
                      <asp:TextBox ID="NameTextBox" runat="server" Height="16px"  Text='<%# Bind("Name") %>' Width="378px"></asp:TextBox>
                    &nbsp;<label id="jquery-colour-picker-example">
        <select  id="selectcolor" runat="server" name="colour">
            <option value="ffffff">#ffffff</option>
            <option value="ffccc9">#ffccc9</option>
            <option value="ffce93">#ffce93</option>
            <option value="fffc9e">#fffc9e</option>
            <option value="ffffc7">#ffffc7</option>
            <option value="9aff99">#9aff99</option>
            <option value="96fffb">#96fffb</option>
            <option value="cdffff">#cdffff</option>
            <option value="cbcefb">#cbcefb</option>
            <option value="cfcfcf">#cfcfcf</option>
            <option value="fd6864">#fd6864</option>
            <option value="fe996b">#fe996b</option>
            <option value="fffe65">#fffe65</option>
            <option value="fcff2f">#fcff2f</option>
            <option value="67fd9a">#67fd9a</option>
            <option value="38fff8">#38fff8</option>
            <option value="68fdff">#68fdff</option>
            <option value="9698ed">#9698ed</option>
            <option value="c0c0c0">#c0c0c0</option>
            <option value="fe0000">#fe0000</option>
            <option value="f8a102">#f8a102</option>
            <option value="ffcc67">#ffcc67</option>
            <option value="f8ff00">#f8ff00</option>
            <option value="34ff34">#34ff34</option>
            <option value="68cbd0">#68cbd0</option>
            <option value="34cdf9">#34cdf9</option>
            <option value="6665cd">#6665cd</option>
            <option value="9b9b9b">#9b9b9b</option>
            <option value="cb0000">#cb0000</option>
            <option value="f56b00">#f56b00</option>
            <option value="ffcb2f">#ffcb2f</option>
            <option value="ffc702">#ffc702</option>
            <option value="32cb00">#32cb00</option>
            <option value="00d2cb">#00d2cb</option>
            <option value="3166ff">#3166ff</option>
            <option value="6434fc">#6434fc</option>
            <option value="656565">#656565</option>
            <option value="9a0000">#9a0000</option>
            <option value="ce6301">#ce6301</option>
            <option value="cd9934">#cd9934</option>
            <option value="999903">#999903</option>
            <option value="009901">#009901</option>
            <option value="329a9d">#329a9d</option>
            <option value="3531ff">#3531ff</option>
            <option value="6200c9">#6200c9</option>
            <option value="343434">#343434</option>
            <option value="680100">#680100</option>
            <option value="963400">#963400</option>
            <option value="986536">#986536</option>
            <option value="646809">#646809</option>
            <option value="036400">#036400</option>
            <option value="34696d">#34696d</option>
            <option value="00009b">#00009b</option>
            <option value="303498">#303498</option>
            <option value="000000" selected="selected">#000000</option>
            <option value="330001">#330001</option>
            <option value="643403">#643403</option>
            <option value="663234">#663234</option>
            <option value="343300">#343300</option>
            <option value="013300">#013300</option>
            <option value="003532">#003532</option>
            <option value="010066">#010066</option>
            <option value="340096">#340096</option>
        </select>
    </label>
                    <asp:CheckBox ID="ShowCheckBox" runat="server" Text="顯示" Checked='<%# Bind("Show") %>' />
                    
                    <label id="Q1" title="輸入活動名稱，並選擇所需的顏色，並選擇是否顯示於活動頁面上">
                    [?]</label><br />活動簡介:
                    <asp:TextBox ID="IntroductionTextBox" runat="server" Text='<%# Bind("Introduction") %>' TextMode="MultiLine" Height="50px" Width="500px" />
                    <label id="Q3"  title="活動簡介，最多100字">[?]</label><asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="IntroductionTextBox" ErrorMessage="字數在100字內" ValidationExpression=".{1,100}$"></asp:RegularExpressionValidator>
                    <br />活動地點:
                    <asp:TextBox ID="LocationTextBox" runat="server" Text='<%# Bind("Location") %>' />
                    <br />
                    主辦單位:
                    <asp:TextBox ID="HostTextBox" runat="server" Text='<%# Bind("Host") %>'></asp:TextBox>
                    <br />
                    圖片網址:
                    <asp:TextBox ID="ImageTextBox" runat="server" Text='<%# Bind("Image") %>' Width="500px" />
                    <label id="Q2"  title="建議解析度1920*1080，直接輸入圖片網址降低伺服器負載">[?]</label><br />限購數量:
                    <asp:TextBox ID="QuantitiesTextBox" runat="server" Text='<%# Bind("Quantities") %>' Width="40px" />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="QuantitiesTextBox" ErrorMessage="必須要有資料" Display="Dynamic"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="QuantitiesTextBox" ErrorMessage="輸入數字" ValidationExpression="[0-9]" Display="Dynamic"></asp:RegularExpressionValidator>
                    <br />
                    活動日期:
                    <asp:TextBox ID="EventDateTextBox" runat="server" Text='<%# Bind("EventDate", "{0:yyyy/MM/dd HH:mm}") %>' />
                    <br />
                    開賣日期:
                    <asp:TextBox ID="StartDateTextBox" runat="server" Text='<%# Bind("StartDate", "{0:yyyy/MM/dd HH:mm}") %>' />
                    <asp:CompareValidator ID="CompareValidator2" runat="server" ControlToCompare="StartDateTextBox" ControlToValidate="EndDateTextBox" ErrorMessage="開賣日期須在結束日期之前" Operator="GreaterThan"></asp:CompareValidator>
                    <br />
                    結束日期:
                    <asp:TextBox ID="EndDateTextBox" runat="server" Text='<%# Bind("EndDate", "{0:yyyy/MM/dd HH:mm}") %>' />
                    <br />
                    活動內容:
                    <CKEditor:CKEditorControl ID="CKEditor1" BasePath="~/ckeditor/" runat="server" Text='<%# Bind("Feature") %>' Height="302px" ></CKEditor:CKEditorControl>
                    
                    <br /><div style="margin:auto; text-align:center;">
                    <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update1" Text="更新" />
&nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="取消" /></div>
                </EditItemTemplate>
                <EditRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                <InsertItemTemplate>
                   活動名稱:
                      <asp:TextBox ID="NameTextBox" runat="server" Height="16px" Text='<%# Bind("Name")%>'  Width="378px"></asp:TextBox>
                    &nbsp;<label id="jquery-colour-picker-example">
        &nbsp;
    </label>
                    <asp:CheckBox ID="ShowCheckBox" runat="server" Text="顯示" Checked='<%# Bind("Show") %>' />
                    
                    <label id="Q1" title="輸入活動名稱，並選擇所需的顏色，並選擇是否顯示於活動頁面上">
                    [?]</label><br />活動簡介:
                    <asp:TextBox ID="IntroductionTextBox" runat="server" Text='<%# Bind("Introduction") %>' TextMode="MultiLine" Height="50px" Width="500px" />
                    <label id="Q3"  title="活動簡介，最多100字">[?]<asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="IntroductionTextBox" ErrorMessage="字數在100字內" ValidationExpression=".{1,100}$"></asp:RegularExpressionValidator>
                    </label><br />活動地點:
                    <asp:TextBox ID="LocationTextBox" runat="server" Text='<%# Bind("Location") %>' />
                    <br />
                    主辦單位:
                    <asp:TextBox ID="HostTextBox" runat="server" Text='<%# Bind("Host") %>'></asp:TextBox>
                    <br />
                    圖片網址:
                    <asp:TextBox ID="ImageTextBox" runat="server" Text='<%# Bind("Image") %>' Width="500px" Height="19px" />
                    <label id="Q2"  title="建議解析度1920*1080，直接輸入圖片網址降低伺服器負載">[?]</label><br />限購數量:
                    <asp:TextBox ID="QuantitiesTextBox" runat="server" Text='<%# Bind("Quantities") %>' Width="40px" />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="QuantitiesTextBox" ErrorMessage="必須要有資料" Display="Dynamic"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="QuantitiesTextBox" ErrorMessage="輸入數字" ValidationExpression="[0-9]" Display="Dynamic"></asp:RegularExpressionValidator>
                    <br />
                    活動日期:
                    <asp:TextBox ID="EventDateTextBox" runat="server" Text='<%# Bind("EventDate", "{0:yyyy/MM/dd HH:mm}") %>' />
                    <br />
                    開賣日期:
                    <asp:TextBox ID="StartDateTextBox" runat="server" Text='<%# Bind("StartDate", "{0:yyyy/MM/dd HH:mm}") %>' />
                    <asp:CompareValidator ID="CompareValidator2" runat="server" ControlToCompare="StartDateTextBox" ControlToValidate="EndDateTextBox" ErrorMessage="開賣日期須在結束日期之前" Operator="GreaterThan"></asp:CompareValidator>
                    <br />
                    結束日期:
                    <asp:TextBox ID="EndDateTextBox" runat="server" Text='<%# Bind("EndDate", "{0:yyyy/MM/dd HH:mm}") %>' />
                    <br />
                    活動內容:
                    <CKEditor:CKEditorControl ID="CKEditor1" BasePath="~/ckeditor/" runat="server" Text='<%# Bind("Feature") %>' Height="302px" ></CKEditor:CKEditorControl>
                    
                 <br />
                    <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="新增" />
&nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="取消" OnClick="InsertCancelButton_Click" />
                    &nbsp;
                </InsertItemTemplate>
                <ItemTemplate>
                    活動編號:
                    <asp:Label ID="EventIdLabel" runat="server" Text='<%# Eval("EventId") %>' />
                    <br />
                    活動名稱:
                    <asp:Label ID="NameLabel" runat="server" Text='<%# Bind("Name") %>' />
                    <br />
                    活動簡介:
                    <asp:Label ID="IntroductionLabel" runat="server" Text='<%# Bind("Introduction") %>' />
                    <br />
                    活動地點:
                    <asp:Label ID="LocationLabel" runat="server" Text='<%# Bind("Location") %>' />
                    <br />
                    主辦單位:
                    <asp:Label ID="HostLabel" runat="server" Text='<%# Bind("Host") %>' />
                    <br />
                    限購數量:
                    <asp:Label ID="QuantitiesLabel" runat="server" Text='<%# Bind("Quantities") %>' />
                    <br />
                    活動日期:
                    <asp:Label ID="EventDateLabel" runat="server" Text='<%# Bind("EventDate", "{0:yyyy/MM/dd HH:mm}") %>' />
                    <br />
                    開賣日期:
                    <asp:Label ID="StartDateLabel" runat="server" Text='<%# Bind("StartDate", "{0:yyyy/MM/dd HH:mm}") %>' />
                    <br />
                    結束日期:
                    <asp:Label ID="EndDateLabel" runat="server" Text='<%# Bind("EndDate", "{0:yyyy/MM/dd HH:mm}") %>' />
                    <br />
                    圖片:
                    <asp:Image ID="Image1" runat="server" ImageUrl='<%#Eval("Image") %>' Height="338px" Width="600px" />
                    <br />
                    活動內容:
                    <asp:Label ID="FeatureLabel" runat="server" Text='<%# Bind("Feature") %>' />
                    <br />
                    <asp:Button ID="Button5" runat="server" CommandName="Edit" Text="修改" />
                </ItemTemplate>
                <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
            </asp:FormView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:eventsConnectionString %>" DeleteCommand="DELETE FROM [Event] WHERE [EventId] = @EventId" InsertCommand="INSERT INTO [Event] ([Name], [Introduction], [Location], [Host], [Image], [Feature], [Quantities], [EventDate], [StartDate], [EndDate], [Show]) VALUES (@Name, @Introduction, @Location, @Host, @Image, @Feature, @Quantities, @EventDate, @StartDate, @EndDate, @Show);select @EventId=@@Identity" SelectCommand="SELECT * FROM [Event] WHERE ([EventId] = @EventId)" UpdateCommand="UPDATE [Event] SET [Name] = @Name, [Introduction] = @Introduction, [Location] = @Location, [Host] = @Host, [Image] = @Image, [Feature] = @Feature, [Quantities] = @Quantities, [EventDate] = @EventDate, [StartDate] = @StartDate, [EndDate] = @EndDate, [Show] = @Show WHERE [EventId] = @EventId">
                <DeleteParameters>
                    <asp:Parameter Name="EventId" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="EventId" Direction="InputOutput" Type="Int16" />
                    <asp:Parameter Name="Name"  Type="String" />
                    <asp:Parameter Name="Introduction" Type="String" />
                    <asp:Parameter Name="Location" Type="String" />
                    <asp:Parameter Name="Host" Type="String" />
                    <asp:Parameter Name="Image" Type="String" />
                    <asp:Parameter Name="Feature" Type="String" />
                    <asp:Parameter Name="Quantities" Type="Int32" />
                    <asp:Parameter Name="EventDate" Type="DateTime" />
                    <asp:Parameter Name="StartDate" Type="DateTime" />
                    <asp:Parameter Name="EndDate" Type="DateTime" />
                    <%--<asp:Parameter Name="Show" Type="String" />--%>
                </InsertParameters>
                <SelectParameters>
                    <asp:QueryStringParameter Name="EventId" QueryStringField="id" Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                  <%--  <asp:Parameter Name="Name" Type="String" />
                    <asp:Parameter Name="Introduction" Type="String" />
                    <asp:Parameter Name="Location" Type="String" />
                    <asp:Parameter Name="Host" Type="String" />
                    <asp:Parameter Name="Image" Type="String" />
                    <asp:Parameter Name="Feature" Type="String" />
                    <asp:Parameter Name="Quantities" Type="Int32" />
                    <asp:Parameter Name="EventDate" Type="DateTime" />
                    <asp:Parameter Name="StartDate" Type="DateTime" />
                    <asp:Parameter Name="EndDate" Type="DateTime" />
                    <asp:Parameter Name="Show" Type="Int32" />
                    <asp:Parameter Name="EventId" Type="Int32" />--%>
                </UpdateParameters>
            </asp:SqlDataSource>
            <br />
        </div>
        <div style="margin: auto; width: 1000px;">
           <asp:GridView ID="GridView1" runat="server" CellPadding="4" Font-Size="Small"
            ForeColor="#333333" GridLines="None" PageSize="5" DataKeyNames="Id" AutoGenerateColumns="False" DataSourceID="SqlDataSource2" style="margin-right: 0px" ShowHeaderWhenEmpty="True">
            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
            <SelectedRowStyle BackColor="#FFC0C0" Font-Bold="True" ForeColor="#333333" />
            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <EditRowStyle BackColor="#999999" />
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <Columns>
                <asp:TemplateField HeaderText="Id" InsertVisible="False" SortExpression="Id">
                    <EditItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("Id") %>'></asp:Label>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label_Id" runat="server" Text='<%# Bind("Id") %>'></asp:Label>
                    </ItemTemplate>
                    <HeaderStyle Width="30px" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="售價" SortExpression="Price">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Price") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:TextBox ID="TextBox_Price" runat="server" Height="15px" Text='<%# Bind("Price") %>' Width="50px" MaxLength="6"></asp:TextBox>
                    </ItemTemplate>
                    <HeaderStyle Width="50px" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="票種" SortExpression="Name">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("Name") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:TextBox ID="TextBox_Name" runat="server" Height="15px" Text='<%# Bind("Name") %>' Width="80px" MaxLength="20"></asp:TextBox>
                    </ItemTemplate>
                    <HeaderStyle Width="85px" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="庫存量">
                    <FooterTemplate>
                        
                    </FooterTemplate>
                    <ItemTemplate>
                        <asp:TextBox ID="TextBox_Qty" runat="server" Height="15px" Text='<%# Application(Eval("EventId") & "_" & Eval("Id"))%>' Width="65px" MaxLength="5"></asp:TextBox>
                    </ItemTemplate>
                    <HeaderStyle Width="65px" />
                </asp:TemplateField>
                <asp:TemplateField ShowHeader="False">
                    <ItemTemplate>
                        <asp:Button ID="Button6" runat="server" CommandArgument='<%# Eval("Id")%>' CommandName="Update1" OnClientClick="return confirm('確認修改')" Text="修改" />
                        <asp:Button ID="Button1" runat="server" CausesValidation="False" CommandName="Delete" OnClientClick="return confirm('確認刪除?')" Text="刪除" />
                    </ItemTemplate>
                    <HeaderStyle Width="97px" />
                    <ItemStyle Width="97px" Wrap="False" />
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
            <asp:FormView ID="FormView2" runat="server" DataKeyNames="Id" DataSourceID="SqlDataSource2" DefaultMode="Insert" BackColor="White" BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Horizontal" Width="382px">
                <EditItemTemplate>
                    Id:
                    <asp:Label ID="IdLabel1" runat="server" Text='<%# Eval("Id") %>' />
                    <br />
                    Price:
                    <asp:TextBox ID="PriceTextBox" runat="server" Text='<%# Bind("Price") %>' />
                    <br />
                    Name:
                    <asp:TextBox ID="NameTextBox" runat="server" Text='<%# Bind("Name") %>' />
                    <br />
                    EventId:
                    <asp:TextBox ID="EventIdTextBox" runat="server" Text='<%# Bind("EventId") %>' />
                    <br />
                    <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="更新" />
                    &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="取消" />
                </EditItemTemplate>
                <EditRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                <InsertItemTemplate>
                    &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:TextBox ID="TextBox_Price2" runat="server" Height="15px" Text='<%# Bind("Price") %>' Width="50px" MaxLength="6" />
                    &nbsp;<asp:TextBox ID="TextBox_Name" runat="server" Height="15px" Text='<%# Bind("Name") %>' Width="80px" MaxLength="20" />
                    &nbsp;<asp:TextBox ID="TextBox3" runat="server" Height="15px" Width="65px" MaxLength="5"></asp:TextBox>
                    &nbsp;<asp:Button ID="Button7" runat="server" CommandName="Insert" Text="新增" />
                </InsertItemTemplate>
                <ItemTemplate>
                    &nbsp;<br />
                </ItemTemplate>
                <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
            </asp:FormView>
            &nbsp;<br />
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:eventsConnectionString %>" SelectCommand="SELECT * FROM [Ticket] WHERE ([EventId] = @EventId)" DeleteCommand="DELETE FROM [Ticket] WHERE [Id] = @Id" InsertCommand="INSERT INTO [Ticket] ([Price], [Name], [EventId]) VALUES (@Price, @Name, @EventId);select @Id=@@Identity" oninserted="SqlDataSource2_Inserted" UpdateCommand="UPDATE [Ticket] SET [Price] = @Price, [Name] = @Name, [EventId] = @EventId WHERE [Id] = @Id">
                <DeleteParameters>
                    <asp:Parameter Name="Id" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="Id" Direction="InputOutput" Type="Int16" />
                    <asp:Parameter Name="Price" Type="Int32" />
                    <asp:Parameter Name="Name" Type="String" />
                    <asp:Parameter Name="EventId" Type="Int32" />
                </InsertParameters>
                <SelectParameters>
                    <asp:QueryStringParameter Name="EventId" QueryStringField="id" Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="Price" Type="Int32" />
                    <asp:Parameter Name="Name" Type="String" />
                    <asp:Parameter Name="EventId" Type="Int32" />
                    <asp:Parameter Name="Id" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
        </div>
    </form>
</body>
</html>
