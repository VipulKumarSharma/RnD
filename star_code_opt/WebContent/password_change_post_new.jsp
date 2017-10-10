
<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:SACHIN GUPTA
 *Date of Creation 		:31 Jan 2007
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:User Validation for STAR
 *Modification 			: 
 *Reason of Modification: Procedure call for removing TID & SID entry from SSO_HISTORY table add by shiv sharma on 4/14/2009
 *Date of Modification  : 
 *Revision History		:
 *Editor				:Editplus
 *******************************************************/
%>

<%@ include  file="importStatement.jsp" %>
<%@ include  file="cacheInc.inc" %>
<%@ include  file="headerIncl.inc" %>
<!--Create Conneciton by useBean-->
<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />

<!--Create the DbUtilityMethods object for utility methods-->
<jsp:useBean id="dbUtility" scope="page" class="src.connection.DbUtilityMethods" />

<%
request.setCharacterEncoding("UTF-8");
String user			=null;
String newPass		=null;
String newPassInDecimal = null;
String oldPass		=null;
String strSql       = ""; 
Connection objCon				    = null;			    // Object for connection
ResultSet objRs,rs		            = null;			    // Object for ResultSet
CallableStatement objCstmt		    = null;			    // Object for Callable Statement

try
{
	user                 =  request.getParameter("user").trim(); 

	oldPass              =  request.getParameter("oldPass").trim();

	newPass              =  request.getParameter("newPass").trim();

	newPass = dbUtility.encrypt(newPass);
	newPassInDecimal = dbUtility.decryptInDecimal(newPass);

    int updated = 0;
	strSql = "update m_userinfo set pin=N'"+newPassInDecimal+"' , enc_flag='y' where username=N'"+user+"' and status_id=10";
	updated = dbConBean.executeUpdate(strSql);

	if(updated > 0)
	{
%>
		<jsp:forward page="userAuthentication.jsp" >
			<jsp:param name="Userid" value="<%=user%>" />
			<jsp:param name="hiddenPassword" value="<%=newPass%>" /> 
			 <jsp:param name="SSO"  value="NO" /> 
		</jsp:forward>
  <%
    // Procedure call for removing TID & SID entry from SSO_HISTORY table add by shiv sharma on 4/14/2009

	}else{
		
		objCstmt = objCon.prepareCall("{?=call SPG_SSO_HISTORY(?,?)}");   
		objCstmt.registerOutParameter(1,java.sql.Types.INTEGER); 
	 	objCstmt.setString(2, user);  
		objCstmt.setString(3, "STAR");
		objCstmt.execute(); 
		objCstmt.close(); 
	}
}
catch(Exception e)
{
	System.out.println("Error in password_change_post_new==="+e);
}
%>
