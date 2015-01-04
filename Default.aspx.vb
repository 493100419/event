Imports System.Data
Imports System.Data.SqlClient
Public Class GoogleResponse
    Public success As Boolean
    Public errorcodes As String
End Class
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
                '----------------以下使用datareader--------------------------------
                Dim conn As SqlConnection = New SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings _
                  ("eventsConnectionString").ConnectionString)
                Dim cmd As New SqlCommand("SELECT Id, Name + ' / $' +" & _
                "CAST(Price AS varchar(10)) AS NP, Cast(EventId AS varchar(10)) + '_' + Cast(Id AS varchar(10)) AS E_I from Ticket where EventId = '" _
                & EventId & "'", conn)
                Dim dr2 As SqlDataReader = Nothing
                Try
                    conn.Open()
                    dr2 = cmd.ExecuteReader()
                    Dim j As Integer = 1
                    While dr2.Read()
                        Select Application(dr2("E_I"))
                            Case Is > 10
                                DropDownList1.Items.Add(dr2("NP") & " / " & "熱賣中")
                                DropDownList1.Items(j).Value = dr2("Id")
                                j = j + 1
                            Case 1 To 10
                                DropDownList1.Items.Add(dr2("NP") & " / " & "剩餘" & Application(dr2("E_I")))
                                DropDownList1.Items(j).Value = dr2("Id")
                                j = j + 1
                            Case Else
                                DropDownList1.Items.Add(dr2("NP") & " / " & "已售完")
                                DropDownList1.Items(j).Value = dr2("Id")
                                j = j + 1
                        End Select
                    End While
                    dr2.NextResult()
                    dr2 = CType(SqlDataSource1.Select(args), SqlDataReader)
                    dr2.Read()
                    '    '寫到Label
                    If dr2.HasRows Then '判斷是否有資料
                        div_image.Attributes.Add("style", "background-image: url(" & dr2("Image").ToString() & ")")
                        'Image2.ImageUrl = dv.Table(0).Item("Image").ToString()
                        Label_Introduction.Text = dr2("introduction").ToString()
                        Label_name.Text = dr2("Name").ToString()
                        Select Case dr2("Show").ToString()
                            Case 1
                                Label_name.Visible = True
                            Case 0
                                Label_name.Visible = False
                        End Select
                        Label_Feature.Text = dr2("Feature").ToString()
                        Label_Location.Text = dr2("Location").ToString()
                        HyperLinkmap.NavigateUrl = "https://www.google.com.tw/maps/search/" & dr2("Location").ToString()
                        Label_Host.Text = dr2("Host").ToString()
                        Label_Quantities.Text = dr2("Quantities").ToString()
                        Dim eventdate As DateTime = dr2("EventDate").ToString()
                        Label_EventDate.Text = eventdate.ToString("yyyy/MM/dd HH:mm:ss")
                        Dim startdate As DateTime = dr2("StartDate").ToString()
                        Label_StartDate.Text = startdate.ToString("yyyy/MM/dd HH:mm:ss")
                        Dim enddate As DateTime = dr2("EndDate").ToString()
                        Label_EndDate.Text = enddate.ToString("yyyy/MM/dd HH:mm:ss")
                        Label_Now.Text = today.ToString("yyyy/MM/dd HH:mm:ss")
                        Label2.Text = "在線人數：" & Application("online")
                        'Me.Title = dv.Table(0).Item("Name").ToString() & " - " & Me.Title
                        '寫限購數量到下拉選單2
                        For i As Integer = 1 To CType(dr2("Quantities").ToString, Integer)
                            Dim item As ListItem = New ListItem(i.ToString())
                            DropDownList2.Items.Add(item)
                        Next i
                        '改Title 並去除顏色
                        If Label_name.Text <> "" And Label_name.Text.Contains(""">") = True Then
                            pagetitle1 = Split(Label_name.Text, """>")(1).Trim()
                            pagetitle2 = Split(pagetitle1, "</span>")(0).Trim()
                        Else
                            pagetitle2 = Label_name.Text
                        End If
                    End If
               

                    '-------------------datareader結束---------------------------------
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
                Catch ex As Exception
                    'Response.Write(ex)
                Finally
                    If Not (dr2 Is Nothing) Then
                        cmd.Cancel()
                        dr2.Close()
                    End If

                    If (conn.State = ConnectionState.Open) Then
                        conn.Close()
                        conn.Dispose()
                    End If
                End Try
            End If

        Else '如果不是第一次讀取則?

            'selected_tab.Value = Request.Form(selected_tab.UniqueID)
        End If
        '每次重新整理則>



    End Sub

   
    '自訂驗證項
    Protected Sub CustomValidator1_ServerValidate(source As Object, args As ServerValidateEventArgs) Handles CustomValidator1.ServerValidate
   
        Dim EventId As String = Request.QueryString("id").ToString()
        Dim Id As String = DropDownList1.SelectedValue
        '判斷是否開啟Cookie
        If Request.Cookies("ckeckcookies").Value IsNot Nothing Then
            '判斷開賣時間
            Dim est As TimeZoneInfo = TimeZoneInfo.FindSystemTimeZoneById("Taipei Standard Time")
            Dim today As DateTime = TimeZoneInfo.ConvertTime(DateTime.Now, est)
            If DateTime.Compare(Label_StartDate.Text, today) > 0 Then
                'CustomValidator1.ErrorMessage = "尚未開賣!"
                Me.Page.ClientScript.RegisterStartupScript(Me.GetType(), "alert", "alert('尚未開賣')", True)
                args.IsValid = False

                '判斷是否選擇票種
            ElseIf DropDownList1.SelectedValue = 0 Then
                'CustomValidator1.ErrorMessage = "請選擇票種"
                Me.Page.ClientScript.RegisterStartupScript(Me.GetType(), "alert", "alert('請選擇票種')", True)
                args.IsValid = False

                '判斷選購數量是否大於實際庫存
            ElseIf Application(EventId & "_" & Id) < CType(DropDownList2.SelectedValue, Integer) And Application(EventId & "_" & Id) > 0 Then
                'CustomValidator1.ErrorMessage = "庫存量不足"
                Me.Page.ClientScript.RegisterStartupScript(Me.GetType(), "alert", "alert('庫存量不足')", True)
                args.IsValid = False

                '判斷票券是否已經售完
            ElseIf Application(EventId & "_" & Id) = 0 Then
                'CustomValidator1.ErrorMessage = "已售完"
                Me.Page.ClientScript.RegisterStartupScript(Me.GetType(), "alert", "alert('已售完')", True)
                args.IsValid = False
                '判斷是否購買過
            ElseIf Session("bought") = "OK" Then
                ' CustomValidator1.ErrorMessage = "抱歉!每人限購一次"
                Me.Page.ClientScript.RegisterStartupScript(Me.GetType(), "alert", "alert('抱歉!每人限購一次')", True)
                args.IsValid = False

            ElseIf Request("g-recaptcha-response") IsNot Nothing And Request("g-recaptcha-response") <> "" Then
                Dim sCatchaResponse As String = Request("g-recaptcha-response")
                Dim sSecret As String = "6LdkS_8SAAAAABOn8WahPxVPCOACqISVCgAy89Tp"
                Dim sIPAddress As String = Request.ServerVariables("REMOTE_ADDR").ToString()
                Dim wc As System.Net.WebClient = New System.Net.WebClient()
                Dim sRequest As String = String.Format("https://www.google.com/recaptcha/api/siteverify? secret={0}&response={1}&remoteip={2}", sSecret, sCatchaResponse, sIPAddress)
                Dim sResponse As String = wc.DownloadString(sRequest)
                Dim serializer As System.Web.Script.Serialization.JavaScriptSerializer = New System.Web.Script.Serialization.JavaScriptSerializer()
                Dim gresponse As GoogleResponse = serializer.Deserialize(Of GoogleResponse)(sResponse)
                If Not gresponse.success Then
                    args.IsValid = True
                End If
            Else
                'CustomValidator1.ErrorMessage = "請勾選我不是機器人"
                'Me.Page.ClientScript.RegisterStartupScript(Me.GetType(), "alert", "alert('請勾選我不是機器人')", True)
                args.IsValid = False
                Response.Write("<script language='JavaScript'>alert('請勾選我不是機器人');window.location='default.aspx?id=" + EventId + "';</script>")
            End If
        Else
            Me.Page.ClientScript.RegisterStartupScript(Me.GetType(), "alert", "alert('請先開啟Cookie功能')", True)
            Response.Write("<script language='JavaScript'>alert('請先開啟Cookie功能');window.location='default.aspx?id=" + EventId + "';</script>")
            CustomValidator1.ErrorMessage = ""
            args.IsValid = False
        End If


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
            Dim code As String = Left(FormsAuthentication.HashPasswordForStoringInConfigFile(Session.SessionID, "MD5"), 12)
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
            Response.Redirect("default.aspx?id=" & EventId)
            'ImageButton1.Visible = False
            'selected_tab.Value = 3
            'DropDownList1.SelectedValue = "0"
            'Me.tab4.Visible = True
        End If
        
    End Sub
End Class
