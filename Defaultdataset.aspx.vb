Imports System.Data
Imports System.Data.SqlClient
Partial Class _Default
    Inherits System.Web.UI.Page
    Protected pagetitle1 As String
    Protected pagetitle2 As String
    '網頁載入
    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then '判斷網頁是否第一次載入
            If Request.QueryString("id") IsNot Nothing Then '判斷是否有傳遞參數

                Dim EventId As String = Request.QueryString("id").ToString()
                Dim Event_Cookies As String = EventId & "_Code"
                Dim Info_Cookies As String = EventId & "_Info"
                Dim price_cookies As String = EventId & "_Price"
                Dim args As New DataSourceSelectArguments

                Dim est As TimeZoneInfo = TimeZoneInfo.FindSystemTimeZoneById("Taipei Standard Time")
                Dim today As DateTime = TimeZoneInfo.ConvertTime(DateTime.Now, est)
                Response.Cookies("ckeckcookies").Value = "OK" '寫一個Coockies到Clent端，用來檢查是否有開啟Cookies

                SqlDataSource2.SelectCommand = "SELECT Id, Name + ' / $' +" & _
                "CAST(Price AS varchar(10)) AS NP, Cast(EventId AS varchar(10)) + '_' + Cast(Id AS varchar(10)) AS E_I from Ticket where EventId = '" & EventId & "'"
                '-------------------使用dataset---------------------------------------------
                Dim dv2 As DataView = CType(SqlDataSource2.Select(args), DataView)

                Dim j As Integer '讀取票種資料
                For j = 0 To dv2.Count - 1
                    DropDownList1.Items.Add(dv2.Table(j).Item("NP") & " / " & Application(dv2.Table(j).Item("E_I")))
                    DropDownList1.Items(j + 1).Value = dv2.Table(j).Item("Id")
                Next j

                Dim dv As DataView = CType(SqlDataSource1.Select(args), DataView) '讀取活動資料
                If dv.Count > 0 Then
                    div_image.Attributes.Add("style", "background-image: url(" & dv.Table(0).Item("Image").ToString() & ")")
                    'Image2.ImageUrl = dv.Table(0).Item("Image").ToString()
                    Label_Introduction.Text = dv.Table(0).Item("introduction").ToString()
                    Label_name.Text = dv.Table(0).Item("Name").ToString()
                    Label_Feature.Text = dv.Table(0).Item("Feature").ToString()
                    Label_Location.Text = dv.Table(0).Item("Location").ToString()
                    Label_Host.Text = dv.Table(0).Item("Host").ToString()
                    Label_Quantities.Text = dv.Table(0).Item("Quantities").ToString()
                    Dim eventdate As DateTime = dv.Table(0).Item("EventDate").ToString()
                    Label_EventDate.Text = eventdate.ToString("yyyy/MM/dd HH:mm:ss")
                    Dim startdate As DateTime = dv.Table(0).Item("StartDate").ToString()
                    Label_StartDate.Text = startdate.ToString("yyyy/MM/dd HH:mm:ss")
                    Dim enddate As DateTime = dv.Table(0).Item("EndDate").ToString()
                    Label_EndDate.Text = enddate.ToString("yyyy/MM/dd HH:mm:ss")
                    Label_Now.Text = today.ToString("yyyy/MM/dd HH:mm:ss")
                    Label2.Text = "在線人數：" & Application("online")
                    'Me.Title = dv.Table(0).Item("Name").ToString() & " - " & Me.Title
                    '寫限購數量到下拉選單2
                    For i As Integer = 1 To CType(dv.Table(0).Item("Quantities").ToString, Integer)
                        Dim item As ListItem = New ListItem(i.ToString())
                        DropDownList2.Items.Add(item)
                    Next i
                    '--------------------dataset結束----------------------------------------

                    If Label_StartDate.Text > today Then '判斷開賣時間是否未到，是則

                        ImageButton1.ImageUrl = "scramble3.png"
                    ElseIf today < Label_EndDate.Text Then '判斷現在時間是否未到結束時間，是則
                        ImageButton1.Enabled = True
                    End If
                    If Request.Cookies(Event_Cookies) IsNot Nothing Then '判斷是否買過，買過則...
                        ImageButton1.Visible = False '搶票按鈕隱藏
                        Me.tab4.Visible = True '預約號碼TAB開啟
                        selected_tab.Value = 3 '預設TAB
                        Label1.Text = "活動：" & Label_name.Text & _
                   "<br/>有效期限：" & Label_EndDate.Text & "<br/>預約號碼：<strong><span style=""font-size:20px"">" & Request.Cookies(Event_Cookies).Value _
                   & "</span></strong><br/>" & Server.UrlDecode(Request.Cookies(Info_Cookies).Value) & _
                   " 張<strong><span style=""font-size:20px"">   NT$" & Request.Cookies(price_cookies).Value & "</span></strong>"
                        Button2.Focus() '將焦點往下移
                    Else '沒買過則
                        ImageButton1.Visible = True '搶票按鈕顯示
                        Me.tab4.Visible = False '預約號碼TAB關閉
                    End If
                    'End If
                End If
            End If
        Else '如果不是第一次讀取則?

            'selected_tab.Value = Request.Form(selected_tab.UniqueID)
        End If
        '每次重新整理則>

        '改Title 
        If Label_name.Text <> "" And Label_name.Text.Contains(""">") = True Then
            pagetitle1 = Split(Label_name.Text, """>")(1).Trim()
            pagetitle2 = Split(pagetitle1, "</span>")(0).Trim()
        Else
            pagetitle2 = Label_name.Text
        End If

    End Sub

   
    '自訂驗證項
    Protected Sub CustomValidator1_ServerValidate(source As Object, args As ServerValidateEventArgs) Handles CustomValidator1.ServerValidate
        Try
            Dim EventId As String = Request.QueryString("id").ToString()
            Dim Id As String = DropDownList1.SelectedValue
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
                    ElseIf Application(EventId & "_" & Id) < CType(DropDownList2.SelectedValue, Integer) And Application(EventId & "_" & Id) > 0 Then
                        CustomValidator1.ErrorMessage = "庫存量不足"
                        args.IsValid = False

                        '判斷票券是否已經售完
                    ElseIf Application(EventId & "_" & Id) = 0 Then


                        CustomValidator1.ErrorMessage = "已售完"
                        args.IsValid = False

                        '判斷是否購買過
                    ElseIf Session("bought") = "OK" Then
                        CustomValidator1.ErrorMessage = "抱歉!每人限購一次"
                        args.IsValid = False
                    End If



                End If
            End If
        Catch
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
              Dim EventId As String = Request.QueryString("id").ToString()
            Dim Id As String = DropDownList1.SelectedValue
            '鎖定變數
            Application.Lock()
            Application(EventId & "_" & Id) = Application(EventId & "_" & Id) - DropDownList2.SelectedValue
            Application.UnLock()

            '寫資料到客戶端的Cookie
            Dim Event_Cookies As String = EventId & "_Code"
            Dim Info_Cookies As String = EventId & "_Info"
            Dim Price_Cookies As String = EventId & "_Price"
            Dim est As TimeZoneInfo = TimeZoneInfo.FindSystemTimeZoneById("Taipei Standard Time")
            Dim today As DateTime = TimeZoneInfo.ConvertTime(DateTime.Now, est)
            Response.Cookies(Event_Cookies).Value = GenerateCheckCode()
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
            cmd.Parameters("@Code").Value = Response.Cookies(Event_Cookies).Value
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
            Response.Redirect("default.aspx?id=" & EventId)
            'ImageButton1.Visible = False
            'selected_tab.Value = 3
            'DropDownList1.SelectedValue = "0"
            'Me.tab4.Visible = True
        End If

    End Sub

    'Protected Sub Timer1_Tick(sender As Object, e As EventArgs) Handles Timer1.Tick '倒數計時器

    '    Dim MyStartDate As DateTime = Convert.ToDateTime(Label_StartDate.Text) '取得開賣日期
    '    '取得電腦現在時間
    '    Dim MyDateNow As DateTime = DateTime.Now
    '    '執行倒數
    '    Dim MySpan1 As TimeSpan = MyStartDate.Subtract(MyDateNow)
    '    Dim diffDay As String = Convert.ToString(MySpan1.Days)
    '    Dim diffHour As String = Convert.ToString(MySpan1.Hours)
    '    Dim diffMin As String = Convert.ToString(MySpan1.Minutes)
    '    Dim diffSec As String = Convert.ToString(MySpan1.Seconds)
    '    If (MySpan1.TotalSeconds > 0) Then


    '        '顯示秒數
    '        Label_CountDown.Text = diffDay + "天" + diffHour + "時" + diffMin + "分" + diffSec + "秒"

    '    Else
    '        ImageButton1.ImageUrl = "scramble.png"
    '        ImageButton1.Enabled = True
    '        Timer1.Enabled = False
    '    End If
    'End Sub
    ' 亂數產生
    Public Function GenerateCheckCode() As String
        Dim number As Integer
        Dim Code As Char
        Dim checkCode As String = String.Empty
        Dim random As System.Random = New Random()
        '要製造出幾個驗證碼
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
