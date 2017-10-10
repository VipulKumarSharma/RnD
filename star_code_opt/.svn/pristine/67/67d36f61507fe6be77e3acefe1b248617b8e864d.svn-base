<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:GURMEET SINGH
 *Date of Creation 		:25-Sep-2015
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This is the  jsp file  for inserting the mail information in req_mailbox table
 *******************************************************/
%>
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
	<jsp:useBean id="dbUtilityBean" scope="page" class="src.connection.DbUtilityMethods" /><!-- Added by vaibhav -->
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<%
request.setCharacterEncoding("UTF-8");

Connection con							= null;
Statement stmt	,stmt1,stmt2			= null;
ResultSet rs,rs1,rs2					= null;
CallableStatement cstmt_mail			= null;
String	sSqlStr							= ""; 
String strSql							= "";
//Create Connection
Class.forName(Sdbdriver);
con=DriverManager.getConnection(Sdburl,Sdbuser,Sdbpwd);

int	intTries								= 0;
String strRequistionId						= null;
String strRequistionNumber	 				= null;
String strMailSubject						= null;
String strMailRefNumber						= null;
String strRequistionCreatorName	 			= null;
String strRequistionCreatorEmail			= null;
String strRequistionTravellerName 			= null;
String strRequistionTravellerEmail			= null;
String strRequistionApproverName			= null;
String strRequistionApproverEmail			= null;
String strTravelCoordinatorEmail			= null;
String strRequistionCreatedDateTime			= null;
String strRequistionCreatedDate				= null;
String strRequisitionComments				= null;
String strSiteName							= null;
String strTravelAgencyId					= null;
String strSendToEmail						= "";
String strCCEmail							= "";
String strRequistionCreatorId	 			= "";
String strRequistionTravellerId	 			= "";
String strRequistionCancelledBy	 			= "";
String strTravelDate						= "";
String strTravellerSex						= "";
String strSex								= "";
String strTravelFrom						= "";
String strTravelTo							= "";
String strCreationDate						= "";
String TType								= "";
String strCurrentDate						= "";
String strGroupTravel		 				= "";
String strGroupTravelFlag  					= "";
String ReqTyp								= "";
String ReqTyp1								= "";
StringBuffer strMailMsg						= new StringBuffer();

strRequistionId								= request.getParameter("purchaseRequisitionId"); 
strRequisitionComments						= request.getParameter("CancelComments");
ReqTyp										= request.getParameter("travelType");

if(ReqTyp != null && ReqTyp.equals("D")) {
	ReqTyp = "Domestic Travel";
	ReqTyp1= "label.mail.domestictravel";
} else if(ReqTyp != null && ReqTyp.equals("I")) {
    ReqTyp = "International Travel";
    ReqTyp1= "label.mail.internationaltravel";
}

//FETCH THE LATEST MAIL ID FROM REQ_MAILBOX
sSqlStr="SELECT ISNULL(MAX(MAIL_ID),'999')+1 FROM REQ_MAILBOX";
stmt = con.createStatement(); 
rs = stmt.executeQuery(sSqlStr);
if(rs.next()) {
	strMailRefNumber =	rs.getString(1);//Mail Reference Number
}
rs.close();
stmt.close();

// FETCH Requisition Details
if(ReqTyp.equals("Domestic Travel")) {
	TType="Domestic Travel Requisition No:";
	sSqlStr="SELECT TRAVEL_REQ_NO, T.C_USERID AS ORIGINATOR_ID, .DBO.USER_NAME(T.C_USERID) AS ORIGINATOR, DBO.USEREMAIL(T.C_USERID) AS ORIGINATOR_MAIL, T.TRAVELLER_ID AS TRAVELLER_ID, .DBO.USER_NAME(T.TRAVELLER_ID) AS TRAVELLER_NAME, DBO.USEREMAIL(T.TRAVELLER_ID) AS TRAVELLER_MAIL, " +
		" .DBO.USER_NAME(TA.APPROVER_ID) AS APPROVER_NAME, DBO.USEREMAIL(TA.APPROVER_ID) AS APPROVER_MAIL, CONVERT(VARCHAR(30),C_DATETIME,113) AS REQ_CREATE_DATE, CONVERT(VARCHAR(10),TRAVEL_DATE,103) AS TRAVEL_DATE, " + 
		" SEX, .DBO.SITENAME(T.SITE_ID) AS SITE_NAME,(select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = T.SITE_ID) as TRAVEL_AGENCY_ID, ISNULL(T.GROUP_TRAVEL_FLAG,'N') AS GROUP_TRAVEL_FLAG, ISNULL(STUFF((SELECT ';'+EMAIL FROM M_USERINFO WHERE SITE_ID IN (SELECT FUNCTION_VALUE FROM functional_ctl WHERE function_key='@MataIndiaSite') AND ROLE_ID ='MATA' AND STATUS_ID=10 FOR XML PATH(''), type).value('.', 'nvarchar(max)'),1,1,''),'') MATAINDIA " + 
		" FROM T_TRAVEL_DETAIL_DOM T LEFT OUTER JOIN(SELECT TOP 1 TRAVEL_ID, APPROVER_ID FROM T_APPROVERS WHERE TRAVEL_ID="+strRequistionId+" AND TRAVEL_TYPE='D' AND STATUS_ID=10 ORDER BY ORDER_ID) TA ON T.TRAVEL_ID=TA.TRAVEL_ID WHERE T.TRAVEL_ID="+strRequistionId+"";
} else {
	TType="International Travel Requisition No:";
	sSqlStr="SELECT TRAVEL_REQ_NO, T.C_USERID AS ORIGINATOR_ID, .DBO.USER_NAME(T.C_USERID) AS ORIGINATOR, DBO.USEREMAIL(T.C_USERID) AS ORIGINATOR_MAIL, T.TRAVELLER_ID AS TRAVELLER_ID, .DBO.USER_NAME(T.TRAVELLER_ID) AS TRAVELLER_NAME, DBO.USEREMAIL(T.TRAVELLER_ID) AS TRAVELLER_MAIL, " +
			" .DBO.USER_NAME(TA.APPROVER_ID) AS APPROVER_NAME, DBO.USEREMAIL(TA.APPROVER_ID) AS APPROVER_MAIL, CONVERT(VARCHAR(30),C_DATETIME,113) AS REQ_CREATE_DATE, CONVERT(VARCHAR(10),TRAVEL_DATE,103) AS TRAVEL_DATE, " + 
			" SEX, .DBO.SITENAME(T.SITE_ID) AS SITE_NAME,(select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = T.SITE_ID) as TRAVEL_AGENCY_ID, ISNULL(T.GROUP_TRAVEL_FLAG,'N') AS GROUP_TRAVEL_FLAG, ISNULL(STUFF((SELECT ';'+EMAIL FROM M_USERINFO WHERE SITE_ID IN (SELECT FUNCTION_VALUE FROM functional_ctl WHERE function_key='@MataIndiaSite') AND ROLE_ID ='MATA' AND STATUS_ID=10 FOR XML PATH(''), type).value('.', 'nvarchar(max)'),1,1,''),'') MATAINDIA " + 
			" FROM T_TRAVEL_DETAIL_INT T LEFT OUTER JOIN(SELECT TOP 1 TRAVEL_ID, APPROVER_ID FROM T_APPROVERS WHERE TRAVEL_ID="+strRequistionId+" AND TRAVEL_TYPE='I' AND STATUS_ID=10 ORDER BY ORDER_ID) TA ON T.TRAVEL_ID=TA.TRAVEL_ID WHERE T.TRAVEL_ID="+strRequistionId+"";
}

stmt= con.createStatement(); 
rs = stmt.executeQuery(sSqlStr);
if(rs.next()) {
	strRequistionNumber					=	rs.getString("TRAVEL_REQ_NO");// Number
	strRequistionCreatorId				=	rs.getString("ORIGINATOR_ID");//Creator Id
	strRequistionCreatorName			=	rs.getString("ORIGINATOR");//Creator Name
	strRequistionCreatorEmail			=	rs.getString("ORIGINATOR_MAIL");//Creator Email
	strRequistionTravellerId			=	rs.getString("TRAVELLER_ID");//Traveller Id
	strRequistionTravellerName			=	rs.getString("TRAVELLER_NAME");//Traveller Name
	strRequistionTravellerEmail			=	rs.getString("TRAVELLER_MAIL");//Traveller Email
	strRequistionApproverName			=	rs.getString("APPROVER_NAME");//Approver Name
	strRequistionApproverEmail			=	rs.getString("APPROVER_MAIL");//Approver Email
	strTravelCoordinatorEmail			=	rs.getString("MATAINDIA");//Mata India Email
	strRequistionCreatedDateTime		=	rs.getString("REQ_CREATE_DATE");//Req Created Date & time		
	strTravelDate						=	rs.getString("TRAVEL_DATE");// Travel Date
	strTravellerSex						=	rs.getString("SEX");// Traveller Sex
	strSiteName							=	rs.getString("SITE_NAME");//Site Name
	strTravelAgencyId					=	rs.getString("TRAVEL_AGENCY_ID");//Site Name
	
	String groupGuestLabel = "";
	if(strTravelAgencyId.equals("2")){
		groupGuestLabel = "label.global.guest";
	}else{
		groupGuestLabel = "label.approverequest.groupguest";
	}
	
	strRequistionCreatedDate = strRequistionCreatedDateTime.substring(0,17);
	
	if(!strRequistionApproverEmail.trim().equalsIgnoreCase("") && !strTravelCoordinatorEmail.trim().equalsIgnoreCase("")) {
		strSendToEmail = strRequistionApproverEmail+";"+strTravelCoordinatorEmail;
	} else if(strTravelCoordinatorEmail.trim().equalsIgnoreCase("")) {
		strSendToEmail = strRequistionApproverEmail;
	}
	
	if(!strRequistionCreatorId.equals(strRequistionTravellerId)) {
		if(Suser_id.equals(strRequistionTravellerId)) {
			strCCEmail 					= strRequistionCreatorEmail; 
			strRequistionCancelledBy	= strRequistionTravellerName;
		} else if(Suser_id.equals(strRequistionCreatorId)) {
			strCCEmail 					= strRequistionTravellerEmail;
			strRequistionCancelledBy	= strRequistionCreatorName;
		}
	} else {
		strRequistionCancelledBy	= strRequistionCreatorName;
	}
	
	if(strTravellerSex.equals("1")) {
		strSex	 =	 "Mr.";
	} else {
		strSex	 =	 "Ms";
	}
	
	if(ReqTyp.equals("Domestic Travel")) {
		
		strSql ="select * FROM  [dbo].[FN_GetDeparturecity]("+strRequistionId+",'d')";
		strGroupTravelFlag   =   rs.getString("GROUP_TRAVEL_FLAG"); 
		
	     if(strGroupTravelFlag==null) {
              	strGroupTravel =""; 
 		 }
		 if(strGroupTravelFlag!=null  &&  (strGroupTravelFlag.trim().equals("Y"))) {
				strGroupTravel = dbLabelBean.getLabel("label.mail.groupguestisscheduledtotravel",strsesLanguage);
				if(strTravelAgencyId.equals("2")) {
					strGroupTravel = dbLabelBean.getLabel("label.mail.guestisscheduledtotravel",strsesLanguage);
				}
			} else {
              	 strGroupTravel = strSex+" "+"<b>"+strRequistionTravellerName+ "</b> "+dbLabelBean.getLabel("label.mail.isscheduledtotravel",strsesLanguage); 
		}
	} else {
		
         strGroupTravelFlag   =   rs.getString("GROUP_TRAVEL_FLAG"); 
         
	     if(strGroupTravelFlag==null) {
              strGroupTravel ="";
         }
	     
		 if(strGroupTravelFlag!=null  &&  (strGroupTravelFlag.trim().equals("Y"))) {
			 strGroupTravel =dbLabelBean.getLabel("label.mail.groupguestisscheduledtotravel",strsesLanguage); 
			 if(strTravelAgencyId.equals("2")) {
				strGroupTravel = dbLabelBean.getLabel("label.mail.guestisscheduledtotravel",strsesLanguage);
			 }
         } else {
        	 strGroupTravel = strSex+" "+"<b>"+strRequistionTravellerName+ "</b> "+dbLabelBean.getLabel("label.mail.isscheduledtotravel",strsesLanguage);
         }
		 
   		 strSql ="select * FROM  [dbo].[FN_GetDeparturecity]("+strRequistionId+",'i')";
	}
	
	stmt1= con.createStatement(); 
	rs1 = stmt1.executeQuery(strSql);
	
	if(rs1.next()) {
		strTravelFrom	=	rs1.getString(1);
		strTravelTo		=	rs1.getString(2);
	}
	rs1.close();
	stmt1.close();
		Date currentDate				= new Date();
		SimpleDateFormat sdf			= new SimpleDateFormat("dd MMM yyyy H:mm");
		strCurrentDate					= (sdf.format(currentDate)).trim();
	 
	strCreationDate=strCurrentDate; 
	
	if(strRequistionCreatorEmail.equals(strRequistionApproverEmail))
	{}
	else {
		strSql	=	"SELECT LANGUAGE_PREF FROM M_USERINFO WHERE EMAIL =N'"+strRequistionCreatorEmail+"' AND STATUS_ID=10";
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
		
		if(strGroupTravelFlag!=null  &&  (strGroupTravelFlag.trim().equals("Y"))) {	
			strMailSubject=dbLabelBean.getLabel("label.mail.starsnotification",strsesLanguage)+" "+TType+" '"+strRequistionNumber.trim()+"' "+dbLabelBean.getLabel(groupGuestLabel,strsesLanguage)+" "+dbLabelBean.getLabel("label.mail.hasbeencancelled",strsesLanguage)+" ";//Mail Subject //added by vijay on 16/04/2007S
		} else {
			strMailSubject=dbLabelBean.getLabel("label.mail.starsnotification",strsesLanguage)+" "+TType+" '"+strRequistionNumber.trim()+"' "+dbLabelBean.getLabel("label.mail.hasbeencancelled",strsesLanguage)+" ";//Mail Subject //added by vijay on 16/04/2007S
		}
			
	try {
		String strSSOUrl = dbUtilityBean.sSSOUrlByMailid(strRequistionCreatorEmail); 

		strMailMsg.append("<html><style>.formhead{ font-family:Arial;font-size:11px;font-style: normal;font-weight:normal;color:#000000;text-decoration:none;letter-spacing:normal;word-spacing:normal;border:1px #333333 solid;background:#E2E4D6;}</style><body bgcolor=\"#d0d0d0\">" + "\n");	
		strMailMsg.append(" <table width=80% border=0 cellspacing=0 cellpadding=0 align=center><tr><td align=right><font face=Verdana, Arial, Helvetica, sans-serif size=2><b><font color=#FFFFFF>"+strCreationDate+"</font><font color=#FFFFFF></font><font color=#000000><br></font></b><font color=#FFFFFF>"+dbLabelBean.getLabel("label.mail.forinternalcirculationonly",strsesLanguage)+"</font></font></td></tr><tr><td bgcolor=#000000> </td></tr><tr><td bgcolor=#FFFFFF align=center>"+ "\n");
		strMailMsg.append("</td></tr><tr><td bgcolor=#000000> </td></tr><tr><td bgcolor=#FFFFFF align=center><table width=100% border=0 cellspacing=0 cellpadding=15><tr><td align=center bgcolor=#aa1220><font face=Arial, Helvetica, sans-serif size=5 color=#FFFFFF>"+dbLabelBean.getLabel("label.mail.starsmailnotification",strsesLanguage)+"</font></td></tr></table></td></tr><tr><td bgcolor=#000000> </td></tr><tr>"+ "\n");
		strMailMsg.append("<td bgcolor=#B6DCDC></td></tr><tr><td bgcolor=#000000> </td></tr><tr><td bgcolor=#000000> </td></tr><tr><td bgcolor=#FFFFFF><table width=100% border=0 cellspacing=0 cellpadding=5>"+ "\n");						
		strMailMsg.append(" <tr><td align=center bgcolor=#aa1220><font face=Verdana, Arial, Helvetica, sans-serif size=2><b><font color=#FFFFFF><font size=3>"+dbLabelBean.getLabel(ReqTyp1,strsesLanguage)+" "+dbLabelBean.getLabel("label.mail.requisition",strsesLanguage)+"</font> </font></b></font></td></tr><tr><td bgcolor=#878787><font face=Verdana, Arial, Helvetica, sans-serif size=2><b>"+dbLabelBean.getLabel(ReqTyp1,strsesLanguage)+" "+dbLabelBean.getLabel("label.global.requisitionnumber",strsesLanguage)+" : "+strRequistionNumber.trim()+"</b>("+dbLabelBean.getLabel("label.mail.dated",strsesLanguage)+" : "+strRequistionCreatedDate+")</font></td></tr><tr><td><p><font color=#FFFFFF>.</font><font size=2 face=Verdana, Arial, Helvetica, sans-serif><br>"+ "\n"); 				
		strMailMsg.append(dbLabelBean.getLabel("label.mail.dearsir",strsesLanguage)+"</font></p><p><font size=2 face=Verdana, Arial, Helvetica, sans-serif>"+dbLabelBean.getLabel("label.global.requisitionnumber",strsesLanguage)+" "+strRequistionNumber.trim()+" "+dbLabelBean.getLabel("label.approverrequest.from",strsesLanguage)+" "+strSiteName+" "+dbLabelBean.getLabel("label.mail.whichwasgeneratedon",strsesLanguage)+" "+strRequistionCreatedDate+" "+dbLabelBean.getLabel("label.mail.hasbeencancelledbyme",strsesLanguage)+"</p>"+ "\n"); 				
		strMailMsg.append("<u><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>"+dbLabelBean.getLabel("label.mail.requisitionsdetails",strsesLanguage)+":-</font></u><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif >"+strGroupTravel+"<br> Departure Date was "+strTravelDate+".  </font>\n<br>"); 
		strMailMsg.append("<u><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>"+dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)+":-</font></u><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif >"+strTravelFrom+" </font>\n<br>"); 
		strMailMsg.append("<u><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>"+dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)+":-</font></u><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif >"+strTravelTo+" </font>\n<br>"); 
		strMailMsg.append("<br><font size=2 face=Verdana, Arial, Helvetica, sans-serif><U><FONT COLOR=BLUE>"+strRequistionCancelledBy.trim()+" Comments</u><br>"+strRequisitionComments.trim()+" "+ "\n"); 
		strMailMsg.append("</font><br><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif><a href='"+strSSOUrl+"'>"+dbLabelBean.getLabel("label.mail.pleaseclickheretologintostars",strsesLanguage)+" </a> "+ "\n");  
		strMailMsg.append("</b></form></font><br><p><font size=2 face=Verdana, Arial, Helvetica, sans-serif>"+dbLabelBean.getLabel("label.mail.bestregards",strsesLanguage)+"</font><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif>"+strRequistionCancelledBy.trim()+"<br></font></p></td></tr></table></td></tr><tr><td bgcolor=#878787 align=center> <font face=Verdana, Arial, Helvetica, sans-serif size=2><b>"+dbLabelBean.getLabel("label.mail.mailreferencenumber",strsesLanguage)+" </b>"+strMailRefNumber+"/"+strCurrentYear+"</font></td></tr><tr><td bgcolor=#FFFFFF align=center>       <table width=100% border=0 cellspacing=0 cellpadding=12>"+ "\n"); 
		strMailMsg.append("<tr><td align=center bgcolor=#aa1220><font size=2 face=Verdana, Arial, Helvetica, sans-serif><b><font size=1>"+dbLabelBean.getLabel("label.mail.starsadministratorcanbecontacted",strsesLanguage)+" : - </font></b><font size=1><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=#000000>"+ "\n"); 
		strMailMsg.append("<a href=mailto:administrator.stars@mind-infotech.com><font size=1 color=#ffffff>administrator.stars@mind-infotech.com</font></a></font></font></font></td>  "+ "\n");  
		strMailMsg.append("</tr><tr><td  align=center bgcolor=#878787 height=55> <b><font size=1 face=Verdana, Arial, Helvetica, sans-serif>"+dbLabelBean.getLabel("label.mail.disclaimer",strsesLanguage)+" : "+dbLabelBean.getLabel("label.mail.thiscommunicationissystemgenererated",strsesLanguage)+" "+ "\n");  
		strMailMsg.append(dbLabelBean.getLabel("label.mail.pleasedonnotreplytothismail",strsesLanguage)+" <br>"+dbLabelBean.getLabel("label.mail.ifyouarenotthecorrectrecipient",strsesLanguage)+"</font></b></td></tr></table></td></tr><tr><td bgcolor=#000000> </td></tr>"+ "\n");    
		strMailMsg.append("<tr><td align=center><font size=2 face=Verdana, Arial, Helvetica, sans-serif><font size=1 color=#000000>&copy;"+dbLabelBean.getLabel("label.mail.mindallrightsreserved",strsesLanguage)+"</font></font></td>  </tr></table><p>&nbsp;</p></body></html>"+ "\n");
		
			try {
	    		//Procedure for inserting Mail Data
				cstmt_mail=con.prepareCall("{?=call PROC_REQUISITION_MAIL_ADD(?,?,?,?,?,?,?,?,?,?,?,?)}");
				cstmt_mail.registerOutParameter(1,java.sql.Types.INTEGER);
				cstmt_mail.setString(2, strRequistionId);
				cstmt_mail.setString(3, strRequistionNumber);
				cstmt_mail.setString(4, strSendToEmail);//TO Email Address(s)
				cstmt_mail.setString(5, strRequistionCreatorEmail);//FROM Email Address
				cstmt_mail.setString(6, strCCEmail);//CC Email Address
				cstmt_mail.setString(7, strMailSubject);
				cstmt_mail.setString(8, strMailMsg.toString());
				cstmt_mail.setInt(9, intTries);
				cstmt_mail.setString(10, "NEW");
				cstmt_mail.setString(11, Suser_id);
				cstmt_mail.setString(12, "Approved By All");
				cstmt_mail.setString(13, "Signatory Cancel IT");
				cstmt_mail.execute();
	    		cstmt_mail.close();
	    		
			} catch(Exception b) {
				System.out.print("ERROR in T_requisitionMailOnCancel_ApprovedByAll.jsp--1------"+b);		
			}
		
		} catch(Exception e) {
			System.out.print("ERROR in T_requisitionMailOnCancel_ApprovedByAll.jsp--2------"+e);		
		}
	}
}
rs.close();
stmt.close();
%>

