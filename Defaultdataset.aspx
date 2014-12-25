<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Defaultdataset.aspx.vb" Inherits="_Default" MaintainScrollPositionOnPostback="True" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>

   
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
<%--<script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.8.9/jquery-ui.js" type="text/javascript"></script>--%>
    <script src="js/jquery-ui.js"></script>
<link rel="stylesheet" type="text/css" href="js/jquery.countdown.css"> 
<script type="text/javascript" src="js/jquery.plugin.min.js"></script> 
<script type="text/javascript" src="js/jquery.countdown.min.js"></script>
<script src="js/jquery.countdown-zh-TW.js"></script>
<!-- Go to www.addthis.com/dashboard to customize your tools -->
<script type="text/javascript" src="//s7.addthis.com/js/300/addthis_widget.js#pubid=ra-5457243356f9e071" async="async"></script>
<link href="js/jquery-ui.css" rel="stylesheet" type="text/css" />
    <title><%=pagetitle2 + " 風谷購票網"%></title>
   <script type="text/javascript">
       var selected_tab = 1;
       $(function () {
           var tabs = $("#tabs").tabs({
               select: function (e, i) {
                   selected_tab = i.index;
               }
           });

           selected_tab = $("[id$=selected_tab]").val() != "" ? parseInt($("[id$=selected_tab]").val()) : 0;
           tabs.tabs('select', selected_tab);
           $("form").submit(function () {
               $("[id$=selected_tab]").val(selected_tab);
           });
        
           $("#dialog-confirm").dialog({
               autoOpen: false,
               resizable: false,
               width: 400,
               height: 200,
               modal: true,
               buttons: {
                   "確認": function () {
                       $(this).dialog("close");
                       <%--<%=Me.Page.ClientScript.GetPostBackEventReference(New PostBackOptions(Me.ImageButton1))%>;--%>
                       __doPostBack("<%=ImageButton1.ClientID%>", "");
                  },
                  "取消": function () {
                      $(this).dialog("close");
                      return false;
                  }
              }
            });
        
           $("#ImageButton1").click(function () {
               $("#dialog-confirm").dialog("open");

               return false;
           });

           $.countdown.setDefaults($.countdown.regionalOptions['zh-TW']);
           var startdate = new Date($("#Label_StartDate").text());
          
           var datenow = new Date($("#Label_Now").text());
          
           $('#defaultCountdown').countdown({
               until: startdate,
               serverSync: function () { return new Date(datenow) },
               onExpiry: liftOff,
               alwaysExpire: true,

           });
           function liftOff() {
               $("#ImageButton1").attr("disabled", false);
               $("#defaultCountdown").hide();
           }
       });
   
  

    </script>
 
    <style type="text/css">
       
        #choose {
           padding-top:15px;
            height: 100px;
            max-width : 1920px;
            margin: 0;
            background-color:#ebeeed;
            margin-bottom:-20px;
            
        }
         #div_image{
            
           width:100%;
            height:100%;
            margin-bottom:-5px;
             margin:0;
		padding:0;
		background:  no-repeat;
        background-position:70% 50%;
		-moz-background-size: cover;
        
		background-size: cover;
           }
        #Name{
            height: 150px;
            /*max-width: 1000px;*/
            /*margin: 0;*/
            font-weight: bold;
            font-family: 微軟正黑體;
            position:absolute;
            margin-left:10%;
       
        }
        
          #tabs{
             max-width:1000px;
             margin: auto; 
             

                     }
       html,body {
            height:100%;
            
	}	
      
      
        
    </style>
    </head>
<body style= "margin:0">
    <div id ="div_image" runat="server"  >
        
        <div id="Name">
   <asp:Image ID="Image1" runat="server" ImageUrl="~/Image/fangoodstitle2.png" />
    <asp:Label ID="Label_name" runat="server" style="font-size: xx-large; " ></asp:Label>
                    </div>
       <div style="float: right; color: #FFFFFF; font-weight: bold;"> <asp:Label ID="Label2" runat="server" Text="" ></asp:Label>
           </div>
    </div>
     <form id="form1" runat="server">
         
<%--            
                    <br />
                    
                    <asp:Image ID="Image2" runat="server"  />
                    <br />--%>
    
   
        
        <div id="choose" >
            
             <div id="defaultCountdown" style="text-align:center; color: #424b51;" ></div>
            <br />
            <div style="text-align:right; margin-right:10%" >
            <asp:DropDownList ID="DropDownList1" runat="server" AppendDataBoundItems="True">
                <asp:ListItem Selected="True" Value="0">票種 / 金額 / 剩餘數量</asp:ListItem>
            </asp:DropDownList>
            &nbsp;<asp:DropDownList ID="DropDownList2" runat="server">
            </asp:DropDownList>
            <asp:ImageButton ID="ImageButton1" runat="server" Enabled="False" Height="25px" ImageAlign="Middle" ImageUrl="/Image/scramble1.png" onmouseout="this.src='/Image/scramble.png'" onmouseover="this.src='/Image/scramble2.png'" Visible="False" />
                <br />
           <asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="CustomValidator" ForeColor="Red"></asp:CustomValidator>
           </div>
           
            </div>
        <br />
         
        	<div id ="tabs" >
	   <div style ="font-weight:bold">
        <ul>
            <li><a href="#tabs-1">活動內容</a></li>   
            <li><a href="#tabs-2">活動介紹</a></li>
            <li><a href="#tabs-3">搶票流程</a></li>
            <li><a href="#tabs-4">我的預約號碼</a></li>
        </ul>
</div>
                
    
    <div id="tabs-1" style="color: #999999; font-weight: normal">
        <!-- Go to www.addthis.com/dashboard to customize your tools -->
<div class="addthis_native_toolbox"></div>
                    <asp:Label ID="Label_Introduction" runat="server"></asp:Label>
                    <br />
                    活動日期：<asp:Label ID="Label_EventDate" runat="server"></asp:Label>
                    <br />
                    活動地點：<asp:Label ID="Label_Location" runat="server"></asp:Label>
                    <br />
                    主辦單位：<asp:Label ID="Label_Host" runat="server"></asp:Label>
                    <br />
                    每人限購數量：<asp:Label ID="Label_Quantities" runat="server"></asp:Label>
                    <br />
                    開賣日期：<asp:Label ID="Label_StartDate" runat="server" ></asp:Label>
                    ~<asp:Label ID="Label_EndDate" runat="server"></asp:Label>
                    <br />
    
        
    
                    <br />

        <br />
        <asp:Label ID="Label_Now" runat="server" Visible="False"></asp:Label>
        <br />
        </div>
    <div id="tabs-2"  >

        <asp:Label ID="Label_Feature" runat="server"></asp:Label>
        <br />
                </div>
    <div id="tabs-3">
        搶票流程說明<br />
        </div>
    
    <div id="tabs-4" >
         <div id ="tab4" runat="server" Visible="False">
             <div class="addthis_sharing_toolbox" ></div>
       <p> <asp:Label ID="Label1" runat="server" style="font-size: small;"></asp:Label>
             </p>
             <p> 
       <asp:Button ID="Button2" runat="server" Text="進入付款流程" Width="126px" /></p>
            <br />
        <br />

        
        <br />
        </div>
      </div>
   </div>
        <%-- <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:eventsConnectionString %>" SelectCommand="SELECT [Name], [Introduction], [Image] FROM [Event] WHERE ([EventId] = @EventId)">
            <SelectParameters>
                <asp:QueryStringParameter Name="EventId" QueryStringField="m" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:eventsConnectionString %>" SelectCommand="SELECT * FROM [Ticket] WHERE ([EventId] = @EventId)">
            <SelectParameters>
                <asp:QueryStringParameter Name="EventId" QueryStringField="a" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>--%>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" CacheDuration="120" ConnectionString="<%$ ConnectionStrings:eventsConnectionString %>" SelectCommand="SELECT * FROM [Event] WHERE ([EventId] = @EventId)" EnableCaching="True">
            <SelectParameters>
                <asp:QueryStringParameter Name="EventId" QueryStringField="id" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" CacheDuration="60" ConnectionString="<%$ ConnectionStrings:eventsConnectionString %>" EnableCaching="True" SelectCommand="SELECT * FROM [Ticket] WHERE ([EventId] = @EventId)">
            <SelectParameters>
                <asp:QueryStringParameter Name="EventId" QueryStringField="id" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:HiddenField ID="selected_tab" Value="0" runat="server" />
        </form>
    <div id="dialog-confirm" title="請確認以下內容">
         <p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>請確認是否清楚搶票流程?並且遵守搶票規則!</p>
        </div>
        </body>
</html>
