<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:DEEPALI DHAR
 *Date of Creation 		:03 November 2006
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This is the  jsp file  for inserting the mail information in req_mailbox table
                
 *Modification 			:1   Added by shiv for showing Group Travel in case of group travel   on 25-Feb-08 ;    
 *Reason of Modification: 
 *Date of Modification  : 
 *Revision History		:
 *Editor				:Editplus
 Modified by vaibhav on jul 19 2010 to enable SSO in Mails
 *Date of Modification	: 09 May 2012
 *Modified By			: Manoj Chand
 *Modification			: Correct the spelling of recipient in the mail body
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
<jsp:useBean id="dbConBean1" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbConBean2" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbutility" scope="page" class="src.connection.DbUtilityMethods" /><!-- Added by vaibhav -->

<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<%
	// Variables declared and initialized
Connection con						=		null;			    // Object for connection
ResultSet rs,rs1					=		null;			  // Object for ResultSet
CallableStatement cstmt_mail		=		null;			// Object for Callable Statement

//Create Connection
con = dbConBean2.getConnection();     //Get the Connection

//DECLARE VARIABLES
String	sSqlStr														=	""; // For sql Statements
String strRequistionId												=	null;
String strRequisitionStatus											=	null;
String strRequistionNumber	 										=	null;
String strMailSubject												=	null;
String strRequistionGTDate											=	null;
String strMailRefNumber												=	null;
String strRequistionCreatorName			 							=	null;
String strRequistionCreatorMail										=	null;
String strRequistionCreatedDate										=	null;
String strRequisitionComments										=	null;
StringBuffer strMailMsg												= new StringBuffer();
String strstrRequistionApproverName									=	null;
String strstrRequistionApproverEmail								=	null;
String strstrRequistionApproverDesig								=	null;
String strstrRequistionNextApproverName								=	null;
String strstrRequistionNextApproverEmail							=	null;
int		intTries													=	0;
strRequistionId														=	request.getParameter("purchaseId");
String strUserPin													=	null;
String strSiteName													=	null;
String strReqVal													=	null;
String	strUserNm													=	"";
String	strTravelDate												=	"";
String	strTravellerSex												=	"";
String	strSex														=	"";
String	strSql														=	"";
String	strTravelFrom												=	"";
String	strTravelTo													=	"";
String	strReq														=	"";
String strMailCreatorId												=   "";                     //userid of star administrator
String  strGroupTravel												="";
String  strGroupTravelFlag										="";	
//GET THE VALUES FROM THE PREVIOUS SCREEN
strRequistionId														=	request.getParameter("purchaseRequisitionId");
strRequisitionStatus												=	request.getParameter("rad").trim();
strRequisitionComments												=	request.getParameter("COMMENTS");
String ReqTyp														=	request.getParameter("ReqTyp");

//FETCH THE LATEST MAIL ID FROM REQ_MAILBOX
sSqlStr="SELECT ISNULL(MAX(MAIL_ID),'999')+1 FROM REQ_MAILBOX";
rs = dbConBean.executeQuery(sSqlStr);
if(rs.next())
{
	strMailRefNumber								=	rs.getString(1);//Mail Reference Number
}
rs.close();

//Query for finding the MailCreator Id(Star Admin)
sSqlStr = "SELECT USERID  AS MAIL_CREATER_ID FROM M_USERINFO WHERE ROLE_ID='AD' AND STATUS_ID=10 AND APPLICATION_ID=1";
rs = dbConBean.executeQuery(sSqlStr);
if(rs.next())
{
	strMailCreatorId = rs.getString("MAIL_CREATER_ID");
}
rs.close();


// FETCH Requistion Details
if(ReqTyp.equals("Domestic Travel"))
{
	sSqlStr="SELECT TRAVEL_REQ_NO ,.DBO.user_name(C_USERID) AS ORIGINATOR,DBO.USEREMAIL(C_USERID)AS ORIGINATOR_MAIL,.DBO.mata_approver("+strRequistionId+",'D') AS APPROVER_NAME,DBO.mata_approver_mail("+strRequistionId+",'D') AS APPROVER_MAIL,ISNULL(RTRIM(.DBO.PRESENTAPPROVER("+strRequistionId+",'D',TRAVELLER_ID)),'NA') AS NEXTWITH,ISNULL(RTRIM(.DBO.PRESENTAPPROVER_MAIL("+strRequistionId+",'D',TRAVELLER_ID)),'NA') AS NEXTWITH_MAIL,convert(varchar(30),C_DATETIME,113),.DBO.USER_NAME(TRAVELLER_ID) AS TRAVELLER_NAME ,convert(varchar(10),TRAVEL_DATE,103),SEX ,.DBO.SITENAME(SITE_ID) AS SITE_NAME  FROM T_TRAVEL_DETAIL_DOM  WHERE TRAVEL_ID="+strRequistionId+" ";
}
else
{
    sSqlStr="SELECT TRAVEL_REQ_NO ,.DBO.user_name(C_USERID) AS ORIGINATOR,DBO.USEREMAIL(C_USERID)AS ORIGINATOR_MAIL,.DBO.mata_approver("+strRequistionId+",'I') AS APPROVER_NAME,DBO.mata_approver_mail("+strRequistionId+",'I') AS APPROVER_MAIL,ISNULL(RTRIM(.DBO.PRESENTAPPROVER("+strRequistionId+",'I',TRAVELLER_ID)),'NA') AS NEXTWITH,ISNULL(RTRIM(.DBO.PRESENTAPPROVER_MAIL("+strRequistionId+",'I',TRAVELLER_ID)),'NA') AS NEXTWITH_MAIL,convert(varchar(30),C_DATETIME,113),.DBO.USER_NAME(TRAVELLER_ID) AS TRAVELLER_NAME ,convert(varchar(10),TRAVEL_DATE,103),SEX ,.DBO.SITENAME(SITE_ID) AS SITE_NAME,T.GROUP_TRAVEL_FLAG   FROM T_TRAVEL_DETAIL_INT T WHERE TRAVEL_ID="+strRequistionId+"  ";
}

//System.out.println("sSqlStr print "+sSqlStr);
rs = dbConBean.executeQuery(sSqlStr);
if(rs.next())
{
	strRequistionNumber											=	rs.getString(1);// Number
	strRequistionCreatorName			 					=	rs.getString(2);//Creator Name
	strRequistionCreatorMail				 					=	rs.getString(3);//Creator Email
	strstrRequistionApproverName						=	rs.getString(4);//APPROVER NAME
	strstrRequistionApproverEmail			 			=	rs.getString(5);//APPROVER EMAIL
	strstrRequistionNextApproverName				=	rs.getString(6);//NEXT APPROVER NAME
	strstrRequistionNextApproverEmail			 	=	rs.getString(7);//NEXT APPROVER MAIL
	strRequistionCreatedDate			 					=	rs.getString(8);//Req Created Date & time
	strUserNm								 							=	rs.getString(9);//TRAVELLER NAME
	strTravelDate														=	rs.getString(10); // TRAVEL DATE
	strTravellerSex														=	rs.getString(11); // TRAVELLER SEX
	strSiteName															=	rs.getString(12); //site name

	if(strTravellerSex.equals("1"))
	{
		strSex	 =	 "Mr.";
	}
	else
	{
		strSex	 =	 "Ms";
	}
	//System.out.println("strTraveller..."+strSex);
	
	if(ReqTyp.equals("Domestic Travel"))
	{
		strSql	=	"SELECT TRAVEL_FROM,TRAVEL_TO FROM T_JOURNEY_DETAILS_DOM WHERE TRAVEL_ID="+strRequistionId+"	";
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
									strGroupTravel ="Group/Guest "; 
								 }	
							else
									{
										 strGroupTravel =""; 
									}

						// strGroupTravel
						// strGroupTravelFlag  

		strSql	=	"SELECT TRAVEL_FROM,TRAVEL_TO FROM T_JOURNEY_DETAILS_INT WHERE TRAVEL_ID="+strRequistionId+"	";
	}
	rs1 = dbConBean1.executeQuery(strSql);
	if(rs1.next())
	{
		strTravelFrom	=	rs1.getString(1);
		strTravelTo		=	rs1.getString(2);
	}
	rs1.close();

	strMailSubject="Travel Requisition No :'"+strRequistionNumber.trim()+"'  has been initiated by '"+strRequistionCreatorName+"'  from '"+strSiteName.trim()+"'  ";//Mail Subject
	try
	{
		String strSSOUrl = dbutility.sSSOUrlByMailid(strstrRequistionApproverEmail); //added by vaibhav
		strMailMsg.append("<html><style>.formhead{ font-family:Arial;font-size:11px;font-style: normal;font-weight:normal;color:#000000;text-decoration:none;letter-spacing:normal;word-spacing:normal;border:1px #333333 solid;background:#E2E4D6;}</style><body bgcolor=\"#99CC66\">" + "\n");	
		strMailMsg.append(" <table width=80% border=0 cellspacing=0 cellpadding=0 align=center><tr><td align=right><font face=Verdana, Arial, Helvetica, sans-serif size=2><b><font color=#FFFFFF>"+strRequistionCreatedDate+"</font><font color=#FFFFFF></font><font color=#000000><br></font></b><font color=#FFFFFF>(For Internal Circulation Only)</font></font></td></tr><tr><td bgcolor=#000000> </td></tr><tr><td bgcolor=#FFFFFF align=center>"+ "\n");
		strMailMsg.append("</td></tr><tr><td bgcolor=#000000> </td></tr><tr><td bgcolor=#FFFFFF align=center><table width=100% border=0 cellspacing=0 cellpadding=15><tr><td align=center bgcolor=#3A7676><font face=Arial, Helvetica, sans-serif size=5 color=#FFFFFF>:: STARS Mail NOTIFICATION ::</font></td></tr></table></td></tr><tr><td bgcolor=#000000> </td></tr><tr>"+ "\n");
		strMailMsg.append("<td bgcolor=#B6DCDC></td></tr><tr><td bgcolor=#000000></td></tr><tr><td bgcolor=#000000> </td></tr><tr><td bgcolor=#FFFFFF><table width=100% border=0 cellspacing=0 cellpadding=5>"+ "\n");						
		strMailMsg.append("  <tr><td align=center bgcolor=#3A7676><font face=Verdana, Arial, Helvetica, sans-serif size=2><b><font color=#FFFFFF><font size=3>"+ReqTyp+" Requisition</font> </font></b></font></td></tr><tr><td bgcolor=#A8D5D5><font face=Verdana, Arial, Helvetica, sans-serif size=2><b>"+ReqTyp+" Requisition Number : "+strRequistionNumber.trim()+"</b>(Dated : "+strRequistionCreatedDate+")</font></td></tr><tr><td><p><font color=#FFFFFF>.</font><font size=2 face=Verdana, Arial, Helvetica, sans-serif><br>"+ "\n"); 				
		strMailMsg.append(" Dear  "+strstrRequistionApproverName+",</font></p><p><font size=2 face=Verdana, Arial, Helvetica, sans-serif>Requisition Number "+strRequistionNumber.trim()+" which was generated by "+strRequistionCreatorName+" on "+strRequistionCreatedDate+" has got the <b>Unit Head</b> approval. Kindly arrange for the <b>tentative</b> booking.</p>"+ "\n"); 				
		strMailMsg.append("<u><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>Requisition Details:-</font></u><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif >"+strSex+" <b>"+strUserNm+ "</b> is scheduled to "+strGroupTravel+" travel.<br> Departure Date is "+strTravelDate+".  </font>\n<br>"); 
		strMailMsg.append("<u><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>Departure City:-</font></u><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif >"+strTravelFrom+" </font>\n<br>"); 
		strMailMsg.append("<u><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>Arrival City:-</font></u><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif >"+strTravelTo+" </font>\n<br>"); 
		//Commented by vaibhav
		//strMailMsg.append("</font><br><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif><a href=\"http://stars.mindeservices.com\">Please click here to login to STARS </a> "+ "\n");  
		strMailMsg.append("</font><br><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif><a href='"+strSSOUrl+"'>Please click here to login to STARS </a> "+ "\n");  
		strMailMsg.append("   </b></form></font><br><p><font size=2 face=Verdana, Arial, Helvetica, sans-serif>Best       Regards,</font><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif>Stars Administrator<br></font></p></td></tr></table></td></tr><tr><td bgcolor=#A8D5D5 align=center> <font face=Verdana, Arial, Helvetica, sans-serif size=2><b>MAIL             Reference Number: </b>"+strMailRefNumber+"/"+strCurrentYear+"</font></td></tr><tr><td bgcolor=#FFFFFF align=center>       <table width=100% border=0 cellspacing=0 cellpadding=12>"+ "\n"); 
		strMailMsg.append("<tr><td align=center bgcolor=#FFCC66><font size=2 face=Verdana, Arial, Helvetica, sans-serif><b><font size=1>STARS Administrator can be contacted at the following EMail Address : - </font></b><font size=1><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=#000000>"+ "\n"); 
		strMailMsg.append("<a href=mailto:administrator.stars@mind-infotech.com><font size=1>administrator.stars@mind-infotech.com</font></a></font></font></font></td>  "+ "\n");  
		strMailMsg.append(" </tr><tr><td  align=center bgcolor=#CCCC99 height=55> <b><font size=1 face=Verdana, Arial, Helvetica, sans-serif>Disclaimer : This communication is System Generated. "+ "\n");  
		strMailMsg.append("Please do not reply to this Email. <br>If you are not the correct recipient for this notification please contact the STARS Administrator quoting the Mail Reference Number</font></b></td></tr></table></td></tr><tr><td bgcolor=#000000> </td></tr>"+ "\n");    
		strMailMsg.append("<tr><td align=center><font size=2 face=Verdana, Arial, Helvetica, sans-serif><font size=1 color=#000000>&copy;MIND. All Rights Reserved.</font></font></td>  </tr></table><p>&nbsp;</p></body></html>"+ "\n");
		


									 
		try
		{
			//Procedure for inserting Mail Data
			cstmt_mail=con.prepareCall("{?=call PROC_REQUISITION_MAIL_ADD(?,?,?,?,?,?,?,?,?,?,?,?)}");
			cstmt_mail.registerOutParameter(1,java.sql.Types.INTEGER);
			cstmt_mail.setString(2, strRequistionId);
			cstmt_mail.setString(3, strRequistionNumber);
			cstmt_mail.setString(4, strstrRequistionApproverEmail);//To
			cstmt_mail.setString(5, "administrator.stars@mind-infotech.com");//From
			cstmt_mail.setString(6, strRequistionCreatorMail);//CC
			cstmt_mail.setString(7, strMailSubject);
			cstmt_mail.setString(8, strMailMsg.toString());
			cstmt_mail.setInt(9, intTries); 
			cstmt_mail.setString(10, "NEW");
			cstmt_mail.setString(11, strMailCreatorId);                  //Set Admin userid
			cstmt_mail.setString(12, "Notify MATA");
			cstmt_mail.setString(13, "First Signatory Approves IT");
			cstmt_mail.execute();
			cstmt_mail.close();
		}
		catch(Exception b)
		{
			System.out.print("ERROR in T_IntimationToMATA.jsp---1--------"+b);		
		}
	}
	catch(Exception e)
	{
		System.out.print("ERROR in T_IntimationToMATA.jsp---2--------"+e);		
	}
}
rs.close();


//Close All Connection
dbConBean.close();
dbConBean1.close();
dbConBean2.close();

%>

