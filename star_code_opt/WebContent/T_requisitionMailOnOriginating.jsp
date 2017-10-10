	<%@page import="org.apache.log4j.Level"%>
<%
	/***************************************************
	 *The information contained here in is confidential and 
	 * proprietary to MIND and forms the part of the MIND 
	 *Author				:DEEPALI DHAR
	 *Date of Creation 		:11 September 2006
	 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
	 *Project	  			:STAR
	 *Operating environment :Tomcat, sql server 2000 
	 *Description 			:This is the  jsp file  for inserting the mail information in req_mailbox table
							           2.Change in database query for date format
	 *Modification 			: 3.Display the mail Subject in different format  
	                          4. Added by shiv for showing Group Travel in case of group travel   on 25-Feb-08 
							  5  code added for showing group travel  in case of domestie group travel_DOM  on shiv sharma on 19-Jun-08   
							  6  added a space for formatting on 7/16/2009 by shiv sharma. 
							  7. sending mail on origination for intimation for SMR FRANCE,UK,Spain added on 02-Nov-2009 
	                                    
	 *Reason of Modification: 
	 *Date of Modification  :04/04/2007,09/04/2007
	 *Modified By			: Vijay Singh
	 *Revision History		:
	 *Editor				:Editplus
	 						:Modified by vaibhav on jul 19 2010 to enable SSO in Mails
							:By Vaibhav on sep 22 2010 to add cc mails on request origination
							:By vaibhav on oct 16 2010 to add mailid of reporting person in cc

	*Modified By			:Manoj Chand
	*Date of Modification	:31 Oct 2011
	*Modification			:Remove bug as SELF is showing in billing client in mail for non-smg case. 

	*Modified By			:Manoj Chand
	*Date of Modification	:07 May 2012
	*Modification			:Send mail to reviewer on originating request
	
	*Date of Modification	: 14 Jan 2013
	*Modified By			: Manoj Chand
	*Modification			: resolve issue related to cc mail on submission of request was not send.
	
	*Date of Modification	: 30 Jan 2013
	*Modified By			: Manoj Chand
	*Modification			: Showing requested amounts in multiple currencies in mail
	
	*Date of Modification	: 02 July 2013
	*Modified By			: Manoj Chand
	*Modification			: Change in sql query to get mail id of report_to and mail_cc person
	
	*Modified By			:Manoj Chand
	 *Date of Modification	:22 Oct 2013
	 *Modification			:javascript validation to stop from typing --,'  symbol is added.
	 *******************************************************/ 
	%>
	<!-- INCLUDE STATEMENTS -->
	<%@page import="java.util.*"%>
    <%@page import="java.util.ArrayList"%>
    <%@page import="org.apache.log4j.Logger"%>
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
	<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
	
	<% 
		DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		Calendar cal = Calendar.getInstance();
		
		
	request.setCharacterEncoding("UTF-8");
	
	String isMATA_GmbH = (String)hs.getValue("isMataGmbHSite");
	
	
	// Variables declared and initialized
	Connection con, con1						= null;			    // Object for connection
	Statement stmt,stmt1,stmt2					= null;			   // Object for Statement
	ResultSet rs,rs1,rs2						= null;			  // Object for ResultSet
	CallableStatement cstmt_mail				= null;			// Object for Callable Statement
	
	//Create Connection
	con=dbConBean.getConnection();
	
	//DECLARE VARIABLES
	String strType								= "";
	String strUserId 							= "";
	String strApproverId 						= "";
	String	sSqlStr								= ""; // For sql Statements
	String strRequistionId						= null;
	String strRequisitionStatus					= null;
	String strRequistionNumber	 				= null;
	String strMailSubject						= null;
	String strMailSubject1						= null;
	String strRequistionGTDate					= null;
	String strMailRefNumber						= null;
	String strRequistionCreatorName	 			= null;
	String strRequistionCreatorMail				= null;
	String strRequistionCreatedDate				= null;
	String strRequisitionComments				= null;
	StringBuffer strMailMsg						= new StringBuffer();
	StringBuffer strMailMsg1					= new StringBuffer();
	String strstrRequistionApproverName			= null;
	String strstrRequistionApproverEmail		= null;
	String strstrRequistionApproverDesig		= null;
	String strstrRequistionNextApproverName		= null;
	String strstrRequistionNextApproverEmail	= null;
	int	intTries								= 0;
	strRequistionId								= request.getParameter("purchaseId");
	String strUserPin							= null;
	String strSiteName							= null;
	String strReqVal							= null;
	String strUserNm							= "";
	String strTravelDate						= "";
	String strTravellerSex						= "";
	String strSex								= "";
	String strSql								= "";
	String strTravelFrom						= "";
	String strTravelTo							= "";
	String strReq								= "";
	String strRequistionCreatedDatewithoutPmAm	= "";	
	String strTravelReturnDate             	= "";
	String strSqlSql							= "";	
	String strGroupTravelFlag					= "";
	String strGroupTravel						= "";
	String strMailID_OrignalApprover			= "";
	String strBillingSite       				= "";
	String strreasonFortravel	 				= ""; 
	String strReviewer							= "";
	String strReviewerEmail						= "";
	String strApproverEmail						= "";
	String strIsmailFwd							= "N";
	String strTravelAgencyTypeId 				= "";
	
	//GET THE VALUES FROM THE PREVIOUS SCREEN
	strRequistionId								= request.getParameter("purchaseRequisitionId");
	strRequisitionStatus						= request.getParameter("rad").trim();
	strRequisitionComments						= request.getParameter("COMMENTS");
	String ReqTyp								= request.getParameter("ReqTyp");
	
	Logger logger=Logger.getLogger(this.getClass().getName()); 		
	logger.setLevel(Level.ALL);
	
	logger.info("Send mail on Originating Start " +dateFormat.format(cal.getTime()));
	logger.info("isMATA_GmbH-->" +isMATA_GmbH);
    logger.info("Send mail on Originating Start for Requisition Number-->"+strRequistionId+ " at " +dateFormat.format(cal.getTime()));
    
    
	String ReqTyp1="";
	if(ReqTyp.equals("Domestic Travel")){
		ReqTyp1="label.mail.domestictravel";
	}else{
		ReqTyp1="label.mail.internationaltravel";
	}
	logger.info("Travel Request Type-->" +ReqTyp);
	//FETCH THE LATEST MAIL ID FROM REQ_MAILBOX
	sSqlStr="SELECT ISNULL(MAX(MAIL_ID),'999')+1 FROM REQ_MAILBOX";
	stmt = con.createStatement(); 
	rs = stmt.executeQuery(sSqlStr);
		if(rs.next()) {
			strMailRefNumber =	rs.getString(1); //Mail Reference Number
		}
	rs.close();
	stmt.close();
	con.close();
	int intMaliRefNumber = Integer.parseInt(strMailRefNumber)+1;
	logger.info("Mail Reference Number is-->" +intMaliRefNumber);
	
	if(ReqTyp.equals("Domestic Travel")) { 
		strType="D";
		sSqlStr="SELECT T.TRAVEL_REQ_NO AS RNO,DBO.USER_NAME(TA.APPROVER_ID)AS NEXTAPPROVER,DBO.USEREMAIL(TA.APPROVER_ID) AS APPROVEREMAIL,DBO.USER_NAME(T.C_USERID) AS CREATOR,DBO.USEREMAIL(T.C_USERID)AS CREATOREMAIL,CONVERT(VARCHAR(30),T.C_DATETIME,113),.DBO.USER_NAME(TA.TRAVELLER_ID) AS TRAVELLER_NAME ,CONVERT(VARCHAR(30),T.TRAVEL_DATE,113),T.SEX,.DBO.SITENAME(T.SITE_ID) AS SITE_NAME ,ISNULL(T.GROUP_TRAVEL_FLAG,'N') AS GROUP_TRAVEL_FLAG,dbo.FN_GET_EXPENDITURE('"+strRequistionId+"','D') AS Expenditure,dbo.sitename(t.BILLING_SITE) as BILLING_SITE,REASON_FOR_TRAVEL,BILLING_SITE as BILLING_SITE_id ,BILLING_CLIENT,T.SITE_ID as SITE_ID,T.C_USERID AS USER_ID,TA.APPROVER_ID,T.TRAVELLER_ID, (select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = T.SITE_ID) as TRAVEL_AGENCY_ID FROM T_TRAVEL_DETAIL_DOM T,T_APPROVERS TA WHERE T.TRAVEL_ID=TA.TRAVEL_ID AND TA.APPROVE_STATUS=0 AND TA.ORDER_ID=DBO.MINREQORDERNO("+strRequistionId+") AND T.TRAVEL_ID="+strRequistionId+" AND TRAVEL_TYPE='D' AND T.STATUS_ID=10 ";
	} else {
		strType="I";
		sSqlStr="SELECT T.TRAVEL_REQ_NO AS RNO,DBO.USER_NAME(TA.APPROVER_ID)AS NEXTAPPROVER,DBO.USEREMAIL(TA.APPROVER_ID)AS APPROVEREMAIL,DBO.USER_NAME(T.C_USERID) AS CREATOR,DBO.USEREMAIL(T.C_USERID)AS CREATOREMAIL,CONVERT(VARCHAR(30),T.C_DATETIME,113),.DBO.USER_NAME(TA.TRAVELLER_ID) AS TRAVELLER_NAME ,CONVERT(VARCHAR(30),T.TRAVEL_DATE,113),T.SEX,.DBO.SITENAME(T.SITE_ID) AS SITE_NAME ,ISNULL(T.GROUP_TRAVEL_FLAG,'N') AS GROUP_TRAVEL_FLAG,dbo.FN_GET_EXPENDITURE('"+strRequistionId+"','I') AS Expenditure,dbo.sitename(t.BILLING_SITE) as BILLING_SITE,REASON_FOR_TRAVEL,BILLING_SITE as BILLING_SITE_id ,BILLING_CLIENT,T.SITE_ID SITE_ID,T.C_USERID AS USER_ID,TA.APPROVER_ID,T.TRAVELLER_ID, (select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = T.SITE_ID) as TRAVEL_AGENCY_ID FROM T_TRAVEL_DETAIL_INT T,T_APPROVERS TA WHERE T.TRAVEL_ID=TA.TRAVEL_ID AND TA.APPROVE_STATUS=0 AND TA.ORDER_ID=DBO.MINREQORDERNO("+strRequistionId+") AND T.TRAVEL_ID="+strRequistionId+" AND TRAVEL_TYPE='I' AND T.STATUS_ID=10 ";
	}
	
	
	con=DriverManager.getConnection(Sdburl,Sdbuser,Sdbpwd);
	stmt= con.createStatement(); 
	rs = stmt.executeQuery(sSqlStr);
	
	if(rs.next()) {					
		strRequistionNumber					=	rs.getString(1);// Number
		strRequistionCreatorName			=	rs.getString(2);///Receipent Name
		strRequistionCreatorMail			=	rs.getString(3);//Receipent Email
		strstrRequistionApproverName		=	rs.getString(4);//CREATOR NAME
		strstrRequistionApproverEmail		=	rs.getString(5);//CREATOR EMAIL
		String strRequistionCreatedDate1	=	rs.getString(6);//Req Created Date & time
		
		//Add the substring Method for time format
		String str= strRequistionCreatedDate1.substring(0,17);
		String str1= strRequistionCreatedDate1.substring(0,11);
		strRequistionCreatedDate=str;	
		strRequistionCreatedDatewithoutPmAm=str1;	
		//End Modification
	
		strUserNm							=	rs.getString(7);//TRAVELLER NAME
		strTravelDate						=	rs.getString(8).substring(0,11); // TRAVEL DATE
		strTravellerSex						=	rs.getString(9); // TRAVELLER SEX
	    strSiteName                     	= 	rs.getString(10); 
		
	    strTravelAgencyTypeId	 			=	rs.getString("TRAVEL_AGENCY_ID");
	    
	    logger.info("Requistion Number is-->" +strRequistionNumber);
	    logger.info("Creator Name is-->" +strstrRequistionApproverName);
	    logger.info("Creator Email is-->" +strstrRequistionApproverEmail);
	    logger.info("Receipent Name is-->" +strRequistionCreatorName);
	    logger.info("Receipent Email is-->" +strRequistionCreatorMail);
	                    
		//get mail to person language preference
	    strSql	=	"SELECT LANGUAGE_PREF FROM M_USERINFO WHERE EMAIL =N'"+strRequistionCreatorMail+"' AND STATUS_ID=10";
	    stmt2= con.createStatement(); 
	    rs2 = stmt2.executeQuery(strSql);
		    if(rs2.next()) {
		    	strsesLanguage=rs2.getString("LANGUAGE_PREF");
	   			if(strsesLanguage==null || strsesLanguage.equals("")){
	   				strsesLanguage="en_US";
	   			}
	   		}
   		rs2.close();
   		stmt2.close();
						
		if(strTravellerSex.equals("1")) {
			strSex	 =	 "Mr.";
		} else {
			strSex	 =	 "Ms";
		}
	
	    if(ReqTyp.equals("Domestic Travel")) 	{
              	strSql ="select * FROM  [dbo].[FN_GetDeparturecity]("+strRequistionId+",'d')";
		      	strGroupTravelFlag       =   rs.getString("GROUP_TRAVEL_FLAG"); 
			  
		      	if(strGroupTravelFlag==null) {
              		strGroupTravel =""; 
 		      	}
		 	  
		      	if(strGroupTravelFlag!=null  &&  (strGroupTravelFlag.trim().equals("Y"))) {
                     strGroupTravel =dbLabelBean.getLabel("label.mail.groupguestisscheduledtotravel",strsesLanguage); 
                     if(strTravelAgencyTypeId.equals("2")) {
                    	 strGroupTravel = dbLabelBean.getLabel("label.mail.guestisscheduledtotravel",strsesLanguage);
					 }
              	} else {
            	  	strGroupTravel = strSex+" "+" <b>"+strUserNm+ "</b> "+dbLabelBean.getLabel("label.mail.isscheduledtotravel",strsesLanguage); 
			  	}
		      
				strSqlSql="SELECT CONVERT(VARCHAR(11), TRAVEL_DATE, 113) FROM "+         		   
			  	 	" T_RET_JOURNEY_DETAILS_DOM WHERE  (TRAVEL_ID = "+strRequistionId+") and  (RETURN_FROM <> '') AND (RETURN_TO <> '')" ;

		} else {
				strSql ="select * FROM  [dbo].[FN_GetDeparturecity]("+strRequistionId+",'i')";
			    strGroupTravelFlag       =   rs.getString("GROUP_TRAVEL_FLAG"); 
     			
			    if(strGroupTravelFlag==null) {
             		strGroupTravel =""; 
		     	}
			    
	 			if(strGroupTravelFlag!=null  &&  (strGroupTravelFlag.trim().equals("Y"))) {
	 				strGroupTravel =dbLabelBean.getLabel("label.mail.groupguestisscheduledtotravel",strsesLanguage); 
	 				if(strTravelAgencyTypeId.equals("2")) {
	 					strGroupTravel = dbLabelBean.getLabel("label.mail.guestisscheduledtotravel",strsesLanguage);
					}
                } else {
                	strGroupTravel = strSex+" "+" <b>"+strUserNm+ "</b> "+dbLabelBean.getLabel("label.mail.isscheduledtotravel",strsesLanguage);
                }
	 			
	 			strSqlSql="SELECT CONVERT(VARCHAR(11), TRAVEL_DATE, 113) FROM "+         		   
		   			" T_RET_JOURNEY_DETAILS_INT WHERE  (TRAVEL_ID = "+strRequistionId+") and  (RETURN_FROM <> '') AND (RETURN_TO <> '')" ;
		}
	
	    logger.info("Group Travel Flag is-->" +strGroupTravelFlag);
	
					
	    String text 		 				=	rs.getString("Expenditure");
		strBillingSite       				=   rs.getString("BILLING_SITE");
		strreasonFortravel   				=   rs.getString("REASON_FOR_TRAVEL");
		String strbillingSiteid		 		=   rs.getString("BILLING_SITE_id");  
		String strBillingClient    			=   rs.getString("BILLING_CLIENT");  
		String strSiteID	 				=   rs.getString("SITE_ID");  	
					
		if(strbillingSiteid.equals("-1")) { //case of out side smg 
			strBillingSite=strBillingClient;  
		}
	
		if(strbillingSiteid.equals("0")) { //case of self smg 
			strBillingSite=strBillingClient;
		}
					
		con1=DriverManager.getConnection(Sdburl,Sdbuser,Sdbpwd);
		stmt1= con1.createStatement(); 
		rs1 = stmt1.executeQuery(strSql);
		if(rs1.next()) {
				strTravelFrom	=	rs1.getString(1);
				strTravelTo		=	rs1.getString(2);
		}
			
		rs1.close();
		stmt1.close();
		con1.close();
					
       //code to find return date from Query 
       con1=DriverManager.getConnection(Sdburl,Sdbuser,Sdbpwd);
	   stmt1= con1.createStatement(); 
	   rs1 = stmt1.executeQuery(strSqlSql);
	   if(rs1.next()) {
				strTravelReturnDate	=	rs1.getString(1);
				
	   }

	   rs1.close();
	   stmt1.close();
	   con1.close();
	
	   //find the orignal approver name in case of handover mail for sending mail 					
		if(ReqTyp.equals("Domestic Travel")) {
			strSql="select dbo.USEREMAIL(ORIGINAL_APPROVER) from t_approvers where (TRAVEL_ID = "+strRequistionId+") and travel_type='d' and ORIGINAL_APPROVER<>'0'";
		
		} else {
			strSql="select dbo.USEREMAIL(ORIGINAL_APPROVER) from t_approvers where (TRAVEL_ID = "+strRequistionId+") and travel_type='i' and ORIGINAL_APPROVER<>'0'";
		}
		con1=DriverManager.getConnection(Sdburl,Sdbuser,Sdbpwd);
		stmt1= con1.createStatement();
	 	rs1 = stmt1.executeQuery(strSql);
		if(rs1.next()) {
	          strMailID_OrignalApprover	=	rs1.getString(1);//Mail ID of CC mails
		 }
		rs1.close();
		stmt1.close();
		con1.close();
		
		//sending mail on origination for intimation for SMR FRANCE,UK,Spain added on 02-Nov-2009 
		if(ReqTyp.equals("Domestic Travel")) {
			sSqlStr	="SELECT isnull(dbo.Find_email(MAIL_TO),'') as MAIL_TO  FROM  MAIL_AT_STAGES	WHERE site_id="+strSiteID+" and (MAIL_STAGE = 'submit')";
			
			String strMailtoCCon ="";
			con1=DriverManager.getConnection(Sdburl,Sdbuser,Sdbpwd);
			stmt1= con1.createStatement();
			rs1 = stmt1.executeQuery(sSqlStr);
			while(rs1.next()) {
				
				strMailtoCCon =rs1.getString("MAIL_TO"); 
			}			
			if(strMailtoCCon==null) {
				strMailtoCCon="";
			}
			rs1.close();
			stmt1.close();
			con1.close();
			strMailID_OrignalApprover=strMailID_OrignalApprover+strMailtoCCon;
		}
		
		strUserId							=   rs.getString("USER_ID");
		strApproverId						=	rs.getString("APPROVER_ID");
		String strTravellerId				=	rs.getString("TRAVELLER_ID");
		
		logger.info("TRAVEL AGENCY ID is-->" +strTravelAgencyTypeId);
		
		//get mail id of report_to and mail_cc person		
		String strQuery = "SELECT MDA.MATA_CC_MAIL CC_MAIL"+
					    " FROM M_DEFAULT_APPROVERS AS MDA  WHERE MDA.APPLICATION_ID = 1 AND MDA.STATUS_ID = 10 AND MDA.SITE_ID = '"+strSiteID+"' AND MDA.TRV_TYPE = '"+strType+"'"+ 
						" AND SP_ROLE =(select sp_role from M_userinfo where   userid='"+strTravellerId+"' and loginstatus in ('ACTIVE','ENABLE')) "+
						" AND MDA.ORDER_ID=(select min(order_id) from M_DEFAULT_APPROVERS MA where MA.site_id='"+strSiteID+"' and MA.STATUS_ID=10 and TRV_TYPE='"+strType+"' "+
						" AND SP_ROLE =(select sp_role from M_userinfo where   userid='"+strTravellerId+"' and loginstatus in ('ACTIVE','ENABLE')) AND MA.ORDER_ID<>10 )"+
						" UNION"+
						" select isnull((select m.EMAIL from m_userinfo um inner join m_userinfo m on um.report_to = m.userid inner join m_site s on s.site_id = um.site_id where um.userid='"+strTravellerId+"' and um.status_id=10 and m.status_id=10 and  MAIL_TO_REPORTING ='Y' and um.userid <> 504 ),'') as MATA_CC_MAIL";
						
		stmt = con.createStatement(); 
		rs = stmt.executeQuery(strQuery);
						
		//get value of report_to person mail and mail_cc from two rows
		String strCCMailOnInitial="";
		while(rs.next()) {
			String strCCMailOnInitialTemp=rs.getString(1);
			if(!strCCMailOnInitialTemp.equals("") && strCCMailOnInitial.equals("")) {
				strCCMailOnInitial =strCCMailOnInitialTemp+strCCMailOnInitial;
			} else if(!strCCMailOnInitialTemp.equals("") && !strCCMailOnInitial.equals("")) {
				strCCMailOnInitial =strCCMailOnInitialTemp+";"+strCCMailOnInitial;
			}
		}
		
		if(!strCCMailOnInitial.trim().equalsIgnoreCase("")) {
			strMailID_OrignalApprover=strMailID_OrignalApprover+";"+strCCMailOnInitial;	
		}
						
		String strTravellerMail="";
		if(!strTravellerId.equals(strUserId)) {							
			String strQuery1 = "SELECT DBO.USEREMAIL(MUI.USERID) AS TRAVELLEREMAIL FROM M_USERINFO MUI WHERE MUI.USERID="+strTravellerId+" AND MUI.STATUS_ID=10 AND MUI.APPLICATION_ID=1"; 
			stmt = con.createStatement(); 
			rs = stmt.executeQuery(strQuery1);
			if(rs.next()) {
				strTravellerMail =  rs.getString("TRAVELLEREMAIL");
			}
		
			if(!"".equals(strTravellerMail)){
				strMailID_OrignalApprover=strMailID_OrignalApprover+";"+strTravellerMail;	
			}
		}
		
		if(strMailID_OrignalApprover.length() > 0) {
			if(strMailID_OrignalApprover.charAt(0)==';')
				strMailID_OrignalApprover = strMailID_OrignalApprover.substring(1);
		}
		
		String groupGuestLabel = "";
		if(strTravelAgencyTypeId.equals("2")){
			groupGuestLabel = "label.global.guest";
		}else{
			groupGuestLabel = "label.approverequest.groupguest";
		}

		//change the mailSubject
		if(strGroupTravelFlag!=null  &&  (strGroupTravelFlag.trim().equals("Y"))) {
			strMailSubject=dbLabelBean.getLabel("label.mail.starsnotification",strsesLanguage)+" "+dbLabelBean.getLabel(ReqTyp1,strsesLanguage)+" "+dbLabelBean.getLabel("label.mail.requisitionno",strsesLanguage)+"'"+strRequistionNumber.trim()+"' "+dbLabelBean.getLabel(groupGuestLabel,strsesLanguage)+" "+dbLabelBean.getLabel("label.mainmenu.pendingforapproval",strsesLanguage)+" ";//Mail Subject
		} else {
			strMailSubject=dbLabelBean.getLabel("label.mail.starsnotification",strsesLanguage)+" "+dbLabelBean.getLabel(ReqTyp1,strsesLanguage)+" "+dbLabelBean.getLabel("label.mail.requisitionno",strsesLanguage)+"'"+strRequistionNumber.trim()+"' "+dbLabelBean.getLabel("label.mainmenu.pendingforapproval",strsesLanguage)+" ";//Mail Subject
		}
		
		logger.info("Email Subject is-->" +strMailSubject);
		
			try {
				
				String strSSOUrl = dbUtilityBean.sSSOUrlByMailid(strRequistionCreatorMail);
				
				strMailMsg.append("<html><style>.formhead{ font-family:Arial;font-size:11px;font-style: normal;font-weight:normal;color:#000000;text-decoration:none;letter-spacing:normal;word-spacing:normal;border:1px #333333 solid;background:#E2E4D6;}</style><body bgcolor=\"#d0d0d0\">" + "\n");
				strMailMsg.append(" <table width=80% border=0 cellspacing=0 cellpadding=0 align=center><tr><td align=right><font face=Verdana, Arial, Helvetica, sans-serif size=2><b><font color=#FFFFFF>"+strRequistionCreatedDatewithoutPmAm+"</font><font color=#FFFFFF></font><font color=#000000><br></font></b><font color=#FFFFFF>"+dbLabelBean.getLabel("label.mail.forinternalcirculationonly",strsesLanguage)+"</font></font></td></tr><tr><td bgcolor=#000000></td></tr><tr><td bgcolor=#FFFFFF align=center>"+ "\n");
				strMailMsg.append("</td></tr><tr><td bgcolor=#000000></td></tr><tr><td bgcolor=#FFFFFF align=center><table width=100% border=0 cellspacing=0 cellpadding=10><tr><td align=center bgcolor=#aa1220><font face=Arial, Helvetica, sans-serif size=5 color=#FFFFFF>"+dbLabelBean.getLabel("label.mail.starsmailnotification",strsesLanguage)+"</font></td></tr></table></td></tr><tr><td bgcolor=#000000> </td></tr><tr>"+ "\n");
				strMailMsg.append("<td bgcolor=#B6DCDC></td></tr><tr><td bgcolor=#000000> </td></tr><tr><td bgcolor=#000000> </td></tr><tr><td bgcolor=#FFFFFF><table width=100% border=0 cellspacing=0 cellpadding=5>"+ "\n");
				strMailMsg.append("  <tr><td align=center bgcolor=#aa1220><font face=Verdana, Arial, Helvetica, sans-serif size=2><b><font color=#FFFFFF><font size=2>"+dbLabelBean.getLabel(ReqTyp1,strsesLanguage)+" "+dbLabelBean.getLabel("label.mail.requisition",strsesLanguage)+"</font> </font></b></font></td></tr><tr><td bgcolor=#878787><font face=Verdana, Arial, Helvetica, sans-serif size=2><b>"+dbLabelBean.getLabel("label.mail.travelrequisitionnumber",strsesLanguage)+" : "+strRequistionNumber.trim()+"</b> ("+dbLabelBean.getLabel("label.mail.dated",strsesLanguage)+" : "+strRequistionCreatedDate+")</font></td></tr><tr><td><p><font color=#FFFFFF></font><font size=2 face=Verdana, Arial, Helvetica, sans-serif>"+"\n"); 
				strMailMsg.append(dbLabelBean.getLabel("label.mail.dear",strsesLanguage)+" "+strRequistionCreatorName+",</font></p><p><font size=2 face=Verdana, Arial, Helvetica, sans-serif>"+dbLabelBean.getLabel("label.global.requisitionnumber",strsesLanguage)+" "+strRequistionNumber.trim()+" "+dbLabelBean.getLabel("label.mail.hasbeenoriginatedby",strsesLanguage)+" "+strstrRequistionApproverName+" "+dbLabelBean.getLabel("label.approverrequest.from",strsesLanguage)+" "+strSiteName+" "+dbLabelBean.getLabel("label.mail.on",strsesLanguage)+" "+strRequistionCreatedDate+" "+"</p>"+ "\n"); 
				strMailMsg.append("<u><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>"+dbLabelBean.getLabel("label.mail.requisitionsdetails",strsesLanguage)+"</u> :-</font><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif >"+strGroupTravel+"   </font>\n<br>"); 
				strMailMsg.append("<u><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>"+dbLabelBean.getLabel("label.global.reasonfortravel",strsesLanguage)+" </u>:- </font><font size=2 face=Verdana, Arial, Helvetica, sans-serif >"+strreasonFortravel+"</font>\n<br><br>"); 
				
				if((strTravelAgencyTypeId != null && strTravelAgencyTypeId.equals("2"))) {
					strMailMsg.append(new T_QuicktravelRequestDaoImpl().customizeApproverMailBodyGmbh(strRequistionId, strType, strTravellerId));
				}else{
					strMailMsg.append("<TABLE border=0 width=750  ><TR  height=10 ><TD    width=170><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue >"+dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)+" </TD><TD    width=200><font size=2 face=Verdana, Arial, Helvetica, sans-serif >:- "+strTravelDate+"</TD><TD    width=170><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>"+dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)+" </TD><TD><font size=2 face=Verdana, Arial, Helvetica, sans-serif > :- "+strTravelFrom+"</TD></TR><TR  height=10><TD ><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>"+dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)+"</TD><TD ><font size=2 face=Verdana, Arial, Helvetica, sans-serif>:-  "+strTravelTo+"</TD><TD ><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>"+dbLabelBean.getLabel("label.report.returndate",strsesLanguage)+" </TD><TD><font size=2 face=Verdana, elvetica, sans-serif > :- "+strTravelReturnDate+" </TD></TR><TR  height=10><TD ><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>"+dbLabelBean.getLabel("label.mail.amountrequested",strsesLanguage)+"</TD><TD width=240><font size=2 face=Verdana, Arial, Helvetica, sans-serif >:- "+text+"</TD><TD><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>"+dbLabelBean.getLabel("label.requestdetails.billingclient",strsesLanguage)+" </TD><TD><font size=2 face=Verdana, Arial, Helvetica, sans-serif >:- "+strBillingSite+" </TD></TR></TABLE>");
				}
				
				strMailMsg.append("</font><br><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif><a href='"+strSSOUrl+"'>"+dbLabelBean.getLabel("label.mail.pleaseclickheretologintostars",strsesLanguage)+" </a> "+ "\n");  
				strMailMsg.append("   </b></form></font><br><p><font size=2 face=Verdana, Arial, Helvetica, sans-serif>"+dbLabelBean.getLabel("label.mail.bestregards",strsesLanguage)+"</font><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif>"+strstrRequistionApproverName.trim()+"<br></font></p></td></tr></table></td></tr><tr><td bgcolor=#878787 align=center> <font face=Verdana, Arial, Helvetica, sans-serif size=1><b>"+dbLabelBean.getLabel("label.mail.mailreferencenumber",strsesLanguage)+" </b>"+strMailRefNumber+"/"+strCurrentYear+"</font></td></tr><tr><td bgcolor=#FFFFFF align=center><table width=100% border=0 cellspacing=0 cellpadding=5>"+ "\n"); 
				strMailMsg.append("<tr><td align=center bgcolor=#aa1220><font size=2 face=Verdana, Arial, Helvetica, sans-serif><b><font size=1>"+dbLabelBean.getLabel("label.mail.starsadministratorcanbecontacted",strsesLanguage)+" : - </font></b><font size=1><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=#000000>"+ "\n"); 
				strMailMsg.append("<a href=mailto:administrator.stars@mind-infotech.com><font size=1 color=#ffffff>administrator.stars@mind-infotech.com</font></a></font></font></font></td>  "+ "\n");  
				strMailMsg.append(" </tr><tr><td  align=center bgcolor=#878787 height=15> <b><font size=1 face=Verdana, Arial, Helvetica, sans-serif>"+dbLabelBean.getLabel("label.mail.disclaimer",strsesLanguage)+"</b> : "+dbLabelBean.getLabel("label.mail.thiscommunicationissystemgenererated",strsesLanguage)+" "+ "\n");  
				strMailMsg.append(dbLabelBean.getLabel("label.mail.pleasedonnotreplytothismail",strsesLanguage)+" <br>"+dbLabelBean.getLabel("label.mail.ifyouarenotthecorrectrecipientforthisnotification",strsesLanguage)+"</font></td></tr></table></td></tr><tr><td bgcolor=#000000></td></tr>"+ "\n");    
				strMailMsg.append("<tr><td align=center><font size=2 face=Verdana, Arial, Helvetica, sans-serif><font size=1 color=#000000>&copy;"+dbLabelBean.getLabel("label.mail.mindallrightsreserved",strsesLanguage)+"</font></font></td>  </tr></table><p>&nbsp;</p></body></html>"+ "\n");
				
				//logger.info("Email Content is-->" +strMailMsg.toString());
				
				logger.info("Send mail to First Approver Start for Requisition Number-->"+strRequistionId+ " at " +dateFormat.format(cal.getTime()));
				try {
					con1=DriverManager.getConnection(Sdburl,Sdbuser,Sdbpwd);
					//Procedure for inserting Mail Data
					cstmt_mail=con1.prepareCall("{?=call PROC_REQUISITION_MAIL_ADD(?,?,?,?,?,?,?,?,?,?,?,?)}");
					cstmt_mail.registerOutParameter(1,java.sql.Types.INTEGER);
					cstmt_mail.setString(2, strRequistionId);
					cstmt_mail.setString(3, strRequistionNumber);
					cstmt_mail.setString(4, strRequistionCreatorMail);//To
					cstmt_mail.setString(5, strstrRequistionApproverEmail);//From
					cstmt_mail.setString(6, strMailID_OrignalApprover);//CC  Mail Address is remove By  shar sharma on 03-Apr-08
					cstmt_mail.setString(7, strMailSubject);
					cstmt_mail.setString(8, strMailMsg.toString());
					cstmt_mail.setInt(9, intTries);
					cstmt_mail.setString(10, "NEW");
					cstmt_mail.setString(11, Suser_id);
					cstmt_mail.setString(12, "New");
					cstmt_mail.setString(13, "User Submitting the Req");
					cstmt_mail.execute();
					cstmt_mail.close();
					con1.close();
				}
				catch(Exception b) {
					b.printStackTrace();
					System.out.println("Error in T_requisitionMailOnOriginating.jsp========="+b);
					logger.log(Level.ERROR, "Error occur in Send mail Approver try/catch block", b);
				}
				
				logger.info("Send mail to First Approver End for Requisition Number-->"+strRequistionId+ " at " +dateFormat.format(cal.getTime()));	
				
				rs1=null;			
			    String approverId="";
				String approver="";
				strSql="SELECT TA.APPROVER_ID, dbo.user_name(TA.APPROVER_ID) as approver, DBO.USEREMAIL(TA.APPROVER_ID) AS ApproverEmail"+
					" ,dbo.user_name(TA.PAP_APPROVER) as reviewer, DBO.USEREMAIL(TA.PAP_APPROVER) AS reviewerEmail, pap.IS_MAIL_FWD"+
					" FROM T_APPROVERS TA inner join"+ 
					" VW_PAGE_ACCESS_PERMISSION PAP on pap.viewToUser=TA.PAP_APPROVER and pap.pendingWithUser = TA.APPROVER_ID"+ 
					" WHERE TA.TRAVEL_ID='"+strRequistionId+"' "+
					" AND TA.ORDER_ID=(SELECT MIN(ORDER_ID) FROM T_APPROVERS WHERE T_APPROVERS.TRAVEL_ID='"+strRequistionId+"' AND T_APPROVERS.SITE_ID='"+strSiteID+"' AND T_APPROVERS.TRAVEL_TYPE='"+strType+"' AND T_APPROVERS.APPROVE_STATUS=0) "+
					" AND TA.SITE_ID='"+strSiteID+"' "+
					" AND TA.TRAVEL_TYPE='"+strType+"'";
				stmt = con.createStatement(); 
				rs1 = stmt.executeQuery(strSql);
					if(rs1.next()) {
						approverId=rs1.getString("APPROVER_ID");
						approver=rs1.getString("approver");
						strApproverEmail=rs1.getString("ApproverEmail");
						strReviewer=rs1.getString("reviewer");
						strReviewerEmail=rs1.getString("ReviewerEmail");
						strIsmailFwd=rs1.getString("is_mail_fwd");
					}
					
				 stmt2=null;
				 rs2=null;
					
				 // get mail to person language preference
				 strSql	=	"SELECT LANGUAGE_PREF FROM M_USERINFO WHERE EMAIL =N'"+strReviewerEmail+"' AND STATUS_ID=10";
				 stmt2= con.createStatement(); 
				 rs2 = stmt2.executeQuery(strSql);
				 if(rs2.next()) {
					strsesLanguage=rs2.getString("LANGUAGE_PREF");
					if(strsesLanguage==null || strsesLanguage.equals("")){
						strsesLanguage="en_US";
					}
				 }
				 rs2.close();
				 stmt2.close();
					
				 strMailSubject1=dbLabelBean.getLabel("label.mail.starsnotification",strsesLanguage)+" "+dbLabelBean.getLabel(ReqTyp1,strsesLanguage)+" "+dbLabelBean.getLabel("label.mail.requisitionno",strsesLanguage)+"'"+strRequistionNumber.trim()+"'  "+dbLabelBean.getLabel("label.mail.forreview",strsesLanguage)+" ";
					
				if(strIsmailFwd!=null && strIsmailFwd.trim().equalsIgnoreCase("Y")) {
					
				strMailMsg1.append("<html><style>.formhead {	font-family: Arial;	font-size: 11px;	font-style: normal;	font-weight: normal;	color: #000000;");
				strMailMsg1.append("border: 1px #333333 solid;	background: #00CCFF;}</style>");
				strMailMsg1.append("<body bgcolor=#00CCFF><table width=80% align=center><tr><td align=right><font size=2><b><font color=#FFFFFF>"+strRequistionCreatedDatewithoutPmAm+"</font>");
				strMailMsg1.append("<font color=#FFFFFF></font><font color=#000000><br></font></b><font color=#FFFFFF>"+dbLabelBean.getLabel("label.mail.forinternalcirculationonly",strsesLanguage)+"</font></font></td>");
				strMailMsg1.append("</tr><tr><td bgcolor=#000000></td></tr><tr><td bgcolor=#FFFFFF align=center><table width=100% border=0 cellspacing=0 cellpadding=9></table>");
				strMailMsg1.append("</td></tr><tr><td bgcolor=#FFFFFF align=center><table width=100% border=0 cellspacing=0 cellpadding=15><tr><td align=center bgcolor=#aa1220>");
				strMailMsg1.append("<font size=5 color=#FFFFFF>"+dbLabelBean.getLabel("label.mail.starsmailnotification",strsesLanguage)+"</font></td></tr></table>");
				strMailMsg1.append("</td></tr><tr><td bgcolor=#FFFFFF><table width=100% border=0 cellspacing=0 cellpadding=5><tr><td align=center bgcolor=#aa1220><font size=2><b>");
				strMailMsg1.append("<font	color=#FFFFFF><font size=3>"+dbLabelBean.getLabel("label.mail.forreview",strsesLanguage)+"</font> </font></b></font></td></tr><tr><td bgcolor=#878787><font size=2></font></td></tr><tr><td><p>");
				strMailMsg1.append("<font color=#FFFFFF>.</font><font size=2 face=Verdana, Arial, Helvetica, sans-serif><br>"+dbLabelBean.getLabel("label.mail.dear",strsesLanguage)+" "+strReviewer+",</font></p><p><font size=2 face=Verdana, Arial, Helvetica, sans-serif> "+dbLabelBean.getLabel("mail.label.kindlyreviewtherequest",strsesLanguage)+" "+strRequistionNumber.trim()+" "+dbLabelBean.getLabel("mail.label.pendingwithmeandtakeappropriateaction",strsesLanguage));
				strMailMsg1.append("<br><br><font color=blue></p></font> </font><font size=2></font></p><font size=2 face=Verdana, Arial, Helvetica, sans-serif><a href='https://stars.mindeservices.com'>"+dbLabelBean.getLabel("label.mail.pleaseclickheretologintostars",strsesLanguage)+" </a> </b></form>");
				strMailMsg1.append("</font><br>	<p><font size=2 face=Verdana, Arial, Helvetica, sans-serif>"+dbLabelBean.getLabel("label.mail.bestregards",strsesLanguage)+"</font><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif>"+approver+"<br></font></p></td></tr></table></td></tr><tr><td bgcolor=#878787 align=center>");
				strMailMsg1.append("<font face=Verdana,Arial, Helvetica, sans-serif size=1><b>"+dbLabelBean.getLabel("label.mail.mailreferencenumber",strsesLanguage)+" </b>"+intMaliRefNumber+"/"+strCurrentYear+"</font></td></tr>");
				strMailMsg1.append("<tr><td bgcolor=#FFFFFF align=center><table width=100% border=0 cellspacing=0 cellpadding=5><tr>");
				strMailMsg1.append("<td align=center bgcolor=#aa1220><font size=2 face=Verdana, Arial, Helvetica, sans-serif><b><font size=1>"+dbLabelBean.getLabel("label.mail.starsadministratorcanbecontacted",strsesLanguage)+" : - </font></b><font size=1><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=#000000> <a href=mailto:administrator.stars@mind-infotech.com><font size=1 color=#ffffff>administrator.stars@mind-infotech.com</font></a></font></font></font></td>");
				strMailMsg1.append("</tr><tr><td  align=center bgcolor=#878787 height=15> <b><font size=1 face=Verdana, Arial, Helvetica, sans-serif>"+dbLabelBean.getLabel("label.mail.disclaimer",strsesLanguage)+"</b> : "+dbLabelBean.getLabel("label.mail.thiscommunicationissystemgenererated",strsesLanguage)+"  "+dbLabelBean.getLabel("label.mail.pleasedonnotreplytothismail",strsesLanguage)+" <br>"+dbLabelBean.getLabel("label.mail.ifyouarenotthecorrectrecipientforthisnotification",strsesLanguage)+"</font></td>");
				strMailMsg1.append("</tr></table></td></tr><tr><td bgcolor=#000000></td></tr><tr><td align=center><font size=2 face=Verdana, Arial, Helvetica, sans-serif><font size=1 color=#000000>&copy;"+dbLabelBean.getLabel("label.mail.mindallrightsreserved",strsesLanguage)+"</font></font></td></tr></table><p>&nbsp;</p></body></html>");
				logger.info("Send mail to First Approver Start(second mail) for Requisition Number-->"+strRequistionId+ " at " +dateFormat.format(cal.getTime()));			
				try {
					con1=DriverManager.getConnection(Sdburl,Sdbuser,Sdbpwd);
					cstmt_mail=con1.prepareCall("{?=call PROC_REQUISITION_MAIL_ADD(?,?,?,?,?,?,?,?,?,?,?,?)}");
					cstmt_mail.registerOutParameter(1,java.sql.Types.INTEGER);
					cstmt_mail.setString(2, "");
					cstmt_mail.setString(3, strRequistionNumber);
					cstmt_mail.setString(4, strReviewerEmail);//To
					cstmt_mail.setString(5, strApproverEmail);//From
					cstmt_mail.setString(6, "");
					cstmt_mail.setString(7, strMailSubject1);
					cstmt_mail.setString(8, strMailMsg1.toString());
					cstmt_mail.setInt(9, intTries);
					cstmt_mail.setString(10, "NEW");
					cstmt_mail.setString(11, approverId);
					cstmt_mail.setString(12, "New");
					cstmt_mail.setString(13, "User Submitting the Req");
					cstmt_mail.execute();
					cstmt_mail.close();
					con1.close();
					logger.info("Send mail to First Approver End(second mail) for Requisition Number-->"+strRequistionId+ " at " +dateFormat.format(cal.getTime()));
				} catch(Exception b) {	
					b.printStackTrace();
					System.out.println("Error in T_requisitionMailOnOriginating.jsp second mail block========="+b);		
					logger.log(Level.ERROR, "Error occur in Send mail for Review try/catch block", b);
				}
				
				}
				
				logger.info("Send mail to MATA_GmbH Start for Requisition Number-->"+strRequistionId+ " at " +dateFormat.format(cal.getTime()));
				// Send Mail to MATA GmbH and Travel Coordinator
				if((isMATA_GmbH != null && isMATA_GmbH.equals("true")) || (strTravelAgencyTypeId != null && strTravelAgencyTypeId.equals("2"))) {					
					logger.info("Get MATA GmbH Email Content Start for Requisition Number-->"+strRequistionId+ " at " +dateFormat.format(cal.getTime()));
					String strMataGmbHMailContent = "";
					if(strGroupTravelFlag!=null  &&  (strGroupTravelFlag.trim().equals("Y"))) {
						 strMataGmbHMailContent = new T_QuicktravelRequestDaoImpl().getGroupMailBodyForMataGmbH(strRequistionId, strType, strTravellerId);
					} else if(strGroupTravelFlag!=null  &&  (strGroupTravelFlag.trim().equals("N"))){
						 strMataGmbHMailContent = new T_QuicktravelRequestDaoImpl().getMailBodyForMataGmbH(strRequistionId, strType, strTravellerId);
					}					
					//logger.info("MATA GmbH Email Content -->" +strMataGmbHMailContent);
					logger.info("Get MATA GmbH Email Content End for Requisition Number-->"+strRequistionId+ " at " +dateFormat.format(cal.getTime()));
					
					String firstDepartureDate = "";
					String strSqlDepartureDate = "";
					if("I".equals(strType) || "INT".equals(strType)) {
						strSqlDepartureDate = "SELECT CONVERT(VARCHAR(10),MIN(TRAVEL_DATE),103) AS FIRST_JOURNY_DATE FROM T_JOURNEY_DETAILS_INT WHERE TRAVEL_ID="+strRequistionId;
					} else if("D".equals(strType) || "DOM".equals(strType)) {
						strSqlDepartureDate = "SELECT CONVERT(VARCHAR(10),MIN(TRAVEL_DATE),103) AS FIRST_JOURNY_DATE FROM T_JOURNEY_DETAILS_DOM WHERE TRAVEL_ID="+strRequistionId;
					}

					stmt2=null;
					rs2=null;
					stmt2= con.createStatement(); 
					rs2 = stmt2.executeQuery(strSqlDepartureDate);
					if(rs2.next()) {
						firstDepartureDate=rs2.getString("FIRST_JOURNY_DATE");
					}
					rs2.close();
					stmt2.close();
					
					String emailIdsMataSql = "";					
					if("I".equals(strType) || "INT".equals(strType)) {
						
						emailIdsMataSql = " select DBO.USEREMAIL(APPROVER_ID) MATAGMBH from T_TRAVEL_DETAIL_INT TDI "+ 
								" INNER JOIN T_APPROVERS TA ON TDI.TRAVEL_ID=TA.TRAVEL_ID AND "+
								" TA.TRAVEL_TYPE='"+strType+"' WHERE TDI.TRAVEL_ID="+strRequistionId+" AND TA.ROLE='MATA' UNION "+
								" select email AS MATAGMBH from m_userinfo "+ 
								" WHERE site_id in (select FUNCTION_VALUE from  functional_ctl where function_key='@MataGmbHSite') and role_id ='MATA' and "+ 
								" exists(select 1 from T_TRAVEL_DETAIL_INT tdi inner join m_site s on tdi.SITE_ID = s.site_id "+ 
								" WHERE TRAVEL_ID="+strRequistionId+" and TRAVEL_AGENCY_ID=2) UNION "+
								" SELECT DBO.USEREMAIL(USERID) MATAGMBH FROM T_TRAVEL_DETAIL_INT TDI "+
								" INNER JOIN  USER_MULTIPLE_ACCESS UMA ON TDI.SITE_ID=UMA.SITE_ID "+
								" WHERE TDI.TRAVEL_ID="+strRequistionId+" AND UMA.TRAVEL_COORDINATOR =1 AND UMA.STATUS_ID=10";			
						
					} else if("D".equals(strType) || "DOM".equals(strType)) {
						
						emailIdsMataSql = " select DBO.USEREMAIL(APPROVER_ID) MATAGMBH from T_TRAVEL_DETAIL_DOM TDD "+
								" INNER JOIN T_APPROVERS TA ON TDD.TRAVEL_ID=TA.TRAVEL_ID AND "+
								" TA.TRAVEL_TYPE='"+strType+"' WHERE TDD.TRAVEL_ID="+strRequistionId+" AND TA.ROLE='MATA' UNION "+
								" select email AS MATAGMBH from m_userinfo "+ 
								" WHERE site_id in (select FUNCTION_VALUE from  functional_ctl where function_key='@MataGmbHSite') and role_id ='MATA' and "+ 
								" exists(select 1 from T_TRAVEL_DETAIL_DOM tdd inner join m_site s on tdd.SITE_ID = s.site_id "+ 
								" WHERE TRAVEL_ID="+strRequistionId+" and TRAVEL_AGENCY_ID=2) UNION "+
								" SELECT DBO.USEREMAIL(USERID) MATAGMBH FROM T_TRAVEL_DETAIL_DOM TDD "+
								" INNER JOIN  USER_MULTIPLE_ACCESS UMA ON TDD.SITE_ID=UMA.SITE_ID "+
								" WHERE TDD.TRAVEL_ID="+strRequistionId+" AND UMA.TRAVEL_COORDINATOR =1 AND UMA.STATUS_ID=10";			
						
					}
					
					
					List emailIdsList = new ArrayList();
					String emailId = "";
					String emailIds = "";
					stmt2=null;
					rs2=null;
					stmt2= con.createStatement(); 
					rs2 = stmt2.executeQuery(emailIdsMataSql);
					while(rs2.next()) {
						emailId=rs2.getString("MATAGMBH");
						emailIdsList.add(emailId);
					}
					rs2.close();
					stmt2.close();
					
					StringBuilder sb = new StringBuilder();
					int size = emailIdsList.size(); 
					if (size > 0) {
						sb.append(emailIdsList.get(0));
						for (int i = 1; i < size; ++i) {
							sb.append("; ").append(emailIdsList.get(i));
					    }
						
						emailIds = sb.toString();
					}
					
					logger.info("Get MATA GmbH Email Id(s) -->" +emailIds);
					
					String strFromMail="administrator.stars@mind-infotech.com";
					String strMataGmbhSubject = "";
					if(strGroupTravelFlag!=null  &&  (strGroupTravelFlag.trim().equals("Y"))) {
						strMataGmbhSubject = "STARS - ["+strUserNm+"] - ["+firstDepartureDate+"] ["+strRequistionNumber+"] ["+dbLabelBean.getLabel("label.global.guest",strsesLanguage)+"]";
					} else {
						strMataGmbhSubject = "STARS - ["+strUserNm+"] - ["+firstDepartureDate+"] ["+strRequistionNumber+"]";
					}
					logger.info("MATA GmbH Email Subject-->" +strMataGmbhSubject);
					
					logger.info("Send Detail Mail to MATA GmbH Start for Requisition Number-->"+strRequistionId+ " at " +dateFormat.format(cal.getTime()));
					try {
							con1=DriverManager.getConnection(Sdburl,Sdbuser,Sdbpwd);
							cstmt_mail=con1.prepareCall("{call PROC_REQUISITION_MAIL_ADD(?,?,?,?,?,?,?,?,?,?,?,?)}");
							cstmt_mail.setString(1, strRequistionId);
							cstmt_mail.setString(2, strRequistionNumber);
							cstmt_mail.setString(3, emailIds);//Email Ids of MATA and Travel Coordinator.
							cstmt_mail.setString(4, strFromMail);//From Admin
							cstmt_mail.setString(5, "");
							cstmt_mail.setString(6, strMataGmbhSubject);
							cstmt_mail.setString(7, strMataGmbHMailContent);
							cstmt_mail.setString(8, "0");
							cstmt_mail.setString(9, "NEW");
							cstmt_mail.setString(10, Suser_id);
							cstmt_mail.setString(11, "New");
							cstmt_mail.setString(12, "User Submitting the Req");
							cstmt_mail.execute();
							cstmt_mail.close();
							con1.close();
					logger.info("Send Detail Mail to MATA GmbH End for Requisition Number-->"+strRequistionId+ " at " +dateFormat.format(cal.getTime()));		
					} catch(Exception b) {
						b.printStackTrace();
						System.out.println("Error in T_requisitionMailOnOriginating.jsp second mail block========="+b);		
						logger.log(Level.ERROR, "Error occur in Send mail to MATA_GmbH try/catch block", b);
					}					
					
				}
				logger.info("Send mail to MATA_GmbH End for Requisition Number-->"+strRequistionId+ " at " +dateFormat.format(cal.getTime()));
				
			} catch(Exception e) {
					System.out.println("Error in T_requisitionMailOnOriginating.jsp========="+ e);
					logger.log(Level.ERROR, "Error occur in Main try/catch block", e);
			}
		}
		rs.close();
		stmt.close();
		con.close();
		logger.info("Send mail on Originating End for Requisition Number-->"+strRequistionId+ " at " +dateFormat.format(cal.getTime()));
		logger.info("Send mail on Originating End " +dateFormat.format(cal.getTime()));
	%>
	
