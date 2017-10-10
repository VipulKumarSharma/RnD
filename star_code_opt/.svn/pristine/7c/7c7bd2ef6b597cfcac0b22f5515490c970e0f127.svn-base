	<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
	<%@ include  file="importStatement.jsp" %>
	<%-- include remove cache  --%>
	<%@ include  file="cacheInc.inc" %>
	<%-- include header  --%>
	<%@ include  file="headerIncl.inc" %>
	<%-- include page with all application session variables --%>
	<%-- include page with all application session variables --%> 
	<%@ include  file="application.jsp" %>
	<%
	String sSqlStr=""; 
	ResultSet rs	=	null;	
	
	String strUserID =request.getParameter("userid");  
	String strAction =request.getParameter("action");
	
	Connection objCon					=  null;    
    CallableStatement objCstmt	=  null;  
    
    objCon               =  dbConBean.getConnection(); 
	
	if(strAction.equals("save")){ 
	
		  objCstmt             =  objCon.prepareCall("{?=call PROC_USER_SITE_ACCESS_ACTION(?,?)}"); 
		  objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
	      objCstmt.setString(2, strAction); 
	      objCstmt.setString(3, strUserID);       
	      int iSuccess1   =  objCstmt.executeUpdate(); 
	      objCstmt.close();	
	}else if(strAction.equals("remove")){  
		 
		  objCstmt  =  objCon.prepareCall("{?=call PROC_USER_SITE_ACCESS_ACTION(?,?)}");  
		  objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
	      objCstmt.setString(2, strAction); 
	      objCstmt.setString(3, strUserID);       
	      int iSuccess1   =  objCstmt.executeUpdate(); 
	      objCstmt.close();	
		
	} 

	String url="M_multipleSiteaccess.jsp?userId="+strUserID; 
	
 
	
	response.sendRedirect(url);    
	
	%>