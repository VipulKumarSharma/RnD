<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				       :Manoj Chand		
 *Date of Creation 		       :19/01/2011
 *Copyright Notice 		       :Copyright(C)2000 MIND.All rights reserved
 *Project	  				   :STAR
 *Operating environment        :Tomcat, sql server 2000 
 *Description 			       :Jsp file  for Showing reports of Requisitions 
 *Editor					   :Eclipse
 *******************************************************/
%>
<%@ include  file="importStatement.jsp" %>

<%@page import="java.net.URLEncoder"%><HTML>
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
String strhandover 			=request.getParameter("handover")==null?"":request.getParameter("handover");
String strHandouverFlage	="";
String flag="y";
String pageflag="t"; 

strIP_Address		=request.getParameter("IP_Address")==null?"":request.getParameter("IP_Address");
String strFromname  =request.getParameter("formname")==null?"":request.getParameter("formname");
//Added By Gurmeet Singh
String strUserAccessCheckFlag = "";


	if (strFromname.equals("frm"))
	{
		  strFromDate		=request.getParameter("from")==null?"":request.getParameter("from");
		  strToDate			=request.getParameter("to")==null?"":request.getParameter("to");
		  strSiteiD			=request.getParameter("SelectUnit")==null?"":request.getParameter("SelectUnit");
		  strTravelType		=request.getParameter("travelType")==null?"":request.getParameter("travelType");
		  strComment		=request.getParameter("comment")==null?"":request.getParameter("comment");
		  strDelegateFrom	=request.getParameter("usernameFrom")==null?"":request.getParameter("usernameFrom");
		  strDelegateTo		=request.getParameter("usernameTo")==null?"":request.getParameter("usernameTo");
		  strReasonID		=request.getParameter("Reason")==null?"":request.getParameter("Reason");
		  //strIP_Address		=request.getParameter("IP_Address");
	//System.out.println("strTravelType==>>"+strTravelType);
		//Added By Gurmeet Singh
			strUserAccessCheckFlag = securityUtilityBean.validateAuthSiteUserAccess(strDelegateFrom, strSiteiD, "0");
			if(strUserAccessCheckFlag.equals("420")){
				dbConBean.close(); 
				dbConBean1.close();
				securityUtilityBean.registerUnauthAccessLog(Suser_id, request.getRemoteAddr(), "T_handOverReqPost.jsp", "Unauthorized Access");
				response.sendRedirect("UnauthorizedAccess.jsp");
				return;
			}
	}

else {
 		 strTurnOFFID	    =request.getParameter("TurnOFFID")==null?"":request.getParameter("TurnOFFID"); 
 		 //strIP_Address		=request.getParameter("IP_Address");
 		
	} 
	String var = "";
	if (strFromname.equals("frm"))
		{
		if (strTravelType.equals("A"))
			var = "";
		else
			var = " AND (TRAVEL_TYPE ='"+strTravelType+"')";
		
		String Cnt ="";
		String strTraveltypeForDispaly="";
		strSqlStr="select count(*) from  OUT_OF_OFFICE WHERE  status_id=10 and ((CONVERT(DATETIME, '"+strFromDate+"', 103)  BETWEEN OOO_from_DT AND OOO_TIll_DT) or   (CONVERT(DATETIME, '"+strToDate+"', 103) BETWEEN OOO_from_DT AND OOO_TIll_DT)) AND (DELEGATE_FROM_USER_INFO_ID = "+strDelegateFrom+") " + var ;
		//System.out.println("strSQLSTR---->>1."+strSqlStr);
	 	objRs = dbConBean1.executeQuery(strSqlStr);
		if(objRs.next())
		{
			Cnt = objRs.getString(1);
		}
	 	objRs.close();
	 	
		 strSqlStr="select TRAVEL_TYPE from  OUT_OF_OFFICE WHERE  status_id=10 and ((CONVERT(DATETIME, '"+strFromDate+"', 103)  BETWEEN OOO_from_DT AND OOO_TIll_DT) or   (CONVERT(DATETIME, '"+strToDate+"', 103) BETWEEN OOO_from_DT AND OOO_TIll_DT)) AND (DELEGATE_FROM_USER_INFO_ID = "+strDelegateFrom+") " + var ;
		 //System.out.println("strSQLSTR---->>2."+strSqlStr);
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
    		  System.out.println("");
    		 // strTraveltypeForDispaly="international/Domestic";
	    	  strInsertflag="1";	       
	       	strMsg="<font color=red>"+dbLabelBean.getLabel("label.outofoffice.youcannotmarkoutofoffice",strsesLanguage)+" "+strTraveltypeForDispaly+" "+dbLabelBean.getLabel("label.outofoffice.forthedaterangeprovided",strsesLanguage)+" </font> ";
	       	strHandouverFlage ="false";
	       	
	       	
	      } 
		  objRs.close();
		  
		  		//System.out.println("travel_type=====>>>>"+strTravelType);
  				//System.out.println("userid=====>>>>"+strDelegateFrom);
  				//System.out.println("Msg=====>>>>"+strHandouverFlage);
  				//System.out.println("strmsg2=====>>>>"+strMsg);
  				//System.out.println("strhandover=====>>>>"+strhandover);
  				
		    if(strhandover.equals("true"))
			   {
		    	//System.out.println("------------if-first----------");
		    	//url="T_HandOverRequest.jsp?travel_type="+strTravelType+"&userid="+strDelegateFrom+"&Msg="+strHandouverFlage+"&strmsg2="+strMsg+"&flag=y&pageflag=t"; 		 
		    	url="T_HandOverRequest.jsp?travel_type="+strTravelType+"&userid="+strDelegateFrom+"&Msg="+strHandouverFlage+"&strmsg2="+URLEncoder.encode(strMsg,"UTF-8")+"&flag="+flag+"&pageflag="+pageflag;
		    	//url="T_HandOverRequest.jsp?travel_type="+strTravelType+"&userid="+strDelegateFrom+"";
		    	session.setAttribute("siteforOutFOrmark",strSiteiD); 
		    	//System.out.println("------------if-second----------");
			 }
		    else
		     {
		    	//System.out.println("-----------else-first-----------");
		    	url="T_outOfOffice.jsp?strMsg="+URLEncoder.encode(strMsg,"UTF-8")+"&userid="+strDelegateFrom;
		    	//System.out.println("-----------else-second----------");
		     }
						 
		}


 //System.out.println("response.sendRedirect(url)=====>>"+url);
response.sendRedirect(url);
	 
%>
</html>