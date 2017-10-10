<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:Shiv Sharma 
 *Date of Creation 		:22 Sept 2008
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This is the  jsp file  for inserting the mail information in req_mailbox table when user handover his 
 						 requstion  user to some other user in STARS.
 *Modification 			: 
 *Reason of Modification: 
 *Date of Modification  :
 *Revision History		:
 *Editor				:Eclipse
 *Modified by vaibhav on jul 19 2010 to enable SSO in Mails
 
 *Modified By			: Manoj Chand 
 *Date of Modification	: 18-May-2011
 *Modification			: Modify the mail body for handover and modify the parameter for procedure.

 *Modified By			: Manoj Chand 
 *Date of Modification	: 14-Mar-2012
 *Modification			: Change in sql query to get requisition number for future handover requests.
 
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
Connection con								=	null;		    // Object for connection
ResultSet rs,rs1							=	null;			// Object for ResultSet
CallableStatement cstmt_mail				=	null;			// Object for Callable Statement

String			sSqlStr						=	""; // For sql Statements
String 			strMailSubject				=	null;
String 			strMailRefNumber			=	null;
StringBuffer 	strMailMsg					=	new StringBuffer();
int				intTries					=	0;

String  strSite=(String)session.getAttribute("siteforOutFOrmark");		

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
String userNewpassd					="";

String strUserId					= request.getParameter("DelegateToUserId");		// delegate to user id 
String strDelegateFrom				= request.getParameter("DelegateFromUserId"); 	// delegate From user id
String strTravelId					= request.getParameter("TravelId"); 			// delegate From user travel_id
String strTraveltype				= request.getParameter("Traveltype");   
//System.out.println("strTravelId---->"+strTravelId);
String strReason					=request.getParameter("Reason");
// delegate From user travel_type 
String strCCmail					="";
String stFromMAIL					="";
String strCCMail_ID					="";
String strFromMail_id				=""; 
String strFullNameTo				="";
String strFromName					="";	
String strReq_detail				="";
String strRegardsName				="";	
String strCurrentDate				="";
String strLAUHuserD 				="";
String strLAUHRole 					="";
String strLanguage					="";

	/*sSqlStr="SELECT DISTINCT TD.TRAVEL_REQ_NO FROM T_APPROVERS TA, T_TRAVEL_STATUS TS,T_TRAVEL_DETAIL_INT TD WHERE TA.TRAVEL_ID=TS.TRAVEL_ID AND TD.TRAVEL_ID=TS.TRAVEL_ID  AND TS.TRAVEL_STATUS_ID=2 AND TS.TRAVEL_TYPE='I' AND TA.APPROVE_STATUS=0 AND TA.APPROVER_ID="+strUserId+" AND TA.TRAVEL_TYPE='I' AND  ORDER_ID=(SELECT MIN(ORDER_ID)FROM T_APPROVERS WHERE TRAVEL_ID=TS.TRAVEL_ID AND TRAVEL_TYPE='I' AND (TRAVEL_ID in ("+strTravelId+")) AND APPROVE_STATUS=0 AND STATUS_ID=10) union "+
			" SELECT DISTINCT TD.TRAVEL_REQ_NO FROM T_APPROVERS TA, T_TRAVEL_STATUS TS,T_TRAVEL_DETAIL_DOM TD WHERE TA.TRAVEL_ID=TS.TRAVEL_ID AND	TD.TRAVEL_ID=TS.TRAVEL_ID  AND TS.TRAVEL_STATUS_ID=2 AND TS.TRAVEL_TYPE='D' AND TA.APPROVE_STATUS=0	AND TA.APPROVER_ID="+strUserId+"  AND TA.TRAVEL_TYPE='D' AND  ORDER_ID=(SELECT MIN(ORDER_ID)FROM T_APPROVERS  WHERE TRAVEL_ID=TS.TRAVEL_ID AND TRAVEL_TYPE='D' AND (TRAVEL_ID in ("+strTravelId+")) AND APPROVE_STATUS=0 AND STATUS_ID=10)";*/
//Query changed by manoj chand on 14 march 2012 to show requisition number of future handover request in email.		
	sSqlStr=" SELECT DISTINCT TD.TRAVEL_REQ_NO FROM T_APPROVERS TA, T_TRAVEL_STATUS TS,T_TRAVEL_DETAIL_INT TD WHERE TA.TRAVEL_ID=TS.TRAVEL_ID AND TD.TRAVEL_ID=TS.TRAVEL_ID  AND TS.TRAVEL_STATUS_ID=2 AND TS.TRAVEL_TYPE='I' AND TA.APPROVE_STATUS=0 AND TA.APPROVER_ID="+strUserId+" AND TA.TRAVEL_TYPE='I' AND  ORDER_ID IN (SELECT CASE WHEN ORIGINAL_APPROVER=0 THEN MIN(ORDER_ID) ELSE ORDER_ID END FROM T_APPROVERS WHERE TRAVEL_ID=TS.TRAVEL_ID AND TRAVEL_TYPE='I' AND (TRAVEL_ID in ("+strTravelId+")) AND APPROVE_STATUS=0 AND STATUS_ID=10 GROUP BY ORIGINAL_APPROVER,ORDER_ID) union "+
			" SELECT DISTINCT TD.TRAVEL_REQ_NO FROM T_APPROVERS TA, T_TRAVEL_STATUS TS,T_TRAVEL_DETAIL_DOM TD WHERE TA.TRAVEL_ID=TS.TRAVEL_ID AND	TD.TRAVEL_ID=TS.TRAVEL_ID  AND TS.TRAVEL_STATUS_ID=2 AND TS.TRAVEL_TYPE='D' AND TA.APPROVE_STATUS=0	AND TA.APPROVER_ID="+strUserId+"  AND TA.TRAVEL_TYPE='D' AND  ORDER_ID IN (SELECT CASE WHEN ORIGINAL_APPROVER=0 THEN MIN(ORDER_ID) ELSE ORDER_ID END FROM T_APPROVERS  WHERE TRAVEL_ID=TS.TRAVEL_ID AND TRAVEL_TYPE='D' AND (TRAVEL_ID in ("+strTravelId+")) AND APPROVE_STATUS=0 AND STATUS_ID=10 GROUP BY ORIGINAL_APPROVER,ORDER_ID)";
				
	
//System.out.println("sSqlStr---->"+sSqlStr);
  
	rs = dbConBean.executeQuery(sSqlStr);
	while(rs.next()){
		    if (strReq_detail.equals("")){  
			strReq_detail=strReq_detail+""+rs.getString(1)+""; 
		    }else{
	    		strReq_detail=strReq_detail+", "+rs.getString(1)+""; 
		    }
		}
	// Mail setting for hand Over request==================
		
		
		//System.out.println("SuserRole==============="+SuserRole);
	
		sSqlStr=" select USERID, SITE_ID, ROLE_ID from ( SELECT USERID, SITE_ID, 'UH-LA'AS ROLE_ID " +
		" FROM  M_USERROLE WHERE (STATUS_ID = 10)  union SELECT USERID, SITE_ID, ROLE_ID FROM  M_USERINFO " +
		" WHERE (ROLE_ID = 'ad')and (STATUS_ID = 10) union SELECT USERID, SITE_ID, 'UH-LA'AS ROLE_ID FROM " +   
		" USER_MULTIPLE_ACCESS where  (STATUS_ID = 10) and unit_head =1 )uhlaad " +
		" where userid ="+Suser_id+" and (site_id = "+strSite+" OR ROLE_ID = 'ad')";

			rs = dbConBean.executeQuery(sSqlStr);

			while(rs.next())
			{
				strLAUHuserD =rs.getString("USERID");
				strLAUHRole =rs.getString("ROLE_ID");
				}

			//System.out.println("strLAUHuserD===="+strLAUHuserD);

			//System.out.println("strLAUHRole===="+strLAUHRole);

			if (strLAUHRole.equals("AD") || strLAUHRole.equals("UH-LA")) { // if  loged user is in (AD,UH,or LA) then following block will be executed  
				  if(strLAUHRole.equals("AD"))   	{
			    		   //System.out.println("case of ad>>>>>>>>"+strLAUHRole);  
			    		   strFromMail_id	="administrator.stars@mind-infotech.com";
							strRegardsName	="STARS Admin";
							strCCmail		=strDelegateFrom;
							sSqlStr			="SELECT EMAIL from m_userinfo where userid="+strCCmail+"and status_id=10";
							rs = dbConBean.executeQuery(sSqlStr);
							if(rs.next())
								{
								strCCMail_ID 	=	rs.getString(1);//Mail Reference Number
								}
							rs.close();
       	  	}
   	  	 else{  //System.out.println("case of UH or LA >>>>>>>"+strLAUHRole);		 
   	  		 // case of UH and LA 
   	  			 //System.out.println(Suser_id);
   	  	 		//System.out.println(strDelegateFrom);
   	  		 
   	  		 
    			if(Suser_id.equals(strDelegateFrom)) { 			 //if LA or UH  marking  OOO him self  
    				//System.out.println("case of UH or LA when he marks for own>>>>>>>"+strLAUHRole);	 
	    				stFromMAIL=Suser_id;
	    				strCCmail="";
	    				sSqlStr="Select dbo.user_name("+stFromMAIL+"),dbo.useremail("+stFromMAIL+")";
		    			rs = dbConBean.executeQuery(sSqlStr);
		    			if(rs.next()){
		    				strRegardsName	=   rs.getString(1);
    						strFromMail_id	=	rs.getString(2);
		    		    }
		    			strCCMail_ID="";
    		      }
    			else{  										// case when LA & UH marking OOO to some one else  							   
				//System.out.println("case of UH or LA when he marks for some on else>>>>>>>"+strLAUHRole);	 
    					stFromMAIL=Suser_id;
    					strCCmail=strDelegateFrom;
    			    	sSqlStr="Select dbo.user_name("+stFromMAIL+"),dbo.useremail("+strCCmail+"),dbo.useremail("+stFromMAIL+")";
    			    	rs = dbConBean.executeQuery(sSqlStr);
    					if(rs.next()){
    						strRegardsName	=   rs.getString(1);
    						strCCMail_ID 	=	rs.getString(2);
    						strFromMail_id	=	rs.getString(3);
    					}
    			}
    	}
    	    	
		}
		else{  // if  loged user is OR then following block will be executed  
		
		
		 //System.out.println("case of Orignator");
			stFromMAIL=Suser_id;
			strCCmail="";
			sSqlStr="SELECT FIRSTNAME, LASTNAME,EMAIL from m_userinfo where userid="+stFromMAIL+"and status_id=10";
			rs = dbConBean.executeQuery(sSqlStr);
			if(rs.next())
			{
				strRegardsName=rs.getString("FIRSTNAME")+" "+rs.getString("LASTNAME");
				strFromMail_id 	=	rs.getString("EMAIL");//Mail Reference Number
			}
			rs.close();
		}

/*if(SuserRole.equals("AD") || SuserRoleOther.equals("LA") || strLAUHflage.equals("1"))
{
strFromMail_id=stFromMAIL;
}
*/

//System.out.println("****************************************************");

//System.out.println("strFromMail_id======"+strFromMail_id);

//System.out.println("strCCMail_ID========"+strCCMail_ID);

////System.out.println("strUserId=============="+strUserId);


	//FETCH THE LATEST MAIL ID FROM REQ_MAILBOX
	sSqlStr="SELECT ISNULL(MAX(MAIL_ID),'999')+1  FROM REQ_MAILBOX";

	
	rs = dbConBean.executeQuery(sSqlStr);
	if(rs.next())
	{
		strMailRefNumber	=	rs.getString(1);//Mail Reference Number
	
	}
	rs.close();


	// FETCH Registered user Details 
	sSqlStr="SELECT FIRSTNAME, LASTNAME, USERNAME, EMAIL, .DBO.DIVISIONNAME(DIV_ID) AS DIVISIONNAME, .DBO.SITENAME(SITE_ID) AS SITENAME, .DBO.DEPARTMENTNAME(DEPT_ID) AS DEPARTMENTNAME, .DBO.DESIGNATIONNAME(DESIG_ID) AS DESIGNATIONNAME, REPORT_TO, ISNULL(SECRET_QUESTION,'') AS SECRET_QUESTION , ISNULL(SECRET_ANSWER,'') AS SECRET_ANSWER, ISNULL(PASSPORT_NO,'') AS PASSPORT_NO, ISNULL(ECNR,'') AS ECNR, ISNULL(.DBO.CONVERTDATEDMY1(DATE_ISSUE),'') AS DATE_ISSUE,ISNULL(.DBO.CONVERTDATEDMY1(EXPIRY_DATE),'') AS EXPIRY_DATE, ISNULL(FF_NUMBER,'') AS FF_NUMBER,ISNULL(.DBO.CONVERTDATEDMY1(DOB),'') AS DOB, ISNULL(FF_NUMBER1,'') AS FF_NUMBER1,ISNULL(PLACE_ISSUE,'') AS PLACE_ISSUE, ISNULL(FF_NUMBER2,'') AS FF_NUMBER2,ISNULL(CONTACT_NUMBER,'') AS CONTACT_NUMBER, ISNULL(ADDRESS,'')AS ADDRESS,ISNULL(.DBO.CONVERTDATEDMY1(C_DATE),'') AS C_DATE,LANGUAGE_PREF FROM M_USERINFO WHERE USERID = '"+strUserId+"' AND STATUS_ID=10  AND APPLICATION_ID=1 ";

	rs = dbConBean.executeQuery(sSqlStr);
	if(rs.next())
	{
		strFirstName						=	rs.getString("FIRSTNAME");		// Number
		strLastName			 				=	rs.getString("LASTNAME");		//Receipent Name
		strUserName				 			=	rs.getString("USERNAME");		//Receipent Email
		strUserEmail						=	rs.getString("EMAIL");			//CREATOR NAME
		strDivisionName			 			=	rs.getString("DIVISIONNAME");	//CREATOR EMAIL
		strSiteName			 				=	rs.getString("SITENAME");		//Req Created Date & time
		strDeptName							=	rs.getString("DEPARTMENTNAME");	//TRAVELLER NAME
		strDesigName						=	rs.getString("DESIGNATIONNAME");// TRAVEL DATE
		strReportTo							=	rs.getString("REPORT_TO"); 		// TRAVELLER SEX
		strDOB								=	rs.getString("DOB"); 			//DOB
		strCreationDate                     =	rs.getString("C_DATE"); 		// TRAVELLER SEX
		strLanguage							=	rs.getString("LANGUAGE_PREF");
		if(strLanguage==null || strLanguage.equals("")){
			strLanguage="en_US";
		}
		//System.out.println("strLanguage--->"+strLanguage);
		
		strFullName							= strFirstName+" "+strLastName;
		
		Date currentDate					= new Date();
		SimpleDateFormat sdf				= new SimpleDateFormat("dd MMM yyyy H:mm");
		strCurrentDate						= (sdf.format(currentDate)).trim();
		//strCurrentYear					= strCurrentDate.substring(7,11);


        strCreationDate=strMailCreatedate; 
		strMailSubject=dbLabelBean.getLabel("label.mail.requisitionhandoverinformation",strLanguage);//Mail Subject
        // mail msg
 		try
		{
 			String strSSOUrl = dbutility.sSSOUrlByMailid(strUserEmail); //Added by vaibhav
			strMailMsg.append("<html><style>.formhead{ font-family:Arial;font-size:11px;font-style: normal;font-weight:normal;color:#000000;text-decoration:none;letter-spacing:normal;word-spacing:normal;border:1px #333333 solid;background:#E2E4D6;}</style><body bgcolor=\"#d0d0d0\">" + "\n");
			strMailMsg.append(" <table width=80% border=0 cellspacing=0 cellpadding=0 align=center><tr><td align=right><font face=Verdana, Arial, Helvetica, sans-serif size=2><b><font color=#FFFFFF>"+strCurrentDate+"</font><font color=#FFFFFF></font><font color=#000000><br></font></b><font color=#FFFFFF>"+dbLabelBean.getLabel("label.mail.forinternalcirculationonly",strLanguage)+"</font></font></td></tr><tr><td bgcolor=#FFFFFF align=center>"+ "\n");
			strMailMsg.append("</td></tr><tr><td bgcolor=#FFFFFF align=center><table width=100% border=0 cellspacing=0 cellpadding=15><tr><td align=center bgcolor=#aa1220><font face=Arial, Helvetica, sans-serif size=5 color=#FFFFFF>"+dbLabelBean.getLabel("label.mail.starsmailnotification",strLanguage)+"</font></td></tr></table></td></tr><tr>"+ "\n");
			strMailMsg.append("<td bgcolor=#B6DCDC></td></tr><tr><td bgcolor=#FFFFFF><table width=100% border=0 cellspacing=0 cellpadding=5>"+ "\n");
			strMailMsg.append("  <tr><td align=center bgcolor=#aa1220><font face=Verdana, Arial, Helvetica, sans-serif size=2><b><font color=#FFFFFF><font size=3>"+dbLabelBean.getLabel("label.mail.requisitionhandoverinfo",strLanguage)+" </font> </font></b></font></td></tr><tr><td bgcolor=#878787><font face=Verdana, Arial, Helvetica, sans-serif size=2><b></b></font></td></tr><tr><td><p><font color=#FFFFFF>.</font><font size=2 face=Verdana, Arial, Helvetica, sans-serif><br>"+ "\n"); 
			strMailMsg.append(" "+dbLabelBean.getLabel("label.mail.dear",strLanguage)+" "+strFullName+",</font></p><p><font size=2 face=Verdana, Arial, Helvetica, sans-serif>"+dbLabelBean.getLabel("label.mail.followingpendingrequisitionshavebeenhandedover",strLanguage)+"<br>");
			strMailMsg.append("<br><b> "+dbLabelBean.getLabel("label.search.requisitionno",strLanguage)+":-</b>"+strReq_detail+".<br><br><br>"); 
			strMailMsg.append("<b> "+dbLabelBean.getLabel("label.mail.reason",strLanguage)+" :-</b>"); 
			strMailMsg.append(""+strReason+".<br><br>"); 
			//Commented by vaibhav
			//strMailMsg.append("<br><A HREF=http://stars.mindeservices.com>Please click here to login to STARS</A>"+ "\n"); 
			strMailMsg.append("<br><a href='"+strSSOUrl+"'>"+dbLabelBean.getLabel("label.mail.pleaseclickheretologintostars",strLanguage)+" </a>"+ "\n"); 
			strMailMsg.append("   </b></form></font><br><p><font size=2 face=Verdana, Arial, Helvetica, sans-serif>"+dbLabelBean.getLabel("label.mail.bestregards",strLanguage)+"</font><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif>"+strRegardsName+"<br></font></p></td></tr></table></td></tr><tr><td bgcolor=#878787 align=center> <font face=Verdana, Arial, Helvetica, sans-serif size=2><b>"+dbLabelBean.getLabel("label.mail.mailreferencenumber",strLanguage)+" </b>"+strMailRefNumber+"/"+strCurrentYear+"</font></td></tr><tr><td bgcolor=#FFFFFF align=center>       <table width=100% border=0 cellspacing=0 cellpadding=12>"+ "\n"); 
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
				//cstmt_mail.setString(2, "Request Transferred");		//Req_id
				cstmt_mail.setString(2, strTravelId.substring(3));		//Req_id
				
				//cstmt_mail.setString(3, "Request Transferred");		//REQ_Number
				cstmt_mail.setString(3, strReq_detail);		//REQ_Number
				cstmt_mail.setString(4, strUserEmail);				//To
				cstmt_mail.setString(5, strFromMail_id);			//From
				cstmt_mail.setString(6, strCCMail_ID);				//CC   
				cstmt_mail.setString(7, strMailSubject);
				cstmt_mail.setString(8, strMailMsg.toString());
				cstmt_mail.setInt(9, intTries);
				cstmt_mail.setString(10, "NEW");
				cstmt_mail.setString(11, Suser_id);                      //Mail Creator Id
				cstmt_mail.setString(12, "New");
				cstmt_mail.setString(13, "User Submitting the Req");
				cstmt_mail.execute();
				cstmt_mail.close();
				//System.out.println(">>>>>>>>> strMailCreatedate      "+strMailMsg.toString());	
			}
			catch(Exception b)
			{
				System.out.println("ERROR in T_MailOnHndOvere.jsp---1--------"+b);		
			}
		}
		catch(Exception e)
		{
			System.out.println("ERROR in T_MailOnHndOvere.jsp---2--------"+e);		
		}
	}
	rs.close();


dbConBean.close();
dbConBean1.close();
%>

