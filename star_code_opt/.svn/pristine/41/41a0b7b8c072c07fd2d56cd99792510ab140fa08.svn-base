<%
/***************************************************
*Copyright (C) 2000 MIND
*All rights reserved.
*The information contained here in is confidential and *proprietary to MIND and forms the part of the MIND 
*CREATED BY		:	Abhinav Ratnawat 
*Date			:	12/12/2005  
*Description	:	Production Workflow Page
**Project		:	STARS
*Modification	:1. Made a procedure for inserting a record PROC_INSERT_M_DEFAULT_APPROVERS
*Reason of Modification:1. Code Enhancement
                 2.Code added for adding CC mail of mata person when mata approver is added in  
										    workflow  on 26-Mar-08 by shiv Sharma    

*Date of Modification  :1. 16-May-2007
*Modification By		:1. Gaurav Aggarwal 
				:By Vaibhav on sep 22 2010 to add cc mails on request origination
				
*Modified By		:	Manoj Chand
*Modification Date	: 	06-May-2013
*Modification 		:   update u_userid in m_default approver table when CC_EMAIL is updated
**********************************************************/%>
<%@ page import= "java.sql.*" pageEncoding="UTF-8" %>

<%-- Import Statements  --%>
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

<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbUtilityBean" scope="page" class="src.connection.DbUtilityMethods" />
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>

<%
request.setCharacterEncoding("UTF-8");
Connection objCon				    = null;	
ResultSet rs						= null;
CallableStatement objCstmt		    = null;
String strSql						="";
String strType =request.getParameter("wftype"); 
String strReqType="";
//System.out.println("strTypeaaaa::"+strType);
String strSiteId =request.getParameter("siteid"); 
String strMailID =request.getParameter("mail_ids")==null?"":request.getParameter("mail_ids").trim();
String mail_ids_initial =request.getParameter("mail_ids_initial")==null?"":request.getParameter("mail_ids_initial").trim(); 
String strSprole = request.getParameter("strSprole");

String strIpAddress = request.getRemoteAddr();

//System.out.println("mail_ids_initial:"+mail_ids_initial);
if(strType.equalsIgnoreCase("1"))
{
	strReqType="D";
}
else
{
	strReqType="I";
}

//Checking for email ids. email id must be registered in STARS----------By Sachin
String strEmails[]	= null;
String strEmailsAppend	= "";
int intMailCountAfterVerification	= 0;
if(!strMailID.trim().equals("")){
	strEmails=strMailID.split(";");	
	for(int i=0;i<strEmails.length;i++){
		strSql	=	"select count(*) from m_userinfo where application_id=1 and status_id=10 and email in (N'"+strEmails[i]+"') ";
		rs = dbConBean.executeQuery(strSql);
		if(rs.next())
		{
			intMailCountAfterVerification	=	rs.getInt(1);
		}else{
			intMailCountAfterVerification = 0;
			break;
		}	
	}	
}
//if added By Vaibhav on sep 22 2010 to add cc mails on request origination
if(!mail_ids_initial.trim().equals("")){
	strEmails=mail_ids_initial.split(";");	
	for(int i=0;i<strEmails.length;i++){
		strSql	=	"select count(*) from m_userinfo where application_id=1 and status_id=10 and email in (N'"+strEmails[i]+"') ";
		rs = dbConBean.executeQuery(strSql);
		if(rs.next())
		{
			intMailCountAfterVerification	=	rs.getInt(1);
		}else{
			intMailCountAfterVerification = 0;
			break;
		}	
	}	
}

//Checking for email ids. email id must be registered in STARS----------By Sachin
		int QueryReturn	= -1;
		if(strMailID.equals("") || intMailCountAfterVerification > 0){
	    	objCon               =  dbConBean.getConnection(); 
			objCstmt=  objCon.prepareCall("{?=call PROC_UPDATE_CC_EMAIL(?,?,?,?,?,?,?)}");
			objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
			objCstmt.setString(2, strReqType);
			objCstmt.setString(3, mail_ids_initial);  //mail id initial By Vaibhav on sep 22 2010 to add cc mails on request origination
			objCstmt.setString(4, strMailID);		//cc mail ids mata
			objCstmt.setString(5, strSiteId.trim());
			objCstmt.setString(6, strSprole);//By Vaibhav on sep 22 2010 to add cc mails on request origination
			//one parameter added by manoj on 06 may 2013 to UPDATE U_user_id in M_defaulworkflow table 
			objCstmt.setString(7,Suser_id);
			objCstmt.setString(8,strIpAddress);
			objCstmt.execute();
			QueryReturn=objCstmt.getInt(1);
			objCstmt.close();	
		} 
		
		String strmsg="";
		if(QueryReturn==0)
		{ 
			strmsg="<font color=green>("+dbLabelBean.getLabel("label.administration.emailidsupdatedsuccessfully",strsesLanguage)+")</font>";
		}else if(QueryReturn == -50002){ 
			strmsg="<font color=red>("+dbLabelBean.getLabel("label.administration.emailidsnotupdatedsuccessfully",strsesLanguage)+")</font>";
		}else if(!strMailID.equals("") && intMailCountAfterVerification == 0){
			strmsg="<font color=red>("+dbLabelBean.getLabel("label.administration.emailidsnotexistinstars",strsesLanguage)+")</font>";
		}else{
			System.out.println("!Error in Executing Procedure=========== ");
		}
		
//Query for finding the order of approver is exist or not, if order is exist then we doesn't put the multiple entry for the same order.
response.sendRedirect("T_showMataassociate.jsp?site_id="+strSiteId+"&msg="+strmsg+"&wftype="+strType+"&strSprole="+strSprole); 


%>