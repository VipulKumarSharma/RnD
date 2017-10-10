<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:SACHIN GUPTA
 *Date of Creation 		:27 Feb 2007
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STARS
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This is the jsp file for making a request for  request for more  info 
  *Editor					:Editplus
  *Revision History		:1  Added by shiv for showing Group Travel in case of group travel   on 02-Jul-08
  Modified by vaibhav on jul 19 2010 to enable SSO in Mails
  
 *Date of Modification	: 09 May 2012
 *Modified By			: Manoj Chand
 *Modification			: Correct the spelling of recipient in the mail body
 
 *Modified By			:Manoj Chand
 *Date of Modification  :02-July-2013
 *Modification			:change in query to correct the value of travel to.
 *******************************************************/ 
%>
<%@ page pageEncoding="UTF-8" %>
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
<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>

<!--Create the DbConnectionBean object for createConnection-->
<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbutility" scope="page" class="src.connection.DbUtilityMethods" /> <!-- Added by vaibhav -->
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>

<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<%
request.setCharacterEncoding("UTF-8");
	// Variables declared and initialized
Connection con						=		null;			    // Object for connection
Statement stmt	,stmt1,stmt2				=		null;			   // Object for Statement
ResultSet rs,rs1,rs2					=		null;			  // Object for ResultSet
CallableStatement cstmt_mail		=		null;			// Object for Callable Statement

//Create Connection
Class.forName(Sdbdriver);
con=DriverManager.getConnection(Sdburl,Sdbuser,Sdbpwd);

//DECLARE VARIABLES
String	sSqlStr										=	""; // For sql Statements
String strRequistionId								=	null;
String strRequisitionStatus							=	null;
String strRequistionNumber	 						=	null;
String strMailSubject								=	null;
String strRequistionGTDate							=	null;
String strMailRefNumber								=	null;
String strRequistionCreatorName	 					=	null;
String strRequistionCreatorMail						=	null;
String strRequistionCreatedDate						=	null;
String strRequisitionComments						=	null;
String strstrRequistionApproverName					=	null;
String strstrRequistionApproverEmail				=	null;
String strstrRequistionApproverDesig				=	null;
String strstrRequistionNextApproverName				=	null;
String strstrRequistionNextApproverEmail			=	null;
int		intTries									=	0;
String strUserPin									=   null;
String strSiteName									=	null;
String strReqVal									=	null;
String	strUserNm									=	"";
String	strTravelDate								=	"";
String	strTravellerSex								=	"";
String	strSex										=	"";
String	strSql										=	"";
String	strTravelFrom								=	"";
String	strTravelTo									=	"";
String	strReq										=	"";
String	strReqComments								=	"";
String  TType										=	"";
strRequistionId										=	request.getParameter("purchaseId");
strReqComments										=	request.getParameter("COMMENTS");
String ReqTyp										=	request.getParameter("ReqTyp");
String ReqTyp1="";
if(ReqTyp.equals("Domestic Travel")){
	ReqTyp1="label.mail.domestictravel";
}else{
	ReqTyp1="label.mail.internationaltravel";
}

String strGroupTravelFlag					="";
String strGroupTravel							="";
String strmailTo1= request.getParameter("toMail");
//@Vijay 05/04/2007 no multiple mails sent to same user
// fetching value from tomail text area
String strmailTo				="";									
String samicolan=";";
String strLanguage	=	"";
//Set set=new HashSet(); 
List set=new ArrayList(); 

		String arrayOfStrings[]= new String[20];
		arrayOfStrings=strmailTo1.split(samicolan);
				
		for (int i=0;i< arrayOfStrings.length;i++) 
		{ 
			set.add(arrayOfStrings[i]);
			
		}


		//System.out.println("list for approver===== "+set);
		Iterator iter = set.iterator();
		while (iter.hasNext())
		{
			strmailTo+=(String)iter.next()+";"; 
		}

		//System.out.println("strmailTo================"+strmailTo);
		//END MODIFICATION
		
String strmailToName								= request.getParameter("mailToName");
String []temp1=null;
String [] temp = null;
String strMailSplit = "";
String strNameSplit="";
temp = strmailTo.split(";");
temp1 = strmailToName.split(";");
int j=0;
// code ends  

String strCreationDate ="";



//Requistion Details
sSqlStr="SELECT ISNULL(MAX(MAIL_ID),'999')+1 FROM REQ_MAILBOX";
stmt = con.createStatement(); 
rs = stmt.executeQuery(sSqlStr);
	if(rs.next())
	{
		strMailRefNumber								=	rs.getString(1);//Mail Reference Number
	}
	rs.close();
stmt.close();

%>
 <link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css">
<body class="body" > 
<%
					// FETCH Requistion Details
					//Change in Database Query add Convert function 
					
					//@Vijay 04/04/2007
	if(ReqTyp.equals("Domestic Travel"))
	{
		TType="Domestic Travel Requisition No:";//added by vijay on 09/04/2007
		sSqlStr="SELECT TRAVEL_REQ_NO ,.DBO.user_name(C_USERID) AS ORIGINATOR,DBO.USEREMAIL(C_USERID)AS ORIGINATOR_MAIL,.DBO.USER_NAME('"+Suser_id+"') AS APPROVER_NAME,DBO.USEREMAIL('"+Suser_id+"') AS APPROVER_MAIL,CONVERT(VARCHAR(30),C_DATETIME,113),.DBO.USER_NAME(TRAVELLER_ID) AS TRAVELLER_NAME ,convert(varchar(10),TRAVEL_DATE,103),SEX ,.DBO.SITENAME(SITE_ID) AS SITE_NAME,GROUP_TRAVEL_FLAG   FROM T_TRAVEL_DETAIL_DOM  WHERE TRAVEL_ID="+strRequistionId+"";
	}
else
	{
		TType="International Travel Requisition No:";//added by vijay on 09/04/2007
		sSqlStr="SELECT TRAVEL_REQ_NO ,.DBO.user_name(C_USERID) AS ORIGINATOR,DBO.USEREMAIL(C_USERID)AS ORIGINATOR_MAIL,.DBO.USER_NAME('"+Suser_id+"') AS APPROVER_NAME,DBO.USEREMAIL('"+Suser_id+"') AS APPROVER_MAIL,CONVERT(VARCHAR(30),C_DATETIME,113),.DBO.USER_NAME(TRAVELLER_ID) AS TRAVELLER_NAME ,convert(varchar(10),TRAVEL_DATE,103),SEX ,.DBO.SITENAME(SITE_ID) AS SITE_NAME,GROUP_TRAVEL_FLAG   FROM T_TRAVEL_DETAIL_INT  WHERE TRAVEL_ID="+strRequistionId+"";
	}


		//System.out.println("when returned.777777777777777."+sSqlStr);
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
	
				//@ Vijay 03/04/2007 Add the substring Method for time format
					
					String strRCDate= strRequistionCreatedDate1.substring(0,17);
					strRequistionCreatedDate	=	strRCDate;
				//End Modification			
					strUserNm			 		=	rs.getString(7);//TRAVELLER NAME
					strTravelDate				=	rs.getString(8); // TRAVEL DATE
					strTravellerSex				=	rs.getString(9); // TRAVELLER SEX
					strSiteName					=	rs.getString(10); //site name
							
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
		//strSql	=	"SELECT TRAVEL_FROM,TRAVEL_TO FROM T_JOURNEY_DETAILS_DOM WHERE TRAVEL_ID="+strRequistionId+"	";
		strSql ="select * FROM  [dbo].[FN_GetDeparturecity]("+strRequistionId+",'d')";
						  //strGroupTravel = strSex+" "+"<b>"+strUserNm+ "</b> is scheduled to travel.";
						 // Code added for showing group travel  in case of domestie group travel_DOM  on shiv sharma on 19-Jun-08

						  strGroupTravelFlag       =   rs.getString("GROUP_TRAVEL_FLAG"); 
										 if(strGroupTravelFlag==null) 	{
										   strGroupTravel =""; 
											 }
										if(strGroupTravelFlag!=null  &&  (strGroupTravelFlag.trim().equals("Y"))){
											strGroupTravel ="A <B>Group/Guest</b> is scheduled to travel.";
											}
										else {
											  strGroupTravel = strSex+" "+"<b>"+strUserNm+ "</b> is scheduled to travel.";
										 }
				}
			else
							{
							 //  Added by shiv for showing Group Travel in case of group travel   on 02-Jul-08 ;  
					
							  strGroupTravelFlag       =   rs.getString("GROUP_TRAVEL_FLAG"); 
								 if(strGroupTravelFlag==null) 
									{
								   strGroupTravel =""; 
									 }
								 if(strGroupTravelFlag!=null  &&  (strGroupTravelFlag.trim().equals("Y")))
									{
									//strGroupTravel ="Group "; 
									strGroupTravel ="A <B>Group/Guest</b> is scheduled to travel.";
									}
									else
									  {
										// strGroupTravel =""; 
										  strGroupTravel = strSex+" "+"<b>"+strUserNm+ "</b> is scheduled to travel.";
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

		

		
                     strCreationDate=strMailCreatedate;
                     String strSSOUrl=""; //Added by vaibhav
                  //Change the mail subject 09/04/2007 @ vijay 
					//strMailSubject="STARS Notification: "+TType+" '"+ strRequistionNumber.trim()+"' Request for More Information ";//Mail Subject

		 for (int i = 0 ; i < temp.length ; i++) {
			 
			//added by manoj chand on 15 june 2012 to get mail to person language preference
				strSql	=	"SELECT LANGUAGE_PREF FROM M_USERINFO WHERE EMAIL =N'"+temp[i]+"' AND STATUS_ID=10";
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
				strMailSubject=dbLabelBean.getLabel("label.mail.starsnotification",strLanguage)+" "+TType+" '"+ strRequistionNumber.trim()+"' "+dbLabelBean.getLabel("label.mail.requestformoreinformation",strLanguage)+" ";//Mail Subject
							StringBuffer strMailMsg	= new StringBuffer();	
						try
						{ 
					strSSOUrl = dbutility.sSSOUrlByMailid(temp[i]);
					strMailMsg.append("<html><style>.formhead{ font-family:Arial;font-size:11px;font-style: normal;font-weight:normal;color:#000000;text-decoration:none;letter-spacing:normal;word-spacing:normal;border:1px #333333 solid;background:#E2E4D6;}</style><body bgcolor=\"#99CC66\">" + "\n");
					strMailMsg.append(" <table width=80% border=0 cellspacing=0 cellpadding=0 align=center><tr><td align=right><font face=Verdana, Arial, Helvetica, sans-serif size=2><b><font color=#FFFFFF>"+strCreationDate+"</font><font color=#FFFFFF></font><font color=#000000><br></font></b><font color=#FFFFFF>"+dbLabelBean.getLabel("label.mail.forinternalcirculationonly",strLanguage)+"</font></font></td></tr><tr><td bgcolor=#000000></td></tr><tr><td bgcolor=#FFFFFF align=center>"+ "\n");
					strMailMsg.append("</td></tr><tr><td bgcolor=#000000></td></tr><tr><td bgcolor=#FFFFFF align=center><table width=100% border=0 cellspacing=0 cellpadding=15><tr><td align=center bgcolor=#3A7676><font face=Arial, Helvetica, sans-serif size=5 color=#FFFFFF>"+dbLabelBean.getLabel("label.mail.starsmailnotification",strLanguage)+"</font></td></tr></table></td></tr><tr><td bgcolor=#000000></td></tr><tr>"+ "\n");
					strMailMsg.append("<td bgcolor=#B6DCDC></td></tr><tr><td bgcolor=#000000></td></tr><tr></td></tr><tr><td bgcolor=#FFFFFF><table width=100% border=0 cellspacing=0 cellpadding=5>"+ "\n");
					strMailMsg.append("  <tr><td align=center bgcolor=#3A7676><font face=Verdana, Arial, Helvetica, sans-serif size=2><b><font color=#FFFFFF><font size=3>"+dbLabelBean.getLabel(ReqTyp1,strLanguage)+" "+dbLabelBean.getLabel("label.mail.requisition",strLanguage)+"</font> </font></b></font></td></tr><tr><td bgcolor=#A8D5D5><font face=Verdana, Arial, Helvetica, sans-serif size=2><b>"+dbLabelBean.getLabel("label.mail.travelrequisitionnumber",strLanguage)+" : "+strRequistionNumber.trim()+"</b>("+dbLabelBean.getLabel("label.mail.dated",strLanguage)+" : "+strRequistionCreatedDate+")</font></td></tr><tr><td><p><font color=#FFFFFF>.</font><font size=2 face=Verdana, Arial, Helvetica, sans-serif><br>"+ "\n"); 
					strMailMsg.append(" "+dbLabelBean.getLabel("label.mail.dear",strLanguage)+" "+temp1[i]+",</font></p><p><font size=2 face=Verdana, Arial, Helvetica, sans-serif>"+dbLabelBean.getLabel("label.mail.iwouldliketorequestformoreinfo",strLanguage)+" "+strRequistionNumber.trim()+" "+dbLabelBean.getLabel("label.mail.whichwasgeneratedby",strLanguage)+" "+strRequistionCreatorName+" "+dbLabelBean.getLabel("label.mail.from",strLanguage)+" "+strSiteName+" "+dbLabelBean.getLabel("label.mail.on",strLanguage)+" "+strRequistionCreatedDate+" </p>"+ "\n"); 	
					strMailMsg.append("<u><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>"+dbLabelBean.getLabel("label.mail.requisitionsdetails",strLanguage)+":-</font></u><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif >"+strGroupTravel+"<br> "+dbLabelBean.getLabel("label.mail.departuredateis",strLanguage)+" "+strTravelDate+".  </font>\n<br>"); 
					strMailMsg.append("<u><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>"+dbLabelBean.getLabel("label.global.departurecity",strLanguage)+":-</font></u><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif >"+strTravelFrom+" </font>\n<br>"); 
					strMailMsg.append("<u><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>"+dbLabelBean.getLabel("label.global.arrivalcity",strLanguage)+":-</font></u><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif >"+strTravelTo+" </font>\n<br>"); 
					//Commented by vaibhav
					//strMailMsg.append("<br><br><FONT COLOR=BLUE><U>Please find my request as follows:-</U></font><br>"+strReqComments+"<font size=2 face=Verdana, Arial, Helvetica, sans-serif></font></p><font size=2 face=Verdana, Arial, Helvetica, sans-serif><a href=\"http://stars.mindeservices.com\">Please click here to login to STARS </a> "+ "\n");    
					strMailMsg.append("<br><br><FONT COLOR=BLUE><U>"+dbLabelBean.getLabel("label.mail.pleasefindmyrequestasfollows",strLanguage)+":-</U></font><br>"+strReqComments+"<font size=2 face=Verdana, Arial, Helvetica, sans-serif></font></p><font size=2 face=Verdana, Arial, Helvetica, sans-serif><a href='"+strSSOUrl+"'>"+dbLabelBean.getLabel("label.mail.pleaseclickheretologintostars",strLanguage)+" </a> "+ "\n");    
					strMailMsg.append("   </b></form></font><br><p><font size=2 face=Verdana, Arial, Helvetica, sans-serif>"+dbLabelBean.getLabel("label.mail.bestregards",strLanguage)+"</font><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif>"+strstrRequistionApproverName.trim()+"<br></font></p></td></tr></table></td></tr><tr><td bgcolor=#A8D5D5 align=center> <font face=Verdana, Arial, Helvetica, sans-serif size=2><b>"+dbLabelBean.getLabel("label.mail.mailreferencenumber",strLanguage)+" </b>"+strMailRefNumber+"/"+strCurrentYear+"</font></td></tr><tr><td bgcolor=#FFFFFF align=center>       <table width=100% border=0 cellspacing=0 cellpadding=12>"+ "\n"); 
					strMailMsg.append("<tr><td align=center bgcolor=#FFCC66><font size=2 face=Verdana, Arial, Helvetica, sans-serif><b><font size=1>"+dbLabelBean.getLabel("label.mail.starsadministratorcanbecontacted",strLanguage)+" : - </font></b><font size=1><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=#000000>"+ "\n"); 
					strMailMsg.append("<a href=mailto:administrator.stars@mind-infotech.com><font size=1>administrator.stars@mind-infotech.com</font></a></font></font></font></td>  "+ "\n");  
					strMailMsg.append(" </tr><tr><td  align=center bgcolor=#CCCC99 height=55> <b><font size=1 face=Verdana, Arial, Helvetica, sans-serif>"+dbLabelBean.getLabel("label.mail.disclaimer",strLanguage)+" : "+dbLabelBean.getLabel("label.mail.thiscommunicationissystemgenererated",strLanguage)+" "+ "\n");  
					strMailMsg.append(dbLabelBean.getLabel("label.mail.pleasedonnotreplytothismail",strLanguage)+" <br>"+dbLabelBean.getLabel("label.mail.ifyouarenotthecorrectrecipient",strLanguage)+"</font></b></td></tr></table></td></tr><tr><td bgcolor=#000000></td></tr>"+ "\n");    
					strMailMsg.append("<tr><td align=center><font size=2 face=Verdana, Arial, Helvetica, sans-serif><font size=1 color=#000000>&copy;"+dbLabelBean.getLabel("label.mail.mindallrightsreserved",strLanguage)+"</font></font></td>  </tr></table><p>&nbsp;</p></body></html>"+ "\n");
																
			    // Loop to insert value in the database,individually for each recepitent a entry is made		  
					  
					 
					
									try
										{
											//Procedure for inserting Mail Data
											cstmt_mail=con.prepareCall("{?=call PROC_REQUISITION_MAIL_ADD(?,?,?,?,?,?,?,?,?,?,?,?)}");
											cstmt_mail.registerOutParameter(1,java.sql.Types.INTEGER);
											cstmt_mail.setString(2, strRequistionId);
											cstmt_mail.setString(3, strRequistionNumber);
											cstmt_mail.setString(4, temp[i]);//To
											cstmt_mail.setString(5, strstrRequistionApproverEmail);//From
											cstmt_mail.setString(6, strstrRequistionApproverEmail);//CC
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
											System.out.println("ERROR in reqRequestMoreInfoSubmit.jsp---1--------"+b);		
										}
								
					
								}
								catch(Exception e)
								{
								out.println("ERROR in reqRequestMoreInfoSubmit.jsp---2--------"+e);
								}
					  }
								}
			rs.close();
			stmt.close();
%>

	<table width="90%" border="0" align="center" cellpadding="0" cellspacing="2" class="selectedmenubg">

<tr><td class="frmlabelsblue" align=center> <%=dbLabelBean.getLabel("label.requestdetails.mailhasbeensent",strsesLanguage)%><br><br><br><a href="#" onClick="window.close();"><%=dbLabelBean.getLabel("button.approverequest.closewindow",strsesLanguage)%></a></tr></td></table>