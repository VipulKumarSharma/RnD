<%
/****************************************************************************************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author						:Manoj Chand
 *Date of Creation 				:23 Oct 2013
 *Copyright Notice 				:Copyright(C)2000 MIND.All rights reserved
 *Project	  					:STARS
 *Operating environment			:Tomcat 6.x, sql server 2008 
 *Description 					:this file is used to display session expired when error occured.
 ***********************************************************************************************************************************/
%>
<%@ page buffer="5kb" language="java"  import="java.sql.*,java.io.*,java.util.*,java.io.*" %>
<%
HttpSession hs = request.getSession(true);
hs.putValue("loginFailureCount", "0");
hs.putValue("invalidUserPass", "N");
%>
<html>
<head>
<%@ include  file="headerIncl.inc" %>
<%@ include  file="cacheInc.inc" %>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>WELCOME TO STARS:  SAMVARDHANA MOTHERSON TRAVEL  APPROVAL SYSTEM Version No:- 1.0 </title>
<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
</head>
<body>
<!-- <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="144" valign="top" background="images/header_bg.gif?buildstamp=2_0_0"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="11%" height="97"><img src="images/header_logo.gif?buildstamp=2_0_0" width="109" height="97" /></td>
        <td width="100%">&nbsp;</td>
        <td width="8%" valign="bottom"><img src="images/header_punc_line.gif?buildstamp=2_0_0" width="237" height="41" /></td>
      </tr>
      <tr>
        <td height="44" colspan="3">&nbsp;</td>
      </tr>
    </table></td>
  </tr>
</table> -->
<table width="100%" border="0" cellspacing="0" cellpadding="10">
   <tr>
       <td align="center" class="dataLabel">Session Expired, Please login again</td>
   </tr>
   <tr>
       <td align="center"><a href="index.jsp" target="_top"><img  src="images/formButton.gif?buildstamp=2_0_0" width="89" height="24" border="0" /><a></td>
   </tr>
  
</table>
</body>
</html>
