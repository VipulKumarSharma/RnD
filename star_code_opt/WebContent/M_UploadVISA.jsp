
<%@ page pageEncoding="UTF-8" %>
<%@ include  file="importStatement.jsp" %>
<%@ include  file="cacheInc.inc" %>
<%@ include  file="headerIncl.inc" %>
<%@ include  file="application.jsp" %>
	
<html>
<head>
	<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
	<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>

	<link type="text/css" rel="stylesheet" href="scripts/main.css?buildstamp=2_0_0">
	
	<link type="text/css" rel="stylesheet" href="style/jquery-ui-1.9.2.css?buildstamp=2_0_0" >
	<link type="text/css" rel="stylesheet" href="jquery-datepicker/jquery.datepick.css?buildstamp=2_0_0">
	<style type="text/css">
		.datepick-nav, .datepick-ctrl {
			font-size: 70%;
		}
		.datepick-month-header select, .datepick-month-header input {
			font-size: 70%;
		}
		.datepick-month table {
			font-size: 80%;
		}
		.datepick-month table span {
			font-size: 75%;
		}
	</style>
	
	<script type="text/javascript" language="JavaScript" src="ScriptLibrary/jQueryMaster.js?buildstamp=2_0_0" ></script>
	<script type="text/javascript" language="JavaScript" src="ScriptLibrary/jquery-1.8.3.js?buildstamp=2_0_0" ></script>
	<script type="text/javascript" language="JavaScript" src="ScriptLibrary/jquery-ui-1.9.2.js?buildstamp=2_0_0" ></script>
	
	<script type="text/javascript" language="JavaScript" src="jquery-datepicker/jquery.plugin.js?buildstamp=2_0_0" ></script>
	<script type="text/javascript" language="JavaScript" src="jquery-datepicker/jquery.datepick.js?buildstamp=2_0_0" ></script>

<%
	request.setCharacterEncoding("UTF-8");
	String sSqlStr			= "";
	String strDivisionName  = "";
	String strDivId			= "";
	
	String strmessage		= request.getParameter("message")==null?"":request.getParameter("message");
	String strflag			= request.getParameter("flag")==null?"no":request.getParameter("flag");
	String strUserId  		= request.getParameter("userid")==null?Suser_id:request.getParameter("userid");
	String whichPage  		= request.getParameter("whichPage")==null?"":request.getParameter("whichPage");
	String strUserVisaId	= request.getParameter("userVisaId")==null	? "" :request.getParameter("userVisaId").trim();
	
	String strVisaCountry	= "0";
	String strVisaIssuDate	= "";
	String strVisaValidFrom	= "";
	String strVisaValidTo	= "";
	String strVisaDuration	= "0 Day(s)";
	String strDurationVal	= "0";
	String strDurationType	= "Day(s)";
	
	//System.out.println("strUserId--->"+strUserId);
	if (!"".equalsIgnoreCase(strUserVisaId)) {
		String query	= "SELECT ISNULL((select COUNTRY_NAME from M_COUNTRY where COUNTRY_ID=M_USERVISA.VISA_COUNTRY),'-') AS COUNTRY_NAME, M_USERVISA.VISA_COUNTRY, dbo.CONVERTDATEDMY1(VISA_ISSUANCE_DATE) AS VISA_ISSUANCE_DATE, dbo.CONVERTDATEDMY1(VISA_VALID_FROM) AS VISA_VALID_FROM, dbo.CONVERTDATEDMY1(VISA_VALID_TO) AS VISA_VALID_TO, isnull(VISA_STAY_DURATION,'0 Days') AS VISA_STAY_DURATION FROM M_USERVISA WHERE USERID= "+strUserId+" AND USER_VISA_ID="+strUserVisaId;
		ResultSet rs 	= dbConBean.executeQuery(query);
		
		while(rs.next()) {
			strVisaCountry		= rs.getString("VISA_COUNTRY") == null ? "0" : rs.getString("VISA_COUNTRY").trim();
			strVisaIssuDate		= rs.getString("VISA_ISSUANCE_DATE") == null ? "-" : rs.getString("VISA_ISSUANCE_DATE").trim();
			strVisaValidFrom	= rs.getString("VISA_VALID_FROM") == null ? "-" : rs.getString("VISA_VALID_FROM").trim();
			strVisaValidTo		= rs.getString("VISA_VALID_TO") == null ? "-" : rs.getString("VISA_VALID_TO").trim();
			strVisaDuration		= rs.getString("VISA_STAY_DURATION") == null ? "0 Day(s)" : rs.getString("VISA_STAY_DURATION").trim();
			
			strDurationVal		= strVisaDuration.split(" ")[0];
			strDurationType		= strVisaDuration.split(" ")[1];
		}
		rs.close();
	}
%>	
	<script type="text/javascript">
		function initializeFutureDate(elId) {
	   		$(elId).datepick({
	   			minDate: new Date(),	
	   			dateFormat: 'dd/mm/yyyy',
	   			changeMonth: true,
	   			changeYear: true,
	   			yearRange: "-100:+30",
	   			onSelect: function(dateText, inst) { $(this).css('color', '#000000'); }
	   		}).click(function () { $(elId).focus(); });	
	   	}
	   	function initializePastDate(elId) {
	   		$(elId).datepick({
	   			maxDate: new Date(),	
	   			dateFormat: 'dd/mm/yyyy',
	   			changeMonth: true,
	   			changeYear: true,
	   			yearRange: "-100:+30",
	   			onSelect: function(dateText, inst) { $(this).css('color', '#000000'); }
	   		}).click(function () { $(elId).focus(); });	
	   	}
	   	
	   	function initializeDate(elId) {
			$(elId).datepick({
			    dateFormat: 'dd/mm/yyyy',
			    changeMonth: true,
			    changeYear: true,
			    yearRange: "-100:+30",
			    onSelect: function(dateText, inst) { $(this).css('color', '#000000'); }
			}).click(function () { $(elId).focus(); });	
		}
	   	
		function showMessage() {
			alert('<%=dbLabelBean.getLabel("label.requestdetails.pleaseclickonbrowsebuttontoupload",strsesLanguage) %>');
		}
		
		function openWaitingProcess(spanTxt) {
			$("body").css("overflow","hidden");
			$('#pleaseWait').html(spanTxt);
			
			var height 	= $(document).height();
			var width 	= $(document).width();
			
	        var bcgDiv 	= document.getElementById("divBackground");
	        var dv 		= document.getElementById("waitingData");
	        
	        bcgDiv.style.height=height;
	        bcgDiv.style.width=width;
	        bcgDiv.style.display="block";
			
			if(dv != null)
			{
				var xpos = screen.width * 0.16;
				var ypos = screen.height * 0.18;   
				
				dv.style.position="absolute";       		
				dv.style.left=(xpos)+"px";
				dv.style.top=(ypos)+"px";
				document.getElementById("waitingData").style.display="";
				document.getElementById("waitingData").style.visibility="";
			}
		}
		
		function closeDivRequest() {
			document.getElementById("divBackground").style.visibility="hidden";	
		}
		
		function test(obj, length, str) {
			if(str=='n.') {
				upToTwoDecimal(obj);
			}
			
			charactercheck(obj,str);
			limitlength(obj, length);
			spaceChecking(obj);
		}
		
		function checkdata() {
			
			var visaCountry 		= document.getElementById("visaCountry");
			var visaIssuanceDate 	= document.getElementById("visaIssuanceDate");
			var visaValidFrom 		= document.getElementById("visaValidFrom");
			var visaValidTo 		= document.getElementById("visaValidTo");
			var visaDurVal	 		= document.getElementById("visaDurVal");
			var visaDurType			= document.getElementById("visaDurType");
			
			if(visaCountry.value == '0' || visaCountry.value == '') {
				alert('Please select Visa Country.');
				visaCountry.focus();
				return false;
			}
			if(visaIssuanceDate.value == '') {
				alert('Please enter Visa Issuance Date.');
				visaIssuanceDate.focus();
				return false;
			}
			if(visaValidFrom.value == '') {
				alert('Please enter Visa Valid From Date.');
				visaValidFrom.focus();
				return false;
			}
			if(visaValidTo.value == '') {
				alert('Please enter Visa Valid To Date.');
				visaValidTo.focus();
				return false;
			}
			if(visaDurVal.value == '0' || visaDurVal.value == '') {
				alert('Please enter Visa Duration.');
				visaDurVal.focus();
				return false;
			}
			
			var z=document.myform.file.value;
			if(z=='') {
				alert('<%=dbLabelBean.getLabel("label.requestdetails.pleaseselectfile",strsesLanguage) %>');
				document.myform.file.focus();
				return false;
			}
		
			var var_index=z.lastIndexOf(".");
			var var_substring=z.substring(var_index+1,z.length);
			if(var_substring=='pdf' || var_substring=='doc' || var_substring=='docx' || var_substring=='xls' || var_substring=='xlsx' || var_substring=='ppt' || var_substring=='pptx' || var_substring=='txt' || var_substring=='gif' || var_substring=='jpeg' || var_substring=='jpg' || var_substring=='html' || var_substring=='zip'|| var_substring=='png') {
				
			} else {
				alert('<%=dbLabelBean.getLabel("label.requestdetails.pleaseuploadfileswithdocxlspptgiftxtziponly",strsesLanguage)%>');
				return false;
			}
			
			if(confirm('<%=dbLabelBean.getLabel("label.requestdetails.areyousurewanttouploadthisdocument",strsesLanguage) %>')) {
				document.getElementById("upload_but").disabled=true;
				
				var userId		= <%=strUserId%>;
				var whichPage	= '<%=whichPage%>';
				var visaDur 	= visaDurVal.value+" "+visaDurType.value;
				
				document.myform.action = 'M_UploadVISAPost.jsp?userid='+userId+'&visaCountry='+visaCountry.value+'&visaIssuanceDate='+visaIssuanceDate.value+'&visaValidFrom='+visaValidFrom.value+'&visaValidTo='+visaValidTo.value+'&visaDur='+visaDur+'&whichPage='+whichPage;
				openWaitingProcess('Please wait... <br>File is uploading');
				myform.submit();
				
				return true;
			
			} else {
				return false;
			}
			
			//document.getElementById("upload_but").disabled=true;
			//return true;
		}
	</script>

</head>
<!-- Start of body -->

<script>
	function showlink(var_flag, whichPage){
		if(whichPage != 'reqCreationPage' && var_flag=='yes') {
			window.opener.location.reload();
		}
	}
</script>

<body onload="showlink('<%=strflag %>','<%=whichPage %>')" onunload="showlink('<%=strflag %>','<%=whichPage %>')">
	<script type="text/javascript" language="JavaScript1.2" src="menu/menu_cnt.js?buildstamp=2_0_0"></script>
	
	<table width="100%" border="0" cellspacing="0" cellpadding="0" >
	  	<tr>
		    <td height="32" class="bodyline-top">
				<ul class="pagebullet">
			      <li class="pageHead"><%=dbLabelBean.getLabel("label.visa.uploadvisa",strsesLanguage) %></li>
			    </ul>
			</td>	
		
			<td height="32" align="right" valign="bottom" class="bodyline-top">
				<table align="right" border="0" cellspacing="0" cellpadding="0">
			      	<tr align="right">
			      		<td align="right">
			       			<ul id="list-nav">
			      	 			<li><a href="#" onclick="window.close();" ><%=dbLabelBean.getLabel("button.global.close",strsesLanguage) %></a></li>
			       			</ul>
			       		</td>
			      	</tr>
			    </table>
			</td>
	  	</tr>
	  	
	  	<tr>
	  		<td colspan="2" class="formhead" align=center><font color=red><%=dbLabelBean.getLabel("label.global.pleaseuploadfiles",strsesLanguage) %></font></td>
	 	</tr>
	</table>
	
	<form enctype="multipart/form-data" name="myform" id="myform" method="POST" onsubmit="return checkdata();">
		
		<div id="divBackground" style="position: absolute; z-index: 99; height: 100%; width: 100%; top: 0; left: 0; background-color: Black; filter: alpha(opacity = 60); opacity: 0.6; -moz-opacity: 0.8; display: none">
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
		
  		<table width="100%" align="center" border="0" cellspacing="0" cellpadding="0">
  			<tr align="left"> 
  				<td class="formtr3" width="30%" style="text-align: right;">Visa <%=dbLabelBean.getLabel("label.user.country",strsesLanguage)%></td>
			    <td width="50%" class="formtr2" style="text-align: left;">
			  		<select name="visaCountry" id="visaCountry" class="textBoxCss" style="width:47%;margin-left: 10px;" title="<%=dbLabelBean.getLabel("label.user.country",strsesLanguage)%>">
						<option value="0"><%=dbLabelBean.getLabel("label.createrequest.visacountry",strsesLanguage)%></option>
				<%
					ResultSet rSet 	= dbConBean.executeQuery("SELECT COUNTRY_ID, COUNTRY_CODE, COUNTRY_NAME FROM M_COUNTRY WHERE STATUS_ID=10 AND APPLICATION_ID=1 ORDER BY COUNTRY_NAME");
					while(rSet.next()) {
				%>		<option value="<%=rSet.getString("COUNTRY_ID")%>"><%=rSet.getString("COUNTRY_NAME")%></option>
				<%	    
					}
					rSet.close();
				%>	</select>
					<script type="text/javascript">
						document.myform.visaCountry.value="<%=strVisaCountry%>";
					</script>
			  	</td>
  			</tr>
  			
  			<tr align="left">
  				<td class="formtr3" width="30%" style="text-align: right;"><%=dbLabelBean.getLabel("label.global.visa",strsesLanguage)%> <%=dbLabelBean.getLabel("label.personnelbooking.visaissuancedate",strsesLanguage)%></td>
			  	<td width="50%" class="formtr2" style="text-align: left;">
					<input type="text" name="visaIssuanceDate" id="visaIssuanceDate" style="width:48%;margin-left: 10px;" class="textBoxCss" placeholder="DD/MM/YYYY"  
						   onFocus="initializeDate(this);" value="<%=strVisaIssuDate%>">
			   	</td>
  			</tr>
     		
     		<tr align="left">
  				<td class="formtr3" width="30%" style="text-align: right;"><%=dbLabelBean.getLabel("label.personnelbooking.visavalidfrom",strsesLanguage)%></td>
			  	<td width="50%" class="formtr2" style="text-align: left;">
					<input type="text" name="visaValidFrom" id="visaValidFrom" style="width:48%;margin-left: 10px;" class="textBoxCss" placeholder="DD/MM/YYYY"  
						   onFocus="initializeDate(this);" value="<%=strVisaValidFrom%>"> 
			   	</td>
  			</tr>
  			
  			<tr align="left">
  				<td class="formtr3" width="30%" style="text-align: right;"><%=dbLabelBean.getLabel("label.personnelbooking.visavalidto",strsesLanguage)%></td>
			  	<td width="50%" class="formtr2" style="text-align: left;">
					<input type="text" name="visaValidTo" id="visaValidTo" style="width:48%;margin-left: 10px;" class="textBoxCss" placeholder="DD/MM/YYYY"  
						   onFocus="initializeFutureDate(this);" value="<%=strVisaValidTo%>">
			   	</td>
  			</tr>
  			
  			<tr align="left">
  				<td class="formtr3" width="30%" style="text-align: right;"><%=dbLabelBean.getLabel("label.visa.stayduration",strsesLanguage)%></td>
			  	<td width="50%" class="formtr2" style="text-align: left;">
					<input type="text" name="visaDurVal" id="visaDurVal" class="textBoxCss" style="width:12%;margin-left: 10px;" value="<%=strDurationVal%>" onKeyUp="return test(this, 30, 'n.')" maxlength="5">
					<select name="visaDurType" id="visaDurType" class="textBoxCss" style="width:34%;margin-left: 1px;">
						<option value="Day(s)">Day(s)</option>
						<option value="Month(s)">Month(s)</option>
						<option value="Year(s)">Year(s)</option>
					</select>
					<script type="text/javascript">
						document.myform.visaDurType.value="<%=strDurationType%>";
					</script>
			   	</td>
  			</tr>
  			
     		<tr align="left">
		      	<td class="formtr3" width="30%" style="text-align: right;"><%=dbLabelBean.getLabel("label.requestdetails.selectdocument",strsesLanguage) %></td>
		      	<td width="45%" class="formtr2" style="text-align: left;">
		      		<input type=file name="file" class="textBoxCss" style="margin-left: 10px;width:72%;" size=34 onKeyDown="showMessage();" onKeyPress="blur();">
		      	</td>
		    </tr>
    		
    		<tr align="left" style="padding-top: 10px;">
  				<td class="" style="text-align: center;font-size: 13px;" colspan="2">
		      		<input type=submit id="upload_but" name="but_upload" class="formButton" value="<%=dbLabelBean.getLabel("label.requestdetails.upload",strsesLanguage)%>">
		      	</td>
  			</tr>
  			
    		<tr style="padding-top: 10px;">
		   		<td colspan="2" style="color:#009f50;font-family:arial,helvetica,sans-serif;font-size: 11px;font-weight: bold;text-align: center;"><%=strmessage %></td>
		    </tr>
  		</table>
 	</form>
 
 	<script language="javaScript">
		closeDivRequest();
	</script>
	
</body>
</html>
