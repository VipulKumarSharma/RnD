<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author								:Shiv Sharma 
 *Date of Creation 				:31 Jan 2007
 *Copyright Notice 				:Copyright(C)2000 MIND.All rights reserved
 *Project	  							:STAR
 *Operating environment		:Tomcat, sql server 2000 
 *Description 						: This is the  jsp file  for inserting the mail information in req_mailbox table when any approver will deleted from default                                             workflow in STARS
 *Reason of Modification		:Correct the spelling. on 20 Apr 2009 by shiv sharma   
 *Date of Modification			:
 *Revision History				:
 *Editor								:Editplus
 
 *Modified By					: Manoj Chand
 *Date of Modification			: 16 May 2012
 *Modification					: Correct the spelling of recipient
 
 *Date of Modification	: 14 June 2012
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
<%--<%@ include  file="systemStyle.jsp" %>--%>

<!--Create the DbConnectionBean object for createConnection-->
<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbConBean1" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<%
request.setCharacterEncoding("UTF-8");
// Variables declared and initialized
Connection con						=	null;		    // Object for connection
ResultSet rs,rs1					=	null;			// Object for ResultSet
CallableStatement cstmt_mail		=	null;			// Object for Callable Statement

String	sSqlStr						=	""; // For sql Statements
String strMailSubject				=	null;
String strMailRefNumber				=	null;
StringBuffer strMailMsg				=	new StringBuffer();
int		intTries					=	0;


//GET THE VALUES FROM THE PREVIOUS SCREEN

String strFirstName					= "";
String strLastName					= "";
String strUserName					= "";
String strUserEmail					= "";
String strDivisionName				= "";
String strSiteName					= "";
String strDeptName					= "";
String strDesigName					= "";
String strReportTo					= "";
String strCreationDate              = "";
String strDOB                       = ""; 

String strFullName                  = "";

String strUserId						           = request.getParameter("userId");
String userSiteId						           = request.getParameter("userSiteId");

//Added the code & Query for finding the site id  and email  of person who has deleted the approver -- added by shiv on 26-Sep-07
String strCurrentDate				="";
String strMailofPersonDeletedby="";
String strSiteofPersonDeletedby="";

String strUserIdTobeDelete	           = request.getParameter("userIdToDelete");
String userApproverAtSite                	= request.getParameter("userApproverAtSite").trim();
String userAproverofTravelType     	= request.getParameter("userAproverofTravelType").trim();
String strTravelType     	="";

		if(userAproverofTravelType.equalsIgnoreCase("i")) 
			            {			 				
							strTravelType="International" ;	
						}
		else			{			
			                 strTravelType="Domestic"; 			            
						}
			sSqlStr="SELECT .DBO.SITENAME(SITE_ID) AS SITENAME,EMAIL FROM M_userinfo where userid="+Suser_id;
			rs = dbConBean.executeQuery(sSqlStr);
			if(rs.next())
	            {    strSiteofPersonDeletedby =	rs.getString(1);
		             strMailofPersonDeletedby=	rs.getString(2); //Mail Reference Number
	           }
	        rs.close();


	//FETCH THE LATEST MAIL ID FROM REQ_MAILBOX
	sSqlStr="SELECT ISNULL(MAX(MAIL_ID),'999')+1  FROM REQ_MAILBOX";
	rs = dbConBean.executeQuery(sSqlStr);
	if(rs.next())
	{
		strMailRefNumber								=	rs.getString(1);//Mail Reference Number
	}
	rs.close();
    

	// FETCH Registered user Details 
	sSqlStr="SELECT FIRSTNAME, LASTNAME, USERNAME, EMAIL, .DBO.DIVISIONNAME(DIV_ID) AS DIVISIONNAME, .DBO.SITENAME(SITE_ID) AS SITENAME, .DBO.DEPARTMENTNAME(DEPT_ID) AS DEPARTMENTNAME, .DBO.DESIGNATIONNAME(DESIG_ID) AS DESIGNATIONNAME, REPORT_TO, ISNULL(SECRET_QUESTION,'') AS SECRET_QUESTION , ISNULL(SECRET_ANSWER,'') AS SECRET_ANSWER, ISNULL(PASSPORT_NO,'') AS PASSPORT_NO, ISNULL(ECNR,'') AS ECNR, ISNULL(.DBO.CONVERTDATEDMY1(DATE_ISSUE),'') AS DATE_ISSUE,ISNULL(.DBO.CONVERTDATEDMY1(EXPIRY_DATE),'') AS EXPIRY_DATE, ISNULL(FF_NUMBER,'') AS FF_NUMBER,ISNULL(.DBO.CONVERTDATEDMY1(DOB),'') AS DOB, ISNULL(FF_NUMBER1,'') AS FF_NUMBER1,ISNULL(PLACE_ISSUE,'') AS PLACE_ISSUE, ISNULL(FF_NUMBER2,'') AS FF_NUMBER2,ISNULL(CONTACT_NUMBER,'') AS CONTACT_NUMBER, ISNULL(ADDRESS,'')AS ADDRESS,ISNULL(.DBO.CONVERTDATEDMY1(C_DATE),'') AS C_DATE FROM M_USERINFO WHERE USERID = '"+strUserIdTobeDelete+"' AND STATUS_ID=10  AND APPLICATION_ID=1 ";

//	System.out.println("print...mail for  "+sSqlStr);

	rs = dbConBean.executeQuery(sSqlStr);
	if(rs.next())
	{
		strFirstName						=	rs.getString("FIRSTNAME");// Number
		strLastName			 				=	rs.getString("LASTNAME");///Receipent Name
		strUserName				 			=	rs.getString("USERNAME");//Receipent Email
		strUserEmail						=	rs.getString("EMAIL");//CREATOR NAME
		strDivisionName			 			=	rs.getString("DIVISIONNAME");//CREATOR EMAIL
		strSiteName			 				=	rs.getString("SITENAME");//Req Created Date & time
		strDeptName							=	rs.getString("DEPARTMENTNAME");//TRAVELLER NAME
		strDesigName						=	rs.getString("DESIGNATIONNAME"); // TRAVEL DATE
		strReportTo							=	rs.getString("REPORT_TO"); // TRAVELLER SEX
		strDOB								=	rs.getString("DOB"); //
		strCreationDate                     =	rs.getString("C_DATE"); // TRAVELLER SEX
		 
		strFullName							= strFirstName+" "+strLastName;
		Date currentDate				= new Date();
		SimpleDateFormat sdf			= new SimpleDateFormat("dd MMM yyyy H:mm");
		strCurrentDate					= (sdf.format(currentDate)).trim();
		//strCurrentYear					= strCurrentDate.substring(7,11);

						
        strCreationDate=strMailCreatedate; //added by shiv on 3/16/2007 
		strMailSubject=dbLabelBean.getLabel("label.mail.deleteapproverinformation",strsesLanguage);//Mail Subject

		try 
		{
			
			strMailMsg.append("<html><style>.formhead{ font-family:Arial;font-size:11px;font-style: normal;font-weight:normal;color:#000000;text-decoration:none;letter-spacing:normal;word-spacing:normal;border:1px #333333 solid;background:#E2E4D6;}</style><body bgcolor=\"#d0d0d0\">" + "\n");
			strMailMsg.append(" <table width=80% border=0 cellspacing=0 cellpadding=0 align=center><tr><td align=right><font face=Verdana, Arial, Helvetica, sans-serif size=2><b><font color=#FFFFFF>"+strCurrentDate+"</font><font color=#FFFFFF></font><font color=#000000><br></font></b><font color=#FFFFFF>"+dbLabelBean.getLabel("label.mail.forinternalcirculationonly",strsesLanguage)+"</font></font></td></tr><tr><td bgcolor=#FFFFFF align=center>"+ "\n");
			strMailMsg.append("</td></tr><tr><td bgcolor=#FFFFFF align=center><table width=100% border=0 cellspacing=0 cellpadding=15><tr><td align=center bgcolor=#aa1220><font face=Arial, Helvetica, sans-serif size=5 color=#FFFFFF>"+dbLabelBean.getLabel("label.mail.deleteapprovernotification",strsesLanguage)+"</font></td></tr></table></td></tr><tr>"+ "\n");
			strMailMsg.append("<td bgcolor=#B6DCDC></td></tr><tr><td bgcolor=#FFFFFF><table width=100% border=0 cellspacing=0 cellpadding=5>"+ "\n");
			strMailMsg.append("  <tr><td align=center bgcolor=#aa1220><font face=Verdana, Arial, Helvetica, sans-serif size=2><b><font color=#FFFFFF><font size=3>"+dbLabelBean.getLabel("label.mail.deleteapproverinfo",strsesLanguage)+"</font> </font></b></font></td></tr><tr><td bgcolor=#878787><font face=Verdana, Arial, Helvetica, sans-serif size=2><b></b></font></td></tr><tr><td><p><font color=#FFFFFF>.</font><font size=2 face=Verdana, Arial, Helvetica, sans-serif><br>"+ "\n"); 
			strMailMsg.append(" "+dbLabelBean.getLabel("label.mail.dearsir",strsesLanguage)+"  </font></p><p><font size=2 face=Verdana, Arial, Helvetica, sans-serif> <B>"+strFullName+" </B> "+dbLabelBean.getLabel("label.mail.hasbeendeletedfromthedefaultworkflow",strsesLanguage)+" <b>"+userApproverAtSite+" </b></br> "+dbLabelBean.getLabel("label.mail.for",strsesLanguage)+" <b>" +strTravelType  +" "+dbLabelBean.getLabel("label.mail.travel",strsesLanguage)+" </b>.  \n<br><br>");
			strMailMsg.append(dbLabelBean.getLabel("label.mail.approverdeletedby",strsesLanguage)+" <b>"+sUserFirstName+" "+ sUserLastName+ " </b>of <b>  "+strSiteofPersonDeletedby+"."); 
			strMailMsg.append(" </b></form></font><p><font size=2 face=Verdana, Arial, Helvetica, sans-serif></font><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif>"+dbLabelBean.getLabel("label.mail.bestregards",strsesLanguage)+" <br>"+sUserFirstName +" "+ sUserLastName+ "</font></p></td></tr></table></td></tr><tr><td bgcolor=#878787 align=center> <font face=Verdana, Arial, Helvetica, sans-serif size=2><b>"+dbLabelBean.getLabel("label.mail.mailreferencenumber",strsesLanguage)+" </b>"+strMailRefNumber+"/"+strCurrentYear+"</font></td></tr><tr><td bgcolor=#FFFFFF align=center>       <table width=100% border=0 cellspacing=0 cellpadding=12>"+ "\n"); 
			strMailMsg.append("<tr><td align=center bgcolor=#aa1220><font size=2 face=Verdana, Arial, Helvetica, sans-serif><b><font size=1>"+dbLabelBean.getLabel("label.mail.starsadministratorcanbecontacted",strsesLanguage)+" : - </font></b><font size=1><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=#000000>"+ "\n"); 
			strMailMsg.append("<a href=mailto:administrator.stars@mind-infotech.com><font size=1 color=#ffffff>administrator.stars@mind-infotech.com</font></a></font></font></font></td>  "+ "\n");  
			strMailMsg.append(" </tr><tr><td  align=center bgcolor=#878787 height=55> <b><font size=1 face=Verdana, Arial, Helvetica, sans-serif>"+dbLabelBean.getLabel("label.mail.disclaimer",strsesLanguage)+" : "+dbLabelBean.getLabel("label.mail.thiscommunicationissystemgenererated",strsesLanguage)+" "+ "\n");  
			strMailMsg.append(dbLabelBean.getLabel("label.mail.pleasedonnotreplytothismail",strsesLanguage)+" <br>"+dbLabelBean.getLabel("label.mail.ifyouarenotthecorrectrecipient",strsesLanguage)+"</font></b></td></tr></table></td></tr>"+ "\n");    
			strMailMsg.append("<tr><td align=center><font size=2 face=Verdana, Arial, Helvetica, sans-serif><font size=1 color=#000000>&copy;"+dbLabelBean.getLabel("label.mail.mindallrightsreserved",strsesLanguage)+"</font></font></td>  </tr></table><p>&nbsp;</p></body></html>"+ "\n");

			// System.out.println("<><>1234<><>"+strMailMsg);
			try
			{
				con   =  dbConBean1.getConnection();  //Get Connetion
				//Procedure for inserting Mail Data
				cstmt_mail=con.prepareCall("{?=call PROC_REQUISITION_MAIL_ADD(?,?,?,?,?,?,?,?,?,?,?,?)}");
				cstmt_mail.registerOutParameter(1,java.sql.Types.INTEGER);
				cstmt_mail.setString(2, "Delete Approver");		//Req_id
				cstmt_mail.setString(3, "Delete Approver");		//REQ_Number
			 	cstmt_mail.setString(4, "administrator.stars@mind-infotech.com");			//To
				cstmt_mail.setString(5, strMailofPersonDeletedby);					//From    //changed by shiv on 26-Sep-07
				cstmt_mail.setString(6, "administrator.stars@mind-infotech.com");		//CC //changed by shiv on 26-Sep-07
				cstmt_mail.setString(7, strMailSubject);
				cstmt_mail.setString(8, strMailMsg.toString());
				cstmt_mail.setInt(9, intTries);
				cstmt_mail.setString(10, "NEW");
				cstmt_mail.setString(11, Suser_id);                      //Mail Creator Id
				cstmt_mail.setString(12, "New");
				cstmt_mail.setString(13, "User Submitting the Req");
				cstmt_mail.execute();
				cstmt_mail.close();
				//System.out.println(">>>>>>>>> strMailCreatedate  3/20/2007     "+strMailMsg.toString());	
			}
			catch(Exception b)
			{
				System.out.println("ERROR in T_MailOnChangeApprover.jsp---1--------"+b);		
			}
		}
		catch(Exception e)
		{
			System.out.println("ERROR in T_MailOnChangeApprover.jsp---2--------"+e);		
		}
	}
	rs.close();


dbConBean.close();
dbConBean1.close();
%>

