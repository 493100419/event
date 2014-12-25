Imports System.Data.SqlClient
Imports StackExchange.Redis
Partial Class redisadmin
    Inherits System.Web.UI.Page

    Protected Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click 'SET
        Dim args As New DataSourceSelectArguments
        SqlDataSource1.SelectCommand = "Select * from Event where EventId =" & DropDownList3.SelectedValue
        Dim dr2 As SqlDataReader = CType(SqlDataSource1.Select(args), SqlDataReader)
        dr2.Read()
        '    '寫到Label
        If dr2.HasRows Then '判斷是否有資料
            '    Dim connection As ConnectionMultiplexer = ConnectionMultiplexer.Connect(System.Web.Configuration.WebConfigurationManager.ConnectionStrings _
            '("bishytsai").ConnectionString)
            Dim cache As IDatabase = redisconnection.connection.GetDatabase()
            cache.StringSet("Name", dr2("Name").ToString())
            cache.StringSet("Show", dr2("Show").ToString())
            cache.StringSet("EventId", dr2("EventId").ToString())
            cache.StringSet("Image", dr2("image").ToString())
            cache.StringSet("Introduction", dr2("Introduction").ToString())
            cache.StringSet("Feature", dr2("Feature").ToString())
            cache.StringSet("Location", dr2("Location").ToString())
            cache.StringSet("Host", dr2("Host").ToString())
            cache.StringSet("Quantities", dr2("Quantities").ToString())
            cache.StringSet("EventDate", dr2("EventDate").ToString())
            cache.StringSet("StartDate", dr2("StartDate").ToString())
            cache.StringSet("EndDate", dr2("EndDate").ToString())
            dr2.NextResult()
            SqlDataSource2.SelectCommand = "SELECT Id, Name + ' / $' +" & _
                "CAST(Price AS varchar(10)) AS NP, Cast(EventId AS varchar(10)) + '_' + Cast(Id AS varchar(10)) AS E_I from Ticket where EventId = '" & DropDownList3.SelectedValue & "'"
            dr2 = CType(SqlDataSource2.Select(args), SqlDataReader)
            Dim j As Integer = 1
            While dr2.Read()
                cache.StringSet("NP" & j, dr2("NP").ToString())
                cache.StringSet("Id" & j, dr2("Id").ToString())
                cache.StringSet("E_I" & j, dr2("E_I").ToString())
                'cache.StringSet("Quantity" & j, dr2("Quantity").ToString())
                j = j + 1
            End While
            dr2.Close()
            Server.Transfer("redisadmin.aspx")
            'Me.Page.ClientScript.RegisterStartupScript(Me.GetType(), "alert", "alert('SET OK')", True)

        End If
    End Sub

    Protected Sub Button2_Click(sender As Object, e As EventArgs) Handles Button2.Click 'GET
        Dim cache As IDatabase = redisconnection.connection.GetDatabase()
        Dim j As String = DropDownList1.SelectedIndex.ToString
        cache.StringSet("Quantity" & j, TextBox1.Text)
        Server.Transfer("redisadmin.aspx")
    End Sub

    Protected Sub Button3_Click(sender As Object, e As EventArgs) Handles Button3.Click
        'Dim connection As ConnectionMultiplexer = ConnectionMultiplexer.Connect(System.Web.Configuration.WebConfigurationManager.ConnectionStrings _
        '    ("bishytsai").ConnectionString)
        Dim server1 As IServer = redisconnection.connection.GetServer(redisconnection.connection.GetEndPoints.First())
        server1.FlushDatabase()
        Server.Transfer("redisadmin.aspx")
    End Sub



    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            Try

                Dim cache As IDatabase = redisconnection.connection.GetDatabase()
                HyperLink1.NavigateUrl = "../Defaultredis.aspx?id=" & cache.StringGet("EventId").ToString
                div_image.Attributes.Add("style", "background-image: url(" & cache.StringGet("Image").ToString() & ")")
                Label_Introduction.Text = cache.StringGet("Introduction")
                Label_name.Text = cache.StringGet("Name")
                Label_Feature.Text = cache.StringGet("Feature")
                Label_Location.Text = cache.StringGet("Location")
                HyperLinkmap.NavigateUrl = "https://www.google.com.tw/maps/search/" & cache.StringGet("Location").ToString()
                Label_Host.Text = cache.StringGet("Host")
                Label_Quantities.Text = cache.StringGet("Quantities")
                Dim eventdate As DateTime = cache.StringGet("EventDate")
                Label_EventDate.Text = eventdate.ToString("yyyy/MM/dd HH:mm:ss")
                Dim startdate As DateTime = cache.StringGet("StartDate")
                Label_StartDate.Text = startdate.ToString("yyyy/MM/dd HH:mm:ss")
                Dim enddate As DateTime = cache.StringGet("EndDate")
                Label_EndDate.Text = enddate.ToString("yyyy/MM/dd HH:mm:ss")

                Dim j As Integer = 1

                While cache.KeyExists("NP" & j)
                    DropDownList1.Items.Add(cache.StringGet("NP" & j).ToString() & " / " & cache.StringGet("Quantity" & j).ToString())
                    DropDownList1.Items(j).Value = cache.StringGet("Id" & j)
                    j = j + 1
                End While
            Catch ex As Exception

            End Try
        End If
    End Sub
End Class
