<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author								:Shiv Sharma 
 *Date of Creation 				:26-Feb-08
 *Copyright Notice 				: Copyright(C)2000 MIND.All rights reserved
 *Project	  							: STARS
 *Operating environment		:Tomcat, sql server 2000 
 *Description 						:This page is used for get the password when the user forget his/her password
 *Modification 						:
 *Reason of Modification		: 
 *Date of Modification			:
 *Modified By						:
 *Editor								:Editplus
 *******************************************************/
%>

<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />

<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<script language="JavaScript" src="scripts/CommonValida.js?buildstamp=2_0_0"></script>
<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />


<%-- include remove cache  --%>
<%@ include  file="cacheInc.inc" %>
<%-- include header  --%>
<%@ include  file="headerIncl.inc" %>
<%-- include page with all application session variables --%>
<%@ include  file="application.jsp" %>
<%-- include page styles  --%>
<%@ include  file="systemStyle.jsp" %>
<link rel="stylesheet" href="styles/fonts.css?buildstamp=2_0_0" type="text/css">
<link rel="stylesheet" href="styles/links.css?buildstamp=2_0_0" type="text/css">
</head>
<%
ResultSet rs			=	null;			  // Object for ResultSet
String sSqlStr			=	"";				// For sql Statements
String strMailId		=	"";				//For holding Purchase Requisition Id

String  strEmail =request.getParameter("uEmail");


String  strSql="";

strSql ="SELECT  MAIL_MSG FROM  REQ_MAILBOX WHERE     (RECEIPENT_TO = '"+strEmail+"')  AND (REQ_NUMBER = 'reset password') AND (MAIL_CREATED_DATE =  (SELECT     MAX(MAIL_CREATED_DATE)  FROM   REQ_MAILBOX   WHERE      (RECEIPENT_TO = '"+strEmail+"') AND (REQ_NUMBER = 'reset password')))"; 

//System.out.println("strSql==============="+strSql);

 

rs = dbConBean.executeQuery(strSql);
%>
<body class="body">
<br>
<table width="100%" align="center" cellspacing="0" border=0 cellpadding="2" class="table">
<tr class="listhead"> 
<td class="colorPink" align=left>Mail Details</td>
<td class="colorPink" align=right><a href="#" onClick="window.print();">PRINT</a>&nbsp;|&nbsp;<a href="#" onClick="window.close();">CLOSE</a></td>
</tr>
<%
if(rs.next())
{
%>
<tr class="listhead"><td width="10%" class="listhead" colspan=2><%=rs.getString(1)%></td></tr>
	
<%
}else
{
	%>
<tr class="listhead"><td width="10%" class="listhead" colspan=2>No Record Found </td></tr>
		<%
}

rs.close();
dbConBean.close();

%>
</table>
<br>
 

</body>
</html>
 