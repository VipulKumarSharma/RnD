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
	   String strUnitid =request.getParameter("unit"); 
	   String strUserID =request.getParameter("userid"); 
	   String strAction =request.getParameter("action"); 
	   String sSqlStr="";
	   
	   
		Connection objCon					=  null;    
	    CallableStatement objCstmt			=  null;  
	    objCon               =  dbConBean.getConnection(); 
	   
		
	    if(strAction.equals("add")){ 
		  objCstmt             =  objCon.prepareCall("{?=call PROC_USER_SITE_ACCESS(?,?,?,?)}"); 
		  objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
	      objCstmt.setString(2, strUnitid); 
	      objCstmt.setString(3, "15");            
	      objCstmt.setString(4, strUserID);       
	      objCstmt.setString(5, Suser_id);    
	      int iSuccess1   =  objCstmt.executeUpdate(); 
	      objCstmt.close();	
		}
		else{
			  objCstmt             =  objCon.prepareCall("{?=call PROC_USER_SITE_ACCESS(?,?,?,?)}"); 
			  objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
		      objCstmt.setString(2, strUnitid); 
		      objCstmt.setString(3, "30");            
		      objCstmt.setString(4, strUserID);       
		      objCstmt.setString(5, Suser_id);    
		      int iSuccess1   =  objCstmt.executeUpdate(); 
		      objCstmt.close();	
			
		} 
	
	    
	    String url="M_multipleSiteaccess.jsp?userId="+strUserID; 
	    
	    
	    response.sendRedirect(url);    
	
	%>