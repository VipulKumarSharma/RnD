
<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:Kaveri Garg
 *Date of Creation 		:29 Aug 2012
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STARS
 *Operating environment :Tomcat, sql server 2008 
 *Description 			:This is post page for Versions to add, update and delete versions in database for STARS.
 *Editor				:Eclipse 3.5
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
String   strReleaseVersionId	     ="";
String  strAction  ="";
String  strMsg        ="";
int retval			  =0;
strReleaseVersionId =request.getParameter("ReleaseVersionId");
//System.out.println("strReleaseVersionId-->"+strReleaseVersionId);
strAction =request.getParameter("action1");
String strIpAddress= request.getRemoteAddr();

String appName="STARS";
	String	strReleaseDate	=	(request.getParameter("release_date")==null)?"0":request.getParameter("release_date");
	String	strReleaseVersion	=	(request.getParameter("release_version")==null)?"":request.getParameter("release_version");
	String	strReleaseBy	=	(request.getParameter("release_by")==null)?"":request.getParameter("release_by");
	String	strReleaseType	=	(request.getParameter("release_type")==null)?"":request.getParameter("release_type");
	String	strRemarks=	(request.getParameter("remarks")==null)?"":request.getParameter("remarks");

 objCon = dbConBean.getConnection();   //Get Connection

if(strAction.equals("insert")) // Block for new Cost Centre 
{  
	objCstmt=objCon.prepareCall("{?=call PROC_VERSION_ADD(?,?,?,?,?,?,?,?,?)}");
	objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
	objCstmt.setString(2, "");
	objCstmt.setString(3, appName.trim());
	objCstmt.setString(4, strReleaseDate.trim());
	objCstmt.setString(5, strReleaseVersion.trim());
	objCstmt.setString(6, strReleaseBy.trim());
	objCstmt.setString(7, strReleaseType);
	objCstmt.setString(8, strRemarks.trim());
	objCstmt.setInt(9, Integer.parseInt(Suser_id));
	objCstmt.setString(10, "INSERT");
    retval= objCstmt.executeUpdate();
    int x	=	objCstmt.getInt(1);
   	if(x==0)
	 {
		strMsg="<font color=Green>"+dbLabelBean.getLabel("alert.version.versionaddedsuccessfully",strsesLanguage)+"</font>";
	 }
	 if(x==1)
	 {
		strMsg="<font color=Red>"+dbLabelBean.getLabel("alert.version.versionalreadyexists",strsesLanguage)+"</font>";
	 }
	objCstmt.close();
	dbConBean.close();  //CLOSE ALL CONNECTIONS
	response.sendRedirect("T_addVersion.jsp?strMsg="+URLEncoder.encode(strMsg,"UTF-8")+"");
}
else if(strAction.equals("update")) //block for update Existing Cost Centre  
{   	
	    objCstmt=objCon.prepareCall("{?=call PROC_VERSION_ADD(?,?,?,?,?,?,?,?,?)}");
		objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
		objCstmt.setString(2, strReleaseVersionId);
		objCstmt.setString(3, appName.trim());
		objCstmt.setString(4, strReleaseDate.trim());
		objCstmt.setString(5, strReleaseVersion.trim());
		objCstmt.setString(6, strReleaseBy.trim());
		objCstmt.setString(7, strReleaseType);
		objCstmt.setString(8, strRemarks.trim());
		objCstmt.setInt(9, Integer.parseInt(Suser_id));
		objCstmt.setString(10, "UPDATE");
		retval= objCstmt.executeUpdate();
	    int x	=	objCstmt.getInt(1);
		if(x==0)
	 {
		strMsg="<font color=Green>"+dbLabelBean.getLabel("alert.version.versionupdatedsuccessfully",strsesLanguage)+"</font>";
	 }
	else
	{
		strMsg="<font color=red>"+dbLabelBean.getLabel("label.version.errorinupdatingversionalreadyexists",strsesLanguage)+"</font>";
	}
	objCstmt.close();
	dbConBean.close();  //CLOSE ALL CONNECTIONS
	response.sendRedirect("M_VersionList.jsp?strMsg="+URLEncoder.encode(strMsg,"UTF-8")+"");
}

else if(strAction.equals("delete")) //block for deleting Existing Cost Centre  
{
	objCstmt=objCon.prepareCall("{?=call PROC_VERSION_ADD(?,?,?,?,?,?,?,?,?)}");
	objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
	objCstmt.setString(2, strReleaseVersionId);
	objCstmt.setString(3, "");
	objCstmt.setString(4, "");
	objCstmt.setString(5, "");
	objCstmt.setString(6, "");
	objCstmt.setString(7, "");
	objCstmt.setString(8, "");
	objCstmt.setInt(9, Integer.parseInt(Suser_id));
	objCstmt.setString(10, "DELETE");
    retval= objCstmt.executeUpdate();
    int x	=	objCstmt.getInt(1);
    retval	=	objCstmt.getInt(1);
	if(x==0)
	 {
		strMsg="<font color=Green>"+dbLabelBean.getLabel("alert.version.versiondeletedsuccessfully",strsesLanguage)+"</font>";
		
	 }
	else
	{
		strMsg="<font color=red>"+dbLabelBean.getLabel("alert.version.versionnotdeleted",strsesLanguage)+"</font>";
	}
	objCstmt.close();
    dbConBean.close();  //CLOSE ALL CONNECTIONS
    response.sendRedirect("M_VersionList.jsp?strMsg="+URLEncoder.encode(strMsg,"UTF-8")+"");
}

 
%>

