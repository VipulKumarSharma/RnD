	 
	<%@ include  file="importStatement.jsp" %>
	<html>
	<head>
	
	<script>  
	  self.moveTo(0,0);
	  self.resizeTo(screen.width,screen.height);  
	</script>
	<%@ include  file="cacheInc.inc" %>
	<%-- include header template (design) --%>
	<%@ include  file="headerIncl.inc" %>
	<%-- include page with all application session variables --%>
	<%@ include  file="application.jsp" %> 
	</head>
	<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
	
	<frameset framespacing="0" border="false" rows="112,*,30" frameborder="0"> 
	   <frame name="top11" target="bottom" src="top11FAP.jsp" scrolling="no" marginwidth="0" marginheight="0" noresize>
	   
	   <%
		String	strSqlStr	=	""; // For sql Statements
		String strCheckAlert		="";
		String strApproverRole 		= "";
		String strSql				= "";	 
		String strPage 		= "no";
		String strOutOFOfficestatus	="";
		ResultSet rs,rs1									=		null;  
		String userid= request.getParameter("Userid");   
		String travel_type="";
		int expTrvReqWeeks = 0;
		
		strSql  = "SELECT CAST(FUNCTION_VALUE AS INT) FROM functional_ctl WHERE FUNCTION_KEY='@ExpTrvReqCutOffWeekForApproval'";
	   rs = dbConBean.executeQuery(strSql);
	   if(rs.next())
	   {
	   	expTrvReqWeeks = rs.getInt(1);
	   }
	   rs.close();
	
		//System.out.println("userid====="+userid); 
		
		  	strSql="SELECT  DISTINCT TA.TRAVEL_ID, TA.TRAVELLER_ID, TD.TRAVEL_REQ_NO, ISNULL(RTRIM(.DBO.USER_NAME(TA.TRAVELLER_ID)),'NA') AS TRAVELLER,ISNULL(dbo.CONVERTDATEDMY1(TA.C_DATETIME),'-') AS C_DATE,ISNULL(RTRIM(.DBO.USER_NAME(TA.C_USER_ID)),'NA') AS CREATED_BY,ISNULL(RTRIM(.DBO.NEXTAPPROVER(TD.TRAVEL_ID,'I',TA.TRAVELLER_ID)),'NA') AS NEXTWITH, dbo.REQUISITIONATTACHMENT(TD.TRAVEL_ID,'I')AS ATTACHMENT  FROM T_APPROVERS TA, T_TRAVEL_STATUS TS,T_TRAVEL_DETAIL_INT TD WHERE TA.TRAVEL_ID=TS.TRAVEL_ID AND TD.TRAVEL_ID=TS.TRAVEL_ID  AND TS.TRAVEL_STATUS_ID=2 AND TS.TRAVEL_TYPE='I' AND TA.APPROVE_STATUS=0 AND TA.APPROVER_ID="+Suser_id+"  AND TA.TRAVEL_TYPE='I'  AND ORDER_ID=(SELECT MIN(ORDER_ID)FROM T_APPROVERS  WHERE TRAVEL_ID=TS.TRAVEL_ID AND TRAVEL_TYPE='I'  AND APPROVE_STATUS=0 AND STATUS_ID=10 ) AND TD.TRAVEL_DATE>=CAST(DATEADD(WK,-"+expTrvReqWeeks+",GETDATE()) AS DATE)";
		
	    
			rs = dbConBean.executeQuery(strSql);
			if (rs.next()) 
			{
			   strPage		=	"yes"; 
			   travel_type  ="INT";
			}
			rs.close();
			
	    	 strSql="SELECT  DISTINCT TA.TRAVEL_ID, TA.TRAVELLER_ID, TD.TRAVEL_REQ_NO, ISNULL(RTRIM(.DBO.USER_NAME(TA.TRAVELLER_ID)),'NA') AS TRAVELLER,ISNULL(dbo.CONVERTDATEDMY1(TA.C_DATETIME),'-') AS C_DATE,ISNULL(RTRIM(.DBO.USER_NAME(TA.C_USER_ID)),'NA') AS CREATED_BY,ISNULL(RTRIM(.DBO.NEXTAPPROVER(TD.TRAVEL_ID,'D',TA.TRAVELLER_ID)),'NA') AS NEXTWITH, dbo.REQUISITIONATTACHMENT(TD.TRAVEL_ID,'D')AS ATTACHMENT  FROM T_APPROVERS TA, T_TRAVEL_STATUS TS,T_TRAVEL_DETAIL_DOM TD WHERE TA.TRAVEL_ID=TS.TRAVEL_ID AND TD.TRAVEL_ID=TS.TRAVEL_ID  AND TS.TRAVEL_STATUS_ID=2 AND TS.TRAVEL_TYPE='D' AND TA.APPROVE_STATUS=0 AND TA.APPROVER_ID="+Suser_id+"  AND TA.TRAVEL_TYPE='D'  AND ORDER_ID=(SELECT MIN(ORDER_ID)FROM T_APPROVERS  WHERE TRAVEL_ID=TS.TRAVEL_ID AND TRAVEL_TYPE='D'  AND APPROVE_STATUS=0 AND STATUS_ID=10 ) AND TD.TRAVEL_DATE>=CAST(DATEADD(WK,-"+expTrvReqWeeks+",GETDATE()) AS DATE)";
	    	 
			
			rs = dbConBean.executeQuery(strSql); 
			if (rs.next()) 
			{
			   strPage		=	"yes";  
			   travel_type  ="DOM";
			}
			rs.close();
	   
	   %>
	   <%  if(SuserRole.equals("MATA")){   
		  	     if(travel_type.equals("INT"))
				     {
			   		%>
			   		<frame name="middle" target="bottom" src="T_approveTravelRequisitions.jsp?travel_type=INT" scrolling="auto" marginwidth="0" marginheight="0" noresize>
			   		<%}else{
			   			%>
			   	   		<frame name="middle" target="bottom" src="T_approveTravelRequisitions_D.jsp?travel_type=DOM" scrolling="auto" marginwidth="0" marginheight="0" noresize>
			   	   		<%
			   		}
			   		%>
	   <% }
	   else{ 
	   %>
	   
	    <frame name="middle" target="bottom" src="T_approveTravelRequisitions_All.jsp" scrolling="auto" marginwidth="0" marginheight="0" noresize>     
	    <%}
	   %>
	   <frame name="bottom11" src="bot2.jsp" scrolling="no" marginwidth="0" marginheight="0" noresize>
	   <noframes>
	     <body>
	       <p>This page uses frames, but your browser doesn't support them.</p>
	     </body>
	   </noframes>
	</frameset>
	</html>
	 