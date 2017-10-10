
<%
	/***********************************************************************************************
	 *The information contained here in is confidential and 
	 * proprietary to MIND and forms the part of the MIND 
	 *Author									:Shiv Sharma 
	 *Date of Creation 				:25 Apr 2008
	 *Copyright Notice 				:Copyright(C)2000 MIND.All rights reserved
	 *Project	  								:STAR
	 *Operating environment	:Tomcat, sql server 2000 
	 *Description 						:     This is first jsp file  for Showing reports of Requisitions which in workflow  
	 *Modification 						: 
	 *Reason of Modification	:   
	 *Date of Modification			:
	 *Revision History				:
	 *Editor								
	
	 *Modified By				:	Manoj Chand
	 *Date of Modification		:	20 june 2012
	 *Modification				:	add two checkbox for show billing site and transit days
	
	 *Modified By				:	Manoj Chand
	 *Date of Modification		:	02 July 2012
	 *Modification				:	provide back button in travel report
	 ******************************************************************************************************/
%>
<%@ page pageEncoding="UTF-8"%>
<%@ include file="importStatement.jsp"%>

<html>
<head>
<%-- include remove cache  --%>
<%@ include file="cacheInc.inc"%>
<%-- include header  --%>
<%@ include file="headerIncl.inc"%>
<%-- include page with all application session variables --%>
<%@ include file="application.jsp"%>
<!--Create the DbConnectionBean object for createConnection-->
<jsp:useBean id="dbConBean" scope="page"
	class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbLabelBean" scope="page"
	class="src.connection.LabelRepository" />


<!--Create the DbUtilityMethods object for utility methods-->
<jsp:useBean id="dbUtility" scope="page"
	class="src.connection.DbUtilityMethods" />

<%-- include page styles  --%>
<%-- <%@ include  file="systemStyle.jsp" %> --%>


<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet"
	type="text/css" />
<script language="JavaScript"
	src="ScriptLibrary/date-picker.js?buildstamp=2_0_0"></script>
<SCRIPT language=JavaScript
	src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<script language="JavaScript"
	src="scripts/CommonValida.js?buildstamp=2_0_0"></script>
<script language=JavaScript
	src="ScriptLibrary/jQueryMaster.js?buildstamp=2_0_0"></script>
<script type="text/javascript"
	src="ScriptLibrary/jquery-1.8.3.js?buildstamp=2_0_0"></script>

<script language="javascript">
	$.noConflict();
	jQuery(document).ready(function($) {
	
		var dv = document.getElementById("waitingData");
		if(dv != null) {
			var xpos = screen.availHeight/2+90;
			var ypos = screen.availWidth/2-180;   
			
			dv.style.position="absolute";       		
			dv.style.left=(xpos+10)+"px";
			dv.style.top=(ypos)+"px";
		}
		
		$("#SelectUnit").change(function() {
			document.getElementById("waitingData").style.display="";
	     		var reqpage="showReportData";
		  	var siteId = $("#SelectUnit option:selected").val();
		 	var Params='<%="language1=" + strsesLanguage + "&suserRole=" + SuserRole
					+ "&useridooo=" + Suser_id%>';
	           var urlParams=Params+"&reqpageooo="+reqpage+"&siteIdooo="+siteId;
			$.ajax({
		            type: "post",
		            url: "AjaxMaster.jsp",
		            data: urlParams,
		            success: function(result){
					var res = jQuery.trim(result);
					$("#username").html('');
	            	$("#username").html(res);
	            },
	            complete: function(){
	            	document.getElementById("waitingData").style.display="none";
	            	},
				error: function(){
					alert('<%=dbLabelBean.getLabel("label.global.jqueryerror",
					strsesLanguage)%>');
	            }
	        });
		});
		
    });
	      
	function checkDate1()
	{
	    if(document.frm.SelectUnit.value=="-1") {
			alert('<%=dbLabelBean.getLabel("alert.global.unitname",
						strsesLanguage)%>');
			document.frm.SelectUnit.focus();
			return false;
		}
	
		if(document.frm.from.value=="") {
			alert('<%=dbLabelBean.getLabel("alert.report.pleaseselectfromdate", strsesLanguage)%>');
			document.frm.from.focus();
			return false;
		}
		if(document.frm.to.value=="") {
			alert('<%=dbLabelBean.getLabel("alert.report.pleaseselecttodate", strsesLanguage)%>');
			document.frm.to.focus();
			return false;
		}
		
	   	if(checkDateme(document.frm,document.frm.from.value,document.frm.to.value,document.frm.from,document.frm.to,'<%=dbLabelBean.getLabel("message.report.fromdatecannotbegreaterthantodate",strsesLanguage)%>','')==false) {
	     	return false;
		}
	 	return true;
	}
	
	function getDivisonID() {
	 	document.frm.action="T_traveldateWiseReport.jsp"; 
		document.frm.submit();
	}
	
	function fun_setvalue() {
		var x = document.getElementById("chk_billingsite").checked;
		if(x){
			document.getElementById("chk_billingsite").value='y';
		}
	}
	
	function fun_setvalue1() {
		var x = document.getElementById("chk_transitdays").checked;
		if(x){
			document.getElementById("chk_transitdays").value='y';
		}
	}
	
	function fun_setvalue2() {
		var x = document.getElementById("chk_travelClass").checked;
		if(x){
			document.getElementById("chk_travelClass").value='y';
		}
	}
	function fun_setvalue3() {
		var x = document.getElementById("chk_tes").checked;
		if(x){
			document.getElementById("chk_tes").value='y';
		}
	}
	function fun_setvalue4() {
		var x = document.getElementById("chk_co").checked;
		if(x){
			document.getElementById("chk_co").value='y';
		}
	}
	function openWaitingProcess() {
		$("body").css("overflow","hidden");
		var height 	= $(document).height();
		var width 	= $(document).width();
		
	    var bcgDiv 	= document.getElementById("divBackground");
	    var dv = document.getElementById("waitingData");
	    
	    bcgDiv.style.height=height;
	    bcgDiv.style.width=width;
	    bcgDiv.style.display="block";
		
		if(dv != null) {
			var xpos = screen.width * 0.43;
			var ypos = screen.height * 0.22;   
			
			dv.style.position="absolute";       		
			dv.style.left=(xpos)+"px";
			dv.style.top=(ypos)+"px";
			document.getElementById("waitingData").style.display="";
			document.getElementById("waitingData").style.visibility="";	
		}
	}
	
	function confirmData() {
		var flag = checkDate1();
		if (flag) {
			document.frm.action="T_travelDateWiseReportPost.jsp";
			openWaitingProcess();
			frm.submit();
		}
	}
</script>
</head>
<body>
	<script type="text/javascript" language="JavaScript1.2"
		src="menu/menu_cnt.js?buildstamp=2_0_0"></script>
	<div id="divBackground"
		style="position: absolute; z-index: 99; height: 100%; width: 100%; top: 0; left: 0; background-color: Black; filter: alpha(opacity = 60); opacity: 0.6; -moz-opacity: 0.8; display: none">
		<div id="waitingData" style="display: none;">
			<center>
				<img src="images/loader.gif?buildstamp=2_0_0" width="60" height="60" />
				<br> <br> 
				<font color="#ffffff" style="font-size: 15px; font-weight: bold; font-family: Verdana, Arial, Helvetica, sans-serif;">
					<span id="pleaseWait">Please wait ...<br>while data is loading.</span>
				</font>
			</center>
		</div>
	</div>
	<table width="100%" align="center" border="0" cellpadding="5" cellspacing="0">
		<tr>
			<td width="90%" height="35" class="bodyline-top">
				<ul class="pagebullet">
					<li class="pageHead"><%=dbLabelBean.getLabel("label.report.starsreporttravelreport", strsesLanguage)%></li>
				</ul>
			</td>
			<td width="10%" height="35" style="vertical-align: bottom;" class="bodyline-top" nowrap="nowrap">
				<ul id="list-nav" style="text-align: right;">
				<li><a href="javascript: void(0)" onclick="popup('T_EmployeeWiseLocationReport.jsp')">My Team Location</a></li>
				</ul>
			</td>
		</tr>
	</table>
	<%
		String strFrom 			= request.getParameter("from1");
		String strTo 			= request.getParameter("to1");
		String strTravelType 	= request.getParameter("travelType1") == null ? "A" : request.getParameter("travelType1");
		String userID 			= request.getParameter("username1") == null ? "0" : request.getParameter("username1");
		String strBillingSite 	= request.getParameter("chk_billingsite1") == null ? "n": request.getParameter("chk_billingsite1");
		String strTransitDays 	= request.getParameter("chk_transitdays1") == null ? "n" : request.getParameter("chk_transitdays1");
		String strTravelClass 	= request.getParameter("chk_travelClass1") == null ? "n" : request.getParameter("chk_travelClass1");
		String strTES 			= request.getParameter("chk_tes") == null ? "n" : request.getParameter("chk_tes");
		String strCO 			= request.getParameter("chk_co") == null ? "n" : request.getParameter("chk_co");
		String strCurr 			= request.getParameter("currency") == null ? "1" : request.getParameter("currency");
		String strTravelStatus 	= (request.getParameter("travelStatus") == null || request.getParameter("travelStatus").equals("2,3,4,6,10")) ? "1" : request.getParameter("travelStatus");
		String strHidCurr		= (request.getParameter("hidCurrency") == null || request.getParameter("hidCurrency").equals("")) ? "INR" : request.getParameter("hidCurrency");
		String Site_ID 			= (request.getParameter("SelectUnit") == null) ? "-1" : request.getParameter("SelectUnit");
		
		//System.out.println("MAIN PAGE:: "+strTES+", "+strCO+", "+strCurr+", "+strTravelStatus);
		/*System.out.println("strFrom---->"+strFrom);
		 System.out.println("strTo---->"+strTo);
		 System.out.println("strTravelType---->"+strTravelType);
		 System.out.println("userID---->"+userID);
		 System.out.println("strBillingSite---->"+strBillingSite);
		 System.out.println("strTransitDays---->"+strTransitDays);*/

		SimpleDateFormat sdf 	= new java.text.SimpleDateFormat("dd/MM/yyyy");
		String strCurrDate 		= sdf.format(new java.util.Date());
		SimpleDateFormat sdfY 	= new java.text.SimpleDateFormat("yyyy");
		String strYear 			= sdfY.format(new java.util.Date());

		Date currentDate 		= new Date();
		SimpleDateFormat sdfnew = new SimpleDateFormat("dd/MM/yyyy");
		String strCurrentDatenew= (sdfnew.format(currentDate)).trim();

		String strSql 					= "";
		ResultSet rs 					= null;
		String strUserid 				= "";
		String strFName 				= "";
		String strLName 				= "";
		
		String strCreationDateBefore 	= "";
		String strCreationDateAfter 	= "";
		
		String strCurrDatenewBefore 	= "";
		String strCurrDatenewAfter 		= "";

		rs = dbConBean.executeQuery("SELECT  convert(varchar(20),getdate()-30,103) as beforeDate, convert(varchar(20),getdate()+30,103) as AfterDate");
		while (rs.next()) {
			strCurrDatenewBefore 	= rs.getString("beforeDate"); // date before 30 days from current date 
			strCurrDatenewAfter 	= rs.getString("AfterDate"); // date before 30 days from current date
		}
		rs.close();
		
		if (strFrom != null) {
			strCurrDatenewBefore = strFrom;
		}
		if (strTo != null) {
			strCurrDatenewAfter = strTo;
		}
	%>

	<table width="95%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder" style="margin-top:3px;">
		<form name="frm" method=post action="T_travelDateWiseReportPost.jsp">

			<tr class="formtr2">
				<td class="formtr2" style="width:50%;"><%=dbLabelBean.getLabel("label.requestdetails.unit",
					strsesLanguage)%></td>
				<td class="formtr1" style="width:50%;">
					<select name="SelectUnit" id="SelectUnit" class="textboxCSS" style="width:30%;">
						<option value="-1"><%=dbLabelBean.getLabel("label.report.selectunit", strsesLanguage)%></option>
						<%
							ArrayList aList = dbUtility.findReportSiteListForUser(SuserRole,SuserRoleOther, strSiteIdSS, Suser_id, strsesLanguage);
							Iterator itr = aList.iterator();
							while (itr.hasNext()) {
						%>
						<option value=<%=itr.next()%>><%=itr.next()%></option>
						<%	} %>
					</select> 
					
					<script language="javascript">
						document.frm.SelectUnit.value ="<%=Site_ID%>";
					</script>
				</td>
			</tr>

			<tr align="left">
				<td class="formtr2" style="width:50%;"><%=dbLabelBean.getLabel("label.report.personname",
					strsesLanguage)%></td>
				<td class="formtr1" style="width:50%;">
					<select name="username" id="username" class="textboxCSS" style="width:30%;">
						<option value="0"><%=dbLabelBean.getLabel("label.report.allperson", strsesLanguage)%></option>
						<%
							/*
							if(SuserRole.equals("AD")){   //for all  site 
							strSql="SELECT  USERID, FIRSTNAME, LASTNAME  FROM   M_USERINFO WHERE  (STATUS_ID = 10) order by 2"; 

							}else{  			 //by this query user will show only those recodes who belonge to user logged site  
							strSql="SELECT  USERID, FIRSTNAME, LASTNAME  FROM   M_USERINFO WHERE site_id="+Site_ID+" and  (STATUS_ID = 10) order by 2";  
							}*/

							if (!Site_ID.equals("0")) {
								strSql = "SELECT  USERID, FIRSTNAME, LASTNAME  FROM   M_USERINFO WHERE site_id="
										+ Site_ID + " and  (STATUS_ID = 10) order by 2";
							} else {
								strSql = "SELECT  USERID, FIRSTNAME, LASTNAME  FROM   M_USERINFO WHERE   (STATUS_ID = 10) order by 2";
							}

							rs = dbConBean.executeQuery(strSql);

							while (rs.next()) {
								strUserid = rs.getString("USERID");
								strFName = rs.getString("FIRSTNAME");
								strLName = rs.getString("LASTNAME");
						%>
						<option value="<%=strUserid%>"><%=strFName%><%=strLName%></option>
						<%	}
							rs.close();
						%>
					</select>
				<script language="javascript">
					document.frm.username.value ="<%=userID%>";
				</script>
				</td>
			</tr>
			<tr align="left">
				<td class="formtr2" style="width:50%;"><%=dbLabelBean.getLabel("label.report.traveltype",strsesLanguage)%></td>
				<td class="formtr1" style="width:50%;">
					<SELECT name="travelType" class="textBoxCss" style="width:30%;">
						<OPTION value="A"><%=dbLabelBean.getLabel("label.search.all", strsesLanguage)%></OPTION>
						<OPTION value="I"><%=(ssflage.equals("3") ? "Intercont" : dbLabelBean.getLabel("label.report.international", strsesLanguage))%></OPTION>
						<OPTION value="D"><%=(ssflage.equals("3") ? "Domestic/Europe" : dbLabelBean.getLabel("label.report.domestic", strsesLanguage))%></OPTION>
					</SELECT>
					<script language="javascript">
						document.frm.travelType.value ="<%=strTravelType%>";
					</script>
				</td>
			</tr>
			
			<tr align="left">
				<td class="formtr2" style="width:50%;">Travel Status</td>
				<td class="formtr1" style="width:50%;">
					<select name="travelStatus" id="travelStatus" class="textboxCSS" style="width:30%;">
						<option value="1">All</option>
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
					<script language="javascript">
						document.frm.travelStatus.value ="<%=strTravelStatus%>";
					</script>
				</td>
			</tr>
			
			<tr align="left">
				<td class="formtr2" style="width:50%;">Currency</td>
				<td class="formtr1" style="width:50%;">
					<select name="currency" id="currency" class="textboxCSS" style="width:30%;">
				<%		strSql = "select CUR_ID,CUR_CODE from M_CURRENCY where STATUS_ID=10;";
						rs = dbConBean.executeQuery(strSql);

						while (rs.next()) {
				%>		<option value="<%=rs.getString("CUR_ID").trim()%>"><%=rs.getString("CUR_CODE").trim()%></option>
				<%		}
						rs.close();
						%>
					</select>
				<script language="javascript">
					document.frm.currency.value ="<%=strCurr%>";
				</script>
				</td>
			</tr>
			
			<tr align="left">

				<td class="formtr2" style="width:50%;"><%=dbLabelBean.getLabel("label.report.departuredatefrom",
					strsesLanguage)%></td>
				<td class="formtr1" style="width:50%;"><input type=textbox name="from" size='10'
					maxlength="10" class="textBoxCss"
					onFocus="javascript:vDateType='DD/MM/YYYY'"
					onKeyUp="DateFormat(this,this.value,event,false,'DD/MM/YYYY','Invalid Date.Please Re-Enter')"
					onBlur="DateFormat(this,this.value,event,true,'DD/MM/YYYY','Invalid Date.Please Re-Enter')"
					value="<%=strCurrDatenewBefore%>"
					onChange="javascript:while(''+this.value.charAt(this.value.length-1)==' ')this.value=this.value.substring(0,this.value.length-1);">
					<a
					href="javascript:show_calendar('frm.from','a','a','DD/MM/YYYY');"
					onMouseOver="window.status='Date Picker';return true;"
					onMouseOut="window.status='';return true;"><img border="0"
						name="imageField" src="images/calender.png?buildstamp=2_0_0"
						align="absmiddle"> </a></td>
			</tr>
			<tr align="left">
				<td class="formtr2" style="width:50%;"><%=dbLabelBean.getLabel("label.report.departuredateto",
					strsesLanguage)%></td>
				<td class="formtr1" style="width:50%;"><input type=textbox name="to" size='10'
					maxlength="10" class="textBoxCss"
					onFocus="javascript:vDateType='DD/MM/YYYY'"
					onKeyUp="DateFormat(this,this.value,event,false,'DD/MM/YYYY','Invalid Date.Please Re-Enter')"
					onBlur="DateFormat(this,this.value,event,true,'DD/MM/YYYY','Invalid Date.Please Re-Enter')"
					value="<%=strCurrDatenewAfter%>"
					onChange="javascript:while(''+this.value.charAt(this.value.length-1)==' ')this.value=this.value.substring(0,this.value.length-1);">
					<a href="javascript:show_calendar('frm.to','a','a','DD/MM/YYYY');"
					onMouseOver="window.status='Date Picker';return true;"
					onMouseOut="window.status='';return true;"><img border="0"
						name="imageField" src="images/calender.png?buildstamp=2_0_0"
						align="absmiddle"> </a></td>
			</tr>
			<!-- added by manoj chand on 20 june 2012 to add two check box -->
			<tr align="left">
				<td class="formtr2" style="width:50%;"><%=dbLabelBean.getLabel("label.report.showbillingsite",
					strsesLanguage)%></td>
				<td class="formtr1" style="width:50%;"><input type="checkbox"
					name="chk_billingsite" value="n" onclick="return fun_setvalue();">
					<script>
						var x='<%=strBillingSite%>';
						if(x=='y') {
							document.frm.chk_billingsite.checked=true;
							document.frm.chk_billingsite.value='y';
						} else if(x=='n') {
							document.frm.chk_billingsite.checked =false;
							document.frm.chk_billingsite.value='n';
						}
					</script>
				</td>
			</tr>
			<tr align="left">
				<td class="formtr2" style="width:50%;"><%=dbLabelBean.getLabel("label.report.showtransitdays",
					strsesLanguage)%></td>
				<td class="formtr1" style="width:50%;"><input type="checkbox"
					name="chk_transitdays" value="n" onclick="return fun_setvalue1();">
					<script>
						var x='<%=strTransitDays%>';
						if(x=='y'){
							document.frm.chk_transitdays.checked=true;
							document.frm.chk_transitdays.value='y';
						} else if(x=='n'){
							document.frm.chk_transitdays.checked =false;
							document.frm.chk_transitdays.value='n';
						}
					</script>
				</td>
			</tr>
			<tr align="left">
				<td class="formtr2" style="width:50%;"><%=dbLabelBean.getLabel("label.report.showtravelclass",
					strsesLanguage)%></td>
				<td class="formtr1" style="width:50%;"><input type="checkbox"
					name="chk_travelClass" value="n" onclick="return fun_setvalue2();">
					<script>
						var x='<%=strTravelClass%>';
						if(x=='y') {
							document.frm.chk_travelClass.checked=true;
							document.frm.chk_travelClass.value='y';
						} else if(x=='n') {
								document.frm.chk_travelClass.checked =false;
								document.frm.chk_travelClass.value='n';
						}
					</script>
				</td>
			</tr>
			
			<tr align="left">
				<td class="formtr2" style="width:50%;">Show Contingencies</td>
				<td class="formtr1" style="width:50%;"><input type="checkbox" name="chk_co"
					value="n" onclick="return fun_setvalue4();"> 
					<script>
						var x='<%=strCO%>';
						if (x == 'y') {
							document.frm.chk_co.checked = true;
							document.frm.chk_co.value = 'y';
						} else if (x == 'n') {
							document.frm.chk_co.checked = false;
							document.frm.chk_co.value = 'n';
						}
					</script></td>
			</tr>
			
			<tr align="left">
				<td class="formtr2" style="width:50%;"><%=dbLabelBean.getLabel("label.report.showpendingtes",strsesLanguage)%></td>
				<td class="formtr1" style="width:50%;"><input type="checkbox" name="chk_tes"
					value="n" onclick="return fun_setvalue3();"> 
					<script>
						var x='<%=strTES%>';
						if (x == 'y') {
							document.frm.chk_tes.checked = true;
							document.frm.chk_tes.value = 'y';
						} else if (x == 'n') {
							document.frm.chk_tes.checked = false;
							document.frm.chk_tes.value = 'n';
						}
					</script></td>
			</tr>
			
			<tr align="left">
				<td class="formtr3" colspan=2 align="center">
				<input class="formbutton-red" type="button" value="<%=dbLabelBean.getLabel("label.report.viewreport",strsesLanguage)%>"
					onClick="confirmData();"></td>
			</tr>
			<input type="HIDDEN" name="UnitHidden"> 
			<input type="hidden" name="todayDate" value="<%=strCurrentDatenew%>" />
			<input type="hidden" name="hidCurrency" id="hidCurrency" value="<%=strHidCurr%>"> 
	
		<script type="text/javascript">
			$('select#currency').change(function () {
				var hidCurr = $('select#currency option:selected').text();
				$('[name=hidCurrency]').val('');
				$('[name=hidCurrency]').val(hidCurr);
			});
		</script>
		
		</form>
	</table>
</body>
</html>