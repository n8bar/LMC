<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>TMC Development</title>
<!--#include file="common.asp" -->

<link rel=stylesheet href="Library/CSS_DEFAULTS.css" media=all>

<style>
html { margin:0; width:100%; height:100%; overflow:hidden; }
body { margin:0; width:100%; height:100%; overflow:hidden; }

h1,h2,h3,h4,h5,h6 { text-align:center; width:100%; margin:4px; }

#left { float:left; width:20%; height:100%; background-color:rgba(0,128,255,.5); overflow:hidden; }
#main{ float:left; width:60%; height:100%; background-color:rgba(0,128,255,.25); overflow:hidden; }
#right { float:left; width:20%; height:100%; background-color:rgba(0,128,255,.5); overflow:hidden; }

.scrollBox { overflow-x:hidden; overlow-y:auto; }
.pre {white-space:pre-wrap; font-family:Consolas, "Courier New", Courier, Monospace; }
</style>

</head>
<body>
	<div id=left class="shade20">
	</div>
	<div id=main class="shade35">
	<!--#include file="../tmc/loginAsp.asp" -->
	</div>
	<div id=right class="shade20">
		<div class="h25p w100p fL scrollBox shade" id=vHistory >
			<h2>Version history</h2>
			<p class=pre ><%=Application("versionHistory")%></p>
		</div>
		<div class="h75p w100p fL scrollBox shade20" id=vRoadMap >
			<h2>Version Roadmap</h2>
			<p class=pre><%=Application("versionRoadMap")%></p>
		</div>
	</div>
</body>
</html>
