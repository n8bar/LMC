<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="TMC/RED.asp"-->
<html>
<head>
<script type="text/javascript">
	function timeout() {
		var t=setTimeout('window.location=window.location;',250);
	}
</script>
</head>
<body style="font-size:24px; font-family:consolas; text-align:center; background:#000; color:#ccc;"  onLoad="timeout();">
	<%=Application("cidLookupLastCallerName")%><br/>
	<%=Application("cidLookupLastCallerNumber")%><br/>
	<small><small style=""><b><small>@</small> <%=Application("cidLookupLastCallerTime")%></b></small></small><br/>
	<br/>
	<small style="font-family:consolas;"><%=Date&" "&Time%></small>
</body>
</html>