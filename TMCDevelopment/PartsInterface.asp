<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Parts Interface</title>
<!--#include file="../TMC/RED.asp" -->
<!--#include file="common.asp" -->
<%
	boxID=request.QueryString("BoxID")
	modalID=request.QueryString("ModalID")
	mmEvent=request.QueryString("MM")
	mdEvent=request.QueryString("MD")
	muEvent=request.QueryString("MU")
%>
<script type="text/javascript" src="Modules/rcstri.js"></script>
<script type="text/javascript" src="Library/SqlAjax.js"></script>
<script type="text/javascript" src="Materials/PartsInterface.js"></script>
<script type="text/javascript" >
	var boxID='<%=boxID%>';
	var modalID='<%=modalID%>';
	
	function AddPart(PartID)	{	return false;}
</script>

<link rel="stylesheet" href="Library/CSS_DEFAULTS.css" media="screen">
<style>
html{overflow:auto; background:#eee; padding:0; margin:0; height:100%; width:100%;}
body{overflow:auto; padding:0; margin:0; height:100%; width:100%; min-width:768px; min-height:264px;}

#mfrModal{ display:none; background:rgba(32,32,32,.5); position:absolute; top:0; left:0; width:100%; height:100%; overflow-x:hidden; overflow-y:auto; z-index:310000;}
#mfrWindow { border-radius:7px; border:4px #0CC solid; background:#eff; margin: 6% 0 0 9%; width:384px; height:auto; text-align:center; vertical-align:middle; display:block !important;}

#modal { display:none; background:rgba(32,32,32,.5); position:absolute; top:0; left:0; width:100%; height:100%; overflow-x:hidden; overflow-y:auto; z-index:210000;}
#editWindow { display:none; border-radius:8px; overflow-x:hidden; overflow-y:auto; margin: 1.5% 0 0 3%; width:94%; height:88%; min-height:276px;}

#editTitle { display:block; background:#0dd; border-top-left-radius:8px; border-top-right-radius:8px; text-align:center; font-weight:bold; width:100%; height:24px;
	background:-moz-linear-gradient(center top , #0ff, #00f6f6 10%, #0ee 90%, #0dd); 
	background:-webkit-gradient(linear,0 0,0 100%, from(#0ff),color-stop(.1, #00f6f6),color-stop(.9, #0ee), to(#0dd)); 
}
#ewBody{width:100%; height:80%; float:left;
	background:-moz-linear-gradient(center top, #fff, #eee 50%, #ddd); 
	background:-webkit-gradient(linear,0 0,0 100%, from(#fff),color-stop(.5, #eee), to(#ddd)); 
}
#ewBottom{width:100%; height:32px; float:left; padding:0 5px 0 5px; border-bottom-right-radius:8px; border-bottom-left-radius:8px;
	background:-moz-linear-gradient(center top, #ddd, #ddd 50%, #aaa 95%, #111); 
	background:-webkit-gradient(linear,0 0,0 100%, from(#ddd),color-stop(.5, #ddd), color-stop(.95, #aaa), to(#111)); 
}
#ewBottom button{height:92%; margin:auto; padding:1px;}

.eField { float:left; height:20px; margin:8px 0 0 2%; font-family:Georgia, "Times New Roman", Times, serif;}
.eField select { font-family:Georgia, "Times New Roman", Times, serif;}
.eField input { font-family:Georgia, "Times New Roman", Times, serif;}
.eField textarea { font-family:Georgia, "Times New Roman", Times, serif;}
#ePN {font-family:Consolas, "Courier New", Courier, monospace; }
#eCost {font-family:Consolas, "Courier New", Courier, monospace; }

#HeadingDiv{width:100%; height:12%; max-height:64px; overflow:hidden;}
.Search{height:25px; padding:3px 0 0 0; margin:0; z-index:2100; }
.Label{float:left; padding:5px 4px 0 0; margin:0; font-family:Arial,Helvetica,sans-serif; font-size:11px; font-weight:bold; text-align:right; color:#FFF; z-index:2100; }
.SearchTxt{float:left; padding:0; margin:0 0 0 5px; font-family:Arial,Helvetica,sans-serif; font-size:13px; font-weight:bold; text-align:left; color:#000; z-index:2200; }
.SearchBtn{float:left; padding:0; margin:1px 0 0 6px; font-family:Arial,Helvetica,sans-serif; font-size:14px; font-weight:bold; text-align:center; color:#000; z-index:2200; }

#HeadItems{width:100%; height:10%; max-height:32px; top:0; left:0; float:left; overflow:hidden; white-space:nowrap; margin:0 0 0 1%; font-size:14px; font-weight:bold; text-align:left; color:#000; border:1px solid #000; display:none; }
	.HeadItem{ background:#dff; float:left; height:100%; overflow:hidden; white-space:nowrap; margin:0; padding:0; text-align:center; border-left:1px solid #2E4615; display:inline; }

#Results{overflow-x:hidden; height:75%; width:98%; background:none; float:left; padding:0; margin:0 0 0 1%; font-family: Arial,Helvetica,sans-serif; font-weight:normal; text-align:left; color:#000; border:none; z-index:2000; }
#Close{	position:relative; float:right; height:25px; margin:1px 0 0 12px; font-size:18px;}
#Close div{float:left;}


</style>
</head>

<body onLoad="Gebi('SearchPartsTxt').focus();" onmousemove="<%=mmEvent%>;" onselectstart="return false;" onResize="resize();">
  
  <div id=mfrModal>
    <div id=mfrWindow class=WindowBox>
    	<b class=fL><small>Manufacturer List</small></b>
      <div class="redXCircle" onClick="Gebi('mfrModal').style.display='none';">X</div>
      <br/>
      <hr/>
      <div class=fL>Add</div><hr/>
    	<br/>
			<label>Manufacturer Name:<input id=mfrName type="text" width="24"/></label>
      <button id=mfrSave onClick="saveMfr();">Save</button>
      <br/>
      <br/>
			<hr/>
      <div class=fL>Delete</div><hr/>
      <br/>
			<select id=dMfr>
        <option id=delMfr0>&nbsp;</option>
				<%
        MfrOptionList("dMfr")
        %>
      </select>
      <button id=mfrDel onClick="delMfr();">Delete</button>
      <br/>
    </div>
  </div>
  
  <div id=modal>  
    <div id=editWindow>
      <div id=editTitle>Edit Part</div>
      <div id=ewBody>
        &nbsp;<span id=eCNLabel style="font-size:14px; color:rgba(0,4,4,.5); height:100%; ">#</span>
        <span id=eCN style="font-size:14px; color:rgba(0,4,4,.5); height:100%; font-family:Consolas, 'Courier New', monospace;"></span>
        <br/>
        <div class=eField >
          <label>&nbsp; &nbsp;Manufacturer <select id=eMfr onChange="if(SelI(this.id).id=='eMfr0') newMfr();">
            <option id=eMfr-1>&nbsp;</option>
            <option id=eMfr0><b>+Edit Manufacturer List</b></option>
						<%
						MfrOptionList("eMfr")
            %>
          </select>*&nbsp; &nbsp;</label>
        </div>
        <div class="eField"><label>&nbsp; &nbsp;Name/Model <input type=text id=eName >&nbsp;&nbsp; &nbsp;</label></div>
        <div class="eField"><label>&nbsp; &nbsp;Part Number <input type=text id=ePN class=taR >*&nbsp; &nbsp;</label></div>
        <div class="eField"><label>&nbsp; &nbsp;Cost <span style="font:Consolas;">$</span><input type=text id=eCost onKeyPress="limitInput(event, '0123456789.');" >*&nbsp; &nbsp;</label>&nbsp; &nbsp;</div>
        <br/>
        <div class=eField style="width:95%;"><label>&nbsp; &nbsp; &nbsp; &nbsp;Description<br><textarea id=eDesc rows=2 style="width:100%;"></textarea></label></div>
      </div>
      <div id=ewBottom class="taC">
        <button id=ewDel onClick="delPart();" style="float:left;"><img src="../Images/delete16.PNG" align="absmiddle" />Delete</button>
        <button id=ewClear onClick="clearPart();" style="float:left;">Clear</button>
        <button id=ewSave onClick="savePart();" style="float:right;"><img src="../Images/save_16.png" align="absmiddle" /> Save</button>
        <button id=ewCancel onClick="cancelPart();" style="float:right;">Cancel</button>
      </div> 
    </div>
  </div>
    
  <div id="HeadingDiv" onselectstart="return false;">
    <div id="Search" class="Search">
      <label class=SearchTxt ><input id=SearchPartsTxt type=text size=24 maxlength=120 onKeyUp="Search('checkboxes');" />&nbsp;</label>
      <span id=searchBtns style="display:none;">
        <button onClick="SearchParts('Manufacturer');" id=SearchPartsManufBtn class=SearchBtn >&nbsp; Manufacturer &nbsp;</button>
        <button onClick="SearchParts('Model');" id=SearchPartsItemNumBtn class=SearchBtn >&nbsp; Model &nbsp;</button>
        <button onClick="SearchParts('PartNumber');" id=SearchPartsItemNumBtn class=SearchBtn >&nbsp; Part # &nbsp;</button>
        <button onClick="SearchParts('PartsID');" id=SearchPartsItemNumBtn class=SearchBtn >&nbsp; Catalog # &nbsp;</button>
        <button onClick="SearchParts('Description');" id=SearchPartsDescBtn class=SearchBtn >&nbsp;Description&nbsp;</button>
      </span>
      <span id=searchChks style="display:inline;">
        <label><input id=mfrChk type=checkbox checked />&nbsp;Manufacturer &nbsp;</label>
        <label><input id=modelChk type=checkbox checked />&nbsp;Model &nbsp;</label>
        <label><input id=PNChk type=checkbox checked />&nbsp;Part # &nbsp;</label>
        <label><input id=pIdChk type=checkbox checked />&nbsp;Catalog # &nbsp;</label>
        <label><input id=descChk type=checkbox />&nbsp;Description&nbsp;</label>
      </span>
      <div class=redXCircle style="display:inline;" onClick="PGebi('<%=boxID%>').style.display='none'; PGebi('<%=modalID%>').style.display='none';">X</div>
      <span class="ToolbarButton fR" style="height:24px; margin:0 32px 0 0;" onClick="newPart();">&nbsp;<img src="../Images/plus_16.png" align=absmiddle/>New Part&nbsp;</span>
    </div>
  </div>
  
  <%
	if modalID="" And BoxID="" Then AddOpacity=".3" Else AddOpacity="1"
	Session("AddOpacity")=AddOpacity
	%>        
  <div id=HeadItems>
    <div class="HeadItem" style="width:4%; border-left:none; font-weight:normal; font-size:12px; opacity:<%=AddOpacity%>; border-color:rgba(0,0,0,<%=AddOpacity%>);">Add</div>
    <div class="HeadItem " style="width:4%; font-weight:normal; font-size:12px; ">Edit</div>
    <div class="HeadItem " style="width:7%; font-weight:normal; font-size:12px; ">Catalog#</div>
    <div class="HeadItem " style="width:12%; ">Manufacturer</div>
    <div class="HeadItem " style="width:15%; ">PartNumber</div>
    <div class="HeadItem " style="width:10%; ">Model</div>
    <div class="HeadItem " style="width:38%; ">Description</div>
    <div class="HeadItem " style="width:10%; ">Cost</div>
    <div class="HeadItem " style="width:10%; height:110%; ">&nbsp;</div>
  </div>
  <iframe id="Results" class="borderSizing" src="PartSearch.asp">Parts</iframe>
	
</body>
</html>