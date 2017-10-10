<!-- INCLUDE STATEMENTS -->
<%@page import="java.util.Calendar"%>
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
	String sSqlStr							= ""; 
	String strSql							= "";
	
	Class.forName(Sdbdriver);
	con=DriverManager.getConnection(Sdburl,Sdbuser,Sdbpwd);
	
	int	intTries							= 0;
	String strRequistionId					= null;
	String strRequistionNumber	 			= null;
	String strMailSubject					= null;
	String strMailRefNumber					= null;
	String strRequistionCreatorName	 		= null;
	String strRequistionCreatorEmail		= null;
	String strRequistionTravellerName 		= null;
	String strRequistionTravellerEmail		= null;
	String strRequistionApproverName		= null;
	String strRequistionApproverEmail		= null;
	String strTravelCoordinatorEmail		= null;
	String strRequistionCreatedDateTime		= null;
	String strRequistionCreatedDate			= null;
	String strRequisitionComments			= null;
	String strSiteName						= null;
	String strTravelAgencyId				= null;
	String strSendToEmail					= "";
	String strCCEmail						= "";
	String strRequistionCreatorId	 		= "";
	String strRequistionTravellerId	 		= "";
	String strRequistionCancelledBy	 		= "";
	String strTravelDate					= "";
	String strTravellerSex					= "";
	String strSex							= "";
	String strTravelFrom					= "";
	String strTravelTo						= "";
	String strCreationDate					= "";
	String TType							= "";
	String strCurrentDate					= "";
	String strGroupTravel		 			= "";
	String strGroupTravelFlag  				= "";
	String ReqTyp							= "";
	String ReqTyp1							= "";
	String strTravelerName					= "";
	StringBuffer strMailMsg					= new StringBuffer();
	
	Date currentDate						= new Date();
	SimpleDateFormat sdf					= new SimpleDateFormat("dd MMM yyyy H:mm");
	strCurrentDate							= (sdf.format(currentDate)).trim();
	strCreationDate							= strCurrentDate;
	
	ReqTyp									= request.getParameter("travelType").trim();
	strRequistionId							= request.getParameter("purchaseRequisitionId").trim(); 
	strRequistionNumber						= request.getParameter("RequisitionNum").trim();
	strRequisitionComments					= request.getParameter("CancelComments").trim();
	strRequistionCancelledBy				= request.getParameter("cnclBy").trim();
	strSiteName								= request.getParameter("siteName").trim();
	strRequistionCreatorEmail				= request.getParameter("emailFrom").trim();
	strTravelerName 						= request.getParameter("travelerName").trim();
	
	if(ReqTyp != null && ReqTyp.equals("D")) {
		ReqTyp 	= "Domestic Travel";
		ReqTyp1	= "label.mail.domestictravel";
		TType	= "Domestic Travel Requisition No:";
	} else if(ReqTyp != null && ReqTyp.equals("I")) {
	    ReqTyp 	= "International Travel";
	    ReqTyp1	= "label.mail.internationaltravel";
	    TType	= "International Travel Requisition No:";
	}
	strMailSubject = dbLabelBean.getLabel("label.mail.starsnotification",strsesLanguage)+" "+TType+" '"+strRequistionNumber.trim()+"' "+dbLabelBean.getLabel("label.mail.hasbeencancelled",strsesLanguage)+" ";
	
	//FETCH THE LATEST MAIL ID FROM REQ_MAILBOX
	sSqlStr	="SELECT ISNULL(MAX(MAIL_ID),'999')+1 FROM REQ_MAILBOX";
	stmt 	= con.createStatement(); 
	rs 		= stmt.executeQuery(sSqlStr);
	if(rs.next()) {
		strMailRefNumber =	rs.getString(1);//Mail Reference Number
	}
	rs.close();
	stmt.close();
	
	strSql	=	"SELECT LANGUAGE_PREF FROM M_USERINFO WHERE EMAIL =N'"+strRequistionCreatorEmail+"' AND STATUS_ID=10";
	stmt2	= con.createStatement(); 
	rs2 	= stmt2.executeQuery(strSql);
	if(rs2.next()) {
		strsesLanguage = rs2.getString("LANGUAGE_PREF");
		if(strsesLanguage==null || strsesLanguage.equals("")){
			strsesLanguage="en_US";
		}
	}
	rs2.close();
	stmt2.close();
	
	List emailIdsList = new ArrayList();
	String emailIds	= "";
	
	sSqlStr	="select EMAIL from M_USERINFO where ROLE_ID='AC' and SITE_ID=105 and STATUS_ID=10";
	stmt	= con.createStatement(); 
	rs 		= stmt.executeQuery(sSqlStr);
	while(rs.next()) {
		emailIds = rs.getString("EMAIL").trim();
		emailIdsList.add(emailIds);
	}
	rs.close();
	stmt.close();
	
	StringBuilder sb 	= new StringBuilder();
	int size 			= emailIdsList.size();
	if (size > 0) {
		sb.append(emailIdsList.get(0));
		for (int i = 1; i < size; ++i) {
			sb.append("; ").append(emailIdsList.get(i));
	    }
		strSendToEmail = sb.toString();
	}	
	
	try {
		String strSSOUrl = dbUtilityBean.sSSOUrlByMailid(strRequistionCreatorEmail); 

		strMailMsg.append("<html><style>.formhead {font-family: Arial;font-size: 11px;font-style: normal;font-weight: normal;color: #000000;text-decoration: none;letter-spacing: normal;word-spacing: normal;border: 1px #333333 solid;background: #E2E4D6;}</style><body bgcolor=\"#d0d0d0\">" + "\n");	
		strMailMsg.append(" <table width=80% border=0 cellspacing=0 cellpadding=0 align=center><tr><td align=right><font face=Verdana, Arial, Helvetica, sans-serif size=2><b><font color=#FFFFFF>"+strCreationDate+"</font><font color=#FFFFFF></font><font color=#000000><br></font></b><font	color=#FFFFFF>"+dbLabelBean.getLabel("label.mail.forinternalcirculationonly",strsesLanguage)+"</font></font></td></tr><tr><td bgcolor=#000000></td></tr><tr><td bgcolor=#FFFFFF align=center>"+ "\n");
		strMailMsg.append("</td></tr><tr><td bgcolor=#000000></td></tr><tr><td bgcolor=#FFFFFF align=center><table width=100% border=0	cellspacing=0 cellpadding=15><tr><td align=center bgcolor=#aa1220><font face=Arial,	Helvetica, sans-serif size=5 color=#FFFFFF>"+dbLabelBean.getLabel("label.mail.starsmailnotification",strsesLanguage)+"</font></td></tr></table></td></tr><tr><td bgcolor=#000000></td></tr><tr>"+ "\n");
		strMailMsg.append("<td bgcolor=#B6DCDC></td></tr><tr><td bgcolor=#000000></td></tr><tr><td bgcolor=#000000></td></tr><tr><td bgcolor=#FFFFFF><table width=100% border=0 cellspacing=0 cellpadding=5>"+ "\n");						
		strMailMsg.append(" <tr><td align=center bgcolor=#aa1220><font face=Verdana, Arial, Helvetica, sans-serif size=2><b><font color=#FFFFFF><font size=3>"+dbLabelBean.getLabel(ReqTyp1,strsesLanguage)+" "+dbLabelBean.getLabel("label.mail.requisition",strsesLanguage)+"</font> </font></b></font></td></tr><tr><td bgcolor=#878787><font face=Verdana, Arial, Helvetica, sans-serif size=2><b>"+dbLabelBean.getLabel(ReqTyp1,strsesLanguage)+" "+dbLabelBean.getLabel("label.global.requisitionnumber",strsesLanguage)+" : "+strRequistionNumber.trim()+"</b></font></td></tr><tr><td><p><font color=#FFFFFF>.</font><font size=2 face=Verdana,	Arial, Helvetica, sans-serif><br>"+ "\n"); 				
		strMailMsg.append(dbLabelBean.getLabel("label.mail.dear",strsesLanguage)+" "+dbLabelBean.getLabel("label.mail.sirmadam",strsesLanguage)+",</font></p><p><font size=2 face=Verdana, Arial, Helvetica, sans-serif>"+dbLabelBean.getLabel("label.global.requisitionnumber",strsesLanguage)+" <b>["+strRequistionNumber.trim()+"]</b> for <b>"+strTravelerName+"</b> "+dbLabelBean.getLabel("label.mail.hasbeencancelledbyme",strsesLanguage)+"</p>"+ "\n"); 				
		strMailMsg.append("<br><br></font> <font size=2 face=Verdana, Arial, Helvetica, sans-serif><a href='strSSOUrl'>"+dbLabelBean.getLabel("label.mail.pleaseclickheretologintostars",strsesLanguage)+"</a>"+"\n"); 
 		strMailMsg.append("</b></font><br><p><font size=2 face=Verdana, Arial, Helvetica, sans-serif>"+dbLabelBean.getLabel("label.mail.bestregards",strsesLanguage)+"</font><br> <font size=2 face=Verdana, Arial, Helvetica, sans-serif>"+strRequistionCancelledBy.trim()+"<br></font></p></td></tr></table></td></tr><tr><td bgcolor=#878787 align=center><font face=Verdana, Arial, Helvetica, sans-serif size=2><b>"+dbLabelBean.getLabel("label.mail.mailreferencenumber",strsesLanguage)+"</b>"+strMailRefNumber+"/"+strCurrentYear+"</font></td></tr><tr><td bgcolor=#FFFFFF align=center><table width=100% border=0 cellspacing=0 cellpadding=12>"+ "\n"); 
 		strMailMsg.append("<tr><td align=center bgcolor=#aa1220><font size=2 face=Verdana,	Arial, Helvetica, sans-serif><b><font size=1>"+dbLabelBean.getLabel("label.mail.starsadministratorcanbecontacted",strsesLanguage)+"	: - </font></b><font size=1><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=#000000>"+ "\n"); 
 		strMailMsg.append("<a href=mailto:administrator.stars@mind-infotech.com><font size=1 color=#ffffff>administrator.stars@mind-infotech.com</font></a></font></font></font></td>  "+ "\n");
		strMailMsg.append("</tr><tr><td align=center bgcolor=#878787 height=55><b><font size=1 face=Verdana, Arial, Helvetica, sans-serif>"+dbLabelBean.getLabel("label.mail.disclaimer",strsesLanguage)+"	: "+dbLabelBean.getLabel("label.mail.thiscommunicationissystemgenererated",strsesLanguage)+" "+ "\n");  
		strMailMsg.append(dbLabelBean.getLabel("label.mail.pleasedonnotreplytothismail",strsesLanguage)+" <br>"+dbLabelBean.getLabel("label.mail.ifyouarenotthecorrectrecipient",strsesLanguage)+"</font></b></td></tr></table></td></tr><tr><td bgcolor=#000000> </td></tr>"+ "\n");    
		strMailMsg.append("<tr><td align=center><font size=2 face=Verdana, Arial, Helvetica, sans-serif><font size=1 color=#000000>&copy;"+dbLabelBean.getLabel("label.mail.mindallrightsreserved",strsesLanguage)+"</font></font></td>  </tr></table><p>&nbsp;</p></body></html>"+ "\n");
		
			try {
	    		//Procedure for inserting Mail Data
				cstmt_mail=con.prepareCall("{?=call PROC_REQUISITION_MAIL_ADD(?,?,?,?,?,?,?,?,?,?,?,?)}");
				cstmt_mail.registerOutParameter(1,java.sql.Types.INTEGER);
				cstmt_mail.setString(2, strRequistionId);
				cstmt_mail.setString(3, strRequistionNumber);
				cstmt_mail.setString(4, strSendToEmail);
				cstmt_mail.setString(5, strRequistionCreatorEmail);
				cstmt_mail.setString(6, strCCEmail);
				cstmt_mail.setString(7, strMailSubject);
				cstmt_mail.setString(8, strMailMsg.toString());
				cstmt_mail.setInt(9, intTries);
				cstmt_mail.setString(10, "NEW");
				cstmt_mail.setString(11, Suser_id);
				cstmt_mail.setString(12, "Personal Booking Cancellation");
				cstmt_mail.setString(13, "Edit Personal Booking Request");
				cstmt_mail.execute();
	    		cstmt_mail.close();
	    		
			} catch(Exception b) {
				System.out.print("ERROR in BookingReportCancellation.jsp--1------"+b);		
			}
		
		} catch(Exception e) {
			System.out.print("ERROR in BookingReportCancellation.jsp--2------"+e);		
		}
	response.sendRedirect("BookingStatusReport.jsp");
%>
