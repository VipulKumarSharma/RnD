<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:Manoj Chand
 *Date of Creation 		:04 July 2012
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STARS
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This is the  jsp file  for refreshing labels.
 *******************************************************/
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
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
<jsp:useBean id="roleBean" scope="page" class="src.connection.Roles_Resource"/>
<style type="text/css">
.solid-green{
	background:#638da3;
	color:#FFFFFF;
	font-weight:bold;
	padding:4px;
	text-align:center;
	width:102%;
	}
</style>

</head>
<body scroll="no">
<br>
<div id="refreshAlert" align="center" class="solid-green" style="visibility: hidden">Labels Refreshed</div>
<script>
<%
String strFlag = request.getParameter("flag")==null?"":request.getParameter("flag");
if(strFlag.equalsIgnoreCase("l"))
	dbLabelBean.getUpdatedLabels();
else if(strFlag.equalsIgnoreCase("r"))
	roleBean.getUpdatedRoles();
else{
	dbLabelBean.getUpdatedLabels();
	roleBean.getUpdatedRoles();
}
%>
document.getElementById("refreshAlert").style.visibility='visible';
</script>
</body>
</html>