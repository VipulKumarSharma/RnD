<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:SACHIN GUPTA
 *Date of Creation 		:30 August 2006
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This is first jsp file  for deleting the USERS from the STAR database ******
 *Modification 			:1.   changed code for changing the color of text   on 09-Jul-07 by shiv 

 *Reason of Modification: 1. Without Revoking the LA/UH roles system should not allow to deactivate the user.
 *Date of Modification  : 1. 02-Apr-2007
 *Revision History		:1. Gaurav Aggarwal
 *Editor				:Editplus
 
 *Modified By : Manoj Chand
 *Date of Modification : 16 August 2013
 *Modification : add two output parameter in PROC_USER_ADMIN_DELETE to get the output.
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
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
<base target="middle">
</head>
<%
// Variables declared and initialized
Connection objCon					=		null;			  // Object for connection
CallableStatement cstmt  			=		null;		      // Object for Callable Statement
objCon                              =       dbConBean.getConnection(); 
String strUserId	    			=       "";
strUserId	 	 		    		=       request.getParameter("userId");
String strQuery						=       null;
ResultSet rs						=		null;
String strMessage					=		"";
String flag	 						=       "y";
String strIpAddress = request.getRemoteAddr();

//@ Gaurav 02-Apr-2007 Without Revoking the LA/UH roles system should not allow to deactivate the user.
		
				strQuery="Select * from USER_MULTIPLE_ACCESS where USERID="+strUserId+ " AND STATUS_ID=10";
				rs   = dbConBean.executeQuery(strQuery);
				if(rs.next()){
				
					    //changed code for changing the color of text   on 09-Jul-07 by shiv 
						//strMessage="<font color='red'>"+dbLabelBean.getLabel("message.user.revokethelocaladminorunitheadrightsfirst",strsesLanguage)+"</font>";
						strMessage=dbLabelBean.getLabel("message.user.revokethelocaladminorunitheadrightsfirst",strsesLanguage);
				
				//End Code
				}else{
					rs   = dbConBean.executeQuery("select OOO_ID from OUT_OF_OFFICE where STATUS_ID=10 and DELEGATE_TO_USER_INFO_ID="+strUserId);
					if(rs.next()){
						strMessage=dbLabelBean.getLabel("alert.user.usercannotbedeactivatedduetooutofoffice",strsesLanguage);
					} 
					else {
						try
						{  //Procedure for Deleting Nominal Code
						   cstmt=objCon.prepareCall("{?=call PROC_USER_ADMIN_DELETE(?,?,?,?,?)}");//PROCEDURE FOR DELETING THE USER
						   cstmt.registerOutParameter(1,java.sql.Types.INTEGER);
						   cstmt.setString(2,strUserId);
						   cstmt.setString(3,Suser_id); //getting from session	
						   cstmt.setString(4,strIpAddress); 	
						   cstmt.registerOutParameter(5,java.sql.Types.INTEGER);
						   cstmt.registerOutParameter(6,java.sql.Types.VARCHAR);
						   boolean procSuccess=cstmt.execute();	
						   
						   int intstatus =cstmt.getInt(5);
						   String strOutput =cstmt.getString(6); 
						   if(strOutput.equals(""))
							   strOutput=" ";
						   
						   if(intstatus==2){
							   //strMessage="<font color=red>"+dbLabelBean.getLabel("message.user.usercannotdeactivateasuserhas",strsesLanguage)+"</font>";   
							   strMessage=dbLabelBean.getLabel("message.user.usercannotdeactivateasuserhas",strsesLanguage);
						   }
						   if(intstatus==0){
							   strMessage=dbLabelBean.getLabel("message.user.successfullydeactivated",strsesLanguage);	
						   }
						   if(intstatus==1){
							   strMessage=dbLabelBean.getLabel("message.user.unsuccessfulattemptofdeactivation",strsesLanguage);		
						   }
						   if(intstatus==3){
							   strMessage=dbLabelBean.getLabel("message.user.userhashraccorpetc",strsesLanguage)+" - \""+strOutput+"\"";		
						   }
						   if(intstatus==4){
							   strMessage=dbLabelBean.getLabel("message.user.userexistsinintimation",strsesLanguage)+" - \""+strOutput+"\"";		
						   }
						   //System.out.println("strMessage--->"+strMessage);
						   /*
						   if(!procSuccess){
								strMessage="Successfully Deactivated";	
						   }else{
						   		strMessage="UnSuccessful Attempt of Deactivation";	
						   }
						   */
						   cstmt.close();
						}
						catch(Exception e) {
							System.out.println("Error in M_userDelete.jsp ==="+e);
						}
					}
				}
				rs.close();
				//Connection Close
				dbConBean.close();
				//@Gaurav 02-Apr-2007
				response.sendRedirect("M_userList.jsp?strMessage="+URLEncoder.encode(strMessage,"UTF-8")+"");
%>
