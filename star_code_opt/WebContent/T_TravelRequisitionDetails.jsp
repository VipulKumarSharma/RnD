
	<%@page import="java.beans.DesignMode"%>
	<%@page pageEncoding="UTF-8"%>
	<%@page import="javax.servlet.http.HttpSession"%>
	<%@page import="java.util.*"%>
	<%@page import="java.sql.*"%>
	<%@page import="src.connection.*"%>
	
<%@ include file="importStatement.jsp"%>
<html>
<head>
<%-- include page with all application session variables --%>
<%@ include file="application.jsp"%>
<%-- include remove cache  --%>
<%@ include file="cacheInc.inc"%>
<%-- include header  --%>
<%@ include file="headerIncl.inc"%>
<%@ page import="src.enumTypes.*"%>
<%@ page import="src.beans.*"%>
<%@ page import="src.dao.*"%>

<!--Create the DbConnectionBean object for createConnection-->
<jsp:useBean id="dbConBean" scope="page"
	class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbConBean1" scope="page"
	class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbLabelBean" scope="page"
	class="src.connection.LabelRepository" />
<jsp:useBean id="securityUtilityBean" scope="page"
	class="src.connection.SecurityUtilityMethods" />

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<script language="JavaScript"
	src="scripts/CommonValida.js?buildstamp=2_0_0"></script>
<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet"
	type="text/css" />
<script type="text/javascript" language="JavaScript1.2"
	src="scripts/div.js?buildstamp=2_0_0"></script>
<style type="text/css">
.reporttble {
	width: 99%;
	max-width: 100%;
}

.reportHeading {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 12px;
	font-weight: bold;
	color: #ffffff;
	line-height: 22px;
	background-color: #7a7a7a;
	padding-left: 5px;
	text-align: left;
}

.reportSubHeading {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 11px;
	font-weight: bold;
	color: #000000;
	line-height: 20px;
	background-color: #dddddd;
	padding-left: 5px;
	text-align: left;
}

.reportCaption {
	width: auto;
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10px;
	font-weight: bold;
	color: #1d1d1d;
	line-height: 20px;
	background-color: #f2f2f2;
	padding-left: 5px;
	padding-right: 5px;
	text-align: left;
	max-width: 40%;
}

.reportdata {
	width: auto;
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10px;
	font-weight: normal;
	color: #373737;
	line-height: 20px;
	background-color: #f7f7f7;
	padding-left: 5px;
	padding-right: 5px;
	text-align: left;
	max-width: 40%;
}
</style>
<script type="text/javascript">
	function ShowHide(id) {
		obj = document.getElementsByTagName("div");
		if (obj[id].style.visibility == 'visible') {
			obj[id].style.visibility = 'hidden';
		} else {
			obj[id].style.visibility = 'visible';
		}
	}
</script>
</head>
<%
	// Variables declared and initialized
	String userId	= "";
	HttpSession sess= request.getSession();
	userId			= sess.getValue("user_id") == null ? "" : (String) sess.getValue("user_id");
	ResultSet rs,rs1= null; 
	Statement stmt 	= null;
	DbConnectionBean objCon	= new DbConnectionBean();
	Connection con  = objCon.getConnection();
	stmt			= con.createStatement();
	
	String sSqlStr 	= ""; // For sql Statements
	String strRequisitionId = "";//For holding Purchase Requisition Id
	String strTravellerId = "";
	String strTravelId = "";
	String travelType = "";

	strTravelId = request.getParameter("purchaseRequisitionId");
	strTravellerId = request.getParameter("traveller_Id");
	travelType = request.getParameter("travelType");
	String strOriginalapprover = "";
	String reportFlag	= request.getParameter("reportFlag")==null?"false":request.getParameter("reportFlag").trim();
	if (travelType != null) {
		if (travelType.equals("INT") || travelType.equals("I")) {
			travelType = "I";
		} else if (travelType.equals("DOM") || travelType.equals("D")) {
			travelType = "D";
		}
	}
	//Added By Gurmeet Singh
	String strUserAccessCheckFlag = "";
	strUserAccessCheckFlag = securityUtilityBean
			.validateAuthTravelDetails(strTravelId, travelType,
					Suser_id);
	if (reportFlag.equalsIgnoreCase("false") && strUserAccessCheckFlag.equals("420")) {
		dbConBean.close();
		dbConBean1.close();
		securityUtilityBean.registerUnauthAccessLog(Suser_id,
				request.getRemoteAddr(),
				"T_TravelRequisitionDetails.jsp",
				"Unauthorized Access");
		response.sendRedirect("UnauthorizedAccess.jsp");
	} else {

		int iCls = 0;
		String strStyleCls = "";

		T_QuicktravelRequestDaoImpl dao = new T_QuicktravelRequestDaoImpl();
		TravelRequest requestInfoObj = dao.getTravelRequestDetailIndia(
				strTravelId, travelType, strTravellerId);
		User requestOriginator = requestInfoObj.getOriginator();
		User traveller = requestInfoObj.getTraveller();
%>
<SCRIPT language=JavaScript
	src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<body>
	<script type="text/javascript" language="JavaScript1.2"
		src="menu/menu_cnt.js?buildstamp=2_0_0"></script>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="45" class="bodyline-top">
				<ul class="pagebullet">
					<li class="pageHead">
						<%
							if (travelType.equals("I"))
									out.print(dbLabelBean.getLabel(
											"label.requestdetails.internationaljourneyreport",
											strsesLanguage));

								else
									out.print(dbLabelBean.getLabel(
											"label.requestdetails.domesticjourneyreport",
											strsesLanguage));
						%>
					</li>
				</ul>
			</td>
			<td align="right" valign="bottom" class="bodyline-top">
				<table align="right" border="0" cellspacing="0" cellpadding="0">
					<tr align="right">
						<td>
							<ul id="list-nav">
								<%
									if (requestInfoObj.getLinkedTravelRequest() != null) {
								%>
								<li><a href="#"
									onClick="MM_openBrWindow('T_TravelRequisitionDetails.jsp?purchaseRequisitionId=<%=requestInfoObj.getLinkedTravelRequest()%>&traveller_Id=<%=strTravellerId%>&travelType=I','LinkedCancelledRequest<%=requestInfoObj.getLinkedTravelRequest()%>','scrollbars=yes,resizable=yes,width=975,height=550')"><%=dbLabelBean.getLabel(
							"label.global.linkedcancelledtravelrequest",
							strsesLanguage)%></a></li>
								<%
									}
								%>
								<li><a href="#" onClick="window.print();"><%=dbLabelBean.getLabel("button.search.print",
						strsesLanguage)%></a></li>
								<li><a href="#" onClick="javascript:top.window.close();"><%=dbLabelBean.getLabel("button.global.close",
						strsesLanguage)%></a></li>
							</ul>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<table width="100%" align="center" style="margin: 0 auto;" border="0"
		cellspacing="5" cellpadding="1">
		<tr>
			<td align="center">
				<table width="100%" align="left" border="1" cellpadding="2"
					cellspacing="0" class="reporttble" bordercolor="#c7c7c5"
					style="border-collapse: collapse">
					<tr>
						<td height="0" colspan="6" align="left" class="reportHeading"><%=dbLabelBean.getLabel(
						"label.requestdetails.requestdetails", strsesLanguage)%></td>
					</tr>
					<tr>
						<td width="12%" height="0" class="reportCaption"><%=dbLabelBean.getLabel(
						"label.global.requisitionnumber", strsesLanguage)%></td>
						<td width="26%" height="0" class="reportdata"><%=requestInfoObj.getRequisitionNo()%></td>
						<td width="12%" height="0" class="reportCaption"><%=dbLabelBean.getLabel(
						"label.requestdetails.originator", strsesLanguage)%></td>
						<td width="20%" height="0" class="reportdata"><%=(requestOriginator.getFullName() != null ? requestOriginator
						.getFullName().toUpperCase() : "")%></td>
						<td width="14%" height="0" class="reportCaption"><%=dbLabelBean.getLabel(
						"label.approverrequest.originatedon", strsesLanguage)%></td>
						<td width="16%" height="0" class="reportdata"><%=requestInfoObj.getCreationDate()%></td>
					</tr>
					<tr>
						<td width="12%" height="0" class="reportCaption"><%=dbLabelBean.getLabel("label.requestdetails.division",
						strsesLanguage)%></td>
						<td width="26%" height="0" class="reportdata"><%=(requestOriginator.getDivisionName() != null ? requestOriginator
						.getDivisionName().toUpperCase() : "")%></td>
						<td width="12%" height="0" class="reportCaption"><%=dbLabelBean.getLabel("label.requestdetails.unit",
						strsesLanguage)%></td>
						<td width="20%" height="0" class="reportdata"><%=(requestOriginator.getUnitName() != null ? requestOriginator
						.getUnitName().toUpperCase() : "")%></td>
						<td width="14%" height="0" align="right" class="reportCaption"><%=dbLabelBean.getLabel(
						"label.requestdetails.department", strsesLanguage)%></td>
						<td width="16%" height="0" class="reportdata"><%=(requestOriginator.getDepartmentName() != null ? requestOriginator
						.getDepartmentName().toUpperCase() : "")%></td>
					</tr>
					<tr>
						<td class="reportCaption" width="12%"><%=dbLabelBean.getLabel(
						"label.createrequest.costcentre", strsesLanguage)%></td>
						<td class="reportdata" width="18%" colspan="2"><%=traveller.getCostCenterName()%></td>
						<td class="reportCaption" width="12%"><%=dbLabelBean.getLabel("label.global.reasonfortravel",
						strsesLanguage)%></td>
						<td class="reportdata" colspan="2"><%=requestInfoObj.getReasonForTravel()%></td>
					</tr>
				</table>
			</td>
		</tr>

		<!-- Personal Detail Section Start -->
		<tr>
			<td>
				<table width="100%" align="left" border="1" cellpadding="2"
					cellspacing="0" class="reporttble" bordercolor="#c7c7c5"
					style="border-collapse: collapse">
					<tr>
						<td height="0" colspan="8" class="reportHeading"><%=dbLabelBean.getLabel("label.global.travellerinformation",
						strsesLanguage)%></td>
					</tr>
					<tr>
						<td class="reportCaption" width="12%"><%=dbLabelBean.getLabel("label.global.travelername",
						strsesLanguage)%></td>
						<td class="reportdata" width="13%"><%=traveller.getUserName()%></td>

						<td class="reportCaption" width="12%"><%=dbLabelBean.getLabel("label.master.empcode",
						strsesLanguage)%></td>
						<td class="reportdata" width="13%"><%=traveller.getEmpCode()%></td>

						<td class="reportCaption" width="12%"><%=dbLabelBean.getLabel("label.global.designation",
						strsesLanguage)%></td>
						<td class="reportdata" width="13%"><%=traveller.getDesignationName()%></td>

						<td class="reportCaption" width="12%"><%=dbLabelBean.getLabel("label.global.emailid",
						strsesLanguage)%></td>
						<td class="reportdata" width="13%"><%=traveller.getEmail()%></td>

					</tr>
					<tr>

						<td class="reportCaption" width="12%"><%=dbLabelBean.getLabel("label.global.contactno",
						strsesLanguage)%></td>
						<td class="reportdata" width="13%"><%=traveller.getContactNo()%></td>

						<td class="reportCaption" width="12%"><%=dbLabelBean.getLabel("label.global.dob",
						strsesLanguage)%></td>
						<td class="reportdata" width="13%"><%=traveller.getDateOfBirth()%></td>

						<td class="reportCaption" width="12%"><%=dbLabelBean.getLabel("label.global.gender",
						strsesLanguage)%></td>
						<td class="reportdata" width="13%"><%=traveller.getGender()%></td>

						<td class="reportCaption" width="12%"><%=dbLabelBean.getLabel("label.global.mealpreference",
						strsesLanguage)%></td>
						<td class="reportdata" width="13%"><%=traveller.getMealPreferrence()%></td>
					</tr>
					<tr>
						<td class="reportCaption" width="12%"><%=dbLabelBean.getLabel(
						"label.createrequest.permanentaddress", strsesLanguage)%></td>
						<td class="reportdata" width="38%" colspan="7"><%=traveller.getPermanentAddress()%></td>
					</tr>
					<tr>
						<td class="reportCaption" width="12%"><%=dbLabelBean.getLabel(
						"label.createrequest.currentaddress", strsesLanguage)%></td>
						<td class="reportdata" width="38%" colspan="7"><%=traveller.getCurrentAddress()%></td>
					</tr>
				</table>
			</td>
		</tr>
		<!-- Personal Detail Section End -->
		
		<!-- Itinerary Details Section Start -->

		<%
			if (requestInfoObj.isFlightDetailExist() || requestInfoObj.isRentA_CarDetailExist() 
					||requestInfoObj.isTrainDetailExist() || requestInfoObj.isAccomodationDetailExist()) 
			{
				
		%>
			<tr id="ItineraryDetailMainTR">
			<td>
				<table width="100%" align="left" border="1" cellpadding="2"
					cellspacing="0" class="reporttble" bordercolor="#c7c7c5"
					style="border-collapse: collapse">
					<tr>
						<td height="0" colspan="10" class="reportHeading"><%=dbLabelBean.getLabel(
							"label.global.itineraryinfo", strsesLanguage)%></td>
					</tr>
					<%
						if (requestInfoObj.isFlightDetailExist() || requestInfoObj.isRentA_CarDetailExist() || requestInfoObj.isTrainDetailExist())
						{
							List travelDetailsList = new ArrayList();
							TravelDetails travelObj = new TravelDetails();
							String journytypeStr = null;
							String flightRemarks = "";
							String trainRemarks = "";
							String carRemarks = "";
					%>
						<tr>
							<td height="0" colspan="10" class="reportSubHeading"><%=dbLabelBean.getLabel("label.global.journeydetails", strsesLanguage)%></td>
						</tr>
						<tr>
							<td class="reportCaption" width="10%"><%=dbLabelBean.getLabel("label.requestdetails.journey", strsesLanguage)%></td>
							<td class="reportCaption" width="10%"><%=dbLabelBean.getLabel("label.global.departurecity", strsesLanguage)%></td>
							<td class="reportCaption" width="10%"><%=dbLabelBean.getLabel("label.global.arrivalcity", strsesLanguage)%></td>
							<td class="reportCaption" width="10%"><%=dbLabelBean.getLabel("label.global.departuredate", strsesLanguage)%></td>
							<td class="reportCaption" width="10%"><%=dbLabelBean.getLabel("label.global.preferredtime", strsesLanguage)%></td>
							<td class="reportCaption" width="10%"><%=dbLabelBean.getLabel("label.requestdetails.travelmode", strsesLanguage)%></td>
							<td class="reportCaption" width="10%"><%=dbLabelBean.getLabel("label.global.class",	strsesLanguage)%></td>
							<td class="reportCaption" width="10%"><%=dbLabelBean.getLabel("label.global.preferredairlinetraincab", strsesLanguage)%></td>
							<td class="reportCaption" width="10%"><%=dbLabelBean.getLabel("label.global.preferredseat", strsesLanguage)%>/<%=dbLabelBean.getLabel("label.global.location", strsesLanguage)%></td>
							<td class="reportCaption" width="10%"><%=dbLabelBean.getLabel("label.requestdetails.otherinformation", strsesLanguage)%></td>
						</tr>
						
						<!-- Flight Detail Section Start -->
						<%
							if (requestInfoObj.isFlightDetailExist()) {
								Flight flightObj = null;
								List flightList = requestInfoObj.getFlightDetailList();
								
								for (int i = 0; i < flightList.size(); i++) {
									flightObj = (Flight) flightList.get(i);
									travelObj = new TravelDetails();
									
									if (flightObj.getJournyType().equals(TravelRequestEnums.JournyType.FORWARD.getId())) {
										journytypeStr = dbLabelBean.getLabel("label.global.forward", strsesLanguage);
									} else if (flightObj.getJournyType().equals(TravelRequestEnums.JournyType.INTERMEDIATE.getId())) {
										journytypeStr = dbLabelBean.getLabel("label.global.intermediate", strsesLanguage);
									} else {
										journytypeStr = dbLabelBean.getLabel("label.global.return", strsesLanguage);
									}
									
									travelObj.setJourneyType(journytypeStr);
									travelObj.setDepartureCity(flightObj.getDepartureCity());
									travelObj.setArrivalCity(flightObj.getArrivalCity());
									travelObj.setDepartureDate(flightObj.getDepartureDate());
									travelObj.setPreferredTimeType(flightObj.getPreferredTimeType());
									travelObj.setPreferredTime(flightObj.getTiming());
									travelObj.setTravelMode("Flight");
									travelObj.setPreferredClass(flightObj.getTravelClass());
									travelObj.setPreferredCompany(flightObj.getPrefAirline());
									travelObj.setPreferredSeat(flightObj.getWindowSeatPreferrence());
									travelObj.setOtherInfo(" - ");
									travelDetailsList.add(travelObj);
									
									if (flightObj.getRemarks() != null && !flightObj.getRemarks().equals("") && !flightObj.getRemarks().trim().equals("-"))
										flightRemarks = flightObj.getRemarks();
								}	
							}
						%>
						<!-- Flight Detail Section End -->
						
						<!-- Train Detail Section Start -->
						<%
							if (requestInfoObj.isTrainDetailExist()) {
								Train trainObj = null;
								List trainList = requestInfoObj.getTrainDetailList();
								
								for (int i = 0; i < trainList.size(); i++) {
									trainObj = (Train) trainList.get(i);
									travelObj = new TravelDetails();	
									if (trainObj.getJournyType().equals(
											TravelRequestEnums.JournyType.FORWARD.getId())) {
										journytypeStr = dbLabelBean.getLabel(
												"label.global.forward",
												strsesLanguage);
									} else if (trainObj.getJournyType().equals(
											TravelRequestEnums.JournyType.INTERMEDIATE
													.getId())) {
										journytypeStr = dbLabelBean.getLabel(
												"label.global.intermediate",
												strsesLanguage);
									} else {
										journytypeStr = dbLabelBean.getLabel(
												"label.global.return",
												strsesLanguage);
									}
									
									travelObj.setJourneyType(journytypeStr);
									travelObj.setDepartureCity(trainObj.getDepartureCity());
									travelObj.setArrivalCity(trainObj.getArrivalCity());
									travelObj.setDepartureDate(trainObj.getDepartureDate());
									travelObj.setPreferredTimeType(trainObj.getPreferredTimeType());
									travelObj.setPreferredTime(trainObj.getTiming());
									travelObj.setTravelMode("Train");
									travelObj.setPreferredClass(trainObj.getTravelClass());
									travelObj.setPreferredCompany(trainObj.getPrefTrain());
									travelObj.setPreferredSeat(trainObj.getSeatPreferrence_1());
									travelObj.setOtherInfo(dbLabelBean.getLabel("label.requestdetails.tatkaal", strsesLanguage) + " - " + (journytypeStr.equals("Intermediate") ? "NA" : (trainObj.isTatkaalTicket() ? "Yes" : "No")));
									travelDetailsList.add(travelObj);
									
									if (trainObj.getRemarks() != null && !trainObj.getRemarks().equals("") && !trainObj.getRemarks().trim().equals("-"))
										trainRemarks = trainObj.getRemarks();
								}	
							}
						%>
						<!-- Train Detail Section End -->
			
						<!-- Rent a Car Detail Section Start -->
						<%
							if (requestInfoObj.isRentA_CarDetailExist())
							{
								Car carObj = null;
								List carList = requestInfoObj.getCarDetailList();
								
								for (int i = 0; i < carList.size(); i++) {
									carObj = (Car) carList.get(i);
									travelObj = new TravelDetails();
										
									if (carObj.getJournyType().equals(
											TravelRequestEnums.JournyType.FORWARD.getId())) {
										journytypeStr = dbLabelBean.getLabel(
												"label.global.forward",
												strsesLanguage);
									} else if (carObj.getJournyType().equals(
											TravelRequestEnums.JournyType.INTERMEDIATE
													.getId())) {
										journytypeStr = dbLabelBean.getLabel(
												"label.global.intermediate",
												strsesLanguage);
									} else {
										journytypeStr = dbLabelBean.getLabel(
												"label.global.return",
												strsesLanguage);
									}
									
									travelObj.setJourneyType(journytypeStr);
									travelObj.setDepartureCity(carObj.getStartCity());
									travelObj.setArrivalCity(carObj.getEndCity());
									travelObj.setDepartureDate(carObj.getStartDate());
									travelObj.setPreferredTimeType(carObj.getPreferredTimeType());
									travelObj.setPreferredTime(carObj.getTiming());
									travelObj.setTravelMode("Car");
									travelObj.setPreferredClass(carObj.getCarClass());
									travelObj.setPreferredCompany(carObj.getPrefCar());
									travelObj.setPreferredSeat(carObj.getStartLocation());
									travelObj.setOtherInfo(dbLabelBean.getLabel("label.global.mobileno", strsesLanguage) + " - " + carObj.getStartMobileNo());
									travelDetailsList.add(travelObj);
									if (carObj.getRemarks() != null	&& !carObj.getRemarks().equals("") && !carObj.getRemarks().trim().equals("-"))
										carRemarks = carObj.getRemarks();
								}	
							}	
						%>
						<!-- Rent a Car Detail Section End -->
						
						<%
							Collections.sort(travelDetailsList);
							for(int listCounter = 0; listCounter < travelDetailsList.size(); listCounter++)
							{
								TravelDetails tempTravelObj = (TravelDetails) travelDetailsList.get(listCounter);
								
								if(listCounter == 0)
								{	tempTravelObj.setJourneyType(dbLabelBean.getLabel(
											"label.global.forward",strsesLanguage));
								}
								else if(listCounter == travelDetailsList.size()-1)
								{
									tempTravelObj.setJourneyType(dbLabelBean.getLabel(
											"label.global.return",strsesLanguage));
								}
								else
								{
									tempTravelObj.setJourneyType(dbLabelBean.getLabel(
											"label.global.intermediate",strsesLanguage));
								}
							}
							ListIterator travelDetailsListIterator = travelDetailsList.listIterator();
							while(travelDetailsListIterator.hasNext())
							{	
								TravelDetails iterTravelObj = (TravelDetails) travelDetailsListIterator.next();
						%>
							<tr>
								<td class="reportdata" width="10%"><%=iterTravelObj.getJourneyType()%></td>
								<td class="reportdata" width="10%"><%=iterTravelObj.getDepartureCity()%></td>
								<td class="reportdata" width="10%"><%=iterTravelObj.getArrivalCity()%></td>
								<td class="reportdata" width="10%"><%=iterTravelObj.getDepartureDate()%></td>
								<td class="reportdata" width="10%"><%=iterTravelObj.getPreferredTimeType()%>&nbsp;<%=iterTravelObj.getPreferredTime()%></td>
								<td class="reportdata" width="10%"><%=iterTravelObj.getTravelMode()%></td>
								<td class="reportdata" width="10%"><%=iterTravelObj.getPreferredClass()%></td>
								<td class="reportdata" width="10%"><%=iterTravelObj.getPreferredCompany()%></td>
								<td class="reportdata" width="10%"><%=iterTravelObj.getPreferredSeat()%></td>
								<td class="reportdata" width="10%"><%=iterTravelObj.getOtherInfo()%></td>
							</tr>
						<%
							}
						%>
						
						<%	if(!flightRemarks.equals("")) {%>
							<tr>
								<td class="reportCaption">Flight&nbsp;<%=dbLabelBean.getLabel("label.createrequest.remarks", strsesLanguage)%></td>
								<td class="reportdata" colspan="9"><%=flightRemarks%></td>
							</tr>	
						<%	}if(!trainRemarks.equals("")) {%>
							<tr>
								<td class="reportCaption">Train&nbsp;<%=dbLabelBean.getLabel("label.createrequest.remarks", strsesLanguage)%></td>
								<td class="reportdata" colspan="9"><%=trainRemarks%></td>
							</tr>	
						<%	}if(!carRemarks.equals("")) {%>
							<tr>
								<td class="reportCaption">Car&nbsp;<%=dbLabelBean.getLabel("label.createrequest.remarks", strsesLanguage)%></td>
								<td class="reportdata" colspan="9"><%=carRemarks%></td>
							</tr>
						<%	} %>		
					<%	}	%>
						
		
				<!-- Accomodation Detail Section Start -->
				<%
					if (requestInfoObj.isAccomodationDetailExist()) {
							List accommodationList = requestInfoObj
									.getAccommodationList();
							if (accommodationList != null
									&& !accommodationList.isEmpty()) {
				%>
						<tr>
							<td height="0" colspan="10" class="reportSubHeading"><%=dbLabelBean.getLabel(
									"label.global.accommodation", strsesLanguage)%></td>
						</tr>
						<tr>
							<td class="reportCaption" width="10%">##</td>
							<td class="reportCaption" width="13%"><%=dbLabelBean.getLabel("label.global.staytype",
									strsesLanguage)%></td>
							<td class="reportCaption" width="13%"><%=dbLabelBean.getLabel("label.global.currency",
									strsesLanguage)%></td>
							<td class="reportCaption" width="13%"><%=dbLabelBean.getLabel("label.global.budget",
									strsesLanguage)%></td>
							<td class="reportCaption" colspan="2" width="13%"><%=dbLabelBean.getLabel(
									"label.global.checkindate", strsesLanguage)%></td>
							<td class="reportCaption" colspan="2" width="13%"><%=dbLabelBean.getLabel(
									"label.global.checkoutdate", strsesLanguage)%></td>
							<td class="reportCaption" colspan="2" width="25%"><%=dbLabelBean.getLabel(
									"label.global.preferredplace", strsesLanguage)%></td>
						</tr>
						<%
							String accomodationRemarks = null;
										for (int i = 0; i < accommodationList.size(); i++) {
											Accommodation accommodation = (Accommodation) accommodationList
													.get(i);
											if (!accommodation.getAccommodationType().equals(
													"0")) {
												accomodationRemarks = accommodation
														.getRemarks();
						%>
						<tr>
							<td class="reportdata" width="10%"><%=i + 1%></td>
							<td class="reportdata" width="13%"><%=accommodation.getAccommodationType()%></td>
							<td class="reportdata" width="13%"><%=accommodation.getCurrency()%></td>
							<td class="reportdata" width="13%"><%=accommodation.getBudget()%></td>
							<td class="reportdata" colspan="2" width="13%"><%=accommodation.getCheckInDate() == null ? ""
											: accommodation.getCheckInDate()%></td>
							<td class="reportdata" colspan="2" width="13%"><%=accommodation.getCheckOutDate() == null ? ""
											: accommodation.getCheckOutDate()%></td>
							<td class="reportdata" colspan="2" width="25%"><%=accommodation.getPlaceOfVisit() == null ? ""
											: accommodation.getPlaceOfVisit()%></td>
						</tr>
	
						<%
							}
										}
										if (accomodationRemarks != null
												&& !accomodationRemarks.equals("")
												&& !accomodationRemarks.trim().equals("-")) {
						%>
						<tr>
							<td class="reportCaption" width="10%"><%=dbLabelBean.getLabel(
										"label.createrequest.remarks",
										strsesLanguage)%></td>
							<td class="reportdata" width="90%" colspan="9"><%=accomodationRemarks%></td>
						</tr>
						<%
							}	}	}
						%>
				
				<!-- Accomodation Detail Section End -->
		
					</table>
				</td>
			</tr>
		<%
			}
		%>
		<!-- Itinerary Details Section End -->
		
		<!-- Advance/Expense Detail Section Start -->
		<%
		if (requestInfoObj.isAdvanceDetailExist()) {
			List advanceForexList = requestInfoObj.getAdvanceForexList();		
			if (advanceForexList != null && !advanceForexList.isEmpty() && advanceForexList.size() > 0) {
		%>
		<tr>
			<td align="left">

				<table width="100%" border="1" cellpadding="2" cellspacing="0"
					class="reporttble" bordercolor="#c7c7c5"
					style="border-collapse: collapse">
					<tr>
						<td height="0" colspan="10" align="left" class="reportHeading"><%=dbLabelBean.getLabel(
							"label.requestdetails.forexdetails",
							strsesLanguage)%></td>
						<td height="0" colspan="5" align="left" class="reportHeading"><%=requestInfoObj.getAdvanceForex() %></td>
					</tr>
					<tr>
						<td class="reportCaption" rowspan="2" nowrap="nowrap"
							style="text-align: center;"><%=dbLabelBean.getLabel("label.global.sno",
							strsesLanguage)%></td>
						<td class="reportCaption" rowspan="2" style="text-align: center;"><%=dbLabelBean.getLabel("label.global.travelername",
							strsesLanguage)%></td>
						<td class="reportCaption" rowspan="2" style="text-align: center;"><%=dbLabelBean.getLabel("label.global.currency",
							strsesLanguage)%></td>
						<td class="reportCaption" colspan="3" style="text-align: center;"><%=dbLabelBean.getLabel(
							"label.global.dailyallowances", strsesLanguage)%></td>
						<td class="reportCaption" colspan="3" style="text-align: center;"><%=dbLabelBean.getLabel("label.global.hotelcharges",
							strsesLanguage)%></td>
						<td class="reportCaption" rowspan="2" style="text-align: center;"><%=dbLabelBean.getLabel("label.global.contigencies",
							strsesLanguage)%><br>(C)</td>
						<td class="reportCaption" rowspan="2" style="text-align: center;"><%=dbLabelBean.getLabel("label.mylinks.others",
							strsesLanguage)%> (D)</td>
						<td class="reportCaption" rowspan="2" style="text-align: center;"><%=dbLabelBean.getLabel("label.global.total",
							strsesLanguage)%> (A+B+C+D)</td>
						<td class="reportCaption" rowspan="2" style="text-align: center;"><%=dbLabelBean.getLabel("label.global.totalamount",
							strsesLanguage)%>(<%=dbLabelBean.getLabel("label.requisition.inr",
							strsesLanguage)%>)</td>
						<td class="reportCaption" rowspan="2" style="text-align: center;"><%=dbLabelBean
							.getLabel(
									"label.requestdetails.remarksforcontingenciesanyother",
									strsesLanguage)%></td>
						<td class="reportCaption" rowspan="2" style="text-align: center;"><%=dbLabelBean
							.getLabel(
									"label.requestdetails.currencydenominationdetails",
									strsesLanguage)%></td>
					</tr>
					<tr>
						<td class="reportCaption" nowrap="nowrap"
							style="text-align: center;"><%=dbLabelBean.getLabel(
							"label.requisitiondetails.expday", strsesLanguage)%></td>
						<td class="reportCaption" nowrap="nowrap"
							style="text-align: center;"><%=dbLabelBean.getLabel("label.requestdetails.days",
							strsesLanguage)%></td>
						<td class="reportCaption" nowrap="nowrap"
							style="text-align: center;"><%=dbLabelBean.getLabel("label.global.total",
							strsesLanguage)%> (A)</td>
						<td class="reportCaption" nowrap="nowrap"
							style="text-align: center;"><%=dbLabelBean.getLabel(
							"label.requisitiondetails.expday", strsesLanguage)%></td>
						<td class="reportCaption" nowrap="nowrap"
							style="text-align: center;"><%=dbLabelBean.getLabel("label.requestdetails.days",
							strsesLanguage)%></td>
						<td class="reportCaption" nowrap="nowrap"
							style="text-align: center;"><%=dbLabelBean.getLabel("label.global.total",
							strsesLanguage)%> (B)</td>
					</tr>

					<%
						AdvanceForex advanceForex = null;
								for (int i = 0; i < advanceForexList.size(); i++) {
									advanceForex = (AdvanceForex) advanceForexList.get(i);
					%>

					<tr>
						<td class="reportdata" style="text-align: center;"><%=i + 1%></td>
						<td class="reportdata"><%=advanceForex.getTravellerName()%></td>
						<td class="reportdata"><%=advanceForex.getAdvCurrency()%></td>
						<td class="reportdata" style="text-align: right;"><%=advanceForex.getExpensePerDay1()%></td>
						<td class="reportdata" style="text-align: right;"><%=advanceForex.getNumOfDays1()%></td>
						<td class="reportdata" style="text-align: right;"><font
							color="black" style="font-weight: bold"> <%=advanceForex.getTotalExpense1()%></font></td>
						<td class="reportdata" style="text-align: right;"><%=advanceForex.getExpensePerDay2()%></td>
						<td class="reportdata" style="text-align: right;"><%=advanceForex.getNumOfDays2()%></td>
						<td class="reportdata" style="text-align: right;"><font
							color="black" style="font-weight: bold"> <%=advanceForex.getTotalExpense2()%></font></td>
						<td class="reportdata" style="text-align: right;"><font
							color="black" style="font-weight: bold"> <%=advanceForex.getContingencyExpense()%></font></td>
						<td class="reportdata" style="text-align: right;"><font
							color="black" style="font-weight: bold"> <%=advanceForex.getOtherExpense()%></font></td>
						<td class="reportdata" style="text-align: right;"><font
							color="black" style="font-weight: bold"> <%=advanceForex.getTotalExpenditure()%></font></td>
						<td class="reportdata" style="text-align: right;"><font
							color="black" style="font-weight: bold"> <%=advanceForex.getTotalAdvanceINR()%></font></td>
						<td class="reportdata"><%=advanceForex.getAdvRemarks()%></td>
						<td class="reportdata"><%=advanceForex.getCashBrkupRemarks()%></td>
					</tr>
					<%
						}
					%>
				</table>
			</td>
		</tr>
		<%
			}
		}
		%>
		<!-- Advance/Expense Detail Section End -->
		
		<!-- Total Travel Fare Section Start -->
		<%
			if (requestInfoObj.isTravelFareDetailExist()) {
				TravelFare travelFare = requestInfoObj.getTravelFare();
				if (travelFare != null) {
		%>
				<tr id="travelFareTR">
					<td>
						<table width="100%" align="left" border="1" cellpadding="2"
							cellspacing="0" class="reporttble" bordercolor="#c7c7c5"
							style="border-collapse: collapse">
							<tr>
								<td height="0" colspan="4" class="reportHeading"
									style="border-bottom: 1px solid #e8e8e8;"><%=dbLabelBean.getLabel(
									"label.createrequest.totaltravelfare", strsesLanguage)%></td>
							</tr>
							<tr>
								<td height="0" class="reportCaption" width="15%"><%=dbLabelBean.getLabel(
									"label.global.currency",
									strsesLanguage)%></td>
								<td height="0" class="reportdata" width="35%"><%=travelFare.getFareCurrency()%></td>
								<td height="0" class="reportCaption" width="15%"><%=dbLabelBean.getLabel(
									"label.createrequest.totalfare",
									strsesLanguage)%></td>
								<td height="0" class="reportdata" width="35%"><%=travelFare.getFareAmount()%></td>
							</tr>
						</table>
					</td>
				</tr>
		<%
			}	}
		%>
		<!-- Total Travel Fare Section End -->
		
		<!-- Budget Actual Section Start -->
		<%
			if(requestInfoObj.isBudgetActualDetailExist()){
				BudgetActual budgetActual = requestInfoObj.getBudgetActual();
				if (budgetActual != null) {
		%>
				<tr id="budgetActualTR">
					<td>
						<table width="100%" align="left" border="1" cellpadding="2"
							cellspacing="0" class="reporttble" bordercolor="#c7c7c5"
							style="border-collapse: collapse">
							<tr>
								<td height="0" colspan="4" class="reportHeading"
									style="border-bottom: 1px solid #e8e8e8;"><%=dbLabelBean.getLabel(
									"label.global.budgetactualdetails", strsesLanguage)%></td>
							</tr>
							<tr>
								<td height="0" class="reportCaption" width="15%"><%=dbLabelBean.getLabel(
									"label.global.ytmbudget",
									strsesLanguage)%></td>
								<td height="0" class="reportdata" width="35%"><%=budgetActual.getYtmBudget()%></td>
								<td height="0" class="reportCaption" width="15%"><%=dbLabelBean.getLabel(
									"label.global.ytdactual",
									strsesLanguage)%></td>
								<td height="0" class="reportdata" width="35%"><%=budgetActual.getYtdActual()%></td>
							</tr>
							<tr>
								<td height="0" class="reportCaption" width="15%"><%=dbLabelBean.getLabel(
									"label.createrequest.availablebudget",
									strsesLanguage)%></td>
								<td height="0" class="reportdata" width="35%"><%=budgetActual.getAvailBudget()%></td>
								<td height="0" class="reportCaption" width="15%"><%=dbLabelBean.getLabel(
									"label.global.estimatedexpenditure",
									strsesLanguage)%></td>
								<td height="0" class="reportdata" width="35%"><%=budgetActual.getEstExp()%></td>
							</tr>
							<tr>
								<td height="0" class="reportCaption" width="15%"><%=dbLabelBean.getLabel(
									"label.createrequest.remarks",
									strsesLanguage)%></td>
								<td height="0" class="reportdata" width="85%" colspan="3"><%=budgetActual.getExpRemarks()%></td>							
							</tr>
						</table>
					</td>
				</tr>
		<%
			}	}
		%>
		<!-- Budget Actual Section End -->

		<!-- Billing Instruction & Approver Level Section Start -->
		<%
			Approver billingApprover = requestInfoObj.getBillingApprover();
			List approverLevelList = requestInfoObj.getApproverLevels();
				if (billingApprover != null || (approverLevelList != null && !approverLevelList.isEmpty()
						&& (approverLevelList.size() == 3))) {
		%>
		<tr id="billingInstTR">
			<td>
				<table width="100%" align="left" border="1" cellpadding="2"
					cellspacing="0" class="reporttble" bordercolor="#c7c7c5"
					style="border-collapse: collapse">
					<% 
						if(billingApprover != null)
						{
					%>	
					
						<tr>
								<td height="0" colspan="4" class="reportHeading"
									style="border-bottom: 1px solid #e8e8e8;">
									<%=dbLabelBean.getLabel("label.global.billinginstructions", strsesLanguage)%> and 
									<%=dbLabelBean.getLabel("label.requestdetails.approvers", strsesLanguage)%>
								</td>
							</tr>
						<tr>
							<td height="0" class="reportCaption" width="15%"><%=dbLabelBean.getLabel(
								"label.requestdetails.billingclient",
								strsesLanguage)%></td>
							<td height="0" class="reportdata" width="35%"><%=billingApprover.getUnitName()%></td>
							<td height="0" class="reportCaption" width="15%"><%=dbLabelBean.getLabel(
								"label.requestdetails.billingapprover",
								strsesLanguage)%></td>
							<td height="0" class="reportdata" width="35%"><%=billingApprover.getName()%></td>
						</tr>
					<%
						}
						Approver appLevel1 = null;
						Approver appLevel2 = null;
						Approver appLevel3 = null;
						if(approverLevelList != null && !approverLevelList.isEmpty() && (approverLevelList.size() == 3))
						{	appLevel1 = (Approver) approverLevelList.get(0);
							appLevel2 = (Approver) approverLevelList.get(1);
							appLevel3 = (Approver) approverLevelList.get(2);
					%>
						<tr>
							<td height="0" class="reportCaption" width="15%"><%=dbLabelBean.getLabel("label.global.approvallevel1",
							strsesLanguage)%></td>
							<td height="0" class="reportdata" width="35%"><%=("-".equals(appLevel1.getName()) ? "Not Applicable"
							: appLevel1.getName())%></td>
							<td height="0" class="reportCaption" width="15%"><%=dbLabelBean.getLabel("label.global.approvallevel2",
							strsesLanguage)%></td>
							<td height="0" class="reportdata" width="35%"><%=("-".equals(appLevel2.getName()) ? "Not Applicable"
							: appLevel2.getName())%></td>
						</tr>
					<%
					
							if(!"-".equals(appLevel3.getName())) {
					%>
							<tr>
								<td height="0" class="reportCaption" width="15%"><%=dbLabelBean.getLabel("label.global.boardmember",
								strsesLanguage)%></td>
								<td height="0" class="reportdata" width="85%" colspan="3"><%=("-".equals(appLevel3.getName()) ? "Not Applicable"
								: appLevel3.getName())%></td>								
							</tr>
					<%			
							}
						}
					%>
				</table>
			</td>
		</tr>
		<%	
			}
		%>
		<!-- Billing Instruction & Approver Level Section End -->

		<!-- Passport/Visa/Insurance Detail Section Start -->
		<%
			if (travelType.equals("I")) {
					Passport travellerPassportInfo = traveller.getPassport();
		%>
		<tr>
			<td>
				<table width="100%" align="left" border="1" cellpadding="2"
					cellspacing="0" class="reporttble" bordercolor="#c7c7c5"
					style="border-collapse: collapse">
					<tr>
						<td height="0" colspan="6" class="reportHeading">
							<%=dbLabelBean.getLabel("label.createrequest.passport",strsesLanguage)%>/
							<%=dbLabelBean.getLabel("label.global.visa",strsesLanguage)%>/
							<%=dbLabelBean.getLabel("label.requestdetails.insuranceinformation",strsesLanguage)%>
						</td>
					</tr>
					<tr>
						<td class="reportCaption" width="14%"><%=dbLabelBean.getLabel(
							"label.createrequest.passportnumber",
							strsesLanguage)%></td>
						<td class="reportdata" width="18%"><%=travellerPassportInfo.getPassportNo()%></td>
						<td class="reportCaption" width="20%"><%=dbLabelBean.getLabel("label.user.nationality",
							strsesLanguage)%></td>
						<td class="reportdata" width="18%"><%=travellerPassportInfo.getNationality()%></td>
						<td class="reportCaption" width="12%"><%=dbLabelBean.getLabel(
							"label.createrequest.placeofissue", strsesLanguage)%></td>
						<td class="reportdata" width="18%"><%=travellerPassportInfo.getPlaceOfIssue()%></td>
					</tr>
					<tr>
						<td class="reportCaption" width="14%"><%=dbLabelBean.getLabel("label.global.dateofissue",
							strsesLanguage)%></td>
						<td class="reportdata" width="38%"><%=travellerPassportInfo.getDateOfIssue()%></td>
						<td class="reportCaption" width="18%"><%=dbLabelBean.getLabel("label.global.dateofexpiry",
							strsesLanguage)%></td>
						<td class="reportdata" width="30%"><%=travellerPassportInfo.getDateOfExpiry()%></td>
						<td class="reportCaption" width="14%"><%=dbLabelBean.getLabel("label.global.visarequired",
							strsesLanguage)%></td>
						<td class="reportdata" width="38%"><%=travellerPassportInfo.isVisaExists() ? "Yes": "No"%>
						</td>
					</tr>
					<tr>
						<td class="reportCaption" width="10%"><%=dbLabelBean.getLabel(
						"label.createrequest.travelinsurancerequired",
						strsesLanguage)%></td>
						<td class="reportdata" width="15%"><%=(travellerPassportInfo.isInsuranceReq() ? "Yes"
						: "No")%></td>
						<%
							if (!travellerPassportInfo.isInsuranceReq()) {
						%>
						<td class="reportCaption" width="10%" colspan="2"><%=dbLabelBean.getLabel(
							"label.requestdetails.insurancecomments",
							strsesLanguage)%></td>
						<td class="reportdata" width="15%" colspan="2"><%=travellerPassportInfo.getInsuranceRemarks()%></td>
						<%
							} else {
						%>
						<td class="reportCaption" width="10%"><%=dbLabelBean.getLabel("label.global.nominee",
							strsesLanguage)%></td>
						<td class="reportdata" width="15%"><%=travellerPassportInfo.getInsuranceNominee()%></td>
						<td class="reportCaption" width="10%"><%=dbLabelBean.getLabel(
							"label.createrequest.relation", strsesLanguage)%></td>
						<td class="reportdata" width="15%"><%=travellerPassportInfo.getInsuranceRelation()%></td>
						<%
							}	}
						%>
					</tr>
		<% 
			if (requestInfoObj.isVisaDetailExist()) {
				List visaDetailList = requestInfoObj.getVisaDetailList();	
				if (visaDetailList != null && !visaDetailList.isEmpty() && visaDetailList.size() > 0) {
		%>	
					<tr>
						<td colspan="6" class="reportSubHeading" style="line-height: 16px;"><%=dbLabelBean.getLabel("label.visa.visadetails",strsesLanguage)%></td>
					</tr>
					<tr>
						<td class="reportCaption"><%=dbLabelBean.getLabel("label.global.visa",strsesLanguage)%> <%=dbLabelBean.getLabel("label.user.country",strsesLanguage)%></td>
						<td class="reportCaption"><%=dbLabelBean.getLabel("label.personnelbooking.visavalidfrom",strsesLanguage)%></td>
						<td class="reportCaption"><%=dbLabelBean.getLabel("label.personnelbooking.visavalidto",strsesLanguage)%></td>
						<td class="reportCaption"><%=dbLabelBean.getLabel("label.visa.visaduration",strsesLanguage)%></td>
						<td class="reportCaption"><%=dbLabelBean.getLabel("label.global.visacomments",strsesLanguage)%></td>
						<td class="reportCaption"><%=dbLabelBean.getLabel("label.visa.validity",strsesLanguage)%></td>
					</tr>
		
		<%			for(int i=0; i < visaDetailList.size(); i++) {
						Visa visa = (Visa) visaDetailList.get(i);
		%>			
					<tr>
						<td class="reportdata"><%=visa.getCountry().trim()%></td>
						<td class="reportdata"><%=visa.getValidFrom().trim()%></td>
						<td class="reportdata"><%=visa.getValidTo().trim()%></td>
						<td class="reportdata"><%=visa.getVisaDuration().trim()%></td>
						<td class="reportdata"><%=visa.getVisaComments().trim()%></td>
		<%				if(visa.getVisaValidityFlag().trim().equalsIgnoreCase("Y")) {
		%>				<td class="reportdata">Valid</td>
		<%				} else {
		%>				<td class="reportdata">Invalid</td>
		<%				}
		%>			</tr>
		
		<%			}
		%>		</table>
			</td>
		</tr>
		
		<%		} else {
		%>		</table>
			</td>
		</tr>
		
		<%		}
			} else {		
		%>		</table>
			</td>
		</tr>
		<%	}
		%>
		<!-- Passport/Visa/Insurance Detail Section End -->
		
		<!-- Rewards Card Detail Section Start -->
		<%
			List rewardCardList = requestInfoObj.getRewardCardList();
				if (rewardCardList != null && !rewardCardList.isEmpty()) {
		%>
		<tr>
			<td>
				<table width="100%" align="left" border="1" cellpadding="2"
					cellspacing="0" class="reporttble" bordercolor="#c7c7c5"
					style="border-collapse: collapse">
					<tr>
						<td height="0" colspan="2" class="reportHeading"><%=dbLabelBean.getLabel(
							"label.createrequest.frequentflyerdetails",
							strsesLanguage)%></td>
						<td height="0" colspan="2" class="reportHeading"><%=dbLabelBean.getLabel(
							"label.global.hotelrewardcard", strsesLanguage)%></td>
					</tr>
					<tr>
						<td class="reportCaption" width="25%"><%=dbLabelBean.getLabel(
							"label.createrequest.airlinenames", strsesLanguage)%></td>
						<td class="reportCaption" width="25%"><%=dbLabelBean.getLabel(
							"label.requestdetails.number", strsesLanguage)%></td>
						<td class="reportCaption" width="25%"><%=dbLabelBean.getLabel("label.global.hotelchain",
							strsesLanguage)%></td>
						<td class="reportCaption" width="25%"><%=dbLabelBean.getLabel(
							"label.requestdetails.number", strsesLanguage)%></td>
					</tr>
					<%
						for (int i = 0; i < rewardCardList.size(); i++) {
									RewardCard card = (RewardCard) rewardCardList.get(i);
					%>
					<tr>
						<td class="reportdata" width="25%"><%=card.getAirlineName()%></td>
						<td class="reportdata" width="25%"><%=card.getAirlineNo()%></td>
						<td class="reportdata" width="25%"><%=card.getHotelChainName()%></td>
						<td class="reportdata" width="25%"><%=card.getHotelChainNo()%></td>
					</tr>
					<%
						}
					%>
				</table>
			</td>
		</tr>
		<%
			}
		%>
		<!-- Rewards Card Detail Section End -->

		<!-- Approvers List Section Start -->
		<tr>
			<td>
				<table width="100%" align="left" border="1" cellpadding="2"
					cellspacing="0" class="reporttble" bordercolor="#c7c7c5"
					style="border-collapse: collapse">
					<tr>
						<td colspan="5" class="reportHeading"><%=dbLabelBean.getLabel(
						"label.requestdetails.approverslist", strsesLanguage)%></td>
					</tr>
					<tr>
						<td width="4%" class="reportCaption" style="text-align: center;"><%=dbLabelBean.getLabel("label.global.sno",
						strsesLanguage)%></td>
						<td width="30%" class="reportCaption"><%=dbLabelBean.getLabel("label.requestdetails.name",
						strsesLanguage)%></td>
						<td width="30%" class="reportCaption"><%=dbLabelBean.getLabel("label.global.designation",
						strsesLanguage)%></td>
						<td width="16%" class="reportCaption" style="text-align: center"><%=dbLabelBean.getLabel("label.requestdetails.status",
						strsesLanguage)%></td>
						<td width="20%" class="reportCaption"><%=dbLabelBean.getLabel(
						"label.requestdetails.approvaldatetime", strsesLanguage)%></td>
					</tr>
					<%
						String strApproveStatus = "";
							int iLoop = 1;
							String strMsg = "";
							String strImg = "Red";

							List approverList = requestInfoObj.getApprovers();
							Approver approver = null;
							for (int i = 0; i < approverList.size(); i++) {
								iLoop = i + 1;
								approver = (Approver) approverList.get(i);
								strApproveStatus = approver.getApproveStatus();

								//added by Manoj Chand on 28 March 2012 to show Current Pending request with red p.
								if (strApproveStatus.equals("0")
										&& !strImg.equalsIgnoreCase("Red")) {
									strApproveStatus = "<img src=images/cross.gif border=0>";
								} else if (strApproveStatus.equals("0")
										&& strImg.equalsIgnoreCase("Red")) {
									strApproveStatus = "<img src=images/mark.gif border=0>";
									strImg = "black";
								} else if (strApproveStatus.equals("4")) {
									strApproveStatus = "<font color=red>"
											+ dbLabelBean.getLabel(
													"label.requestdetails.rejected",
													strsesLanguage) + " </font>";
									strImg = "black";
								} else if (strApproveStatus.equals("3")) {
									strApproveStatus = "<font color=red>"
											+ dbLabelBean.getLabel(
													"label.requestdetails.returned",
													strsesLanguage) + " </font>";
									strImg = "black";
								} else if (strApproveStatus.equals("6")) {
									strApproveStatus = "<font color=red>"
											+ dbLabelBean.getLabel(
													"label.requestdetails.cancelled",
													strsesLanguage) + " </font>";
									strImg = "black";
								} else {
									strApproveStatus = "<img src=images/tick.gif border=0>";
								}

								if (approver.getOriginalApprover().equals("0")) {
									strMsg = "";
								} else {
									strMsg = "<font color=red >("
											+ dbLabelBean.getLabel(
													"label.requestdetails.onbehalfof",
													strsesLanguage) + " "
											+ approver.getOriginalApprover() + ")</font>";
								}
					%>
					<tr>
						<td width="4%" class="reportdata" style="text-align: center;"><%=iLoop++%></td>
						<td width="30%" class="reportdata"><%=approver.getName()%> <%=strMsg%></td>
						<td width="30%" class="reportdata"><%=approver.getDesignationName()%>
						</td>
						<td width="16%" class="reportdata" style="text-align: center;"><%=strApproveStatus%>
						</td>
						<%
							if (strApproveStatus.equals("<img src=images/tick.gif border=0>")) {
								String apprvTime = (approver.getApproveTime() == null || approver.getApproveTime().trim().equals(""))? "": "  "+approver.getApproveTime().trim();
						%>
						<td width="20%" class="reportdata"><%=approver.getApproveDate().trim()%><%=apprvTime%></td>
						<%
							} else {
						%>
						<td width="20%" class="reportdata">-</td>
						<%
							}
						%>
					</tr>
					<%
						}
					%>
				</table>
			</td>
		</tr>
		<!-- Approvers List Section End -->

		<!-- Approvers Comment Section Start -->
		<%
			List approversCommentList = dao.getApproversComment(
						strTravelId, travelType, "APPROVE");
				if (approversCommentList != null) {
		%>
		<tr>
			<td>
				<table width="100%" align="left" border="1" cellpadding="2"
					cellspacing="0" class="reporttble" bordercolor="#c7c7c5"
					style="border-collapse: collapse">
					<tr>
						<td colspan="4" class="reportHeading"><%=dbLabelBean.getLabel(
							"link.approverequest.comments", strsesLanguage)%></td>
					</tr>
					<tr>
						<td class="reportCaption" width="4%" style="text-align: center;" nowrap="nowrap"><%=dbLabelBean.getLabel("label.global.sno",
							strsesLanguage)%></td>
						<td class="reportCaption" width="46%" align="left"><%=dbLabelBean.getLabel(
							"link.approverequest.comments", strsesLanguage)%></td>
						<td class="reportCaption" width="30%" align="left"><%=dbLabelBean.getLabel("label.global.postedby",
							strsesLanguage)%></td>
						<td class="reportCaption" width="20%" style="border-right: 0;"><%=dbLabelBean.getLabel("label.global.postedon",
							strsesLanguage)%></td>
					</tr>
					<%
						if (approversCommentList != null
										&& !approversCommentList.isEmpty()) {
									for (int i = 0; i < approversCommentList.size(); i++) {
										Comment comment = (Comment) approversCommentList
												.get(i);
										if (iCls % 2 == 0) {
											strStyleCls = "formtr2";
										} else {
											strStyleCls = "formtr1";
										}
										iCls++;
					%>
					<tr class="<%=strStyleCls%>">
						<td class="reportdata" width="4%" style="text-align: center;"><%=i + 1%></td>
						<td class="reportdata" width="46%" align="left"><%=comment.getComment()%></td>
						<td class="reportdata" width="30%" align="left"><%=comment.getPostedByName()%></td>
						<td class="reportdata" width="20%" style="border-right: 0;"><%=comment.getPostedOnDate()%></td>
					</tr>
					<%
						}
								}
					%>
				</table>
			</td>
		</tr>
		<%
			}
		%>
		<!-- Approvers Comment Section End -->

		<!--Cancellation Comments Section Start -->
		<%
			List approversCancellationCommentList = dao
						.getApproversComment(strTravelId, travelType, "CANCEL");
				if (approversCancellationCommentList != null) {
		%>
		<tr>
			<td>
				<table width="100%" align="left" border="1" cellpadding="2"
					cellspacing="0" class="reporttble" bordercolor="#c7c7c5"
					style="border-collapse: collapse">
					<tr>
						<td colspan="4" class="reportHeading"><%=dbLabelBean.getLabel(
							"label.global.cancellationcomment", strsesLanguage)%></td>
					</tr>
					<tr>
						<td class="reportCaption" width="4%" style="text-align: center;" valign="top"
							nowrap="nowrap"><%=dbLabelBean.getLabel("label.global.sno",
							strsesLanguage)%></td>
						<td class="reportCaption" width="46%" align="left" valign="top"><%=dbLabelBean.getLabel(
							"link.approverequest.comments", strsesLanguage)%></td>
						<td class="reportCaption" width="30%" align="left" valign="top"><%=dbLabelBean.getLabel("label.global.postedby",
							strsesLanguage)%></td>
						<td class="reportCaption" width="20%"><%=dbLabelBean.getLabel("label.global.postedon",
							strsesLanguage)%></td>
					</tr>
					<%
						if (approversCancellationCommentList != null
										&& !approversCancellationCommentList.isEmpty()) {
									for (int i = 0; i < approversCancellationCommentList
											.size(); i++) {
										Comment cancelComment = (Comment) approversCancellationCommentList
												.get(i);
					%>
					<%
						if (iCls % 2 == 0) {
											strStyleCls = "formtr2";
										} else {
											strStyleCls = "formtr1";
										}
										iCls++;
					%>
					<tr class="<%=strStyleCls%>">
						<td class="reportdata" width="4%" style="text-align: center;"
							valign="top"><%=i + 1%></td>
						<td class="reportdata" width="46%" align="left" valign="top"><%=cancelComment.getComment()%></td>
						<td class="reportdata" width="30%" align="left" valign="top"><%=cancelComment.getPostedByName()%></td>
						<td class="reportdata" width="20%"><%=cancelComment.getPostedOnDate()%></td>
					</tr>
					<%
						}
								}
					%>
				</table>
			</td>
		</tr>
		<%
			}
		%>
		<!--Cancellation Comments Section End -->
	</table>

	<table width="100%" align="left" border="0" cellpadding="0"
		cellspacing="0">
		<tr>
			<td>
				<div id="sub5">
					<table width="98%" align="center" border="0" cellpadding="5"
						cellspacing="1" class="formborder">
						<%
							String strSql5 = "SELECT TRAVEL_STATUS_ID FROM  T_TRAVEL_STATUS WHERE  (TRAVEL_ID = "
										+ strTravelId
										+ ") AND (TRAVEL_TYPE = 'i')  AND (STATUS_ID = 10)";
								String strTravelstatus = "";
								rs = dbConBean.executeQuery(strSql5);
								while (rs.next()) {
									strTravelstatus = rs.getString("TRAVEL_STATUS_ID");
								}
								rs.close();
								if (strTravelstatus != null && strTravelstatus.equals("10")) {
						%>
						<!-- added link for Learms page for showing deatils of lerms after all approveral on 29 jan 2009 -->
						<tr class="formhead">
							<td height="0" class="listhead">&nbsp;<a href="#"
								class="reportLink"
								onClick="MM_openBrWindow('reqlermsDetails.jsp?purchaseRequisitionId=<%=strTravelId%>&travel_type=I','Attachments','scrollbars=yes,resizable=yes,width=650,height=600')"><%=dbLabelBean.getLabel(
							"label.requestdetails.clickheretoopenlermsdetail",
							strsesLanguage)%></td>
						</tr>
						<%
							}
								dbConBean.close(); //close all connection
						%>
						<tr class="formhead1" height="5">
							<td class="reportHeading" align="center">
								<p align=center><%=dbLabelBean.getLabel(
						"label.requestdetails.clickonmailicontoviewmailflow",
						strsesLanguage)%>
									<a href="#"
										onClick="MM_openBrWindow('T_travelRequisitionMails.jsp?travelReqNo=<%=requestInfoObj.getRequisitionNo()%>','REQMAILS','scrollbars=yes,resizable=yes,width=775,height=250')"><IMG
										SRC="images/EMAILIMG.gif?buildstamp=2_0_0" border=0
										alt="<%=dbLabelBean.getLabel(
						"label.requestdetails.viewemails", strsesLanguage)%>"></a>
								</p>
							</td>
						</tr>
					</table>
				</div>
			</td>
		</tr>
	</table>
	<%
		}
	%>
</body>
</html>