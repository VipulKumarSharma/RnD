	<%@page import="java.beans.DesignMode"%>
	<%@ page pageEncoding="UTF-8" %>
	<%@ include  file="importStatement.jsp" %>
	<html>
	<head>
	<%-- include page with all application session variables --%>
	<%@ include  file="application.jsp" %>
	<%-- include remove cache  --%>
	<%@ include  file="cacheInc.inc" %>
	<%-- include header  --%>
	<%@ include  file="headerIncl.inc" %>
	<%@ page import="src.enumTypes.*" %>
	<%@ page import="src.beans.*" %>
	<%@ page import="src.dao.*" %>
	
	<!--Create the DbConnectionBean object for createConnection-->
	<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
	<jsp:useBean id="dbConBean1" scope="page" class="src.connection.DbConnectionBean" />
	<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
	<jsp:useBean id="securityUtilityBean" scope="page" class="src.connection.SecurityUtilityMethods" />
	
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	
	<script language="JavaScript" src="scripts/CommonValida.js?buildstamp=2_0_0"></script>
	<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
	<script type="text/javascript" language="JavaScript1.2" src="scripts/div.js?buildstamp=2_0_0"></script>
	<style type="text/css">
		.reporttble {
		width: auto;
		max-width: 100%;
		}
		.reportHeading
		{
		font-family:Verdana, Arial, Helvetica, sans-serif;
		font-size:13px;
		font-weight:bold;
		color:#ffffff;
		line-height:22px;
		background-color:#7a7a7a;
		padding-left:5px;
		text-align:left;
		}
		
		.reportSubHeading
		{
		font-family:Verdana, Arial, Helvetica, sans-serif;
		font-size:12px;
		font-weight:bold;
		color:#000000;
		line-height:20px;
		background-color:#dddddd;
		padding-left:5px;
		text-align:left;
		}
		
		.reportCaption
		{
		width: auto;
		font-family:Verdana, Arial, Helvetica, sans-serif;
		font-size:11px;
		font-weight:bold;
		color:#1d1d1d;
		line-height:20px;
		background-color:#f2f2f2;
		padding-left:5px;
		padding-right:5px;
		text-align:left;
		}
		
		.reportdata
		{
		width: auto;
		font-family:Verdana, Arial, Helvetica, sans-serif;
		font-size:11px;
		font-weight: normal;
		color:#373737;
		line-height:20px;
		background-color:#f7f7f7;
		padding-left:5px;
		padding-right:5px;
		text-align:left;
		}
	</style>
	<script type="text/javascript">
	function ShowHide(id)
	{
	    obj = document.getElementsByTagName("div");
	    if (obj[id].style.visibility == 'visible')
		{
	      obj[id].style.visibility = 'hidden';
	    }
	    else 
		{
	      obj[id].style.visibility = 'visible';
	    }
	}
	</script>
	</head>
	<%
	// Variables declared and initialized
	ResultSet rs		=		null;			  // Object for ResultSet
	String	sSqlStr          	=	"";			// For sql Statements
	String strRequisitionId  	=	"";//For holding Purchase Requisition Id
	String strTravellerId       =  "";
	String strTravelId          =  "";
	String travelType			=  "";
	
	strTravelId		=	request.getParameter("purchaseRequisitionId");
	strTravellerId  =   request.getParameter("traveller_Id");
	travelType  	=   request.getParameter("travelType");
	String strOriginalapprover		="";
	String reportFlag	= request.getParameter("reportFlag")==null?"false":request.getParameter("reportFlag").trim();
	
	if(travelType != null){
		if(travelType.equals("INT") || travelType.equals("I")){
			travelType = "I";
		}else if(travelType.equals("DOM") || travelType.equals("D")){
			travelType = "D";
		}
	}
	//Added By Gurmeet Singh
	String strUserAccessCheckFlag = "";
	strUserAccessCheckFlag = securityUtilityBean.validateAuthTravelDetails(strTravelId, travelType, Suser_id);		
	
	if(reportFlag.equalsIgnoreCase("false") && strUserAccessCheckFlag.equals("420")){	
		dbConBean.close();  
		dbConBean1.close();		
		securityUtilityBean.registerUnauthAccessLog(Suser_id, request.getRemoteAddr(), "T_TravelRequisitionDetails_INT_GmbH.jsp", "Unauthorized Access");
		response.sendRedirect("UnauthorizedAccess.jsp");		
	} else {	
	
	int iCls = 0;
	String strStyleCls = "";
	
	T_QuicktravelRequestDaoImpl dao = new T_QuicktravelRequestDaoImpl();
	TravelRequest requestInfoObj = dao.getTravelRequestDetail(strTravelId, travelType, strTravellerId);
	User requestOriginator = requestInfoObj.getOriginator();
	User traveller = requestInfoObj.getTraveller();
	%>
	<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
	<body><script type="text/javascript" language="JavaScript1.2" src="menu/menu_cnt.js?buildstamp=2_0_0"></script>
	<table width="99%" border="0" cellspacing="0" cellpadding="0">
		  <tr>
		    <td height="45" class="bodyline-top">
			<ul class="pagebullet">
		      <li class="pageHead">
		      <%if(travelType.equals("I")){ %>
		      <b>
		     	<%--  <%=dbLabelBean.getLabel("label.requestdetails.internationaljourneyreport",strsesLanguage) %> --%>
		     	Intercont Journey Report
		      </b>
		      <%}else{ %>
		      <b>
		     	<%-- <%=dbLabelBean.getLabel("label.requestdetails.domesticjourneyreport",strsesLanguage) %> --%>
		     	Domestic/Europe Journey Report
		     </b>
		     <%} %>
		      </li>
		    </ul></td>
		     <td align="right" valign="bottom" class="bodyline-top">
			<table  align="right" border="0" cellspacing="0" cellpadding="0">
		      <tr align="right">
		       <td>
		     <ul id="list-nav">
		      <li><a href="#" onClick="window.print();"><%=dbLabelBean.getLabel("button.search.print",strsesLanguage) %></a></li>
		      <li><a href="#" onClick="javascript:top.window.close();"><%=dbLabelBean.getLabel("button.global.close",strsesLanguage) %></a></li>
		     </ul>
		       </td>
		      </tr>
		    </table>
		</td>
		</tr>
	</table>
	<table width="99%" align="center" style="margin:0 auto;" border="0" cellpadding="5" cellspacing="1">
	  <tr>
	    <td>
		  <table width="100%" align="left" border="1" cellpadding="2" cellspacing="0" class="reporttble" bordercolor="#c7c7c5" style="border-collapse: collapse">
	        <tr>
	          <td height="0" colspan="6" align="left" class="reportHeading"><%=dbLabelBean.getLabel("label.requestdetails.requestdetails",strsesLanguage) %></td>
	        </tr>
	        <tr>
	          <td width="12%" height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.requisitionnumber",strsesLanguage) %></td>
	          <td width="26%" height="0" class="reportdata"><%=requestInfoObj.getRequisitionNo()%></td>
	          <td width="12%" height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.requestdetails.originator",strsesLanguage) %></td>
	          <td width="20%" height="0" class="reportdata"><%=(requestOriginator.getFullName() != null ? requestOriginator.getFullName().toUpperCase() : "")%></td>
	          <td width="14%" height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.approverrequest.originatedon",strsesLanguage) %></td>
	          <td width="16%" height="0" class="reportdata" ><%=requestInfoObj.getCreationDate()%></td>
	        </tr>
	        <tr>
	          <td width="12%" height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.requestdetails.division",strsesLanguage) %></td>
	          <td width="26%" height="0" class="reportdata" ><%=(requestOriginator.getDivisionName() != null ? requestOriginator.getDivisionName().toUpperCase() : "")%></td>
	          <td width="12%" height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.requestdetails.unit",strsesLanguage) %></td>
	          <td width="20%" height="0" class="reportdata" ><%=(requestOriginator.getUnitName() != null ? requestOriginator.getUnitName().toUpperCase() : "")%></td>
	          <td width="14%" height="0" align="right" class="reportCaption" ><%=dbLabelBean.getLabel("label.requestdetails.department",strsesLanguage) %></td>
	          <td width="16%" height="0" class="reportdata" ><%=(requestOriginator.getDepartmentName() != null ? requestOriginator.getDepartmentName().toUpperCase() : "")%></td>
	        </tr>
	      </table>
	    </td>
	  </tr> 
	  <!-- Personal Detail Section Start -->
	  <tr>
        	<td>    		
        		<table width="100%" align="left" border="1" cellpadding="2" cellspacing="0" class="reporttble" bordercolor="#c7c7c5" style="border-collapse: collapse">
        			 <tr>
          				<td height="0" colspan="8" class="reportHeading"><%=dbLabelBean.getLabel("label.global.personaladdress",strsesLanguage) %></td>
        			</tr>
        			<tr>
        				<td class="reportCaption" width="12%"><%=dbLabelBean.getLabel("label.requestdetails.unit",strsesLanguage) %></td>
        				<td class="reportdata" width="18%"><%=traveller.getUnitName() %></td>
        				<td class="reportCaption" width="15%"><%=dbLabelBean.getLabel("label.global.firstname",strsesLanguage) %></td>
        				<td class="reportdata" width="18%"><%=traveller.getFirstName() %></td>
        				<td class="reportCaption" width="15%"><%=dbLabelBean.getLabel("label.global.lastname",strsesLanguage) %></td>
        				<td class="reportdata" width="18%"><%=traveller.getLastName() %></td>
        				<td class="reportCaption" width="15%"><%=dbLabelBean.getLabel("label.global.designation",strsesLanguage) %></td>
        				<td class="reportdata" width="18%"><%=traveller.getDesignationName() %></td>
        			</tr>
        			<tr>        				
        				<td class="reportCaption" width="12%"><%=dbLabelBean.getLabel("label.global.contactno",strsesLanguage) %></td>
        				<td class="reportdata" width="18%"><%=traveller.getContactNo() %></td>
        				<td class="reportCaption" width="15%"><%=dbLabelBean.getLabel("label.createrequest.costcentre",strsesLanguage) %></td>
        				<td class="reportdata" width="18%"><%=traveller.getCostCenterName() %></td>
        				<td class="reportCaption" width="15%"><%=dbLabelBean.getLabel("label.global.projectnumber",strsesLanguage) %></td>
        				<td class="reportdata" width="18%"><%=requestInfoObj.getProjectNo()%></td>
        				<td class="reportCaption" width="15%"><%=dbLabelBean.getLabel("label.global.gender",strsesLanguage) %></td>
        				<td class="reportdata" width="18%"><%=traveller.getGender() %></td>
        			</tr>
        			<%if(travelType.equals("I")){ %>
        			<tr>
        				<td class="reportCaption" width="15%"><%=dbLabelBean.getLabel("label.global.specialmeal",strsesLanguage) %></td>
        				<td class="reportdata" width="18%"><%=traveller.getMealPreferrence() %></td>
        				<td class="reportCaption" width="15%"><%=dbLabelBean.getLabel("label.global.reasonfortravel",strsesLanguage) %></td>
        			 	<td class="reportdata" colspan="5"><%=requestInfoObj.getReasonForTravel() %></td>
        			</tr>
        			<%} else { %>
        			<tr>
        				<td class="reportCaption" width="15%"><%=dbLabelBean.getLabel("label.global.reasonfortravel",strsesLanguage) %></td>
        			 	<td class="reportdata" colspan="7"><%=requestInfoObj.getReasonForTravel() %></td>
        			</tr>
        			<%} %>
        		</table>        		
        	</td>
        </tr>
         <!-- Personal Detail Section End -->
        <%
        List rewardCardList = requestInfoObj.getRewardCardList();
        if(rewardCardList != null && !rewardCardList.isEmpty()){ %>
        <!-- Rewards Card Detail Section Start -->
        <tr>
        	<td>
        		<table width="100%" align="left" border="1" cellpadding="2" cellspacing="0" class="reporttble" bordercolor="#c7c7c5" style="border-collapse: collapse">
        			 <tr>
          				<td height="0" colspan="4" class="reportHeading"><%=dbLabelBean.getLabel("label.global.rewardscarddetails",strsesLanguage) %></td>
        			</tr>
        			<tr>
        				<td class="reportCaption" width="25%"><%=dbLabelBean.getLabel("label.createrequest.airlinenames",strsesLanguage) %></td>
        				<td class="reportCaption" width="25%"><%=dbLabelBean.getLabel("label.requestdetails.number",strsesLanguage) %></td>
        				<td class="reportCaption" width="25%"><%=dbLabelBean.getLabel("label.global.hotelchain",strsesLanguage) %></td>
        				<td class="reportCaption" width="25%"><%=dbLabelBean.getLabel("label.requestdetails.number",strsesLanguage) %></td>
        			</tr>
        			<%
        				for(int i=0; i<rewardCardList.size(); i++){
        				RewardCard card = (RewardCard)rewardCardList.get(i);
        			%>
        			<tr>
        				<td class="reportdata" width="25%"><%=card.getAirlineName() %></td>
        				<td class="reportdata" width="25%"><%=card.getAirlineNo() %></td>
        				<td class="reportdata" width="25%"><%=card.getHotelChainName() %></td>
        				<td class="reportdata" width="25%"><%=card.getHotelChainNo() %></td>
        			</tr>
        			<%	}%>
        		</table>
        	</td>
        </tr>
        <%} %>
        <!-- Rewards Card Detail Section End -->
	    <!-- Flight Detail Section Start -->
	  <% if(requestInfoObj.isFlightDetailExist()){ %>
        <tr id="flightDetailMainTR">
        	<td>
        		<table width="88%" align="left" border="1" cellpadding="2" cellspacing="0" class="reporttble" bordercolor="#c7c7c5" style="border-collapse: collapse">		        	
        			 <tr>
          				<td height="0" colspan="7" class="reportHeading"><%=dbLabelBean.getLabel("label.global.flightdetails",strsesLanguage) %></td>
        			</tr>
        			<tr>
        				<td class="reportCaption" width="12%"></td>
        				<td class="reportCaption" width="19%"><%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage) %></td>
        				<td class="reportCaption" width="19%"><%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage) %></td>
        				<td class="reportCaption" width="8%"><%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage) %></td>
        				<td class="reportCaption" width="12%"><%=dbLabelBean.getLabel("label.global.preferredtime",strsesLanguage) %></td>
        				<td class="reportCaption" width="8%"><%=dbLabelBean.getLabel("label.global.class",strsesLanguage) %></td>
        				<td class="reportCaption" width="10%"><%=dbLabelBean.getLabel("label.global.preferredseat",strsesLanguage) %></td>
        			</tr>
        			<%
        				  List flightList = requestInfoObj.getFlightDetailList();
        				  Flight flightObj = null;
        				  Fare fareFlt = null;
        				  String journytypeStr = null;
        				  for(int i=0; i<flightList.size(); i++){
        					  flightObj = (Flight)flightList.get(i);
        					  fareFlt = flightObj.getFareDetail();
        					   if(flightObj.getJournyType().equals(TravelRequestEnums.JournyType.FORWARD.getId())){
        						   journytypeStr = dbLabelBean.getLabel("label.global.outwardleg",strsesLanguage);
        					   }else if(flightObj.getJournyType().equals(TravelRequestEnums.JournyType.INTERMEDIATE.getId())){
        						   journytypeStr = dbLabelBean.getLabel("label.global.intermediateleg",strsesLanguage);
        					   }else {
        						   journytypeStr = dbLabelBean.getLabel("label.global.returnleg",strsesLanguage);
        					   }
        			%>
        			<tr>
        				<td class="reportCaption" width="12%"><%=journytypeStr %></td>
        				<td class="reportdata" width="19%"><%=flightObj.getDepartureCity() %></td>
        				<td class="reportdata" width="19%"><%=flightObj.getArrivalCity() %></td>
        				<td class="reportdata" width="10%"><%=flightObj.getDepartureDate() %></td>
        				<td class="reportdata" width="12%"><%=flightObj.getPreferredTimeType() %>&nbsp;<%=flightObj.getTiming() %></td>
        				<td class="reportdata" width="8%"><%=flightObj.getTravelClass() %></td>
        				<td class="reportdata" width="8%"><%=flightObj.getWindowSeatPreferrence() %></td>
        			</tr>
				        <% 
			  	}
				    if(flightObj.getRemarks() != null && !flightObj.getRemarks().equals("") && !flightObj.getRemarks().trim().equals("-")) {
					%>
					<tr>
       					<td class="reportCaption"><%=dbLabelBean.getLabel("label.createrequest.remarks",strsesLanguage) %></td>
       					<td class="reportdata" colspan="6"><%=flightObj.getRemarks() %></td>
       				</tr>
       				<%} %>
        		</table>
        	</td>
        </tr>
        <%if(fareFlt != null){ 
		%>
        <tr>
        	<td>
        		<table width="100%" align="left" border="1" cellpadding="2" cellspacing="0" class="reporttble" bordercolor="#c7c7c5" style="border-collapse: collapse">
        			 <tr>
          				<td height="0" colspan="6" class="reportSubHeading"><%=dbLabelBean.getLabel("label.global.fares",strsesLanguage) %></td>
        			</tr>
        			<tr>
        				<td class="reportCaption" width="20%"><%=dbLabelBean.getLabel("label.global.changeableagainstafee",strsesLanguage) %></td>
        				<td class="reportdata"><%=fareFlt.isChangeableAgainstFee() ? "Yes" : "No" %></td>
        				<td class="reportCaption" width="20%"><%=dbLabelBean.getLabel("label.global.refundableagainstafee",strsesLanguage) %></td>
        				<td class="reportdata"><%=fareFlt.isRefundableAgainstFee() ? "Yes" : "No" %></td>
        				<td class="reportCaption" width="20%"><%=dbLabelBean.getLabel("label.global.checkedbaggage",strsesLanguage) %></td>
        				<td class="reportdata"><%=fareFlt.getCheckedBaggageCount() %></td>
        			</tr>
        		</table>
        	</td>
        </tr>
        <!-- Flight Detail Section End -->
        <%
        	} 
       }
	  %>
	  <% if(requestInfoObj.isTrainDetailExist()) { %>
        <tr id="trnDetailTR1">
        	<td>
        		<table width="88%" align="left" border="1" cellpadding="2" cellspacing="0" class="reporttble" bordercolor="#c7c7c5" style="border-collapse: collapse">		        	
        			 <tr>
          				<td height="0" colspan="7" class="reportHeading"><%=dbLabelBean.getLabel("label.global.traindetails",strsesLanguage) %></td>
        			</tr>
        			<tr>
        				<td class="reportCaption" width="12%"></td>
        				<td class="reportCaption" width="19%"><%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage) %></td>
        				<td class="reportCaption" width="19%"><%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage) %></td>
        				<td class="reportCaption" width="8%"><%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage) %></td>
        				<td class="reportCaption" width="12%"><%=dbLabelBean.getLabel("label.global.preferredtime",strsesLanguage) %></td>
        				<td class="reportCaption" width="8%"><%=dbLabelBean.getLabel("label.global.class",strsesLanguage) %></td>
        				<td class="reportCaption" width="10%"><%=dbLabelBean.getLabel("label.global.preferredseat",strsesLanguage) %></td>
        			</tr>
        			<%	  String isSpecialTrain = null;
        				  List trainList = requestInfoObj.getTrainDetailList();
        				  Train trainObj = null;
        				  Fare fareTrn = null;
        				  String journytypeStr = null;
        				  for(int i=0; i<trainList.size(); i++){
        					  trainObj = (Train)trainList.get(i);
        					  fareTrn = trainObj.getFareDetail();
        					  isSpecialTrain = trainObj.isSpecialTrain() ? "Yes" : "No";
        					   if(trainObj.getJournyType().equals(TravelRequestEnums.JournyType.FORWARD.getId())){
        						   journytypeStr = dbLabelBean.getLabel("label.global.outwardleg",strsesLanguage);
        					   }else if(trainObj.getJournyType().equals(TravelRequestEnums.JournyType.INTERMEDIATE.getId())){
        						   journytypeStr = dbLabelBean.getLabel("label.global.intermediateleg",strsesLanguage);
        					   }else {
        						   journytypeStr = dbLabelBean.getLabel("label.global.returnleg",strsesLanguage);
        					   }
        			%>
        			<tr>
        				<td class="reportCaption" width="12%"><%=journytypeStr %></td>
        				<td class="reportdata" width="19%"><%=trainObj.getDepartureCity() %></td>
        				<td class="reportdata" width="19%"><%=trainObj.getArrivalCity() %></td>
        				<td class="reportdata" width="10%"><%=trainObj.getDepartureDate() %></td>
        				<td class="reportdata" width="12%"><%=trainObj.getPreferredTimeType() %>&nbsp;<%=trainObj.getTiming() %></td>
        				<td class="reportdata" width="8%"><%=trainObj.getTravelClass() %></td>
        				<td class="reportdata" width="8%"><%=trainObj.getSeatPreferrence_1() %></td>
        			</tr>
				        <% 
			  	}
				    if(trainObj.getRemarks() != null && !trainObj.getRemarks().equals("") && !trainObj.getRemarks().trim().equals("-")) {
					%>
					<tr>
       					<td class="reportCaption"><%=dbLabelBean.getLabel("label.createrequest.remarks",strsesLanguage) %></td>
       					<td class="reportdata" colspan="6"><%=trainObj.getRemarks() %></td>
       				</tr>
       				<%} %>
        		</table>
        	</td>
        </tr>
        <tr>
        	<td>
        		<table width="100%" align="left" border="1" cellpadding="2" cellspacing="0" class="reporttble" bordercolor="#c7c7c5" style="border-collapse: collapse">
        		 <%if(fareTrn != null){%>
        			<tr>
          				<td height="0" colspan="10" class="reportSubHeading"><%=dbLabelBean.getLabel("label.global.fares",strsesLanguage) %></td>
        			</tr>        			 
        			<tr>
        				<td class="reportCaption" width="20%"><%=dbLabelBean.getLabel("label.global.bahncardno",strsesLanguage) %></td>
        				<td class="reportdata"><%=fareTrn.getBahnCardNo() %></td>
        				<td class="reportCaption" width="20%"><%=dbLabelBean.getLabel("label.global.discount",strsesLanguage) %></td>
        				<td class="reportdata"><%=fareTrn.getDiscount() %></td>
        				<td class="reportCaption" width="20%"><%=dbLabelBean.getLabel("label.global.class",strsesLanguage) %></td>
        				<td class="reportdata"><%=fareTrn.getFareClass() %></td>
        				<td class="reportCaption" width="20%"><%=dbLabelBean.getLabel("label.global.bahncardvaliditydate",strsesLanguage) %></td>
        				<td class="reportdata"><%=fareTrn.getValidityDate() %></td>
        				<td class="reportCaption" width="20%"><%=dbLabelBean.getLabel("label.global.onlineticket",strsesLanguage) %></td>
        				<td class="reportdata"><%=fareTrn.isOnlineTicket() ? "Yes" : "No" %></td>
        			</tr>
        			<tr>
        				<td class="reportCaption" width="20%"><%=dbLabelBean.getLabel("label.global.sparpreismitzugbindung",strsesLanguage) %></td>
        				<td class="reportdata" colspan="9"><%=isSpecialTrain %></td>
        			</tr>
        			<%} else { %>
        			<tr>
          				<td height="0" colspan="2" class="reportSubHeading"><%=dbLabelBean.getLabel("label.global.fares",strsesLanguage) %></td>
        			</tr>
        			<tr>       				
        				<td class="reportCaption" width="20%"><%=dbLabelBean.getLabel("label.global.sparpreismitzugbindung",strsesLanguage) %></td>
        				<td class="reportdata"><%=isSpecialTrain %></td>
        			</tr>
        			<% } %>
        		</table>
        	</td>
        </tr>
	      <%		  
	      }
		  %>
        <%
        if(requestInfoObj.isRentA_CarDetailExist()){
        	List carList = requestInfoObj.getCarDetailList();
        	if(carList != null && !carList.isEmpty()){
        		int setColSpan1 = 6; 
        		int setColSpan2 = 5; 
        		int setColSpan3 = 3; 
        		String carClass = "";
        		String carClassId = "";
        		Car carData = (Car)carList.get(0);
        		carClass = carData.getCarClass();
        		carClassId = carData.getCarClassId();
        		
		 		if(carClassId != null && !"".equals(carClassId) && ("26".equals(carClassId) || "27".equals(carClassId) || "29".equals(carClassId))) {
		 			setColSpan1 = 6; 
	        		setColSpan2 = 5; 
	        		setColSpan3 = 3; 
		 		} else {
		 			setColSpan1 = 5; 
	        		setColSpan2 = 4; 
	        		setColSpan3 = 2; 
				} 
        %>
        <!-- Rent a Car Detail Section Start -->
        <tr id="carDetailTR">
        	<td>
        		<table width="100%" align="left" border="1" cellpadding="2" cellspacing="0" class="reporttble" bordercolor="#c7c7c5" style="border-collapse: collapse">
        			 <tr>
          				<td height="0" colspan="<%=setColSpan1 %>" class="reportHeading"><%=dbLabelBean.getLabel("label.global.carreservation",strsesLanguage) %>&nbsp;-&nbsp;[<%=carClass %>]</td>
        			</tr>
        			<tr>
        				<td class="reportCaption" width="12%"></td>
        				<td class="reportCaption" width="10%"><%=dbLabelBean.getLabel("label.user.date",strsesLanguage) %></td>
        				<td class="reportCaption" width="20%"><%=dbLabelBean.getLabel("label.global.time",strsesLanguage) %></td>
        				<td class="reportCaption" width="28%"><%=dbLabelBean.getLabel("label.report.city",strsesLanguage) %></td>
        				<td class="reportCaption" width="18%"><%=dbLabelBean.getLabel("label.global.location",strsesLanguage) %></td>
        				<%
        					if(carClassId != null && !"".equals(carClassId) && "26".equals(carClassId)) {
        				%>
        						<td class="reportCaption" width="12%"><%=dbLabelBean.getLabel("label.global.mobilenumber",strsesLanguage) %></td>
        				<%
        					} else if(carClassId != null && !"".equals(carClassId) && ("27".equals(carClassId) || "29".equals(carClassId))) {
        				%>
        						<td class="reportCaption" width="12%"><%=dbLabelBean.getLabel("label.global.routing",strsesLanguage) %></td>
        				<%  
        					} 
        				%>
        			</tr>
        			<% 
        			String needGPS = "";
        			String carCategory = "";
        			String remarks = "";
        			for(int i=0; i<carList.size(); i++){ 
        			Car car = (Car)carList.get(i);
        			%>
        			<tr>
        				<td class="reportCaption" width="12%"><%=dbLabelBean.getLabel("label.global.start",strsesLanguage) %></td>
        				<td class="reportdata" width="10%"><%=car.getStartDate()==null ? "" : car.getStartDate()  %></td>
        				<td class="reportdata" width="20%"><%=car.getStartTime()==null ? "" : car.getStartTime()  %></td>
        				<td class="reportdata" width="28%"><%=car.getStartCity()==null ? "" : car.getStartCity()  %></td>
        				<td class="reportdata" width="18%"><%=car.getStartLocation()%></td>
        				<%
        					if(carClassId != null && !"".equals(carClassId) && "26".equals(carClassId)) {
        				%>
        						<td class="reportdata" width="12%"><%=car.getStartMobileNo()%></td>
        				<%
        					} else if(carClassId != null && !"".equals(carClassId) && ("27".equals(carClassId) || "29".equals(carClassId))) {
        				%>
        						<td class="reportdata" width="12%"><%=car.getStartRouting()%></td>
        				<%  
        					} 
        				%>        				
        			</tr>
        			<tr>
        				<td class="reportCaption" width="12%"><%=dbLabelBean.getLabel("label.global.end",strsesLanguage) %></td>
        				<td class="reportdata" width="10%"><%=car.getEndDate()==null ? "" : car.getEndDate()  %></td>
        				<td class="reportdata" width="20%"><%=car.getEndTime()==null ? "" : car.getEndTime()  %></td>
        				<td class="reportdata" width="28%"><%=car.getEndCity()==null ? "" : car.getEndCity()  %></td>
        				<td class="reportdata" width="18%"><%=car.getEndLocation()%></td>
        				<%
        					if(carClassId != null && !"".equals(carClassId) && "26".equals(carClassId)) {
        				%>
        						<td class="reportdata" width="12%"><%=car.getEndMobileNo()%></td>
        				<%
        					} else if(carClassId != null && !"".equals(carClassId) && ("27".equals(carClassId) || "29".equals(carClassId))) {
        				%>
        						<td class="reportdata" width="12%"><%=car.getEndRouting()%></td>
        				<%  
        					} 
        				%>
        			</tr>
        			<%
        			needGPS = car.isNeed_GPS() ? "Yes" : "No"  ;
        			carCategory = car.getCategory();
        			remarks = car.getRemarks();
		      	 }
        			
        			if(carClassId != null && !"".equals(carClassId) && ("26".equals(carClassId) || "27".equals(carClassId))) {
		        %>
        			<tr>
         				<td height="0" colspan="<%=setColSpan1 %>" class="reportSubHeading" style="color:#000000; background-color:#dddddd; border-top:1px solid #c7c7c5;"><%=dbLabelBean.getLabel("label.global.caroptions",strsesLanguage)%></td>
       				</tr>
        			<tr>
        				<td class="reportCaption" width="12%"><%=dbLabelBean.getLabel("label.global.needgps",strsesLanguage) %></td>
        				<td class="reportdata" width="10%"><%=needGPS%></td>
        				<td class="reportCaption" width="20%"><%=dbLabelBean.getLabel("label.global.category",strsesLanguage) %></td>
        				<td class="reportdata" colspan="<%=setColSpan3 %>" width="20%"><%=carCategory%></td>
        			</tr>
        		<%
        			}
        			if(remarks != null && !remarks.equals("") && !remarks.trim().equals("-")) {
        		%>
        			<tr>
        				<td class="reportCaption"><%=dbLabelBean.getLabel("label.createrequest.remarks",strsesLanguage) %></td>
        				<td class="reportdata" colspan="<%=setColSpan2 %>"><%=remarks %></td>
        			</tr>
        		<%
        			} 
        		%>
        		</table>
        	</td>
        </tr>
        <%} 
        }%>
        <!-- Rent a Car Detail Section End -->
        
        <!-- Accomodation Detail Section Start -->
        <%if(requestInfoObj.isAccomodationDetailExist()){ 
        	List accommodationList = requestInfoObj.getAccommodationList();
        	if(accommodationList != null && !accommodationList.isEmpty()){
        %>
        <tr id="accomodationDetailTR">
        	<td>
        		<table width="100%" align="left" border="1" cellpadding="2" cellspacing="0" class="reporttble" bordercolor="#c7c7c5" style="border-collapse: collapse">
        			 <tr>
          				<td height="0" colspan="5" class="reportHeading"><%=dbLabelBean.getLabel("label.global.accommodation",strsesLanguage) %></td>
        			</tr>
        			<tr>
        				<td class="reportCaption" width="10%">##</td>
        				<td class="reportCaption" width="15%"><%=dbLabelBean.getLabel("label.global.cityandaddress",strsesLanguage) %></td>
        				<td class="reportCaption" width="15%"><%=dbLabelBean.getLabel("label.global.accomodationtype",strsesLanguage) %></td>        				
        				<td class="reportCaption" width="15%"><%=dbLabelBean.getLabel("label.global.checkindate",strsesLanguage) %></td>
        				<td class="reportCaption" width="15%"><%=dbLabelBean.getLabel("label.global.checkoutdate",strsesLanguage) %></td>        				
        			</tr>
        			<%
        				String accomodationRemarks = null;
        				for(int i=0; i<accommodationList.size(); i++){
	        				Accommodation accommodation = (Accommodation)accommodationList.get(i);
	        				if(!accommodation.getAccommodationType().equals("0")) {
	        					accomodationRemarks = accommodation.getRemarks();
        			%>
	        			<tr>
	        				<td class="reportdata" width="10%"><%=i+1%></td>
	        				<td class="reportdata" width="15%"><%=accommodation.getPlaceOfVisit()==null ? "" : accommodation.getPlaceOfVisit()  %></td>
	        				<td class="reportdata" width="15%"><%=accommodation.getAccommodationType()  %></td>
	        				<td class="reportdata" width="15%"><%=accommodation.getCheckInDate()==null ? "" : accommodation.getCheckInDate()  %></td>
	        				<td class="reportdata" width="15%"><%=accommodation.getCheckOutDate()==null ? "" : accommodation.getCheckOutDate()  %></td>	        				
	        			</tr>
	        		
        			<% 
        				}
        			} 
        			if(accomodationRemarks != null && !accomodationRemarks.equals("") && !accomodationRemarks.trim().equals("-")) {
        			%>
        			<tr>
        				<td class="reportCaption" width="10%"><%=dbLabelBean.getLabel("label.createrequest.remarks",strsesLanguage) %></td>
        				<td class="reportdata" width="15%" colspan="4"><%=accomodationRemarks %></td>
        			</tr>
        			<% } %>
        		</table>
        	</td>
        </tr>
        <%
        	}
        }%>
         <!-- Accomodation Detail Section End -->
         
         <!-- Total Travel Fare Detail Section Start -->
        <%if(requestInfoObj.isTravelFareDetailExist()){ 
        	TravelFare travelFare = requestInfoObj.getTravelFare();
        	if(travelFare != null) {
        %>
        <tr id="travelFareDetailTR">
        	<td>
        		<table width="100%" align="left" border="1" cellpadding="2" cellspacing="0" class="reporttble" bordercolor="#c7c7c5" style="border-collapse: collapse">
        			 <tr>
          				<td height="0" colspan="5" class="reportHeading"><%=dbLabelBean.getLabel("label.createrequest.totaltravelfare",strsesLanguage)%></td>
        			</tr>
        			<tr>
        				<td class="reportCaption" width="15%"><%=dbLabelBean.getLabel("label.global.currency",strsesLanguage)%></td>
        				<td class="reportdata" width="15%"><%=travelFare.getFareCurrency() == null ? "" : travelFare.getFareCurrency()  %></td>
        				<td class="reportCaption" width="15%"><%=dbLabelBean.getLabel("label.createrequest.totalfare",strsesLanguage)%></td>
        				<td class="reportdata" width="15%"><%=travelFare.getFareAmount() == null ? "0" : travelFare.getFareAmount()   %></td>        				
        			</tr>
        		</table>
        	</td>
        </tr>
        <%
        	}
        }%>
         <!-- Total Travel Fare Detail Section End -->
         
         <!-- Passport Detail Section Start -->
         <%if(travelType.equals("I")){ 
         Passport travellerPassportInfo = traveller.getPassport();
         %>
         <tr>
        	<td>
		         <table width="100%" align="left" border="1" cellpadding="2" cellspacing="0" class="reporttble" bordercolor="#c7c7c5" style="border-collapse: collapse">
		        	<tr>
		        		<td height="0" colspan="6" class="reportHeading"><%=dbLabelBean.getLabel("label.createrequest.passportinformation",strsesLanguage) %></td>
		        	</tr>
		        	<tr>
		        		<td class="reportCaption" width="14%"><%=dbLabelBean.getLabel("label.global.firstnameasperpass",strsesLanguage) %></td>
		   				<td class="reportdata" width="18%"><%=travellerPassportInfo.getFirstName() %></td>
		   				<td class="reportCaption" width="20%"><%=dbLabelBean.getLabel("label.global.lastnameasperpass",strsesLanguage) %></td>
		   				<td class="reportdata" width="18%"><%=travellerPassportInfo.getLastName() %></td>
		   				<td class="reportCaption" width="12%"><%=dbLabelBean.getLabel("label.requestdetails.dob",strsesLanguage) %></td>
		   				<td class="reportdata" width="18%"><%=travellerPassportInfo.getDateOfBirth() %></td>
		        	</tr>
		        	<tr>		        		
		   				<td class="reportCaption" width="14%"><%=dbLabelBean.getLabel("label.createrequest.passportnumber",strsesLanguage) %></td>
		   				<td class="reportdata" width="18%"><%=travellerPassportInfo.getPassportNo() %></td>		        	
		        		<td class="reportCaption" width="20%"><%=dbLabelBean.getLabel("label.user.nationality",strsesLanguage) %></td>
		   				<td class="reportdata" width="18%"><%=travellerPassportInfo.getNationality() %></td>
		   				<td class="reportCaption" width="12%"><%=dbLabelBean.getLabel("label.createrequest.placeofissue",strsesLanguage) %></td>
		   				<td class="reportdata" width="18%"><%=travellerPassportInfo.getPlaceOfIssue() %></td>
		        	</tr>
		        	<tr>
		        		<td class="reportCaption" width="14%"><%=dbLabelBean.getLabel("label.global.dateofissue",strsesLanguage) %></td>
		   				<td class="reportdata" width="18%"><%=travellerPassportInfo.getDateOfIssue() %></td>
		   				<td class="reportCaption" width="20%"><%=dbLabelBean.getLabel("label.global.dateofexpiry",strsesLanguage) %></td>
		   				<td class="reportdata" width="18%"><%=travellerPassportInfo.getDateOfExpiry() %></td>		   			
		   				<td class="reportCaption" width="12%"><%=dbLabelBean.getLabel("label.global.visaexists",strsesLanguage) %></td>
		   			 	<td class="reportdata" width="18%"><%=travellerPassportInfo.isVisaExists() ? "Yes" : "No" %></td>
		        	</tr>
		        </table>
		     </td>
		 </tr>
         <%} %>
         <!-- Passport Detail Section End -->       
        <!-- Billing Instruction Section Start -->
        <%
        Approver billingApprover = requestInfoObj.getBillingApprover();
			if(billingApprover != null ){  
        %>
        <tr id="billingInstTR">
        	<td>
        		<table width="100%" align="left" border="1" cellpadding="2" cellspacing="0" class="reporttble" bordercolor="#c7c7c5" style="border-collapse: collapse">
        			 <tr>
          				<td height="0" colspan="4" class="reportHeading" style="border-bottom:1px solid #e8e8e8;"><%=dbLabelBean.getLabel("label.global.billinginstructions",strsesLanguage) %></td>
        			</tr>
        			<tr>
        				<tr>
				          <td height="0" class="reportCaption" width="25%"><%=dbLabelBean.getLabel("label.requestdetails.billingclient",strsesLanguage) %> </td>
				          <td height="0" class="reportdata" width="25%"><%=billingApprover.getUnitName()%></td>
				          <td height="0" class="reportCaption" width="25%"><%=dbLabelBean.getLabel("label.requestdetails.billingapprover",strsesLanguage) %></td>
				          <td height="0" class="reportdata" width="25%"><%=billingApprover.getName() %></td> 
				        </tr>
        			</tr>
        		</table>
        	</td>
        </tr>
        <%} %>
         <!-- Billing Instruction Section End -->
         <!-- Approval Level Section Start -->
        <%
        List approverLevelList = requestInfoObj.getApproverLevels();
        Approver appLevel1 = null;
		Approver appLevel2 = null;
		if(approverLevelList != null && !approverLevelList.isEmpty() && (approverLevelList.size() == 2)){  
			appLevel1 = (Approver)approverLevelList.get(0);
			appLevel2 = (Approver)approverLevelList.get(1);
		}
		%>
		<tr>
        	<td>
        		<table width="100%" align="left" border="1" cellpadding="2" cellspacing="0" class="reporttble" bordercolor="#c7c7c5" style="border-collapse: collapse">
			        <tr>
			          <td height="0" colspan="4" class="reportHeading"><%=dbLabelBean.getLabel("label.requestdetails.approvers",strsesLanguage) %></td>
			        </tr>
			        <tr>
			          <td height="0" class="reportCaption" width="25%"><%=dbLabelBean.getLabel("label.global.approvallevel1",strsesLanguage) %> </td>
			          <td height="0" class="reportdata" width="25%"><%=("-".equals(appLevel1.getName()) ? "Not Applicable" : appLevel1.getName())%></td>
			          <td height="0" class="reportCaption" width="25%"><%=dbLabelBean.getLabel("label.global.approvallevel2",strsesLanguage) %> </td>
			          <td height="0" class="reportdata" width="25%"><%=("-".equals(appLevel2.getName()) ? "Not Applicable" : appLevel2.getName())%></td>
			        </tr>					
				</table>
			</td>
		</tr>	
        <!-- Approval Level Section End -->
	 <tr>
	 <td>
	<table width="100%" align="left" border="1" cellpadding="2" cellspacing="0" class="reporttble" bordercolor="#c7c7c5" style="border-collapse: collapse">
	  <tr> 
	    <td colspan="5" class="reportHeading"><%=dbLabelBean.getLabel("label.requestdetails.approverslist",strsesLanguage) %></td>
	  </tr>
	  <tr> 
	    <td width="4%" class="reportCaption" nowrap="nowrap"><%=dbLabelBean.getLabel("label.global.sno",strsesLanguage) %></td>
	    <td width="30%" class="reportCaption"><%=dbLabelBean.getLabel("label.requestdetails.name",strsesLanguage) %></td>
	    <td width="30%" class="reportCaption"><%=dbLabelBean.getLabel("label.global.designation",strsesLanguage) %></td>
	    <td width="16%" class="reportCaption" style="text-align: center"><%=dbLabelBean.getLabel("label.requestdetails.status",strsesLanguage) %></td>
	    <td width="20%" class="reportCaption"><%=dbLabelBean.getLabel("label.requestdetails.approvaldatetime",strsesLanguage) %></td>    
	</tr>
	<%
	  String strApproveStatus		    	=	"";
	  int iLoop							    =	1;
	  String strMsg							=	"";
	  String strImg							=	"Red";
	 
	  List approverList = requestInfoObj.getApprovers();
	  Approver approver = null;
	  for(int i=0; i<approverList.size(); i++)
	  {  
		  iLoop = i+1;
		  approver = (Approver)approverList.get(i);
	    strApproveStatus    	=	approver.getApproveStatus();
	    
	  //added by Manoj Chand on 28 March 2012 to show Current Pending request with red p.
	    if(strApproveStatus.equals("0") && !strImg.equalsIgnoreCase("Red"))
   	    {
   			strApproveStatus="<img src=images/cross.gif border=0>";
   	    }
   	    else if(strApproveStatus.equals("0") && strImg.equalsIgnoreCase("Red"))
   	    {
   			strApproveStatus="<img src=images/mark.gif border=0>";
   			strImg="black";
   	    }
	    else if(strApproveStatus.equals("4"))
	    {
	  		strApproveStatus= "<font color=red>"+dbLabelBean.getLabel("label.requestdetails.rejected",strsesLanguage)+" </font>";
	  		strImg="black";
	    }
	    else if(strApproveStatus.equals("3"))
	    {
			strApproveStatus="<font color=red>"+dbLabelBean.getLabel("label.requestdetails.returned",strsesLanguage)+" </font>";
			strImg="black";
	    }
		else if(strApproveStatus.equals("6"))
	    {
			strApproveStatus="<font color=red>"+dbLabelBean.getLabel("label.requestdetails.cancelled",strsesLanguage) +" </font>";
			strImg="black";
	    }
	    else
	    {
			strApproveStatus="<img src=images/tick.gif border=0>";
	    }
		
		if(approver.getOriginalApprover().equals("0") )
		{	
			strMsg="";
		}else
		 {
		  strMsg="<font color=red >("+dbLabelBean.getLabel("label.requestdetails.onbehalfof",strsesLanguage)+ " "+approver.getOriginalApprover()+")</font>";		
		}
	%>
	    <tr> 
	      <td width="4%" class="reportdata" style="text-align: center;"><%=iLoop++%></td>
	      <td width="30%" class="reportdata"><%=approver.getName()%> <%=strMsg%></td>
	      <td width="30%" class="reportdata"><%=approver.getDesignationName()%> </td>
	      <td width="16%" class="reportdata" style="text-align: center;"><%=strApproveStatus%> </td>
	<%	
		  if(strApproveStatus.equals("<img src=images/tick.gif border=0>"))
		  {
			  String apprvTime = (approver.getApproveTime() == null || approver.getApproveTime().trim().equals(""))? "": "  "+approver.getApproveTime().trim();
	%>
				<td width="20%"  class="reportdata"><%=approver.getApproveDate().trim()%><%=apprvTime%></td>
	<% 
		  } 
	      else
		  { 
	%>
				<td width="20%"  class="reportdata">-</td> 
	<%    } %>
	 </tr>
	<%
	}	
	%>
	</table>
	<tr>
	<td>
	<table width="100%" align="left" border="1" cellpadding="2" cellspacing="0" class="reporttble" bordercolor="#c7c7c5" style="border-collapse: collapse">
	  <tr>
	    <td colspan="4" class="reportHeading"><%=dbLabelBean.getLabel("link.approverequest.comments",strsesLanguage) %></td>
	  </tr>	
	  <tr>
	    <td class="reportCaption" width="4%" align="left" nowrap="nowrap"><%=dbLabelBean.getLabel("label.global.sno",strsesLanguage) %></td>
		<td class="reportCaption" width="46%" align="left"><%=dbLabelBean.getLabel("link.approverequest.comments",strsesLanguage) %></td>
		<td class="reportCaption" width="30%" align="left"><%=dbLabelBean.getLabel("label.global.postedby",strsesLanguage) %></td>
		<td class="reportCaption" width="20%" style="border-right:0;"><%=dbLabelBean.getLabel("label.global.postedon",strsesLanguage) %></td>
	  </tr>
	<%
		 List approversCommentList = dao.getApproversComment(strTravelId, travelType, "APPROVE");
		 if(approversCommentList != null && !approversCommentList.isEmpty())
		 {
			for(int i=0; i<approversCommentList.size(); i++)
			 {
				Comment comment = (Comment)approversCommentList.get(i);
	         	 if (iCls%2 == 0) { 
	        		strStyleCls="formtr2";
	             } else { 
	    		 strStyleCls="formtr1";
	             } 
	      	     iCls++;
	%>
					<tr class="<%=strStyleCls%>">
						<td class="reportdata" width="4%" style="text-align: center;" ><%=i+1%></td>
						<td class="reportdata" width="46%" align="left" ><%=comment.getComment()%></td>
						<td class="reportdata" width="30%" align="left" ><%=comment.getPostedByName()%></td>
						<td class="reportdata" width="20%" style="border-right:0;"><%=comment.getPostedOnDate()%></td>
					</tr>
	<%
			 }
		 }
	%>
	</table>
	</td>
	</tr>
	<!--@ 23/Mar/2007 Vijay Display the Cancellation  Comments in report -->
	<tr>
	<td>
	<table width="100%"  align="left" border="1" cellpadding="2" cellspacing="0" class="reporttble" bordercolor="#c7c7c5" style="border-collapse: collapse">
		<tr>
		 <td colspan="4" class="reportHeading"><%=dbLabelBean.getLabel("label.global.cancellationcomment",strsesLanguage) %> </td>
		</tr>
		<tr>
			<td class="reportCaption" width="4%" align="left" valign="top" nowrap="nowrap"><%=dbLabelBean.getLabel("label.global.sno",strsesLanguage) %></td>
			<td class="reportCaption" width="46%" align="left" valign="top"><%=dbLabelBean.getLabel("link.approverequest.comments",strsesLanguage) %></td>
			<td class="reportCaption" width="30%" align="left" valign="top"><%=dbLabelBean.getLabel("label.global.postedby",strsesLanguage) %></td>
			<td class="reportCaption" width="20%"><%=dbLabelBean.getLabel("label.global.postedon",strsesLanguage) %></td>
	  </tr>
	<% 
	List approversCancellationCommentList = dao.getApproversComment(strTravelId, travelType, "CANCEL");
	 if(approversCancellationCommentList != null && !approversCancellationCommentList.isEmpty())
	 {
		for(int i=0; i<approversCancellationCommentList.size(); i++)
		 {
			Comment cancelComment = (Comment)approversCancellationCommentList.get(i);
	%>
	<%
	         		if (iCls%2 == 0) { 
	        				strStyleCls="formtr2";
					} else { 
	    				strStyleCls="formtr1";
					} 
					iCls++;
	%>
					<tr class="<%=strStyleCls%>">
						<td class="reportdata" width="4%" style="text-align: center;" valign="top"><%=i+1%></td>
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
	<!-- END MODIFICATION--> 
	</table>
	
	<table width="100%" align="left" border="0" cellpadding="0" cellspacing="0">	
		<tr>
			<td> 
				<div id="sub5">
					<table width="98%" align="center" border="0" cellpadding="5"  cellspacing="1" class="formborder" >
						<%
							String strSql5 = "SELECT TRAVEL_STATUS_ID FROM  T_TRAVEL_STATUS WHERE  (TRAVEL_ID = "
									+ strTravelId + ") AND (TRAVEL_TYPE = 'i')  AND (STATUS_ID = 10)";
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
					          <td height="0" class="listhead">&nbsp;<a href="#" class="reportLink" onClick="MM_openBrWindow('reqlermsDetails.jsp?purchaseRequisitionId=<%=strTravelId%>&travel_type=I','Attachments','scrollbars=yes,resizable=yes,width=650,height=600')"><%=dbLabelBean.getLabel("label.requestdetails.clickheretoopenlermsdetail",strsesLanguage) %></td>
					        </tr>
				        <%
				        	}
							 dbConBean.close();   //close all connection
				        %>
							<tr class="formhead1" height="5"> 
								<td   class="reportHeading" align="center">
								   <p    align=center><%=dbLabelBean.getLabel("label.requestdetails.clickonmailicontoviewmailflow",strsesLanguage) %>
								    <a href="#" onClick="MM_openBrWindow('T_travelRequisitionMails.jsp?travelReqNo=<%=requestInfoObj.getRequisitionNo()%>','REQMAILS','scrollbars=yes,resizable=yes,width=775,height=250')"><IMG SRC="images/EMAILIMG.gif?buildstamp=2_0_0" border=0 alt="<%= dbLabelBean.getLabel("label.requestdetails.viewemails",strsesLanguage)%>"></a>
								  </p>
								</td>
							</tr>
					 </table>
				 </div>
			</td>
		</tr>
	</table>
	<%} %>
	</body>
	</html>