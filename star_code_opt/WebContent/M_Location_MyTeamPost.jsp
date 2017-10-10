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
CallableStatement objCstmt  		=		null;		      // Object for Callable Statement
objCon                              =       dbConBean.getConnection(); 
String strQuery						=       null;
ResultSet rs						=		null;
String strIpAddress = request.getRemoteAddr();

int icount = Integer.parseInt(request.getParameter("flagIndex"));
int  iuserID = 0;
String site_ID = "";
String user_ID = "";
String addRemove_Flag = "";
String strMessage = "";
String user_Flag = "";
String strSearchFlag = "true";

for (int i =1 ; i < icount ; i++) {
	String index = new Integer(i).toString();
	String strChkBoxVal = request.getParameter("childCheckBox"+index) == null ? "N" :request.getParameter("childCheckBox"+index);
	
	if(strChkBoxVal.equalsIgnoreCase("Y")){	
		iuserID = Integer.parseInt(request.getParameter("userID" +index));
		site_ID = request.getParameter("selectUnit")==null?"-1":request.getParameter("selectUnit");
		user_ID = request.getParameter("username")==null?"-1":request.getParameter("username");
		user_Flag = request.getParameter("userFlag2")==null?"":request.getParameter("userFlag2");
		addRemove_Flag = request.getParameter("addRemoveFlag")==null?"":request.getParameter("addRemoveFlag");		
		
		try	{
			if(addRemove_Flag.equals("add")){
				
					objCstmt = objCon.prepareCall("{?=call PROC_INSERT_TEAM_MEMBER(?,?,?,?,?,?,?)}"); 
					objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
					objCstmt.setInt(2, Integer.parseInt(site_ID));
					objCstmt.setInt(3, Integer.parseInt(Suser_id));
					objCstmt.setInt(4, iuserID);
					objCstmt.setString(5, "");							
					objCstmt.setString(6, strIpAddress);
					objCstmt.setString(7,"INSERT");
					objCstmt.registerOutParameter(8,java.sql.Types.INTEGER);
					int intSuccess = objCstmt.executeUpdate();
					if(intSuccess == 0) {
						strMessage = dbLabelBean.getLabel("alert.myteam.recordaddedsuccess",strsesLanguage);						   
					} else {
						strMessage = dbLabelBean.getLabel("alert.myteam.errorinaddingrecord",strsesLanguage);
					}
				    objCstmt.close();
				
			} else if(addRemove_Flag.equals("remove")){
				
				objCstmt = objCon.prepareCall("{?=call PROC_INSERT_TEAM_MEMBER(?,?,?,?,?,?,?)}"); 
				objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
				objCstmt.setInt(2, Integer.parseInt(site_ID));
				objCstmt.setInt(3, Integer.parseInt(Suser_id));
				objCstmt.setInt(4, iuserID);
				objCstmt.setString(5, "");							
				objCstmt.setString(6, strIpAddress);
				objCstmt.setString(7,"DELETE");
				objCstmt.registerOutParameter(8,java.sql.Types.INTEGER);
				int intSuccess = objCstmt.executeUpdate();
				if(intSuccess == 0){
					strMessage = dbLabelBean.getLabel("alert.myteam.recordremovedsuccess",strsesLanguage);					
				} else {
					strMessage = dbLabelBean.getLabel("alert.myteam.errorinremoverecord",strsesLanguage);
				}
			    objCstmt.close();
			
			}
		} catch (SQLException e) {
			System.out.println("Error in M_Location_MyTeamPost.jsp ==="+e);
	    } catch(Exception e) {
	    	System.out.println("Error in M_Location_MyTeamPost.jsp ==="+e);
	    }
		
	}
}

response.sendRedirect("M_Location_MyTeam.jsp?selectUnit="+site_ID+"&username="+user_ID+"&userFlag="+user_Flag+"&searchFlag="+strSearchFlag+"&strMessage="+URLEncoder.encode(strMessage,"UTF-8")+"");
%>