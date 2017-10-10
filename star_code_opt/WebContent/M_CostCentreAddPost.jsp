
<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:Kaveri Garg
 *Date of Creation 		:21 Aug 2012
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STARS
 *Operating environment :Tomcat, sql server 2008 
 *Description 			:This is post page for Cost Centre in M_Cost_Centre table of STAR Databasel.
 *Modification 			: 
 *Reason of Modification: 
 *Date of Modification  : 
 *Revision History		:
 *Editor				:Editplus
*******************************************************/%>
<%@ page buffer="5kb" language="java"  import="java.sql.*,java.io.*,java.util.*,java.io.*,java.math.*" pageEncoding="UTF-8"%>
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
String strSiteId= "";
String   strCostCentreId	     ="";
String  strCostCentreCode    ="";
String  strCostCentreDesc    ="";
String  strAction  ="";
String  strMsg        ="";
int retval			  =0;
strSiteId =request.getParameter("sitedivId");
strAction =request.getParameter("action1");
String strIpAddress= request.getRemoteAddr();
strCostCentreDesc =request.getParameter("Description");
strCostCentreCode=request.getParameter("costCentreCode");
//System.out.println("strCostCentreCode--->"+strCostCentreCode);
//System.out.println("strSiteId-->"+strSiteId);   
//System.out.println("strAction-->"+strAction);
 objCon = dbConBean.getConnection();   //Get Connection

if(strAction.equals("insert")) // Block for new Cost Centre 
{  
	objCstmt=objCon.prepareCall("{?=call PROC_COST_CENTRE_ADD_UPDATE_DELETE(?,?,?,?,?,?,?)}");
	objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
	objCstmt.setString(2, strCostCentreCode.trim());
	objCstmt.setInt(3, Integer.parseInt(strSiteId));
	objCstmt.setString(4, strCostCentreDesc.trim());
	objCstmt.setInt(5, Integer.parseInt(Suser_id));
	objCstmt.setString(6, strIpAddress);
	objCstmt.setString(7, "INSERT");
	objCstmt.registerOutParameter(8,java.sql.Types.INTEGER);
    retval= objCstmt.executeUpdate();
    int x	=	objCstmt.getInt(8);
    //System.out.println("x-->"+x);
   	if(x==0)
	 {
		strMsg="<font color=Green>"+dbLabelBean.getLabel("label.costcentre.costcentreaddedsuccessfully",strsesLanguage)+"</font>";
	 }
	if(x==1)
	 {
		strMsg="<font color=Green>"+dbLabelBean.getLabel("label.costcentre.errorininserting",strsesLanguage)+"</font>";
	 }
	 if(x==2)
	 {
		strMsg="<font color=Red>"+dbLabelBean.getLabel("label.costcentre.costcentrealreadyexists",strsesLanguage)+"</font>";
	 }
	objCstmt.close();
	dbConBean.close();  //CLOSE ALL CONNECTIONS
	response.sendRedirect("M_CostCentreAdd.jsp?selected="+strSiteId+"&strMsg="+URLEncoder.encode(strMsg,"UTF-8")+"");
}
else if(strAction.equals("update")) //block for update Existing Cost Centre  
{
	objCstmt=objCon.prepareCall("{?=call PROC_COST_CENTRE_ADD_UPDATE_DELETE(?,?,?,?,?,?,?)}");
	objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
	objCstmt.setString(2, strCostCentreCode.trim());
	objCstmt.setInt(3, Integer.parseInt(strSiteId));
	objCstmt.setString(4, strCostCentreDesc.trim());
	objCstmt.setInt(5, Integer.parseInt(Suser_id));
	objCstmt.setString(6, strIpAddress);
	objCstmt.setString(7, "UPDATE");
	objCstmt.registerOutParameter(8,java.sql.Types.INTEGER);
	retval=objCstmt.executeUpdate();
	int x	=	objCstmt.getInt(8);
	if(x==0)
	 {
		strMsg="<font color=Green>"+dbLabelBean.getLabel("label.costcentre.costcentreupdatedsuccessfully",strsesLanguage)+"</font>";
	 }
	else
	{
		strMsg="<font color=red>"+dbLabelBean.getLabel("label.costcentre.errorinupdatingrecord",strsesLanguage)+"</font>";
	}
	objCstmt.close();
	dbConBean.close();  //CLOSE ALL CONNECTIONS
	response.sendRedirect("M_CostCentreList.jsp?strMsg="+URLEncoder.encode(strMsg,"UTF-8")+"");
}

else if(strAction.equals("Delete")) //block for deleting Existing Cost Centre  
{
	objCstmt=objCon.prepareCall("{?=call PROC_COST_CENTRE_ADD_UPDATE_DELETE(?,?,?,?,?,?,?)}");
	objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
	objCstmt.setString(2, strCostCentreCode.trim());
	objCstmt.setInt(3, Integer.parseInt(strSiteId));
	objCstmt.setString(4, "");
	objCstmt.setInt(5, Integer.parseInt(Suser_id));
	objCstmt.setString(6,strIpAddress);
	objCstmt.setString(7, "DELETE");
	objCstmt.registerOutParameter(8,java.sql.Types.INTEGER);
	objCstmt.executeUpdate();
	int x	=	objCstmt.getInt(8);
	//System.out.println("strCostCentreCode-->"+strCostCentreCode);
	//System.out.println("x-->"+x);
    retval	=	objCstmt.getInt(1);
	if(x==0)
	 {
		strMsg="<font color=Green>"+dbLabelBean.getLabel("label.costcentre.costcentredeletedsuccessfully",strsesLanguage)+"</font>";
		
	 }
	else
	{
		strMsg="<font color=Green>"+dbLabelBean.getLabel("label.costcentre.notdeleted",strsesLanguage)+"</font>";
	}
	objCstmt.close();
    dbConBean.close();  //CLOSE ALL CONNECTIONS
    response.sendRedirect("M_CostCentreList.jsp?strMsg="+URLEncoder.encode(strMsg,"UTF-8")+"");
}

 
%>