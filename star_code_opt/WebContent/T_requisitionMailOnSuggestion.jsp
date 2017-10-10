	<%
	/***************************************************
	 *The information contained here in is confidential and 
	 * proprietary to MIND and forms the part of the MIND 
	 *Author				:Shiv sharma 
	 *Date of Creation 		:13 -july 2009
	 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
	 *Project	  			:STAR
	 *Operating environment :Tomcat, sql server 2000 
	 *Description 			:This is the  jsp file  for sending mail of suggestion given by user to stars admin  
	 *Modification 			: 
	 *Reason of Modification: 
	 *Date of Modification  : 
	 *Revision History		:
	 *Modified By			: 
	 *Editor				:Editplus
	 Modified by vaibhav on jul 19 2010 to enable SSO in Mails

	 *Date of Modification	: 08 May 2012
	 *Modified By			: Manoj Chand
	 *Modification			: Correct the spelling of recipient in the mail body
	 
	 *Date of Modification	: 13 June 2012
	 *Modified By			: Manoj Chand
	 *Modification			: implementing multilingual functionality
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
	Statement stmt	,stmt1						=	null;	// Object for Statement
	ResultSet rs,rs1,rs2							=	null;	// Object for ResultSet
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
	String strReqVal							=	null;
	String	strUserNm							=	"";
	String	strTravelDate						=	"";
	String	strTravellerSex						=	"";
	String	strSex								=	"";
	String	strSql								=	"";
	String	strTravelFrom						=	"";
	String	strTravelTo							=	"";
	String	strReq								=	"";
	String	strHrNm								=	dbLabelBean.getLabel("label.mail.sirmadam",strsesLanguage);
	String	strHrMail							=	"";
	String	strSiteId							=	"";
	String strBillingSite						=	"";	
	String TType								=	"";// added by vijay on 11/04/2007
	
	String strTravelReturnDate					=	"";
	
	String 	strRequistionCreatedDatewithoutAMPM	=   "";
	
	
	String strCurrency			=   "";
	String strTotalAmount       =   "";
	String strBillingSite1       =   "";
	String strreasonFortravel   =   ""; 
	String strSqlSql			="";
	
	String   strGroupTravelFlag        ="";
	String    strGroupTravel              ="";
	ArrayList aList                                                 =   new ArrayList();
	//GET THE VALUES FROM THE PREVIOUS SCREEN
	
		String strUserid		=	request.getParameter("userid");
		String strComment	    =	request.getParameter("COMMENTS");
		String text				="";
		
		String ReqTyp			="";
		String strMailFromName  ="";
		String strMailFromEmail  ="";
	
	
	
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
	
	sSqlStr="SELECT FIRSTNAME + ' ' + LASTNAME AS username, EMAIL  FROM  M_USERINFO WHERE (USERID = "+strUserid+") AND (STATUS_ID = 10)";
		//stmt = con.createStatement(); 
		rs = dbConBean.executeQuery(sSqlStr);
		if(rs.next())
		{
			strMailFromName		=	rs.getString("username");//Mail Reference Number
			strMailFromEmail		=	rs.getString("EMAIL");//Mail Reference Number
			
			
		}
	rs.close();
	
					
		 	 strMailMsg = new StringBuffer();
		 	 strsesLanguage="en_US";
			
			strMailSubject=dbLabelBean.getLabel("label.mail.newsuggestionby",strsesLanguage)+" "+strMailFromName.trim()+"  ";//Mail Subject
			try
			{
				String strSSOUrl = dbUtilityBean.sSSOUrlByMailid("administrator.stars@mind-infotech.com"); //Added by vaibhav

				strMailMsg.append("<html><style>.formhead{ font-family:Arial;font-size:11px;font-style: normal;font-weight:normal;color:#000000;text-decoration:none;letter-spacing:normal;word-spacing:normal;border:1px #333333 solid;background:#E2E4D6;}</style><body bgcolor=\"#d0d0d0\">" + "\n");	
				strMailMsg.append(" <table width=80% border=0 cellspacing=0 cellpadding=0 align=center><tr><td align=right><font face=Verdana, Arial, Helvetica, sans-serif size=2><b><font color=#FFFFFF>"+strRequistionCreatedDatewithoutAMPM+"</font><font color=#FFFFFF></font><font color=#000000><br></font></b><font color=#FFFFFF>"+dbLabelBean.getLabel("label.mail.forinternalcirculationonly",strsesLanguage)+"</font></font></td></tr><tr><td bgcolor=#000000> </td></tr><tr><td bgcolor=#FFFFFF align=center>"+ "\n");
				strMailMsg.append("</td></tr><tr><td bgcolor=#000000> </td></tr><tr><td bgcolor=#FFFFFF align=center><table width=100% border=0 cellspacing=0 cellpadding=10><tr><td align=center bgcolor=#aa1220><font face=Arial, Helvetica, sans-serif size=5 color=#FFFFFF>"+dbLabelBean.getLabel("label.mail.starsmailnotification",strsesLanguage)+"</font></td></tr></table></td></tr><tr><td bgcolor=#000000> </td></tr><tr>"+ "\n");
				strMailMsg.append("<td bgcolor=#B6DCDC></td></tr><tr><td bgcolor=#000000> </td></tr><tr><td bgcolor=#000000> </td></tr><tr><td bgcolor=#FFFFFF><table width=100% border=0 cellspacing=0 cellpadding=5>"+ "\n");						
				strMailMsg.append("  <tr><td align=center bgcolor=#aa1220><font face=Verdana, Arial, Helvetica, sans-serif size=2><b><font color=#FFFFFF><font size=2> </font> </font></b></font></td></tr><tr><td bgcolor=#ffffff><font face=Verdana, Arial, Helvetica, sans-serif size=2><b>"); 				
				strMailMsg.append(dbLabelBean.getLabel("label.mail.dear",strsesLanguage)+" "+strHrNm+",</font></p></font>"); 
				
				strMailMsg.append("</b><font size=2 face=Verdana, Arial, Helvetica, sans-serif> "+dbLabelBean.getLabel("label.mail.anewsuggestionhasbeenpostedbyme",strsesLanguage)+"</font>");
				
				strMailMsg.append("<br><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif><U><FONT COLOR=BLUE>"+dbLabelBean.getLabel("label.mail.mysuggestion",strsesLanguage)+"</u><br></FONT>"+strComment.trim()+" "+ "\n"); 
				//Commented by vaibhav
				//strMailMsg.append("</font><br><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif><a href=\"http://stars.mindeservices.com\">Please click here to login to STARS </a> "+ "\n");  
				strMailMsg.append("</font><br><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif><a href='"+strSSOUrl+"'>"+dbLabelBean.getLabel("label.mail.pleaseclickheretologintostars",strsesLanguage)+" </a> "+ "\n");  
				strMailMsg.append("</b></form></font><br><p><font size=2 face=Verdana, Arial, Helvetica, sans-serif>"+dbLabelBean.getLabel("label.mail.bestregards",strsesLanguage)+"</font><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif>"+strMailFromName.trim()+"<br></font></p></td></tr></table></td></tr><tr><td bgcolor=#878787 align=center> <font face=Verdana, Arial, Helvetica, sans-serif size=1><b>"+dbLabelBean.getLabel("label.mail.mailreferencenumber",strsesLanguage)+" </b>"+strMailRefNumber+"/"+strCurrentYear+"</font></td></tr><tr><td bgcolor=#FFFFFF align=center>       <table width=100% border=0 cellspacing=0 cellpadding=5>"+ "\n"); 
				strMailMsg.append("<tr><td align=center bgcolor=#aa1220><font size=2 face=Verdana, Arial, Helvetica, sans-serif><b><font size=1>"+dbLabelBean.getLabel("label.mail.starsadministratorcanbecontacted",strsesLanguage)+" : - </font></b><font size=1><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=#000000>"+ "\n"); 
				strMailMsg.append("<a href=mailto:administrator.stars@mind-infotech.com><font size=1 color=#ffffff>administrator.stars@mind-infotech.com</font></a></font></font></font></td>  "+ "\n");  
				strMailMsg.append(" </tr><tr><td  align=center bgcolor=#878787 height=55> <b><font size=1 face=Verdana, Arial, Helvetica, sans-serif>"+dbLabelBean.getLabel("label.mail.disclaimer",strsesLanguage)+" </b>: "+dbLabelBean.getLabel("label.mail.thiscommunicationissystemgenererated",strsesLanguage)+" "+ "\n");  
				strMailMsg.append(dbLabelBean.getLabel("label.mail.pleasedonnotreplytothismail",strsesLanguage)+" <br>"+dbLabelBean.getLabel("label.mail.ifyouarenotthecorrectrecipientforthisnotification",strsesLanguage)+"</font></td></tr></table></td></tr><tr><td bgcolor=#000000></td></tr>"+ "\n");    
				strMailMsg.append("<tr><td align=center><font size=2 face=Verdana, Arial, Helvetica, sans-serif><font size=1 color=#000000>&copy;"+dbLabelBean.getLabel("label.mail.mindallrightsreserved",strsesLanguage)+"</font></font></td>  </tr></table><p>&nbsp;</p></body></html>"+ "\n");
	
				 
				 
						
				try
				{
				//Procedure for inserting Mail Data
					cstmt_mail=con.prepareCall("{?=call PROC_REQUISITION_MAIL_ADD(?,?,?,?,?,?,?,?,?,?,?,?)}");
					cstmt_mail.registerOutParameter(1,java.sql.Types.INTEGER);
					cstmt_mail.setString(2, "New Suggestions");
					cstmt_mail.setString(3, "New Suggestions");
					cstmt_mail.setString(4,"administrator.stars@mind-infotech.com");//To
					cstmt_mail.setString(5, strMailFromEmail);//From
					cstmt_mail.setString(6, "");//CC Mail Address is remove By   shar sharma 		on 03-Apr-08
					cstmt_mail.setString(7, strMailSubject);
					cstmt_mail.setString(8, strMailMsg.toString());
					cstmt_mail.setInt(9, intTries);
					cstmt_mail.setString(10, "NEW");
					cstmt_mail.setString(11, Suser_id);
					cstmt_mail.setString(12, "New Suggestions");
					cstmt_mail.setString(13, "New Suggestions"); 
					cstmt_mail.execute();
					cstmt_mail.close();
					
				}
				catch(Exception b) 
				{
					System.out.println("ERROR in T_requisitionMailOnSuggestion.jsp ----1----"+b);		
				}
			}
			catch(Exception e)
			{
			   System.out.println("ERROR in T_requisitionMailOnSuggestion.jsp----2------"+e);
			}
		
	 
	 
	
	
	//Close All Connection M_mySuggestionsList.jsp
	dbConBean.close();  
	dbConBean1.close(); 
	dbConBean2.close();  
%>
	
