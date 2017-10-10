<%
/***************************************************
**** The information contained here in is confidential and ******
**** proprietary to MIND and forms the part of the MIND ****** 
*Author			  :Rohit Ganjoo
*Date of Creation : 02/09/2006

**** Copyright Notice :Copyright(C)2000 MIND.All rights reserved. ******
**** Project	  : STAR ****** 
**** Operating environment :Tomcat, sql server 2000 ******
**** Description : This is the second jsp file for transferng reqs  ******
**** Modification : ******
**** Reason of Modification : changed by shiv from 'transfered' to 'transferred'  
							:2. sapreted by comma when more then one requisitions are selected
**** Date of Modification   : on 3/21/2007,14/04/2007
**** Modified By			: Vijay Singh
**** Revision History		: none******
**** Editor					:Editplus ******
Modified by vaibhav on jul 19 2010 to enable SSO in Mails

**** Modified By			: Manoj Chand
**** Modification Date		: 11 may 2011
**** Modification			: modify the page to provide handover comments on requisitions details page.

**** Modified By			: Manoj Chand
**** Modification Date		: 04 July 2012
**** Modification			: Resolve issue of handover mail was not shown in mails list when multiple request are handovered.
**********************************************************/
%>
<%@ page pageEncoding="UTF-8" %>
<%@ include  file="importStatement.jsp"%>
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
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
<jsp:useBean id="dbUtilityBean" scope="page" class="src.connection.DbUtilityMethods" /> <!-- Added by vaibhav -->
<jsp:useBean id="securityUtilityBean" scope="page" class="src.connection.SecurityUtilityMethods" />


<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
</head>
<%
request.setCharacterEncoding("UTF-8");
// Variables declared and initialized
Connection con					=		null;			    // Object for connection
Statement stmt,stmt2			=		null;			   // Object for Statement
ResultSet rs,rs2				=		null;			  // Object for ResultSet
CallableStatement cstmt			=		null;			// Object for Callable Statement

//Create Connection
Class.forName(Sdbdriver);
con=DriverManager.getConnection(Sdburl,Sdbuser,Sdbpwd);
String	strSqlStr=""; // For sql Statements
String strCount					=	""; //object to store no of rows selected
int	   intCount					=	0;
String strCheck				    =	"";
String strDelegateName			=	"";
String strCheckValue            =   "";
String strTravelId              =   "";
String strTravellerId           =   "";
String strAutoTransferMechanism =   "";
String strTraveltype            =   "";
String	strTravel	            =   "";

String strAllRequsitionNo       =   "";  //new fields
String strTempRequsitionNo      =   "";  //new fields
String strCreationDate			=	"";  //Added by shiv on 3/21/2007
String strLanguage				=	"";

//Added By Gurmeet Singh
String strUserAccessCheckFlag = "";

strDelegateName					=	request.getParameter("delName");
strCount	 					=	request.getParameter("count");	// GET COUNT
intCount						=	Integer.parseInt(strCount);	//get int value for count
//System.out.println("intCount-----------------------------------------------------------------------"+intCount);
strAutoTransferMechanism		=	request.getParameter("reasons");
strTraveltype					=   request.getParameter("travel_type");
//System.out.println("strTraveltype------------------------------------------------------------------"+strTraveltype);
if(strTraveltype.equalsIgnoreCase("I"))
{
strTravel	 =	 "International Travel";
}
else
{
strTravel	 =	 "Domestic Travel";
}

 /* try
		{   
	  		System.out.println("strTravelId------>"+strTravelId);
			cstmt=con.prepareCall("{?=call PROC_APP_AUTOTRANSFER_STATUSUPDATE(?,?,?,?,?,?)}");
			cstmt.registerOutParameter(1,java.sql.Types.INTEGER);
    		cstmt.setString(2, strTravelId);
	    	cstmt.setString(3, Suser_id);
			cstmt.setString(4, strDelegateName);	
			cstmt.setString(5, strAutoTransferMechanism);
			cstmt.setString(6, strTraveltype);
			cstmt.setString(7, strTravellerId);
			cstmt.execute();
			cstmt.close();
		}
		catch(Exception erEx)
		{
			System.out.println("Error in T_purchaseReqTransferPost.jsp========================"+erEx);
		}*/

		//System.out.println("value of intCount-----1---->"+intCount);
for (int j=1;j<=intCount;j++ )
{
	strCheckValue =  "";  //set blank value;

	if((request.getParameter("chk"+j)!=null) && !(request.getParameter("chk"+j)).equals(""))
	{
		strCheckValue = request.getParameter("chk"+j);
	}
	//System.out.println("strCheck value ========================"+strCheckValue);
	if(strCheckValue!=null && !strCheckValue.equals(""))
	{
      StringTokenizer token = new StringTokenizer(strCheckValue,";"); 
	  while(token.hasMoreTokens())
	  {
		  strTravelId     =  token.nextToken();
		  strTravellerId  =  token.nextToken();		 
	  }  //--end of while
		  
	//Added By Gurmeet Singh
	  strUserAccessCheckFlag = securityUtilityBean.validateAuthSiteUserAccess(strDelegateName, strSiteIdSS, "0");	
	  if(!strUserAccessCheckFlag.equals("420")){
		  strUserAccessCheckFlag = securityUtilityBean.validateAuthHandover(strTravelId, strTraveltype, strTravellerId, Suser_id);  
	  }
	  if(strUserAccessCheckFlag.equals("420")){	
	  	dbConBean.close();  
	  	dbConBean1.close();
	  	securityUtilityBean.registerUnauthAccessLog(Suser_id, request.getRemoteAddr(), "T_purchaseReqTransferPost.jsp", "Unauthorized Access");
	  	response.sendRedirect("UnauthorizedAccess.jsp");	
	  	return;
	  } 
	   
	  if(strTraveltype != null && strTraveltype.equals("I"))
	  {
		  strSqlStr = "SELECT TRAVEL_REQ_NO FROM T_TRAVEL_DETAIL_INT WHERE TRAVEL_ID="+strTravelId+" AND STATUS_ID=10 AND APPLICATION_ID=1";	
	  }
	  else
	  {
  		  strSqlStr = "SELECT TRAVEL_REQ_NO FROM T_TRAVEL_DETAIL_DOM WHERE TRAVEL_ID="+strTravelId+" AND STATUS_ID=10 AND APPLICATION_ID=1";	
	  }
	  //System.out.println("==================================="+strSqlStr); 
	  rs = dbConBean.executeQuery(strSqlStr);	
	  if(rs.next())
	  {
		  if(j > 1)
		  {
			  if(strAllRequsitionNo.equalsIgnoreCase(""))
			 	  strAllRequsitionNo = strAllRequsitionNo+"";
			  else
				  strAllRequsitionNo = strAllRequsitionNo+", ";
		  }
		  else
		  {
				strAllRequsitionNo = strAllRequsitionNo;
		  }
		  strTempRequsitionNo = rs.getString("TRAVEL_REQ_NO");
		  strAllRequsitionNo = strAllRequsitionNo + strTempRequsitionNo;
		  
		// Added  by manoj on 11 may 2011
		
		try
		{   
	  		//System.out.println("strTravelId------>"+strTravelId);
			cstmt=con.prepareCall("{?=call PROC_APP_AUTOTRANSFER_STATUSUPDATE(?,?,?,?,?,?)}");
			cstmt.registerOutParameter(1,java.sql.Types.INTEGER);
    		cstmt.setString(2, strTravelId);
	    	cstmt.setString(3, Suser_id);
			cstmt.setString(4, strDelegateName);	
			cstmt.setString(5, strAutoTransferMechanism);
			cstmt.setString(6, strTraveltype);
			cstmt.setString(7, strTravellerId);
			cstmt.execute();
			cstmt.close();
		}
		catch(Exception erEx)
		{
			System.out.println("Error in T_purchaseReqTransferPost.jsp========================"+erEx);
		}
		
		// End Here
	  }
	  rs.close();

	  if(request.getParameter("transType"+j).trim().equals("REQS"))
	  {
		try
		{
			//System.out.println(" **************** In transfer procedure **************************");
		
			cstmt=con.prepareCall("{?=call PROC_APP_AUTOTRANSFER(?,?,?,?,?,?)}");
    		cstmt.registerOutParameter(1,java.sql.Types.INTEGER);
			cstmt.setString(2, strTravelId);
			//System.out.println("strTravelId in Procedure Update "+strTravelId);
			cstmt.setString(3, strTravellerId);
			//System.out.println("strTravelId in Procedure Update "+strTravellerId);
			cstmt.setString(4, strDelegateName);
			//System.out.println("strTravelId in Procedure Update "+strDelegateName);
			cstmt.setString(5, Suser_id);	
			//System.out.println("strTravelId in Procedure Update "+Suser_id);
			cstmt.setString(6, strAutoTransferMechanism);
			//System.out.println("strTraveltype inside procedure11"+strAutoTransferMechanism);
			cstmt.setString(7, strTraveltype);
			//System.out.println("strTravelId in Procedure Update "+strTraveltype);
				
            //System.out.println("Before execute");
			cstmt.execute();
			 //System.out.println("after execute");
			cstmt.close();
			//System.out.println("********************************* in Transfer Procedure Ends *********************");
		}
		catch(Exception e_2)
		{
			System.out.println("Error in T_purchaseReqTransferPost.jsp =======0========"+e_2);
		}
	  } //end of third if
	}  //end of second if
} //end of for


String strpType = request.getParameter("pType");
/*************************************Mails ************************************************/

String strUserTransferedTo		=	"";
String strUserTransferedToMail	=	"";
String strUserTransferedBy		=	"";
String strUserTransferedByMail	=	"";
String strRequistionCreatedDate	=	"";
String strMailRefNumber			=	"";
strSqlStr="SELECT DBO.USER_NAME('"+strDelegateName+"')AS TRANSTO,DBO.USER_NAME('"+Suser_id+"')AS TRANSFROM,DBO.USEREMAIL('"+strDelegateName+"')AS TRNSTOMAIL,DBO.USEREMAIL('"+Suser_id+"')AS TRANSFROM,DBO.CONVERTDATE(GETDATE()),DBO.MAILREFNUMBER()+1";

stmt = con.createStatement(); 
rs = stmt.executeQuery(strSqlStr);
while(rs.next())
{
strUserTransferedTo		=	rs.getString(1);
strUserTransferedBy		=	rs.getString(2);
strUserTransferedToMail	=	rs.getString(3);
strUserTransferedByMail	=	rs.getString(4);
strRequistionCreatedDate=	rs.getString(5);
strMailRefNumber		=	rs.getString(6);
}
rs.close();
stmt.close();

StringBuffer strMailMsg							= new StringBuffer();
String strMailSubject	="";

 strCreationDate=strMailCreatedate;//added by shiv on 3/21/2007 
try
{	 
	String strSSOUrl = dbUtilityBean.sSSOUrlByMailid(strUserTransferedToMail.trim()); //Added by vaibhav

	//added by manoj chand on 20 june 2012 to get mail to person language preference
	strSqlStr	=	"SELECT LANGUAGE_PREF FROM M_USERINFO WHERE EMAIL =N'"+strUserTransferedToMail+"' AND STATUS_ID=10";
	stmt2= con.createStatement(); 
	rs2 = stmt2.executeQuery(strSqlStr);
	if(rs2.next()){
		strLanguage=rs2.getString("LANGUAGE_PREF");
		if(strLanguage==null || strLanguage.equals("")){
			strLanguage="en_US";
		}
	}
	rs2.close();
	stmt2.close();

	
	
	
strMailSubject=dbLabelBean.getLabel("label.mail.starsnotification",strLanguage)+" "+strTravel+" "+dbLabelBean.getLabel("label.mail.requisitions",strLanguage)+": '"+strAllRequsitionNo.trim()+"' "+dbLabelBean.getLabel("label.mail.pendingforapprovalhasbeenhandedovertoyou",strLanguage)+" ";//Mail Subject 
//Mail Body Content         // changed by shiv from 'transfered' to 'transferred'  on 3/21/2007
strMailMsg.append("<html><style>.formhead{ font-family:Arial;font-size:11px;font-style: normal;font-weight:normal;color:#000000;text-decoration:none;letter-spacing:normal;word-spacing:normal;border:1px #333333 solid;background:#E2E4D6;}</style><body bgcolor=\"#99CC66\">" + "\n");
strMailMsg.append(" <table width=80% border=0 cellspacing=0 cellpadding=0 align=center><tr><td align=right><font face=Verdana, Arial, Helvetica, sans-serif size=2><b><font color=#FFFFFF>"+strCreationDate+"</font><font color=#FFFFFF></font><font color=#000000><br></font></b><font color=#FFFFFF>"+dbLabelBean.getLabel("label.mail.forinternalcirculationonly",strLanguage)+"</font></font></td></tr><tr><td bgcolor=#FFFFFF align=center>"+ "\n");
strMailMsg.append("</td></tr><tr><td bgcolor=#FFFFFF align=center><table width=100% border=0 cellspacing=0 cellpadding=15><tr><td align=center bgcolor=#3A7676><font face=Arial, Helvetica, sans-serif size=5 color=#FFFFFF>"+dbLabelBean.getLabel("label.mail.starsmailnotification",strLanguage)+"</font></td></tr></table></td></tr><tr>"+ "\n");
strMailMsg.append("<td bgcolor=#B6DCDC></td></tr><tr><td bgcolor=#FFFFFF><table width=100% border=0 cellspacing=0 cellpadding=5>"+ "\n");
strMailMsg.append("  <tr><td align=center bgcolor=#3A7676><font face=Verdana, Arial, Helvetica, sans-serif size=2><b><font color=#FFFFFF><font size=3>"+dbLabelBean.getLabel("label.mail.requisitionhandoverinfo",strLanguage)+" </font> </font></b></font></td></tr><tr><td bgcolor=#A8D5D5><font face=Verdana, Arial, Helvetica, sans-serif size=2><b></b></font></td></tr><tr><td><p><font color=#FFFFFF>.</font><font size=2 face=Verdana, Arial, Helvetica, sans-serif><br>"+ "\n"); 
strMailMsg.append(" "+dbLabelBean.getLabel("label.mail.dear",strLanguage)+" "+strUserTransferedTo+",</font></p><p><font size=2 face=Verdana, Arial, Helvetica, sans-serif>"+dbLabelBean.getLabel("label.mail.following",strLanguage)+" "+strTravel+" "+dbLabelBean.getLabel("label.mail.pendingrequisitionshavebeenhandedover",strLanguage)+"<br>");
strMailMsg.append("<br><b> "+dbLabelBean.getLabel("label.search.requisitionno",strLanguage)+":-</b>"+strAllRequsitionNo.trim()+".<br><br><br>"); 
strMailMsg.append("<b> "+dbLabelBean.getLabel("label.mail.reason",strLanguage)+" :-</b>"); 
strMailMsg.append(""+strAutoTransferMechanism+".<br><br>"); 
//Commented by vaibhav
//strMailMsg.append("<br><A HREF=http://stars.mindeservices.com>Please click here to login to STARS</A>"+ "\n"); 
strMailMsg.append("<br><a href='"+strSSOUrl+"'>"+dbLabelBean.getLabel("label.mail.pleaseclickheretologintostars",strLanguage)+" </a>"+ "\n"); 
strMailMsg.append("   </b></form></font><br><p><font size=2 face=Verdana, Arial, Helvetica, sans-serif>"+dbLabelBean.getLabel("label.mail.bestregards",strLanguage)+"</font><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif>"+strUserTransferedBy+"<br></font></p></td></tr></table></td></tr><tr><td bgcolor=#A8D5D5 align=center> <font face=Verdana, Arial, Helvetica, sans-serif size=2><b>"+dbLabelBean.getLabel("label.mail.mailreferencenumber",strLanguage)+" </b>"+strMailRefNumber+"/"+strCurrentYear+"</font></td></tr><tr><td bgcolor=#FFFFFF align=center>       <table width=100% border=0 cellspacing=0 cellpadding=12>"+ "\n"); 
strMailMsg.append("<tr><td align=center bgcolor=#FFCC66><font size=2 face=Verdana, Arial, Helvetica, sans-serif><b><font size=1>"+dbLabelBean.getLabel("label.mail.starsadministratorcanbecontacted",strLanguage)+" : - </font></b><font size=1><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=#000000>"+ "\n"); 
strMailMsg.append("<a href=mailto:administrator.stars@mind-infotech.com><font size=1>administrator.stars@mind-infotech.com</font></a></font></font></font></td>  "+ "\n");  
strMailMsg.append(" </tr><tr><td  align=center bgcolor=#CCCC99 height=55> <b><font size=1 face=Verdana, Arial, Helvetica, sans-serif>"+dbLabelBean.getLabel("label.mail.disclaimer",strLanguage)+": "+dbLabelBean.getLabel("label.mail.thiscommunicationissystemgenererated",strLanguage)+" "+ "\n");  
strMailMsg.append(dbLabelBean.getLabel("label.mail.pleasedonnotreplytothismail",strLanguage)+" <br>"+dbLabelBean.getLabel("label.mail.ifyouarenotthecorrectrecipient",strLanguage)+"</font></b></td></tr></table></td></tr>"+ "\n");    
strMailMsg.append("<tr><td align=center><font size=2 face=Verdana, Arial, Helvetica, sans-serif><font size=1 color=#000000>&copy;"+dbLabelBean.getLabel("label.mail.mindallrightsreserved",strLanguage)+"</font></font></td>  </tr></table><p>&nbsp;</p></body></html>"+ "\n");


		try
		{
				//Procedure for inserting Mail Data
				cstmt=con.prepareCall("{?=call PROC_REQUISITION_MAIL_ADD(?,?,?,?,?,?,?,?,?,?,?,?)}");
				cstmt.registerOutParameter(1,java.sql.Types.INTEGER);
				cstmt.setString(2, strTravelId);           //travelId
				cstmt.setString(3, strAllRequsitionNo);                //travel_no 
				cstmt.setString(4, strUserTransferedToMail.trim());//To
				cstmt.setString(5, strUserTransferedByMail);//From
				cstmt.setString(6,  "");  //CC mail  Address  remove by Shiv  Sharma on 31-Mar-08
 				cstmt.setString(7, strMailSubject.trim());
				cstmt.setString(8, strMailMsg.toString());
				cstmt.setInt(9, 0);
				cstmt.setString(10, "NEW");
				cstmt.setString(11, Suser_id);
				cstmt.setString(12, "New");
				cstmt.setString(13, "Requisition / Sanction Transfer");
				cstmt.execute();
				cstmt.close();
		}
		catch(Exception b)
		{
			System.out.println("Error in T_purchaseReqTransferPost.jsp =======1========"+b);
		}	
}
catch(Exception e)
{
	System.out.println("Error in T_purchaseReqTransferPost.jsp =======2========"+e);
}

//Close All Connection
dbConBean.close();
%>
<body onLoad="subForm();">
<SCRIPT LANGUAGE="JavaScript">
function subForm()
{
document.frm1.submit();
}
</SCRIPT>
<%
  if(strTraveltype.equals("I"))
  {
%>
  <form method=post name="frm1" action="T_transferMain.jsp">
<%
  }
  else
  {
	  ///System.out.println("iam in else");
%>
   <form method=post name="frm1" action="T_transferMain_D.jsp">
   
<%
  }
%>
<input type="hidden" name="pType" value="<%=strpType%>"> 
<input type="hidden" name="travel_type" value="<%=strTraveltype%>"> 
<input type="hidden" name="travel_id" value="<%=strTravelId%>"> 
<input type="hidden" name="traveller_id" value="<%=strTravellerId%>"> 
</form>