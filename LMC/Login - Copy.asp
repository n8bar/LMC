<!DOCTYPE HTML>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<meta http-equiv="X-UA-Compatible" content="chrome=1">

<script type="text/javascript" src="LoginAJAX.js"></script>
<script type="text/javascript" src="rcstri.js"></script>
 
<style>
	table,tr,td,form,font,label,input,div,a,b,i { -webkit-box-sizing:border-box; -moz-box-sizing:border-box; box-sizing:border-box; }
	html { margin:0; padding:0; width:100%; height:100%; overflow:hidden;
		background: -moz-linear-gradient( 90deg bottom left, rgba(213,226,234,0) 0, rgba(213,226,234,.875) 5%, rgba(213,226,234,1) 10%, rgba(213,226,234,1) 90%, rgba(213,226,234,.875) 95%, rgba(213,226,234,0) 100% );
		background: -webkit-gradient( linear,0 100%,0 0, from(rgba(213,226,234,0)), color-stop(.05, rgba(213,226,234,.875)), color-stop(.1, rgba(213,226,234,1)), color-stop(.9, rgba(213,226,234,1)), color-stop(.95, rgba(213,226,234,.875)), to(rgba(213,226,234,0)) );
	}
	body { margin:0; padding:0; width:100%; height:100%; overflow:hidden; color:#046; /* background-image:url(Logos/TMCTriangle.gif); background-size:cover; */ }
	
	.text{outline:none; border-radius:6px; border:inset 1px; background-color:rgba(255,255,255,.75); margin:2px; padding:2px;}
	strong{text-shadow:#fff 0px 0px 1px, #fff 0px 0px 2px, #fff 0px 0px 3px, #fff 0px 0px 5px, #fff 0px 0px 10px, #fff 0px 0px 20px, #fff 0px 0px 40px;}
	#caseSensitive{text-shadow:#fff 0px 0px 1px, #fff 0px 0px 2px, #fff 0px 0px 3px, #fff 0px 0px 5px, #fff 0px 0px 10px, #fff 0px 0px 20px, #fff 0px 0px 40px;}
	.tmc{
			font-family:Nyala, Arial, Geneva, sans-serif; font-size:64px; font-style:italic; font-weight:bold; text-align:center;
			text-shadow:#fff 0 0 40px, #fff 0 0 36px, #fff 0 0 32px, #fff 0 0 28px, #fff 0 0 24px, #fff 0 0 20px, #fff 0 0 16px, #fff 0 0 12px, #fff 0 0 8px, #fff 0 0 4px;
	}	
	.mobile{display:block; float:right; text-decoration:none; padding:3px; font-weight:bold; color:#004; text-align:center; }
</style>

 
</head>
 
<body onLoad="document.getElementById('user').focus();" >
<table width="100%" height="95%"border="0" cellpadding="0" cellspacing="0" >
	<tr height="64" >
		<td class=tmc> Tricom Management Center</td>
	</tr>
	<tr> 
		<td width="100%" height="100%" align="center" valign="middle"> 
			<table width="648" height="500" border="0" cellpadding="0" cellspacing="0" >
				<tr>
					<td width="648" height="500" align="center" valign="m" style="background-image:url(Logos/TMCTriangle.gif); background-size:cover;"> 
						<form action="javascript:Login();" method=post >
							<label>
								<font color="#0000FF" size=2 face="Verdana, Arial, Helvetica, sans-serif" style="margin-left:3px;" ><strong>Username:</strong></font>
								<input class=text type=text id=user size=16 />
							</label>
							<br/>
							<label>
								<font color="#0000FF" size="2" face="Verdana, Arial, Helvetica, sans-serif">
									<strong>
										&nbsp;Password:
										<input class=text type=password id=pass size=16 onFocus="//Gebi('caseSensitive').innerHTML='Case Sensitive!';" onBlur="Gebi('caseSensitive').innerHTML='&nbsp;';" />
									</strong>
									<div id=caseSensitive style="color:#D00;" >&nbsp;</div>
								</font>
							</label>
							<table width="222" border="0" cellspacing="0" cellpadding="0">
								<tr> 
									<td width="78" height="26">
										<input type="reset" name="Cancel" value="Clear">
									</td>
									<td width="66"></td>
									<td width="78">
										<input type="submit" name="Login" value="Login"/>
									</td>
								</tr>
							</table> 
						</form>
					</td>  
				</tr>
				<tr height="24" ></tr>
				<tr height="24" >
					<td ><button class="mobile" onclick="window.top.location='../m';">TMC Mobile</button></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<script type="text/javascript">Validate();</script>
</body>
</html>

