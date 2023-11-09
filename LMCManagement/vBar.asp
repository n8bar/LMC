<%GraphData=Request.QueryString("GraphData")%>

<!DOCTYPE html>
<html style="overflow:hidden; height:100%; width:100%; margin:0; padding:0; ">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Vertical Bar Graph</title>

<style media="all">
body { overflow:hidden; font-family:Calibri, Tahoma, Geneva, sans-serif; height:100%; width:100%; margin:0; padding:0; position:relative; top:0%; }

div, table, tr, td {box-sizing:border-box; -moz-box-sizing:border-box; padding:0; margin:0; white-space:nowrap; }
table {overflow:hidden; }
.positive div { float:left; }
.negative div { float:left; }

.caption{	/* border-radius:50%; overflow:hidden; padding:1.5%; position:absolute; text-align:center; white-space:nowrap; width:auto; z-index:10000; */
	text-shadow: #fff 0px 0px 2px, #fff 0px 0px 2px, #fff 0px 0px 4px, #fff 0px 0px 4px, #fff 0px 0px 6px, #fff 0px 0px 6px, #fff 0px 0px 10px;
}

#BudgetLine {position:absolute; width:100%; height:19px; border-bottom:1px rgba(0,96,0,.7) solid; color:rgba(0,0,0,.7); font-size:14px; font-weight:bold; z-index:100; }

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
	var gA=parseFloat(GraphItems[0].split('_')[1])/100;
	var hi=gA; var lo=gA;
	for(g=gStart;g<count;g++)	{
		gA=parseFloat(GraphItems[g].split('_')[1])/100;
		if(gA>0) {
			gTotal+=gA;
			//alert(gA+' ? '+hiPlus+'\n'+(gA>hiPlus));
			if(gA>hiPlus) {  hiPlus=gA; }
			//alert(gA+' >= '+hiPlus);
		}
		else {
			gMTotal-=(gA*1);
			if(gA<loMinus) loMinus=gA;
		}
		if(gA>hi) hi=gA; 
		if(gA<lo) lo=gA;
	}
	gRange=hi-lo//hiPlus-loMinus;
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
		//document.getElementById('positive').style.height=((hiPlus/gRange)*95)+'%';
		//document.getElementById('negative').style.height=(((-loMinus)/gRange)*95)+'%';
		//if (document.getElementById('negative').offsetHeight>64) {
		//	document.getElementById('positive').style.height=(document.getElementById('positive').offsetHeight+(document.getElementById('negative').offsetHeight-64))+'px';
		//	document.getElementById('negative').style.height='64px';
		//
		//}
		
		
		document.getElementById('pValues').innerHTML=''; 
		//document.getElementById('nValues').innerHTML=''; 
		document.getElementById('BudgetLine').style.bottom=(Math.abs(lo/gRange)*95)+('%');
		//document.getElementById('BudgetLine').innerHTML='hi:'+hi+' lo:'+lo+' >>'+gRange;
		var	gHtml=''; var tHtml='';
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
				//subRange=hiPlus; 
				align='bottom';
				//br='top';
				mH='';
				if(gNum>0) { overUnder='Over'; color='C00'; }
			}
			else {
				//subRange=-loMinus;
				align='top';
				//br='bottom';
				mH='';// max-height:64px; ';
				overUnder='Under';
				color='080';
				//document.getElementById('nValues').style.maxHeight='64px';
				//document.getElementById('nValues').parentNode.style.maxHeight='64px';
				//document.getElementById('negative').style.maxHeight='64px';
			}
			br='top';
			
			var gNumO=gNum+Math.abs(lo);
			
			//alert(gNum+' : '+hi+' - '+lo+' = '+subRange);
			var P=Math.round(((gNum)/gRange)*100);
			var H=((gNumO/gRange)*100)+1;
			var W=(100/count);
			
			var opacity='';
			if(gText=='Bottomer') {
				opacity=' opacity:0; ';
			}
			//tHtml+='<div class=caption style="float:left; width:'+W+'%; color:#'+color+'; '+opacity+' " align=center >'+gText+' <br/> $'+(gNum)+' <br/> [ '+P+'% ]</div>';
			tHtml+='<div class=caption style="float:left; width:'+W+'%; color:#'+color+'; '+opacity+' " align=center >'+gText+' <br/> $'+(gNum)+'</div>';

			gHtml+='	<td width='+W+'% height=100% style=" '+mH+' " align=center >';
			gHtml+='		<div style="float:left; height:'+H+'%; '+mH+' '+opacity+' min-height:3px; width:90%; background:#'+gColr+'; margin:0 5% 0 5%; border:#'+gColr+' outset 2px; border-'+br+'-left-radius:12px; border-'+br+'-right-radius:12px; " >';
			gHtml+='		</div>';
			gHtml+='	<td>';
				
			document.getElementById('topper').innerHTML+=tHtml; 
			//if (gNum<0) {
			//	document.getElementById('nValues').innerHTML+=gHtml; 
			//	document.getElementById('pValues').innerHTML+='&nbsp;';//'<td width='+W+'% height=100% " >&nbsp;'+gNum+'</td>'; 
			//}
			//else {
			//	document.getElementById('nValues').innerHTML+='&nbsp;';//'<td width='+W+'% height=100% " >&nbsp;'+gNum+'</td>'; 
				document.getElementById('pValues').innerHTML+=gHtml; 
			//}
		}
		//document.getElementById('positive').childNodes[0].style.height=((hiPlus/gRange)*100)+'%';
		//document.getElementById('negative').childNodes[0].style.height=((loMinus/gRange)*100)+'%';
	}
}
</script>
</head>

<body onLoad="DrawGraph();" >
	<div id=title style="float:left; height:5%; width:100%; " align=center></div>
	<div id=topper style="height:auto; position:absolute; top:7.5%; width:100%; z-index:100;" >
	</div>
	<table id=positive height=95% width=100% cellpadding="0" cellspacing="0" >
		<tbody height=100%>
			<tr id=pValues height=100% valign=bottom ></tr>
		</tbody>
	</table>
	<!-- div id=footer style="float:left; height:2.5%; width:100%; " align=center></div -->
	<div id=BudgetLine >
		&nbsp; &nbsp; Budget
		<div style="border-top:1px solid rgba(255,64,64,.5); width:100%; height:1px; float:left;"></div>
	</div>
</body>

</html>