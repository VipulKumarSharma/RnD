<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:Sachin Gupta
 *Date of Creation 		:28 Nov 2006
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This jsp list the designation.
 *Modification 			: 
 *Reason of Modification: 
 *Date of Modification  : 
 *Revision History		:
 *Editor				:Editplus
*******************************************************/%>
<html>
<head>
<%@ page pageEncoding="UTF-8" %>
<%@page import="java.net.URLDecoder"%>
<%@ include  file="importStatement.jsp" %>
<%-- include remove cache  --%>
<%@ include  file="cacheInc.inc" %>
<%-- include header  --%>
<%@ include  file="headerIncl.inc" %>
<%-- include page with all application session variables --%>
<%@ include  file="application.jsp" %>
<%-- include page styles  --%>
<%-- <%@ include  file="systemStyle.jsp" %> --%>
<!--Create the DbConnectionBean object for createConnection-->
<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbConBean1" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>

<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />

<%
// Variables declared and initialized
ResultSet objRs			=		null;			  // Object for ResultSet
ResultSet rs 			=		null;	
String	strSqlStr	=	""; // For sql Statements
int iCls = 0;
String strStyleCls = "";
String strsiteid	 ="";
String strMessage =  URLDecoder.decode((request.getParameter("strMsg") == null) ? "" : request.getParameter("strMsg"), "UTF-8");

%>
<script language=JavaScript >

function deleteConfirm()
{

if(confirm('<%=dbLabelBean.getLabel("alert.global.deleterecord",strsesLanguage)%>'))
	return true;
else
	return false;
}
</script>
<base target="middle">
</head>
<body><script type="text/javascript" language="JavaScript1.2" src="menu/menu_cnt.js?buildstamp=2_0_0"></script>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="77%" height="38" class="bodyline-top">
	<ul class="pagebullet">
      <li class="pageHead"><%=dbLabelBean.getLabel("label.division.division",strsesLanguage)%>   &nbsp;</li><font color='red'><%=strMessage%></font>
    </ul></td>
    <td width="23%" align="right" valign="bottom" class="bodyline-top">
	<table align="right" border="0" cellspacing="0" cellpadding="0">
      <tr align="right">
      <td>
		<ul id="list-nav">
			<li><a href="M_divAdd.jsp"><%=dbLabelBean.getLabel("button.global.new",strsesLanguage)%></a></li>
			<li><a href="#" onClick="window.print();"><%=dbLabelBean.getLabel("button.search.print",strsesLanguage)%></a></li>
		</ul>
      </td>
      </tr>
    </table>
	</td>
  </tr>
</table>
<br>
<table width="100%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder">
<tr align="left" class="formhead"> 
    <td width="2%" nowrap="nowrap"><%=dbLabelBean.getLabel("label.global.sno",strsesLanguage)%></td>
	<td width="7%"><%=dbLabelBean.getLabel("label.division.divisionid",strsesLanguage)%></td>
    <td width="20%"><%=dbLabelBean.getLabel("label.division.divisionname",strsesLanguage)%></td>
    <td width="22%"><%=dbLabelBean.getLabel("label.division.divisiondesc",strsesLanguage)%></td>
    <td width="16%"><%=dbLabelBean.getLabel("label.global.createdon",strsesLanguage)%></td>
    <td width="16%"><%=dbLabelBean.getLabel("label.approverequest.action",strsesLanguage)%></td>

  </tr>
  <%
		
	int		intSno		=	1;
	String strSiteName  =   ""; 
	String strDivisionId =   "";
 
	String strCreatedDate = "";
 
	String strDivisioName=  "";
	String strDivisioDesc="";

	
	//Sql to get the the site list  from site table

	strSqlStr="SELECT  DIV_ID, DIV_NAME, DIV_DESC, dbo.CONVERTDATE(C_DATE) AS create_date  FROM  M_DIVISION WHERE (STATUS_ID =           10) order by 2" ;
      objRs				= dbConBean.executeQuery(strSqlStr);


	  
//New Check for local administrator
	

	//objRs				= dbConBean.executeQuery(strSqlStr);
	while(objRs.next())
	{
		strDivisionId				= objRs.getString("DIV_ID");
		strDivisioName              = objRs.getString("DIV_NAME"); 
		strDivisioDesc				= objRs.getString("DIV_DESC");
		strCreatedDate			    = objRs.getString("create_date");
		

		if (iCls%2 == 0) { 
		strStyleCls="formtr2";
	    } else { 
		strStyleCls="formtr1";
		} 
	    iCls++;
%>
    <tr class="<%=strStyleCls%>"> 
    <td width="2%"><%=intSno%></td>
    <td width="6%"><%=strDivisionId%></td>
	<td width="20%"><%=strDivisioName%></td>
	<td width="22%" ><%=strDivisioDesc%></td>
	<td width="16%" ><%=strCreatedDate%></td>
    <td width="16%" align="left" class="rep-txt"><a href="M_divEdit.jsp?divId=<%=strDivisionId%>"><%=dbLabelBean.getLabel("link.createrequest.edit",strsesLanguage)%></a> | <a href="M_divPost.jsp?strDivId=<%=strDivisionId%>&action=Delete" onClick="return  deleteConfirm();"><%=dbLabelBean.getLabel("link.createrequest.delete",strsesLanguage)%></a></td>
  </tr>
  <%
				intSno++;				
	}
	objRs.close();
	dbConBean.close();   //Close All Connection
%>
 <tr>
    <td height="1" colspan="2" align="center" class="bodyline-bottom"></td>
  </tr>
</table>
<br>
</body>
</html>
