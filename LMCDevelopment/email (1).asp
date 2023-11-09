<%@ Language=VBScript %>
<%

Orig = Request.QueryString("from")
Dest = Request.QueryString("To")
Message = Request.QueryString("message")

Set objMail = CreateObject("CDONTS.NewMail")

objMail.From = Trim(Orig)
objMail.To = Dest
objMail.Subject = "Feedback"
objMail.BodyFormat = "0" ' -- HTML format
objMail.Body = "" & Trim(strMessage)

' -- send the email -- 
objMail.Send

' -- clean up object
Set objMail = Nothing

' -- execute confirmation page
'Response.Redirect "thanks.html"
%>