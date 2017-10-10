<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				                :Rohit Ganjoo
 *Date of Creation 		       :07/09/2006
 *Copyright Notice 		       :Copyright(C)2000 MIND.All rights reserved
 *Project	  						   :STAR
 *Operating environment    :Tomcat, sql server 2000 
 *Description 			           : This is first jsp file  for Showing reports of Requisitions 
 *Modification 			           : 1.Selection of sites in case  of LA ,when LA  has multiple access of site ,on 24-Apr-07   
                                     2. Added a new code for showing "from date"  as seven days before date as current Date  on 22-May-07 by shiv 

 *Reason of Modification    :  New functionality added
 *Date of Modification         :  24-Apr-07 by shiv ,22-May-07 by shiv 
 *Revision History		       :
 *Editor				               :Editplus
 
 *Modified By					: Manoj Chand
 *Date of Modification			: 16 May 2012
 *Modification					: Adding message when approver has a reviewer
 
 *Modified By					: Kaveri Garg
 *Date of Modification			: 09 Nov 2012
 *Modification 					: One column added in Out of office table for site id and in procedure.
 *******************************************************/
%>
<%@ include  file="importStatement.jsp" %>

<%@page import="java.net.URLEncoder" pageEncoding="UTF-8"%>
<HTML>
<HEAD>
<%-- include remove cache  --%>
<%@ include  file="cacheInc.inc" %>
<%-- include header  --%>
<%@ include  file="headerIncl.inc" %>
<%-- include page with all application session variables --%>
<%@ include  file="application.jsp" %>
<%-- include page styles  --%>
<%--<%@ include  file="systemStyle.jsp" %>--%>
<!--Create the DbConnectionBean object for createConnection-->
<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbConBean1" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
<jsp:useBean id="securityUtilityBean" scope="page" class="src.connection.SecurityUtilityMethods" />


<!--Create the DbUtilityMethods object for utility methods-->
<jsp:useBean id="dbUtility" scope="page" class="src.connection.DbUtilityMethods" />

<%
request.setCharacterEncoding("UTF-8");
String  strSql="";
ResultSet rs			=		null;	
Connection objCon					=		null;			    // Object for connection
Statement objStmt					=		null;			   // Object for Statement
ResultSet objRs						=		null;			  // Object for ResultSet
CallableStatement objCstmt			=		null;			// Object for Callable Statement

objCon = dbConBean.getConnection();  //Get the Conneciton
String strFromDate			="";
String strToDate			="";
String strSiteiD			="";
String strTravelType		="";
String strComment			="";
String strDelegateFrom		="";
String strDelegateTo		="";
String strReasonID			=""; 
String url					="";	
String strTurnOFFID			="";
String strSqlStr			="";
String strInsertflag		=""; 
String strMsg				="";
String strIP_Address		="";
String strhandover 			=request.getParameter("handover");
String strHandouverFlage	="";


strIP_Address		=request.getParameter("IP_Address");
String strFromname  =request.getParameter("formname");

	if (strFromname.equals("frm"))
	{
		  strFromDate		=request.getParameter("from");
		  strToDate			=request.getParameter("to");
		  strSiteiD			=request.getParameter("SelectUnit");
		  strTravelType		=request.getParameter("travelType");
		  strComment		=request.getParameter("comment");
		  strDelegateFrom	=request.getParameter("usernameFrom");
		  strDelegateTo		=request.getParameter("usernameTo");
		  strReasonID		=request.getParameter("Reason");
		  //strIP_Address		=request.getParameter("IP_Address");
	}

else {
 		 strTurnOFFID	    =request.getParameter("TurnOFFID"); 
 		 //strIP_Address		=request.getParameter("IP_Address");
 	
	} 
	//System.out.println("--->>> "+strComment);
	String var = "";
	if (strFromname.equals("frm"))
		{
		
//added by manoj chand on 16 may 2012 to display message when approver has a reviewer 		
		String strMessage="";
		strSqlStr="SELECT VIEWTOUSER FROM VW_PAGE_ACCESS_PERMISSION WHERE VW_PAGE_ACCESS_PERMISSION.pendingWithUser='"+strDelegateFrom+"' "+
				  " AND VW_PAGE_ACCESS_PERMISSION.SITE_ID='"+strSiteiD+"' AND VW_PAGE_ACCESS_PERMISSION.status=10";
		//System.out.println("strSqlStr--->"+strSqlStr);
		objRs = dbConBean1.executeQuery(strSqlStr);
		if(objRs.next()){
			strMessage = dbLabelBean.getLabel("label.outofoffice.cannotmarkoutofofficeasselectedapprover",strsesLanguage);
			url = "T_outOfOffice.jsp?message="+URLEncoder.encode(strMessage,"UTF-8")+"&SelectUnit="+strSiteiD+"&from="+strFromDate+"&to="+strToDate+"&travelType="+strTravelType+"&comment="+strComment+"&Reason="+strReasonID;
		}
		objRs.close();
		
		
		
		if(strMessage.trim().equals("")){
		if (strTravelType.equals("A"))
			var = "";
		else
			var = " AND (TRAVEL_TYPE ='"+strTravelType+"')";
		
		String Cnt ="";
		String strTraveltypeForDispaly="";
		strSqlStr="select count(*) from  OUT_OF_OFFICE WHERE  status_id=10 and ((CONVERT(DATETIME, '"+strFromDate+"', 103)  BETWEEN OOO_from_DT AND OOO_TIll_DT) or   (CONVERT(DATETIME, '"+strToDate+"', 103) BETWEEN OOO_from_DT AND OOO_TIll_DT)) AND (DELEGATE_FROM_USER_INFO_ID = "+strDelegateFrom+") " + var ;
		
	 	objRs = dbConBean1.executeQuery(strSqlStr);
		if(objRs.next())
		{
			Cnt = objRs.getString(1);
		}
	 	objRs.close();
		
		 strSqlStr="select TRAVEL_TYPE from  OUT_OF_OFFICE WHERE  status_id=10 and ((CONVERT(DATETIME, '"+strFromDate+"', 103)  BETWEEN OOO_from_DT AND OOO_TIll_DT) or   (CONVERT(DATETIME, '"+strToDate+"', 103) BETWEEN OOO_from_DT AND OOO_TIll_DT)) AND (DELEGATE_FROM_USER_INFO_ID = "+strDelegateFrom+") " + var ;
		 objRs = dbConBean1.executeQuery(strSqlStr);
	      if(objRs.next())
	      {
	    
	    	  if (Cnt.equals("1"))
	    		  {
	    		  	var = objRs.getString(1);
	    		    if (var.equals("I")){
		    		    strTraveltypeForDispaly=dbLabelBean.getLabel("label.outofoffice.internationaltype",strsesLanguage);
		    		 }
		    	    else{ 
		    	        strTraveltypeForDispaly=dbLabelBean.getLabel("label.outofoffice.domestictype",strsesLanguage);
		    	    }
		    	 }
	    		  
    		  if (Cnt.equals("2"))
    		 	 {
	    	        strTraveltypeForDispaly=dbLabelBean.getLabel("label.outofoffice.bothtype",strsesLanguage);
    		 	 }
    		 
    		 // strTraveltypeForDispaly="international/Domestic";
	    	  strInsertflag="1";	       
	       	strMsg="<font color=red>"+dbLabelBean.getLabel("label.outofoffice.youcannotmarkoutofoffice",strsesLanguage)+" "+strTraveltypeForDispaly+" "+dbLabelBean.getLabel("label.outofoffice.forthedaterangeprovided",strsesLanguage)+"</font> ";
	       	strHandouverFlage ="false";
	       	
	       	
	      } 
		  objRs.close();
		  
		 // Code to check if approve have any requistion  pending with his
		
		  
	
	  		try{
 				 //Procedure for Nominal Code
		            if(!strInsertflag.equals("1")){    
					objCstmt=objCon.prepareCall("{?=call PROC_OUTOFOFFICE_INSERT_UPDATE_DELETE(?,?,?,?, ?,?,?,? ,?,?,?,?)}");//PROCEDURE TO ADD THE USER IN SITE TABLE
					objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
					objCstmt.setString(2, "");  // need to be change as primary key in the table
					objCstmt.setString(3, strFromDate );
					objCstmt.setString(4, strToDate);
					objCstmt.setString(5, strDelegateTo);
					objCstmt.setString(6, strDelegateFrom);
					objCstmt.setString(7,strReasonID);
					objCstmt.setString(8,strComment);
					objCstmt.setString(9,strIP_Address);
					objCstmt.setString(10,Suser_id);
					objCstmt.setString(11,"INSERT");
				 	objCstmt.setString(12,strTravelType);
				 	objCstmt.setString(13,strSiteiD);
				 	
					int succ=objCstmt.executeUpdate();
					if(succ >0 )
					{
					strMsg="<font color=green>"+dbLabelBean.getLabel("label.handover.outofofficemarkedsuccessfully",strsesLanguage)+"</font> "; 
					} else{
						objCstmt.close();
						securityUtilityBean.registerUnauthAccessLog(Suser_id, request.getRemoteAddr(), "T_outOfOfficePost.jsp", "Unauthorized Access");
						response.sendRedirect("UnauthorizedAccess.jsp");
						return;
					}
					
					objCstmt.close();
					
					//code that send mail to the person to handover
					%>
					<jsp:include page="T_MailOnOutOfOfice.jsp">
						<jsp:param name="DelegateToUserId" value="<%=strDelegateTo%>"/>
						<jsp:param name="DelegateFromUserId" value="<%=strDelegateFrom%>"/>
						<jsp:param name="TravelType" value="<%=strTravelType%>"/>
						<jsp:param name="FromDate" value="<%=strFromDate%>"/>
						<jsp:param name="ToDate" value="<%=strToDate%>"/> 
						<jsp:param name="site" value="<%=strSiteiD%>"/> 
						<jsp:param name="Comment" value="<%=strComment%>"/>
					</jsp:include>
			 		<%
			    }	
			 }catch(Exception e)
  					{
		  			System.out.println("Error in Out of office post page=====>"+e);
  				}
			 
		    if(strhandover.equals("true"))
			   {
		    	url="T_HandOverRequest.jsp?travel_type="+strTravelType+"&userid="+strDelegateFrom+"&Msg="+strHandouverFlage+"&strmsg2="+URLEncoder.encode(strMsg,"UTF-8")+""; 		 
		    	session.setAttribute("siteforOutFOrmark",strSiteiD); 
		    	
			 }
		    else
		     {
		    	url="T_outOfOffice.jsp?strMsg="+URLEncoder.encode(strMsg,"UTF-8")+"&userid="+strDelegateFrom;
			 
		     }
		}//new				 
		}else
			{
			try{
	 			 //Procedure for Nominal Code

				objCstmt=objCon.prepareCall("{?=call PROC_OUTOFOFFICE_INSERT_UPDATE_DELETE(?,?,?,?, ?,?,?,? ,?,?,?,?)}");//PROCEDURE TO ADD THE USER IN SITE TABLE
				objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
				objCstmt.setString(2,strTurnOFFID );  // need to be change as primary key in the table
				objCstmt.setString(3, "" );
				objCstmt.setString(4, "");
				objCstmt.setString(5, "");
				objCstmt.setString(6, "");
				objCstmt.setString(7,"");
				objCstmt.setString(8,"");
				objCstmt.setString(9,strIP_Address);
				objCstmt.setString(10,Suser_id);
				objCstmt.setString(11,"DELETE");
				objCstmt.setString(12,strTravelType);
			 	objCstmt.setString(13,strSiteiD);
				int isucc=objCstmt.executeUpdate();
				
				if (isucc>0){
					strMsg="<font color=green>"+dbLabelBean.getLabel("label.outofoffice.turnedoffsuccessfully",strsesLanguage)+"</font>";
				 }
					objCstmt.close();
				 }catch(Exception e)
	  					{
			  			System.out.println("Error in Out of office post page= in delete block====>"+e);
	  				}
				 
				 url="T_outOfOffice.jsp?strMsg="+URLEncoder.encode(strMsg,"UTF-8");
	}

response.sendRedirect(url); 
%>