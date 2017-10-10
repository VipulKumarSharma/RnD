<html>
<head>
	<%@ page pageEncoding="UTF-8" %>
	<%@ include file="importStatement.jsp"%>
	<%@ include file="cacheInc.inc"%>
	<%@ include file="headerIncl.inc"%>
	<%@ include file="application.jsp"%>
	<%-- <%@ include  file="systemStyle.jsp" %> --%>
	
	<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
	<jsp:useBean id="dbConBean1" scope="page" class="src.connection.DbConnectionBean" />
	<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
	
	<link type="text/css" rel="stylesheet" href="scripts/main.css?buildstamp=2_0_0">
	<link type="text/css" rel="stylesheet" href="style/sortable.css?buildstamp=2_0_0">
</head>
	
	<%!
		String dbDateFormat(String str) {	
			if(str != "") {	
				String[] parts	= (str.trim()).split("/");
				str 			= parts[2]+"-"+parts[1]+"-"+parts[0];
			}
			else {	
				str			= "";
			}
			return str;
		}
	%>
	
	<%
	String isMATA_GmbH 				= (String)hs.getValue("isMataGmbHSite");
	
	int rowCount					= 10;
	boolean reportDataFlag 			= false;
	ResultSet rs                    = null;
	
	String strFrom                  = "";
	String strTo                    = "";
	String strTravelType            = "";
	String strDestination           = "";
	String strTotalReq	            = "";
	String strTableName	            = "";
	String strUnitHidden            = "";
	String strSelectUnit            = "";
	
	String strtraveltype            = ""; 
	String strSql	                = ""; 
	String strSitename              = "";
	String userID					= "";
	String strReq_no				= "";
	String strReturnDate			= "";	
	
	String strTraveler		    	= "";
	String strCreationDate			= "";
	String strTravelDate			= "";
	String strTravelfrom			= "";
	String strTravel_to				= "";
	String strTravel_status_id   	= "";
	String strIntermediateDesc		= "";
	
	String strCondition 			= "";
	String strCondition1 			= "";
	String strBillingSite 			= "";
	String strTransitDays 			= "";
	String strTravelClass 			= "";
	String strTES		  			= "";
	String strCO					= "";
	String strCurr					= "";
	String strTravelStatus  		= "";
	String strLevel         		= "";
	String trvlType					= "";
	String strHidCurr				= "";
	
	String strTESShowFlag			= "N";
	String loadFlag 				= "";
	
	strFrom                			= request.getParameter("from");
	strTo                  			= request.getParameter("to");
	strTravelType          			= request.getParameter("travelType");
	strUnitHidden          			= request.getParameter("UnitHidden");
	userID                 			= request.getParameter("username");
	strSelectUnit          			= request.getParameter("SelectUnit");
	
	strBillingSite		   			= request.getParameter("chk_billingsite")==null?"n":request.getParameter("chk_billingsite");
	strTransitDays		   			= request.getParameter("chk_transitdays")==null?"n":request.getParameter("chk_transitdays");
	strTravelClass		   			= request.getParameter("chk_travelClass")==null?"n":request.getParameter("chk_travelClass");
	
	strTES		  		   			= request.getParameter("chk_tes")==null  ? "n" : request.getParameter("chk_tes");
	strCO 				   			= request.getParameter("chk_co") == null? "n": request.getParameter("chk_co");
	strCurr 			   			= request.getParameter("currency") == null? "1": request.getParameter("currency");
	strTravelStatus		   			= request.getParameter("travelStatus") == null? "1": request.getParameter("travelStatus");
	strHidCurr			   			= (request.getParameter("hidCurrency") == null || request.getParameter("hidCurrency").equals(""))? "INR": request.getParameter("hidCurrency");
	
	trvlType						= strTravelType;
	
	if (strTravelStatus.equals("1")) {
		strTravelStatus = "2,3,4,6,10";
	}
	
	if (strBillingSite.equalsIgnoreCase("y")) {
		strLevel = strLevel + "BS";
	}
	if (strBillingSite.equalsIgnoreCase("y")) {
		strLevel = strLevel + "TD";
	}
	if (strTravelClass.equalsIgnoreCase("y")) {
		strLevel = strLevel + "TC";
	}
	if (strCO.equalsIgnoreCase("y")) {
		strLevel = strLevel + "CO";
	}
	
	strUnitHidden 	= strSelectUnit;
	
	if(strUnitHidden.equals("0")) 	{
		strSitename=dbLabelBean.getLabel("label.report.forallunits",strsesLanguage);
	
	} else {
		 strSql="select isnull(dbo.sitename("+strUnitHidden+"),'') as sitename from M_site where status_id=10" ;  
		 rs = dbConBean.executeQuery(strSql);
		 while (rs.next()) {
			strSitename=rs .getString("sitename");  
		 }
		 rs.close();
		 strSitename= " in " + strSitename;   
	} 
	
	if(strTravelType.equals("I")) {
		 strtraveltype=dbLabelBean.getLabel("label.report.international",strsesLanguage);
		 
		 if(ssflage.equals("3")) {
			 strtraveltype = "Intercont";
		 }
	}
	if(strTravelType.equals("D")) {
		 strtraveltype=dbLabelBean.getLabel("label.report.domestic",strsesLanguage);
		 if(ssflage.equals("3")){
			 strtraveltype = "Domestic/Europe";
		 }
	}
	if(strTravelType.equals("A")) {
		strtraveltype=dbLabelBean.getLabel("label.report.domesticandinternational",strsesLanguage);
		if(ssflage.equals("3")){
			strtraveltype = "Domestic/Europe and Intercont";
		}
	}
			 
 	strSql	= "SELECT CASE WHEN YEAR(TES_CUTTOFF_DATE)<>1900 THEN 'Y' ELSE 'N' END AS SHOW_FLAG FROM M_SITE WHERE SITE_ID ="+strUnitHidden;
 	rs 		= dbConBean.executeQuery(strSql);
    while (rs.next()) {
      	strTESShowFlag= (rs.getString("SHOW_FLAG")==null || rs.getString("SHOW_FLAG").equals(""))? "N":rs.getString("SHOW_FLAG").trim();  
	}                
	rs.close();
	
	%>
	
<body style="overflow:hidden;">
	
	<form method=post name=frm action="T_travelDateWiseReportPost.jsp">
		<input type=hidden name=va>
		<input type="hidden" name="flag" id="flag" value="N">
		<script type="text/javascript" language="JavaScript1.2"	src="menu/menu_cnt.js?buildstamp=2_0_0"></script>
		
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
		  	<tr>
				<td width="88%" height="35" class="bodyline-top" nowrap="nowrap">
		 	  		<ul class="pagebullet"><li class="pageHead" id="reportTitle"><b> <%=dbLabelBean.getLabel("submenu.reports.travelreport",strsesLanguage) %> >> <%=strtraveltype %>  <%=dbLabelBean.getLabel("label.report.travelrequisitions",strsesLanguage) %> <%=strSitename %>  (<%=dbLabelBean.getLabel("label.report.departuredatebetween",strsesLanguage) %>  <%=strFrom %>  - <%=strTo %>) </b></li></ul>
				</td>
				<td height="35" style="valign: bottom;" class="bodyline-top" nowrap="nowrap">
					<ul id="list-nav">
						<li><a href="#" onClick="write1();"><%=dbLabelBean.getLabel("label.report.exporttoexcel",strsesLanguage) %></a></li>
						<li><a href="T_traveldateWiseReport.jsp?SelectUnit=<%=strSelectUnit %>&username1=<%=userID %>&travelType1=<%=strTravelType %>&from1=<%=strFrom %>&to1=<%=strTo %>&chk_billingsite1=<%=strBillingSite %>&chk_transitdays1=<%=strTransitDays %>&chk_travelClass1=<%=strTravelClass %>&chk_tes=<%=strTES%>&chk_co=<%=strCO%>&currency=<%=strCurr%>&travelStatus=<%=strTravelStatus%>&hidCurrency=<%=strHidCurr%>"><%=dbLabelBean.getLabel("button.global.back",strsesLanguage) %></a></li>
					</ul>
				</td>
		  	</tr>
		</table>
	
		<div id="scrollableDiv" align="center" style="width:100%; left:1px; height:93%; position: absolute; overflow: auto;overflow-x: auto;">
		
			<table id="travelReportData" width="98%" border="0" cellpadding="5" cellspacing="1" class="sortable">
		  		<thead>
				  	<tr>
						<th width="2%" nowrap="nowrap" class="sorttable_nosort" style="cursor: default;"><%=dbLabelBean.getLabel("label.global.sno",strsesLanguage)%></th>
					 
					 	<th width="8%" nowrap="nowrap" title="Sort by <%=dbLabelBean.getLabel("label.search.requisitionno",strsesLanguage)%>"><%=dbLabelBean.getLabel("label.search.requisitionno",strsesLanguage)%></th>
					 
					 	<th width="8%" nowrap="nowrap" title="Sort by <%=dbLabelBean.getLabel("label.global.travelername",strsesLanguage)%>"><%=dbLabelBean.getLabel("label.global.travelername",strsesLanguage)%></th>
					 
					 	<th width="8%" nowrap="nowrap" title="Sort by Creation Date">Creation Date</th>
					 	
					 	<th width="8%" nowrap="nowrap" title="Sort by <%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>"><%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%></th>
					 
					 	<th width="12%" nowrap="nowrap" title="Sort by <%=dbLabelBean.getLabel("label.global.intermediatedestinations",strsesLanguage)%>"><%=dbLabelBean.getLabel("label.global.intermediatedestinations",strsesLanguage)%></th>
					 
					 	<th width="8%" nowrap="nowrap" title="Sort by <%=dbLabelBean.getLabel("label.report.returndate",strsesLanguage)%>"><%=dbLabelBean.getLabel("label.report.returndate",strsesLanguage)%></th>
					 
					 	<th width="8%" nowrap="nowrap" title="Sort by <%=dbLabelBean.getLabel("label.report.traveldays",strsesLanguage)%>"><%=dbLabelBean.getLabel("label.report.traveldays",strsesLanguage)%></th>
					 
					 	<th width="8%" nowrap="nowrap" title="Sort by <%=dbLabelBean.getLabel("label.global.totalamount",strsesLanguage)%>"><%=dbLabelBean.getLabel("label.global.totalamount",strsesLanguage)%></th>
					 
				<%	if(strBillingSite.trim().equalsIgnoreCase("y")) { 
						++rowCount;
				%>	 	<th width="8%" nowrap="nowrap" title="Sort by <%=dbLabelBean.getLabel("label.report.billingsite",strsesLanguage)%>"><%=dbLabelBean.getLabel("label.report.billingsite",strsesLanguage)%></th>
				
				<%	} if(strTransitDays.trim().equalsIgnoreCase("y")) { 
						++rowCount;
				%>	 	<th width="8%" nowrap="nowrap" title="Sort by <%=dbLabelBean.getLabel("label.report.transitdays",strsesLanguage)%>"><%=dbLabelBean.getLabel("label.report.transitdays",strsesLanguage)%></th>
				
				<%	} if(strTravelClass.trim().equalsIgnoreCase("y")) { 
						++rowCount;
				%>	 	<th width="8%" nowrap="nowrap" title="Sort by <%=dbLabelBean.getLabel("label.report.clicktosortaccordingtotravelclass",strsesLanguage)%>"><%=dbLabelBean.getLabel("label.report.clicktosortaccordingtotravelclass",strsesLanguage)%></th>
				<%	} %>
						
						<th width="8%" nowrap="nowrap" title="Sort by <%=dbLabelBean.getLabel("label.mail.requisition",strsesLanguage)%><%=dbLabelBean.getLabel("label.requestdetails.status",strsesLanguage)%>"><%=dbLabelBean.getLabel("label.mail.requisition",strsesLanguage)%><%=dbLabelBean.getLabel("label.requestdetails.status",strsesLanguage)%></th>
				
				<%	if((SuserRole.trim().equals("AD") || SuserRole.trim().equals("AC")) && strTESShowFlag.trim().equalsIgnoreCase("Y")) { 
						rowCount += 2;
				%>	 	<th width="8%" nowrap="nowrap" title="Sort by <%=dbLabelBean.getLabel("label.report.tesstatus",strsesLanguage)%>"><%=dbLabelBean.getLabel("label.report.tesstatus",strsesLanguage)%></th>
					 	<th width="8%" nowrap="nowrap" title="Sort by <%=dbLabelBean.getLabel("label.report.tesreason",strsesLanguage)%>"><%=dbLabelBean.getLabel("label.report.tesreason",strsesLanguage)%></th>
				
				<%	} if(strCO.trim().equalsIgnoreCase("y")) { 
						rowCount += 5;
				%>		<th nowrap="nowrap" title="Sort by <%=dbLabelBean.getLabel("label.global.travelallowance",strsesLanguage)%>"><%=dbLabelBean.getLabel("label.global.travelallowance",strsesLanguage)%></th>
						<th nowrap="nowrap" title="Sort by <%=dbLabelBean.getLabel("label.global.dailycharges",strsesLanguage)%>"><%=dbLabelBean.getLabel("label.global.dailycharges",strsesLanguage)%></th>
						<th nowrap="nowrap" title="Sort by <%=dbLabelBean.getLabel("label.global.contigencies",strsesLanguage)%>"><%=dbLabelBean.getLabel("label.global.contigencies",strsesLanguage)%></th>
						<th nowrap="nowrap" title="Sort by <%=dbLabelBean.getLabel("label.travelreport.otherexp",strsesLanguage)%>"><%=dbLabelBean.getLabel("label.travelreport.otherexp",strsesLanguage)%></th>
						<th nowrap="nowrap" title="Sort by <%=dbLabelBean.getLabel("label.travelreport.totalcontingencyamount",strsesLanguage)%>"><%=dbLabelBean.getLabel("label.travelreport.totalcontingencyamount",strsesLanguage)%> [ <%=strHidCurr %> ]</th>
				<%	} %>
					</tr>
				</thead>
				
				<tbody>
		<%
			int index                       =       0;
			Connection con					=		null;			    // Object for connection
			CallableStatement cstmt			=		null;			// Object for Callable Statement
			con 							= dbConBean.getConnection();
					
			String dateFrom 				= dbDateFormat(strFrom.trim());
			String dateTo					= dbDateFormat(strTo.trim());		
					
			int iCls 						= 0;
			int sn							= 1;
			
			String sqlStr 					= "";
			String strStyleCls 				= "";
			String strEmployee				= "";
			String strGroupTravelFlag		= "";
			String strTravelAgencyTypeId	= "";
			String strTravelDays			= "";
			String strDetailPageUrl			= "";	
			String strtravelid				= "";
			String strtravelerId 			= "";
			String totalAmount				= "";
			String currency 				= "";
			String strBillingUnit			= "";
			String strDays					= "";
			String strTESFlag				= "";
			String strTESRemarks			= "";
			String strReqStatusFlag			= "";
			String strClass					= "";
			String strReasonForTravel		= "";
			String strTravelAllowances		= "";
			String strDailyCharges			= "";
			String strContingencies			= "";
			String strOtherExp				= "";
			String strTotalBaseCurr			= "";
			
			try 
			{		
				cstmt = con.prepareCall("{call PROC_TRAVEL_REPORT(?,?,?,?,?,?,?,?,?,?)}");
				cstmt.setInt(++index, Integer.parseInt(userID.trim()));
				cstmt.setInt(++index, Integer.parseInt(strSelectUnit.trim()));
				cstmt.setString(++index, dateFrom);
				cstmt.setString(++index, dateTo); 
				cstmt.setString(++index, trvlType.trim());
				cstmt.setString(++index, strTravelStatus.trim());
				cstmt.setString(++index, strCurr.trim());
				cstmt.setInt(++index, Integer.parseInt(Suser_id));
				cstmt.setString(++index, strLevel.trim());
				cstmt.registerOutParameter(++index,java.sql.Types.INTEGER);
				rs = cstmt.executeQuery();
				
				while (rs.next()) {	  
					strReq_no				= (rs.getString("TRAVEL_REQ_NO") == null || rs.getString("TRAVEL_REQ_NO").equals(""))? "-":rs.getString("TRAVEL_REQ_NO").trim();
					strtravelid				= (rs.getString("TRAVEL_ID") == null || rs.getString("TRAVEL_ID").equals(""))? "-":rs.getString("TRAVEL_ID").trim();	
					strTraveler				= (rs.getString("TRAVELLER") == null || rs.getString("TRAVELLER").equals(""))? "-":rs.getString("TRAVELLER").trim();
					strCreationDate			= (rs.getString("CREATION_DATE") == null || rs.getString("CREATION_DATE").equals(""))? "-":rs.getString("CREATION_DATE").trim();
					strTravelDate			= (rs.getString("TRAVEL_DATE") == null || rs.getString("TRAVEL_DATE").equals(""))? "-":rs.getString("TRAVEL_DATE").trim(); 
					strIntermediateDesc		= (rs.getString("INTERMEDIATE") == null || rs.getString("INTERMEDIATE").equals(""))? "-":rs.getString("INTERMEDIATE").trim();
					strTravel_status_id   	= (rs.getString("TRAVEL_STATUS_ID") == null || rs.getString("TRAVEL_STATUS_ID").equals(""))? "-":rs.getString("TRAVEL_STATUS_ID").trim();
					strReturnDate         	= (rs.getString("RETURN_DATE") == null || rs.getString("RETURN_DATE").equals(""))? "-":rs.getString("RETURN_DATE").trim();
					strTravelDays         	= (rs.getString("travel_Days") == null || rs.getString("travel_Days").equals("")) ? "-":rs.getString("travel_Days").trim();
					strGroupTravelFlag    	= (rs.getString("Group_Travel_Flag").trim() == null || rs.getString("Group_Travel_Flag").equals("")) ? "-":rs.getString("Group_Travel_Flag").trim();
					strTravelAgencyTypeId	= (rs.getString("travel_agency_id") == null || rs.getString("travel_agency_id").equals("")) ? "-":rs.getString("travel_agency_id").trim();
					strtravelerId         	= (rs.getString("TRAVELLER_ID") == null || rs.getString("TRAVELLER_ID").equals("")) ? "-":rs.getString("TRAVELLER_ID").trim();
					strReasonForTravel 		= (rs.getString("REASON_FOR_TRAVEL") == null || rs.getString("REASON_FOR_TRAVEL").equals("")) ? "-":rs.getString("REASON_FOR_TRAVEL").trim();
					totalAmount				= (rs.getString("curr") == null || rs.getString("curr").equals(""))? "-":rs.getString("curr").trim();
				 	strTravelType			= (rs.getString("Travel_Type") == null  || rs.getString("Travel_Type").equals(""))? "-":rs.getString("Travel_Type").trim();
				 	strTESFlag 				= (rs.getString("TES_FLAG") == null  || rs.getString("TES_FLAG").equals(""))? "-":rs.getString("TES_FLAG").trim();
				 	strTESRemarks 			= (rs.getString("TES_REMARKS") == null || rs.getString("TES_REMARKS").equals(""))? "-":rs.getString("TES_REMARKS").trim();
					
				 	if(strCO.trim().equalsIgnoreCase("y")) { 
				  		strTravelAllowances	= rs.getString("TRAVELALLOWANCE") == null ? "-":rs.getString("TRAVELALLOWANCE").trim();
				  		strDailyCharges		= rs.getString("DAILYCHARGES") == null ? "-":rs.getString("DAILYCHARGES").trim();
				  		strContingencies	= rs.getString("CONTINGENCIES") == null ? "-":rs.getString("CONTINGENCIES").trim();
				  		strOtherExp			= rs.getString("OTHEREXP") == null ? "-":rs.getString("OTHEREXP").trim();
				  		strTotalBaseCurr	= rs.getString("TOTAL_BASE_CURRENCY") == null ? "-":rs.getString("TOTAL_BASE_CURRENCY").trim();
				  	}
				 	
				 	if(strBillingSite.equalsIgnoreCase("y")) {
				 		strBillingUnit		= (rs.getString("Billing_Unit") == null  || rs.getString("Billing_Unit").equals(""))? "-":rs.getString("Billing_Unit").trim();
				 	}
				 	
				 	if(strTransitDays.equalsIgnoreCase("y")) {
				 		strDays				= (rs.getString("Days") == null  || rs.getString("Days").equals(""))? "-":rs.getString("Days").trim();
				 	}
				 	
				 	if(strTravelClass.equalsIgnoreCase("y")) {
				 		strClass 			= (rs.getString("TRAVEL_CLASS") == null  || rs.getString("TRAVEL_CLASS").equals(""))? "-":rs.getString("TRAVEL_CLASS").trim();
				 	}
				 	
					if(!strCreationDate.equalsIgnoreCase("-")) {
						String creationYear 	= strCreationDate.substring(0, 4);
						String creationMonth	= strCreationDate.substring(5, 7);
						String creationDay		= strCreationDate.substring(8, 10);
						strCreationDate			= creationDay+"/"+creationMonth+"/"+creationYear;
					}
					
					if(!strTravelDate.equalsIgnoreCase("-")) {
						String year 			= strTravelDate.substring(0, 4);
						String month			= strTravelDate.substring(5, 7);
						String day				= strTravelDate.substring(8, 10);
						strTravelDate			= day+"/"+month+"/"+year;
					}
					
					if (!strReturnDate.equals("-")){
						String year1 			= strReturnDate.substring(0, 4);
						String month1			= strReturnDate.substring(5, 7);
						String day1				= strReturnDate.substring(8, 10);
						strReturnDate			= day1+"/"+month1+"/"+year1;
					}
					          
					if(strTravelDays.equals("0")) {
					  	strTravelDays         ="-";
					}
	
					if (strTravel_status_id.equals("10")) {
						strTravel_status_id ="<font color=#33CC00><b>"+dbLabelBean.getLabel("label.search.approvedbyall",strsesLanguage)+"</b></font>";
						strReqStatusFlag = "A";
					}
					
					if (strTravel_status_id.equals("2")) {
						strTravel_status_id ="<font color=red><b>"+dbLabelBean.getLabel("label.search.pending",strsesLanguage)+"</b></font>";
						strReqStatusFlag = "P";
					}
					   
					if (strTravel_status_id.equals("11")) {
					  	strTravel_status_id ="<font color=#f08012><b>"+dbLabelBean.getLabel("label.search.expired",strsesLanguage)+"</b></font>";
					  	strReqStatusFlag = "P";
					}
		
				 	if (iCls % 2 == 0) {
						strStyleCls = "oddRow";
				    } else {
					   	strStyleCls = "evenRow";
				  	}
				 	
				 	if(strGroupTravelFlag.equals("Y")) {
				 		if(strTravelType.equals("I")) {
	         	        	strDetailPageUrl = "Group_T_TravelRequisitionDetails.jsp";  
	    				} else {
	    					strDetailPageUrl = "Group_T_TravelRequisitionDetails_D.jsp";	
	    				}
	         	   		strTraveler="Group/Guest Travel";
	         	  		
	         	   		if(strTravelAgencyTypeId != null && strTravelAgencyTypeId.equals("2")) {
					   		strDetailPageUrl = "Group_T_TravelRequisitionDetails_GmbH.jsp";
		         	   		strTraveler="Guest Travel";
						}
				   	} else {
					   	if(strTravelType.equals("I")) {
	    	        		strDetailPageUrl = "T_TravelRequisitionDetails.jsp";    
						} else {
							strDetailPageUrl = "T_TravelRequisitionDetails_D.jsp";	
						}	
					   	
					   	if(strTravelAgencyTypeId != null && strTravelAgencyTypeId.equals("2")) {
						   strDetailPageUrl = "T_TravelRequisitionDetails_INT_GmbH.jsp";
						}
				   	}
				 	loadFlag = "Y";
				  	iCls++;  
		%>
					<script type="text/javascript">
			        	document.getElementById("flag").value='<%=loadFlag%>';			
			        </script>
	        
	    <%	if (strTES.equalsIgnoreCase("n")) { 
	    		reportDataFlag 	= true;
	    %>
		    	<tr class="<%=strStyleCls%>">
					<td width="2%" style="color: #fb5353; font-weight: bold;"><%=sn++%></td>
					<td width="8%">
						<a href="javascript:MM_openBrWindow('<%=strDetailPageUrl%>?purchaseRequisitionId=<%=strtravelid%>&traveller_Id=<%=strtravelerId%>&travelType=<%=strTravelType%>','SEARCH','scrollbars=yes,resizable=yes,width=975,height=550');" 
						   class="reportLink" title="<%=strReasonForTravel%>"> 
							<%=strReq_no%>
						</a>
					</td>
					
					<td width="8%" nowrap="nowrap">
			<% 		if (strTraveler.equalsIgnoreCase("Group/Guest Travel") || strTraveler.equalsIgnoreCase("Guest Travel")) { %> 
						<a href="javascript:showTravellerName('<%=strTravelType.trim()%>',<%=strtravelid%>, '<%=strReq_no.replaceAll("/", "~")%>');"class="reportLink">
							<%=strTraveler%>
						</a> 
			<%		} else {
		 				out.print(strTraveler);
					}
			%>		</td>
					
					<td width="8%"><%=strCreationDate%></td>
					<td width="8%"><%=strTravelDate%></td>
					<td width="12%"><%=strIntermediateDesc.trim()%></td>
					<td width="8%"><%=strReturnDate%></td>
					<td width="8%"><%=strTravelDays%></td>
					<td width="8%"><%=totalAmount%></td>
			
			<%	if (strBillingSite.trim().equalsIgnoreCase("y")) { %>
					<td width="8%"><%=strBillingUnit%></td>
			<%	} 
					
				if (strTransitDays.trim().equalsIgnoreCase("y")) { %>
					<td width="8%"><%=strDays%></td>
			<%	} 
					
				if (strTravelClass.trim().equalsIgnoreCase("y")) { %>
					<td width="8%"><%=strClass%></td>
			<%	} %>
					
					<td width="8%"><%=strTravel_status_id%></td>
					
			<%	if ((SuserRole.trim().equals("AD") || SuserRole.trim().equals("AC")) && strTESShowFlag.trim().equalsIgnoreCase("Y")) { %>
					
					<td width="8%" nowrap="nowrap">
			<%		if (strTESFlag.trim().equalsIgnoreCase("Y")	&& strReqStatusFlag.trim().equalsIgnoreCase("A") && (strTESRemarks.trim().equalsIgnoreCase("") || strTESRemarks.trim().equalsIgnoreCase("-"))) { %>		
						<font color=#33CC00><b><%=dbLabelBean.getLabel("label.search.tessubmitted",strsesLanguage)%></b></font>
			
			<%		} else if (strTESFlag.trim().equalsIgnoreCase("Y") && strReqStatusFlag.trim().equalsIgnoreCase("A")	&& !strTESRemarks.trim().equalsIgnoreCase("") && !strTESRemarks.trim().equalsIgnoreCase("-")) { %>
						<font color=#373737><b><%=dbLabelBean.getLabel("label.search.tesmanuallysubmitted",strsesLanguage)%></b></font>
			
			<%		} else if ((strTESFlag.trim().equalsIgnoreCase("-") || strTESFlag.trim().equalsIgnoreCase("N"))	&& strReqStatusFlag.trim().equalsIgnoreCase("P")) { %>
						<font color="red"><b><%=dbLabelBean.getLabel("label.search.tesnotsubmitted",strsesLanguage)%></b></font>
			
			<%		} else if ((strTESFlag.trim().equalsIgnoreCase("-") || strTESFlag.trim().equalsIgnoreCase("N"))	&& strReqStatusFlag.trim().equalsIgnoreCase("A")) { %>
						<a href="#" onClick="javascript:MM_openBrWindow('T_TESStatus_RequestClose.jsp?purchaseRequisitionId=<%=strtravelid%>&travel_type=<%=strTravelType.trim()%>&whichPage=T_travelDateWiseReportPost.jsp&targetFrame=yes','SEARCH','scrollbars=yes,resizable=yes,width=775,height=300')"
							title="<%=dbLabelBean.getLabel("label.search.tesnotsubmitted",strsesLanguage)%>">
							<font color="#0000ff"><b><%=dbLabelBean.getLabel("label.search.tesnotsubmitted",strsesLanguage)%></b></font>
						</a>
			
			<%		} else { %>
						<font color="red"><b><%=dbLabelBean.getLabel("label.search.tesnotsubmitted",strsesLanguage)%></b></font>
			<%		} %>
					</td>
					
					<td width="8%"><%=strTESRemarks%></td>
			<%	} 
			
				if(strCO.trim().equalsIgnoreCase("y")) { %>
					<td><%=strTravelAllowances%></td>
					<td><%=strDailyCharges%></td>
					<td><%=strContingencies%></td>
					<td><%=strOtherExp%></td>
					<td><%=strTotalBaseCurr%></td>
			<%	} %>
				</tr> 
		
		<%	} else if(strTES.equalsIgnoreCase("y") && strReqStatusFlag.equalsIgnoreCase("A") && (strTESFlag.trim().equalsIgnoreCase("-") || strTESFlag.trim().equalsIgnoreCase("N"))) { 
				reportDataFlag 	= true;
		%>
				<tr class="<%=strStyleCls%>">
					<td width="2%" style="color: #fb5353; font-weight: bold;"><%=sn++%></td>
					<td width="8%">
						<a href="javascript:MM_openBrWindow('<%=strDetailPageUrl%>?purchaseRequisitionId=<%=strtravelid%>&traveller_Id=<%=strtravelerId%>&travelType=<%=strTravelType%>','SEARCH','scrollbars=yes,resizable=yes,width=975,height=550');"
						   class="reportLink" title="<%=strReasonForTravel%>"> 
							<%=strReq_no%>
						</a>
					</td>
					
					<td width="8%" nowrap="nowrap">
			<%		if (strTraveler.equalsIgnoreCase("Group/Guest Travel") || strTraveler.equalsIgnoreCase("Guest Travel")) { %> 
						<a href="javascript:showTravellerName('<%=strTravelType.trim()%>',<%=strtravelid%>, '<%=strReq_no.replaceAll("/", "~")%>');" class="reportLink">
							<%=strTraveler%>
						</a> 
			<%		} else {
		 				out.print(strTraveler);
					}
			%>		</td>
			
					<td width="8%"><%=strCreationDate%></td>
					<td width="8%"><%=strTravelDate%></td>
					<td width="12%"><%=strIntermediateDesc.trim()%></td>
					<td width="8%"><%=strReturnDate%></td>
					<td width="8%"><%=strTravelDays%></td>
					<td width="8%"><%=totalAmount%></td>
							
			<% 		if (strBillingSite.trim().equalsIgnoreCase("y")) { %>
					<td width="8%"><%=strBillingUnit%></td>
			<%		} 
			
					if (strTransitDays.trim().equalsIgnoreCase("y")) { %>
					<td width="8%"><%=strDays%></td>
			<%		} 
					
					if (strTravelClass.trim().equalsIgnoreCase("y")) { %>
					<td width="8%"><%=strClass%></td>
			<%		} %>
			
					<td width="8%"><%=strTravel_status_id%></td>
			
			<%		if ((SuserRole.trim().equals("AD") || SuserRole.trim().equals("AC")) && strTESShowFlag.trim().equalsIgnoreCase("Y")) { %>
					<td width="8%" nowrap="nowrap">
						<a href="#"	onClick="javascript:MM_openBrWindow('T_TESStatus_RequestClose.jsp?purchaseRequisitionId=<%=strtravelid%>&travel_type=<%=strTravelType.trim()%>&whichPage=T_travelDateWiseReportPost.jsp&targetFrame=yes','SEARCH','scrollbars=yes,resizable=yes,width=775,height=300')"
							title="<%=dbLabelBean.getLabel("label.search.tesnotsubmitted",strsesLanguage)%>">
							<font color="#0000ff"><b><%=dbLabelBean.getLabel("label.search.tesnotsubmitted",strsesLanguage)%></b></font>
						</a>
					</td>
					
					<td width="8%"><%=strTESRemarks%></td>
			<% 		} 
					
					if(strCO.trim().equalsIgnoreCase("y")) { 
			%>		<td><%=strTravelAllowances%></td>
					<td><%=strDailyCharges%></td>
					<td><%=strContingencies%></td>
					<td><%=strOtherExp%></td>
					<td><%=strTotalBaseCurr%></td>
			<%		} %>
				</tr>
		<%		}
			}
			rs.close();
			cstmt.close();
			dbConBean.close();
			
			} catch (Exception e) {	
				e.printStackTrace();
		%>	<script type="text/javascript">
				alert("Error while retrieving data.");
			</script>
		<%	}
			
			if(!reportDataFlag) {
		%>		<tr class="oddRow">
					<td colspan="<%=rowCount %>" style="text-align: center;font-weight: bold;color:red;"><%=dbLabelBean.getLabel("label.global.norecordfound",strsesLanguage)%></td>							
				</tr>
		<%	} %>
		
			</tbody>
	</table>
</div>
</form>
</body>

	<script type="text/javascript">
		var win = null;
		function MM_openBrWindow(theURL,winName,features) { 
			win = window.open(theURL,winName,features);
			win.focus();
		}
	
		function showTravellerName(strTrvType,strTrvId, strTrvRequestNo) {
			if(strTrvType=='I') {
				strTrvType="INT";
			} else {
				strTrvType="DOM";
			}
			
			var url = 'T_ShowTravellerFromGroupReqs.jsp?traveltype='+strTrvType+'&strTravelId='+strTrvId+'&strTravelRequestNo='+strTrvRequestNo;
			window.open(url,'DefaultApprovers','scrollbars=yes,resizable=no,width=400,height=350');
		}
		
		function write1() {
			var loadflag 		= document.getElementById('flag').value;
			var reportHeader 	= document.getElementById('reportTitle').innerHTML;
			var reportBody		= document.getElementById('travelReportData').innerHTML;
			var reportData		= '';
			
			if(loadflag=='Y') {
				reportData 				= "<meta http-equiv=\"Content-Type\" content=\"application/vnd.ms-excel; charset=UTF-8\"><table border=1 >"+ reportHeader + reportBody +"</table>";
				document.frm.va.value	= '';
				document.frm.va.value	= reportData;
				document.frm.action		= "issue_exlWrite.jsp";
				document.frm.submit();
			} else {
				alert('<%=dbLabelBean.getLabel("alert.report.nodataforexporttoexcel",strsesLanguage) %>');
			}
		}
	</script>
	
	<script type="text/javascript" language="JavaScript" src="ScriptLibrary/sorttable.js?buildstamp=2_0_0"/>
	<script type="text/javascript">
		var tableObject = document.getElementById("travelReportData");
		sorttable.makeSortable(tableObject);
	</script>
</html>
			

	
			