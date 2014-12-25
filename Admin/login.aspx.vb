
Partial Class login
    Inherits System.Web.UI.Page

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click

        If FormsAuthentication.Authenticate(TextBox1.Text, TextBox2.Text) Then
            Session("Login") = Server.HtmlEncode("OK")
            Session.Timeout = 20
            If Not Session("forward") = Nothing Then
                Response.Redirect(Session("forward"))
            Else
                Response.Redirect("admin.aspx")
            End If
        Else

            Literal1.Text = "帳號或密碼錯誤"
        End If



    End Sub

End Class
