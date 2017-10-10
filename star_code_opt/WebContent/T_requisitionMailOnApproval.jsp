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
	 *Modification 			:1 Display the mail Subject in different format 
	                                 2 Added by shiv for showing Group Travel in case of group travel   on 25-Feb-08 ; 
									 3 code that send CC mail to mata Assoctias for intimaton added on 27-Mar-08
									 4.code added for showing group travel  in case of domestie group travel_DOM  on shiv sharma on 19-Jun-08  
									 5 Change  Currency format on 05-03-2009 by shiv sharma  
									 6.added new to flag to configure dynamic workflow of SMR sites for  while adding approvers from M_default_approvers
									 7:added code for showing travel class of journey on 29 march 2010 by shiv sharma 
	 *Reason of Modification:
	 *Date of Modification  : 09/04/2007
	 *Modified By			: Vijay Singh 
	 *Revision History		:
	 *Editor				:Editplus
	 Modified by vaibhav on jul 19 2010 to enable SSO in Mails
	 
	 *Date of Modification	: 26 May 2011
	 *Modified By			: Manoj Chand
	 *Modification			: Return date is not showing in email going to approvers from one to another in group domestic request.

	 *Date of Modification	: 01 Nov 2011
	 *Modified By			: Manoj Chand
	 *Modification			: billing client was showing self as wrong entry in approval mail from approvers.
	 
	 *Date of Modification	: 25 Apr 2012
	 *Modified By			: Manoj Chand
	 *Modification			: A message added in mail for Transit House.
	 
	 *Date of Modification	: 10 May 2012
	 *Modified By			: Manoj Chand
	 *Modification			: Mail Created for review and over limit approval
	 
	 *Date of Modification	: 14 Jan 2013
	 *Modified By			: Manoj Chand
	 *Modification			: Provision need to be given in STARS to notify Travel Coordinator in CC after the approval of final approver.
	 
	 *Date of Modification	: 30 Jan 2013
	 *Modified By			: Manoj Chand
	 *Modification			: Showing requested amounts in multiple currencies in mail
	 
	 *Modified By			:Manoj Chand
	 *Date of Modification  :27-June-2013
 	 *Modification			:change in query to correct the value of travel to.
 	 
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
	Connection con, con1					=		null;			    // Object for connection
	Statement stmt	,stmt1,stmt2				=		null;			   // Object for Statement
	ResultSet rs,rs1,rs2,rs3,rs4					=		null;			  // Object for ResultSet
	CallableStatement cstmt_mail			=		null;			// Object for Callable Statement
	
	//Create Connection
	Class.forName(Sdbdriver);
	con=DriverManager.getConnection(Sdburl,Sdbuser,Sdbpwd);
	
	//DECLARE VARIABLES
	String	sSqlStr								=	""; // For sql Statements
	String strRequistionId						=	null;
	String strRequisitionStatus	    			=	null;
	String strRequistionNumber	 				=	null;
	String strMailSubject						=	null;
	String strMailSubject1						=	null;
	String strRequistionGTDate					=	null;
	String strMailRefNumber						=	null;
	String strRequistionCreatorName	 			=	null;
	String strRequistionCreatorMail				=	null;
	String strRequistionCreatedDate				=	null;
	String strRequisitionComments				=	null;
	StringBuffer strMailMsg						=	new StringBuffer();
	String strstrRequistionApproverName			=	null;
	String strstrRequistionApproverEmail		=	null;
	String strstrRequistionApproverDesig		=	null;
	String strRequistionNextApprover_UserId		=	null;
	String strstrRequistionNextApproverName		=	null;
	String strstrRequistionNextApproverEmail	=	null;
	int		intTries							=	0;
	//strRequistionId							=	request.getParameter("purchaseId");
	String strUserPin							=	null;
	String strSiteName							=	null;
	String strReqVal							=	null;
	String	strUserNm							=	"";
	String	strTravelDate						=	"";
	String	strTravellerSex						=	"";
	String	strSex								=	"";
	String	strSql								=	"";
	String	strTravelFrom						=	"";
	String	strTravelTo							=	"";
	String	strReq								=	"";
	String strSiteId                            =   "";        // new
	String strCreationDate                      =	"";
	String TType								=	""; //Added by Vijay on 09/04/2007
	String strTraveltype						=	"";   //added by shiv on 27-Mar-08
	
	String    strGroupTravel          			=	"";
	String	  strGroupTravelFlag   				=	"";
	
	String   strLastApprover_flag				=	"";
	
	String   strMailID_MataAsso					=	"";	
	ArrayList aList								=   new ArrayList();   
	String strMailID_OrignalApprover			=	"";
	
	String strRequistionCreatedDateWithoutAMPM ="";
	
	String strSqlSql			="";
	
	
	String  strreasonFortravel   =   "";
	//String	strCurrency			 =   "";//TOTAL_AMOUNT 
	//String	strTotalAmount       =  ""; //BILLING_SITE
	String	strBillingSite		 ="";
	
	String strTravelReturnDate	="";
	String strTravelClass		="";
	String strTransitType	= "0";
	String strTrasitMsg		= "";
	String strTrvType="";
	String strApproverId="";
	String strMailFlag="N";
	String strTrasitMsg1		= "";
	//code for making a currency  format of  Rs added  on  06-03-2009 
	String strTravelAgencyTypeId = ""; 
	String groupGuestLabel = "";
			
	java.text.NumberFormat dblFunnelVal = null;
	dblFunnelVal = new java.text.DecimalFormat("#######,###.####");
	
	
	
	///get Current Date  
	          /*Date currentDate = new Date();
	           SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy"); 
	           String strCurrentDate = (sdf.format(currentDate)).trim();
	          */ 
	
	//GET THE VALUES FROM THE PREVIOUS SCREEN
	strRequistionId															=	request.getParameter("purchaseRequisitionId");
	strRequisitionStatus													=	request.getParameter("rad").trim();
	strRequisitionComments													=	request.getParameter("COMMENTS");
	String ReqTyp															=	request.getParameter("ReqTyp");
	String strSiteID														= 	request.getParameter("SiteId");
	
	Logger logger=Logger.getLogger(this.getClass().getName()); 		
	logger.setLevel(Level.ALL);
	
	logger.info("Send mail on Approval Start " +dateFormat.format(cal.getTime()));	
	logger.info("isMATA_GmbH-->" +isMATA_GmbH);	
    logger.info("Send mail on Approval Start for Requisition Number-->"+strRequistionId+ " at " +dateFormat.format(cal.getTime()));
    
    
	String ReqTyp1="";
	if(ReqTyp.equals("Domestic Travel")){
		ReqTyp1="label.mail.domestictravel";
	}else{
		ReqTyp1="label.mail.internationaltravel";
	}
	logger.info("Travel Request Type-->" +ReqTyp);
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
	
	int intMaliRefNumber = Integer.parseInt(strMailRefNumber)+1;
	logger.info("Mail Reference Number is-->" +intMaliRefNumber);
	//query added by manoj chand on 10 may 2012 to send mail form R2A OR A2R for special workflow case.
	if(ReqTyp.equals("Domestic Travel")) 
	{
		strTrvType="D";
	sSqlStr=" select .DBO.USER_NAME(mailfrom) AS APPROVER_NAME, DBO.USEREMAIL(mailfrom) AS APPROVER_MAIL ,"+
			" .DBO.USER_NAME(mailto) AS NEXTWITH, DBO.USEREMAIL(mailto) AS NEXTWITH_MAIL , IS_MAIL_FWD, TOTAL_AMOUNT, PAP_VALUE_LIMIT"+ 
			" ,MAIL_DIRECTION from ("+
			" select  ta.travel_id, order_id, TA.site_id ,travel_type, approver_id, pap_approver, pap_flag, approve_status,"+ 
			" VW.IS_MAIL_FWD, td.TOTAL_AMOUNT, VW.PAP_VALUE_LIMIT ,"+
			" case when (PAP_APPROVER<>0 and pap_flag<>'') then 'R2A' else 'A2R' end MAIL_DIRECTION,"+
			" case when pap_approver<>0 AND pap_flag ='' and approve_status =0 then approver_id else pap_approver end mailfrom,"+ 
			" case when pap_approver<>0 AND pap_flag ='' and approve_status =0 then pap_approver else approver_id end mailto"+ 
			" from t_approvers ta INNER JOIN T_TRAVEL_DETAIL_DOM TD ON TD.TRAVEL_ID = ta.TRAVEL_ID and ta.TRAVELLER_ID = td.TRAVELLER_ID"+ 
			" LEFT JOIN VW_PAGE_ACCESS_PERMISSION  VW ON TA.SITE_ID = VW.SITE_ID "+
			" AND TA.APPROVER_ID  = VW.pendingWithUser AND TA.PAP_APPROVER = VW.viewToUser"+ 
			" where ta.travel_id='"+strRequistionId+"' and travel_type ='d' "+
			//" AND VW.IS_MAIL_FWD='Y'"+
			" AND  (td.TOTAL_AMOUNT > VW.PAP_VALUE_LIMIT OR pap_flag ='')"+
			" and(order_id = (select min(order_id ) from  t_approvers  where travel_id =ta.travel_id and travel_type =ta.travel_type and approve_status =0) )	)tbl";
	}else{
		strTrvType="I";
		sSqlStr=" select .DBO.USER_NAME(mailfrom) AS APPROVER_NAME, DBO.USEREMAIL(mailfrom) AS APPROVER_MAIL ,"+
		" .DBO.USER_NAME(mailto) AS NEXTWITH, DBO.USEREMAIL(mailto) AS NEXTWITH_MAIL , IS_MAIL_FWD, TOTAL_AMOUNT, PAP_VALUE_LIMIT"+ 
		" ,MAIL_DIRECTION from ("+
		" select  ta.travel_id, order_id, TA.site_id ,travel_type, approver_id, pap_approver, pap_flag, approve_status,"+ 
		" VW.IS_MAIL_FWD, td.TOTAL_AMOUNT, VW.PAP_VALUE_LIMIT ,"+
		" case when (PAP_APPROVER<>0 and pap_flag<>'') then 'R2A' else 'A2R' end MAIL_DIRECTION,"+
		" case when pap_approver<>0 AND pap_flag ='' and approve_status =0 then approver_id else pap_approver end mailfrom,"+ 
		" case when pap_approver<>0 AND pap_flag ='' and approve_status =0 then pap_approver else approver_id end mailto"+ 
		" from t_approvers ta INNER JOIN T_TRAVEL_DETAIL_INT TD ON TD.TRAVEL_ID = ta.TRAVEL_ID and ta.TRAVELLER_ID = td.TRAVELLER_ID"+ 
		" LEFT JOIN VW_PAGE_ACCESS_PERMISSION  VW ON TA.SITE_ID = VW.SITE_ID "+
		" AND TA.APPROVER_ID  = VW.pendingWithUser AND TA.PAP_APPROVER = VW.viewToUser"+ 
		" where ta.travel_id='"+strRequistionId+"' and travel_type ='I' "+
		//" AND VW.IS_MAIL_FWD='Y' "+
		" AND  (td.TOTAL_AMOUNT > VW.PAP_VALUE_LIMIT OR pap_flag ='')"+
		" and(order_id = (select min(order_id ) from  t_approvers  where travel_id =ta.travel_id and travel_type =ta.travel_type and approve_status =0) )	)tbl";

	}
	//System.out.println("sSqlStr--first query on apprval mail -->"+sSqlStr);
	stmt		= con.createStatement(); 
	rs			= stmt.executeQuery(sSqlStr);
	String strFromName="";
	String strFromMail="";
	String strToName="";
	String strToMail="";
	String strMailFwdFlag="";
	String strMailDir="";
	if(rs.next())
	{
		strMailFlag="Y";
		strFromName= rs.getString("APPROVER_NAME");
		strFromMail= rs.getString("APPROVER_MAIL");
		strToName= rs.getString("NEXTWITH");
		strToMail= rs.getString("NEXTWITH_MAIL");
		strMailFwdFlag= rs.getString("IS_MAIL_FWD");
		if(strMailFwdFlag==null)
			strMailFwdFlag="";
		strMailDir= rs.getString("MAIL_DIRECTION");
	}
	rs.close();
	stmt.close();
	
	/*sSqlStr=" SELECT TA.APPROVER_ID	FROM T_APPROVERS TA"+
			" inner join VW_PAGE_ACCESS_PERMISSION PAP on pap.viewToUser=TA.PAP_APPROVER "+
			" and pap.pendingWithUser = TA.APPROVER_ID"+
			" WHERE TA.TRAVEL_ID='"+strRequistionId+"' AND TA.ORDER_ID=(SELECT MIN(ORDER_ID) FROM T_APPROVERS WHERE T_APPROVERS.TRAVEL_ID='"+strRequistionId+"' AND T_APPROVERS.SITE_ID='"+strSiteID+"' AND T_APPROVERS.TRAVEL_TYPE='"+strTrvType+"' and T_APPROVERS.APPROVE_STATUS=0)"+ 
			" AND TA.SITE_ID='"+strSiteID+"' AND TA.PAP_APPROVER='"+Suser_id+"' AND TA.TRAVEL_TYPE='"+strTrvType+"'";*/
	sSqlStr=" SELECT TA.APPROVER_ID FROM T_APPROVERS TA"+
		    " inner join VW_PAGE_ACCESS_PERMISSION PAP on "+
		    " pap.viewToUser=TA.PAP_APPROVER and pap.pendingWithUser = case when ta.ORIGINAL_APPROVER =0 then TA.APPROVER_ID else ta.ORIGINAL_APPROVER  end"+
		 	" WHERE TA.TRAVEL_ID='"+strRequistionId+"'"+ 
		 	" AND TA.ORDER_ID=(SELECT MAX(ORDER_ID) FROM T_APPROVERS WHERE T_APPROVERS.TRAVEL_ID='"+strRequistionId+"'"+ 
		 	" AND SITE_ID='"+strSiteID+"' AND TRAVEL_TYPE='"+strTrvType+"' AND PAP_APPROVER='"+Suser_id+"' AND PAP_FLAG ='A')"+ 
		 	"AND TA.SITE_ID='"+strSiteID+"' AND TA.TRAVEL_TYPE='"+strTrvType+"'";
	//System.out.println("sSqlStr---second query on approval mail-->"+sSqlStr);
	stmt		= con.createStatement(); 
	rs			= stmt.executeQuery(sSqlStr);
	if(rs.next())
	{
		strApproverId		=	rs.getString("APPROVER_ID");
	}
	rs.close();
	stmt.close();
	//System.out.println("strApproverId-->"+strApproverId);
	if(strApproverId==null || strApproverId.equals("")){
		//System.out.println("----inside if ---");
		strApproverId=Suser_id;
	}
	//System.out.println("strApproverId----outside if --->"+strApproverId);
	
	
	 // FETCH Requistion Details
	if(ReqTyp.equals("Domestic Travel")) 
	{
		//TType="Domestic Travel Requisition No:";//added by vijay on 09/04/2007
		//added by manoj chand on 28 june 2012
		TType="label.mail.domesticatravelrequisitionno";
		//sSqlStr="SELECT TRAVEL_REQ_NO ,.DBO.user_name(C_USERID) AS ORIGINATOR, DBO.USEREMAIL(C_USERID)AS ORIGINATOR_MAIL, .DBO.USER_NAME('"+Suser_id+"') AS APPROVER_NAME,DBO.USEREMAIL('"+Suser_id+"') AS APPROVER_MAIL, ISNULL(RTRIM(.DBO.PRESENTAPPROVER("+strRequistionId+",'D',TRAVELLER_ID)),'NA') AS NEXTWITH, ISNULL(RTRIM(.DBO.PRESENTAPPROVER_USERID("+strRequistionId+",'D',TRAVELLER_ID)),'NA') AS NEXTWITH_USERID, ISNULL(RTRIM(.DBO.PRESENTAPPROVER_MAIL("+strRequistionId+",'D',TRAVELLER_ID)),'NA') AS NEXTWITH_MAIL, convert(varchar(30), C_DATETIME,113), .DBO.USER_NAME(TRAVELLER_ID) AS TRAVELLER_NAME ,convert(varchar(30),TRAVEL_DATE,113),SEX ,.DBO.SITENAME(T.SITE_ID) AS SITE_NAME,SITE_ID,T.GROUP_TRAVEL_FLAG,REASON_FOR_TRAVEL,t.TA_CURRENCY as TA_CURRENCY,t.TOTAL_AMOUNT as TOTAL_AMOUNT,dbo.sitename(t.BILLING_SITE) as BILLING_SITE,REASON_FOR_TRAVEL,BILLING_SITE as BILLING_SITE_id ,BILLING_CLIENT,C_USERID,dbo.FN_TRAVEL_CLASS("+strRequistionId+",'D') as travel_class  FROM T_TRAVEL_DETAIL_DOM t  WHERE TRAVEL_ID="+strRequistionId+" ";
		//CHANGE QUERY TO GET TRANSIT_TYPE BY MANOJ CHAND ON 24 APRIL 2012
		sSqlStr="SELECT TRAVEL_REQ_NO ,.DBO.user_name(C_USERID) AS ORIGINATOR, DBO.USEREMAIL(C_USERID)AS ORIGINATOR_MAIL, .DBO.USER_NAME('"+strApproverId+"') AS APPROVER_NAME,DBO.USEREMAIL('"+strApproverId+"') AS APPROVER_MAIL, ISNULL(RTRIM(.DBO.PRESENTAPPROVER("+strRequistionId+",'D',TRAVELLER_ID)),'NA') AS NEXTWITH, ISNULL(RTRIM(.DBO.PRESENTAPPROVER_USERID("+strRequistionId+",'D',TRAVELLER_ID)),'NA') AS NEXTWITH_USERID, ISNULL(RTRIM(.DBO.PRESENTAPPROVER_MAIL("+strRequistionId+",'D',TRAVELLER_ID)),'NA') AS NEXTWITH_MAIL, convert(varchar(30), C_DATETIME,113), .DBO.USER_NAME(TRAVELLER_ID) AS TRAVELLER_NAME ,convert(varchar(30),TRAVEL_DATE,113),SEX ,.DBO.SITENAME(T.SITE_ID) AS SITE_NAME,SITE_ID,T.GROUP_TRAVEL_FLAG,REASON_FOR_TRAVEL,dbo.FN_GET_EXPENDITURE('"+strRequistionId+"','D') AS Expenditure,dbo.sitename(t.BILLING_SITE) as BILLING_SITE,REASON_FOR_TRAVEL,BILLING_SITE as BILLING_SITE_id ,BILLING_CLIENT,C_USERID,dbo.FN_TRAVEL_CLASS("+strRequistionId+",'D') as travel_class,t.TRANSIT_TYPE,t.TRAVELLER_ID, (select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = t.SITE_ID) as TRAVEL_AGENCY_ID  FROM T_TRAVEL_DETAIL_DOM t  WHERE TRAVEL_ID="+strRequistionId+" ";
		
	}
	else
	{
		//TType="International Travel Requisition No:";//added by vijay on 09/04/2007
		//added by manoj chand on 28 june 2012
		TType="label.mail.internationalatravelrequisitionno";
		//sSqlStr="SELECT TRAVEL_REQ_NO ,.DBO.user_name(C_USERID) AS ORIGINATOR, DBO.USEREMAIL(C_USERID)AS ORIGINATOR_MAIL, .DBO.USER_NAME('"+Suser_id+"') AS APPROVER_NAME, DBO.USEREMAIL('"+Suser_id+"') AS APPROVER_MAIL, ISNULL(RTRIM(.DBO.PRESENTAPPROVER("+strRequistionId+",'I',TRAVELLER_ID)),'NA') AS NEXTWITH, ISNULL(RTRIM(.DBO.PRESENTAPPROVER_USERID("+strRequistionId+",'I',TRAVELLER_ID)),'NA') AS NEXTWITH_USERID, ISNULL(RTRIM(.DBO.PRESENTAPPROVER_MAIL("+strRequistionId+",'I',TRAVELLER_ID)),'NA') AS NEXTWITH_MAIL, convert(varchar(30),C_DATETIME,113),.DBO.USER_NAME(TRAVELLER_ID) AS TRAVELLER_NAME ,convert(varchar(30),TRAVEL_DATE,113), SEX, .DBO.SITENAME(T.SITE_ID) AS SITE_NAME,SITE_ID,T.GROUP_TRAVEL_FLAG,REASON_FOR_TRAVEL,t.TA_CURRENCY as TA_CURRENCY,t.TOTAL_AMOUNT as TOTAL_AMOUNT,dbo.sitename(t.BILLING_SITE) as BILLING_SITE,REASON_FOR_TRAVEL,BILLING_SITE as BILLING_SITE_id ,BILLING_CLIENT,C_USERID,dbo.FN_TRAVEL_CLASS("+strRequistionId+",'I') as travel_class FROM T_TRAVEL_DETAIL_INT T  WHERE TRAVEL_ID="+strRequistionId+"  ";
		//CHANGE QUERY TO GET TRANSIT_TYPE BY MANO CHAND ON 24 APRIL 2012
		sSqlStr="SELECT TRAVEL_REQ_NO ,.DBO.user_name(C_USERID) AS ORIGINATOR, DBO.USEREMAIL(C_USERID)AS ORIGINATOR_MAIL, .DBO.USER_NAME('"+strApproverId+"') AS APPROVER_NAME, DBO.USEREMAIL('"+strApproverId+"') AS APPROVER_MAIL, ISNULL(RTRIM(.DBO.PRESENTAPPROVER("+strRequistionId+",'I',TRAVELLER_ID)),'NA') AS NEXTWITH, ISNULL(RTRIM(.DBO.PRESENTAPPROVER_USERID("+strRequistionId+",'I',TRAVELLER_ID)),'NA') AS NEXTWITH_USERID, ISNULL(RTRIM(.DBO.PRESENTAPPROVER_MAIL("+strRequistionId+",'I',TRAVELLER_ID)),'NA') AS NEXTWITH_MAIL, convert(varchar(30),C_DATETIME,113),.DBO.USER_NAME(TRAVELLER_ID) AS TRAVELLER_NAME ,convert(varchar(30),TRAVEL_DATE,113), SEX, .DBO.SITENAME(T.SITE_ID) AS SITE_NAME,SITE_ID,T.GROUP_TRAVEL_FLAG,REASON_FOR_TRAVEL,dbo.FN_GET_EXPENDITURE('"+strRequistionId+"','I') AS Expenditure,dbo.sitename(t.BILLING_SITE) as BILLING_SITE,REASON_FOR_TRAVEL,BILLING_SITE as BILLING_SITE_id ,BILLING_CLIENT,C_USERID,dbo.FN_TRAVEL_CLASS("+strRequistionId+",'I') as travel_class,T.HOTEL_REQUIRED AS TRANSIT_TYPE,T.TRAVELLER_ID, (select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = T.SITE_ID) as TRAVEL_AGENCY_ID FROM T_TRAVEL_DETAIL_INT T  WHERE TRAVEL_ID="+strRequistionId+"  ";
		
	}
	 //System.out.println("sSqlStr==3====="+sSqlStr);
	
	stmt= con.createStatement(); 
	
	rs = stmt.executeQuery(sSqlStr);
	if(rs.next())
	{
		strRequistionNumber									=	rs.getString(1);// Number
		strRequistionCreatorName			 				=	rs.getString(2);//Creator Name
		strRequistionCreatorMail				 			=	rs.getString(3);//Creator Email
		strstrRequistionApproverName						=	rs.getString(4);//APPROVER NAME
		strstrRequistionApproverEmail			 			=	rs.getString(5);//APPROVER EMAIL
		strstrRequistionNextApproverName					=	rs.getString(6);//NEXT APPROVER NAME
		strRequistionNextApprover_UserId					=	rs.getString(7);//NEXT APPROVER USER_ID NEW FIELDS
		strstrRequistionNextApproverEmail			 		=	rs.getString(8);//NEXT APPROVER MAIL
		//@ Vijay 30-Mar-2007 Add the substring Method for time format
		String strRequistionCreatedDate1			 		=	rs.getString(9);//Req Created Date & time
		String str											= strRequistionCreatedDate1.substring(0,17);
		String str1											= strRequistionCreatedDate1.substring(0,11);
		strRequistionCreatedDate=str;
		strRequistionCreatedDateWithoutAMPM=str1;	
		//End Modification
		strUserNm								 			=	rs.getString(10);//TRAVELLER NAME
		strTravelDate										=	rs.getString(11).substring(0,11); // TRAVEL DATE
		strTravellerSex										=	rs.getString(12); // TRAVELLER SEX
		strSiteName											=	rs.getString(13); //site name
		strSiteId                                           =	rs.getString(14); //site id
						
		if(strTravellerSex.equals("1"))	{
			strSex	 =	 "Mr.";
		}
		else{
			strSex	 =	 "Ms";
		}
		
		strTravelAgencyTypeId	 =	rs.getString("TRAVEL_AGENCY_ID");
		
		if(ReqTyp.equals("Domestic Travel"))
		{
			//code commented by manoj chand and replace with new query on 27 june 2013.	
			//strSql	=	"SELECT TRAVEL_FROM,TRAVEL_TO FROM T_JOURNEY_DETAILS_DOM WHERE TRAVEL_ID="+strRequistionId+"	";
			strSql ="select * FROM  [dbo].[FN_GetDeparturecity]("+strRequistionId+",'d')";
		    //strGroupTravel = strSex+" "+"<b> "+strUserNm+ "</b> is scheduled to travel."; 
		    // code added for showing group travel  in case of domestie group travel_DOM  on shiv sharma on 19-Jun-08  
	    
			   strGroupTravelFlag       =   rs.getString("GROUP_TRAVEL_FLAG"); 
					     if(strGroupTravelFlag==null) {
			               strGroupTravel =""; 
				 		     }
						 if(strGroupTravelFlag!=null  &&  (strGroupTravelFlag.trim().equals("Y"))){
	                   					 strGroupTravel =dbLabelBean.getLabel("label.mail.groupguestisscheduledtotravel",strsesLanguage); 
	                   					if(strTravelAgencyTypeId.equals("2")) {
	    	                   				strGroupTravel =dbLabelBean.getLabel("label.mail.guestisscheduledtotravel",strsesLanguage);
	    	   	 						}
	                        }
							else {
	                   				    strGroupTravel = strSex+" "+"<b> "+strUserNm+ "</b> "+dbLabelBean.getLabel("label.mail.isscheduledtotravel",strsesLanguage); 
							 }
					// Sql for getting return date added on 2/13/2009 
					// SQL QUERY CHANGED BY MANOJ CHAND ON 26 MAY 2011
					 strSqlSql="SELECT CONVERT(VARCHAR(11), TRAVEL_DATE, 113) FROM "+         		   
							   " T_RET_JOURNEY_DETAILS_DOM WHERE  (TRAVEL_ID = "+strRequistionId+") and  (RETURN_FROM <> '') AND (RETURN_TO <> '')" ;
	
	   }
		else 
		{
			
			 
			//  Added by shiv for showing Group Travel in case of group travel   on 25-Feb-08 ;  
	
	         strGroupTravelFlag       =   rs.getString("GROUP_TRAVEL_FLAG"); 
					     if(strGroupTravelFlag==null) 
							{
			               strGroupTravel =""; 
				 		     }
	
						 if(strGroupTravelFlag!=null  &&  (strGroupTravelFlag.trim().equals("Y")))
							{
	                   					 strGroupTravel =dbLabelBean.getLabel("label.mail.groupguestisscheduledtotravel",strsesLanguage);
	                   					if(strTravelAgencyTypeId.equals("2")) {
	    	                   				strGroupTravel =dbLabelBean.getLabel("label.mail.guestisscheduledtotravel",strsesLanguage);
	    	   	 						}
	                        }
							else
						      {
	                   				    strGroupTravel = strSex+" "+"<b> "+strUserNm+ "</b> "+dbLabelBean.getLabel("label.mail.isscheduledtotravel",strsesLanguage); 
							 }
	
			//code commented by manoj chand and replace with new query on 27 june 2013.
			//strSql	=	"SELECT TRAVEL_FROM,TRAVEL_TO FROM T_JOURNEY_DETAILS_INT WHERE TRAVEL_ID="+strRequistionId+"	";
			strSql ="select * FROM  [dbo].[FN_GetDeparturecity]("+strRequistionId+",'i')";
	
	
			// Sql for getting return date added on 2/13/2009 
			strSqlSql="SELECT CONVERT(VARCHAR(11), TRAVEL_DATE, 113) FROM "+         		   
							   " T_RET_JOURNEY_DETAILS_INT WHERE  (TRAVEL_ID = "+strRequistionId+") and  (RETURN_FROM <> '') AND (RETURN_TO <> '')" ;
	
		}
	
	
		strreasonFortravel   =   rs.getString("REASON_FOR_TRAVEL");
		String text   		 = 	 rs.getString("Expenditure"); 
		//strCurrency			 =   rs.getString("TA_CURRENCY");//TOTAL_AMOUNT 
		//strTotalAmount       =   rs.getString("TOTAL_AMOUNT"); //BILLING_SITE
		strBillingSite       =   rs.getString("BILLING_SITE");
		//strTotalAmount= dblFunnelVal.format(Double.parseDouble(strTotalAmount));
		String strbillingSiteid		 = rs.getString("BILLING_SITE_id");  
		String strBillingClient    = rs.getString("BILLING_CLIENT");  
		String strCreatorID        = rs.getString("C_USERID");
		strTravelClass			=	rs.getString("travel_class"); //added on 25 march 2010 by shiv sharma
		//added by manoj chand on 24 april 2012 to show transit house related message in email.
		strTransitType = rs.getString("TRANSIT_TYPE");
		if(strTransitType.trim().equalsIgnoreCase("2")){
			//strTrasitMsg="<font size=2 color=red >"+dbLabelBean.getLabel("label.mail.smokingandalcolholmsg",strsesLanguage)+"</font><br>";
			strTrasitMsg="label.mail.smokingandalcolholmsg";
		}
		String strTravellerId=rs.getString("TRAVELLER_ID");
		
		logger.info("TRAVEL AGENCY ID is-->" +strTravelAgencyTypeId);
		
		// code added by shiv for sendin mail to last approver if last approver is not MATA on 26-Oct-09   
		String strISLastapprover   ="no";	
		if(strRequistionNextApprover_UserId.equalsIgnoreCase("NA")){
			strRequistionNextApprover_UserId	=strCreatorID;
			strstrRequistionNextApproverName    =strRequistionCreatorName;
			strISLastapprover="yes"; 
		}
			
		if(strbillingSiteid.equals("-1")) { //case of out side smg 
		strBillingSite=strBillingClient;  
		}
	
		if(strbillingSiteid.equals("0")) { //case of self smg 
		//strBillingSite="self";
		//change by manoj chand on 01 nov 2011 to show billing client in approval mail
			strBillingSite=strBillingClient; 
		}
	   	
		rs.close();
		stmt1= con.createStatement(); 
		rs1 = stmt1.executeQuery(strSql);
		if(rs1.next())
		{
			strTravelFrom	=	rs1.getString(1);
			strTravelTo		=	rs1.getString(2);
		}
		rs1.close();
		stmt1.close();
	   //code to find return date from Query 
		stmt1= con.createStatement(); 
   		rs2 = stmt1.executeQuery(strSqlSql);
				if(rs2.next())
				{
						strTravelReturnDate	=	rs2.getString(1);		
				}
	
		rs2.close();
		stmt1.close();
		 
	aList  = dbUtilityBean.getApproverAccoringToRole(strRequistionNextApprover_UserId,strSiteId);
	
	 if(ReqTyp.equals("Domestic Travel"))
		{
	    strTraveltype="d";
		}
		else
		{
			    strTraveltype="i";
		}
	
	 
		// code that send CC mail to mata Assoctias for intimaton  
		// code that  find is next approver is last approver or not if yes it will return Y or N  added on 27-Mar-08
	
	   //sSqlStr ="select case when 	(select max(order_id) from T_APPROVERS where TRAVEL_ID="+strRequistionId+" AND TRAVEL_TYPE= '"+strTraveltype+"')=(select order_id from T_APPROVERS where order_id = (select isnull(min(order_id),-1)  from T_APPROVERS 	where TRAVEL_ID="+strRequistionId+" AND approve_status =0 AND TRAVEL_TYPE= '"+strTraveltype+"')  	and TRAVEL_ID="+strRequistionId+" AND TRAVEL_TYPE='"+strTraveltype+"')  then 'y' else 'n' end  " ;
	
	    sSqlStr ="select case when 	(select max(order_id) from T_APPROVERS where TRAVEL_ID="+strRequistionId+" AND TRAVEL_TYPE= '"+strTraveltype+"')= (select isnull(max(order_id),-1)  from T_APPROVERS 	where TRAVEL_ID="+strRequistionId+" AND approve_status =10 AND TRAVEL_TYPE= '"+strTraveltype+"')  then 'y' else 'n' end  " ;

	   stmt= con.createStatement(); 
	    rs = stmt.executeQuery(sSqlStr);
		while(rs.next())
		        {
			  strLastApprover_flag=rs.getString(1);
		 }
	
	rs.close();
	
	//System.out.println("strLastApprover_flag--->"+strLastApprover_flag); 
	if(strLastApprover_flag.equals("y")) 
		{
	    //code that send CC mail to mata Assoctias for intimaton  
		//QUERY CHANGED BY MANOJ CHAND ON 10 JAN 2013 TO RESOLVE ISSUE OF BLANK CC_MAIL RECEIVED. 
	     	sSqlStr="SELECT  M_DEFAULT_APPROVERS.MATA_CC_MAIL  FROM   T_APPROVERS INNER JOIN  M_DEFAULT_APPROVERS  ON T_APPROVERS.APPROVER_ID = M_DEFAULT_APPROVERS.APPROVER_ID AND  T_APPROVERS.SITE_ID =M_DEFAULT_APPROVERS.SITE_ID  WHERE    (T_APPROVERS.SITE_ID = "+strSiteId+") AND (T_APPROVERS.TRAVEL_ID = "+strRequistionId+") AND (T_APPROVERS.TRAVEL_TYPE = '"+strTraveltype+"') AND M_DEFAULT_APPROVERS.TRV_TYPE='"+strTraveltype+"' AND T_APPROVERS.STATUS_ID=10 AND M_DEFAULT_APPROVERS.STATUS_ID=10 AND M_DEFAULT_APPROVERS.ORDER_ID=(SELECT MAX(ORDER_ID) FROM M_DEFAULT_APPROVERS A WHERE A.SITE_ID="+strSiteId+" AND A.TRV_TYPE='"+strTraveltype+"' AND A.STATUS_ID=10)"; 
	         		
	
	  	 	  rs = dbConBean.executeQuery(sSqlStr);
	          if(rs.next())
	               {
	           	          strMailID_MataAsso	=	rs.getString(1);//Mail ID of CC mails 
						  if (strMailID_MataAsso==null || strMailID_MataAsso.equals(""))
					            {
							  strMailID_MataAsso=strRequistionCreatorMail;
						  }
	               }
	}
	else{
		strMailID_MataAsso="";
	}
	
	//code added  by manoj chand on 11 jan 2013 to send mail after request is approved by last approver. and last approver is not mata.
	rs=null;
	String strTempflag="";
	sSqlStr="select case when not exists(select  1 FROM T_APPROVERS WHERE (TRAVEL_ID = '"+strRequistionId+"') AND (TRAVEL_TYPE = '"+strTraveltype+"') AND APPROVE_STATUS=0 AND STATUS_ID=10) then 'y' else 'n' end";
	 rs = dbConBean.executeQuery(sSqlStr);
	 //System.out.println("sSqlStr---if--->"+sSqlStr);
	 if(rs.next()){
	 strTempflag=rs.getString(1);
	}
	 //System.out.println("strTempflag---if--->"+strTempflag);
     if(strTempflag.equals("y"))
          {
      	  sSqlStr="SELECT isnull(MDA.MATA_CC_MAIL,'') FROM T_APPROVERS TA"+
 			 " INNER JOIN M_DEFAULT_APPROVERS MDA"+
 			 " ON MDA.SITE_ID=TA.SITE_ID AND MDA.APPROVER_ID=TA.APPROVER_ID"+ 
 			 " WHERE (TA.SITE_ID = '"+strSiteId+"') AND (TA.TRAVEL_ID = '"+strRequistionId+"') AND (TA.TRAVEL_TYPE = '"+strTraveltype+"') AND MDA.TRV_TYPE='"+strTraveltype+"' AND TA.STATUS_ID=10 AND MDA.STATUS_ID=10"+
 			 " AND TA.ORDER_ID=(SELECT MAX(ORDER_ID) FROM T_APPROVERS WHERE (TRAVEL_ID = '"+strRequistionId+"') AND (TRAVEL_TYPE = '"+strTraveltype+"') AND APPROVE_STATUS=10 AND STATUS_ID=10) AND TA.ROLE<>'MATA' "+
 			 " and sp_role = (select sp_role from m_userinfo where userid='"+strTravellerId+"' and loginstatus in ('ACTIVE','ENABLE'))";
 			 //System.out.println("sSqlStr---ELSE--->"+sSqlStr); 
 			 rs4 = dbConBean.executeQuery(sSqlStr);
        	  if(rs4.next()){
        	  	strMailID_MataAsso	=	rs4.getString(1);
        	  }
          }
	
	// find the orignal approver name in case of handover mail  for sending mail 
		
		if(ReqTyp.equals("Domestic Travel")){
			strSql="select isnull(dbo.USEREMAIL(ORIGINAL_APPROVER),'') as  ORIGINAL_APPROVER from t_approvers where (TRAVEL_ID = "+strRequistionId+") and travel_type='d' and approve_status='0'";
	
		}
		else	{
			strSql="select isnull(dbo.USEREMAIL(ORIGINAL_APPROVER),'') as  ORIGINAL_APPROVER from t_approvers where (TRAVEL_ID = "+strRequistionId+") and travel_type='i' and approve_status='0'";
		}
	
		 
	     
		 rs = dbConBean.executeQuery(strSql);
	 	if(rs.next())
	      	{
	  	          strMailID_OrignalApprover	=	rs.getString(1);//Mail ID of CC mails 
				 
	      }
	 	
	 	
	   
	 	
	 	
	 	if (!strMailID_MataAsso.equals(""))
	 	{
	 		strMailID_MataAsso=strMailID_MataAsso+";"+strMailID_OrignalApprover;
	 	
	 	}else
	 		{
	 		strMailID_MataAsso=strMailID_MataAsso+strMailID_OrignalApprover;
	 		
	 	}	 
	 	
	 //System.out.println("strMailID_MataAsso==="+strMailID_MataAsso);
	 
	///
	
		Iterator itr =  aList.iterator();
		while(itr.hasNext())
		{
			strstrRequistionNextApproverName       = (String) itr.next();
			strstrRequistionNextApproverEmail      = (String) itr.next();
			
			//added by manoj chand on 20 june 2012 to get mail to person language preference
			strSql	=	"SELECT LANGUAGE_PREF FROM M_USERINFO WHERE EMAIL =N'"+strstrRequistionNextApproverEmail+"' AND STATUS_ID=10";
			stmt2= con.createStatement(); 
			rs3 = stmt2.executeQuery(strSql);
			if(rs3.next()){
				strsesLanguage=rs3.getString("LANGUAGE_PREF");
				if(strsesLanguage==null || strsesLanguage.equals("")){
					strsesLanguage="en_US";
				}
			}
			rs3.close();
			stmt2.close();
			
			
			strMailMsg = new StringBuffer();
			strCreationDate=strMailCreatedate;////3/19/2007
	  
			if(strTransitType.trim().equalsIgnoreCase("2")){
			 	strTrasitMsg1="<font size=2 color=red >"+dbLabelBean.getLabel(strTrasitMsg,strsesLanguage)+"</font><br>";
			 	}
			
			
			if(strTravelAgencyTypeId.equals("2")){
				groupGuestLabel = "label.global.guest";
			}else{
				groupGuestLabel = "label.approverequest.groupguest";
			}
			
		   if(strISLastapprover.equals("no")){
			   
		   if(strMailFlag.equals("N") || strMailDir.equals("A2R")){
			   if(strGroupTravelFlag!=null  &&  (strGroupTravelFlag.trim().equals("Y"))) {
				   strMailSubject=dbLabelBean.getLabel("label.mail.starsnotification",strsesLanguage)+" "+dbLabelBean.getLabel(TType,strsesLanguage)+" '"+strRequistionNumber.trim()+"' "+dbLabelBean.getLabel(groupGuestLabel,strsesLanguage)+" "+dbLabelBean.getLabel("label.mainmenu.pendingforapproval",strsesLanguage)+" ";//Mail Subject
			   } else {
				   strMailSubject=dbLabelBean.getLabel("label.mail.starsnotification",strsesLanguage)+" "+dbLabelBean.getLabel(TType,strsesLanguage)+" '"+strRequistionNumber.trim()+"' "+dbLabelBean.getLabel("label.mainmenu.pendingforapproval",strsesLanguage)+" ";//Mail Subject 
			   }
			
			   logger.info("Pending for approval main block start for Requisition Number-->"+strRequistionId+ " at " +dateFormat.format(cal.getTime()));
			try
			{
				String strSSOUrl = dbUtilityBean.sSSOUrlByMailid(strstrRequistionNextApproverEmail); //Added by vaibhav

				strMailMsg.append("<html><style>.formhead{ font-family:Arial;font-size:11px;font-style: normal;font-weight:normal;color:#000000;text-decoration:none;letter-spacing:normal;word-spacing:normal;border:1px #333333 solid;background:#E2E4D6;}</style><body bgcolor=\"#d0d0d0\">" + "\n");	
				strMailMsg.append(" <table width=80% border=0 cellspacing=0 cellpadding=0 align=center><tr><td align=right><font face=Verdana, Arial, Helvetica, sans-serif size=2><b><font color=#FFFFFF>"+strRequistionCreatedDateWithoutAMPM+"</font><font color=#FFFFFF></font><font color=#000000><br></font></b><font color=#FFFFFF>"+dbLabelBean.getLabel("label.mail.forinternalcirculationonly",strsesLanguage)+"</font></font></td></tr><tr><td bgcolor=#000000> </td></tr><tr><td bgcolor=#FFFFFF align=center>"+ "\n");
				strMailMsg.append("</td></tr><tr><td bgcolor=#000000> </td></tr><tr><td bgcolor=#FFFFFF align=center><table width=100% border=0 cellspacing=0 cellpadding=10><tr><td align=center bgcolor=#aa1220><font face=Arial, Helvetica, sans-serif size=5 color=#FFFFFF>"+dbLabelBean.getLabel("label.mail.starsmailnotification",strsesLanguage)+"</font></td></tr></table></td></tr><tr><td bgcolor=#000000> </td></tr><tr>"+ "\n");
				strMailMsg.append("<td bgcolor=#B6DCDC></td></tr><tr><td bgcolor=#000000> </td></tr><tr><td bgcolor=#000000> </td></tr><tr><td bgcolor=#FFFFFF><table width=100% border=0 cellspacing=0 cellpadding=5>"+ "\n");						
				strMailMsg.append("  <tr><td align=center bgcolor=#aa1220><font face=Verdana, Arial, Helvetica, sans-serif size=2><b><font color=#FFFFFF><font size=2>"+dbLabelBean.getLabel(ReqTyp1,strsesLanguage)+" "+dbLabelBean.getLabel("label.mail.requisition",strsesLanguage)+"</font> </font></b></font></td></tr><tr><td bgcolor=#878787><font face=Verdana, Arial, Helvetica, sans-serif size=2><b>"+dbLabelBean.getLabel(ReqTyp1,strsesLanguage)+" "+dbLabelBean.getLabel("label.global.requisitionnumber",strsesLanguage)+" : "+strRequistionNumber.trim()+"</b> ("+dbLabelBean.getLabel("label.mail.dated",strsesLanguage)+" : "+strRequistionCreatedDate+")</font></td></tr><tr><td><p><font color=#FFFFFF></font><font size=2 face=Verdana, Arial, Helvetica, sans-serif>"+ "\n"); 				
				strMailMsg.append(dbLabelBean.getLabel("label.mail.dear",strsesLanguage)+" "+strstrRequistionNextApproverName+",</font></p><p><font size=2 face=Verdana, Arial, Helvetica, sans-serif>"+dbLabelBean.getLabel("label.global.requisitionnumber",strsesLanguage)+" "+strRequistionNumber.trim()+" "+dbLabelBean.getLabel("label.mail.whichwasoriginatedby",strsesLanguage)+" "+strRequistionCreatorName+" "+dbLabelBean.getLabel("label.approverrequest.from",strsesLanguage)+" "+strSiteName+" "+dbLabelBean.getLabel("label.mail.on",strsesLanguage)+" "+strRequistionCreatedDate+" "+dbLabelBean.getLabel("label.mail.hasbeenapprovedbyme",strsesLanguage)+"</p>"+ "\n"); 
				strMailMsg.append("<u><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>"+dbLabelBean.getLabel("label.mail.requisitionsdetails",strsesLanguage)+" </u>:-</font><font size=2 face=Verdana, Arial, Helvetica, sans-serif >"+strGroupTravel+"<br>  </font>\n<br>"); 
				strMailMsg.append("<u><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>"+dbLabelBean.getLabel("label.global.reasonfortravel",strsesLanguage)+" </u>:- </font><font size=2 face=Verdana, Arial, Helvetica, sans-serif >"+strreasonFortravel+"</font>\n<br><br>"); 
				
				if((strTravelAgencyTypeId != null && strTravelAgencyTypeId.equals("2"))) {
					strMailMsg.append(new T_QuicktravelRequestDaoImpl().customizeApproverMailBodyGmbh(strRequistionId, strTraveltype, strTravellerId));
				}else{
					strMailMsg.append("<TABLE border=0 width=750  ><TR  height=10 ><TD    width=170><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue >"+dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)+" </TD><TD    width=200><font size=2 face=Verdana, Arial, Helvetica, sans-serif >:- "+strTravelDate+"</TD><TD    width=170><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>"+dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)+" </TD><TD><font size=2 face=Verdana, Arial, Helvetica, sans-serif > :- "+strTravelFrom+"</TD></TR><TR  height=10><TD ><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>"+dbLabelBean.getLabel("label.report.returndate",strsesLanguage)+" </TD><TD><font size=2 face=Verdana, elvetica, sans-serif > :- "+strTravelReturnDate+" </TD><TD ><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>"+dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)+" </TD><TD ><font size=2 face=Verdana, Arial, Helvetica, sans-serif>:-  "+strTravelTo+"</TD></TR><TR  height=10><TD ><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>"+dbLabelBean.getLabel("label.mail.amountrequested",strsesLanguage)+"</TD><TD width=240><font size=2 face=Verdana, Arial, Helvetica, sans-serif >:- "+text+"</TD><TD><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>"+dbLabelBean.getLabel("label.requestdetails.billingclient",strsesLanguage)+" </TD><TD><font size=2 face=Verdana, Arial, Helvetica, sans-serif >:- "+strBillingSite+" </TD></TR><TR  height=10><TD ><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>"+dbLabelBean.getLabel("label.approverequest.travelclass",strsesLanguage)+"</TD><TD ><font size=2 face=Verdana, Arial, Helvetica, sans-serif >:- "+strTravelClass+"</TD><TD><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue></TD><TD><font size=2 face=Verdana, Arial, Helvetica, sans-serif >&nbsp;</TD></TR></TABLE>");
				}
				
				strMailMsg.append("<br><font size=2 face=Verdana, Arial, Helvetica, sans-serif><U><FONT COLOR=BLUE>"+strstrRequistionApproverName+" "+dbLabelBean.getLabel("label.mail.approvingcomments",strsesLanguage)+"</FONT></u><br>"+strRequisitionComments.trim()+" "+ "\n"); 
			    strMailMsg.append("</font><br><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif><a href='"+strSSOUrl+"'>"+dbLabelBean.getLabel("label.mail.pleaseclickheretologintostars",strsesLanguage)+" </a> "+ "\n");
				strMailMsg.append("   </b></form></font><br><p><font size=2 face=Verdana, Arial, Helvetica, sans-serif>"+dbLabelBean.getLabel("label.mail.bestregards",strsesLanguage)+"</font><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif>"+strstrRequistionApproverName.trim()+"<br></font></p></td></tr></table></td></tr><tr><td bgcolor=#878787 align=center> <font face=Verdana, Arial, Helvetica, sans-serif size=1><b>"+dbLabelBean.getLabel("label.mail.mailreferencenumber",strsesLanguage)+" </b>"+strMailRefNumber+"/"+strCurrentYear+"</font></td></tr><tr><td bgcolor=#FFFFFF align=center>       <table width=100% border=0 cellspacing=0 cellpadding=5>"+ "\n"); 
				strMailMsg.append("<tr><td align=center bgcolor=#aa1220><font size=2 face=Verdana, Arial, Helvetica, sans-serif><b><font size=1>"+dbLabelBean.getLabel("label.mail.starsadministratorcanbecontacted",strsesLanguage)+" : - </font></b><font size=1><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=#000000>"+ "\n"); 
				strMailMsg.append("<a href=mailto:administrator.stars@mind-infotech.com><font size=1 color=#ffffff>administrator.stars@mind-infotech.com</font></a></font></font></font></td>  "+ "\n");  
				strMailMsg.append(" </tr><tr><td  align=center bgcolor=#878787 height=15> <b><font size=1 face=Verdana, Arial, Helvetica, sans-serif>"+dbLabelBean.getLabel("label.mail.disclaimer",strsesLanguage)+"</b> : "+dbLabelBean.getLabel("label.mail.thiscommunicationissystemgenererated",strsesLanguage)+" "+ "\n");  
				strMailMsg.append(dbLabelBean.getLabel("label.mail.pleasedonnotreplytothismail",strsesLanguage)+" <br>"+dbLabelBean.getLabel("label.mail.ifyouarenotthecorrectrecipientforthisnotification",strsesLanguage)+"</font></td></tr></table></td></tr><tr><td bgcolor=#000000></td></tr>"+ "\n");    
				strMailMsg.append("<tr><td align=center><font size=2 face=Verdana, Arial, Helvetica, sans-serif><font size=1 color=#000000>&copy;"+dbLabelBean.getLabel("label.mail.mindallrightsreserved",strsesLanguage)+"</font></font></td>  </tr></table><p>&nbsp;</p></body></html>"+ "\n");
				
				//System.out.println("strMailMsg====1====="+strMailMsg); 
				logger.info("Pending for approval inner block start for Requisition Number-->"+strRequistionId+ " at " +dateFormat.format(cal.getTime()));
				try
				{
					//Procedure for inserting Mail Data
					cstmt_mail=con.prepareCall("{?=call PROC_REQUISITION_MAIL_ADD(?,?,?,?,?,?,?,?,?,?,?,?)}");
					cstmt_mail.registerOutParameter(1,java.sql.Types.INTEGER);
					cstmt_mail.setString(2, strRequistionId);
					cstmt_mail.setString(3, strRequistionNumber);
					cstmt_mail.setString(4, strstrRequistionNextApproverEmail);//To
					cstmt_mail.setString(5, strstrRequistionApproverEmail);//From
					cstmt_mail.setString(6, strMailID_MataAsso);//CC  mail will go to mata Associates
					cstmt_mail.setString(7, strMailSubject);
					cstmt_mail.setString(8, strMailMsg.toString());
					cstmt_mail.setInt(9, intTries);
					cstmt_mail.setString(10, "NEW");
					cstmt_mail.setString(11, strApproverId);
					cstmt_mail.setString(12, "Approval Process");
					cstmt_mail.setString(13, "Signatory Approves IT");
	                cstmt_mail.execute();
					cstmt_mail.close(); 
					logger.info("Pending for approval inner block end for Requisition Number-->"+strRequistionId+ " at " +dateFormat.format(cal.getTime()));
				}
				catch(Exception b)
				{
					System.out.println("ERROR in T_requisitionMailOnApproval---1--------"+b);
					logger.log(Level.ERROR, "Error occur in Pending for Approval inner mail try/catch block", b);
				}
				logger.info("Pending for approval main block end for Requisition Number-->"+strRequistionId+ " at " +dateFormat.format(cal.getTime()));
			}
			catch(Exception e)
			{
				System.out.println("Error in T_requisitionMailOnApproval--------------2-------------"+e);
				logger.log(Level.ERROR, "Error occur in Pending for Approval main mail try/catch block", e);
			}
		   }// IF END

		  }//if of last approver
		   else{
			   
			   String strTravellerMail="";
			 	if(!strTravellerId.equals(strCreatorID)) {			
					String strQuery1 = "SELECT DBO.USEREMAIL(MUI.USERID) AS TRAVELLEREMAIL FROM M_USERINFO MUI WHERE MUI.USERID="+strTravellerId+" AND MUI.STATUS_ID=10 AND MUI.APPLICATION_ID=1"; 
					rs = dbConBean.executeQuery(strQuery1);
					if(rs.next()){
						strTravellerMail =  rs.getString("TRAVELLEREMAIL");
					}
				}
			   
			 	logger.info("Send mail to MATA_GmbH Start for Requisition Number-->"+strRequistionId+ " at " +dateFormat.format(cal.getTime()));
			    // Send Mail to MATA GmbH and Travel Coordinator
				if((isMATA_GmbH != null && isMATA_GmbH.equals("true")) || (strTravelAgencyTypeId != null && strTravelAgencyTypeId.equals("2"))) {
					logger.info("Get MATA GmbH Email Content Start for Requisition Number-->"+strRequistionId+ " at " +dateFormat.format(cal.getTime()));
					String strMataGmbHMailContent = "";
					if(strGroupTravelFlag!=null  &&  (strGroupTravelFlag.trim().equals("Y"))) {
						 strMataGmbHMailContent = new T_QuicktravelRequestDaoImpl().getGroupMailBodyForMataGmbH(strRequistionId, strTrvType, strTravellerId);
					} else if(strGroupTravelFlag!=null  &&  (strGroupTravelFlag.trim().equals("N"))){
						 strMataGmbHMailContent = new T_QuicktravelRequestDaoImpl().getMailBodyForMataGmbH(strRequistionId, strTrvType, strTravellerId);
					}
					//logger.info("MATA GmbH Email Content -->" +strMataGmbHMailContent);
					logger.info("Get MATA GmbH Email Content End for Requisition Number-->"+strRequistionId+ " at " +dateFormat.format(cal.getTime()));
					
					String firstDepartureDate = "";
					String strSqlDepartureDate = "";
					if("I".equals(strTrvType) || "INT".equals(strTrvType)){
						strSqlDepartureDate = "SELECT CONVERT(VARCHAR(10),MIN(TRAVEL_DATE),103) AS FIRST_JOURNY_DATE FROM T_JOURNEY_DETAILS_INT WHERE TRAVEL_ID="+strRequistionId;
					}else if("D".equals(strTrvType) || "DOM".equals(strTrvType)){
						strSqlDepartureDate = "SELECT CONVERT(VARCHAR(10),MIN(TRAVEL_DATE),103) AS FIRST_JOURNY_DATE FROM T_JOURNEY_DETAILS_DOM WHERE TRAVEL_ID="+strRequistionId;
					}
					
					stmt2=null;
					rs2=null;
					stmt2= con.createStatement(); 
					rs2 = stmt2.executeQuery(strSqlDepartureDate);
					if(rs2.next()){
						firstDepartureDate=rs2.getString("FIRST_JOURNY_DATE");
					}
					rs2.close();
					stmt2.close();
					
					String emailIdsMataSql = "";
					
					if("I".equals(strTrvType) || "INT".equals(strTrvType)) {
						
						emailIdsMataSql = " select DBO.USEREMAIL(APPROVER_ID) MATAGMBH from T_TRAVEL_DETAIL_INT TDI "+ 
								" INNER JOIN T_APPROVERS TA ON TDI.TRAVEL_ID=TA.TRAVEL_ID AND "+
								" TA.TRAVEL_TYPE='"+strTrvType+"' WHERE TDI.TRAVEL_ID="+strRequistionId+" AND TA.ROLE='MATA' UNION "+
								" select email AS MATAGMBH from m_userinfo "+ 
								" WHERE site_id in (select FUNCTION_VALUE from  functional_ctl where function_key='@MataGmbHSite') and role_id ='MATA' and "+ 
								" exists(select 1 from T_TRAVEL_DETAIL_INT tdi inner join m_site s on tdi.SITE_ID = s.site_id "+ 
								" WHERE TRAVEL_ID="+strRequistionId+" and TRAVEL_AGENCY_ID=2) UNION "+
								" SELECT DBO.USEREMAIL(USERID) MATAGMBH FROM T_TRAVEL_DETAIL_INT TDI "+
								" INNER JOIN  USER_MULTIPLE_ACCESS UMA ON TDI.SITE_ID=UMA.SITE_ID "+
								" WHERE TDI.TRAVEL_ID="+strRequistionId+" AND UMA.TRAVEL_COORDINATOR =1 AND UMA.STATUS_ID=10";			
						
					} else if("D".equals(strTrvType) || "DOM".equals(strTrvType)) {
						
						emailIdsMataSql = " select DBO.USEREMAIL(APPROVER_ID) MATAGMBH from T_TRAVEL_DETAIL_DOM TDD "+
								" INNER JOIN T_APPROVERS TA ON TDD.TRAVEL_ID=TA.TRAVEL_ID AND "+
								" TA.TRAVEL_TYPE='"+strTrvType+"' WHERE TDD.TRAVEL_ID="+strRequistionId+" AND TA.ROLE='MATA' UNION "+
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
					while(rs2.next()){
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
					
					String strFromMailGmbH="administrator.stars@mind-infotech.com";
					String strMataGmbhSubject = "";
					if(strGroupTravelFlag!=null  &&  (strGroupTravelFlag.trim().equals("Y"))) {
						strMataGmbhSubject = "STARS - ["+strUserNm+"] - ["+firstDepartureDate+"] ["+strRequistionNumber+"] ["+dbLabelBean.getLabel(groupGuestLabel,strsesLanguage)+"] - Approved";
					} else {
						strMataGmbhSubject = "STARS - ["+strUserNm+"] - ["+firstDepartureDate+"] ["+strRequistionNumber+"] - Approved";
					}
					
					logger.info("MATA GmbH Email Subject-->" +strMataGmbhSubject);
					
					logger.info("Send Detail Mail to MATA GmbH Start for Requisition Number-->"+strRequistionId+ " at " +dateFormat.format(cal.getTime()));
					
					try {
							con1=DriverManager.getConnection(Sdburl,Sdbuser,Sdbpwd);
							cstmt_mail=con1.prepareCall("{call PROC_REQUISITION_MAIL_ADD(?,?,?,?,?,?,?,?,?,?,?,?)}");
							cstmt_mail.setString(1, strRequistionId);
							cstmt_mail.setString(2, strRequistionNumber);
							cstmt_mail.setString(3, emailIds);//Email Ids of MATA and Travel Coordinator.
							cstmt_mail.setString(4, strFromMailGmbH);//From Admin
							cstmt_mail.setString(5, strTravellerMail);
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
					}
					catch(Exception b)
					{	b.printStackTrace();
						System.out.println("Error in T_requisitionMailOnOriginating.jsp second mail block========="+b);	
						logger.log(Level.ERROR, "Error occur in Send mail to MATA_GmbH try/catch block", b);
					}
					logger.info("Send mail to MATA_GmbH End for Requisition Number-->"+strRequistionId+ " at " +dateFormat.format(cal.getTime()));
				} 
			    
				//else {					
				 	
				 	if(!"".equals(strTravellerMail)){
				 		if (!strMailID_MataAsso.equals("")) {
					 		strMailID_MataAsso=strMailID_MataAsso+";"+strTravellerMail;				 	
					 	} else {
					 		strMailID_MataAsso=strMailID_MataAsso+strTravellerMail;
					 	}
					}
				 	
				 	
			   //this block will work when approver is last approver 
			     // then following mail content will go to originator, add on 14 oct 2009 by shiv sharma   
					if(strGroupTravelFlag!=null  &&  (strGroupTravelFlag.trim().equals("Y"))) {
						strMailSubject=dbLabelBean.getLabel("label.mail.starsnotification",strsesLanguage)+" "+dbLabelBean.getLabel(TType,strsesLanguage)+" "+dbLabelBean.getLabel(groupGuestLabel,strsesLanguage)+" '"+strRequistionNumber.trim()+"' has been Approved ";//Mail Subject
					} else {
						strMailSubject=dbLabelBean.getLabel("label.mail.starsnotification",strsesLanguage)+" "+dbLabelBean.getLabel(TType,strsesLanguage)+" '"+strRequistionNumber.trim()+"' has been Approved ";//Mail Subject
					}
					logger.info("Request Approved main block start for Requisition Number-->"+strRequistionId+ " at " +dateFormat.format(cal.getTime()));
				try
				{
					String strSSOUrl = dbUtilityBean.sSSOUrlByMailid(strstrRequistionNextApproverEmail); //Added by vaibhav

					strMailMsg.append("<html><style>.formhead{ font-family:Arial;font-size:11px;font-style: normal;font-weight:normal;color:#000000;text-decoration:none;letter-spacing:normal;word-spacing:normal;border:1px #333333 solid;background:#E2E4D6;}</style><body bgcolor=\"#d0d0d0\">" + "\n");	
					strMailMsg.append(" <table width=80% border=0 cellspacing=0 cellpadding=0 align=center><tr><td align=right><font face=Verdana, Arial, Helvetica, sans-serif size=2><b><font color=#FFFFFF>"+strRequistionCreatedDateWithoutAMPM+"</font><font color=#FFFFFF></font><font color=#000000><br></font></b><font color=#FFFFFF>"+dbLabelBean.getLabel("label.mail.forinternalcirculationonly",strsesLanguage)+"</font></font></td></tr><tr><td bgcolor=#000000> </td></tr><tr><td bgcolor=#FFFFFF align=center>"+ "\n");
					strMailMsg.append("</td></tr><tr><td bgcolor=#000000> </td></tr><tr><td bgcolor=#FFFFFF align=center><table width=100% border=0 cellspacing=0 cellpadding=10><tr><td align=center bgcolor=#aa1220><font face=Arial, Helvetica, sans-serif size=5 color=#FFFFFF>"+dbLabelBean.getLabel("label.mail.starsmailnotification",strsesLanguage)+"</font></td></tr></table></td></tr><tr><td bgcolor=#000000> </td></tr><tr>"+ "\n");
					strMailMsg.append("<td bgcolor=#B6DCDC></td></tr><tr><td bgcolor=#000000> </td></tr><tr><td bgcolor=#000000> </td></tr><tr><td bgcolor=#FFFFFF><table width=100% border=0 cellspacing=0 cellpadding=5>"+ "\n");						
					strMailMsg.append("  <tr><td align=center bgcolor=#aa1220><font face=Verdana, Arial, Helvetica, sans-serif size=2><b><font color=#FFFFFF><font size=2>"+dbLabelBean.getLabel(ReqTyp1,strsesLanguage)+" "+dbLabelBean.getLabel("label.mail.requisition",strsesLanguage)+"</font> </font></b></font></td></tr><tr><td bgcolor=#878787><font face=Verdana, Arial, Helvetica, sans-serif size=2><b>"+dbLabelBean.getLabel(ReqTyp1,strsesLanguage)+" "+dbLabelBean.getLabel("label.global.requisitionnumber",strsesLanguage)+" : "+strRequistionNumber.trim()+"</b> ("+dbLabelBean.getLabel("label.mail.dated",strsesLanguage)+" : "+strRequistionCreatedDate+")</font></td></tr><tr><td><p><font color=#FFFFFF></font><font size=2 face=Verdana, Arial, Helvetica, sans-serif>"+ "\n"); 				
					strMailMsg.append(dbLabelBean.getLabel("label.mail.dear",strsesLanguage)+" "+strstrRequistionNextApproverName+",</font></p><p><font size=2 face=Verdana, Arial, Helvetica, sans-serif>"+dbLabelBean.getLabel("label.global.requisitionnumber",strsesLanguage)+" "+strRequistionNumber.trim()+" "+dbLabelBean.getLabel("label.mail.whichwasoriginatedbyyou",strsesLanguage)+" "+dbLabelBean.getLabel("label.approverrequest.from",strsesLanguage)+" "+strSiteName+" "+dbLabelBean.getLabel("label.mail.on",strsesLanguage)+" "+strRequistionCreatedDate+" "+dbLabelBean.getLabel("label.mail.hasbeenapprovedbyme",strsesLanguage)+"</p>"+ "\n"); 
					strMailMsg.append("<u><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>Requisition Details </u>:-</font><font size=2 face=Verdana, Arial, Helvetica, sans-serif >"+strGroupTravel+"<br>  </font>\n<br>"); 
					strMailMsg.append("<u><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>Reason for Travel </u>:- </font><font size=2 face=Verdana, Arial, Helvetica, sans-serif >"+strreasonFortravel+"</font>\n<br><br>"); 
					strMailMsg.append("<TABLE border=0 width=750  ><TR  height=10 ><TD    width=170><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue >"+dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)+" </TD><TD    width=200><font size=2 face=Verdana, Arial, Helvetica, sans-serif >:- "+strTravelDate+"</TD><TD    width=170><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>"+dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)+" </TD><TD><font size=2 face=Verdana, Arial, Helvetica, sans-serif > :- "+strTravelFrom+"</TD></TR><TR  height=10><TD ><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>"+dbLabelBean.getLabel("label.report.returndate",strsesLanguage)+" </TD><TD><font size=2 face=Verdana, elvetica, sans-serif > :- "+strTravelReturnDate+" </TD><TD ><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>"+dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)+" </TD><TD ><font size=2 face=Verdana, Arial, Helvetica, sans-serif>:-  "+strTravelTo+"</TD></TR><TR  height=10><TD ><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>"+dbLabelBean.getLabel("label.mail.amountrequested",strsesLanguage)+"</TD><TD width=240><font size=2 face=Verdana, Arial, Helvetica, sans-serif >:- "+text+"</TD><TD><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>"+dbLabelBean.getLabel("label.requestdetails.billingclient",strsesLanguage)+" </TD><TD><font size=2 face=Verdana, Arial, Helvetica, sans-serif >:- "+strBillingSite+" </TD></TR></TABLE>");
					strMailMsg.append("<br><font size=2 face=Verdana, Arial, Helvetica, sans-serif><U><FONT COLOR=BLUE>"+strstrRequistionApproverName+" "+dbLabelBean.getLabel("label.mail.approvingcomments",strsesLanguage)+"</FONT></u><br>"+strRequisitionComments.trim()+" "+ "\n"); 
					//System.out.println("strstrRequistionNextApproverName-->"+strstrRequistionNextApproverName);
					//System.out.println("strRequistionCreatorName-->"+strRequistionCreatorName);
					if(strstrRequistionNextApproverName.trim().equalsIgnoreCase(strRequistionCreatorName.trim())){
						strMailMsg.append("</font><br><br>"+strTrasitMsg1+"<font size=2 face=Verdana, Arial, Helvetica, sans-serif><a href='"+strSSOUrl+"'>"+dbLabelBean.getLabel("label.mail.pleaseclickheretologintostars",strsesLanguage)+" </a> "+ "\n");
						//System.out.println("-------if-----mail on approval--ELSE-->"+strTrasitMsg);
					}else{
						strMailMsg.append("</font><br><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif><a href='"+strSSOUrl+"'>"+dbLabelBean.getLabel("label.mail.pleaseclickheretologintostars",strsesLanguage)+" </a> "+ "\n");	
					}
					
					//strMailMsg.append("</font><br><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif><a href='"+strSSOUrl+"'>Please click here to login to STARS </a> "+ "\n");  
					strMailMsg.append("   </b></form></font><br><p><font size=2 face=Verdana, Arial, Helvetica, sans-serif>"+dbLabelBean.getLabel("label.mail.bestregards",strsesLanguage)+"</font><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif>"+strstrRequistionApproverName.trim()+"<br></font></p></td></tr></table></td></tr><tr><td bgcolor=#878787 align=center> <font face=Verdana, Arial, Helvetica, sans-serif size=1><b>"+dbLabelBean.getLabel("label.mail.mailreferencenumber",strsesLanguage)+" </b>"+strMailRefNumber+"/"+strCurrentYear+"</font></td></tr><tr><td bgcolor=#FFFFFF align=center>       <table width=100% border=0 cellspacing=0 cellpadding=5>"+ "\n"); 
					strMailMsg.append("<tr><td align=center bgcolor=#aa1220><font size=2 face=Verdana, Arial, Helvetica, sans-serif><b><font size=1>"+dbLabelBean.getLabel("label.mail.starsadministratorcanbecontacted",strsesLanguage)+" : - </font></b><font size=1><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=#000000>"+ "\n"); 
					strMailMsg.append("<a href=mailto:administrator.stars@mind-infotech.com><font size=1 color=#ffffff>administrator.stars@mind-infotech.com</font></a></font></font></font></td>  "+ "\n");  
					strMailMsg.append(" </tr><tr><td  align=center bgcolor=#878787 height=15> <b><font size=1 face=Verdana, Arial, Helvetica, sans-serif>"+dbLabelBean.getLabel("label.mail.disclaimer",strsesLanguage)+"</b> : "+dbLabelBean.getLabel("label.mail.thiscommunicationissystemgenererated",strsesLanguage)+" "+ "\n");  
					strMailMsg.append(dbLabelBean.getLabel("label.mail.pleasedonnotreplytothismail",strsesLanguage)+" <br>"+dbLabelBean.getLabel("label.mail.ifyouarenotthecorrectrecipientforthisnotification",strsesLanguage)+"</font></td></tr></table></td></tr><tr><td bgcolor=#000000></td></tr>"+ "\n");    
					strMailMsg.append("<tr><td align=center><font size=2 face=Verdana, Arial, Helvetica, sans-serif><font size=1 color=#000000>&copy;"+dbLabelBean.getLabel("label.mail.mindallrightsreserved",strsesLanguage)+"</font></font></td>  </tr></table><p>&nbsp;</p></body></html>"+ "\n");
							
		
					logger.info("Request Approved inner block start for Requisition Number-->"+strRequistionId+ " at " +dateFormat.format(cal.getTime()));
					// System.out.println("strMailMsg======2==="+strMailMsg);
					try
					{
						//Procedure for inserting Mail Data
						cstmt_mail=con.prepareCall("{?=call PROC_REQUISITION_MAIL_ADD(?,?,?,?,?,?,?,?,?,?,?,?)}");
						cstmt_mail.registerOutParameter(1,java.sql.Types.INTEGER);
						cstmt_mail.setString(2, strRequistionId);
						cstmt_mail.setString(3, strRequistionNumber);
						cstmt_mail.setString(4, strstrRequistionNextApproverEmail);//To
						cstmt_mail.setString(5, strstrRequistionApproverEmail);//From
						cstmt_mail.setString(6, strMailID_MataAsso);//CC  mail will go to mata Associates
						cstmt_mail.setString(7, strMailSubject);
						cstmt_mail.setString(8, strMailMsg.toString());
						cstmt_mail.setInt(9, intTries);
						cstmt_mail.setString(10, "NEW");
						cstmt_mail.setString(11, strApproverId);
						cstmt_mail.setString(12, "Approval Process");
						cstmt_mail.setString(13, "Signatory Approves IT");
		                cstmt_mail.execute();
						cstmt_mail.close(); 
						logger.info("Request Approved inner block end for Requisition Number-->"+strRequistionId+ " at " +dateFormat.format(cal.getTime()));
					}
					catch(Exception b)
					{
						System.out.println("ERROR in T_requisitionMailOnApproval---1--------"+b);	
						logger.log(Level.ERROR, "Error occur in on Approved inner mail try/catch block", b);
					}
					logger.info("Request Approved main block end for Requisition Number-->"+strRequistionId+ " at " +dateFormat.format(cal.getTime()));
				}
				catch(Exception e)
				{
					System.out.println("Error in T_requisitionMailOnApproval--------------2-------------"+e);
					logger.log(Level.ERROR, "Error occur in on Approved main mail try/catch block", e);
				}
				
			   
		  // } 
		   }//else end here 
			
		}// end of while
		
	//ADDED BY MANOJ CHAND ON 10 MAY 2012 TO SENT MAILS FROM REV TO APP AND APP TO REV.		
		if(strMailFlag.equals("Y") && (isMATA_GmbH == null || !isMATA_GmbH.equals("true"))){	
			StringBuffer strMailMsg1 = new StringBuffer();
			  // System.out.println("strMailDir--->"+strMailDir);
			  // System.out.println("strMailFwdFlag--->"+strMailFwdFlag);
			//added by manoj chand on 20 june 2012 to get mail to person language preference
			stmt2=null;
			rs3=null;
			strSql	=	"SELECT LANGUAGE_PREF FROM M_USERINFO WHERE EMAIL =N'"+strToMail+"' AND STATUS_ID=10";
			stmt2= con.createStatement(); 
			rs3 = stmt2.executeQuery(strSql);
			if(rs3.next()){
				strsesLanguage=rs3.getString("LANGUAGE_PREF");
				if(strsesLanguage==null || strsesLanguage.equals("")){
					strsesLanguage="en_US";
				}
			}
			rs3.close();
			stmt2.close();

		   if(strMailDir.equals("R2A")){
			   String strSSOUrl = dbUtilityBean.sSSOUrlByMailid(strToMail);
			   if(strGroupTravelFlag!=null  &&  (strGroupTravelFlag.trim().equals("Y"))) {
				   strMailSubject1=dbLabelBean.getLabel("label.mail.starsnotification",strsesLanguage)+" "+dbLabelBean.getLabel(TType,strsesLanguage)+" '"+strRequistionNumber.trim()+"' "+dbLabelBean.getLabel(groupGuestLabel,strsesLanguage)+" "+dbLabelBean.getLabel("label.mail.forapproval",strsesLanguage)+" ";
			   } else {
				   strMailSubject1=dbLabelBean.getLabel("label.mail.starsnotification",strsesLanguage)+" "+dbLabelBean.getLabel(TType,strsesLanguage)+" '"+strRequistionNumber.trim()+"' "+dbLabelBean.getLabel("label.mail.forapproval",strsesLanguage)+" ";
			   }
			   
			   
			   strMailMsg1.append("<html><style>.formhead{ font-family:Arial;font-size:11px;font-style: normal;font-weight:normal;color:#000000;text-decoration:none;letter-spacing:normal;word-spacing:normal;border:1px #333333 solid;background:#E2E4D6;}</style><body bgcolor=\"#d0d0d0\">" + "\n");	
			   strMailMsg1.append(" <table width=80% border=0 cellspacing=0 cellpadding=0 align=center><tr><td align=right><font face=Verdana, Arial, Helvetica, sans-serif size=2><b><font color=#FFFFFF>"+strRequistionCreatedDateWithoutAMPM+"</font><font color=#FFFFFF></font><font color=#000000><br></font></b><font color=#FFFFFF>"+dbLabelBean.getLabel("label.mail.forinternalcirculationonly",strsesLanguage)+"</font></font></td></tr><tr><td bgcolor=#000000> </td></tr><tr><td bgcolor=#FFFFFF align=center>"+ "\n");
			   strMailMsg1.append("</td></tr><tr><td bgcolor=#000000> </td></tr><tr><td bgcolor=#FFFFFF align=center><table width=100% border=0 cellspacing=0 cellpadding=10><tr><td align=center bgcolor=#aa1220><font face=Arial, Helvetica, sans-serif size=5 color=#FFFFFF>"+dbLabelBean.getLabel("label.mail.starsmailnotification",strsesLanguage)+"</font></td></tr></table></td></tr><tr><td bgcolor=#000000> </td></tr><tr>"+ "\n");
			   strMailMsg1.append("<td bgcolor=#B6DCDC></td></tr><tr><td bgcolor=#000000> </td></tr><tr><td bgcolor=#000000> </td></tr><tr><td bgcolor=#FFFFFF><table width=100% border=0 cellspacing=0 cellpadding=5>"+ "\n");						
			   strMailMsg1.append("  <tr><td align=center bgcolor=#aa1220><font face=Verdana, Arial, Helvetica, sans-serif size=2><b><font color=#FFFFFF><font size=2>"+dbLabelBean.getLabel(ReqTyp1,strsesLanguage)+" "+dbLabelBean.getLabel("label.mail.requisition",strsesLanguage)+"</font> </font></b></font></td></tr><tr><td bgcolor=#878787><font face=Verdana, Arial, Helvetica, sans-serif size=2><b>"+dbLabelBean.getLabel(ReqTyp1,strsesLanguage)+" "+dbLabelBean.getLabel("label.global.requisitionnumber",strsesLanguage)+" : "+strRequistionNumber.trim()+"</b> ("+dbLabelBean.getLabel("label.mail.dated",strsesLanguage)+" : "+strRequistionCreatedDate+")</font></td></tr><tr><td><p><font color=#FFFFFF></font><font size=2 face=Verdana, Arial, Helvetica, sans-serif>"+ "\n"); 				
			   strMailMsg1.append(dbLabelBean.getLabel("label.mail.dear",strsesLanguage)+" "+strToName+",</font></p><p><font size=2 face=Verdana, Arial, Helvetica, sans-serif>"+dbLabelBean.getLabel("label.global.requisitionnumber",strsesLanguage)+" "+strRequistionNumber.trim()+" "+dbLabelBean.getLabel("label.mail.whichwasoriginatedby",strsesLanguage)+" "+strRequistionCreatorName+" "+dbLabelBean.getLabel("label.approverrequest.from",strsesLanguage)+" "+strSiteName+" "+dbLabelBean.getLabel("label.mail.on",strsesLanguage)+" "+strRequistionCreatedDate+" "+dbLabelBean.getLabel("label.mail.hasbeenapprovedbyme",strsesLanguage)+"</p>"+ "\n"); 
			   strMailMsg1.append("<u><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>"+dbLabelBean.getLabel("label.mail.requisitionsdetails",strsesLanguage)+" </u>:-</font><font size=2 face=Verdana, Arial, Helvetica, sans-serif >"+strGroupTravel+"<br>  </font>\n<br>"); 
			   strMailMsg1.append("<u><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>"+dbLabelBean.getLabel("label.global.reasonfortravel",strsesLanguage)+" </u>:- </font><font size=2 face=Verdana, Arial, Helvetica, sans-serif >"+strreasonFortravel+"</font>\n<br><br>"); 
			   strMailMsg1.append("<TABLE border=0 width=750  ><TR  height=10 ><TD    width=170><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue >"+dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)+" </TD><TD    width=200><font size=2 face=Verdana, Arial, Helvetica, sans-serif >:- "+strTravelDate+"</TD><TD    width=170><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>"+dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)+" </TD><TD><font size=2 face=Verdana, Arial, Helvetica, sans-serif > :- "+strTravelFrom+"</TD></TR><TR  height=10><TD ><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>"+dbLabelBean.getLabel("label.report.returndate",strsesLanguage)+" </TD><TD><font size=2 face=Verdana, elvetica, sans-serif > :- "+strTravelReturnDate+" </TD><TD ><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>"+dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)+" </TD><TD ><font size=2 face=Verdana, Arial, Helvetica, sans-serif>:-  "+strTravelTo+"</TD></TR><TR  height=10><TD ><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>"+dbLabelBean.getLabel("label.mail.amountrequested",strsesLanguage)+"</TD><TD width=240><font size=2 face=Verdana, Arial, Helvetica, sans-serif >:- "+text+"&nbsp;[<font size=2 face=Verdana, Arial, Helvetica, sans-serif color=red>Over Limit</font>]</TD><TD><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>"+dbLabelBean.getLabel("label.requestdetails.billingclient",strsesLanguage)+" </TD><TD><font size=2 face=Verdana, Arial, Helvetica, sans-serif >:- "+strBillingSite+" </TD></TR><TR  height=10><TD ><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>"+dbLabelBean.getLabel("label.approverequest.travelclass",strsesLanguage)+"</TD><TD ><font size=2 face=Verdana, Arial, Helvetica, sans-serif >:- "+strTravelClass+"</TD><TD><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue></TD><TD><font size=2 face=Verdana, Arial, Helvetica, sans-serif >&nbsp;</TD></TR></TABLE>");
			   strMailMsg1.append("<br><font size=2 face=Verdana, Arial, Helvetica, sans-serif><U><FONT COLOR=BLUE>"+dbLabelBean.getLabel("label.mail.reviewercomments",strsesLanguage)+" </FONT></u><br>"+strRequisitionComments.trim()+" "+ "\n"); 
			   strMailMsg1.append("</font><br><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif><a href='"+strSSOUrl+"'>"+dbLabelBean.getLabel("label.mail.pleaseclickheretologintostars",strsesLanguage)+" </a> "+ "\n");
			   strMailMsg1.append("   </b></form></font><br><p><font size=2 face=Verdana, Arial, Helvetica, sans-serif>"+dbLabelBean.getLabel("label.mail.bestregards",strsesLanguage)+"</font><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif>"+strFromName+"<br></font></p></td></tr></table></td></tr><tr><td bgcolor=#878787 align=center> <font face=Verdana, Arial, Helvetica, sans-serif size=1><b>"+dbLabelBean.getLabel("label.mail.mailreferencenumber",strsesLanguage)+" </b>"+strMailRefNumber+"/"+strCurrentYear+"</font></td></tr><tr><td bgcolor=#FFFFFF align=center>       <table width=100% border=0 cellspacing=0 cellpadding=5>"+ "\n"); 
			   strMailMsg1.append("<tr><td align=center bgcolor=#aa1220><font size=2 face=Verdana, Arial, Helvetica, sans-serif><b><font size=1>"+dbLabelBean.getLabel("label.mail.starsadministratorcanbecontacted",strsesLanguage)+" : - </font></b><font size=1><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=#000000>"+ "\n"); 
			   strMailMsg1.append("<a href=mailto:administrator.stars@mind-infotech.com><font size=1 color=#ffffff>administrator.stars@mind-infotech.com</font></a></font></font></font></td>  "+ "\n");  
			   strMailMsg1.append(" </tr><tr><td  align=center bgcolor=#878787 height=15> <b><font size=1 face=Verdana, Arial, Helvetica, sans-serif>"+dbLabelBean.getLabel("label.mail.disclaimer",strsesLanguage)+"</b> : "+dbLabelBean.getLabel("label.mail.thiscommunicationissystemgenererated",strsesLanguage)+" "+ "\n");  
			   strMailMsg1.append(dbLabelBean.getLabel("label.mail.pleasedonnotreplytothismail",strsesLanguage)+" <br>"+dbLabelBean.getLabel("label.mail.ifyouarenotthecorrectrecipientforthisnotification",strsesLanguage)+"</font></td></tr></table></td></tr><tr><td bgcolor=#000000></td></tr>"+ "\n");    
			   strMailMsg1.append("<tr><td align=center><font size=2 face=Verdana, Arial, Helvetica, sans-serif><font size=1 color=#000000>&copy;"+dbLabelBean.getLabel("label.mail.mindallrightsreserved",strsesLanguage)+"</font></font></td>  </tr></table><p>&nbsp;</p></body></html>"+ "\n");
			   //System.out.println("strMailMsg1--in approval R2A---->"+strMailMsg1);
			   //strApproverId=Suser_id;
			   logger.info("Request for approval main block start for Requisition Number-->"+strRequistionId+ " at " +dateFormat.format(cal.getTime()));
			   try
				{
						cstmt_mail=con.prepareCall("{?=call PROC_REQUISITION_MAIL_ADD(?,?,?,?,?,?,?,?,?,?,?,?)}");
						cstmt_mail.registerOutParameter(1,java.sql.Types.INTEGER);
						cstmt_mail.setString(2, "");
						cstmt_mail.setString(3, strRequistionNumber);
						cstmt_mail.setString(4, strToMail);//To
						cstmt_mail.setString(5, strFromMail);//From
						cstmt_mail.setString(6, "");
						cstmt_mail.setString(7, strMailSubject1);
						cstmt_mail.setString(8, strMailMsg1.toString());
						cstmt_mail.setInt(9, intTries);
						cstmt_mail.setString(10, "NEW");
						cstmt_mail.setString(11, Suser_id);
						cstmt_mail.setString(12, "Approval Process");
						cstmt_mail.setString(13, "Signatory Approves IT");
						cstmt_mail.execute();
						cstmt_mail.close();
						logger.info("Request for approval main block end for Requisition Number-->"+strRequistionId+ " at " +dateFormat.format(cal.getTime()));
				}
				catch(Exception b)
				{
					System.out.println("Error in T_requisitionMailOnApproval.jsp second mail block=====R2A===="+b);
					b.printStackTrace();
					logger.log(Level.ERROR, "Error occur in For Approval second mail try/catch block", b);
				}
		   }
		   else if(strMailDir.equals("A2R") && strMailFwdFlag.equals("Y"))
		   {	
			    strMailSubject1=dbLabelBean.getLabel("label.mail.starsnotification",strsesLanguage)+" "+dbLabelBean.getLabel(TType,strsesLanguage)+" '"+strRequistionNumber.trim()+"' "+dbLabelBean.getLabel("label.mail.forreview",strsesLanguage)+" ";
			    
				strMailMsg1.append("<html><style>.formhead {	font-family: Arial;	font-size: 11px;	font-style: normal;	font-weight: normal;	color: #000000;");
				strMailMsg1.append("border: 1px #333333 solid;	background: #00CCFF;}</style>");
				strMailMsg1.append("<body bgcolor=#00CCFF><table width=80% align=center><tr><td align=right><font size=2><b><font color=#FFFFFF>"+strRequistionCreatedDateWithoutAMPM+"</font>");
				strMailMsg1.append("<font color=#FFFFFF></font><font color=#000000><br></font></b><font color=#FFFFFF>"+dbLabelBean.getLabel("label.mail.forinternalcirculationonly",strsesLanguage)+"</font></font></td>");
				strMailMsg1.append("</tr><tr><td bgcolor=#000000></td></tr><tr><td bgcolor=#FFFFFF align=center><table width=100% border=0 cellspacing=0 cellpadding=9></table>");
				strMailMsg1.append("</td></tr><tr><td bgcolor=#FFFFFF align=center><table width=100% border=0 cellspacing=0 cellpadding=15><tr><td align=center bgcolor=#aa1220>");
				strMailMsg1.append("<font size=5 color=#FFFFFF>"+dbLabelBean.getLabel("label.mail.starsmailnotification",strsesLanguage)+"</font></td></tr></table>");
				strMailMsg1.append("</td></tr><tr><td bgcolor=#FFFFFF><table width=100% border=0 cellspacing=0 cellpadding=5><tr><td align=center bgcolor=#aa1220><font size=2><b>");
				strMailMsg1.append("<font	color=#FFFFFF><font size=3>"+dbLabelBean.getLabel("label.mail.forreview",strsesLanguage)+"</font> </font></b></font></td></tr><tr><td bgcolor=#878787><font size=2></font></td></tr><tr><td><p>");
				strMailMsg1.append("<font color=#FFFFFF>.</font><font size=2 face=Verdana, Arial, Helvetica, sans-serif><br>Dear "+strToName+",</font></p><p><font size=2 face=Verdana, Arial, Helvetica, sans-serif> "+dbLabelBean.getLabel("label.mail.kindlyreviewtherequest",strsesLanguage)+" "+strRequistionNumber.trim()+" "+dbLabelBean.getLabel("label.mail.pendingwithmeandtakeappropriateaction",strsesLanguage));
				strMailMsg1.append("<br><br><font color=blue></p></font> </font><font size=2></font></p><font size=2 face=Verdana, Arial, Helvetica, sans-serif><a href='https://stars.mindeservices.com'>"+dbLabelBean.getLabel("label.mail.pleaseclickheretologintostars",strsesLanguage)+" </a> </b></form>");
				strMailMsg1.append("</font><br>	<p><font size=2 face=Verdana, Arial, Helvetica, sans-serif>"+dbLabelBean.getLabel("label.mail.bestregards",strsesLanguage)+"</font><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif>"+strFromName+"<br></font></p></td></tr></table></td></tr><tr><td bgcolor=#878787 align=center>");
				strMailMsg1.append("<font face=Verdana,Arial, Helvetica, sans-serif size=1><b>"+dbLabelBean.getLabel("label.mail.mailreferencenumber",strsesLanguage)+" </b>"+intMaliRefNumber+"/"+strCurrentYear+"</font></td></tr>");
				strMailMsg1.append("<tr><td bgcolor=#FFFFFF align=center><table width=100% border=0 cellspacing=0 cellpadding=5><tr>");
				strMailMsg1.append("<td align=center bgcolor=#aa1220><font size=2 face=Verdana, Arial, Helvetica, sans-serif><b><font size=1>"+dbLabelBean.getLabel("label.mail.starsadministratorcanbecontacted",strsesLanguage)+" : - </font></b><font size=1><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=#000000> <a href=mailto:administrator.stars@mind-infotech.com><font size=1 color=#ffffff>administrator.stars@mind-infotech.com</font></a></font></font></font></td>");
				strMailMsg1.append("</tr><tr><td  align=center bgcolor=#878787 height=15> <b><font size=1 face=Verdana, Arial, Helvetica, sans-serif>"+dbLabelBean.getLabel("label.mail.disclaimer",strsesLanguage)+"</b> : "+dbLabelBean.getLabel("label.mail.thiscommunicationissystemgenererated",strsesLanguage)+"  "+dbLabelBean.getLabel("label.mail.pleasedonnotreplytothismail",strsesLanguage)+" <br>"+dbLabelBean.getLabel("label.mail.ifyouarenotthecorrectrecipientforthisnotification",strsesLanguage)+"</font></td>");
				strMailMsg1.append("</tr></table></td></tr><tr><td bgcolor=#000000></td></tr><tr><td align=center><font size=2 face=Verdana, Arial, Helvetica, sans-serif><font size=1 color=#000000>&copy;"+dbLabelBean.getLabel("label.mail.mindallrightsreserved",strsesLanguage)+"</font></font></td></tr></table><p>&nbsp;</p></body></html>");
				//strApproverId=strRequistionNextApprover_UserId;
				//System.out.println("strMailMsg1--in approval A2R---->"+strMailMsg1);
				logger.info("Request for review main block start for Requisition Number-->"+strRequistionId+ " at " +dateFormat.format(cal.getTime()));
				try
					{
							cstmt_mail=con.prepareCall("{?=call PROC_REQUISITION_MAIL_ADD(?,?,?,?,?,?,?,?,?,?,?,?)}");
							cstmt_mail.registerOutParameter(1,java.sql.Types.INTEGER);
							cstmt_mail.setString(2, "");
							cstmt_mail.setString(3, strRequistionNumber);
							cstmt_mail.setString(4, strToMail);//To
							cstmt_mail.setString(5, strFromMail);//From
							cstmt_mail.setString(6, "");
							cstmt_mail.setString(7, strMailSubject1);
							cstmt_mail.setString(8, strMailMsg1.toString());
							cstmt_mail.setInt(9, intTries);
							cstmt_mail.setString(10, "NEW");
							cstmt_mail.setString(11, strRequistionNextApprover_UserId);
							cstmt_mail.setString(12, "Review Process");
							cstmt_mail.setString(13, "Signatory Approves IT");
							cstmt_mail.execute();
							cstmt_mail.close();
							logger.info("Request for review main block end for Requisition Number-->"+strRequistionId+ " at " +dateFormat.format(cal.getTime()));
					}
					catch(Exception b)
					{
						System.out.println("Error in T_requisitionMailOnApproval.jsp second mail block=====A2R===="+b);
						b.printStackTrace();	
						logger.log(Level.ERROR, "Error occur in For Review mail try/catch block", b);
					}
					
		   }
				   
		   	
		}
			
			//END HERE BY MANOJ CHAND ON 10 MAY 2012
				
	}
	stmt.close();
	con.close();
	logger.info("Send mail on Approval End for Requisition Number-->"+strRequistionId+ " at " +dateFormat.format(cal.getTime()));			
	logger.info("Send mail on Approval End " +dateFormat.format(cal.getTime()));
	%>
	
