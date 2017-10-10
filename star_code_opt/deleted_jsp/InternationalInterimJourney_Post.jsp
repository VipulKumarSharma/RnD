<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:SACHIN GUPTA
 *Date of Creation 		:15 September 2006
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This is second(post) jsp file  for Intrim Journey of Trravel Request
 *Modification 			:1.Add new fields visa Required and visa comment. 
                         2.code added by Shiv sharma  on 25-Oct-07  for prefered time for intermediate journey  
                         3:  code commented for not showing trave mode in case of intrenational travel changed by shiv on 07 jan 2009  
                                  

 *Reason of Modification: change suggested by MATA
 *Date of Modification  :1 Nov 2006 
 *Modified By	        :SACHIN GUPTA
 *Editor				:Editplus
 
 *Date of modification	: 30 Sep 2011
 *Modified By			: Manoj Chand
 *Modification			: modify to save and refresh parent page of international group/guest request
 *******************************************************/
%>
<%@ page pageEncoding="UTF-8" %>
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
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<% 
request.setCharacterEncoding("UTF-8");
Connection objCon			=  null;            //Object for Connection 
ResultSet rs			 	=  null;            // Object for ResultSet
CallableStatement objCstmt	=  null;		    // Object for Callable Statement
int iSuccess1				=	0;
String strSql           = "";

String strDCity 		= "";
String strACity			= "";
String strDDate 		= "";
String strDMode 		= "";
String strAirline 		= "";
String strDClass		= "";

//New Change Start
String strVisa          =  "";                           
String strVisaComment   =  "";    
//New change End

String strTravel_Id 	= "";
String strTravel_Type	= "I";

String strAcualTravelId = "";
String strUpdateFlag    = "";

String strPreferedTimeInterMediate  ="";          //added  by Shiv Sharma  on 25-Oct-07
String strSeatPreffered             ="";                    //added  by Shiv Sharma  on 08-Jan-09



//getting value from request

strAcualTravelId        =  request.getParameter("actualTravelId");


if(strAcualTravelId != null && !strAcualTravelId.equals("null") && !strAcualTravelId.equals("") && !strAcualTravelId.equals("new"))
{
    strUpdateFlag = "yes";     
}
else
    strUpdateFlag = "no"; 

//System.out.println("strAcualTravelId===555555555==="+strAcualTravelId);
//System.out.println("strUpdateFlag===555555555==="+strUpdateFlag);


strDCity				=	request.getParameter("strDeptCity");
strACity				=	request.getParameter("strArrCity");
strDDate				=	request.getParameter("strDeptDate");
// code commented for not showing trave mode in case of intrenational travel changed by shiv on 07 jan 2009 
//strDMode				=	request.getParameter("strMode");
strDMode				=	"1";

strAirline				=	request.getParameter("strAirlineName");
strDClass				=	request.getParameter("strClass");

//New Change Start
strVisa                  =  request.getParameter("visa");
strVisaComment           =  request.getParameter("visaComment")==null?"":request.getParameter("visaComment");
// added by Shiv sharma  on 25-Oct-07  for prefered time for intermediate journey 
strPreferedTimeInterMediate          =  request.getParameter("preferTimeInterMediate")==null?"1":request.getParameter("preferTimeInterMediate");
//New change End
//added new on 08 jan 2009 
strSeatPreffered        =   request.getParameter("seatPreffered")==null?"1":request.getParameter("seatPreffered");
String strGroupFlag		=	request.getParameter("GroupFlag")==null?"no":request.getParameter("GroupFlag");
//System.out.println("strGroupflag--int-->"+strGroupFlag);
  
//added by manoj to get parameters on 30 sep 2011
String strdepCity=request.getParameter("depCity")==null?"":request.getParameter("depCity");
String strarrCity=request.getParameter("arrCity")==null?"":request.getParameter("arrCity");
String strdepDate=request.getParameter("depDate")==null?"":request.getParameter("depDate");
String strprfTime=request.getParameter("preferTime")==null?"":request.getParameter("preferTime");
String strairName=request.getParameter("nameOfAirline")==null?"":request.getParameter("nameOfAirline");
String strtrvClass=request.getParameter("travelClass")==null?"":request.getParameter("travelClass");
String strsetPrf=request.getParameter("seatpreference")==null?"":request.getParameter("seatpreference");
String strHotel=request.getParameter("hotel")==null?"0":request.getParameter("hotel");
String strCur=request.getParameter("currency")==null?"USD":request.getParameter("currency");
String strPlace=request.getParameter("place")==null?"":request.getParameter("place");
String strBudget=request.getParameter("budget")==null?"":request.getParameter("budget");
String strCheckin=request.getParameter("checkin")==null?"":request.getParameter("checkin");
String strCheckout=request.getParameter("checkout")==null?"":request.getParameter("checkout");
String strOthcomment=request.getParameter("otherComment")==null?"":request.getParameter("otherComment");
String strUserids=request.getParameter("userids")==null?"":request.getParameter("userids");
   
String strvalflag="depCity="+strdepCity+"&arrCity="+strarrCity+"&depDate="+strdepDate+"&preferTime="+strprfTime+"&nameOfAirline="+strairName+"&travelClass="+strtrvClass+"&seatpreference="+strsetPrf+"&hotel="+strHotel+"&currency="+strCur+"&place="+strPlace+"&budget="+strBudget+"&checkin="+strCheckin+"&checkout="+strCheckout+"&otherComment="+strOthcomment+"&userids="+strUserids;
//System.out.println("strvalflag---post-->"+strvalflag);
//end here

strTravel_Id			=	request.getParameter("travel_id");

if ( strTravel_Id == null || strTravel_Id.equals("")) {
	
strTravel_Id  =  dbUtilityBean.getNewGeneratedId("INTERIM_ID")+""; 
} 
 
try
{
	 
 	
  objCon               =  dbConBean.getConnection();            //Get the Connection
  if(strUpdateFlag.equals("yes")) //insert the data   when requsition is new and travel_ID is not genrated --(i.c.NULL) --by shiv sharma 25-Oct-07      
  {
	  String strNewJouneyOrder = "";
	  strSql  ="SELECT MAX(JOURNEY_ORDER)+1 AS NEW_JOURNEY_ORDER FROM T_JOURNEY_DETAILS_INT WHERE TRAVEL_ID ="+strAcualTravelId+" AND STATUS_ID=10 AND APPLICATION_ID=1";
	  rs = dbConBean.executeQuery(strSql);
	  
	   
	  if(rs.next())
	  {
		  strNewJouneyOrder = rs.getString("NEW_JOURNEY_ORDER");
		 // System.out.println("strNewJouneyOrder ----> > "+strNewJouneyOrder);
	  }
	  rs.close();

	  //PROCEDURE for INSERT data in T_JOURNEY_DETAILS_INT
	   
      objCstmt             =  objCon.prepareCall("{?=call PROC_INSERT_T_JOURNEY_DETAILS_INT(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}"); 
      objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
      objCstmt.setString(2, strAcualTravelId);
      objCstmt.setString(3, strDCity);             //set the Traveller Departure City Name(TRAVEL_FROM)
      objCstmt.setString(4, strACity);             //set the Traveller Arrival City Namei(TRAVEL_TO)
      objCstmt.setString(5, strDDate);             //set the Traveller Departure Date
      objCstmt.setString(6, strNewJouneyOrder);      //set the Order of Traveller intrim journey greater than 1 because 1 reserve for  actual from and to journey detail
      objCstmt.setString(7, strDMode);         //set the Travel Mode name( in int value) e.g. 1 for Air or 2 for Train
      objCstmt.setString(8, strAirline);      //set the Travel Mode name(in int value), e.g. Air India, Air Deccon etc.
      objCstmt.setString(9, strDClass);        //set the Travel Class Name(in int value), e.g. First class, Business class 

      objCstmt.setString(10, strVisa);        //set the VISA_REQUIRED, e.g. 1 for yes and 2 for no
	  objCstmt.setString(11, strVisaComment);        //set the VISA_COMMENT

      //objCstmt.setString(12, "1");          //set the Travel Preferred Time e.g. Morning,evening etc.
      objCstmt.setString(12, strPreferedTimeInterMediate);       // changed by shiv on  25-Oct-07 for adding prefered time for intemidiate destination to  for international journey 
      objCstmt.setString(13, Suser_id);              //set the current user Login UserId
      objCstmt.setString(14, strSeatPreffered);              //set the current user Login UserId
      objCstmt.setString(15, "1");
	  objCstmt.setInt(16, 0);
      iSuccess1   =  objCstmt.executeUpdate();
      objCstmt.close(); 
  }
  else
  {
	  //objCon.setAutoCommit(false);
	  // proc which  insert data with first time------- in T_INTERIM_JOURNEY table --- Shiv sharma   
      
	  objCstmt         =  objCon.prepareCall("{?=call PROC_INSERT_T_INTERIM_JOURNEY_DETAILS(?,?,?,?,?,?,?,?,?,?,   ?,?,?)}");//PROCEDURE to insert the row in T_INTERIM_JOURNEY  Table
	  objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
	  objCstmt.setString(2, strTravel_Id);
	  objCstmt.setString(3, strDCity);             //set the current user Site Id
	  objCstmt.setString(4, strACity);                //set the current user Login UserId
	  objCstmt.setString(5, strDDate);
	  objCstmt.setString(6, strDMode);
	  objCstmt.setString(7, strAirline);
	  objCstmt.setString(8, strDClass);
	  objCstmt.setString(9, strVisa);
	  objCstmt.setString(10, strVisaComment); 
	  objCstmt.setString(11, strTravel_Type);
	  objCstmt.setString(12, strPreferedTimeInterMediate);   /// added new for prefered time on 25-Oct-07 By Shiv Sharma   
	  objCstmt.setString(13, strSeatPreffered);
	  objCstmt.setString(14, "n");
	  iSuccess1   =  objCstmt.executeUpdate();
	  objCstmt.close();
  }
  if (iSuccess1 >0)	 
  {
	  //objCon.commit();
  }
} catch (Exception e) {

	//objCon.rollback();
	System.out.println("exception inside interim internationalIntrimJourney_Post.jsp"+e);
	e.printStackTrace();
	
}

response.setContentType("text/xml; charset=UTF-8");

//System.out.println("traveltype-->"+strTravel_Type);
//System.out.println("1212-->"+"Group_InternationalInterimJourney.jsp?interimTravelId="+strTravel_Id+"&actualTravelId="+strAcualTravelId+"&"+strvalflag);

if(strGroupFlag.equalsIgnoreCase("yes") && strTravel_Type.equalsIgnoreCase("I")){
	response.sendRedirect("Group_InternationalInterimJourney.jsp?interimTravelId="+strTravel_Id+"&actualTravelId="+strAcualTravelId+"&"+strvalflag);
}else{
response.sendRedirect("InternationalInterimJourney.jsp?interimTravelId="+strTravel_Id+"&actualTravelId="+strAcualTravelId);
}
%>
<%-- <jsp:forward page="/InterimJourney.jsp"></jsp:forward> --%>

