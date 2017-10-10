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
 *Reason of Modification: change suggested by MATA
 *Date of Modification  :14 Nov 2006 
 *Modified By	        :SACHIN GUPTA
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
strAcualTravelId        =  request.getParameter("actualTravelId");
if(strAcualTravelId != null && !strAcualTravelId.equals("null") && !strAcualTravelId.equals("") && !strAcualTravelId.equals("new"))
{
	strUpdateFlag = "yes";     
}
else
	strUpdateFlag = "no"; 


//System.out.println("Actual Travel id is===in post====="+strAcualTravelId);
//System.out.println("strUpdateFlag is===in post====="+strUpdateFlag);



//getting value from request
strDCity							=	request.getParameter("strDeptCity");
strACity							=	request.getParameter("strArrCity");
strDDate					     	=	request.getParameter("strDeptDate");
strDMode				     		=	request.getParameter("strMode");
strDAirline					    	=	request.getParameter("strAirlineName");
strDClass					    	=	request.getParameter("strClass");
strTravel_Id				    	=	request.getParameter("travel_id");

//System.out.println("captured travel id is"+strTravel_Id);
if (strTravel_Id.equals("") || strTravel_Id == null  ) {
strTravel_Id  =  dbUtilityBean.getNewGeneratedId("INTERIM_ID")+"";
//System.out.println("interim_Id is =="+strTravel_Id);
} 

try
{
  objCon               =  dbConBean.getConnection(); 
 // objCon.setAutoCommit(false);
  if(strUpdateFlag.equals("yes"))
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
	  objCstmt             =  objCon.prepareCall("{?=call PROC_INSERT_T_JOURNEY_DETAILS_DOM(?,?,?,?,?,?,?,?,?,?,?)}"); 
      objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
      objCstmt.setString(2, strAcualTravelId);
      objCstmt.setString(3, strDCity);             //set the Traveller Departure City Name(TRAVEL_FROM)
      objCstmt.setString(4, strACity);             //set the Traveller Arrival City Namei(TRAVEL_TO)
      objCstmt.setString(5, strDDate);             //set the Traveller Departure Date
      objCstmt.setString(6, strNewJouneyOrder);        //set the Order of Traveller intrim journey(it is 1 for the actual from and to)
      objCstmt.setString(7, strDMode);         //set the Travel Mode name( in int value) e.g. 1 for Air or 2 for Train
      objCstmt.setString(8, strDAirline);      //set the Travel Mode name(in int value), e.g. Air India, Air Deccon etc.
      objCstmt.setString(9, strDClass);        //set the Travel Class Name(in int value), e.g. First class, Business class 
      objCstmt.setString(10, "1");          //set the Travel Preferred Time e.g. Morning,evening etc.
      objCstmt.setString(11, Suser_id);              //set the current user Login UserId
      objCstmt.setInt(12, 0);
      iSuccess1   =  objCstmt.executeUpdate();
      objCstmt.close();	

	//System.out.println("iSuccess1=========="+iSuccess1);
	  
  }
  else
  {

	  objCstmt             =  objCon.prepareCall("{?=call PROC_INSERT_T_INTERIM_JOURNEY_DETAILS(?,?,?,?,?,?,?,?,?,?)}");//PROCEDURE to insert the row in T_INTERIM_JOURNEY  Table
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

response.sendRedirect("InterimJourney_Dom_Edit.jsp?interimTravelId="+strTravel_Id+"&actualTravelId="+strAcualTravelId);
%>

