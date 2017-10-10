<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:SACHIN GUPTA
 *Date of Creation 		:05 September 2006
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This is first jsp file  for add Comment with the travel requisition in TRAVEL_COMMENT Table of the STAR Database
 *Modification 			:1.Add the cancellation comments 
                                 2. Added by shiv for showing Group Travel in case of group travel inspite of traveller Name on 04-Mar-08 ;  
								 3: added  for showing group travel in case of group travel instead of traveller name by shi sharma on 02-Jul-08
 *Reason of Modification: 
 *Date of Modification  : 23/Mar/2007
 *Modified By			:VIJAY SINGH
 *Revision History		:
 *Editor				:Editplus
 						:By Vaibhav on sep 22 2010 to add cc mails on request origination
 						
 *Modified By			:Manoj Chand 
 *Date of Modification	:22 Sept 2011
 *Modification 			:Change label Email to cc(Initial) with (on Submission) and for mata (on Received by Mata)
 *******************************************************/
%>
<%@ page pageEncoding="UTF-8" %>
<%@page import="java.net.URLDecoder"%>

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
<%-- <%@ include  file="systemStyle.jsp" %> --%>

<!--Create the DbConnectionBean object for createConnection-->
<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<script>

function checkEnterOnBrowse()
{
	if(event.keyCode==13)
	{
		return false;
	}
	else
	{	
		
	}
}	  


function checkemail(){

	if('<%=SuserRole.equalsIgnoreCase("AD")%>'=='true') 
         { 
		if (document.frm.mail_ids.value!='')
		  {
			  var arrayOfStrings = new Array(70);
			
			  var email_ids=document.frm.mail_ids.value;

				  if (email_ids.indexOf(";")==-1)  //case of  single  mail   
				   {
						 var flag = echeckMultple(window.document.frm.mail_ids.value);
							if (flag == false)
							 {
									  document.frm.mail_ids.focus();
									   return false;
							 }
				   
				   }
				   else{  //case of multpiltpe mail id  
						 
							 arrayOfStrings=email_ids.split(";");
							  for(i=0;i<arrayOfStrings.length;i++) 
								  { 
									  var flag = echeckMultple(arrayOfStrings[i]);
									   if (flag == false)
											   {
													document.frm.mail_ids.focus();
													return false;
												 }
								   }
					 
				   } 
			}
		//condition added By Vaibhav on sep 22 2010 to add cc mails on request origination
		if (document.frm.mail_ids_initial.value!='')
		  {
			  var arrayOfStrings = new Array(70);
			
			  var email_ids=document.frm.mail_ids_initial.value;

				  if (email_ids.indexOf(";")==-1)  //case of  single  mail   
				   {
						 var flag = echeckMultple(window.document.frm.mail_ids_initial.value);
							if (flag == false)
							 {
									  document.frm.mail_ids_initial.focus();
									   return false;
							 }
				   
				   }
				   else{  //case of multpiltpe mail id  
						 
							 arrayOfStrings=email_ids.split(";");
							  for(i=0;i<arrayOfStrings.length;i++) 
								  { 
									  var flag = echeckMultple(arrayOfStrings[i]);
									   if (flag == false)
											   {
													document.frm.mail_ids_initial.focus();
													return false;
												 }
								   }
					 
				   } 
			}	
}
}

</script>

</head>
<%
// Variables declared and initialized

String strTravelType   =  "";
String strSiteid    =  "";
String strTargetFrame  =  "";
String strTargetFlag   =  "";
boolean showFlag=true;
strTravelType   =  request.getParameter("travel_type"); 

strSiteid    =  request.getParameter("site_id"); 
String strSprole = request.getParameter("strSprole");
//System.out.println("which strSiteid is=========="+strSiteid);

if(strTravelType != null && strTravelType.equals("INT"))   //set  the flag for international 'I'or domestic 'D'
{
   strTravelType = "I";
}
if(strTravelType != null && strTravelType.equals("DOM"))   
{
   strTravelType = "D";
}

// Variables declared and initialized
Connection con	=	null;			    // Object for connection
Statement stmt	=	null;			   // Object for Statement
ResultSet rs	=	null;			  // Object for ResultSet
//Create Connection
Class.forName(Sdbdriver);
con=DriverManager.getConnection(Sdburl,Sdbuser,Sdbpwd);

String	sSqlStr        		=   ""; // For sql Statements
String strRequisitionId		=	"";
String strMsg               =	URLDecoder.decode((request.getParameter("msg")==null ? "":request.getParameter("msg")), "UTF-8");
String strType  =	request.getParameter("wftype");
String strTypeReq=strType;
String strTrvType="";

//System.out.println("strMsg::"+strMsg);

if(strType!=null)
{
	if(strType.equalsIgnoreCase("1")){
		strTrvType="("+dbLabelBean.getLabel("label.report.domestic",strsesLanguage)+")";
		strType="D";
	} 
	else
	{
		strTrvType="("+dbLabelBean.getLabel("label.report.international",strsesLanguage)+")";
		strType="I";
	}
}
%>

<body >
<script type="text/javascript" language="JavaScript1.2" src="menu/menu_cnt.js?buildstamp=2_0_0"></script>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="77%" height="50" class="bodyline-top">
	<ul class="pagebullet">
      <li class="pageHead"><b><%=dbLabelBean.getLabel("label.administration.updateemailforccmail",strsesLanguage)%>  <%=strTrvType %><br><%=strMsg %></b></li>
    </ul></td>
    <td width="23%" align="right" valign="bottom" class="bodyline-top">
	<table width="39%" align="right" border="0" cellspacing="0" cellpadding="0"> 
      <tr align="right">
        
      </tr>
    </table>
	</td>
  </tr>
</table>

 <form name=frm action="T_showMataassociate_POST.jsp?strSprole=<%= strSprole%>&wftype=<%= strTypeReq %>" method=post> 
 <%
 sSqlStr="select count(*) from M_DEFAULT_APPROVERS where site_id='"+strSiteid+"' and sp_role='"+strSprole+"' and trv_type='"+strType+"' and status_id=10 and application_id=1";
 rs = dbConBean.executeQuery(sSqlStr);
 if(rs.next())
 {
	 if(rs.getInt(1)==1)
		 showFlag=false;
 }
 %>

  <%
  String strMailids="";	
	//sSqlStr="SELECT MDA.MATA_CC_MAIL as MATA_CC_MAIL , MDA.SITE_ID, MDA.TRV_TYPE, MDA.DESIG_ID, mD.DESIG_NAME, mD.DESIG_DESC " +
	  //     " FROM   M_DEFAULT_APPROVERS AS MDA INNER JOIN  M_DESIGNATION AS mD ON MDA.DESIG_ID = mD.DESIG_ID " +
		//" WHERE  (MDA.APPLICATION_ID = 1) AND (MDA.STATUS_ID = 10) AND (MDA.SITE_ID = '"+strSiteid+"') AND   "+ 
		//" (mD.DESIG_DESC = 'REQUISITION RECEIVER (MATA)') ORDER BY MDA.TRV_TYPE, MDA.ORDER_ID"; 
	sSqlStr="SELECT MDA.MATA_CC_MAIL as MATA_CC_MAIL , MDA.SITE_ID, MDA.TRV_TYPE, MDA.DESIG_ID FROM M_DEFAULT_APPROVERS AS MDA "+  
	" WHERE MDA.APPLICATION_ID = 1 AND MDA.STATUS_ID = 10 AND MDA.SITE_ID = '"+strSiteid+"' AND MDA.TRV_TYPE = '"+strType+"' AND MDA.ORDER_ID=(select max(order_id) from M_DEFAULT_APPROVERS MA where MA.site_id='"+strSiteid+"' and MA.STATUS_ID=10 and TRV_TYPE='"+strType+"' and sp_role='"+strSprole+"') and sp_role='"+strSprole+"' ORDER BY MATA_CC_MAIL";
	
		//System.out.print("test--->"+sSqlStr);

	 rs = dbConBean.executeQuery(sSqlStr);
	 int intSno=1;
	 while(rs.next())
	  {
		 strMailids=rs.getString("MATA_CC_MAIL");   
	  }
	 if(strMailids==null)
	 {
		 strMailids="";
	 }
%>
<% //Block added by Vaibhav on sep 22 2010 to add cc mails on request origination
  String strMailidsOnOriginating="";	
	//sSqlStr="SELECT MDA.MATA_CC_MAIL as MATA_CC_MAIL , MDA.SITE_ID, MDA.TRV_TYPE, MDA.DESIG_ID, mD.DESIG_NAME, mD.DESIG_DESC " +
	  //     " FROM   M_DEFAULT_APPROVERS AS MDA INNER JOIN  M_DESIGNATION AS mD ON MDA.DESIG_ID = mD.DESIG_ID " +
		//" WHERE  (MDA.APPLICATION_ID = 1) AND (MDA.STATUS_ID = 10) AND (MDA.SITE_ID = '"+strSiteid+"') AND   "+ 
		//" (mD.DESIG_DESC = 'REQUISITION RECEIVER (MATA)') ORDER BY MDA.TRV_TYPE, MDA.ORDER_ID"; 
	sSqlStr="SELECT MDA.MATA_CC_MAIL as MATA_CC_MAIL , MDA.SITE_ID, MDA.TRV_TYPE, MDA.DESIG_ID FROM M_DEFAULT_APPROVERS AS MDA "+  
	" WHERE MDA.APPLICATION_ID = 1 AND MDA.STATUS_ID = 10 AND MDA.SITE_ID = '"+strSiteid+"' AND MDA.TRV_TYPE = '"+strType+"' and sp_role='"+strSprole+"' AND MDA.ORDER_ID=(select min(order_id) from M_DEFAULT_APPROVERS MA where MA.site_id='"+strSiteid+"' and MA.STATUS_ID=10 and TRV_TYPE='"+strType+"' and sp_role='"+strSprole+"') ORDER BY MATA_CC_MAIL";
	
		//System.out.print(sSqlStr);

	 rs = dbConBean.executeQuery(sSqlStr);
	
	 while(rs.next())
	  {
		 strMailidsOnOriginating=rs.getString("MATA_CC_MAIL");   
	  }
	 if(strMailidsOnOriginating==null)
	 {
		 strMailidsOnOriginating="";
	 }
%>

	<table width="100%" border="0" align="center" cellpadding="5" cellspacing="1" class="formborder" > 
	<%if(showFlag==false) {%>  
	<tr align="right" class="formhead" >
        <td  class="formtr1" align="center"   valign="middle"><%=dbLabelBean.getLabel("label.administration.emailidforcc",strsesLanguage)%> &nbsp;&nbsp;&nbsp;<br>(<%=dbLabelBean.getLabel("label.administration.onsubmission",strsesLanguage)%>)</td>
         <td  class="formtr1" align="center"   valign="bottom">
         	         	<textarea rows="4" cols="50" name="mail_ids_initial" disabled="disabled"></textarea>
         </td>
          </tr>
	
	<%}else
		{%>
	
      <tr align="right" class="formhead" >
        <td  class="formtr1" align="center"   valign="middle"><%=dbLabelBean.getLabel("label.administration.emailidforcc",strsesLanguage)%> &nbsp;&nbsp;&nbsp;<br>(<%=dbLabelBean.getLabel("label.administration.onsubmission",strsesLanguage)%>)</td>
         <td  class="formtr1" align="center"   valign="bottom">
         	         	<textarea rows="4" cols="50" name="mail_ids_initial" onkeypress="return checkEnterOnBrowse();"><%=strMailidsOnOriginating%></textarea>
         	
         </td>
          </tr>
      <%} %>
          <tr align="right" class="formhead" >
          <td  class="formtr1" align="center"   valign="middle"><%=dbLabelBean.getLabel("label.administration.emailidforcc",strsesLanguage)%> (<%=dbLabelBean.getLabel("label.administration.onreceivedbymata",strsesLanguage)%>)</td>
         
         <td  class="formtr1" align="center"   valign="bottom">
         	         	<textarea rows="4" cols="50" name="mail_ids" onkeypress="return checkEnterOnBrowse();"><%=strMailids%></textarea>
         	
         </td>
          </tr>
          <tr>   
          
      
        <td class="formtr1"   align="center"  colspan="2"  > &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <input type="submit" name="emails" class="formButton" value="<%=dbLabelBean.getLabel("label.suggestions.update",strsesLanguage)%>"  onclick="return checkemail();"> &nbsp;&nbsp;<input type="button" class="formButton"  value="<%=dbLabelBean.getLabel("link.approverequest.cancel",strsesLanguage)%>"  onclick="window.close();"></td>
      </tr>
      <input type="hidden" name="siteid" value="<%=strSiteid %>" >
    </table>  

</form>

  
</body>

</html>
