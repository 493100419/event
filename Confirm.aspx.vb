Imports System.Data
Imports System.Data.SqlClient
Partial Class Confirm
    Inherits System.Web.UI.Page

    Protected Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
        Try

            SqlDataSource1.SelectParameters.Add("Code", TextBox1.Text)
            SqlDataSource1.SelectCommand = "select * from EventOrder where Code= @Code"
            SqlDataSource1.DataSourceMode = SqlDataSourceMode.DataReader
            Dim args As New DataSourceSelectArguments
            '== DataSourceSelectArguments 提供一項機制，讓資料繫結控制項於擷取資料時，
            '== 用來向資料來源控制項要求資料相關的作業。

            Dim dr As IDataReader = CType(SqlDataSource1.Select(args), IDataReader)

            dr.Read()  '*****  重點！！ *****

            '檢查輸入預約號碼是否正確
            If TextBox1.Text.Trim() = dr.Item("Code").ToString() Then

                If dr.Item("Status") = "N" Then

                    'STATUS改為Y
                    Dim conn As SqlConnection = New SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings _
                       ("eventsConnectionString").ConnectionString)
                    conn.Open()
                    Dim cmd As SqlCommand = New SqlCommand("Update Eventorder set Status = 'Y' where Code ='" & TextBox1.Text & "'", conn)
                    cmd.ExecuteNonQuery()
                    conn.Close()
                    Label2.Text = "轉入購物車>>>跳到購物車頁面"

                Else
                    Label2.Text = "此號碼已轉入購物車"
                End If


            End If
            dr.Close()
            dr.Dispose()
            SqlDataSource1.SelectParameters.Clear()


        Catch ex As Exception
            'Response.Write(ex)
            Label2.Text = "抱歉!號碼輸入錯誤，請重新確認"

        End Try
    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim code As String = Left(FormsAuthentication.HashPasswordForStoringInConfigFile(Session.SessionID, "MD5"), 12)
        Response.Write(code)
    End Sub
End Class
