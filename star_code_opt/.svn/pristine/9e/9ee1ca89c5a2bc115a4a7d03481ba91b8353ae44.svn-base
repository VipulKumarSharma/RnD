	<%@ page pageEncoding="UTF-8" %>
	<%@page import="java.sql.*"%>
	<%@page import="java.util.*"%>
	<%@page import="java.sql.*"%>
	<%@page import="src.connection.*"%>
	<%@ include  file="importStatement.jsp" %>
	<html>
	<head>	
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
	
	<link type="text/css" rel="stylesheet" href="scripts/main.css?buildstamp=2_0_0" />
	
	<link type="text/css" rel="stylesheet" href="jsGrid/css/jquery-ui.css?buildstamp=2_0_0" />
	<link type="text/css" rel="stylesheet" href="jsGrid/css/jsgrid.css?buildstamp=2_0_0" />
	<link type="text/css" rel="stylesheet" href="jsGrid/css/jsgrid-theme.css?buildstamp=2_0_0" />
	<link type="text/css" rel="stylesheet" href="jsGrid/css/jquery-ui-timepicker-addon.css?buildstamp=2_0_0" />
	
	<script type="text/javascript" language="JavaScript" src="ScriptLibrary/date-picker.js?buildstamp=2_0_0"></script>
	<script type="text/javascript" language="JavaScript" src="scripts/CommonValida.js?buildstamp=2_0_0"></script>
	
	<script type="text/javascript" language="JavaScript" src="jsGrid/js/jquery-1.10.2.js?buildstamp=2_0_0"></script>
    <script type="text/javascript" language="JavaScript" src="jsGrid/js/jquery-ui.js?buildstamp=2_0_0"></script>
    <script type="text/javascript" language="JavaScript" src="jsGrid/js/jquery.validate.min.1.9.js?buildstamp=2_0_0"></script>
    <script type="text/javascript" language="JavaScript" src="jsGrid/js/json2.js?buildstamp=2_0_0"></script>
	<script type="text/javascript" language="JavaScript" src="jsGrid/js/jquery-ui-sliderAccess.js?buildstamp=2_0_0"></script>
    <script type="text/javascript" language="JavaScript" src="jsGrid/js/jquery-ui-timepicker-addon.js?buildstamp=2_0_0"></script>
 
	<script type="text/javascript" language="JavaScript" src="jsGrid/js/jsgrid.js?buildstamp=2_0_0"></script>
    
	<script type="text/javascript" language="JavaScript" src="jsGrid/src/jsgrid.core.js?buildstamp=2_0_0"></script>
    <script type="text/javascript" language="JavaScript" src="jsGrid/src/jsgrid.load-indicator.js?buildstamp=2_0_0"></script>
    <script type="text/javascript" language="JavaScript" src="jsGrid/src/jsgrid.load-strategies.js?buildstamp=2_0_0"></script>
    <script type="text/javascript" language="JavaScript" src="jsGrid/src/jsgrid.sort-strategies.js?buildstamp=2_0_0"></script>
    <script type="text/javascript" language="JavaScript" src="jsGrid/src/jsgrid.field.js?buildstamp=2_0_0"></script>
    <script type="text/javascript" language="JavaScript" src="jsGrid/src/jsgrid.field.text.js?buildstamp=2_0_0"></script>
    <script type="text/javascript" language="JavaScript" src="jsGrid/src/jsgrid.field.number.js?buildstamp=2_0_0"></script>
    <script type="text/javascript" language="JavaScript" src="jsGrid/src/jsgrid.field.select.js?buildstamp=2_0_0"></script>
    <script type="text/javascript" language="JavaScript" src="jsGrid/src/jsgrid.field.checkbox.js?buildstamp=2_0_0"></script>
    <script type="text/javascript" language="JavaScript" src="jsGrid/src/jsgrid.field.control.js?buildstamp=2_0_0"></script>
	
	<%
		Calendar cal 			= Calendar.getInstance();
		SimpleDateFormat sdf 	= new SimpleDateFormat("dd/MM/yyyy");
		String strDate 			= sdf.format(cal.getTime());
		
		DbConnectionBean objCon;
	 	Connection con 	= null;
	 	Statement stmt 	= null;
		ResultSet rs	= null;
		objCon 			= new DbConnectionBean();
		con 			= objCon.getConnection();
		stmt			= con.createStatement();
		
		HttpSession sess= request.getSession();
		String userId	= "";
		String subRole	= "";
		String cnclBy	= "";
		String emailFrom= "";
		
		String strMsg					= request.getParameter("strMsg")== null ?  "" : request.getParameter("strMsg").trim();
		
		String dataExistsFlag			= request.getParameter("etx_dataExistsFlag")== null ?  "true" : request.getParameter("etx_dataExistsFlag").trim();
		String etx_date					= request.getParameter("etx_date")== null ?  strDate : request.getParameter("etx_date").trim();
		String etx_siteId				= request.getParameter("etx_siteId")== null ?  "0" : request.getParameter("etx_siteId").trim();
		String etx_travellerId			= request.getParameter("etx_travellerId")== null ?  "0" : request.getParameter("etx_travellerId").trim();
		String etx_travelType			= request.getParameter("etx_travelType")== null ?  "A" : request.getParameter("etx_travelType").trim();
		String etx_reqNo				= request.getParameter("etx_reqNo")== null ?  "" : request.getParameter("etx_reqNo").trim();
		String etx_status				= request.getParameter("etx_status")== null ?  "0" : request.getParameter("etx_status").trim();
		String etx_bookedBy				= request.getParameter("etx_bookedBy")== null ?  "0" : request.getParameter("etx_bookedBy").trim();
		String etx_reportType			= request.getParameter("etx_reportType")== null ?  "0" : request.getParameter("etx_reportType").trim();
		String etx_selectedReportType	= request.getParameter("etx_selectedReportType")== null ?  "0" : request.getParameter("etx_selectedReportType").trim();
		
		String etx_travelStatus			= request.getParameter("etx_travelStatus")== null ?  "10" : request.getParameter("etx_travelStatus").trim();
				
		userId			= sess.getValue("user_id") == null ? "" : (String) sess.getValue("user_id");
		//System.out.println("userId="+userId);
		
		rs	= stmt.executeQuery("select LTRIM(RTRIM(FIRSTNAME))+' '+LTRIM(RTRIM(LASTNAME)) as NAME, EMAIL from M_USERINFO where USERID="+userId+" and STATUS_ID=10");
		if(rs.next()) 
		{	cnclBy		=   rs.getString("NAME").trim();
			emailFrom	=	rs.getString("EMAIL").trim();
		}
		rs.close();
		
		String M_trvlBookId		= request.getParameter("trvlBookId")== null ?  "" : request.getParameter("trvlBookId").trim();
		String M_tReqNo			= request.getParameter("tReqNo")== null ?      "" : request.getParameter("tReqNo").trim();
		String M_statusflag		= request.getParameter("flag")== null ?        "" : request.getParameter("flag").trim();
		String M_cnclMailFlag	= request.getParameter("cnclMailFlag")== null ?"false" : request.getParameter("cnclMailFlag");
		String M_travelType		= request.getParameter("travelType")== null ?  "" : request.getParameter("travelType").trim();
		String M_siteName		= request.getParameter("siteName")== null ?  "" : request.getParameter("siteName").trim();
		String M_travelerName   = request.getParameter("travelerName")== null ?  "" : request.getParameter("travelerName").trim();
		String action			= request.getParameter("action")== null ?  "" : request.getParameter("action").trim();
		
		//System.out.println("[CNCL. MAIL] :: TrvlBookId="+M_trvlBookId+"  Statusflag="+M_statusflag+"  MailFlag="+M_cnclMailFlag+"  TravelType="+M_travelType); 
		//System.out.println("[CNCL. MAIL] :: ReqNo="+M_tReqNo+"  EmailFrom="+emailFrom+"  userId="+userId+"  action="+action);
		
		if (M_cnclMailFlag.equalsIgnoreCase("true") && M_statusflag.equals("0")  && (action.equalsIgnoreCase("UPDATE"))) {
		%>
			<jsp:include page="BookingReportCancellation.jsp"> 
				<jsp:param name="purchaseRequisitionId" value="0"/>
				<jsp:param name="CancelComments" value=""/>
				<jsp:param name="travelType" value="<%=M_travelType%>"/>
				<jsp:param name="RequisitionNum" value="<%=M_tReqNo%>"/>
				<jsp:param name="emailFrom" value="<%=emailFrom%>"/>
				<jsp:param name="cnclBy" value="<%=cnclBy%>"/>
				<jsp:param name="siteName" value="<%=M_siteName%>"/>
				<jsp:param name="travelerName" value="<%=M_travelerName%>"/>
			</jsp:include>
		<%	
		}
		
		
		rs	= stmt.executeQuery("select STUFF((SELECT ','+Booking_Role FROM M_BOOKING_ROLE R WHERE CHARINDEX(','+CONVERT(VARCHAR,Booking_Role_ID)+',',','+M_USERINFO.BOOKING_ROLE+',')>0 FOR XML path(''), type).value('.', 'varchar(max)')   ,1,1,'') AS BOOKING_ROLE from M_USERINFO where M_USERINFO.USERID="+userId+" and M_USERINFO.STATUS_ID=10");
		if(rs.next()) 
		{	subRole	=	rs.getString("BOOKING_ROLE");
		}
		rs.close();
	%>
	</head>	
	<body id="parentBody">
	<div id = "divBackground" style="position: absolute; z-index: 999; height: 100%; width: 100%; top: 0; left:0; background-color: Black; filter: alpha(opacity=60); opacity: 0.6; -moz-opacity: 0.8;display:none">
	</div>
	<form name="frm" action="">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin:8px 5px 5px 5px;">
		  <tr style="padding-bottom: 8px;">
		    <td width="50%" height="15" class="bodyline-top" style="border-bottom: lightgray 1px solid;" nowrap="">
				<ul class="pagebullet">
			      <li class="pageHead">
			      		<font color="#515151"><b><%=dbLabelBean.getLabel("label.report.submenu.starreporttravelfutrereport",strsesLanguage) %></b></font>
			      		<span style="padding-left: 250px;" id="message"></span>
			      </li>
			    </ul>
		    </td>
			<td width="50%" height="15" align="left" valign="bottom" class="bodyline-top" style="border-bottom: lightgray 1px solid;">
				<font color='green'>
			      	<b></b>
			  	</font>
				<table width="39%" align="right" border="0" cellspacing="0" cellpadding="0" >
			      <!--<tr align="right">
			         <td width="48%" align="right"><a href="#" onClick="javascript:top.window.close();"><img src="images/IconClose.gif?buildstamp=2_0_0" width="49" height="24" border="0" /></a></td>
			        <td width="48%" align="right"><a href="#" onClick="window.print();"><img src="images/IconPrint.gif?buildstamp=2_0_0" width="49" height="24" border="0" /></a></td>
			      </tr>-->
			    </table>
			</td>
		  </tr>
		</table>
	
		<table width="100%" align="center" border="0" cellpadding="5" cellspacing="0" class="formborder" style="margin:5px 5px 5px 5px;border: lightgray 1px solid; ">
			<tr>
				<td class="formtr2" align="left" nowrap="" style="color:#515151;">&nbsp;<%=dbLabelBean.getLabel("label.user.date",strsesLanguage) %></td>
				<td class="formtr2" align="left">
					 <input type="textbox" name="dt_date" id="dt_date" value="<%=etx_date%>" size='10' maxlength="10" class="textBoxCss" 
					 	onFocus="javascript:vDateType='DD/MM/YYYY'" onKeyUp="DateFormat(this,this.value,event,false,'DD/MM/YYYY','Invalid Date.Please Re-Enter')" 
					 	onBlur="DateFormat(this,this.value,event,true,'DD/MM/YYYY','Invalid Date.Please Re-Enter')" 
					 	onChange="javascript:while(''+this.value.charAt(this.value.length-1)==' ')this.value=this.value.substring(0,this.value.length-1);"
					 >
					<a href="javascript:show_calendar('frm.dt_date','a','a','DD/MM/YYYY');" 
						onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;">
						<img border="0" name="imageField" src="images/calender.png?buildstamp=2_0_0" align="absmiddle">
					</a>
				</td>
				
				<td class="formtr2" align="center" nowrap="" style="color:#515151;"><%=dbLabelBean.getLabel("label.global.unitname",strsesLanguage)%></td>
			 	<td class="formtr2" align="center" style="width:250px;">
			 		<select name="selectUnit" id="selectUnit" class="textBoxCss" style="width: 100%;">	
			 			<option VALUE="0"> All</option>
	<%
						String sSqlStr="select  DISTINCT(dbo.sitename(site_id)) as site_name ,SITE_ID  from m_userinfo WHERE (STATUS_ID = 10) order BY SITE_NAME;";
						rs = stmt.executeQuery(sSqlStr);
						while(rs.next()) 
						{
	%>						<option VALUE="<%=rs.getString("SITE_ID")%>"><%=rs.getString("site_name")%></option>
	<%					}
						rs.close();	
	%>				</select>
					<script type="text/javascript">
					    document.getElementById("selectUnit").value='<%=etx_siteId%>';
					</script>
			 	</td>
			 	
			 	<td class="formtr2" align="center" style="color:#515151;"><%=dbLabelBean.getLabel("label.global.traveller",strsesLanguage)%></td>
				<td class="formtr2" align="center">
					<select name="traveller" id="traveller" class="textBoxCss" style="width: 180px;">	
					    <option  value='0' selected="selected">All</option>
					</select>
				</td>
				
			 	<td class="formtr2" nowrap="nowrap" style="color:#515151;"><%=dbLabelBean.getLabel("label.report.traveltype",strsesLanguage) %></td>
			 	<td class="formtr2" align="center" style="width:150px;" nowrap="nowrap">
			 		<select name="travelType" id="travelType" class="textBoxCss" style="width:100%;"> 
						<option value="A" selected="selected"><%=dbLabelBean.getLabel("label.search.all",strsesLanguage) %></option>
						<option value="I"><%=dbLabelBean.getLabel("label.report.international",strsesLanguage) %></option>
						<option value="D"><%=dbLabelBean.getLabel("label.report.domestic",strsesLanguage) %></option>
					</select>
			 	</td> 
			 	
			 	<td class="formtr2" align="center" style="text-align: center;color:#515151;width:80px;" colspan="1"  nowrap="nowrap">
				 	<%=dbLabelBean.getLabel("label.search.reportType",strsesLanguage)%>
				</td>
				<td class="formtr2" style="width:180px;" nowrap="nowrap">
				 	<select name="reportType" id="reportType" class="textBoxCss" style="width:100%;">	
					    <option value="0">Select Report Type</option>		
					<%
						ResultSet rList = dbUtility.getReportType();
						while(rList.next()) {
					%>		<option value=<%=rList.getString(1)%>> <%=rList.getString(2)%></option>
					<%	}
					%>
					</select>
				 </td>
			</tr>
			<tr>
				<td class="formtr2" align="center" nowrap="" style="color:#515151;"><%=dbLabelBean.getLabel("label.bookingstatus.bookedby",strsesLanguage)%></td>
				<td class="formtr2" align="center">
					<select name="bookedBy" id="bookedBy" class="textBoxCss" style="width: 100px;">
				 	</select>
				 	
				</td>  
				
				<td class="formtr2" align="center" nowrap="" style="color:#515151;"><%=dbLabelBean.getLabel("label.bookingstatus.travelstatus",strsesLanguage)%></td>
				<td class="formtr2">
					<select name="travelStatus" id="travelStatus" class="textBoxCss" style="width: 250px;">
				<%		ResultSet rListNew = dbUtility.getTravelStatus();
						String travelStatusId	= "" ;
						String travelStatusName	= "" ;
						
						while(rListNew.next()) {
							travelStatusId 		= rListNew.getString(1);
							travelStatusName	= rListNew.getString(2);
							
							if(travelStatusId.equals("2")) {
								travelStatusName	=	"Pending";
							} else if(travelStatusId.equals("3")) {
								travelStatusName	=	"Return"	;
							} else if(travelStatusId.equals("4")) {
								travelStatusName	=	"Reject"	;						
							} else if(travelStatusId.equals("6")) {
								travelStatusName	=	"Cancel"	;
							} else if(travelStatusId.equals("10")) {
								travelStatusName	=	"Approved By All";
							}
				%>		<option value="<%=travelStatusId.trim()%>"><%=travelStatusName.trim()%></option>
				<%		}
				%>	</select>
				</td>
				
				<td class="formtr2" align="center" nowrap="" style="color:#515151;"><%=dbLabelBean.getLabel("label.personnelbooking.ticketstatus",strsesLanguage)%></td>
				<td class="formtr2" align="center" >
				 	<select name="status" id="status" class="textBoxCss" style="width: 180px;">
				 	</select>
				</td>
				 
				<td class="formtr2" nowrap="nowrap" align="center" style="color:#515151;" nowrap="nowrap"><%=dbLabelBean.getLabel("label.search.requisitionno",strsesLanguage)%></td>
				<td class="formtr2" nowrap="nowrap" align="center" style="width:150px;">
					<input type="text" name="requisitioNo" id="requisitioNo" value="<%=etx_reqNo %>" maxlength="30" class="textBoxCss" 
						onKeyUp="return test1('reqno', 29, 'cn' )" style="width:100%;">
				</td>
				 
				 <td class="formtr2" style="text-align:center;width:80px;" nowrap="nowrap">
				 	<input type="button" value="<%=dbLabelBean.getLabel("button.global.search",strsesLanguage)%>"  
						class="formbutton-green" id="goBtn" style="width:90%;font-size:100%;" onclick="javascript:reloadGrid();" >	
				 </td>
				 <td class="formtr2" style="font-size:80%;text-align:center;width:180px;" nowrap="nowrap">
				 	<input type="button" value="<%=dbLabelBean.getLabel("button.search.exporttoexcel",strsesLanguage)%>" class="formbutton-green" id="exportToExcel" 
				 		onclick="javascript:expToExcel();" style="width:95%;">
				 </td>
			</tr>
		</table>
		
		<div id="jsGrid"></div>
		<table style="margin-top: 5px;">
			<tr>
				<td width="200px">
					&nbsp;&nbsp;&nbsp;
					<input type="button" value="<%=dbLabelBean.getLabel("label.search.addPersonnelBooking",strsesLanguage)%>" 
						class="formbutton-red" id="addPersonnelBooking" style="width: 180px" 
						onClick="MM_openBrWindow('Single_PersonnelBooking.jsp','_self','scrollbars=yes,resizable=no,width=1000,height=650')">
				</td>
				
				<td width="200px" align="right" style="padding-bottom:3px;" nowrap="nowrap">
					<b><span style="border:0px;FONT-FAMILY:Verdana;FONT-SIZE:11px;COLOR:#666666;"><%=dbLabelBean.getLabel("label.bookingstatus.reqtypes",strsesLanguage)%> :&nbsp;</span></b>
				</td>
			
				<td>
					<img src='images/docIcon-red-square.png?buildstamp=2_0_0' border='0'> 
				</td>
				<td style="padding-bottom:3px;width:75px;" nowrap="nowrap">
					<span style="border:0px;FONT-FAMILY:Verdana;FONT-SIZE:11px;COLOR:#666666;"><%=dbLabelBean.getLabel("label.bookingstatus.unitsingle",strsesLanguage)%></span>
				</td>
				
				<td>
					<img src='images/docIcon-blue-square.png?buildstamp=2_0_0' border='0'>
				</td>
				<td style="padding-bottom:3px;width:50px;" nowrap="nowrap">
					<span style="border:0px;FONT-FAMILY:Verdana;FONT-SIZE:11px;COLOR:#666666;"><%=dbLabelBean.getLabel("label.bookingstatus.group",strsesLanguage)%></span>
				</td>
				
				<td>
					<img src='images/docIcon-purple-square.png?buildstamp=2_0_0' border='0'> 
				</td>
				<td style="padding-bottom:3px;width:65px;" nowrap="nowrap">
					<span style="border:0px;FONT-FAMILY:Verdana;FONT-SIZE:11px;COLOR:#666666;"><%=dbLabelBean.getLabel("label.personnelbooking.personal",strsesLanguage)%></span>
				</td>
				
				<td>
					<img src='images/docIcon-green-square.png?buildstamp=2_0_0' border='0'> 
				</td>
				<td style="padding-bottom:3px;width:90px;" nowrap="nowrap">
					<span style="border:0px;FONT-FAMILY:Verdana;FONT-SIZE:11px;COLOR:#666666;"><%=dbLabelBean.getLabel("label.bookingstatus.unitpersonal",strsesLanguage)%></span>
				</td>
				
				<td>
					<img src='images/docIcon-black-square.png?buildstamp=2_0_0' border='0'> 
				</td>
				<td style="padding-bottom:3px;width:70px;" nowrap="nowrap">
					<span style="border:0px;FONT-FAMILY:Verdana;FONT-SIZE:11px;COLOR:#666666;"><%=dbLabelBean.getLabel("label.personnelbooking.miscellaneous",strsesLanguage)%></span>
				</td>
				
				
				
				<td width="180px" align="right" style="padding-bottom:3px;" nowrap="nowrap">
					<b><span style="border:0px;FONT-FAMILY:Verdana;FONT-SIZE:11px;COLOR:#666666;"><%=dbLabelBean.getLabel("label.bookingstatus.reqstatus",strsesLanguage)%> :&nbsp;</span></b>
				</td>
				
				<td style="padding-left: 6px;">
					<img src='images/docIcon-red-square.png?buildstamp=2_0_0' border='0'> 
				</td>
				<td style="padding-bottom:2px;padding-left:5px;width:90px;" align="left" nowrap="nowrap">
					<span style="border:0px;FONT-FAMILY:Verdana;FONT-SIZE:11px;COLOR:#666666;"><%=dbLabelBean.getLabel("label.bookingstatus.inforequired",strsesLanguage)%></span>
				</td>
				
				<td style="padding-left: 6px;">
					<img src='images/docIcon-green-square.png?buildstamp=2_0_0' border='0'> 
				</td>
				<td style="padding-bottom:2px;padding-left:5px;width:100px;" align="left" nowrap="nowrap">
					<span style="border:0px;FONT-FAMILY:Verdana;FONT-SIZE:11px;COLOR:#666666;"><%=dbLabelBean.getLabel("label.bookingstatus.infofilled",strsesLanguage)%></span>
				</td>
			</tr>
			<tr align="center">
				<td width="200px"></td>
				<td width="200px"></td>
				<td colspan="10" style="padding-top:2px;" align="left" nowrap="nowrap">
					<span style="font-size: 10px;color: #373737;font-family: Verdana, Arial, Helvetica, sans-serif;padding-left: 0px;">
						[<sub style="vertical-align: middle;color=red;padding-left: 2px;">* </sub><font color="red"><%=dbLabelBean.getLabel("label.bookingstatus.unitsingle",strsesLanguage)%></font> & <font color="red"><%=dbLabelBean.getLabel("label.bookingstatus.group",strsesLanguage)%>
						</font> <%=dbLabelBean.getLabel("label.bookingstatus.detailslinknote",strsesLanguage)%> ]
					</span>
				</td>
				<td width="180px" align="right" style="padding-bottom:3px;" nowrap="nowrap">
					<b><span style="border:0px;FONT-FAMILY:Verdana;FONT-SIZE:11px;COLOR:#666666;"><%=dbLabelBean.getLabel("label.report.traveltype",strsesLanguage)%> :&nbsp;</span></b>
				</td>
				
				<td style="padding-left: 4px;">
					<img src='images/userIcon-Collaborator-15.png?buildstamp=2_0_0' border='0'> 
				</td>
				<td style="padding-bottom:2px;padding-left:5px;width:90px;" align="left" nowrap="nowrap">
					<span style="border:0px;FONT-FAMILY:Verdana;FONT-SIZE:11px;COLOR:#666666;"><%=dbLabelBean.getLabel("label.bookingstatus.singletravel",strsesLanguage)%></span>
				</td>
				
				<td style="padding-left: 4px;">
					<img src='images/grpIcon-blue.png?buildstamp=2_0_0' border='0'> 
				</td>
				<td style="padding-bottom:2px;padding-left:5px;width:100px;" align="left" nowrap="nowrap">
					<span style="border:0px;FONT-FAMILY:Verdana;FONT-SIZE:11px;COLOR:#666666;"><%=dbLabelBean.getLabel("label.bookingstatus.grouptravel",strsesLanguage)%></span>
				</td>
			</tr>
		</table>
		
<script language="JavaScript">

	bokkingStatusArr= [];
	bokkingByArr 	= [];
	yesNoArr 		= [ { Name: "YES", Id: 'Y' },
	              		{ Name: "NO" , Id: 'N' } 	
					  ];
	countryArr 		= [] ;
	airlineArr 		= [] ;
	var popupWindow ;

	
	function child_open(tBookId,lstUpDt,grpTrvlFlag)
	{	
		//LoadModalDiv();
		//popupWindow.focus();
		
		var	date  			= $('#dt_date').val();
		var	siteId  		= $('#selectUnit').val();
		var	travellerId 	= $('#traveller').val();
		var	travelType 		= $('#travelType').val();		                		
		var	reqNo  			= $('#requisitioNo').val();
		var	status  		= $('#status').val();
		var	bookedBy  		= $('#bookedBy').val();
		var	reportType  	= $('#reportType').val();
	    var travelStatus 	= $('#travelStatus').val();
		
	    var url = 'Single_PersonnelBooking.jsp';
	    if(grpTrvlFlag == 'Y') {
	    	
	    	url = 'Group_PersonnelBooking.jsp';
	    	popupWindow = window.open('./'+url+'?travelBookingId='+tBookId+'&latestUpdatedDate='+lstUpDt+'&travelStatus='+travelStatus+'&date='+date+'&siteId='+siteId+'&travellerId='+travellerId+'&travelType='+travelType+'&reqNo='+reqNo+'&status='+status+'&bookedBy='+bookedBy+'&reportType='+reportType,'_self','scrollbars=yes, resizable=no,width=1000,height=650');
	    	
	    } else if(grpTrvlFlag == 'N') {

	    	url = 'Single_PersonnelBooking.jsp';
	    	popupWindow = window.open('./'+url+'?travelBookingId='+tBookId+'&latestUpdatedDate='+lstUpDt+'&travelStatus='+travelStatus+'&date='+date+'&siteId='+siteId+'&travellerId='+travellerId+'&travelType='+travelType+'&reqNo='+reqNo+'&status='+status+'&bookedBy='+bookedBy+'&reportType='+reportType,'_self','scrollbars=yes, resizable=no,width=1000,height=650');
	    	
	    } else {
	    	alert('Error occured while fetching requisition data.');
	    }
		
	}
	function LoadModalDiv()
    {	var body = document.body;
		var html = document.documentElement;
		
		var height = $(document).height();
		var width = $(document).width();
		
        var bcgDiv = document.getElementById("divBackground");
        bcgDiv.style.height=height;
        bcgDiv.style.width=width;
        bcgDiv.style.display="block";
    }
	function HideModalDiv()
    {  var bcgDiv = document.getElementById("divBackground");
       bcgDiv.style.display="none";
    }
	function MM_openBrWindow(theURL,winName,features) 
	{	window.open(theURL,winName,features);
	}
	
	function showTravellerName(strTrvType,strTrvId, strTrvRequestNo)
	{
		if(strTrvType=='I')
			strTrvType="INT";
		else
			strTrvType="DOM";
		var url = 'T_ShowTravellerFromGroupReqs.jsp?traveltype='+strTrvType+'&strTravelId='+strTrvId+'&strTravelRequestNo='+strTrvRequestNo+'&reportFlag=true';
		window.open(url,'DefaultApprovers','scrollbars=yes,resizable=no,width=500,height=200');
	}
	
	$( document ).ready(function() {
		var userRole	= '<%=subRole%>';
		
		if ((userRole.indexOf('TC_VISA')>=0) || (userRole.indexOf('TC_INSU')>=0) || (userRole.indexOf('TC_ACCO')>=0) || (userRole.indexOf('TC_TICK')>=0) || (userRole.indexOf('TC_ADMI')>=0))
		{	$.ajax({
			       url: "BookingStatusReport",
			       type:'POST',
			       dataType: "json",
			       data : {
			           action : 'bookingStatus' // will be accessible in $_POST['data1']
			       }
			   }).done(function(response) {
			   		bokkingStatusArr = response;
			   		for(var i=0; i<bokkingStatusArr.length; i++){
			   			$("#status").append("<option value='"+bokkingStatusArr[i].Id+"'>"+bokkingStatusArr[i].Name+"</option>");
			   		}
			});
		
			$.ajax({
			       url: "BookingStatusReport",
			       type:'POST',
			       dataType: "json",
			       data : {
			           action : 'countrylist' // will be accessible in $_POST['data1']
			       }
			   }).done(function(response) {
				   countryArr = response;
		    });
				
			$.ajax({
			       url: "BookingStatusReport",
			       type:'POST',
			       dataType: "json",
			       data : {
			           action : 'airLineList' // will be accessible in $_POST['data1']
			       }
			   }).done(function(response) {
				   airlineArr = response;
			});
				
			$.ajax({
			       url: "BookingStatusReport",
			       type:'POST',
			       dataType: "json",
			       data : {
			           action : 'bookingBy' // will be accessible in $_POST['action']
			       }
			   }).done(function(response) {
				   bokkingByArr = response;
			   		for(var i=0; i<bokkingByArr.length; i++){
			   			$("#bookedBy").append("<option value='"+bokkingByArr[i].Id+"'>"+bokkingByArr[i].Name+"</option>");
			   		}
			   		initializeJsGrid();
		   	});
			
			var siteIdVal = '<%=etx_siteId%>';
			getTravellerList(siteIdVal);
			
			
			$("select#selectUnit").change(function() {		
				var siteId = $("select#selectUnit option:selected").val();
				getTravellerList(siteId);
			});
		}else if (userRole == '' || userRole == 'null')
		{	$('[name=frm]').html("<div style='text-align:center;color:red;'><h1><br/><br/><br/><br/><br/><span><b>You are not Authorized to see this information.</b></span></h1></div>");
		}
		
		var strMessage  = '<%=strMsg%>';
		if(strMessage != '') {
			var strHtml = '';
			if(strMessage.indexOf('success') > -1) {
				strHtml = '<font color="#008000">'+strMessage+'</font>';
			
			} else if(strMessage.indexOf('fail') > -1) {
				strHtml = '<font color="red">'+strMessage+'</font>';
			}
			$('span#message').html(strHtml);
			
			blinkMessage(10000, 500);
			
			setTimeout(function() { 
				$('span#message').html('');
			}, 10000);
		}
	});
	
	function blinkMessage(time, interval) {
	    var timer = window.setInterval(function(){
	    	$('span#message').show();
	        window.setTimeout(function(){
	        	$('span#message').hide();
	        }, 700);
	    }, interval);
	    
	    window.setTimeout(function(){	
	    	clearInterval(timer);
	    }, time);
	}
	
	function getTravellerList(siteId) {	
		$("#traveller").find('option:gt(0)').remove();
		$.ajax({
		       url: "BookingStatusReport",
		       type:'POST',
		       dataType: "json",
		       data : {
		           action : 'travellerList', // will be accessible in $_POST['action']
				   siteId : siteId
		       },
		       async:false
		   }).done(function(response) {			   
		   		$("#traveller").append(response.travellerHtml);	 
		   	 	
		   });
	}
	
	function expToExcel(){
		var action 			= 'exportToExcel'; 
		var	date  			= $('#dt_date').val();
		var	siteId  		= $('#selectUnit').val();
		var	travellerId 	= $('#traveller').val();
		var	travelType 		= $('#travelType').val();		                		
		var	reqNo  			= $('#requisitioNo').val();
		var	status  		= $('#status').val();
		var	bookedBy  		= $('#bookedBy').val();
		var	reportType  	= $('#reportType').val();
		var el 				= document.getElementById('reportType');
	    var selectedReportType = el.options[el.selectedIndex].innerHTML;
	   
	    var travelStatus 	= $('#travelStatus').val();
	    
	    if (reportType == "0" || reportType == null)
	    {	alert("Please Select Report Type");
	    	return false;
	    }
	    else
	    {	window.open('./ExportBookingStatusReport?action='+action+'&travelStatus='+travelStatus+'&date='+date+'&siteId='+siteId+'&travellerId='+travellerId+'&travelType='+travelType+'&reqNo='+reqNo+'&status='+status+'&bookedBy='+bookedBy+'&reportType='+reportType+'&selectedReportType='+selectedReportType, '_self','scrollbars=yes, resizable=yes,top=280,left=350,width=1,height=1');
	    }	
		
	}
	function detailRequest(trvlType,trvlrId,trvlId,grpTrvlFlag,trvlAgencyId) 
	{   
		if(grpTrvlFlag==null) 
		{	grpTrvlFlag="N";
 		}
          
		if(grpTrvlFlag!=null  &&  (grpTrvlFlag == 'Y'))
		{	
			if(trvlType == "I")
			{
				if(trvlAgencyId != null && trvlAgencyId == 2)
				{	 strUrl = "Group_T_TravelRequisitionDetails_GmbH.jsp";
				}else
				{	strUrl = "Group_T_TravelRequisitionDetails.jsp";
				}
			}
			else if(trvlType == "D")
			{
				if(trvlAgencyId != null && trvlAgencyId == 2)
				{	 strUrl = "Group_T_TravelRequisitionDetails_GmbH.jsp";
				}else
				{	strUrl = "Group_T_TravelRequisitionDetails_D.jsp";
				}
			}
		}
		else
		{	
			if(trvlType == "I")
			{
				if(trvlAgencyId != null && trvlAgencyId == 2)
				{	strUrl = "T_TravelRequisitionDetails_INT_GmbH.jsp";
				}
				else
				{	strUrl = "T_TravelRequisitionDetails.jsp";
				}
			}
			else if(trvlType == "D")
			{
				if(trvlAgencyId != null && trvlAgencyId == 2)
				{	strUrl = "T_TravelRequisitionDetails_INT_GmbH.jsp";
				}
				else
				{	strUrl = "T_TravelRequisitionDetails_D.jsp";
				}
			}
			
		}
        window.open(strUrl+'?purchaseRequisitionId='+trvlId+'&traveller_Id='+trvlrId+'&travelType='+trvlType+'&reportFlag=true','POLICY','scrollbars=yes,resizable=yes,width=1000,height=650');
 	}      

			
	function initializeJsGrid(){
		
		 $("#traveller").val('<%=etx_travellerId%>');
         $("#travelType").val('<%=etx_travelType%>');
         $("#bookedBy").val('<%=etx_bookedBy%>');
         $("#status").val('<%=etx_status%>');
         $("#reportType").val('<%=etx_reportType%>');
         
         $("#travelStatus").val('<%=etx_travelStatus%>');
         
		var MyDateField = function(config) {
	        jsGrid.Field.call(this, config);
	    };
	 
	    MyDateField.prototype = new jsGrid.Field({
	        sorter: function(date1, date2) {
	            return new Date(date1) - new Date(date2);
	        },
	        itemTemplate: function(value) {
	        	if(value == undefined || value == ''){
	            	return '';
	            }else{
	            	//return $.datepicker.formatDate('dd/mm/yy', new Date(value));
	            	return value;
	            }
	        },
	        insertTemplate: function(value) {
	            return this._insertPicker = $("<input>").datepicker({ defaultDate: new Date(), dateFormat: 'dd/mm/yy' });
	        },
	        editTemplate: function(value) {
	        	if(value == undefined || value == ''){
	        		return this._editPicker = $("<input>").datepicker({ defaultDate: new Date(), dateFormat: 'dd/mm/yy' }).datepicker("setDate", new Date());
	        	}else{
	            	return this._editPicker = $("<input>").datepicker({ defaultDate: new Date(), dateFormat: 'dd/mm/yy' }).datepicker("setDate",$.datepicker.formatDate('dd/mm/yy', new Date(value)));
	        	}
	        },
	        insertValue: function() {
	            return this._insertPicker.datepicker("getDate").toString();
	        },
	        editValue: function() {
	            return $.datepicker.formatDate('dd/mm/yy', new Date(this._editPicker.datepicker("getDate")));
	        }
	    });
	    
	    var MyTimeField = function(config) {
	        jsGrid.Field.call(this, config);
	    };
	    
	    MyTimeField.prototype = new jsGrid.Field({
	        sorter: "String",
	        itemTemplate: function(value) {
	        	if(value == undefined){
	            	return '';
	            }else{
	            	return value;
	            }
	        },
	        insertTemplate: function(value) {
	            return this._insertPicker =  $('<input>').timepicker({ defaultTime: new Date() });
	        },
	        editTemplate: function(value) {
	        	if(value == undefined){
	        		return this._editPicker = $('<input>').timepicker();
	        	}else{
	            	return this._editPicker = $('<input>').timepicker().timepicker("setTime", value);
	        	}
	        },
	        insertValue: function() {
	        	  return this._insertPicker.timepicker()[0].value;
	        },
	        editValue: function() {
	        	return this._editPicker.timepicker()[0].value;
	        }
	    });
	    
	    var MyCostField = function(config) {
	        jsGrid.Field.call(this, config);
	    };
	    
	    var currentItem = {};
	    MyCostField.prototype = new jsGrid.Field({
	        sorter: "String",
	        itemTemplate: function(value, item) {
	        	
	        	if(value == undefined){
	            	return '';
	            }else{
	            	return value;
	            }
	        },
	        insertTemplate: function(value) {
	            return this._insertPicker =  $('<input>').attr('type','number');
	        },
	        editTemplate: function(value, item) {
	        	currentItem = item;
	        	if(value == undefined){
	        		return this._editPicker = $('<input>').attr('type','number');
	        	}else{
	        		var input =  $('<input>').attr('type','number');
	        		input.attr('value',value);
	            	return this._editPicker = input;
	        	}
	        },
	        insertValue: function() {
	        	  return this.insertControl.value;
	        },
	        editValue: function() {
	        	return this.editControl.value;
	        }
	    });
	    
	    var MySNoField = function(config) {
	        jsGrid.Field.call(this, config);
	    };
	    
	    var recordCount = 0; 
	    MySNoField.prototype = new jsGrid.Field({
	        sorter: "number",
	        itemTemplate: function(value, item) {
	        	recordCount = (parseInt(recordCount)+1);
	        	if(value == undefined || value == ''){
	        		return recordCount;
	        	}
	        	return value;
	        },
	        insertTemplate: function(value) {
	            return this._insertPicker =  value;
	        },
	        editTemplate: function(value, item) {
	        	return this._editPicker = value;
	        },
	        insertValue: function() {
	        	  return this.insertControl.value;
	        },
	        editValue: function() {
	        	return this.editControl.value;
	        }
	    });
	    
	    var MyLinkField = function(config) {
	        jsGrid.Field.call(this, config);
	    };
	    
	    var recordCount = 0; 
	    MyLinkField.prototype = new jsGrid.Field({
	        sorter: "number",
	        itemTemplate: function(value, item) {
	        	return value;
	        },
	        insertTemplate: function(value) {
	            return this._insertPicker =  value;
	        },
	        editTemplate: function(value, item) {
	        	return this._editPicker = value;
	        },
	        insertValue: function() {
	        	  return this.insertControl.value;
	        },
	        editValue: function() {
	        	return this.editControl.value;
	        }
	    });
	   
	    jsGrid.fields.myDateField = MyDateField;
	    jsGrid.fields.mytimeField = MyTimeField;
	    jsGrid.fields.myCostField = MyCostField;
	    jsGrid.fields.sNoField 	  = MySNoField;
	    jsGrid.fields.linkField   = MyLinkField;
	    var unEditableFields = 'travellerName,siteName,itenary,DOB';
	
	    $("#jsGrid").jsGrid({
			        height: "63%",
			        width: "100%",
			        filtering: false,
			        editing: true,
			        sorting: true,
			        paging: true,
			        autoload: true,
			        pageSize: 10,
			        pageButtonCount: 5,
			        deleteConfirm: "Do you really want to delete the client?",
			        controller: {
			            loadData: function() {
			                var d = $.Deferred();
			                $.ajax({
			                    url: "BookingStatusReport",
			                    type:'POST',
			                    dataType: "json",
			                    data : {
			                        action : 'load', // will be accessible in $_POST['action']
			                		date  : $('#dt_date').val(),
			                		siteId  : $('#selectUnit').val(),
			                		travellerId  : $('#traveller').val(),
			                		travelType  : $('#travelType').val(),		                		
			                		reqNo  : $('#requisitioNo').val(),
			                		status  : $('#status').val(),
			                		bookedBy  : $('#bookedBy').val(),
			                		travelStatus : $('#travelStatus').val()
			                    }
			                }).done(function(response) {
			                    d.resolve(response.value);
			                });
			                return d.promise();
			            }
			        },
					editRowRenderer: function(item, itemIndex){
			        	var $result = $("<tr>").addClass(this.editRowClass);
						item.isAllowedToEdit = true;
						this._eachField(function(field) {
								field.editing=false;
								$("<td>").addClass(field.editcss || field.css).addClass(field.align == '' ? '' : ("jsgrid-align-" + field.align))
								.appendTo($result)
								.append(field.editTemplate ? field.editTemplate(item[field.name], item) : "")
								.width(field.width || "auto");
						});
						return $result;
			        },
			        fields: [
			            { title: "SITE ID",name: "site_id", type: "text",css: "hide"},
			            { title: "LOCK_BY_ME",name: "isLockedByMe", type: "text",css: "hide"},
			            { title: "U_DATE",name: "latestUpdatedDate", type: "text",css: "hide"},
			            { title: "LOCKED_USER_ID",name: "lockedUserId", type: "text",css: "hide"},
			            { title: "TRAVEL BOOK ID",name: "travel_booking_id", type: "text",css: "hide"},
			            { type: "control",headerTemplate: function() { return '<font color="#f8805c"><i>Action</i></font>'; },modeSwitchButton: false, deleteButton: false, align :"center" ,
			            	lockButton: false ,keyButton: false , width: 33,
			            	itemTemplate: function(value, item) 
			            	{
			            		 var $result = $([]);
			            		 item.action = 'LOCK';
			            		 //console.log(item);
			            		 if(item.isLockedByMe)
			            		 {	 return this._createGridButton('jsgrid-lock-button', 'Click to Lock record', function(grid, e) {
			            				//alert("item.travel_booking_id:"+item.travel_booking_id);
			            				child_open(item.travel_booking_id,item.latestUpdatedDate,item.grpTrvlFlag);
			            				reloadGrid();
			            			 });
			            			 $result = $result.add(lockBtn);
			            		 }
			            		 else if(!item.isLocked && !item.lockFlag)
			            		 {	 if(this.editButton) 
			            			 {	return this._createGridButton('jsgrid-key-button', 'Click to Lock record', function(grid, e) {
						     	               updateItem(item);
						     	               reloadGrid();
						    			});
		           		                $result = $result.add(unlockBtn);
		           		             }
			            		}
			            		else if(!item.isLocked && item.lockFlag && ((item.lockedUserId == '<%=Suser_id%>')))
			            		{	return this._createGridButton('jsgrid-lock-button', 'Click to Lock record', function(grid, e) {
			            				//updateItem(item);
			            				child_open(item.travel_booking_id,item.latestUpdatedDate,item.grpTrvlFlag);
			            				reloadGrid();
			            			});
			                 		$result = $result.add(unlockBtn);
			            		}
			            		else if(item.isLocked && item.lockFlag && ((item.lockedUserId == '<%=Suser_id%>')))
			            		{	return this._createGridButton('jsgrid-lock-button', 'Click to Lock record', function(grid, e) {
			            				child_open(item.travel_booking_id,item.latestUpdatedDate,item.grpTrvlFlag);
			            				reloadGrid();
				            		});
			                 		$result = $result.add(unlockBtn);
			            		}
			            		else if(item.isLocked || item.lockFlag)
			            		{	$result = $result.add("<span style='color:red;' title='Locked by other user'>Locked</span>");
			            		}
			            		return $result;
			            	},
			            	editTemplate: function(value, item) 
			            	{
			            		item.action = 'LOCK';
			            	   	if(!item.isLocked && !item.lockFlag)
			            	   	{	var fieldsShowInEditMode = '';
				            		item.showFieldsInEditMode = fieldsShowInEditMode;
				            		return this._createGridButton('jsgrid-key-button', 'Click to Lock record', function(grid, e) {
				            			updateItem(item);
				            			reloadGrid();
				    				});
		            		   	}
			            	   	else if(item.isLockedByMe)
			            	   	{	if(this.editButton) 
			            	   		{	return this._createGridButton('jsgrid-lock-button', 'Click to Lock record', function(grid, e) {
			            					child_open(item.travel_booking_id,item.latestUpdatedDate,item.grpTrvlFlag);
			            					reloadGrid();
					    				});
	           		             	}
		            		 	}
			            	   	else if(!item.isLocked && item.lockFlag && ((item.lockedUserId == '<%=Suser_id%>')))
			            	   	{	return this._createGridButton('jsgrid-lock-button', 'Click to Lock record', function(grid, e) {
			            				//updateItem(item);
			            				child_open(item.travel_booking_id,item.latestUpdatedDate,item.grpTrvlFlag);
			            				reloadGrid();
			            			});
		            			}
			            	   	else if(item.isLocked && item.lockFlag && ((item.lockedUserId == '<%=Suser_id%>')))
			            	   	{	return this._createGridButton('jsgrid-lock-button', 'Click to Lock record', function(grid, e) {
			            				child_open(item.travel_booking_id,item.latestUpdatedDate,item.grpTrvlFlag);
			            				reloadGrid();
			            			});
		                 			$result = $result.add(unlockBtn);
		            			}
			            	   	else if(item.isLocked || item.lockFlag)
			            	   	{	var $result = $([]);
		            				return $result = $result.add("<span style='color:red;' title='Locked by other user'>Locked</span>");
		            			}
			            	}  
			            },
			            { title: "<font color='#515151'>S No.</font>",name: "sNo", type: "sNoField", editing :false ,sorting: true, width: 33, align:"center"},
			            { title: "<font color='#515151'>Requisition No.</font>",name: "travel_req_no", type: "linkField",  editing :false, sorting: false,width: 250, 
			            	itemTemplate: function(value, item) 
			            	{
                                var $result = $([]);
                                var trvlType	= '"'+item.travel_type+'"';
                                var trvlId		= item.travel_id;
                                var trvlrId		= item.traveller_id;
                                var grpTrvlFlag = '"'+item.grpTrvlFlag+'"';
                                var trvlAgencyId= item.trvlAgencyId;
                                var grpTrvlFlag = '"'+item.grpTrvlFlag+'"';
                                                                
                                if (value.toLowerCase() === ("Personal").toLowerCase())
                               	{	$result = $result.add("<span style='color:#9f32fa;'>"+('<%=dbLabelBean.getLabel("label.personnelbooking.personal",strsesLanguage)%>').toUpperCase()+"</span>");
                               	}
                                else if (value.toLowerCase() === ("Miscellaneous").toLowerCase())
                               	{	$result = $result.add("<span style='color:black;'>"+('<%=dbLabelBean.getLabel("label.personnelbooking.miscellaneous",strsesLanguage)%>').toUpperCase()+"</span>");
                               	}
                                else if (value.indexOf("/PERSONAL") >= 0)
                               	{	$result = $result.add("<span style='color:#1b8122;'>"+value+"</span>");
                               	}
                                else
                                {	if (item.grpTrvlFlag.toLowerCase() == ('Y').toLowerCase())
	                               	{	$result = $result.add("<a href=# onClick='detailRequest("+trvlType+","+trvlrId+","+trvlId+","+grpTrvlFlag+","+trvlAgencyId+");' style='color:#1c84d9;text-decoration:none;cursor:pointer;' title='Click to See the Requisition details'><img src='images/grpIcon-blue.png?buildstamp=2_0_0' border='0'> "+value+"</a>");
	                               	}
	                                else
	                                {	$result = $result.add("<a href=# onClick='detailRequest("+trvlType+","+trvlrId+","+trvlId+","+grpTrvlFlag+","+trvlAgencyId+");' style='color:red;text-decoration:none;cursor:pointer;' title='Click to See the Requisition details'><img src='images/userIcon-Collaborator-15.png?buildstamp=2_0_0' border='0'> "+value+"</a>");
	                                }
                                }
                                return $result;
                       		},
                     		editTemplate: function(value, item) 
                     		{
                         		var $result = $([]);
                         		var trvlType	= '"'+item.travel_type+'"';
                                var trvlId		= item.travel_id;
                                var trvlrId		= item.traveller_id;
                                var grpTrvlFlag = '"'+item.grpTrvlFlag+'"';
                                var trvlAgencyId= item.trvlAgencyId;
                                 
                                if (value.toLowerCase() === ("Personal").toLowerCase())
                               	{	$result = $result.add("<span style='color:#9f32fa;'>"+('<%=dbLabelBean.getLabel("label.personnelbooking.personal",strsesLanguage)%>').toUpperCase()+"</span>");
                               	}
                                else if (value.toLowerCase() === ("Miscellaneous").toLowerCase())
                               	{	$result = $result.add("<span style='color:black;'>"+('<%=dbLabelBean.getLabel("label.personnelbooking.miscellaneous",strsesLanguage)%>').toUpperCase()+"</span>");
                               	}
                         		else if (value.indexOf("/PERSONAL") >= 0)
                               	{	$result = $result.add("<span style='color:#1b8122;'>"+value+"</span>");
                               	}
                                else
                              	{	if (item.grpTrvlFlag.toLowerCase() == ('Y').toLowerCase())
	                               	{	$result = $result.add("<a href=# onClick='detailRequest("+trvlType+","+trvlrId+","+trvlId+","+grpTrvlFlag+","+trvlAgencyId+");' style='color:#1c84d9;text-decoration:none;cursor:pointer;' title='Click to See the Requisition details'><img src='images/grpIcon-blue.png?buildstamp=2_0_0' border='0'> "+value+"</a>");
	                               	}
	                                else
	                                {	$result = $result.add("<a href=# onClick='detailRequest("+trvlType+","+trvlrId+","+trvlId+","+grpTrvlFlag+","+trvlAgencyId+");' style='color:red;text-decoration:none;cursor:pointer;' title='Click to See the Requisition details'><img src='images/userIcon-Collaborator-15.png?buildstamp=2_0_0' border='0'> "+value+"</a>");
	                                }
                              	}
                         		return $result;
                			}
			            },
			            { title: "<font color='#515151'>Site Name</font>",name: "siteName", type: "text",editing :false ,sorting: false, css: "hide"},
			            { title: "<font color='#515151'>Travel Date</font>",name: "Travel_Date",type: "text",align: "center", editing :false ,sorting: true, width: 80},
			            { title: "<font color='#515151'>Traveller / Originator</font>",name: "travellerName", type: "text",editing :false ,sorting: false, width: 140,
			            	itemTemplate: function(value, item) 
			            	{
                                var $result 	= $([]);
                                var trvlType	= '"'+item.travel_type+'"';
                                var trvlId		=     item.travel_id;
                                var grpTrvlFlag = '"'+item.grpTrvlFlag+'"';
                                var trvlReqNo 	= '"'+item.travel_req_no+'"';
                                
                                if (grpTrvlFlag.toLowerCase() == ('\"Y\"').toLowerCase())
                               	{	$result = $result.add("<a href=# onClick='showTravellerName("+trvlType+","+trvlId+","+trvlReqNo+");' style='color:#1c84d9;text-decoration:none;cursor:pointer;' title='Click to See the Travellers list'><img src='images/grpIcon-blue.png?buildstamp=2_0_0' border='0'>&nbsp;"+value+"</a>");
                               	}
                                else
                                {	$result = $result.add("<span style='color:black;'>"+value+"</span>");
                                }
                                return $result;
                       		},
                     		editTemplate: function(value, item) 
                     		{
                     			var $result 	= $([]);
                                var trvlType	= '"'+item.travel_type+'"';
                                var trvlId		=     item.travel_id;
                                var grpTrvlFlag = '"'+item.grpTrvlFlag+'"';
                                var trvlReqNo 	= '"'+item.travel_req_no.replace('/','~')+'"';
                                
                                if (grpTrvlFlag.toLowerCase() == ('\"Y\"').toLowerCase())
                               	{	$result = $result.add("<a href=# onClick='showTravellerName("+trvlType+","+trvlId+","+trvlReqNo+");' style='color:#1c84d9;text-decoration:none;cursor:pointer;' title='Click to See the Travellers list'><img src='images/grpIcon-blue.png?buildstamp=2_0_0' border='0'>&nbsp;"+value+"</a>");
                               	}
                                else
                                {	$result = $result.add("<span style='color:black;'>"+value+"</span>");
                                }
                                return $result;
                			}
			            },
			            { title: "<font color='#515151'>Mobile No.</font>",name: "MOBILE_NO", type: "text",align: "right",editing :false ,sorting: false, width:120},
			            { title: "<font color='#515151'>Requisition Status</font>",name: "Status_Flags", type: "text",editing :false,sorting: false, width: 240},
			            { title: "<font color='#515151'>Last Modified On</font>",name: "latestUpdatedDate",align: "center", type: "text",editing :false ,sorting: false, width: 110,
			            	itemTemplate: function(value, item) 
			            	{
                                var $result = $([]);
                                var parts	= [];
                                var tmp1	= (item.latestUpdatedDate).substring(0,10);
                                parts		= tmp1.split('-');
                                var lstModDt= parts[2]+'/'+parts[1]+'/'+parts[0]+'  '+(item.latestUpdatedDate).substring(11,16);
                                
                                $result = $result.add("<label>"+lstModDt+"</label>");
                                return $result;
                       		},
                     		editTemplate: function(value, item)
                     		{
                     			var $result = $([]);
                                var parts	= [];
                                var tmp1	= (item.latestUpdatedDate).substring(0,10);
                                parts		= tmp1.split('-');
                                var lstModDt= parts[2]+'/'+parts[1]+'/'+parts[0]+'  '+(item.latestUpdatedDate).substring(11,16);
                                $result = $result.add("<label>"+lstModDt+"</label>");
                                return $result;
                			}	
			            },
			            { title: "<font color='#515151'>Locked By</font>",name: "locked_by_name", type: "text",sorting: false,editing :false, width: 70}
			        ]
			    });
			}
			
		function reloadGrid(){
			$("#jsGrid").jsGrid("loadData").done(function() {
			});
		}
</script>
	
<script type="text/javascript">

function updateItem(item){
	
    	if(item.action == 'LOCK'){
			item.bookedBy='<%=Suser_id%>';
			item.bkgStatus=0;
    	}
    		item.fieldDataArr = {};
        	var d = $.Deferred();
             $.ajax({
                url: "BookingStatusReport",
                type:'POST',
                dataType: "json",
                data : {
                    action : 'update' // will be accessible in $_POST['action'],
                    ,item : JSON.stringify(item)
                }
            }).done(function(response) {
            	var statusCode = response.STATUS;
            	if(parseInt(statusCode) == 0){
                	d.resolve(response);
                	recordCount = 0;
               		$("#jsGrid").jsGrid("loadData");
               		
               		var	date  			= $('#dt_date').val();
            		var	siteId  		= $('#selectUnit').val();
            		var	travellerId 	= $('#traveller').val();
            		var	travelType 		= $('#travelType').val();		                		
            		var	reqNo  			= $('#requisitioNo').val();
            		var	status  		= $('#status').val();
            		var	bookedBy  		= $('#bookedBy').val();
            		var	reportType  	= $('#reportType').val();
            	    var travelStatus 	= $('#travelStatus').val();
            	    
            	    var url = 'Single_PersonnelBooking.jsp';
            	    if(item.grpTrvlFlag == 'Y'){
            	    	
            	    	url = 'Group_PersonnelBooking.jsp';
            	    	window.open('./'+url+'?travelBookingId='+item.travel_booking_id+'&latestUpdatedDate='+item.latestUpdatedDate+'&travelStatus='+travelStatus+'&date='+date+'&siteId='+siteId+'&travellerId='+travellerId+'&travelType='+travelType+'&reqNo='+reqNo+'&status='+status+'&bookedBy='+bookedBy+'&reportType='+reportType,'_self','scrollbars=yes, resizable=no,width=1500,height=650');
            	    
            	    } else if(item.grpTrvlFlag == 'N'){
            	    	
            	    	url = 'Single_PersonnelBooking.jsp';
            	    	window.open('./'+url+'?travelBookingId='+item.travel_booking_id+'&latestUpdatedDate='+item.latestUpdatedDate+'&travelStatus='+travelStatus+'&date='+date+'&siteId='+siteId+'&travellerId='+travellerId+'&travelType='+travelType+'&reqNo='+reqNo+'&status='+status+'&bookedBy='+bookedBy+'&reportType='+reportType,'_self','scrollbars=yes, resizable=no,width=1500,height=650');
            	    
            	    } else {
            	    	alert('Error occured while fetching requisition data.');
            	    }

            	}else if(parseInt(statusCode) == -50001){
            		d.resolve(item);
            		alert('Something went wrong. Please contact STARS support team.');
            	}else if(parseInt(statusCode) == -50002){
            		var result = confirm('You can not lock this record either lock is acquired by someone else or record data is not updated.\nSo click Ok to refresh records.');
            		if(result){
            			recordCount = 0;
            			$("#jsGrid").jsGrid("loadData");
            		}
            		d.resolve(item);
            	}else{
            		alert('Something went wrong. Please contact STARS support team.');
            	}
            	reloadGrid();
            }); 
          
}
    function validate(depDate, arrDate) {

        var format = 'dd/MM/yyyy';

       
        if(isBeforeCurrentDate(depDate, format)) {
            alert('Departure date cannot be less than current date.');
            return false;
        } 
        if(isBeforeCurrentDate(arrDate, format)) {
            alert('Arrival date cannot be less than current date.');
            return false;
        }
      
        if (isBefore(depDate, arrDate, format)) {
            alert('Departure date cannot be greater than Arrival date.');
            return false;
        } 
        
        if (isAfter(depDate, arrDate, format)) {
            alert('Arrival date cannot be less than Departure date.');
            return false;
        } 
        
        if (!isDate(depDate, format)) {
        	 alert('Please enter a valid departure date(dd/mm/yyyy).');
        	 return false;
        } 
        
        if (!isDate(arrDate, format)) {
	       	 alert('Please enter a valid arrival date(dd/mm/yyyy).');
	       	 return false;
	    } 
        
        return true;
    }

    /**
     * This method gets the year index from the supplied format
     */
    function getYearIndex(format) {

        var tokens = splitDateFormat(format);

        if (tokens[0] === 'YYYY'
                || tokens[0] === 'yyyy') {
            return 0;
        } else if (tokens[1]=== 'YYYY'
                || tokens[1] === 'yyyy') {
            return 1;
        } else if (tokens[2] === 'YYYY'
                || tokens[2] === 'yyyy') {
            return 2;
        }
        // Returning the default value as -1
        return -1;
    }

    /**
     * This method returns the year string located at the supplied index
     */
    function getYear(date, index) {

        var tokens = splitDateFormat(date);
        return tokens[index];
    }

    /**
     * This method gets the month index from the supplied format
     */
    function getMonthIndex(format) {

        var tokens = splitDateFormat(format);

        if (tokens[0] === 'MM'
                || tokens[0] === 'mm') {
            return 0;
        } else if (tokens[1] === 'MM'
                || tokens[1] === 'mm') {
            return 1;
        } else if (tokens[2] === 'MM'
                || tokens[2] === 'mm') {
            return 2;
        }
        // Returning the default value as -1
        return -1;
    }

    /**
     * This method returns the month string located at the supplied index
     */
    function getMonth(date, index) {

        var tokens = splitDateFormat(date);
        return tokens[index];
    }

    /**
     * This method gets the date index from the supplied format
     */
    function getDateIndex(format) {

        var tokens = splitDateFormat(format);

        if (tokens[0] === 'DD'
                || tokens[0] === 'dd') {
            return 0;
        } else if (tokens[1] === 'DD'
                || tokens[1] === 'dd') {
            return 1;
        } else if (tokens[2] === 'DD'
                || tokens[2] === 'dd') {
            return 2;
        }
        // Returning the default value as -1
        return -1;
    }

    /**
     * This method returns the date string located at the supplied index
     */
    function getDate(date, index) {

        var tokens = splitDateFormat(date);
        return tokens[index];
    }

    /**
     * This method returns true if date1 is before date2 else return false
     */
    function isBefore(date1, date2, format) {
        // Validating if date1 date is greater than the date2 date
        if (new Date(getYear(date1, getYearIndex(format)), 
                getMonth(date1, getMonthIndex(format)) - 1, 
                getDate(date1, getDateIndex(format))).getTime()
            > new Date(getYear(date2, getYearIndex(format)), 
                getMonth(date2, getMonthIndex(format)) - 1, 
                getDate(date2, getDateIndex(format))).getTime()) {
            return true;
        } 
        return false;                
    }

    /**
     * This method returns true if date1 is after date2 else return false
     */
    function isAfter(date1, date2, format) {
        // Validating if date2 date is less than the date1 date
        if (new Date(getYear(date2, getYearIndex(format)), 
                getMonth(date2, getMonthIndex(format)) - 1, 
                getDate(date2, getDateIndex(format))).getTime()
            < new Date(getYear(date1, getYearIndex(format)), 
                getMonth(date1, getMonthIndex(format)) - 1, 
                getDate(date1, getDateIndex(format))).getTime()
            ) {
            return true;
        } 
        return false;                
    }

    /**
     * This method returns true if date1 is equals to date2 else return false
     */
    function isEquals(date1, date2, format) {
        // Validating if date1 date is equals to the date2 date
        if (new Date(getYear(date1, getYearIndex(format)), 
                getMonth(date1, getMonthIndex(format)) - 1, 
                getDate(date1, getDateIndex(format))).getTime()
            === new Date(getYear(date2, getYearIndex(format)), 
                getMonth(date2, getMonthIndex(format)) - 1, 
                getDate(date2, getDateIndex(format))).getTime()) {
            return true;
        } 
        return false;
    }

    /**
     * This method validates and returns true if the supplied date is 
     * equals to the current date.
     */
    function isCurrentDate(date, format) {
        // Validating if the supplied date is the current date
        if (new Date(getYear(date, getYearIndex(format)), 
                getMonth(date, getMonthIndex(format)) - 1, 
                getDate(date, getDateIndex(format))).getTime()
            === new Date(new Date().getFullYear(), 
                    new Date().getMonth(), 
                    new Date().getDate()).getTime()) {
            return true;
        } 
        return false;                
    }

    /**
     * This method validates and returns true if the supplied date value 
     * is before the current date.
     */
    function isBeforeCurrentDate(date, format) {
        // Validating if the supplied date is before the current date
        if (new Date(getYear(date, getYearIndex(format)), 
                getMonth(date, getMonthIndex(format)) - 1, 
                getDate(date, getDateIndex(format))).getTime()
            < new Date(new Date().getFullYear(), 
                    new Date().getMonth(), 
                    new Date().getDate()).getTime()) {
            return true;
        } 
        return false;                
    }

    /**
     * This method validates and returns true if the supplied date value 
     * is after the current date.
     */
    function isAfterCurrentDate(date, format) {
        // Validating if the supplied date is before the current date
        if (new Date(getYear(date, getYearIndex(format)), 
                getMonth(date, getMonthIndex(format)) - 1, 
                getDate(date, getDateIndex(format))).getTime()
            > new Date(new Date().getFullYear(),
                    new Date().getMonth(), 
                    new Date().getDate()).getTime()) {
            return true;
        } 
        return false;                
    }

    /**
     * This method splits the supplied date OR format based 
     * on non alpha numeric characters in the supplied string.
     */
    function splitDateFormat(dateFormat) {
        // Spliting the supplied string based on non characters
        return dateFormat.split(/\W/);
    }

    /*
     * This method validates if the supplied value is a valid date.
     */
    function isDate(date, format) {                
        // Validating if the supplied date string is valid and not a NaN (Not a Number)
        if (!isNaN(new Date(getYear(date, getYearIndex(format)), 
                getMonth(date, getMonthIndex(format)) - 1, 
                getDate(date, getDateIndex(format))))) {                    
            return true;
        } 
        return false;                                      
    }
    
    function validateHhMm(inputField, flag) {
    	var isValid = false;
        isValid = /^([0-1]?[0-9]|2[0-4]):([0-5][0-9])(:[0-5][0-9])?$/.test(inputField);

        if(!isValid) {
        	if(flag === 'depTime') {
        		alert("Please enter the valid departure time.");
        	} else if(flag === 'arrTime') {
        		alert("Please enter the valid arrival time.");
        	}
        	
        	return false;
        }

        return isValid;
    }
</script>
	</form>
  </body>
</html>
<script type="text/javascript">

var chkReadyState = setInterval(function() {
    if (document.readyState == "complete") {
        clearInterval(chkReadyState);
        
        var dataExistsFlag	='<%=dataExistsFlag%>';
		if(dataExistsFlag=="false"){
			 alert('<%=dbLabelBean.getLabel("alert.report.nodataforexporttoexcel",strsesLanguage)%>');
		}
    }
}, 1000);	
</script>