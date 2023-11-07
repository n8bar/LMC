<%
REDconnstring = "DRIVER={SQL Server};SERVER=tmc.tricom;UID=rcstricom;PWD=watf-771;DATABASE=Tribase"
PDconn = "DRIVER={SQL Server};SERVER=whsql-v03.prod.mesa1.secureserver.net;UID=tricomelstore;PWD=watf-771;DATABASE=DB_16816"


Function DecodeChars(TheString)
	dim OldString : OldString=""
	If Not ((IsNull(TheString)) OR TheString="") Then
		while(OldString<>TheString)
			OldString=TheString
			TheString=Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(TheString,"--RET--",chr(13)),"-COMMA-",","),"-AMPERSAND-","&"),"-QUOTE-",""""),"-APOSTROPHE-","'"),"-LESSTHAN-","<"),"-GREATERTHAN-",">"),"-PERCENT-","%"),"-POUND-","#")
			TheString=Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(TheString,"_CR_",chr(13)),"_CO_",","),"_AM_","&"),"_QU_",""""),"_AP_","'"),"_LT_","<"),"_GT_",">"),"_PE_","%"),"_PO_","#"),"_PL_","+"),"_DE_","°")
		wend
	End If
	DecodeChars=TheString
End Function

Function EncodeChars(TheString)
	dim OldString : OldString=""
	If Not IsNull(TheString) Then
		while(OldString<>TheString)
			OldString=TheString
			TheString=Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(TheString,chr(13),"_CR_"),",","_CO_"),"&","_AM_"),chr(34),"_QU_"),"'","_AP_"),"<","_LT_"),">","_GT_"),"%","_PE_"),"#","_PO_"),"+","_PL_"),"°","_DE_")
		wend
	End If
	EncodeChars=TheString
End Function

Function CR2Br(S) 
	br="<br/>"
	oldS=""
	While S<>oldS
		oldS=S
		S=Replace(S,chr(13), br)
		S=Replace(S,"--RET--", br)
		S=Replace(S,"_CR_", br)
	WEnd	
	
	CR2Br=S
End Function

function Br2CR(S)
	oldS=""
	While S<>oldS
		oldS=S
		S=S.replace("<br>",chr(13))
		S=S.replace("<br/>",chr(13))
		S=S.replace("<bR>",chr(13))
		S=S.replace("<bR/>",chr(13))
		S=S.replace("<Br>",chr(13))
		S=S.replace("<Br/>",chr(13))
		S=S.replace("<BR>",chr(13))
		S=S.replace("<BR/>",chr(13))
	Wend
	Br2CR = S
End Function



Function UnCurrency(str) 
	str=DecodeChars(str)
	str=replace(str,"$","")
	str=replace(str,"%","")
	While str<>replace(str,",","")
		str=replace(str,",","")
	Wend
	UnCurrency=str
End Function

Function MonthDays(mon,yr)
	mDays= Array(0,31,28,31,30,31,30,31,31,30,31,30,31)
	days=mDays(mon)
	If days=28 AND yr MOD 4 =0 Then 
		If (yr Mod 100=0) AND (yr Mod 400 <>0) Then days=28 Else days=29
	End If
	MonthDays=days
End Function


Function Phone(i)
	If IsNull(i) Then 
		Phone=0
		Exit Function
	End If
	
	str=CStr(i)
	
	If len(str) > 4 Then str=left(str,len(str)-4)&"-"&right(str,4)
	If len(str) > 8 Then
		str=left(str,len(str)-8)&")"&right(str,8)
		If len(str) > 12 Then
			str=left(str,len(str)-12)&"("&right(str,12)
		Else
			str="("&str
		End If
	End If
	
	Phone=str
End Function



Sub LoginCheck()
	If Session("EmpId")="" Then
		%>
		<script type="text/javascript" src=RedAJAX.js></script>
		<script type="text/javascript">LoginCheck();</script>
		<%
		start=Timer
		Do while Session("EmpID")=""
			If Timer>start+45 Then
				%><script type="text/javascript">alert('Your Login has Expired.');</script><%
				Response.Redirect("tmc.html")
				Response.End()
			End If
		Loop
	End If
	
End Sub

Function newCreationKey()
	DateStr=Date
	timeStr=Time
	tmr=timer
	If (Instr(tmr,".") or Instr(".",tmr) ) Then mSec=split(tmr,".")(1) Else mSec=0
	Hr=split(timeStr,":")(0)
	Min=split(timeStr,":")(1)
	Sec=split(split(timeStr,":")(2)," ")(0)
	if split(timeStr," ")(1)="PM" and Hr<12 Then Hr=Hr+12
	timeStr=Hr&Min&mSec
	NowStr=Replace(DateStr,"/","")&TimeStr	
	newCreationKey=Session.SessionID&nowStr
End Function


'session.Timeout=90
%>