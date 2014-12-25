<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Defaultredis.aspx.vb" Inherits="_Default" MaintainScrollPositionOnPostback="True" %>
<%If Request.Browser.Type = "IE8" Or Request.Browser.Type = "IE7" Or Request.Browser.Type = "IE6" Then
        Response.Write("本網站不支援IE8以下的瀏覽器，請更新瀏覽器或使用Chrome、Firefox")
        Exit Sub
    End If
    %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
 <meta name="viewport" id="view" content="width=device-width; initial-scale=1" /> 
   
<script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
<script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.8.9/jquery-ui.min.js" type="text/javascript"></script>
    <%--<script src="js/jquery-ui.js"></script>--%>
<link rel="stylesheet" type="text/css" href="js/jquery.countdown.css"> 
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
           $("#Button_Print").click(function () {
               
               $("#Label1").printThis();
           });
           $('#Button_Copy').zclip({
               path: 'js/ZeroClipboard.swf',
               copy: $('#EventCode').text()
               
           });

           //倒數計時功能
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
               $("#ImageButton1").attr("src", "Image/scramble1.png");
               $("#defaultCountdown").hide();
           }
       });
   
  

    </script>
 
    <style type="text/css">
       
        #choose {
           padding-top:15px;
            height: 120px;
            max-width : 1920px;
            margin: 0;
            background-color:#ebeeed;
            margin-bottom:-18px;
            
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
       
        
          #tabs{
             max-width:1000px;
             margin: auto; 
             

                     }
       html,body {
            height:100%;
            
	}	
        footer{
            margin: auto;
            color: #999999;
            border-top: solid;
            max-width: 1000px;
            border-top-width: 1px;
            text-align:center;
        }
        @media screen and (min-width: 480px) {
             #Name{
            height: 150px;
            /*max-width: 1000px;*/
            /*margin: 0;*/
            font-weight: bold;
            font-family: 微軟正黑體;
            position:absolute;
            margin-left:10%;
            font-size:xx-large;
             }
        }
        @media screen and (max-width: 480px) {
           #small_image{
               width:100%;
            height:100%;
            margin-bottom:-5px;
             margin:0;
		    padding:0;
	    	background:  no-repeat;
		    -moz-background-size: cover;
		     background-size: cover;
             background-image: url("image/small.jpg");
             }
                        li {
                min-width: 100%;
            }
        #Name{height: 100px;font-weight: bold;position:absolute;margin-left:10%;}
        #Image1{width:auto;height:75px;}
        #Button_Copy{display:none;}
        #Button_Print{display:none;}
}
        
    </style>
    </head>
<body style= "margin:0">
    <div  id ="div_image" runat="server"  >
        <div id="small_image">
        <div id="Name">
   <asp:Image ID="Image1" runat="server" ImageUrl="~/Image/fangoodstitle2.png" /><br/>
    <asp:Label ID="Label_name" runat="server" ></asp:Label>
                    </div>
       <div style="float: right; color: #FFFFFF; font-weight: bold;"> <asp:Label ID="Label2" runat="server" Text="" ></asp:Label>
           </div>
            </div>
    </div>
     <form id="form1" runat="server">
         

        <div id="choose" >
            
             <div id="defaultCountdown" style="text-align:center; color: #424b51;" ></div>
            <br />
            <div style="text-align:center" >
            <asp:DropDownList ID="DropDownList1" runat="server" AppendDataBoundItems="True">
                <asp:ListItem Selected="True" Value="0">票種 / 金額 / 剩餘數量</asp:ListItem>
            </asp:DropDownList>
            &nbsp;<asp:DropDownList ID="DropDownList2" runat="server">
            </asp:DropDownList>
            <asp:ImageButton ID="ImageButton1" runat="server" Enabled="False" height="50px" ImageAlign="Middle" ImageUrl="~/Image/scramble1.png"  onmouseover="this.src='/Image/scramble2.png'" onmouseout="this.src='/Image/scramble1.png'" Visible="False" />
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
                    <asp:HyperLink ID="HyperLinkmap" runat="server" ForeColor="Blue" Target="_blank">地圖</asp:HyperLink>
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
       <div style="display:none"> <asp:Label ID="Label_Now" runat="server" Visible="true"></asp:Label></div>
        <br />
        </div>
    <div id="tabs-2"  >

        <asp:Label ID="Label_Feature" runat="server" ViewStateMode="Disabled"></asp:Label>
        <br />
                </div>
    <div id="tabs-3" style="text-align:center">
        <asp:Image ID="Image2" runat="server" ImageUrl="~/Image/flowchart.png" />
        <br />
        <p style="text-align:left; font-size:small;">購票前請詳閱注意事項：<br />
(1.每人每次限購四張。(為維護歌迷購票權益，敬請遵守，造成不便亦請見諒。)<br />
(5.身心障礙票劵僅接受傳真訂購，欲購票者，透過上方【身心障礙傳真】按鈕下載傳真表單，並於11/17 (一) 11:00起連同「身心障礙手冊影本」傳真到(02)8712-7243進行購票，將於收到傳真三個工作天內，告知購票者取票相關資訊&nbsp;(若身心障礙席已售罄亦一併通知)。查詢專線：(02)8712-7432#9 (數量有限，售完為止)<br />
(6.請確實核對訂購內容，本票劵一經列印售出，表示台端同意支付本次交易的內容與價格，台端不得以任何理由拒付本次交易費用。<br />
(7.入場卷請小心保管，如發生遺失、損毀、破損等情形，一律不予重新開票。<br />
(8.任意塗改、影印或套印、掃描複製票劵，均屬無效票。<br />
(9.一人一票，憑票入場，孩童亦需購票。惟7歲以下之孩童不建議入場，因考量整體音量恐對孩童造成影響及其身高受限而影響視線，故購票前請自行斟酌。<br />
(10.活動現場嚴禁攝影、拍照、錄音，不得攜帶相機、攝影機入場，如經查獲，將由工作人員留置器材保管並刪除拍攝內容，但損壞與遺失概不負責，現場工作人員亦有權將底片與記憶卡加以強制曝光或強制刪除，並保留法律追訴權，謝謝您的合作。<br />
(11.場內禁帶外食飲料、寵物、手拍、哨子、加油棒等製造聲響之物品，違者逕行沒收。為維護體育場之草皮，搖滾區請勿穿高跟鞋入場，開演後手機請關機或開靜音。<br />
(12.主辦單位保留加場及相關演出內容之權益。<br />
(13.請您於購票前確認購票細節。並呼籲您不要購買來路不明的票劵，以免自身權益受損，主辦單位將保留認定票券合法性之權力。其他購票相關問題請您電洽ibon客服諮詢專線0800-016-138或02-2659-9900(24小時)由客服人員為您服務解說。</p>

        </div>
    
    <div id="tabs-4" >
         <div id ="tab4" runat="server" Visible="False">
          <input type="button" id="Button_Print" style="background-image:url('Image/printicon.png');background-repeat:no-repeat; width:28px; height:28px;">&nbsp;
       <input type="button" id="Button_Copy" style="background-image:url('Image/copyicon.png');background-repeat:no-repeat; width:28px; height:28px;">
           
               <p> <asp:Label ID="Label1" runat="server" style="font-size: small;"></asp:Label>
             </p>
             <p> 
                 恭喜您！您已取得購買資格，請於有效期限內登入指定頁面並完成交易！<br />
                 <asp:Button ID="Button2" runat="server" Text="進入付款流程" Width="126px" /></p>
            <br />
        <br />

        
        <br />
        </div>
      </div>
   </div>
      
        <%--<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:eventsConnectionString %>" SelectCommand="SELECT * FROM [Event] WHERE ([EventId] = @EventId)" DataSourceMode="DataReader">
            <SelectParameters>
                <asp:QueryStringParameter Name="EventId" QueryStringField="id" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" CacheDuration="60" ConnectionString="<%$ ConnectionStrings:eventsConnectionString %>" SelectCommand="SELECT * FROM [Ticket] WHERE ([EventId] = @EventId)" DataSourceMode="DataReader">
            <SelectParameters>
                <asp:QueryStringParameter Name="EventId" QueryStringField="id" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>--%>
        <asp:HiddenField ID="selected_tab" Value="0" runat="server" />
        </form>
    <div id="dialog-confirm" title="請確認以下內容">
         <p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>請確認是否清楚搶票流程?並且遵守搶票規則!</p>
        </div>
    <%--JS放最後--%>
    <script type="text/javascript" src="//s7.addthis.com/js/300/addthis_widget.js#pubid=ra-5457243356f9e071" async="async"></script>
    <script type="text/javascript" src="js/jquery.plugin.min.js"></script> 
    <script type="text/javascript" src="js/jquery.countdown.min.js"></script>
    <script src="js/jquery.countdown-zh-TW.js"></script>
    <script src="js/printThis.js"></script>
    <script type="text/javascript" src="js/jquery.zclip.js"></script>
     
    <footer>  
  
   <div> © 2014 風谷電子商務 All rights reserved. </div> 
  
</footer>
      </body>

</html>
