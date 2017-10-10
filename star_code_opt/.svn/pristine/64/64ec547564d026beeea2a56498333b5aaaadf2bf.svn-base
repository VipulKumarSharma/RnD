<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:SACHIN GUPTA
 *Date of Creation 		:21 Feb 2007
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This jsp file  for showing unit head information to the administrator from  M_USERINFO in the STAR Database 
 *Modification 		    :1. getting unit_head information from  the USER_MULTIPLE_ACCESS
						 2. Invisible Password information to super Admin 
 *Reason of Modification:1. New Change
						 2. Password Security Purpose 
 *Date of Modification  :1. 25 April 2007
						 2. 17 May 2007 
 *Modified By			:1. Sachin Gupta
						 2. Sachin Gupta 
 *Editor				:Editplus
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
int iCls                =       0;
String strStyleCls      =       "";
String strMessage 		= URLDecoder.decode((request.getParameter("message") == null) ?"" : request.getParameter("message"), "UTF-8");

%>

<!--Java Script-->
<script language=JavaScript >
function deleteConfirm()
{

if(confirm('<%=dbLabelBean.getLabel("alert.user.areyousureyouwanttodeleteunitheadaccess",strsesLanguage)%>'))
	return true;
else
	return false;
}
</script>

<script language="JavaScript">

function resetPassword(userId,email)
{
	if(confirm('<%=dbLabelBean.getLabel("alert.master.areyousurewanttoresetpassword",strsesLanguage)%>'))
	{
	  MM_openBrWindow('reset_password_mail.jsp?userId='+userId+'&email='+email,'SEARCH','scrollbars=yes,resizable=yes,width=300,height=250');
		return true;
	}
	else
		return false;
}
function MM_openBrWindow(theURL,winName,features) 
{ 
window.open(theURL,winName,features);
}
</script>
 <base target="middle"> 
</head>
<body><script type="text/javascript" language="JavaScript1.2" src="menu/menu_cnt.js?buildstamp=2_0_0"></script>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td width="70%" height="38" class="bodyline-top">
	    <ul class="pagebullet"><li class="pageHead"><%=dbLabelBean.getLabel("label.user.starsunitheads",strsesLanguage)%></li>  <font color='red'><%=strMessage%></font></ul> 
	  </td>
      <td width="30%" align="right" valign="bottom" class="bodyline-top">
   	    <table align="right" border="0" cellspacing="0" cellpadding="0">
          <tr align="right">
			<td align="right">
			<ul id="list-nav">
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
  <tr> 
    <td width="5%" class="formhead" nowrap="nowrap"><%=dbLabelBean.getLabel("label.global.sno",strsesLanguage)%></td>
<%
//New Check for local administrator
	if(SuserRole.trim().equals("AD"))
	{
%>
	<td width="5%" class="formhead" nowrap="nowrap"><%=dbLabelBean.getLabel("label.master.userid",strsesLanguage)%></td>
	<td width="5%" class="formhead" nowrap="nowrap"><%=dbLabelBean.getLabel("label.user.unitid",strsesLanguage)%></td>
<%
	}
%>
	<td width="9%" class="formhead" nowrap="nowrap"><%=dbLabelBean.getLabel("label.global.createdon",strsesLanguage)%></td>
    <td width="5%" class="formhead"><%=dbLabelBean.getLabel("label.requestdetails.name",strsesLanguage)%></td>	
	<td width="9%" class="formhead"><%=dbLabelBean.getLabel("label.requestdetails.division",strsesLanguage)%></td>
	<td width="5%" class="formhead"><%=dbLabelBean.getLabel("label.global.unitname",strsesLanguage)%></td> 
	<td width="9%" class="formhead"><%=dbLabelBean.getLabel("label.requestdetails.department",strsesLanguage)%></td>
	<td width="9%" class="formhead"><%=dbLabelBean.getLabel("label.global.designation",strsesLanguage)%></td>
	<td width="9%" class="formhead"><%=dbLabelBean.getLabel("label.mail.username",strsesLanguage)%></td>
<%
//New Check for local administrator
	if(SuserRole.trim().equals("AD"))
	{
%>
<!--Changed on 17 May by Sachin start-->
      <!-- <td width="9%" class="formhead">Pin</td> -->
<!--Changed on 17 May by Sachin end-->
<%
	}
%>
    <td width="9%" class="formhead"><%=dbLabelBean.getLabel("label.mylinks.email",strsesLanguage)%></td>
    <td width="9%" class="formhead" nowrap="nowrap"><%=dbLabelBean.getLabel("label.master.role",strsesLanguage)%></td>
	<td width="9%" class="formhead" nowrap="nowrap"><%=dbLabelBean.getLabel("label.master.approverlevel",strsesLanguage)%></td>
    
    <td width="9%" class="formhead" nowrap="nowrap"><%=dbLabelBean.getLabel("label.approverequest.action",strsesLanguage)%></td>
  </tr>

<%
	int iSno                          = 1;
	String strUserId               = "";
	String strSiteId				 =	"";
	String sDivName					 = "";
	String sSiteName				 = "";
	String sDeptName				 = "";
	String sName					 = "";
	String sCreatedDate				 = "";
	String sUsername				 = "";
	String sEmail					 = "";
	String sRole					 = "";
	String sPswd					 = "";	
	String sUserid					 = "";
	String sDesigid					 = "";
	String strChkBudAgainstUser		 = "";                                                                                              
	String sUserPin					 = "";
	String sApproverLevel			 = "";

	// Customer funded projects and item wise booking
	//Sql to get the the item list and sanction_dtl_id from sanction_detail
	
    //sSqlStr="SELECT USERID, dbo.DIVISIONNAME(DIV_ID) AS DIV,dbo.SITEDETAILS(SITE_ID) AS SITE,ISNULL(dbo.DEPARTMENTNAME(DEPT_ID),'-') AS DEPT,RTRIM(dbo.USER_NAME(USERID)) AS UNAME,dbo.CONVERTDATE(C_DATE) AS CREATEDDATE,USERNAME ,EMAIL,ISNULL(ROLE_ID,'') AS ROLE,PIN,USERID,dbo.DESIGNATIONNAME(DESIG_ID) AS DESIG_ID,PIN AS PIN1, LTRIM(RTRIM(ISNULL(APPROVER_LEVEL,'0'))) AS APPROVER_LEVEL FROM M_USERINFO WHERE UNIT_HEAD='1' AND STATUS_ID=10 AND APPLICATION_ID=1  ORDER BY 1,2,3,4 ";
	//sSqlStr = "select userid,site_id,dbo.user_name(userid) as userName,dbo.sitename(site_id) as siteName,dbo.CONVERTDATE(C_DATE) AS CREATEDDATE from user_multiple_access where status_id=10 and unit_head=1";
	sSqlStr = "select a.userid,a.site_id,dbo.CONVERTDATE(a.C_DATE) AS CREATEDDATE,dbo.user_name(a.userid) as Name,dbo.DIVISIONNAME(DIV_ID) AS DIV_NAME,dbo.sitename(a.site_id) as siteName,ISNULL(dbo.DEPARTMENTNAME(DEPT_ID),'-') AS DEPT,dbo.DESIGNATIONNAME(b.DESIG_ID) AS DESIG_ID,USERNAME ,PIN,EMAIL,ISNULL(b.ROLE_ID,'') AS ROLE,LTRIM(RTRIM(ISNULL(APPROVER_LEVEL,'0'))) AS APPROVER_LEVEL from user_multiple_access a, m_userinfo b  where a.userid=b.userid and a.status_id=10 and b.status_id=10 and a.unit_head=1";
	

  	rs   = dbConBean.executeQuery(sSqlStr);//stmt.executeQuery(sSqlStr);
	while(rs.next())
	{
		strUserId           = rs.getString("userid");  
		strSiteId			= rs.getString("site_id");
		sCreatedDate		= rs.getString("CREATEDDATE");
		sName				= rs.getString("Name");
		sDivName			= rs.getString("DIV_NAME");
		sSiteName        = rs.getString("siteName");
		sDeptName		= rs.getString("DEPT");
		sDesigid			= rs.getString("DESIG_ID");
		sUsername		= rs.getString("USERNAME");
		sPswd				= rs.getString("PIN");

		//System.out.println("before decrypt ="+ sPswd);
        sPswd               = dbUtilityBean.decryptFromDecimalToString(sPswd); 
		//System.out.println("after decrypt===="+sPswd);


		sEmail				= rs.getString("EMAIL");
		sRole				= rs.getString("ROLE");
		sApproverLevel   = rs.getString("APPROVER_LEVEL"); 
		sApproverLevel   = dbUtilityBean.getApproverLevelNameFromNo(sApproverLevel);     //Get the label name correspond to the no  
		if(sApproverLevel.equalsIgnoreCase("None"))
			sApproverLevel=dbLabelBean.getLabel("label.master.none",strsesLanguage);
		if(sApproverLevel.equalsIgnoreCase("Approver Level 1"))
			sApproverLevel=dbLabelBean.getLabel("label.global.approvallevel1",strsesLanguage);
		if(sApproverLevel.equalsIgnoreCase("Approver Level 2"))
			sApproverLevel=dbLabelBean.getLabel("label.global.approvallevel2",strsesLanguage);
		if(sApproverLevel.equalsIgnoreCase("Global Approver"))
			sApproverLevel=dbLabelBean.getLabel("label.global.globalapprover",strsesLanguage);
		
    	if (iCls%2 == 0) 
     	{ 
	    	strStyleCls="formtr2";
        } 
		else
		{ 
	    	strStyleCls="formtr1";
        } 
        iCls++;
%>

<tr class="<%=strStyleCls%>"> 
    <td class="<%=strStyleCls%>" width="5%"><%=iSno%></td>
<%
//New Check for local administrator
	if(SuserRole.trim().equals("AD"))
	{
%>
	<td class="<%=strStyleCls%>" width="5%"><%=strUserId%></td>
	<td class="<%=strStyleCls%>" width="9%"><%=strSiteId%></td>
<%
	}
%>
	 <td class="<%=strStyleCls%>" width="9%"><%=sCreatedDate%></td> 
	 <td class="<%=strStyleCls%>" width="9%"><%=sName%></td>
	 <td  class="<%=strStyleCls%>" width="9%"><%=sDivName%></td>
	 <td class="<%=strStyleCls%>" width="9%"><%=sSiteName%></td>
	 <td class="<%=strStyleCls%>" width="9%"><%=sDeptName%></td>
     <td class="<%=strStyleCls%>" width="9%"><%=sDesigid%></td>
	 <td class="<%=strStyleCls%>" width="9%"><%=sUsername%></td>   
    
<%
//New Check for local administrator
	if(SuserRole.trim().equals("AD"))
	{
%>
<!--Changed on 17 May by Sachin start-->
      <!-- <td class="<%//=strStyleCls%>" width="9%"><%//=sPswd%></td> -->
<!--Changed on 17 May by Sachin start-->
<%
	}
%>
    <td class="<%=strStyleCls%>" width="9%"><%=sEmail%></td>
    <td class="<%=strStyleCls%>" width="9%"><%=sRole%></td>

	<td class="<%=strStyleCls%>" width="9%"><%=sApproverLevel%></td>
    <td class="<%=strStyleCls%>" width="9%" align="center" nowrap="nowrap"><a href="M_UnitHeadDelete.jsp?userId=<%=strUserId%>&siteId=<%=strSiteId%>" onClick="return  deleteConfirm();"><%=dbLabelBean.getLabel("link.createeditlist.delete",strsesLanguage)%></a></td>
  </tr>
<%
		iSno++;				
	}
	rs.close();
	dbConBean.close();    //Close Connection
/*}
catch(Exception e)
{
	Date dd = new Date();
    SimpleDateFormat sdf = new SimpleDateFormat("dd MMM yyyy hh:mm:ss zzz");		   
	String strLog = sdf.format(dd)+"::  Error in M_userList.jsp ====\n"+e;
	dbUtilityBean.appendToLog(strLog);		   
}*/
	
%>
 <tr>
    <td height="1" colspan="2" align="center" class="bodyline-bottom"></td>
  </tr>
</table>
</body>
</html>
