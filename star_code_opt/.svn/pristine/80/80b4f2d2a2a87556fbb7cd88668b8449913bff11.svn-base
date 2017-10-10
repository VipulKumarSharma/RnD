<!DOCTYPE html>
<%@page import="src.dao.starDaoImpl"%>
<%@page pageEncoding="UTF-8" %>
<%@page import="src.beans.TicketBeanList"%>
<%@page import="org.json.JSONObject"%>
<%@page import="src.beans.TicketBean"%>
<%@page import="org.json.JSONArray"%>
<%@page import="javax.xml.bind.*"%>
<%@page import="sun.security.krb5.internal.tools.Ktab"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="src.connection.*"%>
<%@page import="java.io.*"%>
<%@page import="src.beans.*" %>

<%@ include  file="importStatement.jsp" %>
<%-- include remove cache  --%>
<%@ include  file="cacheInc.inc" %>
<%-- include header  --%>
<%@ include  file="headerIncl.inc" %>
<%-- include page with all application session variables --%>
<%@ include  file="application.jsp" %>

<!--Create the DbConnectionBean object for createConnection-->
<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>

<!--Create the DbUtilityMethods object for utility methods-->
<jsp:useBean id="dbUtility" scope="page" class="src.connection.DbUtilityMethods" />

<html lang="en">
	<head>
		<link type="text/css" rel="stylesheet" href="scripts/main.css?buildstamp=2_0_0" >
		
		<link type="text/css" rel="stylesheet" href="style/quick-travel-style-mata.css?buildstamp=2_0_0" media="all" >
		<link type="text/css" rel="stylesheet" href="style/quick-travel-style_gmbh.css?buildstamp=2_0_0" media="all"  >
		<link type="text/css" rel="stylesheet" href="style/jquery-ui-1.9.2.css?buildstamp=2_0_0" >
		
		<link type="text/css" rel="stylesheet" href="jquery-datepicker/jquery.datepick.css?buildstamp=2_0_0" >
		
		<link type="text/css" rel="stylesheet" href="EditableSelectBox/css/jquery.editable-select.css" >
		
	 	<script type="text/javascript" language="JavaScript" src="ScriptLibrary/FormCheckQuickTravelRequest.js?buildstamp=2_0_0"></script>
		<script type="text/javascript" language="JavaScript" src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></script>
		<script type="text/javascript" language="JavaScript" src="ScriptLibrary/jQueryMaster.js?buildstamp=2_0_0"></script>
		<script type="text/javascript" language="JavaScript" src="ScriptLibrary/jquery-1.8.3.js?buildstamp=2_0_0"></script>
		<script type="text/javascript" language="JavaScript" src="ScriptLibrary/jquery-ui-1.9.2.js?buildstamp=2_0_0"></script>
		<script type="text/javascript" language="JavaScript" src="ScriptLibrary/jquery-ui-autocomplete.js?buildstamp=2_0_0"></script>
		 
		<script type="text/javascript" language="JavaScript" src="jquery-datepicker/jquery.plugin.js?buildstamp=2_0_0"></script>
		<script type="text/javascript" language="JavaScript" src="jquery-datepicker/jquery.datepick.js?buildstamp=2_0_0"></script>
	 
	 	<script type="text/javascript" language="JavaScript" src="scripts/CommonValida.js?buildstamp=2_0_0"></script>
	 	
	 	<script type="text/javascript" language="JavaScript" src="EditableSelectBox/js/jquery.editable-select.js"></script>
	 	
	</head>
	<%	int sNum 		= 0;
		int sNum1 		= 0;
		int sNum2 		= 0;
		int sNum3 		= 0;
		int cnt 		= 0;
		int count	 	= 0;
		int len			= 0;
		int iSno		= 0;
		
		String siteId 	= "";
		String siteName	= "";
		String userId 	= "";
		String tBookId 	= "";
		String secFrom 	= "";
		String secTo 	= "";
		String location = "";
		String airType 	= "";
		String country 	= "";
		
		
		String company 	= "";
		String paxName 	= "";
		String mobNo 	= "";
		String dob 		= "";
		String traveltype= "";
		String forex 	= "";
		String ppNo		= "";
		String ppExpDt	= "";
		String userDetailXML = "";
		
		String tktBookId= "";
		String secFrom1  = "";
		String secTo1 	= "";
		String cls 		= "";
		String deptrDate= "";
		String deptrTime= "";
		String arrDate 	= "";
		String arrTime 	= "";
		String airline 	= "";
		String pnr 		= ""; 
		String eTktNo 	= "";
		String basicFare= "";
		String taxes 	= "";
		String totFare 	= "";
		String tktStatus= "";
		String tktRemarks= "";
		String tktUsers = "";
		String tktUserIds= "";
		
		String visaStatusId	= "";
		String visaBookId	= "";
		String pptNo 		= "";
		String pptExpDt 	= "";
		String visaType 	= "";
		String country1 	= "";
		String docRecDt 	= "";
		String visaIssDt	= "";
		String visaValFrom	= "";
		String visaValTo	= "";
		String durOfStay	= ""; 
		String entryType	= "";
		String visaCharges	= "";
		String visaRemarks	= "";
		
		String insuBookId	= "";
		String insuStatus 	= "";
		String insuPolNo	= "";
		String insuStDt 	= "";
		String insuEndDt	= "";
		String insuType 	= "";
		String nominee 		= "";
		String relation 	= "";
		String insuCharges	= "";
		String insuRemarks	= "";
		
		String accBookId= "";
		String stayType = "";
		String locn 	= "";
		String chkInDt 	= "";
		String chkInTime= "";
		String chkOutDt = "";
		String chkOutTime= "";
		String bookConfno= "";
		String stayCharges= "";
		String stayRemarks= "";
		
		String chkBoxFlag ="";
		String travelCnclId= "";
		String tktIssuDt= "";
		String secFrom2 = "";
		String secTo2 	= "";
		String tktCnclDt= "";
		String pnr1 	= "";
		String eTktNo1 	= "";
		String cnclCharges= "";
		String cnclReason= "";
		String refundRemarks= ""; 
		String mailSentFlag = "";
		
		String subRole	= "";
		String query	= "";
		DbConnectionBean objCon;
	 	Connection con 	= null;
	 	Statement stmt 	= null;
	 	Statement stmt1 = null;
	 	Statement stmt2 = null;
	 	Statement stmt3 = null;
		ResultSet rSet,rs,rs1,rs2,rs3,rs4,rs5,rs6,rs7,rs8,rs9,rs10 = null;
		objCon 			= new DbConnectionBean();
		con 			= objCon.getConnection();
		stmt			= con.createStatement();
		stmt1			= con.createStatement();
		stmt2			= con.createStatement();
		stmt3			= con.createStatement();

		boolean singleTktRowShowFlag		=  false;
		boolean tktReqDetailExists 			=  false;
		boolean visaReqDetailExists 		=  false;
		boolean insurReqDetailExists 		=  false;
		boolean accomoReqDetailExists 		=  false;
		boolean cnclRefundDetailExists		=  false;
		boolean showCnclBlockFlag			=  false;
		boolean editModeFlag				=  false;
		boolean closeFlag					=  false;
		
		String trvllerId	= "";
		String trvlId		= "";
		String trvlReqNum	= "";
		String trvlType		= "";
		
		String travelID 	= "";
		String travelReqNo 	= "";
		String travellerId 	= "";
		String travelStsId	= "";
		String travelBookingId 	= "";
		
		String strUrl		= "";
		String grpTravelFlag= "";	
		String trRemark		= "";
		
		String grpTrvlFlag	= "";
		String trvlAgencyId	= "";
		HttpSession sess	= request.getSession();
		Date date 			= new Date();
		String currentDate	= new SimpleDateFormat("yyyy-MM-dd").format(date);
		String currDate		= new SimpleDateFormat("dd/MM/yyyy").format(date);
		
		tBookId				= request.getParameter("travelBookingId")==null?"0":request.getParameter("travelBookingId");
		String lstModDt		= request.getParameter("latestUpdatedDate")==null?currentDate.trim():request.getParameter("latestUpdatedDate").trim();
		userId				= sess.getValue("user_id") == null ? "" : (String) sess.getValue("user_id");
		
		rs	= stmt.executeQuery("select STUFF((SELECT ','+Booking_Role FROM M_BOOKING_ROLE R WHERE CHARINDEX(','+CONVERT(VARCHAR,Booking_Role_ID)+',',','+M_USERINFO.BOOKING_ROLE+',')>0 FOR XML path(''), type).value('.', 'varchar(max)')   ,1,1,'') AS BOOKING_ROLE from M_USERINFO where M_USERINFO.USERID="+userId+" and M_USERINFO.STATUS_ID=10");
		if(rs.next()) 
		{	subRole	=	rs.getString("BOOKING_ROLE");
		}
		rs.close();
		
		rSet = stmt.executeQuery("select TTBD.Traveller_ID, TTBD.Travel_Req_No, TTBD.Travel_ID, TTBD.Travel_Type,TTBD.Group_Travel_Flag,MS.TRAVEL_AGENCY_ID as TRAVEL_AGENCY_ID from T_TRAVEL_BOOKING_DETAIL TTBD inner join M_SITE MS ON TTBD.Site_ID=MS.Site_ID  WHERE TRAVEL_BOOK_ID="+tBookId);
		if(rSet.next()) 
		{	trvllerId	= rSet.getString("Traveller_ID");
			trvlId      = rSet.getString("Travel_ID");
			trvlReqNum	= rSet.getString("Travel_Req_No").trim();
			trvlType	= rSet.getString("Travel_Type");
			grpTrvlFlag = rSet.getString("Group_Travel_Flag").trim();
			trvlAgencyId= rSet.getString("TRAVEL_AGENCY_ID");
		}
		rSet.close();
		
		//System.out.println("tBookId="+tBookId+" lstModDt="+lstModDt+" userId="+userId+" subRole="+subRole);
		//System.out.println("trvllerId="+trvllerId+" trvlId="+trvlId+" trvlReqNum="+trvlReqNum);
		//System.out.println("trvlType="+trvlType+" grpTrvlFlag="+grpTrvlFlag+" trvlAgencyId="+trvlAgencyId+"\n\n");
		
		if(grpTrvlFlag==null) 
		{	grpTrvlFlag="N";
 		}
          
		if(grpTrvlFlag!=null  &&  (grpTrvlFlag.equalsIgnoreCase("Y")))
		{	
			if(trvlType.equalsIgnoreCase("I"))
			{
				if(trvlAgencyId != null && trvlAgencyId.equalsIgnoreCase("2"))
				{	 strUrl = "Group_T_TravelRequisitionDetails_GmbH.jsp";
				}else
				{	strUrl = "Group_T_TravelRequisitionDetails.jsp";
				}
			}
			else if(trvlType.equalsIgnoreCase("D"))
			{
				if(trvlAgencyId != null && trvlAgencyId.equalsIgnoreCase("2"))
				{	 strUrl = "Group_T_TravelRequisitionDetails_GmbH.jsp";
				}else
				{	strUrl = "Group_T_TravelRequisitionDetails_D.jsp";
				}
			}
		}
		else
		{	
			if(trvlType.equalsIgnoreCase("I"))
			{
				if(trvlAgencyId != null && trvlAgencyId.equalsIgnoreCase("2"))
				{	strUrl = "T_TravelRequisitionDetails_INT_GmbH.jsp";
				}
				else
				{	strUrl = "T_TravelRequisitionDetails.jsp";
				}
			}
			else if(trvlType.equalsIgnoreCase("D"))
			{
				if(trvlAgencyId != null && trvlAgencyId.equalsIgnoreCase("2"))
				{	strUrl = "T_TravelRequisitionDetails_INT_GmbH.jsp";
				}
				else
				{	strUrl = "T_TravelRequisitionDetails_D.jsp";
				}
			}
			
		}
		
		String bs_siteId 			= request.getParameter("siteId") == null ? "0" : request.getParameter("siteId");
		String bs_reqNo 			= request.getParameter("reqNo") == null ? "" : request.getParameter("reqNo");
		String bs_travelDateStr 	= request.getParameter("date") == null  ? currDate : request.getParameter("date") ;
		String bs_travelType 		= request.getParameter("travelType") == null ? "A" : request.getParameter("travelType");
		String bs_travellerId 		= request.getParameter("travellerId") == null ? "0" : request.getParameter("travellerId");
		String bs_bookingStatus 	= (request.getParameter("status") == null || "".equals(request.getParameter("status"))) ? "0" : request.getParameter("status");
		String bs_bookedBy 			= (request.getParameter("bookedBy") == null || "".equals(request.getParameter("bookedBy"))) ? "0" : request.getParameter("bookedBy");
		String bs_reportType 		= (request.getParameter("reportType") == null || "".equals(request.getParameter("reportType"))) ? "0" : request.getParameter("reportType");
		String bs_travelStatus 		= (request.getParameter("travelStatus") == null || "".equals(request.getParameter("travelStatus"))) ? "10" : request.getParameter("travelStatus");
	%>
	<%! 
		String revDtStr(String str)
		{	
			String dobDt 	= str.substring(0, 10);
			String[] parts	= dobDt.split("-");
			dobDt 			= parts[2]+"/"+parts[1]+"/"+parts[0];
			return dobDt;
		}
	%>
<body>
	<div id = "divBackground" style="position: absolute; z-index: 99; height: 100%; width: 100%; top: 0; left:0; background-color: Black; filter: alpha(opacity=60); opacity: 0.6; -moz-opacity: 0.8;display:none">
		<div id="waitingData" style="display: none;"> 	    
		<center>
			<img src="images/loader-circle.gif?buildstamp=2_0_0" width="50" height="50"/> 
			<br><br>
			<font color="#ffffff" style="font-size:14px;font-weight:bold;font-family:Verdana, Arial, Helvetica, sans-serif;">   
			<span id="pleaseWait"></span>
			</font>  
		</center>
		</div>
	</div>
	
	<form name="frm" action="" method="POST">
		<br/>
		<input type="hidden" name="hid_bs_siteId" id="hid_bs_siteId" value="<%=bs_siteId%>"/>
		<input type="hidden" name="hid_bs_reqNo" id="hid_bs_reqNo" value="<%=bs_reqNo%>"/>
		<input type="hidden" name="hid_bs_travelDateStr" id="hid_bs_travelDateStr" value="<%=bs_travelDateStr%>"/>
		<input type="hidden" name="hid_bs_travelType" id="hid_bs_travelType" value="<%=bs_travelType%>"/>
		<input type="hidden" name="hid_bs_travellerId" id="hid_bs_travellerId" value="<%=bs_travellerId%>"/>
		<input type="hidden" name="hid_bs_bookingStatus" id="hid_bs_bookingStatus" value="<%=bs_bookingStatus%>"/>
		<input type="hidden" name="hid_bs_bookedBy" id="hid_bs_bookedBy" value="<%=bs_bookedBy%>"/>
		<input type="hidden" name="hid_bs_reportType" id="hid_bs_reportType" value="<%=bs_reportType%>"/>
		<input type="hidden" name="hid_bs_travelStatus" id="hid_bs_travelStatus" value="<%=bs_travelStatus%>"/>
		
		<div id="reqNum">
			<table width="100%">
			<tr>
			<td id="reqNoTD">
				<b><%=dbLabelBean.getLabel("label.mail.travelrequisitionnumber",strsesLanguage)%> : 
				<a href=# onClick="MM_openBrWindow('<%=strUrl%>?purchaseRequisitionId=<%=trvlId%>&traveller_Id=<%=trvllerId%>&travelType=<%=trvlType%>&reportFlag=true','SEARCH','scrollbars=yes,resizable=yes,width=975,height=550');" 
					style='color:red;text-decoration:none;cursor:pointer;' title='Click to See the Requisition details'>
				<%	if (grpTrvlFlag.equalsIgnoreCase("Y")) {	%>	
					<img src='images/grpIcon-blue.png?buildstamp=2_0_0' border='0'> <label id="travelReqNum" style="color:red;"><%=trvlReqNum%></label>
				<%	} else {	%>	
					<label id="travelReqNum" style="color:red;"><%=trvlReqNum%></label> 
				<%	} %>
				</a>	
				</b>
			</td>
			<td align="right">
				<input type="button" value="<%=dbLabelBean.getLabel("button.global.back",strsesLanguage)%>"  
					id="closeBtn" class="cnclbtnCss" onclick="submitData('true',0);" style="width:60px;font-size:90%;padding-bottom: 1px;margin-right:8px;">
			</td>
			</tr>
			</table>
			<hr width="99.2%" align="left">
			
		</div>
		
		<div id="passengerInfo" style="margin:0 auto;_text-align:left;" nowrap>
	<%	if (grpTrvlFlag.equalsIgnoreCase("Y") && !(tBookId.equals("0")) && !(tBookId.equals("")) && (tBookId != null)) {	%>		
			<table style="padding-bottom: 5px;">
				<tr>
					<td>
						<ul class="pagebullet">
			      			<li class="pageHead">
								<td text-align="left"><b>Originator's Detail</b></td>
							</li>
						</ul>
					</td>
				</tr>
			</table>
	<%	} else { %>		
			<br>
	<%	} %>		
			<table width="99.3%" align="left" border="0" cellpadding="5" cellspacing="1" class="formborder" id="personalInfoTable">
				<thead>
				<tr class="formhead" align="center">
					<td name="unitHide"><%=dbLabelBean.getLabel("submenu.master.company",strsesLanguage)%></td>
				<%	if (grpTrvlFlag.equalsIgnoreCase("Y")) {	%>
					<td width="180px">Originator Name</td>
				<%	} else { %>
					<td width="180px"><%=dbLabelBean.getLabel("label.personnelbooking.paxname",strsesLanguage)%></td>
				<%	} %>	
					
					<td style="width:90px;"><%=dbLabelBean.getLabel("label.global.dob",strsesLanguage)%></td>
					<td><%=dbLabelBean.getLabel("label.global.mobileno",strsesLanguage)%></td>
					<td style="width:90px;">Passport No</td>
					<td style="width:90px;">PP Exp. Date</td>
					<td style="width:90px;"><%=dbLabelBean.getLabel("label.report.traveltype",strsesLanguage)%></td>
					<td><%=dbLabelBean.getLabel("label.personnelbooking.totalforexadvance",strsesLanguage)%></td>
				</tr>
				</thead>
				<tbody>
				<%
				if(!(tBookId.equals("0")) && !(tBookId.equals("")) && (tBookId != null))
				{	
					rs1=stmt.executeQuery("select UM.PASSPORT_NO, UM.EXPIRY_DATE, MS.SITE_NAME,TBD.Remark,TBD.Group_Travel_Flag,TBD.Travel_ID,TBD.Travel_Req_No,TBD.Traveller_ID,TBD.Travel_Status_ID,TBD.traveller_name,TBD.SITE_ID, TBD.Mobile_No,TBD.DOB, Travel_Type, Forex_Detail from T_TRAVEL_BOOKING_DETAIL TBD left JOIN M_USERINFO UM ON TBD.Traveller_ID=UM.USERID LEFT JOIN M_SITE MS on TBD.Site_ID=MS.SITE_ID WHERE TRAVEL_BOOK_ID="+tBookId);
					while(rs1.next()) 
					{	
						trRemark	= rs1.getString("Remark")==null ? "":rs1.getString("Remark");		
						grpTravelFlag=rs1.getString("Group_Travel_Flag")==null ? "N":rs1.getString("Group_Travel_Flag");
						travelID	= rs1.getString("Travel_ID")==null ? "-1":rs1.getString("Travel_ID");
						travelReqNo	= rs1.getString("Travel_Req_No")==null ? "PERSONAL":rs1.getString("Travel_Req_No");
						travellerId	= rs1.getString("Traveller_ID")==null ? "-1":rs1.getString("Traveller_ID");
						travelStsId	= rs1.getString("Travel_Status_ID")==null ? "2":rs1.getString("Travel_Status_ID");
						siteId		= rs1.getString("SITE_ID")==null ? "":rs1.getString("SITE_ID");
						siteName	= rs1.getString("SITE_NAME")==null ? "":rs1.getString("SITE_NAME").trim();
						paxName 	= rs1.getString("TRAVELLER_NAME")==null ? "":rs1.getString("TRAVELLER_NAME");
						mobNo 		= rs1.getString("Mobile_No")==null ? "":rs1.getString("Mobile_No");
						dob 		= rs1.getString("DOB")==null ? "":revDtStr(rs1.getString("DOB"));
						traveltype 	= rs1.getString("Travel_Type")==null ? "D":rs1.getString("Travel_Type");
						forex 		= rs1.getString("Forex_Detail")==null ? "":rs1.getString("Forex_Detail"); 
						ppNo		= rs1.getString("PASSPORT_NO")==null ? "-":rs1.getString("PASSPORT_NO");
						ppExpDt		= rs1.getString("EXPIRY_DATE")==null ? "":revDtStr(rs1.getString("EXPIRY_DATE"));
						
						//System.out.println("trRemark="+trRemark+" grpTravelFlag="+grpTravelFlag+" travelID="+travelID+" travelReqNo="+travelReqNo);
						//System.out.println("travellerId="+travellerId+" travelStsId="+travelStsId+" siteId="+siteId);
						//System.out.println("siteName="+siteName+" paxName="+paxName+" mobNo="+mobNo);
						//System.out.println("dob="+dob+" traveltype="+traveltype+" forex="+forex+"\n\n");
						
				%>
				<input type="hidden" name="hidTravelBookingId" value="<%=tBookId%>"/>
				<input type="hidden" name="hidtravelID" value="<%=travelID%>"/>
				<input type="hidden" name="hidtravelReqNo" value="<%=travelReqNo%>"/>
				<input type="hidden" name="hidtravellerId" value="<%=travellerId%>"/>
				<input type="hidden" name="hidtravelStsId" value="<%=travelStsId%>"/>
				<input type="hidden" name="hidgrpTravelFlag" value="<%=grpTravelFlag%>"/>
				<input type="hidden" name="hidtrRemark" value="<%=trRemark%>"/>
				<input type="hidden" name="hidLstModDt" value="<%=lstModDt%>"/>
			
				<tr class="personalDetailsRow">
					<td name="unitHide" style="width:150px;">
						<select name="selectUnit" id="selectUnit" class="textBoxCss" style="width:100%;">	
			 				<option value="-2"><%=dbLabelBean.getLabel("label.personnelbooking.miscellaneous",strsesLanguage)%></option>
			 				<option value="0" selected="selected"><%=dbLabelBean.getLabel("label.personnelbooking.personal",strsesLanguage)%></option>	
				<%			String sSqlStr="select  DISTINCT(dbo.sitename(site_id)) as site_name ,SITE_ID  from m_userinfo WHERE (STATUS_ID = 10) order BY SITE_NAME;";
							rs = stmt1.executeQuery(sSqlStr);
							while(rs.next()) 
							{
				%>			<option VALUE="<%=rs.getString("SITE_ID")%>"><%=rs.getString("site_name")%></option>
				<%			}
							rs.close();	
				%>
						</select>  
						<input type="hidden" name="hidsiteId" value="<%=siteId%>"/>
						<input type="hidden" name="hidsiteName" value="<%=siteName%>"/>
					<script type="text/javascript" language="JavaScript">
							
					<%	if (travelReqNo.equalsIgnoreCase("PERSONAL")) { %>		
							
							$("#reqNoTD").html('<b>Travel Requisition No: <font style="color:red;">PERSONAL</font></b>');
							$("select#selectUnit").val('0');
					<%	} else if (travelReqNo.equalsIgnoreCase("MISCELLANEOUS")) {	%>		
							
							$("#reqNoTD").html('<b>Travel Requisition No: <font style="color:red;">MISCELLANEOUS</font></b>');
							$("select#selectUnit").val('-2');
					<%	} else if (travelReqNo.indexOf("/PERSONAL") >= 0) { %>		
							
							$("#reqNoTD").html('<b>Travel Requisition No: <font style="color:red;">'+'<%=siteName%>'+'/PERSONAL</font></b>');
							$("select#selectUnit").val('<%=siteId%>');
					<%	} else { %>		
							
							$("select#selectUnit").val('<%=siteId%>');
					<%	} %>
					</script>	
					</td>
					<td style="width:180px;">
						<input type="text" name="paxName" id="paxName" value="<%=paxName%>" class="tableTextBox" onkeyup="return test1(this,200,'c.');" style="width:100%;text-align: center;">
					</td>
					<td style="width:90px;">
						<input type="text" name="dob" id="dob" size=12 style="width:100%;" value="<%=dob %>" 
								class="tableTextBox validDateBook validDate" placeholder="DD/MM/YYYY"  
								onFocus="initializePastDate(this);"	>
					</td>
					<td style="width:105px;">
						<input type="text" name="mobileNo" id="mobileNo" value="<%=mobNo%>" class="tableTextBox" onkeyup="return test1(this,20,'n');" style="width:100%;text-align:right;" >
					</td>
					<td style="width:90px;">
						<input type="text" name="ppNo" id="ppNo" size=12 style="width:100%;" value="<%=ppNo%>" class="tableTextBox" placeholder="">
					</td>
					<td style="width:90px;">
						<input type="text" name="ppExpDt" id="ppExpDt" size=12 style="width:100%;" value="<%=ppExpDt%>" class="tableTextBox">
					</td>
					<td style="width:90px;">
						<select name="travelType" id="travelType" class="textBoxCss" style="width:100%;">	
					    	<option  value='D' 
					    		<% if(traveltype.equalsIgnoreCase("D")){%>
						    	selected="selected"
						    	<%} %>
					    	><%=dbLabelBean.getLabel("button.global.domestic",strsesLanguage)%></option>
					    	<option  value='I' 
					    		<% if(traveltype.equalsIgnoreCase("I")){%>
						    	selected="selected"
						    	<%} %>
					    	><%=dbLabelBean.getLabel("button.global.international",strsesLanguage)%></option>
						</select>
					</td>
					<td style="width:175px;">
						<input type="text" name="forex" id="forex" value="<%=forex%>" class="tableTextBox" onkeyup="return test1(this,100,'a');" style="width:100%;">
					</td>
				</tr>
				<%	}
					rs1.close();
				}
				else if(tBookId.equals("0") || tBookId.equals("") || (tBookId != null))
				{	
				%>
				<tr class="personalDetailsRow">
					<td style="width:150px;" name="unitHide" id="unitHide">
						<input type="hidden" name="hidsiteName" id="hidsiteName" value=""> 
						
						<select name="selectUnit" id="selectUnit" class="textBoxCss" style="width:100%;">	
			 				<option value="-2"><%=dbLabelBean.getLabel("label.personnelbooking.miscellaneous",strsesLanguage)%></option>
			 				<option value="0" selected="selected"><%=dbLabelBean.getLabel("label.personnelbooking.personal",strsesLanguage)%></option>	
				<%
							String sSqlStr="select  DISTINCT(dbo.sitename(site_id)) as site_name ,SITE_ID  from m_userinfo WHERE (STATUS_ID = 10) order BY SITE_NAME;";
							rs = stmt1.executeQuery(sSqlStr);
							while(rs.next()) 
							{
				%>			<option VALUE="<%=rs.getString("SITE_ID")%>"><%=rs.getString("site_name")%></option>
				<%			}
							rs.close();	
				%>
						</select> 
						
						<script>
							$("#reqNoTD").html('<b>Travel Requisition No: <font style="color:GREEN;">[NEW REQUISITION]</font></b>');
						</script>
					</td>
					<td style="width:180px;">
						<input type="text" name="paxName" id="paxName" value="" class="tableTextBox" onkeyup="return test1(this,200,'c.');" style="width:100%;">
					</td>
					<td style="width:90px;">
						<input type="text" name="dob" id="dob" size=12 style="width:100%;" value="" 
								class="tableTextBox validDateBook validDate" placeholder="DD/MM/YYYY"  
								onFocus="initializePastDate(this);"	>
					</td>
					<td style="width:105px;">
						<input type="text" name="mobileNo" id="mobileNo" value="" class="tableTextBox" onkeyup="return test1(this,20,'n');" style="width:100%;text-align:right;">
					</td>
					<td style="width:90px;">
						<input type="text" name="ppNo" id="ppNo" size=12 style="width:100%;" value="" class="tableTextBox" placeholder="">
					</td>
					<td style="width:90px;">
						<input type="text" name="ppExpDt" id="ppExpDt" size=12 style="width:100%;" value="" class="tableTextBox">
					</td>
					<td style="width:90px;">
						<select name="travelType" id="travelType" class="textBoxCss" style="width:100%;">	
					    	<option  value='I'><%=dbLabelBean.getLabel("button.global.international",strsesLanguage)%></option>
					    	<option  value='D' selected="selected"><%=dbLabelBean.getLabel("button.global.domestic",strsesLanguage)%></option>
						</select>
					</td>
					<td style="width:200px;">
						<input type="text" name="forex" id="forex" value="" class="tableTextBox" onkeyup="return test1(this,100,'a');" style="width:100%;">
					</td>
				</tr>
				<%
				}
				%>
				</tr>
				</tbody>
			</table>
		<br/><br/><br/><br/>
		</div>
	
	<script>
		var newGrpUsersArr 	= [];
		var fixedGrpUsersArr = [];
	</script>	
	<%	if (grpTrvlFlag.equalsIgnoreCase("Y") && !(tBookId.equals("0")) && !(tBookId.equals("")) && (tBookId != null)) {	%>	
		<div id="grpTravelersInfo" style="margin:0 auto;_text-align:left;" nowrap>
			<table style="padding-top: 5px;padding-bottom: 5px;">
				<tr>
					<td>
						<ul class="pagebullet">
			      			<li class="pageHead">
								<td text-align="left"><b>Group Travellers Detail</b></td>
							</li>
						</ul>
					</td>
				</tr>
			</table>
			<table width="99.3%" align="" border="0" cellpadding="5" cellspacing="1" id="grpTravelersInfoTable" class="formborder">
				<thead>
					<th class="formhead" style="width: 5px;">TKT</th>
					<th class="formhead" style="width: 180px;"><%=dbLabelBean.getLabel("label.personnelbooking.paxname",strsesLanguage)%></th>
					<th class="formhead" style="width: 180px;"><%=dbLabelBean.getLabel("label.global.designation",strsesLanguage)%></th>
					<th class="formhead" style="width: 90px;"><%=dbLabelBean.getLabel("label.global.dob",strsesLanguage)%></th>
					<th class="formhead" style="width: 100px;"><%=dbLabelBean.getLabel("label.global.mobileno",strsesLanguage)%></th>
					<th class="formhead" style=""><%=dbLabelBean.getLabel("label.personnelbooking.forexadvance",strsesLanguage)%></th>
				</thead>
				<tbody>
			<%	
				rs1 = stmt.executeQuery("select Group_User_Detail from T_TRAVEL_BOOKING_DETAIL WHERE TRAVEL_BOOK_ID="+tBookId);
				if(rs1.next()) 
				{	
					userDetailXML = rs1.getString("Group_User_Detail")==null ? "":rs1.getString("Group_User_Detail").trim();
					
					List userDetails 	= new ArrayList();
					starDaoImpl sdi 	= new starDaoImpl();
					userDetails 		= sdi.getGrpUserDetailsFromXML(userDetailXML,grpTravelFlag);
					
					for(int i=0; i< ((ArrayList)userDetails.get(1)).size(); i++) { 
						String grpUserTktFlag	= "";
						String grpUserId 		= "";
						
						grpUserTktFlag	= ((ArrayList)userDetails.get(0)).get(i).toString();
						grpUserId 		= ((ArrayList)userDetails.get(6)).get(i).toString();
						
			%>	<tr class="grpTravelersInfoRow">
					<td align="center" width="1%" class="">
							<input type="checkbox" name="usrChkBox" id="usrChkBox" value="<%=grpUserId%>" class="tktFlagChkBox" 
						<%	if("Y".equalsIgnoreCase(grpUserTktFlag.trim())) { %> 
								disabled="disabled" 
						
						<%		if((subRole.indexOf("TC_TICK") == -1 && subRole.indexOf("TC_ADMI") == -1)) { %>
									checked="checked"	
						<%		}
							} else if("N".equalsIgnoreCase(grpUserTktFlag.trim()) || "".equalsIgnoreCase(grpUserTktFlag.trim())) {}%> 
							>
							<input type="hidden" name="checkedUserId" id="checkedUserId" class="checkedUserCls" value="<%=grpUserId%>"/>
								<script type="text/javascript">
									var tktFlag = '<%=grpUserTktFlag%>';
									var userId  = '<%=grpUserId%>';
									if(tktFlag == 'Y' && ($.inArray(userId,newGrpUsersArr) == -1)){
										fixedGrpUsersArr.push(userId);
									}
								</script>
					</td>
					<td>
						<input type="hidden" name="userIds" id="userIds" value="<%=grpUserId%>"/>
						<input type="text" name="userNames" id="userNames" value="<%=((ArrayList)userDetails.get(1)).get(i) %>" class="tableTextBox input-disabled" 
							onkeyup="return test1(this,20,'c');" style="width:100%;text-align: center;" readonly="readonly" onfocus="blur();">
					</td>
					
					<td>
						<input type="text" name="userDesigs" id="userDesigs" value="<%=((ArrayList)userDetails.get(3)).get(i) %>" class="tableTextBox" 
							onkeyup="return test1(this,50,'c');" style="width:100%;" >
					</td>
					
					<td style="width:90px;">
						<input type="text" name="userDobs" id="userDobs" size=12 style="width:100%;" value="<%=((ArrayList)userDetails.get(2)).get(i) %>" 
							placeholder="DD/MM/YYYY" class="tableTextBox validDateBook validDate" onFocus="initializePastDate(this);">
					</td>
					
					<td style="width:105px;">
						<input type="text" name="userMobNos" id="userMobNos" value="<%=((ArrayList)userDetails.get(4)).get(i) %>" class="tableTextBox" 
							onkeyup="return test1(this,20,'n');" style="width:100%;text-align:right;" >
					</td>
					
					<td style="width:175px;">
						<input type="text" name="userForexes" id="userForexes" value="<%=((ArrayList)userDetails.get(5)).get(i) %>" class="tableTextBox" 
							onkeyup="return test1(this,100,'a');" style="width:100%;">
					</td>
				</tr>
			<% 		}
					for(int i=0; i< ((ArrayList)userDetails.get(1)).size(); i++) { 
						if("Y".equalsIgnoreCase(((ArrayList)userDetails.get(0)).get(i).toString().toUpperCase().trim())) {
							singleTktRowShowFlag = true;
							break;
						}
					}
				}
				rs1.close();
			%>				
			</tbody>
			</table>
		</div>
	<%	} else { %>
		<br>
	<%	} %>		
		
		<div id="ticketReq" style="margin:0 auto;_text-align:left;">
			<table 
	<%	if (grpTrvlFlag.equalsIgnoreCase("Y") && !(tBookId.equals("0")) && !(tBookId.equals("")) && (tBookId != null)) {	%>		
			style="padding-top: 10px;"
	<%	} else { } %>
			>		
				<tr>
					<td>
						<ul class="pagebullet">
			      			<li class="pageHead" width="50px">
								<td text-align="left"><b><%=dbLabelBean.getLabel("label.personnelbooking.ticketrequired",strsesLanguage)%></b></td>
							</li>
						</ul>
					</td>
					<td width="125px"></td>
					<td>
						<div id="tktYN">
						<table width="100%" border="0" cellspacing="0" cellpadding="0" class="checkbox">
							<tr>
								<td class="labelTd">
									<label class="yes" id="tktReqYes"> 
										<input type="radio" name="ticket" value="1" id="tktReq_Y">
											<%=dbLabelBean.getLabel("label.global.yes",strsesLanguage)%>
									</label>
								</td>
								<td class="labelTd">
									<label class="no" id="tktReqNo"> 
										<input type="radio"	name="ticket" value="2" checked="checked" id="tktReq_N">
											<%=dbLabelBean.getLabel("label.global.no",strsesLanguage)%>
									</label>
								</td>
							</tr>
						</table>
						</div>
					</td>
				</tr>
			</table>
			
			<div id="tktInfo" class="hide">
	
	<% 		if(!tBookId.equals("0") && !tBookId.equals("") &&  (tBookId != null) && singleTktRowShowFlag)
			{	
				editModeFlag		= true;
				rs2=stmt.executeQuery("SELECT Group_User_ID,Ticket_Book_ID, Sector_From, Sector_To, Class, Departure_Date, Departure_Time, Arrival_Date, Arrival_Time, AirLine_Name, PNR, E_Ticket_No, Basic_Fare, Taxes, Total_Fare, TBD.Booking_Status_ID, Remark, convert(time,case when isnull(Departure_Time,'')='' then '00:00' else substring(replace(Departure_Time,':',''), 1, 2)+':'+substring(replace(Departure_Time,':',''), 3, 2) end) as depttime, convert(time,case when isnull(Arrival_Time,'')='' then '00:00' else substring(replace(Arrival_Time,':',''), 1, 2)+':'+substring(replace(Arrival_Time,':',''), 3, 2) end) arrtime FROM T_TRAVEL_TICKET_BOOKING_DETAIL TBD LEFT JOIN M_BOOKING_STATUS MBS ON (TBD.Booking_Status_ID=MBS.Booking_Status_ID) WHERE TRAVEL_BOOK_ID="+tBookId+" order by departure_date, depttime, arrival_date, arrtime");
				if(rs2.next()) 
				{	
	%>				<div id="tktInfoGrid" class="" style="padding-left: 8px;padding-top: 3px;padding-bottom: 3px;">
	
						<table width="97%" align="left" border="0" cellpadding="4" cellspacing="1" class="formborder" id="tktGridTable">
							<thead>
								<tr>
									<th class="formhead">Sector From</th>
									<th class="formhead">Sector To</th>
									<th class="formhead">Class</th>
									<th class="formhead">Departure</th>
									<th class="formhead">Arrival</th>
									<th class="formhead">PNR</th>
									<th class="formhead">TKT No.</th>
									<th class="formhead">Total Fare</th>
									<th class="formhead">Status</th>
									<th class="formhead">Group Travellers</th>
	<% 							if(subRole.indexOf("TC_TICK") > -1 || subRole.indexOf("TC_ADMI") > -1) { %>								
									<th class="formhead" id="editGridHeader">Edit</th>
	<% 							} %>								
								</tr>
							</thead>
							<tbody>
	<%				do
					{	tktReqDetailExists 	= true;
						showCnclBlockFlag	= true;
						tktBookId  	= rs2.getString("Ticket_Book_Id")==null?"0":rs2.getString("Ticket_Book_Id");
						secFrom1 	= rs2.getString("Sector_From")==null ? "":rs2.getString("Sector_From");
						secTo1 		= rs2.getString("Sector_To")==null ? "":rs2.getString("Sector_To");
						cls 		= rs2.getString("Class")==null ? "":rs2.getString("Class");
						deptrDate 	= rs2.getString("Departure_Date")==null ? "":revDtStr(rs2.getString("Departure_Date"));
						deptrTime 	= (rs2.getString("Departure_Time")==null || rs2.getString("Departure_Time").equals("")) ? "0100":rs2.getString("Departure_Time");
						arrDate 	= rs2.getString("Arrival_Date") == null ? "":revDtStr(rs2.getString("Arrival_Date"));
						arrTime 	= (rs2.getString("Arrival_Time")==null || rs2.getString("Arrival_Time").equals("")) ? "0100":rs2.getString("Arrival_Time");
						airline 	= rs2.getString("AirLine_Name")==null ? "":rs2.getString("AirLine_Name");
						pnr 		= rs2.getString("PNR")==null ? "":rs2.getString("PNR");
						eTktNo 		= rs2.getString("E_Ticket_No")==null ? "":rs2.getString("E_Ticket_No");
						basicFare 	= rs2.getString("Basic_Fare")==null ? "0":rs2.getString("Basic_Fare");
						taxes 		= rs2.getString("Taxes")==null ? "0":rs2.getString("Taxes");
						totFare 	= rs2.getString("Total_Fare")==null ? "0":rs2.getString("Total_Fare");
						tktStatus	= rs2.getString("Booking_Status_ID")==null ? "1":rs2.getString("Booking_Status_ID");
						tktRemarks 	= rs2.getString("Remark")==null ? "":rs2.getString("Remark");
						tktUserIds	= rs2.getString("Group_User_ID")==null ? "":rs2.getString("Group_User_ID");	
						
						if(deptrDate.equals("01/01/1900"))
						{	deptrDate="";
						}
						if(arrDate.equals("01/01/1900"))
						{	arrDate="";
						}
						
						deptrTime 	= deptrTime.replace(":", "");
						arrTime 	= arrTime.replace(":", "");
						
						basicFare 	= Integer.toString(Math.round(Float.parseFloat(basicFare)));
						taxes 		= Integer.toString(Math.round(Float.parseFloat(taxes)));
						totFare 	= Integer.toString(Math.round(Float.parseFloat(totFare)));
						
						String tktGrpUsers = "";
						rs = stmt1.executeQuery("select STUFF((SELECT ','+ TGU.FIRST_NAME+' '+TGU.LAST_NAME as name FROM T_GROUP_USERINFO TGU WHERE CHARINDEX(','+CONVERT(VARCHAR,TGU.G_USERID)+',',','+TBD.Group_User_Id+',')>0 FOR XML path(''), type).value('.', 'varchar(max)')   ,1,1,'') AS Users from T_TRAVEL_TICKET_BOOKING_DETAIL TBD where TBD.Travel_Book_ID="+tBookId+" AND TBD.Ticket_Book_ID="+tktBookId);
						if(rs.next()) {
							tktGrpUsers = rs.getString("Users") == null ? "" : rs.getString("Users").trim();
						}
						rs.close();
			%>						
							<tr align="center" class="tktGridRow" id="tktGridRow">
								<td>
									<input type="hidden" id="hidTktBookId" name="hidTktBookId" value="<%=tktBookId%>"/>
									<input type="text" name="secFrom" id="secFrom" class="tableTextBox input-disabled" style="width:100%;" value="<%=secFrom1%>" readonly="readonly" onclick="blur();"/>
								</td>
								<td>
									<input type="text" name="secTo" id="secTo" class="tableTextBox input-disabled" style="width:100%;" value="<%=secTo1%>" readonly="readonly" onclick="blur();"/>
								</td>
								<td>
									<select name="classType" id="classType" class="textBoxCss input-disabled" style="width:104%;" disabled="disabled">	
								    	<option value='<%=dbLabelBean.getLabel("label.personnelbooking.economy",strsesLanguage)%>' 
									    	<% if(cls.equalsIgnoreCase(dbLabelBean.getLabel("label.personnelbooking.economy",strsesLanguage)) || cls.equalsIgnoreCase("")){%>
									    	selected="selected"
									    	<%} %>
								    	><%=dbLabelBean.getLabel("label.personnelbooking.economy",strsesLanguage)%></option>
								    	<option value='Premium Economy' 
									    	<% if(cls.equalsIgnoreCase("Premium Economy")){%>
									    	selected="selected"
									    	<%} %>
								    	>Premium Economy</option>
								    	<option value='<%=dbLabelBean.getLabel("label.personnelbooking.business",strsesLanguage)%>'  
									    	<% if(cls.equalsIgnoreCase(dbLabelBean.getLabel("label.personnelbooking.business",strsesLanguage))){%>
									    	selected="selected"
									    	<%} %>
									    ><%=dbLabelBean.getLabel("label.personnelbooking.business",strsesLanguage)%></option>
								    	<option value='<%=dbLabelBean.getLabel("label.personnelbooking.firstclass",strsesLanguage)%>'   
									    	<% if(cls.equalsIgnoreCase(dbLabelBean.getLabel("label.personnelbooking.firstclass",strsesLanguage))){ %>
									    	selected="selected"
									    	<%} %>
									    ><%=dbLabelBean.getLabel("label.personnelbooking.firstclass",strsesLanguage)%></option>
									</select>
								</td>
								<td>	
									<input type="text" name="deptrDate" id="deptrDate" class="tableTextBox input-disabled" style="width:100%;" value="<%=deptrDate%>" readonly="readonly" onclick="blur();"/>
									<input type="hidden" name="deptrTime" id="deptrTime" class="tableTextBox" style="width:100%;" value="<%=deptrTime%>" />
								</td>
								<td>
									<input type="text" name="arrDate" id="arrDate" class="tableTextBox input-disabled" style="width:100%;" value="<%=arrDate%>" readonly="readonly" onclick="blur();"/>
									<input type="hidden" name="arrTime" id="arrTime" class="tableTextBox" style="width:100%;" value="<%=arrTime%>" />
								</td>
								<td>
									<input type="hidden" name="airlineType" id="airlineType" class="tableTextBox" style="width:100%;" value="<%=airline%>"/>
									<input type="text" name="pnr" id="pnr" class="tableTextBox input-disabled" style="width:100%;" value="<%=pnr%>" readonly="readonly" onclick="blur();"/>
								</td>
								<td>
									<input type="text" name="ticketNo" id="ticketNo" class="tableTextBox input-disabled" style="width:100%;" value="<%=eTktNo%>" readonly="readonly" onclick="blur();"/>
								</td>
								
								<td>
									<input type="text" name="ttlFare" id="ttlFare" class="tableTextBox input-disabled" style="width:100%;" value="<%=totFare%>" readonly="readonly" onclick="blur();"/>
									
									<%-- <input type="hidden" name="bscFare" id="bscFare" class="tableTextBox" style="width:100%;" value="<%=basicFare%>" />
									<input type="hidden" name="taxes" id="taxes" class="tableTextBox" style="width:100%;" value="<%=taxes%>" /> --%>
								</td>
								
								<td>
									<select name="tktStatus" id="tktStatus" class="textBoxCss input-disabled" style="width:104%;" disabled="disabled">	
							<%			rs = stmt1.executeQuery("SELECT Booking_Status_ID,Booking_Status FROM M_BOOKING_STATUS where Status_ID=10");
										while(rs.next())  {
											if(rs.getString("Booking_Status_ID").trim().equals(tktStatus)) {
							%>					<option VALUE="<%=rs.getString("Booking_Status_ID").trim()%>" selected="selected"><%=rs.getString("Booking_Status").trim()%></option>
							<%				} else {
							%>					<option VALUE="<%=rs.getString("Booking_Status_ID").trim()%>"><%=rs.getString("Booking_Status").trim()%></option>
							<%				}
										}
										rs.close();	
							%>		</select>
								</td>
								<td width="18%">
									<input type="hidden" name="tktRemarks" id="tktRemarks" class="tableTextBox" style="width:100%;" value="<%=tktRemarks%>"/>
									<input type="text" name="tktUsers" id="tktUsers" class="tableTextBox input-disabled tktUserIdsCls" style="width:100%;" value="<%=tktGrpUsers%>" readonly="readonly" onclick="blur();"/>
									<input type="hidden" name="hidGrpTktUserIds" id="hidGrpTktUserIds" value="<%=tktUserIds%>"/>
								</td>
							<% 	if(subRole.indexOf("TC_TICK") > -1 || subRole.indexOf("TC_ADMI") > -1) { %>		
								<td align="center" id="editGridRow">
									<img src="images/Edit.png?buildstamp=2_0_0" border="0" style="cursor:pointer;" id="editRow" title="Edit Ticket" onclick="getTicketDetails(this,'<%=tktBookId%>');">
								</td>
							<% 	} %>	
							</tr>
	<%				} while(rs2.next());
	%>					</tbody>
					</table>
				</div>
	<%			}
			}	
	%>				
				<input type="button" name="addTktInfo" id="addTktInfo" value="<%=dbLabelBean.getLabel("label.personnelbooking.addticketinfo",strsesLanguage)%>" 
					class="formButton-red" style="margin-left:8px;margin-top:8px;font-size: 95%;"/>
					
				<table width="100%" align="center" border="0" cellpadding="5" cellspacing="1" id="ticketInfoTable">
					<tbody>
					<%
					if (singleTktRowShowFlag && (subRole.indexOf("TC_TICK") > -1 || subRole.indexOf("TC_ADMI") > -1))
					{	tktBookId	= "0";	
						//tktReqDetailExists 	= true;
				%>
					<tr class="ticketDetailsRow" id="emptyTicketDetailsRow">
						<input type="hidden" id="hidTktBookId" name="hidTktBookId" value="<%=tktBookId%>"/>
						<td>
							<table width="100%" class="">
								<tr class="ticketDetailsRow1">
									<td align="center" width="30px" class="formhead" rowspan="3">
										<b><label name="sno" id="sno">1</label>.</b>
									</td>
									
									<td style="width:110px;" class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.sectorfrom",strsesLanguage)%></td>
									<td style="width:110px;padding-right:5px;">
										<input type="text" name="secFrom" id="secFrom" class="tableTextBox editTktRowSec" value="" 
										onFocus="initializeCityName(this);" maxlength="30"  onkeyup="return test1(this,50,'a');" 
										placeholder="<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>" 
										title="<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>"  style="width:100%;"
										>
									</td>
									
									<td style="width:100px;" class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.sectorto",strsesLanguage)%></td>
									<td style="width:110px;padding-right:5px;">
										<input type="text" name="secTo" id="secTo" class="tableTextBox" value="" 
										onFocus="initializeCityName(this);" maxlength="30"  onkeyup="return test1(this,50,'a');" 
										placeholder="<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>" 
										title="<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>"  style="width:100%;"
										> 
									</td>
									
									<td style="width:120px;" class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.global.class",strsesLanguage)%></td>
									<td style="width:110px;padding-right:5px;">
										<select name="classType" id="classType" class="textBoxCss" style="width:103%;">	
									    	<option value='0' selected="selected"><%=dbLabelBean.getLabel("label.personnelbooking.economy",strsesLanguage)%></option>
									    	<option value='1'>Premium Economy</option>
									    	<option value='2'><%=dbLabelBean.getLabel("label.personnelbooking.business",strsesLanguage)%></option>
									    	<option value='3'><%=dbLabelBean.getLabel("label.personnelbooking.firstclass",strsesLanguage)%></option>
										</select>
									</td>
									
									<td style="width:120px;" class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%></td>
									<td style="width:110px;padding-right:5px;">
										<input type="text" name="deptrDate" id="deptrDate" value=""  style="width:100%;" 
											class="tableTextBox validDateBook validDate" placeholder="DD/MM/YYYY"  
											onFocus="initializeFutureDate(this);" size=12>
									</td>
									
									<td style="width:120px;" class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.departuretime",strsesLanguage)%></td>
									<td style="width:110px;padding-right:5px;">
										<select name="deptrTime" id="deptrTime" class="textBoxCss deptrTime" style="width:100.5%;" title="HHMM (24hr)">	
										<%	String strSqlStr1="SELECT PREFER_TIME FROM M_PREFER_TIME (NOLOCK) WHERE STATUS_ID=10 AND APPLICATION_ID=1 AND TIME_ID NOT IN (1,102) ORDER BY DISPLAY_ORDER ASC";
											rs = stmt1.executeQuery(strSqlStr1);
											
											while(rs.next())  {
												String tmpTime  = rs.getString("PREFER_TIME").trim().replace(":", "");
										%>		<option VALUE="<%=tmpTime%>"><%=tmpTime%></option>
										<%	}
											rs.close();	
										%>	    	
										</select>
									</td>
									<script>
										$('select.deptrTime').editableSelect({ effects: 'fade' });
									</script>
								</tr>
								<tr class="ticketDetailsRow2">	
									<td style="width:110px;" class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.arrivaldate",strsesLanguage)%></td>
									<td style="width:110px;padding-right:5px;">
										<input type="text" name="arrDate" id="arrDate" value=""  style="width:100%;" 
											class="tableTextBox validDateBook validDate" placeholder="DD/MM/YYYY"  
											onFocus="validateDates(this,'DD/MM/YYYY', 'validDateBook');"	size=12>
									</td>
									
									<td style="width:100px;" class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.arrivaltime",strsesLanguage)%></td>
									<td style="width:110px;padding-right:5px;">
										<select name="arrTime" id="arrTime" class="textBoxCss arrTime" style="width:102%;" title="HHMM (24hr)">	
										<%	String strSqlStr2="SELECT PREFER_TIME FROM M_PREFER_TIME (NOLOCK) WHERE STATUS_ID=10 AND APPLICATION_ID=1 AND TIME_ID NOT IN (1,102) ORDER BY DISPLAY_ORDER ASC";
											rs = stmt1.executeQuery(strSqlStr2);
											
											while(rs.next())  {
												String tmpTime  = rs.getString("PREFER_TIME").trim().replace(":", "");
										%>		<option VALUE="<%=tmpTime%>"><%=tmpTime%></option>
										<%	}
											rs.close();	
										%>	    	
										</select>
									</td>
									<script>
										$('select.arrTime').editableSelect({ effects: 'fade' });
									</script>
									
									<td style="width:120px;" class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.flightnumber",strsesLanguage)%></td>
									<td style="width:110px;padding-right:5px;">
										<input type="text" name="airlineType" id="airlineType" class="tableTextBox" value=""  style="width:100%;" 
										onFocus="" maxlength="30"  onkeyup="return test1(this,50,'cn');"  
										placeholder="<%=dbLabelBean.getLabel("label.personnelbooking.flightnumber",strsesLanguage)%>" 
										title="<%=dbLabelBean.getLabel("label.personnelbooking.flightnumber",strsesLanguage)%>" 
										>
									</td>
									
									<td style="width:120px;" class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.pnr",strsesLanguage)%></td>
									<td style="width:110px;padding-right:5px;">
										<input type="text" name="pnr" id="pnr" value="" class="tableTextBox" onkeyup="return test1(this,100,'cn');" style="width:100%;">
									</td>
									
									<td style="width:120px;" class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.ticketno",strsesLanguage)%></td>
									<td style="width:110px;padding-right:5px;">
										<input type="text" name="ticketNo" id="ticketNo" value="" class="tableTextBox" onkeyup="return test1(this,100,'cn');" style="width:100%;">
									</td>
									
									<td align="center" style="width:22px;padding-top:2px;">
										<img src="images/deleteNew.png?buildstamp=2_0_0" border="0" style="cursor:pointer;"  
											 id="delRow" title="<%=dbLabelBean.getLabel("button.global.delete",strsesLanguage)%>">
									</td>
								</tr>
								<tr class="ticketDetailsRow3">	
									<%-- <td style="width:110px;" class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.basicfare",strsesLanguage)%> [ INR ]</td>
									<td style="width:110px;padding-right:5px;">
										<input type="text" name="bscFare" id="bscFare" size=12 value="" class="tableTextBox" style="width:100%;text-align:right;" onkeyup="return test1(this,10,'n');" onChange="setTktTotalFareVal(this);calcTotalFare(this);">
									</td>
									
									<td style="width:100px;" class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.taxes",strsesLanguage)%> [ INR ]</td>
									<td style="width:110px;padding-right:5px;">
										<input type="text" name="taxes" id="taxes" size=12 value="" class="tableTextBox" style="width:100%;text-align:right;" onkeyup="return test1(this,10,'n');" onChange="calcTotalFare(this);">
									</td> --%>
									
									<td style="width:120px;" class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.createrequest.totalfare",strsesLanguage)%> [ INR ]</td>
									<td style="width:110px;padding-right:5px;">
										<input type="text" name="ttlFare" id="ttlFare" size=12 value="0" class="tableTextBox" onKeyUp="return test1(this,10,'n');" style="width:100%;text-align:right;" onChange="setTktTotalFareVal(this);">
									</td>
									
									<td style="width:120px;" class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.ticketstatus",strsesLanguage)%></td>
									<td style="width:110px;padding-right:5px;">
										<select name="tktStatus" id="tktStatus" class="textBoxCss" style="width:104%;">	
							<%			String sSqlStr2="SELECT Booking_Status_ID,Booking_Status FROM M_BOOKING_STATUS where Status_ID=10";
										rs = stmt1.executeQuery(sSqlStr2);
										while(rs.next()) 
										{
							%>				<option VALUE="<%=rs.getString("Booking_Status_ID").trim()%>"><%=rs.getString("Booking_Status").trim()%></option>
							<%			}
										rs.close();	
							%>
										</select>
									</td>
									
									<td style="width:120px;" class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.createrequest.remarks",strsesLanguage)%></td>
									<td style="width:110px;padding-right:5px;" colspan="2">
										<input type="text" name="tktRemarks" id="tktRemarks" value="" class="tableTextBox" onKeyUp="return test1(this,1000,'a');" style="width:100%;">
										<input type="hidden" name="tktUsers" id="tktUsers" value="" class="tktUserIdsCls"/>
									</td>
								</tr>							
							</table>
						</td>
					</tr>
				<%	}
					else if(!tBookId.equals("0") && !tBookId.equals("") &&  (tBookId != null) && !singleTktRowShowFlag)
					{	editModeFlag		= true;
						
						rs2=stmt.executeQuery("SELECT Group_User_ID,Ticket_Book_ID, Sector_From, Sector_To, Class, Departure_Date, Departure_Time, Arrival_Date, Arrival_Time, AirLine_Name, PNR, E_Ticket_No, Basic_Fare, Taxes, Total_Fare, TBD.Booking_Status_ID, Remark, convert(time,case when isnull(Departure_Time,'')='' then '00:00' else substring(replace(Departure_Time,':',''), 1, 2)+':'+substring(replace(Departure_Time,':',''), 3, 2) end) as depttime, convert(time,case when isnull(Arrival_Time,'')='' then '00:00' else substring(replace(Arrival_Time,':',''), 1, 2)+':'+substring(replace(Arrival_Time,':',''), 3, 2) end) arrtime FROM T_TRAVEL_TICKET_BOOKING_DETAIL TBD LEFT JOIN M_BOOKING_STATUS MBS ON (TBD.Booking_Status_ID=MBS.Booking_Status_ID) WHERE TRAVEL_BOOK_ID="+tBookId+" order by departure_date, depttime, arrival_date, arrtime");
						if(rs2.next()) 
						{	do
							{	tktReqDetailExists 	= true;
								tktBookId  	= rs2.getString("Ticket_Book_Id")==null?"0":rs2.getString("Ticket_Book_Id");
								secFrom1 	= rs2.getString("Sector_From")==null ? "":rs2.getString("Sector_From");
								secTo1 		= rs2.getString("Sector_To")==null ? "":rs2.getString("Sector_To");
								cls 		= rs2.getString("Class")==null ? "":rs2.getString("Class");
								deptrDate 	= rs2.getString("Departure_Date")==null ? "":revDtStr(rs2.getString("Departure_Date"));
								deptrTime 	= (rs2.getString("Departure_Time")==null || rs2.getString("Departure_Time").equals("")) ? "01:00":rs2.getString("Departure_Time");
								arrDate 	= rs2.getString("Arrival_Date") == null ? "":revDtStr(rs2.getString("Arrival_Date"));
								arrTime 	= (rs2.getString("Arrival_Time")==null || rs2.getString("Arrival_Time").equals("")) ? "01:00":rs2.getString("Arrival_Time");
								airline 	= rs2.getString("AirLine_Name")==null ? "":rs2.getString("AirLine_Name");
								pnr 		= rs2.getString("PNR")==null ? "":rs2.getString("PNR");
								eTktNo 		= rs2.getString("E_Ticket_No")==null ? "":rs2.getString("E_Ticket_No");
								basicFare 	= rs2.getString("Basic_Fare")==null ? "0":rs2.getString("Basic_Fare");
								taxes 		= rs2.getString("Taxes")==null ? "0":rs2.getString("Taxes");
								totFare 	= rs2.getString("Total_Fare")==null ? "0":rs2.getString("Total_Fare");
								tktStatus	= rs2.getString("Booking_Status_ID")==null ? "1":rs2.getString("Booking_Status_ID");
								tktRemarks 	= rs2.getString("Remark")==null ? "":rs2.getString("Remark");
								tktUsers 	= rs2.getString("Group_User_ID") == null ? "" : rs2.getString("Group_User_ID").trim();
								
								if(deptrDate.equals("01/01/1900"))
								{	deptrDate="";
								}
								if(arrDate.equals("01/01/1900"))
								{	arrDate="";
								}
								
								deptrTime 	= deptrTime.replace(":", "");
								arrTime 	= arrTime.replace(":", "");
								
								basicFare 	= Integer.toString(Math.round(Float.parseFloat(basicFare)));
								taxes 		= Integer.toString(Math.round(Float.parseFloat(taxes)));
								totFare 	= Integer.toString(Math.round(Float.parseFloat(totFare)));
								
								//System.out.println("tktBookId="+tktBookId+" cls="+cls+" tktStatus="+tktStatus);
								//System.out.println("secFrom1="+secFrom1+" secTo1="+secTo1+" airline="+airline);
								//System.out.println("deptrTime="+deptrTime+" arrTime="+arrTime);
								//System.out.println("deptrDate="+deptrDate+" arrDate="+arrDate);
								//System.out.println("pnr="+pnr+" eTktNo="+eTktNo+" basicFare="+basicFare);
								//System.out.println("taxes="+taxes+" totFare="+totFare+" tktRemarks="+tktRemarks+"\n\n");
						%>
						<tr class="ticketDetailsRow">
							<input type="hidden" id="hidTktBookId" name="hidTktBookId" value="<%=tktBookId%>"/>
							<td>
								<table width="100%" class="">
									<tr class="ticketDetailsRow1">			
										<td align="center" width="30px" class="formhead" rowspan="3">
											<b><%=++sNum%>.</b>
										</td>
										
										<td style="width:110px;" class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.sectorfrom",strsesLanguage)%></td>
										<td style="width:110px; padding-right:5px;">
											<input type="text" name="secFrom" id="secFrom" class="tableTextBox" value="<%=secFrom1%>" 
											onFocus="initializeCityName(this);" maxlength="30"  onkeyup="return test1(this,50,'a');"  
											placeholder="<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>" 
											title="<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>"  style="width:100%;"
											>
										</td>
										
										<td style="width:100px;" class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.sectorto",strsesLanguage)%></td>
										<td style="width:110px; padding-right:5px;">
											<input type="text" name="secTo" id="secTo" class="tableTextBox" value="<%=secTo1%>" 
											onFocus="initializeCityName(this);" maxlength="30"  onkeyup="return test1(this,50,'a');" 
											placeholder="<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>" 
											title="<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>"  style="width:100%;"
											>
										</td>
										
										<td style="width:120px;" class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.global.class",strsesLanguage)%></td>
										<td style="width:110px; padding-right:5px;">
											<select name="classType" id="classType" class="textBoxCss" style="width:103%;">	
										    	<option value='<%=dbLabelBean.getLabel("label.personnelbooking.economy",strsesLanguage)%>' 
											    	<% if(cls.equalsIgnoreCase(dbLabelBean.getLabel("label.personnelbooking.economy",strsesLanguage)) || cls.equalsIgnoreCase("")){%>
											    	selected="selected"
											    	<%} %>
										    	><%=dbLabelBean.getLabel("label.personnelbooking.economy",strsesLanguage)%></option>
										    	<option value='Premium Economy' 
											    	<% if(cls.equalsIgnoreCase("Premium Economy")){%>
											    	selected="selected"
											    	<%} %>
										    	>Premium Economy</option>
										    	<option value='<%=dbLabelBean.getLabel("label.personnelbooking.business",strsesLanguage)%>'  
											    	<% if(cls.equalsIgnoreCase(dbLabelBean.getLabel("label.personnelbooking.business",strsesLanguage))){%>
											    	selected="selected"
											    	<%} %>
											    ><%=dbLabelBean.getLabel("label.personnelbooking.business",strsesLanguage)%></option>
										    	<option value='<%=dbLabelBean.getLabel("label.personnelbooking.firstclass",strsesLanguage)%>'   
											    	<% if(cls.equalsIgnoreCase(dbLabelBean.getLabel("label.personnelbooking.firstclass",strsesLanguage))){%>
											    	selected="selected"
											    	<%} %>
											    ><%=dbLabelBean.getLabel("label.personnelbooking.firstclass",strsesLanguage)%></option>
											</select>
										</td>
										
										<td style="width:120px;" class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%></td>
										<td style="width:110px; padding-right:5px;">
											<input type="text" name="deptrDate" id="deptrDate" value="<%=deptrDate %>" 
												class="tableTextBox validDateBook validDate" placeholder="DD/MM/YYYY"  
												onFocus="initializeFutureDate(this);" size=12  style="width:100%;">
										</td>
										
										<td style="width:120px;" class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.departuretime",strsesLanguage)%></td>
										<td style="width:110px; padding-right:5px;">
											<select name="deptrTime" id="deptrTime" class="textBoxCss deptrTime<%=sNum-1%>" style="width:100.5%;" title="HHMM (24hr)">	
											<%	String strSqlStr1="SELECT PREFER_TIME FROM M_PREFER_TIME (NOLOCK) WHERE STATUS_ID=10 AND APPLICATION_ID=1 AND TIME_ID NOT IN (1,102) ORDER BY DISPLAY_ORDER ASC";
												rs = stmt1.executeQuery(strSqlStr1);
												
												while(rs.next())  {
													String tmpTime  = rs.getString("PREFER_TIME").trim().replace(":", "");
													if(tmpTime.equals(deptrTime)) {
											%>			<option VALUE="<%=tmpTime%>" selected="selected"><%=tmpTime%></option>
											<%		} else {
											%>			<option VALUE="<%=tmpTime%>"><%=tmpTime%></option>
											<%		}
												}
												rs.close();	
											%>	    	
											</select>
										</td>
										<script>
											var count = <%=sNum-1%>;
											$('select.deptrTime'+count).editableSelect({ effects: 'fade' });
											$('input.deptrTime'+count).val('<%=deptrTime%>');
										<%	if(subRole.indexOf("TC_TICK")== -1 && subRole.indexOf("TC_ADMI") == -1) { %>
												$('input.deptrTime'+count).css('background','#EBEBE4');
												$('input.deptrTime'+count).css('color','#6f6f6f');
												$('input.deptrTime'+count).css('border','1px solid #ABADB3');
												$('input.deptrTime'+count).css('padding','1px 0px');
												$('input.deptrTime'+count).attr('onfocus','blur();');
										<% 	} %>	
										</script>
									</tr>
									<tr class="ticketDetailsRow2">
										<td style="width:110px;" class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.arrivaldate",strsesLanguage)%></td>
										<td style="width:110px; padding-right:5px;">
											<input type="text" name="arrDate" id="arrDate" value="<%=arrDate%>" 
												class="tableTextBox validDateBook validDate" placeholder="DD/MM/YYYY"  
												onFocus="validateDates(this,'DD/MM/YYYY', 'validDateBook');" size=12  style="width:100%;">
										</td>
										
										<td style="width:100px;" class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.arrivaltime",strsesLanguage)%></td>
										<td style="width:110px; padding-right:5px;">
											<select name="arrTime" id="arrTime" class="textBoxCss arrTime<%=sNum-1%>" style="width:100.5%;" title="HHMM (24hr)">	
											<%	String strSqlStr2="SELECT PREFER_TIME FROM M_PREFER_TIME (NOLOCK) WHERE STATUS_ID=10 AND APPLICATION_ID=1 AND TIME_ID NOT IN (1,102) ORDER BY DISPLAY_ORDER ASC";
												rs = stmt1.executeQuery(strSqlStr2);
												
												while(rs.next())  {
													String tmpTime  = rs.getString("PREFER_TIME").trim().replace(":", "");
													if(tmpTime.equals(arrTime)) {
											%>			<option VALUE="<%=tmpTime%>" selected="selected"><%=tmpTime%></option>
											<%		} else {
											%>			<option VALUE="<%=tmpTime%>"><%=tmpTime%></option>
											<%		}
												}
												rs.close();	
											%>	    	
											</select>
										</td>
										<script>
											var count = <%=sNum-1%>;
											$('select.arrTime'+count).editableSelect({ effects: 'fade' });
											$('input.arrTime'+count).val('<%=arrTime%>');
										<%	if(subRole.indexOf("TC_TICK")== -1 && subRole.indexOf("TC_ADMI") == -1) { %>
												$('input.arrTime'+count).css('background','#EBEBE4');
												$('input.arrTime'+count).css('color','#6f6f6f');
												$('input.arrTime'+count).css('border','1px solid #ABADB3');
												$('input.arrTime'+count).css('padding','1px 0px');
												$('input.arrTime'+count).attr('onfocus','blur();');
										<% 	} %>	
										</script>
										
										<td style="width:120px;" class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.flightnumber",strsesLanguage)%></td>
										<td style="width:110px; padding-right:5px;">
											<input type="text" name="airlineType" id="airlineType" class="tableTextBox" value="<%=airline%>" 
											onFocus="" maxlength="30"  onkeyup="return test1(this,50,'cn');"  
											placeholder="<%=dbLabelBean.getLabel("label.personnelbooking.flightnumber",strsesLanguage)%>" 
											title="<%=dbLabelBean.getLabel("label.personnelbooking.flightnumber",strsesLanguage)%>"  style="width:100%;"
											>
										</td>
										
										<td style="width:120px;" class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.pnr",strsesLanguage)%></td>
										<td style="width:110px; padding-right:5px;">
											<input type="text" name="pnr" id="pnr" value="<%=pnr %>" class="tableTextBox" onkeyup="return test1(this,100,'cn');" style="width:100%;">
										</td>
										
										<td style="width:120px;" class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.ticketno",strsesLanguage)%></td>
										<td style="width:110px; padding-right:5px;">
											<input type="text" name="ticketNo" id="ticketNo" value="<%=eTktNo %>" class="tableTextBox" onkeyup="return test1(this,100,'cn');" style="width:100%;">
										</td>
										
									<% 	if(subRole.indexOf("TC_TICK")>=0 || subRole.indexOf("TC_ADMI")>=0) {
									%>  <td align="center" style="width:22px;padding-top:2px;">
											<img src="images/deleteNew.png?buildstamp=2_0_0" border="0" style="cursor:pointer;"  
												 id="delRow" title="<%=dbLabelBean.getLabel("button.global.delete",strsesLanguage)%>">
										</td>
									<% }%>	
									</tr>
									<tr class="ticketDetailsRow3">	
										<%-- <td style="width:110px;" class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.basicfare",strsesLanguage)%> [ INR ]</td>
										<td style="width:110px; padding-right:5px;">
											<input type="text" name="bscFare" id="bscFare" size=12 value="<%=basicFare %>" class="tableTextBox" style="width:100%;text-align:right;" onkeyup="return test1(this,10,'n');" onChange="setTktTotalFareVal(this);calcTotalFare(this);">
										</td>
										
										<td style="width:100px;" class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.taxes",strsesLanguage)%> [ INR ]</td>
										<td style="width:110px; padding-right:5px;">
											<input type="text" name="taxes" id="taxes" size=12 value="<%=taxes %>" class="tableTextBox" style="width:100%;text-align:right;" onkeyup="return test1(this,10,'n');" onChange="calcTotalFare(this);">
										</td> --%>
										
										<td style="width:120px;" class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.createrequest.totalfare",strsesLanguage)%> [ INR ]</td>
										<td style="width:110px; padding-right:5px;">
											<input type="text" name="ttlFare" id="ttlFare" size=12 value="<%=totFare %>" class="tableTextBox" onKeyUp="return test1(this,10,'n');" style="width:100%;text-align:right;" onChange="setTktTotalFareVal(this);">
										</td>
										
										<td style="width:120px;" class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.ticketstatus",strsesLanguage)%></td>
										<td style="width:110px; padding-right:5px;">
											<select name="tktStatus" id="tktStatus" class="textBoxCss" style="width:104%;">	
								<%			String sSqlStr2="SELECT Booking_Status_ID,Booking_Status FROM M_BOOKING_STATUS where Status_ID=10";
											rs = stmt1.executeQuery(sSqlStr2);
											
											while(rs.next())  {
												if(rs.getString("Booking_Status_ID").trim().equals(tktStatus)) {
								%>					<option VALUE="<%=rs.getString("Booking_Status_ID").trim()%>" selected="selected"><%=rs.getString("Booking_Status").trim()%></option>
								<%				} else {
								%>					<option VALUE="<%=rs.getString("Booking_Status_ID").trim()%>"><%=rs.getString("Booking_Status").trim()%></option>
								<%				}
											}
											rs.close();	
								%>	    	
											</select>
										</td>
										
										<td style="width:120px;" class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.createrequest.remarks",strsesLanguage)%></td>
										<td style="width:110px; padding-right:5px;" colspan="2">
											<input type="text" name="tktRemarks" id="tktRemarks" value="<%=tktRemarks %>" class="tableTextBox" onkeyup="return test1(this,1000,'a');" style="width:100%;">
											<input type="hidden" name="tktUsers" id="tktUsers" value="<%=tktUsers%>" class="tktUserIdsCls"/>
										</td>
									</tr>							
								</table>
							</td>
						</tr>
					<%		}while(rs2.next());	
						}
						else
						{	tktBookId	= "0";	
					%>
						<tr class="ticketDetailsRow" id="emptyTicketDetailsRow">
							<input type="hidden" id="hidTktBookId" name="hidTktBookId" value="<%=tktBookId%>"/>
							<td>
								<table width="100%" class="">
									<tr class="ticketDetailsRow1">
										<td align="center" width="30px" class="formhead" rowspan="3">
											<b><label name="sno" id="sno">1</label>.</b>
										</td>
										
										<td style="width:110px;" class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.sectorfrom",strsesLanguage)%></td>
										<td style="width:110px;padding-right:5px;">
											<input type="text" name="secFrom" id="secFrom" class="tableTextBox" value="" 
											onFocus="initializeCityName(this);" maxlength="30"  onkeyup="return test1(this,50,'a');" 
											placeholder="<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>" 
											title="<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>"  style="width:100%;"
											>
										</td>
										
										<td style="width:100px;" class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.sectorto",strsesLanguage)%></td>
										<td style="width:110px;padding-right:5px;">
											<input type="text" name="secTo" id="secTo" class="tableTextBox" value="" 
											onFocus="initializeCityName(this);" maxlength="30"  onkeyup="return test1(this,50,'a');" 
											placeholder="<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>" 
											title="<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>"  style="width:100%;"
											> 
										</td>
										
										<td style="width:120px;" class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.global.class",strsesLanguage)%></td>
										<td style="width:110px;padding-right:5px;">
											<select name="classType" id="classType" class="textBoxCss" style="width:103%;">	
										    	<option value='0' selected="selected"><%=dbLabelBean.getLabel("label.personnelbooking.economy",strsesLanguage)%></option>
										    	<option value='1'>Premium Economy</option>
										    	<option value='2'><%=dbLabelBean.getLabel("label.personnelbooking.business",strsesLanguage)%></option>
										    	<option value='3'><%=dbLabelBean.getLabel("label.personnelbooking.firstclass",strsesLanguage)%></option>
											</select>
										</td>
										
										<td style="width:120px;" class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%></td>
										<td style="width:110px;padding-right:5px;">
											<input type="text" name="deptrDate" id="deptrDate" value=""  style="width:100%;" 
												class="tableTextBox validDateBook validDate" placeholder="DD/MM/YYYY"  
												onFocus="initializeFutureDate(this);" size=12>
										</td>
										
										<td style="width:120px;" class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.departuretime",strsesLanguage)%></td>
										<td style="width:110px;padding-right:5px;">
											<select name="deptrTime" id="deptrTime" class="textBoxCss deptrTime" style="width:100.5%;" title="HHMM (24hr)">	
											<%	String strSqlStr1="SELECT PREFER_TIME FROM M_PREFER_TIME (NOLOCK) WHERE STATUS_ID=10 AND APPLICATION_ID=1 AND TIME_ID NOT IN (1,102) ORDER BY DISPLAY_ORDER ASC";
												rs = stmt1.executeQuery(strSqlStr1);
												
												while(rs.next())  {
													String tmpTime  = rs.getString("PREFER_TIME").trim().replace(":", "");
											%>		<option VALUE="<%=tmpTime%>"><%=tmpTime%></option>
											<%	}
												rs.close();	
											%>	    	
											</select>
										</td>
										<script>
											$('select.deptrTime').editableSelect({ effects: 'fade' });
										</script>
									</tr>
									<tr class="ticketDetailsRow2">	
										<td style="width:110px;" class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.arrivaldate",strsesLanguage)%></td>
										<td style="width:110px;padding-right:5px;">
											<input type="text" name="arrDate" id="arrDate" value=""  style="width:100%;" 
												class="tableTextBox validDateBook validDate" placeholder="DD/MM/YYYY"  
												onFocus="validateDates(this,'DD/MM/YYYY', 'validDateBook');"	size=12>
										</td>
										
										<td style="width:100px;" class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.arrivaltime",strsesLanguage)%></td>
										<td style="width:110px;padding-right:5px;">
											<select name="arrTime" id="arrTime" class="textBoxCss arrTime" style="width:102%;" title="HHMM (24hr)">	
											<%	String strSqlStr2="SELECT PREFER_TIME FROM M_PREFER_TIME (NOLOCK) WHERE STATUS_ID=10 AND APPLICATION_ID=1 AND TIME_ID NOT IN (1,102) ORDER BY DISPLAY_ORDER ASC";
												rs = stmt1.executeQuery(strSqlStr2);
												
												while(rs.next())  {
													String tmpTime  = rs.getString("PREFER_TIME").trim().replace(":", "");
											%>		<option VALUE="<%=tmpTime%>"><%=tmpTime%></option>
											<%	}
												rs.close();	
											%>	    	
											</select>
										</td>
										<script>
											$('select.arrTime').editableSelect({ effects: 'fade' });
										</script>
										
										<td style="width:120px;" class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.flightnumber",strsesLanguage)%></td>
										<td style="width:110px;padding-right:5px;">
											<input type="text" name="airlineType" id="airlineType" class="tableTextBox" value=""  style="width:100%;" 
											onFocus="" maxlength="30"  onkeyup="return test1(this,50,'cn');"  
											placeholder="<%=dbLabelBean.getLabel("label.personnelbooking.flightnumber",strsesLanguage)%>" 
											title="<%=dbLabelBean.getLabel("label.personnelbooking.flightnumber",strsesLanguage)%>" 
											>
										</td>
										
										<td style="width:120px;" class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.pnr",strsesLanguage)%></td>
										<td style="width:110px;padding-right:5px;">
											<input type="text" name="pnr" id="pnr" value="" class="tableTextBox" onkeyup="return test1(this,100,'cn');" style="width:100%;">
										</td>
										
										<td style="width:120px;" class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.ticketno",strsesLanguage)%></td>
										<td style="width:110px;padding-right:5px;">
											<input type="text" name="ticketNo" id="ticketNo" value="" class="tableTextBox" onkeyup="return test1(this,100,'cn');" style="width:100%;">
										</td>
										
										<td align="center" style="width:22px;"></td>
									</tr>
									<tr class="ticketDetailsRow3">	
										<%-- <td style="width:110px;" class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.basicfare",strsesLanguage)%> [ INR ]</td>
										<td style="width:110px;padding-right:5px;">
											<input type="text" name="bscFare" id="bscFare" size=12 value="" class="tableTextBox" style="width:100%;text-align:right;" onkeyup="return test1(this,10,'n');" onChange="setTktTotalFareVal(this);calcTotalFare(this);">
										</td>
										
										<td style="width:100px;" class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.taxes",strsesLanguage)%> [ INR ]</td>
										<td style="width:110px;padding-right:5px;">
											<input type="text" name="taxes" id="taxes" size=12 value="" class="tableTextBox" style="width:100%;text-align:right;" onkeyup="return test1(this,10,'n');" onChange="calcTotalFare(this);">
										</td> --%>
										
										<td style="width:120px;" class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.createrequest.totalfare",strsesLanguage)%> [ INR ]</td>
										<td style="width:110px;padding-right:5px;">
											<input type="text" name="ttlFare" id="ttlFare" size=12 value="0" class="tableTextBox" onKeyUp="return test1(this,10,'n');" style="width:100%;text-align:right;" onChange="setTktTotalFareVal(this);">
										</td>
										
										<td style="width:120px;" class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.ticketstatus",strsesLanguage)%></td>
										<td style="width:110px;padding-right:5px;">
											<select name="tktStatus" id="tktStatus" class="textBoxCss" style="width:104%;">	
								<%			String sSqlStr2="SELECT Booking_Status_ID,Booking_Status FROM M_BOOKING_STATUS where Status_ID=10";
											rs = stmt1.executeQuery(sSqlStr2);
											while(rs.next()) 
											{
								%>				<option VALUE="<%=rs.getString("Booking_Status_ID").trim()%>"><%=rs.getString("Booking_Status").trim()%></option>
								<%			}
											rs.close();	
								%>
											</select>
										</td>
										
										<td style="width:120px;" class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.createrequest.remarks",strsesLanguage)%></td>
										<td style="width:110px;padding-right:5px;" colspan="2">
											<input type="text" name="tktRemarks" id="tktRemarks" value="" class="tableTextBox" onKeyUp="return test1(this,1000,'a');" style="width:100%;">
											<input type="hidden" name="tktUsers" id="tktUsers" value="" class="tktUserIdsCls"/>
										</td>
									</tr>							
								</table>
							</td>
						</tr>
					<%	}	
						//rs2.close();
					}
					else if(subRole.indexOf("TC_TICK") > -1 || subRole.indexOf("TC_ADMI") > -1)
					{	tktBookId	= "0";	
					%>
					<tr class="ticketDetailsRow" id="emptyTicketDetailsRow">
						<input type="hidden" id="hidTktBookId" name="hidTktBookId" value="<%=tktBookId%>"/>
						<td>
							<table width="100%" class="">
								<tr class="ticketDetailsRow1">
									<td align="center" width="30px" class="formhead" rowspan="3">
										<b><label name="sno" id="sno">1</label>.</b>
									</td>
									
									<td style="width:110px;" class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.sectorfrom",strsesLanguage)%></td>
									<td style="width:110px;padding-right:5px;">
										<input type="text" name="secFrom" id="secFrom" class="tableTextBox" value="" 
										onFocus="initializeCityName(this);" maxlength="30"  onkeyup="return test1(this,50,'a');" 
										placeholder="<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>" 
										title="<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>"  style="width:100%;"
										>
									</td>
									
									<td style="width:100px;" class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.sectorto",strsesLanguage)%></td>
									<td style="width:110px;padding-right:5px;">
										<input type="text" name="secTo" id="secTo" class="tableTextBox" value="" 
										onFocus="initializeCityName(this);" maxlength="30"  onkeyup="return test1(this,50,'a');" 
										placeholder="<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>" 
										title="<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>"  style="width:100%;"
										> 
									</td>
									
									<td style="width:120px;" class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.global.class",strsesLanguage)%></td>
									<td style="width:110px;padding-right:5px;">
										<select name="classType" id="classType" class="textBoxCss" style="width:103%;">	
									    	<option value='0' selected="selected"><%=dbLabelBean.getLabel("label.personnelbooking.economy",strsesLanguage)%></option>
									    	<option value='1'>Premium Economy</option>
									    	<option value='2'><%=dbLabelBean.getLabel("label.personnelbooking.business",strsesLanguage)%></option>
									    	<option value='3'><%=dbLabelBean.getLabel("label.personnelbooking.firstclass",strsesLanguage)%></option>
										</select>
									</td>
									
									<td style="width:120px;" class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%></td>
									<td style="width:110px;padding-right:5px;">
										<input type="text" name="deptrDate" id="deptrDate" value=""  style="width:100%;" 
											class="tableTextBox validDateBook validDate" placeholder="DD/MM/YYYY"  
											onFocus="initializeFutureDate(this);" size=12>
									</td>
									
									<td style="width:120px;" class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.departuretime",strsesLanguage)%></td>
									<td style="width:110px;padding-right:5px;">
										<select name="deptrTime" id="deptrTime" class="textBoxCss deptrTime" style="width:100.5%;" title="HHMM (24hr)">
											<%	String strSqlStr1="SELECT PREFER_TIME FROM M_PREFER_TIME (NOLOCK) WHERE STATUS_ID=10 AND APPLICATION_ID=1 AND TIME_ID NOT IN (1,102) ORDER BY DISPLAY_ORDER ASC";
												rs = stmt1.executeQuery(strSqlStr1);
												
												while(rs.next())  {
													String tmpTime  = rs.getString("PREFER_TIME").trim().replace(":", "");
											%>		<option VALUE="<%=tmpTime%>"><%=tmpTime%></option>
											<%	}
												rs.close();	
											%>	    	
										</select>
									</td>
									<script>
										$('select.deptrTime').editableSelect({ effects: 'fade' });
									</script>
								</tr>
								<tr class="ticketDetailsRow2">	
									<td style="width:110px;" class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.arrivaldate",strsesLanguage)%></td>
									<td style="width:110px;padding-right:5px;">
										<input type="text" name="arrDate" id="arrDate" value=""  style="width:100%;" 
											class="tableTextBox validDateBook validDate" placeholder="DD/MM/YYYY"  
											onFocus="validateDates(this,'DD/MM/YYYY', 'validDateBook');"	size=12>
									</td>
									
									<td style="width:100px;" class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.arrivaltime",strsesLanguage)%></td>
									<td style="width:110px;padding-right:5px;">
										<select name="arrTime" id="arrTime" class="textBoxCss arrTime" style="width:102%;" title="HHMM (24hr)">	
											<%	String strSqlStr2="SELECT PREFER_TIME FROM M_PREFER_TIME (NOLOCK) WHERE STATUS_ID=10 AND APPLICATION_ID=1 AND TIME_ID NOT IN (1,102) ORDER BY DISPLAY_ORDER ASC";
												rs = stmt1.executeQuery(strSqlStr2);
												
												while(rs.next())  {
													String tmpTime  = rs.getString("PREFER_TIME").trim().replace(":", "");
											%>		<option VALUE="<%=tmpTime%>"><%=tmpTime%></option>
											<%	}
												rs.close();	
											%>	    	
										</select>
									</td>
									<script>
										$('select.arrTime').editableSelect({ effects: 'fade' });
									</script>
									
									<td style="width:120px;" class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.flightnumber",strsesLanguage)%></td>
									<td style="width:110px;padding-right:5px;">
										<input type="text" name="airlineType" id="airlineType" class="tableTextBox" value=""  style="width:100%;" 
										onFocus="" maxlength="30"  onkeyup="return test1(this,50,'cn');"  
										placeholder="<%=dbLabelBean.getLabel("label.personnelbooking.flightnumber",strsesLanguage)%>" 
										title="<%=dbLabelBean.getLabel("label.personnelbooking.flightnumber",strsesLanguage)%>" 
										>
									</td>
									
									<td style="width:120px;" class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.pnr",strsesLanguage)%></td>
									<td style="width:110px;padding-right:5px;">
										<input type="text" name="pnr" id="pnr" value="" class="tableTextBox" onkeyup="return test1(this,100,'cn');" style="width:100%;">
									</td>
									
									<td style="width:120px;" class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.ticketno",strsesLanguage)%></td>
									<td style="width:110px;padding-right:5px;">
										<input type="text" name="ticketNo" id="ticketNo" value="" class="tableTextBox" onkeyup="return test1(this,100,'cn');" style="width:100%;">
									</td>
									
									<td align="center" style="width:22px;"></td>
								</tr>
								<tr class="ticketDetailsRow3">	
									<%-- <td style="width:110px;" class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.basicfare",strsesLanguage)%> [ INR ]</td>
									<td style="width:110px;padding-right:5px;">
										<input type="text" name="bscFare" id="bscFare" size=12 value="" class="tableTextBox" style="width:100%;text-align:right;" onkeyup="return test1(this,10,'n');" onChange="setTktTotalFareVal(this);calcTotalFare(this);">
									</td>
									
									<td style="width:100px;" class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.taxes",strsesLanguage)%> [ INR ]</td>
									<td style="width:110px;padding-right:5px;">
										<input type="text" name="taxes" id="taxes" size=12 value="" class="tableTextBox" style="width:100%;text-align:right;" onkeyup="return test1(this,10,'n');" onChange="calcTotalFare(this);">
									</td> --%>
									
									<td style="width:120px;" class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.createrequest.totalfare",strsesLanguage)%> [ INR ]</td>
									<td style="width:110px;padding-right:5px;">
										<input type="text" name="ttlFare" id="ttlFare" size=12 value="0" class="tableTextBox" onKeyUp="return test1(this,10,'n');" style="width:100%;text-align:right;" onChange="setTktTotalFareVal(this);">
									</td>
									
									<td style="width:120px;" class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.ticketstatus",strsesLanguage)%></td>
									<td style="width:110px;padding-right:5px;">
										<select name="tktStatus" id="tktStatus" class="textBoxCss" style="width:104%;">	
								<%			String sSqlStr2="SELECT Booking_Status_ID,Booking_Status FROM M_BOOKING_STATUS where Status_ID=10";
											rs = stmt1.executeQuery(sSqlStr2);
											while(rs.next()) 
											{
								%>				<option VALUE="<%=rs.getString("Booking_Status_ID").trim()%>"><%=rs.getString("Booking_Status").trim()%></option>
								<%			}
											rs.close();	
								%>
										</select>
									</td>
									
									<td style="width:120px;" class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.createrequest.remarks",strsesLanguage)%></td>
									<td style="width:110px;padding-right:5px;" colspan="2">
										<input type="text" name="tktRemarks" id="tktRemarks" value="" class="tableTextBox" onKeyUp="return test1(this,1000,'a');" style="width:100%;">
										<input type="hidden" name="tktUsers" id="tktUsers" value="" class="tktUserIdsCls"/>
									</td>
								</tr>							
							</table>
						</td>
					</tr>
					<%	
					}
					%>
					<tr class="innerTktInfoRow"></tr>
					<tr class="tktInfoPrototypeRow hide">
						<input type="hidden" name="hidTktBookIdPT" id="hidTktBookId" value="0"/>
						<td>
							<table width="100%" class="">
								<tr class="tktInfoPrototypeRow1">
									<td align="center" width="30px" class="formhead" rowspan="3">
										<b><label name="snoPT" id="sno" >2</label>.</b>
									</td>
								
									<td style="width:110px;" class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.sectorfrom",strsesLanguage)%></td>
									<td style="width:110px;padding-right:5px;">
										<input type="text" name="secFromPT" id="secFrom" class="tableTextBox" value="" 
										onFocus="initializeCityName(this);" maxlength="30"  onkeyup="return test1(this,50,'a');" 
										placeholder="<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>" 
										title="<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>"  style="width:100%;"
										>
									</td>
									
									<td style="width:100px;" class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.sectorto",strsesLanguage)%></td>
									<td style="width:110px;padding-right:5px;">
										<input type="text" name="secToPT" id="secTo" class="tableTextBox" value="" 
										onFocus="initializeCityName(this);" maxlength="30"  onkeyup="return test1(this,50,'a');" 
										placeholder="<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>" 
										title="<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>"  style="width:100%;"
										> 
									</td>
									
									<td style="width:120px;" class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.global.class",strsesLanguage)%></td>
									<td style="width:110px;padding-right:5px;">
										<select name="classTypePT" id="classType" class="textBoxCss" style="width:103%;">	
									    	<option value='0' selected="selected"><%=dbLabelBean.getLabel("label.personnelbooking.economy",strsesLanguage)%></option>
									    	<option value='1'>Premium Economy</option>
									    	<option value='2'><%=dbLabelBean.getLabel("label.personnelbooking.business",strsesLanguage)%></option>
									    	<option value='3'><%=dbLabelBean.getLabel("label.personnelbooking.firstclass",strsesLanguage)%></option>
										</select>
									</td>
									
									<td style="width:120px;" class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%></td>
									<td style="width:110px;padding-right:5px;">
										<input type="text" name="deptrDatePT" id="deptrDate" value=""  style="width:100%;" 
											class="tableTextBox validDateBook validDate" placeholder="DD/MM/YYYY"  
											onFocus="validateDates(this,'DD/MM/YYYY', 'validDateBook');" size=12>
									</td>
									
									<td style="width:120px;" class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.departuretime",strsesLanguage)%></td>
									<td style="width:110px;padding-right:5px;">
										<select name="deptrTimePT" id="deptrTime" class="textBoxCss deptrTime" style="width:100.5%;" title="HHMM (24hr)">	
											<%	String strSqlStr1="SELECT PREFER_TIME FROM M_PREFER_TIME (NOLOCK) WHERE STATUS_ID=10 AND APPLICATION_ID=1 AND TIME_ID NOT IN (1,102) ORDER BY DISPLAY_ORDER ASC";
												rs = stmt1.executeQuery(strSqlStr1);
												
												while(rs.next())  {
													String tmpTime  = rs.getString("PREFER_TIME").trim().replace(":", "");
											%>		<option VALUE="<%=tmpTime%>"><%=tmpTime%></option>
											<%	}
												rs.close();	
											%>	    	
										</select>
									</td>
								</tr>
								<tr class="tktInfoPrototypeRow2">	
									<td style="width:110px;" class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.arrivaldate",strsesLanguage)%></td>
									<td style="width:110px;padding-right:5px;">
										<input type="text" name="arrDatePT" id="arrDate" value=""  style="width:100%;" 
											class="tableTextBox validDateBook validDate" placeholder="DD/MM/YYYY"  
											onFocus="validateDates(this,'DD/MM/YYYY', 'validDateBook');" size=12>
									</td>
									
									<td style="width:100px;" class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.arrivaltime",strsesLanguage)%></td>
									<td style="width:110px;padding-right:5px;">
										<select name="arrTimePT" id="arrTime" class="textBoxCss arrTime" style="width:102%;" title="HHMM (24hr)">	
											<%	String strSqlStr2="SELECT PREFER_TIME FROM M_PREFER_TIME (NOLOCK) WHERE STATUS_ID=10 AND APPLICATION_ID=1 AND TIME_ID NOT IN (1,102) ORDER BY DISPLAY_ORDER ASC";
												rs = stmt1.executeQuery(strSqlStr2);
												
												while(rs.next())  {
													String tmpTime  = rs.getString("PREFER_TIME").trim().replace(":", "");
											%>		<option VALUE="<%=tmpTime%>"><%=tmpTime%></option>
											<%	}
												rs.close();	
											%>	    	
										</select>
									</td>
									
									<td style="width:120px;" class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.flightnumber",strsesLanguage)%></td>
									<td style="width:110px;padding-right:5px;">
										<input type="text" name="airlineTypePT" id="airlineType" class="tableTextBox" value=""  style="width:100%;" 
										onFocus="" maxlength="30"  onkeyup="return test1(this,50,'cn');"  
										placeholder="<%=dbLabelBean.getLabel("label.personnelbooking.flightnumber",strsesLanguage)%>" 
										title="<%=dbLabelBean.getLabel("label.personnelbooking.flightnumber",strsesLanguage)%>" 
										>
									</td>
									
									<td style="width:120px;" class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.pnr",strsesLanguage)%></td>
									<td style="width:110px;padding-right:5px;">
										<input type="text" name="pnrPT" id="pnr" value="" class="tableTextBox" onkeyup="return test1(this,100,'cn');" style="width:100%;">
									</td>
									
									<td style="width:120px;" class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.ticketno",strsesLanguage)%></td>
									<td style="width:110px;padding-right:5px;">
										<input type="text" name="ticketNoPT" id="ticketNo" value="" class="tableTextBox" onkeyup="return test1(this,100,'cn');" style="width:100%;">
									</td>
									
									<td align="center" style="width:22px;padding-top:2px;">
										<img src="images/deleteNew.png?buildstamp=2_0_0" border="0" style="cursor:pointer;"  
											 id="delRow" title="<%=dbLabelBean.getLabel("button.global.delete",strsesLanguage)%>">
									</td>
								</tr>
								<tr class="tktInfoPrototypeRow3">	
									<%-- <td style="width:110px;" class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.basicfare",strsesLanguage)%> [ INR ]</td>
									<td style="width:110px;padding-right:5px;">
										<input type="text" name="bscFarePT" id="bscFare" size=12 value="" class="tableTextBox" style="width:100%;text-align:right;" onkeyup="return test1(this,10,'n');" onChange="setTktTotalFareVal(this);calcTotalFare(this);">
									</td>
									
									<td style="width:100px;" class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.taxes",strsesLanguage)%> [ INR ]</td>
									<td style="width:110px;padding-right:5px;">
										<input type="text" name="taxesPT" id="taxes" size=12 value="" class="tableTextBox" style="width:100%;text-align:right;" onkeyup="return test1(this,10,'n');" onChange="calcTotalFare(this);">
									</td> --%>
									
									<td style="width:120px;" class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.createrequest.totalfare",strsesLanguage)%> [ INR ]</td>
									<td style="width:110px;padding-right:5px;">
										<input type="text" name="ttlFarePT" id="ttlFare" size=12 value="0" class="tableTextBox" onKeyUp="return test1(this,10,'n');" style="width:100%;text-align:right;" onChange="setTktTotalFareVal(this);">
									</td>
									
									<td style="width:120px;" class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.ticketstatus",strsesLanguage)%></td>
									<td style="width:110px;padding-right:5px;">
										<select name="tktStatusPT" id="tktStatus" class="textBoxCss" style="width:104%;">	
								<%			String sSqlStr2="SELECT Booking_Status_ID,Booking_Status FROM M_BOOKING_STATUS where Status_ID=10";
											rs = stmt1.executeQuery(sSqlStr2);
											while(rs.next()) 
											{
								%>				<option VALUE="<%=rs.getString("Booking_Status_ID").trim()%>"><%=rs.getString("Booking_Status").trim()%></option>
								<%			}
											rs.close();	
								%>
										</select>
									</td>
									
									<td style="width:120px;" class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.createrequest.remarks",strsesLanguage)%></td>
									<td style="width:110px;padding-right:5px;" colspan="2">
										<input type="text" name="tktRemarksPT" id="tktRemarks" value="" class="tableTextBox" onKeyUp="return test1(this,1000,'a');" style="width:100%;">
										<input type="hidden" name="tktUsersPT" id="tktUsers" value=""/>
									</td>
								</tr>							
							</table>
						</td>
					</tr>
					</tbody>
				</table>
				<input type="hidden" name="hidTicketDataFlag" id="hidTicketDataFlag" value="<%=tktReqDetailExists%>"/>
			</div>
		</div>
		
		<div id="VisaReq" style="margin:0 auto;_text-align:left;">
		<br/>
			<table>
				<tr>
					<td>
						<ul class="pagebullet">
				      		<li class="pageHead" width="50px">
								<td text-align="left"><b><%=dbLabelBean.getLabel("label.global.visarequired",strsesLanguage)%></b></td>
							</li>
						</ul>
					</td>	
					<td width="138px"></td>
					<td>
						<div id="visaYN">
						<table width="100%" border="0" cellspacing="0" cellpadding="0" class="checkbox">
							<tr>
								<td class="labelTd">
									<label class="yes" id="VisaReqYes"> 
										<input type="radio" name="visa" value="1" id="VisaReq_Y">
											<%=dbLabelBean.getLabel("label.global.yes",strsesLanguage)%>
									</label>
								</td>
								<td class="labelTd">
									<label class="no" id="VisaReqNo"> 
										<input type="radio"	name="visa" value="2" checked="checked"	id="VisaReq_N">
											<%=dbLabelBean.getLabel("label.global.no",strsesLanguage)%>
									</label>
								</td>
							</tr>
						</table>
						</div>
					</td>
				</tr>
			</table>
			<div id="visaInfo" class="hide">
				<table width="100%" align="center" border="0" cellpadding="5" cellspacing="1" id="visaInfoTable">
					<tbody>
					<%
					if((tBookId != "0") && (tBookId != "") && (tBookId != null))
					{	editModeFlag		= true;
					
						rs6=stmt.executeQuery("SELECT Visa_Status_Id,Visa_Book_id, Passport_No, Passport_Expiry_Date, Visa_Type, Country_Name, Doc_Recived_Date, Visa_Issuance_Date, Valid_From, Valid_To, Duration_of_Stay, Visa_Validity, Amount, Remark FROM T_TRAVEL_VISA_BOOKING_DETAIL  WHERE TRAVEL_BOOK_ID="+tBookId);
						if(rs6.next()) 
						{	do 
							{	visaReqDetailExists	=  true;
							                  
								visaStatusId= rs6.getString("Visa_Status_Id")==null ? "0":rs6.getString("Visa_Status_Id");
								visaBookId	= rs6.getString("Visa_Book_id")==null ? "0":rs6.getString("Visa_Book_id");
								pptNo 		= rs6.getString("Passport_No")==null ? "":rs6.getString("Passport_No");
								pptExpDt 	= rs6.getString("Passport_Expiry_Date")==null ? "":revDtStr(rs6.getString("Passport_Expiry_Date"));
								visaType 	= rs6.getString("Visa_Type")==null?"":rs6.getString("Visa_Type");
								country1 	= rs6.getString("Country_Name")==null?"":rs6.getString("Country_Name");
								docRecDt 	= rs6.getString("Doc_Recived_Date")==null ? "":revDtStr(rs6.getString("Doc_Recived_Date"));
								visaIssDt 	= rs6.getString("Visa_Issuance_Date")==null ? "":revDtStr(rs6.getString("Visa_Issuance_Date"));
								visaValFrom = rs6.getString("Valid_From")==null ? "":revDtStr(rs6.getString("Valid_From"));
								visaValTo 	= rs6.getString("Valid_To")==null ? "":revDtStr(rs6.getString("Valid_To"));
								durOfStay 	= rs6.getString("Duration_of_Stay")==null ? "":rs6.getString("Duration_of_Stay");
								entryType 	= rs6.getString("Visa_Validity")==null ? "":rs6.getString("Visa_Validity");
								visaCharges = rs6.getString("Amount")==null ? "0":rs6.getString("Amount");
								visaRemarks = rs6.getString("Remark")==null ? "":rs6.getString("Remark");
								
								if(pptExpDt.equals("01/01/1900"))
								{	pptExpDt="";
								}
								if(docRecDt.equals("01/01/1900"))
								{	docRecDt="";
								}
								if(visaIssDt.equals("01/01/1900"))
								{	visaIssDt="";
								}
								if(visaValFrom.equals("01/01/1900"))
								{	visaValFrom="";
								}
								if(visaValTo.equals("01/01/1900"))
								{	visaValTo="";
								}
								
								visaCharges = Integer.toString(Math.round(Float.parseFloat(visaCharges)));
								
								//System.out.println("visaBookId="+visaBookId+" visaStatusId="+visaStatusId+" pptNo="+pptNo);
								//System.out.println("pptExpDt="+pptExpDt+" visaType="+visaType+" country1="+country1+" docRecDt="+docRecDt);
								//System.out.println("visaIssDt="+visaIssDt+" visaValFrom="+visaValFrom+" visaValTo="+visaValTo);
								//System.out.println("durOfStay="+durOfStay+" entryType="+entryType+" visaCharges="+visaCharges);
								//System.out.println("visaRemarks="+visaRemarks+"\n\n");
						%>
						<tr class="visaDetailsRow">
							<input type="hidden" name="hidVisaBookId" id="hidVisaBookId" value="<%=visaBookId%>"/>
							<td>
								<table width="100%" class="">
									<tr class="visaDetailsRow1">
										<td align="center" width="30px" class="formhead" rowspan="3">
											<b><%=++sNum3%>.</b>
										</td>
										
										<td class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.visastatus",strsesLanguage)%></td>
										<td style="width:100px;">
											<select name="visaStatus" id="visaStatus" class="textBoxCss"  style="width:100%;">	
												<!-- <option value="0">Select Status</option> -->    	
								<%			String sSqlStr="SELECT DISTINCT Visa_Status_Id,Visa_Status FROM M_VISA_BOOKING_STATUS where visa_status='VISA Received';";
											rs = stmt1.executeQuery(sSqlStr);
											while(rs.next()) {
												if(rs.getString("Visa_Status_Id").equals(visaStatusId)) {
								%>				
													<option VALUE="<%=rs.getString("Visa_Status_Id").trim()%>" selected="selected"><%=rs.getString("Visa_Status").trim()%></option>
								<%			
												} else {
								%>
													<option VALUE="<%=rs.getString("Visa_Status_Id").trim()%>"><%=rs.getString("Visa_Status").trim()%></option>
								<%			
												}
											}
											rs.close();	
								%>			</select>
										</td>
										
										<td class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.createrequest.passportnumber",strsesLanguage)%></td>
										<td style="width:110px;padding-right:5px;">
											<input type="text" name="pprtNo" id="pprtNo" value="<%=pptNo %>" class="tableTextBox" onKeyUp="return test1(this,30,'cn');" style="width:100%;">
										</td>
										
										<td class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.global.expirydate",strsesLanguage)%></td>
										<td style="width:100px;padding-right:5px;">
											<input type="text" name="ppExpDate" id="ppExpDate" value="<%=pptExpDt %>" 
												class="tableTextBox validDateBook validDate" placeholder="DD/MM/YYYY"  
												onFocus="initializeFutureDate(this);" style="width:100%;">
										</td>
										
										<td class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.type",strsesLanguage)%></td>
										<td style="width:100px;padding-right:5px;">
											<select name="visaType" id="visaType" class="textBoxCss"  style="width:104%;">	
										    	<option value='0' 
										    		<% if(visaType.equalsIgnoreCase("Business") || visaType.equalsIgnoreCase("")){%>
											    	selected="selected"
											    	<%} %>
										    	><%=dbLabelBean.getLabel("label.personnelbooking.business",strsesLanguage)%></option>
										    	<option value='1' 
										    		<% if(visaType.equalsIgnoreCase("Work Permit")){%>
											    	selected="selected"
											    	<%} %>
										    	><%=dbLabelBean.getLabel("label.personnelbooking.workpermit",strsesLanguage)%></option>
										    	<option value='2' 
										    		<% if(visaType.equalsIgnoreCase("Tourist")){%>
											    	selected="selected"
											    	<%} %>
										    	><%=dbLabelBean.getLabel("label.personnelbooking.tourist",strsesLanguage)%></option>
										    	<option value='3' 
										    		<% if(visaType.equalsIgnoreCase("Dependent")){%>
											    	selected="selected"
											    	<%} %>
										    	><%=dbLabelBean.getLabel("label.personnelbooking.dependent",strsesLanguage)%></option>
											</select>
										</td>
										
										<td class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.user.country",strsesLanguage)%></td>
										<td style="padding-right:5px;">
											<input type="text" name="country" id="country" class="tableTextBox" value="<%=country1%>" 
												onFocus="initializeCountryName(this);" maxlength="30"  onkeyup="return test1(this,100,'c');"  
												placeholder="<%=dbLabelBean.getLabel("label.user.country",strsesLanguage)%>" 
												title="<%=dbLabelBean.getLabel("label.user.country",strsesLanguage)%>" style="width:100%;" 
											>
										</td>
									</tr>
									<tr class="visaDetailsRow2">	
										<%-- <td class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.docrecdate",strsesLanguage)%></td>
										<td style="width:100px;" class="docRecDateTd">
											<input type="text" name="docRecDate" id="docRecDate" value="<%=docRecDt %>" 
												class="tableTextBox validDatevisa validDate" placeholder="DD/MM/YYYY"  
												onFocus="initializeDocRecDate(this);"	size=15>
										</td>
										
										<td class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.visaissuancedate",strsesLanguage)%></td>
										<td style="width:110px;padding-right:5px;">
											<input type="text" name="visaIssuDate" id="visaIssuDate" value="<%=visaIssDt %>" 
												class="tableTextBox validDatevisa validDate" placeholder="DD/MM/YYYY"  
												onFocus="initializeDate(this);" style="width:100%;">
										</td> --%>
										
										<td class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.visavalidfrom",strsesLanguage)%></td>
										<td style="width:100px;padding-right:5px;">
											<input type="text" name="visaValFrom" id="visaValFrom" value="<%=visaValFrom %>" 
												class="tableTextBox validDatevisa validDate" placeholder="DD/MM/YYYY"  
												onFocus="initializeDate(this);" style="width:100%;">
										</td>
										
										<td class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.visavalidto",strsesLanguage)%></td>
										<td style="width:100px;padding-right:5px;">
											<input type="text" name="visaValTo" id="visaValTo" value="<%=visaValTo %>" 
												class="tableTextBox validDatevisa validDate" placeholder="DD/MM/YYYY"  
												onFocus="initializeFutureDate(this);" style="width:100%;">
										</td>
										
										<td class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.entrytype",strsesLanguage)%></td>
										<td style="width:100px;">
											<select name="entryType" id="entryType" class="textBoxCss"  style="width:100%;">	
										    	<option value='0' 
										    		<% if(entryType.equalsIgnoreCase("Single") || entryType.equalsIgnoreCase("")){%>
											    	selected="selected"
											    	<%} %>
										    	><%=dbLabelBean.getLabel("label.personnelbooking.single",strsesLanguage)%></option>
										    	<option value='1' 
										    		<% if(entryType.equalsIgnoreCase("Multiple")){%>
											    	selected="selected"
											    	<%} %>
										    	><%=dbLabelBean.getLabel("label.personnelbooking.multiple",strsesLanguage)%></option>
											</select>
										</td>
										
										<td class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.visacharges",strsesLanguage)%> [ INR ]</td>
										<td style="width:110px;padding-right:5px;">
											<input type="text" name="visaCharges" id="visaCharges" value="<%=visaCharges %>" class="tableTextBox" onKeyUp="return test1(this,10,'n');" style="width:100%;text-align:right;">
										</td>
										
										<td class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.durationofstay",strsesLanguage)%></td>
										<td style="padding-right:5px;">
											<input type="text" name="durOfStay" id="durOfStay" value="<%=durOfStay %>" class="tableTextBox" style="width:100%;">
										</td>
										
									<% 	if(subRole.indexOf("TC_VISA")>=0 || subRole.indexOf("TC_ADMI")>=0) {
									%>	<td align="center" style="width:22px;padding-top:2px;">
											<img src="images/deleteNew.png?buildstamp=2_0_0" border="0" style="cursor:pointer;"  
												 id="delRow" title="<%=dbLabelBean.getLabel("button.global.delete",strsesLanguage)%>">
										</td>
									<% }%>
									</tr>
									<tr class="visaDetailsRow3">	
										
										<td class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.createrequest.remarks",strsesLanguage)%></td>
										<td style="padding-right:5px;" colspan="2">
											<input type="text" name="visaRem" id="visaRem" value="<%=visaRemarks %>" class="tableTextBox" onKeyUp="return test1(this,1000,'a');" style="width:100%;">
										</td>
									</tr>							
								</table>
							</td>
						</tr>
						<%	
							}while(rs6.next());
						}
						else 
						{	visaBookId	= "0";
					%>
						<tr class="visaDetailsRow" id="emptyVisaDetailsRow">
							<input type="hidden" name="hidVisaBookId" id="hidVisaBookId" value="<%=visaBookId%>"/>
							<td>
								<table width="100%" class="">
									<tr class="visaDetailsRow1">			
										<td align="center" width="30px" class="formhead" rowspan="3">
											<b><label name="sno" id="sno">1</label>.</b>
										</td>
										
										<td class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.visastatus",strsesLanguage)%></td>
										<td style="width:100px;">
											<select name="visaStatus" id="visaStatus" class="textBoxCss"  style="width:100%;">	
										    	<!-- <option value="0">Select Status</option> -->
								<%				String sSqlStr="SELECT DISTINCT Visa_Status_Id,Visa_Status FROM M_VISA_BOOKING_STATUS where visa_status='VISA Received';";
												rs = stmt1.executeQuery(sSqlStr);
												while(rs.next()) 
												{
								%>					<option VALUE="<%=rs.getString("Visa_Status_Id").trim()%>"><%=rs.getString("Visa_Status").trim()%></option>
								<%				}
												rs.close();	
								%>
											</select>
										</td>
										
										<td class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.createrequest.passportnumber",strsesLanguage)%></td>
										<td style="width:110px;padding-right:5px;">
											<input type="text" name="pprtNo" id="pprtNo" value="" class="tableTextBox" onKeyUp="return test1(this,30,'cn');" style="width:100%;">
										</td>
										
										<td class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.global.expirydate",strsesLanguage)%></td>
										<td style="width:100px;padding-right:5px;">
											<input type="text" name="ppExpDate" id="ppExpDate" value="" 
												class="tableTextBox validDateBook validDate" placeholder="DD/MM/YYYY"  
												onFocus="initializeFutureDate(this);" style="width:100%;">
										</td>
										
										<td class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.type",strsesLanguage)%></td>
										<td style="width:100px;padding-right:5px;">
											<select name="visaType" id="visaType" class="textBoxCss" style="width:104%;">	
										    	<option value='0' selected="selected"><%=dbLabelBean.getLabel("label.personnelbooking.business",strsesLanguage)%></option>
										    	<option value='1'><%=dbLabelBean.getLabel("label.personnelbooking.workpermit",strsesLanguage)%></option>
										    	<option value='2'><%=dbLabelBean.getLabel("label.personnelbooking.tourist",strsesLanguage)%></option>
										    	<option value='3'><%=dbLabelBean.getLabel("label.personnelbooking.dependent",strsesLanguage)%></option>
											</select>
										</td>
										
										<td class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.user.country",strsesLanguage)%></td>
										<td style="padding-right:5px;">
											<input type="text" name="country" id="country" class="tableTextBox" value="" 
												onFocus="initializeCountryName(this);" maxlength="30"  onkeyup="return test1(this,100,'c');"  
												placeholder="<%=dbLabelBean.getLabel("label.user.country",strsesLanguage)%>" 
												title="<%=dbLabelBean.getLabel("label.user.country",strsesLanguage)%>" style="width:100%;" 
											>
										</td>
									</tr>
									<tr class="visaDetailsRow2">		
										<%-- <td class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.docrecdate",strsesLanguage)%></td>
										<td style="width:100px;" class="docRecDateTd">
											<input type="text" name="docRecDate" id="docRecDate" value="" 
												class="tableTextBox validDatevisa validDate" placeholder="DD/MM/YYYY"  
												onFocus="initializeDocRecDate(this);"	size=15>
										</td>
										
										<td class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.visaissuancedate",strsesLanguage)%></td>
										<td style="width:110px;padding-right:5px;">
											<input type="text" name="visaIssuDate" id="visaIssuDate" value="" 
												class="tableTextBox validDatevisa validDate" placeholder="DD/MM/YYYY"  
												onFocus="initializeDate(this);" style="width:100%;">
										</td> --%>
										
										<td class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.visavalidfrom",strsesLanguage)%></td>
										<td style="width:100px;padding-right:5px;">
											<input type="text" name="visaValFrom" id="visaValFrom" value="" 
												class="tableTextBox validDatevisa validDate" placeholder="DD/MM/YYYY"  
												onFocus="initializeDate(this);" style="width:100%;">
										</td>
										
										<td class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.visavalidto",strsesLanguage)%></td>
										<td style="width:100px;padding-right:5px;">
											<input type="text" name="visaValTo" id="visaValTo" value="" 
												class="tableTextBox validDatevisa validDate" placeholder="DD/MM/YYYY"  
												onFocus="initializeFutureDate(this);" style="width:100%;">
										</td>
										
										<td class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.entrytype",strsesLanguage)%></td>
										<td style="width:100px;">
											<select name="entryType" id="entryType" class="textBoxCss"  style="width:100%;">	
										    	<option value='0' selected="selected"><%=dbLabelBean.getLabel("label.personnelbooking.single",strsesLanguage)%></option>
										    	<option value='1'><%=dbLabelBean.getLabel("label.personnelbooking.multiple",strsesLanguage)%></option>
											</select>
										</td>
										
										<td class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.visacharges",strsesLanguage)%> [ INR ]</td>
										<td style="width:110px;padding-right:5px;">
											<input type="text" name="visaCharges" id="visaCharges" value="" class="tableTextBox" onKeyUp="return test1(this,10,'n');" style="width:100%;text-align:right;">
										</td>
										
										<td class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.durationofstay",strsesLanguage)%></td>
										<td style="padding-right:5px;">
											<input type="text" name="durOfStay" id="durOfStay" value="" class="tableTextBox" style="width:100%;">
										</td>
										
										<td align="center" style="width:22px;"></td>
									</tr>
									<tr class="visaDetailsRow3">	
										
										<td class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.createrequest.remarks",strsesLanguage)%></td>
										<td style="padding-right:5px;" colspan="2">
											<input type="text" name="visaRem" id="visaRem" value="" class="tableTextBox" onKeyUp="return test1(this,1000,'a');" style="width:100%;">
										</td>
									</tr>							
								</table>
							</td>
						</tr>
					<%		
						}							
						rs6.close();
					}
					else 
					{	visaBookId	= "0";
					%>
					<tr class="visaDetailsRow" id="emptyVisaDetailsRow">
						<input type="hidden" name="hidVisaBookId" id="hidVisaBookId" value="<%=visaBookId%>"/>
						<td>
							<table width="100%" class="">
								<tr class="visaDetailsRow1">			
									<td align="center" width="30px" class="formhead" rowspan="3">
										<b><label name="sno" id="sno">1</label>.</b>
									</td>
									
									<td class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.visastatus",strsesLanguage)%></td>
									<td style="width:100px;">
										<select name="visaStatus" id="visaStatus" class="textBoxCss"  style="width:100%;">	
											<!-- <option value="0">Select Status</option> -->
								
								<%		String sSqlStr="SELECT DISTINCT Visa_Status_Id,Visa_Status FROM M_VISA_BOOKING_STATUS where visa_status='VISA Received';";
										rs = stmt1.executeQuery(sSqlStr);
										while(rs.next()) 
										{
								%>			<option VALUE="<%=rs.getString("Visa_Status_Id").trim()%>"><%=rs.getString("Visa_Status").trim()%></option>
								<%		}
										rs.close();	
								%>
										</select>
									</td>
									
									<td class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.createrequest.passportnumber",strsesLanguage)%></td>
									<td style="width:110px;padding-right:5px;">
										<input type="text" name="pprtNo" id="pprtNo" value="" class="tableTextBox" onKeyUp="return test1(this,30,'cn');" style="width:100%;">
									</td>
									
									<td class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.global.expirydate",strsesLanguage)%></td>
									<td style="width:100px;padding-right:5px;">
										<input type="text" name="ppExpDate" id="ppExpDate" value="" 
											class="tableTextBox validDateBook validDate" placeholder="DD/MM/YYYY"  
											onFocus="initializeFutureDate(this);" style="width:100%;">
									</td>
									
									<td class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.type",strsesLanguage)%></td>
									<td style="width:100px;padding-right:5px;">
										<select name="visaType" id="visaType" class="textBoxCss" style="width:104%;">	
									    	<option value='0' selected="selected"><%=dbLabelBean.getLabel("label.personnelbooking.business",strsesLanguage)%></option>
									    	<option value='1'><%=dbLabelBean.getLabel("label.personnelbooking.workpermit",strsesLanguage)%></option>
									    	<option value='2'><%=dbLabelBean.getLabel("label.personnelbooking.tourist",strsesLanguage)%></option>
									    	<option value='3'><%=dbLabelBean.getLabel("label.personnelbooking.dependent",strsesLanguage)%></option>
										</select>
									</td>
									
									<td class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.user.country",strsesLanguage)%></td>
									<td style="padding-right:5px;">
										<input type="text" name="country" id="country" class="tableTextBox" value="" 
											onFocus="initializeCountryName(this);" maxlength="30"  onkeyup="return test1(this,100,'c');"  
											placeholder="<%=dbLabelBean.getLabel("label.user.country",strsesLanguage)%>" 
											title="<%=dbLabelBean.getLabel("label.user.country",strsesLanguage)%>" style="width:100%;" 
										>
									</td>
								</tr>
								<tr class="visaDetailsRow2">		
									<%-- <td class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.docrecdate",strsesLanguage)%></td>
									<td style="width:100px;" class="docRecDateTd">
										<input type="text" name="docRecDate" id="docRecDate" value="" 
											class="tableTextBox validDatevisa validDate" placeholder="DD/MM/YYYY"  
											onFocus="initializeDocRecDate(this);"	size=15>
									</td>
									
									<td class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.visaissuancedate",strsesLanguage)%></td>
									<td style="width:110px;padding-right:5px;">
										<input type="text" name="visaIssuDate" id="visaIssuDate" value="" 
											class="tableTextBox validDatevisa validDate" placeholder="DD/MM/YYYY"  
											onFocus="initializeDate(this);" style="width:100%;">
									</td> --%>
									
									<td class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.visavalidfrom",strsesLanguage)%></td>
									<td style="width:100px;padding-right:5px;">
										<input type="text" name="visaValFrom" id="visaValFrom" value="" 
											class="tableTextBox validDatevisa validDate" placeholder="DD/MM/YYYY"  
											onFocus="initializeDate(this);" style="width:100%;">
									</td>
									
									<td class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.visavalidto",strsesLanguage)%></td>
									<td style="width:100px;padding-right:5px;">
										<input type="text" name="visaValTo" id="visaValTo" value="" 
											class="tableTextBox validDatevisa validDate" placeholder="DD/MM/YYYY"  
											onFocus="initializeFutureDate(this);" style="width:100%;">
									</td>
									
									<td class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.entrytype",strsesLanguage)%></td>
									<td style="width:100px;">
										<select name="entryType" id="entryType" class="textBoxCss"  style="width:100%;">	
									    	<option value='0' selected="selected"><%=dbLabelBean.getLabel("label.personnelbooking.single",strsesLanguage)%></option>
									    	<option value='1'><%=dbLabelBean.getLabel("label.personnelbooking.multiple",strsesLanguage)%></option>
										</select>
									</td>
									
									<td class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.visacharges",strsesLanguage)%> [ INR ]</td>
									<td style="width:110px;padding-right:5px;">
										<input type="text" name="visaCharges" id="visaCharges" value="" class="tableTextBox" onKeyUp="return test1(this,10,'n');" style="width:100%;text-align:right;">
									</td>
									
									<td class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.durationofstay",strsesLanguage)%></td>
									<td style="padding-right:5px;">
										<input type="text" name="durOfStay" id="durOfStay" value="" class="tableTextBox" style="width:100%;">
									</td>
									
									<td align="center" style="width:22px;"></td>
								</tr>
								<tr class="visaDetailsRow3">	
									
									<td class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.createrequest.remarks",strsesLanguage)%></td>
									<td style="padding-right:5px;" colspan="2">
										<input type="text" name="visaRem" id="visaRem" value="" class="tableTextBox" onKeyUp="return test1(this,1000,'a');" style="width:100%;">
									</td>
								</tr>							
							</table>
						</td>
					</tr>
				<%	}
				%>	<tr class="innerVisaInfoRow"></tr>
					<tr class="visaInfoPrototypeRow hide">
						<input type="hidden" name="hidVisaBookIdPT" id="hidVisaBookId" value="0"/>
						<td>
							<table width="100%" class="">
								<tr class="visaPrototypeRow1">
									<td align="center" width="30px" class="formhead" rowspan="3">
										<b><label name="snoPT" id="sno" >2</label>.</b>
									</td>
									
									<td class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.visastatus",strsesLanguage)%></td>
									<td style="width:100px;">
										<select name="visaStatusPT" id="visaStatus" class="textBoxCss"  style="width:100%;">	
											<!-- <option value="0">Select Status</option> -->
						<%				String sSqlStr="SELECT DISTINCT Visa_Status_Id,Visa_Status FROM M_VISA_BOOKING_STATUS where visa_status='VISA Received';";
										rs = stmt1.executeQuery(sSqlStr);
										while(rs.next()) 
										{
						%>					<option VALUE="<%=rs.getString("Visa_Status_Id").trim()%>"><%=rs.getString("Visa_Status").trim()%></option>
						<%				}
										rs.close();	
						%>	    	
										</select>
									</td>
									
									<td class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.createrequest.passportnumber",strsesLanguage)%></td>
									<td style="width:110px;padding-right:5px;">
										<input type="text" name="pprtNoPT" id="pprtNo" value="" class="tableTextBox" onKeyUp="return test1(this,30,'cn');" style="width:100%;">
									</td>
									
									<td class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.global.expirydate",strsesLanguage)%></td>
									<td style="width:100px;padding-right:5px;">
										<input type="text" name="ppExpDatePT" id="ppExpDate" value="" 
											class="tableTextBox validDateBook validDate" placeholder="DD/MM/YYYY"  
											onFocus="initializeFutureDate(this);" style="width:100%;">
									</td>
									
									<td class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.type",strsesLanguage)%></td>
									<td style="width:100px;padding-right:5px;">
										<select name="visaTypePT" id="visaType" class="textBoxCss" style="width:104%;">	
									    	<option value='0' selected="selected"><%=dbLabelBean.getLabel("label.personnelbooking.business",strsesLanguage)%></option>
									    	<option value='1'><%=dbLabelBean.getLabel("label.personnelbooking.workpermit",strsesLanguage)%></option>
									    	<option value='2'><%=dbLabelBean.getLabel("label.personnelbooking.tourist",strsesLanguage)%></option>
									    	<option value='3'><%=dbLabelBean.getLabel("label.personnelbooking.dependent",strsesLanguage)%></option>
										</select>
									</td>
									
									<td class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.user.country",strsesLanguage)%></td>
									<td style="padding-right:5px;">
										<input type="text" name="countryPT" id="country" class="tableTextBox" value="" 
											onFocus="initializeCountryName(this);" maxlength="30"  onkeyup="return test1(this,100,'c');"  
											placeholder="<%=dbLabelBean.getLabel("label.user.country",strsesLanguage)%>" 
											title="<%=dbLabelBean.getLabel("label.user.country",strsesLanguage)%>" style="width:100%;" 
										>
									</td>
								</tr>
								<tr class="visaPrototypeRow2">		
									<%-- <td class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.docrecdate",strsesLanguage)%></td>
									<td style="width:100px;" class="docRecDateTd">
										<input type="text" name="docRecDatePT" id="docRecDate" value="" 
											class="tableTextBox validDatevisa validDate" placeholder="DD/MM/YYYY"  
											onFocus="initializeDocRecDate(this);"	size=15>
									</td>
									
									<td class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.visaissuancedate",strsesLanguage)%></td>
									<td style="width:110px;padding-right:5px;">
										<input type="text" name="visaIssuDatePT" id="visaIssuDate" value="" 
											class="tableTextBox validDatevisa validDate" placeholder="DD/MM/YYYY"  
											onFocus="initializeDate(this);" style="width:100%;">
									</td> --%>
									
									<td class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.visavalidfrom",strsesLanguage)%></td>
									<td style="width:100px;padding-right:5px;">
										<input type="text" name="visaValFromPT" id="visaValFrom" value="" 
											class="tableTextBox validDatevisa validDate" placeholder="DD/MM/YYYY"  
											onFocus="initializeDate(this);" style="width:100%;">
									</td>
									
									<td class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.visavalidto",strsesLanguage)%></td>
									<td style="width:100px;padding-right:5px;">
										<input type="text" name="visaValToPT" id="visaValTo" value="" 
											class="tableTextBox validDatevisa validDate" placeholder="DD/MM/YYYY"  
											onFocus="initializeFutureDate(this);" style="width:100%;">
									</td>
									
									<td class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.entrytype",strsesLanguage)%></td>
									<td style="width:100px;">
										<select name="entryTypePT" id="entryType" class="textBoxCss"  style="width:100%;">	
									    	<option value='0' selected="selected"><%=dbLabelBean.getLabel("label.personnelbooking.single",strsesLanguage)%></option>
									    	<option value='1'><%=dbLabelBean.getLabel("label.personnelbooking.multiple",strsesLanguage)%></option>
										</select>
									</td>
									
									<td class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.visacharges",strsesLanguage)%> [ INR ]</td>
									<td style="width:110px;padding-right:5px;">
										<input type="text" name="visaChargesPT" id="visaCharges" value="" class="tableTextBox" onKeyUp="return test1(this,10,'n');" style="width:100%;text-align:right;">
									</td>
									
									<td class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.durationofstay",strsesLanguage)%></td>
									<td style="padding-right:5px;">
										<input type="text" name="durOfStayPT" id="durOfStay" value="" class="tableTextBox" style="width:100%;">
									</td>
									
								<% 	if(subRole.indexOf("TC_VISA")>=0 || subRole.indexOf("TC_ADMI")>=0) {
								%>	<td align="center" style="width:22px;padding-top:2px;">
										<img src="images/deleteNew.png?buildstamp=2_0_0" border="0" style="cursor:pointer;"  
											 id="delRow" title="<%=dbLabelBean.getLabel("button.global.delete",strsesLanguage)%>">
									</td>
								<% }%>
								</tr>
								<tr class="visaPrototypeRow3">	
									
									<td class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.createrequest.remarks",strsesLanguage)%></td>
									<td style="padding-right:5px;" colspan="2">
										<input type="text" name="visaRemPT" id="visaRem" value="" class="tableTextBox" onKeyUp="return test1(this,1000,'a');" style="width:100%;">
									</td>
								</tr>
							</table>
						</td>
					</tr>
					</tbody>
					<script>
						var subRole	= "<%=subRole%>";
						if(subRole.indexOf("VISA")>=0 || subRole.indexOf("ADMI")>=0) {
							
							/* $("table#visaInfoTable tbody tr.visaDetailsRow").each(function() {
								var visaStatus = $(this).find('select#visaStatus option:selected').text();
								//alert("visaStatus : "+visaStatus);
								var docRecDate = $(this).find("tr.visaDetailsRow2 td.docRecDateTd #docRecDate");
								
								if (visaStatus == "VISA Received") {
										
									//var docRecDate = $(this).find('#docRecDate').val();
									//alert("docRecDate : "+docRecDate);
										
									$(this).find("#docRecDate").css('background-color','#e9e9e9');
									$(this).find("#docRecDate").css('color','#858585');
									$(this).find("#docRecDate").attr('disabled', true);
										
								} else {	
										
									//var docRecDate = $(this).find('#docRecDate').val();
									//alert("docRecDate : "+docRecDate);
									
									$(this).find("#docRecDate").css('background-color','#ffffff');
									$(this).find("#docRecDate").css('color','#5b5b5b');
									//$(this).find("#docRecDate").attr("onfocus", "");
									$(this).find("#docRecDate").attr('disabled', false);
									
								}
							}); */
						}
					</script>
				</table>
				<input type="hidden" name="hidVisaDataFlag" value="<%=visaReqDetailExists%>"/>
				<input type="button" name="addVisaInfo" id="addVisaInfo" value="<%=dbLabelBean.getLabel("label.personnelbooking.addVisainfo",strsesLanguage)%>" 
					class="formButton-red" style="margin-left:8px;font-size: 95%;">
			</div>
		</div>
		
		<div id="insuranceReq" style="margin:0 auto;_text-align:left;">
		<br/>
			<table>
				<tr>
					<td>
						<ul class="pagebullet">
				      		<li class="pageHead" width="50px">
								<td text-align="left"><b><%=dbLabelBean.getLabel("label.createrequest.insurancerequired",strsesLanguage)%></b></td>
							</li>
						</ul>
					</td>
					<td width="98px"></td>
					<td>
						<div id="insuYN">
						<table width="100%" border="0" cellspacing="0" cellpadding="0" class="checkbox">
							<tr>
								<td class="labelTd">
									<label class="yes" id="InsuReqYes"> 
										<input type="radio" name="insu" value="1" id="InsuReq_Y">
											<%=dbLabelBean.getLabel("label.global.yes",strsesLanguage)%>
									</label>
								</td>
								<td class="labelTd">
									<label class="no" id="InsuReqNo"> 
										<input type="radio"	name="insu" value="2" checked="checked"	id="InsuReq_N">
											<%=dbLabelBean.getLabel("label.global.no",strsesLanguage)%>
									</label>
								</td>
							</tr>
						</table>
						</div>
					</td>
				</tr>
			</table>
			<div id="insuInfo" class="hide">
				<table width="100%" border="0" cellpadding="5" cellspacing="1" id="insuInfoTable">
					<tbody>
					<%
					if((tBookId != "0") && (tBookId != "") && (tBookId != null))
					{	editModeFlag		= true;
					
						rs7=stmt.executeQuery("SELECT Insurance_Status,Insurance_Book_id, Policy_No, Start_Date, End_Date,Insurance_Type, Nominee, Relation, Amount, Remark  FROM T_TRAVEL_INSURANCE_BOOKING_DETAIL  where TRAVEL_BOOK_ID="+tBookId);
						if(rs7.next()) 
						{	do
							{	insurReqDetailExists =  true;
								insuBookId	= rs7.getString("Insurance_Book_id")==null ? "Issued":rs7.getString("Insurance_Book_id");
								insuStatus	= rs7.getString("Insurance_Status")==null ? "0":rs7.getString("Insurance_Status");
								insuPolNo 	= rs7.getString("Policy_No")==null ? "":rs7.getString("Policy_No");
								insuStDt 	= rs7.getString("Start_Date")==null ? "":revDtStr(rs7.getString("Start_Date"));
								insuEndDt 	= rs7.getString("End_Date")==null ? "":revDtStr(rs7.getString("End_Date"));
								insuType 	= rs7.getString("Insurance_Type")==null ?"":rs7.getString("Insurance_Type");
								nominee 	= rs7.getString("Nominee")==null ? "":rs7.getString("Nominee");
								relation 	= rs7.getString("Relation")==null ? "":rs7.getString("Relation");
								insuCharges = rs7.getString("Amount")==null ? "0":rs7.getString("Amount");
								insuRemarks = rs7.getString("Remark")==null ? "":rs7.getString("Remark");
								
								if(insuStDt.equals("01/01/1900"))
								{	insuStDt="";
								}
								if(insuEndDt.equals("01/01/1900"))
								{	insuEndDt="";
								}
								
								insuCharges = Integer.toString(Math.round(Float.parseFloat(insuCharges)));
								
								//System.out.println("insuBookId="+insuBookId+" insuStatus="+insuStatus+" insuPolNo="+insuPolNo);
								//System.out.println("insuStDt="+insuStDt+" insuEndDt="+insuEndDt+" insuType="+insuType+" nominee="+nominee);
								//System.out.println("relation="+relation+" insuCharges="+insuCharges+" insuRemarks="+insuRemarks+"\n\n");
						%>
						<tr class="insuDetailsRow">
							<input type="hidden" name="hidInsuBookId" id="hidInsuBookId" value="<%=insuBookId%>"/>
							<td>
								<table>
									<tr class="insuDetailsRow1">
										<td class="formhead" style="width:10%;">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.insustatus",strsesLanguage)%></td>
										<td width="130px">
											<select name="insuStatus" id="insuStatus" class="textBoxCss" style="width:100%;">	
										    	<option value='1' 
										    		<% if(insuStatus.equalsIgnoreCase("Issued")) {%>
											    	selected="selected"
											    	<%} %>
										    	>Issued</option>
										    	<option value='2' 
										    		<% if(insuStatus.equalsIgnoreCase("Void") || insuStatus.equalsIgnoreCase("")) {%>
											    	selected="selected"
											    	<%} %>
										    	>Void</option>
											</select>
										</td>
										
										<td class="formhead" style="width:10%;">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.insurancepolicyno",strsesLanguage)%></td>
										<td style="width:140px;padding-right:5px;">
											<input type="text" name="insuPolNo" id="insuPolNo" value="<%=insuPolNo %>" class="tableTextBox" onKeyUp="return test1(this,200,'cn');" style="width:100%;">
										</td>
										
										<td class="formhead" style="width:15%;">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.global.startdate",strsesLanguage)%></td>
										<td style="width:100px;">
											<input type="text" name="insuStDate" id="insuStDate" value="<%=insuStDt %>" 
												class="tableTextBox validDateInsu validDate" placeholder="DD/MM/YYYY"  
												onFocus="initializeDate(this);"	size=15>
										</td>
										
										<td class="formhead" style="width:8%;">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.global.enddate",strsesLanguage)%></td>
										<td>
											<input type="text" name="insuEndDate" id="insuEndDate" value="<%=insuEndDt %>" 
												class="tableTextBox validDateInsu validDate" placeholder="DD/MM/YYYY"  
												onFocus="initializeFutureDate(this);" size=15>
										</td>
										
										<td class="formhead" style="width:5%;">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.type",strsesLanguage)%></td>
										<td width="9%" align="center">
											<select name="insuType" id="insuType" class="textBoxCss" style="width:101%;">	
										    	<option value='0' 
										    		<% if(insuType.equalsIgnoreCase("LTA")){%>
											    	selected="selected"
											    	<%} %>
										    	><%=dbLabelBean.getLabel("label.personnelbooking.lta",strsesLanguage)%></option>
										    	<option value='1' 
										    		<% if(insuType.equalsIgnoreCase("BTA") || insuType.equalsIgnoreCase("")){%>
											    	selected="selected"
											    	<%} %>
										    	><%=dbLabelBean.getLabel("label.personnelbooking.bta",strsesLanguage)%></option>
											</select>
										</td>
									</tr>
									<tr class="insuDetailsRow2">	
										<td class="formhead" style="width:10%;">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.global.nominee",strsesLanguage)%></td>
										<td width="130px;">
											<input type="text" name="nominee" id="nominee" value="<%=nominee %>" class="tableTextBox" onKeyUp="return test1(this,200,'c');" style="width:96%;">
										</td>
										
										<td class="formhead" style="width:10%;">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.createrequest.relation",strsesLanguage)%></td>
										<td style="width:120px;padding-right:5px;">
											<input type="text" name="relation" id="relation" value="<%=relation %>" class="tableTextBox" onKeyUp="return test1(this,100,'c');" style="width:100%;">
										</td>
										
										<td class="formhead" style="width:15%;">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.insurancecharges",strsesLanguage)%> [ INR ]</td>
										<td style="width:100px;">
											<input type="text" name="insuCharges" id="insuCharges" value="<%=insuCharges %>" class="tableTextBox" onKeyUp="return test1(this,10,'n');" style="width:96%;text-align:right;">
										</td>
										
										<td class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.createrequest.remarks",strsesLanguage)%></td>
										<td colspan="3">
											<input type="text" name="insuRemarks" id="insuRemarks" value="<%=insuRemarks %>" class="tableTextBox" onKeyUp="return test1(this,1000,'a');" style="width:99%;">
										</td>
									</tr>							
								</table>
							</td>
						</tr>
					<%		}while(rs7.next());
						}
						else 
						{	insuBookId	= "0";
					%>
					<tr class="insuDetailsRow" id="emptyInsuDetailsRow">
						<input type="hidden" name="hidInsuBookId" id="hidInsuBookId" value="<%=insuBookId%>"/>
						<td>
							<table>
								<tr class="insuDetailsRow1">
									<td class="formhead" style="width:10%;">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.insustatus",strsesLanguage)%></td>
									<td width="130px">
										<select name="insuStatus" id="insuStatus" class="textBoxCss" style="width:100%;">	
										    <option value='1' selected="selected">Issued</option>
										    <option value='2'>Void</option>
										</select>
									</td>
									
									<td class="formhead" style="width:10%;">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.insurancepolicyno",strsesLanguage)%></td>
									<td style="width:140px;padding-right:5px;">
										<input type="text" name="insuPolNo" id="insuPolNo" value="" class="tableTextBox" onKeyUp="return test1(this,200,'cn');" style="width:100%;">
									</td>
									
									<td class="formhead" style="width:15%;">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.global.startdate",strsesLanguage)%></td>
									<td style="width:100px;">
										<input type="text" name="insuStDate" id="insuStDate" value="" 
											class="tableTextBox validDateInsu validDate" placeholder="DD/MM/YYYY"  
											onFocus="initializeDate(this);"	size=15>
									</td>
									
									<td class="formhead" style="width:8%;">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.global.enddate",strsesLanguage)%></td>
									<td>
										<input type="text" name="insuEndDate" id="insuEndDate" value="" 
											class="tableTextBox validDateInsu validDate" placeholder="DD/MM/YYYY"  
											onFocus="initializeFutureDate(this);" size=15>
									</td>
									
									<td class="formhead" style="width:5%;">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.type",strsesLanguage)%></td>
									<td width="9%" align="center">
										<select name="insuType" id="insuType" class="textBoxCss" style="width:101%;">	
									    	<option value='0'><%=dbLabelBean.getLabel("label.personnelbooking.lta",strsesLanguage)%></option>
									    	<option value='1' selected="selected"><%=dbLabelBean.getLabel("label.personnelbooking.bta",strsesLanguage)%></option>
										</select>
									</td>
								</tr>
								<tr class="insuDetailsRow2">	
									<td class="formhead" style="width:10%;">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.global.nominee",strsesLanguage)%></td>
									<td width="130px">
										<input type="text" name="nominee" id="nominee" value="" class="tableTextBox" onKeyUp="return test1(this,200,'c');" style="width:96%;">
									</td>
									
									<td class="formhead" style="width:10%;">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.createrequest.relation",strsesLanguage)%></td>
									<td style="width:120px;padding-right:5px;">
										<input type="text" name="relation" id="relation" value="" class="tableTextBox" onKeyUp="return test1(this,100,'c');" style="width:100%;">
									</td>
									
									<td class="formhead" style="width:15%;">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.insurancecharges",strsesLanguage)%> [ INR ]</td>
									<td style="width:100px;">
										<input type="text" name="insuCharges" id="insuCharges" value="" class="tableTextBox" onKeyUp="return test1(this,10,'n');" style="width:96%;text-align:right;">
									</td>
									
									<td class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.createrequest.remarks",strsesLanguage)%></td>
									<td colspan="3">
										<input type="text" name="insuRemarks" id="insuRemarks" value="" class="tableTextBox" onKeyUp="return test1(this,1000,'a');" style="width:99%;">
									</td>
								</tr>							
							</table>
						</td>
					</tr>
					<%	}	
						rs7.close();
					}
					else 
					{	insuBookId	= "0";
					%>
					<tr class="insuDetailsRow" id="emptyInsuDetailsRow">
						<input type="hidden" name="hidInsuBookId" id="hidInsuBookId" value="<%=insuBookId%>"/>
						<td>
							<table>
								<tr class="insuDetailsRow1">
									<td class="formhead" style="width:10%;">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.insustatus",strsesLanguage)%></td>
									<td width="130px">
										<select name="insuStatus" id="insuStatus" class="textBoxCss" style="width:100%;">	
										    <option value='1' selected="selected">Issued</option>
										    <option value='2'>Void</option>
										</select>
									</td>
									
									<td class="formhead" style="width:10%;">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.insurancepolicyno",strsesLanguage)%></td>
									<td style="width:140px;padding-right:5px;">
										<input type="text" name="insuPolNo" id="insuPolNo" value="" class="tableTextBox" onKeyUp="return test1(this,200,'cn');" style="width:100%;">
									</td>
									
									<td class="formhead" style="width:15%;">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.global.startdate",strsesLanguage)%></td>
									<td style="width:100px;">
										<input type="text" name="insuStDate" id="insuStDate" value="" 
											class="tableTextBox validDateInsu validDate" placeholder="DD/MM/YYYY"  
											onFocus="initializeDate(this);"	size=15>
									</td>
									
									<td class="formhead" style="width:8%;">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.global.enddate",strsesLanguage)%></td>
									<td>
										<input type="text" name="insuEndDate" id="insuEndDate" value="" 
											class="tableTextBox validDateInsu validDate" placeholder="DD/MM/YYYY"  
											onFocus="initializeFutureDate(this);" size=15>
									</td>
									
									<td class="formhead" style="width:5%;">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.type",strsesLanguage)%></td>
									<td width="9%" align="center">
										<select name="insuType" id="insuType" class="textBoxCss" style="width:101%;">	
									    	<option value='0'><%=dbLabelBean.getLabel("label.personnelbooking.lta",strsesLanguage)%></option>
									    	<option value='1' selected="selected"><%=dbLabelBean.getLabel("label.personnelbooking.bta",strsesLanguage)%></option>
										</select>
									</td>
								</tr>
								<tr class="insuDetailsRow2">	
									<td class="formhead" style="width:10%;">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.global.nominee",strsesLanguage)%></td>
									<td width="130px">
										<input type="text" name="nominee" id="nominee" value="" class="tableTextBox" onKeyUp="return test1(this,200,'c');" style="width:96%;">
									</td>
									
									<td class="formhead" style="width:10%;">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.createrequest.relation",strsesLanguage)%></td>
									<td style="width:120px;padding-right:5px;">
										<input type="text" name="relation" id="relation" value="" class="tableTextBox" onKeyUp="return test1(this,100,'c');" style="width:100%;">
									</td>
									
									<td class="formhead" style="width:15%;">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.insurancecharges",strsesLanguage)%> [ INR ]</td>
									<td style="width:100px">
										<input type="text" name="insuCharges" id="insuCharges" value="" class="tableTextBox" onKeyUp="return test1(this,10,'n');" style="width:96%;text-align:right;">
									</td>
									
									<td class="formhead">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.createrequest.remarks",strsesLanguage)%></td>
									<td colspan="3">
										<input type="text" name="insuRemarks" id="insuRemarks" value="" class="tableTextBox" onKeyUp="return test1(this,1000,'a');" style="width:99%;">
									</td>
								</tr>							
							</table>
						</td>
					</tr>
					<%
					}
					%>
					</tbody>
				</table>
				<input type="hidden" name="hidInsuDataFlag" value="<%=insurReqDetailExists%>"/>
			</div>
		</div>
		
		<div id="accomodationReq" style="margin:0 auto;_text-align:left;">
		<br/>
			<table>
				<tr>
					<td>
						<ul class="pagebullet">
				      		<li class="pageHead" width="50px">
								<td text-align="left"><b><%=dbLabelBean.getLabel("label.personnelbooking.accomodationrequired",strsesLanguage)%></b></td>
							</li>
						</ul>
					</td>
					<td width="71px"></td>
					<td>
						<div id="accYN">
						<table width="100%" border="0" cellspacing="0" cellpadding="0" class="checkbox">
							<tr>
								<td class="labelTd">
									<label class="yes" id="AccReqYes"> 
										<input type="radio" name="insu" value="1" id="AccReq_Y">
											<%=dbLabelBean.getLabel("label.global.yes",strsesLanguage)%>
									</label>
								</td>
								<td class="labelTd">
									<label class="no" id="AccReqNo"> 
										<input type="radio"	name="insu" value="2" checked="checked"	id="AccReq_N">
											<%=dbLabelBean.getLabel("label.global.no",strsesLanguage)%>
									</label>
								</td>
							</tr>
						</table>
						</div>
					</td>
				</tr>
			</table>
			<div id="accInfo" class="hide">
				<table width="100%" align="center" border="0" cellpadding="5" cellspacing="1" id="accInfoTable">
					<tbody>
					<%
					if((tBookId != "0") && (tBookId != "") && (tBookId != null))
					{	editModeFlag		= true;
					
						rs8=stmt.executeQuery("SELECT Acc_Book_id, ACC_TYPE, Location, Check_In_Date, Check_Out_Date, Amount, Remark  FROM T_TRAVEL_ACC_BOOKING_DETAIL where TRAVEL_BOOK_ID="+tBookId);
						if(rs8.next()) 
						{	do
							{	String locnTmp  = "0";
								accomoReqDetailExists =  true;
								accBookId	= rs8.getString("Acc_Book_id")==null ?"0":rs8.getString("Acc_Book_id");
								stayType 	= rs8.getString("ACC_TYPE")==null ?"":rs8.getString("ACC_TYPE");
								locn 		= rs8.getString("Location")==null ?"":rs8.getString("Location");
								chkInDt 	= rs8.getString("Check_In_Date")==null ? "":revDtStr(rs8.getString("Check_In_Date"));
								chkOutDt 	= rs8.getString("Check_Out_Date")==null ? "":revDtStr(rs8.getString("Check_Out_Date"));
								stayCharges = (rs8.getString("Amount")==null || rs8.getString("Amount").equals("-1") || rs8.getString("Amount").equals("-1.0")) ? "0" : rs8.getString("Amount");
								stayRemarks = rs8.getString("Remark")==null ? "":rs8.getString("Remark");
								
								if (!locn.equals("") && stayType.equalsIgnoreCase("Transit House")) {
									rs3=stmt1.executeQuery("Select transit_house_id,NAME from M_TRANSIT_HOUSE where name like '%"+locn.trim()+"%'");
									if(rs3.next()) {	
										locnTmp = rs3.getString("transit_house_id")==null? "0" :rs3.getString("transit_house_id");
									} else {
										locnTmp =locn;
									}
	 								rs3.close();
								}	
								
								if(chkInDt.equals("01/01/1900"))
								{	chkInDt="";
								}
								if(chkOutDt.equals("01/01/1900"))
								{	chkOutDt="";
								}
								
								stayCharges = Integer.toString(Math.round(Float.parseFloat(stayCharges)));
								
								//System.out.println("accBookId="+accBookId+" stayType="+stayType+" locn="+locn+" locnTmp="+locnTmp);
								//System.out.println("chkInDt="+chkInDt+" chkOutDt="+chkOutDt+" stayCharges="+stayCharges+" stayRemarks="+stayRemarks+"\n\n");
						%>
						<tr class="accDetailsRow">
							<input type="hidden" name="hidAccBookId" id="hidAccBookId" value="<%=accBookId%>"/>
							<td>
								<table>
									<tr class="accDetailsRow1">
										<td align="center" width="30px" class="formhead" rowspan="2">
											<b><%=++sNum1%>.</b>
										</td>
										
										<td class="formhead" style="width:60px;">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.type",strsesLanguage)%></td>
										<td style="width:120px;">
											<select name="stayType" id="stayType" class="textBoxCss" style="width:100%;">	
										    	<option value='Hotel' 
										    		<% if(stayType.equalsIgnoreCase("Hotel") || stayType.equalsIgnoreCase("")){%>
											    	selected="selected"
											    	<%} %>
										    	><%=dbLabelBean.getLabel("label.global.hotel",strsesLanguage)%></option>
										    	<option value='Transit House' 
										    		<% if(stayType.equalsIgnoreCase("Transit House")){%>
											    	selected="selected"
											    	<%} %>
										    	><%=dbLabelBean.getLabel("label.global.transithouse",strsesLanguage)%></option>
											</select>
										</td>
										
										<td class="formhead" style="width:80px;">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.global.location",strsesLanguage)%></td>
										<td style="width:140px;" id="locTd">
											<input type="hidden" name="locationPT" id="locationTBHid" value="<%=locn%>">
											
											<input type="text" name="locationPT" id="locationTB" value="<%=locn%>" class="tableTextBox hide" onKeyUp="return test1(this,200,'c');" style="width:97%;">
											<select name="locationTemp" id="locationDD" class="textBoxCss hide" style="width:100%;">	
											    <option value='0' selected="selected">Select Transit House</option>
								<%			String sSqlStr1="SELECT Transit_house_Id,Name FROM M_TRANSIT_HOUSE";
											rs = stmt1.executeQuery(sSqlStr1);
											while(rs.next()) 
											{
												if(rs.getString("Transit_house_Id").equals(locnTmp)){
								%>				<option VALUE="<%=rs.getString("Transit_house_Id").trim()%>" selected="selected" ><%=rs.getString("NAME").trim()%></option>
								<%			
												} else { 
								%>
												<option VALUE="<%=rs.getString("Transit_house_Id").trim()%>"><%=rs.getString("NAME").trim()%></option>
								<%
												}
											}
											rs.close();	
								%>
											</select>
											
										</td>
										
										<td class="formhead" style="width:10%;">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.global.checkindate",strsesLanguage)%></td>
										<td style="width:105px;padding-right:5px;">
											<input type="text" name="chkInDate" id="chkInDate" value="<%=chkInDt %>" 
												class="tableTextBox validDateAcc validDate" placeholder="DD/MM/YYYY"  
												onFocus="validateDates(this,'DD/MM/YYYY','validDateAcc');" style="width:100%;">
										</td>
										
										<td class="formhead" style="width:10%;">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.global.checkoutdate",strsesLanguage)%></td>
										<td style="width:105px;padding-right:5px;">
											<input type="text" name="chkOutDate" id="chkOutDate" value="<%=chkOutDt %>" 
												class="tableTextBox validDateAcc validDate" placeholder="DD/MM/YYYY"  
												onFocus="validateDates(this,'DD/MM/YYYY','validDateAcc');" style="width:100%;">
										</td>
										
										<td class="formhead" style="width:13%;">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.staycharges",strsesLanguage)%> [ INR ]</td>
										<td style="width:120px;">
											<input type="text" name="stayCharges" id="stayCharges" value="<%=stayCharges %>" class="tableTextBox" onKeyUp="return test1(this,10,'n');" style="width:100%;text-align:right;">
										</td>
										
									<% 	if(subRole.indexOf("TC_ACCO")>=0 || subRole.indexOf("TC_ADMI")>=0) {
									%>	<td align="right" style="width:27px;">
											<img src="images/deleteNew.png?buildstamp=2_0_0" border="0" style="cursor:pointer;"  
												 id="delRow" title="<%=dbLabelBean.getLabel("button.global.delete",strsesLanguage)%>">
										</td>
									<%  }%>
									</tr>
									<tr class="accDetailsRow2">
										<td class="formhead" style="width:60px;">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.createrequest.remarks",strsesLanguage)%></td>
										<td colspan="2">
											<input type="text" name="stayRemarks" id="stayRemarks" value="<%=stayRemarks %>" class="tableTextBox" onKeyUp="return test1(this,1000,'a');" style="width:99%;">
										</td>
									</tr>							
								</table>
							</td>	
						</tr>
					<%		}while(rs8.next());
						}
						else
						{	accBookId	= "0";
					%>	
					<tr class="accDetailsRow" style="width:500px;" id="emptyAccDetailsRow">
						<input type="hidden" name="hidAccBookId" id="hidAccBookId" value="<%=accBookId%>"/>
						<td>
							<table>
								<tr class="accDetailsRow1">
									<td align="center" width="30px" class="formhead" rowspan="2">
										<b><label name="sno" id="sno">1</label>.</b>
									</td>
									
									<td class="formhead" style="width:60px;">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.type",strsesLanguage)%></td>
									<td style="width:120px;">
										<select name="stayType" id="stayType" class="textBoxCss" style="width:100%;">	
									    	<option value='Hotel'><%=dbLabelBean.getLabel("label.global.hotel",strsesLanguage)%></option>
									    	<option value='Transit House' selected="selected"><%=dbLabelBean.getLabel("label.global.transithouse",strsesLanguage)%></option>
										</select>
									</td>
									
									<td class="formhead" style="width:80px;">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.global.location",strsesLanguage)%></td>
									<td style="width:140px;" id="locTd">
							 			<input type="hidden" name="locationPT" id="locationTBHid" value="">
							 			
							 			<input type="text" name="locationPT" id="locationTB" value="" class="tableTextBox hide" onKeyUp="return test1(this,200,'c');" style="width:97%;">
							 			<select name="locationTemp" id="locationDD" class="textBoxCss show" style="width:100%;">	
									    	<option value='0' selected="selected">Select Transit House</option>
								<%			String sSqlStr1="SELECT Transit_house_Id,Name FROM M_TRANSIT_HOUSE";
											rs = stmt1.executeQuery(sSqlStr1);
											while(rs.next()) 
											{
								%>				<option VALUE="<%=rs.getString("Transit_house_Id").trim()%>"><%=rs.getString("NAME").trim()%></option>
								<%			}
											rs.close();	
								%>
										</select>
									</td>
									
									<td class="formhead" style="width:10%;">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.global.checkindate",strsesLanguage)%></td>
									<td style="width:105px;padding-right:5px;">
										<input type="text" name="chkInDate" id="chkInDate" value="" style="width:100%;" 
											class="tableTextBox validDateAcc validDate" placeholder="DD/MM/YYYY"  
											onFocus="validateDates(this,'DD/MM/YYYY','validDateAcc');"	>
									</td>
									
									<td class="formhead" style="width:10%;">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.global.checkoutdate",strsesLanguage)%></td>
									<td style="width:105px;padding-right:5px;">
										<input type="text" name="chkOutDate" id="chkOutDate" value=""  style="width:100%;"  
											class="tableTextBox validDateAcc validDate" placeholder="DD/MM/YYYY"  
											onFocus="validateDates(this,'DD/MM/YYYY','validDateAcc');"	>
									</td>
									
									<td class="formhead" style="width:13%;">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.staycharges",strsesLanguage)%> [ INR ]</td>
									<td style="width:120px;">
										<input type="text" name="stayCharges" id="stayCharges" value="" class="tableTextBox" onKeyUp="return test1(this,10,'n');" style="width:100%;text-align:right;">
									</td>
									
									<td align="right" style="width:27px;"></td>
								</tr>
								<tr class="accDetailsRow2">
									<td class="formhead" style="width:60px;">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.createrequest.remarks",strsesLanguage)%></td>
									<td colspan="2">
										<input type="text" name="stayRemarks" id="stayRemarks" value="" class="tableTextBox" onKeyUp="return test1(this,1000,'a');" style="width:99%;">
									</td>
								</tr>							
							</table>
						</td>
					</tr>
					<%	}
						rs8.close();	
					}
					else 
					{	accBookId	= "0";
					%>
					<tr class="accDetailsRow" style="width:500px;" id="emptyAccDetailsRow">
						<input type="hidden" name="hidAccBookId" id="hidAccBookId" value="<%=accBookId%>"/>
						<td>
							<table>
								<tr class="accDetailsRow1">
									<td align="center" width="30px" class="formhead" rowspan="2">
										<b><label name="sno" id="sno">1</label>.</b>
									</td>
									
									<td class="formhead" style="width:60px;">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.type",strsesLanguage)%></td>
									<td style="width:120px;">
										<select name="stayType" id="stayType" class="textBoxCss" style="width:100%;">	
									    	<option value='Hotel'><%=dbLabelBean.getLabel("label.global.hotel",strsesLanguage)%></option>
									    	<option value='Transit House' selected="selected"><%=dbLabelBean.getLabel("label.global.transithouse",strsesLanguage)%></option>
										</select>
									</td>
									
									<td class="formhead" style="width:80px;">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.global.location",strsesLanguage)%></td>
									<td style="width:140px;" id="locTd">
							 			<input type="hidden" name="locationPT" id="locationTBHid" value="">
							 			
							 			<input type="text" name="locationPT" id="locationTB" value="" class="tableTextBox hide" onKeyUp="return test1(this,200,'c');" style="width:97%;">
							 			<select name="locationTemp" id="locationDD" class="textBoxCss show" style="width:100%;">	
									    	<option value='0' selected="selected">Select Transit House</option>
								<%			String sSqlStr1="SELECT Transit_house_Id,Name FROM M_TRANSIT_HOUSE";
											rs = stmt1.executeQuery(sSqlStr1);
											while(rs.next()) 
											{
								%>				<option VALUE="<%=rs.getString("Transit_house_Id").trim()%>"><%=rs.getString("NAME").trim()%></option>
								<%			}
											rs.close();	
								%>
										</select>
									</td>
									
									<td class="formhead" style="width:10%;">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.global.checkindate",strsesLanguage)%></td>
									<td style="width:105px;padding-right:5px;">
										<input type="text" name="chkInDate" id="chkInDate" value="" style="width:100%;" 
											class="tableTextBox validDateAcc validDate" placeholder="DD/MM/YYYY"  
											onFocus="validateDates(this,'DD/MM/YYYY','validDateAcc');"	>
									</td>
									
									<td class="formhead" style="width:10%;">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.global.checkoutdate",strsesLanguage)%></td>
									<td style="width:105px;padding-right:5px;">
										<input type="text" name="chkOutDate" id="chkOutDate" value="" style="width:100%;"  
											class="tableTextBox validDateAcc validDate" placeholder="DD/MM/YYYY"  
											onFocus="validateDates(this,'DD/MM/YYYY','validDateAcc');"	>
									</td>
									
									<td class="formhead" style="width:13%;">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.staycharges",strsesLanguage)%> [ INR ]</td>
									<td style="width:120px;">
										<input type="text" name="stayCharges" id="stayCharges" value="" class="tableTextBox" onKeyUp="return test1(this,10,'n');" style="width:100%;text-align:right;">
									</td>
									
									<td align="right" style="width:27px;"></td>
								</tr>
								<tr class="accDetailsRow2">
									<td class="formhead" style="width:60px;">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.createrequest.remarks",strsesLanguage)%></td>
									<td colspan="2">
										<input type="text" name="stayRemarks" id="stayRemarks" value="" class="tableTextBox" onKeyUp="return test1(this,1000,'a');" style="width:99%;">
									</td>
								</tr>								
							</table>
						</td>
					</tr>
					<%
					}	
					%>
					<tr class="innerAccInfoRow"></tr>
					<tr class="accInfoPrototypeRow hide">
						<input type="hidden" name="hidAccBookIdPT" id="hidAccBookId" value="0"/>
						<td>
							<table>
								<tr class="accPrototypeRow1">
									<td align="center" width="30px" class="formhead" rowspan="2">
										<b><label name="snoPT" id="sno">2</label>.</b>
									</td>
									
									<td class="formhead" style="width:60px;">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.type",strsesLanguage)%></td>
									<td style="width:120px;">
										<select name="stayTypePT" id="stayType" class="textBoxCss" style="width:100%;">	
									    	<option value='Hotel'><%=dbLabelBean.getLabel("label.global.hotel",strsesLanguage)%></option>
									    	<option value='Transit House' selected="selected"><%=dbLabelBean.getLabel("label.global.transithouse",strsesLanguage)%></option>
										</select>
									</td>
									
									<td class="formhead" style="width:80px;">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.global.location",strsesLanguage)%></td>
									<td style="width:140px;" id="locTd">
							 			<input type="hidden" name="locationPT" id="locationTBHid" value="">
							 			
							 			<input type="text" name="locationPT" id="locationTB" value="" class="tableTextBox hide" onKeyUp="return test1(this,200,'c');" style="width:97%;">
							 			<select name="locationTempPT" id="locationDD" class="textBoxCss show" style="width:100%;">	
									    	<option value='0' selected="selected">Select Transit House</option>
								<%			String sSqlStr1="SELECT Transit_house_Id,Name FROM M_TRANSIT_HOUSE";
											rs = stmt1.executeQuery(sSqlStr1);
											while(rs.next()) 
											{
								%>				<option VALUE="<%=rs.getString("Transit_house_Id").trim()%>"><%=rs.getString("NAME").trim()%></option>
								<%			}
											rs.close();	
								%>
										</select>
									</td>
									
									<td class="formhead" style="width:10%;">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.global.checkindate",strsesLanguage)%></td>
									<td style="width:105px;padding-right:5px;">
										<input type="text" name="chkInDatePT" id="chkInDate" value="" style="width:100%;" 
											class="tableTextBox validDateAcc validDate" placeholder="DD/MM/YYYY"  
											onFocus="validateDates(this,'DD/MM/YYYY','validDateAcc');"	>
									</td>
									
									<td class="formhead" style="width:10%;">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.global.checkoutdate",strsesLanguage)%></td>
									<td style="width:105px;padding-right:5px;">
										<input type="text" name="chkOutDatePT" id="chkOutDate" value=""  style="width:100%;"  
											class="tableTextBox validDateAcc validDate" placeholder="DD/MM/YYYY"  
											onFocus="validateDates(this,'DD/MM/YYYY','validDateAcc');"	>
									</td>
									
									<td class="formhead" style="width:13%;">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.staycharges",strsesLanguage)%> [ INR ]</td>
									<td style="width:120px;">
										<input type="text" name="stayChargesPT" id="stayCharges" value="" class="tableTextBox" onKeyUp="return test1(this,10,'n');" style="width:100%;text-align:right;">
									</td>
									
									<td align="right" style="width:27px;">
										<img src="images/deleteNew.png?buildstamp=2_0_0" border="0" style="cursor:pointer;"  
											 id="delRow" title="<%=dbLabelBean.getLabel("button.global.delete",strsesLanguage)%>">
									</td>
								</tr>
								<tr class="accPrototypeRow2">
									<td class="formhead" style="width:60px;">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.createrequest.remarks",strsesLanguage)%></td>
									<td colspan="2">
										<input type="text" name="stayRemarksPT" id="stayRemarks" value="" class="tableTextBox" onKeyUp="return test1(this,1000,'a');" style="width:99%;">
									</td>
								</tr>							
							</table>
						</td>
					</tr>
					</tbody>
					<script>
					$("table#accInfoTable tbody tr.accDetailsRow").each(function() {
						var stayTypeVal = $(this).find("td table tr.accDetailsRow1").find("#stayType").val();
						if(stayTypeVal == 'Hotel') {
							
							$(this).find("td table tr.accDetailsRow1").find("td#locTd").find("#locationTB").removeClass("hide");
							$(this).find("td table tr.accDetailsRow1").find("td#locTd").find("#locationTB").addClass("show");
							$(this).find("td table tr.accDetailsRow1").find("td#locTd").find("#locationDD").removeClass("show");
							$(this).find("td table tr.accDetailsRow1").find("td#locTd").find("#locationDD").addClass("hide");
							
							$(this).find("td table tr.accDetailsRow1").find("td#locTd").find("#locationTBHid").attr('name','locationPT');
							$(this).find("td table tr.accDetailsRow1").find("td#locTd").find("#locationTB").attr('name','location');
							
							$(this).find("td table tr.accDetailsRow1").find("td#locTd").find("#locationTBHid").val("");
							
						} else if(stayTypeVal == 'Transit House') {
							
							$(this).find("td table tr.accDetailsRow1").find("td#locTd").find("#locationDD").removeClass("hide");
							$(this).find("td table tr.accDetailsRow1").find("td#locTd").find("#locationDD").addClass("show");
							$(this).find("td table tr.accDetailsRow1").find("td#locTd").find("#locationTB").removeClass("show");
							$(this).find("td table tr.accDetailsRow1").find("td#locTd").find("#locationTB").addClass("hide");
							
							$(this).find("td table tr.accDetailsRow1").find("td#locTd").find("#locationTBHid").attr('name','location');
							$(this).find("td table tr.accDetailsRow1").find("td#locTd").find("#locationTB").attr('name','locationPT');
							$(this).find("td table tr.accDetailsRow1").find("td#locTd").find("#locationTB").val("");
							
							var locDDVal = $(this).find("td table tr.accDetailsRow1").find("td#locTd").find("select#locationDD option:selected").val();
							var locDDTxt = $(this).find("td table tr.accDetailsRow1").find("td#locTd").find("select#locationDD option:selected").text();
							
							$(this).find("td table tr.accDetailsRow1").find("td#locTd").find("#locationTBHid").val(""); 
							
							if (locDDVal != "0") { 
								$(this).find("td table tr.accDetailsRow1").find("td#locTd").find("#locationTBHid").val(locDDTxt); 
							} 
						}
						//alert(stayTypeVal+" : "+$(this).find("td table tr.accDetailsRow1").find("td#locTd").find("#locationTBHid").val());
					});
					</script>
				</table>
				<input type="hidden" name="hidAccDataFlag" value="<%=accomoReqDetailExists%>"/>
				<input type="button" name="addAccInfo" id="addAccInfo" value="<%=dbLabelBean.getLabel("label.personnelbooking.addaccomodationinfo",strsesLanguage)%>" 
					class="formButton-red" style="margin-left:8px;font-size: 95%;">
			</div>
		</div>
		
		<div id="cancellation" style="margin:0 auto;_text-align:left;">
		<br/>
			<table>
				<tr>
					<td>
						<ul class="pagebullet">
				      		<li class="pageHead" width="50px">
								<td text-align="left"><b><%=dbLabelBean.getLabel("label.personnelbooking.cancellationrefunddetail",strsesLanguage)%></b></td>
							</li>
						</ul>
					</td>
					<td width="59px"></td>
					<td>
						<div id="cnclYN">
						<table width="100%" border="0" cellspacing="0" cellpadding="0" class="checkbox">
							<tr>
								<td class="labelTd">
									<label class="yes" id="CnclReqYes"> 
										<input type="radio" name="insu" value="1" id="CnclReq_Y">
											<%=dbLabelBean.getLabel("label.global.yes",strsesLanguage)%>
									</label>
								</td>
								<td class="labelTd">
									<label class="no" id="CnclReqNo"> 
										<input type="radio"	name="insu" value="2" checked="checked"	id="CnclReq_N">
											<%=dbLabelBean.getLabel("label.global.no",strsesLanguage)%>
									</label>
								</td>
							</tr>
						</table>
						</div>
					</td>
				</tr>
			</table>
			<div id="cnclInfo" class="hide">
				<table width="100%" align="center" border="0" cellpadding="5" cellspacing="1" id="cnclInfoTable">
					<tbody>
					<%
					if((tBookId != "0") && (tBookId != "") && (tBookId != null))
					{	editModeFlag		= true;
						if(tktReqDetailExists)
						{	cnclRefundDetailExists	=  true;
						}else 
						{	cnclRefundDetailExists	=  false;
						}
						rs9 = stmt.executeQuery("SELECT distinct cbd.Flag,cbd.Travel_Cancel_Id,cbd.Ticket_Issue_Date AS Ticket_Issue_Date,CBD.Sector_From, CBD.Sector_To,CBD.PNR AS PNR,CBD.E_Ticket_No AS E_Ticket_No,cbd.Cancelled_Date, cbd.Amount, cbd.Cancel_Reason, cbd.Remark, cbd.Mail_Sent_Flag from T_TRAVEL_CANCEL_BOOKING_DETAIL cbd where cbd.TRAVEL_BOOK_ID="+tBookId);
						//rs9 = stmt.executeQuery("SELECT distinct cbd.Flag,cbd.Travel_Cancel_Id,cbd.Ticket_Issue_Date AS Ticket_Issue_Date,dbo.fn_getairportcode(tbd.Sector_From,'N') as Sector_From,dbo.fn_getairportcode(tbd.Sector_To,'N') as  Sector_To,tbd.PNR AS PNR,tbd.E_Ticket_No AS E_Ticket_No,cbd.Cancelled_Date, cbd.Amount, cbd.Cancel_Reason,cbd.Remark from T_TRAVEL_CANCEL_BOOKING_DETAIL cbd right join T_TRAVEL_TICKET_BOOKING_DETAIL tbd on cbd.TRAVEL_BOOK_ID=tbd.TRAVEL_BOOK_ID where tbd.TRAVEL_BOOK_ID="+tBookId);
						if(rs9.next() && showCnclBlockFlag)
						{	do
							{
							cnclRefundDetailExists	=  true;
							chkBoxFlag		= rs9.getString("Flag")==null ? "N"				:rs9.getString("Flag");
							travelCnclId	= rs9.getString("Travel_Cancel_Id")==null ? ""	:rs9.getString("Travel_Cancel_Id");
							tktIssuDt 		= rs9.getString("Ticket_Issue_Date")==null ? ""	:revDtStr(rs9.getString("Ticket_Issue_Date"));
							secFrom2 		= rs9.getString("Sector_From")==null ? ""		:rs9.getString("Sector_From");
							secTo2 			= rs9.getString("Sector_To")==null ? ""			:rs9.getString("Sector_To");
							tktCnclDt 		= rs9.getString("Cancelled_Date")==null ? ""	:revDtStr(rs9.getString("Cancelled_Date"));
							pnr1 			= rs9.getString("PNR")==null ? ""				:rs9.getString("PNR");
							eTktNo1 		= rs9.getString("E_Ticket_No")==null ? ""		:rs9.getString("E_Ticket_No");
							cnclCharges 	= rs9.getString("Amount")==null ? "0"			:rs9.getString("Amount");
							cnclReason 		= rs9.getString("Cancel_Reason")==null ? ""		:rs9.getString("Cancel_Reason");
							refundRemarks	= rs9.getString("Remark")==null ? ""			:rs9.getString("Remark");
							mailSentFlag	= rs9.getString("Mail_Sent_Flag")==null ? "N"	:rs9.getString("Mail_Sent_Flag");
							
							if(tktIssuDt.equals("01/01/1900"))
							{	tktIssuDt="";
							}
							if(tktCnclDt.equals("01/01/1900") || tktCnclDt.equals(""))
							{	tktCnclDt=currDate.trim();
							}	
							String strChkNameSn = "chkbox"+iSno;
							
							cnclCharges = Integer.toString(Math.round(Float.parseFloat(cnclCharges)));
							
							//System.out.println("chkBoxFlag="+chkBoxFlag+" travelCnclId="+travelCnclId+" tktIssuDt="+tktIssuDt);
							//System.out.println("tktCnclDt="+tktCnclDt+" chkOutDt="+chkOutDt+" secFrom2="+secFrom2+" secTo2="+secTo2);
							//System.out.println("pnr1="+pnr1+" eTktNo1="+eTktNo1+" cnclCharges="+cnclCharges+" cnclReason="+cnclReason);
							//System.out.println("refundRemarks="+refundRemarks+" mailSentFlag="+mailSentFlag+"\n\n");
					%>
					<tr class="cnclDetailsRow">
					   	<input type="hidden" name="hidTrvlCnclId" id="hidTrvlCnclId" value="<%=travelCnclId%>"/>
					   	<input type="hidden" name="hidmailSentFlag" id="hidmailSentFlag<%=iSno%>" value="N">
						<td>
							<table width="100%">
								<tr class="cnclDetailsRow1">
								<% 	if(subRole.indexOf("TC_TICK")>=0 || subRole.indexOf("TC_ADMI")>=0) {
								%>	
									<td align="center" width="30px" class="formhead" rowspan="2">
										<input type="checkbox" name="<%=strChkNameSn%>" id="chkbox<%=iSno%>" value="<%=chkBoxFlag%>" 
									<%	if(chkBoxFlag.equalsIgnoreCase("Y")){ %> 
										checked="checked" disabled="disabled"
									<% 	} else if(chkBoxFlag.equalsIgnoreCase("N") || chkBoxFlag.equalsIgnoreCase("")){}%> 
										class="chkCls">
									</td>
								<%  }%>
									
									<td class="formhead" style="width:10%;">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.ticketissuedate",strsesLanguage)%></td>
									<td style="width:120px;padding-right:5px;">
										<input type="text" name="tktIssuDate" id="tktIssuDate" value="<%=tktIssuDt%>" 
											class="tableTextBox validDateCncl validDate 
											<%	if(chkBoxFlag.equalsIgnoreCase("Y")){ %> 
										 		input-disabled
											<% 	} else if(chkBoxFlag.equalsIgnoreCase("N") || chkBoxFlag.equalsIgnoreCase("")){}%>
											" placeholder="DD/MM/YYYY"  
											onFocus="initializeDate(this);" style="width:100%;" 
											<%	if(chkBoxFlag.equalsIgnoreCase("Y")){ %> 
										 		disabled="disabled"
											<% 	} else if(chkBoxFlag.equalsIgnoreCase("N") || chkBoxFlag.equalsIgnoreCase("")){}%> 
										>
									</td>
									
									<td class="formhead" style="width:12%;">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.sectorfrom",strsesLanguage)%></td>
									<td style="width:120px;padding-right:5px;">
										<input type="text" name="cnclSecFrom" id="cnclSecFrom" class="tableTextBox 
											<%	if(chkBoxFlag.equalsIgnoreCase("Y")){ %> 
										 		input-disabled
											<% 	} else if(chkBoxFlag.equalsIgnoreCase("N") || chkBoxFlag.equalsIgnoreCase("")){}%>
											" value="<%=secFrom2%>"   
											onFocus="initializeCityName(this);" maxlength="30"  onKeyUp="return test1(this,50,'c');" 
											placeholder="<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>" 
											title="<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>" 
											style="width:100%;" 
											<%	if(chkBoxFlag.equalsIgnoreCase("Y")){ %> 
										 		disabled="disabled"
											<% 	} else if(chkBoxFlag.equalsIgnoreCase("N") || chkBoxFlag.equalsIgnoreCase("")){}%> 
										> 
									</td>
									
									<td class="formhead" style="width:7%;">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.sectorto",strsesLanguage)%></td>
									<td style="width:120px;padding-right:5px;">
										<input type="text" name="cnclSecTo" id="cnclSecTo" class="tableTextBox 
											<%	if(chkBoxFlag.equalsIgnoreCase("Y")){ %> 
										 		input-disabled
											<% 	} else if(chkBoxFlag.equalsIgnoreCase("N") || chkBoxFlag.equalsIgnoreCase("")){}%>
											" value="<%=secTo2%>"   
											onFocus="initializeCityName(this);" maxlength="30"  onKeyUp="return test1(this,50,'c');" 
											placeholder="<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>" 
											title="<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>" 
											style="width:100%;" 
											<%	if(chkBoxFlag.equalsIgnoreCase("Y")){ %> 
										 		disabled="disabled"
											<% 	} else if(chkBoxFlag.equalsIgnoreCase("N") || chkBoxFlag.equalsIgnoreCase("")){}%> 
										> 
									</td>
									
									<td class="formhead" style="width:9%;">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.ticketcancelleddate",strsesLanguage)%></td>
									<td style="width:100px;padding-right:5px;">
										<input type="text" name="tktCnclDate" id="tktCnclDate" value="<%=tktCnclDt%>" 
											class="tableTextBox validDateCncl 
											<%	if(chkBoxFlag.equalsIgnoreCase("Y")){ %> 
										 		input-disabled
											<% 	} else if(chkBoxFlag.equalsIgnoreCase("N") || chkBoxFlag.equalsIgnoreCase("")){}%>
											" placeholder="DD/MM/YYYY"  
											onFocus="validateDates(this,'DD/MM/YYYY','validDateCncl');" style="width:100%;"
											<%	if(chkBoxFlag.equalsIgnoreCase("Y")){ %> 
										 		disabled="disabled"
											<% 	} else if(chkBoxFlag.equalsIgnoreCase("N") || chkBoxFlag.equalsIgnoreCase("")){}%>
											>
									</td>
									
									<td class="formhead" style="width:4%;">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.pnr",strsesLanguage)%></td>
									<td style="width:120px;">
										<input type="text" name="pnrNo" id="pnrNo" value="<%=pnr1 %>" class="tableTextBox 
											<%	if(chkBoxFlag.equalsIgnoreCase("Y")){ %> 
										 		input-disabled
											<% 	} else if(chkBoxFlag.equalsIgnoreCase("N") || chkBoxFlag.equalsIgnoreCase("")){}%>
											" onKeyUp="return test1(this,100,'cn');" style="width:100%;"
										<%	if(chkBoxFlag.equalsIgnoreCase("Y")){ %> 
										 		disabled="disabled"
										<% 	} else if(chkBoxFlag.equalsIgnoreCase("N") || chkBoxFlag.equalsIgnoreCase("")){}%> 
										>
									</td>
									
									<td align="right" style="width:27px;"></td>
								</tr>
								<tr class="cnclDetailsRow2">
									<td class="formhead" style="width:10%;">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.ticketno",strsesLanguage)%></td>
									<td style="width:120px;padding-right:5px;">
										<input type="text" name="tktNo" id="tktNo" value="<%=eTktNo1 %>" class="tableTextBox 
											<%	if(chkBoxFlag.equalsIgnoreCase("Y")){ %> 
										 		input-disabled
											<% 	} else if(chkBoxFlag.equalsIgnoreCase("N") || chkBoxFlag.equalsIgnoreCase("")){}%>
											" onKeyUp="return test1(this,100,'cn');" style="width:100%;"
										<%	if(chkBoxFlag.equalsIgnoreCase("Y")){ %> 
									 		disabled="disabled"
										<% 	} else if(chkBoxFlag.equalsIgnoreCase("N") || chkBoxFlag.equalsIgnoreCase("")){}%> 
										>
									</td>
										
									<td class="formhead" style="width:12%;">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.cancellationcharges",strsesLanguage)%> [ INR ]</td>
									<td style="width:120px;padding-right:5px;">
										<input type="text" name="cnclCharges" id="cnclCharges" value="<%=cnclCharges %>" class="tableTextBox
											<%	if(chkBoxFlag.equalsIgnoreCase("Y")){ %> 
										 		input-disabled
											<% 	} else if(chkBoxFlag.equalsIgnoreCase("N") || chkBoxFlag.equalsIgnoreCase("")){}%>
											" onKeyUp="return test1(this,10,'n');" style="width:100%;text-align:right;"<%	if(chkBoxFlag.equalsIgnoreCase("Y")){ %> 
									 		disabled="disabled"
										<% 	} else if(chkBoxFlag.equalsIgnoreCase("N") || chkBoxFlag.equalsIgnoreCase("")){}%>
										>
									</td>
									
									<td class="formhead" style="width:7%;">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.mail.reason",strsesLanguage)%></td>
									<td style="width:120px;padding-right:5px;">
										<input type="text" name="cnclReason" id="cnclReason" value="<%=cnclReason %>" class="tableTextBox
											<%	if(chkBoxFlag.equalsIgnoreCase("Y")){ %> 
										 		input-disabled
											<% 	} else if(chkBoxFlag.equalsIgnoreCase("N") || chkBoxFlag.equalsIgnoreCase("")){}%>
											" onKeyUp="return test1(this,1000,'a');" style="width:100%;"<%	if(chkBoxFlag.equalsIgnoreCase("Y")){ %> 
									 		disabled="disabled"
										<% 	} else if(chkBoxFlag.equalsIgnoreCase("N") || chkBoxFlag.equalsIgnoreCase("")){}%>
										>
									</td>
									
									<td class="formhead" style="width:9%;">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.createrequest.remarks",strsesLanguage)%></td>
									<td colspan="3">
										<input type="text" name="refundRemarks" id="refundRemarks" value="<%=refundRemarks%>" class="tableTextBox
											<%	if(chkBoxFlag.equalsIgnoreCase("Y")){ %> 
										 		input-disabled
											<% 	} else if(chkBoxFlag.equalsIgnoreCase("N") || chkBoxFlag.equalsIgnoreCase("")){}%>
											" onKeyUp="return test1(this,1000,'a');" style="width:100%;"<%	if(chkBoxFlag.equalsIgnoreCase("Y")){ %> 
									 		disabled="disabled"
										<% 	} else if(chkBoxFlag.equalsIgnoreCase("N") || chkBoxFlag.equalsIgnoreCase("")){}%>
										>
									</td>
								</tr>
							</table>
						</td>	
					</tr>
					<script type="text/javascript">
						$('#chkbox'+<%=iSno%>).click(function () {
							if($(this).is(':checked')){
								
								$(this).val('Y');
								$('#hidmailSentFlag'+<%=iSno%>).val('Y');
							
							} else if(!$(this).is(':checked')) {
								
								$(this).val('N');
								$('#hidmailSentFlag'+<%=iSno%>).val('N');
							}
							<%-- alert("hidmailSentFlag"+<%=iSno%>+" : "+$('#hidmailSentFlag'+<%=iSno%>).val()); --%>
						});
					</script>								
					<%		iSno++;
							} while(rs9.next());	
						
						} else if(!showCnclBlockFlag) {
							cnclRefundDetailExists	=  false;
							
						} else {	
							travelCnclId	= "0";
							mailSentFlag    = "N";
					%>
					<tr class="cnclDetailsRow" id="emptyCnclDetailsRow">
						<input type="hidden" name="hidmailSentFlag" id="hidmailSentFlag0" value="N">
						<input type="hidden" name="hidTrvlCnclId" id="hidTrvlCnclId" value="<%=travelCnclId%>"/>
						<td>
							<table width="100%">
								<tr class="cnclDetailsRow1">			
									<td align="center" width="30px" class="formhead" rowspan="2">
										<input type="checkbox" name="chkbox0" id="chkbox0" class="chkCls">
									</td>
									
									<td class="formhead" style="width:10%;">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.ticketissuedate",strsesLanguage)%></td>
									<td style="width:120px;padding-right:5px;">
										<input type="text" name="tktIssuDate" id="tktIssuDate" value="" 
											class="tableTextBox validDateCncl validDate" placeholder="DD/MM/YYYY"  
											onFocus="initializeDate(this);"	style="width:100%;">
									</td>
									
									<td class="formhead" style="width:12%;">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.sectorfrom",strsesLanguage)%></td>
									<td style="width:120px;padding-right:5px;">
											<input type="text" name="cnclSecFrom" id="cnclSecFrom" class="tableTextBox" value=""  
											onFocus="initializeCityName(this);" maxlength="30"  onKeyUp="return test1(this,50,'c');" 
											placeholder="<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>" 
											title="<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>" 
											style="width:100%;"> 
									</td>
									
									<td class="formhead" style="width:7%;">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.sectorto",strsesLanguage)%></td>
									<td style="width:120px;padding-right:5px;">
											<input type="text" name="cnclSecTo" id="cnclSecTo" class="tableTextBox" value=""  
											onFocus="initializeCityName(this);" maxlength="30"  onKeyUp="return test1(this,50,'c');" 
											placeholder="<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>" 
											title="<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>" 
											style="width:100%;"> 
									</td>
									
									<td class="formhead" style="width:9%;">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.ticketcancelleddate",strsesLanguage)%></td>
									<td style="width:100px;padding-right:5px;">
										<input type="text" name="tktCnclDate" id="tktCnclDate" value="<%=currDate.trim()%>" 
											class="tableTextBox validDateCncl validDate" placeholder="DD/MM/YYYY"  
											onFocus="validateDates(this,'DD/MM/YYYY','validDateCncl');" style="width:100%;">
									</td>
									
									<td class="formhead" style="width:4%;">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.pnr",strsesLanguage)%></td>
									<td style="width:120px;">
										<input type="text" name="pnrNo" id="pnrNo" value="" class="tableTextBox" onKeyUp="return test1(this,100,'cn');" style="width:100%;">
									</td>
									
									<td align="right" style="width:27px;"></td>
								</tr>
								<tr class="cnclDetailsRow2">	
									<td class="formhead" style="width:10%;">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.ticketno",strsesLanguage)%></td>
									<td style="width:120px;padding-right:5px;">
										<input type="text" name="tktNo" id="tktNo" value="" class="tableTextBox" onKeyUp="return test1(this,100,'cn');" style="width:100%;">
									</td>
									
									<td class="formhead" style="width:12%;">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.cancellationcharges",strsesLanguage)%> [ INR ]</td>
									<td style="width:120px;padding-right:5px;">
										<input type="text" name="cnclCharges" id="cnclCharges" value="" class="tableTextBox" onKeyUp="return test1(this,10,'n');" style="width:100%;text-align:right;">
									</td>
									
									<td class="formhead" style="width:7%;">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.mail.reason",strsesLanguage)%></td>
									<td style="width:120px;padding-right:5px;">
										<input type="text" name="cnclReason" id="cnclReason" value="" class="tableTextBox" onKeyUp="return test1(this,1000,'a');" style="width:100%;">
									</td>
									
									<td class="formhead" style="width:9%;">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.createrequest.remarks",strsesLanguage)%></td>
									<td colspan="3">
										<input type="text" name="refundRemarks" id="refundRemarks" value="" class="tableTextBox" onKeyUp="return test1(this,1000,'a');" style="width:100%;">
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<script type="text/javascript">
						$("#chkbox0").click(function () {
							if($(this).is(':checked')){
								$(this).val("Y");
								$("#hidmailSentFlag0").val("Y");
							} else if(!$(this).is(':checked')) {
								$(this).val("N");
								$("#hidmailSentFlag0").val("N");
							}
							//alert("hidmailSentFlag0" : "+$("#hidmailSentFlag0").val());
						});
					</script>
					<%	}
						rs9.close();
					}
					else 
					{	travelCnclId	= "0";
						mailSentFlag    = "N";
					%>
					<tr class="cnclDetailsRow" id="emptyCnclDetailsRow">
						<input type="hidden" name="hidTrvlCnclId" id="hidTrvlCnclId" value="<%=travelCnclId%>"/>
						<input type="hidden" name="hidmailSentFlag" id="hidmailSentFlag0" value="N"/>
						<td>
							<table width="100%">
								<tr class="cnclDetailsRow1">			
									<td align="center" width="30px" class="formhead" rowspan="2">
										<!-- <b><label name="sno" id="sno">1</label>.</b> -->
										<input type="checkbox" name="chkbox0" id="chkbox0" class="chkCls">
									</td>
									
									<td class="formhead" style="width:10%;">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.ticketissuedate",strsesLanguage)%></td>
									<td style="width:120px;padding-right:5px;">
										<input type="text" name="tktIssuDate" id="tktIssuDate" value="" 
											class="tableTextBox validDateCncl validDate" placeholder="DD/MM/YYYY"  
											onFocus="initializeDate(this);"	style="width:100%;">
									</td>
									
									<td class="formhead" style="width:12%;">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.sectorfrom",strsesLanguage)%></td>
									<td style="width:120px;padding-right:5px;">
											<input type="text" name="cnclSecFrom" id="cnclSecFrom" class="tableTextBox" value=""  
											onFocus="initializeCityName(this);" maxlength="30"  onKeyUp="return test1(this,50,'c');" 
											placeholder="<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>" 
											title="<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>" 
											style="width:100%;"> 
									</td>
									
									<td class="formhead" style="width:7%;">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.sectorto",strsesLanguage)%></td>
									<td style="width:120px;padding-right:5px;">
											<input type="text" name="cnclSecTo" id="cnclSecTo" class="tableTextBox" value=""  
											onFocus="initializeCityName(this);" maxlength="30"  onKeyUp="return test1(this,50,'c');" 
											placeholder="<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>" 
											title="<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>" 
											style="width:100%;"> 
									</td>
									
									<td class="formhead" style="width:9%;">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.ticketcancelleddate",strsesLanguage)%></td>
									<td style="width:100px;padding-right:5px;">
										<input type="text" name="tktCnclDate" id="tktCnclDate" value="<%=currDate.trim()%>" 
											class="tableTextBox validDateCncl validDate" placeholder="DD/MM/YYYY"  
											onFocus="validateDates(this,'DD/MM/YYYY','validDateCncl');" style="width:100%;">
									</td>
									
									<td class="formhead" style="width:4%;">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.pnr",strsesLanguage)%></td>
									<td style="width:120px;">
										<input type="text" name="pnrNo" id="pnrNo" value="" class="tableTextBox" onKeyUp="return test1(this,100,'cn');" style="width:100%;">
									</td>
									
									<td align="right" style="width:27px;"></td>
								</tr>
								<tr class="cnclDetailsRow2">	
									<td class="formhead" style="width:10%;">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.ticketno",strsesLanguage)%></td>
									<td style="width:120px;padding-right:5px;">
										<input type="text" name="tktNo" id="tktNo" value="" class="tableTextBox" onKeyUp="return test1(this,100,'cn');" style="width:100%;">
									</td>
									
									<td class="formhead" style="width:12%;">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.personnelbooking.cancellationcharges",strsesLanguage)%> [ INR ]</td>
									<td style="width:120px;padding-right:5px;">
										<input type="text" name="cnclCharges" id="cnclCharges" value="" class="tableTextBox" onKeyUp="return test1(this,10,'n');" style="width:100%;text-align:right;">
									</td>
									
									<td class="formhead" style="width:7%;">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.mail.reason",strsesLanguage)%></td>
									<td style="width:120px;padding-right:5px;">
										<input type="text" name="cnclReason" id="cnclReason" value="" class="tableTextBox" onKeyUp="return test1(this,1000,'a');" style="width:100%;">
									</td>
									
									<td class="formhead" style="width:9%;">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.createrequest.remarks",strsesLanguage)%></td>
									<td colspan="3">
										<input type="text" name="refundRemarks" id="refundRemarks" value="" class="tableTextBox" onKeyUp="return test1(this,1000,'a');" style="width:100%;">
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<%
					}	
					%>
					</tbody>
				</table>
				<input type="hidden" name="hidCnclDataFlag" value="<%=cnclRefundDetailExists%>"/>
				<input type="hidden" name="flagIndex" value = "<%=iSno %>">	
			
			<% 	if(subRole.indexOf("TC_TICK")>=0 || subRole.indexOf("TC_ADMI")>=0) {
			%>	<span class="accomtxt2" style="padding-left: 8px;"><sub>*</sub> Cancel the tickets using checkboxes.</span> 
				<br>&nbsp;
				
				<input type="button" name="SelectAll" id="SelectAll" value="Select All" onclick="checkAll();"
					class="formButton-green" style="width:90px;font-size:90%;padding-bottom:2px;padding-left:8px;margin-top:5px;">
					
				<input type="button" name="UnselectAll" id="UnselectAll" value="Unselect All" onclick="uncheckAll();"
					class="formButton-red" style="width:90px;font-size:90%;padding-bottom:2px;margin-top:5px;">
			<%	} %>
			</div>
		</div>
		<br/>
				<input type="hidden" name="hidEditMode" value="<%=editModeFlag%>"/>
				<input type="hidden" name="hidCloseFlag" value="<%=closeFlag%>"/>
		<table width="100%">
			<tr>
				<td align="CENTER" width="50%">
					<input type="button" value="<%=dbLabelBean.getLabel("button.global.save",strsesLanguage)%>" 
						id="saveBtn" class="btnCss" onclick="submitData('false',1);">
				</td>
			</tr>
			<span id="foo1" style="visibility: hidden;"></span>
			<span id="foo2" style="visibility: hidden;"></span>
			<span id="foo3" style="visibility: hidden;"></span>
			<span id="foo4" style="visibility: hidden;"></span>
			<span id="foo5" style="visibility: hidden;"></span>
			<span id="foo6" style="visibility: hidden;"></span>
			<span id="foo7" style="visibility: hidden;"></span>
			<span id="foo8" style="visibility: hidden;"></span>
			<span id="foo9" style="visibility: hidden;"></span>
		</table>
		
	<script>
		var tktChkYFlag		= false;
		var visaChkYFlag	= false;
		var insChkYFlag		= false;
		var accChkYFlag		= false;
		var cnclChkYFlag	= false;
		
		function validateTktNo(tktNoVal)
		{	
			if (tktNoVal == "")
			{	alert("Ticket No. cannot be empty");
				return false;
			}
			if(tktNoVal != "")
			{
				if (tktNoVal.length < 5)
				{	alert("Enter Ticket No. having correct length [at least 5 characters]");
					return false;
				}
				if (tktNoVal.indexOf(" ") != 3)
				{	alert("Enter Ticket No. in correct format [XXX X......]");
					return false;
				}
				
				var parts= tktNoVal.split(' ');
				if (!(typeof parts[2] === 'undefined') || parts[1]=="" || parts[0]=="")
				{	alert("Enter Ticket No. in correct format [XXX X......]");
					return false;
				}			
			}	
			return true;
		}
		
		function validateFlightNo(flightNoVal)
		{	
			if (flightNoVal == "")
			{	alert("Flight No. cannot be empty");
				return false;
			}
			if(flightNoVal != "")
			{
				if (flightNoVal.length < 5)
				{	alert("Enter Flight No. having correct length [at least 4 characters]");
					return false;
				}
				if (flightNoVal.indexOf(" ") != 2)
				{	alert("Enter Flight No. in correct format [XXX X......]");
					return false;
				}
				
				var parts= flightNoVal.split(' ');
				if (!(typeof parts[2] === 'undefined') || parts[1]=="" || parts[0]=="")
				{	alert("Enter Flight No. in correct format [XXX X......]");
					return false;
				}			
			}	
			return true;
		}
		
		function validateTime(t)
		{ 	var parts = [];
			
			if (t=="") {	
				alert("TIME cannot be empty");
				return false;
			}
			if(t != "" && t.length == 4) {
				
				var hr  	= t.substring(0,2);
				var min		= t.substring(2,t.length);
				
		  		if (isNaN(hr))
				{
					alert("Please enter correct numeric Hours");
					return false;
				}
				else if (isNaN(min))
				{
					alert("Please enter correct numeric Minutes");
					return false;
				}
				else if(hr>23)
				{	alert("invalid Hours");
					return false;
				}
				else if (min > 60)
				{	alert("Invalid Minutes");
					return false;
				}
				else if(min == 60)
				{	min = "00";
					if(hr == 23)
					{	hr = "00";
					}
					else if (hr < 23)
					{	hr = parseInt(hr) +1;
						hr = hr.toString();
					}	
				}
			
			} else {	
				alert("Enter Correct Time [HHMM (24hr)]");
				return false;
			}
			return (hr+min);
		}
		
		function validateFields()
		{
			var subRole			= "<%=subRole%>";
			var trvlBookId		= "<%=tBookId%>";
			var grpTrvlFlag		= "<%=grpTrvlFlag%>";
			var traveltype		= "<%=trvlType%>";
			
			var rowCountTkt 	= $("table#ticketInfoTable tbody tr.ticketDetailsRow").length;
			var rowCountTktGrid	= $("table#tktGridTable tbody tr.tktGridRow").length;
			var rowCountVisa 	= $("table#visaInfoTable tbody tr.visaDetailsRow").length;
			var rowCountInsu 	= $("table#insuInfoTable tbody tr.insuDetailsRow").length;
			var rowCountAcc 	= $("table#accInfoTable tbody tr.accDetailsRow").length;
			var rowCountCncl	= $("table#cnclInfoTable tbody tr.cnclDetailsRow").length;
			
			var selectUnit		=	document.getElementById("selectUnit");
			var paxName			=	document.getElementById("paxName");
			var mobileNo		=	document.getElementById("mobileNo");
			var dob				=	document.getElementById("dob");
			var travelType		=	document.getElementById("travelType");
			var forex			=	document.getElementById("forex");
			
			if(paxName.value == '') 
			{	alert('Pax Name');
				paxName.style.backgroundColor="#fbfebc";
				paxName.style.color="#000000";
				paxName.focus();
				return false;
			}
			if(mobileNo.value == '') 
			{	alert('Mobile No.');
				mobileNo.style.backgroundColor="#fbfebc";
				mobileNo.style.color="#000000";
				mobileNo.focus();
				return false;
			}
			if(dob.value == '' || dob.value == 'DD/MM/YYYY') 
			{	alert('DOB');
				dob.style.backgroundColor="#fbfebc";
				dob.style.color="#000000";
				dob.focus();
				return false;
			}
			if(forex.value == '') 
			{	alert('Total Forex/Advance.');
				forex.style.backgroundColor="#fbfebc";
				forex.style.color="#000000";
				forex.focus();
				return false;
			}
			
			if((grpTrvlFlag.toUpperCase() == "Y") && (trvlBookId != "") && (trvlBookId != null) && (trvlBookId != "0"))
			{	
				var rowCountUserDetails = $("table#grpTravelersInfoTable tbody tr.grpTravelersInfoRow").length;
				
				if(rowCountUserDetails >= 1) 
				{	
					var userNames		=	document.getElementsByName("userNames");
					var userDesigs		=	document.getElementsByName("userDesigs");
					var userDobs		=	document.getElementsByName("userDobs");
					var userMobNos		=	document.getElementsByName("userMobNos");
					var userForexes		=	document.getElementsByName("userForexes");
					
					for (var i = 0, len = rowCountUserDetails; i < len; i++) 
					{	
						if(userNames[i].value == '') 
						{
							alert('Group/Guest Details :: Enter Name');
							userNames[i].style.backgroundColor="#fbfebc";
							userNames[i].style.color="#000000";
							userNames[i].focus();
							return false;
						}
						
						if(userDesigs[i].value == '') 
						{
							alert('Group/Guest Details :: Enter Designation');
							userDesigs[i].style.backgroundColor="#fbfebc";
							userDesigs[i].style.color="#000000";
							userDesigs[i].focus();
							return false;
						}
						
						if(userDobs[i].value == '' || userDobs[i].value == 'DD/MM/YYYY') 
						{
							alert('Group/Guest Details :: Enter Date Of Birth');
							userDobs[i].style.backgroundColor="#fbfebc";
							userDobs[i].style.color="#000000";
							userDobs[i].focus();
							return false;
						}
						
						if(userMobNos[i].value =='')
						{
							alert('Group/Guest Details :: Enter Mobile No.');
							userMobNos[i].style.backgroundColor="#fbfebc";
							userMobNos[i].style.color="#000000";
							userMobNos[i].focus();
							return false;
						}
						
						if(traveltype.toUpperCase()=="I" && userForexes[i].value =='')
						{
							alert('Group/Guest Details :: Enter Forex/Advance.');
							userForexes[i].style.backgroundColor="#fbfebc";
							userForexes[i].style.color="#000000";
							userForexes[i].focus();
							return false;
						}
					}
				}
			}
		
			if(subRole.indexOf("TC_ADMI")>=0)	
			{	
				var deptrTime   = document.getElementsByName("deptrTime");
				var arrTime 	= document.getElementsByName("arrTime");
				var airlineType = document.getElementsByName("airlineType");
				var ticketNo 	= document.getElementsByName("ticketNo");
								
				if(tktChkYFlag == true) 
				{	if(rowCountTkt >= 1) 
					{	for (var i = 0, len = rowCountTkt; i < len; i++) 
						{	
							if(deptrTime[i].value != '') 
							{
								var strDeptrTimeFlag = validateTime(deptrTime[i].value);
								if (strDeptrTimeFlag == false && strDeptrTimeFlag != '0000') {	
									deptrTime[i].style.backgroundColor="#fbfebc";
									deptrTime[i].style.color="#000000";
									deptrTime[i].focus();
									return false;
								}
								else {	
									deptrTime[i].value = strDeptrTimeFlag;		
								}
							}
							
							if(arrTime[i].value != '') 
							{
								var strArrTimeFlag   = validateTime(arrTime[i].value);	
								if (strArrTimeFlag == false && strArrTimeFlag != '0000') {	
									arrTime[i].style.backgroundColor="#fbfebc";
									arrTime[i].style.color="#000000";
									arrTime[i].focus();
									return false;
								}
								else {	
									arrTime[i].value = strArrTimeFlag;		
								}
							}
							
							if(airlineType[i].value !='' && airlineType[i].value !='Flight No.') 
							{
								var strFlightNoFlag = validateFlightNo(airlineType[i].value);
								if (strFlightNoFlag == false)
								{	airlineType[i].style.backgroundColor="#fbfebc";
									airlineType[i].style.color="#000000";
									airlineType[i].focus();
									return false;		
								}
							}
							
							if(ticketNo[i].value !='')
							{
								var strTktNoFlag = validateTktNo(ticketNo[i].value);
								if (strTktNoFlag == false)
								{	ticketNo[i].style.backgroundColor="#fbfebc";
									ticketNo[i].style.color="#000000";
									ticketNo[i].focus();
									return false;		
								}
							}	
						}
					}
				}
			} 
			else if (subRole.indexOf("TC_ADMI") < 0) {
				
				var secFrom 	= document.getElementsByName("secFrom");
				var secTo 		= document.getElementsByName("secTo");
				var deptrDate 	= document.getElementsByName("deptrDate");	
				var deptrTime   = document.getElementsByName("deptrTime");
				var arrDate 	= document.getElementsByName("arrDate");
				var arrTime 	= document.getElementsByName("arrTime");
				var airlineType = document.getElementsByName("airlineType");
				var pnr   		= document.getElementsByName("pnr");
				var ticketNo 	= document.getElementsByName("ticketNo");
				/* var bscFare 	= document.getElementsByName("bscFare");
				var taxes 		= document.getElementsByName("taxes"); */
				var ttlFare 	= document.getElementsByName("ttlFare");
				
				var visaStatus	= document.getElementsByName("visaStatus");
				var pprtNo 		= document.getElementsByName("pprtNo");
				var ppExpDate 	= document.getElementsByName("ppExpDate");	
				var country 	= document.getElementsByName("country");
				/* var docRecDate 	= document.getElementsByName("docRecDate");
				var visaIssuDate= document.getElementsByName("visaIssuDate"); */
				var visaValFrom = document.getElementsByName("visaValFrom");
				var visaValTo 	= document.getElementsByName("visaValTo");
				var durOfStay 	= document.getElementsByName("durOfStay");
				var visaCharges = document.getElementsByName("visaCharges");
				var visaRem 	= document.getElementsByName("visaRem");
				
				var insuStatus	= document.getElementsByName("insuStatus");
				var insuPolNo 	= document.getElementsByName("insuPolNo");
				var insuStDate 	= document.getElementsByName("insuStDate");	
				var insuEndDate = document.getElementsByName("insuEndDate");
				var nominee 	= document.getElementsByName("nominee");
				var relation 	= document.getElementsByName("relation");
				var insuCharges = document.getElementsByName("insuCharges");
				var insuRemarks = document.getElementsByName("insuRemarks");
				
				var hidstayType	= document.getElementsByName("hidstayType");
				var location 	= document.getElementsByName("location");	
				var chkInDate 	= document.getElementsByName("chkInDate");
				var chkOutDate 	= document.getElementsByName("chkOutDate");
				var stayCharges = document.getElementsByName("stayCharges");
				
				if(subRole.indexOf("TC_TICK")>=0 || trvlBookId=="0")	
				{	if(tktChkYFlag == true) 
					{	if(rowCountTkt >= 1) 
						{	 
							var diffCnt = rowCountTktGrid - rowCountTkt;
							var len		= rowCountTktGrid + rowCountTkt;
							
							for (var i = Math.abs(rowCountTkt+diffCnt); i < len; i++) 
							{
								if(secFrom[i].value=='' || secFrom[i].value=='<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>') 
								{	alert('<%=dbLabelBean.getLabel("alert.global.departurecity",strsesLanguage)%>');
									secFrom[i].style.backgroundColor="#fbfebc";
									secFrom[i].style.color="#000000";
									secFrom[i].focus();
									return false;
								}
								if(secTo[i].value=='' || secTo[i].value=='<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>') 
								{	alert('Arrival City');
									secTo[i].style.backgroundColor="#fbfebc";
									secTo[i].style.color="#000000";
									secTo[i].focus();
									return false;
								}
								if(deptrDate[i].value=='' || deptrDate[i].value=='DD/MM/YYYY') 
								{	alert('Departure Date');
									deptrDate[i].style.backgroundColor="#fbfebc";
									deptrDate[i].style.color="#000000";
									deptrDate[i].focus();
									return false;
								}
								if(deptrTime[i].value=='' || deptrTime[i].value=='HHMM (24hr)') 
								{	alert('Departure Time');
									deptrTime[i].style.backgroundColor="#fbfebc";
									deptrTime[i].style.color="#000000";
									deptrTime[i].focus();
									return false;
								}
								if(deptrTime[i].value != '') 
								{	var str = validateTime(deptrTime[i].value);
									if (str== false && str != '0000')
									{	deptrTime[i].style.backgroundColor="#fbfebc";
										deptrTime[i].style.color="#000000";
										deptrTime[i].focus();
										return false;		
									}
									else
									{	deptrTime[i].value = str;		
									}
								}
								if(arrDate[i].value=='' || arrDate[i].value=='DD/MM/YYYY') 
								{	alert('Arrival Date');
									arrDate[i].style.backgroundColor="#fbfebc";
									arrDate[i].style.color="#000000";
									arrDate[i].focus();
									return false;
								}
								if(arrTime[i].value=='' || arrTime[i].value=='HHMM (24hr)') 
								{	alert('Arrival Time');
									arrTime[i].style.backgroundColor="#fbfebc";
									arrTime[i].style.color="#000000";
									arrTime[i].focus();
									return false;
								}
								if(arrTime[i].value !='') 
								{	var str = validateTime(arrTime[i].value);
									if (str== false && str != '0000')
									{	arrTime[i].style.backgroundColor="#fbfebc";
										arrTime[i].style.color="#000000";
										arrTime[i].focus();
										return false;	
									}
									else
									{	arrTime[i].value = str;		
									}
								}
								if(airlineType[i].value=='' || airlineType[i].value=='Flight No.') 
								{	alert('Flight No.');
									airlineType[i].style.backgroundColor="#fbfebc";
									airlineType[i].style.color="#000000";
									airlineType[i].focus();
									return false;
								}
								if(airlineType[i].value !='' && airlineType[i].value !='Flight No.') 
								{
									var str = validateFlightNo(airlineType[i].value);
									if (str== false)
									{	airlineType[i].style.backgroundColor="#fbfebc";
										airlineType[i].style.color="#000000";
										airlineType[i].focus();
										return false;		
									}
								}
								if(pnr[i].value=='') 
								{	alert('PNR No.');
									pnr[i].style.backgroundColor="#fbfebc";
									pnr[i].style.color="#000000";
									pnr[i].focus();
									return false;
								}
								if(ticketNo[i].value !='') 
								{	
									var str = validateTktNo(ticketNo[i].value);
									if (str== false)
									{	ticketNo[i].style.backgroundColor="#fbfebc";
										ticketNo[i].style.color="#000000";
										ticketNo[i].focus();
										return false;		
									}
								}
								/* if(bscFare[i].value=='') 
								{	alert('Basic Fare');
									bscFare[i].style.backgroundColor="#fbfebc";
									bscFare[i].style.color="#000000";
									bscFare[i].focus();
									return false;
								}
								if(taxes[i].value=='') 
								{	alert('Taxes');
									taxes[i].style.backgroundColor="#fbfebc";
									taxes[i].style.color="#000000";
									taxes[i].focus();
									return false;
								} */
							}
						}
					}
				}
				
				if(subRole.indexOf("TC_VISA")>=0 || trvlBookId=="0")	
				{	if(visaChkYFlag == true) 
					{	if(rowCountVisa >= 1) 
						{	for (var i = 0, len = rowCountVisa; i < len; i++) 
							{	
								if(visaStatus[i].value !='' && visaStatus[i].value !='0') 
								{	
									if(pprtNo[i].value=='') 
									{	alert('Passport No.');
										pprtNo[i].style.backgroundColor="#fbfebc";
										pprtNo[i].style.color="#000000";
										pprtNo[i].focus();
										return false;
									}
									if(ppExpDate[i].value=='' || ppExpDate[i].value=='DD/MM/YYYY') 
									{	alert('Passport Expiry Date');
										ppExpDate[i].style.backgroundColor="#fbfebc";
										ppExpDate[i].style.color="#000000";
										ppExpDate[i].focus();
										return false;
									}
									if(country[i].value=='' || country[i].value=='Country') 
									{	alert('Country');
										country[i].style.backgroundColor="#fbfebc";
										country[i].style.color="#000000";
										country[i].focus();
										return false;
									}
									/* if(visaStatus[i].value !='3' && (docRecDate[i].value=='' || docRecDate[i].value=='DD/MM/YYYY'))
									{	alert('Doc. Rec. Date');
										docRecDate[i].style.backgroundColor="#fbfebc";
										docRecDate[i].style.color="#000000";
										docRecDate[i].focus();
										return false;
									} 
									if(visaIssuDate[i].value=='' || visaIssuDate[i].value=='DD/MM/YYYY') 
									{	alert('Visa Issue Date');
										visaIssuDate[i].style.backgroundColor="#fbfebc";
										visaIssuDate[i].style.color="#000000";
										visaIssuDate[i].focus();
										return false;
									} */
									if(visaValFrom[i].value=='' || visaValFrom[i].value=='DD/MM/YYYY') 
									{	alert('Visa Valid From');
										visaValFrom[i].style.backgroundColor="#fbfebc";
										visaValFrom[i].style.color="#000000";
										visaValFrom[i].focus();
										return false;
									}
									if(visaValTo[i].value=='' || visaValTo[i].value=='DD/MM/YYYY') 
									{	alert('Visa Valid To');
										visaValTo[i].style.backgroundColor="#fbfebc";
										visaValTo[i].style.color="#000000";
										visaValTo[i].focus();
										return false;
									}
									if(durOfStay[i].value=='') 
									{	alert('Duration Of Stay');
										durOfStay[i].style.backgroundColor="#fbfebc";
										durOfStay[i].style.color="#000000";
										durOfStay[i].focus();
										return false;
									}
									if(visaCharges[i].value=='') 
									{	alert('Visa Charges');
										visaCharges[i].style.backgroundColor="#fbfebc";
										visaCharges[i].style.color="#000000";
										visaCharges[i].focus();
										return false;
									}
									if(visaRem[i].value=='' && visaStatus[i].value =='6') 
									{	alert('Enter Visa Remarks');
										visaRem[i].style.backgroundColor="#fbfebc";
										visaRem[i].style.color="#000000";
										visaRem[i].focus();
										return false;
									}
								}
								if(pprtNo[i].value !='') 
								{	
									if(visaStatus[i].value=='' || visaStatus[i].value=='0') 
									{	alert('Select Visa Status');
										visaStatus[i].style.backgroundColor="#fbfebc";
										visaStatus[i].style.color="#000000";
										visaStatus[i].focus();
										return false;
									}
									if(ppExpDate[i].value=='' || ppExpDate[i].value=='DD/MM/YYYY') 
									{	alert('Passport Expiry Date');
										ppExpDate[i].style.backgroundColor="#fbfebc";
										ppExpDate[i].style.color="#000000";
										ppExpDate[i].focus();
										return false;
									}
									if(country[i].value=='' || country[i].value=='Country') 
									{	alert('Country');
										country[i].style.backgroundColor="#fbfebc";
										country[i].style.color="#000000";
										country[i].focus();
										return false;
									}
									/* if(visaStatus[i].value !='3' && (docRecDate[i].value=='' || docRecDate[i].value=='DD/MM/YYYY'))
									{	alert('Doc. Rec. Date');
										docRecDate[i].style.backgroundColor="#fbfebc";
										docRecDate[i].style.color="#000000";
										docRecDate[i].focus();
										return false;
									}
									if(visaIssuDate[i].value=='' || visaIssuDate[i].value=='DD/MM/YYYY') 
									{	alert('Visa Issue Date');
										visaIssuDate[i].style.backgroundColor="#fbfebc";
										visaIssuDate[i].style.color="#000000";
										visaIssuDate[i].focus();
										return false;
									} */
									if(visaValFrom[i].value=='' || visaValFrom[i].value=='DD/MM/YYYY') 
									{	alert('Visa Valid From');
										visaValFrom[i].style.backgroundColor="#fbfebc";
										visaValFrom[i].style.color="#000000";
										visaValFrom[i].focus();
										return false;
									}
									if(visaValTo[i].value=='' || visaValTo[i].value=='DD/MM/YYYY') 
									{	alert('Visa Valid To');
										visaValTo[i].style.backgroundColor="#fbfebc";
										visaValTo[i].style.color="#000000";
										visaValTo[i].focus();
										return false;
									}
									if(durOfStay[i].value=='') 
									{	alert('Duration Of Stay');
										durOfStay[i].style.backgroundColor="#fbfebc";
										durOfStay[i].style.color="#000000";
										durOfStay[i].focus();
										return false;
									}
									if(visaCharges[i].value=='') 
									{	alert('Visa Charges');
										visaCharges[i].style.backgroundColor="#fbfebc";
										visaCharges[i].style.color="#000000";
										visaCharges[i].focus();
										return false;
									}
									if(visaRem[i].value=='' && visaStatus[i].value =='6') 
									{	alert('Enter Visa Remarks');
										visaRem[i].style.backgroundColor="#fbfebc";
										visaRem[i].style.color="#000000";
										visaRem[i].focus();
										return false;
									}
								}
								if(ppExpDate[i].value !='' && ppExpDate[i].value !='DD/MM/YYYY') 
								{	
									if(visaStatus[i].value=='' || visaStatus[i].value=='0') 
									{	alert('Select Visa Status');
										visaStatus[i].style.backgroundColor="#fbfebc";
										visaStatus[i].style.color="#000000";
										visaStatus[i].focus();
										return false;
									}
									if(pprtNo[i].value=='') 
									{	alert('Passport No.');
										pprtNo[i].style.backgroundColor="#fbfebc";
										pprtNo[i].style.color="#000000";
										pprtNo[i].focus();
										return false;
									}
									if(country[i].value=='' || country[i].value=='Country') 
									{	alert('Country');
										country[i].style.backgroundColor="#fbfebc";
										country[i].style.color="#000000";
										country[i].focus();
										return false;
									}
									/* if(visaStatus[i].value !='3' && (docRecDate[i].value=='' || docRecDate[i].value=='DD/MM/YYYY'))
									{	alert('Doc. Rec. Date');
										docRecDate[i].style.backgroundColor="#fbfebc";
										docRecDate[i].style.color="#000000";
										docRecDate[i].focus();
										return false;
									}
									if(visaIssuDate[i].value=='' || visaIssuDate[i].value=='DD/MM/YYYY') 
									{	alert('Visa Issue Date');
										visaIssuDate[i].style.backgroundColor="#fbfebc";
										visaIssuDate[i].style.color="#000000";
										visaIssuDate[i].focus();
										return false;
									} */
									if(visaValFrom[i].value=='' || visaValFrom[i].value=='DD/MM/YYYY') 
									{	alert('Visa Valid From');
										visaValFrom[i].style.backgroundColor="#fbfebc";
										visaValFrom[i].style.color="#000000";
										visaValFrom[i].focus();
										return false;
									}
									if(visaValTo[i].value=='' || visaValTo[i].value=='DD/MM/YYYY') 
									{	alert('Visa Valid To');
										visaValTo[i].style.backgroundColor="#fbfebc";
										visaValTo[i].style.color="#000000";
										visaValTo[i].focus();
										return false;
									}
									if(durOfStay[i].value=='') 
									{	alert('Duration Of Stay');
										durOfStay[i].style.backgroundColor="#fbfebc";
										durOfStay[i].style.color="#000000";
										durOfStay[i].focus();
										return false;
									}
									if(visaCharges[i].value=='') 
									{	alert('Visa Charges');
										visaCharges[i].style.backgroundColor="#fbfebc";
										visaCharges[i].style.color="#000000";
										visaCharges[i].focus();
										return false;
									}
									if(visaRem[i].value=='' && visaStatus[i].value =='6') 
									{	alert('Enter Visa Remarks');
										visaRem[i].style.backgroundColor="#fbfebc";
										visaRem[i].style.color="#000000";
										visaRem[i].focus();
										return false;
									}
								}
								if(country[i].value !='' && country[i].value !='Country') 
								{	
									if(visaStatus[i].value=='' || visaStatus[i].value=='0') 
									{	alert('Select Visa Status');
										visaStatus[i].style.backgroundColor="#fbfebc";
										visaStatus[i].style.color="#000000";
										visaStatus[i].focus();
										return false;
									}
									if(pprtNo[i].value=='') 
									{	alert('Passport No.');
										pprtNo[i].style.backgroundColor="#fbfebc";
										pprtNo[i].style.color="#000000";
										pprtNo[i].focus();
										return false;
									}
									if(ppExpDate[i].value=='' || ppExpDate[i].value=='DD/MM/YYYY') 
									{	alert('Passport Expiry Date');
										ppExpDate[i].style.backgroundColor="#fbfebc";
										ppExpDate[i].style.color="#000000";
										ppExpDate[i].focus();
										return false;
									}
									/* if(visaStatus[i].value !='3' && (docRecDate[i].value=='' || docRecDate[i].value=='DD/MM/YYYY'))
									{	alert('Doc. Rec. Date');
										docRecDate[i].style.backgroundColor="#fbfebc";
										docRecDate[i].style.color="#000000";
										docRecDate[i].focus();
										return false;
									}
									if(visaIssuDate[i].value=='' || visaIssuDate[i].value=='DD/MM/YYYY') 
									{	alert('Visa Issue Date');
										visaIssuDate[i].style.backgroundColor="#fbfebc";
										visaIssuDate[i].style.color="#000000";
										visaIssuDate[i].focus();
										return false;
									} */
									if(visaValFrom[i].value=='' || visaValFrom[i].value=='DD/MM/YYYY') 
									{	alert('Visa Valid From');
										visaValFrom[i].style.backgroundColor="#fbfebc";
										visaValFrom[i].style.color="#000000";
										visaValFrom[i].focus();
										return false;
									}
									if(visaValTo[i].value=='' || visaValTo[i].value=='DD/MM/YYYY') 
									{	alert('Visa Valid To');
										visaValTo[i].style.backgroundColor="#fbfebc";
										visaValTo[i].style.color="#000000";
										visaValTo[i].focus();
										return false;
									}
									if(durOfStay[i].value=='') 
									{	alert('Duration Of Stay');
										durOfStay[i].style.backgroundColor="#fbfebc";
										durOfStay[i].style.color="#000000";
										durOfStay[i].focus();
										return false;
									}
									if(visaCharges[i].value=='') 
									{	alert('Visa Charges');
										visaCharges[i].style.backgroundColor="#fbfebc";
										visaCharges[i].style.color="#000000";
										visaCharges[i].focus();
										return false;
									}
									if(visaRem[i].value=='' && visaStatus[i].value =='6') 
									{	alert('Enter Visa Remarks');
										visaRem[i].style.backgroundColor="#fbfebc";
										visaRem[i].style.color="#000000";
										visaRem[i].focus();
										return false;
									}
								}
								/* if(docRecDate[i].value !='' && docRecDate[i].value !='DD/MM/YYYY') 
								{	
									if(visaStatus[i].value=='' || visaStatus[i].value=='0') 
									{	alert('Select Visa Status');
										visaStatus[i].style.backgroundColor="#fbfebc";
										visaStatus[i].style.color="#000000";
										visaStatus[i].focus();
										return false;
									}
									if(pprtNo[i].value=='') 
									{	alert('Passport No.');
										pprtNo[i].style.backgroundColor="#fbfebc";
										pprtNo[i].style.color="#000000";
										pprtNo[i].focus();
										return false;
									}
									if(ppExpDate[i].value=='' || ppExpDate[i].value=='DD/MM/YYYY') 
									{	alert('Passport Expiry Date');
										ppExpDate[i].style.backgroundColor="#fbfebc";
										ppExpDate[i].style.color="#000000";
										ppExpDate[i].focus();
										return false;
									}
									if(country[i].value=='' || country[i].value=='Country') 
									{	alert('Country');
										country[i].style.backgroundColor="#fbfebc";
										country[i].style.color="#000000";
										country[i].focus();
										return false;
									}
									if(visaIssuDate[i].value=='' || visaIssuDate[i].value=='DD/MM/YYYY') 
									{	alert('Visa Issue Date');
										visaIssuDate[i].style.backgroundColor="#fbfebc";
										visaIssuDate[i].style.color="#000000";
										visaIssuDate[i].focus();
										return false;
									}
									if(visaValFrom[i].value=='' || visaValFrom[i].value=='DD/MM/YYYY') 
									{	alert('Visa Valid From');
										visaValFrom[i].style.backgroundColor="#fbfebc";
										visaValFrom[i].style.color="#000000";
										visaValFrom[i].focus();
										return false;
									}
									if(visaValTo[i].value=='' || visaValTo[i].value=='DD/MM/YYYY') 
									{	alert('Visa Valid To');
										visaValTo[i].style.backgroundColor="#fbfebc";
										visaValTo[i].style.color="#000000";
										visaValTo[i].focus();
										return false;
									}
									if(durOfStay[i].value=='') 
									{	alert('Duration Of Stay');
										durOfStay[i].style.backgroundColor="#fbfebc";
										durOfStay[i].style.color="#000000";
										durOfStay[i].focus();
										return false;
									}
									if(visaCharges[i].value=='') 
									{	alert('Visa Charges');
										visaCharges[i].style.backgroundColor="#fbfebc";
										visaCharges[i].style.color="#000000";
										visaCharges[i].focus();
										return false;
									}
									if(visaRem[i].value=='' && visaStatus[i].value =='6') 
									{	alert('Enter Visa Remarks');
										visaRem[i].style.backgroundColor="#fbfebc";
										visaRem[i].style.color="#000000";
										visaRem[i].focus();
										return false;
									}
								}
								if(visaIssuDate[i].value !='' && visaIssuDate[i].value !='DD/MM/YYYY') 
								{	
									if(visaStatus[i].value=='' || visaStatus[i].value=='0') 
									{	alert('Select Visa Status');
										visaStatus[i].style.backgroundColor="#fbfebc";
										visaStatus[i].style.color="#000000";
										visaStatus[i].focus();
										return false;
									}
									if(pprtNo[i].value=='') 
									{	alert('Passport No.');
										pprtNo[i].style.backgroundColor="#fbfebc";
										pprtNo[i].style.color="#000000";
										pprtNo[i].focus();
										return false;
									}
									if(ppExpDate[i].value=='' || ppExpDate[i].value=='DD/MM/YYYY') 
									{	alert('Passport Expiry Date');
										ppExpDate[i].style.backgroundColor="#fbfebc";
										ppExpDate[i].style.color="#000000";
										ppExpDate[i].focus();
										return false;
									}
									if(country[i].value=='' || country[i].value=='Country') 
									{	alert('Country');
										country[i].style.backgroundColor="#fbfebc";
										country[i].style.color="#000000";
										country[i].focus();
										return false;
									}
									if(visaStatus[i].value !='3' && (docRecDate[i].value=='' || docRecDate[i].value=='DD/MM/YYYY'))
									{	alert('Doc. Rec. Date');
										docRecDate[i].style.backgroundColor="#fbfebc";
										docRecDate[i].style.color="#000000";
										docRecDate[i].focus();
										return false;
									}
									if(visaValFrom[i].value=='' || visaValFrom[i].value=='DD/MM/YYYY') 
									{	alert('Visa Valid From');
										visaValFrom[i].style.backgroundColor="#fbfebc";
										visaValFrom[i].style.color="#000000";
										visaValFrom[i].focus();
										return false;
									}
									if(visaValTo[i].value=='' || visaValTo[i].value=='DD/MM/YYYY') 
									{	alert('Visa Valid To');
										visaValTo[i].style.backgroundColor="#fbfebc";
										visaValTo[i].style.color="#000000";
										visaValTo[i].focus();
										return false;
									}
									if(durOfStay[i].value=='') 
									{	alert('Duration Of Stay');
										durOfStay[i].style.backgroundColor="#fbfebc";
										durOfStay[i].style.color="#000000";
										durOfStay[i].focus();
										return false;
									}
									if(visaCharges[i].value=='') 
									{	alert('Visa Charges');
										visaCharges[i].style.backgroundColor="#fbfebc";
										visaCharges[i].style.color="#000000";
										visaCharges[i].focus();
										return false;
									}
									if(visaRem[i].value=='' && visaStatus[i].value =='6') 
									{	alert('Enter Visa Remarks');
										visaRem[i].style.backgroundColor="#fbfebc";
										visaRem[i].style.color="#000000";
										visaRem[i].focus();
										return false;
									}
								} */
								if(visaValFrom[i].value !='' && visaValFrom[i].value !='DD/MM/YYYY') 
								{	
									if(visaStatus[i].value=='' || visaStatus[i].value=='0') 
									{	alert('Select Visa Status');
										visaStatus[i].style.backgroundColor="#fbfebc";
										visaStatus[i].style.color="#000000";
										visaStatus[i].focus();
										return false;
									}
									if(pprtNo[i].value=='') 
									{	alert('Passport No.');
										pprtNo[i].style.backgroundColor="#fbfebc";
										pprtNo[i].style.color="#000000";
										pprtNo[i].focus();
										return false;
									}
									if(ppExpDate[i].value=='' || ppExpDate[i].value=='DD/MM/YYYY') 
									{	alert('Passport Expiry Date');
										ppExpDate[i].style.backgroundColor="#fbfebc";
										ppExpDate[i].style.color="#000000";
										ppExpDate[i].focus();
										return false;
									}
									if(country[i].value=='' || country[i].value=='Country') 
									{	alert('Country');
										country[i].style.backgroundColor="#fbfebc";
										country[i].style.color="#000000";
										country[i].focus();
										return false;
									}
									/* if(visaStatus[i].value !='3' && (docRecDate[i].value=='' || docRecDate[i].value=='DD/MM/YYYY'))
									{	alert('Doc. Rec. Date');
										docRecDate[i].style.backgroundColor="#fbfebc";
										docRecDate[i].style.color="#000000";
										docRecDate[i].focus();
										return false;
									}
									if(visaIssuDate[i].value=='' || visaIssuDate[i].value=='DD/MM/YYYY') 
									{	alert('Visa Issue Date');
										visaIssuDate[i].style.backgroundColor="#fbfebc";
										visaIssuDate[i].style.color="#000000";
										visaIssuDate[i].focus();
										return false;
									} */
									if(visaValTo[i].value=='' || visaValTo[i].value=='DD/MM/YYYY') 
									{	alert('Visa Valid To');
										visaValTo[i].style.backgroundColor="#fbfebc";
										visaValTo[i].style.color="#000000";
										visaValTo[i].focus();
										return false;
									}
									if(durOfStay[i].value=='') 
									{	alert('Duration Of Stay');
										durOfStay[i].style.backgroundColor="#fbfebc";
										durOfStay[i].style.color="#000000";
										durOfStay[i].focus();
										return false;
									}
									if(visaCharges[i].value=='') 
									{	alert('Visa Charges');
										visaCharges[i].style.backgroundColor="#fbfebc";
										visaCharges[i].style.color="#000000";
										visaCharges[i].focus();
										return false;
									}
									if(visaRem[i].value=='' && visaStatus[i].value =='6') 
									{	alert('Enter Visa Remarks');
										visaRem[i].style.backgroundColor="#fbfebc";
										visaRem[i].style.color="#000000";
										visaRem[i].focus();
										return false;
									}
								}
								if(visaValTo[i].value !='' && visaValTo[i].value !='DD/MM/YYYY') 
								{	
									if(visaStatus[i].value=='' || visaStatus[i].value=='0') 
									{	alert('Select Visa Status');
										visaStatus[i].style.backgroundColor="#fbfebc";
										visaStatus[i].style.color="#000000";
										visaStatus[i].focus();
										return false;
									}
									if(pprtNo[i].value=='') 
									{	alert('Passport No.');
										pprtNo[i].style.backgroundColor="#fbfebc";
										pprtNo[i].style.color="#000000";
										pprtNo[i].focus();
										return false;
									}
									if(ppExpDate[i].value=='' || ppExpDate[i].value=='DD/MM/YYYY') 
									{	alert('Passport Expiry Date');
										ppExpDate[i].style.backgroundColor="#fbfebc";
										ppExpDate[i].style.color="#000000";
										ppExpDate[i].focus();
										return false;
									}
									if(country[i].value=='' || country[i].value=='Country') 
									{	alert('Country');
										country[i].style.backgroundColor="#fbfebc";
										country[i].style.color="#000000";
										country[i].focus();
										return false;
									}
									/* if(visaStatus[i].value !='3' && (docRecDate[i].value=='' || docRecDate[i].value=='DD/MM/YYYY'))
									{	alert('Doc. Rec. Date');
										docRecDate[i].style.backgroundColor="#fbfebc";
										docRecDate[i].style.color="#000000";
										docRecDate[i].focus();
										return false;
									}
									if(visaIssuDate[i].value=='' || visaIssuDate[i].value=='DD/MM/YYYY') 
									{	alert('Visa Issue Date');
										visaIssuDate[i].style.backgroundColor="#fbfebc";
										visaIssuDate[i].style.color="#000000";
										visaIssuDate[i].focus();
										return false;
									} */
									if(visaValFrom[i].value=='' || visaValFrom[i].value=='DD/MM/YYYY') 
									{	alert('Visa Valid From');
										visaValFrom[i].style.backgroundColor="#fbfebc";
										visaValFrom[i].style.color="#000000";
										visaValFrom[i].focus();
										return false;
									}
									if(durOfStay[i].value=='') 
									{	alert('Duration Of Stay');
										durOfStay[i].style.backgroundColor="#fbfebc";
										durOfStay[i].style.color="#000000";
										durOfStay[i].focus();
										return false;
									}
									if(visaCharges[i].value=='') 
									{	alert('Visa Charges');
										visaCharges[i].style.backgroundColor="#fbfebc";
										visaCharges[i].style.color="#000000";
										visaCharges[i].focus();
										return false;
									}
									if(visaRem[i].value=='' && visaStatus[i].value =='6') 
									{	alert('Enter Visa Remarks');
										visaRem[i].style.backgroundColor="#fbfebc";
										visaRem[i].style.color="#000000";
										visaRem[i].focus();
										return false;
									}
								}
								if(durOfStay[i].value !='') 
								{	
									if(visaStatus[i].value=='' || visaStatus[i].value=='0') 
									{	alert('Select Visa Status');
										visaStatus[i].style.backgroundColor="#fbfebc";
										visaStatus[i].style.color="#000000";
										visaStatus[i].focus();
										return false;
									}
									if(pprtNo[i].value=='') 
									{	alert('Passport No.');
										pprtNo[i].style.backgroundColor="#fbfebc";
										pprtNo[i].style.color="#000000";
										pprtNo[i].focus();
										return false;
									}
									if(ppExpDate[i].value=='' || ppExpDate[i].value=='DD/MM/YYYY') 
									{	alert('Passport Expiry Date');
										ppExpDate[i].style.backgroundColor="#fbfebc";
										ppExpDate[i].style.color="#000000";
										ppExpDate[i].focus();
										return false;
									}
									if(country[i].value=='' || country[i].value=='Country') 
									{	alert('Country');
										country[i].style.backgroundColor="#fbfebc";
										country[i].style.color="#000000";
										country[i].focus();
										return false;
									}
									/* if(visaStatus[i].value !='3' && (docRecDate[i].value=='' || docRecDate[i].value=='DD/MM/YYYY'))
									{	alert('Doc. Rec. Date');
										docRecDate[i].style.backgroundColor="#fbfebc";
										docRecDate[i].style.color="#000000";
										docRecDate[i].focus();
										return false;
									}
									if(visaIssuDate[i].value=='' || visaIssuDate[i].value=='DD/MM/YYYY') 
									{	alert('Visa Issue Date');
										visaIssuDate[i].style.backgroundColor="#fbfebc";
										visaIssuDate[i].style.color="#000000";
										visaIssuDate[i].focus();
										return false;
									} */
									if(visaValFrom[i].value=='' || visaValFrom[i].value=='DD/MM/YYYY') 
									{	alert('Visa Valid From');
										visaValFrom[i].style.backgroundColor="#fbfebc";
										visaValFrom[i].style.color="#000000";
										visaValFrom[i].focus();
										return false;
									}
									if(visaValTo[i].value=='' || visaValTo[i].value=='DD/MM/YYYY') 
									{	alert('Visa Valid To');
										visaValTo[i].style.backgroundColor="#fbfebc";
										visaValTo[i].style.color="#000000";
										visaValTo[i].focus();
										return false;
									}
									if(visaCharges[i].value=='') 
									{	alert('Visa Charges');
										visaCharges[i].style.backgroundColor="#fbfebc";
										visaCharges[i].style.color="#000000";
										visaCharges[i].focus();
										return false;
									}
									if(visaRem[i].value=='' && visaStatus[i].value =='6') 
									{	alert('Enter Visa Remarks');
										visaRem[i].style.backgroundColor="#fbfebc";
										visaRem[i].style.color="#000000";
										visaRem[i].focus();
										return false;
									}
								}
								if(visaCharges[i].value !='') 
								{	
									if(visaStatus[i].value=='' || visaStatus[i].value=='0') 
									{	alert('Select Visa Status');
										visaStatus[i].style.backgroundColor="#fbfebc";
										visaStatus[i].style.color="#000000";
										visaStatus[i].focus();
										return false;
									}
									if(pprtNo[i].value=='') 
									{	alert('Passport No.');
										pprtNo[i].style.backgroundColor="#fbfebc";
										pprtNo[i].style.color="#000000";
										pprtNo[i].focus();
										return false;
									}
									if(ppExpDate[i].value=='' || ppExpDate[i].value=='DD/MM/YYYY') 
									{	alert('Passport Expiry Date');
										ppExpDate[i].style.backgroundColor="#fbfebc";
										ppExpDate[i].style.color="#000000";
										ppExpDate[i].focus();
										return false;
									}
									if(country[i].value=='' || country[i].value=='Country') 
									{	alert('Country');
										country[i].style.backgroundColor="#fbfebc";
										country[i].style.color="#000000";
										country[i].focus();
										return false;
									}
									/* if(visaStatus[i].value !='3' && (docRecDate[i].value=='' || docRecDate[i].value=='DD/MM/YYYY'))
									{	alert('Doc. Rec. Date');
										docRecDate[i].style.backgroundColor="#fbfebc";
										docRecDate[i].style.color="#000000";
										docRecDate[i].focus();
										return false;
									}
									if(visaIssuDate[i].value=='' || visaIssuDate[i].value=='DD/MM/YYYY') 
									{	alert('Visa Issue Date');
										visaIssuDate[i].style.backgroundColor="#fbfebc";
										visaIssuDate[i].style.color="#000000";
										visaIssuDate[i].focus();
										return false;
									} */
									if(visaValFrom[i].value=='' || visaValFrom[i].value=='DD/MM/YYYY') 
									{	alert('Visa Valid From');
										visaValFrom[i].style.backgroundColor="#fbfebc";
										visaValFrom[i].style.color="#000000";
										visaValFrom[i].focus();
										return false;
									}
									if(visaValTo[i].value=='' || visaValTo[i].value=='DD/MM/YYYY') 
									{	alert('Visa Valid To');
										visaValTo[i].style.backgroundColor="#fbfebc";
										visaValTo[i].style.color="#000000";
										visaValTo[i].focus();
										return false;
									}
									if(durOfStay[i].value=='') 
									{	alert('Duration Of Stay');
										durOfStay[i].style.backgroundColor="#fbfebc";
										durOfStay[i].style.color="#000000";
										durOfStay[i].focus();
										return false;
									}
									if(visaRem[i].value=='' && visaStatus[i].value =='6') 
									{	alert('Enter Visa Remarks');
										visaRem[i].style.backgroundColor="#fbfebc";
										visaRem[i].style.color="#000000";
										visaRem[i].focus();
										return false;
									}
								}
								if(visaRem[i].value !='') 
								{
									if(visaStatus[i].value=='' || visaStatus[i].value=='0') 
									{	alert('Select Visa Status');
										visaStatus[i].style.backgroundColor="#fbfebc";
										visaStatus[i].style.color="#000000";
										visaStatus[i].focus();
										return false;
									}
									if(pprtNo[i].value=='') 
									{	alert('Passport No.');
										pprtNo[i].style.backgroundColor="#fbfebc";
										pprtNo[i].style.color="#000000";
										pprtNo[i].focus();
										return false;
									}
									if(ppExpDate[i].value=='' || ppExpDate[i].value=='DD/MM/YYYY') 
									{	alert('Passport Expiry Date');
										ppExpDate[i].style.backgroundColor="#fbfebc";
										ppExpDate[i].style.color="#000000";
										ppExpDate[i].focus();
										return false;
									}
									if(country[i].value=='' || country[i].value=='Country') 
									{	alert('Country');
										country[i].style.backgroundColor="#fbfebc";
										country[i].style.color="#000000";
										country[i].focus();
										return false;
									}
									/* if(visaStatus[i].value !='3' && (docRecDate[i].value=='' || docRecDate[i].value=='DD/MM/YYYY'))
									{	alert('Doc. Rec. Date');
										docRecDate[i].style.backgroundColor="#fbfebc";
										docRecDate[i].style.color="#000000";
										docRecDate[i].focus();
										return false;
									}
									if(visaIssuDate[i].value=='' || visaIssuDate[i].value=='DD/MM/YYYY') 
									{	alert('Visa Issue Date');
										visaIssuDate[i].style.backgroundColor="#fbfebc";
										visaIssuDate[i].style.color="#000000";
										visaIssuDate[i].focus();
										return false;
									} */
									if(visaValFrom[i].value=='' || visaValFrom[i].value=='DD/MM/YYYY') 
									{	alert('Visa Valid From');
										visaValFrom[i].style.backgroundColor="#fbfebc";
										visaValFrom[i].style.color="#000000";
										visaValFrom[i].focus();
										return false;
									}
									if(visaValTo[i].value=='' || visaValTo[i].value=='DD/MM/YYYY') 
									{	alert('Visa Valid To');
										visaValTo[i].style.backgroundColor="#fbfebc";
										visaValTo[i].style.color="#000000";
										visaValTo[i].focus();
										return false;
									}
									if(durOfStay[i].value=='') 
									{	alert('Duration Of Stay');
										durOfStay[i].style.backgroundColor="#fbfebc";
										durOfStay[i].style.color="#000000";
										durOfStay[i].focus();
										return false;
									}
									if(visaCharges[i].value=='') 
									{	alert('Visa Charges');
										visaCharges[i].style.backgroundColor="#fbfebc";
										visaCharges[i].style.color="#000000";
										visaCharges[i].focus();
										return false;
									}
								}
							}
						}
					}
				}	
			
				if(subRole.indexOf("TC_INSU")>=0 || trvlBookId=="0")	
				{	if(insChkYFlag == true) 
					{	if(rowCountInsu >= 1) 
						{	for (var i = 0, len = rowCountInsu; i < len; i++) 
							{	if(insuPolNo[i].value !='') 
								{	if(insuStDate[i].value=='' || insuStDate[i].value=='DD/MM/YYYY') 
									{	alert('Insurance Start Date');
										insuStDate[i].style.backgroundColor="#fbfebc";
										insuStDate[i].style.color="#000000";
										insuStDate[i].focus();
										return false;
									}
									if(insuEndDate[i].value=='' || insuEndDate[i].value=='DD/MM/YYYY') 
									{	alert('Insurance End Date');
										insuEndDate[i].style.backgroundColor="#fbfebc";
										insuEndDate[i].style.color="#000000";
										insuEndDate[i].focus();
										return false;
									}
									if(nominee[i].value=='') 
									{	alert('Nominee');
										nominee[i].style.backgroundColor="#fbfebc";
										nominee[i].style.color="#000000";
										nominee[i].focus();
										return false;
									}
									if(relation[i].value=='') 
									{	alert('Relation');
										relation[i].style.backgroundColor="#fbfebc";
										relation[i].style.color="#000000";
										relation[i].focus();
										return false;
									}
									if(insuCharges[i].value=='') 
									{	alert('Insurance Charges');
										insuCharges[i].style.backgroundColor="#fbfebc";
										insuCharges[i].style.color="#000000";
										insuCharges[i].focus();
										return false;
									}
									if(insuStatus[i].value=='2' && (insuRemarks[i].value=='' || insuRemarks[i].value=='*Enter Policy No.')) 
									{	alert('Insurance Remarks');
										insuRemarks[i].style.backgroundColor="#fbfebc";
										insuRemarks[i].style.color="#000000";
										insuRemarks[i].focus();
										return false;
									}
								}
								if(insuStDate[i].value !='' && insuStDate[i].value !='DD/MM/YYYY') 
								{	if(insuPolNo[i].value=='') 
									{	alert('Policy No.');
										insuPolNo[i].style.backgroundColor="#fbfebc";
										insuPolNo[i].style.color="#000000";
										insuPolNo[i].focus();
										return false;
									}
									if(insuEndDate[i].value=='' || insuEndDate[i].value=='DD/MM/YYYY') 
									{	alert('Insurance End Date');
										insuEndDate[i].style.backgroundColor="#fbfebc";
										insuEndDate[i].style.color="#000000";
										insuEndDate[i].focus();
										return false;
									}
									if(nominee[i].value=='') 
									{	alert('Nominee');
										nominee[i].style.backgroundColor="#fbfebc";
										nominee[i].style.color="#000000";
										nominee[i].focus();
										return false;
									}
									if(relation[i].value=='') 
									{	alert('Relation');
										relation[i].style.backgroundColor="#fbfebc";
										relation[i].style.color="#000000";
										relation[i].focus();
										return false;
									}
									if(insuCharges[i].value=='') 
									{	alert('Insurance Charges');
										insuCharges[i].style.backgroundColor="#fbfebc";
										insuCharges[i].style.color="#000000";
										insuCharges[i].focus();
										return false;
									}
									if(insuStatus[i].value=='2' && (insuRemarks[i].value=='' || insuRemarks[i].value=='*Enter Policy No.')) 
									{	alert('Insurance Remarks');
										insuRemarks[i].style.backgroundColor="#fbfebc";
										insuRemarks[i].style.color="#000000";
										insuRemarks[i].focus();
										return false;
									}
								}
								if(insuEndDate[i].value !='' && insuEndDate[i].value !='DD/MM/YYYY') 
								{	
									if(insuPolNo[i].value=='') 
									{	alert('Policy No.');
										insuPolNo[i].style.backgroundColor="#fbfebc";
										insuPolNo[i].style.color="#000000";
										insuPolNo[i].focus();
										return false;
									}
									if(insuStDate[i].value=='' || insuStDate[i].value=='DD/MM/YYYY') 
									{	alert('Insurance Start Date');
										insuStDate[i].style.backgroundColor="#fbfebc";
										insuStDate[i].style.color="#000000";
										insuStDate[i].focus();
										return false;
									}
									if(nominee[i].value=='') 
									{	alert('Nominee');
										nominee[i].style.backgroundColor="#fbfebc";
										nominee[i].style.color="#000000";
										nominee[i].focus();
										return false;
									}
									if(relation[i].value=='') 
									{	alert('Relation');
										relation[i].style.backgroundColor="#fbfebc";
										relation[i].style.color="#000000";
										relation[i].focus();
										return false;
									}
									if(insuCharges[i].value=='') 
									{	alert('Insurance Charges');
										insuCharges[i].style.backgroundColor="#fbfebc";
										insuCharges[i].style.color="#000000";
										insuCharges[i].focus();
										return false;
									}
									if(insuStatus[i].value=='2' && (insuRemarks[i].value=='' || insuRemarks[i].value=='*Enter Policy No.')) 
									{	alert('Insurance Remarks');
										insuRemarks[i].style.backgroundColor="#fbfebc";
										insuRemarks[i].style.color="#000000";
										insuRemarks[i].focus();
										return false;
									}
								}
								if(nominee[i].value !='') 
								{	
									if(insuPolNo[i].value=='') 
									{	alert('Policy No.');
										insuPolNo[i].style.backgroundColor="#fbfebc";
										insuPolNo[i].style.color="#000000";
										insuPolNo[i].focus();
										return false;
									}
									if(insuStDate[i].value=='' || insuStDate[i].value=='DD/MM/YYYY') 
									{	alert('Insurance Start Date');
										insuStDate[i].style.backgroundColor="#fbfebc";
										insuStDate[i].style.color="#000000";
										insuStDate[i].focus();
										return false;
									}
									if(insuEndDate[i].value=='' || insuEndDate[i].value=='DD/MM/YYYY') 
									{	alert('Insurance End Date');
										insuEndDate[i].style.backgroundColor="#fbfebc";
										insuEndDate[i].style.color="#000000";
										insuEndDate[i].focus();
										return false;
									}
									if(relation[i].value=='') 
									{	alert('Relation');
										relation[i].style.backgroundColor="#fbfebc";
										relation[i].style.color="#000000";
										relation[i].focus();
										return false;
									}
									if(insuCharges[i].value=='') 
									{	alert('Insurance Charges');
										insuCharges[i].style.backgroundColor="#fbfebc";
										insuCharges[i].style.color="#000000";
										insuCharges[i].focus();
										return false;
									}
									if(insuStatus[i].value=='2' && (insuRemarks[i].value=='' || insuRemarks[i].value=='*Enter Policy No.')) 
									{	alert('Insurance Remarks');
										insuRemarks[i].style.backgroundColor="#fbfebc";
										insuRemarks[i].style.color="#000000";
										insuRemarks[i].focus();
										return false;
									}
								}
								if(relation[i].value !='') 
								{	
									if(insuPolNo[i].value=='') 
									{	alert('Policy No.');
										insuPolNo[i].style.backgroundColor="#fbfebc";
										insuPolNo[i].style.color="#000000";
										insuPolNo[i].focus();
										return false;
									}
									if(insuStDate[i].value=='' || insuStDate[i].value=='DD/MM/YYYY') 
									{	alert('Insurance Start Date');
										insuStDate[i].style.backgroundColor="#fbfebc";
										insuStDate[i].style.color="#000000";
										insuStDate[i].focus();
										return false;
									}
									if(insuEndDate[i].value=='' || insuEndDate[i].value=='DD/MM/YYYY') 
									{	alert('Insurance End Date');
										insuEndDate[i].style.backgroundColor="#fbfebc";
										insuEndDate[i].style.color="#000000";
										insuEndDate[i].focus();
										return false;
									}
									if(nominee[i].value=='') 
									{	alert('Nominee');
										nominee[i].style.backgroundColor="#fbfebc";
										nominee[i].style.color="#000000";
										nominee[i].focus();
										return false;
									}
									if(insuCharges[i].value=='') 
									{	alert('Insurance Charges');
										insuCharges[i].style.backgroundColor="#fbfebc";
										insuCharges[i].style.color="#000000";
										insuCharges[i].focus();
										return false;
									}
									if(insuStatus[i].value=='2' && (insuRemarks[i].value=='' || insuRemarks[i].value=='*Enter Policy No.')) 
									{	alert('Insurance Remarks');
										insuRemarks[i].style.backgroundColor="#fbfebc";
										insuRemarks[i].style.color="#000000";
										insuRemarks[i].focus();
										return false;
									}
								}
								if(insuCharges[i].value !='') 
								{	
									if(insuPolNo[i].value=='') 
									{	alert('Policy No.');
										insuPolNo[i].style.backgroundColor="#fbfebc";
										insuPolNo[i].style.color="#000000";
										insuPolNo[i].focus();
										return false;
									}
									if(insuStDate[i].value=='' || insuStDate[i].value=='DD/MM/YYYY') 
									{	alert('Insurance Start Date');
										insuStDate[i].style.backgroundColor="#fbfebc";
										insuStDate[i].style.color="#000000";
										insuStDate[i].focus();
										return false;
									}
									if(insuEndDate[i].value=='' || insuEndDate[i].value=='DD/MM/YYYY') 
									{	alert('Insurance End Date');
										insuEndDate[i].style.backgroundColor="#fbfebc";
										insuEndDate[i].style.color="#000000";
										insuEndDate[i].focus();
										return false;
									}
									if(nominee[i].value=='') 
									{	alert('Nominee');
										nominee[i].style.backgroundColor="#fbfebc";
										nominee[i].style.color="#000000";
										nominee[i].focus();
										return false;
									}
									if(relation[i].value=='') 
									{	alert('Relation');
										relation[i].style.backgroundColor="#fbfebc";
										relation[i].style.color="#000000";
										relation[i].focus();
										return false;
									}
									if(insuStatus[i].value=='2' && (insuRemarks[i].value=='' || insuRemarks[i].value=='*Enter Policy No.')) 
									{	alert('Insurance Remarks');
										insuRemarks[i].style.backgroundColor="#fbfebc";
										insuRemarks[i].style.color="#000000";
										insuRemarks[i].focus();
										return false;
									}
								}
								if(insuRemarks[i].value != '' && insuRemarks[i].value != '*Enter Policy No.') 
								{	
									if(insuPolNo[i].value=='') 
									{	alert('Policy No.');
										insuPolNo[i].style.backgroundColor="#fbfebc";
										insuPolNo[i].style.color="#000000";
										insuPolNo[i].focus();
										return false;
									}
									if(insuStDate[i].value=='' || insuStDate[i].value=='DD/MM/YYYY') 
									{	alert('Insurance Start Date');
										insuStDate[i].style.backgroundColor="#fbfebc";
										insuStDate[i].style.color="#000000";
										insuStDate[i].focus();
										return false;
									}
									if(insuEndDate[i].value=='' || insuEndDate[i].value=='DD/MM/YYYY') 
									{	alert('Insurance End Date');
										insuEndDate[i].style.backgroundColor="#fbfebc";
										insuEndDate[i].style.color="#000000";
										insuEndDate[i].focus();
										return false;
									}
									if(nominee[i].value=='') 
									{	alert('Nominee');
										nominee[i].style.backgroundColor="#fbfebc";
										nominee[i].style.color="#000000";
										nominee[i].focus();
										return false;
									}
									if(relation[i].value=='') 
									{	alert('Relation');
										relation[i].style.backgroundColor="#fbfebc";
										relation[i].style.color="#000000";
										relation[i].focus();
										return false;
									}
									if(insuCharges[i].value=='') 
									{	alert('Insurance Charges');
										insuCharges[i].style.backgroundColor="#fbfebc";
										insuCharges[i].style.color="#000000";
										insuCharges[i].focus();
										return false;
									}
								}
							}
						}
					}
				}
			
				if(subRole.indexOf("TC_ACCO")>=0 || trvlBookId=="0")	
				{	if(accChkYFlag == true) 
					{	if(rowCountAcc >= 1) 
						{	for (var i = 0, len = rowCountAcc; i < len; i++) 
							{	
								if(location[i].value !='' && location[i].value !='Location') 
								{	if(chkInDate[i].value=='' || chkInDate[i].value=='DD/MM/YYYY') 
									{	alert('Check In Date');
										chkInDate[i].style.backgroundColor="#fbfebc";
										chkInDate[i].style.color="#000000";
										chkInDate[i].focus();
										return false;
									}
									if(chkOutDate[i].value=='' || chkOutDate[i].value=='DD/MM/YYYY') 
									{	alert('Check Out Date');
										chkOutDate[i].style.backgroundColor="#fbfebc";
										chkOutDate[i].style.color="#000000";
										chkOutDate[i].focus();
										return false;
									}
									if(stayCharges[i].value=='') 
									{	alert('Stay Charges');
										stayCharges[i].style.backgroundColor="#fbfebc";
										stayCharges[i].style.color="#000000";
										stayCharges[i].focus();
										return false;
									}
								}
								if(chkInDate[i].value !='' && chkInDate[i].value !='DD/MM/YYYY') 
								{
									if(location[i].value =='' || location[i].value =='Location') 
									{	alert('Location');
										location[i].style.backgroundColor="#fbfebc";
										location[i].style.color="#000000";
										location[i].focus();
										return false;
									}
									if(chkOutDate[i].value=='' || chkOutDate[i].value=='DD/MM/YYYY') 
									{	alert('Check Out Date');
										chkOutDate[i].style.backgroundColor="#fbfebc";
										chkOutDate[i].style.color="#000000";
										chkOutDate[i].focus();
										return false;
									}
									if(stayCharges[i].value=='') 
									{	alert('Stay Charges');
										stayCharges[i].style.backgroundColor="#fbfebc";
										stayCharges[i].style.color="#000000";
										stayCharges[i].focus();
										return false;
									}
								}
								if(chkOutDate[i].value !='' && chkOutDate[i].value !='DD/MM/YYYY') 
								{
									if(location[i].value =='' || location[i].value =='Location') 
									{	alert('Location');
										location[i].style.backgroundColor="#fbfebc";
										location[i].style.color="#000000";
										location[i].focus();
										return false;
									}
									if(chkInDate[i].value=='' || chkInDate[i].value=='DD/MM/YYYY') 
									{	alert('Check In Date');
										chkInDate[i].style.backgroundColor="#fbfebc";
										chkInDate[i].style.color="#000000";
										chkInDate[i].focus();
										return false;
									}
									if(stayCharges[i].value=='') 
									{	alert('Stay Charges');
										stayCharges[i].style.backgroundColor="#fbfebc";
										stayCharges[i].style.color="#000000";
										stayCharges[i].focus();
										return false;
									}
								}
								if(stayCharges[i].value !='') 
								{
									if(location[i].value =='' || location[i].value == 'Location') 
									{	alert('Location');
										location[i].style.backgroundColor="#fbfebc";
										location[i].style.color="#000000";
										location[i].focus();
										return false;
									}
									if(chkInDate[i].value=='' || chkInDate[i].value=='DD/MM/YYYY') 
									{	alert('Check In Date');
										chkInDate[i].style.backgroundColor="#fbfebc";
										chkInDate[i].style.color="#000000";
										chkInDate[i].focus();
										return false;
									}
									if(chkOutDate[i].value=='' || chkOutDate[i].value=='DD/MM/YYYY') 
									{	alert('Check Out Date');
										chkOutDate[i].style.backgroundColor="#fbfebc";
										chkOutDate[i].style.color="#000000";
										chkOutDate[i].focus();
										return false;
									}
								}
							}
						}
					}
				}
			}
			
			var tktIssuDate = document.getElementsByName("tktIssuDate");
			var cnclSecFrom = document.getElementsByName("cnclSecFrom");	
			var cnclSecTo 	= document.getElementsByName("cnclSecTo");
			var tktCnclDate = document.getElementsByName("tktCnclDate");
			var pnrNo 		= document.getElementsByName("pnrNo");
			var tktNo 		= document.getElementsByName("tktNo");
			var cnclCharges = document.getElementsByName("cnclCharges");
			var cnclReason 	= document.getElementsByName("cnclReason");
			
			if(subRole.indexOf("TC_TICK")>=0 || subRole.indexOf("TC_ADMI")>=0 || trvlBookId=="0")	
			{	//if(cnclChkYFlag == true) {
					if(rowCountCncl >= 1) 
					{	for (var i = 0, len = rowCountCncl; i < len; i++) 
						{	
							if (document.getElementById('chkbox'+i).checked) 
							{
								if(tktIssuDate[i].value !='' && tktIssuDate[i].value !='DD/MM/YYYY') 
								{	if(cnclSecFrom[i].value=='' || cnclSecFrom[i].value=='<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>') 
									{	alert('Cancellation: Sector From');
										cnclSecFrom[i].style.backgroundColor="#fbfebc";
										cnclSecFrom[i].style.color="#000000";
										cnclSecFrom[i].focus();
										return false;
									}
									if(cnclSecTo[i].value=='' || cnclSecTo[i].value=='<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>') 
									{	alert('Cancellation: Sector To');
										cnclSecTo[i].style.backgroundColor="#fbfebc";
										cnclSecTo[i].style.color="#000000";
										cnclSecTo[i].focus();
										return false;
									}
									if(tktCnclDate[i].value=='' || tktCnclDate[i].value=='DD/MM/YYYY') 
									{	alert('Cancellation: Ticket Cancel Date');
										tktCnclDate[i].style.backgroundColor="#fbfebc";
										tktCnclDate[i].style.color="#000000";
										tktCnclDate[i].focus();
										return false;
									}
									if(pnrNo[i].value=='') 
									{	alert('Cancellation: PNR No.');
										pnrNo[i].style.backgroundColor="#fbfebc";
										pnrNo[i].style.color="#000000";
										pnrNo[i].focus();
										return false;
									}
									if(tktNo[i].value=='') 
									{	alert('Cancellation: Ticket No.');
										tktNo[i].style.backgroundColor="#fbfebc";
										tktNo[i].style.color="#000000";
										tktNo[i].focus();
										return false;
									}
									if(cnclCharges[i].value=='') 
									{	alert('Cancellation Charges');
										cnclCharges[i].style.backgroundColor="#fbfebc";
										cnclCharges[i].style.color="#000000";
										cnclCharges[i].focus();
										return false;
									}
									if(cnclReason[i].value=='') 
									{	alert('Cancellation Reason');
										cnclReason[i].style.backgroundColor="#fbfebc";
										cnclReason[i].style.color="#000000";
										cnclReason[i].focus();
										return false;
									}
								}
								if(cnclSecFrom[i].value !='' && cnclSecFrom[i].value != '<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>') 
								{	if(tktIssuDate[i].value=='' || tktIssuDate[i].value=='DD/MM/YYYY') 
									{	alert('Cancellation: Ticket Issue Date');
										tktIssuDate[i].style.backgroundColor="#fbfebc";
										tktIssuDate[i].style.color="#000000";
										tktIssuDate[i].focus();
										return false;
									}
									if(cnclSecTo[i].value=='' || cnclSecTo[i].value=='<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>') 
									{	alert('Cancellation: Sector To');
										cnclSecTo[i].style.backgroundColor="#fbfebc";
										cnclSecTo[i].style.color="#000000";
										cnclSecTo[i].focus();
										return false;
									}
									if(tktCnclDate[i].value=='' || tktCnclDate[i].value=='DD/MM/YYYY') 
									{	alert('Cancellation: Ticket Cancel Date');
										tktCnclDate[i].style.backgroundColor="#fbfebc";
										tktCnclDate[i].style.color="#000000";
										tktCnclDate[i].focus();
										return false;
									}
									if(pnrNo[i].value=='') 
									{	alert('Cancellation: PNR No.');
										pnrNo[i].style.backgroundColor="#fbfebc";
										pnrNo[i].style.color="#000000";
										pnrNo[i].focus();
										return false;
									}
									if(tktNo[i].value=='') 
									{	alert('Cancellation: Ticket No.');
										tktNo[i].style.backgroundColor="#fbfebc";
										tktNo[i].style.color="#000000";
										tktNo[i].focus();
										return false;
									}
									if(cnclCharges[i].value=='') 
									{	alert('Cancellation Charges');
										cnclCharges[i].style.backgroundColor="#fbfebc";
										cnclCharges[i].style.color="#000000";
										cnclCharges[i].focus();
										return false;
									}
									if(cnclReason[i].value=='') 
									{	alert('Cancellation Reason');
										cnclReason[i].style.backgroundColor="#fbfebc";
										cnclReason[i].style.color="#000000";
										cnclReason[i].focus();
										return false;
									}
								}
								if(cnclSecTo[i].value !='' && cnclSecTo[i].value != '<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>') 
								{	
									if(tktIssuDate[i].value=='' || tktIssuDate[i].value=='DD/MM/YYYY') 
									{	alert('Cancellation: Ticket Issue Date');
										tktIssuDate[i].style.backgroundColor="#fbfebc";
										tktIssuDate[i].style.color="#000000";
										tktIssuDate[i].focus();
										return false;
									}
									if(cnclSecFrom[i].value=='' || cnclSecFrom[i].value=='<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>') 
									{	alert('Cancellation: Sector From');
										cnclSecFrom[i].style.backgroundColor="#fbfebc";
										cnclSecFrom[i].style.color="#000000";
										cnclSecFrom[i].focus();
										return false;
									}
									if(tktCnclDate[i].value=='' || tktCnclDate[i].value=='DD/MM/YYYY') 
									{	alert('Cancellation: Ticket Cancel Date');
										tktCnclDate[i].style.backgroundColor="#fbfebc";
										tktCnclDate[i].style.color="#000000";
										tktCnclDate[i].focus();
										return false;
									}
									if(pnrNo[i].value=='') 
									{	alert('Cancellation: PNR No.');
										pnrNo[i].style.backgroundColor="#fbfebc";
										pnrNo[i].style.color="#000000";
										pnrNo[i].focus();
										return false;
									}
									if(tktNo[i].value=='') 
									{	alert('Cancellation: Ticket No.');
										tktNo[i].style.backgroundColor="#fbfebc";
										tktNo[i].style.color="#000000";
										tktNo[i].focus();
										return false;
									}
									if(cnclCharges[i].value=='') 
									{	alert('Cancellation Charges');
										cnclCharges[i].style.backgroundColor="#fbfebc";
										cnclCharges[i].style.color="#000000";
										cnclCharges[i].focus();
										return false;
									}
									if(cnclReason[i].value=='') 
									{	alert('Cancellation Reason');
										cnclReason[i].style.backgroundColor="#fbfebc";
										cnclReason[i].style.color="#000000";
										cnclReason[i].focus();
										return false;
									}
								}
								if(tktCnclDate[i].value !='' && tktCnclDate[i].value !='DD/MM/YYYY') 
								{	
									if(tktIssuDate[i].value=='' || tktIssuDate[i].value=='DD/MM/YYYY') 
									{	alert('Cancellation: Ticket Issue Date');
										tktIssuDate[i].style.backgroundColor="#fbfebc";
										tktIssuDate[i].style.color="#000000";
										tktIssuDate[i].focus();
										return false;
									}
									if(cnclSecFrom[i].value=='' || cnclSecFrom[i].value=='<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>') 
									{	alert('Cancellation: Sector From');
										cnclSecFrom[i].style.backgroundColor="#fbfebc";
										cnclSecFrom[i].style.color="#000000";
										cnclSecFrom[i].focus();
										return false;
									}
									if(cnclSecTo[i].value=='' || cnclSecTo[i].value=='<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>') 
									{	alert('Cancellation: Sector To');
										cnclSecTo[i].style.backgroundColor="#fbfebc";
										cnclSecTo[i].style.color="#000000";
										cnclSecTo[i].focus();
										return false;
									}
									if(pnrNo[i].value=='') 
									{	alert('Cancellation: PNR No.');
										pnrNo[i].style.backgroundColor="#fbfebc";
										pnrNo[i].style.color="#000000";
										pnrNo[i].focus();
										return false;
									}
									if(tktNo[i].value=='') 
									{	alert('Cancellation: Ticket No.');
										tktNo[i].style.backgroundColor="#fbfebc";
										tktNo[i].style.color="#000000";
										tktNo[i].focus();
										return false;
									}
									if(cnclCharges[i].value=='') 
									{	alert('Cancellation Charges');
										cnclCharges[i].style.backgroundColor="#fbfebc";
										cnclCharges[i].style.color="#000000";
										cnclCharges[i].focus();
										return false;
									}
									if(cnclReason[i].value=='') 
									{	alert('Cancellation Reason');
										cnclReason[i].style.backgroundColor="#fbfebc";
										cnclReason[i].style.color="#000000";
										cnclReason[i].focus();
										return false;
									}
								}
								if(pnrNo[i].value !='') 
								{	
									if(tktIssuDate[i].value=='' || tktIssuDate[i].value=='DD/MM/YYYY') 
									{	alert('Cancellation: Ticket Issue Date');
										tktIssuDate[i].style.backgroundColor="#fbfebc";
										tktIssuDate[i].style.color="#000000";
										tktIssuDate[i].focus();
										return false;
									}
									if(cnclSecFrom[i].value=='' || cnclSecFrom[i].value=='<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>') 
									{	alert('Cancellation: Sector From');
										cnclSecFrom[i].style.backgroundColor="#fbfebc";
										cnclSecFrom[i].style.color="#000000";
										cnclSecFrom[i].focus();
										return false;
									}
									if(cnclSecTo[i].value=='' || cnclSecTo[i].value=='<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>') 
									{	alert('Cancellation: Sector To');
										cnclSecTo[i].style.backgroundColor="#fbfebc";
										cnclSecTo[i].style.color="#000000";
										cnclSecTo[i].focus();
										return false;
									}
									if(tktCnclDate[i].value=='' || tktCnclDate[i].value=='DD/MM/YYYY') 
									{	alert('Cancellation: Ticket Cancel Date');
										tktCnclDate[i].style.backgroundColor="#fbfebc";
										tktCnclDate[i].style.color="#000000";
										tktCnclDate[i].focus();
										return false;
									}
									if(tktNo[i].value=='') 
									{	alert('Cancellation: Ticket No.');
										tktNo[i].style.backgroundColor="#fbfebc";
										tktNo[i].style.color="#000000";
										tktNo[i].focus();
										return false;
									}
									if(cnclCharges[i].value=='') 
									{	alert('Cancellation Charges');
										cnclCharges[i].style.backgroundColor="#fbfebc";
										cnclCharges[i].style.color="#000000";
										cnclCharges[i].focus();
										return false;
									}
									if(cnclReason[i].value=='') 
									{	alert('Cancellation Reason');
										cnclReason[i].style.backgroundColor="#fbfebc";
										cnclReason[i].style.color="#000000";
										cnclReason[i].focus();
										return false;
									}
								}
								if(tktNo[i].value !='') 
								{	
									var str = validateTktNo(tktNo[i].value);
									if (str== false)
									{	alert('Cancellation: Ticket No.');
										tktNo[i].style.backgroundColor="#fbfebc";
										tktNo[i].style.color="#000000";
										tktNo[i].focus();
										return false;		
									}
									
									if(tktIssuDate[i].value=='' || tktIssuDate[i].value=='DD/MM/YYYY') 
									{	alert('Cancellation: Ticket Issue Date');
										tktIssuDate[i].style.backgroundColor="#fbfebc";
										tktIssuDate[i].style.color="#000000";
										tktIssuDate[i].focus();
										return false;
									}
									if(cnclSecFrom[i].value=='' || cnclSecFrom[i].value=='<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>') 
									{	alert('Cancellation: Sector From');
										cnclSecFrom[i].style.backgroundColor="#fbfebc";
										cnclSecFrom[i].style.color="#000000";
										cnclSecFrom[i].focus();
										return false;
									}
									if(cnclSecTo[i].value=='' || cnclSecTo[i].value=='<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>') 
									{	alert('Cancellation: Sector To');
										cnclSecTo[i].style.backgroundColor="#fbfebc";
										cnclSecTo[i].style.color="#000000";
										cnclSecTo[i].focus();
										return false;
									}
									if(tktCnclDate[i].value=='' || tktCnclDate[i].value=='DD/MM/YYYY') 
									{	alert('Cancellation: Ticket Cancel Date');
										tktCnclDate[i].style.backgroundColor="#fbfebc";
										tktCnclDate[i].style.color="#000000";
										tktCnclDate[i].focus();
										return false;
									}
									if(cnclCharges[i].value=='') 
									{	alert('Cancellation: Cancellation Charges');
										cnclCharges[i].style.backgroundColor="#fbfebc";
										cnclCharges[i].style.color="#000000";
										cnclCharges[i].focus();
										return false;
									}
									if(cnclReason[i].value=='') 
									{	alert('Cancellation: Cancellation Reason');
										cnclReason[i].style.backgroundColor="#fbfebc";
										cnclReason[i].style.color="#000000";
										cnclReason[i].focus();
										return false;
									}
								}
								if(cnclCharges[i].value !='') 
								{
									if(tktIssuDate[i].value=='' || tktIssuDate[i].value=='DD/MM/YYYY') 
									{	alert('Cancellation: Ticket Issue Date');
										tktIssuDate[i].style.backgroundColor="#fbfebc";
										tktIssuDate[i].style.color="#000000";
										tktIssuDate[i].focus();
										return false;
									}
									if(cnclSecFrom[i].value=='' || cnclSecFrom[i].value=='<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>') 
									{	alert('Cancellation: Sector From');
										cnclSecFrom[i].style.backgroundColor="#fbfebc";
										cnclSecFrom[i].style.color="#000000";
										cnclSecFrom[i].focus();
										return false;
									}
									if(cnclSecTo[i].value=='' || cnclSecTo[i].value=='<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>') 
									{	alert('Cancellation: Sector To');
										cnclSecTo[i].style.backgroundColor="#fbfebc";
										cnclSecTo[i].style.color="#000000";
										cnclSecTo[i].focus();
										return false;
									}
									if(tktCnclDate[i].value=='' || tktCnclDate[i].value=='DD/MM/YYYY') 
									{	alert('Cancellation: Ticket Cancel Date');
										tktCnclDate[i].style.backgroundColor="#fbfebc";
										tktCnclDate[i].style.color="#000000";
										tktCnclDate[i].focus();
										return false;
									}
									if(pnrNo[i].value=='') 
									{	alert('Cancellation: PNR No.');
										pnrNo[i].style.backgroundColor="#fbfebc";
										pnrNo[i].style.color="#000000";
										pnrNo[i].focus();
										return false;
									}
									if(tktNo[i].value=='') 
									{	alert('Cancellation: Ticket No.');
										tktNo[i].style.backgroundColor="#fbfebc";
										tktNo[i].style.color="#000000";
										tktNo[i].focus();
										return false;
									}
									if(cnclReason[i].value=='') 
									{	alert('Cancellation Reason');
										cnclReason[i].style.backgroundColor="#fbfebc";
										cnclReason[i].style.color="#000000";
										cnclReason[i].focus();
										return false;
									}
								}
								if(cnclReason[i].value !='') 
								{
									if(tktIssuDate[i].value=='' || tktIssuDate[i].value=='DD/MM/YYYY') 
									{	alert('Cancellation: Ticket Issue Date');
										tktIssuDate[i].style.backgroundColor="#fbfebc";
										tktIssuDate[i].style.color="#000000";
										tktIssuDate[i].focus();
										return false;
									}
									if(cnclSecFrom[i].value=='' || cnclSecFrom[i].value=='<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>') 
									{	alert('Cancellation: Sector From');
										cnclSecFrom[i].style.backgroundColor="#fbfebc";
										cnclSecFrom[i].style.color="#000000";
										cnclSecFrom[i].focus();
										return false;
									}
									if(cnclSecTo[i].value=='' || cnclSecTo[i].value=='<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>') 
									{	alert('Cancellation: Sector To');
										cnclSecTo[i].style.backgroundColor="#fbfebc";
										cnclSecTo[i].style.color="#000000";
										cnclSecTo[i].focus();
										return false;
									}
									if(tktCnclDate[i].value=='' || tktCnclDate[i].value=='DD/MM/YYYY') 
									{	alert('Cancellation: Ticket Cancel Date');
										tktCnclDate[i].style.backgroundColor="#fbfebc";
										tktCnclDate[i].style.color="#000000";
										tktCnclDate[i].focus();
										return false;
									}
									if(pnrNo[i].value=='') 
									{	alert('Cancellation: PNR No.');
										pnrNo[i].style.backgroundColor="#fbfebc";
										pnrNo[i].style.color="#000000";
										pnrNo[i].focus();
										return false;
									}
									if(tktNo[i].value=='') 
									{	alert('Cancellation: Ticket No.');
										tktNo[i].style.backgroundColor="#fbfebc";
										tktNo[i].style.color="#000000";
										tktNo[i].focus();
										return false;
									}
									if(cnclCharges[i].value=='') 
									{	alert('Cancellation Charges');
										cnclCharges[i].style.backgroundColor="#fbfebc";
										cnclCharges[i].style.color="#000000";
										cnclCharges[i].focus();
										return false;
									}
								}
							}	
						}
					}
				//}
			}
			return true;
		}
		
		function openWaitingProcess(spanTxt) {
			$("body").css("overflow","hidden");
			$('#pleaseWait').html(spanTxt);
			
			var height 	= $(document).height();
			var width 	= $(document).width();
			
	        var bcgDiv 	= document.getElementById("divBackground");
	        var dv = document.getElementById("waitingData");
	        
	        bcgDiv.style.height=height;
	        bcgDiv.style.width=width;
	        bcgDiv.style.display="block";
			
			if(dv != null)
			{
				var xpos = screen.width * 0.45;
				var ypos = screen.height * 0.30;   
				
				dv.style.position="absolute";       		
				dv.style.left=(xpos)+"px";
				dv.style.top=(ypos)+"px";
				document.getElementById("waitingData").style.display="";
				document.getElementById("waitingData").style.visibility="";	
			}
		}
	    
		function submitData(closeFlag,crossFlag)
		{ 	
			var siteName = $('#selectUnit option:selected').text();
			$('#hidsiteName').val(siteName);
			
			if(closeFlag == "false")
			{	$('#saveBtn').removeClass("btnCss");
				$('#saveBtn').addClass("afterSaveBtnCss");
			}
			if(closeFlag == "true")
			{	$('#closeBtn').removeClass("cnclbtnCss");
				$('#closeBtn').addClass("afterCancelBtnCss");
				$('[name=hidCloseFlag]').val("true");
			}
			
			// remove all TKT grid rows having class hideGridRow
			$('div#tktInfo div#tktInfoGrid table#tktGridTable tbody').find('tr.hideGridRow').each(function(){
				$(this).remove();
			});
			
			var foo1=document.getElementById("foo1");
			var foo2=document.getElementById("foo2");
			var foo3=document.getElementById("foo3");
			var foo4=document.getElementById("foo4");
			var foo5=document.getElementById("foo5");
			var foo6=document.getElementById("foo6");
			var foo7=document.getElementById("foo7");
			var foo8=document.getElementById("foo8");
			var foo9=document.getElementById("foo9");
			
			var insuStatusArr 	=[];
			$('[name="insuStatus"] :selected').each(function() {
				var st = $(this).text();
				insuStatusArr.push(st);
				var element=document.createElement("input");
				element.setAttribute("type", "hidden");
				element.setAttribute("name", "hidInsuStatus");
				element.setAttribute("value", st);
				foo1.appendChild(element);
			});
			//-------------------------------------------------
			var tktStus 	=[];
			$('[name="tktStatus"] :selected').each(function() {
				var st = $(this).val();
				tktStus.push(st);
				var element=document.createElement("input");
				element.setAttribute("type", "hidden");
				element.setAttribute("name", "hidtktStatus");
				element.setAttribute("value", st);
				foo2.appendChild(element);
			});
			//--------------------------------------------------
			var sttArr 	=[];
			$('[name="stayType"] :selected').each(function() {
				var st = $(this).text();
				sttArr.push(st);
				var element=document.createElement("input");
				element.setAttribute("type", "hidden");
				element.setAttribute("name", "hidstayType");
				element.setAttribute("value", st);
				foo4.appendChild(element);
			});
			//--------------------------------------------------
			
			var itArr	=[];
			$('[name="insuType"] :selected').each(function() {
				var st = $(this).text();
				itArr.push(st);	
				var element=document.createElement("input");
				element.setAttribute("type", "hidden");
				element.setAttribute("name", "hidinsuType");
				element.setAttribute("value", st);
				foo5.appendChild(element);
			});
			//---------------------------------------------------
			var vtArr 	=[];
			$('[name="visaType"] :selected').each(function() {
				var st = $(this).text();
				vtArr.push(st);	    
				var element=document.createElement("input");
				element.setAttribute("type", "hidden");
				element.setAttribute("name", "hidvisaType");
				element.setAttribute("value", st);
				foo6.appendChild(element);
			});
			//---------------------------------------------------
			var etArr	=[];
			$('[name="entryType"] :selected').each(function() {
				var st = $(this).text();
				etArr.push(st);	  
				var element=document.createElement("input");
				element.setAttribute("type", "hidden");
				element.setAttribute("name", "hidentryType");
				element.setAttribute("value", st);
				foo7.appendChild(element);
			});
			//---------------------------------------------------
			var clsArr	=[];
			$('[name="classType"] :selected').each(function() {
				var st = $(this).text();
				clsArr.push(st);	 
				var element=document.createElement("input");
				element.setAttribute("type", "hidden");
				element.setAttribute("name", "hidclassType");
				element.setAttribute("value", st);
				foo8.appendChild(element);
			});
			//---------------------------------------------------
			var submitUserIdsArr 	= [];						// array containing Y/N according to check/uncheck
			var grpUserIds 			= '';						// $[POST] selected user id's string
			var tktChkFlag 			= false;					// flag for selecting at least 1 grp User			
			
			$('[name=usrChkBox]').attr('disabled',false);
			//Generate UserIds Array for POST (all which are checked)
			$('table#grpTravelersInfoTable tbody tr.grpTravelersInfoRow').find('#usrChkBox').each(function() {
				
				var element=document.createElement("input");
				element.setAttribute("type", "hidden");
				element.setAttribute("name", "tktFlags");
				
				//var thisElmt = $(this).find('input.tktFlagChkBox');
				if($(this).is(":checked")) {
					
					element.setAttribute("value", "Y");
					if(!$(this).is(":disabled")) {
						tktChkFlag = true;	
					}
					if(grpUserIds=='') {
						grpUserIds = grpUserIds + $(this).next('.checkedUserCls').val() ;
					} else {
						grpUserIds = grpUserIds +','+ $(this).next('.checkedUserCls').val() ;
					}
				} else {
					var tmpUsrId = $(this).next('.checkedUserCls').val();
					if ($.inArray(tmpUsrId,fixedGrpUsersArr) > -1) {
						element.setAttribute("value", "Y");
					} else {
						element.setAttribute("value", "N");
					}
		   		}
				foo3.appendChild(element);
				submitUserIdsArr.push(element.value);
			});
			
			// Set userIds for each TKT Grid table row
			$('table#tktGridTable tbody tr.tktGridRow').each(function() {
				
				var element = $(this).find('#tktUsers');
				if(element.hasClass('tktUserIdsCls')) {
					var textBoxVal = element.val();
					if(textBoxVal == "") {
						element.val(grpUserIds);
					}
					else if (isNaN(textBoxVal)) {
						element.val(element.next('#hidGrpTktUserIds').val());
					}
				}
			});
			// Set userIds for each Edit TKT table row
			$('table#ticketInfoTable tbody tr.ticketDetailsRow').each(function() {
				
				var element = $(this).find('#tktUsers');
				if(element.hasClass('tktUserIdsCls')) {
					var textBoxVal = element.val();
					if(textBoxVal == "") {
						element.val(grpUserIds);
					}
				}
			});	
			
			if(crossFlag==0)
			{
				$('[name=frm]').find('[placeholder]').each(function() {
					var input = $(this);
					if (input.val() == input.attr('placeholder')) {
						input.val('');
					}
				});
				
				var sNo = <%=iSno%>;
				for(var i=0;i<sNo;i++) {
					$('[name=chkbox'+i+']').attr('disabled',false);
				}
				
				$('[name=visaStatus],[name=selectUnit],[name=travelType]').attr('disabled',false);
				
				var fields = $("[name=frm] :input" ).not( "button" );
				fields.each(function(index, element) {
				    var isDisabled = $(element).is(':disabled');
				    if (isDisabled) {
				        $(element).prop('disabled', false);
				    }
				});
				
				document.frm.action="Group_PersonnelBookingServlet";
				openWaitingProcess('Going backwards...');
				frm.submit();
				//window.opener.location.reload();
				close();
			}
			else if(crossFlag==1)
			{
				var flag	= false;
				flag 		= validateFields();
								
				if(flag) 
				{	
					// if no grp users are selected for TKT block, then message will be displayed
					var tktInfoFlag = $('#hidTicketDataFlag').val();
					var subRole		= "<%=subRole%>";
					if(!tktChkFlag && (tktInfoFlag == "true") && (subRole.indexOf("TC_TICK")>=0 || subRole.indexOf("TC_ADMI")>=0)) {
						
						grpUserIds = [];		// empty the selected grp user's Array if validation fails.
						resetGrpTrvlrChkBoxesOnValidationFail(submitUserIdsArr);
						submitUserIdsArr = [];
						foo3.innerHTML = '';
						
						alert('Please select atleast one group traveller to save the information.');
						$('#saveBtn').removeClass("afterSaveBtnCss");
						$('#saveBtn').addClass("btnCss");
						return false;
					}
					
					$('[name=frm]').find('[placeholder]').each(function() {
						var input = $(this);
						if (input.val() == input.attr('placeholder')) {
							input.val('');
						}
					});
				
					var sNo = <%=iSno%>;
					for(var i=0;i<sNo;i++) {
						$('[name=chkbox'+i+']').attr('disabled',false);
					}
					
					$('[name=visaStatus],[name=selectUnit],[name=travelType]').attr('disabled',false);
										
					var fields = $("[name=frm] :input" ).not( "button" );
					fields.each(function(index, element) {
					    var isDisabled = $(element).is(':disabled');
					    if (isDisabled) {
					        $(element).prop('disabled', false);
					    } else {
					    }
					});
					
					document.frm.action="Group_PersonnelBookingServlet";
					$(window).scrollTop(0);
					openWaitingProcess('Please wait, while<br/>Data is saving...');
					frm.submit();
					//window.opener.location.reload();
					close();
				}
				else if(!flag)
				{	grpUserIds = [];								// empty the selected grp user's Array if validation fails.
					resetGrpTrvlrChkBoxesOnValidationFail(submitUserIdsArr);
					submitUserIdsArr = [];
					foo3.innerHTML = '';
					
					$('#saveBtn').removeClass("afterSaveBtnCss");
					$('#saveBtn').addClass("btnCss");
				}
				
			}
		}
		
		function resetPlaceHolder(){
		if ($.browser.msie	&& $.browser.version <= 9) {
			$('[placeholder]').focus(function() {
				var input = $(this);
				if (input.val() == input.attr('placeholder')) {
					input.val('');
					input.css('color','#000000');
				}
			});
			$('[placeholder]').blur(function() {
				var input = $(this);
				if (input.val() == '' || input.val() == input.attr('placeholder')) {
					input.css('color','#7a7a7a');
					input.val(input.attr('placeholder'));
				}
			}).blur();
			$('[placeholder]').parents('form').submit(function() {
				$(this).find('[placeholder]').each(function() {
					var input = $(this);
					if (input.val() == input.attr('placeholder')) {
						input.val('');
					}
				});
			});
		}
		}
		
		function test1(obj, length, str) {
			//obj.style.backgroundColor="#ffffff";
			//obj.style.color="#000000";
			if(str=='n.') {
				upToTwoDecimal(obj);
			}
			charactercheck(obj,str);
			limitlength(obj, length);
			spaceChecking(obj);
		}
		
		//initialize city names from database 
		function initializeCityName(elId) {
			var timer;
			var typingTimer;              
			var doneTypingInterval = 50; 
			//var nameType = "city";
			$(elId).keyup(function() { 
				if (timer) { 
					timer.abort();
				} 
				clearTimeout(typingTimer);
				if ($(elId).val) {
					typingTimer = setTimeout(function() {
						timer = doneTypingAirportName(elId);	
					}, doneTypingInterval);
				}
			});	   	
		}
		function doneTypingAirportName(elId) {
	   	   	$(elId).autocomplete({
	   	   		delay: 500,
				source : function(request, response) {
	            	airPortName = "";            	
		            $.ajax({
		            	 type: "get",
						 url: "AutoCompleteServlet",
						 data: { term: $(elId).val(), airPortName: $(elId).val(), tempFlag:  "airMode", field: "tempFlag"},
		                 dataType: "json",
		                 success : function(data) {response(data);}
		           	});
		    	}
			});
	   	}
		
		//initialize country names from database 
		function initializeCountryName(elId) {
			var timer;
			var typingTimer;              
			var doneTypingInterval = 50; 
			var nameType = "country";
			$(elId).keyup(function() { 
				if (timer) { 
					timer.abort();
				} 
				clearTimeout(typingTimer);
				if ($(elId).val) {
					typingTimer = setTimeout(function() {
						timer = doneTyping(elId,nameType);	
					}, doneTypingInterval);
				}
			});	   	
		}
		
		function doneTyping(elId,nameType) {
			$.widget( "custom.catcomplete", $.ui.autocomplete, {
				_resizeMenu: function() {
					this.menu.element.outerWidth( 200 );
				},
				_renderMenu: function( ul, items ) {
					$.each( items, function( index, item ) {
						item.label = item.label.replace(new RegExp("(?![^&;]+;)(?!<[^<>]*)(" + $.ui.autocomplete.escapeRegex($(elId).val()) + ")(?![^<>]*>)(?![^&;]+;)", "gi"), "<strong>$1</strong>");
						$("<li></li>")
			            .data("item.autocomplete", item)
			            .append("<a>" + item.label + "</a>")
			            .appendTo(ul);
					});
				}
			});
			$(elId).catcomplete({
				minLength: 3,
				delay: 500,
				source : function(request, response) {
					airPortName = "";            	
					$.ajax({
						type: "get",
						url: "AutoCompleteNames",
						data: { term: $(elId).val(), type:nameType},
						dataType: "json",
						success : function(data) {response(data);}
					});
				}
			});
		}
		
	   	function calcTotalFare(obj) {
	   		var objRow = $(obj).parents("table#ticketInfoTable tbody tr.ticketDetailsRow");
	   		var totalFare = '0';
	   		var bscFare = $(objRow).find("#bscFare");
	   		var taxes = $(objRow).find("#taxes");
	   		var ttlFare = $(objRow).find("#ttlFare");
	   		
	   		if($(bscFare).val()=="") {
	   			$(bscFare).val("0");
	   		}
	   		
	   		if($(taxes).val()=="") {	
	   			$(taxes).val("0");
	   		} 

			totalFare = (parseFloat($(bscFare).val()) + parseFloat($(taxes).val())).toFixed(0) ;
			$(ttlFare).val(totalFare);
		}
	   	
	   	function initializeFutureDate(elId) {
	   		$(elId).datepick({
	   			minDate: new Date(),	
	   			dateFormat: 'dd/mm/yyyy',
	   			changeMonth: true,
	   			changeYear: true,
	   			yearRange: "-100:+30", // magic!
	   			onSelect: function(dateText, inst) { $(this).css('color', '#000000'); }
	   		}).click(function () { $(elId).focus(); });	
	   	}
	   	function initializePastDate(elId) {
	   		$(elId).datepick({
	   			maxDate: new Date(),	
	   			dateFormat: 'dd/mm/yyyy',
	   			changeMonth: true,
	   			changeYear: true,
	   			yearRange: "-100:+30", // magic!
	   			onSelect: function(dateText, inst) { $(this).css('color', '#000000'); }
	   		}).click(function () { $(elId).focus(); });	
	   	}
	   	
	   	function initializeDate(elId) {
			$(elId).datepick({
			    dateFormat: 'dd/mm/yyyy',
			    changeMonth: true,
			    changeYear: true,
			    yearRange: "-100:+30", // magic!
			    onSelect: function(dateText, inst) { $(this).css('color', '#000000'); }
			}).click(function () { $(elId).focus(); });	
		}
	   	
	   	/* function initializeDocRecDate(elId) {
	   		var visaStatusTxt = $(elId).parents("table#visaInfoTable tbody tr.visaDetailsRow td table tbody").find("tr.visaDetailsRow1").find('select#visaStatus option:selected').text();

	   		if(visaStatusTxt == 'VISA Received') {
	   			$(this).parents("table#visaInfoTable tbody tr.visaDetailsRow td table tbody").find("tr.visaDetailsRow2 td.docRecDateTd #docRecDate").css('background-color','#e9e9e9');
				$(this).parents("table#visaInfoTable tbody tr.visaDetailsRow td table tbody").find("tr.visaDetailsRow2 td.docRecDateTd #docRecDate").css('color','#858585');
				$(this).parents("table#visaInfoTable tbody tr.visaDetailsRow td table tbody").find("tr.visaDetailsRow2 td.docRecDateTd #docRecDate").attr('disabled', true);
				$(elId).datepick("destroy");
	   		} else {
	   			
	   			$(this).parents("table#visaInfoTable tbody tr.visaDetailsRow td table tbody").find("tr.visaDetailsRow2 td.docRecDateTd #docRecDate").css('background-color','#ffffff');
				$(this).parents("table#visaInfoTable tbody tr.visaDetailsRow td table tbody").find("tr.visaDetailsRow2 td.docRecDateTd #docRecDate").css('color','#5b5b5b');
				$(this).parents("table#visaInfoTable tbody tr.visaDetailsRow td table tbody").find("tr.visaDetailsRow2 td.docRecDateTd #docRecDate").attr('disabled', false);
				$(elId).datepick({
				    dateFormat: 'dd/mm/yyyy',
				    changeMonth: true,
				    changeYear: true,
				    yearRange: "-100:+30", // magic!
				    onSelect: function(dateText, inst) { $(this).css('color', '#000000'); }
				}).click(function () { $(elId).focus(); });	   			
	   		}
		} */
	   	
	   	function validateDates(elId, datePlcHldr, className) {
	   		var elIdIndex = $(elId).closest('body').find('.'+className).index(elId);	
	   		var setDate = new Date();
	   		var dt = 0;
	   		var flag = false; 		
	   		$('.'+className).each(function(index) {			
	   			var dateVal = $(this).val();	
	   			var dateValParts = dateVal.split("/");
	   			if((parseInt(index) < parseInt(elIdIndex)) && dateVal != "" && dateVal != datePlcHldr) {	
	   				flag = true;
	   				dt = new Date(Number(dateValParts[2]), Number(dateValParts[1]) - 1, Number(dateValParts[0]));
	   			}
	   		}); 	
	   		if(flag) {
	   			setDate = new Date();
	   			setDate = dt;	
	   		} 	
	   		$(elId).datepick({			
	   			dateFormat: 'dd/mm/yyyy',
	   			minDate: new Date(setDate),		
	   			onSelect: function(dateText, inst) { $(this).css('color', '#000000'); },
	   			onClose: function(dateText, inst) {
	   				var elIdVal = $(elId).val();
	   				var elIdValParts = elIdVal.split("/");
	   				var elIdDate = new Date(Number(elIdValParts[2]), Number(elIdValParts[1]) - 1, Number(elIdValParts[0]));		    			    	
	   				$('.'+className).each(function(thisIndex) {	
	   					var thisVal = $(this).val();
	   					var thisValParts = thisVal.split("/");
	   					var thisDate = new Date(Number(thisValParts[2]), Number(thisValParts[1]) - 1, Number(thisValParts[0]));		    		
	   					if(parseInt(thisIndex) > parseInt(elIdIndex) && thisDate < elIdDate) {
	   						$(this).val(elIdVal);
	   					}
	   				});			    	
	   				$(elId).datepick("destroy");
	   			}
	   		}).click(function () { $(elId).focus(); });		
	   	}
	   	
	   	function openDomInAddMode() {
	   		$('[name=ppNo],[name=ppExpDt]').attr('onfocus','blur();');
	   		//$('[name=ppNo],[name=ppExpDt]').addClass('input-disabled');
	   		
	   		$('#cancellation').css('display','none');
	   		
	   		$("label#tktReqNo").addClass("active");
			$("label#VisaReqNo").addClass("active");
			$("label#InsuReqNo").addClass("active");
			$("label#AccReqNo").addClass("active"); 
			
			$("#VisaReq").hide();
			$("#insuranceReq").hide();
			visaChkYFlag = false;
			insChkYFlag	= false;
		}
		
		function openDomInEditMode() {
			var traveltype				= "<%=trvlType%>";
			var subRole					= "<%=subRole%>";
			var tktReqDetailExists		= <%=tktReqDetailExists%>;
			var visaReqDetailExists		= <%=visaReqDetailExists%>;
			var insurReqDetailExists	= <%=insurReqDetailExists%>;
			var accomoReqDetailExists	= <%=accomoReqDetailExists%>;
			var cnclRefundDetailExists	= <%=cnclRefundDetailExists%>;
			var showCnclBlockFlag		= <%=showCnclBlockFlag%>;
			
			$('[name=paxName],[name=ppNo],[name=ppExpDt]').attr('readonly',true);
			$('[name=paxName],[name=ppNo],[name=ppExpDt]').attr('onfocus','blur();');
			
			$('[name=selectUnit],[name=travelType]').attr('disabled',true);
			$('[name=selectUnit],[name=paxName],[name=travelType],[name=ppNo],[name=ppExpDt]').addClass('input-disabled');
			
			if(subRole == null || subRole == "" || (subRole.indexOf("TC_VISA")== -1 && subRole.indexOf("TC_INSU")== -1 && subRole.indexOf("TC_ACCO")== -1 && subRole.indexOf("TC_TICK")== -1 && subRole.indexOf("TC_ADMI")== -1))
			{	$('[name=frm]').html("<div style='text-align:center;color:red;'><h1><br/><br/><br/><br/><br/><br/><br/><br/><span><b>You are not Authorized to see this information.</b></span></h1></div>");
			}
			else
			{	
				if(subRole.indexOf("TC_TICK")>=0 || subRole.indexOf("TC_ADMI")>=0) {
					
					if (tktReqDetailExists==false) {	
						$("label#tktReqYes").removeClass("active");
						$("label#tktReqNo").addClass("active");				
						$("input:radio#tktReq_N").attr('checked', true);
						$("input:radio#tktReq_Y").attr('checked', false);
						$("div#tktInfo").removeClass("show");
						$("div#tktInfo").addClass("hide");
						tktChkYFlag	= false;
					
					} else if(tktReqDetailExists==true) {	
						$("label#tktReqNo").removeClass("active");
						$("label#tktReqYes").addClass("active");				
						$("input:radio#tktReq_Y").attr('checked', true);
						$("input:radio#tktReq_N").attr('checked', false);
						$("div#tktInfo").removeClass("hide");
						$("div#tktInfo").addClass("show");
						tktChkYFlag	= true;
					}
					
					var hideEditTktRowFlag = true;
					$('table#grpTravelersInfoTable tbody tr.grpTravelersInfoRow').find('#usrChkBox').each(function() {
				   		if(!$(this).is(':disabled')) {
				   			hideEditTktRowFlag = false;
				   		}
					});
					// If all grp travellers are disabled then hide Edit Tkt Table, remove Edit TKT buttons from TKT Grid & check all grp Travellers
					if(hideEditTktRowFlag){
						$('table#grpTravelersInfoTable tbody tr.grpTravelersInfoRow').find('#usrChkBox').each(function() {
					   		this.checked = true;
						});
						$('table#ticketInfoTable').hide();
						/* $('#editGridHeader').remove();
						$('table#tktGridTable tbody tr.tktGridRow').find('td#editGridRow').each(function() {
							$(this).remove();
						}); */
					}
					
					if (tktReqDetailExists==false) {	
						// disable all grp. travellers checkboxes
						$(':checkbox.tktFlagChkBox').each(function() {
					   		this.disabled 	= true;
						});
					}
				}
				else if(subRole.indexOf("TC_TICK")== -1 && subRole.indexOf("TC_ADMI") == -1)
				{	
					// disable all grp. travellers checkboxes
					$(':checkbox.tktFlagChkBox').each(function() {
				   		this.disabled 	= true;
					});
					
					if (tktReqDetailExists==false)
					{	$("#ticketReq").hide();
						tktChkYFlag	= false;
					}
					else if(tktReqDetailExists==true)
					{	$("label#tktReqNo").removeClass("active");
						$("label#tktReqYes").addClass("active");				
						$("input:radio#tktReq_Y").attr('checked', true);
						$("input:radio#tktReq_N").attr('checked', false);
						$("div#tktInfo").removeClass("hide");
						$("div#tktInfo").addClass("show");
						$("#addTktInfo").hide();
						$("div#tktYN").remove();
						tktChkYFlag	= true;
						
						$('[name=deptrDate],[name=arrDate]').attr('onFocus',"");
						
						$('[name=secFrom],[name=secTo],[name=deptrDate]').attr('readonly',true);
						$('[name=arrDate],[name=airlineType],[name=pnr],[name=ticketNo]').attr('readonly',true);
						/* $('[name=bscFare],[name=taxes]').attr('readonly',true); */
						$('[name=ttlFare],[name=tktRemarks]').attr('readonly',true);
						
						$('[name=secFrom],[name=secTo],[name=deptrDate],[name=deptrTime]').attr('onfocus','blur();');
						$('[name=arrDate],[name=arrTime],[name=airlineType],[name=pnr],[name=ticketNo]').attr('onfocus','blur();');
						/* $('[name=bscFare],[name=taxes]').attr('onfocus','blur();'); */
						$('[name=ttlFare],[name=tktRemarks]').attr('onfocus','blur();');
						
						$('[name=classType],[name=tktStatus],[name=deptrTime],[name=arrTime]').attr('disabled',true);
						
						$('[name=secFrom],[name=secTo],[name=classType],[name=deptrDate],[name=deptrTime]').addClass('input-disabled');
						$('[name=arrDate],[name=arrTime],[name=airlineType],[name=pnr],[name=ticketNo]').addClass('input-disabled');
						/* $('[name=bscFare],[name=taxes]').addClass('input-disabled'); */
						$('[name=ttlFare],[name=tktStatus],[name=tktRemarks]').addClass('input-disabled');
					}
				}	
	
				if(subRole.indexOf("TC_VISA")>=0 || subRole.indexOf("TC_ADMI")>=0)
				{	if (visaReqDetailExists==false)
					{	$("label#VisaReqYes").removeClass("active");
						$("label#VisaReqNo").addClass("active");				
						$("input:radio#VisaReq_N").attr('checked', true);
						$("input:radio#VisaReq_Y").attr('checked', false);
						$("div#visaInfo").removeClass("show");
						$("div#visaInfo").addClass("hide");
						visaChkYFlag = false;
					}
					else if (visaReqDetailExists==true)
					{	$("label#VisaReqNo").removeClass("active");
						$("label#VisaReqYes").addClass("active");				
						$("input:radio#VisaReq_Y").attr('checked', true);
						$("input:radio#VisaReq_N").attr('checked', false);
						$("div#visaInfo").removeClass("hide");
						$("div#visaInfo").addClass("show");
						visaChkYFlag = true;
					}
				}
				else if(subRole.indexOf("TC_VISA")== -1 && subRole.indexOf("TC_ADMI") == -1)
				{	if (visaReqDetailExists==false)
					{	$("#VisaReq").hide();
						visaChkYFlag = false;
					}
					else if (visaReqDetailExists==true)
					{	$("label#VisaReqNo").removeClass("active");
						$("label#VisaReqYes").addClass("active");				
						$("input:radio#VisaReq_Y").attr('checked', true);
						$("input:radio#VisaReq_N").attr('checked', false);
						$("div#visaInfo").removeClass("hide");
						$("div#visaInfo").addClass("show");
						$("#addVisaInfo").remove();
						$("div#visaYN").remove();
						
						visaChkYFlag = true;
						
						$('[name=ppExpDate],[name=visaValFrom],[name=visaValTo]').attr('onFocus',"");
						/* $('[name=docRecDate],[name=visaIssuDate]').attr('onFocus',""); */
						
						/* $('[name=docRecDate],[name=visaIssuDate]').attr('readonly',true); */
						$('[name=pprtNo],[name=ppExpDate],[name=country],[name=visaRem]').attr('readonly',true);
						$('[name=visaValFrom],[name=visaValTo],[name=durOfStay],[name=visaCharges]').attr('readonly',true);
						
						/* $('[name=docRecDate],[name=visaIssuDate]').attr('onfocus','blur();'); */
						$('[name=pprtNo],[name=ppExpDate],[name=country],[name=visaRem]').attr('onfocus','blur();');
						$('[name=visaValFrom],[name=visaValTo],[name=durOfStay],[name=visaCharges]').attr('onfocus','blur();');
						
						$('[name=visaStatus],[name=visaType],[name=entryType]').attr('disabled',true);
						
						/* $('[name=docRecDate],[name=visaIssuDate]').addClass('input-disabled'); */
						$('[name=visaStatus],[name=pprtNo],[name=ppExpDate],[name=visaType],[name=country]').addClass('input-disabled');
						$('[name=visaValFrom],[name=visaValTo],[name=durOfStay],[name=entryType]').addClass('input-disabled');
						$('[name=visaCharges],[name=visaRem]').addClass('input-disabled');
					}	
				}
	
				if(subRole.indexOf("TC_INSU")>=0 || subRole.indexOf("TC_ADMI")>=0)
				{	if (insurReqDetailExists==false)
					{	$("label#InsuReqYes").removeClass("active");
						$("label#InsuReqNo").addClass("active");				
						$("input:radio#InsuReq_N").attr('checked', true);
						$("input:radio#InsuReq_Y").attr('checked', false);
						$("div#insuInfo").removeClass("show");
						$("div#insuInfo").addClass("hide");
						insChkYFlag	= false;
					}
					else if (insurReqDetailExists==true)
					{	$("label#InsuReqNo").removeClass("active");
						$("label#InsuReqYes").addClass("active");				
						$("input:radio#InsuReq_Y").attr('checked', true);
						$("input:radio#InsuReq_N").attr('checked', false);
						$("div#insuInfo").removeClass("hide");
						$("div#insuInfo").addClass("show");
						insChkYFlag	= true;
					}
				}
				else if(subRole.indexOf("TC_INSU")== -1 && subRole.indexOf("TC_ADMI") == -1)
				{	if (insurReqDetailExists==false)
					{	$("#insuranceReq").hide();
						insChkYFlag	= false;
					}
					else if (insurReqDetailExists==true)
					{	$("label#InsuReqNo").removeClass("active");
						$("label#InsuReqYes").addClass("active");				
						$("input:radio#InsuReq_Y").attr('checked', true);
						$("input:radio#InsuReq_N").attr('checked', false);
						$("div#insuInfo").removeClass("hide");
						$("div#insuInfo").addClass("show");
						$("div#insuYN").remove();
						insChkYFlag	= true;
						
						$('[name=insuStDate],[name=insuEndDate]').attr('onFocus',"");
						
						$('[name=insuPolNo],[name=insuStDate],[name=insuEndDate],[name=nominee]').attr('readonly',true);
						$('[name=relation],[name=insuCharges],[name=insuRemarks]').attr('readonly',true);
						
						$('[name=insuPolNo],[name=insuStDate],[name=insuEndDate],[name=nominee]').attr('onfocus','blur();');
						$('[name=relation],[name=insuCharges],[name=insuRemarks]').attr('onfocus','blur();');
						
						$('[name=insuStatus],[name=insuType]').attr('disabled',true);
						
						$('[name=insuStatus],[name=insuPolNo],[name=insuStDate],[name=insuEndDate],[name=insuType],[name=nominee]').addClass('input-disabled');
						$('[name=relation],[name=insuCharges],[name=insuRemarks]').addClass('input-disabled');
					}
				}
				
				if(subRole.indexOf("TC_ACCO")>=0 || subRole.indexOf("TC_ADMI")>=0)
				{	if (accomoReqDetailExists==false)
					{	$("label#AccReqYes").removeClass("active");
						$("label#AccReqNo").addClass("active");				
						$("input:radio#AccReq_N").attr('checked', true);
						$("input:radio#AccReq_Y").attr('checked', false);
						$("div#accInfo").removeClass("show");
						$("div#accInfo").addClass("hide");
						accChkYFlag	= false;
					}
					else if (accomoReqDetailExists==true)
					{	$("label#AccReqNo").removeClass("active");
						$("label#AccReqYes").addClass("active");				
						$("input:radio#AccReq_Y").attr('checked', true);
						$("input:radio#AccReq_N").attr('checked', false);
						$("div#accInfo").removeClass("hide");
						$("div#accInfo").addClass("show"); 
						accChkYFlag	= true;
					}	
				}
				else if(subRole.indexOf("TC_ACCO")== -1 && subRole.indexOf("TC_ADMI") == -1)
				{	if (accomoReqDetailExists==false)
					{	$("#accomodationReq").hide();
						accChkYFlag	= false;
					}
					else if (accomoReqDetailExists==true)
					{	$("label#AccReqNo").removeClass("active");
						$("label#AccReqYes").addClass("active");				
						$("input:radio#AccReq_Y").attr('checked', true);
						$("input:radio#AccReq_N").attr('checked', false);
						$("div#accInfo").removeClass("hide");
						$("div#accInfo").addClass("show"); 
						$("#addAccInfo").remove();
						$("div#accYN").remove();
						accChkYFlag	= true;
						
						$('[name=chkInDate],[name=chkOutDate]').attr('onFocus',"");
						
						$('[name=location],[name=chkInDate],[name=chkOutDate],[name=stayCharges],[name=stayRemarks]').attr('readonly',true);
						
						$('[name=location],[name=chkInDate],[name=chkOutDate],[name=stayCharges],[name=stayRemarks]').attr('onfocus','blur();');
						
						$('[name=stayType]').attr('disabled',true);
						
						$("table#accInfoTable tbody tr.accDetailsRow").each(function() {
							$(this).find("td table tr.accDetailsRow1").find("td#locTd").find("#locationDD").attr('disabled',true);
							$(this).find("td table tr.accDetailsRow1").find("td#locTd").find("#locationDD").addClass('input-disabled');
						});		
						
						$('[name=stayType],[name=location],[name=chkInDate],[name=chkOutDate],[name=stayCharges],[name=stayRemarks]').addClass('input-disabled');
					}
				}
				
				if(subRole.indexOf("TC_TICK")>=0 || subRole.indexOf("TC_ADMI")>=0)
				{	if (cnclRefundDetailExists==false || showCnclBlockFlag==false)
					{	
						$("#cancellation").hide();
						cnclChkYFlag = false;
					}
					else if (cnclRefundDetailExists==true)
					{	$("label#CnclReqNo").removeClass("active");
						$("label#CnclReqYes").addClass("active");				
						$("input:radio#CnclReq_Y").attr('checked', true);
						$("input:radio#CnclReq_N").attr('checked', false);
						$("div#cnclInfo").removeClass("hide");
						$("div#cnclInfo").addClass("show"); 
						cnclChkYFlag = true;
						$("div#cnclYN").remove();
					}	
				}
				else if(subRole.indexOf("TC_TICK")== -1 && subRole.indexOf("TC_ADMI") == -1)
				{	if (cnclRefundDetailExists==false || showCnclBlockFlag==false)
					{	$("#cancellation").hide();
						cnclChkYFlag = false;
					}
					else if (cnclRefundDetailExists==true)
					{	$("label#CnclReqNo").removeClass("active");
						$("label#CnclReqYes").addClass("active");				
						$("input:radio#CnclReq_Y").attr('checked', true);
						$("input:radio#CnclReq_N").attr('checked', false);
						$("div#cnclInfo").removeClass("hide");
						$("div#cnclInfo").addClass("show"); 
						$("div#cnclYN").remove();
						cnclChkYFlag = true;
						
						$('[name=tktIssuDate],[name=tktCnclDate]').attr('onFocus',"");
						
						$('[name=tktIssuDate],[name=cnclSecFrom],[name=cnclSecTo],[name=tktCnclDate],[name=pnrNo]').attr('readonly',true);
						$('[name=tktNo],[name=cnclCharges],[name=cnclReason],[name=refundRemarks]').attr('readonly',true);
						
						$('[name=tktIssuDate],[name=cnclSecFrom],[name=cnclSecTo],[name=tktCnclDate],[name=pnrNo]').attr('onfocus','blur();');
						$('[name=tktNo],[name=cnclCharges],[name=cnclReason],[name=refundRemarks]').attr('onfocus','blur();');
						
						var sNo = <%=iSno%>;
						for(var i=0;i<sNo;i++) {
							$('[name=chkbox'+i+']').attr('disabled',true);
						}
						
						$('[name=tktIssuDate],[name=cnclSecFrom],[name=cnclSecTo],[name=tktCnclDate],[name=pnrNo]').addClass('input-disabled');
						$('[name=tktNo],[name=cnclCharges],[name=cnclReason],[name=refundRemarks]').addClass('input-disabled');
					}
				}
				
				if(traveltype.toUpperCase() == "D") {
					$("#VisaReq").hide();
					visaChkYFlag = false;

					$("#insuranceReq").hide();
					insChkYFlag	= false;
				}
			}
		}
		
		$(document).ready(function() {
			resetPlaceHolder();
			var travelBookId = '<%=tBookId%>';
			if(travelBookId == "0") {	
				openDomInAddMode();
			}
			if(travelBookId !=null && travelBookId != "" && travelBookId != "0") {	
				openDomInEditMode();
			}
			
			var tktNoEl;
			var flightNoEl;
			var typingTimer;          
			var doneTypingInterval = 50;
			
			$('[name=ticketNo]').live('keyup', function () {
				tktNoEl = this;
				clearTimeout(typingTimer);
				typingTimer = setTimeout(doneTypingTktNo, doneTypingInterval);
			});
			$('[name=ticketNo]').live('keydown', function () {
				tktNoEl = this;
				clearTimeout(typingTimer);
			});
			
			$('[name=tktNo]').live('keyup', function () {
				tktNoEl = this;
				clearTimeout(typingTimer);
				typingTimer = setTimeout(doneTypingTktNo, doneTypingInterval);
			});
			$('[name=tktNo]').live('keydown', function () {
				tktNoEl = this;
				clearTimeout(typingTimer);
			});
			
			function doneTypingTktNo () {
				var tktNoVal 	= tktNoEl.value;
				var tktNoValNew = '';
				
				if(tktNoVal.length>3) {
					for (var i=0;i<tktNoVal.length;i++) {
						if (i==3 & tktNoVal[3] != " ") {
							tktNoValNew = tktNoValNew +" "+tktNoVal[i];
						
						} else {
							tktNoValNew = tktNoValNew + tktNoVal[i];
						}
					}
					tktNoEl.value = tktNoValNew;
				}
				setTktTotalFareVal($(tktNoEl).parents('tr.ticketDetailsRow').find('#ttlFare'));
			}
			
			$('[name=airlineType]').live('keyup', function () {
				flightNoEl = this;
				clearTimeout(typingTimer);
				typingTimer = setTimeout(doneTypingAir, doneTypingInterval);
			});
			$('[name=airlineType]').live('keydown', function () {
				flightNoEl = this;
				clearTimeout(typingTimer);
			});
			
			function doneTypingAir () {
				var flightNoVal 	= flightNoEl.value;
				var flightNoValNew 	= '';
				
				if(flightNoVal.length>2) {
					for (var i=0;i<flightNoVal.length;i++) {
						if (i==2 & flightNoVal[2] != " ") {
							flightNoValNew = flightNoValNew +" "+flightNoVal[i];
						
						} else {
							flightNoValNew = flightNoValNew + flightNoVal[i];
						}
					}
					flightNoEl.value = flightNoValNew;
				}
			}
			
			$('[name=selectUnit]').change(function() {
				$("#paxName").val('');
				$("#dob").val('');
				$("#mobileNo").val('');
				$("#ppNo").val('');
				$("#ppExpDt").val('');
			});
			
			$('[name=travelType]').change(function() {
				var travelType = $("#travelType option:selected").val();
				
				if (travelType == 'D') {	
					$("#VisaReq").hide();
					$("#insuranceReq").hide();
					visaChkYFlag 	= false;
					insChkYFlag		= false;
					
					resetPlaceHolder();
				}
				else if (travelType == 'I') {	
					$("#VisaReq").show();
					$("#insuranceReq").show();
					visaChkYFlag	= true;
					insChkYFlag		= true;
					
					resetPlaceHolder();
				}
			});
			
			// On chkBox click set the grpuserId to it's value & add/delete that id from newGrpUsersArr 
			$(':checkbox.tktFlagChkBox').click(function() {
				var chkBoxVal = $(this).next('.checkedUserCls').val();
				$(this).val(chkBoxVal);
				
				var index = $.inArray(chkBoxVal,newGrpUsersArr);
				if($(this).is(':checked')) {
					if(index == -1) {
						newGrpUsersArr.push(chkBoxVal);
					}
				} else if(!$(this).is(':checked')) {
					if(index >-1 ) {
						newGrpUsersArr.splice(index, 1);
					}
				}
			});
			
			// If all ckeckboxes are disabled then hide TKT Y/N button
			var hideTktYNFlag = true;
			$(':checkbox.tktFlagChkBox').each(function() {
				if(!$(this).is(':disabled')) {
					hideTktYNFlag = false;
				} 
			});
			if(hideTktYNFlag) {
				$("#addTktInfo").hide();
				
				var subRole = '<%=subRole%>';
				if(subRole.indexOf("TC_TICK") == -1 && subRole.indexOf("TC_ADMI") == -1){
					$("div#tktYN").remove();
				}
			}
		});
		
		$('[name=insuStatus]').change(function() {
			var insuStatus = $("#insuStatus option:selected").val();
			if (insuStatus == 1)
			{	$('[name=insuRemarks]').css("backgroundColor", "#ffffff");
				$('[name=insuRemarks]').attr("onKeyUp", "return test1(this,200,'a');");
				$('[name=insuRemarks]').val("");
				$('[name=insuRemarks]').attr('placeholder', '');
				resetPlaceHolder();
			}
			else if (insuStatus == 2)
			{	$('[name=insuRemarks]').css("backgroundColor", "#ffffff");
				$('[name=insuRemarks]').attr("onKeyUp", "return test1(this,12,'n');");
				$('[name=insuRemarks]').val("");
				$('[name=insuRemarks]').attr('placeholder', '*Enter Policy No.');
				resetPlaceHolder();
			}
		});
		
		$(document).on('change','table#accInfoTable #stayType',function() {
			var stayType = $(this).val();
			//alert(stayType);
			if (stayType == "Hotel")
			{	$(this).parents("table#accInfoTable tbody tr.accDetailsRow td table tr.accDetailsRow1").find("td#locTd").find("#locationDD").hide();
				$(this).parents("table#accInfoTable tbody tr.accDetailsRow td table tr.accDetailsRow1").find("td#locTd").find("#locationTB").show();
				
				$(this).parents("table#accInfoTable tbody tr.accDetailsRow td table tr.accDetailsRow1").find("td#locTd").find("#locationTBHid").attr('name','locationPT');
				$(this).parents("table#accInfoTable tbody tr.accDetailsRow td table tr.accDetailsRow1").find("td#locTd").find("#locationTB").attr('name','location');
				
				$(this).parents("table#accInfoTable tbody tr.accDetailsRow td table tr.accDetailsRow1").find("td#locTd").find("#locationTB").css({"backgroundColor":"#ffffff"});
				$(this).parents("table#accInfoTable tbody tr.accDetailsRow td table tr.accDetailsRow1").find("td#locTd").find("#locationTB").attr('placeholder', 'Location');
				resetPlaceHolder();
			}
			else if (stayType == "Transit House")
			{	$(this).parents("table#accInfoTable tbody tr.accDetailsRow td table tr.accDetailsRow1").find("td#locTd").find("#locationTB").hide();
				$(this).parents("table#accInfoTable tbody tr.accDetailsRow td table tr.accDetailsRow1").find("td#locTd").find("#locationDD").show();
				
				$(this).parents("table#accInfoTable tbody tr.accDetailsRow td table tr.accDetailsRow1").find("td#locTd").find("#locationTB").attr('name','locationPT');
				$(this).parents("table#accInfoTable tbody tr.accDetailsRow td table tr.accDetailsRow1").find("td#locTd").find("#locationTBHid").attr('name','location');
				
				$(this).parents("table#accInfoTable tbody tr.accDetailsRow td table tr.accDetailsRow1").find("td#locTd").find("#locationDD").css("backgroundColor", "#ffffff");
				$(this).parents("table#accInfoTable tbody tr.accDetailsRow td table tr.accDetailsRow1").find("td#locTd").find("#locationDD").val("-1");
				$(this).parents("table#accInfoTable tbody tr.accDetailsRow td table tr.accDetailsRow1").find("td#locTd").find("#locationDD").attr('selected', 'selected');
				resetPlaceHolder();
			}
		});
		
		$(document).on('change','table#accInfoTable select#locationDD',function() {
			var locDDVal = $(this).parents("table#accInfoTable tbody tr.accDetailsRow td table tr.accDetailsRow1").find("td#locTd").find('select#locationDD option:selected').val();
			var locDDTxt = $(this).parents("table#accInfoTable tbody tr.accDetailsRow td table tr.accDetailsRow1").find("td#locTd").find('select#locationDD option:selected').text();
			
			$(this).parents("table#accInfoTable tbody tr.accDetailsRow td table tr.accDetailsRow1").find("td#locTd").find("#locationTBHid").attr('name','location');
			$(this).parents("table#accInfoTable tbody tr.accDetailsRow td table tr.accDetailsRow1").find("td#locTd").find("#locationTB").attr('name','locationPT');

			 if (locDDVal != "0") { 
				 $(this).parents("table#accInfoTable tbody tr.accDetailsRow td table tr.accDetailsRow1").find("td#locTd").find("#locationTBHid").val("");
				 $(this).parents("table#accInfoTable tbody tr.accDetailsRow td table tr.accDetailsRow1").find("td#locTd").find("#locationTBHid").val(locDDTxt);
			}
			
		});
		
		/* $(document).on('change','table#visaInfoTable tbody tr.visaDetailsRow td table tr.visaDetailsRow1 select#visaStatus',function() {
			var visaStatus = $(this).parents("table#visaInfoTable tbody tr.visaDetailsRow td table tbody tr.visaDetailsRow1 td").find('select#visaStatus option:selected').text();
			
			if (visaStatus == "VISA Received") {
				
				$(this).parents("table#visaInfoTable tbody tr.visaDetailsRow td table tbody").find("tr.visaDetailsRow2 td.docRecDateTd #docRecDate").css('background-color','#e9e9e9');
				$(this).parents("table#visaInfoTable tbody tr.visaDetailsRow td table tbody").find("tr.visaDetailsRow2 td.docRecDateTd #docRecDate").css('color','#858585');
				$(this).parents("table#visaInfoTable tbody tr.visaDetailsRow td table tbody").find("tr.visaDetailsRow2 td.docRecDateTd #docRecDate").attr('disabled', true);
				resetPlaceHolder();
			} else {	
				
				$(this).parents("table#visaInfoTable tbody tr.visaDetailsRow td table tbody").find("tr.visaDetailsRow2 td.docRecDateTd #docRecDate").css('background-color','#ffffff');
				$(this).parents("table#visaInfoTable tbody tr.visaDetailsRow td table tbody").find("tr.visaDetailsRow2 td.docRecDateTd #docRecDate").css('color','#5b5b5b');
				$(this).parents("table#visaInfoTable tbody tr.visaDetailsRow td table tbody").find("tr.visaDetailsRow2 td.docRecDateTd #docRecDate").attr('disabled', false);
				resetPlaceHolder();
			}
		}); */
		
		$('input:radio#tktReq_Y').click(function() {
			$(this).attr('checked', true);
			$("label#tktReqNo").removeClass("active");
			$("label#tktReqYes").addClass("active");				
			$("input:radio#tktReq_Y").attr('checked', true);
			$("input:radio#tktReq_N").attr('checked', false);
			$("div#tktInfo").removeClass("hide");
			$("div#tktInfo").addClass("show");
			
			var rowCountTkt = $("table#ticketInfoTable tbody tr.ticketDetailsRow").length;
			if(rowCountTkt > 0) {
				$('[name=hidTicketDataFlag]').val("true");
				tktChkYFlag	= true;
				//$('[name=hidCnclDataFlag]').val("true");
				//cnclChkYFlag = true;
			} else {
				$('[name=hidTicketDataFlag]').val("false");
				tktChkYFlag	= false;
				//$('[name=hidCnclDataFlag]').val("false");
				//cnclChkYFlag = false;
			}
			
			var rowCountCncl = $("table#cnclInfoTable tbody tr.cnclDetailsRow").length;
			if(rowCountCncl > 0) {
				$('[name=hidCnclDataFlag]').val("true");
			} else {
				$('[name=hidCnclDataFlag]').val("false");
			}
			
			resetGrpTrvlrChkBoxesOnTktReqYes();
		});
		$('input:radio#tktReq_N').click(function() {
			tktChkYFlag		= false;
			cnclChkYFlag 	= false;
			var secFrom 	= document.getElementsByName("secFrom");
			var secTo 		= document.getElementsByName("secTo");
			var deptrDate 	= document.getElementsByName("deptrDate");	
			var deptrTime   = document.getElementsByName("deptrTime");
			var arrDate 	= document.getElementsByName("arrDate");
			var arrTime 	= document.getElementsByName("arrTime");
			var airlineType = document.getElementsByName("airlineType");
			var pnr   		= document.getElementsByName("pnr");
			var ticketNo 	= document.getElementsByName("ticketNo");
			/* var bscFare 	= document.getElementsByName("bscFare");
			var taxes 		= document.getElementsByName("taxes"); */
			var ttlFare 	= document.getElementsByName("ttlFare");
			var tktDataFlag	=	false;
			var tktNoFlag	=	false;
			
			for(var i = 0, len = secFrom.length; i < len; i++) {
				if((secFrom[i].value != '' && secFrom[i].value != 'Departure City') || (secTo[i].value != '' && secTo[i].value != 'Arrival City') 
						|| (deptrDate[i].value != '' && deptrDate[i].value != 'DD/MM/YYYY') || (arrDate[i].value != '' && arrDate[i].value != 'DD/MM/YYYY') 
						|| (airlineType[i].value !='' && airlineType[i].value !='Flight No.') || (pnr[i].value !='') || (ticketNo[i].value !='') 
						/* || (bscFare[i].value !='' && bscFare[i].value !='0') || (taxes[i].value !='' && taxes[i].value !='0') */ 
						|| (ttlFare[i].value !='0'))
				{	tktDataFlag= 	true;
					break;
				}
			}
			if(tktDataFlag == true)
			{	tktNoFlag = confirm("Do you want to delete all Ticket info.?");
				if(tktNoFlag == true)
				{	$('[name=hidTicketDataFlag]').val("false");
					$('[name=hidCnclDataFlag]').val("false");
					//resetTktData();
					$(this).attr('checked', true);
					$("label#tktReqYes").removeClass("active");
					$("label#tktReqNo").addClass("active");
					$("input:radio#tktReq_Y").attr('checked', false);
					$("input:radio#tktReq_N").attr('checked', true);
					$("div#tktInfo").removeClass("show");
					$("div#tktInfo").addClass("hide");
				}
			}
			else if(tktDataFlag == false)
			{	$('[name=hidTicketDataFlag]').val("false");
				$('[name=hidCnclDataFlag]').val("false");
				$(this).attr('checked', true);
				$("label#tktReqYes").removeClass("active");
				$("label#tktReqNo").addClass("active");
				$("input:radio#tktReq_Y").attr('checked', false);
				$("input:radio#tktReq_N").attr('checked', true);
				$("div#tktInfo").removeClass("show");
				$("div#tktInfo").addClass("hide");
			}
			
			resetGrpTrvlrChkBoxesOnTktReqNo();
		});
		
		$('input:radio#VisaReq_Y').click(function() {
			$(this).attr('checked', true);
			$("label#VisaReqNo").removeClass("active");
			$("label#VisaReqYes").addClass("active");				
			$("input:radio#VisaReq_Y").attr('checked', true);
			$("input:radio#VisaReq_N").attr('checked', false);
			$("div#visaInfo").removeClass("hide");
			$("div#visaInfo").addClass("show");
			
			var rowCountVisa = $("table#visaInfoTable tbody tr.visaDetailsRow").length;
			if(rowCountVisa > 0) {
				$('[name=hidVisaDataFlag]').val("true");
				visaChkYFlag = true;
			} else {
				$('[name=hidVisaDataFlag]').val("false");
				visaChkYFlag = false;
			}
		});
		$('input:radio#VisaReq_N').click(function() {
			visaChkYFlag = false;
			var visaStatus = document.getElementsByName("visaStatus");
			var pprtNo = document.getElementsByName("pprtNo");
			var ppExpDate = document.getElementsByName("ppExpDate");
			var country = document.getElementsByName("country");
			/* var docRecDate = document.getElementsByName("docRecDate");
			var visaIssuDate = document.getElementsByName("visaIssuDate"); */
			var visaValFrom = document.getElementsByName("visaValFrom");
			var visaValTo = document.getElementsByName("visaValTo");
			var durOfStay = document.getElementsByName("durOfStay");
			var visaCharges = document.getElementsByName("visaCharges");
			var visaDataFlag= 	false;
			var visaNoFlag	=	false;
			
			for(var i = 0, len = pprtNo.length; i < len; i++) {
				if((pprtNo[i].value !='') || (ppExpDate[i].value !='' && ppExpDate[i].value !='DD/MM/YYYY') || (country[i].value !='' && country[i].value !='Country') 
						|| (visaValFrom[i].value !='' && visaValFrom[i].value !='DD/MM/YYYY') || (visaValTo[i].value !='' && visaValTo[i].value !='DD/MM/YYYY') 
						|| (durOfStay[i].value !='') || (visaCharges[i].value !=''))
				{	visaDataFlag= 	true;
					break;
				}
			}
			if(visaDataFlag == true)
			{	visaNoFlag = confirm("Do you want to delete all Visa info.?");
				if(visaNoFlag == true)
				{	$('[name=hidVisaDataFlag]').val("false");
					//resetVisaData();
					$(this).attr('checked', true);
					$("label#VisaReqYes").removeClass("active");
					$("label#VisaReqNo").addClass("active");
					$("input:radio#VisaReq_Y").attr('checked', false);
					$("input:radio#VisaReq_N").attr('checked', true);
					$("div#visaInfo").removeClass("show");
					$("div#visaInfo").addClass("hide");
				}
			}	
			else if(visaDataFlag == false)
			{	$('[name=hidVisaDataFlag]').val("false");
				$(this).attr('checked', true);
				$("label#VisaReqYes").removeClass("active");
				$("label#VisaReqNo").addClass("active");
				$("input:radio#VisaReq_Y").attr('checked', false);
				$("input:radio#VisaReq_N").attr('checked', true);
				$("div#visaInfo").removeClass("show");
				$("div#visaInfo").addClass("hide");
			}
		});
		
		$('input:radio#InsuReq_Y').click(function() {
			$('[name=hidInsuDataFlag]').val("true");
			$(this).attr('checked', true);
			$("label#InsuReqNo").removeClass("active");
			$("label#InsuReqYes").addClass("active");				
			$("input:radio#InsuReq_Y").attr('checked', true);
			$("input:radio#InsuReq_N").attr('checked', false);
			$("div#insuInfo").removeClass("hide");
			$("div#insuInfo").addClass("show");
			insChkYFlag	= true;
		});
		$('input:radio#InsuReq_N').click(function() {
			insChkYFlag	= false;
			var insuPolNo = document.getElementsByName("insuPolNo");
			var insuStDate = document.getElementsByName("insuStDate");	
			var insuEndDate = document.getElementsByName("insuEndDate");
			var nominee = document.getElementsByName("nominee");
			var relation = document.getElementsByName("relation");
			var insuCharges = document.getElementsByName("insuCharges");
			var insuRemarks = document.getElementsByName("insuRemarks");
			var insuNoFlag	=	false;
			var insuDataFlag= 	false;
			
			for(var i = 0, len = insuPolNo.length; i < len; i++) {
				if((insuPolNo[i].value !='') || (insuStDate[i].value !='' && insuStDate[i].value !='DD/MM/YYYY') || (insuEndDate[i].value !='' && insuEndDate[i].value !='DD/MM/YYYY') 
						|| (nominee[i].value !='') || (relation[i].value !='') || (insuCharges[i].value !='') || (insuRemarks[i].value !='' && insuRemarks[i].value !='*Enter Policy No.'))
				{	insuDataFlag= 	true;
					break;
				}
			}
			if(insuDataFlag == 	true)
			{	insuNoFlag = confirm("Do you want to delete all Insurance info.?");
				if(insuNoFlag == true)
				{	$('[name=hidInsuDataFlag]').val("false");
					//resetInsuData();
					$(this).attr('checked', true);
					$("label#InsuReqYes").removeClass("active");
					$("label#InsuReqNo").addClass("active");
					$("input:radio#InsuReq_Y").attr('checked', false);
					$("input:radio#InsuReq_N").attr('checked', true);
					$("div#insuInfo").removeClass("show");
					$("div#insuInfo").addClass("hide");
				}
			}
			else if(insuDataFlag == false)
			{	$('[name=hidInsuDataFlag]').val("false");
				$(this).attr('checked', true);
				$("label#InsuReqYes").removeClass("active");
				$("label#InsuReqNo").addClass("active");
				$("input:radio#InsuReq_Y").attr('checked', false);
				$("input:radio#InsuReq_N").attr('checked', true);
				$("div#insuInfo").removeClass("show");
				$("div#insuInfo").addClass("hide");
			}	
		});
		
		$('input:radio#AccReq_Y').click(function() {
			$(this).attr('checked', true);
			$("label#AccReqNo").removeClass("active");
			$("label#AccReqYes").addClass("active");				
			$("input:radio#AccReq_Y").attr('checked', true);
			$("input:radio#AccReq_N").attr('checked', false);
			$("div#accInfo").removeClass("hide");
			$("div#accInfo").addClass("show");
			
			var rowCountAccom = $("table#accInfoTable tbody tr.accDetailsRow").length;
			if(rowCountAccom > 0) {
				$('[name=hidAccDataFlag]').val("true");
				accChkYFlag	= true;
			} else {
				$('[name=hidAccDataFlag]').val("false");
				accChkYFlag	= false;
			}
		});
		$('input:radio#AccReq_N').click(function() {
			accChkYFlag		= false;
			var stayType	= document.getElementsByName("stayType");		
			var location 	= document.getElementsByName("location");	
			var chkInDate 	= document.getElementsByName("chkInDate");
			var chkOutDate 	= document.getElementsByName("chkOutDate");
			var stayCharges = document.getElementsByName("stayCharges");
			var stayRemarks = document.getElementsByName("stayRemarks");
			
			var accNoFlag	=	false;
			var accDataFlag	= 	false;
			
			for(var i = 0, len = location.length; i < len; i++) {
				if((location[i].value !='' && location[i].value !='Location' && location[i].value !='-1') || (chkInDate[i].value !='' && chkInDate[i].value !='DD/MM/YYYY') 
						|| (chkOutDate[i].value !='' && chkOutDate[i].value !='DD/MM/YYYY') || (stayCharges[i].value !=''))
				{	accDataFlag= 	true;
					break;
				}
			}
			if(accDataFlag == true)
			{	accNoFlag = confirm("Do you want to delete all Accomodation info.?");
				if(accNoFlag == true)
				{	$('[name=hidAccDataFlag]').val("false");
					//resetAccData();
					$(this).attr('checked', true);
					$("label#AccReqYes").removeClass("active");
					$("label#AccReqNo").addClass("active");
					$("input:radio#AccReq_Y").attr('checked', false);
					$("input:radio#AccReq_N").attr('checked', true);
					$("div#accInfo").removeClass("show");
					$("div#accInfo").addClass("hide");
				}
			}
			else if(accDataFlag == 	false)
			{	$('[name=hidAccDataFlag]').val("false");
				$(this).attr('checked', true);
				$("label#AccReqYes").removeClass("active");
				$("label#AccReqNo").addClass("active");
				$("input:radio#AccReq_Y").attr('checked', false);
				$("input:radio#AccReq_N").attr('checked', true);
				$("div#accInfo").removeClass("show");
				$("div#accInfo").addClass("hide");
			}	
		});
		
		$('input:radio#CnclReq_Y').click(function() {
			cnclChkYFlag = true;
			$('[name=hidCnclDataFlag]').val("true");
			$(this).attr('checked', true);
			$("label#CnclReqNo").removeClass("active");
			$("label#CnclReqYes").addClass("active");				
			$("input:radio#CnclReq_Y").attr('checked', true);
			$("input:radio#CnclReq_N").attr('checked', false);
			$("div#cnclInfo").removeClass("hide");
			$("div#cnclInfo").addClass("show");
			cnclChkYFlag = true;
		});
		$('input:radio#CnclReq_N').click(function() {
			cnclChkYFlag = false;
			var tktIssuDate = document.getElementsByName("tktIssuDate");
			var cnclSecFrom = document.getElementsByName("cnclSecFrom");	
			var cnclSecTo = document.getElementsByName("cnclSecTo");
			var tktCnclDate = document.getElementsByName("tktCnclDate");
			var pnrNo = document.getElementsByName("pnrNo");
			var tktNo = document.getElementsByName("tktNo");
			var cnclCharges = document.getElementsByName("cnclCharges");
			var cnclReason = document.getElementsByName("cnclReason");
			var cnclNoFlag	=	false;
			var cnclDataFlag=   false;
				
			for(var i = 0, len = cnclCharges.length; i < len; i++) {
				if((tktIssuDate[i].value !='' && tktIssuDate[i].value !='DD/MM/YYYY') || (cnclSecFrom[i].value !='' && cnclSecFrom[i].value != 'Departure City') 
						|| (cnclSecTo[i].value !='' && cnclSecTo[i].value != 'Arrival City') || (tktCnclDate[i].value !='' && tktCnclDate[i].value !='DD/MM/YYYY') 
						|| (pnrNo[i].value !='') || (tktNo[i].value !='') ||(cnclCharges[i].value !='') || (cnclReason[i].value !=''))
				{	cnclDataFlag= 	true;
					break;
				}
			}
			if(cnclDataFlag == true)
			{	cnclNoFlag = confirm("Do you want to delete all Cancellation info.?");
				if(cnclNoFlag == true)
				{	$('[name=hidCnclDataFlag]').val("false");
					//resetCnclData();
					$(this).attr('checked', true);
					$("label#CnclReqYes").removeClass("active");
					$("label#CnclReqNo").addClass("active");
					$("input:radio#CnclReq_Y").attr('checked', false);
					$("input:radio#CnclReq_N").attr('checked', true);
					$("div#cnclInfo").removeClass("show");
					$("div#cnclInfo").addClass("hide");
				}
			}
			else if(cnclDataFlag == false)
			{	$('[name=hidCnclDataFlag]').val("false");
				$(this).attr('checked', true);
				$("label#CnclReqYes").removeClass("active");
				$("label#CnclReqNo").addClass("active");
				$("input:radio#CnclReq_Y").attr('checked', false);
				$("input:radio#CnclReq_N").attr('checked', true);
				$("div#cnclInfo").removeClass("show");
				$("div#cnclInfo").addClass("hide");
			}
		});

		$(document).on('click','#addTktInfo',function() {
			$('[name=hidTicketDataFlag]').val("true");
			resetGrpTrvlrChkBoxesOnRowAdd();
			
			$('#tktReqDetailHead').show();
			var master = $("table#ticketInfoTable");
			var prot = master.find(".tktInfoPrototypeRow").clone();
			
			var rowCount = ($("table#ticketInfoTable tbody tr.ticketDetailsRow").length) +1;
			prot.find('#sno').attr('name', 'sno');
			prot.find('#sno').html(rowCount);
			
			prot.find('#hidTktBookId').attr('name', 'hidTktBookId');
			prot.find('#secFrom').attr('name', 'secFrom');
			prot.find('#secTo').attr('name', 'secTo');
			prot.find('#classType').attr('name', 'classType');	
			prot.find('#deptrDate').attr('name', 'deptrDate');
			prot.find('#deptrTime').attr('name', 'deptrTime');
			prot.find('#arrDate').attr('name', 'arrDate');
			prot.find('#arrTime').attr('name', 'arrTime');
			prot.find('#airlineType').attr('name', 'airlineType');
			prot.find('#pnr').attr('name', 'pnr');	
			prot.find('#ticketNo').attr('name', 'ticketNo');
			/* prot.find('#bscFare').attr('name', 'bscFare');
			prot.find('#taxes').attr('name', 'taxes'); */
			prot.find('#ttlFare').attr('name', 'ttlFare');
			prot.find('#tktStatus').attr('name', 'tktStatus');
			prot.find('#tktRemarks').attr('name', 'tktRemarks');
			prot.find('#tktUsers').attr('name', 'tktUsers');
			prot.find('#tktUsers').addClass('tktUserIdsCls');
			
			prot.find('tr.tktInfoPrototypeRow1').addClass('ticketDetailsRow1');
			prot.find('tr.ticketDetailsRow1').removeClass('tktInfoPrototypeRow1');
			
			prot.find('tr.tktInfoPrototypeRow2').addClass('ticketDetailsRow2');
			prot.find('tr.ticketDetailsRow2').removeClass('tktInfoPrototypeRow2');
			
			prot.find('tr.tktInfoPrototypeRow3').addClass('ticketDetailsRow3');
			prot.find('tr.ticketDetailsRow3').removeClass('tktInfoPrototypeRow3');
			
			prot.attr("class", "");
			prot.addClass("ticketDetailsRow");	
			$('.innerTktInfoRow').before(prot);
			
			prot.find('#deptrTime').editableSelect({ effects: 'fade' });
			prot.find('#arrTime').editableSelect({ effects: 'fade' });
			
			resetPlaceHolder();
		});
		
		$(document).on('click','#addVisaInfo',function() {
			$('[name=hidVisaDataFlag]').val("true");	
			
			var master = $("table#visaInfoTable");
			var prot = master.find(".visaInfoPrototypeRow").clone();
			var rowCount = ($("table#visaInfoTable tbody tr.visaDetailsRow").length) +1;
			
			prot.find('#sno').attr('name', 'sno');
			prot.find('#sno').html(rowCount);
			
			prot.find('#hidVisaBookId').attr('name', 'hidVisaBookId');
			prot.find('#visaStatus').attr('name', 'visaStatus');
			prot.find('#pprtNo').attr('name', 'pprtNo');
			prot.find('#ppExpDate').attr('name', 'ppExpDate');	
			prot.find('#visaType').attr('name', 'visaType');
			prot.find('#country').attr('name', 'country');
			/* prot.find('#docRecDate').attr('name', 'docRecDate');
			prot.find('#visaIssuDate').attr('name', 'visaIssuDate'); */
			prot.find('#visaValFrom').attr('name', 'visaValFrom');
			prot.find('#visaValTo').attr('name', 'visaValTo');	
			prot.find('#durOfStay').attr('name', 'durOfStay');
			prot.find('#entryType').attr('name', 'entryType');
			prot.find('#visaCharges').attr('name', 'visaCharges');
			prot.find('#visaRem').attr('name', 'visaRem');
			
			prot.find('tr.visaPrototypeRow1').addClass('visaDetailsRow1');
			prot.find('tr.visaDetailsRow1').removeClass('visaPrototypeRow1');
			
			prot.find('tr.visaPrototypeRow2').addClass('visaDetailsRow2');
			prot.find('tr.visaDetailsRow2').removeClass('visaPrototypeRow2');
			
			prot.find('tr.visaPrototypeRow3').addClass('visaDetailsRow3');
			prot.find('tr.visaDetailsRow3').removeClass('visaPrototypeRow3');
			
			prot.attr("class", "");
			prot.addClass("visaDetailsRow");	
			$('.innerVisaInfoRow').before(prot);
				
			resetPlaceHolder();
		});
		
		$(document).on('click','#addAccInfo',function() {
			$('[name=hidAccDataFlag]').val("true");
			
			$('#accReqDetailHead').show();
			var master = $("table#accInfoTable");
			var prot = master.find(".accInfoPrototypeRow").clone();
			
			var rowCount = ($("table#accInfoTable tbody tr.accDetailsRow").length) +1;
			prot.find('#sno').attr('name', 'sno');
			prot.find('#sno').html(rowCount);
			
			prot.find('#hidAccBookId').attr('name', 'hidAccBookId');
			prot.find('#stayType').attr('name', 'stayType');
			prot.find('#locationTB').attr('name', 'locationPT');
			prot.find('#locationDD').attr('name', 'locationTemp');
			prot.find('#locationTBHid').attr('name', 'locationPT');
			prot.find('#chkInDate').attr('name', 'chkInDate');	
			prot.find('#chkOutDate').attr('name', 'chkOutDate');
			prot.find('#stayCharges').attr('name', 'stayCharges');
			prot.find('#stayRemarks').attr('name', 'stayRemarks');
			
			var stayTypeVal = prot.find("#stayType").val();
			if(stayTypeVal == 'Hotel') {
				
				prot.find("td#locTd").find("#locationTB").removeClass("hide");
				prot.find("td#locTd").find("#locationTB").addClass("show");
				prot.find("td#locTd").find("#locationDD").removeClass("show");
				prot.find("td#locTd").find("#locationDD").addClass("hide");
				
				prot.find("td#locTd").find("#locationTBHid").attr('name','locationPT');
				prot.find("td#locTd").find("#locationTB").attr('name','location');
				
				prot.find("td#locTd").find("#locationTBHid").val("");
				
			} else if(stayTypeVal == 'Transit House') {
				
				prot.find("td#locTd").find("#locationDD").removeClass("hide");
				prot.find("td#locTd").find("#locationDD").addClass("show");
				prot.find("td#locTd").find("#locationTB").removeClass("show");
				prot.find("td#locTd").find("#locationTB").addClass("hide");
				
				prot.find("td#locTd").find("#locationTBHid").attr('name','location');
				prot.find("td#locTd").find("#locationTB").attr('name','locationPT');
				prot.find("td#locTd").find("#locationTB").val("");
				
				var locDDVal = prot.find("td#locTd").find("select#locationDD option:selected").val();
				var locDDTxt = prot.find("td#locTd").find("select#locationDD option:selected").text();
				//prot.find("td#locTd").find("#locationTBHid").val(""); 
				
				if (locDDVal != "0") { 
					prot.find("td#locTd").find("#locationTBHid").val(locDDTxt); 
				}
			}
			
			prot.find('tr.accPrototypeRow1').addClass('accDetailsRow1');
			prot.find('tr.accDetailsRow1').removeClass('accPrototypeRow1');
			
			prot.find('tr.accPrototypeRow2').addClass('accDetailsRow2');
			prot.find('tr.accDetailsRow2').removeClass('accPrototypeRow2');
			
			prot.attr("class", "");
			prot.addClass("accDetailsRow");	
			$('.innerAccInfoRow').before(prot);
		
			resetPlaceHolder();
		});
		
		$(document).on('click','table#ticketInfoTable #delRow',function() {
			var master = $("table#ticketInfoTable");
			var dataRow = master.find("tbody tr.ticketDetailsRow");
			var rowCountTkt = $("table#ticketInfoTable tbody tr.ticketDetailsRow").length;
			
			// show Grid Tkt Row having tktId same as deleted row's tktId
			var hidTktId = $(this).parents('tr.ticketDetailsRow').find("#hidTktBookId").val();
			$("table#tktGridTable tbody tr.tktGridRow").each(function(){
				if($(this).find("#hidTktBookId").val() == hidTktId) {
					$(this).show();
					$(this).removeClass("hideGridRow");
				}
			});
			resetGrpTrvlrChkBoxesOnRowDelete(this);
			
			if(rowCountTkt > 1) {
				$(this).parents("table#ticketInfoTable tr").remove();
			} 
			else 
			{	dataRow.find("#hidTktBookId").val("0");
				dataRow.find("#secFrom").val("");
				dataRow.find("#secFrom").attr('style','color:rgb(122, 122, 122)');
				dataRow.find("#secTo").val("");
				dataRow.find("#secTo").attr('style','color:rgb(122, 122, 122)');			
				dataRow.find("#classType").val("");
				dataRow.find("#classType").attr('style','color:rgb(122, 122, 122)');
				dataRow.find("#deptrDate").val("");
				dataRow.find("#deptrDate").attr('style','color:rgb(122, 122, 122)');	
				dataRow.find("#deptrTime").val("");
				dataRow.find("#deptrTime").attr('style','color:rgb(122, 122, 122)');
				dataRow.find("#arrDate").val("");
				dataRow.find("#arrDate").attr('style','color:rgb(122, 122, 122)');
				dataRow.find("#arrTime").val("");
				dataRow.find("#arrTime").attr('style','color:rgb(122, 122, 122)');	
				dataRow.find("#airlineType").val("");
				dataRow.find("#airlineType").attr('style','color:rgb(122, 122, 122)');
				dataRow.find("#pnr").val("");
				dataRow.find("#pnr").attr('style','color:rgb(122, 122, 122)'); 
				dataRow.find("#ticketNo").val("");
				dataRow.find("#ticketNo").attr('style','color:rgb(122, 122, 122)');
				/* dataRow.find("#bscFare").val("");
				dataRow.find("#bscFare").attr('style','color:rgb(122, 122, 122)');			
				dataRow.find("#taxes").val("");
				dataRow.find("#taxes").attr('style','color:rgb(122, 122, 122)'); */
				dataRow.find("#ttlFare").val("");
				dataRow.find("#ttlFare").attr('style','color:rgb(122, 122, 122)');	
				dataRow.find("#tktStatus").val("");
				dataRow.find("#tktStatus").attr('style','color:rgb(122, 122, 122)');
				dataRow.find("#tktRemarks").val("");
				dataRow.find("#tktRemarks").attr('style','color:rgb(122, 122, 122)');
				dataRow.find("#tktUsers").val("");
				dataRow.find("#tktUsers").removeClass("tktUserIdsCls");
				dataRow.find("#tktUsers").attr('style','color:rgb(122, 122, 122)');
				
				/* if(rowCountTkt == 1) {
					$("label#tktReqYes").removeClass("active");
					$("label#tktReqNo").addClass("active");
					$("input:radio#tktReq_Y").attr('checked', false);
					$("input:radio#tktReq_N").attr('checked', true);
					$("div#tktInfo").removeClass("show");
					$("div#tktInfo").addClass("hide");
					$('[name=hidTicketDataFlag]').val("false");
					tktChkYFlag	= false;
				} */
			} 
			$(this).parents("table#ticketInfoTable tr").remove();
		});
		
		$(document).on('click','table#visaInfoTable #delRow',function() {
			var master = $("table#visaInfoTable");
			var dataRow = master.find("tbody tr.visaDetailsRow");
			var rowCountVisa = $("table#visaInfoTable tbody tr.visaDetailsRow").length;
			if(rowCountVisa > 1) {
				$(this).parents("table#visaInfoTable tr").remove();
			} 
			else 
			{	dataRow.find("#hidVisaBookId").val("0");
				dataRow.find("#visaStatus").val("");
				dataRow.find("#visaStatus").attr('style','color:rgb(122, 122, 122)');
				dataRow.find("#sno").val("");
				dataRow.find("#sno").attr('style','color:rgb(122, 122, 122)');			
				dataRow.find("#pprtNo").val("");
				dataRow.find("#pprtNo").attr('style','color:rgb(122, 122, 122)');
				dataRow.find("#ppExpDate").val("");
				dataRow.find("#ppExpDate").attr('style','color:rgb(122, 122, 122)');	
				dataRow.find("#visaType").val("");
				dataRow.find("#visaType").attr('style','color:rgb(122, 122, 122)');
				dataRow.find("#country").val("");
				dataRow.find("#country").attr('style','color:rgb(122, 122, 122)');
				/* dataRow.find("#docRecDate").val("");
				dataRow.find("#docRecDate").attr('style','color:rgb(122, 122, 122)');	
				dataRow.find("#visaIssuDate").val("");
				dataRow.find("#visaIssuDate").attr('style','color:rgb(122, 122, 122)'); */
				dataRow.find("#visaValFrom").val("");
				dataRow.find("#visaValFrom").attr('style','color:rgb(122, 122, 122)'); 
				dataRow.find("#visaValTo").val("");
				dataRow.find("#visaValTo").attr('style','color:rgb(122, 122, 122)');
				dataRow.find("#durOfStay").val("");
				dataRow.find("#durOfStay").attr('style','color:rgb(122, 122, 122)');			
				dataRow.find("#entryType").val("");
				dataRow.find("#entryType").attr('style','color:rgb(122, 122, 122)');
				dataRow.find("#visaCharges").val("");
				dataRow.find("#visaCharges").attr('style','color:rgb(122, 122, 122)');	
				dataRow.find("#visaRem").val("");
				dataRow.find("#visaRem").attr('style','color:rgb(122, 122, 122)');
				
				if(rowCountVisa == 1) {
					$("label#VisaReqYes").removeClass("active");
					$("label#VisaReqNo").addClass("active");
					$("input:radio#VisaReq_Y").attr('checked', false);
					$("input:radio#VisaReq_N").attr('checked', true);
					$("div#visaInfo").removeClass("show");
					$("div#visaInfo").addClass("hide");
					$('[name=hidVisaDataFlag]').val("false");
					visaChkYFlag = false;
				}
			} 
			$(this).parents("table#visaInfoTable tr").remove();
		});
		
		$(document).on('click','table#accInfoTable #delRow',function() {
			var master = $("table#accInfoTable");
			var dataRow = master.find("tbody tr.accDetailsRow");
			var rowCountAccom = $("table#accInfoTable tbody tr.accDetailsRow").length;
			if(rowCountAccom > 1) {
				$(this).parents("table#accInfoTable tr").remove();
			} 
			else { 
				dataRow.find("#hidAccBookId").val("0");
				dataRow.find("#stayType").val("");
				dataRow.find("#stayType").attr('style','color:rgb(122, 122, 122)');
				dataRow.find("#locationTB").val("");
				dataRow.find("#locationTB").attr('style','color:rgb(122, 122, 122)');	
				dataRow.find("#locationDD").val("");
				dataRow.find("#locationDD").attr('style','color:rgb(122, 122, 122)');
				dataRow.find("#locationTBHid").val("");
				dataRow.find("#chkInDate").val("");
				dataRow.find("#chkInDate").attr('style','color:rgb(122, 122, 122)');
				dataRow.find("#chkOutDate").val("");
				dataRow.find("#chkOutDate").attr('style','color:rgb(122, 122, 122)');	
				dataRow.find("#stayCharges").val("");
				dataRow.find("#stayCharges").attr('style','color:rgb(122, 122, 122)');
				dataRow.find("#stayRemarks").val("");
				dataRow.find("#stayRemarks").attr('style','color:rgb(122, 122, 122)');
				
				if(rowCountAccom == 1) {
					$("label#AccReqYes").removeClass("active");
					$("label#AccReqNo").addClass("active");
					$("input:radio#AccReq_Y").attr('checked', false);
					$("input:radio#AccReq_N").attr('checked', true);
					$("div#accInfo").removeClass("show");
					$("div#accInfo").addClass("hide");
					$('[name=hidAccDataFlag]').val("false");
					accChkYFlag	= false;
				}
			} 
			$(this).parents("table#accInfoTable tr").remove();
		});
		
		function checkAll()
		{
			for(var i=0;i<<%=iSno%>;i++) {
				if(!$('[name=chkbox'+i+']').is(':disabled')) {
					
					$('[name=chkbox'+i+']').attr('checked',true);
					$('[name=chkbox'+i+']').val('Y');
					$('#hidmailSentFlag'+i).val('Y');
				}
			}
		}

		function uncheckAll()
		{
			for(var i=0;i<<%=iSno%>;i++) {
				if(!$('[name=chkbox'+i+']').is(':disabled')) {
					
					$('[name=chkbox'+i+']').attr('checked',false);
					$('[name=chkbox'+i+']').val('N');
					$('#hidmailSentFlag'+i).val('N');
				}
			}
		}
		
		function setTktTotalFareVal(element) {
			
			var totalFareVal	= $(element).val();
			var tktNo 			= $(element).parents('tr.ticketDetailsRow').find('#ticketNo').val();
			
			if(totalFareVal == '') {
				$(element).val('0');
				totalFareVal 	= '0';
			
			} else {
				totalFareVal = (parseInt(totalFareVal)).toString();
				$(element).val(totalFareVal);
			}
			
			if(tktNo != '') {
				
				var ticketNoVal  	= '';
				var gridTktNoVal 	= '';
				var ttlFare			= '';
				var tktIdVal		= '';
				
				var prototypeFlag	= false;
				var gridFlag		= ($('table#tktGridTable').length > 0 );
				
				var tktRowIndex		= $(element).parents('tr.ticketDetailsRow').index();
				var tktRows 		= $('table#ticketInfoTable tbody tr.ticketDetailsRow');
				var tktRowsCount	= $('table#ticketInfoTable tbody tr.ticketDetailsRow').length;
				
				var tktGrid 		= $('table#tktGridTable');
				var tktGridRows		= tktGrid.find('tbody tr#tktGridRow');
				
				if(gridFlag && tktRowsCount == 1) {
					
					tktGridRows.each(function() {
						if(!$(this).hasClass("hideGridRow")) {
							gridTktNoVal = $(this).find('#ticketNo').val();
							
							var tmpTtlFare = $(this).find('#ttlFare').val();
							if(tmpTtlFare != '') {
								tmpTtlFare = (parseInt(tmpTtlFare)).toString();
							}
							
							if(gridTktNoVal == tktNo) {
								if(tmpTtlFare != '0') {
									
									$(element).val('0');
									return false;
								}
							}
						}
					});
				
				} else if(gridFlag && tktRowsCount > 1) {
					
					tktGridRows.each(function() {
						
						if(!$(this).hasClass("hideGridRow")) {
							gridTktNoVal = $(this).find('#ticketNo').val();
							
							var tmpTtlFare = $(this).find('#ttlFare').val();
							if(tmpTtlFare != '') {
								tmpTtlFare = (parseInt(tmpTtlFare)).toString();
							}
							
							if(gridTktNoVal == tktNo) {
								if(tmpTtlFare != '0') {
									
									$(element).val('0');
									return false;
								}
							}
						}
					});
					
					tktRows.each(function() {
						var rowIndex	= $(this).index();
						
						ticketNoVal 	= $(this).find('table tr.ticketDetailsRow2 #ticketNo').val();
						ttlFare			= $(this).find('table tr.ticketDetailsRow3 #ttlFare').val();
						
						if(ttlFare != '') {
							ttlFare = (parseInt(ttlFare)).toString();
						}
						
						if(typeof ticketNoVal === 'undefined' && typeof ttlFare === 'undefined') {
							prototypeFlag = true;
						}
						
						if(!prototypeFlag && (tktRowIndex != rowIndex) && (ttlFare != '0') && (ticketNoVal == tktNo)) {
							$(element).val('0');
							return false;
						}
					});
				
				} else {
					tktRows.each(function() {
						var rowIndex	= $(this).index();
						
						ticketNoVal 	= $(this).find('table tr.ticketDetailsRow2 #ticketNo').val();
						ttlFare			= $(this).find('table tr.ticketDetailsRow3 #ttlFare').val();
						
						if(ttlFare != '') {
							ttlFare = (parseInt(ttlFare)).toString();
						}
						
						if(typeof ticketNoVal === 'undefined' && typeof ttlFare === 'undefined') {
							prototypeFlag = true;
						}
						
						if(!prototypeFlag && (tktRowIndex != rowIndex) && (ttlFare != '0') && (ticketNoVal == tktNo)) {
							$(element).val('0');
							return false;
						}
					});
				}
			}
		}
		
		function resetGrpTrvlrChkBoxesOnTktReqYes() {
				
			$(':checkbox.tktFlagChkBox').each(function() {
				var chkBoxval = $(this).next('.checkedUserCls').val();
				//check all users exists in fixed userId Array
		   		if($.inArray(chkBoxval,fixedGrpUsersArr) > -1) {
					this.checked 	= false;
					this.disabled 	= true;
				} else {
					this.checked 	= false;
					this.disabled 	= false;
				}
			});
			
			var hideTktYNFlag = true;
			$(':checkbox.tktFlagChkBox').each(function() {
				if(!$(this).is(':disabled')) {
					hideTktYNFlag = false;
				} 
			});
			// if all Grp. traveller checkboxes are disabled then hide Add Row Button
			if(hideTktYNFlag) {
				$("#addTktInfo").hide();
			} else {
				$("#addTktInfo").show();
			}
		}
		
		function resetGrpTrvlrChkBoxesOnTktReqNo() {
			
			// disable all grp travellers checkboxes
			$(':checkbox.tktFlagChkBox').each(function() {
		   		this.disabled 	= true;
			});
		}
		
		function resetGrpTrvlrChkBoxesOnRowAdd(){
			
			var rowCountTkt = $("table#ticketInfoTable tbody tr.ticketDetailsRow").length;
			
			if(rowCountTkt == 0) {
				
				$(':checkbox.tktFlagChkBox').each(function() {
					var chkBoxval = $(this).next('.checkedUserCls').val();
					//check all users exists in fixed userId Array
			   		if($.inArray(chkBoxval,fixedGrpUsersArr) > -1) {
						this.checked 	= false;
						this.disabled 	= true;
					} else {
						this.checked 	= false;
						this.disabled 	= false;
					}
				});
			} else {
				// do nothing
			}
		}
		
		function resetGrpTrvlrChkBoxesOnRowDelete(element){
			
			// check/uncheck grpUsers CheckBoxes 
			var grpUsersId 	= $(element).parents('tr.ticketDetailsRow').find(".tktUserIdsCls").val();
			var rowCountTkt = $("table#ticketInfoTable tbody tr.ticketDetailsRow").length;
			
			if(rowCountTkt == 1) {
				
				$(':checkbox.tktFlagChkBox').each(function() {
					var chkBoxval = $(this).next('.checkedUserCls').val();
					//check all users exists in fixed userId Array
			   		if($.inArray(chkBoxval,fixedGrpUsersArr) > -1) {
						this.checked 	= true;
						
					} else {
						this.checked 	= false;
					}
			   		this.disabled 	= true;
				});
			
			} else if(rowCountTkt > 1) {
				if(grpUsersId != "") {
					$(':checkbox.tktFlagChkBox').each(function() {
						var chkBoxval = $(this).next('.checkedUserCls').val();
						
						//check all users exists in new userIds Array
				   		if($.inArray(chkBoxval,newGrpUsersArr) > -1) {
							this.checked 	= true;
						} else {
							this.checked 	= false;
						}
				   		//disable all users, exists in fixed userId Array
				   		if($.inArray(chkBoxval,fixedGrpUsersArr) > -1) {
				   			this.checked 	= true;
				   			this.disabled 	= true;
						} else {
							this.disabled 	= false;
						}
					});
				} else {
					// do nothing
				}
			}
		}
		
		function resetGrpTrvlrChkBoxesOnValidationFail(submitUserIdsArr) {
			
			var i = 0;
			$(':checkbox.tktFlagChkBox').each(function() {
				var chkBoxval = $(this).next('.checkedUserCls').val();
				
				if(submitUserIdsArr[i]=='Y'){
					//this.checked 	= true;
				} else {
					this.checked 	= false;
				}
				
		   		//disable all users, exists in fixed userId Array
		   		if($.inArray(chkBoxval,fixedGrpUsersArr) > -1) {
		   			//this.checked 	= true;
		   			this.disabled 	= true;
				} else {
					this.disabled 	= false;
				}
		   		++i;
			});
		}
		
		function getTicketDetails(element,tktBookId) {
			var trvlBookId = <%=tBookId%>;
			var tktRowLen = $("table#ticketInfoTable tbody tr.ticketDetailsRow").length;
			
			if(tktRowLen >= 0){
				if(tktRowLen == 0) {
					$("#addTktInfo").click();			// If there are no editable rows, generate 1 editable TKT row
				}
				
				$.ajax({
			       url: "Group_PersonnelBookingServlet",
			       type:'POST',
			       dataType: "json",
			       data : {
			           action 		: 'ticketDetails',
			           trvlBookId	: trvlBookId,
			           tktBookId	: tktBookId
			       }
			   	}).done(function(result) {
			   		
			   		var master = $("table#ticketInfoTable");
					var dataRow = master.find("tbody tr.ticketDetailsRow");
					var hidTktId = dataRow.find("#hidTktBookId").val();				// always pick 1st row's hidden ticket id [Editable ticket's row]
					
					$('table#ticketInfoTable').show();
					// remove all rows other than 1st TKT row on Edit button click
					var cnt = 0;
					$("table#ticketInfoTable tbody tr.ticketDetailsRow").each(function(){
						if (cnt > 0){
							$(this).find("#delRow").click();
						}
						++cnt;
					});
					
					// show Grid's hidden row having tktId same as 1st Editable TKT row
					$("table#tktGridTable tbody tr.tktGridRow").each(function(){
						if(hidTktId == $(this).find("#hidTktBookId").val()) {
							$(this).show();											  
							$(this).removeClass("hideGridRow");
						}
					});
					
					dataRow.find("#hidTktBookId").val("");
					dataRow.find("#hidTktBookId").val(result.ticketBookId);
					dataRow.find("#secFrom").val("");
					dataRow.find("#secFrom").val(result.secFrom1);
					dataRow.find("#secTo").val("");
					dataRow.find("#secTo").val(result.secTo1);
					dataRow.find("#classType option").each(function() {
						if($(this).text() == result.cls) {
					    	$(this).attr('selected', 'selected');            
					  	}                        
					});
					dataRow.find("#deptrDate").val("");
					dataRow.find("#deptrDate").val(result.deptrDate);
					dataRow.find("#deptrTime").val("");
					dataRow.find("#deptrTime").val(result.deptrTime);
					dataRow.find("#arrDate").val("");
					dataRow.find("#arrDate").val(result.arrDate);
					dataRow.find("#arrTime").val("");
					dataRow.find("#arrTime").val(result.arrTime);
					dataRow.find("#airlineType").val("");
					dataRow.find("#airlineType").val(result.airline);
					dataRow.find("#pnr").val("");
					dataRow.find("#pnr").val(result.pnr);
					dataRow.find("#ticketNo").val("");
					dataRow.find("#ticketNo").val(result.eTktNo);
					/* dataRow.find("#bscFare").val("");
					dataRow.find("#bscFare").val(result.basicFare);
					dataRow.find("#taxes").val("");
					dataRow.find("#taxes").val(result.taxes); */
					dataRow.find("#ttlFare").val("");
					dataRow.find("#ttlFare").val(result.totFare);
					dataRow.find("#tktStatus").val("");
					dataRow.find("#tktStatus").val(result.tktStatus);
					dataRow.find("#tktRemarks").val("");
					dataRow.find("#tktRemarks").val(result.tktRemarks);
					dataRow.find("#tktUsers").val("");
					dataRow.find("#tktUsers").val(result.grpUserIds);
					
					var grpUsersArr = (result.grpUserIds).split(',');
					
					// check all grp users(checkboxes) for which the editable ticket row is generated previously & disable all checkboxes
					$(':checkbox.tktFlagChkBox').each(function() {
				   		
						var chkBoxval = $(this).next('.checkedUserCls').val();
						//check all users exists in post userId Array
				   		if($.inArray(chkBoxval,grpUsersArr) > -1) {
							this.checked 	= true;
							//$(this).click();
						} else {
							this.checked 	= false;
						}
				   		this.disabled 	= true;
					});
					
					// hide this row from TKT Grid Table 
					$(element).parents("tr.tktGridRow").addClass("hideGridRow");
					$(element).parents("tr.tktGridRow").hide();
				});
			}
		}
	</script>
	</form>
  </body>
</html>