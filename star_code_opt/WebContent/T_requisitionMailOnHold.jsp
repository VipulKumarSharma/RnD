<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:Manoj Chand
 *Date of Creation 		:25 Feb 2013
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat 6.0, sql server 2008 
 *Description 			:This is the  jsp file  for inserting the hold mail information in req_mailbox table 
 
 *Modified By			:Manoj Chand
 *Date of Modification  :01-July-2013
 *Modification			:change in query to correct the value of travel to.
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

<jsp:useBean id="dbUtilityBean" scope="page" class="src.connection.DbUtilityMethods" />
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<%
request.setCharacterEncoding("UTF-8");
	// Variables declared and initialized
Connection con				=		null;			    // Object for connection
Statement stmt,stmt2,stmt1			=		null;			   // Object for Statement
ResultSet rs,rs2,rs1			=		null;			  // Object for ResultSet
CallableStatement cstmt_mail=		null;			// Object for Callable Statement

//Create Connection
Class.forName(Sdbdriver);
con=DriverManager.getConnection(Sdburl,Sdbuser,Sdbpwd);

//DECLARE VARIABLES

String strMailUserId					=  "";
String strCancelledBy                   =  "";
String	sSqlStr							=	""; // For sql Statements
String strRequistionId					=	null;
String strRequisitionStatus				=	null;
String strRequistionNumber	 			=	null;
String strMailSubject					=	null;
String strRequistionGTDate				=	null;
String strMailRefNumber					=	null;
String strRequistionCreatorName	 		=	null;
String strRequistionCreatorMail			=	null;
String strRequistionCreatedDate			=	null;
String strRequisitionComments			=	null;
StringBuffer strMailMsg					=   new StringBuffer();
String strstrRequistionApproverName		=	null;
String strstrRequistionApproverEmail	=	null;
String strstrRequistionApproverDesig	=	null;
String strstrRequistionNextApproverName	=	null;
String strstrRequistionNextApproverEmail=	null;
int		intTries						=	0;
String strUserPin						=   null;
String strSiteName						=	null;
String strTravelAgencyTypeId			=	null;
String strReqVal						=	null;
String	strUserNm						=	"";
String	strTravelDate					=	"";
String	strTravellerSex					=	"";
String	strSex							=	"";
String	strSql							=	"";
String	strTravelFrom					=	"";
String	strTravelTo						=	"";
String	strReq							=	"";
String strCreationDate					=	"";
String TType							=	"";
String strCurrentDate					=	"";

String 			strGroupTravel		  ="";
String 			strGroupTravelFlag  ="";

//GET THE VALUES FROM THE PREVIOUS SCREEN
strRequistionId						=	request.getParameter("purchaseRequisitionId");  //travel id
strMailUserId						=   request.getParameter("mailUserId");         //userid for mail
strRequisitionComments				=	request.getParameter("CancelComments");//reason for cancellation
String ReqTyp						=	request.getParameter("travelType");//travel type
String ReqTyp1="";

if(ReqTyp != null && ReqTyp.equals("D"))
{
	ReqTyp = "Domestic Travel";
	ReqTyp1= "label.mail.domestictravel";
}
if(ReqTyp != null && ReqTyp.equals("I"))
{
    ReqTyp = "International Travel";
    ReqTyp1= "label.mail.internationaltravel";
}

//FETCH THE LATEST MAIL ID FROM REQ_MAILBOX
sSqlStr="SELECT ISNULL(MAX(MAIL_ID),'999')+1 FROM REQ_MAILBOX";
stmt = con.createStatement(); 
rs = stmt.executeQuery(sSqlStr);
if(rs.next())
{
	strMailRefNumber				=	rs.getString(1);//Mail Reference Number
}
rs.close();
stmt.close();

// FETCH Requisition Details
if(ReqTyp.equals("Domestic Travel"))
{
	TType="Domestic Travel Requisition No:";//added by vijay on 16/04/2007
	sSqlStr="SELECT TRAVEL_REQ_NO ,.DBO.user_name('"+strMailUserId+"') AS ORIGINATOR,DBO.USEREMAIL('"+strMailUserId+"')AS ORIGINATOR_MAIL,.DBO.USER_NAME('"+Suser_id+"') AS APPROVER_NAME,DBO.USEREMAIL('"+Suser_id+"') AS APPROVER_MAIL,convert(varchar(30), C_DATETIME,113),.DBO.USER_NAME(TRAVELLER_ID) AS TRAVELLER_NAME ,convert(varchar(10),TRAVEL_DATE,103) AS TRAVEL_DATE,SEX ,.DBO.SITENAME(T.SITE_ID) AS SITE_NAME,ISNULL(T.GROUP_TRAVEL_FLAG,'N') AS GROUP_TRAVEL_FLAG,(select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = T.SITE_ID) as TRAVEL_AGENCY_ID  FROM T_TRAVEL_DETAIL_DOM  T  WHERE TRAVEL_ID="+strRequistionId+"";
}
else
{
	TType="International Travel Requisition No:";//added by vijay on 16/04/2007
	sSqlStr="SELECT TRAVEL_REQ_NO ,.DBO.user_name('"+strMailUserId+"') AS ORIGINATOR,DBO.USEREMAIL('"+strMailUserId+"')AS ORIGINATOR_MAIL,.DBO.USER_NAME('"+Suser_id+"') AS APPROVER_NAME,DBO.USEREMAIL('"+Suser_id+"') AS APPROVER_MAIL,convert(varchar(30), C_DATETIME,113),.DBO.USER_NAME(TRAVELLER_ID) AS TRAVELLER_NAME ,convert(varchar(10),TRAVEL_DATE,103) AS TRAVEL_DATE ,SEX ,.DBO.SITENAME(T.SITE_ID) AS SITE_NAME,ISNULL(T.GROUP_TRAVEL_FLAG,'N') AS GROUP_TRAVEL_FLAG,(select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = T.SITE_ID) as TRAVEL_AGENCY_ID  FROM T_TRAVEL_DETAIL_INT  T  WHERE TRAVEL_ID="+strRequistionId+"";
}
stmt= con.createStatement(); 
rs = stmt.executeQuery(sSqlStr);
if(rs.next())
{
	strRequistionNumber					=	rs.getString(1);// Number
	strRequistionCreatorName			=	rs.getString(2);//APPROVER NAME who will get the mail
	strRequistionCreatorMail			=	rs.getString(3);//APPROVER EMAIL who will get the mail
	strstrRequistionApproverName		=	rs.getString(4);//Creator Name
	strstrRequistionApproverEmail		=	rs.getString(5);//Creator Email
	String strRequistionCreatedDate1	=	rs.getString(6);//Req Created Date & time
	
	/*System.out.println("strRequistionNumber---"+strRequistionNumber);
	System.out.println("strRequistionCreatorName---"+strRequistionCreatorName);
	System.out.println("strRequistionCreatorMail------"+strRequistionCreatorMail);
	System.out.println("strstrRequistionApproverName------"+strstrRequistionApproverName);
	System.out.println("strstrRequistionApproverEmail------"+strstrRequistionApproverEmail);
	System.out.println("strRequistionCreatedDate1------"+strRequistionCreatedDate1);*/
	
	String str= strRequistionCreatedDate1.substring(0,17);
	strRequistionCreatedDate=str;	
	//End Modification
	strUserNm							=	rs.getString(7);//TRAVELLER NAME
	strTravelDate						=	rs.getString(8);// TRAVEL DATE
	strTravellerSex						=	rs.getString(9);// TRAVELLER SEX
	strSiteName							=	rs.getString(10);//site name
	strTravelAgencyTypeId				=	rs.getString("TRAVEL_AGENCY_ID"); //site name
	strCancelledBy						=	strstrRequistionApproverName;
	
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
		//strSql	=	"SELECT TRAVEL_FROM,TRAVEL_TO FROM T_JOURNEY_DETAILS_DOM WHERE TRAVEL_ID="+strRequistionId+"";
		strSql ="select * FROM  [dbo].[FN_GetDeparturecity]("+strRequistionId+",'d')";
		     strGroupTravelFlag       =   rs.getString("GROUP_TRAVEL_FLAG"); 
				     if(strGroupTravelFlag==null){
		               strGroupTravel =""; 
			 		 }
				 if(strGroupTravelFlag!=null  &&  (strGroupTravelFlag.trim().equals("Y"))){
  					   strGroupTravel =dbLabelBean.getLabel("label.mail.groupguestisscheduledtotravel",strsesLanguage); 
  					 	if(strTravelAgencyTypeId.equals("2")) {
  					 		strGroupTravel = dbLabelBean.getLabel("label.mail.guestisscheduledtotravel",strsesLanguage);
 						}
                    }
				else {
                	 strGroupTravel = strSex+" "+"<b>"+strUserNm+ "</b> "+dbLabelBean.getLabel("label.mail.isscheduledtotravel",strsesLanguage); 
				}

	}
	else
	{			
              strGroupTravelFlag       =   rs.getString("GROUP_TRAVEL_FLAG"); 
				     if(strGroupTravelFlag==null) 
						{
		               strGroupTravel =""; 
			 		     }
					 if(strGroupTravelFlag!=null  &&  (strGroupTravelFlag.trim().equals("Y")))
						{
						 strGroupTravel =dbLabelBean.getLabel("label.mail.groupguestisscheduledtotravel",strsesLanguage); 
						 if(strTravelAgencyTypeId.equals("2")) {
	  							strGroupTravel = dbLabelBean.getLabel("label.mail.guestisscheduledtotravel",strsesLanguage);
	 						}
                        }
						else
					      {
							 strGroupTravel = strSex+" "+"<b>"+strUserNm+ "</b> "+dbLabelBean.getLabel("label.mail.isscheduledtotravel",strsesLanguage); 
						 }
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
		Date currentDate				= new Date();
		SimpleDateFormat sdf			= new SimpleDateFormat("dd MMM yyyy H:mm");
		strCurrentDate					= (sdf.format(currentDate)).trim();
	 
	strCreationDate=strCurrentDate;
		strSql	=	"SELECT LANGUAGE_PREF FROM M_USERINFO WHERE EMAIL =N'"+strRequistionCreatorMail+"' AND STATUS_ID=10";
		stmt2= con.createStatement(); 
		rs2 = stmt2.executeQuery(strSql);
		if(rs2.next()){
			strsesLanguage=rs2.getString("LANGUAGE_PREF");
			if(strsesLanguage==null || strsesLanguage.equals("")){
				strsesLanguage="en_US";
			}
		}
		rs2.close();
		stmt2.close();
		
		if(strGroupTravelFlag!=null  &&  (strGroupTravelFlag.trim().equals("Y"))) {
			strMailSubject=dbLabelBean.getLabel("label.mail.starsnotification",strsesLanguage)+" "+TType+" '"+strRequistionNumber.trim()+"' "+dbLabelBean.getLabel(groupGuestLabel,strsesLanguage)+" "+dbLabelBean.getLabel("label.mail.hasbeenholded",strsesLanguage)+" ";//Mail Subject
		} else {
			strMailSubject=dbLabelBean.getLabel("label.mail.starsnotification",strsesLanguage)+" "+TType+" '"+strRequistionNumber.trim()+"' "+dbLabelBean.getLabel("label.mail.hasbeenholded",strsesLanguage)+" ";//Mail Subject
		}
		
	
	try
	{
		String strSSOUrl = dbUtilityBean.sSSOUrlByMailid(strRequistionCreatorMail); //Added by vaibhav

		strMailMsg.append("<html><style>.formhead{ font-family:Arial;font-size:11px;font-style: normal;font-weight:normal;color:#000000;text-decoration:none;letter-spacing:normal;word-spacing:normal;border:1px #333333 solid;background:#E2E4D6;}</style><body bgcolor=\"#d0d0d0\">" + "\n");	
		strMailMsg.append(" <table width=80% border=0 cellspacing=0 cellpadding=0 align=center><tr><td align=right><font face=Verdana, Arial, Helvetica, sans-serif size=2><b><font color=#FFFFFF>"+strCreationDate+"</font><font color=#FFFFFF></font><font color=#000000><br></font></b><font color=#FFFFFF>"+dbLabelBean.getLabel("label.mail.forinternalcirculationonly",strsesLanguage)+"</font></font></td></tr><tr><td bgcolor=#000000> </td></tr><tr><td bgcolor=#FFFFFF align=center>"+ "\n");
		strMailMsg.append("</td></tr><tr><td bgcolor=#000000> </td></tr><tr><td bgcolor=#FFFFFF align=center><table width=100% border=0 cellspacing=0 cellpadding=15><tr><td align=center bgcolor=#aa1220><font face=Arial, Helvetica, sans-serif size=5 color=#FFFFFF>"+dbLabelBean.getLabel("label.mail.starsmailnotification",strsesLanguage)+"</font></td></tr></table></td></tr><tr><td bgcolor=#000000> </td></tr><tr>"+ "\n");
		strMailMsg.append("<td bgcolor=#B6DCDC></td></tr><tr><td bgcolor=#000000> </td></tr><tr><td bgcolor=#000000> </td></tr><tr><td bgcolor=#FFFFFF><table width=100% border=0 cellspacing=0 cellpadding=5>"+ "\n");						
		strMailMsg.append("  <tr><td align=center bgcolor=#aa1220><font face=Verdana, Arial, Helvetica, sans-serif size=2><b><font color=#FFFFFF><font size=3>"+dbLabelBean.getLabel(ReqTyp1,strsesLanguage)+" "+dbLabelBean.getLabel("label.mail.requisition",strsesLanguage)+"</font> </font></b></font></td></tr><tr><td bgcolor=#878787><font face=Verdana, Arial, Helvetica, sans-serif size=2><b>"+dbLabelBean.getLabel(ReqTyp1,strsesLanguage)+" "+dbLabelBean.getLabel("label.global.requisitionnumber",strsesLanguage)+" : "+strRequistionNumber.trim()+"</b>("+dbLabelBean.getLabel("label.mail.dated",strsesLanguage)+" : "+strRequistionCreatedDate+")</font></td></tr><tr><td><p><font color=#FFFFFF>.</font><font size=2 face=Verdana, Arial, Helvetica, sans-serif><br>"+ "\n"); 				
		strMailMsg.append(dbLabelBean.getLabel("label.mail.dear",strsesLanguage)+" "+strRequistionCreatorName+",</font></p><p><font size=2 face=Verdana, Arial, Helvetica, sans-serif>"+dbLabelBean.getLabel("label.global.requisitionnumber",strsesLanguage)+" "+strRequistionNumber.trim()+" "+dbLabelBean.getLabel("label.approverrequest.from",strsesLanguage)+" "+strSiteName+" "+dbLabelBean.getLabel("label.mail.whichwasgeneratedon",strsesLanguage)+" "+strRequistionCreatedDate+" "+dbLabelBean.getLabel("label.mail.hasbeenholdedbyme",strsesLanguage)+"</p>"+ "\n"); 				
		strMailMsg.append("<u><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>"+dbLabelBean.getLabel("label.mail.requisitionsdetails",strsesLanguage)+":-</font></u><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif >"+strGroupTravel+"<br> "+dbLabelBean.getLabel("label.mail.departuredatewas",strsesLanguage)+" "+strTravelDate+".  </font>\n<br>"); 
		strMailMsg.append("<u><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>"+dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)+":-</font></u><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif >"+strTravelFrom+" </font>\n<br>"); 
		strMailMsg.append("<u><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>"+dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)+":-</font></u><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif >"+strTravelTo+" </font>\n<br>"); 
		strMailMsg.append("<br><font size=2 face=Verdana, Arial, Helvetica, sans-serif><U><FONT COLOR=BLUE>"+strstrRequistionApproverName+" "+dbLabelBean.getLabel("link.approverequest.comments",strsesLanguage)+"</u><br>"+strRequisitionComments.trim()+" "+ "\n"); 
		strMailMsg.append("</font><br><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif><a href='"+strSSOUrl+"'>"+dbLabelBean.getLabel("label.mail.pleaseclickheretologintostars",strsesLanguage)+" </a> "+ "\n");  
		strMailMsg.append("   </b></form></font><br><p><font size=2 face=Verdana, Arial, Helvetica, sans-serif>"+dbLabelBean.getLabel("label.mail.bestregards",strsesLanguage)+"</font><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif>"+strstrRequistionApproverName.trim()+"<br></font></p></td></tr></table></td></tr><tr><td bgcolor=#878787 align=center> <font face=Verdana, Arial, Helvetica, sans-serif size=2><b>"+dbLabelBean.getLabel("label.mail.mailreferencenumber",strsesLanguage)+" </b>"+strMailRefNumber+"/"+strCurrentYear+"</font></td></tr><tr><td bgcolor=#FFFFFF align=center>       <table width=100% border=0 cellspacing=0 cellpadding=12>"+ "\n"); 
		strMailMsg.append("<tr><td align=center bgcolor=#aa1220><font size=2 face=Verdana, Arial, Helvetica, sans-serif><b><font size=1>"+dbLabelBean.getLabel("label.mail.starsadministratorcanbecontacted",strsesLanguage)+" : - </font></b><font size=1><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=#000000>"+ "\n"); 
		strMailMsg.append("<a href=mailto:administrator.stars@mind-infotech.com><font size=1 color=#ffffff>administrator.stars@mind-infotech.com</font></a></font></font></font></td>  "+ "\n");  
		strMailMsg.append(" </tr><tr><td  align=center bgcolor=#878787 height=55> <b><font size=1 face=Verdana, Arial, Helvetica, sans-serif>"+dbLabelBean.getLabel("label.mail.disclaimer",strsesLanguage)+" : "+dbLabelBean.getLabel("label.mail.thiscommunicationissystemgenererated",strsesLanguage)+" "+ "\n");  
		strMailMsg.append(dbLabelBean.getLabel("label.mail.pleasedonnotreplytothismail",strsesLanguage)+" <br>"+dbLabelBean.getLabel("label.mail.ifyouarenotthecorrectrecipient",strsesLanguage)+"</font></b></td></tr></table></td></tr><tr><td bgcolor=#000000> </td></tr>"+ "\n");    
		strMailMsg.append("<tr><td align=center><font size=2 face=Verdana, Arial, Helvetica, sans-serif><font size=1 color=#000000>&copy;"+dbLabelBean.getLabel("label.mail.mindallrightsreserved",strsesLanguage)+"</font></font></td>  </tr></table><p>&nbsp;</p></body></html>"+ "\n");
		try
		{
    		//Procedure for inserting Mail Data
			cstmt_mail=con.prepareCall("{?=call PROC_REQUISITION_MAIL_ADD(?,?,?,?,?,?,?,?,?,?,?,?)}");
			cstmt_mail.registerOutParameter(1,java.sql.Types.INTEGER);
			cstmt_mail.setString(2, strRequistionId);
			cstmt_mail.setString(3, "Hold");
			cstmt_mail.setString(4, strRequistionCreatorMail);//
			cstmt_mail.setString(5, strstrRequistionApproverEmail);//From
			cstmt_mail.setString(6, "");
			cstmt_mail.setString(7, strMailSubject);
			cstmt_mail.setString(8, strMailMsg.toString());
			cstmt_mail.setInt(9, intTries);
			cstmt_mail.setString(10, "NEW");
			cstmt_mail.setString(11, Suser_id);///changed  by shiv  on 3/27/2007
			cstmt_mail.setString(12, "Hold Process");
			cstmt_mail.setString(13, "Signatory Cancel IT");
			cstmt_mail.execute();
    		cstmt_mail.close();
		}
		catch(Exception b)
		{
			System.out.print("ERROR in T_requisitionMailOnHold.jsp--1------"+b);		
		}
	}
	catch(Exception e)
	{
			System.out.print("ERROR in T_requisitionMailOnHold.jsp--2------"+e);		
	}
	
}
rs.close();
stmt.close();
con.close();

%>

