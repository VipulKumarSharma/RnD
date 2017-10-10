	<%
	/***************************************************
	 *The information contained here in is confidential and 
	 * proprietary to MIND and forms the part of the MIND 
	 *Author				:Sachin Gupta
	 *Date of Creation 		:09 March 2007
	 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
	 *Project	  			:STAR
	 *Operating environment :Tomcat, sql server 2000 
	 *Description 			:This is the  jsp file  for inserting the mail information in req_mailbox table
	 *Modification 			:1. Mail subject is changed  by Shiv, VISA & ECR Option  by shiv 
							 2.Change the database query for date format 
							  3.Display the mail Subject in different format 	
							  4. Added by shiv for showing Group Travel in case of group travel   on 25-Feb-08 ;  
							  5:CC mail address is  removed by Shiv Sharma on 03-Apr-08  
							  6: Added by shiv for showing Group Travel in case of group travel   on 02-Jul-08 for Domestice travel 
							  7: Added department name of traveler in intimation mail to HR & AC. on 30 march 2009 by shiv sharma 
							  8: Added Employee code of traveler in intimation mail to HR & AC. on 01 April 09 by shiv sharma 
							  9:Change mail content of Intimation mail of HR/AC,add "This mail is for your information only in mail body. by shiv sharma on 06-Oct-09
	
	
	 *Reason of Modification: 
	 *Date of Modification  : 23/03/2007, 27/03/2007, 28/03/2007,04/04/2007,09/04/2007 
	 *Modified By			: Vijay Singh
	 *Revision History		:
	 *Editor				:Editplus
	 Modified by vaibhav on jul 19 2010 to enable SSO in Mails

	 *Date of Modification	: 09 May 2012
	 *Modified By			: Manoj Chand
	 *Modification			: Correct the spelling of recipient in the mail body
	 
	 *Modified By			:Manoj Chand
	 *Date of Modification  :27-June-2013
 	 *Modification			:change in query to correct the value of travel to.
	 *******************************************************/
	%>
	<%@ page pageEncoding="UTF-8" %>
	<!-- INCLUDE STATEMENTS -->
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
	
	<%@ page import="src.dao.T_QuicktravelRequestDaoImpl" %>
	<!--Create the DbConnectionBean object for createConnection-->
	<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
	<jsp:useBean id="dbUtilityBean" scope="page" class="src.connection.DbUtilityMethods" />
	<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
	<jsp:useBean id="dbutility" scope="page" class="src.connection.DbUtilityMethods" /><!-- Added by vaibhav -->
	
	
	<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
	<%
	request.setCharacterEncoding("UTF-8");
		// Variables declared and initialized
	Connection con					=		null;			    // Object for connection
	Statement stmt	,stmt1,stmt2				=		null;			   // Object for Statement
	ResultSet rs,rs1,rs2					=		null;			  // Object for ResultSet
	CallableStatement cstmt_mail			=		null;			// Object for Callable Statement
	
	//Create Connection
	Class.forName(Sdbdriver);
	con=DriverManager.getConnection(Sdburl,Sdbuser,Sdbpwd);
	
	//DECLARE VARIABLES
	String	sSqlStr															=	""; // For sql Statements
	String strRequistionId													=	null;
	String strRequisitionStatus	    										=	null;
	String strRequistionNumber	 	        								=	null;
	String strMailSubject													=	null;
	String strRequistionGTDate												=	null;
	String strMailRefNumber													=	null;
	String strRequistionCreatorName	 										=	null;
	String strRequistionCreatorMail											=	null;
	String strRequistionCreatedDate											=	null;
	String strRequisitionComments											=	null;
	StringBuffer strMailMsg													=	new StringBuffer();
	String strstrRequistionApproverName										=	null;
	String strstrRequistionApproverEmail									=	null;
	String strstrRequistionApproverDesig									=	null;
	String strRequistionNextApprover_UserId									=	null;
	String strstrRequistionNextApproverName									=	null;
	String strstrRequistionNextApproverEmail								=	null;
	
	
	String strVisaRequired													=  null;
	String strVisaRequiredComment											=  null;
	String strECRRequired													=  null;
	String strTravellerId													=  null;
	
	int		intTries														=	0;
	//strRequistionId															=	request.getParameter("purchaseId");
	String strUserPin														=	null;
	String strSiteName														=	null;
	String strReqVal														=	null;
	String	strUserNm														=	"";
	String	strTravelDate													=	"";
	String	strTravellerSex													=	"";
	String	strSex															=	"";
	String	strSql															=	"";
	String	strTravelFrom													=	"";
	String	strTravelTo														=	"";
	String strSiteId                                                        =   "";        // new
	String ReqTyp															=   "";					
	String	strHrNm															=	"";
	String	strHrMail														=	"";
	String strRoleId														=   "";
	
	String strCreationDate											="";  //added by shiv on 3/20/2007
	String strRoleId1		="";// 04/04/2007 vijay
	String TType			=""; //added by vijay 09/04/2007
	
	String strTravellerSiteId=""; //added by shiv on 02-May-07 
	String  strGroupTravel  ="";
	String  strGroupTravelFlag =""; 
	String  strBillingSite ="";
	String strTraverlDept   ="";
	String strEmpcode		=""; 
	String strtext			="";
	String	strBillingSiteName       =  "";	
	String strTravelAgencyTypeId 	= "";
	
	String strHrNmofownsite	  ="";
	String strHrMailofownsite ="";
	String strTrvType="";
	String strApproverId="";
	String strLanguage	=	"";
	strMailSubject			=   request.getParameter("mailSubject")==null?"":request.getParameter("mailSubject");
	String strMailMessage	=   request.getParameter("mailMessage")==null?"":request.getParameter("mailMessage");
	//System.out.println("strMailSubject--->"+strMailSubject);
	//System.out.println("strMailMessage--->"+strMailMessage);
	ArrayList aList                                                         =   new ArrayList();   
	//GET THE VALUES FROM THE PREVIOUS SCREEN
	strRequistionId															=	request.getParameter("purchaseRequisitionId");
	strRequisitionComments													=	request.getParameter("COMMENTS");
	ReqTyp																	=	request.getParameter("ReqTyp");
	strRoleId																=	request.getParameter("RoleId");
	
	strTravellerSiteId													=	request.getParameter("strTravellerSiteId"); //adddes by shiv on 02-May-07strTravllerSiteId
		
	String strMailSubject1=strMailSubject;
	String ReqTyp1="";
	if(ReqTyp.equals("Domestic Travel")){
		ReqTyp1="label.mail.domestictravel";
	}else{
		ReqTyp1="label.mail.internationaltravel";
	}
	//strUnitHead=	request.getParameter("mailMessage");
	//HR or AC or HRAC
	//FETCH THE LATEST MAIL ID FROM REQ_MAILBOX
	sSqlStr		= "SELECT ISNULL(MAX(MAIL_ID),'999')+1 FROM REQ_MAILBOX";
	stmt		= con.createStatement(); 
	rs			= stmt.executeQuery(sSqlStr);
	if(rs.next())
	{
		strMailRefNumber		=	rs.getString(1);//Mail Reference Number
	}
	rs.close();
	stmt.close();
	
	//ADDED BY MANOJ TO SEND EMAIL FROM CORRECT MAIL ID IN SPECIAL WORKFLOW CASE ON 10 MAY 2012
	if(ReqTyp.equals("Domestic Travel")){
		strTrvType="D";
	}else{
		strTrvType="I";
	}

	sSqlStr=" SELECT TA.APPROVER_ID FROM T_APPROVERS TA"+
		    " inner join VW_PAGE_ACCESS_PERMISSION PAP on pap.viewToUser=TA.PAP_APPROVER"+  
		 	" and pap.pendingWithUser = TA.APPROVER_ID	 WHERE TA.TRAVEL_ID='"+strRequistionId+"'"+ 
		 	" AND TA.ORDER_ID=(SELECT MAX(ORDER_ID) FROM T_APPROVERS WHERE T_APPROVERS.TRAVEL_ID='"+strRequistionId+"'"+ 
		 	" AND SITE_ID='"+strTravellerSiteId+"' AND TRAVEL_TYPE='"+strTrvType+"' AND PAP_APPROVER='"+Suser_id+"' AND PAP_FLAG ='A')"+ 
		 	"AND TA.SITE_ID='"+strTravellerSiteId+"' AND TA.TRAVEL_TYPE='"+strTrvType+"'";
	
	//System.out.println("sSqlStr----hr and ac first-->"+sSqlStr);
	stmt		= con.createStatement(); 
	rs			= stmt.executeQuery(sSqlStr);
	if(rs.next())
	{
		strApproverId		=	rs.getString("APPROVER_ID");
	}
	rs.close();
	stmt.close();
	if(strApproverId==null || strApproverId.equals("")){
		strApproverId=Suser_id;
	}
	 
	
	// FETCH Requistion Details
	//replace suser_id with strApproverId in both of these queries by manoj chand on 10 may 2012
	if(ReqTyp.equals("Domestic Travel"))
	{
		sSqlStr="SELECT TRAVEL_REQ_NO ,.DBO.user_name(C_USERID) AS ORIGINATOR, DBO.USEREMAIL(C_USERID)AS ORIGINATOR_MAIL, .DBO.USER_NAME('"+strApproverId+"') AS APPROVER_NAME,DBO.USEREMAIL('"+strApproverId+"') AS APPROVER_MAIL, ISNULL(RTRIM(.DBO.PRESENTAPPROVER("+strRequistionId+",'D',TRAVELLER_ID)),'NA') AS NEXTWITH, ISNULL(RTRIM(.DBO.PRESENTAPPROVER_USERID("+strRequistionId+",'D',TRAVELLER_ID)),'NA') AS NEXTWITH_USERID, ISNULL(RTRIM(.DBO.PRESENTAPPROVER_MAIL("+strRequistionId+",'D',TRAVELLER_ID)),'NA') AS NEXTWITH_MAIL, convert(varchar(30), C_DATETIME,113), .DBO.USER_NAME(TRAVELLER_ID) AS TRAVELLER_NAME ,convert(varchar(10),TRAVEL_DATE,103),SEX ,.DBO.SITENAME(t.SITE_ID) AS SITE_NAME,t.SITE_ID,TRAVELLER_ID,dbo.DEPTNAME_FROM_USERID(TRAVELLER_ID) as traveler_dept,isnull(EMP_CODE,'') as EMPCODE, T.GROUP_TRAVEL_FLAG, t.BILLING_SITE AS BILLING_SITE_ID, DBO.SITENAME(t.BILLING_SITE) as BILLING_SITE, t.BILLING_CLIENT, (select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = t.SITE_ID) as TRAVEL_AGENCY_ID FROM T_TRAVEL_DETAIL_DOM  t inner join m_userinfo on t.TRAVELLER_ID=m_userinfo.userid  WHERE TRAVEL_ID="+strRequistionId+" ";
	}
	else
	{
		sSqlStr="SELECT TRAVEL_REQ_NO ,.DBO.user_name(C_USERID) AS ORIGINATOR, DBO.USEREMAIL(C_USERID)AS ORIGINATOR_MAIL, .DBO.USER_NAME('"+strApproverId+"') AS APPROVER_NAME, DBO.USEREMAIL('"+strApproverId+"') AS APPROVER_MAIL, ISNULL(RTRIM(.DBO.PRESENTAPPROVER("+strRequistionId+",'I',TRAVELLER_ID)),'NA') AS NEXTWITH, ISNULL(RTRIM(.DBO.PRESENTAPPROVER_USERID("+strRequistionId+",'I',TRAVELLER_ID)),'NA') AS NEXTWITH_USERID, ISNULL(RTRIM(.DBO.PRESENTAPPROVER_MAIL("+strRequistionId+",'I',TRAVELLER_ID)),'NA') AS NEXTWITH_MAIL, convert(varchar(30),C_DATETIME,113),.DBO.USER_NAME(TRAVELLER_ID) AS TRAVELLER_NAME ,convert(varchar(10),TRAVEL_DATE,103), SEX, .DBO.SITENAME(T.SITE_ID) AS SITE_NAME,t.SITE_ID,TRAVELLER_ID,dbo.DEPTNAME_FROM_USERID(TRAVELLER_ID) as traveler_dept,isnull(EMP_CODE,'') as EMPCODE,  T.GROUP_TRAVEL_FLAG, t.BILLING_SITE AS BILLING_SITE_ID, DBO.SITENAME(t.BILLING_SITE) as BILLING_SITE, t.BILLING_CLIENT, (select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = T.SITE_ID) as TRAVEL_AGENCY_ID FROM T_TRAVEL_DETAIL_INT  T inner join m_userinfo on t.TRAVELLER_ID=m_userinfo.userid WHERE TRAVEL_ID="+strRequistionId+"  ";
	}
	
	
	//System.out.println("sSqlStr====01/04/2009=="+sSqlStr);
	
	stmt= con.createStatement(); 
	rs = stmt.executeQuery(sSqlStr);
	if(rs.next())
	{
		strRequistionNumber					=	rs.getString(1);// Number
		strRequistionCreatorName			=	rs.getString(2);//Creator Name
		strRequistionCreatorMail			=	rs.getString(3);//Creator Email
		strstrRequistionApproverName		=	rs.getString(4);//APPROVER NAME
		strstrRequistionApproverEmail		=	rs.getString(5);//APPROVER EMAIL
		strstrRequistionNextApproverName	=	rs.getString(6);//NEXT APPROVER NAME
		strRequistionNextApprover_UserId	=	rs.getString(7);//NEXT APPROVER USER_ID        NEW FIELDS
		strstrRequistionNextApproverEmail	=	rs.getString(8);//NEXT APPROVER MAIL
		//@ Vijay 30-Mar-2007 Add the substring Method for time format
		String strRequistionCreatedDate1			 		=	rs.getString(9);//Req Created Date & time
		String str= strRequistionCreatedDate1.substring(0,17);
		strRequistionCreatedDate=str;
		//End Modification
	
		strUserNm							=	rs.getString(10);//TRAVELLER NAME
		strTravelDate						=	rs.getString(11); // TRAVEL DATE
		strTravellerSex						=	rs.getString(12); // TRAVELLER SEX
		strSiteName							=	rs.getString(13); //site name
		strSiteId                           =	rs.getString(14); //site id  
		strTravellerId						=   rs.getString(15);  //traveller_id
		strTraverlDept						=   rs.getString("traveler_dept").trim();  //traveller dept added on 30 march by shiv sharma 
		strEmpcode							=   rs.getString("EMPCODE").trim();
		
		//Added by Gurmeet Singh to get Billing Client Name on 27/07/2015
		strBillingSiteName       =   rs.getString("BILLING_SITE");					
		String strbillingSiteid		 = rs.getString("BILLING_SITE_ID");  
		String strBillingClientName    = rs.getString("BILLING_CLIENT"); 
		strTravelAgencyTypeId	 	   = rs.getString("TRAVEL_AGENCY_ID");
		
		if(strEmpcode.equals(""))
		{
			//strEmpcode="";	
		}else
		{
				
			strtext="("+strEmpcode+")";	
			
		}
							
		if(strTravellerSex.equals("1"))
		{
			strSex	 =	 "Mr.";
		}
		else
		{
			strSex	 =	 "Ms";
		}
		
		//Added by Gurmeet Singh to get Billing Client Name on 27/07/2015
		if(strbillingSiteid.equals("-1")) { 
			strBillingSiteName=strBillingClientName;  
		}

		if(strbillingSiteid.equals("0")) { 
			strBillingSiteName=strBillingClientName;
		}
					
		if(ReqTyp.equals("Domestic Travel"))
		{
			TType="Domestic Travel Requisition No:";//added by vijay 09/04/2007
			//code commented by manoj chand and replace with new query on 27 june 2013.
			//strSql	=	"SELECT TRAVEL_FROM,TRAVEL_TO FROM T_JOURNEY_DETAILS_DOM WHERE TRAVEL_ID="+strRequistionId+"	";
			strSql ="select * FROM  [dbo].[FN_GetDeparturecity]("+strRequistionId+",'d')";
			 //strGroupTravel = strSex+" "+" <b>"+strUserNm+ "</b> is scheduled to travel."; 
			  //  Added by shiv for showing Group Travel in case of group travel   on 02-Jul-08 ;  
				              strGroupTravelFlag       =   rs.getString("GROUP_TRAVEL_FLAG"); 
			
	
						 	 if(strGroupTravelFlag==null) 
									{
										strGroupTravel =""; 
										strGroupTravelFlag ="N";
				 					}
	
								if(strGroupTravelFlag!=null && (strGroupTravelFlag.trim().equals("Y")) )
									{
									
										 strGroupTravel ="A <B>Group</b> is scheduled to travel."; 
									 }	
								else
										{
										
	                                          strGroupTravel = strSex+" "+" <b>"+strUserNm+" "+strtext+"</b> from <b> "+strTraverlDept+" </b> department is scheduled to travel."; 
								  }
						
		}
		else
		{
	  
	     //  Added by shiv for showing Group Travel in case of group travel   on 25-Feb-08 ;  
				              strGroupTravelFlag       =   rs.getString("GROUP_TRAVEL_FLAG"); 
	
				
						 	 if(strGroupTravelFlag==null) 
									{
										strGroupTravel =""; 
										strGroupTravelFlag ="N";
				 					}
	
								if(strGroupTravelFlag!=null && (strGroupTravelFlag.trim().equals("Y")) )
									{
										//strGroupTravel ="Group"; 
										 strGroupTravel ="A <B>Group</b> is scheduled to travel."; 
									 }	
								else
										{
											// strGroupTravel =""; 
	                                          strGroupTravel = strSex+" "+" <b>"+strUserNm+" "+strtext+" </b> from <B>"+strTraverlDept+"</b> department  is scheduled to travel."; 
								  }
					
	
			TType="International Travel Requisition No:";//added by vijay 09/04/2007
			//code commented by manoj chand and replace with new query on 27 june 2013.
			//strSql	=	"SELECT TRAVEL_FROM,TRAVEL_TO FROM T_JOURNEY_DETAILS_INT WHERE TRAVEL_ID="+strRequistionId+"	";
			strSql ="select * FROM  [dbo].[FN_GetDeparturecity]("+strRequistionId+",'i')";
		}
		
		stmt1= con.createStatement(); 
		rs1 = stmt1.executeQuery(strSql);
		if(rs1.next())
		{
			strTravelFrom	=	rs1.getString(1);
			strTravelTo		=	rs1.getString(2);
		}
		rs1.close();
		stmt1.close();
	
		if(ReqTyp.equals("International Travel"))
		{
			strSql	=	"SELECT ISNULL(VISA_REQUIRED,'1') AS VISA_REQUIRED, ISNULL(VISA_COMMENT,'-') AS VISA_COMMENT FROM T_TRAVEL_DETAIL_INT WHERE TRAVEL_ID="+strRequistionId;
	
			 
			stmt1= con.createStatement(); 
			rs1 = stmt1.executeQuery(strSql);
			if(rs1.next())
			{
				strVisaRequired				=	rs1.getString(1);
				if(strVisaRequired.equals("2")) ///changed by shiv 3/28/2007
					strVisaRequired = "no";
				else
					strVisaRequired = "yes";
				strVisaRequiredComment		=	rs1.getString(2);
			}
			rs1.close();
			stmt1.close();
		}
	
	
		strSql  =  "SELECT ISNULL(ECNR,'1') AS ECNR FROM M_USERINFO WHERE USERID="+strTravellerId;
	
		
		stmt1= con.createStatement(); 
	
		rs1 = stmt1.executeQuery(strSql);
		if(rs1.next())
		{
			strECRRequired				=	rs1.getString("ECNR").trim();
			
			if(strECRRequired.equals("1")) {///changed by shiv 3/28/2007
				strECRRequired = "yes";
			} else if(strECRRequired.equals("2")) {
				strECRRequired = "no";	
			} else if(strECRRequired.equals("3")) {
				strECRRequired = "N/A";	
			}
		}
		rs1.close();
		stmt1.close();
	    
	
		if(strRoleId != null && strRoleId.equals("HR"))
		{
			/*sSqlStr	=	"SELECT DBO.USER_NAME(USERID),EMAIL FROM M_USERINFO WHERE SITE_ID="+strSiteId+" AND ROLE_ID IN ('HR') AND STATUS_ID=10";
			*/
			///query  changed by shiv  on 04-May-07 
			sSqlStr	=	"SELECT DBO.USER_NAME(USERID),EMAIL FROM M_USERINFO WHERE SITE_ID="+strTravellerSiteId+" AND ROLE_ID IN ('HR') AND STATUS_ID=10";
	
			//System.out.println("sSqlStr==1=1/29/2009==="+sSqlStr);
			//stmt1= con.createStatement(); 
			rs1 = dbConBean.executeQuery(sSqlStr);
			while(rs1.next())
			{
				strHrNm			=	rs1.getString(1);
				strHrMail		=	rs1.getString(2);
				aList.add(strHrNm);
				aList.add(strHrMail);
			}
			rs1.close();
		}
		else if(strRoleId != null && strRoleId.equals("AC"))
		{
			/*sSqlStr	=	"SELECT DBO.USER_NAME(USERID),EMAIL FROM M_USERINFO WHERE SITE_ID="+strSiteId+" AND ROLE_ID IN ('AC') AND STATUS_ID=10";
			*/
			///query  changed by shiv  on 04-May-07 
			sSqlStr	=	"SELECT DBO.USER_NAME(USERID),EMAIL FROM M_USERINFO WHERE SITE_ID="+strTravellerSiteId+" AND ROLE_ID IN ('AC') AND STATUS_ID=10";
	
			//System.out.println("sSqlStr=2==1/29/2009==="+sSqlStr);
			//stmt1= con.createStatement(); 
			rs1 = dbConBean.executeQuery(sSqlStr);
			while(rs1.next())
			{
				strHrNm			=	rs1.getString(1);
				strHrMail		=	rs1.getString(2);
				aList.add(strHrNm);
				aList.add(strHrMail);
			}
			rs1.close();
		}
		else if(strRoleId != null && strRoleId.equals("HR&AC"))
		{
			/*sSqlStr	=	"SELECT DBO.USER_NAME(USERID),EMAIL FROM M_USERINFO WHERE SITE_ID="+strSiteId+" AND ROLE_ID IN ('HR','AC') AND STATUS_ID=10";
			*/
	
	
			///Query to find Billing Site 
			if(ReqTyp.equals("International Travel"))
		     {
				  sSqlStr	="SELECT  BILLING_SITE FROM  T_TRAVEL_DETAIL_INT TTIINT WHERE  (TRAVEL_ID = "+strRequistionId+") AND 		  (STATUS_ID = 10)";
			 }else{
						sSqlStr	=	"SELECT  isnull(BILLING_SITE,-1) as BILLING_SITE   FROM T_TRAVEL_DETAIL_DOM TTDDOM WHERE (TRAVEL_ID = "+strRequistionId+") AND (STATUS_ID = 10)";
			 } 
	
			rs1 = dbConBean.executeQuery(sSqlStr);
			while(rs1.next())
			{
				
				strBillingSite		=	rs1.getString(1); 
				
			}
			rs1.close();
	
	
			/*sSqlStr	="SELECT DBO.USER_NAME(USERID),EMAIL FROM M_USERINFO WHERE SITE_ID="+strTravellerSiteId+" AND ROLE_ID IN ('HR','AC') AND STATUS_ID=10";
			*/
	        /// when billing site is not in   -1 and 0      
			if(ReqTyp.equals("International Travel"))
		   {
	
						if (strBillingSite.equals("-1") || strBillingSite.equals("0")){ 
							
							sSqlStr	="SELECT DBO.USER_NAME(USERID),EMAIL FROM M_USERINFO WHERE SITE_ID="+strTravellerSiteId+" AND ROLE_ID IN ('HR','AC') AND STATUS_ID=10";
						}else{
	
							sSqlStr	="SELECT dbo.user_name(MUINFO.USERID), MUINFO.EMAIL FROM  T_TRAVEL_DETAIL_INT TTDINT INNER JOIN "+
								 " M_USERINFO MUINFO ON TTDINT.BILLING_SITE = MUINFO.SITE_ID WHERE     (MUINFO.ROLE_ID IN ('ac','hr')) AND  (MUINFO.STATUS_ID = 10) AND (TTDINT.TRAVEL_ID = "+strRequistionId+")" ;
							
						} 
						
	       }else{ 
	         
	 				  if (strBillingSite.equals("-1") || strBillingSite.equals("0")){   
				
								sSqlStr	="SELECT DBO.USER_NAME(USERID),EMAIL FROM M_USERINFO WHERE SITE_ID="+strTravellerSiteId+" AND ROLE_ID IN ('HR','AC') AND STATUS_ID=10";
								
	  				   }
					  else{
						  sSqlStr	="SELECT dbo.user_name(MUINFO.USERID), MUINFO.EMAIL FROM T_TRAVEL_DETAIL_DOM TTDDOM INNER JOIN "+
						           " M_USERINFO MUINFO ON TTDDOM.BILLING_SITE = MUINFO.SITE_ID WHERE     (MUINFO.ROLE_ID IN ('ac','hr')) AND "+  
						          " (MUINFO.STATUS_ID = 10) AND (TTDDOM.TRAVEL_ID = "+strRequistionId+") " ;
						  
						  
						  
					  }
		   }   
		
			//stmt1= con.createStatement(); 
			rs1 = dbConBean.executeQuery(sSqlStr);
			while(rs1.next())
			{
				strHrNm			=	rs1.getString(1);
				strHrMail		=	rs1.getString(2);
				aList.add(strHrNm);
				aList.add(strHrMail);
			}
			rs1.close();  
		       
	        
	     // this code will send mail to HR & ac person to creator site when user will select the billing site other than his own site 
	        if (strBillingSite.equals("-1") || strBillingSite.equals("0")){     
	        }else{
	        	        	if(!strTravellerSiteId.trim().equals(strBillingSite.trim()))   
	        				{
					        	sSqlStr	="SELECT DBO.USER_NAME(USERID),EMAIL FROM M_USERINFO WHERE SITE_ID in("+strTravellerSiteId+") AND ROLE_ID IN ('AC') AND STATUS_ID=10";
					        	
					        	  
					        	//stmt1= con.createStatement(); 
								rs1 = dbConBean.executeQuery(sSqlStr);
								while(rs1.next())
								{
									strHrNmofownsite			=	rs1.getString(1); 
									strHrMailofownsite		    =	rs1.getString(2); 
									aList.add(strHrNmofownsite);
									aList.add(strHrMailofownsite); 
								}
					  	      rs1.close();
	        	}	
	        }
	       
	     
				
		}
		
	 
		
		Iterator itr =  aList.iterator();
		//added by vijay 09/04/2007 change the mail subject
		//strMailSubject=dbLabelBean.getLabel("label.mail.starsnotification",strLanguage)+TType+" '"+strRequistionNumber.trim()+"' "+strMailSubject;//Mail Subject
		while(itr.hasNext())
		{
				strstrRequistionNextApproverName       = (String) itr.next();
				strstrRequistionNextApproverEmail      = (String) itr.next(); 
				//added by manoj chand on 14 june 2012 to get mail to person language preference
				strSql	=	"SELECT LANGUAGE_PREF FROM M_USERINFO WHERE EMAIL =N'"+strstrRequistionNextApproverEmail+"' AND STATUS_ID=10";
				stmt2= con.createStatement(); 
				rs2 = stmt2.executeQuery(strSql);
				if(rs2.next()){
					strLanguage=rs2.getString("LANGUAGE_PREF");
					if(strLanguage==null || strLanguage.equals("")){
						strLanguage="en_US";
					}
				}
				rs2.close();
				stmt2.close();
				
				
			strMailMsg = new StringBuffer();
	
			//strMailCreatedate
			 strCreationDate=strMailCreatedate; //added  by shiv  on 3/20/2007
			 
			//strMailSubject="Travel Request Approval Requisition No :'"+strRequistionNumber.trim()+"' Received from '"+strSiteName.trim()+"' Approved ";//Mail Subject
			strMailSubject=dbLabelBean.getLabel("label.mail.starsnotification",strLanguage)+TType+" '"+strRequistionNumber.trim()+"' "+dbLabelBean.getLabel(strMailSubject1,strLanguage);//Mail Subject
			try
			{
				String strSSOUrl = dbutility.sSSOUrlByMailid(strstrRequistionNextApproverEmail); //Added by vaibhav
				
				strMailMsg.append("<html><style>.formhead{ font-family:Arial;font-size:11px;font-style: normal;font-weight:normal;color:#000000;text-decoration:none;letter-spacing:normal;word-spacing:normal;border:1px #333333 solid;background:#E2E4D6;}</style><body bgcolor=\"#d0d0d0\">" + "\n");	
				strMailMsg.append(" <table width=80% border=0 cellspacing=0 cellpadding=0 align=center><tr><td align=right><font face=Verdana, Arial, Helvetica, sans-serif size=2><b><font color=#FFFFFF>"+strCreationDate+"</font><font color=#FFFFFF></font><font color=#000000><br></font></b><font color=#FFFFFF>"+dbLabelBean.getLabel("label.mail.forinternalcirculationonly",strLanguage)+"</font></font></td></tr> \n");
				strMailMsg.append("<tr><td bgcolor=#FFFFFF align=center><table width=100% border=0 cellspacing=0 cellpadding=15><tr><td align=center bgcolor=#aa1220><font face=Arial, Helvetica, sans-serif size=5 color=#FFFFFF>"+dbLabelBean.getLabel("label.mail.starsmailnotification",strLanguage)+"</font></td></tr></table></td></tr>"+ "\n");
				strMailMsg.append("<tr><td bgcolor=#FFFFFF><table width=100% border=0 cellspacing=0 cellpadding=5>"+ "\n");						
				strMailMsg.append("  <tr><td align=center bgcolor=#aa1220><font face=Verdana, Arial, Helvetica, sans-serif size=2><b><font color=#FFFFFF><font size=3>"+dbLabelBean.getLabel(ReqTyp1,strLanguage)+" "+dbLabelBean.getLabel("label.mail.requisitionintimation",strLanguage)+"</font> </font></b></font></td></tr><tr><td bgcolor=#878787><font face=Verdana, Arial, Helvetica, sans-serif size=2><b>"+dbLabelBean.getLabel(ReqTyp1,strLanguage)+" "+dbLabelBean.getLabel("label.global.requisitionnumber",strLanguage)+" : "+strRequistionNumber.trim()+"</b>("+dbLabelBean.getLabel("label.mail.dated",strLanguage)+" : "+strRequistionCreatedDate+")</font></td></tr><tr><td><p><font color=#FFFFFF>.</font><font size=2 face=Verdana, Arial, Helvetica, sans-serif><br>"+ "\n");
				if(!strMailMessage.equals("")){
				strRequistionCreatedDate=strRequistionCreatedDate+" ";
				}
				strMailMsg.append(" "+dbLabelBean.getLabel("label.mail.dear",strLanguage)+" "+strstrRequistionNextApproverName+",</font></p><p><font size=2 face=Verdana, Arial, Helvetica, sans-serif>"+dbLabelBean.getLabel("label.global.requisitionnumber",strLanguage)+" "+strRequistionNumber.trim()+" "+dbLabelBean.getLabel("label.mail.wasgeneratedby",strLanguage)+" "+strRequistionCreatorName+" "+dbLabelBean.getLabel("label.mail.from",strLanguage)+" "+strSiteName+ " "+dbLabelBean.getLabel("label.mail.on",strLanguage)+" "+strRequistionCreatedDate+""+dbLabelBean.getLabel(strMailMessage,strLanguage)+".</p>"+ " \n"); 		//added by shiv on 3/23/2007	change 04/04/2007 vijay	
				strMailMsg.append("<u><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>"+dbLabelBean.getLabel("label.mail.requisitionsdetails",strLanguage)+":-</font></u><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif >"+strGroupTravel+"<br> "+dbLabelBean.getLabel("label.mail.departuredateis",strLanguage)+" "+strTravelDate+".  </font>\n<br>"); 
				
 				
				
				if((strTravelAgencyTypeId != null && strTravelAgencyTypeId.equals("2"))) {
					strMailMsg.append(new T_QuicktravelRequestDaoImpl().customizeApproverMailBodyGmbh(strRequistionId, strTrvType, strTravellerId));
				} else {
					strMailMsg.append(new T_QuicktravelRequestDaoImpl().customizeApproverMailBodyIndia(strRequistionId, strTrvType, strTravellerId, strGroupTravelFlag));
				}

// 				strMailMsg.append("<u><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>"+dbLabelBean.getLabel("label.global.departurecity",strLanguage)+": </font></u><font size=2 face=Verdana, Arial, Helvetica, sans-serif >"+strTravelFrom+" </font>\n<br>"); 
// 				strMailMsg.append("<u><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>"+dbLabelBean.getLabel("label.global.arrivalcity",strLanguage)+": </font></u><font size=2 face=Verdana, Arial, Helvetica, sans-serif >"+strTravelTo+" </font>\n<br>"); 

				strMailMsg.append("<u><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>"+dbLabelBean.getLabel("label.requestdetails.billingclient",strLanguage)+": </font></u><font size=2 face=Verdana, Arial, Helvetica, sans-serif >"+strBillingSiteName+" </font>\n<br>"); 
				if(ReqTyp.equals("International Travel") && (strGroupTravelFlag.trim().equals("N")))
				{			
					strMailMsg.append("<u><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>"+dbLabelBean.getLabel("label.global.visarequired",strLanguage)+": </font></u><font size=2 face=Verdana, Arial, Helvetica, sans-serif >"+strVisaRequired+" </font>\n<br>"); 
					strMailMsg.append("<u><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>"+dbLabelBean.getLabel("label.mail.visacomment",strLanguage)+": </font></u><font size=2 face=Verdana, Arial, Helvetica, sans-serif >"+strVisaRequiredComment+" </font>\n<br>"); 
					strMailMsg.append("<u><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>"+dbLabelBean.getLabel("label.mail.ecrrequired",strLanguage)+": </font></u><font size=2 face=Verdana, Arial, Helvetica, sans-serif >"+strECRRequired+" </font>\n<br>"); 
				}
	
	
	
				//strMailMsg.append("<br><font size=2 face=Verdana, Arial, Helvetica, sans-serif><U><FONT COLOR=BLUE>"+strstrRequistionApproverName+" Comments</u><br>"+strRequisitionComments.trim()+" "+ "\n"); 

				strMailMsg.append("</font><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>"+dbLabelBean.getLabel("label.mail.thismailisforyourinformationonly",strLanguage)+" "+ "\n");
				//Commented by vaibhav
				//strMailMsg.append("</font><br><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif><a href=\"http://stars.mindeservices.com\">Please click here to login to STARS </a> "+ "\n");  
				strMailMsg.append("</font><br><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif><a href='"+strSSOUrl+"'>"+dbLabelBean.getLabel("label.mail.pleaseclickheretologintostars",strLanguage)+" </a> "+ "\n");  
				strMailMsg.append("   </b></form></font><br><p><font size=2 face=Verdana, Arial, Helvetica, sans-serif>"+dbLabelBean.getLabel("label.mail.bestregards",strLanguage)+"</font><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif>"+strstrRequistionApproverName.trim()+"<br></font></p></td></tr></table></td></tr><tr><td bgcolor=#878787 align=center> <font face=Verdana, Arial, Helvetica, sans-serif size=2><b>"+dbLabelBean.getLabel("label.mail.mailreferencenumber",strLanguage)+" </b>"+strMailRefNumber+"/"+strCurrentYear+"</font></td></tr><tr><td bgcolor=#FFFFFF align=center>       <table width=100% border=0 cellspacing=0 cellpadding=12>"+ "\n"); 
				strMailMsg.append("<tr><td align=center bgcolor=#aa1220><font size=2 face=Verdana, Arial, Helvetica, sans-serif><b><font size=1>"+dbLabelBean.getLabel("label.mail.starsadministratorcanbecontacted",strLanguage)+" : - </font></b><font size=1><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=#000000>"+ "\n"); 
				strMailMsg.append("<a href=mailto:administrator.stars@mind-infotech.com><font size=1 color=#ffffff>administrator.stars@mind-infotech.com</font></a></font></font></font></td>  "+ "\n");  
				strMailMsg.append(" </tr><tr><td  align=center bgcolor=#878787 height=55> <b><font size=1 face=Verdana, Arial, Helvetica, sans-serif>"+dbLabelBean.getLabel("label.mail.disclaimer",strLanguage)+" : "+dbLabelBean.getLabel("label.mail.thiscommunicationissystemgenererated",strLanguage)+" "+ "\n");  
				strMailMsg.append(dbLabelBean.getLabel("label.mail.pleasedonnotreplytothismail",strLanguage)+" <br>"+dbLabelBean.getLabel("label.mail.ifyouarenotthecorrectrecipient",strLanguage)+"</font></b></td></tr></table></td></tr> \n");    
				strMailMsg.append("<tr><td align=center><font size=2 face=Verdana, Arial, Helvetica, sans-serif><font size=1 color=#000000>&copy;"+dbLabelBean.getLabel("label.mail.mindallrightsreserved",strLanguage)+"</font></font></td>  </tr></table><p>&nbsp;</p></body></html>"+ "\n");
				
	          // System.out.println(">>>>>"+strMailMsg); 
	
				try
				{
					//Procedure for inserting Mail Data
					cstmt_mail=con.prepareCall("{?=call PROC_REQUISITION_MAIL_ADD(?,?,?,?,?,?,?,?,?,?,?,?)}");
					cstmt_mail.registerOutParameter(1,java.sql.Types.INTEGER);
					cstmt_mail.setString(2, strRequistionId);
					cstmt_mail.setString(3, strRequistionNumber);
					cstmt_mail.setString(4, strstrRequistionNextApproverEmail);//To
					cstmt_mail.setString(5, strstrRequistionApproverEmail);//From
					cstmt_mail.setString(6, "");   //CC mail address is  removed by Shiv Sharma on 03-Apr-08 
					cstmt_mail.setString(7, strMailSubject);
					cstmt_mail.setString(8, strMailMsg.toString());
					cstmt_mail.setInt(9, intTries);
					cstmt_mail.setString(10, "NEW");
					cstmt_mail.setString(11, strApproverId);   //added by shiv on 27/3/2007
					cstmt_mail.setString(12, "Approval Process");
					cstmt_mail.setString(13, "Signatory Approves IT");
					cstmt_mail.execute();
					cstmt_mail.close();
				}
				catch(Exception b)
				{
					System.out.println("ERROR in T_requisitionMailOnApproval---1--------"+b);		
				}
			}
			catch(Exception e)
			{
				System.out.println("Error in T_requisitionMailOnApproval--------------2-------------"+e);
			}
		}
	}
	rs.close();
	stmt.close();
	
	%>
	
