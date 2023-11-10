<div id=PrintBidToTitle class=ProjInfoTitle>Print</div>
<div id=PrintBidTo class=ProjInfo height=202px style="height:auto; margin-top:0;">
	<div class=ProjInfoHeading>
		<div class="fL taC w33p">Letterhead</div>
		<div class="fL taC w33p">
			<button class="tButton24 fR mT0" onclick=showNewSys(); title="Add a System"><img src="../../LMCManagement/images/plus_16.PNG"></button>
			Systems
		</div>
		<div class="fL taC w33p">
			<button class="tButton24 fR mT0" onclick=showAddCust(); title="Add a Customer"><img src="../../LMCManagement/images/plus_16.PNG"></button>
			Customers
</div>
	</div>
	
	<div class="fieldColumn w33p" style="height:218px; overflow-x:hidden; overflow-y:auto;">
		<%
		lhId=rs("pLHeadID")
		If isNull(lhId) Then
			Set updateLH=Server.CreateObject("AdoDB.RecordSet")
			updateLH.Open "UPDATE Projects SET pLHeadID=6 WHERE projId="&projID, REDConnString
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
			onClick="var l=getElementsByClassName('lhCheck');  for(c=0;c<l.length;c++){ l[c].checked=false; } printLH(this,"&lhRS("HeaderID")&");"
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
		%>
	</div>
	
	<div class="fieldColumn w33p" style="height:218px; overflow-x:hidden; overflow-y:auto;">
		<%
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
		<% If rs("pSubT")="True" then checked="checked" Else checked="" %>
		<label class="fieldDiv"><input class=pdCheck <%=checked%> type=checkbox onChange="WSQLUBit('Projects','pSubT',this.checked,'ProjID',projId);" /><span>Subtotal</span>
		</label>
		<% If rs("pTax")="True" then checked="checked" Else checked="" %>
		<label class="fieldDiv"><input class=pdCheck <%=checked%> type=checkbox onChange="WSQLUBit('Projects','pTax',this.checked,'ProjID',projId);" /><span>Tax</span>
		</label>
		<% If rs("pTotal")="True" then checked="checked" Else checked="" %>
		<label class="fieldDiv"><input class=pdCheck <%=checked%> type=checkbox onChange="WSQLUBit('Projects','pTotal',this.checked,'ProjID',projId);" /><span>Total</span>
		</label>
	</div>
	
	<div class="fieldColumn w33p" style="height:120px; overflow-x:hidden; overflow-y:auto;">
		<% If rs("pLetter")="True" then checked="checked" Else checked="" %>
		<label class="fieldDiv"><input class=pdCheck <%=checked%> type=checkbox onChange="WSQLUBit('Projects','pLetter',this.checked,'ProjID',projId);" /><span>Letter</span>
		</label>
		<% If rs("pScope")="True" then checked="checked" Else checked="" %>
		<label class="fieldDiv"><input class=pdCheck <%=checked%> type=checkbox onChange="WSQLUBit('Projects','pScope',this.checked,'ProjID',projId);" /><span>Scope of work</span>
		</label>
		<% If rs("pInc")="True" then checked="checked" Else checked="" %>
		<label class="fieldDiv"><input class=pdCheck <%=checked%> type=checkbox onChange="WSQLUBit('Projects','pInc',this.checked,'ProjID',projId);" /><span>Includes</span>
		</label>
		<% If rs("pExc")="True" then checked="checked" Else checked="" %>
		<label class="fieldDiv"><input class=pdCheck <%=checked%> type=checkbox onChange="WSQLUBit('Projects','pExc',this.checked,'ProjID',projId);" /><span>Excludes</span>
		</label>
	</div>
	
	<div class="fieldColumn w33p" style="height:120px; overflow-x:hidden; overflow-y:auto;">
		<% style="style=""margin-left:12px;""" %>
		<% If rs("pParts")="True" then checked="checked" Else checked="" %>
		<label class="fieldDiv"><input class=pdCheck <%=checked%> type=checkbox onChange="WSQLUBit('Projects','pParts',this.checked,'ProjID',projId);" /><span>Show Itemized Materials <small>(Parts List)</small></span>
		</label>
		
		
		<% If rs("pPartsPrice")="True" then checked="checked" Else checked="" %>
		<% If useNewBidder then checked=" disabled"%>
		<label class="fieldDiv" style="width:50%;"><input class=pdCheck <%=checked%> type=checkbox onChange="WSQLUBit('Projects','pPartsPrice',this.checked,'ProjID',projId);" <%=style%> /><span>Parts Pricing</span></label>
		
		<% If rs("pPartsTotal")="True" then checked="checked" Else checked="" %>
		<% If useNewBidder then checked=" disabled"%>
		<label class="fieldDiv" style="width:50%;"><input class=pdCheck <%=checked%> type=checkbox onChange="WSQLUBit('Projects','pPartsTotal',this.checked,'ProjID',projId);" <%=style%> /><span>Parts Total</span></label>
		
		<% If rs("pLabor")="True" then checked="checked" Else checked="" %>
		<label class="fieldDiv"><input class=pdCheck <%=checked%> type=checkbox onChange="WSQLUBit('Projects','pLabor',this.checked,'ProjID',projId);" /><span>Show Itemized Labor <small>(Labor List)</small></span></label>
		
		<% If rs("pLaborPrice")="True" then checked="checked" Else checked="" %>
		<% If useNewBidder then checked=" disabled"%>
		<label class="fieldDiv" style="width:50%;"><input class=pdCheck <%=checked%> type=checkbox onChange="WSQLUBit('Projects','pLaborPrice',this.checked,'ProjID',projId);" <%=style%> /><span>Labor Pricing</span></label>
		
		<% If rs("pLaborTotal")="True" then checked="checked" Else checked="" %>
		<% If useNewBidder then checked=" disabled"%>
		<label class="fieldDiv" style="width:50%;"><input class=pdCheck <%=checked%> type=checkbox onChange="WSQLUBit('Projects','pLaborTotal',this.checked,'ProjID',projId);" <%=style%> /><span>Labor Total</span></label>
		
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
		<div class=fieldDiv id=pLetterTitle><%=editLink&rs("pLetterTitle")%></div>
		<div class=fieldDiv id=pPrintDate><%=dateLink&rs("pPrintDate")%></div>
		<div class=fieldDiv id=pScopeTitle><%=editLink&rs("pScopeTitle")%></div>
	</div>
	<div class="labelColumn w25p">
		<label>Addressing</label>
		<label>Signed By Tricom</label>
		<label>Signed By Customer</label>
	</div>
	<div class="fieldColumn w25p">
		<div class=fieldDiv id=pAddressing><%=editLink&rs("pAddressing")%></div>
		<div class=fieldDiv id=pSignedTCS><%=editLink&rs("pSignedTCS")%></div>
		<div class=fieldDiv id=pSignedCust><%=editLink&rs("pSignedCust")%></div>
	</div>

	<div class=ProjInfoHeading>
		<div class="fL taC w100p">Proposal Letter</div>
	</div>
	<div class="fieldColumn w100p">
		<div class=fieldDiv id=pBody style="height:96px; line-height:14px; white-space:normal;"><%=notesLink&DecodeChars(rs("pBody"))%></div>
	</div>

	<div class=ProjInfoHeading>
		<div class="fL taC w100p">Legal Notes</div>
	</div>
	<div class="fieldColumn w100p">
		<div class="fieldDiv" id=pLegalNotes style="height:64px; line-height:14px; white-space:normal;">
			<%=notesLink&DecodeChars(rs("pLegalNotes"))%>
		</div>
	</div>

	<div class=ProjInfoHeading>
		<div class="fL taC w100p">Address Footer</div>
	</div>
	<div class="fieldColumn w100p">
		<div class="fieldDiv" id=AddressFooter style="height:24px; line-height:14px; white-space:normal;">
			<%=notesLink&DecodeChars(rs("pAddressFooter"))%>
		</div>
	</div>

</div>
<div style="float:left; width:100%; height:16px;"></div>
