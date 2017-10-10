<%
/***************************************************
 *The information contained here in is confidential and 
 **** proprietary to MIND and forms the part of the MIND ****** 
 *Author			  : Abhinav Ratnawat
 *Date of Creation : 25 August 2006
**** Copyright Notice :Copyright(C)2000 MIND.All rights reserved. ******
**** Project	  : STAR ****** 
**** Operating environment :Tomcat, sql server 2000 ******
**** Description : This is first jsp file  for assigning roles to STAR users.******
**** Modification : ******
**** Reason of Modification : ******
**** Date of Modification   : ******
**** Revision History		: none******
**** Editor					:Editplus ******
**********************************************************/
%>

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
<%--<%@ include  file="systemStyle.jsp" %>--%>
<%@ page import="java.sql.*" pageEncoding="UTF-8" %>
<!--Create the DbConnectionBean object for createConnection-->
<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbConBean1" scope="page" class="src.connection.DbConnectionBean" />


<%
//Added By Gurmeet Singh on 12-06-2014 [--Start--]
Connection objCon, objCon1 =  null; 
objCon = dbConBean.getConnection(); 
objCon1	= dbConBean1.getConnection();
CallableStatement proc, proc1 = null;		
//Added By Gurmeet Singh on 12-06-2014 [--End--]
		
String strIpAddress = request.getRemoteAddr();
int icount = Integer.parseInt(request.getParameter("flagIndex"));
int  iuserID = 0;

for (int i =1 ; i < icount ; i++) 
{
	
	String index = new Integer(i).toString();
	String strRoleID = request.getParameter("role"+index) == null ? "" :request.getParameter("role"+index).trim();
	String strBoss   = request.getParameter("boss"+index) == null ?"" :request.getParameter("boss"+index).trim();
	String chkFlag   = request.getParameter("chk"+index) == null ?"" :request.getParameter("chk"+index).trim();
	if (chkFlag.equals("0")){
	if (!(strRoleID.equals("-1")))
	{
		iuserID = Integer.parseInt(request.getParameter("userID" +index));
		try 
		{
			String sql = " update M_USERINFO set ROLE_ID=N'"+strRoleID+"',ORG_ROLE=N'"+strRoleID+"',U_USER_ID='"+Suser_id+"',U_DATE=GETDATE(),IP_ADDRESS='"+strIpAddress+"'  where USERID=' " +iuserID+ " ' AND STATUS_ID=10 AND APPLICATION_ID=1  "  ; 
			//String sqlAudit = " update AUDIT_M_USERINFO set ROLE_ID=N'"+strRoleID+"',ORG_ROLE=N'"+strRoleID+"',U_USER_ID='"+Suser_id+"',U_DATE=GETDATE(),IP_ADDRESS='"+strIpAddress+"' where USERID=' " +iuserID+ " '  "  ; 
			dbConBean.executeUpdate(sql);	
			//dbConBean.executeUpdate(sqlAudit);
			
			//Added By Gurmeet Singh on 12-06-2014 [--Start--]
			proc = objCon.prepareCall("{?=call PROC_TRANSFER_USERINFO_TO_AUDIT_USERINFO(?)}");
			proc.registerOutParameter(1,java.sql.Types.INTEGER);
			proc.setString(2,String.valueOf(iuserID));
			proc.execute();	
			proc.close();
			//Added By Gurmeet Singh on 12-06-2014 [--End--]
		}
		catch (Exception e) 
		{
			System.out.println("Error in RoleAssignment.jsp==ROLE==== "+e);
			e.printStackTrace();
		} 
		
	}
  }
	if (chkFlag.equals("0")){
	if (!(strBoss.equals("-1")))
	{
		iuserID = Integer.parseInt(request.getParameter("userID" +index));
		try 
		{
			String sql = " update M_USERINFO set BOSS='"+strBoss+"',U_USER_ID='"+Suser_id+"',U_DATE=GETDATE(),IP_ADDRESS='"+strIpAddress+"'  where USERID=' " +iuserID+ " ' AND STATUS_ID=10 AND APPLICATION_ID=1  "  ; 
			//String sqlAudit = " update AUDIT_M_USERINFO set BOSS='"+strBoss+"',U_USER_ID='"+Suser_id+"',U_DATE=GETDATE(),IP_ADDRESS='"+strIpAddress+"'  where USERID=' " +iuserID+ " '  "  ; 
			dbConBean.executeUpdate(sql);	
			//dbConBean.executeUpdate(sqlAudit);
			
			//Added By Gurmeet Singh on 12-06-2014 [--Start--]
			proc1 = objCon1.prepareCall("{?=call PROC_TRANSFER_USERINFO_TO_AUDIT_USERINFO(?)}");
			proc1.registerOutParameter(1,java.sql.Types.INTEGER);
			proc1.setString(2,String.valueOf(iuserID));
			proc1.execute();
			proc1.close();
			//Added By Gurmeet Singh on 12-06-2014 [--End--]
		}
		catch (Exception e) 
		{
			System.out.println("Error in RoleAssignment.jsp==BOSS==== "+e);
			e.printStackTrace();
		} 

	}
}
}
//Added By Gurmeet Singh on 12-06-2014 [--Start--]
//connection closed
objCon.close();
objCon1.close();
//Added By Gurmeet Singh on 12-06-2014 [--End--]
%>

<jsp:forward page="M_userDeisgList.jsp?dataFlag=true"/>
