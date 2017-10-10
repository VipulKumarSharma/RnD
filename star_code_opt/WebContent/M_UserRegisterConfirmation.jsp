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
 *Modification 			: 1. added code  for showing status when report to person  is not selected on 21 june 07  by shiv 
                        2. Code changed for change the color of text  on 12-Jul-07 by shiv 
						3. Code added for shown Identity Proof name & number on 23-Oct-07 by shiv 
						4: Added  new fields for windows user id,domian id  on 05-02-2009 by shiv sharma  
						5: change text domian name to network domain name on 25 feb 2010  by shiv sharma 

 *Reason of Modification: 
 *Date of Modification  : 
 *Revision History		:
 *Editor				:Editplus
 *******************************************************/
%>
<html>
<head>
<%@ page import = "java.sql.*" pageEncoding="UTF-8"%>
<%-- include remove cache  --%>
<%@ include  file="cacheInc.inc" %>
<%-- include header  --%>
<%@ include  file="headerIncl.inc" %>
<%-- include page with all application session variables --%>
<%--	<%@ include  file="application.jsp" %> --%>

<%@ include  file="importStatement.jsp" %>

<% 
%>

<!--Connection get by user bean-->
<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbConBean1" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbConBean2" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>

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
	request.setCharacterEncoding("UTF-8");
	ResultSet objRs,objRs1 = null;
	String strSql   =  "";

		
    String strCloseFlag = request.getParameter("closeFlag")==null?"outside":request.getParameter("closeFlag");
	String  strFlag = request.getParameter("flag");
	String strUserName = request.getParameter("ID");
	String strUserId   = request.getParameter("userId");
	String strSiteId   = request.getParameter("siteId");

	String langselected = request.getParameter("langselected")==null?"en_US":request.getParameter("langselected");
	//String langselected = "ja_JP";
    //System.out.println("language is--->"+langselected);
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
	String passportIssuCountry= "";
	String nationality		  = "";
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

//	Added by shiv  Sharma on  18-Oct-2007 
 	String strIdentityproof		="";
	String strIdentityproofNo		="";
	String strIdentityproofname="";
	String strMiddleName       ="";
	String strReportPerson		="";
	
	String strWinUserID             =""; 
	String strDomainName			="";


//
	//Mukesh Mishra
	String strFFNo3="";
	String strFFNo4="";
	String strAirLineName3	  =	"";
	String strAirLineName4	  =	"";
	String hotelChain="";
	String hotelChain1="";
	String hotelChain2="";
	String hotelChain3="";
	String hotelChain4="";
	String hotelNumber="";
	String hotelNumber1="";
	String hotelNumber2="";
	String hotelNumber3="";
	String hotelNumber4="";
	
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

	

   // Query changes for windows user id,domian name by shiv shrama on 05-02-2009    
	strSql = "SELECT FIRSTNAME, LASTNAME, USERNAME,EMAIL, .DBO.DIVISIONNAME(DIV_ID) AS DIVISIONNAME, "+
	" .DBO.SITENAME(SITE_ID) AS SITENAME, .DBO.DEPARTMENTNAME(DEPT_ID) AS DEPARTMENTNAME,  "+
	" .DBO.DESIGNATIONNAME(DESIG_ID) AS DESIGNATIONNAME, REPORT_TO, ISNULL(SECRET_QUESTION,'') AS SECRET_QUESTION , "+
    " ISNULL(SECRET_ANSWER,'') AS SECRET_ANSWER, ISNULL(PASSPORT_NO,'') AS PASSPORT_NO, ISNULL((select COUNTRY_NAME from M_COUNTRY where COUNTRY_ID=M_USERINFO.PASSPORT_ISSUE_COUNTRY),'-') AS PASSPORT_ISSUE_COUNTRY, ISNULL(ECNR,'') AS ECNR,  "+
	" ISNULL(.DBO.CONVERTDATEDMY1(DATE_ISSUE),'') AS DATE_ISSUE,ISNULL(.DBO.CONVERTDATEDMY1(EXPIRY_DATE),'') AS EXPIRY_DATE, "+
	"	ISNULL(PLACE_ISSUE,'') AS PLACE_ISSUE, ISNULL(.DBO.CONVERTDATEDMY1(DOB),'') AS DOB,  ISNULL(FF_NUMBER,'') AS FF_NUMBER,"+
	"	ISNULL(FF_NUMBER1,'') AS FF_NUMBER1, ISNULL(FF_NUMBER2,'') AS FF_NUMBER2,ISNULL(FF_NUMBER3,'') AS FF_NUMBER3,ISNULL(FF_NUMBER4,'') AS FF_NUMBER4,ISNULL(CONTACT_NUMBER,'') AS CONTACT_NUMBER, "+
	"	ISNULL(ADDRESS,'')AS ADDRESS,	ISNULL(CURRENT_ADDRESS,'') AS CURRENT_ADDRESS, ISNULL(FF_AIR_NAME,'') AS FF_AIR_NAME, "+
	"	ISNULL(FF_AIR_NAME1,'') AS FF_AIR_NAME1, ISNULL(FF_AIR_NAME2,'') AS FF_AIR_NAME2 ,ISNULL(FF_AIR_NAME3,'') AS FF_AIR_NAME3 ,ISNULL(FF_AIR_NAME4,'') AS FF_AIR_NAME4 ,ISNULL(HOTEL_NAME,'') AS HOTEL_NAME,ISNULL(HOTEL_NAME1,'') AS HOTEL_NAME1, "+
	"ISNULL(HOTEL_NAME2,'') AS HOTEL_NAME2,ISNULL(HOTEL_NAME3,'') AS HOTEL_NAME3,ISNULL(HOTEL_NAME4,'') AS HOTEL_NAME4,ISNULL(HOTEL_NUMBER,'') AS HOTEL_NUMBER,ISNULL(HOTEL_NUMBER1,'') AS HOTEL_NUMBER1,ISNULL(HOTEL_NUMBER2,'') AS HOTEL_NUMBER2,ISNULL(HOTEL_NUMBER3,'') AS HOTEL_NUMBER3,ISNULL(HOTEL_NUMBER4,'') AS HOTEL_NUMBER4,	EMP_CODE,IDENTITY_ID,IDENTITY_NO,MIDDLENAME,WIN_USER_ID, DOMAIN_NAME , nationality"+
    " FROM M_USERINFO WHERE USERID="+strUserId+" AND USERNAME = N'"+strUserName+"' AND STATUS_ID=30 AND APPLICATION_ID=1";

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
		passportIssuCountry = objRs.getString("PASSPORT_ISSUE_COUNTRY");
		String strECNR_Status = "";
		String strECNR			   = "";
		strECNR_Status			   =		objRs.getString("ECNR") ;
		if (strECNR_Status.trim().equals("1")) {
			strECNR	=	"Yes";
		}
		else if (strECNR_Status.trim().equals("2")) {
			strECNR	=	"No";
		} 
		else if (strECNR_Status.trim().equals("3")) {
			strECNR	=	"N/A";
		}

		strDateOfIssue	    = objRs.getString("DATE_ISSUE");
		strDateOfExpire	    = objRs.getString("EXPIRY_DATE");

		strPlaceOfIssue		= objRs.getString("PLACE_ISSUE");
		strDOB			    = objRs.getString("DOB");

		strFFNo			    = objRs.getString("FF_NUMBER");
		strFFNo1		    = objRs.getString("FF_NUMBER1");
		strFFNo2		    = objRs.getString("FF_NUMBER2");
		strFFNo3		    = objRs.getString("FF_NUMBER3");
		strFFNo4		    = objRs.getString("FF_NUMBER4");

		strContactNo	    = objRs.getString("CONTACT_NUMBER");	
		strPerAddress	    = objRs.getString("ADDRESS");	
		strCurrentAddress	    = objRs.getString("CURRENT_ADDRESS");	
		strAirLineName	    = objRs.getString("FF_AIR_NAME");
		strAirLineName1	    = objRs.getString("FF_AIR_NAME1");
		strAirLineName2	    = objRs.getString("FF_AIR_NAME2");
		strAirLineName3	    = objRs.getString("FF_AIR_NAME3");
		strAirLineName4	    = objRs.getString("FF_AIR_NAME4");
		hotelChain          =objRs.getString("HOTEL_NAME");
		hotelChain1          =objRs.getString("HOTEL_NAME1");
		hotelChain2          =objRs.getString("HOTEL_NAME2");
		hotelChain3          =objRs.getString("HOTEL_NAME3");
		hotelChain4          =objRs.getString("HOTEL_NAME4");
		hotelNumber          =objRs.getString("HOTEL_NUMBER");
		hotelNumber1          =objRs.getString("HOTEL_NUMBER1");
		hotelNumber2          =objRs.getString("HOTEL_NUMBER2");
		hotelNumber3          =objRs.getString("HOTEL_NUMBER3");
		hotelNumber4          =objRs.getString("HOTEL_NUMBER4");

		strEmpcode			= objRs.getString("EMP_CODE");

		//	Added by shiv  Sharma on  18-Oct-2007 
		strIdentityproof			= objRs.getString("IDENTITY_ID");
		strIdentityproofNo			= objRs.getString("IDENTITY_NO");
		
		strMiddleName     = objRs.getString("MIDDLENAME"); 
		
		
		strWinUserID       =objRs.getString("WIN_USER_ID"); 	
		strDomainName	   =objRs.getString("DOMAIN_NAME");
		nationality		   =objRs.getString("nationality");		 
		
		 

		
	/*	if(strIdentityproof.equals("0")) 
		{
			strIdentityproof="-1";
		}
*/
		


%>
<!-- Start of body -->
	<body >
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
      
    </table>
	<table width="100%" border="0" cellspacing="0" cellpadding="10">
	 	
	</table>

<!-- Start of Form -->
<form name="frm" method="post" action="RegisterUser" onSubmit="javascript:return checkData();">
<br>
	<table width="100%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder">
		<tr align="left">
  			<td  colspan="4" class="selectedmenubg">
		   <!--  code changed for change the color of text  on 12-Jul-07 by shiv  open    -->
	      <b> 
    		<li class="pageHead"><%=dbLabelBean.getLabel("label.register.congratulationsregisteredsuccessfully",langselected)%>  <FONT SIZE="2" COLOR="#FF0000"><li class="pageHead"><FONT SIZE="2" COLOR="#FF3300">  <%=dbLabelBean.getLabel("label.register.loginafterlocaladministrator",langselected)%> </FONT></li>
				</td> 
		</tr>
  		   <!--  code changed for change the color of text  on 12-Jul-07 by shiv close   -->
		<tr align="left">
  			<td colspan="4" class="dataLabel"> <%=dbLabelBean.getLabel("label.register.youruseridinformation",langselected)%> </td>
  		</tr>
	</table>
	
	<div id="targetDiv" style="margin:0 auto; width:100%; height:520px; overflow-y:scroll;">
		<table width="100%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder">
			<tr align="left">
				<td width="180" class="formtr1"><%=dbLabelBean.getLabel("label.global.firstname",langselected)%>  </td>
				<td width="290" class="formtr11"><%= strFirstName %></td>
	
				<td width="180" class="formtr1"><%=dbLabelBean.getLabel("label.mylinks.middlename",langselected)%>  </td>
				<td width="290" class="formtr1"><span class="formtr11"><%= strMiddleName%></span></td>  
				
			</tr>
			
				<tr align="left">
				
	
				<td width="180" class="formtr1"><%=dbLabelBean.getLabel("label.global.lastname",langselected)%>  </td>
				<td width="290" class="formtr1"><span class="formtr11"><%= strLastName%></span></td>
				
				<td width="180" class="formtr1">  </td>
				<td width="290" class="formtr11"> </td>
			</tr>
			<tr align="left">
	            <td width="180" class="formtr1"><%=dbLabelBean.getLabel("label.mail.username",langselected)%>  </td>
				<td width="290" class="formtr1"><span class="formtr11"><%= strUserName %></span></td> 
				<td class="formtr1"><%=dbLabelBean.getLabel("label.mylinks.email",langselected)%> </td>
				<td class="formtr1"><span class="formtr11"><%= strEmail %></span></td>
	 		</tr>
			<tr align="left">	
				<td class="formtr1"><%=dbLabelBean.getLabel("label.requestdetails.unit",langselected)%> </td>
				<td class="formtr1"><span class="formtr11"><%= strSiteName %></span></td>
				<td class="formtr1"><%=dbLabelBean.getLabel("label.requestdetails.department",langselected)%> </td>
				<td class="formtr1"><span class="formtr11"><%= strDeptName %></span></td>
			</tr>
			<tr align="left">	
				<td class="formtr1"><%=dbLabelBean.getLabel("label.global.designation",langselected)%> </td>
				<td class="formtr1"><span class="formtr11"><%= strDesigName %></span></td>
					<td class="formtr1"> <%=dbLabelBean.getLabel("label.register.reportto",langselected)%> </td>
				<%
	               /// added code  for showing status when report to person  is not selected on 21 june 07 open
					if(strReport_To.equals("0")) 
			        {
	                 strReport_To = "-1";
					}
					/// added code  for showing status when report to person  is not selected on 21 june 07 close 
	
				strSql = "SELECT DISTINCT ISNULL(.DBO.USER_NAME(REPORT_TO),'-')  AS REPORTING_PERSON FROM M_USERINFO WHERE  REPORT_TO ="+strReport_To;
				//System.out.println("sql querty"+ strSql);
	
				objRs1			=			dbConBean1.executeQuery(strSql);
				while (objRs1.next()) {
				
						strReportPerson= objRs1.getString("REPORTING_PERSON"); 
				}  	
				 objRs1.close();    
				  dbConBean1.close();%>		
				  
				  <td class="formtr1"><span class="formtr11"><%= strReportPerson %></span></td>
		   </tr>
					
					<tr>
	                     <td class="formtr1"><font size="" color="#FF3300"></font> <%=dbLabelBean.getLabel("label.mylinks.employeecode",langselected)%></td><td width="290" class="formtr1"><%=strEmpcode%></td>
	                        <!-- code changed  by shiv on 23-Oct-07  for showing Identity proof name & number  -->
							 	<%	
										 strSql = "SELECT ISNULL(IDENTITY_NAME,'') AS IDENTITY_NAME  FROM m_IDENTITY_PROOF WHERE IDENTITY_ID="+strIdentityproof+" and STATUS_ID=10 ";
										objRs1 = dbConBean2.executeQuery(strSql); 
								
										while(objRs1.next()) 
										{ 
											strIdentityproofname =objRs1.getString("IDENTITY_NAME").trim(); 
								        }
										objRs1.close();
	
									 dbConBean2.close();
								 
								%>
	
	                     <td class="formtr1"><%=dbLabelBean.getLabel("label.global.proofofidentity",langselected)%></td><td class="formtr1"><%=strIdentityproofname%> - <%=strIdentityproofNo%> </td>
					</tr>
	                  <!-- 2/28/2007 -->
	                  <!-- added on 03-02-2009 for domian bank and wondow user id  open  -->
	                    <tr>
						<!--10/18/2007 by shiv  open-->
						<td class="formtr1"><font size="" color="#FF3300"></font>&nbsp;<%=dbLabelBean.getLabel("label.mylinks.windowsuserid",langselected)%></td>
						<td width="290" class="formtr1"><%=strWinUserID%>
						 <td class="formtr1"><%=dbLabelBean.getLabel("label.mylinks.networkdomainname",langselected)%> <font size="" color="#FF3300"></font> </td>
								  <td class="formtr1">
								<%=strDomainName%>
							</td>
						   <!--End Modification-->
						</tr>
	                  
	                   <!-- added on 03-02-2009 for domian bank and wondow user id  close  -->
			<tr align="center">
			<td colspan="4" align="left" class="dataLabel"><%=dbLabelBean.getLabel("label.mylinks.ifyouforgetyourpassword",langselected)%></td>
			</tr>
				<tr align="center">
				<td class="formtr1"> <%=dbLabelBean.getLabel("label.mylinks.secretquestion",langselected)%>  </td>
				<td class="formtr1"><span class="formtr11"><%= strSecretQuestion %></span></td>
				<td class="formtr1"><span style="display:none"><%=dbLabelBean.getLabel("label.mylinks.secretanswer",langselected)%> </span></td>
				<td class="formtr1"><span class="formtr11" style="display:none"><%= strSecretAnswer %></span></td> 
			</tr>
			<tr align="center">
				<td colspan="4" align="left" class="dataLabel"> <%=dbLabelBean.getLabel("label.register.yourpassportdetails",langselected)%></td>
			</tr>
			<tr align="center">
				<td width="180" class="formtr1"><%=dbLabelBean.getLabel("label.createrequest.passportnumber",langselected)%> </td>
				<td width="290" class="formtr1"><span class="formtr11"><%= strPassportNo%></span></td>
				
				<td width="180" class="formtr1" width="15%"><%=dbLabelBean.getLabel("label.user.nationality",langselected)%></td>
				<td width="290" class="formtr1" colspan="3"><span class="formtr11"><%=nationality%></span></td>
			</tr>
			<tr align="left">
				<td class="formtr1"> <%=dbLabelBean.getLabel("label.visa.passportissuingcountry",langselected)%> </td>
				<td class="formtr1"><span class="formtr11"><%=passportIssuCountry %></span></td>
				
				<td class="formtr1"> <%=dbLabelBean.getLabel("label.createrequest.placeofissue",langselected)%> </td>
				<td class="formtr1"><span class="formtr11"><%=strPlaceOfIssue %></span></td>
			</tr>
			<tr align="left">
		    	<td class="formtr1"><%=dbLabelBean.getLabel("label.global.dateofissue",langselected)%></td>
		    	<td class="formtr1"><span class="formtr11"><%= strDateOfIssue %></span></td>
	
				<td class="formtr1"><%=dbLabelBean.getLabel("label.global.expirydate",langselected)%> </td>
				<td class="formtr1"><span class="formtr11"><%= strDateOfExpire %></span></td>
			</tr>
			<tr align="left">
				<td class="formtr1"><%=dbLabelBean.getLabel("label.global.dob",langselected)%></td>
				<td class="formtr1"><span class="formtr11"><%= strDOB %></span></td>
				
				<td class="formtr1"><%=dbLabelBean.getLabel("label.global.contactno",langselected)%></td>
				<td class="formtr1"><span class="formtr11"><%= strContactNo %></span></td>
			</tr>
			
			<tr align="left">
				<td  class="formtr1"><%=dbLabelBean.getLabel("label.global.emigrationclearancerequired",langselected)%> </td>
				<td  class="formtr1" colspan="3"><span class="formtr11"><%= strECNR  %></span></td>
			</tr>
			
			<tr align="left">
				<td class="formtr1"><%=dbLabelBean.getLabel("label.register.frequentflyernumber",langselected)%></td>
				<td class="formtr1"><span class="formtr11"><%=strAirLineName%> - <%= strFFNo%></span></td>
				
				<td class="formtr1"><%=dbLabelBean.getLabel("label.global.hotelrewardcard",langselected)%></td>
				<td class="formtr1"><span class="formtr11"><%= hotelChain%> - <%= hotelNumber%></span></td>
			</tr>
			<tr align="left">
				<td class="formtr1"></td>
				<td class="formtr1"><span class="formtr11"><%=strAirLineName1%> - <%= strFFNo1 %></span></td>
				<td class="formtr1"></td>
				<td class="formtr1"><span class="formtr11"><%= hotelChain1%> - <%= hotelNumber1%></span></td>
			</tr>
			<tr align="left">
				<td class="formtr1"></td>
				<td class="formtr1"><span class="formtr11"><%=strAirLineName2%> - <%= strFFNo2 %></span></td> 
				<td class="formtr1"></td>
				<td class="formtr1"><span class="formtr11"><%= hotelChain2%> - <%= hotelNumber2%></span></td>
		</tr>
		<tr align="left">
				<td class="formtr1"></td>
				<td class="formtr1"><span class="formtr11"><%=strAirLineName3%> - <%= strFFNo3 %></span></td> 
				<td class="formtr1"></td>
				<td class="formtr1"><span class="formtr11"><%= hotelChain3%> - <%= hotelNumber3%></span></td>
		</tr>
		<tr align="left">
				<td class="formtr1"></td>
				<td class="formtr1"><span class="formtr11"><%=strAirLineName4%> - <%= strFFNo4 %></span></td> 
				<td class="formtr1"></td>
				<td class="formtr1"><span class="formtr11"><%= hotelChain4%> - <%= hotelNumber4%></span></td>
		</tr>
		<tr align="left">
				<td class="formtr1"><%=dbLabelBean.getLabel("label.createrequest.permanentaddress",langselected)%> </td>
				<td class="formtr1"><span class="formtr11"><%= strPerAddress %></span></td>
				<td class="formtr1"><%=dbLabelBean.getLabel("label.createrequest.currentaddress",langselected)%> </td>
				<td class="formtr1"><span class="formtr11"><%=strCurrentAddress%></span></td>
			</tr>
		</table>	
	</div>
	
   <table width="100%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder">	
		<tr align="center"> 
		<td colspan="4" class="formBottom">
		<input type="button" name="Submit2" value="<%=dbLabelBean.getLabel("button.global.close",langselected)%> "class="formButton"  onClick="MM_closeBrWindow('<%=strCloseFlag%>')">			
		</td>
		</tr>
  </table>

	</form>
<%}objRs.close();%>
	<!-- End of Form  -->
	</body>
</html>
