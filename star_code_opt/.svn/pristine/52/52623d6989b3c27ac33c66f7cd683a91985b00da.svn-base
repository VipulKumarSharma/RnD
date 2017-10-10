
<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:Manoj
 *Date of Creation 		:12 Jan 2011
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This is post jsp file  for Cancel the Requisition
 *Editor				:Eclipse
 *******************************************************/
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
<%@ include  file="systemStyle.jsp" %>

<!--Create the DbConnectionBean object for createConnection-->
<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />

<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<base target="middle">
</head>
<%
request.setCharacterEncoding("UTF-8");
// Variables declared and initialized
int intSuccess            = 0; 
String strTravelType      = "";
String strTravelTypeFlag  = "";
String strTravellerId   = "";
String strTravllerSiteId = "";
strTravelType   =  request.getParameter("travelType"); 
String strfinalUrl=request.getParameter("final_url");
String strIpAddr = request.getRemoteAddr();
String strWhichPage    =  "";
String strTargetFlag   =  "";
String flage					="";

String unitheadcheck	="";
String chairmancheck	 ="";
strWhichPage    =  request.getParameter("whichPage"); 

//System.out.println("strWhichPage=="+strWhichPage);

if(strWhichPage == null)
   strWhichPage = "#";

strTargetFlag    =  request.getParameter("targetFrame"); 
if(strTargetFlag !=null && strTargetFlag.equals("yes"))
{
	strTargetFlag = "yes";
}
Connection con					=		null;			    // Object for connection
ResultSet rs					=		null;			  // Object for ResultSet
CallableStatement cstmt			=		null;			// Object for Callable Statement

//Create Connection
con=dbConBean.getConnection();
String	sSqlStr=""; // For sql Statements
 
if(strTravelType != null && strTravelType.equals("INT"))   //set  the flag for international 'I'or domestic 'D'
{
   strTravelType = "I";
}
if(strTravelType != null && strTravelType.equals("DOM"))   
{
   strTravelType = "D";
}

String strRequisitionId     	=   ""; // Object to store Requisition ID
strRequisitionId				=	request.getParameter("purchaseRequisitionId");

String strComments          	=   "";
String strSiteId				=	"";
String strUserSiteID			=	"";
String strRoleId				=	"";	
String strTableName				=	"";
//String strUserMailID			=	"";
//System.out.println(""+);
strComments		            	=   request.getParameter("comments");
try
{

		cstmt=con.prepareCall("{?=call PROC_TRAVEL_REQ_HOLD_BY_ADMIN(?,?,?,?,?,?,?,?)}");
		cstmt.registerOutParameter(1,java.sql.Types.INTEGER);
		cstmt.setString(2, strRequisitionId);
		cstmt.setString(3, strTravelType);
		cstmt.setInt(4, 10);
		cstmt.setString(5,"I");
		cstmt.setString(6, strIpAddr);
		cstmt.setString(7, Suser_id);
		cstmt.setString(8, strComments.trim());
		cstmt.setString(9, "HOLD");
		intSuccess = cstmt.executeUpdate();
		cstmt.close();

    String strUserBillingClient="";



	if(intSuccess > 0 )       
	{
	%>
		
		<jsp:include page="T_requisitionMailOnHold.jsp"> 
		<jsp:param name="purchaseRequisitionId" value="<%=strRequisitionId%>"/>
		<jsp:param name="mailUserId" value="<%=Suser_id%>"/>
		<jsp:param name="CancelComments" value="<%=strComments.trim()%>"/>
		<jsp:param name="travelType" value="<%=strTravelType%>"/>
	</jsp:include>
	<%
    

}
}
catch(Exception e)
{
   System.out.println("Error in T_Travel_Requisition_Hold_Post.jsp====="+e);
}

String strUrl = strWhichPage+"?"+strfinalUrl;
dbConBean.close();  //close All Connection
%>
<html>
<head>
<Script>
	function win()
	{
		window.opener.location.href="<%=strUrl%>";
		self.close();
	}
</Script>
<head>
	<body onload="win();">
	<form >
	</form>
	<body>
</html>

