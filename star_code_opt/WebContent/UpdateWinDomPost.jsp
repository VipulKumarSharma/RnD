		<%
	/***************************************************
	 *The information contained here in is confidential and 
	 * proprietary to MIND and forms the part of the MIND 
	 *Author				:Shiv sharma 
	 *Date of Creation 		:04 Feb 2010
	 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
	 *Project	  			:STAR
	 *Operating environment :Tomcat, sql server 2000 
	 *Description 			:Updation of Windows user id & Domain Name
	 *Modification 			: 
	 *Reason of Modification:
	 *Date of Modification  : 
	 *Revision History		:
	 *Editor				:Editplus
	 *******************************************************/
	%> 
	
	<%@ include  file="importStatement.jsp" %>
	<%@ include  file="cacheInc.inc" %>
	<%@ include  file="headerIncl.inc" %>
	<!--Create Conneciton by useBean-->
	<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
	
	<!--Create the DbUtilityMethods object for utility methods-->
	
	<%
	String user				=null;
	String strSql       	= "";  
	String strDomain		="";
	String strWinuserid		="";
	String strPage			="";   
	try
	{
		
		strPage 					 =	request.getParameter("page").trim();  
		user                		 =  request.getParameter("user").trim(); 
		strDomain             		 =  request.getParameter("domain").trim();
		strWinuserid           	   	 =  request.getParameter("winuserid").trim();
	
	    int updated = 0;
		strSql = "update m_userinfo set SSO_ENABLE='y', WIN_USER_ID ='"+strWinuserid+"',DOMAIN_NAME='"+strDomain+"' where  username='"+user+"' and status_id=10";
		updated = dbConBean.executeUpdate(strSql);  
	
		if(updated > 0)   
		{
	        	 if(strPage.equals("yes"))  
				   {
		        	%>
		        	   <jsp:forward page="innerMainforApproval.jsp" >
		        	   	<jsp:param name="Userid" value="<%=user%>" />
		        	   </jsp:forward> 
		        	<% 
		    	  }else{
		    		  %>
		        	   <jsp:forward page="innerMain.jsp" >
		        	   	<jsp:param name="Userid" value="<%=user%>" />
		        	   </jsp:forward> 
		        	<% 
		    	   }
		}  	 
 
	}
	catch(Exception e)
	{
		System.out.println("Error in password_change_post_new==="+e);
	}
	%>
