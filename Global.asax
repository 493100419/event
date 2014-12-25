<%@ Application Language="VB" %>

<script runat="server">

    Sub Application_Start(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs on application startup
        Application("online") = 0

    End Sub
    
    Sub Application_End(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs on application shutdown
        Application("online") = 0
        'UpdateCount(2)
    End Sub
        
    Sub Application_Error(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs when an unhandled error occurs
    End Sub

    Sub Session_Start(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs when a new session is started
        'Session 存活時間，如需要 Login 則將此段註解
        Session.Timeout = 5
        'Application 鎖定
        Application.Lock()
        '在線人數 +1
        Application("online") = CInt(Application("online")) + 1
        '更新總瀏覽人數
        'UpdateCount(1)
        'Application 解鎖
        Application.UnLock()
    End Sub

    Sub Session_End(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs when a session ends. 
        ' Note: The Session_End event is raised only when the sessionstate mode
        ' is set to InProc in the Web.config file. If session mode is set to StateServer 
        ' or SQLServer, the event is not raised.
        Application.Lock()
        '當 Session 結束後，將在線人數 -1
        Application("online") = CInt(Application("online")) - 1
        Application.UnLock()
    End Sub
       
</script>