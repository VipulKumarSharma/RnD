<%
/***************************************************
**** The information contained here in is confidential and ******
**** proprietary to MIND and forms the part of the MIND ****** 
*Author			  :Deepali Dhar
*Date of Creation : 04 June 2004

**** Copyright Notice :Copyright(C)2000 MIND.All rights reserved. ******
**** Project	  : SERS ****** 
**** Operating environment :Tomcat, sql server 2000 ******
**** Description : This is first jsp file  for listing all the  USERS on search basis from the SERS database ******
**** Modification : ******
**** Reason of Modification : ******
**** Date of Modification   : ******
**** Revision History		: none******
**** Editor					:Editplus ******

*Modified By			: Manoj Chand
*Date of Modification	: 16 Apr 2012
*Modification			: Change the rows percentage of frames windows 
**********************************************************/
%>

<%@ include  file="importStatement.jsp" %>
<html>
<head>
<%-- include remove cache  --%>
<%@ include  file="cacheInc.inc" %>
<%-- include header  --%>
<%@ include  file="headerIncl.inc" %>
<%-- include page with all application session variables --%>
<%@ include  file="application.jsp" %>
<%-- include page styles  --%>
<%@ include  file="systemStyle.jsp" %>
<script language=JavaScript >
</script>
<html>
<head>
<title>List</title>
<!-- <base target="_top">
 --></head>
  <frameset framespacing="0" border="0" rows="12.5%,78%" frameborder="0">
 	<frame name="ListHeader" scrolling="yes"  target="ListBody" src="M_searchHead.jsp?" marginheight="0">
	<frame name="ListBody"  src="M_searchList.jsp?" scrolling="yes"  marginheight="0" >
  <noframes>
  <body><script type="text/javascript" language="JavaScript1.2" src="menu/menu_cnt.js?buildstamp=2_0_0"></script>
  <p>This page uses frames, but your browser doesn't support them.</p>
  </body>
  </noframes>
</frameset>
</html>
</SCRIPT>
