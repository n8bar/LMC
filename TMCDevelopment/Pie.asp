<%GraphData=Request.QueryString("GraphData")%>

<!DOCTYPE html>
<html style="overflow:hidden; height:100%; width:100%; margin:0; padding:0; ">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>System Information</title>

<script type="text/javascript" src="Modules/wz_jsgraphics.js"></script><script type="text/javascript" src="Library/pie.js"></script><script type="text/javascript" src="Modules/rcstri.js"></script>

<style media="all">
.caption{	border-radius:50%; overflow:hidden; padding:1.5%; position:absolute; text-align:center; white-space:nowrap; width:auto; z-index:10000;
	text-shadow: #fff 0px 0px 2px, #fff 0px 0px 2px, #fff 0px 0px 4px, #fff 0px 0px 4px, #fff 0px 0px 6px, #fff 0px 0px 6px, #fff 0px 0px 10px;
}
</style>

</head>
<body style="overflow:hidden; height:100%; width:100%; margin:0; padding:0; position:relative; top:0%;">

<div id="pieCanvas" style="overflow:hidden; position:relative; height:100%; width:100%; margin:0; padding:0;"></div>

<script type="text/javascript">

var gTotal=0;
var negTop=10;
var negI=0
function showNeg(amount,caption) {
	negI++
	var pc=Math.round((amount/gTotal)*1000)/100;
	document.body.innerHTML+='<div id=neg'+negI+' class=caption style="background:rgba(255,0,0,.25); left:10px; top:'+negTop+'px; ">'+caption+'<br/>'+pc+'%</div>';
	negTop+=document.getElementById('neg'+negI).offsetHeight;
}


var GraphData='<%=GraphData%>';
if(!GraphData) {
	document.body.innerHTML='Error:No Graph Data';
}
else {
	GraphData=GraphData.replace(/!/g,'%');
	
	var gStart=0;
	if(GraphData.indexOf('.')==0) { GraphData=GraphData.replace('.',''); }
	//alert(GraphData);
	
	var GraphItems=GraphData.split('.');
	
	var p = new pie();
	//p.add("Jan",100);
	
	for(g=gStart;g<=GraphItems.length-1;g++)	{
		var gNum=GraphItems[g].split('_')[1];
		if(gNum>0) gTotal+=(gNum*1);
	}
	for(g=0;g<=GraphItems.length-1;g++)	{
		var gText=GraphItems[g].split('_')[0];
		var gNum=GraphItems[g].split('_')[1];
		var gColr=GraphItems[g].split('_')[2];
		if(gNum<0) { 
			showNeg(gNum,gText);
			continue;
		}
		p.add(gText,gNum,gColr);
	}
	
	p.render("pieCanvas", "Pie Graph");
}
</script>

<!-- 




<div id="pieCanvas" style="overflow: auto; position:relative;height:350px;width:380px;"></div>

<script type="text/javascript">
var p = new pie();
p.add("Jan",100);
p.add("Feb",200);
p.add("Mar",150);
p.add("Apr",120);
p.add("May",315);
p.add("Jun",415);
p.add("Jul",315);
p.render("pieCanvas", "Pie Graph")

</script>
-->

</body>
</html>