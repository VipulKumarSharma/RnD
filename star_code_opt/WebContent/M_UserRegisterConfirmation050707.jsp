<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:Abhinav Ratnawat
 *Date of Creation 		:24 August 2006
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This is first jsp file  for updating the SITE in the STAR Database
 *Modification 			: 
 *Reason of Modification: 
 *Date of Modification  : 
 *Revision History		:
 *Editor				:Editplus
 *******************************************************/
%>
<html>
<head>
<%-- include remove cache  --%>
<%@ include  file="cacheInc.inc" %>
<%-- include header  --%>
<%@ include  file="headerIncl.inc" %>
<%-- include page with all application session variables --%>
<%--	<%@ include  file="application.jsp" %> --%>
<%@ page import = "java.sql.*" %>
<%@ include  file="importStatement.jsp" %>
<!--Connection get by user bean-->
<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbConBean1" scope="page" class="src.connection.DbConnectionBean" />

<!--Create the DbUtilityMethods object for utility methods-->
<jsp:useBean id="dbUtility" scope="page" class="src.connection.DbUtilityMethods" />

<title>User Registration Screen</title>

	<script language="JavaScript">
		function MM_closeBrWindow(closeFlag) 
		{
		   if(closeFlag != null && closeFlag != "" && closeFlag == "inside")
		   {
			  location.href="M_userList.jsp";
		   }
		   else
		   {
			  window.close();
		   }
		}
		</script>

		<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
</head>
<% 
	
	ResultSet objRs,objRs1 = null;
	String strSql   =  "";

    String strCloseFlag = request.getParameter("closeFlag")==null?"outside":request.getParameter("closeFlag");
	String  strFlag = request.getParameter("flag");
	String strUserName = request.getParameter("ID");
	String strUserId   = request.getParameter("userId");
	String strSiteId   = request.getParameter("siteId");
	String []strUserRoles		 =  null;   //
	String strRoles     = "";

//new 16-02-2007
    String strFirstName = "";
	String strLastName  = "";
    ///2/28/2007
	String strEmpcode  = "";
	///2/28/2007

	String strEmail     = "";
	String strSiteName  = "";
	String strDeptName  = "";
	String strDesigName = "";
	String strReport_To = "";
	String strReportingPerson = "";
	String strSecretQuestion  = "";
	String strSecretAnswer    = "";
	String strPassportNo	  = "";
	String strDateOfIssue	  = "";
	String strDateOfExpire	  = "";
	String strPlaceOfIssue	  = "";
	String strFFNo			  = "";
	String strFFNo1			  = "";
	String strFFNo2			  = "";
	String strDOB			  = "";
	String strContactNo		  = "";	
	String strPerAddress	  = "";	
	
	String strCurrentAddress  =	"";
	String strAirLineName	  =	"";
	String strAirLineName1	  =	"";
	String strAirLineName2	  =	"";

//

//Find the local admin userid of the site
	String strLocalAdminUserId = "";
	boolean bRoleFlag          = false;    
	String strSendStatus       = "no";  // for find when mail goes to Local admin or not
    strSql = "SELECT USERID, RTRIM(LTRIM(ISNULL(ROLE_ID,''))) AS ROLE_ID FROM M_USERROLE WHERE SITE_ID="+strSiteId+" AND STATUS_ID=10";
//System.out.println("strSql is======="+strSql);
	objRs = dbConBean.executeQuery(strSql);
	while(objRs.next())
	{
		strLocalAdminUserId = objRs.getString("USERID");		
		strRoles = objRs.getString("ROLE_ID");		
		//System.out.println("test is==========="+strRoles.length());
		try
		{
			//bRoleFlag = dbUtility.findUserRole(strLocalAdminUserId,"LA");//find user role From M_USERROLE table
			if(!strRoles.equals(""))
			{
				strUserRoles	=  strRoles.split(";");
				for(int i=0; i<strUserRoles.length; i++)
				{
					if(strUserRoles[i].equalsIgnoreCase("LA"))
					{					
						bRoleFlag = true;
					}
				}
			}
			if(bRoleFlag == true)
			{
%>			
				 <jsp:include page="T_MailOnUserRegistration.jsp" flush="true" >
					<jsp:param name="registerUserId" value="<%=strUserId%>"/>
					<jsp:param name="registerUserSiteId" value="<%=strSiteId%>"/>
					<jsp:param name="localAdminUserId" value="<%=strLocalAdminUserId%>"/>	    
				 </jsp:include>			
<%		
				 bRoleFlag = false; 	
				 strSendStatus = "yes";
			}			
		}
		catch(Exception e)
		{
			System.out.println("Error in M_UserRegisterConfirmation.jsp is======"+e);
		}
	}
	objRs.close();

	if(strSendStatus.equals("no"))
	{
		//System.out.println("=========send status is no===========");
	}





//	
	strSql = "SELECT FIRSTNAME, LASTNAME, USERNAME,EMAIL, .DBO.DIVISIONNAME(DIV_ID) AS DIVISIONNAME, .DBO.SITENAME(SITE_ID) AS SITENAME, .DBO.DEPARTMENTNAME(DEPT_ID) AS DEPARTMENTNAME, .DBO.DESIGNATIONNAME(DESIG_ID) AS DESIGNATIONNAME, REPORT_TO, ISNULL(SECRET_QUESTION,'') AS SECRET_QUESTION , ISNULL(SECRET_ANSWER,'') AS SECRET_ANSWER, ISNULL(PASSPORT_NO,'') AS PASSPORT_NO, ISNULL(ECNR,'') AS ECNR, ISNULL(.DBO.CONVERTDATEDMY1(DATE_ISSUE),'') AS DATE_ISSUE,ISNULL(.DBO.CONVERTDATEDMY1(EXPIRY_DATE),'') AS EXPIRY_DATE,ISNULL(PLACE_ISSUE,'') AS PLACE_ISSUE, ISNULL(.DBO.CONVERTDATEDMY1(DOB),'') AS DOB,  ISNULL(FF_NUMBER,'') AS FF_NUMBER,ISNULL(FF_NUMBER1,'') AS FF_NUMBER1, ISNULL(FF_NUMBER2,'') AS FF_NUMBER2,ISNULL(CONTACT_NUMBER,'') AS CONTACT_NUMBER, ISNULL(ADDRESS,'')AS ADDRESS, ISNULL(CURRENT_ADDRESS,'') AS CURRENT_ADDRESS, ISNULL(FF_AIR_NAME,'') AS FF_AIR_NAME, ISNULL(FF_AIR_NAME1,'') AS FF_AIR_NAME1, ISNULL(FF_AIR_NAME2,'') AS FF_AIR_NAME2 ,EMP_CODE FROM M_USERINFO WHERE USERID="+strUserId+" AND USERNAME = '"+strUserName+"' AND STATUS_ID=30 AND APPLICATION_ID=1";
	//System.out.println("strSql is========"+strSql);
	objRs = dbConBean.executeQuery(strSql);
	while(objRs.next()) 
	{
		strFirstName		= objRs.getString("FIRSTNAME");
		strLastName			= objRs.getString("LASTNAME");
		strEmail			= objRs.getString("EMAIL");
		strSiteName			= objRs.getString("SITENAME");
		strDeptName			= objRs.getString("DEPARTMENTNAME");
		strDesigName		= objRs.getString("DESIGNATIONNAME");
		strReport_To		= objRs.getString("REPORT_TO");	

		strSecretQuestion   = objRs.getString("SECRET_QUESTION");
		strSecretAnswer     = objRs.getString("SECRET_ANSWER");
		strPassportNo	    = objRs.getString("PASSPORT_NO");
		String strECNR_Status = "";
		String strECNR			   = "";
		strECNR_Status			   =		objRs.getString("ECNR") ;
		if (strECNR_Status.trim().equals("1"))
			strECNR	=	"Yes";
		else
			strECNR	=	"No";

		strDateOfIssue	    = objRs.getString("DATE_ISSUE");
		strDateOfExpire	    = objRs.getString("EXPIRY_DATE");

		strPlaceOfIssue		= objRs.getString("PLACE_ISSUE");
		strDOB			    = objRs.getString("DOB");

		strFFNo			    = objRs.getString("FF_NUMBER");
		strFFNo1		    = objRs.getString("FF_NUMBER1");
		strFFNo2		    = objRs.getString("FF_NUMBER2");

		strContactNo	    = objRs.getString("CONTACT_NUMBER");	
		strPerAddress	    = objRs.getString("ADDRESS");	
		strCurrentAddress	    = objRs.getString("CURRENT_ADDRESS");	
		strAirLineName	    = objRs.getString("FF_AIR_NAME");
		strAirLineName1	    = objRs.getString("FF_AIR_NAME1");
		strAirLineName2	    = objRs.getString("FF_AIR_NAME2");


		strEmpcode			= objRs.getString("EMP_CODE");

	
	

%>





<!-- Start of body -->
	<body >
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
      
    </table>
	<table width="100%" border="0" cellspacing="0" cellpadding="10">
	 	
	</table>

<!-- Start of Form -->
<form name="frm" method="post" action="RegisterUser" onSubmit="javascript:return checkData();">

	<table width="95%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder">
		<tr align="left">
  			<td  colspan="4" class="selectedmenubg">
			<li class="pageHead">Congratulations! You have been registered successfully on STARS, Login with your <FONT SIZE="2" COLOR="#FF3300">User Name</FONT> is only possible after your <FONT SIZE="2" COLOR="#FF3300">Local Administrator </FONT> confirmation.</li>
			</td>
		</tr>
		
		<tr align="left">
  			<td colspan="4" class="dataLabel"> Your User ID! Information </td>
  		</tr>

		<tr align="left">
			<td width="116" class="formtr1">First Name </span></td>
			<td width="220" class="formtr11"><%= strFirstName %></td>

			<td width="120" class="formtr1">Last Name </span></td>
			<td width="328" class="formtr1"><span class="formtr11"><%= strLastName%></span></td>
		</tr>
		<tr align="left">
            <td width="120" class="formtr1">User Name </span></td>
			<td width="328" class="formtr1"><span class="formtr11"><%= strUserName %></span></td> 
			<td class="formtr1">Email</span></td>
			<td class="formtr1"><span class="formtr11"><%= strEmail %></span></td>
			
		</tr>
		
		<tr align="left">	
			<td class="formtr1">Unit </span></td>
			<td class="formtr1"><span class="formtr11"><%= strSiteName %></span></td>
			<td class="formtr1">Department</span></td>
			<td class="formtr1"><span class="formtr11"><%= strDeptName %></span></td>
		
			
		</tr>
		<tr align="left">	

			
			<td class="formtr1">Designation </span></td>
			<td class="formtr1"><span class="formtr11"><%= strDesigName %></span></td>
			<%
			strSql = "SELECT DISTINCT ISNULL(.DBO.USER_NAME(REPORT_TO),'-')  AS REPORTING_PERSON FROM M_USERINFO WHERE  REPORT_TO ="+strReport_To;
			objRs1			=			dbConBean1.executeQuery(strSql);
			while (objRs1.next()) {
			%>
			<td class="formtr1"> Report to</span></td>
			<td class="formtr1"><span class="formtr11"><%= objRs1.getString("REPORTING_PERSON") %></span></td>
			<% } %>	
				<%objRs1.close(); %>
				<% dbConBean1.close();%>		
	   </tr>
				<!-- 2/28/2007 -->
				<tr>

					
                     <td class="formtr1"><font size="" color="#FF3300"></font> Employee Code</td><td width="328" class="formtr1"><%=strEmpcode%></td>
                     <td class="formtr1">&nbsp;</td><td class="formtr1">&nbsp;</td>
				</tr>
                  <!-- 2/28/2007 -->
		<tr align="center">
		<td colspan="4" align="left" class="dataLabel">If You Forget Your Password!</td>
		</tr>
			<tr align="center">
			<td class="formtr1"> Secret Question </span></td>
			<td class="formtr1"><span class="formtr11"><%= strSecretQuestion %></span></td>

			<td class="formtr1"><span style="display:none">Secret Answer </span></td>
			<td class="formtr1"><span class="formtr11" style="display:none"><%= strSecretAnswer %></span></td> 
		</tr>

		<tr align="center">
			<td colspan="4" align="left" class="dataLabel"> Your Passport Details!</td>
		</tr>
		<tr align="center">
			<td width="116" class="formtr1">Passport No</span></td>
			<td width="220" class="formtr1"><span class="formtr11"><%= strPassportNo%></span></td>

			<td width="120" class="formtr1">Emigration Clearance Required</span></td>
			<% 
			
			%>
			<td width="328" class="formtr1"><span class="formtr11"><%= strECNR  %></span></td>
		</tr>
		<tr align="left">
	    	<td class="formtr1">Date of Issue</td>
	    	<td class="formtr1"><span class="formtr11"><%= strDateOfIssue %></span></td>

			<td class="formtr1">Expiry date </td>
			<td class="formtr1"><span class="formtr11"><%= strDateOfExpire %></span></td>
						
			
			
		</tr>
		<tr align="left">
			
			<td class="formtr1">Frequent Flyer Number</td>
			<td class="formtr1"><span class="formtr11"><%=strAirLineName%> - <%= strFFNo%></span></td>

			<td class="formtr1">DOB</td>
			 <td class="formtr1"><span class="formtr11"><%= strDOB %></span></td>
		</tr>
		<tr align="left">


			<td class="formtr1"></td>
			<td class="formtr1"><span class="formtr11"><%=strAirLineName1%> - <%= strFFNo1 %></span></td>

			<td class="formtr1"> Place of issue </td>
			<td class="formtr1"><span class="formtr11"><%= strPlaceOfIssue %></span></td>

			
		</tr>
		<tr align="left">

			<td class="formtr1"></td>
			<td class="formtr1"><span class="formtr11"><%=strAirLineName2%> - <%= strFFNo2 %></span></td> 

			<td class="formtr1"> Mobile Number</td>
			<td class="formtr1"><span class="formtr11"><%= strContactNo %></span></td>

	</tr>
	<tr align="left">
			<td class="formtr1">Permanent Address </td>
			<td class="formtr1"><span class="formtr11"><%= strPerAddress %></span></td>

			<td class="formtr1">Current Address </td>
			<td class="formtr1"><%=strCurrentAddress%></td>
		</tr>

			<tr align="center"> 
			<td colspan="4" class="formBottom">
			<input type="button" name="Submit2" value="Close "class="formButton"  onClick="MM_closeBrWindow('<%=strCloseFlag%>')">			
			</td>
			</tr>
  </table>

	</form>
<%}objRs.close();%>

	<!-- End of Form  -->
	</body>
</html>
