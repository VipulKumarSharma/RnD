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
 *Modification 			: 1  Change the mail Subject content 
                                  2  Change the mail Subject content,Added by shiv for showing Group Travel in case of group travel   on 25-Feb-08 ;    
								  3: CC Mail Address is remove By   shar sharma 		on 03-Apr-08
								  4: code added for sending mail to mail creartor on reciving of requisition with mata person 08-May-08
								  5:  Code added for showing group travel  in case of domestie group travel_DOM  on shiv sharma on 19-Jun-08
 *Reason of Modification: 
 *Date of Modification  : 11/04/2007
 *Revision History		:
 *Modified By			: Vijay Singh
 *Editor				:Editplus
 Modified by vaibhav on jul 19 2010 to enable SSO in Mails
 
 *Date of Modification	: 01 Nov 2011
 *Modified By			: Manoj Chand
 *Modification			: billing client was showing self as wrong entry in receiving mail from MATA.
 
 *Date of Modification	: 25 Apr 2012
 *Modified By			: Manoj Chand
 *Modification			: A message added in mail for Transit House.
 
 *Date of Modification	: 08 May 2012
 *Modified By			: Manoj Chand
 *Modification			: Correct the spelling of recipient in the mail body
 
 *Date of Modification	: 14 June 2012
 *Modified By			: Manoj Chand
 *Modification			: implementing multilingual functionality
 
 *Date of Modification	: 30 Jan 2013
 *Modified By			: Manoj Chand
 *Modification			: Showing requested amounts in multiple currencies in mail
 
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
<jsp:useBean id="dbConBean1" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbConBean2" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
<jsp:useBean id="dbUtilityBean" scope="page" class="src.connection.DbUtilityMethods" />

<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<%
request.setCharacterEncoding("UTF-8");
	// Variables declared and initialized
Connection con								=	null;	// Object for connection
Statement stmt	,stmt1,stmt2						=	null;	// Object for Statement
ResultSet rs,rs1,rs2,rs3							=	null;	// Object for ResultSet
CallableStatement cstmt_mail				=	null;	// Object for Callable Statement

//Create Connection
//Class.forName(Sdbdriver);
//con=DriverManager.getConnection(Sdburl,Sdbuser,Sdbpwd);
con = dbConBean2.getConnection();  //Get Connection
//DECLARE VARIABLES
String	sSqlStr								=	""; // For sql Statements
String	strSql2								=	"";
String strRequistionId						=	null;
String strRequisitionStatus					=	null;
String strRequistionNumber	 				=	null;
String strMailSubject						=	null;
String strRequistionGTDate					=	null;
String strMailRefNumber						=	null;
String strRequistionCreatorName	 			=	null;
String strRequistionCreatorMail				=	null;
String strRequistionCreatedDate				=	null;
String strRequisitionComments				=	null;
StringBuffer strMailMsg						= new StringBuffer();
String strstrRequistionApproverName			=	null;
String strstrRequistionApproverEmail		=	null;
String strstrRequistionApproverDesig		=	null;
String strstrRequistionNextApproverName		=	null;
String strstrRequistionNextApproverEmail	=	null;
int		intTries							=	0;
strRequistionId								=	request.getParameter("purchaseId");
String strUserPin							=	null;
String strSiteName							=	null;
String strTravelAgencyTypeId				=	null;
String strReqVal							=	null;
String	strUserNm							=	"";
String	strTravelDate						=	"";
String	strTravellerSex						=	"";
String	strSex								=	"";
String	strSql								=	"";
String	strTravelFrom						=	"";
String	strTravelTo							=	"";
String	strReq								=	"";
String	strHrNm								=	"";
String	strHrMail							=	"";
String	strSiteId							=	"";
String strBillingSite						=	"";	
String TType								=	"";// added by vijay on 11/04/2007

String strTravelReturnDate					=	"";

String 	strRequistionCreatedDatewithoutAMPM	=   "";


//String strCurrency			=   "";
//String strTotalAmount       =   "";
String strBillingSite1       =   "";
String strreasonFortravel   =   ""; 
String strSqlSql			="";

String   strGroupTravelFlag        ="";
String    strGroupTravel              ="";
ArrayList aList                                                 =   new ArrayList();
//GET THE VALUES FROM THE PREVIOUS SCREEN
strRequistionId								=	request.getParameter("purchaseRequisitionId");
strRequisitionStatus						=	request.getParameter("rad").trim();
strRequisitionComments						=	request.getParameter("COMMENTS");
String ReqTyp								=	request.getParameter("ReqTyp");
String strTransitType	= "0";
String strTrasitMsg		= "";
String strTrasitMsg1		= "";
String strLanguage = "";
String ReqTyp1="";
if(ReqTyp.equals("Domestic Travel")){
	ReqTyp1="label.mail.domestictravel";
}else{
	ReqTyp1="label.mail.internationaltravel";
}


//FETCH THE LATEST MAIL ID FROM REQ_MAILBOX
sSqlStr="SELECT ISNULL(MAX(MAIL_ID),'999')+1 FROM REQ_MAILBOX";
//stmt = con.createStatement(); 
rs = dbConBean.executeQuery(sSqlStr);
if(rs.next())
{
	strMailRefNumber		=	rs.getString(1);//Mail Reference Number
}
rs.close();
//stmt.close();

// FETCH Requistion Details
if(ReqTyp.equals("Domestic Travel"))
{
	TType="Domestic Travel Requisition No:";//added by vijay on 11/04/2007
	//sSqlStr="SELECT TRAVEL_REQ_NO ,.DBO.user_name(C_USERID) AS ORIGINATOR,DBO.USEREMAIL(C_USERID)AS ORIGINATOR_MAIL,.DBO.USER_NAME('"+Suser_id+"') AS APPROVER_NAME,DBO.USEREMAIL('"+Suser_id+"') AS APPROVER_MAIL,convert(varchar(30),C_DATETIME,113),.DBO.USER_NAME(TRAVELLER_ID) AS TRAVELLER_NAME ,convert(varchar(30),TRAVEL_DATE,113),SEX,SITE_ID AS SITE_NAME,.DBO.SITENAME(SITE_ID) AS SITE_NAME1,ISNULL(T.GROUP_TRAVEL_FLAG,'N') AS GROUP_TRAVEL_FLAG,t.TA_CURRENCY as TA_CURRENCY,t.TOTAL_AMOUNT as TOTAL_AMOUNT,dbo.sitename(t.BILLING_SITE) as BILLING_SITE,REASON_FOR_TRAVEL,BILLING_SITE as BILLING_SITE_id ,BILLING_CLIENT FROM T_TRAVEL_DETAIL_DOM  T WHERE TRAVEL_ID="+strRequistionId+" ";
	//CHANGE QUERY TO GET TRANSIT_TYPE BY MANO CHAND ON 24 APRIL 2012
	sSqlStr="SELECT TRAVEL_REQ_NO ,.DBO.user_name(C_USERID) AS ORIGINATOR,DBO.USEREMAIL(C_USERID)AS ORIGINATOR_MAIL,.DBO.USER_NAME('"+Suser_id+"') AS APPROVER_NAME,DBO.USEREMAIL('"+Suser_id+"') AS APPROVER_MAIL,convert(varchar(30),C_DATETIME,113),.DBO.USER_NAME(TRAVELLER_ID) AS TRAVELLER_NAME ,convert(varchar(30),TRAVEL_DATE,113),SEX,SITE_ID AS SITE_NAME,.DBO.SITENAME(SITE_ID) AS SITE_NAME1,ISNULL(T.GROUP_TRAVEL_FLAG,'N') AS GROUP_TRAVEL_FLAG,dbo.FN_GET_EXPENDITURE('"+strRequistionId+"','D') AS Expenditure,dbo.sitename(t.BILLING_SITE) as BILLING_SITE,REASON_FOR_TRAVEL,BILLING_SITE as BILLING_SITE_id ,BILLING_CLIENT,T.TRANSIT_TYPE,(select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = T.SITE_ID) as TRAVEL_AGENCY_ID FROM T_TRAVEL_DETAIL_DOM  T WHERE TRAVEL_ID="+strRequistionId+" ";
}
else
{
	TType="International Travel Requisition No:";//added by vijay on 11/04/2007
	//CHANGE QUERY TO GET TRANSIT_TYPE BY MANO CHAND ON 24 APRIL 2012
	sSqlStr="SELECT TRAVEL_REQ_NO ,.DBO.user_name(C_USERID) AS ORIGINATOR,DBO.USEREMAIL(C_USERID)AS ORIGINATOR_MAIL,.DBO.USER_NAME('"+Suser_id+"') AS APPROVER_NAME,DBO.USEREMAIL('"+Suser_id+"') AS APPROVER_MAIL,convert(varchar(30),C_DATETIME,113),.DBO.USER_NAME(TRAVELLER_ID) AS TRAVELLER_NAME ,convert(varchar(30),TRAVEL_DATE,113),SEX ,SITE_ID AS SITE_NAME,.DBO.SITENAME(SITE_ID) AS SITE_NAME1,ISNULL(T.GROUP_TRAVEL_FLAG,'N') AS GROUP_TRAVEL_FLAG,dbo.FN_GET_EXPENDITURE('"+strRequistionId+"','I') AS Expenditure,dbo.sitename(t.BILLING_SITE) as BILLING_SITE,REASON_FOR_TRAVEL,BILLING_SITE as BILLING_SITE_id ,BILLING_CLIENT,T.HOTEL_REQUIRED AS TRANSIT_TYPE,(select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = T.SITE_ID) as TRAVEL_AGENCY_ID  FROM T_TRAVEL_DETAIL_INT  T WHERE TRAVEL_ID="+strRequistionId+" ";
}
//stmt= con.createStatement(); 
//System.out.println("sSqlStr--->"+sSqlStr);
rs = dbConBean1.executeQuery(sSqlStr);
if(rs.next())
{
				
	strRequistionNumber							=	rs.getString(1);// Number
	strRequistionCreatorName			 		=	rs.getString(2);//Creator Name
	//System.out.println("strRequistionCreatorName--->"+strRequistionCreatorName);
	
	strRequistionCreatorMail				 	=	rs.getString(3);//Creator Email
	strstrRequistionApproverName				=	rs.getString(4);//APPROVER NAME
	strstrRequistionApproverEmail			 	=	rs.getString(5);//APPROVER EMAIL
	String strRequistionCreatedDate1			=	rs.getString(6);//Req Created Date & time
	
	//@ Vijay 30-Mar-2007 Add the substring Method for time format
	
	String str= strRequistionCreatedDate1.substring(0,17);

	String str1= strRequistionCreatedDate1.substring(0,11);

	strRequistionCreatedDate=str;

	strRequistionCreatedDatewithoutAMPM=str1;
	//End Modification
	strUserNm								 	=	rs.getString(7);//TRAVELLER NAME
	strTravelDate								=	rs.getString(8).substring(0,11); // TRAVEL DATE
	strTravellerSex								=	rs.getString(9); // TRAVELLER SEX
	strSiteId									=	rs.getString(10);//get site id
	strSiteName                                 =	rs.getString("SITE_NAME1");//get site id  
	strTravelAgencyTypeId						=	rs.getString("TRAVEL_AGENCY_ID"); //site name
	 
	String groupGuestLabel = "";
	if(strTravelAgencyTypeId.equals("2")){
		groupGuestLabel = "label.global.guest";
	}else{
		groupGuestLabel = "label.approverequest.groupguest";
	}
		
	if(strTravellerSex.equals("1"))
	{
		strSex	 =	 "Mr.";
	}
	else
	{
		strSex	 =	 "Ms";
	}

	if(ReqTyp.equals("Domestic Travel"))
	{
		//code commented by manoj chand and replace with new query on 27 june 2013.
		//strSql	=	"SELECT TRAVEL_FROM,TRAVEL_TO FROM T_JOURNEY_DETAILS_DOM WHERE TRAVEL_ID="+strRequistionId+"	";
		strSql ="select * FROM  [dbo].[FN_GetDeparturecity]("+strRequistionId+",'d')";
		  //strGroupTravel = strSex+" "+"<b>"+strUserNm+ "</b> is scheduled to travel.";
       // Code added for showing group travel  in case of domestie group travel_DOM  on shiv sharma on 19-Jun-08
		    strGroupTravelFlag       =   rs.getString("GROUP_TRAVEL_FLAG"); 
				     if(strGroupTravelFlag==null) {
		               strGroupTravel =""; 
		 		     }
  				    if(strGroupTravelFlag!=null  &&  (strGroupTravelFlag.trim().equals("Y"))){
 					   strGroupTravel ="A <B>Group/Guest</b> is scheduled to travel."; 
                    }
					else{
                       strGroupTravel = strSex+" "+"<b>"+strUserNm+ "</b> is scheduled to travel.";
					 }

    strSqlSql="SELECT CONVERT(VARCHAR(11), TRAVEL_DATE, 113) FROM "+         		   
		   " T_RET_JOURNEY_DETAILS_Dom WHERE  (TRAVEL_ID = "+strRequistionId+") and  (RETURN_FROM <> '') AND (RETURN_TO <> '')" ;
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
                        //strGroupTravel ="Group "; 
						strGroupTravel ="A <B>Group/Guest</b> is scheduled to travel."; 
                        }
						else
					      {
                            strGroupTravel = strSex+" "+"<b>"+strUserNm+ "</b> is scheduled to travel.";
						 }
						 //strGroupTravelFlag
						 //strGroupTravel
		//code commented by manoj chand and replace with new query on 27 june 2013.
		//strSql	=	"SELECT TRAVEL_FROM,TRAVEL_TO FROM T_JOURNEY_DETAILS_INT WHERE TRAVEL_ID="+strRequistionId+"	";
		strSql ="select * FROM  [dbo].[FN_GetDeparturecity]("+strRequistionId+",'i')";

		 strSqlSql="SELECT CONVERT(VARCHAR(11), TRAVEL_DATE, 113) FROM "+         		   
						   " T_RET_JOURNEY_DETAILS_INT WHERE  (TRAVEL_ID = "+strRequistionId+") and  (RETURN_FROM <> '') AND (RETURN_TO <> '')" ;
	}

	String text = rs.getString("Expenditure");
	//strCurrency			 =   rs.getString("TA_CURRENCY");//TOTAL_AMOUNT 
	//strTotalAmount       =   rs.getString("TOTAL_AMOUNT"); //BILLING_SITE
	strBillingSite1       =   rs.getString("BILLING_SITE");
	strreasonFortravel   =   rs.getString("REASON_FOR_TRAVEL");

	String strbillingSiteid		 = rs.getString("BILLING_SITE_id");  

	String strBillingClient    = rs.getString("BILLING_CLIENT");  
	//ADDED BY MANOJ CHANDO ON 24 APRIL 2012
	strTransitType = rs.getString("TRANSIT_TYPE");
	//System.out.println("Transit Type --->"+strTransitType);
	
	if(strbillingSiteid.equals("-1")) { //case of out side smg 
	strBillingSite1=strBillingClient;  
	}

	if(strbillingSiteid.equals("0")) { //case of self smg 
	//strBillingSite1="self";
	//changed by manoj chand on 01 nov 2011 to show billing client on receiving mail.
		strBillingSite1=strBillingClient;
	}
	
   //System.out.println("strGroupTravel ====="+strGroupTravel);

	//String text =strCurrency+" "+strTotalAmount ;


	//added by manoj chand on 24 april 2012 to show transit house related message in email.
	if(strTransitType.trim().equalsIgnoreCase("2")){
		//strTrasitMsg="<font size=2 color=red >SMOKING & ALCOHOL IS STRICTLY PROHIBITED INSIDE COMPANY'S TRANSIT HOUSE.</font><br>";
		strTrasitMsg="label.mail.smokingandalcolholmsg";
	}
		
		
  // System.out.println("ssssssssssssssssssssssssss");


	//stmt1= con.createStatement(); 
	rs1 = dbConBean.executeQuery(strSql);
	if(rs1.next())
	{
		strTravelFrom	=	rs1.getString(1);
		strTravelTo		=	rs1.getString(2);
	}
	rs1.close();


	
   //code to find return date from Query 
	
	stmt1= con.createStatement(); 
	rs2 = stmt1.executeQuery(strSqlSql);
			if(rs2.next())
			{
					strTravelReturnDate	=	rs2.getString(1);
					
			}

	rs2.close();
	//stmt1.close();

	//stmt1.close();

	//There are two case. if billing client is self then mail goes to Originator otherwise mail goes to hr in the case of receiving.
	if(ReqTyp.equals("Domestic Travel"))
	{
		//query for finding the dom billing site
		strSql = "SELECT BILLING_SITE, BILLING_CLIENT FROM T_TRAVEL_DETAIL_DOM WHERE TRAVEL_ID="+strRequistionId+" AND STATUS_ID=10 AND APPLICATION_ID=1";
	}
	else
	{
		//query for finding the international billing site
		strSql = "SELECT BILLING_SITE, BILLING_CLIENT FROM T_TRAVEL_DETAIL_INT WHERE TRAVEL_ID="+strRequistionId+" AND STATUS_ID=10 AND APPLICATION_ID=1";			
	}
	rs1 = dbConBean.executeQuery(strSql);
	if(rs1.next())
	{
		strBillingSite = rs1.getString("BILLING_SITE");
	}
	rs1.close();

	if(strBillingSite != null && !strBillingSite.equals("0"))              //0 for self option 
	{
		strSql2	="SELECT DBO.USER_NAME(USERID),EMAIL FROM M_USERINFO WHERE SITE_ID="+strSiteId+" AND ROLE_ID IN ('HR') AND STATUS_ID=10";
		//stmt1= con.createStatement(); 
		rs1 = dbConBean.executeQuery(strSql2);
		while(rs1.next())
		{
			strHrNm			=	rs1.getString(1);
			strHrMail		=	rs1.getString(2);
			aList.add(strHrNm);
			aList.add(strHrMail);

		}
		rs1.close();
		//  code added for sending mail to mail creartor on reciving of requisition with mata person 08-May-08  
		strHrNm    =  strRequistionCreatorName;
		strHrMail  =  strRequistionCreatorMail;	
		//System.out.println("strHrNm   1 --->"+strHrNm);
		//System.out.println("strHrMail 1 --->"+strHrMail);
		aList.add(strHrNm);
		aList.add(strHrMail);
		 		//stmt1.close();
	}
	else
	{
		strHrNm    =  strRequistionCreatorName;
		strHrMail  =  strRequistionCreatorMail;	
		//System.out.println("strHrNm   2 --->"+strHrNm);
		//System.out.println("strHrMail 2 --->"+strHrMail);
		aList.add(strHrNm);
		aList.add(strHrMail);
	}

	//aList  = dbUtilityBean.getApproverAccoringToRole(strRequistionNextApprover_UserId);
	//System.out.println("aList is=============="+aList);
	Iterator itr =  aList.iterator();
	while(itr.hasNext())
	{
		 strHrNm        = (String) itr.next();
		 strHrMail      = (String) itr.next(); 
		//added by manoj chand on 13 june 2012 to get mail to person language preference
			strSql	=	"SELECT LANGUAGE_PREF FROM M_USERINFO WHERE EMAIL =N'"+strHrMail+"' AND STATUS_ID=10";
			stmt2= con.createStatement(); 
			rs3 = stmt2.executeQuery(strSql);
			if(rs3.next()){
				strLanguage=rs3.getString("LANGUAGE_PREF");
				if(strLanguage==null || strLanguage.equals("")){
					strLanguage="en_US";
				}
			}
			rs3.close();
			stmt2.close();

			
	 	 strMailMsg = new StringBuffer();
	 	if(strTransitType.trim().equalsIgnoreCase("2")){
	 	strTrasitMsg1="<font size=2 color=red >"+dbLabelBean.getLabel(strTrasitMsg,strLanguage)+"</font><br>";
	 	}
	 	
	 	if(strGroupTravelFlag!=null  &&  (strGroupTravelFlag.trim().equals("Y"))) {
	 		strMailSubject=dbLabelBean.getLabel("label.mail.starsnotification",strLanguage)+" "+TType+" '"+strRequistionNumber.trim()+"' "+dbLabelBean.getLabel(groupGuestLabel,strLanguage)+" "+dbLabelBean.getLabel("label.mail.receivedbymata",strLanguage)+" ";//Mail Subject
		} else {
			strMailSubject=dbLabelBean.getLabel("label.mail.starsnotification",strLanguage)+" "+TType+" '"+strRequistionNumber.trim()+"' "+dbLabelBean.getLabel("label.mail.receivedbymata",strLanguage)+" ";//Mail Subject
		}
				
		try
		{
			String strSSOUrl = dbUtilityBean.sSSOUrlByMailid(strHrMail); //Added by vaibhav

			strMailMsg.append("<html><style>.formhead{ font-family:Arial;font-size:11px;font-style: normal;font-weight:normal;color:#000000;text-decoration:none;letter-spacing:normal;word-spacing:normal;border:1px #333333 solid;background:#E2E4D6;}</style><body bgcolor=\"#d0d0d0\">" + "\n");	
			strMailMsg.append(" <table width=80% border=0 cellspacing=0 cellpadding=0 align=center><tr><td align=right><font face=Verdana, Arial, Helvetica, sans-serif size=2><b><font color=#FFFFFF>"+strRequistionCreatedDatewithoutAMPM+"</font><font color=#FFFFFF></font><font color=#000000><br></font></b><font color=#FFFFFF>"+dbLabelBean.getLabel("label.mail.forinternalcirculationonly",strLanguage)+"</font></font></td></tr><tr><td bgcolor=#000000> </td></tr><tr><td bgcolor=#FFFFFF align=center>"+ "\n");
			strMailMsg.append("</td></tr><tr><td bgcolor=#000000> </td></tr><tr><td bgcolor=#FFFFFF align=center><table width=100% border=0 cellspacing=0 cellpadding=10><tr><td align=center bgcolor=#aa1220><font face=Arial, Helvetica, sans-serif size=5 color=#FFFFFF>"+dbLabelBean.getLabel("label.mail.starsmailnotification",strLanguage)+"</font></td></tr></table></td></tr><tr><td bgcolor=#000000> </td></tr><tr>"+ "\n");
			strMailMsg.append("<td bgcolor=#B6DCDC></td></tr><tr><td bgcolor=#000000> </td></tr><tr><td bgcolor=#000000> </td></tr><tr><td bgcolor=#FFFFFF><table width=100% border=0 cellspacing=0 cellpadding=5>"+ "\n");						
			strMailMsg.append("  <tr><td align=center bgcolor=#aa1220><font face=Verdana, Arial, Helvetica, sans-serif size=2><b><font color=#FFFFFF><font size=2>"+dbLabelBean.getLabel(ReqTyp1,strLanguage)+" "+dbLabelBean.getLabel("label.mail.requisition",strLanguage)+"</font> </font></b></font></td></tr><tr><td bgcolor=#878787><font face=Verdana, Arial, Helvetica, sans-serif size=2><b>"+dbLabelBean.getLabel(ReqTyp1,strLanguage)+" "+dbLabelBean.getLabel("label.global.requisitionnumber",strLanguage)+" : "+strRequistionNumber.trim()+"</b> ("+dbLabelBean.getLabel("label.mail.dated",strLanguage)+" : "+strRequistionCreatedDate+")</font></td></tr><tr><td><p><font color=#FFFFFF></font><font size=2 face=Verdana, Arial, Helvetica, sans-serif>"+"\n"); 				
			strMailMsg.append(dbLabelBean.getLabel("label.mail.dear",strLanguage)+" "+strHrNm+",</font></p><p><font size=2 face=Verdana, Arial, Helvetica, sans-serif>"+dbLabelBean.getLabel("label.global.requisitionnumber",strLanguage)+" "+strRequistionNumber.trim()+" "+dbLabelBean.getLabel("label.mail.whichwasoriginatedby",strLanguage)+" "+strRequistionCreatorName+" "+dbLabelBean.getLabel("label.mail.from",strLanguage)+" "+strSiteName+" "+dbLabelBean.getLabel("label.mail.on",strLanguage)+" "+strRequistionCreatedDate+" "+dbLabelBean.getLabel("label.mail.hasbeenreceivedbyme",strLanguage)+"</p>"+ "\n");
			
		strMailMsg.append("<u><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>"+dbLabelBean.getLabel("label.mail.requisitionsdetails",strLanguage)+" </u>  :-</font><font size=2 face=Verdana, Arial, Helvetica, sans-serif >"+strGroupTravel+"<br>  </font>\n<br>"); 

			strMailMsg.append("<u><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>"+dbLabelBean.getLabel("label.global.reasonfortravel",strLanguage)+" </u>  :-</font><font size=2 face=Verdana, Arial, Helvetica, sans-serif >"+strreasonFortravel+".  </font>\n<br><br>"); 

			strMailMsg.append("<TABLE border=0 width=750  ><TR  height=10 ><TD    width=170><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue >"+dbLabelBean.getLabel("label.global.departuredate",strLanguage)+" </TD><TD    width=200><font size=2 face=Verdana, Arial, Helvetica, sans-serif >:- "+strTravelDate+"</TD><TD    width=170><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>"+dbLabelBean.getLabel("label.global.departurecity",strLanguage)+" </TD><TD><font size=2 face=Verdana, Arial, Helvetica, sans-serif > :- "+strTravelFrom+"</TD></TR><TR  height=10><TD ><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>"+dbLabelBean.getLabel("label.global.arrivalcity",strLanguage)+" </TD><TD ><font size=2 face=Verdana, Arial, Helvetica, sans-serif>:-  "+strTravelTo+"</TD><TD ><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>"+dbLabelBean.getLabel("label.report.returndate",strLanguage)+" </TD><TD><font size=2 face=Verdana, elvetica, sans-serif > :- "+strTravelReturnDate+" </TD></TR><TR  height=10><TD ><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>"+dbLabelBean.getLabel("label.mail.amountrequested",strLanguage)+"</TD><TD width=240><font size=2 face=Verdana, Arial, Helvetica, sans-serif >:- "+text+"</TD><TD><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>"+dbLabelBean.getLabel("label.requestdetails.billingclient",strLanguage)+" </TD><TD><font size=2 face=Verdana, Arial, Helvetica, sans-serif >:- "+strBillingSite1+" </TD></TR></TABLE>");


			
			strMailMsg.append("<br><font size=2 face=Verdana, Arial, Helvetica, sans-serif><U><FONT COLOR=BLUE>"+dbLabelBean.getLabel("label.mail.mycomments",strLanguage)+"</u><br></FONT>"+strRequisitionComments.trim()+" "+ "\n"); 
			
			
			if(strHrNm.trim().equalsIgnoreCase(strRequistionCreatorName.trim())){
				strMailMsg.append("</font><br><br>"+strTrasitMsg1+"<font size=2 face=Verdana, Arial, Helvetica, sans-serif><a href='"+strSSOUrl+"'>"+dbLabelBean.getLabel("label.mail.pleaseclickheretologintostars",strLanguage)+" </a> "+ "\n");
				//System.out.println("-------if------mata--->"+strTrasitMsg);
			}else{
				strMailMsg.append("</font><br><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif><a href='"+strSSOUrl+"'>"+dbLabelBean.getLabel("label.mail.pleaseclickheretologintostars",strLanguage)+" </a> "+ "\n");	
			}
			  
			  
			strMailMsg.append("   </b></form></font><br><p><font size=2 face=Verdana, Arial, Helvetica, sans-serif>"+dbLabelBean.getLabel("label.mail.bestregards",strLanguage)+"</font><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif>"+strstrRequistionApproverName.trim()+"<br></font></p></td></tr></table></td></tr><tr><td bgcolor=#878787 align=center> <font face=Verdana, Arial, Helvetica, sans-serif size=1><b>"+dbLabelBean.getLabel("label.mail.mailreferencenumber",strLanguage)+" </b>"+strMailRefNumber+"/"+strCurrentYear+"</font></td></tr><tr><td bgcolor=#FFFFFF align=center>       <table width=100% border=0 cellspacing=0 cellpadding=5>"+ "\n"); 
			strMailMsg.append("<tr><td align=center bgcolor=#aa1220><font size=2 face=Verdana, Arial, Helvetica, sans-serif><b><font size=1>"+dbLabelBean.getLabel("label.mail.starsadministratorcanbecontacted",strLanguage)+" : - </font></b><font size=1><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=#000000>"+ "\n"); 
			strMailMsg.append("<a href=mailto:administrator.stars@mind-infotech.com><font size=1 color=#ffffff>administrator.stars@mind-infotech.com</font></a></font></font></font></td>  "+ "\n");  
			strMailMsg.append(" </tr><tr><td  align=center bgcolor=#878787 height=55> <b><font size=1 face=Verdana, Arial, Helvetica, sans-serif>"+dbLabelBean.getLabel("label.mail.disclaimer",strLanguage)+" </b>: "+dbLabelBean.getLabel("label.mail.thiscommunicationissystemgenererated",strLanguage)+" "+ "\n");  
			strMailMsg.append(dbLabelBean.getLabel("label.mail.pleasedonnotreplytothismail",strLanguage)+" <br>"+dbLabelBean.getLabel("label.mail.ifyouarenotthecorrectrecipientforthisnotification",strLanguage)+"</font></td></tr></table></td></tr><tr><td bgcolor=#000000></td></tr>"+ "\n");    
			strMailMsg.append("<tr><td align=center><font size=2 face=Verdana, Arial, Helvetica, sans-serif><font size=1 color=#000000>&copy;"+dbLabelBean.getLabel("label.mail.mindallrightsreserved",strLanguage)+"</font></font></td>  </tr></table><p>&nbsp;</p></body></html>"+ "\n");

			//System.out.println("strMailMsg=========="+strMailMsg);
					
			try
			{
				//Procedure for inserting Mail Data
				cstmt_mail=con.prepareCall("{?=call PROC_REQUISITION_MAIL_ADD(?,?,?,?,?,?,?,?,?,?,?,?)}");
				cstmt_mail.registerOutParameter(1,java.sql.Types.INTEGER);
				cstmt_mail.setString(2, strRequistionId);
				cstmt_mail.setString(3, strRequistionNumber);
				cstmt_mail.setString(4, strHrMail);//To
				cstmt_mail.setString(5, strstrRequistionApproverEmail);//From
				cstmt_mail.setString(6, "");//CC Mail Address is remove By   shar sharma 		on 03-Apr-08
				cstmt_mail.setString(7, strMailSubject);
				cstmt_mail.setString(8, strMailMsg.toString());
				cstmt_mail.setInt(9, intTries);
				cstmt_mail.setString(10, "NEW");
				cstmt_mail.setString(11, Suser_id);
				cstmt_mail.setString(12, "Approval Process");
				cstmt_mail.setString(13, "MATA receives IT");
				cstmt_mail.execute();
				cstmt_mail.close();
			}
			catch(Exception b)
			{
				System.out.println("ERROR in T_requisitionMailOnReceiving.jsp ----1----"+b);		
			}
		}
		catch(Exception e)
		{
		   System.out.println("ERROR in T_requisitionMailOnReceiving.jsp----2------"+e);
		}
	}

}
rs.close();

//Close All Connection
dbConBean.close();  
dbConBean1.close(); 
dbConBean2.close();  
%>

