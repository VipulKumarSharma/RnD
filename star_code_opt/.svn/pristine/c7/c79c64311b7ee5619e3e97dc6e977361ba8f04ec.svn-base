
<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:SACHIN GUPTA
 *Date of Creation 		:24 August 2006
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This jsp file  for showing user information to the administrator from  M_USERINFO in the STAR Database *Modification 		   :1. Invisible Password information to super Admin 
 *Reason of Modification:1. Password Security Purpose 
 *Date of Modification  :1. 17 May 2007 
 *Modified By			:1. Sachin Gupta 
 *Editor				:Editplus
 *******************************************************/
%>


<%@ include  file="importStatement.jsp" %>
<html>
<head>
<%-- include remove cache  --%>
<%@ include  file="cacheInc.inc" %>
<%-- include header  --%>
<%@ include  file="headerIncl.inc" %>
<%-- include page with all application session variables --%>
<%--@ include  file="application.jsp"--%>
<%-- include page styles  --%>
<%-- <%@ include  file="systemStyle.jsp" %> --%>

<!--Create the DbConnectionBean object for createConnection-->
<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbConBean1" scope="page" class="src.connection.DbConnectionBean" />

<jsp:useBean id="dbUtilityBean" scope="page" class="src.connection.DbUtilityMethods" />
 
<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<%
// Variables declared and initialized
ResultSet rs			=		null;			  // Object for ResultSet
ResultSet rs1			=		null;			  // Object for ResultSet

String	sSqlStr         =       "";                         // For sql Statements
int iCls                =       0;
String strStyleCls      =       "";
String strUserIdnew           = ""; 
String strUsersitenew          = "";




%>

<!--Java Script-->
<script language=JavaScript >
function deleteConfirm()
{

if(confirm('Are you sure you want to deactive the record !'))
	return true;
else
	return false;
}
</script>

<script language="JavaScript">

function resetPassword(userId,email)
{
	if(confirm('Are you sure you want to reset password !'))
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
      <td width="70%" height="45" class="bodyline-top">
	    <ul class="pagebullet"><li class="pageHead">STARS Active User(s)</li>
	    </ul>
	  </td>
      <!--<td width="30%" align="right" valign="bottom" class="bodyline-top">
   	    <table width="43%" align="right" border="0" cellspacing="0" cellpadding="0">
          <tr align="right">

		    <td width="20%" align="right"><a href="#" onClick="MM_openBrWindow('requisitionAttachment_Policy.jsp','POLICY','scrollbars=yes,resizable=no,width=750,height=550')"><img src="images/UploadPolicy.gif?buildstamp=2_0_0" width="93" height="24" border="0"></a></td>

			<td width="20%" align="right"><a href="M_UnitHeadList.jsp"><img src="images/UnitHead.gif?buildstamp=2_0_0" width="83" height="24" border="0" /></a></td>
			<td width="20%" align="right"><a href="M_localAdminUserList.jsp"><img src="images/newTabs/LocalAdmin.gif?buildstamp=2_0_0" width="77" height="24" border="0" /></a></td>

			
			<td width="20%" align="right"><a href="M_deactiveUserList.jsp"><img src="images/newTabs/Deactivated.gif?buildstamp=2_0_0" width="77" height="24" border="0" /></a></td>
            <td width="20%" align="right"><a href="M_UserRegisterByAdmin.jsp?flag=new&closeFlag=inside"><img src="images/IconNew.gif?buildstamp=2_0_0" width="49" height="24" border="0" /></a></td>

            <td width="35%" align="right"><a href="M_userDeisgList.jsp"><img src="images/Assign_Role.gif?buildstamp=2_0_0" width="77" height="24" border="0" /></a></td>

        	<td width="25%" align="right"><a href="#" onClick="MM_openBrWindow('M_searchInitial.jsp','USER','scrollbars=yes,width=800,height=700,resizable=yes')"><img src="images/IconSearch.gif?buildstamp=2_0_0" width="57" height="24" border="0" /></a></td>
            <td width="20%" align="right"><a href="#" onClick="window.print();"><img src="images/IconPrint.gif?buildstamp=2_0_0" width="49" height="24" border="0" /></a></td>
          </tr>
        </table>
	  </td>--> 
    </tr>
  </table>

  <br>
  <table width="100%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder">
  <tr> 
    <td width="5%" class="formhead">S.No</td>
<%
//New Check for local administrator
	//if(SuserRole.trim().equals("AD"))
	//{
%>
	<td width="5%" class="formhead">UserId</td>
<%
	//}
%>
    <td width="9%" class="formhead">Division</td>
    <td width="7%" class="formhead">Unit</td>
    <td width="9%" class="formhead">Department</td>
	<td width="11%" class="formhead">Emp Code</td><!--  3/1/2007   -->
    <td width="9%" class="formhead">Name</td>
	<td width="9%" class="formhead">Designation</td>
    <td width="9%" class="formhead">User Name</td>
<%
//New Check for local administrator
	//if(SuserRole.trim().equals("AD"))
	//{
%>
	<td width="9%" class="formhead">Pin</td>
	
<%
	//}
%>
    <td width="9%" class="formhead">EMail</td>
    <td width="9%" class="formhead">Role</td>
	<td width="9%" class="formhead">Approver Level</td>
    <td width="9%" class="formhead">Created_On</td>
    <!--<td width="9%" class="formhead">Action</td>-->
  </tr>

<%
	int iSno                         = 1;
	String strUserId                 = "";
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
	String sEmpcode                 ="";
	String url								="";	

	// Customer funded projects and item wise booking
	//Sql to get the the item list and sanction_dtl_id from sanction_detail

	//New Check for Super administrator
	
    sSqlStr="SELECT USERID, dbo.DIVISIONNAME(DIV_ID) AS DIV,dbo.SITEDETAILS(SITE_ID) AS SITE,ISNULL(dbo.DEPARTMENTNAME(DEPT_ID),'-') AS DEPT,RTRIM(dbo.USER_NAME(USERID)) AS UNAME,dbo.CONVERTDATE(C_DATE) AS CREATEDDATE,USERNAME ,EMAIL,ISNULL(ROLE_ID,'') AS ROLE,PIN,USERID,dbo.DESIGNATIONNAME(DESIG_ID) AS DESIG_ID,PIN AS PIN1, LTRIM(RTRIM(ISNULL(APPROVER_LEVEL,'0'))) AS APPROVER_LEVEL,LTRIM(RTRIM(ISNULL(EMP_CODE,'-'))) AS EMP_CODE  FROM M_USERINFO WHERE STATUS_ID=10 AND APPLICATION_ID=1  ORDER BY 1,2,3,4 ";
	

//New Check for local administrator
	
 
	    sSqlStr="SELECT USERID, dbo.DIVISIONNAME(DIV_ID) AS DIV,ISNULL(dbo.SITEDETAILS(SITE_ID),'') AS SITE,ISNULL(dbo.DEPARTMENTNAME(DEPT_ID),'-') AS DEPT,ISNULL(RTRIM(dbo.USER_NAME(USERID)),'') AS UNAME,ISNULL(dbo.CONVERTDATE(C_DATE),'') AS CREATEDDATE,USERNAME ,EMAIL,ISNULL(ROLE_ID,'') AS ROLE,PIN,USERID,ISNULL(dbo.DESIGNATIONNAME(DESIG_ID),'')  AS DESIG_ID,PIN AS PIN1, LTRIM(RTRIM(ISNULL(APPROVER_LEVEL,'0'))) AS APPROVER_LEVEL,LTRIM(RTRIM(ISNULL(EMP_CODE,'-'))) AS EMP_CODE  FROM M_USERINFO WHERE STATUS_ID=10 AND APPLICATION_ID=1  ORDER BY 1,2,3,4 ";
  
        
		url="Admin_User_Profile_Edit.jsp";

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
		sApproverLevel      = dbUtilityBean.getApproverLevelNameFromNo(sApproverLevel);     //Get the label name correspond to the no  
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
<%
//New Check for local administrator
	//if(SuserRole.trim().equals("AD"))
	//{
%>
	<td class="<%=strStyleCls%>" width="5%"><%=strUserId%></td>
<%
	//}
%>
    <td  class="<%=strStyleCls%>" width="9%"><%=sDivName%></td>
    <td class="<%=strStyleCls%>" width="7%"><%=sSiteName%></td>
	<td class="<%=strStyleCls%>" width="9%"><%=sDeptName%></td>

     <td class="<%=strStyleCls%>" width="11%"><%=sEmpcode%></td><!-- 3/1/2007 Adding Employee Code -->


    <td class="<%=strStyleCls%>" width="9%"><%=sName%></td>
    <td class="<%=strStyleCls%>" width="9%"><%=sDesigid%></td>
    <td class="<%=strStyleCls%>" width="9%"><%=sUsername%></td>
<%
//New Check for local administrator
	//if(SuserRole.trim().equals("AD"))
	//{
%>
	
    <td class="<%=strStyleCls%>" width="9%"><%=sPswd%></td>
	
<%
	//}
%>
    <td class="<%=strStyleCls%>" width="9%"><%=sEmail%></td>
    <td class="<%=strStyleCls%>" width="9%"><%=sRole%></td>

	<td class="<%=strStyleCls%>" width="9%"><%=sApproverLevel%></td>

    <td class="<%=strStyleCls%>" width="9%"><%=sCreatedDate%></td>

    <!--<td class="<%=strStyleCls%>" width="9%" align="center">-->
		  <!--  Admin_User_Profile_Edit orignal <a href="M_UpdateProfile.jsp?userId=<%=strUserId%>&flag=0"> -->
	<!--<a href="<%//=url%>?userId=<%=strUserId%>&flag=0">Edit</a>| <a href="M_userDelete.jsp?userId=<%//=strUserId%>" onClick="return  deleteConfirm();">Deactive</a>| <a href="M_ApproverLevelSelection.jsp?userId=<%//=strUserId%>&nextPage=activeUserList">Approver Level</a>| <a href="#" onClick="resetPassword('<%//=strUserId%>','<%//=sEmail%>')">ResetPassword</a>

	</td>-->
  </tr>
<%
		iSno++;				
	}
	//rs.close();
	//dbConBean.close();    //Close Connection
/*}
catch(Exception e)
{
	Date dd = new Date();
    SimpleDateFormat sdf = new SimpleDateFormat("dd MMM yyyy hh:mm:ss zzz");		   
	String strLog = sdf.format(dd)+"::  Error in M_userList.jsp ====\n"+e;
	dbUtilityBean.appendToLog(strLog);		   
}*/
	
%>
<% ///////////////NEW CODE ADDES BY SHIV ON  11 -April -2007  open 


 

dbConBean1.close();



//////////////////////4/12/2007 close %>
 <tr>
    <td height="1" colspan="2" align="center" class="bodyline-bottom">   </td>
   	   
	   
  </tr>
</table>
</body>
</html>
