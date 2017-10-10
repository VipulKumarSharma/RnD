	<%
	/***************************************************
	 *The information contained here in is confidential and 
	 * proprietary to MIND and forms the part of the MIND 
	 *Author				:MANOJ CHAND
	 *Date of Creation 		:03 MAY 2012
	 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
	 *Project	  			:STARS
	 *Operating environment :Tomcat, sql server 2008 
	 *Description 			:This is the  jsp file  for inserting the PASS action mail information in req_mailbox table
	 
	 *Modified By			:Manoj Chand
     *Date of Modification  :01-July-2013
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
	
	<!--Create the DbConnectionBean object for createConnection-->
	<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
	<jsp:useBean id="dbUtilityBean" scope="page" class="src.connection.DbUtilityMethods" />
	<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
	
	<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
	<% 
	request.setCharacterEncoding("UTF-8");
	
	// Variables declared and initialized
	Connection con					=		null;			    // Object for connection
	Statement stmt	,stmt1,stmt2				=		null;			   // Object for Statement
	ResultSet rs,rs1,rs2,rs3					=		null;			  // Object for ResultSet
	CallableStatement cstmt_mail			=		null;			// Object for Callable Statement
	
	con=dbConBean.getConnection();
	
	//DECLARE VARIABLES
	String	sSqlStr								=	""; // For sql Statements
	String strRequistionId						=	null;
	String strRequisitionStatus	    			=	null;
	String strRequistionNumber	 				=	null;
	String strMailSubject						=	null;
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
	String strSiteId                            =   "";
	String strCreationDate                      =	"";
	String TType								=	"";
	String strTraveltype						=	"";
	
	String    strGroupTravel          			=	"";
	String	  strGroupTravelFlag   				=	"";
	
	String   strLastApprover_flag				=	"";
	
	String   strMailID_MataAsso					=	"";	
	//ArrayList aList								=   new ArrayList();   
	String strMailID_OrignalApprover			=	"";
	
	String strRequistionCreatedDateWithoutAMPM ="";
	String strTravelAgencyId					=   "";
	
	String strSqlSql			="";
	
	
	String  strreasonFortravel   =   "";
	String	strCurrency			 =   "";
	String	strTotalAmount       =  ""; 
	String	strBillingSite		 ="";
	
	String strTravelReturnDate	="";
	String strTravelClass		="";
	String strTrasitMsg		= "";
	String strApproverName="";
    String strApproverEmail="";
    String strLanguage	= "";

	java.text.NumberFormat dblFunnelVal = null;
	dblFunnelVal = new java.text.DecimalFormat("#######,###.####");

	//GET THE VALUES FROM THE PREVIOUS SCREEN
	strRequistionId															=	request.getParameter("purchaseRequisitionId");
	strRequisitionStatus													=	request.getParameter("rad").trim();
	strRequisitionComments													=	request.getParameter("COMMENTS");
	String ReqTyp															=	request.getParameter("ReqTyp");
	String ReqTyp1="";
	if(ReqTyp.equals("Domestic Travel")){
		ReqTyp1="label.mail.domestictravel";
	}else{
		ReqTyp1="label.mail.internationaltravel";
	}
	
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
	
	if(ReqTyp.equals("Domestic Travel")) 
	{
		TType="Domestic Travel Requisition No:";
		sSqlStr="SELECT (SELECT TRAVEL_AGENCY_ID FROM M_SITE WHERE SITE_ID=t.SITE_ID) AS TRAVEL_AGENCY_ID, TRAVEL_REQ_NO ,.DBO.user_name(C_USERID) AS ORIGINATOR, DBO.USEREMAIL(C_USERID)AS ORIGINATOR_MAIL, .DBO.USER_NAME('"+Suser_id+"') AS APPROVER_NAME,DBO.USEREMAIL('"+Suser_id+"') AS APPROVER_MAIL, ISNULL(RTRIM(.DBO.PRESENTAPPROVER("+strRequistionId+",'D',TRAVELLER_ID)),'NA') AS NEXTWITH, ISNULL(RTRIM(.DBO.PRESENTAPPROVER_USERID("+strRequistionId+",'D',TRAVELLER_ID)),'NA') AS NEXTWITH_USERID, ISNULL(RTRIM(.DBO.PRESENTAPPROVER_MAIL("+strRequistionId+",'D',TRAVELLER_ID)),'NA') AS NEXTWITH_MAIL, convert(varchar(30), C_DATETIME,113), .DBO.USER_NAME(TRAVELLER_ID) AS TRAVELLER_NAME ,convert(varchar(30),TRAVEL_DATE,113),SEX ,.DBO.SITENAME(T.SITE_ID) AS SITE_NAME,SITE_ID,T.GROUP_TRAVEL_FLAG,REASON_FOR_TRAVEL,t.TA_CURRENCY as TA_CURRENCY,t.TOTAL_AMOUNT as TOTAL_AMOUNT,dbo.sitename(t.BILLING_SITE) as BILLING_SITE,REASON_FOR_TRAVEL,BILLING_SITE as BILLING_SITE_id ,BILLING_CLIENT,C_USERID,dbo.FN_TRAVEL_CLASS("+strRequistionId+",'D') as travel_class  FROM T_TRAVEL_DETAIL_DOM t  WHERE TRAVEL_ID="+strRequistionId+" ";
	}
	else
	{
		TType="International Travel Requisition No:";
		sSqlStr="SELECT (SELECT TRAVEL_AGENCY_ID FROM M_SITE WHERE SITE_ID=T.SITE_ID) AS TRAVEL_AGENCY_ID, TRAVEL_REQ_NO ,.DBO.user_name(C_USERID) AS ORIGINATOR, DBO.USEREMAIL(C_USERID)AS ORIGINATOR_MAIL, .DBO.USER_NAME('"+Suser_id+"') AS APPROVER_NAME, DBO.USEREMAIL('"+Suser_id+"') AS APPROVER_MAIL, ISNULL(RTRIM(.DBO.PRESENTAPPROVER("+strRequistionId+",'I',TRAVELLER_ID)),'NA') AS NEXTWITH, ISNULL(RTRIM(.DBO.PRESENTAPPROVER_USERID("+strRequistionId+",'I',TRAVELLER_ID)),'NA') AS NEXTWITH_USERID, ISNULL(RTRIM(.DBO.PRESENTAPPROVER_MAIL("+strRequistionId+",'I',TRAVELLER_ID)),'NA') AS NEXTWITH_MAIL, convert(varchar(30),C_DATETIME,113),.DBO.USER_NAME(TRAVELLER_ID) AS TRAVELLER_NAME ,convert(varchar(30),TRAVEL_DATE,113), SEX, .DBO.SITENAME(T.SITE_ID) AS SITE_NAME,SITE_ID,T.GROUP_TRAVEL_FLAG,REASON_FOR_TRAVEL,t.TA_CURRENCY as TA_CURRENCY,t.TOTAL_AMOUNT as TOTAL_AMOUNT,dbo.sitename(t.BILLING_SITE) as BILLING_SITE,REASON_FOR_TRAVEL,BILLING_SITE as BILLING_SITE_id ,BILLING_CLIENT,C_USERID,dbo.FN_TRAVEL_CLASS("+strRequistionId+",'I') as travel_class FROM T_TRAVEL_DETAIL_INT T  WHERE TRAVEL_ID="+strRequistionId+"  ";	
	}
	
	// System.out.println("sSqlStr======="+sSqlStr);
	
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
		String strRequistionCreatedDate1			 		=	rs.getString(9);//Req Created Date & time
		String str											= strRequistionCreatedDate1.substring(0,17);
		String str1											= strRequistionCreatedDate1.substring(0,11);
		strRequistionCreatedDate=str;	
	
		strRequistionCreatedDateWithoutAMPM=str1;	
		strUserNm								 			=	rs.getString(10);//TRAVELLER NAME
		strTravelDate										=	rs.getString(11).substring(0,11); // TRAVEL DATE
		strTravellerSex										=	rs.getString(12); // TRAVELLER SEX
		
	
		strSiteName											=	rs.getString(13); //site name
		strSiteId                                           =	rs.getString(14); //site id
		
		strTravelAgencyId									= 	rs.getString("TRAVEL_AGENCY_ID");
							
		if(strTravellerSex.equals("1"))	{
			strSex	 =	 "Mr.";
		}
		else{
			strSex	 =	 "Ms";
		}
		
		//added by manoj chand on 13 june 2012 to get mail to person language preference
		strSql	=	"SELECT LANGUAGE_PREF FROM M_USERINFO WHERE EMAIL ='"+strstrRequistionNextApproverEmail+"' AND STATUS_ID=10";
		stmt2= con.createStatement(); 
		rs3 = stmt2.executeQuery(strSql);
		if(rs3.next()){
			strLanguage=rs3.getString("LANGUAGE_PREF");
			if(strLanguage==null || strLanguage.equals("")){
				strLanguage="en_US";
			}
		}
		//System.out.println("strLanguage--->"+strLanguage);
		rs3.close();
		stmt2.close();
		
		
		if(ReqTyp.equals("Domestic Travel"))
		{
			//code commented by manoj chand and replace with new query on 27 june 2013.
			//strSql	=	"SELECT TRAVEL_FROM,TRAVEL_TO FROM T_JOURNEY_DETAILS_DOM WHERE TRAVEL_ID="+strRequistionId+"	";
		      strSql ="select * FROM  [dbo].[FN_GetDeparturecity]("+strRequistionId+",'d')";
		    // code added for showing group travel  in case of domestie group travel_DOM  on shiv sharma on 19-Jun-08  
	    
			   strGroupTravelFlag       =   rs.getString("GROUP_TRAVEL_FLAG"); 
					     if(strGroupTravelFlag==null) {
			               strGroupTravel =""; 
				 		     }
						 if(strGroupTravelFlag!=null  &&  (strGroupTravelFlag.trim().equals("Y"))){
	                   					 strGroupTravel =dbLabelBean.getLabel("label.mail.groupguestisscheduledtotravel",strsesLanguage); 
	                   					if(strTravelAgencyId.equals("2")) {
	                   						strGroupTravel = dbLabelBean.getLabel("label.mail.guestisscheduledtotravel",strsesLanguage);
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
	                   					if(strTravelAgencyId.equals("2")) {
	                   						strGroupTravel = dbLabelBean.getLabel("label.mail.guestisscheduledtotravel",strsesLanguage);
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
		strCurrency			 =   rs.getString("TA_CURRENCY");//TOTAL_AMOUNT 
		strTotalAmount       =   rs.getString("TOTAL_AMOUNT"); //BILLING_SITE
		strBillingSite       =   rs.getString("BILLING_SITE");
	
		strTotalAmount= dblFunnelVal.format(Double.parseDouble(strTotalAmount));
		
		String strbillingSiteid		 = rs.getString("BILLING_SITE_id");  
		
		String strBillingClient    = rs.getString("BILLING_CLIENT");  
		
		String strCreatorID        = rs.getString("C_USERID");
		
		strTravelClass			=	rs.getString("travel_class"); //added on 25 march 2010 by shiv sharma
		
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
	
	   	String text =strCurrency+" "+strTotalAmount ; 
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
	//System.out.println("strSqlSql---sec->"+strSqlSql);   
		rs2 = stmt1.executeQuery(strSqlSql);
				if(rs2.next())
				{
						strTravelReturnDate	=	rs2.getString(1);		
				}
	
		rs2.close();
		stmt1.close();
		 
	//aList  = dbUtilityBean.getApproverAccoringToRole(strRequistionNextApprover_UserId,strSiteId);
	
	 if(ReqTyp.equals("Domestic Travel"))
		{
	    strTraveltype="d";
		}
		else
		{
			    strTraveltype="i";
		}
	
	 
	   // sSqlStr ="SELECT dbo.user_name(pendingWithUser) as approver, dbo.USEREMAIL(pendingWithUser) AS ApproverEmail "+
	    //         " FROM PAGE_ACCESS_PERMISSION WHERE PAGE_ACCESS_PERMISSION.viewToUser='"+Suser_id+"' AND PAGE_ACCESS_PERMISSION.status=10" ;
	   sSqlStr="SELECT dbo.user_name(APPROVER_ID) as approver, DBO.USEREMAIL(APPROVER_ID) AS ApproverEmail"+
		       " FROM T_APPROVERS WHERE T_APPROVERS.TRAVEL_ID='"+strRequistionId+"' AND T_APPROVERS.PAP_APPROVER='"+Suser_id+"' AND T_APPROVERS.SITE_ID='"+strSiteId+"' AND T_APPROVERS.PAP_FLAG='P' AND T_APPROVERS.TRAVEL_TYPE='"+strTraveltype+"'";
	  // System.out.println("sSqlStr--pass mail--->"+sSqlStr);
	   stmt= con.createStatement();
	    rs = stmt.executeQuery(sSqlStr);
		if(rs.next())
		        {
			  strApproverName=rs.getString("approver");
			  strApproverEmail=rs.getString("ApproverEmail");
		 }
	
	    rs.close();
	
			strMailMsg = new StringBuffer();
			strCreationDate=strMailCreatedate;
	  
			strMailSubject=dbLabelBean.getLabel("label.mail.starsnotification",strsesLanguage)+" "+TType+" '"+strRequistionNumber.trim()+"' "+dbLabelBean.getLabel("label.mail.passed",strsesLanguage)+" ";//Mail Subject
			try
			{
				String strSSOUrl = dbUtilityBean.sSSOUrlByMailid(strstrRequistionNextApproverEmail); //Added by vaibhav

				strMailMsg.append("<html><style>.formhead{ font-family:Arial;font-size:11px;font-style: normal;font-weight:normal;color:#000000;text-decoration:none;letter-spacing:normal;word-spacing:normal;border:1px #333333 solid;background:#E2E4D6;}</style><body bgcolor=\"#d0d0d0\">" + "\n");	
				strMailMsg.append(" <table width=80% border=0 cellspacing=0 cellpadding=0 align=center><tr><td align=right><font face=Verdana, Arial, Helvetica, sans-serif size=2><b><font color=#FFFFFF>"+strRequistionCreatedDateWithoutAMPM+"</font><font color=#FFFFFF></font><font color=#000000><br></font></b><font color=#FFFFFF>"+dbLabelBean.getLabel("label.mail.forinternalcirculationonly",strLanguage)+"</font></font></td></tr><tr><td bgcolor=#000000> </td></tr><tr><td bgcolor=#FFFFFF align=center>"+ "\n");
				strMailMsg.append("</td></tr><tr><td bgcolor=#000000> </td></tr><tr><td bgcolor=#FFFFFF align=center><table width=100% border=0 cellspacing=0 cellpadding=10><tr><td align=center bgcolor=#aa1220><font face=Arial, Helvetica, sans-serif size=5 color=#FFFFFF>"+dbLabelBean.getLabel("label.mail.starsmailnotification",strLanguage)+"</font></td></tr></table></td></tr><tr><td bgcolor=#000000> </td></tr><tr>"+ "\n");
				strMailMsg.append("<td bgcolor=#B6DCDC></td></tr><tr><td bgcolor=#000000> </td></tr><tr><td bgcolor=#000000> </td></tr><tr><td bgcolor=#FFFFFF><table width=100% border=0 cellspacing=0 cellpadding=5>"+ "\n");						
				strMailMsg.append("  <tr><td align=center bgcolor=#aa1220><font face=Verdana, Arial, Helvetica, sans-serif size=2><b><font color=#FFFFFF><font size=2>"+dbLabelBean.getLabel(ReqTyp1,strLanguage)+" "+dbLabelBean.getLabel("label.mail.requisitionpassedtoyou",strLanguage)+"</font> </font></b></font></td></tr><tr><td bgcolor=#878787><font face=Verdana, Arial, Helvetica, sans-serif size=2><b>"+dbLabelBean.getLabel(ReqTyp1,strLanguage)+" "+dbLabelBean.getLabel("label.global.requisitionnumber",strLanguage)+" : "+strRequistionNumber.trim()+"</b> ("+dbLabelBean.getLabel("label.mail.dated",strLanguage)+" : "+strRequistionCreatedDate+")</font></td></tr><tr><td><p><font color=#FFFFFF></font><font size=2 face=Verdana, Arial, Helvetica, sans-serif>"+ "\n"); 				
				strMailMsg.append(dbLabelBean.getLabel("label.mail.dear",strLanguage)+" "+strApproverName+",</font></p><p><font size=2 face=Verdana, Arial, Helvetica, sans-serif>"+dbLabelBean.getLabel("label.global.requisitionnumber",strLanguage)+" "+strRequistionNumber.trim()+" "+dbLabelBean.getLabel("label.mail.whichwasoriginatedby",strLanguage)+" "+strRequistionCreatorName+" "+dbLabelBean.getLabel("label.mail.from",strLanguage)+" "+strSiteName+" "+dbLabelBean.getLabel("label.mail.on",strLanguage)+" "+strRequistionCreatedDate+" "+dbLabelBean.getLabel("label.mail.hasbeenpassedbyme",strLanguage)+"</p>"+ "\n"); 
			
				strMailMsg.append("<u><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>"+dbLabelBean.getLabel("label.mail.requisitionsdetails",strLanguage)+" </u>:-</font><font size=2 face=Verdana, Arial, Helvetica, sans-serif >"+strGroupTravel+"<br>  </font>\n<br>"); 
				
				strMailMsg.append("<u><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>"+dbLabelBean.getLabel("label.global.reasonfortravel",strLanguage)+" </u>:- </font><font size=2 face=Verdana, Arial, Helvetica, sans-serif >"+strreasonFortravel+"</font>\n<br><br>"); 
	
				strMailMsg.append("<TABLE border=0 width=750  ><TR  height=10 ><TD    width=170><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue >"+dbLabelBean.getLabel("label.global.departuredate",strLanguage)+" </TD><TD    width=200><font size=2 face=Verdana, Arial, Helvetica, sans-serif >:- "+strTravelDate+"</TD><TD    width=170><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>"+dbLabelBean.getLabel("label.global.departurecity",strLanguage)+" </TD><TD><font size=2 face=Verdana, Arial, Helvetica, sans-serif > :- "+strTravelFrom+"</TD></TR><TR  height=10><TD ><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>"+dbLabelBean.getLabel("label.global.arrivalcity",strLanguage)+" </TD><TD ><font size=2 face=Verdana, Arial, Helvetica, sans-serif>:-  "+strTravelTo+"</TD><TD ><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>Return Date </TD><TD><font size=2 face=Verdana, elvetica, sans-serif > :- "+strTravelReturnDate+" </TD></TR><TR  height=10><TD ><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>"+dbLabelBean.getLabel("label.mail.amountrequested",strLanguage)+"</TD><TD ><font size=2 face=Verdana, Arial, Helvetica, sans-serif >:- "+text+"</TD><TD><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>Billing Client </TD><TD><font size=2 face=Verdana, Arial, Helvetica, sans-serif >:- "+strBillingSite+" </TD></TR><TR  height=10><TD ><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>"+dbLabelBean.getLabel("label.approverequest.travelclass",strLanguage)+"</TD><TD ><font size=2 face=Verdana, Arial, Helvetica, sans-serif >:- "+strTravelClass+"</TD><TD><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue></TD><TD><font size=2 face=Verdana, Arial, Helvetica, sans-serif >&nbsp;</TD></TR></TABLE>");
	
				strMailMsg.append("<br><font size=2 face=Verdana, Arial, Helvetica, sans-serif><U><FONT COLOR=BLUE>Reviewer Comments</FONT></u><br>"+strRequisitionComments.trim()+" "+ "\n"); 
				
			    strMailMsg.append("</font><br><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif><a href='"+strSSOUrl+"'>"+dbLabelBean.getLabel("label.mail.pleaseclickheretologintostars",strLanguage)+" </a> "+ "\n");
				strMailMsg.append("   </b></form></font><br><p><font size=2 face=Verdana, Arial, Helvetica, sans-serif>"+dbLabelBean.getLabel("label.mail.mailreferencenumber",strLanguage)+"</font><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif>"+strstrRequistionApproverName.trim()+"<br></font></p></td></tr></table></td></tr><tr><td bgcolor=#878787 align=center> <font face=Verdana, Arial, Helvetica, sans-serif size=1><b>"+dbLabelBean.getLabel("label.mail.mailreferencenumber",strsesLanguage)+" </b>"+strMailRefNumber+"/"+strCurrentYear+"</font></td></tr><tr><td bgcolor=#FFFFFF align=center>       <table width=100% border=0 cellspacing=0 cellpadding=5>"+ "\n"); 
				strMailMsg.append("<tr><td align=center bgcolor=#aa1220><font size=2 face=Verdana, Arial, Helvetica, sans-serif><b><font size=1>"+dbLabelBean.getLabel("label.mail.starsadministratorcanbecontacted",strLanguage)+" : - </font></b><font size=1><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=#000000>"+ "\n"); 
				strMailMsg.append("<a href=mailto:administrator.stars@mind-infotech.com><font size=1 color=#ffffff>administrator.stars@mind-infotech.com</font></a></font></font></font></td>  "+ "\n");  
				strMailMsg.append(" </tr><tr><td  align=center bgcolor=#878787 height=15> <b><font size=1 face=Verdana, Arial, Helvetica, sans-serif>"+dbLabelBean.getLabel("label.mail.disclaimer",strLanguage)+"</b> : "+dbLabelBean.getLabel("label.mail.thiscommunicationissystemgenererated",strLanguage)+" "+ "\n");  
				strMailMsg.append(dbLabelBean.getLabel("label.mail.pleasedonnotreplytothismail",strLanguage)+" <br>"+dbLabelBean.getLabel("label.mail.ifyouarenotthecorrectrecipientforthisnotification",strLanguage)+"</font></td></tr></table></td></tr><tr><td bgcolor=#000000></td></tr>"+ "\n");    
				strMailMsg.append("<tr><td align=center><font size=2 face=Verdana, Arial, Helvetica, sans-serif><font size=1 color=#000000>&copy;"+dbLabelBean.getLabel("label.mail.mindallrightsreserved",strLanguage)+"</font></font></td>  </tr></table><p>&nbsp;</p></body></html>"+ "\n");
						
				// System.out.println("strMailMsg====pass====="+strMailMsg); 
				try
				{
					//Procedure for inserting Mail Data
					cstmt_mail=con.prepareCall("{?=call PROC_REQUISITION_MAIL_ADD(?,?,?,?,?,?,?,?,?,?,?,?)}");
					cstmt_mail.registerOutParameter(1,java.sql.Types.INTEGER);
					cstmt_mail.setString(2, "");
					cstmt_mail.setString(3, strRequistionNumber);
					cstmt_mail.setString(4, strstrRequistionNextApproverEmail);//To
					cstmt_mail.setString(5, strstrRequistionApproverEmail);//From
					cstmt_mail.setString(6, "");//CC  mail will go to mata Associates
					cstmt_mail.setString(7, strMailSubject);
					cstmt_mail.setString(8, strMailMsg.toString());
					cstmt_mail.setInt(9, intTries);
					cstmt_mail.setString(10, "NEW");
					cstmt_mail.setString(11, Suser_id);
					cstmt_mail.setString(12, "Pass Process");
					cstmt_mail.setString(13, "Signatory Approves IT");
	                cstmt_mail.execute();
					cstmt_mail.close(); 
				}
				catch(Exception b)
				{
					System.out.println("ERROR in T_requisitionMailOnPass---1--------"+b);		
				}
			}
			catch(Exception e)
			{
				System.out.println("Error in T_requisitionMailOnPass--------------2-------------"+e);
			}
	}
	stmt.close();
	con.close();
	%>
	
