Imports Microsoft.VisualBasic
Imports StackExchange.Redis
Imports System.Data
Imports System.Web.Configuration
Public Class redisconnection
    Private Shared lazyconnection As Lazy(Of ConnectionMultiplexer) = New Lazy(Of ConnectionMultiplexer) _
 (Function()
      Return ConnectionMultiplexer.Connect(WebConfigurationManager.ConnectionStrings("bishytsai").ConnectionString)
  End Function)
    Public Shared Function connection() As ConnectionMultiplexer
        Return lazyconnection.Value
    End Function
End Class
