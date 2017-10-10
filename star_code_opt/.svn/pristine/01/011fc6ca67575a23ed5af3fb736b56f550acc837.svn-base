<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:SACHIN GUPTA
 *Date of Creation 		:31 Jan 2007
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This is the  jsp file  for inserting the mail information in req_mailbox table when user registered in STARS
 *Modification 			: Remove the " . " (dot) from  end of Login ID and Password  showing to user -by shiv on 26-Sep-07
                                : Added  code  by shiv  on 23-Oct-07  "for genrating random password on reset  password    
								: remove CC address for reset password   by shiv on 28-Mar-08
  *Reason of Modification: 
 *Date of Modification  :16/03/2007
 *Revision History		:Password  reset date for mail 
 *Editor				:Editplus
 Modified by vaibhav on jul 19 2010 to enable SSO in Mails
 *Date of Modification	: 09 May 2012
 *Modified By			: Manoj Chand
 *Modification			: Correct the spelling of recipient in the mail body
 
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
<jsp:useBean id="dbutility" scope="page" class="src.connection.DbUtilityMethods" /><!-- Added by vaibhav -->

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
String userNewpassd				="";

String strUserId					= request.getParameter("userId");
 userNewpassd			= request.getParameter("pin");
String strCurrentDate				="";
String strLanguage	=	"";


	//FETCH THE LATEST MAIL ID FROM REQ_MAILBOX
	sSqlStr="SELECT ISNULL(MAX(MAIL_ID),'999')+1  FROM REQ_MAILBOX";

	
	rs = dbConBean.executeQuery(sSqlStr);
	if(rs.next())
	{
		strMailRefNumber								=	rs.getString(1);//Mail Reference Number
	
	}
	rs.close();


	// FETCH Registered user Details 

	sSqlStr="SELECT FIRSTNAME, LASTNAME, USERNAME, EMAIL, .DBO.DIVISIONNAME(DIV_ID) AS DIVISIONNAME, .DBO.SITENAME(SITE_ID) AS SITENAME, .DBO.DEPARTMENTNAME(DEPT_ID) AS DEPARTMENTNAME, .DBO.DESIGNATIONNAME(DESIG_ID) AS DESIGNATIONNAME, REPORT_TO, ISNULL(SECRET_QUESTION,'') AS SECRET_QUESTION , ISNULL(SECRET_ANSWER,'') AS SECRET_ANSWER, ISNULL(PASSPORT_NO,'') AS PASSPORT_NO, ISNULL(ECNR,'') AS ECNR, ISNULL(.DBO.CONVERTDATEDMY1(DATE_ISSUE),'') AS DATE_ISSUE,ISNULL(.DBO.CONVERTDATEDMY1(EXPIRY_DATE),'') AS EXPIRY_DATE, ISNULL(FF_NUMBER,'') AS FF_NUMBER,ISNULL(.DBO.CONVERTDATEDMY1(DOB),'') AS DOB, ISNULL(FF_NUMBER1,'') AS FF_NUMBER1,ISNULL(PLACE_ISSUE,'') AS PLACE_ISSUE, ISNULL(FF_NUMBER2,'') AS FF_NUMBER2,ISNULL(CONTACT_NUMBER,'') AS CONTACT_NUMBER, ISNULL(ADDRESS,'')AS ADDRESS,ISNULL(.DBO.CONVERTDATEDMY1(C_DATE),'') AS C_DATE,LANGUAGE_PREF FROM M_USERINFO WHERE USERID = '"+strUserId+"' AND STATUS_ID=10  AND APPLICATION_ID=1 ";

	//System.out.println("print...mail for  "+sSqlStr);

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
		strLanguage							=	rs.getString("LANGUAGE_PREF");
		if(strLanguage==null || strLanguage.equals("")){
			strLanguage="en_US";
		}
		strFullName							= strFirstName+" "+strLastName;
		Date currentDate				= new Date();
		SimpleDateFormat sdf			= new SimpleDateFormat("dd MMM yyyy H:mm");
		strCurrentDate					= (sdf.format(currentDate)).trim();
		//strCurrentYear					= strCurrentDate.substring(7,11);

						
        strCreationDate=strMailCreatedate; //added by shiv on 3/16/2007 
		strMailSubject=dbLabelBean.getLabel("label.mail.resetpasswordinformation",strLanguage);//Mail Subject

		//mail  messsage change by shiv on 26-Sep-07 "Removed   "." (dot) at the end of line of login ID and password  
		//mail  message change by shiv  on 23-Oct-07  "for genrating random password on reset  password    
 		try
		{
 			String strSSOUrl = dbutility.sSSOUrlByMailid(strUserEmail); //Added by vaibhav

			strMailMsg.append("<html><style>.formhead{ font-family:Arial;font-size:11px;font-style: normal;font-weight:normal;color:#000000;text-decoration:none;letter-spacing:normal;word-spacing:normal;border:1px #333333 solid;background:#E2E4D6;}</style><body bgcolor=\"#d0d0d0\">" + "\n");
			strMailMsg.append(" <table width=80% border=0 cellspacing=0 cellpadding=0 align=center><tr><td align=right><font face=Verdana, Arial, Helvetica, sans-serif size=2><b><font color=#FFFFFF>"+strCurrentDate+"</font><font color=#FFFFFF></font><font color=#000000><br></font></b><font color=#FFFFFF>"+dbLabelBean.getLabel("label.mail.forinternalcirculationonly",strLanguage)+"</font></font></td></tr><tr><td bgcolor=#FFFFFF align=center>"+ "\n");
			strMailMsg.append("</td></tr><tr><td bgcolor=#FFFFFF align=center><table width=100% border=0 cellspacing=0 cellpadding=15><tr><td align=center bgcolor=#aa1220><font face=Arial, Helvetica, sans-serif size=5 color=#FFFFFF>"+dbLabelBean.getLabel("label.mail.starsmailnotification",strLanguage)+"</font></td></tr></table></td></tr><tr>"+ "\n");
			strMailMsg.append("<td bgcolor=#B6DCDC></td></tr><tr><td bgcolor=#FFFFFF><table width=100% border=0 cellspacing=0 cellpadding=5>"+ "\n");
			strMailMsg.append("  <tr><td align=center bgcolor=#aa1220><font face=Verdana, Arial, Helvetica, sans-serif size=2><b><font color=#FFFFFF><font size=3>"+dbLabelBean.getLabel("label.mail.resetpasswordinformations",strLanguage)+"</font> </font></b></font></td></tr><tr><td bgcolor=#878787><font face=Verdana, Arial, Helvetica, sans-serif size=2><b></b></font></td></tr><tr><td><p><font color=#FFFFFF>.</font><font size=2 face=Verdana, Arial, Helvetica, sans-serif><br>"+ "\n"); 
			strMailMsg.append(" "+dbLabelBean.getLabel("label.mail.dear",strLanguage)+" "+strFullName+",</font></p><p><font size=2 face=Verdana, Arial, Helvetica, sans-serif>"+dbLabelBean.getLabel("label.mail.yourpasswordhasbeenreset",strLanguage)+".<br>"+dbLabelBean.getLabel("label.mail.yourloginidis",strLanguage)+" <b>"+strUserName+"</b> <br> "+dbLabelBean.getLabel("label.mail.yournewpasswordis",strLanguage)+" <b>"+userNewpassd+"</b> \n<br><br>");
			//Commented by vaibhav
			//strMailMsg.append("<A HREF=http://stars.mindeservices.com>Please click here to login to STARS</A>"+ "\n"); 
			strMailMsg.append("<a href='"+strSSOUrl+"'>"+dbLabelBean.getLabel("label.mail.pleaseclickheretologintostars",strLanguage)+" </a>"+ "\n"); 
			strMailMsg.append("   </b></form></font><br><p><font size=2 face=Verdana, Arial, Helvetica, sans-serif>"+dbLabelBean.getLabel("label.mail.bestregards",strLanguage)+"</font><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif>"+dbLabelBean.getLabel("label.mail.starsadmin",strLanguage)+"<br></font></p></td></tr></table></td></tr><tr><td bgcolor=#878787 align=center> <font face=Verdana, Arial, Helvetica, sans-serif size=2><b>"+dbLabelBean.getLabel("label.mail.mailreferencenumber",strLanguage)+" </b>"+strMailRefNumber+"/"+strCurrentYear+"</font></td></tr><tr><td bgcolor=#FFFFFF align=center>       <table width=100% border=0 cellspacing=0 cellpadding=12>"+ "\n"); 
			strMailMsg.append("<tr><td align=center bgcolor=#aa1220><font size=2 face=Verdana, Arial, Helvetica, sans-serif><b><font size=1>"+dbLabelBean.getLabel("label.mail.starsadministratorcanbecontacted",strLanguage)+" : - </font></b><font size=1><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=#000000>"+ "\n"); 
			strMailMsg.append("<a href=mailto:administrator.stars@mind-infotech.com><font size=1 color=#ffffff>administrator.stars@mind-infotech.com</font></a></font></font></font></td>  "+ "\n");  
			strMailMsg.append(" </tr><tr><td  align=center bgcolor=#878787 height=55> <b><font size=1 face=Verdana, Arial, Helvetica, sans-serif>"+dbLabelBean.getLabel("label.mail.disclaimer",strLanguage)+" : "+dbLabelBean.getLabel("label.mail.thiscommunicationissystemgenererated",strLanguage)+" "+ "\n");  
			strMailMsg.append(dbLabelBean.getLabel("label.mail.pleasedonnotreplytothismail",strLanguage)+" <br>"+dbLabelBean.getLabel("label.mail.ifyouarenotthecorrectrecipient",strLanguage)+"</font></b></td></tr></table></td></tr>"+ "\n");    
			strMailMsg.append("<tr><td align=center><font size=2 face=Verdana, Arial, Helvetica, sans-serif><font size=1 color=#000000>&copy;"+dbLabelBean.getLabel("label.mail.mindallrightsreserved",strLanguage)+"</font></font></td>  </tr></table><p>&nbsp;</p></body></html>"+ "\n");

			 //System.out.println("<><><><>"+strMailMsg);
			try
			{
				con   =  dbConBean1.getConnection();  //Get Connetion
				//Procedure for inserting Mail Data
				cstmt_mail=con.prepareCall("{?=call PROC_REQUISITION_MAIL_ADD(?,?,?,?,?,?,?,?,?,?,?,?)}");
				cstmt_mail.registerOutParameter(1,java.sql.Types.INTEGER);
				cstmt_mail.setString(2, "Reset Password");		//Req_id
				cstmt_mail.setString(3, "Reset Password");		//REQ_Number
				cstmt_mail.setString(4, strUserEmail);			//To
				cstmt_mail.setString(5, "administrator.stars@mind-infotech.com");					//From
				cstmt_mail.setString(6, "");					//CC   --remove by shiv on 28-Mar-08 
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
				System.out.println("ERROR in T_MailOnResetPassword.jsp---1--------"+b);		
			}
		}
		catch(Exception e)
		{
			System.out.println("ERROR in T_MailOnResetPassword.jsp---2--------"+e);		
		}
	}
	rs.close();


dbConBean.close();
dbConBean1.close();
%>

