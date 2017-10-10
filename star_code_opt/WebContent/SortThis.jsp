 <%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				             :Shiv sharma 
 *Date of Creation 	         :29-Apr-08
 *Copyright Notice 		     :Copyright(C)2000 MIND.All rights reserved
 *Project	  			             :STARS
 *Operating environment :Tomcat, sql server 2000 
 *Description 		     	    : This is Ajax master used for calculate age  of traveler 
 *Modification 	    	    :
 *Reason of Modification:
 *Date of Modification  :
 *Modified By	  :
 *Editor				:Editplus\
 
 *Modified By		: Manoj Chand
 *Date of Modification :	09 jan 2012
 *Modification			:Done changes to provide both ascending and descending order sorting in travel report.
 
 *Modified By			: Manoj Chand
 *Date of Modification  : 21 June 2012
 *Modification			: Done changes to provide both ascending and descending order sorting in travel report based on billng site and transit days.
 *******************************************************/
%>

 
 <jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />

<%@ page buffer="5kb" language="java"  import="java.sql.*,java.io.*,java.util.Date,java.text.*,javax.mail.*,javax.mail.internet.*,javax.activation.*,java.util.*,java.text.*" 
%>

 <% 
  response.setHeader("Pragma","no-cache");
  response.setDateHeader("Expires",0);
  response.setHeader("Cache-Control","no-cache");

%>
 <%
  
   String strFrom = request.getParameter("strFrom")==null?"1":request.getParameter("strFrom");
   String strTo = request.getParameter("strTo")==null?"1":request.getParameter("strTo");
   String strTravelType = request.getParameter("strTravelType")==null?"1":request.getParameter("strTravelType");
   String strUnitHidden = request.getParameter("strUnitHidden")==null?"1":request.getParameter("strUnitHidden");
   String userID = request.getParameter("userID")==null?"1":request.getParameter("userID");
   String strSelectUnit = request.getParameter("strSelectUnit")==null?"1":request.getParameter("strSelectUnit");
   String strBillingSite = request.getParameter("strchk_billingsite")==null?"n":request.getParameter("strchk_billingsite");
   String strTransitDays = request.getParameter("strchk_transitdays")==null?"n":request.getParameter("strchk_transitdays");
   String strTravelClass = request.getParameter("strchk_travelclass")==null?"n":request.getParameter("strchk_travelclass");
   
   String strTES = request.getParameter("strchk_tes") == null
			? "n"
			: request.getParameter("strchk_tes");
	
	String strCO = request.getParameter("strchk_co") == null
			? "n"
			: request.getParameter("strchk_co");
	
	String strCurr = request.getParameter("strcurrency") == null
			? "1"
			: request.getParameter("strcurrency");
	
	String strTravelStatus = (request.getParameter("strtravelStatus") == null || request.getParameter("strtravelStatus").equals("2,3,4,6,10"))
			? "1"
			: request.getParameter("strtravelStatus");
	
	String strHidCurr	= (request.getParameter("strHidCurr") == null || request.getParameter("strHidCurr").equals(""))
			? "INR"
			: request.getParameter("strHidCurr");
	
   //System.out.println("strBillingSite--s-->"+strBillingSite);
   //System.out.println("strTransitDays--s-->"+strTransitDays);
   //added by manoj chand on 09 jan 2012 to make both kind of sorting.
   String strCount=null;
   int x=0;
   String scount="";
   String Count="";
   for(int i=1;i<=27;i++){
	   strCount=request.getParameter("count"+i);
	   if(strCount!=null){
		   x=i;
		   scount=strCount;
		   //System.out.println("count"+x+"  value is--->"+scount);
		   break;
	   }
		  
   }
   
  if(scount!=null && scount.equalsIgnoreCase("0"))
	  Count="1";
  if(scount!=null && scount.equalsIgnoreCase("1"))
	  Count="2";
  if(scount!=null && scount.equalsIgnoreCase("2"))
	  Count="1";
  
  //end here 
  

String strValues=""; strValues="&from="+strFrom+"&to="+strTo+"&travelType="+strTravelType+"&UnitHidden="+strUnitHidden+"&username="+userID+"&SelectUnit="+strSelectUnit+"&chk_billingsite="+strBillingSite+"&chk_transitdays="+strTransitDays+"&chk_travelClass="+strTravelClass+"&chk_tes="+strTES+"&chk_co="+strCO+"&currency="+strCurr+"&travelStatus="+strTravelStatus+"&hidCurrency="+strHidCurr;

   String col_id = request.getParameter("col_id")==null?"1":request.getParameter("col_id");

 
  String url="T_travelDateWiseReportPost.jsp?col_id="+col_id+"&count"+x+"="+Count+""+strValues;
   response.sendRedirect(url);	
 %>