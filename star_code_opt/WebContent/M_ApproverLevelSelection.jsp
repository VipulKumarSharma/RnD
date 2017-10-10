<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:SACHIN GUPTA
 *Date of Creation 		:16 Jan 2007
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This jsp file  for showing the deactive user information to the administrator from  M_USERINFO in the STAR *Modification 		   :1. Invisible Password information to super Admin 
 *Reason of Modification:1. Password Security Purpose 
 *Date of Modification  :1. 17 May 2007 
 *Modified By			:1. Sachin Gupta 
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

String	sSqlStr         =    "";                         // For sql Statements
int iCls                =    0;
String strStyleCls      =    "";
String strMessage       =    URLDecoder.decode((request.getParameter("message")==null)?"":request.getParameter("message"), "UTF-8");
String strUserId        =	 request.getParameter("userId"); 
String strNextPage      =    request.getParameter("nextPage");  



%>

<!--Java Script-->
<script language=JavaScript >
function activeConfirm()
{

if(confirm('<%=dbLabelBean.getLabel("alert.master.areyousureyouwanttoactivetherecord",strsesLanguage)%>'))
	return true;
else
	return false;
}
</script>

<script language="JavaScript">

 
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
	    <ul class="pagebullet"><li class="pageHead"><%=dbLabelBean.getLabel("label.master.selecttheactivateduserapproverlevel",strsesLanguage)%> </li><font color="red"><%=strMessage%></font>
	    </ul>
	  </td>
      <td width="30%" align="right" valign="bottom" class="bodyline-top">
   	    <table width="43%" align="right" border="0" cellspacing="0" cellpadding="0">
          <tr align="right">
          </tr>
        </table>
	  </td> 
    </tr>
  </table>

  <br>
  <table width="100%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder">
  <tr> 
    <td width="5%" class="formhead"><%=dbLabelBean.getLabel("label.global.sno",strsesLanguage)%></td>
    <td width="9%" class="formhead"><%=dbLabelBean.getLabel("label.requestdetails.division",strsesLanguage)%></td>
    <td width="9%" class="formhead"><%=dbLabelBean.getLabel("label.requestdetails.unit",strsesLanguage)%></td>
    <td width="9%" class="formhead"><%=dbLabelBean.getLabel("label.requestdetails.department",strsesLanguage)%></td>
	<td width="11%" class="formhead"><%=dbLabelBean.getLabel("label.mylinks.employeecode",strsesLanguage)%></td>
    <td width="9%" class="formhead"><%=dbLabelBean.getLabel("label.requestdetails.name",strsesLanguage)%></td>
	<td width="9%" class="formhead"><%=dbLabelBean.getLabel("label.global.designation",strsesLanguage)%></td>
    <td width="9%" class="formhead"><%=dbLabelBean.getLabel("label.mail.username",strsesLanguage)%></td>
<!--Changed on 17 May by Sachin start-->
    <!--<td width="9%" class="formhead">Pin</td>-->
<!--Changed on 17 May by Sachin end-->
    <td width="9%" class="formhead"><%=dbLabelBean.getLabel("label.mylinks.email",strsesLanguage)%></td>
    <td width="9%" class="formhead"><%=dbLabelBean.getLabel("label.master.role",strsesLanguage)%></td>
	<td width="9%" class="formhead"><%=dbLabelBean.getLabel("label.master.approverlevel",strsesLanguage)%></td>
    <td width="9%" class="formhead" nowrap="nowrap"><%=dbLabelBean.getLabel("label.global.createdon",strsesLanguage)%></td>   
  </tr>

<%
	int iSno                         = 1;
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
	String sArrroverLevelName        = "";
	String sEmpcode                  = "";

	// Customer funded projects and item wise booking
	//Sql to get the the item list and sanction_dtl_id from sanction_detail
        sSqlStr="SELECT USERID, dbo.DIVISIONNAME(DIV_ID) AS DIV,dbo.SITEDETAILS(SITE_ID) AS SITE,ISNULL(dbo.DEPARTMENTNAME(DEPT_ID),'-') AS DEPT,RTRIM(dbo.USER_NAME(USERID)) AS UNAME,dbo.CONVERTDATE(C_DATE) AS CREATEDDATE,USERNAME ,EMAIL,ISNULL(ROLE_ID,'') AS ROLE,PIN,USERID,dbo.DESIGNATIONNAME(DESIG_ID) AS DESIG_ID,PIN AS PIN1,LTRIM(RTRIM(ISNULL(APPROVER_LEVEL,'0'))) AS APPROVER_LEVEL,LTRIM(RTRIM(ISNULL(EMP_CODE,'-'))) AS EMP_CODE FROM M_USERINFO WHERE USERID="+strUserId+" AND STATUS_ID=10 AND APPLICATION_ID=1  ORDER BY 1,2,3,4 ";

//New Check for local administrator
	/*if((SuserRoleOther.trim().equals("LA")))
	{
		sSqlStr="SELECT USERID, dbo.DIVISIONNAME(DIV_ID) AS DIV,dbo.SITEDETAILS(SITE_ID) AS SITE,ISNULL(dbo.DEPARTMENTNAME(DEPT_ID),'-') AS DEPT,RTRIM(dbo.USER_NAME(USERID)) AS UNAME,dbo.CONVERTDATE(C_DATE) AS CREATEDDATE,USERNAME ,EMAIL,ISNULL(ROLE_ID,'') AS ROLE,PIN,USERID,dbo.DESIGNATIONNAME(DESIG_ID) AS DESIG_ID,PIN AS PIN1 FROM M_USERINFO WHERE STATUS_ID=10 AND SITE_ID="+strSiteIdSS+" AND USERID="+strUserId+" AND APPLICATION_ID=1  ORDER BY 1,2,3,4 ";
	}*/
//



  	rs   = dbConBean.executeQuery(sSqlStr);//stmt.executeQuery(sSqlStr);
	while(rs.next())
	{
		strUserId           = rs.getString(1);  
		sDivName			= rs.getString(2);
		sSiteName			= rs.getString(3);
		sDeptName			= rs.getString(4);
		sName				= rs.getString(5);
		sCreatedDate		= rs.getString(6);
		sUsername			= rs.getString(7);
		sEmail				= rs.getString(8);
		sRole				= rs.getString(9);
		sPswd				= rs.getString(10);

		//System.out.println("before decrypt ="+ sPswd);
        sPswd               = dbUtilityBean.decryptFromDecimalToString(sPswd); 
		//System.out.println("after decrypt===="+sPswd);

		sUserid				= rs.getString(11);
		sDesigid			= rs.getString(12);
    	sUserPin			= rs.getString(13);

		sApproverLevel      = rs.getString(14); 
		sArrroverLevelName  = dbUtilityBean.getApproverLevelNameFromNo(sApproverLevel);     //Get the label name correspond to the no  
        sEmpcode      = rs.getString("EMP_CODE");  



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
    <td  class="<%=strStyleCls%>" width="9%"><%=sDivName%></td>
    <td class="<%=strStyleCls%>" width="9%"><%=sSiteName%></td>
	<td class="<%=strStyleCls%>" width="9%"><%=sDeptName%></td>

	<td class="<%=strStyleCls%>" width="11%"><%=sEmpcode%></td>

    <td class="<%=strStyleCls%>" width="9%"><%=sName%></td>
    <td class="<%=strStyleCls%>" width="9%"><%=sDesigid%></td>
    <td class="<%=strStyleCls%>" width="9%"><%=sUsername%></td>
<!--Changed on 17 May by Sachin start-->
    <!--<td class="<%=strStyleCls%>" width="9%"><%=sPswd%></td>-->
<!--Changed on 17 May by Sachin end-->
    <td class="<%=strStyleCls%>" width="9%"><%=sEmail%></td>
    <td class="<%=strStyleCls%>" width="9%"><%=sRole%></td>

	<td class="<%=strStyleCls%>" width="9%"><%=sArrroverLevelName%></td>

    <td class="<%=strStyleCls%>" width="9%"><%=sCreatedDate%></td>    
  </tr>
<%
		iSno++;				
	}
	rs.close();
	dbConBean.close();    //Close Connection
	
%>
 <tr>
    <td height="1" colspan="2" align="center" class="bodyline-bottom"></td>
  </tr>
</table>



<br><br>
<table width="100%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder">
  <form name="frm" action="M_ApproverLevelSelection_Post.jsp">
    <tr> 
  	  <td width="2%" class="formhead"><%=dbLabelBean.getLabel("label.master.selecttheapproverlevelforuser",strsesLanguage)%></td>
	  <td width="5%" class="formhead"></td>
	</tr>
	<tr class="<%=strStyleCls%>" align="center">
	  <td class="<%=strStyleCls%>" width="2%"><%=dbLabelBean.getLabel("label.master.approverlevel",strsesLanguage)%></td>
	  <td class="<%=strStyleCls%>" width="5%" >
	    <select name="approverLevel">
		  <option value="0"><%=dbLabelBean.getLabel("label.master.none",strsesLanguage)%></option>
		  <option value="1"><%=dbLabelBean.getLabel("label.global.approvallevel1",strsesLanguage)%></option>
		  <option value="2"><%=dbLabelBean.getLabel("label.global.approvallevel2",strsesLanguage)%></option>
		  <option value="3"><%=dbLabelBean.getLabel("label.global.globalapprover",strsesLanguage)%></option>
		</select>
		<script>
		   document.frm.approverLevel.value='<%=sApproverLevel%>';
		</script>
	  </td>			
	</tr>
	<tr  align="center">
	  <td><input type="submit" value="<%=dbLabelBean.getLabel("button.approverequest.submit",strsesLanguage)%>"/></td> 
	</tr>
	<input type="hidden" name="userId" value="<%=strUserId%>"/> 
	<input type="hidden" name="nextPage" value="<%=strNextPage%>"/> 
  </form>
</table>

</body>
</html>
