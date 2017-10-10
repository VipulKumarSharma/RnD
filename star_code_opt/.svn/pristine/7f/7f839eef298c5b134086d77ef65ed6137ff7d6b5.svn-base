<%/***************************************************
*Copyright (C) 2000 MIND
*All rights reserved.
*The information contained here in is confidential and *proprietary to MIND and forms the part of the MIND 
*CREATED BY		:	Abhinav Ratnawat
*Date			:	30 Aug 2006 
*Description	:	Production Workflow Page
*Modification			:1. Code changed for sending A mail to Stars admin on delete of Approver  from Default Workflow  -added by shiv on                                                     26-Sep-07
**Project		:	STAR

*Modified By	:	Manoj chand
*Modification   :	write sql query to add delete remarks in table
*Date of Modification	: 08 August 2011 

*Modified By	:	Manoj chand
*Modification   :	modification in insert query
*Date of Modification	:14 Sept 2011

*Modified By	:	Manoj chand
*Modification   :	Modifies the insert query
*Date of Modification	:07 Feb 2012
**********************************************************/%>
<%@ page import="java.sql.*" pageEncoding="UTF-8" %>
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
<!--Create the DbConnectionBean object for createConnection-->
<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
<%
request.setCharacterEncoding("UTF-8");
String strSiteId = request.getParameter("ID")==null?"":request.getParameter("ID");
String strVal	 = request.getParameter("VAL")==null?"":request.getParameter("VAL");
String strDelId	 = request.getParameter("DELID")==null?"":request.getParameter("DELID");
String strRemark = request.getParameter("remark")==null?"":request.getParameter("remark");
String strSpRole = request.getParameter("Sprole");
//System.out.println("strRemark--del-->"+strRemark);
String strOrder = request.getParameter("order")==null?"0.0":request.getParameter("order");
String strDesig = request.getParameter("designation")==null?"":request.getParameter("designation");
float fltOrder=Float.parseFloat(strOrder);

ResultSet objRs = null;
String strSqlDelete="";
String strSql="";
String strApproverID="";  
String strApproverAtSite="";
String strApproverofTravelType ="";
String strWKType = request.getParameter("TYPE")==null?"":request.getParameter("TYPE");

String strIpAddress = request.getRemoteAddr();

int retval=0;
Connection conn;
Statement stmt;

// Finding approver ID for M_default Approver who is deleted - added  by shiv on 26-Sep-07
strSql="SELECT APPROVER_ID,.DBO.SITENAME(SITE_ID) AS SITENAME,TRV_TYPE FROM M_DEFAULT_APPROVERS WHERE DA_ID='"+strDelId+"'";
       
		     objRs = dbConBean.executeQuery(strSql);
             while (objRs.next()) {
				       strApproverID=objRs.getString("APPROVER_ID");
				       strApproverAtSite=objRs.getString("SITENAME");
				       strApproverofTravelType =objRs.getString("TRV_TYPE");
				      }
	         objRs.close();  

	         
	         try {    
	        	 	strSqlDelete = "UPDATE M_DEFAULT_APPROVERS set U_USER_ID='"+Suser_id+"',U_DATETIME=GETDATE(),U_IPADDRESS='"+strIpAddress+"' WHERE DA_ID='"+strDelId+"' AND TRV_TYPE='"+strApproverofTravelType.trim()+"'";
	        	    retval=dbConBean.executeUpdate(strSqlDelete);
					strSqlDelete="DELETE FROM M_DEFAULT_APPROVERS WHERE DA_ID='"+strDelId+"' AND TRV_TYPE='"+strApproverofTravelType.trim()+"'";
					retval=dbConBean.executeUpdate(strSqlDelete);
					strSqlDelete ="update dbo.M_USERINFO set ROLE_ID=ORG_ROLE,U_USER_ID='"+Suser_id+"',U_DATE=GETDATE(),IP_ADDRESS='"+strIpAddress+"' where USERID="+strApproverID+" and STATUS_ID=10";
					int updatedrows=dbConBean.executeUpdate(strSqlDelete);
					}
					catch (Exception e) {
							System.out.println("Connection not Created !Error "+e);
							e.printStackTrace();
					} finally {
				try{
					
				}catch(Exception e){

				}
}
	         
	         
	         try{
	        	 
	        	 if(retval!=0){
	        	 //modified by manoj on 14 sept 2011 to insert c_userid
	        	 //strSql="INSERT INTO M_WORKFLOW_REMARK VALUES('"+strApproverID+"','"+strSpRole+"','"+strRemark+"','"+strSiteId+"','"+strApproverofTravelType.trim()+"',GETDATE())";
	        	 strSql="INSERT INTO M_WORKFLOW_REMARK (UserId,Site,Order_of_Approval,Designation,Travel_Type,spRole,Remark_Type,Remark,C_date,C_userid) "+
	        	        " VALUES ('"+strApproverID+"','"+strSiteId.trim()+"','"+fltOrder+"','"+strDesig+"','"+strApproverofTravelType.trim()+"','"+strSpRole+"','Delete',N'"+strRemark.replaceAll("~","%")+"',GETDATE(),'"+Suser_id+"')";
	 
	        	 int x=dbConBean.executeUpdate(strSql);
	        	 }
	         }catch(Exception e){
	        	 e.printStackTrace();
	         }
	         
	         
				
				
dbConBean.close();
%>
<!-- Sending mail to Star admin on deletion of  approver from Default workflow  -added by shiv on 26-Sep-07 -->
		 <jsp:include page="T_MailOnChangeApporover.jsp">
				<jsp:param name="userId" value="<%=Suser_id%>"/>
				<jsp:param name="userSiteId" value="<%=strSiteIdSS%>"/>
				<jsp:param name="userIdToDelete" value="<%=strApproverID%>"/>
				<jsp:param name="userApproverAtSite" value="<%=strApproverAtSite%>"/>
				<jsp:param name ="userAproverofTravelType" value="<%=strApproverofTravelType%>" />
		</jsp:include> 

<SCRIPT LANGUAGE="JavaScript">
//document.FRM.submit();
</SCRIPT>

<FORM METHOD=POST NAME=FRM ACTION="M_WorkFlowAddApprover.jsp">
<input type=hidden name="ID" value="<%=strSiteId%>">
<input type=hidden name="VAL" value="<%=strVal%>">
<input type=hidden name="TYPE" value="<%=strWKType%>">
</form>

</html>