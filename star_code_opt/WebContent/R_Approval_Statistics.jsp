<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:MANOJ CHAND
 *Date of Creation 		:31 JAN 2012
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat 5.5, sql server 2000 
 *Description 			:This is first jsp file for showing approval statistic report
 *Modified By			: Manoj Chand
 *Date of Modification	: 09 feb 2012
 *Modification 			: change in query to resolve wrong count.
 
 *Modified By			: Manoj Chand
 *Date of Modification	: 09 Apr 2012
 *Modification 			: change in query to resolve wrong count.
 
 *Modified By			: Manoj Chand
 *Date of Modification	: 16 May 2012
 *Modification 			: Showing wap approval also in reports
 
 *Modified By			: Manoj Chand
 *Date of Modification	: 18 May 2012
 *Modification 			: Showing Change caption from IPHONE to iPhone and ANDROID to Android
 
 *Modified By			: Manoj Chand
 *Modification 			: Create Database connection from stars.properties located outside STARS application.
 *Modification Date		: 02 Jan 2013
 
 *Modified By	        : MANOJ CHAND
 *Date of Modification  : 04 Feb 2013
 *Description			: IE Compatibility Issue resolved
 
 *Modified By	        : MANOJ CHAND
 *Date of Modification  : 23 Sept 2013
 *Description			: add unit and user combobox in approver report.
 *******************************************************/
%>

<%@ page buffer="5kb" language="java"  import="java.sql.*,java.io.*,java.util.*,java.io.*,java.math.*,src.connection.PropertiesLoader" pageEncoding="UTF-8" %>

<HTML>
<HEAD>
<%-- include remove cache  --%>
<%@ include  file="cacheInc.inc" %>
<%-- include header  --%>
<%@ include  file="headerIncl.inc" %>
<%-- include page with all application session variables --%>
<%@ include  file="application.jsp" %>
<%-- include page styles  --%>
<%--<%@ include  file="systemStyle.jsp" %>--%>

<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<script language="JavaScript" src="scripts/BackSpaceDisable.js?buildstamp=2_0_0"></script>
<script language="JavaScript" src="ScriptLibrary/date-picker.js?buildstamp=2_0_0"></script>
<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
<script language=JavaScript src="ScriptLibrary/jQueryMaster.js?buildstamp=2_0_0"></script>
<script type="text/javascript" src="ScriptLibrary/jquery-1.8.3.js?buildstamp=2_0_0"></script>	

<script type="text/javascript">

function showData(){
	
	var trvtypeval=document.getElementById("travelType").value;
	var sourceval=document.getElementById("sourceType").value;
	var fromval=document.getElementById("from").value;
	var toval=document.getElementById("to").value;
	var checkval=document.getElementById("chkData").value;
	var unitval=document.getElementById("unit").value;
	var userval=document.getElementById("user").value;

	if(checkval=='2')
		{
				if(unitval=='-1')
				{
				alert('<%=dbLabelBean.getLabel("alert.master.pleaseselecttheunit",strsesLanguage) %>');
				document.frm.unit.focus();
				return false;
				}
				if(userval=='-1')
				{
				alert('<%=dbLabelBean.getLabel("alert.accessrights.pleaseselectusername",strsesLanguage) %>');
				document.frm.user.focus();
				return false;
				}
				if(trvtypeval=='-1')
				{
				alert('<%=dbLabelBean.getLabel("alert.report.pleaseselecttraveltype",strsesLanguage) %>');
				document.frm.travelType.focus();
				return false;
				}
		
				if(sourceval=='-1')
				{
				alert('<%=dbLabelBean.getLabel("alert.report.pleaseselectmobiletype",strsesLanguage) %>');
				document.frm.sourceType.focus();
				return false;
				}
		
				if(fromval=='')
				{
				alert('<%=dbLabelBean.getLabel("alert.report.pleaseselectfromdate",strsesLanguage) %>');
				document.frm.from.focus();
				return false;
				}
		
				if(toval=='')
				{
				alert('<%=dbLabelBean.getLabel("alert.report.pleaseselecttilldate",strsesLanguage) %>');
				document.frm.to.focus();
				return false;
				}
				openWaitingProcess();
				document.frm.action="R_Approval_Statistics.jsp";
				document.frm.submit();
		}
	else if(checkval=='1')
		{
				var trvtypeval=document.getElementById("travelType").value;
				var sourceval=document.getElementById("sourceType").value;
				if(trvtypeval=='-1')
				{
				alert('<%=dbLabelBean.getLabel("alert.report.pleaseselecttraveltype",strsesLanguage) %>');
				document.frm.travelType.focus();
				return false;
				}
		
				if(sourceval=='-1')
				{
				alert('<%=dbLabelBean.getLabel("alert.report.pleaseselectmobiletype",strsesLanguage) %>');
				document.frm.sourceType.focus();
				return false;
				}
				if(confirm('<%=dbLabelBean.getLabel("label.report.youhaveoptedviewallrequisitionstaketime",strsesLanguage) %>'))
				{
					openWaitingProcess();
					document.frm.action="R_Approval_Statistics.jsp";
					document.frm.submit();
					return true;
				}
				else
				{
					return false;
				}
		}
}

function blankTextBox(fromdate,todate){
	var checkval=document.getElementById("chkData").value;
	if(checkval==1){
		document.frm.from.value='';
		document.frm.to.value='';
		document.frm.from.disabled=true;
		document.frm.to.disabled=true;
		document.getElementById("datepickfrom").href='#';
		document.getElementById("datepickto").href='#';
	}else{
		document.frm.from.value=fromdate;
		document.frm.to.value=todate;
		document.frm.from.disabled=false;
		document.frm.to.disabled=false;
		document.getElementById("datepickfrom").href="javascript:show_calendar('frm.from','a','a','DD/MM/YYYY')";
		document.getElementById("datepickto").href="javascript:show_calendar('frm.to','a','a','DD/MM/YYYY')";
	}
	
}

function write1(loadflag)
{
	var info='';
	var checkflag=document.getElementById("chkData").value;
	if(checkflag!=1){
		info='<font size=2><%=dbLabelBean.getLabel("alert.report.approvalstatisticsreportfrom",strsesLanguage) %> <b>'+ document.frm.from.value +'</b> <%=dbLabelBean.getLabel("label.approverequest.to",strsesLanguage) %> <b>'+ document.frm.to.value+'</b></font>';
	}else{
		info='<b><%=dbLabelBean.getLabel("alert.report.approvalstatisticsreport",strsesLanguage) %></b>';
	}

	var txt='';
	if(loadflag==2){
	txt= "<meta http-equiv=\"Content-Type\" content=\"application/vnd.ms.excel; charset=UTF-8\"><table border=1 >"+info+ document.getElementById("main").innerHTML+"</table>";
	document.frm.va.value='';
	document.frm.va.value=txt;
	document.frm.action="issue_exlWrite.jsp";
	document.frm.submit();
	}else
		alert('<%=dbLabelBean.getLabel("alert.report.nodataforexporttoexcel",strsesLanguage) %>');
}


function closeDivRequest()
{
	document.getElementById("waitingData").style.visibility="hidden";	
}

function openWaitingProcess() {
	var height 	= $(document).height();
	var width 	= $(document).width();
	
    var bcgDiv 	= document.getElementById("divBackground");
    var dv = document.getElementById("waitingData");
    
    bcgDiv.style.height=height;
    bcgDiv.style.width=width;
    bcgDiv.style.display="block";
	
	if(dv != null)
	{
		var xpos = screen.width * 0.43;
		var ypos = screen.height * 0.23;   
		
		dv.style.position="absolute";       		
		dv.style.left=(xpos)+"px";
		dv.style.top=(ypos)+"px";
		document.getElementById("waitingData").style.display="";
		document.getElementById("waitingData").style.visibility="";	
	}
}

$.noConflict();
jQuery(document).ready(function($) {

	var dv = document.getElementById("waitingData");
	if(dv != null)
	{
		var xpos = screen.availHeight/2+90;
		var ypos = screen.availWidth/2-350;   
		
		dv.style.position="absolute";       		
		dv.style.left=(xpos+10)+"px";
		dv.style.top=(ypos)+"px";
	}
	
	$("#unit").change(
			function() {
			document.getElementById("waitingData").style.display="";
      		var reqpage="reqapprovebyperson";
		  	var siteId = $("#unit option:selected").val();
		 	var Params='<%="language1="+strsesLanguage+"&suserRole="+SuserRole+"&useridooo="+Suser_id%>';
            var urlParams=Params+"&reqpageooo="+reqpage+"&siteIdooo="+siteId;
			$.ajax({
		            type: "post",
		            url: "AjaxMaster.jsp",
		            data: urlParams,
		            success: function(result){
					var res = jQuery.trim(result);
					$("#user").html('');
	            	$("#user").html(res);
	            },
	            complete: function(){
	            	document.getElementById("waitingData").style.display="none";
	            	},
				error: function(){
					alert('<%=dbLabelBean.getLabel("label.global.jqueryerror",strsesLanguage)%>');
	            }
	          });
			}
		);
      });
</script>
<%

// Variables declared and initialized

ResultSet rs=null;			// Object for ResultSet
ResultSet rs2=null;
Statement stmt,stmt1		= null;				// Object for Statement
CallableStatement cstmt			=		null;

int intSerialNo				=  0;
String	strSql				=  ""; // For sql Statements
String	strTravelId	    	=  "";
String	strTravelRequestNo 	=  "";

String  strFrom             =  "";
String  strTo               =  "";
String  strTravelDate       =  "";
  
String	strSiteName			=  "";

int iCls				    =  0;
String strStyleCls			=  "";
String strTitle				=  "";


String  stroldDate="";
String strApproverCount="0";
String strApprover="";
String strApproverId="";
String strColor="";
String strSource="";

String loadFlag=request.getParameter("flag")==null?"":request.getParameter("flag");
String strFromDate=request.getParameter("from")==null?"":request.getParameter("from");
String strToDate=request.getParameter("to")==null?"":request.getParameter("to");
String strCheckType=request.getParameter("chkData")==null?"2":request.getParameter("chkData");
String strTrvType=request.getParameter("travelType")==null?"B":request.getParameter("travelType");
String strSourceType=request.getParameter("sourceType")==null?"MOBILE":request.getParameter("sourceType").trim();
String strUser=request.getParameter("user")==null?"-1":request.getParameter("user").trim();
String strUnit=request.getParameter("unit")==null?"-1":request.getParameter("unit").trim();
//String contextServerPath  =	application.getInitParameter("serverPath");
//FileInputStream propfile = new FileInputStream(contextServerPath+"STAR.properties");
String strDbdriver="";
String strDburl="";
String strUsername="";
String strDbpwd="";
//changed by manoj chand on 02 jan 2013 to fetch db connection parameters from outside STARS application.
	strDbdriver 	= PropertiesLoader.config.getProperty("dbdriver")==null?"":PropertiesLoader.config.getProperty("dbdriver");
	strDburl 	    = PropertiesLoader.config.getProperty("dburl")==null?"":PropertiesLoader.config.getProperty("dburl");
	strUsername 	= PropertiesLoader.config.getProperty("dbuser")==null?"":PropertiesLoader.config.getProperty("dbuser");
	strDbpwd 	    = PropertiesLoader.config.getProperty("dbpwd")==null?"":PropertiesLoader.config.getProperty("dbpwd");
	
Connection cn = null;
Class.forName(strDbdriver);
cn=DriverManager.getConnection(strDburl,strUsername,strDbpwd);
stmt=cn.createStatement();

strSql="SELECT  convert(varchar(20),getdate()-30,103) as date"; 
rs = stmt.executeQuery(strSql); 
if(rs.next())
    {
	stroldDate=rs.getString(1); 
     }
 rs.close();
 
SimpleDateFormat sdf=  new java.text.SimpleDateFormat("dd/MM/yyyy");
String strCurrDate= sdf.format(new java.util.Date());
%>

</HEAD>

<body>

	<div id = "divBackground" style="position: absolute; z-index: 99; height: 100%; width: 100%; top: 0; left:0; background-color: Black; filter: alpha(opacity=60); opacity: 0.6; -moz-opacity: 0.8;display:none">
		<div id="waitingData" style="display: none;"> 	    
		<center>
			<img src="images/loader-circle.gif?buildstamp=2_0_0" width="50" height="50"/> 
			<br><br>
			<font color="#ffffff" style="font-size:14px;font-weight:bold;font-family:Verdana, Arial, Helvetica, sans-serif;">   
			<span id="pleaseWait">Please Wait...<br/>while data is loading</span>
			</font>  
		</center>
		</div>
	</div>


<script type="text/javascript" language="JavaScript1.2" src="menu/menu_cnt.js?buildstamp=2_0_0"></script>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="35" class="bodyline-top">
    <ul class="pagebullet">
      <li class="pageHead"><%=dbLabelBean.getLabel("label.report.starsapproverreport",strsesLanguage) %> </li>
    </ul></td>
    <td height="40" align="right" valign="bottom" class="bodyline-top">
    <table align="right" border="0" cellspacing="0" cellpadding="0">
      <tr align="right">
      
      <td>
<ul id="list-nav">
<li><a href="#" onClick="write1('<%=loadFlag %>');"><%=dbLabelBean.getLabel("label.report.exporttoexcel",strsesLanguage) %></a></li>
<li><a href="#" onClick="window.print();"><%=dbLabelBean.getLabel("button.search.print",strsesLanguage) %></a></li>
</ul>
</td>
      
     </tr>
    </table>
    </td> 
  </tr> 
</table>


<form method=post name=frm action="R_Approval_Statistics.jsp" style="display: inline; margin: 0; " onsubmit="openWaitingProcess();">  

<table width="100%" border="0" cellpadding="5" cellspacing="1" class="formborder">
  
  <input type="hidden" name="flag" value="2">
  <input type=hidden name=va>
   <tr> 
     <td class="formhead" align="Left" colspan="8"><span class="formTit"><%=dbLabelBean.getLabel("label.report.selectpreference",strsesLanguage) %></span></td>
   </tr>
   <tr> 
   <td class="formtr3" align="left" width="5%"><%=dbLabelBean.getLabel("label.requestdetails.unit",strsesLanguage) %></td> 
   <td class="formtr3" align="left" width="23%">
   <select name="unit" id="unit" class="textboxCSS" >
		 <option value="-1"><%=dbLabelBean.getLabel("label.report.selectunit",strsesLanguage) %></option>
		 <option value="0"><%=dbLabelBean.getLabel("label.search.all",strsesLanguage) %></option> 
	      <%  
        	strSql="SELECT  site_id, RTRIM(Site_name) FROM  M_site WHERE STATUS_ID = 10 and isnull(M_site.CLOSED_UNIT_FLAG,'')<>'y' order by 2";
  			stmt = null;
  			stmt = cn.createStatement();
            rs = stmt.executeQuery(strSql);
            String strSiteid="",strSite="",strTrimName="";
            
	        while(rs.next()){
	        	strSiteid = rs.getString(1);
	        	strSite = rs.getString(2);
	        	strTrimName = strSite;
	        	if(strTrimName.length() > 30)
       				strTrimName = strTrimName.substring(0,30)+"..";
	        %>
	    	<option title="<%=strSite %>" value="<%=strSiteid%>"> <%=strTrimName%></option>
		  <% }
	        stmt.close();
	        rs.close();
	        %> 
	</select>
   </td>
   <td class="formtr3" align="left" width="5%"><%=dbLabelBean.getLabel("submenu.master.user",strsesLanguage) %></td>
   <td class="formtr3" align="left" width="25%">
   <select name="user" id="user" class="textboxCSS" >
			   <option value="-1" ><%=dbLabelBean.getLabel("label.outofoffice.selectperson",strsesLanguage) %></option>
			   <%
			   if(!strUnit.equals("-1")){
				   if(strUnit.equals("0"))
			 	    		strSql="SELECT  USERID, FIRSTNAME, LASTNAME,RTRIM(dbo.SITENAME(site_id)) as SITE  FROM   M_USERINFO WHERE STATUS_ID = 10 order by 2";
			 	    	else
							strSql="SELECT  USERID, FIRSTNAME, LASTNAME FROM M_USERINFO WHERE Site_ID="+strUnit+" and  STATUS_ID = 10 order by 2";
		  			stmt = null;
		  			stmt = cn.createStatement();
		            rs = stmt.executeQuery(strSql);
		            String strUserid="",strFname="",strLname="",strSitename="",strTrim="",strOriginalName="";
		            %>
		            <option value="0"><%=dbLabelBean.getLabel("label.search.all",strsesLanguage) %></option>
		            <%
		            if(strUnit.equals("0")){
			        	while(rs.next())
						{
			        	 strUserid=rs.getString("USERID");    
			        	 strFname=rs.getString("FIRSTNAME");  
			        	 strLname=rs.getString("LASTNAME");
			        	 strSitename=rs.getString("SITE");
			        	 strTrim=strFname+" "+strLname+" ("+strSitename+")";
					 	 strOriginalName=strTrim;
						 if(strTrim.length() > 30){
							 strTrim = strTrim.substring(0,30)+"..";
						 }
			            %>
						<option title="<%=strOriginalName%>" value="<%=strUserid%>"><%=strTrim%></option> 
						 <%
						 }
				       
		            }else{
		            	while(rs.next())
						{
			        	 strUserid=rs.getString("USERID");    
			        	 strFname=rs.getString("FIRSTNAME");  
			        	 strLname=rs.getString("LASTNAME");
			        	 strTrim=strFname+" "+strLname;
						 strOriginalName=strTrimName;
						 if(strTrim.length() > 30){
							 strTrim = strTrim.substring(0,30)+"..";
						 }
			            %>
						<option title="<%=strOriginalName%>" value="<%=strUserid%>"><%=strTrim%></option> 
						 <%
						 }
		            }
		            stmt.close();
			        rs.close();
			   }
			   %>
	          </select> 
   </td>
   <td class="formtr3" align="left" width="8%"><%=dbLabelBean.getLabel("label.report.traveltype",strsesLanguage) %></td>
   <td class="formtr3" align="left" width="12%">
	   <select name="travelType"  class="textboxCSS">
		<!-- 	<option value="-1"><%=dbLabelBean.getLabel("label.handover.select",strsesLanguage) %></option>  -->
			<option value="B" selected="selected"><%=dbLabelBean.getLabel("label.search.all",strsesLanguage) %></option> 
			<option value="I"><%=dbLabelBean.getLabel("label.report.international",strsesLanguage) %></option> 
			<option value="D"><%=dbLabelBean.getLabel("label.report.domestic",strsesLanguage) %></option>
			</select>
   </td>
   <td class="formtr3" align="left" width="10%"><%=dbLabelBean.getLabel("label.reqapprovebyperson.approvaltype",strsesLanguage) %></td>
    <td class="formtr3" align="left" width="10%">
	   <select name="sourceType"  class="textboxCSS">
			<option value="-1"><%=dbLabelBean.getLabel("label.handover.select",strsesLanguage) %></option> 
			<option value="MOBILE" selected="selected"><%=dbLabelBean.getLabel("label.search.all",strsesLanguage) %></option> 
			<option value="IPHONE"><%=dbLabelBean.getLabel("label.report.iphone",strsesLanguage) %></option>
			<option value="ANDROID"><%=dbLabelBean.getLabel("label.report.android",strsesLanguage) %></option>
			<option value="WAP"><%=dbLabelBean.getLabel("label.report.wap",strsesLanguage) %></option>
			<option value="WEB"><%=dbLabelBean.getLabel("label.reqapprovebyperson.web",strsesLanguage) %></option>
			</select>
   </td>
   </tr>
   <tr>
   <td class="formtr3" align="left" width="5%"><%=dbLabelBean.getLabel("label.reqapprovebyperson.period",strsesLanguage) %></td>
     <td class="formtr3" align="left">
	   <select name="chkData" id="chkData"  class="textboxCSS" onchange="blankTextBox('<%=stroldDate %>','<%=strCurrDate %>');">
 	     <option value="1"><%=dbLabelBean.getLabel("label.search.all",strsesLanguage) %></option> 
	     <option value="2" selected><%=dbLabelBean.getLabel("label.report.selectedperiod",strsesLanguage) %></option>
	   </select>
	  </td>
     <td class="formtr3" align="left" width="5%"><%=dbLabelBean.getLabel("label.approverrequest.from",strsesLanguage) %></td>
	  <td class="formtr3" align="left">
	  <input type="text" name="from" id="from" size='10' maxlength="10" class="textboxCSS" onFocus="javascript:vDateType='DD/MM/YYYY'" onKeyUp="DateFormat(this,this.value,event,false,'DD/MM/YYYY','Invalid Date.Please Re-Enter')" onBlur="DateFormat(this,this.value,event,true,'DD/MM/YYYY','Invalid Date.Please Re-Enter')"  value="<%=stroldDate %>" onChange="javascript:while(''+this.value.charAt(this.value.length-1)==' ')this.value=this.value.substring(0,this.value.length-1);" >
        <a id="datepickfrom" href="javascript:show_calendar('frm.from','a','a','DD/MM/YYYY');" onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;"><img border="0" name="imageField" src="images/calender.png?buildstamp=2_0_0" align="absmiddle"></a>
      </td>
      <td class="formtr3" align="left" width="5%"><%=dbLabelBean.getLabel("label.report.till",strsesLanguage) %></td>
      <td class="formtr3" align="left">
      <input type="text" name="to" id="to"  size='10' maxlength="10" class="textboxCSS" onFocus="javascript:vDateType='DD/MM/YYYY'" onKeyUp="DateFormat(this,this.value,event,false,'DD/MM/YYYY','Invalid Date.Please Re-Enter')" onBlur="DateFormat(this,this.value,event,true,'DD/MM/YYYY','Invalid Date.Please Re-Enter')"  value="<%=strCurrDate %>" onChange="javascript:while(''+this.value.charAt(this.value.length-1)==' ')this.value=this.value.substring(0,this.value.length-1);" >        <a id="datepickto" href="javascript:show_calendar('frm.to','a','a','DD/MM/YYYY');" onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;"><img border="0" name="imageField" src="images/calender.png?buildstamp=2_0_0" align="absmiddle"></a>
        </td>
        <td class="formtr3" align="left" colspan="2">
        <center>
        <input type="submit" name="Gobutton" id="go" value="<%=dbLabelBean.getLabel("label.report.generatereport",strsesLanguage) %>" class="formbutton"></center>
     <%
     if(loadFlag.equalsIgnoreCase("2")){
     
     %> 
        
        <script type="text/javascript">
        	document.getElementById("unit").value='<%=strUnit%>';
			document.getElementById("user").value='<%=strUser%>';
        	document.getElementById("travelType").value='<%=strTrvType%>';
    		document.getElementById("sourceType").value='<%=strSourceType%>';
	        document.getElementById("chkData").value='<%=strCheckType%>';
	        document.getElementById("from").value='<%=strFromDate%>';
	        document.getElementById("to").value='<%=strToDate%>';
        </script>
        <%} %>
        
      <% if(strCheckType.equalsIgnoreCase("1")){%>
		<script type="text/javascript">
			document.frm.from.disabled=true;
			document.frm.to.disabled=true;
			document.getElementById("datepickfrom").href='#';
			document.getElementById("datepickto").href='#';
		</script>
		<%} %>
     </td>
   </tr>

<!-- bymanoj -->

</table>
<br>
<!-- end here -->
<%

if(loadFlag.trim().equals("2"))
{
%>
<table width="60%" cellpadding="3" cellspacing="1" align="center" class="formborder" >
<span id=main>
  <tr class="formhead"> 
	<td class="listhead" width="3%" align="center"><%=dbLabelBean.getLabel("label.global.sno",strsesLanguage) %></td>	
 	<td class="listhead" width="14%" align="center"><%=dbLabelBean.getLabel("label.report.approvername",strsesLanguage) %></td>
    <td class="listhead" width="15%" align="center"><%=dbLabelBean.getLabel("label.report.countofapproval",strsesLanguage) %></td> 
	<td class="listhead" width="15%" align="center"><%=dbLabelBean.getLabel("label.report.mobiledevice",strsesLanguage) %></td>
  </tr>
<%

int success=10;
int tempCount=0;
String strAppend="";
if(strCheckType.trim().equalsIgnoreCase("2")){
	strAppend=" AND CONVERT(VARCHAR(10),T_APPROVERS.APPROVE_DATE,20) BETWEEN CONVERT(VARCHAR(10),CONVERT(DATETIME,'"+strFromDate+"'),20) AND CONVERT(VARCHAR(10),CONVERT(DATETIME,'"+strToDate+"'),20)";	
}

	 try
	   {
		 //adding case for wap in this query on 16 may 2012 by manoj chand
		/*strSql=" SET DATEFORMAT DMY "+
			   " SELECT APPROVER_ID,DBO.USER_NAME(APPROVER_ID)AS APPROVER, COUNT(APPROVER_ID) AS APPROVALCOUNT,"+
			   " APPROVED_DEVICE FROM ( SELECT TRAVEL_ID, APPROVER_ID,TRAVEL_TYPE,"+ 
			   " CASE WHEN APPROVED_DEVICE LIKE '%ANDROID%' THEN 'Android' WHEN APPROVED_DEVICE LIKE '%IPHONE%' THEN 'iPhone' WHEN APPROVED_DEVICE LIKE '%WAP%' THEN 'WAP' ELSE 'iPhone' END AS APPROVED_DEVICE"+ 
			   " FROM T_APPROVERS WHERE   T_APPROVERS.APPROVED_DEVICE LIKE '%MOBILE%' "+strAppend+""+ " and convert(varchar(10),T_APPROVERS.APPROVE_DATE) <>'-'  ) ABC"+ 
			   " WHERE ABC.APPROVED_DEVICE = CASE WHEN 'MOBILE' = '"+strSourceType+"' THEN ABC.APPROVED_DEVICE ELSE '"+strSourceType+"' END "+
			   " AND ABC.TRAVEL_TYPE=CASE WHEN 'B' = '"+strTrvType+"' THEN ABC.TRAVEL_TYPE ELSE '"+strTrvType+"'  END"+
			   " GROUP BY DBO.USER_NAME(APPROVER_ID),APPROVER_ID,ABC.APPROVED_DEVICE ORDER BY APPROVER";*/		
		//new query added by manoj chand on 07 sept 2013
		String strCondition="";
		if(!strUnit.equals("0"))
		strCondition=" AND T_APPROVERS.APPROVER_ID IN (SELECT USERID FROM M_USERINFO WHERE SITE_ID ='"+strUnit+"')";
		if(!strUser.equals("0"))
			strCondition = " AND T_APPROVERS.APPROVER_ID = "+strUser;
		
		 strSql =" SET DATEFORMAT DMY"+
				 " SELECT APPROVER_ID,DBO.USER_NAME(APPROVER_ID)AS APPROVER, COUNT(APPROVER_ID) AS APPROVALCOUNT,"+ 
				 " APPROVED_DEVICE FROM ( SELECT TRAVEL_ID, APPROVER_ID,TRAVEL_TYPE,"+
				 " CASE WHEN APPROVED_DEVICE LIKE '%ANDROID%' THEN 'Android' WHEN APPROVED_DEVICE LIKE '%IPHONE%' THEN 'iPhone' WHEN APPROVED_DEVICE LIKE '%WAP%' THEN 'WAP' ELSE 'iPhone' END AS APPROVED_DEVICE"+ 
				 " FROM T_APPROVERS WHERE T_APPROVERS.APPROVED_DEVICE LIKE '%MOBILE%' "+ strAppend+""+
				 " and convert(varchar(10),T_APPROVERS.APPROVE_DATE) <>'-'"+ 
				 " AND T_APPROVERS.APPROVER_ID=CASE WHEN 0="+strUser+" THEN T_APPROVERS.APPROVER_ID else "+strUser+" end "+strCondition+
				 " UNION ALL"+
				 " SELECT TRAVEL_ID, APPROVER_ID,TRAVEL_TYPE, 'Web' AS APPROVED_DEVICE"+ 
				 " FROM T_APPROVERS WHERE (T_APPROVERS.APPROVED_DEVICE IS NULL OR T_APPROVERS.APPROVED_DEVICE ='')"+strAppend+""+
				 " and convert(varchar(10),T_APPROVERS.APPROVE_DATE) <>'-' "+
				 " AND T_APPROVERS.APPROVE_STATUS<>0"+
				 " AND T_APPROVERS.APPROVER_ID=CASE WHEN 0="+strUser+" THEN T_APPROVERS.APPROVER_ID else "+strUser+" end "+strCondition+") ABC"+ 
				 " WHERE ABC.APPROVED_DEVICE = CASE WHEN 'MOBILE' = '"+strSourceType+"' "+
				 " THEN ABC.APPROVED_DEVICE ELSE '"+strSourceType+"' END  "+
				 " AND ABC.TRAVEL_TYPE=CASE WHEN 'B' = '"+strTrvType+"' THEN ABC.TRAVEL_TYPE"+ 
				 " ELSE '"+strTrvType+"'  END "+
				 " GROUP BY DBO.USER_NAME(APPROVER_ID),APPROVER_ID,"+
				 " ABC.APPROVED_DEVICE "+
				 " ORDER BY APPROVER";
		 
		//System.out.println("strSql--->"+strSql);
		stmt1=cn.createStatement();
		rs2=stmt1.executeQuery(strSql);
		//END HERE
			
		while(rs2.next()){
			strApproverId     		=	rs2.getString("APPROVER_ID");
			strApprover     		=	rs2.getString("APPROVER");
			strApproverCount        =	rs2.getString("APPROVALCOUNT");
			strSource				=	rs2.getString("APPROVED_DEVICE");
			strColor              =   "";
			if (iCls%2 == 0) { 
				strStyleCls="formtr2";
		    } else { 
				strStyleCls="formtr1";
		    } 
		    iCls++;
		    tempCount++;
%>
		  <tr class="<%=strStyleCls%>"> 
		    <td class="listhead" width="3%" align="center"><%=++intSerialNo %></td>	
		    <td class="listdata" width="14%" align="center"><%=strApprover%></td>
		    <td class="listdata" width="15%" align="center"><a href="#" onClick="MM_openBrWindow('R_showApprovalStatistics.jsp?userid=<%=strApproverId %>&approver=<%=strApprover %>&travel_type=<%=strTrvType %>&sourceType=<%=strSource %>&check=<%=strCheckType %>&from=<%=strFromDate %>&to=<%=strToDate %>','ApprovalStatistics','scrollbars=yes,resizable=yes,width=760,height=300')"><%=strApproverCount%></a></td>
		    <td class="listdata" width="15%" align="center" ><%=strSource %></td>
		  </tr>
    <%
		}
		rs2.close();
		cn.close();
	   }
	   catch(Exception e)
	   {
		   System.out.println("Error in R_APPROVAL_STATISTICS.jsp====="+e);
	   }

if(tempCount==0){
	%>
	<tr class="formtr1">
		<td colspan="13" class="formtr2" style="text-align: center;font-weight: bold;color:red;">
			<%=dbLabelBean.getLabel("label.approverequest.norecordfound",strsesLanguage) %>
		</td>
	</tr>	
<%}%>
 </span>
  
</table>

 </form> 
<script language="javaScript">
		closeDivRequest();
	</script>
<%}%>

</body>
</HTML>
