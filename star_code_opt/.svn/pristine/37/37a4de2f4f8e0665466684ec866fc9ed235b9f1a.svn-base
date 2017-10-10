<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:Himanshu Jain
 *Date of Creation 		:04 October 2006
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This is first jsp file  to display mail details.
 *Modification 			: 
 *Reason of Modification: 
 *Date of Modification  : 
 *Revision History		:
 *Editor				:Editplus
 *******************************************************/
%>
<%@ page pageEncoding="UTF-8" %>
<%@ include  file="importStatement.jsp" %>

<!--Create the DbConnectionBean object for createConnection-->
<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
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
<link rel="stylesheet" href="styles/fonts.css?buildstamp=2_0_0" type="text/css">
<link rel="stylesheet" href="styles/links.css?buildstamp=2_0_0" type="text/css">
<style>
td.listhead table {
margin:0 auto;
}
</style>
</head>
<%
ResultSet rs			=	null;			  // Object for ResultSet
String sSqlStr			=	"";				// For sql Statements
String strMailId		=	"";				//For holding Purchase Requisition Id
strMailId				=	request.getParameter("MAILID");
sSqlStr="SELECT MAIL_MSG FROM VW_Req_mailBox  WHERE MAIL_ID='"+strMailId+"'" ; 

//System.out.println("sSqlStr=shiv=="+sSqlStr);

rs = dbConBean.executeQuery(sSqlStr);
%>
<body class="body">
<br>
<table width="100%" align="center" cellspacing="0" border=0 cellpadding="2" class="table" style="margin:0 auto;">
<tr class="listhead"> 
<td class="colorPink" align=left><%= dbLabelBean.getLabel("label.mail.maildetails",strsesLanguage)%></td>
<td class="colorPink" align=right><a href="#" onClick="window.print();"><%=dbLabelBean.getLabel("link.mail.print",strsesLanguage) %></a>&nbsp;|&nbsp;<a href="#" onClick="window.close();"><%=dbLabelBean.getLabel("link.mail.close",strsesLanguage) %></a></td>
</tr>
<%
while(rs.next())
{
%>
<tr class="listhead"><td width="10%" class="listhead" colspan=2><%=rs.getString(1)%></td></tr>
	
<%
}
rs.close();
dbConBean.close();

%>
</table>
<br>
 

</body>
</html>
