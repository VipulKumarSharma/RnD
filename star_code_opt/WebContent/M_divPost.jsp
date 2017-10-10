<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:Shiv sharma 
 *Date of Creation 		:28 Aug 2008
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STARS
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This is post page for Division in M_Division table of STAR Database.
 *Modification 			: 
 *Reason of Modification: 
 *Date of Modification  : 
 *Revision History		:
 *Editor				:Editplus
*******************************************************/%>

<%@ page pageEncoding="UTF-8" %>
<%@ include  file="importStatement.jsp" %>
<%@ page import = "src.connection.DbUtilityMethods" %>

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

<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<base target="middle">
</head>

<%
request.setCharacterEncoding("UTF-8");
// Variables declared and initialized
Connection objCon= null;			    // Object for connection
CallableStatement objCstmt			=		null;

String  strDivID      ="";
String  strDivName    ="";
String  strDivDesc    ="";
String  strDivAction  ="";
String  strMsg        ="";
int retval			  =0;
strDivID     =request.getParameter("strDivId");
strDivAction =request.getParameter("action");

if(!strDivAction.equals("Delete"))
  {
    strDivName=request.getParameter("divName");
    strDivDesc=request.getParameter("DivDescription");
  }

 objCon = dbConBean.getConnection();   //Get Connection

//PROCEDURE TO Add, Update,Delete THE DIVISION IN M_DIVISION TABLE

if(strDivID.equals("new")) // Block for new Division 
{  
	DbUtilityMethods utilitymethod = new DbUtilityMethods(); // getNewID method defined in this file
	int intDivid = utilitymethod.getNewGeneratedId("DIV_ID"); //Getting unique DIV_ID from the bean
	//Procedure for Nominal Code

	objCstmt=objCon.prepareCall("{?=call PROC_DIVISION_ADD_UPDATE_DELETE(?,?,?,?,?,?)}");
	objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
	objCstmt.setInt(2, intDivid);
	objCstmt.setString(3, strDivName.trim());
	objCstmt.setString(4, strDivDesc.trim());
	objCstmt.setString(5, "10");
	objCstmt.setString(6, Suser_id);
	objCstmt.setString(7, "INSERT");
    retval= objCstmt.executeUpdate();

    retval	=	objCstmt.getInt(1);

	//System.out.println("retval=======>>>>>>="+retval);
	if(retval==0)
	 {
		strMsg="<font color=Green>"+dbLabelBean.getLabel("message.division.divisionaddedsuccessfully",strsesLanguage)+"</font>";
	 }
	 if(retval==5)
	 {
		strMsg="<font color=Red>"+dbLabelBean.getLabel("message.division.divisionalreadyexists",strsesLanguage)+"</font>";
	 }
	objCstmt.close();
	dbConBean.close();  //CLOSE ALL CONNECTIONS
}
else if(strDivAction.equals("update")) //block for update Existing Division  
{
	objCstmt=objCon.prepareCall("{?=call PROC_DIVISION_ADD_UPDATE_DELETE(?,?,?,?,?,?)}");
	objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
	objCstmt.setInt(2, Integer.parseInt(strDivID));
	objCstmt.setString(3, strDivName.trim());
	objCstmt.setString(4, strDivDesc.trim());
	objCstmt.setString(5, "10");
	objCstmt.setString(6, Suser_id);
	objCstmt.setString(7, "UPDATE");
	retval=objCstmt.executeUpdate();

	if(retval>0)
	 {
		strMsg="<font color=Green>"+dbLabelBean.getLabel("message.division.divisionupdatedsuccessfully",strsesLanguage)+"</font>";
	 }
	objCstmt.close();
	dbConBean.close();  //CLOSE ALL CONNECTIONS
}

else if(strDivAction.equals("Delete")) //block for update Existing Division  
{
 
	objCstmt=objCon.prepareCall("{?=call PROC_DIVISION_ADD_UPDATE_DELETE(?,?,?,?,?,?)}");
	objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
	objCstmt.setInt(2, Integer.parseInt(strDivID));
	objCstmt.setString(3, "");
	objCstmt.setString(4, "");
	objCstmt.setString(5, "30");
	objCstmt.setString(6, Suser_id);
	objCstmt.setString(7, "DELETE");

	objCstmt.executeUpdate();
	
    retval	=	objCstmt.getInt(1);
	 
	if(retval==3)
	 {
		strMsg="<font color=red>"+dbLabelBean.getLabel("message.division.divisioncannotdelete",strsesLanguage)+"</font>";
	 }
	 else
	 {
		strMsg="<font color=Green>"+dbLabelBean.getLabel("message.division.divisiondeletedsuccessfully",strsesLanguage)+"</font>";
	 }
	objCstmt.close();
    dbConBean.close();  //CLOSE ALL CONNECTIONS

}
response.sendRedirect("M_division.jsp?strMsg="+URLEncoder.encode(strMsg,"UTF-8")+"");
 
%>