
<%
/***************************************************
 *The information contained here in is confidential and  
 *proprietary to MIND and forms the part of the MIND 
 *Author				:
 *Date of Creation 		:
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STARS
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:
 *Modification 			:1. Commented some unused code
 *Reason of Modification:1. Unused Code
 *Date of Modification  :1. 22-May-2007 
 * Modification By		:1. Gaurav Aggarwal
						 2  Procedure call for removing TID & SID entry from SSO_HISTORY table add by shiv sharma on 4/14/2009
 *Editor				:Editplus
 
 *Modified By			:Manoj Chand
 *Date of Modification	:23 Oct 2013
 *Modification			:invalide the session when user click on log out button
 *******************************************************/
%>
<%@ page import="src.dao.starDaoImpl" %>
<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbUtility" scope="page" class="src.connection.DbUtilityMethods" />
<%@ page buffer="5kb" language="java"  import="java.sql.*,java.io.*,java.util.*,java.io.*" %>
 
<HTML>
<head>

</head>  

<%
// Variables declared and initialized for session Management
		//Current Http Session object

Connection con  = null;				// Object for connection

CallableStatement cstmt			=		null;	

%>

<!--@Gaurav Aggarwal 21-May-2007  
<body background="images/page-bg.jpg?buildstamp=2_0_0" bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="document.frm1.submit();">-->

<%  
        //HttpSession hs							=		request.getSession(true);  
	    // objCstmt  =  objCon.prepareCall("{?=call SPG_SSO_HISTORY(?,?)}");  
	    String userid=request.getParameter("userid")==null?"0":request.getParameter("userid");
	    con=dbConBean.getConnection(); 
        String struserid ="";//session.getAttribute("user_id").toString()==null?"0":session.getAttribute("user_id").toString();  
        
       // if (struserid.equals(""))
       // {
       // 	struserid="0";
       // } 
     struserid= userid;
     	
     	starDaoImpl sdi    	= new starDaoImpl();
		String ipAddress 	= request.getRemoteAddr();
		String sUserId		= request.getParameter("sessionUid")==null?"0":request.getParameter("sessionUid");
		
		sdi.updateLogoutInfoOnSessionTimeOut(sUserId, ipAddress);
		
	//  Procedure call for removing TID & SID entry from SSO_HISTORY table add by shiv sharma on 4/14/2009 	
      if(struserid!=null && !struserid.equals("")){
    	  
    	cstmt=con.prepareCall("{?=call SPG_SSO_HISTORY(?,?)}");
   		cstmt.registerOutParameter(1,java.sql.Types.INTEGER); 
   		cstmt.setString(2, struserid);  
   		cstmt.setString(3, "STAR");
   		cstmt.execute(); 
   		cstmt.close(); 
    	   
      } 
      HttpSession hs = request.getSession(true);
      hs.invalidate();
%>

<body  onLoad="document.frm1.submit();" unload="window.close();"  >

<form method=post action="index.jsp" name=frm1 target=_top>

</form>

