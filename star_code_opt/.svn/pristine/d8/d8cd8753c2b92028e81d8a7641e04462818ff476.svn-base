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
 *Modification 			:Add new fields visa Required and visa comment. 
 *Reason of Modification: change suggested by MATA
 *Date of Modification  :1 Nov 2006 
 *Modified By	        :SACHIN GUPTA
 *Editor				:Editplus
 *******************************************************/
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
strDMode				=	request.getParameter("strMode");
strAirline				=	request.getParameter("strAirlineName");
strDClass				=	request.getParameter("strClass");

//New Change Start
strVisa                  =  request.getParameter("visa");
strVisaComment           =  request.getParameter("visaComment")==null?"":request.getParameter("visaComment");
//New change End


strTravel_Id			=	request.getParameter("travel_id");

if (strTravel_Id.equals("") || strTravel_Id == null  ) {
strTravel_Id  =  dbUtilityBean.getNewGeneratedId("INTERIM_ID")+"";
} 

try
{
  objCon               =  dbConBean.getConnection();            //Get the Connection
  if(strUpdateFlag.equals("yes"))
  {
	  String strNewJouneyOrder = "";
	  //System.out.println("inside update block----------");
	  strSql  ="SELECT MAX(JOURNEY_ORDER)+1 AS NEW_JOURNEY_ORDER FROM T_JOURNEY_DETAILS_INT WHERE TRAVEL_ID ="+strAcualTravelId+" AND STATUS_ID=10 AND APPLICATION_ID=1";
	  rs = dbConBean.executeQuery(strSql);
	  if(rs.next())
	  {
		  strNewJouneyOrder = rs.getString("NEW_JOURNEY_ORDER");
		 // System.out.println("strNewJouneyOrder ----> > "+strNewJouneyOrder);
	  }
	  rs.close();

	  //PROCEDURE for INSERT data in T_JOURNEY_DETAILS_INT
      objCstmt             =  objCon.prepareCall("{?=call PROC_INSERT_T_JOURNEY_DETAILS_INT(?,?,?,?,?,?,?,?,?,?,?,?,?)}"); 
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

      objCstmt.setString(12, "1");          //set the Travel Preferred Time e.g. Morning,evening etc.
      objCstmt.setString(13, Suser_id);              //set the current user Login UserId
      objCstmt.setInt(14, 0);
      iSuccess1   =  objCstmt.executeUpdate();
      objCstmt.close();
	//System.out.println("iSuccess1=========="+iSuccess1);
  }
  else
  {
	  //objCon.setAutoCommit(false);
	  objCstmt             =  objCon.prepareCall("{?=call PROC_INSERT_T_INTERIM_JOURNEY_DETAILS(?,?,?,?,?,?,?,?,?,?)}");//PROCEDURE to insert the row in T_INTERIM_JOURNEY  Table
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
	  iSuccess1   =  objCstmt.executeUpdate();
	// System.out.println("iSuccess1=========="+iSuccess1);
	  

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

response.sendRedirect("InternationalInterimJourney_Edit.jsp?interimTravelId="+strTravel_Id+"&actualTravelId="+strAcualTravelId);
%>
<%-- <jsp:forward page="/InterimJourney.jsp"></jsp:forward> --%>

