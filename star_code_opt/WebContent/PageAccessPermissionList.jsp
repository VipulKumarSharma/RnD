<%
/***************************************************

**** Copyright Notice :Copyright(C)2000 MIND.All rights reserved. ******
**** Project	  : STARS ****** 
**** Operating environment :Tomcat, sql server 2000 ******
**** Description : This is first jsp file  for listing all the  users to whom approval page is assigned  ******
**** Modified By			: Manoj Chand
**** Modification			: To list all the parameters like Mail forward, value etc. 
**** Date of Modification   : 01-05-2012
**********************************************************/
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
<%--<%@ include  file="systemStyle.jsp" %>--%>
<%-- include the beans --%>

<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbConBean1" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
<script language="JavaScript" src="scripts/CommonValida.js?buildstamp=2_0_0"></script>
<SCRIPT language=JavaScript src="ScriptLibrary/validation.js?buildstamp=2_0_0"></SCRIPT>
<SCRIPT language="JavaScript" src="ScriptLibrary/date-picker.js?buildstamp=2_0_0"></SCRIPT>
<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
<script language=JavaScript >
function deleteConfirm()
{
if(confirm('<%=dbLabelBean.getLabel("alert.global.deleterecord",strsesLanguage)%>'))
	return true;
else
	return false;
}

function showMsg(strMsg){
	if(strMsg=="1")
		alert('<%=dbLabelBean.getLabel("label.department.dataaddedsuccessfully",strsesLanguage)%>');
	else if(strMsg=="2")
		alert('<%=dbLabelBean.getLabel("alert.pageaccesspermission.dataalreadyexists",strsesLanguage)%>');
	else if(strMsg=="3")
		alert('<%=dbLabelBean.getLabel("label.department.dataupdatedsuccessfully",strsesLanguage)%>');
	else if(strMsg=="4")
		alert('<%=dbLabelBean.getLabel("label.department.datadeletedsuccessfully",strsesLanguage)%>');
	else if(strMsg=="5")
		alert('<%=dbLabelBean.getLabel("message.user.datacannotbedeletedsitehassomereference",strsesLanguage)%>');
	if(strMsg=="7")
		alert('<%=dbLabelBean.getLabel("message.user.thesite",strsesLanguage)%>');
	if(strMsg=="8")
		alert('<%=dbLabelBean.getLabel("alert.pageaccesspermission.fullcontrolhasalreadybeenassigned",strsesLanguage)%>');

}

</script>

<%
// Variables declared and initialized
Connection objCon,objCon1		=		null;			    // Object for connection
Statement objStmt,objStmt1		=		null;			   // Object for Statement
ResultSet objRs,objRs1			=		null;			  // Object for ResultSet
CallableStatement objCstmt		=		null;			// Object for Callable Statement

//Create Connection
Class.forName(Sdbdriver);
objCon=DriverManager.getConnection(Sdburl,Sdbuser,Sdbpwd);
objCon1=DriverManager.getConnection(Sdburl,Sdbuser,Sdbpwd);

String	strSqlStr,strSqlStr1	=	""; // For sql Statements
Calendar objCal		= Calendar.getInstance();
int		objCur_year	= objCal.get(Calendar.YEAR);// get current year
int iCls = 0;
String strStyleCls = "";
//Added By Anjali on 09-04-2012
String strSiteAccess="";
String strAccessLevel="";
String strBeforePassCheck="";
String strAfterPassCheck="";
String strMailForward="";
String strPAPValue="";
String strPAP_ID="";

String strType="";
String strError="";
strType			=	request.getParameter("Type")==null?"":request.getParameter("Type");
strError	 	=	request.getParameter("Error")==null?"":request.getParameter("Error");

%>

</head>
<body onload="showMsg('<%=strError %>');"><script type="text/javascript" language="JavaScript1.2" src="menu/menu_cnt.js?buildstamp=2_0_0"></script>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="70%" height="35" class="bodyline-top">
	<ul class="pagebullet">
      <li class="pageHead"><%=dbLabelBean.getLabel("label.pageaccesspermission.permissiontoviewapproverequestpage",strsesLanguage)%></li>
    </ul></td>
    <td width="30%" align="right" valign="bottom" class="bodyline-top">
	<table align="right" border="0" cellspacing="0" cellpadding="0">
      <tr align="right">
      <td>
      <ul id="list-nav">
		<li><a href="M_PageAccessPermissionAdd.jsp"><%=dbLabelBean.getLabel("button.global.new",strsesLanguage)%></a></li>
	  </ul>
	  </td>
      </tr>
    </table>
	</td> 
  </tr>
</table>
<table width="100%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder">
  <tr align="center" class="formhead"> 
   		 <td width="4%" nowrap="nowrap"><%=dbLabelBean.getLabel("label.global.sno",strsesLanguage)%></td>
		<td width="14%" ><%=dbLabelBean.getLabel("label.pageaccesspermission.pendingwithuser",strsesLanguage)%></td>
		<td width="14%" ><%=dbLabelBean.getLabel("label.pageaccesspermission.viewtouser",strsesLanguage)%></td>		
		<td width="12%"><%=dbLabelBean.getLabel("label.administration.site",strsesLanguage)%></td>
		<td width="7%"><%=dbLabelBean.getLabel("label.pageaccesspermission.access",strsesLanguage)%></td>
		<td width="5%"><%=dbLabelBean.getLabel("label.administration.showbeforepass",strsesLanguage)%></td>
		<td width="5%"><%=dbLabelBean.getLabel("label.administration.showafterpass",strsesLanguage)%></td>
		<td width="5%"><%=dbLabelBean.getLabel("label.administration.mailforward",strsesLanguage)%></td>
		<td width="5%"><%=dbLabelBean.getLabel("label.administration.value",strsesLanguage)%></td>
		<td width="10%"><%=dbLabelBean.getLabel("label.administration.createdby",strsesLanguage)%></td>
 	  	<td width="12%" nowrap="nowrap"><%=dbLabelBean.getLabel("label.global.createdon",strsesLanguage)%></td>
		<td width="5%"><%=dbLabelBean.getLabel("label.approverequest.action",strsesLanguage)%></td>	
		
   </tr>
  <%
	int	intSno	=	1;
	String strPendingWithId	 	= 	"";	
	String strViewToId 	= 	"";	
	String strPendingWithName	 	= 	"";	
	String strViewToName	= 	"";	
	String strCreatedBy		= 	""; 
	String strCreatedOn		=	""; 
	String strCSS	 =	"";
	//strSqlStr1="SELECT pendingWithUser,.dbo.user_name(pendingWithUser) as PendingWithUserName,viewToUser,.dbo.user_name(viewToUser) as ViewToUserName,.dbo.user_name(createdBy) as CreatedBy,.dbo.convertdate(createdOn) as CreatedOn,Site,Access_Level,IS_Show_Before_Pass,IS_Show_After_Pass,IS_MAIL_FWD  FROM PAGE_ACCESS_PERMISSION PAP inner join site ST on  WHERE STATUS=10 order by 1";
	strSqlStr1="SELECT pendingWithUser,.dbo.user_name(pendingWithUser) as PendingWithUserName,viewToUser,isnull(.dbo.user_name(viewToUser),'All') as ViewToUserName,.dbo.user_name(createdBy) as CreatedBy,.dbo.convertdate(createdOn) as CreatedOn,ISNULL(DBO.SITENAME(PAP.Site),'All') as Site ,ISNULL(PAP.Access_Level,'View') as Access_Level, isnull(PAP.IS_Show_Before_Pass,'N') as Show_Before_Pass, isnull(PAP.IS_Show_After_Pass,'N') as Show_After_Pass ,isnull(PAP.IS_MAIL_FWD,'N') as MAIL_FWD,isnull(PAP.PAP_VALUE_LIMIT,0) as value ,PAP_ID as PAP_ID FROM PAGE_ACCESS_PERMISSION PAP  WHERE STATUS=10 order by 2 ";
	//System.out.println("strSqlStr1------->"+strSqlStr1);
	objStmt		 = objCon.createStatement(); 
	objRs		 = objStmt.executeQuery(strSqlStr1);

				while(objRs.next())
				{
					strPendingWithId		= objRs.getString("PendingWithUser");
					strPendingWithName		= objRs.getString("PendingWithUserName");
					strViewToId				= objRs.getString("ViewToUser");
					strViewToName			= objRs.getString("ViewToUserName");
					strCreatedBy			= objRs.getString("CreatedBy");
					strCreatedOn			= objRs.getString("CreatedOn");
					strSiteAccess			= objRs.getString("Site");
					strAccessLevel			= objRs.getString("Access_Level");
					strBeforePassCheck		= objRs.getString("Show_Before_Pass");
					strAfterPassCheck		= objRs.getString("Show_After_Pass");
					strMailForward			= objRs.getString("MAIL_FWD");
					strPAPValue				= objRs.getString("value");
					strPAP_ID				= objRs.getString("PAP_ID");	
					
				%>
<%
	if (iCls%2 == 0) { 
		strStyleCls="formtr2";
    } else { 
		strStyleCls="formtr1";
    } 


	  iCls++;
%>
    <tr class="<%=strStyleCls%>"> 
    <td  align="center"><%=intSno%></td>
	<td  align="center"><%=strPendingWithName%></td>
    <td  align="center"><%=strViewToName%></td>
    <td  align="center"><%=strSiteAccess%></td>
    <td  align="center"><%=strAccessLevel%></td>
    <td  align="center"><%=strBeforePassCheck%></td>
	<td  align="center"><%=strAfterPassCheck%></td>
	<td  align="center"><%=strMailForward%></td>
	<td  align="center"><%=strPAPValue%></td>
    <td  align="center"><%=strCreatedBy%></td>
	<td  align="center"><%=strCreatedOn%></td>	
	<td  align="center"><a href="M_PageAccessDelete.jsp?strPendingWithId=<%=strPendingWithId%>&strViewToId=<%=strViewToId%>&reqPAP_ID=<%=strPAP_ID%>" onClick="return  deleteConfirm();"><%=dbLabelBean.getLabel("link.createeditlist.delete",strsesLanguage)%></a></td>
	</tr>
  <%
				intSno++;		
					}//end of while

	


objRs.close();
objStmt.close();
objCon.close();	//CLOSE ALL THE CONNECTIONS

%>
  <tr>
    <td height="1" colspan="2" align="center" class="bodyline-bottom"></td>
  </tr>
</table>
<br>
</body>
</html>
