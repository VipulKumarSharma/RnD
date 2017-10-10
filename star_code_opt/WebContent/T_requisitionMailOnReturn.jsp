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
 *Modification 			: 1  Display the mail Subject in different format 
                                   2 Added by shiv for showing Group Travel in case of group travel   on 25-Feb-08 ;  
								   3: CC mail address is  removed by Shiv Sharma on 03-Apr-08
								   4:Code added for showing group travel  in case of domestie group travel_DOM  on shiv sharma on 19-Jun-08

 *Reason of Modification: 
 *Date of Modification  : 09/04/2007
 *Revision History		:
 *Modified By			: Vijay Singh
 *Editor				:Editplus
 
 *Date of Modification	: 08 May 2012
 *Modified By			: Manoj Chand
 *Modification			: Correct the spelling of recipient in the mail body
 
 *Date of Modification	: 13 June 2012
 *Modified By			: Manoj Chand
 *Modification			: implementing multilingual functionality
 
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
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<%
request.setCharacterEncoding("UTF-8");
	// Variables declared and initialized
Connection con					=		null;			    // Object for connection
Statement stmt	,stmt1,stmt2,stmt3		=		null;			   // Object for Statement
ResultSet rs,rs1,rs2,rs3				=		null;			  // Object for ResultSet
CallableStatement cstmt_mail			=		null;			// Object for Callable Statement

//Create Connection
Class.forName(Sdbdriver);
con=DriverManager.getConnection(Sdburl,Sdbuser,Sdbpwd);

//DECLARE VARIABLES
String	sSqlStr								=	""; // For sql Statements
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
StringBuffer strMailMsg						=	new StringBuffer();
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
String strCreationDate						=	"";	
String TType								=	"";//added by vijay 09/04/2007
String  strGroupTravel					="";
String   strGroupTravelFlag        =""; 
String strLanguage	=	"";
String strMailToMATA	= "N";
//GET THE VALUES FROM THE PREVIOUS SCREEN
strRequistionId								=	request.getParameter("purchaseRequisitionId");
strRequisitionStatus						=	request.getParameter("rad").trim();
strRequisitionComments						=	request.getParameter("COMMENTS");
String ReqTyp								=	request.getParameter("ReqTyp");
String ReqTyp1="";
if(ReqTyp.equals("Domestic Travel")){
	ReqTyp1="label.mail.domestictravel";
}else{
	ReqTyp1="label.mail.internationaltravel";
}


String strMailID_OrignalApprover			=	"";
String strMailID_TravelMata			=	"";
String	strTravelMataMailSql	=	"";
//System.out.println("in here.."+ReqTyp);
//FETCH THE LATEST MAIL ID FROM REQ_MAILBOX
sSqlStr="SELECT ISNULL(MAX(MAIL_ID),'999')+1 FROM REQ_MAILBOX";
stmt = con.createStatement(); 
rs = stmt.executeQuery(sSqlStr);
	if(rs.next())
	{
		strMailRefNumber								=	rs.getString(1);//Mail Reference Number
	}
	rs.close();
stmt.close();



					// FETCH Requistion Details
	if(ReqTyp.equals("Domestic Travel"))
	{
		TType="Domestic Travel Requisition No:";//added by vijay on 09/04/2007
sSqlStr="SELECT TRAVEL_REQ_NO ,.DBO.user_name(C_USERID) AS ORIGINATOR,DBO.USEREMAIL(C_USERID)AS ORIGINATOR_MAIL,.DBO.USER_NAME('"+Suser_id+"') AS APPROVER_NAME,DBO.USEREMAIL('"+Suser_id+"') AS APPROVER_MAIL,convert(varchar(30), C_DATETIME,113),.DBO.USER_NAME(TRAVELLER_ID) AS TRAVELLER_NAME ,convert(varchar(10),TRAVEL_DATE,103),SEX ,.DBO.SITENAME(SITE_ID) AS SITE_NAME,ISNULL(T.GROUP_TRAVEL_FLAG,'N') AS GROUP_TRAVEL_FLAG,(select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = T.SITE_ID) as TRAVEL_AGENCY_ID, (select MAIL_TO_MATA from M_SITE where SITE_ID = T.SITE_ID) as MAIL_TO_MATA FROM T_TRAVEL_DETAIL_DOM  T  WHERE TRAVEL_ID="+strRequistionId+"";
	}
else
	{
		TType="International Travel Requisition No:";//added by vijay on 09/04/2007
sSqlStr="SELECT TRAVEL_REQ_NO ,.DBO.user_name(C_USERID) AS ORIGINATOR,DBO.USEREMAIL(C_USERID)AS ORIGINATOR_MAIL,.DBO.USER_NAME('"+Suser_id+"') AS APPROVER_NAME,DBO.USEREMAIL('"+Suser_id+"') AS APPROVER_MAIL,convert(varchar(30), C_DATETIME,113),.DBO.USER_NAME(TRAVELLER_ID) AS TRAVELLER_NAME ,convert(varchar(10),TRAVEL_DATE,103),SEX ,.DBO.SITENAME(SITE_ID) AS SITE_NAME,ISNULL(T.GROUP_TRAVEL_FLAG,'N') AS GROUP_TRAVEL_FLAG,(select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = T.SITE_ID) as TRAVEL_AGENCY_ID, (select MAIL_TO_MATA from M_SITE where SITE_ID = T.SITE_ID) as MAIL_TO_MATA FROM T_TRAVEL_DETAIL_INT  T  WHERE TRAVEL_ID="+strRequistionId+"  ";
	}


		//System.out.println("when returned.."+sSqlStr);
           	stmt= con.createStatement(); 
			rs = stmt.executeQuery(sSqlStr);


	if(rs.next())
			{
				
					strRequistionNumber				=	rs.getString(1);// Number
					strRequistionCreatorName		=	rs.getString(2);//Creator Name
					strRequistionCreatorMail		=	rs.getString(3);//Creator Email
					strstrRequistionApproverName	=	rs.getString(4);//APPROVER NAME
					strstrRequistionApproverEmail	=	rs.getString(5);//APPROVER EMAIL
					String strRequistionCreatedDate1=	rs.getString(6);//Req Created Date & time
	
	//@ Vijay 30-Mar-2007 Add the substring Method for time format
	
	String str= strRequistionCreatedDate1.substring(0,17);
	strRequistionCreatedDate=str;
					strUserNm								 							=	rs.getString(7);//TRAVELLER NAME
					strTravelDate														=	rs.getString(8); // TRAVEL DATE
					strTravellerSex														=	rs.getString(9); // TRAVELLER SEX
					strSiteName															=	rs.getString(10); //site name
					strTravelAgencyTypeId												=	rs.getString("TRAVEL_AGENCY_ID"); //site name
					strMailToMATA														=	rs.getString("MAIL_TO_MATA");
					
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
					//added by manoj chand on 13 june 2012 to get mail to person language preference
					strSql	=	"SELECT LANGUAGE_PREF FROM M_USERINFO WHERE EMAIL =N'"+strRequistionCreatorMail+"' AND STATUS_ID=10";
					stmt2= con.createStatement(); 
					rs2 = stmt2.executeQuery(strSql);
					if(rs2.next()){
						strLanguage=rs2.getString("LANGUAGE_PREF");
						if(strLanguage==null || strLanguage.equals("")){
							strLanguage="en_US";
						}
					}
					rs2.close();
					stmt2.close();

if(ReqTyp.equals("Domestic Travel"))
				{
	//code commented by manoj chand and replace with new query on 27 june 2013.	            
	//strSql	=	"SELECT TRAVEL_FROM,TRAVEL_TO FROM T_JOURNEY_DETAILS_DOM WHERE TRAVEL_ID="+strRequistionId+"	";
	strSql ="select * FROM  [dbo].[FN_GetDeparturecity]("+strRequistionId+",'d')";
				  // strGroupTravel = strSex+"<b>"+strUserNm+ "</b> is scheduled to travel.";
				 // Code added for showing group travel  in case of domestie group travel_DOM  on shiv sharma on 19-Jun-08

				   strGroupTravelFlag       =   rs.getString("GROUP_TRAVEL_FLAG"); 
                 
						try{
							 if(strGroupTravelFlag==null)	{
							   strGroupTravel =""; 
			                     }
							if(strGroupTravelFlag!=null  &&  (strGroupTravelFlag.trim().equals("Y"))){
 								   strGroupTravel =dbLabelBean.getLabel("label.mail.groupguestisscheduledtotravel",strsesLanguage);
 								  if(strTravelAgencyTypeId.equals("2")) {
 									 strGroupTravel = dbLabelBean.getLabel("label.mail.guestisscheduledtotravel",strsesLanguage);
  	   	 						  }
								 }	
							else{
								strGroupTravel = strSex+"<b>"+strUserNm+ "</b> "+dbLabelBean.getLabel("label.mail.isscheduledtotravel",strsesLanguage);
							}
				}catch(Exception e){
					System.out.println("error in page T_requsitionmailon return.jsp"+e);
					              
				}
						
						strTravelMataMailSql = " SELECT EMAIL AS MATAGMBH FROM M_USERINFO WHERE SITE_ID IN (SELECT FUNCTION_VALUE FROM functional_ctl WHERE function_key='@MataGmbHSite') "+
				   				" AND ROLE_ID ='MATA' AND  EXISTS(SELECT 1 FROM T_TRAVEL_DETAIL_DOM TDI INNER JOIN M_SITE S ON TDI.SITE_ID = S.SITE_ID "+
				   				" WHERE TRAVEL_ID="+strRequistionId+" AND TRAVEL_AGENCY_ID=2) AND M_USERINFO.STATUS_ID=10";	
				}
else
				{
			
				 //  Added by shiv for showing Group Travel in case of group travel   on 25-Feb-08 ;  
			              strGroupTravelFlag       =   rs.getString("GROUP_TRAVEL_FLAG"); 
                         
                 	       
                            try{
							 if(strGroupTravelFlag==null) 
								{
								  
							strGroupTravel =""; 
			                 	 
			 					}
							if(strGroupTravelFlag!=null  &&  (strGroupTravelFlag.trim().equals("Y")))
								{
									//strGroupTravel ="Group "; 
									strGroupTravel =dbLabelBean.getLabel("label.mail.groupguestisscheduledtotravel",strsesLanguage);
									if(strTravelAgencyTypeId.equals("2")) {
	 									 strGroupTravel = dbLabelBean.getLabel("label.mail.guestisscheduledtotravel",strsesLanguage);
	  	   	 						}
								 }	
							else{
								     // strGroupTravel =""; 
									strGroupTravel = strSex+"<b>"+strUserNm+ "</b> "+dbLabelBean.getLabel("label.mail.isscheduledtotravel",strsesLanguage);
									}
				}catch(Exception e){
					System.out.println("error in page T_requsitionmailon return.jsp"+e);
					              
				}
				//code commented by manoj chand and replace with new query on 27 june 2013.	
                  //strSql	=	"SELECT TRAVEL_FROM,TRAVEL_TO FROM T_JOURNEY_DETAILS_INT WHERE TRAVEL_ID="+strRequistionId+"	";
				strSql ="select * FROM  [dbo].[FN_GetDeparturecity]("+strRequistionId+",'i')";
				
				strTravelMataMailSql = " SELECT EMAIL AS MATAGMBH FROM M_USERINFO WHERE SITE_ID IN (SELECT FUNCTION_VALUE FROM functional_ctl WHERE function_key='@MataGmbHSite') "+
						   " AND ROLE_ID ='MATA' AND  EXISTS(SELECT 1 FROM T_TRAVEL_DETAIL_INT TDI INNER JOIN M_SITE S ON TDI.SITE_ID = S.SITE_ID "+
						   " WHERE TRAVEL_ID="+strRequistionId+" AND TRAVEL_AGENCY_ID=2) AND M_USERINFO.STATUS_ID=10";
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

//Added by Gurmeet Singh
stmt3= con.createStatement(); 
rs3 = stmt3.executeQuery(strTravelMataMailSql);
if(rs3.next()) {
	strMailID_TravelMata = rs3.getString("MATAGMBH");
}
rs3.close();
stmt3.close();

if("N".equals(strMailToMATA)) {
	strMailID_TravelMata = "";
}


//find the orignal approver name in case of handover mail  for sending mail added by shiv sharma on 25 sept 2008 

if(ReqTyp.equals("Domestic Travel")){
	strSql="select ISNULL(dbo.USEREMAIL(ORIGINAL_APPROVER), '') from t_approvers where (TRAVEL_ID = "+strRequistionId+") and travel_type='d' and approver_id="+Suser_id+"";

}
else	{
	strSql="select ISNULL(dbo.USEREMAIL(ORIGINAL_APPROVER), '') from t_approvers where (TRAVEL_ID = "+strRequistionId+") and travel_type='i' and approver_id="+Suser_id+"";
}

 rs = dbConBean.executeQuery(strSql);
	if(rs.next()) {
          strMailID_OrignalApprover	=	rs.getString(1);//Mail ID of CC mails 
	}
	
	if(!"".equals(strMailID_OrignalApprover)){
		strMailID_OrignalApprover=strMailID_OrignalApprover+"; "+strMailID_TravelMata;	
	} else {
		strMailID_OrignalApprover=strMailID_TravelMata;
	}


		
                    strCreationDate=strMailCreatedate; //added by shiv on 3/20/2007
					//added by vijay on 09/04/2007
					
					if(strGroupTravelFlag!=null  &&  (strGroupTravelFlag.trim().equals("Y"))) {
						strMailSubject=dbLabelBean.getLabel("label.mail.starsnotification",strLanguage)+TType+" '"+strRequistionNumber.trim()+"' "+dbLabelBean.getLabel(groupGuestLabel,strLanguage)+" "+dbLabelBean.getLabel("label.mail.hasbeenreturned",strLanguage)+" ";//Mail Subject
					} else {
						strMailSubject=dbLabelBean.getLabel("label.mail.starsnotification",strLanguage)+TType+" '"+strRequistionNumber.trim()+"' "+dbLabelBean.getLabel("label.mail.hasbeenreturned",strLanguage)+" ";//Mail Subject
					}
                    

						try
						{
					strMailMsg.append("<html><style>.formhead{ font-family:Arial;font-size:11px;font-style: normal;font-weight:normal;color:#000000;text-decoration:none;letter-spacing:normal;word-spacing:normal;border:1px #333333 solid;background:#E2E4D6;}</style><body bgcolor=\"#d0d0d0\">" + "\n");
				strMailMsg.append(" <table width=80% border=0 cellspacing=0 cellpadding=0 align=center><tr><td align=right><font face=Verdana, Arial, Helvetica, sans-serif size=2><b><font color=#FFFFFF>"+strCreationDate+"</font><font color=#FFFFFF></font><font color=#000000><br></font></b><font color=#FFFFFF>"+dbLabelBean.getLabel("label.mail.forinternalcirculationonly",strLanguage)+"</font></font></td></tr><tr><td bgcolor=#000000></td></tr><tr><td bgcolor=#FFFFFF align=center>"+ "\n");
				strMailMsg.append("</td></tr><tr><td bgcolor=#000000></td></tr><tr><td bgcolor=#FFFFFF align=center><table width=100% border=0 cellspacing=0 cellpadding=15><tr><td align=center bgcolor=#aa1220><font face=Arial, Helvetica, sans-serif size=5 color=#FFFFFF>"+dbLabelBean.getLabel("label.mail.starsmailnotification",strLanguage)+"</font></td></tr></table></td></tr><tr><td bgcolor=#000000></td></tr><tr>"+ "\n");
				strMailMsg.append("<td bgcolor=#B6DCDC></td></tr><tr><td bgcolor=#000000</td></tr><tr><td bgcolor=#000000></td></tr><tr><td bgcolor=#FFFFFF><table width=100% border=0 cellspacing=0 cellpadding=5>"+ "\n");
				strMailMsg.append("  <tr><td align=center bgcolor=#aa1220><font face=Verdana, Arial, Helvetica, sans-serif size=2><b><font color=#FFFFFF><font size=3>"+dbLabelBean.getLabel(ReqTyp1,strLanguage)+" "+dbLabelBean.getLabel("label.mail.requisition",strLanguage)+"</font> </font></b></font></td></tr><tr><td bgcolor=#878787><font face=Verdana, Arial, Helvetica, sans-serif size=2><b>"+dbLabelBean.getLabel("label.mail.travelrequisitionnumber",strLanguage)+" : "+strRequistionNumber.trim()+"</b>("+dbLabelBean.getLabel("label.mail.dated",strLanguage)+" : "+strRequistionCreatedDate+")</font></td></tr><tr><td><p><font color=#FFFFFF>.</font><font size=2 face=Verdana, Arial, Helvetica, sans-serif><br>"+ "\n"); 
				strMailMsg.append(" "+dbLabelBean.getLabel("label.mail.dear",strLanguage)+" "+strRequistionCreatorName+",</font></p><p><font size=2 face=Verdana, Arial, Helvetica, sans-serif>"+dbLabelBean.getLabel("label.global.requisitionnumber",strsesLanguage)+" "+strRequistionNumber.trim()+" "+dbLabelBean.getLabel("label.mail.whichwasgeneratedbyyou",strLanguage)+" "+dbLabelBean.getLabel("label.mail.from",strLanguage)+" "+strSiteName+" "+dbLabelBean.getLabel("label.mail.on",strLanguage)+" "+strRequistionCreatedDate+" "+dbLabelBean.getLabel("label.mail.hasbeenreturnedbyme",strLanguage)+"</p>"+ "\n"); 	
				strMailMsg.append("<u><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>"+dbLabelBean.getLabel("label.mail.requisitionsdetails",strLanguage)+":-</font></u><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif >"+strGroupTravel+"<br> "+dbLabelBean.getLabel("label.mail.departuredateis",strLanguage)+" "+strTravelDate+".  </font>\n<br>"); 
				strMailMsg.append("<u><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>"+dbLabelBean.getLabel("label.global.departurecity",strLanguage)+":-</font></u><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif >"+strTravelFrom+" </font>\n<br>"); 
				strMailMsg.append("<u><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>"+dbLabelBean.getLabel("label.global.arrivalcity",strLanguage)+":-</font></u><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif >"+strTravelTo+" </font>\n<br>"); 
				strMailMsg.append("<br><font size=2 face=Verdana, Arial, Helvetica, sans-serif><U><FONT COLOR=BLUE>"+strstrRequistionApproverName+"  "+dbLabelBean.getLabel("link.approverequest.comments",strLanguage)+"</u><br>"+strRequisitionComments.trim()+" "+ "\n"); 
				strMailMsg.append("   </b></form></font><br><p><font size=2 face=Verdana, Arial, Helvetica, sans-serif>"+dbLabelBean.getLabel("label.mail.bestregards",strLanguage)+"</font><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif>"+strstrRequistionApproverName.trim()+"<br></font></p></td></tr></table></td></tr><tr><td bgcolor=#878787 align=center> <font face=Verdana, Arial, Helvetica, sans-serif size=2><b>"+dbLabelBean.getLabel("label.mail.mailreferencenumber",strLanguage)+" </b>"+strMailRefNumber+"/"+strCurrentYear+"</font></td></tr><tr><td bgcolor=#FFFFFF align=center>       <table width=100% border=0 cellspacing=0 cellpadding=12>"+ "\n"); 
				strMailMsg.append("<tr><td align=center bgcolor=#aa1220><font size=2 face=Verdana, Arial, Helvetica, sans-serif><b><font size=1>"+dbLabelBean.getLabel("label.mail.starsadministratorcanbecontacted",strLanguage)+" : - </font></b><font size=1><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=#000000>"+ "\n"); 
				strMailMsg.append("<a href=mailto:administrator.stars@mind-infotech.com><font size=1 color=#ffffff>administrator.stars@mind-infotech.com</font></a></font></font></font></td>  "+ "\n");  
				strMailMsg.append(" </tr><tr><td  align=center bgcolor=#878787 height=55> <b><font size=1 face=Verdana, Arial, Helvetica, sans-serif>"+dbLabelBean.getLabel("label.mail.disclaimer",strLanguage)+" : "+dbLabelBean.getLabel("label.mail.thiscommunicationissystemgenererated",strsesLanguage)+" "+ "\n");  
				strMailMsg.append(dbLabelBean.getLabel("label.mail.pleasedonnotreplytothismail",strLanguage)+" <br>"+dbLabelBean.getLabel("label.mail.ifyouarenotthecorrectrecipient",strLanguage)+"</font></b></td></tr></table></td></tr><tr><td bgcolor=#000000> </td></tr>"+ "\n");    
				strMailMsg.append("<tr><td align=center><font size=2 face=Verdana, Arial, Helvetica, sans-serif><font size=1 color=#000000>&copy;"+dbLabelBean.getLabel("label.mail.mindallrightsreserved",strLanguage)+"</font></font></td>  </tr></table><p>&nbsp;</p></body></html>"+ "\n");

			 //System.out.println("strMailMsg========"+strMailMsg);
									try
										{
													//Procedure for inserting Mail Data
													cstmt_mail=con.prepareCall("{?=call PROC_REQUISITION_MAIL_ADD(?,?,?,?,?,?,?,?,?,?,?,?)}");
													cstmt_mail.registerOutParameter(1,java.sql.Types.INTEGER);
													cstmt_mail.setString(2, strRequistionId);
													cstmt_mail.setString(3, strRequistionNumber);
													cstmt_mail.setString(4, strRequistionCreatorMail);//To
													cstmt_mail.setString(5, strstrRequistionApproverEmail);//From
													cstmt_mail.setString(6, strMailID_OrignalApprover); //CC mail address is  removed by Shiv Sharma on 03-Apr-08 
													cstmt_mail.setString(7, strMailSubject);
													cstmt_mail.setString(8, strMailMsg.toString());
													cstmt_mail.setInt(9, intTries);
													cstmt_mail.setString(10, "NEW");
													cstmt_mail.setString(11, Suser_id);
													cstmt_mail.setString(12, "Approval Process");
													cstmt_mail.setString(13, "Signatory Returns IT");
													cstmt_mail.execute();
													cstmt_mail.close();
										}
										catch(Exception b)
										{
											out.print("ERROR---1--------"+b);		
										}

								}
								catch(Exception e)
								{
								out.println(e);
								}

								}
			rs.close();
			stmt.close();
%>

