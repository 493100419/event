Imports System.Data.SqlClient
Imports System.Data
Imports System.Web.Configuration
Imports System.Web.UI.WebControls
Partial Class admin
    Inherits System.Web.UI.Page

 
    '手動GridView
    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        '第一次進入如果沒有傳遞字串則設為插入模式
        If Not Page.IsPostBack Then
            If Request.QueryString("id") = Nothing Then
                FormView1.DefaultMode = FormViewMode.Insert
                '將新增票種選項隱藏
                FormView2.Visible = False
            End If
            Try
                '設定活動連結
                Dim EventId As String = Request.QueryString("id").ToString()
          
                HyperLink1.NavigateUrl = String.Format(HyperLink1.NavigateUrl, Request.QueryString("id"))
            Catch ex As Exception

            End Try
        End If
    End Sub
    '修改票種資料
    Protected Sub GridView1_RowCommand(ByVal sender As Object, ByVal e As GridViewCommandEventArgs) Handles GridView1.RowCommand
        Dim EventId As String = Request.QueryString("id").ToString()
        If e.CommandName = "Update1" Then

            Dim TicketId As String = e.CommandArgument
            Dim rows As GridViewRow = CType(CType(e.CommandSource, Control).Parent.Parent, GridViewRow)
            Dim Id As Integer = CType(rows.FindControl("Label_Id"), Label).Text.Trim()
            Dim qty As String = CType(rows.FindControl("Textbox_Qty"), TextBox).Text.Trim()
            Dim Price As Integer = CType(rows.FindControl("Textbox_Price"), TextBox).Text.Trim()
            Dim Name As String = CType(rows.FindControl("Textbox_Name"), TextBox).Text.Trim()

            Try
                Application(EventId & "_" & TicketId) = qty


                Dim conn As SqlConnection = New SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings _
                           ("eventsConnectionString").ConnectionString)
                conn.Open()

                Dim cmd As SqlCommand = New SqlCommand("Update Ticket Set Price= @Price, Name = @Name Where Id = @Id", conn)
                cmd.Parameters.Add("@Price", SqlDbType.Int)
                cmd.Parameters("@Price").Value = Price
                cmd.Parameters.Add("@Name", SqlDbType.NVarChar)
                cmd.Parameters("@Name").Value = Name
                cmd.Parameters.Add("@Id", SqlDbType.Int)
                cmd.Parameters("@Id").Value = Id
                cmd.ExecuteNonQuery()
                cmd.Cancel()
                conn.Close()

            Catch ex As Exception
                Response.Write(ex.Message)
            End Try
            '按下新增票種後，GridView切到EmptyDataTemplete的新增模式
        ElseIf e.CommandName = "Insert1" Then
            GridView1.DataSourceID = Nothing
        End If
    End Sub


    '票種新增後返回票種畫面
    Protected Sub SqlDataSource2_Inserted(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSource2.Inserted
        GridView1.DataSourceID = "SqlDataSource2"
        Dim EventId As String = Request.QueryString("id").ToString()
        Dim id As Integer = e.Command.Parameters("@Id").Value.ToString()
        Dim textbox3 As TextBox = FormView2.FindControl("TextBox3")
        Application(EventId & "_" & id) = textbox3.Text
    End Sub

  



    '新增票種時預設EventId
    Protected Sub FormView2_ItemInserting(sender As Object, e As FormViewInsertEventArgs) Handles FormView2.ItemInserting
        e.Values("EventId") = Request.QueryString("id").ToString()
    End Sub

    '按下取消後回到目錄
    Protected Sub InsertCancelButton_Click(sender As Object, e As EventArgs)
        Response.Redirect("admin.aspx")

    End Sub

    

    Protected Sub FormView1_ItemCommand(sender As Object, e As FormViewCommandEventArgs) Handles FormView1.ItemCommand
     
        If e.CommandName = "Update1" Then '更新活動
            Dim EventId As String = Request.QueryString("id").ToString()
            Dim pagetitle1 As String
            Dim pagetitle2 As String
            Dim Name As String = CType(FormView1.FindControl("NameTextBox"), TextBox).Text.Trim()
            Dim show As String = CType(FormView1.FindControl("ShowCheckBox"), CheckBox).Checked
            Dim Introduction As String = CType(FormView1.FindControl("IntroductionTextBox"), TextBox).Text.Trim()
            Dim Location As String = CType(FormView1.FindControl("LocationTextBox"), TextBox).Text.Trim()
            Dim Host As String = CType(FormView1.FindControl("HostTextBox"), TextBox).Text.Trim()
            Dim Image As String = CType(FormView1.FindControl("ImageTextBox"), TextBox).Text.Trim()
            Dim Feature As String = CType(FormView1.FindControl("CKEditor1"), TextBox).Text.Trim()
            Dim Quantities As Integer = CType(FormView1.FindControl("QuantitiesTextBox"), TextBox).Text.Trim()
            Dim EventDate As String = CType(FormView1.FindControl("EventDateTextBox"), TextBox).Text.Trim()
            Dim StartDate As String = CType(FormView1.FindControl("StartDateTextBox"), TextBox).Text.Trim()
            Dim EndDate As String = CType(FormView1.FindControl("EndDateTextBox"), TextBox).Text.Trim()
            Dim color As String = CType(FormView1.FindControl("Selectcolor"), HtmlControls.HtmlSelect).Value.Trim()
            If Name <> "" And Name.Contains(""">") = True Then '取出不加HTML的字串
                pagetitle1 = Split(Name, """>")(1).Trim()
                pagetitle2 = Split(pagetitle1, "</span>")(0).Trim()
            Else
                pagetitle2 = Name
            End If

            Dim conn As SqlConnection = New SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings _
                        ("eventsConnectionString").ConnectionString)
            conn.Open()

            Dim cmd As SqlCommand = New SqlCommand("Update Event Set Name= @Name, Introduction = @Introduction, Location = " _
             & "@Location, Host = @Host, Image = @Image, Feature = @Feature, Quantities = @Quantities, EventDate = @EventDate, " _
            & "StartDate = @StartDate, EndDate = @EndDate, Show = @Show WHERE EventId = @EventId", conn)
            'cmd.Parameters.Add("@Name", SqlDbType.NVarChar)
            If color = "000000" Then '不改顏色
                cmd.Parameters.AddWithValue("@Name", Name)
            Else '改顏色
                cmd.Parameters.AddWithValue("@Name", "<span style=""color: #" & color & """>" & pagetitle2 & "</span>")
            End If
            cmd.Parameters.AddWithValue("@EventId", EventId)
            cmd.Parameters.AddWithValue("@Introduction", Introduction)
            cmd.Parameters.AddWithValue("@Location", Location)
            cmd.Parameters.AddWithValue("@Host", Host)
            cmd.Parameters.AddWithValue("@Image", Image)
            cmd.Parameters.AddWithValue("@Feature", Feature)
            cmd.Parameters.AddWithValue("@Quantities", Quantities)
            cmd.Parameters.AddWithValue("@EventDate", EventDate)
            cmd.Parameters.AddWithValue("@StartDate", StartDate)
            cmd.Parameters.AddWithValue("@EndDate", EndDate)
            If show = True Then
                cmd.Parameters.AddWithValue("@Show", 1)
            Else
                cmd.Parameters.AddWithValue("@Show", 0)
            End If

            cmd.ExecuteNonQuery()
            cmd.Cancel()
            conn.Close()
            Response.Redirect("adminproduct.aspx?id=" & EventId)
        End If
    End Sub

    Protected Sub SqlDataSource1_Inserted(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSource1.Inserted

        '新增活動後回到檢視模式
        Dim id As Integer = e.Command.Parameters("@EventId").Value.ToString()
        Server.Transfer("adminproduct.aspx?id=" & id)
        '顯示新增票種
        FormView2.Visible = True

    End Sub

    Protected Sub SqlDataSource1_Inserting(sender As Object, e As SqlDataSourceCommandEventArgs) Handles SqlDataSource1.Inserting
      
        Dim show As String = CType(FormView1.FindControl("ShowCheckBox"), CheckBox).Checked '新增活動時檢查是否顯示
        If show = True Then
            SqlDataSource1.InsertParameters.Add("@Show", 1)
        Else
            SqlDataSource1.InsertParameters.Add("@Show", 0)
        End If
    End Sub
End Class
