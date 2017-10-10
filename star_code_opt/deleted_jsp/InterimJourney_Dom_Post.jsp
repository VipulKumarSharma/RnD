<%/************************************************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author									:Abhinav Ratnawat
 *Date of Creation 				:11 September 2006
 *Copyright Notice 				:Copyright(C)2000 MIND.All rights reserved
 *Project	  								:STAR
 *Operating environment	:Tomcat, sql server 2000 
 *Description 			:
  *Modification 	    :Change the display fuctionality.
                            :Added new filed for prefered time in intermediate destination journey  on 26-Oct-07   by Shiv Sharma 
 *Reason of Modification: change suggested by MATA
 *Date of Modification  :14 Nov 2006 
 *Modified By	        :SACHIN GUPTA
 
 *Modified By			:Manoj Chand
 *Date of modification	:26 Sep 2011
 *Modification 			:added interim jouney details for group request also.
 
 *Editor									:Editplus
 *****************************************************************************************/
%>
<%-- Import Statements  --%>
<%@ include  file="importStatement.jsp" %>
<%-- include remove cache  --%>
<%@ include  file="cacheInc.inc" %>
<%-- include header  --%>
<%@ include  file="headerIncl.inc" %>
<%-- include page with all application session variables --%>
<%-- include page with all application session variables --%>
<%@ include  file="application.jsp" %>

<!--Create the DbConnectionBean object for createConnection-->

<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbUtilityBean" scope="page" class="src.connection.DbUtilityMethods" />
<% 
request.setCharacterEncoding("UTF-8");
Connection objCon					=  null;            //Object for Connection 
ResultSet rs			 					=  null;            // Object for ResultSet
CallableStatement objCstmt	=  null;		    // Object for Callable Statement
int iSuccess1							=	0;
String strSql               = ""; 
String strDCity 			= "";
String strACity				= "";
String strDDate 			= "";
String strDMode 			= "";
String strDAirline 			= "";
String strDClass			= "";
String strTravel_Id 		= "";
String strTravel_Type	    ="D";


String strAcualTravelId = "";
String strUpdateFlag    = "";

String strPreferedTimeInterMediate=""; 
strAcualTravelId        =  request.getParameter("actualTravelId");

//added new for showing seat preffeence on 08 jan 2009  

String strSeatPrefer =  request.getParameter("strSeatPrefer");



if(strAcualTravelId != null && !strAcualTravelId.equals("null") && !strAcualTravelId.equals("") && !strAcualTravelId.equals("new"))
{
	strUpdateFlag = "yes";     
}
else
	strUpdateFlag = "no"; 
 


//getting value from request
strDCity							=	request.getParameter("strDeptCity");
strACity							=	request.getParameter("strArrCity");
strDDate					     	=	request.getParameter("strDeptDate");
strDMode				     		=	request.getParameter("strMode");
strDAirline					    	=	request.getParameter("strAirlineName");
strDClass					    	=	request.getParameter("strClass");
strTravel_Id				    	=	request.getParameter("travel_id");

strPreferedTimeInterMediate          =  request.getParameter("preferTimeInterMediate")==null?"1":request.getParameter("preferTimeInterMediate");
String strGroupFlag 				=	request.getParameter("Groupflag")==null?"no":request.getParameter("Groupflag");
//System.out.println("strGroupFlag--->"+strGroupFlag);

//added by manoj on 03 oct 2011

String strfwddepCity = request.getParameter("fwddepCity")==null?"":request.getParameter("fwddepCity");
String strfwdarrCity = request.getParameter("fwdarrCity")==null?"":request.getParameter("fwdarrCity");
String strfwddepDate = request.getParameter("fwddepDate")==null?"":request.getParameter("fwddepDate");
String strfwdpreferTime = request.getParameter("fwdpreferTime")==null?"1":request.getParameter("fwdpreferTime");
String strtravelMode = request.getParameter("travelMode")==null?"1":request.getParameter("travelMode");
String strfwdnameOfAirline = request.getParameter("fwdnameOfAirline")==null?"":request.getParameter("fwdnameOfAirline");
String strfwdtravelClass = request.getParameter("fwdtravelClass")==null?"":request.getParameter("fwdtravelClass");
String strfwdseatpreference = request.getParameter("fwdseatpreference")==null?"":request.getParameter("fwdseatpreference");
String strfwdforTatkaalRequired = request.getParameter("fwdforTatkaalRequired")==null?"n":request.getParameter("fwdforTatkaalRequired");
String strfwdforCoupanRequired = request.getParameter("fwdforCoupanRequired")==null?"n":request.getParameter("fwdforCoupanRequired");
String strfwdticketrefund = request.getParameter("fwdticketrefund")==null?"n":request.getParameter("fwdticketrefund");
String strtransit = request.getParameter("transit")==null?"0":request.getParameter("transit");
String strcurrency = request.getParameter("currency")==null?"INR":request.getParameter("currency");
String strplace = request.getParameter("place")==null?"":request.getParameter("place");
String strbudget = request.getParameter("budget")==null?"":request.getParameter("budget");
String strcheckin = request.getParameter("checkin")==null?"":request.getParameter("checkin");
String strcheckout = request.getParameter("checkout")==null?"":request.getParameter("checkout");
String strothers = request.getParameter("others")==null?"":request.getParameter("others");
String struserids = request.getParameter("userids")==null?"":request.getParameter("userids");

String strdomvalflag="fwddepCity="+strfwddepCity+"&fwdarrCity="+strfwdarrCity+"&fwddepDate="+strfwddepDate+"&fwdpreferTime="+strfwdpreferTime+"&travelMode="+strtravelMode+"&fwdnameOfAirline="+strfwdnameOfAirline+"&fwdtravelClass="+strfwdtravelClass+"&fwdseatpreference="+strfwdseatpreference+"&fwdforTatkaalRequired="+strfwdforTatkaalRequired+"&fwdforCoupanRequired="+strfwdforCoupanRequired+"&fwdticketrefund="+strfwdticketrefund+"&transit="+strtransit+"&currency="+strcurrency+"&place="+strplace+"&budget="+strbudget+"&checkin="+strcheckin+"&checkout="+strcheckout+"&others="+strothers+"&userids="+struserids;

//System.out.println("strvalflag---post-->"+strdomvalflag);

if (strTravel_Id.equals("") || strTravel_Id == null  ) {
strTravel_Id  =  dbUtilityBean.getNewGeneratedId("INTERIM_ID")+"";
} 

try
{
  objCon               =  dbConBean.getConnection(); 
 // objCon.setAutoCommit(false);
  if(strUpdateFlag.equals("yes"))  // FIRST TIME INSERT UNTIL TRAVEL_ID IS NOT GENRATED----(i.c .  NULL ) ---BY SHIV SHARMA 
  {
	  String strNewJouneyOrder = "";
	  //System.out.println("inside update block----------");
	  strSql  ="SELECT MAX(JOURNEY_ORDER)+1 AS NEW_JOURNEY_ORDER FROM T_JOURNEY_DETAILS_DOM WHERE TRAVEL_ID ="+strAcualTravelId+" AND STATUS_ID=10 AND APPLICATION_ID=1";
	  rs = dbConBean.executeQuery(strSql);
	  if(rs.next())
	  {
		  strNewJouneyOrder = rs.getString("NEW_JOURNEY_ORDER");
		  //System.out.println("strNewJouneyOrder ----> > "+strNewJouneyOrder);
	  }
	  rs.close();
	  
	  //PROCEDURE for INSERT data in T_JOURNEY_DETAILS_INT
	  objCstmt             =  objCon.prepareCall("{?=call PROC_INSERT_T_JOURNEY_DETAILS_DOM(?,?,?,?,?,?,?,?,?,?,?,?  ,?,?)}"); 
      objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
      objCstmt.setString(2, strAcualTravelId);
      objCstmt.setString(3, strDCity);             //set the Traveller Departure City Name(TRAVEL_FROM)
      objCstmt.setString(4, strACity);             //set the Traveller Arrival City Namei(TRAVEL_TO)
      objCstmt.setString(5, strDDate);             //set the Traveller Departure Date
      objCstmt.setString(6, strNewJouneyOrder);        //set the Order of Traveller intrim journey(it is 1 for the actual from and to)
      objCstmt.setString(7, strDMode);         //set the Travel Mode name( in int value) e.g. 1 for Air or 2 for Train
      objCstmt.setString(8, strDAirline);      //set the Travel Mode name(in int value), e.g. Air India, Air Deccon etc.
      objCstmt.setString(9, strDClass);        //set the Travel Class Name(in int value), e.g. First class, Business class 
      objCstmt.setString(10, strPreferedTimeInterMediate);     
	  //set the Travel Preferred Time e.g. Morning,evening etc.  Added by shiv on 25-Oct-07
      
      objCstmt.setString(11, Suser_id);              //set the current user Login UserId
      
      objCstmt.setString(12, strSeatPrefer);              //set the current user Login UserId
      objCstmt.setString(13, "n");              //set the current user Login UserId
      objCstmt.setString(14, "1");
	  objCstmt.setInt(15, 0);
      iSuccess1   =  objCstmt.executeUpdate();
      objCstmt.close();	

	//System.out.println("iSuccess1=========="+iSuccess1);
	  
  }
  else
  {
          
	  objCstmt             =  objCon.prepareCall("{?=call PROC_INSERT_T_INTERIM_JOURNEY_DETAILS(?,?,?,?,?,?,?,?,?,?,  ?,?,?)}");//PROCEDURE to insert the row in T_INTERIM_JOURNEY  Table
	  objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
	  objCstmt.setString(2, strTravel_Id);
	  objCstmt.setString(3, strDCity);             //set the current user Site Id
	  objCstmt.setString(4, strACity);                //set the current user Login UserId
	  objCstmt.setString(5, strDDate);
	  objCstmt.setString(6, strDMode);
	  objCstmt.setString(7, strDAirline);
	  objCstmt.setString(8, strDClass);
	  
	  objCstmt.setString(9, "N");
	  objCstmt.setString(10, "N"); 

	  objCstmt.setString(11, strTravel_Type);
	  objCstmt.setString(12, strPreferedTimeInterMediate);  ///added intermidiate  time for domestic journey  on 25-Oct-07 --- By shiv sharma 
	  objCstmt.setString(13, strSeatPrefer);  ///added intermidiate  time for domestic journey  on 25-Oct-07 --- By shiv sharma 
	  objCstmt.setString(14, "n");  ///added intermidiate  time for domestic journey  on 25-Oct-07 --- By shiv sharma 
	  
	  iSuccess1   =  objCstmt.executeUpdate();
	  objCstmt.close();

  }

  if (iSuccess1 >0)	 {
	 // objCon.commit();
	  //System.out.println("Data inserted successfully in T_INTERIM_JOURNEY");	
  }

  
} catch (Exception e) {

	//objCon.rollback();
	System.out.println("exception inside interimjourney_dom_post.jsp");
	e.printStackTrace();
}
if(strGroupFlag.equalsIgnoreCase("yes") && strTravel_Type.equalsIgnoreCase("D")){
	response.sendRedirect("Group_InterimJourney_Dom.jsp?interimTravelId="+strTravel_Id+"&actualTravelId="+strAcualTravelId+"&"+strdomvalflag);
}
else{ 
response.sendRedirect("InterimJourney_Dom.jsp?interimTravelId="+strTravel_Id+"&actualTravelId="+strAcualTravelId);
}
%>

