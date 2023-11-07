<br/>
<label> Print Settings
<select id=printPreset>
	<%
	ppSQL="SELECT ID,Name FROM ProposalPrint WHERE ProjID="&projId&" ORDER BY lastPrinted DESC, ID DESC"
	Set ppRS=server.CreateObject("AdoDB.recordSet")
	ppRS.Open ppSQL, REDConnString
	
	If ppRS.EOF Then
		ppId=sessionEmpID&loadStamp
		ppSQL="INSERT INTO ProposalPrint (Name,ProjID,creationKey) VALUES ('Default',"&projId&","&ppId&")"
		Set ppRS=server.CreateObject("AdoDB.recordSet")
		ppRS.Open ppSQL, REDConnString
		
		ppSQL="SELECT * FROM ProposalPrint ORDER BY lastPrinted DESC"
		Set ppRS=server.CreateObject("AdoDB.recordSet")
		ppRS.Open ppSQL, REDConnString
	End If
	
	Dim ppName(1024)
	Dim ppID(1024)
	ppCount=0
	Do Until ppRS.EOF
		ppCount=ppCount+1
		ppID(ppCount)	= ppRS("ID")
		ppName(ppCount) =	ppRS("Name")
		%><option id=printPreset<%=ppCount%> value="<%=ppID(ppCount)%>"><%=ppName(ppCount)%></option><%
		ppRS.MoveNext
	Loop
	%>
</select>
</label>
&nbsp; &nbsp;
<label> New Settings Preset:<input id=newPresetName /></label><button style="color:green;" onclick="addProposalPreset();">✔</button>
<%
	psIndex=1	%><script>var printSettingsID=<%=ppID(psIndex)%>;</script><%
	ppSQL="SELECT * FROM ProposalPrint WHERE ID="&ppId(psIndex)&" ORDER BY lastPrinted DESC"
	%><div style="display:none;"><%=ppSQL%></div><%
	Set ppRS=server.CreateObject("AdoDB.recordSet")
	ppRS.Open ppSQL, REDConnString
	
	psEditLink="<a class=""editLink"" style=""z-index:10000;"" onclick=""ePrintField(this.parentNode);"" >Edit</a>"
	psCurrencyLink="<a class=""editLink"" onclick=""ePrintCurrency(this.parentNode);"" >Edit</a>"
	psDateLink="<a class=""editLink"" onclick=""datePrintField(this.parentNode)"" >Edit</a>"
	psNotesLink="<a class=editLink onClick=ePrintNotes(this.parentNode);>Edit</a>"
	
%>
<script>clearTimeout(crashBang);</script>
<br/>
<div id=PrintBidToTitle class=ProjInfoTitle>Print</div>
<div id=PrintBidTo class=ProjInfo height=202px style="height:auto; margin-top:0;">
	<div class=ProjInfoHeading>
		<div class="fL taC w33p">Letterhead</div>
		<div class="fL taC w33p">
			<button class="tButton24 fR mT0" onclick=showNewSec(); title="Add a Section"><img src="../images/plus_16.PNG"></button>
			Sections
		</div>
		<div class="fL taC w33p">
			<button class="tButton24 fR mT0" onclick=showAddCust(); title="Add a Customer"><img src="../images/plus_16.PNG"></button>
			Customers
</div>
	</div>
	
	<div class="fieldColumn w33p" style="height:218px; overflow-x:hidden; overflow-y:auto;">
		<%
		lhId=ppRS("pLHeadID")
		If isNull(lhId) Then
			Set updateLH=Server.CreateObject("AdoDB.RecordSet")
			updateLH.Open "UPDATE ProposalPrint SET pLHeadID=6 WHERE projId="&projID, REDConnString
			Set updateLH=Nothing
			lhId=6
		End If
		lhId=CInt(lhId)
		
		lhSQL="SELECT HeaderID, HeaderName, Image FROM LetterHeads"
		Set lhRS=Server.createObject("Adodb.Recordset")
		lhRS.open lhSQL, REDConnstring

		Do Until lhRS.eof
			thisLhId=CInt(lhRS("HeaderID"))
			If lhId=thisLhId Then checked=" checked " Else checked=""
			onClick="var l=getElementsByClassName('lhCheck');  for(c=0;c<l.length;c++){ l[c].checked=false; } printLH(this,"&lhRS("HeaderID")&","&ppId(psIndex)&");"
			%>
			<label class="lhItem fieldDiv"><img class="lhImg o50 w100p" src="../Images/<%=lhRS("Image")%>" />
				<div align="center" class="lhName"><%=DecodeChars(lhRS("HeaderName"))%></div><input id=lh<%=lhRS("HeaderID")%> class=lhCheck type=checkbox onClick="<%=onClick%>" <%=checked%> />
			</label>
			<%
			lhRS.moveNext
		Loop
		Set lhRS=Nothing
		%>
	</div>
	
	<div class="fieldColumn w33p" style="height:218px; overflow-x:hidden; overflow-y:auto;">
		<%
		secSQL="SELECT Section, SectionID FROM Sections WHERE ProjectID="&ProjID
		Set secRS=Server.createObject("Adodb.Recordset")
		secRS.open secSQL, REDConnstring

		Do Until secRS.eof
			secPrintSQL="SELECT * FROM ProposalPrintSections WHERE DetailID="&secRS("SectionID")
			%><script>console.log('<%=secPrintSQL%>');</script><%
			Set secPrintRS=Server.createObject("Adodb.Recordset")
			secPrintRS.Open secPrintSQL, REDConnString
			If secPrintRS.EOF Then checked="" Else checked=" checked "
			%>
			<label class="fieldDiv"><input id=printSec<%=secRS("SectionID")%> style="float:left; margin:2px 4px 0 0;" type=checkbox onChange="printSec(this.checked,<%=ppId(psIndex)%>,<%=secRS("SectionID")%>)" <%=checked%> /><span><%=DecodeChars(secRS("Section"))%></span></label>
			<%
			secRS.moveNext
		Loop
		Set secRS=Nothing
		%>
	</div>
	
	<div class="fieldColumn w33p" style="height:218px; overflow-x:hidden; overflow-y:auto;">
		<%
		custSQL="SELECT BidToID, CustID, CustName, noPrint FROM BidTo WHERE ProjID="&ProjID
		Set custRS=Server.createObject("Adodb.Recordset")
		custRS.open custSQL, REDConnstring

		Do Until custRS.eof
			
			If custRS("noPrint")="True" Then checked="" Else checked=" checked "
			%>
			<label class="fieldDiv"><input id=printCust<%=custRS("CustID")%> class=custCheck type=checkbox <%=checked%> onClick="printCust(this.checked,<%=custRS("BidToID")%>)" /><span><%=DecodeChars(custRS("CustName"))%></span></label>
			<%
			custRS.moveNext
		Loop
		Set custRS=Nothing

		If newCustStyle<>"" Then
		%>&nbsp;<small>At least 1 customer is required to print a bid.</small><%
	End If

		%>
	</div>
	
</div>

<div style="float:left; width:100%; height:24px;"></div>
<div style="float:left; width:87.5%; margin-left:5%;" align=center>
	<button style="font-size:24px; height:64px; width:75%;" onClick="Print();">Print</button>
</div>

<div id=PrintBidToTitle class=ProjInfoTitle>Details disclosed</div>
<div id=PrintDetails class=ProjInfo height=154px style="height:154px;">
	<div class=ProjInfoHeading>
		<div class="fL taC w33p"></div>
		<div class="fL taC w33p"></div>
		<div class="fL taC w33p"></div>
	</div>
	<div class="fieldColumn w33p" style="height:120px; overflow-x:hidden; overflow-y:auto;">
		<% If pprs("pSecTotals")="True" then checked="checked" Else checked="" %>
		<label class="fieldDiv"><input class=pdCheck <%=checked%> type=checkbox onChange="WSQLUBit('ProposalPrint','pSecTotals',this.checked,'ProjID',projId);" /><span>Section Totals</span>
		</label>
		<% If pprs("pSubT")="True" then checked="checked" Else checked="" %>
		<label class="fieldDiv"><input class=pdCheck <%=checked%> type=checkbox onChange="WSQLUBit('ProposalPrint','pSubT',this.checked,'ProjID',projId);" /><span>Subtotal</span>
		</label>
		<% If pprs("pTax")="True" then checked="checked" Else checked="" %>
		<label class="fieldDiv"><input class=pdCheck <%=checked%> type=checkbox onChange="WSQLUBit('ProposalPrint','pTax',this.checked,'ProjID',projId);" /><span>Tax</span>
		</label>
		<% If pprs("pTotal")="True" then checked="checked" Else checked="" %>
		<label class="fieldDiv"><input class=pdCheck <%=checked%> type=checkbox onChange="WSQLUBit('ProposalPrint','pTotal',this.checked,'ProjID',projId);" /><span>Total</span>
		</label>
	</div>
	
	<div class="fieldColumn w33p" style="height:120px; overflow-x:hidden; overflow-y:auto;">
		<% If pprs("pLetter")="True" then checked="checked" Else checked="" %>
		<label class="fieldDiv"><input class=pdCheck <%=checked%> type=checkbox onChange="WSQLUBit('ProposalPrint','pLetter',this.checked,'ProjID',projId);" /><span>Letter</span>
		</label>
		<% If pprs("pScope")="True" then checked="checked" Else checked="" %>
		<label class="fieldDiv"><input class=pdCheck <%=checked%> type=checkbox onChange="WSQLUBit('ProposalPrint','pScope',this.checked,'ProjID',projId);" /><span>Scope of work</span>
		</label>
		<% If pprs("pInc")="True" then checked="checked" Else checked="" %>
		<label class="fieldDiv"><input class=pdCheck <%=checked%> type=checkbox onChange="WSQLUBit('ProposalPrint','pInc',this.checked,'ProjID',projId);" /><span>Includes</span>
		</label>
		<% If pprs("pExc")="True" then checked="checked" Else checked="" %>
		<label class="fieldDiv"><input class=pdCheck <%=checked%> type=checkbox onChange="WSQLUBit('ProposalPrint','pExc',this.checked,'ProjID',projId);" /><span>Excludes</span>
		</label>
	</div>
	
	<div class="fieldColumn w33p" style="height:120px; overflow-x:hidden; overflow-y:auto;">
		<% style="style=""margin-left:12px;""" %>
		<% If pprs("pParts")="True" then checked="checked" Else checked="" %>
		<label class="fieldDiv"><input class=pdCheck <%=checked%> type=checkbox onChange="WSQLUBit('ProposalPrint','pParts',this.checked,'ProjID',projId);" /><span>Show Itemized Materials <small>(Parts List)</small></span>
		</label>
		
		
		<% If pprs("pPartsPrice")="True" then checked="checked" Else checked="" %>
		<% If useNewBidder then checked=" disabled"%>
		<label class="fieldDiv" style="width:50%;"><input class=pdCheck <%=checked%> type=checkbox onChange="WSQLUBit('ProposalPrint','pPartsPrice',this.checked,'ProjID',projId);" <%=style%> /><span>Parts Pricing</span></label>
		
		<% If pprs("pPartsTotal")="True" then checked="checked" Else checked="" %>
		<% If useNewBidder then checked=" disabled"%>
		<label class="fieldDiv" style="width:50%;"><input class=pdCheck <%=checked%> type=checkbox onChange="WSQLUBit('ProposalPrint','pPartsTotal',this.checked,'ProjID',projId);" <%=style%> /><span>Parts Total</span></label>
		
		<% If pprs("pLabor")="True" then checked="checked" Else checked="" %>
		<label class="fieldDiv"><input class=pdCheck <%=checked%> type=checkbox onChange="WSQLUBit('ProposalPrint','pLabor',this.checked,'ProjID',projId);" /><span>Show Itemized Labor <small>(Labor List)</small></span></label>
		
		<% If pprs("pLaborPrice")="True" then checked="checked" Else checked="" %>
		<% If useNewBidder then checked=" disabled"%>
		<label class="fieldDiv" style="width:50%;"><input class=pdCheck <%=checked%> type=checkbox onChange="WSQLUBit('ProposalPrint','pLaborPrice',this.checked,'ProjID',projId);" <%=style%> /><span>Labor Pricing</span></label>
		
		<% If pprs("pLaborTotal")="True" then checked="checked" Else checked="" %>
		<% If useNewBidder then checked=" disabled"%>
		<label class="fieldDiv" style="width:50%;"><input class=pdCheck <%=checked%> type=checkbox onChange="WSQLUBit('ProposalPrint','pLaborTotal',this.checked,'ProjID',projId);" <%=style%> /><span>Labor Total</span></label>
		
	</div>
</div>

<br/>

<div id=ProjProposalTitle class="ProjInfoTitle">
	<div style=float:left;>Proposal</div>
	<div id=ProjectTotal class=total style="font-size:32px; float:right; line-height:20px; margin-right:8px;"></div>
</div>
<div id=ProjProposal class=ProjInfo height=330px style="height:330px;" >
	<!--
	<div class=ProjInfoHeading>
		<div class="fL taC w33p">Headings</div>
		<div class="fL taC w33p">Customer Addressings</div>
		<div class="fL taC w33p">Customer Signed-By's</div>
	</div>
	-->
	<div class="labelColumn w25p">
		<label>Letter Title</label>
		<label>Date</label>
		<label>Scope Title</label>
	</div>
	<div class="fieldColumn w25p">
		<div class=fieldDiv id=pLetterTitle><%=psEditLink&pprs("pLetterTitle")%></div>
		<div class=fieldDiv id=pPrintDate><%=psDateLink&pprs("pPrintDate")%></div>
		<div class=fieldDiv id=pScopeTitle><%=psEditLink&pprs("pScopeTitle")%></div>
	</div>
	<div class="labelColumn w25p">
		<label>Addressing</label>
		<label>Signed By Tricom</label>
		<label>Signed By Customer</label>
	</div>
	<div class="fieldColumn w25p">
		<div class=fieldDiv id=pAddressing><%=psEditLink&pprs("pAddressing")%></div>
		<div class=fieldDiv id=pSignedTCS><%=psEditLink&pprs("pSignedTCS")%></div>
		<div class=fieldDiv id=pSignedCust><%=psEditLink&pprs("pSignedCust")%></div>
	</div>

	<div class=ProjInfoHeading>
		<div class="fL taC w100p">Proposal Letter</div>
	</div>
	<div class="fieldColumn w100p">
		<div class=fieldDiv id=pBody style="height:96px; line-height:14px; white-space:normal;"><%=psNotesLink&DecodeChars(pprs("pBody"))%></div>
	</div>

	<div class=ProjInfoHeading>
		<div class="fL taC w100p">Legal Notes</div>
	</div>
	<div class="fieldColumn w100p">
		<div class="fieldDiv" id=pLegalNotes style="height:64px; line-height:14px; white-space:normal;">
			<%=psNotesLink&DecodeChars(pprs("pLegalNotes"))%>
		</div>
	</div>

	<div class=ProjInfoHeading>
		<div class="fL taC w100p">Address Footer</div>
	</div>
	<div class="fieldColumn w100p">
		<div class="fieldDiv" id=AddressFooter style="height:24px; line-height:14px; white-space:normal;">
			<%=psNotesLink&DecodeChars(pprs("AddressFooter"))%>
		</div>
	</div>

</div>
<div style="float:left; width:100%; height:16px;"></div>
<% Set ppRS=Nothing %>
<script>var i1=1;</script>