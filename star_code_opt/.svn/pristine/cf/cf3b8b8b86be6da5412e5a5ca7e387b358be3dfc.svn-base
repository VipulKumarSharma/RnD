<%/***************************************************
*Copyright (C) 2000 MIND
*All rights reserved.
*The information contained here in is confidential and *proprietary to MIND and forms the part of the MIND 
*CREATED BY		:	Sachin Gupta
*Date			:	14 Nov 2006 
*Description	:	Page for delete the domestic interim journey details
**Project		:	STAR

*Modification	:	Delete domestic group request interim jouney also
*Modified By	:	Manoj Chand
*Date of modification : 25 sep 2011
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
String strTravelType = request.getParameter("travelType")==null?"D":request.getParameter("travelType"); 
String strSqlDelete  = "";

String strAcualTravelId = "";
String strUpdateFlag    = "";
String strJourneyOrder  = "";
strJourneyOrder         =  request.getParameter("journeyOrder");
strAcualTravelId        =  request.getParameter("actualTravelId");

//added by manoj chand 20 sep 2011 to check for group flag.
String strGroupflag		= request.getParameter("Groupflag")==null ? "" :request.getParameter("Groupflag");

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
String struserids= request.getParameter("userids")==null?"":request.getParameter("userids");

String strinturlflag="fwddepCity="+strfwddepCity+"&fwdarrCity="+strfwdarrCity+"&fwddepDate="+strfwddepDate+"&fwdpreferTime="+strfwdpreferTime+"&travelMode="+strtravelMode+"&fwdnameOfAirline="+strfwdnameOfAirline+"&fwdtravelClass="+strfwdtravelClass+"&fwdseatpreference="+strfwdseatpreference+"&fwdforTatkaalRequired="+strfwdforTatkaalRequired+"&fwdforCoupanRequired="+strfwdforCoupanRequired+"&fwdticketrefund="+strfwdticketrefund+"&transit="+strtransit+"&currency="+strcurrency+"&place="+strplace+"&budget="+strbudget+"&checkin="+strcheckin+"&checkout="+strcheckout+"&others="+strothers+"&userids="+struserids;




if(strAcualTravelId != null && !strAcualTravelId.equals("null") && !strAcualTravelId.equals("") && !strAcualTravelId.equals("new"))
{
    strUpdateFlag = "yes";     
}
else
    strUpdateFlag = "no"; 

//System.out.println("strUpdateFlag======="+strUpdateFlag);




Connection conn;


try 
{
 	//conn               =  dbConBean.getConnection();            //Get the Connection
    //conn.setAutoCommit(false);
    if(strUpdateFlag.equals("yes"))
    {
    	strSqlDelete="UPDATE T_JOURNEY_DETAILS_DOM SET STATUS_ID=30 WHERE TRAVEL_ID='"+strAcualTravelId+"' AND JOURNEY_ORDER="+strJourneyOrder+" AND STATUS_ID=10 AND APPLICATION_ID=1";

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
	var groupFlag  = "<%=strGroupflag%>";
	var var_groupval = "<%=strinturlflag%>";
   // alert(travelType);
	if(travelType == "D" && groupFlag==""){
		document.FRM.action="InterimJourney_Dom.jsp";
	}
   else if(travelType == "D" && groupFlag=="GroupDom"){
		document.FRM.action="Group_InterimJourney_Dom.jsp?"+var_groupval;
	}
	//alert(document.FRM.action);
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