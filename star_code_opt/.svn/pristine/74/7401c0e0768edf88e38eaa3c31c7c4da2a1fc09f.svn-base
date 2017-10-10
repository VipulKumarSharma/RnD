<%/***************************************************
*Copyright (C) 2000 MIND
*All rights reserved.
*The information contained here in is confidential and *proprietary to MIND and forms the part of the MIND 
*CREATED BY		:	Abhinav Ratnawat
*Date			:	30 Aug 2006 
*Description	:	Production Workflow Page
*Project		:	STARS

*Date of Modification	: 22 Sep 2011
*Modified By			: Manoj Chand
*Modification			: Delete intermediate journey information of international group/guest intermediate 
**********************************************************/%>
<%@ page import="java.sql.*" %>
<%-- Import Statements  --%>
<%@ include  file="importStatement.jsp" %>
<html>
<head>
<%-- include remove cache  --%>
<%@ include  file="cacheInc.inc" %>
<%-- include header  --%>
<%@ include  file="headerIncl.inc" %>
<%-- include page with all application session variables --%>
<%@ include  file="application.jsp" %>
<%-- include page styles  --%>
<%-- <%@ include  file="systemStyle.jsp" %> --%>
<!--Create the DbConnectionBean object for createConnection-->

<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbUtilityBean" scope="page" class="src.connection.DbUtilityMethods" />
<html>
<%
int intSuccess = 0;
String strInterimId  = request.getParameter("interimID");
String strTravelId	 = request.getParameter("travelID");
String strTravelType = request.getParameter("travelType")==null?"I":request.getParameter("travelType"); 
String strSqlDelete  = "";

String strAcualTravelId = "";
String strUpdateFlag    = "";
String strJourneyOrder  = "";
strJourneyOrder         =  request.getParameter("journeyOrder");
strAcualTravelId        =  request.getParameter("actualTravelId");
String strGroupFlag = request.getParameter("groupFlag")==null?"":request.getParameter("groupFlag");


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

//System.out.println("strvalflag---delete int---->"+strvalflag);


if(strAcualTravelId != null && !strAcualTravelId.equals("null") && !strAcualTravelId.equals("") && !strAcualTravelId.equals("new"))
{
    strUpdateFlag = "yes";     
}
else
    strUpdateFlag = "no"; 

Connection conn;


try 
{
 	//conn               =  dbConBean.getConnection();            //Get the Connection
    //conn.setAutoCommit(false);
    if(strUpdateFlag.equals("yes"))
    {
    	strSqlDelete="UPDATE T_JOURNEY_DETAILS_INT SET STATUS_ID=30 WHERE TRAVEL_ID='"+strAcualTravelId+"' AND JOURNEY_ORDER="+strJourneyOrder+" AND STATUS_ID=10 AND APPLICATION_ID=1";

	}
	else
	{
		strSqlDelete="DELETE FROM T_INTERIM_JOURNEY WHERE INTERIM_ID='"+strInterimId+"'";
	}
    	intSuccess = dbConBean.executeUpdate(strSqlDelete);	
    	//conn.commit();
	    //System.out.println("Data deleted successfully");
	
}
catch (Exception e) {
		System.out.println("Connection not Created !Error "+e);
		e.printStackTrace();
} finally {
	try{
		
	}catch(Exception e){
		//conn.close();
	}
}

//out.println("travel_type="+strTravelType);
%>
<script>

function findNextForm()
{
	var travelType = "<%=strTravelType%>";
	var groupflag	= "<%=strGroupFlag%>";
	var var_valflag = "<%=strvalflag%>";
   // alert(travelType);
	if(travelType == "I" && groupflag=="")
	{
	   document.FRM.action="InternationalInterimJourney.jsp";
	}else if(travelType == "I" && groupflag=="GroupInt"){
		document.FRM.action="Group_InternationalInterimJourney.jsp?"+var_valflag;
	}
	
	document.FRM.submit();
}

</script>


<body onload="findNextForm()">
<FORM METHOD=POST NAME=FRM ACTION="InterimJourney_Dom.jsp" >
<input type=hidden name="interimTravelId" value="<%=strTravelId%>"> 
<input type=hidden name="actualTravelId" value="<%=strAcualTravelId%>"> 
</form>
</body>
</html>