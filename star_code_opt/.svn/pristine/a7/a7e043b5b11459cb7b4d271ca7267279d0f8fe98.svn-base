<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:Sachin Gupta
 *Date of Creation 		:08 DEC 2006
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:.
 *Modification 			: 
 *Reason of Modification: 
 *Date of Modification  : 
 *Revision History		:
 *Editor				:Editplus
*******************************************************/%>
<html>
<head>

<%@ include  file="importStatement.jsp" %>
<%-- include remove cache  --%>
<%@ include  file="cacheInc.inc" %>
<%-- include header  --%>
<%@ include  file="headerIncl.inc" %>
<%-- include page with all application session variables --%>
<%-- @ include  file="application.jsp" --%>
<%-- include page styles  --%>
<%-- <%@ include  file="systemStyle.jsp" %> --%>

<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />

<%
// Variables declared and initialized
ResultSet objRs			=		null;			  // Object for ResultSet
String	strSqlStr	=	""; // For sql Statements
int iCls = 0;
String strStyleCls = "";
String strMessage = "";

strMessage = request.getParameter("message")== null?"":request.getParameter("message");

%>
<script language=JavaScript >
function updateConfirm()
{

if(confirm('Are you sure you want to update the record !'))
	return true;
else
	return false;
}

function checkData(f1)
{
	/*if(f1.inputTableName.value == "")
	{
		alert("Please insert the table name");
		f1.inputTableName.focus();
		return false;
	}*/
	if(f1.inputQuery.value == "")
	{
		alert("Please insert the query");
		f1.inputQuery.focus();
		return false;
	}
	updateConfirm();
	f1.submit();
}

</script>
<base target="middle">
</head>
<body><script type="text/javascript" language="JavaScript1.2" src="menu/menu_cnt.js?buildstamp=2_0_0"></script>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="77%" height="45" class="bodyline-top">
	<ul class="pagebullet">
      <li class="pageHead">Update QUERY</li><FONT COLOR="RED"><%=strMessage%></FONT>
    </ul></td>
    <td width="23%" align="right" valign="bottom" class="bodyline-top">
	<table width="39%" align="right" border="0" cellspacing="0" cellpadding="0">
      <tr align="right">
		
		<td width="52%" align="right"><a href="TEST.jsp" title="Attachments"></a></td>

        <td width="52%" align="right"><a href="M_desigAdd.jsp"><img src="images/IconNew.gif?buildstamp=2_0_0" width="49" height="24" border="0" /></a></td>
        <td width="48%" align="right"><a href="#" onClick="window.print();"><img src="images/IconPrint.gif?buildstamp=2_0_0" width="49" height="24" border="0" /></a></td>
      </tr>
    </table>
	</td>
  </tr>
</table>
<br>
<table width="100%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder">
	<form name="frm" action="UpdateQuery_POST.jsp">
		<tr align="left" class="formhead"> 
			<td width="8%"></td>
		</tr>
		<!--<tr>
			<TD width="52%" align="left">INPUT TABLE NAME</TD>
			<TD> <input type="text" name="inputTableName" size="100"/></TD>
		</tr>-->
		<tr>
			<TD width="52%" align="left">INPUT UPDATE QUERY</TD>
			<TD> <input type="text" name="inputQuery" size="100"/></TD>
		</tr>
		
		<tr align="center">
			<TD><input type="button" value="Submit" name="submit1" size="10" onClick="checkData(this.form)"/></TD>
		</tr>
	</form>
</table>

<br>
</body>
</html>
