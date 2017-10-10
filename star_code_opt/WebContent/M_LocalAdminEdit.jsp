<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:SACHIN GUPTA
 *Date of Creation 		:24 Jan 2007
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This jsp file  for edit local admin for a site by super admin
 *Modification 			: 
 *Reason of Modification: 
 *Date of Modification  : 
 *Revision History		:
 *Editor				:Editplus
 
 *Modified By			:Manoj Chand
 *Date of Modification	:22 Oct 2013
 *Modification			:javascript validation to stop from typing --,'  symbol is added.
 *******************************************************/
%>

<%@ page pageEncoding="UTF-8" %>
<%@page import="java.net.URLDecoder"%>

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
<%-- <%@ include  file="systemStyle.jsp" %> --%>

<!--Create the DbConnectionBean object for createConnection-->
<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbUtilityBean" scope="page" class="src.connection.DbUtilityMethods" />
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>

<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<%
// Variables declared and initialized
ResultSet rs			=		null;			  // Object for ResultSet

String	sSqlStr         =       "";                         // For sql Statements
String  strMessage      =       ""; 
int iCls                =       0;
String strStyleCls      =       "";
String strSiteId        = "";
String strDivisionName  = "";
String strSiteName      = "";
String strDivId         = ""; 
String strUserId		= "";	
String strUserName      = "";
String strSiteIdForUser = "";
String strRoleId        = "";

strSiteId		        = request.getParameter("sitedivId")==null ?"-1" :request.getParameter("sitedivId");
strMessage              = URLDecoder.decode((request.getParameter("message")==null) ?"" :request.getParameter("message"), "UTF-8");
strUserId              	= request.getParameter("userId")==null ?"-1" :request.getParameter("userId");
%>

<!--Java Script-->
<script language=JavaScript >
function checkData()
{
	var site = document.frm.sitedivId.value;
	if(site == "-1")
	{
		alert('<%=dbLabelBean.getLabel("alert.master.pleaseselecttheunit",strsesLanguage)%>');
		document.frm.sitedivId.focus();
		return false;
	}	
	var userId= document.frm.userId.value;
	if(userId=='-1')
	{
		alert('<%=dbLabelBean.getLabel("alert.login.entertheusername",strsesLanguage)%>');
		document.frm.userId.focus();
		return false;
	}

	var strRole= document.frm.roleId.value;	
	if(strRole=='')
	{
		alert('<%=dbLabelBean.getLabel("alert.user.pleaseenterroleid",strsesLanguage)%>');
		document.frm.roleId.focus();
		return false;
	}
	
	return true;
	
}
function deleteConfirm()
{

if(confirm('<%=dbLabelBean.getLabel("alert.global.deleterecord",strsesLanguage)%>'))
	return true;
else
	return false;
}

 
function MM_openBrWindow(theURL,winName,features) 
{ 
window.open(theURL,winName,features);
}
//ADDED BY MANOJ CHAND ON 22 OCT 2013 TO IMPLEMENT VALIDATION
function test1(obj1, length, str)
{	
	var obj;
	if(obj1=='roleId')
	{
		obj = document.frm.roleId;
	}
	charactercheck(obj,str);
	limitlength(obj, length);
	spaceChecking(obj);
}
</script>
<base target="middle"> 
</head>
<body><script type="text/javascript" language="JavaScript1.2" src="menu/menu_cnt.js?buildstamp=2_0_0"></script>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td width="70%" height="38" class="bodyline-top">
	    <ul class="pagebullet"><li class="pageHead"><%=dbLabelBean.getLabel("label.user.editstarslocaladmins",strsesLanguage)%> <font color='red'><%=strMessage%></font></li>
	    </ul>
	  </td>
      <td width="30%" align="right" valign="bottom" class="bodyline-top">
   	    <table border="0" cellspacing="0" cellpadding="0">
          <tr align="right">
			<td align="right">
			<ul id="list-nav">
			<li><a href="M_localAdminUserList.jsp">&nbsp;&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.global.list",strsesLanguage)%>&nbsp;&nbsp;&nbsp;</a></li>
			</ul>
			</td>               	
          </tr>
        </table></td></tr>
  </table>

  <br>
  <form method=post name=frm action="M_LocalAdminAdd_Post.jsp" >
  <table width="70%" align="center" cellspacing="1" cellpadding="5">
    <tr align="left">
      <td colspan="2" class="formbottom">&nbsp;</td>
    </tr>


<%	
		sSqlStr="SELECT SITE_ID, DBO.DIVISIONNAME(DIV_ID),ISNULL(SITE_NAME,'-'), DIV_ID FROM M_SITE WHERE SITE_ID="+strSiteId+" AND STATUS_ID=10 ";
		rs = dbConBean.executeQuery(sSqlStr);
		if(rs.next())
		{
			strSiteId		=   rs.getString(1);
			strDivisionName	=	rs.getString(2);
			strSiteName		=	rs.getString(3);
			strDivId		=	rs.getString(4);
		}
		rs.close();	
		

		sSqlStr="SELECT USERID,RTRIM(DBO.USER_NAME(USERID)) AS UNAME, RTRIM(LTRIM(ISNULL(ROLE_ID,''))) AS ROLE_ID FROM M_USERROLE WHERE USERID="+strUserId+" AND STATUS_ID=10 ";
		rs = dbConBean.executeQuery(sSqlStr);
		if(rs.next())
		{	
			strUserId   = rs.getString("USERID");
			strUserName = rs.getString("UNAME");
			strRoleId   = rs.getString("ROLE_ID");
		}
		rs.close();			
%>
	<tr align="left">
	  <td class="formtr2" width="37%"><%=dbLabelBean.getLabel("label.global.unitname",strsesLanguage)%></td>    
      <td width="63%" class="formtr1">
	    <input type="text" size=20 maxlength=50 name=siteName readOnly value="<%=strDivisionName+"/"+strSiteName%>" class="textBoxCss"/>
	  </td>
    </tr>
	<tr align="left">	  
	  <td class="formtr2" width="37%"><%=dbLabelBean.getLabel("label.mail.username",strsesLanguage)%></td>
      <!-- TO ADD THE USER NAME -->
      <td width="63%" class="formtr1">
   	    <input type="text" size=20 maxlength=50 name=userName readOnly value="<%=strUserName%>" class="textBoxCss">
	  </td>
	</tr>

    <tr align="left">
      <td class="formtr2" width="37%"><%=dbLabelBean.getLabel("label.user.roleid",strsesLanguage)%></td>
      <!-- TO ADD THE ROLE ID-->
      <td width="63%" class="formtr1">
		<input type="text" size=20 maxlength="10" name="roleId" onkeyup="return test1('roleId',20,'c');"  value="<%=strRoleId%>"  class="textBoxCss"/>
	  </td>
    </tr>
    <tr align="center">
      <td class="formbottom" colspan="2">
		<input type="submit" name="Submit" value="<%=dbLabelBean.getLabel("label.suggestions.update",strsesLanguage)%>" class="formButton" onClick="javascript:return checkData();">
        <input type="Reset" name="Submit2" value="<%=dbLabelBean.getLabel("button.global.reset",strsesLanguage)%>" class="formButton">    
	  </td>
    </tr>
    <tr>
      <td height="1" colspan="2" align="center" class="bodyline-bottom"></td>
    </tr>
	<input type="hidden" name="action" value="edit"/><!--HIDDEN FIELD-->
	<input type="hidden" name="userId" value="<%=strUserId%>"/><!--HIDDEN FIELD-->
	<input type="hidden" name="sitedivId" value="<%=strSiteId%>"/><!--HIDDEN FIELD-->

  </table>
</form>

</body>
</html>
