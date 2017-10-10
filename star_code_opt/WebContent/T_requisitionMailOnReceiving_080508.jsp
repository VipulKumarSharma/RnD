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
                                  2   Change the mail Subject content,Added by shiv for showing Group Travel in case of group travel   on 25-Feb-08 ;    
								  3:CC Mail Address is remove By   shar sharma 		on 03-Apr-08
 *Reason of Modification: 
 *Date of Modification  : 11/04/2007
 *Revision History		:
 *Modified By			: Vijay Singh
 *Editor				:Editplus
 Modified by vaibhav on jul 19 2010 to enable SSO in Mails

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

<jsp:useBean id="dbUtilityBean" scope="page" class="src.connection.DbUtilityMethods" />

<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<%
	// Variables declared and initialized
Connection con								=	null;	// Object for connection
Statement stmt	,stmt1						=	null;	// Object for Statement
ResultSet rs,rs1							=	null;	// Object for ResultSet
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
String	strHrNm								=	"";
String	strHrMail							=	"";
String	strSiteId							=	"";
String strBillingSite						=	"";	
String TType								=	"";// added by vijay on 11/04/2007


String   strGroupTravelFlag        ="";
String    strGroupTravel              ="";
ArrayList aList                                                 =   new ArrayList();
//GET THE VALUES FROM THE PREVIOUS SCREEN
strRequistionId								=	request.getParameter("purchaseRequisitionId");
strRequisitionStatus						=	request.getParameter("rad").trim();
strRequisitionComments						=	request.getParameter("COMMENTS");
String ReqTyp								=	request.getParameter("ReqTyp");



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
	sSqlStr="SELECT TRAVEL_REQ_NO ,.DBO.user_name(C_USERID) AS ORIGINATOR,DBO.USEREMAIL(C_USERID)AS ORIGINATOR_MAIL,.DBO.USER_NAME('"+Suser_id+"') AS APPROVER_NAME,DBO.USEREMAIL('"+Suser_id+"') AS APPROVER_MAIL,convert(varchar(30),C_DATETIME,113),.DBO.USER_NAME(TRAVELLER_ID) AS TRAVELLER_NAME ,convert(varchar(10),TRAVEL_DATE,103),SEX ,SITE_ID AS SITE_NAME  FROM T_TRAVEL_DETAIL_DOM  WHERE TRAVEL_ID="+strRequistionId+" ";
}
else
{
	TType="International Travel Requisition No:";//added by vijay on 11/04/2007
	sSqlStr="SELECT TRAVEL_REQ_NO ,.DBO.user_name(C_USERID) AS ORIGINATOR,DBO.USEREMAIL(C_USERID)AS ORIGINATOR_MAIL,.DBO.USER_NAME('"+Suser_id+"') AS APPROVER_NAME,DBO.USEREMAIL('"+Suser_id+"') AS APPROVER_MAIL,convert(varchar(30),C_DATETIME,113),.DBO.USER_NAME(TRAVELLER_ID) AS TRAVELLER_NAME ,convert(varchar(10),TRAVEL_DATE,103),SEX ,SITE_ID AS SITE_NAME,ISNULL(T.GROUP_TRAVEL_FLAG,'N') AS GROUP_TRAVEL_FLAG  FROM T_TRAVEL_DETAIL_INT  T WHERE TRAVEL_ID="+strRequistionId+" ";
}
//stmt= con.createStatement(); 
rs = dbConBean1.executeQuery(sSqlStr);
if(rs.next())
{
				
	strRequistionNumber							=	rs.getString(1);// Number
	strRequistionCreatorName			 		=	rs.getString(2);//Creator Name
	strRequistionCreatorMail				 	=	rs.getString(3);//Creator Email
	strstrRequistionApproverName				=	rs.getString(4);//APPROVER NAME
	strstrRequistionApproverEmail			 	=	rs.getString(5);//APPROVER EMAIL
	String strRequistionCreatedDate1			=	rs.getString(6);//Req Created Date & time
	
	//@ Vijay 30-Mar-2007 Add the substring Method for time format
	
	String str= strRequistionCreatedDate1.substring(0,17);
	strRequistionCreatedDate=str;
	//End Modification
	strUserNm								 	=	rs.getString(7);//TRAVELLER NAME
	strTravelDate								=	rs.getString(8); // TRAVEL DATE
	strTravellerSex								=	rs.getString(9); // TRAVELLER SEX
	strSiteId									=	rs.getString(10);//get site id
		
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
		strSql	=	"SELECT TRAVEL_FROM,TRAVEL_TO FROM T_JOURNEY_DETAILS_DOM WHERE TRAVEL_ID="+strRequistionId+"	";
		  strGroupTravel = strSex+" "+"<b>"+strUserNm+ "</b> is scheduled to travel.";
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
						strGroupTravel ="A <B>Group</b> is scheduled to travel."; 
                        }
						else
					      {
                            strGroupTravel = strSex+" "+"<b>"+strUserNm+ "</b> is scheduled to travel.";
						 }
						 //strGroupTravelFlag
						 //strGroupTravel
                         
          

		strSql	=	"SELECT TRAVEL_FROM,TRAVEL_TO FROM T_JOURNEY_DETAILS_INT WHERE TRAVEL_ID="+strRequistionId+"	";
	}
	//stmt1= con.createStatement(); 
	rs1 = dbConBean.executeQuery(strSql);
	if(rs1.next())
	{
		strTravelFrom	=	rs1.getString(1);
		strTravelTo		=	rs1.getString(2);
	}
	rs1.close();
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
		strSql2	=	"SELECT DBO.USER_NAME(USERID),EMAIL FROM M_USERINFO WHERE SITE_ID="+strSiteId+" AND ROLE_ID IN ('HR') AND STATUS_ID=10";
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
		//stmt1.close();
	}
	else
	{
		strHrNm    =  strRequistionCreatorName;
		strHrMail  =  strRequistionCreatorMail;	
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
				
	 	 strMailMsg = new StringBuffer();
		
		strMailSubject="STARS Notification: "+TType+" '"+strRequistionNumber.trim()+"' Received by MATA ";//Mail Subject
		try
		{
			String strSSOUrl = dbUtilityBean.sSSOUrlByMailid(strHrMail); //Added by vaibhav

			strMailMsg.append("<html><style>.formhead{ font-family:Arial;font-size:11px;font-style: normal;font-weight:normal;color:#000000;text-decoration:none;letter-spacing:normal;word-spacing:normal;border:1px #333333 solid;background:#E2E4D6;}</style><body bgcolor=\"#d0d0d0\">" + "\n");	
			strMailMsg.append(" <table width=80% border=0 cellspacing=0 cellpadding=0 align=center><tr><td align=right><font face=Verdana, Arial, Helvetica, sans-serif size=2><b><font color=#FFFFFF>"+strRequistionCreatedDate+"</font><font color=#FFFFFF></font><font color=#000000><br></font></b><font color=#FFFFFF>(For Internal Circulation Only)</font></font></td></tr><tr><td bgcolor=#000000><img src=\"http://"+SmailUrl+":8080/star/images/spacer.gif\" width=1 height=1></td></tr><tr><td bgcolor=#FFFFFF align=center>"+ "\n");
			strMailMsg.append("</td></tr><tr><td bgcolor=#000000><img src=\"http://"+SmailUrl+":8080/star/images/spacer.gif\" width=1 height=1></td></tr><tr><td bgcolor=#FFFFFF align=center><table width=100% border=0 cellspacing=0 cellpadding=15><tr><td align=center bgcolor=#aa1220><font face=Arial, Helvetica, sans-serif size=5 color=#FFFFFF>:: STARS Mail NOTIFICATION ::</font></td></tr></table></td></tr><tr><td bgcolor=#000000><img src=\"http://"+SmailUrl+":8080/star/images/spacer.gif\" width=1 height=1></td></tr><tr>"+ "\n");
			strMailMsg.append("<td bgcolor=#B6DCDC></td></tr><tr><td bgcolor=#000000><img src=\"http://"+SmailUrl+":8080/star/images/spacer.gif\" width=1 height=1></td></tr><tr><td bgcolor=#000000><img src=\"http://"+SmailUrl+":8080/star/images/spacer.gif\" width=1 height=1></td></tr><tr><td bgcolor=#FFFFFF><table width=100% border=0 cellspacing=0 cellpadding=5>"+ "\n");						
			strMailMsg.append("  <tr><td align=center bgcolor=#aa1220><font face=Verdana, Arial, Helvetica, sans-serif size=2><b><font color=#FFFFFF><font size=3>"+ReqTyp+" Requisition</font> </font></b></font></td></tr><tr><td bgcolor=#878787><font face=Verdana, Arial, Helvetica, sans-serif size=2><b>"+ReqTyp+" Requisition Number : "+strRequistionNumber.trim()+"</b>(Dated : "+strRequistionCreatedDate+")</font></td></tr><tr><td><p><font color=#FFFFFF>.</font><font size=2 face=Verdana, Arial, Helvetica, sans-serif><br>"+ "\n"); 				
			strMailMsg.append(" Dear "+strHrNm+",</font></p><p><font size=2 face=Verdana, Arial, Helvetica, sans-serif>Requisition Number "+strRequistionNumber.trim()+" which was generated by "+strRequistionCreatorName+" on "+strRequistionCreatedDate+" has been <b>received</b> by me.</p>"+ "\n"); 				
			strMailMsg.append("<u><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>Requisition Details:-</font></u><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif >"+strGroupTravel+"<br> Departure Date is "+strTravelDate+".  </font>\n<br>"); 
			strMailMsg.append("<u><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>Departure City:-</font></u><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif >"+strTravelFrom+" </font>\n<br>"); 
			strMailMsg.append("<u><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>Arrival City:-</font></u><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif >"+strTravelTo+" </font>\n<br>"); 
			strMailMsg.append("<br><font size=2 face=Verdana, Arial, Helvetica, sans-serif><U><FONT COLOR=BLUE>My Comments</u><br>"+strRequisitionComments.trim()+" "+ "\n"); 
			//Commented by vaibhav
			//strMailMsg.append("</font><br><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif><a href=\"http://stars.mindeservices.com\">Please click here to login to STARS </a> "+ "\n");  
			strMailMsg.append("</font><br><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif><a href='"+strSSOUrl+"'>Please click here to login to STARS </a> "+ "\n");  
			strMailMsg.append("   </b></form></font><br><p><font size=2 face=Verdana, Arial, Helvetica, sans-serif>Best   Regards,</font><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif>"+strstrRequistionApproverName.trim()+"<br></font></p></td></tr></table></td></tr><tr><td bgcolor=#878787 align=center> <font face=Verdana, Arial, Helvetica, sans-serif size=2><b>MAIL             Reference Number: </b>"+strMailRefNumber+"/"+strCurrentYear+"</font></td></tr><tr><td bgcolor=#FFFFFF align=center>       <table width=100% border=0 cellspacing=0 cellpadding=12>"+ "\n"); 
			strMailMsg.append("<tr><td align=center bgcolor=#aa1220><font size=2 face=Verdana, Arial, Helvetica, sans-serif><b><font size=1>STARS Administrator can be contacted at the following EMail Address : - </font></b><font size=1><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=#000000>"+ "\n"); 
			strMailMsg.append("<a href=mailto:administrator.stars@mind-infotech.com><font size=1 color=#ffffff>administrator.stars@mind-infotech.com</font></a></font></font></font></td>  "+ "\n");  
			strMailMsg.append(" </tr><tr><td  align=center bgcolor=#878787 height=55> <b><font size=1 face=Verdana, Arial, Helvetica, sans-serif>Disclaimer : This communication is System Generated. "+ "\n");  
			strMailMsg.append("Please do not reply to this Email. <br>If you are not the correct receipent for this notification please contact the STARS Administrator quoting the Mail Reference Number</font></b></td></tr></table></td></tr><tr><td bgcolor=#000000><img src=\"http://"+SmailUrl+":8080/star/images/spacer.gif\"width=1 height=1></td></tr>"+ "\n");    
			strMailMsg.append("<tr><td align=center><font size=2 face=Verdana, Arial, Helvetica, sans-serif><font size=1 color=#000000>&copy;MIND. All Rights Reserved.</font></font></td>  </tr></table><p>&nbsp;</p></body></html>"+ "\n");
					
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

