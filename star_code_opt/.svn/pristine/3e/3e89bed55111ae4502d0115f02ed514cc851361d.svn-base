<%
/***************************************************
*Copyright (C) 2000 MIND 
*All rights reserved.
*The information contained here in is confidential and 
*proprietary to MIND and forms the part of the MIND 
*CREATED BY		:	Manoj Chand
*Date			:   10/02/2011
*Description	:	To take response after adding currency
*Project		:	STARS
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
	strErrorMsg	=	" Data Added Successfully";
}
if(strError.trim().equals("2"))
{
	strErrorMsg	=	" The Currency entered already exists";
}
if(strError.trim().equals("3"))
{
	strErrorMsg	=	" Data Updated Successfully";
}
if(strError.trim().equals("4"))
{
	strErrorMsg	=	" Data Deleted Successfully";
}

if(strError.trim().equals("5"))
{
	strErrorMsg	=	" Data Cannot be deleted.";
}

if(strError.trim().equals("7"))
{
	strErrorMsg	=	" The Currency ";
}

%>

</head>

<body class="body"><script type="text/javascript" language="JavaScript1.2" src="menu/menu_cnt.js?buildstamp=2_0_0"></script>

<table width="100%" height="45" border="0" align="center" cellpadding="0" cellspacing="0"  class="bodyline-top">
  <tr> 
    <td width="86%" height="45" class="pageHead">&nbsp;&nbsp;Currency >> <%=strType%> </td>
    <td width="14%" valign="bottom" class="pageHead" ><table width="43%" align="right" border="0" cellspacing="0" cellpadding="0">
      <tr align="right">
        <td width="52%" align="right"><a href="M_currencyAdd.jsp"><img src="images/IconNew.gif?buildstamp=2_0_0" width="49" height="24" border="0" /></a></td>
        <td width="25%" align="right"><a href="M_currencyList.jsp"><img src="images/2List.gif?buildstamp=2_0_0" width="57" height="24" border="0" /></a></td>
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