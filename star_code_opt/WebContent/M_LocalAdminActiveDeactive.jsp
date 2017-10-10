<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:SACHIN GUPTA
 *Date of Creation 		:23 Jan 2007
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This is first jsp file  for deleting the USERS from the STAR database ******
 *Modification 			: 
 *Reason of Modification:1. Code for deactivating the record of LA from  user_multiple_access 
						 2. Bug Fixing 	
 *Date of Modification  : 1.14-May-07
						  2. 18-May-2007

 *Modification By         :1 .shiv sharma 
						   2 . Gaurav Aggarwal
 *Revision History		:
 *Editor				:Editplus
 *******************************************************/
%>
<%@ page pageEncoding="UTF-8" %>
<%@ include  file="importStatement.jsp" %>

<%@page import="java.net.URLEncoder"%><html>
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
<base target="middle">
</head>
<%
////
// Variables declared and initialized
int intFlag							      =        0;
Connection objCon					=		null;			  // Object for connection
ResultSet rs						    =      null; 
CallableStatement cstmt  			=		null;		      // Object for Callable Statement
String strUrl                       =       "";
String strMessage                   =       dbLabelBean.getLabel("label.user.localadminsuccessfullyactivated",strsesLanguage);     
objCon                              =       dbConBean.getConnection(); 
String strUserId	    			=       "";
String strStatusId                  =       ""; 
String strSql							="";
String						strSiteid = "";
String strflag						="";
String strIpAddress = request.getRemoteAddr();

strUserId	 	 		    		=       request.getParameter("userId");
strStatusId                         =       request.getParameter("statusId");  //10 for active and 30 for deactive
strSiteid=  request.getParameter("sitedivId"); //added by shiv on 17 april 07
 

//Procedure for Deleting Nominal Code
try
{
	    strflag=  request.getParameter("flag")==null?"":request.getParameter("flag").trim(); 
		 if(strflag.equals("active"))
	     {
					strSql = "Select * from M_USERROLE WHERE  site_id="+strSiteid+"  and status_id=10";
					rs= dbConBean.executeQuery(strSql);
					if(!rs.next()){		 
						   cstmt=objCon.prepareCall("{?=call PROC_LOCAL_ADMIN_ACTIVE_AND_DEACTIVE(?,?,?         ,?,?)}");//PROCEDURE FOR DELETING THE USER
						   cstmt.registerOutParameter(1,java.sql.Types.INTEGER);
						   cstmt.setString(2,strUserId);
						   cstmt.setString(3,strStatusId);
						   cstmt.setString(4,Suser_id); //getting from session
						   cstmt.setString(5,strSiteid);//Added new  on date 17 april 2007 
						   cstmt.setString(6,strIpAddress);
						   
						   intFlag = cstmt.executeUpdate();
						   cstmt.close();
				     }
					 else{
							 strflag="cant";
					 }
				  
		 }
		 else
	     {
			  			  
						   cstmt=objCon.prepareCall("{?=call PROC_LOCAL_ADMIN_ACTIVE_AND_DEACTIVE(?,?,?         ,?,?)}");//PROCEDURE FOR DELETING THE USER
						   cstmt.registerOutParameter(1,java.sql.Types.INTEGER);
						   cstmt.setString(2,strUserId);
						   cstmt.setString(3,strStatusId);
						   cstmt.setString(4,Suser_id); //getting from session
						   cstmt.setString(5,strSiteid);//Added new  on date 17 april 2007 
						   cstmt.setString(6,strIpAddress);
						   
						   intFlag = cstmt.executeUpdate();
						   cstmt.close();
		  }
	

}
catch(Exception e)
{
	System.out.println("Error in M_LocalAdminActiveDeactive.jsp ==="+e);
}

//// code for deactivating the record of LA fro  user_multiple_access open by shiv on 14-May-07 
try 
        {
		 strSql = "Select  *  from USER_MULTIPLE_ACCESS WHERE  site_id="+strSiteid+" and   unit_head=0  and userid IN (Select userid from m_USERROLE WHERE   USERID="+strUserId+" and site_id="+strSiteid+"  and status_id=10)";
		 rs= dbConBean.executeQuery(strSql);
	 	 if(!rs.next()){	

 			 			  strSql = "UPDATE USER_MULTIPLE_ACCESS SET status_id=50,U_USER_ID='"+Suser_id+"',U_DATE=GETDATE(),IP_ADDRESS='"+strIpAddress+"' WHERE USERID="+strUserId+" and site_id="+strSiteid+" and status_id=10 and   unit_head=0 "; 
			              dbConBean1.executeUpdate(strSql);
		                 
         }else{
        	 /*strSql = "Select * from M_USERROLE WHERE  site_id="+strSiteid+"  and status_id=10";
    		 rs= dbConBean.executeQuery(strSql);
			 */
        // 	 if(!rs.next()){		 
        	 
						  strSql = "UPDATE USER_MULTIPLE_ACCESS SET status_id=10,U_USER_ID='"+Suser_id+"',U_DATE=GETDATE(),IP_ADDRESS='"+strIpAddress+"' WHERE USERID="+strUserId+" and site_id="+strSiteid+" and status_id=50 "; 
 						  dbConBean1.executeUpdate(strSql);
    		// }
		 }
		}catch(Exception e)
         {
				System.out.println("Error in M_LocalAdminActiveDeactive.jsp ==="+e);
         }

rs.close();
//Connection Close
dbConBean1.close();
//// code for deactivating the record of LA fro  user_multiple_access close by shiv on 14-May-07 
dbConBean.close();

if(strStatusId != null && strStatusId.equals("10"))
{	if(strflag.equals("cant")){
       strMessage = dbLabelBean.getLabel("message.master.localadminalreadyexist",strsesLanguage);
	}else if(intFlag > 0){
		strMessage = dbLabelBean.getLabel("label.user.localadminsuccessfullyactivated",strsesLanguage);
	}
	strUrl = "M_LocalAdminDeactiveUserList.jsp?message="+URLEncoder.encode(strMessage,"UTF-8");
}
if(strStatusId != null && strStatusId.equals("30"))
{	
	if(intFlag > 0)
		strMessage = dbLabelBean.getLabel("label.user.localadminsuccessfullydeactivated",strsesLanguage);
	strUrl = "M_localAdminUserList.jsp?message="+URLEncoder.encode(strMessage,"UTF-8");
}
if(strStatusId != null && strStatusId.equals("50"))
{	
	if(intFlag > 0)
		strMessage = dbLabelBean.getLabel("label.user.localadminsuccessfullydeleted",strsesLanguage);
	strUrl = "M_LocalAdminDeactiveUserList.jsp?message="+URLEncoder.encode(strMessage,"UTF-8");
}

response.sendRedirect(strUrl);

%>
