<%GraphData=Request.QueryString("GraphData")%>

<!DOCTYPE html>
<html style="overflow:hidden; height:100%; width:100%; margin:0; padding:0; ">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Vertical Bar Graph</title>

<style media="all">
body { overflow:hidden; font-family:Calibri, Tahoma, Geneva, sans-serif; height:100%; width:100%; margin:0; padding:0; position:relative; top:0%; }

div, table, tr, td {box-sizing:border-box; -moz-box-sizing:border-box; padding:0; margin:0; white-space:nowrap; }

.positive div { float:left; }
.negative div { float:left; }

.caption{	/* border-radius:50%; overflow:hidden; padding:1.5%; position:absolute; text-align:center; white-space:nowrap; width:auto; z-index:10000; */
	text-shadow: #fff 0px 0px 2px, #fff 0px 0px 2px, #fff 0px 0px 4px, #fff 0px 0px 4px, #fff 0px 0px 6px, #fff 0px 0px 6px, #fff 0px 0px 10px;
}


</style>

<script type="text/javascript">

var GraphData='<%=GraphData%>';

if (!!GraphData) {
	GraphData=GraphData.replace(/!/g,'%');
	
	var gStart=0;
	if(GraphData.indexOf('.')==0) { GraphData=GraphData.replace('.',''); }
	//alert(GraphData);
	
	var GraphItems=GraphData.split('.');
	
	var count=GraphItems.length;
	
	var hiPlus=0; var loMinus=0;
	var gTotal=0; var gMTotal=0;
	for(g=gStart;g<count;g++)	{
		var gA=parseFloat(GraphItems[g].split('_')[1]);
		if(gA>0) {
			gTotal+=(gA*1);
			//alert(gA+' ? '+hiPlus+'\n'+(gA>hiPlus));
			if(gA>hiPlus) {  hiPlus=gA; }
			//alert(gA+' >= '+hiPlus);
		}
		else {
			gMTotal-=(gA*1);
			if(gA<loMinus) loMinus=gA;
		}
	}
	gRange=hiPlus-loMinus;
	gTotalTotal=gTotal+gMTotal;
}
function DrawGraph() {
	if(!GraphData) {
		document.body.innerHTML='Error:No Graph Data';
	}
	else {
		//document.getElementById('title').innerHTML=GraphItems;
		
		//document.getElementById('positive').setAttribute('height',((hiPlus/gRange)*100)+'%');
		//document.getElementById('negative').setAttribute('height',((loMinus/gRange)*100)+'%');
		document.getElementById('positive').style.height=((hiPlus/gRange)*95)+'%';
		document.getElementById('negative').style.height=(((-loMinus)/gRange)*95)+'%';
		if (document.getElementById('negative').offsetHeight>64) {
			document.getElementById('positive').style.height=(document.getElementById('positive').offsetHeight+(document.getElementById('negative').offsetHeight-64))+'px';
			document.getElementById('negative').style.height='64px';
		}
		
		
		var	gHtml=''; var tHtml='';
		document.getElementById('pValues').innerHTML=''; 
		document.getElementById('nValues').innerHTML=''; 
		for(g=0;g<=count-1;g++)	{
			gHtml=''; tHtml='';
			var gText=GraphItems[g].split('_')[0];
			var gNum=(GraphItems[g].split('_')[1]/100);
			var gColr=GraphItems[g].split('_')[2];
			if (gColr=='') gColr='ddd';
			
			var subRange; 
			var align;
			var br
			var mH
			var overUnder='On Budget.';
			var color='000';
			if (gNum>=0) {
				subRange=hiPlus; 
				align='bottom';
				br='top';
				mH='';
				if(gNum>0) { overUnder='Over'; color='C00'; }
			}
			else {
				subRange=-loMinus;
				align='top';
				br='bottom';
				mH='';// max-height:64px; ';
				overUnder='Under';
				color='080';
				//document.getElementById('nValues').style.maxHeight='64px';
				//document.getElementById('nValues').parentNode.style.maxHeight='64px';
				//document.getElementById('negative').style.maxHeight='64px';
			}
			var P=Math.round(Math.abs(gNum/gTotalTotal)*10000);
			var H=Math.abs((gNum/subRange)*10000);
			var W=(100/count);
			
			
			
			tHtml+='<div class=caption style="float:left; width:'+W+'%; color:#'+color+';" align=center >'+gText+' <br/> $'+Math.abs(gNum)+' <br/> [ '+P+'% ]</div>';

			gHtml+='	<td width='+W+'% height=100% style="'+mH+'" >';
			gHtml+='		<div style="float:left; height:'+H+'%; '+mH+' width:100%; background:#'+gColr+'; border:#'+gColr+' outset 1px; border-'+br+'-left-radius:12px; border-'+br+'-right-radius:12px; " >';
			gHtml+='		</div>';
			gHtml+='	<td>';
				
			document.getElementById('topper').innerHTML+=tHtml; 
			if (gNum<0) {
				document.getElementById('nValues').innerHTML+=gHtml; 
				document.getElementById('pValues').innerHTML+='&nbsp;';//'<td width='+W+'% height=100% " >&nbsp;'+gNum+'</td>'; 
			}
			else {
				document.getElementById('nValues').innerHTML+='&nbsp;';//'<td width='+W+'% height=100% " >&nbsp;'+gNum+'</td>'; 
				document.getElementById('pValues').innerHTML+=gHtml; 
			}
		}
		//document.getElementById('positive').childNodes[0].style.height=((hiPlus/gRange)*100)+'%';
		//document.getElementById('negative').childNodes[0].style.height=((loMinus/gRange)*100)+'%';
	}
}
</script>
</head>

<body onLoad="DrawGraph();" >
	<div id=title style="float:left; height:2.5%; width:100%; " align=center></div>
	<div id=topper style="height:auto; position:absolute; top:7.5%; width:100%;" >
	</div>
	<table id=positive width=100% cellpadding="0" cellspacing="0" >
		<tbody>
			<tr id=pValues height=100% valign=bottom ></tr>
		</tbody>
	</table>
	<table id=negative width=100% cellpadding="0" cellspacing="0"  >
		<tbody>
			<tr id=nValues height=100% valign=top ></tr>
		</tbody>
	</table>
	<div id=footer style="float:left; height:2.5%; width:100%; " align=center></div>
</body>

</html>