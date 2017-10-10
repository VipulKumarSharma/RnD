<!DOCTYPE html>
<%@ include  file="importStatement.jsp" %>

<%@page import="java.net.URLEncoder"%><html>

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
<html lang="en">
<head>
<base target="middle">
</head>
<%
request.setCharacterEncoding("UTF-8");
// Variables declared and initialized
Connection objCon						= null;			  // Object for connection
CallableStatement objCstmt  			= null;		      // Object for Callable Statement
objCon                              	= dbConBean.getConnection(); 
ResultSet rs						    = null;
String strQuery							= null;

String strMessage						= "";
String strGUserId	    				= "";
String strTravel_id				    	= "";
String strTravel_reqno			    	= "";
String strTravel_reqid				   	= "";
String strTraveller_id				   	= "";
String strTravel_type               	= "";
String strIntermi_id				    = "";
String strwhatAction					= "";

int intSuccess1  						= 0;
int intSuccess2  						= 0;

strGUserId	 	 		    	   	    = request.getParameter("G_userId");
strTravel_id	 	 		    		= request.getParameter("travelId");
strTravel_reqno	 	 		    		= request.getParameter("travelReqNo");
strTravel_reqid	 	 		    		= request.getParameter("travelReqId");
strTraveller_id	 	 		    		= request.getParameter("travellerId");
strTravel_type	 	 		    		= request.getParameter("travel_type");
strIntermi_id	 	 		    		= request.getParameter("interimId");
strwhatAction	 	 		    		= request.getParameter("action");

try	{

	objCstmt=objCon.prepareCall("{?=call PROC_T_GROUP_USERINFO(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
	objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
    objCstmt.setString(2,strGUserId);
	objCstmt.setString(3,strTravel_id);
	objCstmt.setString(4, "");
	objCstmt.setString(5, "");
	objCstmt.setString(6, "");
	objCstmt.setString(7, "");
	objCstmt.setString(8, "");
	objCstmt.setString(9, "50");			
	objCstmt.setString(10, "");
	objCstmt.setString(11, "");
	objCstmt.setString(12, "");
	objCstmt.setString(13, "");
	objCstmt.setString(14, "");
	objCstmt.setString(15, "");
	objCstmt.setString(16, "");
	objCstmt.setString(17, "");
	objCstmt.setString(18, "");
	objCstmt.setString(19, "");
	objCstmt.setString(20, "");
	objCstmt.setString(21, "");
	objCstmt.setString(22, "");
	objCstmt.setString(23, "");
	objCstmt.setString(24, "");
	objCstmt.setString(25, Suser_id);
	objCstmt.setString(26, "DELETE");
  	objCstmt.setString(27, "");
  	objCstmt.setString(28, "");
  	objCstmt.setString(29, "N");
  	objCstmt.setString(30, "");
  	objCstmt.setString(31, "");
  	objCstmt.setString(32, "");
  	objCstmt.registerOutParameter(33,java.sql.Types.INTEGER);
   	
  	boolean procSuccess=objCstmt.execute();	

	if(strTravel_type.equals("i")) {
	        objCstmt = objCon.prepareCall("{?=call PROC_DELETE_FOREX_DETAIL_TABLES_GROUP(?,?,?)}");
	        objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
	        objCstmt.setString(2, strTravel_id);
			objCstmt.setString(3, strGUserId);
			objCstmt.setString(4, strTravel_type);
	        intSuccess1   =  objCstmt.executeUpdate();
	        objCstmt.close();   
	
	        objCstmt =  objCon.prepareCall("{?=call PROC_T_TRAVEL_EXPENDITURE_INT_UPDATE_GROUP(?)}");
	        objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
		    objCstmt.setString(2, strTravel_id);
	    	intSuccess2   =  objCstmt.executeUpdate();
			objCstmt.close();	
	} else {
			objCstmt = objCon.prepareCall("{?=call PROC_DELETE_FOREX_DETAIL_TABLES_GROUP(?,?,?)}");
	        objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
	        objCstmt.setString(2, strTravel_id);
			objCstmt.setString(3, strGUserId);
			objCstmt.setString(4, strTravel_type);
	        intSuccess1   =  objCstmt.executeUpdate();
	        objCstmt.close();   
	
	        objCstmt =  objCon.prepareCall("{?=call PROC_T_TRAVEL_EXPENDITURE_DOM_UPDATE_GROUP(?)}");
	        objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
		    objCstmt.setString(2, strTravel_id);
		    intSuccess2   =  objCstmt.executeUpdate();
			objCstmt.close();	
	}

	if(!procSuccess  &&   intSuccess1>0 ) {
		strMessage=dbLabelBean.getLabel("label.createrequest.userdeletedsuccessfully",strsesLanguage);	
	} else {
		strMessage=dbLabelBean.getLabel("label.createrequest.unsuccessfulattempttodelete",strsesLanguage);	
	}

   objCstmt.close();
} catch(Exception e) {
	System.out.println("Error in G_userDelete.jsp ==="+e);
}

dbConBean.close();

response.sendRedirect("T_Group_QuickTravel_Detail_MATA.jsp?message="+URLEncoder.encode(strMessage,"UTF-8")+"&travelId="+strTravel_id+"&travelReqId="+strTravel_reqid+"&travellerId="+strTraveller_id+"&travelReqNo="+strTravel_reqno+"&interimId="+strIntermi_id+"&travel_type="+strTravel_type+"&action=addBtn");

%>

