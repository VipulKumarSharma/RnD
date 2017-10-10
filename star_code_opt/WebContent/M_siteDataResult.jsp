
<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:Himanshu Jain	
 *Date of Creation 		:28 August 2006
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This is first jsp file  for adding new site in M_site table of STAR database 
 *Modification 			: 
 *Reason of Modification: 
 *Date of Modification  : 
 *Revision History		:
 *Editor				:Editplus
 *******************************************************/
%>
<%@ page pageEncoding="UTF-8" %>
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
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
<%
// Variables declared and initialized
String strSqlStr	=	""; // For sql Statements
String strType	=	""; // Object to Hold the Page Type
String strError	=	"";	// Object to hold the Error type if any
String strPageMsg	=	"";	// Object to hold the Page type add or modify
String strErrorMsg	=	"";	// Object to hold the Page type add or modify

strType			=	request.getParameter("Type");
strError	 	=	request.getParameter("Error");
if(strError.trim().equals("1"))
{
	strErrorMsg	=	" "+dbLabelBean.getLabel("label.department.dataaddedsuccessfully",strsesLanguage);
}
if(strError.trim().equals("2"))
{
	strErrorMsg	=	" "+dbLabelBean.getLabel("message.user.thesiteenteredalreadyexists",strsesLanguage);
}
if(strError.trim().equals("3"))
{
	strErrorMsg	=	" "+dbLabelBean.getLabel("label.department.dataupdatedsuccessfully",strsesLanguage);
}
if(strError.trim().equals("4"))
{
	strErrorMsg	=	" "+dbLabelBean.getLabel("label.department.datadeletedsuccessfully",strsesLanguage);
}

if(strError.trim().equals("5"))
{
	strErrorMsg	=	" "+dbLabelBean.getLabel("message.user.datacannotbedeletedsitehassomereference",strsesLanguage);
}

if(strError.trim().equals("7"))
{
	strErrorMsg	=	" "+dbLabelBean.getLabel("message.user.thesite",strsesLanguage)+" ";
}

%>

</head>

<body class="body"><script type="text/javascript" language="JavaScript1.2" src="menu/menu_cnt.js?buildstamp=2_0_0"></script>

<table width="100%" height="45" border="0" align="center" cellpadding="0" cellspacing="0"  class="bodyline-top">
  <tr> 
    <td width="86%" height="45" class="pageHead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.requestdetails.unit",strsesLanguage)%> >> <%=strType%> </td>
    <td width="14%" valign="bottom" class="pageHead" >
    <table align="right" border="0" cellspacing="0" cellpadding="0">
      <tr align="right">
      <td>
      <ul id="list-nav">
		<li><a href="M_siteAdd.jsp"><%=dbLabelBean.getLabel("button.global.new",strsesLanguage)%></a></li>
		<li><a href="M_siteList.jsp"><%=dbLabelBean.getLabel("label.global.list",strsesLanguage)%></a></li>
	  </ul>   
      </td>
      </tr>
    </table></td>
  </tr>
 
</table>
<table width="95%" border="0" cellspacing="0" cellpadding="0"  align="center">
  <tr>
    <td height="1" colspan="2" align="center" class="bodyline-bottom"></td>
  </tr>
</table>
<table width="50%" border="0" align="center" cellpadding="5" cellspacing="0" class="formborder">
  <tr>
    <td height="45" align="center" class="formtr2"><div align="center"><%=strErrorMsg%></div></td>
  </tr>
</table>
</body>
</html>
