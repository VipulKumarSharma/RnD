<%@ include file="importStatement.jsp"%>
	<html>
	<head>
	<%@ page pageEncoding="UTF-8" %>
	<%-- include remove cache  --%>
	<%@ include file="cacheInc.inc"%>
	<%-- include header  --%>
	<%@ include file="headerIncl.inc"%>
	
	<%-- include page with all application session variables --%>
	<%@ include file="application.jsp"%>
	<%-- include page styles  --%>
	<%-- <%@ include  file="systemStyle.jsp" %> --%>

<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
<script language="JavaScript" src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></script>
<script language="JavaScript" src="scripts/CommonValida.js?buildstamp=2_0_0"></script>
<script language="JavaScript" src="ScriptLibrary/date-picker_search.js?buildstamp=2_0_0"></script>
<script language=JavaScript src="ScriptLibrary/jQueryMaster.js?buildstamp=2_0_0"></script>
	
<% 
//String strTravelType = (String)session.getAttribute("strTravelType");
%>

<!--Create the DbConnectionBean object for createConnection-->
<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbConBean1" scope="page" class="src.connection.DbConnectionBean" />
<!--Create the DbUtilityMethods object for utility methods-->
<jsp:useBean id="dbUtility" scope="page" class="src.connection.DbUtilityMethods" />
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>

<script language="JavaScript">

function statusOnClick(f1){
	var statusValue = f1.status.value;
	
	if(statusValue != null && statusValue == "9"){
		f1.fromdate1.value="";
		f1.todate1.value="";
		f1.fromdate1.disabled=true;
		f1.todate1.disabled=true;
		document.getElementById("imageField1").style.display="none";
		document.getElementById("imageField2").style.display="none";
	} else {
		f1.fromdate1.disabled=false;
		f1.todate1.disabled=false;
		document.getElementById("imageField1").style.display="";
		document.getElementById("imageField2").style.display="";
	}	
}


function charactercheck1(val, type) {
 
   if(type=='cn')                              // cn for character and no only
   {
	mikExp = /[$\\@\\\#%\^\&\*\(\)\[\]\+\_\{\}\`\~\=\.\|\,\'\"\?\>\<\!\-\:\;]/;
   }
   if(type=='c')                              // cn for character and no only
   {
	   mikExp = /[$\\@\\\#%\^\&\*\(\)\[\]\+\_\{\}\`\~\=\.\|\,\'\"\?\/\>\<\!\-\:\;\\0\\1\\2\\3\\4\\5\\6\\7\\8\\9]/;
   }
   var strPass = val.value;
   var strLength = strPass.length; 
   //var lchar = val.value.charAt((strLength) - 1);
  // alert("length is=="+strLength); 
   if(strLength > 0)
   {
	   for(var i=0; i<strLength; i++)
	   {
		  // alert("inside for ");
		   var lchar = val.value.charAt(i); 
		   if(lchar.search(mikExp) != -1) 
           { //alert("inside for qq");
              var tst = val.value.substring(0, i);
			  var last = val.value.substring(i+1,strLength);
              val.value = tst+last;
			  i--;
		   }

	   }
   }
}

function test1(obj1, length, str) {				 
		var obj;
		if(obj1=='reqno') {
			obj = document.frm.reqno;
		}

		if(obj1=='originatedby') {
			obj = document.frm.originatedby;
		}
		if(obj1=='traveller') {
			obj = document.frm.username;
		}
		if(obj1=='papprover') {
			obj = document.frm.papprover;
		}			 
	 	if(obj1=='destination')	{
			obj = document.frm.destination; 
		}
		
		spaceChecking(obj);  
		charactercheck1(obj,str);
		limitlength(obj, length);
}

function checkFrm() {
	var a1= document.frm.reqno.value;
	var a2= document.frm.originatedby.value;
	var a3= document.frm.destination.value;
	var a4= document.frm.deptdate.value;
	
	if(a1==''  &&  a2==''  && a3=='' && a4=='' ) {
		alert('<%=dbLabelBean.getLabel("alert.search.enteranykewordforsearch",strsesLanguage)%>');
		return false;
	} else {
		document.frm.submit();
		return true;
	}
}

//function added by manoj chand on 30 jan 2013 to resolve issue coming in ie 10 browser
function findPos(obj) {
	var curleft = curtop = 0;
	if (obj.offsetParent) {
		curleft = obj.offsetLeft;
		curtop = obj.offsetTop;
		while (obj = obj.offsetParent) {
			curleft += obj.offsetLeft;
			curtop += obj.offsetTop;
		}
	}
	return curtop;
}

function resetFieldsOnSearchTypeChange(searchType){
		document.getElementById('travelType').value = 'A';
		document.getElementById('keyWordParamVal').value = '';
}

function hideshow(searchType) {
	resetFieldsOnSearchTypeChange(searchType);
	if(searchType == 'ADVANCE'){
		document.getElementById('advanceSearchDiv').style.display='block';
		document.getElementById('quickSearchDiv').style.display='none';
	}else{
		document.getElementById('quickSearchDiv').style.display='block';
		document.getElementById('advanceSearchDiv').style.display='none';
	}
 			
		if(searchType == 'ADVANCE'){
				document.getElementById('searchType').value = 'ADVANCE';
				document.getElementById('showhide').value = '<%=dbLabelBean.getLabel("label.search.showquicksearch",strsesLanguage)%>';
		}else{
				document.getElementById('searchType').value = 'QUICK';
				document.getElementById('showhide').value = '<%=dbLabelBean.getLabel("label.search.showadvancesearch",strsesLanguage)%>';
		}		

}

function closeDivRequest() {
	document.getElementById("waitingData").style.visibility="hidden";	
}

function openWaitingProcess() {
		var dv = document.getElementById("waitingData");
		if(dv != null)
		{
			var xpos = screen.availHeight/2+90;
			var ypos = screen.availWidth/2-350;   
			
			dv.style.position="absolute";       		
			dv.style.left=(xpos+10)+"px";
			dv.style.top=(ypos)+"px";
			document.getElementById("waitingData").style.display="";
			document.getElementById("waitingData").style.visibility="";	
		}
}

function write1(loadflag) {	

	var txt='';
	if(loadflag==2){
	txt=  document.getElementById("main").innerHTML	;
	txt=  document.getElementById("main").innerHTML	;
	document.frm.va.value='';
	document.frm.va.value=txt;
	document.frm.action="issue_exlWrite.jsp";
	document.frm.submit();
	}else
		alert('<%=dbLabelBean.getLabel("alert.report.nodataforexporttoexcel",strsesLanguage) %>');
}
			
			
//function created by manoj chand on 01-oct-2013 to call erp or mata can cancel request web service
function fun_callwebservice(erpwsurl,matawsurl,cid,reqno,travelid,siteid,traveltype){
	document.getElementById("waitingData").style.display="";
 	var Params='requestnumber='+reqno+'&erpurl='+erpwsurl+'&mataurl='+matawsurl+'&cid='+cid+'&actionflag=cancancelrequest&travel_id='+travelid+'&site_id='+siteid;
    var urlParams=Params;
	$.ajax({
            type: "post",
            url: "CancelTrip",
            data: urlParams,
            success: function(result){
			var res = jQuery.trim(result);
			if(res == 'yes'){
				if(confirm('<%=dbLabelBean.getLabel("alert.search.areyousure",strsesLanguage)%>')){
					var finalresult = fun_callwebservice1(erpwsurl,matawsurl,cid,reqno,travelid,siteid,traveltype);
					if(finalresult == 'TT'){
						alert('<%=dbLabelBean.getLabel("alert.search.requesthasbeencancelled",strsesLanguage)%>');
						top.main_11.frm.submit();
					}else if(finalresult == 'Error'){
						alert('Error!');
					}else{
						alert(finalresult);
					}
				}
			}else{
				alert(res);
			}
        },
        complete: function(){
        	document.getElementById("waitingData").style.display="none";
        	},
		error: function(){
			alert('<%=dbLabelBean.getLabel("label.global.jqueryerror",strsesLanguage)%>');
        }
      });
}		
//function created by manoj chand on 01-oct-2013 to call erp or mata cancel request web service 
function fun_callwebservice1(erpwsurl,matawsurl,cid,reqno,travelid,siteid,traveltype){
	document.getElementById("waitingData").style.display="";
	var flag = '';
 	var Params='requestnumber='+reqno+'&erpurl='+erpwsurl+'&mataurl='+matawsurl+'&cid='+cid+'&actionflag=cancelrequest&travel_id='+travelid+'&site_id='+siteid+'&travel_type='+traveltype;
    var urlParams=Params;
	$.ajax({
            type: "post",
            url: "CancelTrip",
            data: urlParams,
            async: false,
            success: function(result){
			var res = jQuery.trim(result);
			flag = res;
        },
        complete: function(){
        	document.getElementById("waitingData").style.display="none";
        	},
		error: function(){
			alert('<%=dbLabelBean.getLabel("label.global.jqueryerror",strsesLanguage)%>');
        }
      });
    return flag;
}		

jQuery(document).ready(function($) {

	var dv = document.getElementById("waitingData");
	if(dv != null) {
		var xpos = screen.availHeight/2+90;
		var ypos = screen.availWidth/2-350;   
		
		dv.style.position="absolute";       		
		dv.style.left=(xpos+10)+"px";
		dv.style.top=(ypos)+"px";
	}

});

</script>
<%
ArrayList aList = dbUtility.findSearchSiteListForUser(SuserRole, SuserRoleOther, strSiteIdSS, Suser_id,strsesLanguage);
Iterator itr = aList.iterator();
%>

<%
	request.setCharacterEncoding("UTF-8");
	String isMATA_GmbH = (String)hs.getValue("isMataGmbHSite");
	
	Connection objCon					=		null;	
	CallableStatement objCstmt			=		null;	
	objCon = dbConBean1.getConnection(); 	

		int iCls = 0;
		int countflag = 0; 
		String strStyleCls = "";
		String strGroupTravelFlag="";
	    String strTravelAgencyTypeId="";
	    
		String loadFlag				=  request.getParameter("flag")==null?"":request.getParameter("flag");
		String strRequstionNo       =  request.getParameter("reqno"); 
	  String  strOrigenation      =  request.getParameter("originatedby"); 
	  String strDeptdate          =  request.getParameter("deptdate"); 
	  String strDestination       =  request.getParameter("destination"); 	  
	  String strUnitNo            =  request.getParameter("SelectUnit"); 
	  String strTravler           =  request.getParameter("username"); 
	  String strCreateFromdate    =  request.getParameter("fromdate");
	  String strCreateTodate      =  request.getParameter("todate");
	  String strStatus1           =  request.getParameter("status");
	  String strPendingApprover   =  request.getParameter("papprover");
	  String strApproveFromdate   =  request.getParameter("fromdate1");
	  String strApproveTodate     =  request.getParameter("todate1");
	  String strTravelType 		  =  request.getParameter("travelType"); 
	  String searchType			  =	 request.getParameter("searchType"); 
	  String keyWordSearchVal	  =	 request.getParameter("keyWordParamVal")==null?"":request.getParameter("keyWordParamVal");;	  
	  String requestAppFlag	      =	 request.getParameter("requestAppFlag");

		String strERPWS_URL = "",strMATAWS_URL="",strCID="",strSiteId="";
	  
		if(searchType != null && searchType.equalsIgnoreCase("quick")){
		strCreateFromdate    =  request.getParameter("Qfromdate");
		strCreateTodate      =  request.getParameter("Qtodate");
		strUnitNo            =  request.getParameter("QSelectUnit"); 
	  	}
	%>	

</head>      
<body > 
<div id="waitingData" style="display:none;"> 	    
	<img src="images/loading16.gif?buildstamp=2_0_0" width="50" height="51" border="0" /> 
	<br>      
	<font color="#000080" class="pageHead"><center><%=dbLabelBean.getLabel("label.global.pleasewait",strsesLanguage) %> </center></font>    
</div>  
<%
if(loadFlag.trim().equals("2")){
%> 
<script language="javaScript">
	openWaitingProcess();
</script>
<%} %>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="40" class="bodyline-top">
		<ul class="pagebullet">
	      <li class="pageHead"><%=dbLabelBean.getLabel("label.search.searchtravelrequisitions",strsesLanguage)%></li>
	    </ul>
    </td>
    <td height="40" align="right" valign="bottom" class="bodyline-top"></td>
  </tr> 
</table>
  
<form method=post name=frm action="T_searchTravelRequisitionsNew.jsp" style="display: inline; margin: 0;">
<input type="hidden" name="flag" value="2">
<input type=hidden name="va">
<input  type="hidden" name="rad">  
<input type="hidden" name="searchType" value="QUICK"/>
<%
	SimpleDateFormat sdf              =  new java.text.SimpleDateFormat("dd/MM/yyyy");
	String strCurrDate                     = sdf.format(new java.util.Date()); 
	SimpleDateFormat sdfY            =  new java.text.SimpleDateFormat("yyyy");
	String strYear                             = sdfY.format(new java.util.Date());

	Date currentDate                       = new Date();
	SimpleDateFormat sdfnew       = new SimpleDateFormat("dd/MM/yyyy");
	String strCurrentDatenew         = (sdfnew.format(currentDate)).trim();

	String strSql                      ="";
	ResultSet  rs                     =null;
	String strUserid				  ="";
	String strFName				  ="";
	String strLName			   	  ="";
	String Site_ID 				      = (request.getParameter("SelectUnit")==null)?"0":request.getParameter("SelectUnit");


	String  strCurrDatenewBefore="";
	String  strCurrDatenewAfter="";

	  strSql="SELECT  convert(varchar(20),getdate()-30,103) as beforeDate, convert(varchar(20),getdate()+30,103) as AfterDate";
	  rs = dbConBean.executeQuery(strSql); 
	  while (rs.next())
	      {
		  strCurrDatenewBefore     =rs.getString(1); // date before 30 days from current date 
		  strCurrDatenewAfter        =rs.getString(2); // date before 30 days from current date
	       }
	   rs.close();
%>

	<table width="99%" align="center" border="0" cellpadding="0" cellspacing="0">
		<tr><td height="5px"></td></tr>
		
		<tr valign="top" id="quickSearchDiv">
			<td>
			    <table width="99%" align="center" border="0" cellpadding="3" cellspacing="1"  class="formborder">
			 	 	<tr align="left" valign="top"> 	 
			   			<td class="formtr2" align="center" ><%=dbLabelBean.getLabel("label.global.unitname",strsesLanguage)%></td>
				 		<td class="formtr2" align="center">
				 			<select name="QSelectUnit"  class="textboxCSS" >
								<%
									String siteId ="";
									String siteName ="";
									while(itr.hasNext())
											{
										siteId = itr.next().toString();
										siteName = itr.next().toString();
										
											%>
											<option value=<%=siteId%>> <%=((siteName.indexOf("Representative")>-1)?siteName.replaceAll("Representative","Rep..."):siteName)%></option>
											<%
											}					  
								%>
							</select>    
				           <script language="javascript">
							document.frm.SelectUnit.value ="<%=Site_ID%>";
							</script>
				 	</td>   
				 	 <td class="formtr2" align="left"><%=dbLabelBean.getLabel("label.global.keyword",strsesLanguage)%></td>
				 	 <td class="formtr2" align="center">
				 	 	<input type="text" name="keyWordParamVal" id="keyWordParamVal" size=20 maxlength=30 class="textBoxCss" onKeyUp="return test1('originatedby', 29, 'cn')"/>
				 	 </td>
				 	 <td class="formtr2" align="center" > <%=dbLabelBean.getLabel("label.search.createdbetween",strsesLanguage)%></td>
				 	 <td class="formtr2" align="center"> 
						<input name="Qfromdate" type="text" class="textBoxCss" id="test223" size="10" onFocus="javascript:vDateType='DD/MM/YYYY'"
													onKeyUp="DateFormat(this,this.value,event,false,'DD/MM/YYYY','Invalid Date.Please Re-Enter')"
													onBlur="DateFormat(this,this.value,event,true,'DD/MM/YYYY','Invalid Date.Please Re-Enter')"
													onChange="javascript:while(''+this.value.charAt(this.value.length-1)==' ')this.value=this.value.substring(0,this.value.length-1);"><a href="javascript:show_calendar('frm.Qfromdate','a','a','DD/MM/YYYY');"
													onMouseOver="window.status='Date Picker';return true;"
													onMouseOut="window.status='';return true;"><img border="0" name="imageField" src="images/calender.png?buildstamp=2_0_0" align="absmiddle"></a>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.search.and",strsesLanguage)%>&nbsp;&nbsp;&nbsp;&nbsp;
								<input name="Qtodate" type="text" class="textBoxCss" id="test223" size="10" onFocus="javascript:vDateType='DD/MM/YYYY'"
						onKeyUp="DateFormat(this,this.value,event,false,'DD/MM/YYYY','Invalid Date.Please Re-Enter')"
						onBlur="DateFormat(this,this.value,event,true,'DD/MM/YYYY','Invalid Date.Please Re-Enter')"
						onChange="javascript:while(''+this.value.charAt(this.value.length-1)==' ')this.value=this.value.substring(0,this.value.length-1);"><a href="javascript:show_calendar('frm.Qtodate','a','a','DD/MM/YYYY');"
						onMouseOver="window.status='Date Picker';return true;"
						onMouseOut="window.status='';return true;"><img border="0" name="imageField" src="images/calender.png?buildstamp=2_0_0" align="absmiddle"></a>									
					</td>  
					<td class="formtr2" align="right" style="width:160px; text-align: right;">
			        	<input type=submit value="<%=dbLabelBean.getLabel("button.search.go",strsesLanguage)%>" class="formbutton">  
			 	 		&nbsp;
			 	 		<input type=button value="<%=dbLabelBean.getLabel("label.search.showadvancesearch",strsesLanguage)%>" id="showhide" 
			 	 		class="formbutton" onclick="hideshow('ADVANCE')" style="width:110px;">
				    </td> 
				 </tr>			 
				</table>
			</td>
		</tr>
		
		<tr align="left" valign="top" id="advanceSearchDiv" style="display: none;">
			<td>
				<table width="99%" align="center" border="0" cellpadding="3" cellspacing="1"  class="formborder">
					<tr>
						<td class="formtr2" align="center" ><%=dbLabelBean.getLabel("label.global.unitname",strsesLanguage)%></td>
					 	<td class="formtr2" align="center">
					 		<select name="SelectUnit"  class="textboxCSS">				
							<%
									aList = dbUtility.findSearchSiteListForUser(SuserRole, SuserRoleOther, strSiteIdSS, Suser_id,strsesLanguage);
									itr = aList.iterator();
									siteId ="";
									siteName ="";
									while(itr.hasNext())
											{
										siteId = itr.next().toString();
										siteName = itr.next().toString();
										
											%>
											<option value=<%=siteId%>> <%=((siteName.indexOf("Representative")>-1)?siteName.replaceAll("Representative","Rep..."):siteName)%></option>
											<%
											}
							  
							%>
							</select>    
				           <script language="javascript">
							document.frm.SelectUnit.value ="<%=Site_ID%>";
						</script>
					 	</td>   
					 	<td class="formtr2" align="center"><%=dbLabelBean.getLabel("label.approverequest.originatedby",strsesLanguage)%></td>
					 	<td class="formtr2" align="center"> 
					 	<Input type=text name="originatedby" size=20 maxlength=30 class="textBoxCss" onKeyUp="return test1('originatedby', 29, 'cn')"></td>					 	
					 	 <td class="formtr2" align="center"><%=dbLabelBean.getLabel("label.global.traveller",strsesLanguage)%></td>
					 	<td class="formtr2" align="center"> 
						<Input type=text name="username" size=20 maxlength=30 class="textBoxCss" onKeyUp="return test1('traveller', 35, 'c')"></td> 
					 	<td class="formtr2" align="center" ><%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>: </td>
						<td  class="formtr2">   
						<input name="deptdate" type="text" class="textBoxCss" id="test223" size="10" onFocus="javascript:vDateType='DD/MM/YYYY'"
													onKeyUp="DateFormat(this,this.value,event,false,'DD/MM/YYYY','Invalid Date.Please Re-Enter')"
													onBlur="DateFormat(this,this.value,event,true,'DD/MM/YYYY','Invalid Date.Please Re-Enter')"
													onChange="javascript:while(''+this.value.charAt(this.value.length-1)==' ')this.value=this.value.substring(0,this.value.length-1);"><a href="javascript:show_calendar('frm.deptdate','a','a','DD/MM/YYYY');"
													onMouseOver="window.status='Date Picker';return true;"
													onMouseOut="window.status='';return true;"><img border="0" name="imageField" src="images/calender.png?buildstamp=2_0_0" align="absmiddle"></a>
					  </td> 					 
				</tr>				  
				 <tr>    
				 	<td class="formtr2" align="center" ><%=dbLabelBean.getLabel("label.search.requisitionno",strsesLanguage)%></td>
				 	<td class="formtr2" align="center"><Input type=text name="reqno" size=20 maxlength=30 class="textBoxCss" onKeyUp="return test1('reqno', 29, 'cn' )"></td>
				 	<td class="formtr2" align="center"><%=dbLabelBean.getLabel("label.search.destination",strsesLanguage)%> </td>
				 	<td class="formtr2" align="center"><Input type=text name="destination" size=20 maxlength=30 class="textBoxCss" onKeyUp="return test1('destination', 29, 'cn')"></td>
				 	<td class="formtr2" align="center" > <%=dbLabelBean.getLabel("label.search.createdbetween",strsesLanguage)%></td>
				 	<td class="formtr2" align="center" colspan="3"> 
					<input name="fromdate" type="text" class="textBoxCss" id="test223" size="10" onFocus="javascript:vDateType='DD/MM/YYYY'"
												onKeyUp="DateFormat(this,this.value,event,false,'DD/MM/YYYY','Invalid Date.Please Re-Enter')"
												onBlur="DateFormat(this,this.value,event,true,'DD/MM/YYYY','Invalid Date.Please Re-Enter')"
												onChange="javascript:while(''+this.value.charAt(this.value.length-1)==' ')this.value=this.value.substring(0,this.value.length-1);"><a href="javascript:show_calendar('frm.fromdate','a','a','DD/MM/YYYY');"
												onMouseOver="window.status='Date Picker';return true;"
												onMouseOut="window.status='';return true;"><img border="0" name="imageField" src="images/calender.png?buildstamp=2_0_0" align="absmiddle"></a>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.search.and",strsesLanguage)%>&nbsp;&nbsp;&nbsp;&nbsp;
							<input name="todate" type="text" class="textBoxCss" id="test223" size="10" onFocus="javascript:vDateType='DD/MM/YYYY'"
					onKeyUp="DateFormat(this,this.value,event,false,'DD/MM/YYYY','Invalid Date.Please Re-Enter')"
					onBlur="DateFormat(this,this.value,event,true,'DD/MM/YYYY','Invalid Date.Please Re-Enter')"
					onChange="javascript:while(''+this.value.charAt(this.value.length-1)==' ')this.value=this.value.substring(0,this.value.length-1);"><a href="javascript:show_calendar('frm.todate','a','a','DD/MM/YYYY');"
					onMouseOver="window.status='Date Picker';return true;"
					onMouseOut="window.status='';return true;"><img border="0" name="imageField" src="images/calender.png?buildstamp=2_0_0" align="absmiddle"></a>													
				</td> 						
			 </tr> 
				 <tr>			 
				 <td class="formtr2" align="center" ><%=dbLabelBean.getLabel("label.search.approver",strsesLanguage)%> </td>
				 <td class="formtr2" align="center" ><Input type=text name="papprover" size=20 maxlength=30 class="textBoxCss" onKeyUp="return test1('papprover',35, 'c' )"></td>
				 <td class="formtr2" align="center"><%=dbLabelBean.getLabel("label.search.withstatus",strsesLanguage)%></td>
			 	<td class="formtr2" align="center" >
				 	<select  name="status"  class="textboxCSS" onChange="return statusOnClick(this.form);">
				 	<option value="-1"><%=dbLabelBean.getLabel("label.search.all",strsesLanguage)%></option>
				 	<option value="9"><%=dbLabelBean.getLabel("label.search.pending",strsesLanguage)%></option>
				 	<option value="8"><%=dbLabelBean.getLabel("label.search.expired",strsesLanguage)%></option>
				 	<option value="3"><%=dbLabelBean.getLabel("label.requestdetails.returned",strsesLanguage)%></option>
				 	<option value="4"><%=dbLabelBean.getLabel("label.requestdetails.rejected",strsesLanguage)%></option>  
				 	<option value="6"><%=dbLabelBean.getLabel("label.requestdetails.cancelled",strsesLanguage)%></option>
				 	<option value="10"><%=dbLabelBean.getLabel("label.search.approvedbyall",strsesLanguage)%></option> 
				 	</select>
			 	</td>
			 	<td class="formtr2" align="center" ><%=dbLabelBean.getLabel("label.search.actiontakenbetween",strsesLanguage)%></td>
			 	<td class="formtr2" align="center" colspan="3"> 
						<input name="fromdate1" type="text" class="textBoxCss" id="test223" size="10" onFocus="javascript:vDateType='DD/MM/YYYY'"
													onKeyUp="DateFormat(this,this.value,event,false,'DD/MM/YYYY','Invalid Date.Please Re-Enter')"
													onBlur="DateFormat(this,this.value,event,true,'DD/MM/YYYY','Invalid Date.Please Re-Enter')"
													onChange="javascript:while(''+this.value.charAt(this.value.length-1)==' ')this.value=this.value.substring(0,this.value.length-1);"><a href="javascript:show_calendar('frm.fromdate1','a','a','DD/MM/YYYY');"
													onMouseOver="window.status='Date Picker';return true;"
													onMouseOut="window.status='';return true;"><img border="0" name="imageField"  id="imageField1" src="images/calender.png?buildstamp=2_0_0" align="absmiddle"></a>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.search.and",strsesLanguage)%>&nbsp;&nbsp;&nbsp;&nbsp;
								<input name="todate1" type="text" class="textBoxCss" id="test223" size="10" onFocus="javascript:vDateType='DD/MM/YYYY'"
						onKeyUp="DateFormat(this,this.value,event,false,'DD/MM/YYYY','Invalid Date.Please Re-Enter')"
						onBlur="DateFormat(this,this.value,event,true,'DD/MM/YYYY','Invalid Date.Please Re-Enter')"
						onChange="javascript:while(''+this.value.charAt(this.value.length-1)==' ')this.value=this.value.substring(0,this.value.length-1);"><a href="javascript:show_calendar('frm.todate1','a','a','DD/MM/YYYY');"
						onMouseOver="window.status='Date Picker';return true;"
						onMouseOut="window.status='';return true;"><img border="0" name="imageField1"  id="imageField2" src="images/calender.png?buildstamp=2_0_0" align="absmiddle"></a>
				</td>
			</tr>
			<tr>
			 	<td class="formtr2"><%=dbLabelBean.getLabel("label.report.traveltype",strsesLanguage) %></td>
			 	<td class="formtr2" align="center" colspan="6">
			 		<SELECT name="travelType" id="travelType" class="textBoxCss" > 
						<%-- <OPTION value = "-1"><%=dbLabelBean.getLabel("label.report.selecttraveltype",strsesLanguage) %></OPTION> --%>
						<OPTION value = "A" selected="selected"><%=dbLabelBean.getLabel("label.search.all",strsesLanguage) %></OPTION>
						<OPTION value="I"><%=dbLabelBean.getLabel("label.report.international",strsesLanguage) %></OPTION>
						<OPTION value="D"><%=dbLabelBean.getLabel("label.report.domestic",strsesLanguage) %></OPTION>
					</SELECT>
			 	</td>
			 	<td class="formtr2" align="right" style="width:160px; text-align: right;">
		        	<input type=submit value="<%=dbLabelBean.getLabel("button.search.go",strsesLanguage)%>" class="formbutton">
		        	<input type=button value="<%=dbLabelBean.getLabel("label.search.showquicksearch",strsesLanguage)%>" id="showhide" 
		 	 		class="formbutton" onclick="hideshow('QUICK')"  style="width:110px;">
			    </td> 
			</tr>
		</table>
			</td>
		</tr>
		<tr><td height="5px"></td></tr>
		<%
		if(loadFlag.trim().equals("2")){
			if(searchType != null && searchType.equalsIgnoreCase("quick")){
		%> 
			<script language="javaScript">
				document.getElementById('quickSearchDiv').style.display='block';
				document.getElementById('advanceSearchDiv').style.display='none';
				
				document.frm.QSelectUnit.value ="<%=strUnitNo%>";
	        	document.frm.keyWordParamVal.value ="<%=keyWordSearchVal%>";
	        	document.frm.Qfromdate.value ="<%=strCreateFromdate%>";
	        	document.frm.Qtodate.value ="<%=strCreateTodate%>";
			</script>
		<% } else if(searchType != null && searchType.equalsIgnoreCase("advance")){ %>
			<script language="javaScript">
				document.getElementById('advanceSearchDiv').style.display='block';
				document.getElementById('quickSearchDiv').style.display='none';
				
				document.frm.SelectUnit.value ="<%=strUnitNo%>";
	        	document.frm.originatedby.value ="<%=strOrigenation%>";
	        	document.frm.username.value ="<%=strTravler%>";
	        	document.frm.deptdate.value ="<%=strDeptdate%>";
	        	document.frm.reqno.value ="<%=strRequstionNo%>";
	        	document.frm.destination.value ="<%=strDestination%>";
	        	document.frm.fromdate.value ="<%=strCreateFromdate%>";
	        	document.frm.todate.value ="<%=strCreateTodate%>";
	        	document.frm.papprover.value ="<%=strPendingApprover%>";
	        	document.frm.status.value ="<%=strStatus1%>";
	        	document.frm.fromdate1.value ="<%=strApproveFromdate%>";
	        	document.frm.todate1.value ="<%=strApproveTodate%>";
	        	document.frm.travelType.value ="<%=strTravelType%>";
	        	document.frm.searchType.value ="<%=searchType%>";
			</script>
		<% } 
		}%>

	</table>
	
<%
if(loadFlag.trim().equals("2")){
%>		
	<table width="98%" align="center" border="0" cellspacing="1" border=0 cellpadding="5" class="formborder" id="btnTable">
		<tr align="right" class="formhead" height="16">
			<td colspan="12" align="right"><input type=button
				value='<%=dbLabelBean.getLabel("button.search.exporttoexcel",strsesLanguage)%>' class="formButton" onClick="write1('<%=loadFlag %>');">
			<input type=button Value="<%=dbLabelBean.getLabel("button.search.print",strsesLanguage)%>" class="formButton"
				onClick="window.print();"></td>
		</tr>
	</table>
	<div id="searchDataDiv" style="width:100%; overflow: auto;">
	<span id=main>	
	<table width="98.2%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder">  
		<tr align="center" class="formhead"> 
			<td width="4%" align="left" nowrap="nowrap"><%=dbLabelBean.getLabel("label.global.sno",strsesLanguage)%></td>
			<td width="13%" align="left"><%=dbLabelBean.getLabel("label.global.requisitionnumber",strsesLanguage)%></td>
			<td width="10%" align="left"><%=dbLabelBean.getLabel("label.global.unitname",strsesLanguage)%></td>
			<td width="13%" align="left"><%=dbLabelBean.getLabel("label.search.originatorname",strsesLanguage)%></td>
			<td width="13%" align="left"><%=dbLabelBean.getLabel("label.global.travelername",strsesLanguage)%></td>
			<td width="12%" align="left"><%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%></td>
			<!-- 2/26/2007 -->
			<td width="10%" align="left"><%=dbLabelBean.getLabel("label.global.travelfrom",strsesLanguage)%></td>
			<td width="8%" align="left"><%=dbLabelBean.getLabel("label.global.travelto",strsesLanguage)%></td>
			<td width="10%" align="left"><%=dbLabelBean.getLabel("label.global.totalamount",strsesLanguage)%></td>
			<!--	<td width="23%" align="center">TCHEQUE</TD> -->
			<td width="6%" align="left"><%=dbLabelBean.getLabel("label.requestdetails.status",strsesLanguage)%></td>
		</tr>

		<%
					int iSno=1;
					String OriginatorName		="";
					String sRequisitionNo		="";
					String NAME					="";
					String TRAVEL_DATE			="";
					String DERPARTMENT_NAME	 	="";
					String DIVISIONNAME			="";
					String SITENAME				="";
					String TRAVELFROM			="";
					String TRAVELTO				="";
					String TOTALAMOUNT			="";
					String TACURRENCY			="";
					String TCHEQUE				="";
					String TCURRENCY			="";
					String APPROVEDBY			="";
					String APPROVE_STATUS		="";
					String Traveller_id			="";
					String TRAVEL_REQ_ID		="";
					String ORIGINATED_BY		="";
					String TRAVEL_ID			="";
					String C_DATETIME			="";
					String strPageUrl           ="";
					
					
					objCstmt=objCon.prepareCall("{call SEARCH_TRAVEL_REQUEST(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
					objCstmt.setString(1,strUnitNo);
					objCstmt.setString(2,strOrigenation);
					objCstmt.setString(3,strTravler);
					objCstmt.setString(4,strDeptdate);
					objCstmt.setString(5,strRequstionNo);
					objCstmt.setString(6,strDestination);
					objCstmt.setString(7,strCreateFromdate);
					objCstmt.setString(8,strCreateTodate);
					objCstmt.setString(9,strPendingApprover);
					objCstmt.setString(10,strStatus1);
					objCstmt.setString(11,strApproveFromdate);
					objCstmt.setString(12,strApproveTodate);
					objCstmt.setString(13,strTravelType);
					objCstmt.setInt(14,Integer.parseInt(Suser_id));
					objCstmt.setString(15,keyWordSearchVal);
					objCstmt.setString(16,requestAppFlag);
					rs=objCstmt.executeQuery();
					
					while(rs.next()) {					
						 countflag=1;
						 OriginatorName					=	rs.getString("Originator_Name");
						 TRAVEL_REQ_ID					=	rs.getString("TRAVEL_REQ_ID");
						 TRAVEL_ID						=	rs.getString("TRAVEL_ID");
						 Traveller_id					=	rs.getString("TRAVELLER_ID");
						 sRequisitionNo					=	rs.getString("TRAVEL_REQ_NO");
						 ORIGINATED_BY					=	rs.getString("ORIGINATED_BY");
						 C_DATETIME						=	rs.getString("C_DATETIME");
						 DIVISIONNAME					=	rs.getString("DIVISION");
						 SITENAME						=	rs.getString("UNIT");
						 DERPARTMENT_NAME				=	rs.getString("DEPT_name");
						 NAME							=	rs.getString("CURRENT_TRAVELLER");
						 TRAVELFROM						=	rs.getString("TRAVEL_FROM");
						 TRAVELTO						=	rs.getString("TRAVEL_TO");
						 TOTALAMOUNT					=	rs.getString("TOTAL_AMOUNT");						 
						 strTravelType					=   rs.getString("TRAVEL_TYPE");
						 
						 String  tRAVEL_DATE			=	rs.getString("TRAVEL_DATE");							
						 TRAVEL_DATE					=   tRAVEL_DATE; 
	  
				     
		                 if(strTravelType.equals("INT")) {
									strGroupTravelFlag       =   rs.getString("GROUP_TRAVEL_FLAG"); 
									strTravelAgencyTypeId			=	rs.getString("travel_agency_id");
									if(strGroupTravelFlag==null) 
									{
										strGroupTravelFlag="N";
									}
									if(strGroupTravelFlag!=null  &&  (strGroupTravelFlag.trim().equals("Y")))   
									{		
										NAME="Group/Guest Travel ";
										strPageUrl = "Group_T_TravelRequisitionDetails.jsp";
										if(strTravelAgencyTypeId != null && strTravelAgencyTypeId.equals("2")){
											strPageUrl = "Group_T_TravelRequisitionDetails_GmbH.jsp";
										}
	  							    }
									else {
										strPageUrl = "T_TravelRequisitionDetails.jsp";
										if(strTravelAgencyTypeId != null && strTravelAgencyTypeId.equals("2")){
											strPageUrl = "T_TravelRequisitionDetails_INT_GmbH.jsp";
										}
									}
						} else {
								strGroupTravelFlag       =   rs.getString("GROUP_TRAVEL_FLAG"); 
								strTravelAgencyTypeId			=	rs.getString("travel_agency_id");
								if(strGroupTravelFlag==null) 
								{
									strGroupTravelFlag="N";
								}
								if(strGroupTravelFlag!=null  &&  (strGroupTravelFlag.trim().equals("Y")))   
								{		
									NAME="Group/Guest Travel ";
									strPageUrl = "Group_T_TravelRequisitionDetails_D.jsp";
									if(strTravelAgencyTypeId != null && strTravelAgencyTypeId.equals("2")){
										strPageUrl = "Group_T_TravelRequisitionDetails_GmbH.jsp";
									}
								}
								else {
									strPageUrl = "T_TravelRequisitionDetails_D.jsp";
									if(strTravelAgencyTypeId != null && strTravelAgencyTypeId.equals("2")){
										strPageUrl = "T_TravelRequisitionDetails_INT_GmbH.jsp";
									}
								}
						} 
						
					    strCID = rs.getString("CID");
						strERPWS_URL = rs.getString("ERP_WS_URL");
						strMATAWS_URL = rs.getString("MATA_WS_URL");
						strSiteId = rs.getString("SITE_ID");
				
				if (iCls % 2 == 0) {
					strStyleCls = "formtr2";
				} else {
					strStyleCls = "formtr1";
				}
	
				iCls++;
		%>
		<tr valign=top class="<%=strStyleCls%>">			
			<td width="4%" class="rep-head"><%=iSno%></td>
			<td width="13%" class="rep-txt">
			<%
			if (strTravelType.equals("INT")) {
			%> <a href="#"
				onClick="MM_openBrWindow('<%=strPageUrl%>?purchaseRequisitionId=<%=TRAVEL_ID%>&traveller_Id=<%=Traveller_id%>&travelType=I','SEARCH1','scrollbars=yes,resizable=yes,width=975,height=550')">
			<%=sRequisitionNo%></a> <%
			}
			%>
			<%
			if (strTravelType.equals("DOM")) {
			%> <a href="#"
				onClick="MM_openBrWindow('<%=strPageUrl%>?purchaseRequisitionId=<%=TRAVEL_ID%>&traveller_Id=<%=Traveller_id%>&travelType=D','SEARCH1','scrollbars=yes,resizable=yes,width=975,height=550')">
			<%=sRequisitionNo%></a> <%
			 }
			 %>
			</td>
			<td width="10%" class="rep-txt"><%=SITENAME%></td>
			<td width="13%" class="rep-txt"><%=OriginatorName%></td>
			<td width="13%" class="rep-txt"><%=NAME%></td>
			<td width="12%" class="rep-txt"><%=TRAVEL_DATE%></td>			
			<td width="10%" class="rep-txt"><%=TRAVELFROM%></td>
			<td width="8%" class="rep-txt"><%=TRAVELTO%></td>
			<td width="10%" class="rep-txt"><%=TOTALAMOUNT%></td>
			<%
			if (strTravelType.equals("INT")) {
			%>
			<td class="listdata" width="7%" align="center"><a href="#"
				onClick="MM_openBrWindow('T_TravelRequisitionWorkFlowDiagram.jsp?travelRequisitionId=<%=TRAVEL_ID%>&strTravellerId=<%=Traveller_id%>&strTravelRequestNo=<%=sRequisitionNo%>&travelType=I','SEARCH1','scrollbars=yes,resizable=yes,width=775,height=250')"><%=dbLabelBean.getLabel("link.search.approvers",strsesLanguage)%></a>
			<%
			if((strERPWS_URL!=null && !strERPWS_URL.equals("")) && (strMATAWS_URL!=null && !strMATAWS_URL.equals(""))){
				%>
				<a href="#"	onClick="fun_callwebservice('<%=strERPWS_URL %>','<%=strMATAWS_URL %>','<%=strCID %>','<%=sRequisitionNo %>','<%=TRAVEL_ID %>','<%=strSiteId %>','I')">Cancel</a>
			<%	}%>
			</td>
			<%}
			%>
			<%
			if (strTravelType.equals("DOM")) {
			%>
			<td class="listdata" width="13%" align="center"><a href="#"
				onClick="MM_openBrWindow('T_TravelRequisitionWorkFlowDiagram.jsp?travelRequisitionId=<%=TRAVEL_ID%>&strTravellerId=<%=Traveller_id%>&strTravelRequestNo=<%=sRequisitionNo%>&travelType=D','SEARCH1','scrollbars=yes,resizable=yes,width=775,height=250')"><%=dbLabelBean.getLabel("link.search.approvers",strsesLanguage)%></a>
			
			<%
			if((strERPWS_URL!=null && !strERPWS_URL.equals("")) && (strMATAWS_URL!=null && !strMATAWS_URL.equals(""))){
				%>
				<a href="#"	onClick="fun_callwebservice('<%=strERPWS_URL %>','<%=strMATAWS_URL %>','<%=strCID %>','<%=sRequisitionNo %>','<%=TRAVEL_ID %>','<%=strSiteId %>','D')">Cancel</a>
			<%	}
			%>
			</td>				
			<%}	%>
			</tr>
			<%
			
			iSno++;
			}
			rs.close();
			if(countflag == 0){%>
			<tr class="formtr2">
			<td colspan="10"><%=dbLabelBean.getLabel("label.approverequest.norecordfound",strsesLanguage) %>
			</td>
			</tr>
			</table>
		<%	}
		dbConBean.close(); //Close All Connection
		%>
	   </span>
	</div>
	
   </form>
   <script language="javaScript">
		closeDivRequest();
		
		var docHeight = $(document).height();
		var divOffset = $("div#searchDataDiv");
		var offset = divOffset.offset();
		var divTopPos = offset.top;
		var divHeight = docHeight - divTopPos - 10;
		$("div#searchDataDiv").css('height', divHeight);
		
   </script>
 <%}%>
 </body>
</html>
