Imports System.Data
Imports System.Data.SqlClient
Imports StackExchange.Redis
Partial Class _Default
    Inherits System.Web.UI.Page
    Protected pagetitle1 As String
    Protected pagetitle2 As String
    Private Shared thislock As Object = New Object
    '網頁載入
    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then '判斷網頁是否第一次載入
            Dim cache As IDatabase = redisconnection.connection.GetDatabase()
            If Request.QueryString("id") = cache.StringGet("EventId").ToString Then '判斷傳遞參數是否吻合
                Dim EventId As String = Request.QueryString("id").ToString()
                Dim Event_Cookies As String = EventId & "_Code"
                Dim Info_Cookies As String = EventId & "_Info"
                Dim price_cookies As String = EventId & "_Price"
                'Dim connection As ConnectionMultiplexer = ConnectionMultiplexer.Connect(System.Web.Configuration. _
                'WebConfigurationManager.ConnectionStrings("bishytsai").ConnectionString)


                Dim est As TimeZoneInfo = TimeZoneInfo.FindSystemTimeZoneById("Taipei Standard Time")
                Dim today As DateTime = TimeZoneInfo.ConvertTime(DateTime.Now, est)
                Response.Cookies("ckeckcookies").Value = "OK" '寫一個Coockies到Clent端，用來檢查是否有開啟Cookies
                div_image.Attributes.Add("style", "background-image: url(" & cache.StringGet("Image").ToString() & ")")
                Label_Introduction.Text = cache.StringGet("Introduction")
                Label_name.Text = cache.StringGet("Name")
                Select Case cache.StringGet("Show").ToString()
                    Case 1
                        Label_name.Visible = True
                    Case 0
                        Label_name.Visible = False
                End Select
                Label_Feature.Text = cache.StringGet("Feature")
                Label_Location.Text = cache.StringGet("Location")
                HyperLinkmap.NavigateUrl = "https://www.google.com.tw/maps/search/" & cache.StringGet("Location").ToString()
                Label_Host.Text = cache.StringGet("Host")
                Label_Quantities.Text = cache.StringGet("Quantities")
                Dim eventdate As DateTime = cache.StringGet("EventDate")
                Label_EventDate.Text = eventdate.ToString("yyyy/MM/dd HH:mm")
                Dim startdate As DateTime = cache.StringGet("StartDate")
                Label_StartDate.Text = startdate.ToString("yyyy/MM/dd HH:mm")
                Dim enddate As DateTime = cache.StringGet("EndDate")
                Label_EndDate.Text = enddate.ToString("yyyy/MM/dd HH:mm")
                For i As Integer = 1 To CType(cache.StringGet("Quantities").ToString, Integer)
                    Dim item As ListItem = New ListItem(i.ToString())
                    DropDownList2.Items.Add(item)
                Next i
                Dim j As Integer = 1

                While cache.KeyExists("NP" & j)
                    DropDownList1.Items.Add(cache.StringGet("NP" & j).ToString() & " / " & cache.StringGet("Quantity" & j).ToString())
                    DropDownList1.Items(j).Value = cache.StringGet("Id" & j)
                    j = j + 1
                End While



                Label_Now.Text = today.ToString("yyyy/MM/dd HH:mm:ss")
                Label2.Text = "在線人數：" & Application("online")
                '改Title 並去除顏色
                If Label_name.Text <> "" And Label_name.Text.Contains(""">") = True Then
                    pagetitle1 = Split(Label_name.Text, """>")(1).Trim()
                    pagetitle2 = Split(pagetitle1, "</span>")(0).Trim()
                Else
                    pagetitle2 = Label_name.Text
                End If
                'End If

                If Label_StartDate.Text > today Then '判斷開賣時間是否未到，是則

                    ImageButton1.ImageUrl = "Image/scramble3.png"
                ElseIf today < Label_EndDate.Text Then '判斷現在時間是否未到結束時間，是則
                    ImageButton1.Enabled = True
                End If
                If Request.Cookies(Event_Cookies) IsNot Nothing Then '判斷是否買過，買過則...
                    ImageButton1.Visible = False '搶票按鈕隱藏
                    Me.tab4.Visible = True '預約號碼TAB開啟
                    selected_tab.Value = 3 '預設TAB
                    Label1.Text = "活動：" & pagetitle2 & _
               "<br/>有效期限：" & Label_EndDate.Text & "<br/>預約號碼：<strong><span id=""EventCode""; style=""font-size:20px"">" & Request.Cookies(Event_Cookies).Value _
               & "</span></strong><br/>" & Server.UrlDecode(Request.Cookies(Info_Cookies).Value) & _
               " 張<strong><span style=""font-size:20px"">   NT$" & Request.Cookies(price_cookies).Value & "</span></strong>"
                    Button2.Focus() '將焦點往下移
                Else '沒買過則
                    ImageButton1.Visible = True '搶票按鈕顯示
                    Me.tab4.Visible = False '預約號碼TAB關閉
                End If
                'End If
            End If

        Else '如果不是第一次讀取則?

            'selected_tab.Value = Request.Form(selected_tab.UniqueID)
        End If
        '每次重新整理則>



    End Sub

   
    '自訂驗證項
    Protected Sub CustomValidator1_ServerValidate(source As Object, args As ServerValidateEventArgs) Handles CustomValidator1.ServerValidate
        Try
            Dim cache As IDatabase = redisconnection.connection.GetDatabase()
            Dim EventId As String = Request.QueryString("id").ToString()

            Dim j As String = DropDownList1.SelectedIndex.ToString
            '判斷是否開啟Cookie
            If Request.Cookies("ckeckcookies").Value = "OK" Then

                '判斷開賣時間

                Dim est As TimeZoneInfo = TimeZoneInfo.FindSystemTimeZoneById("Taipei Standard Time")
                Dim today As DateTime = TimeZoneInfo.ConvertTime(DateTime.Now, est)
                If DateTime.Compare(Label_StartDate.Text, today) > 0 Then
                    CustomValidator1.ErrorMessage = "尚未開賣!"
                    args.IsValid = False


                Else
                    '判斷是否選擇票種
                    If DropDownList1.SelectedValue = 0 Then
                        CustomValidator1.ErrorMessage = "請選擇票種"
                        args.IsValid = False

                        '判斷選購數量是否大於實際庫存
                    ElseIf cache.StringGet("Quantity" & j).ToString < CType(DropDownList2.SelectedValue, Integer) And cache.StringGet("Quantity" & j).ToString > 0 Then
                        CustomValidator1.ErrorMessage = "庫存量不足"
                        args.IsValid = False

                        '判斷票券是否已經售完
                    ElseIf cache.StringGet("Quantity" & j).ToString <= 0 Then
                        CustomValidator1.ErrorMessage = "已售完"
                        args.IsValid = False

                        '判斷是否購買過
                    ElseIf Session("bought") = "OK" Then
                        CustomValidator1.ErrorMessage = "抱歉!每人限購一次"
                        args.IsValid = False
                    End If



                End If
            End If
        Catch ex As Exception

            Me.Page.ClientScript.RegisterStartupScript(Me.GetType(), "alert", "alert('請先開啟Cookie功能')", True)
            CustomValidator1.ErrorMessage = ""
            args.IsValid = False

        End Try

    End Sub


    '跳到輸入預約號碼功能
    Protected Sub Button2_Click(sender As Object, e As EventArgs) Handles Button2.Click
        Server.Transfer("Confirm.aspx")
    End Sub

    

  
    Protected Sub ImageButton1_Click(sender As Object, e As ImageClickEventArgs) Handles ImageButton1.Click
        '搶購票券
       
        If Page.IsValid = True Then
            Dim cache As IDatabase = redisconnection.connection.GetDatabase()
            Dim EventId As String = Request.QueryString("id").ToString()
            Dim j As String = DropDownList1.SelectedIndex.ToString

            SyncLock thislock '鎖定變數
                If cache.StringGet("Quantity" & j).ToString > 0 Then
                    cache.StringSet("Quantity" & j, cache.StringGet("Quantity" & j).ToString - DropDownList2.SelectedValue)
                Else
                    Me.Page.ClientScript.RegisterStartupScript(Me.GetType(), "alert", "alert('已售完')", True)
                    Exit Sub
                End If
            End SyncLock
            ''鎖定變數
            'Application.Lock()
            'Application(EventId & "_" & Id) = Application(EventId & "_" & Id) - DropDownList2.SelectedValue
            'Application.UnLock()

            '寫資料到客戶端的Cookie
            Dim Event_Cookies As String = EventId & "_Code"
            Dim Info_Cookies As String = EventId & "_Info"
            Dim Price_Cookies As String = EventId & "_Price"
            Dim code As String = UCase(Left(Session.SessionID, 12))
            Dim est As TimeZoneInfo = TimeZoneInfo.FindSystemTimeZoneById("Taipei Standard Time")
            Dim today As DateTime = TimeZoneInfo.ConvertTime(DateTime.Now, est)
            Response.Cookies(Event_Cookies).Value = code
            Response.Cookies(Event_Cookies).Expires = Label_EndDate.Text '設定cookies過期時間
            Dim name As String = Split(DropDownList1.SelectedItem.Text, "/")(0).Trim()
            Dim price As Integer = Mid(Split(DropDownList1.SelectedItem.Text, "/")(1).Trim(), 2) * DropDownList2.SelectedValue
            Response.Cookies(Info_Cookies).Value = Server.UrlEncode(name & " " & DropDownList2.SelectedValue)
            Response.Cookies(Info_Cookies).Expires = Label_EndDate.Text '設定cookies過期時間
            Response.Cookies(Price_Cookies).Value = price
            Response.Cookies(Price_Cookies).Expires = Label_EndDate.Text '設定cookies過期時間
            'Label1.Text = "活動：" & Label_name.Text & _
            '    "<br/>有效期限：" & Label_EndDate.Text & "<br/>預約號碼：<strong><span style=""font-size:20px"">" & Response.Cookies(Event_Cookies).Value _
            '   & "</span></strong><br/>" & Server.UrlDecode(Response.Cookies(Info_Cookies).Value) & " 張<strong><span style=""font-size:20px"">   NT$" _
            '   & Response.Cookies(Price_Cookies).Value & "</span></strong>"

            '寫訂單資料到DB
            Dim conn As SqlConnection = New SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings _
            ("eventsConnectionString").ConnectionString)
            Dim cmd As SqlCommand = New SqlCommand("insert into Eventorder(Code, Status, TicketId, Quantity, CreatedDate) Values (@Code, 'N', @TicketId, @Quantity, @CreatedDate)", conn)
            cmd.Parameters.Add("@Code", SqlDbType.NVarChar)
            cmd.Parameters("@Code").Value = code
            cmd.Parameters.Add("@TIcketId", SqlDbType.Int)
            cmd.Parameters("@TicketId").Value = DropDownList1.SelectedValue
            cmd.Parameters.Add("@Quantity", SqlDbType.NVarChar)
            cmd.Parameters("@Quantity").Value = DropDownList2.SelectedValue
            cmd.Parameters.Add("@CreatedDate", SqlDbType.DateTime)
            cmd.Parameters("@CreatedDate").Value = today.ToString()
            conn.Open()
            cmd.ExecuteNonQuery()
            cmd.Cancel()
            conn.Close()

            '設定為搶購過，不能再搶
            Session("bought") = "OK"
            Response.Redirect("defaultredis.aspx?id=" & EventId)
            'ImageButton1.Visible = False
            'selected_tab.Value = 3
            'DropDownList1.SelectedValue = "0"
            'Me.tab4.Visible = True
        End If

    End Sub

   
    ' 亂數產生預約號碼
    Public Function GenerateCheckCode() As String
        Dim number As Integer
        Dim Code As Char
        Dim checkCode As String = String.Empty
        Dim random As System.Random = New Random()
        '要製造出幾個數字
        For i As Integer = 0 To 11
            'number = random.[Next]()
            number = random.Next
            '亂數決定哪一個是數字或字母
            If number Mod 2 = 0 Then
                Code = CChar(ChrW(Asc("0") + (number Mod 10)))
            Else
                Code = CChar(ChrW(Asc("A") + (number Mod 26)))
            End If
            checkCode += Code.ToString()
        Next
        '寫入Cook
        ' Response.Cookies.Add(New HttpCookie("CheckCode", checkCode))
        Return checkCode
    End Function

    
End Class
