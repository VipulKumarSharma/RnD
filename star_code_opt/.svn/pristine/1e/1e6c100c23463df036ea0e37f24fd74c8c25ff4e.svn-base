	<%
	/***************************************************
	 *The information contained here in is confidential and 
	 * proprietary to MIND and forms the part of the MIND 
	 *Author						:Shiv Sharma	
	 *Date of Creation 		       	:17/09/2008
	 *Copyright Notice 		       	:Copyright(C)2000 MIND.All rights reserved
	 *Project	  					:STAR
	 *Operating environment    		:Tomcat, sql server 2000 
	 *Description 			        : This is  jsp file  for marking Out Of office 
	 *Modification 				    : change the for normal user  for shoiwng unit as his access  on 16 july by shiv sharma 
	
	 *Reason of Modification    	:
	 *Date of Modification         	:
	 *Revision History		       	:
	 *Editor				               :Editplus
	 *Modified By					: Manoj Chand
	 *Date of Modification			: 16 May 2012
	 *Modification 					: Show Message when approver has reviewer when marking out of office 
	 *Modified By					: Kaveri Garg
	 *Date of Modification			: 09 Nov 2012
	 *Modification 					: To implement Ajax for populating values in combobox and designing change in Ooo report.
	 
	 *Modified By					: Manoj Chand
	 *Date of Modification			: 17 Sep 2013
	 *Modification 					: add all option in unit combobox.
	 *******************************************************/
	%>
	<%@ page buffer="5kb" language="java"  import="java.sql.*,java.io.*,java.util.*,java.io.*,java.math.*" pageEncoding="UTF-8"%>
	<%@page import="java.net.URLDecoder"%>
	
	<%@ include  file="importStatement.jsp" %>
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
	<!--Create the DbConnectionBean object for createConnection-->
	<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
	<jsp:useBean id="dbConBean1" scope="page" class="src.connection.DbConnectionBean" />
	<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
	<%@ include file="M_InsertProfile.jsp"  %>
	<script language=JavaScript src="ScriptLibrary/jQueryMaster.js?buildstamp=2_0_0"></script>
	
	<!--Create the DbUtilityMethods object for utility methods-->
	<jsp:useBean id="dbUtility" scope="page" class="src.connection.DbUtilityMethods" />
	
	<%
	request.setCharacterEncoding("UTF-8");
	SimpleDateFormat sdf=  new java.text.SimpleDateFormat("dd/MM/yyyy");
	String strCurrDate= sdf.format(new java.util.Date());
	String  strSql="";
    ResultSet rs,objRs	,objRs1		=		null;	
		
	String  strCurrDatenew="";
	
		  strSql="SELECT  convert(varchar(20),getdate()-6,103) as date";
		  rs = dbConBean.executeQuery(strSql); 
		  while (rs.next())
		      {
			  strCurrDatenew=rs.getString(1);
		       }
		   rs.close();
	     
	
	String 		strSelectUnit			="";
	String 		strSiteid				="";
	String 		strUserid				="";
	String 		strFName				="";
	String 		strLName				="";
	String		strDateFrom				= "";
	String		strDateTo				= "";
	String		strSiteID				= "";
	String		strTravelTypee			= "";
	String		strSiteId				= "";
	String		strDelegateFrom			= "";
	String		strDelegateTo			= "";
	String		strReason_list		    = "";
	String		strComment_list			= "";
	String		strTrunOffDate			="";
	String		strSqlStr				="";
	String		strCreatDate		    ="";
	String		strStyleCls				="";
	int			intSno					=1;
	int 		iCls 					= 0;
	String		strOOOID				="";
	String UnitHidden					="";	
	String strText						="";
	String flagForMultiple				="";
	String Site_ID						="";	

	String  strSite=(String)session.getAttribute("siteforOutFOrmark");	
	/*
	if (strSite==null){
		 Site_ID	     = (request.getParameter("SelectUnit")==null)?"-1":request.getParameter("SelectUnit"); 
	
	}else{
	 Site_ID  = strSite;
	}
	*/
	Site_ID	     			 = (request.getParameter("SelectUnit")==null)?strSiteIdSS:request.getParameter("SelectUnit"); 
	String strto		     = (request.getParameter("to")==null)?"":request.getParameter("to");
	 
	String strfrom 		     = (request.getParameter("from")==null)?"":request.getParameter("from");
	String strTravelType     = (request.getParameter("travelType")==null)?"-1":request.getParameter("travelType");
	String strcomment 	     = (request.getParameter("comment")==null)?"":request.getParameter("comment");
	String strReason 	     = (request.getParameter("Reason")==null)?"-1":request.getParameter("Reason");
	String strPageFlag       = (request.getParameter("flag")==null)?"Current":request.getParameter("flag");
	String strMsg 		     = URLDecoder.decode((request.getParameter("strMsg")==null)?"":request.getParameter("strMsg"), "UTF-8");
	String strMessage		 = URLDecoder.decode((request.getParameter("message")==null)?"":request.getParameter("message"), "UTF-8");

	String strUserid_list    = (request.getParameter("userid")==null)?Suser_id:request.getParameter("userid");
	
	String strStatusID 		 ="10"; 
	String strButtonState	 ="";
	String strButtonState1	 ="";
	String strIp_address	  ="";
	String strSiteName		  ="";
    String strTurnOffBy		  ="";
	
	
	
	if (strPageFlag.equals("Current"))
	    {
			strStatusID			="10";
			strButtonState		="disabled";
		    strButtonState1		="Enabled";
	  }
	else
		{
			strStatusID			="30";
	    	strButtonState		="Enabled";
	    	strButtonState1		="disabled";
	   }
	
	strIp_address=request.getRemoteHost();
	
	//System.out.println("strIp_address+++++++"+strIp_address);
	
	%>
	
	<script language="JavaScript" src="style/pupdate.js?buildstamp=2_0_0"></script>
	<script language="JavaScript" src="scripts/CommonValida.js?buildstamp=2_0_0"></script>
	<SCRIPT language="JavaScript" src="ScriptLibrary/date-picker.js?buildstamp=2_0_0"></SCRIPT>
	<script language="JavaScript" src="scripts/BackSpaceDisable.js?buildstamp=2_0_0"></script>
	<SCRIPT language=JavaScript src="ScriptLibrary/validation.js?buildstamp=2_0_0"></SCRIPT>
	<!-- <SCRIPT language="JavaScript" src="LocalScript/M_InsertProfile.js?buildstamp=2_0_0"></SCRIPT> -->
	<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
	  
	<script language="JavaScript" src="ScriptLibrary/date-picker.js?buildstamp=2_0_0"></script>
	<SCRIPT language=JavaScript src="scripts/CommonValida.js?buildstamp=2_0_0"></SCRIPT>
	<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
	<script language="JavaScript" src="style/pupdate.js?buildstamp=2_0_0"></script>
	<script language="JavaScript" src="scripts/CommonValida.js?buildstamp=2_0_0"></script>
	<SCRIPT language="JavaScript" src="ScriptLibrary/date-picker.js?buildstamp=2_0_0"></SCRIPT>
	<script language="JavaScript" src="scripts/BackSpaceDisable.js?buildstamp=2_0_0"></script>
	<script language="JavaScript">
	
	//ADDED BY KAVERI GARG ON 09 NOV 2012 FOR JQUERY DROPDOWN FILLING IMPLEMENTAION STARTS
	$.noConflict();
	jQuery(document).ready(function($) {

		var dv = document.getElementById("waitingData");
		if(dv != null)
		{
			var xpos = screen.width * 0.475;
			var ypos = screen.height * 0.30;   
			
			dv.style.position="absolute";       		
			dv.style.left=(xpos)+"px";
			dv.style.top=(ypos)+"px";
		}
		
		$("#SelectUnit").change(
			function() {
			document.getElementById("waitingData").style.display="";
      		var reqpage="outofoffice1";
		  	var siteIdooo = $("#SelectUnit option:selected").val();
		 	var Params='<%="language1="+strsesLanguage+"&suserRole="+SuserRole+"&useridooo="+Suser_id%>';
            var urlParams=Params+"&reqpageooo="+reqpage+"&siteIdooo="+siteIdooo;
			$.ajax({
		            type: "post",
		            url: "AjaxMaster.jsp",
		            data: urlParams,
		            success: function(result){
					var res = jQuery.trim(result);
					$("#usernameFrom").html('');
	            	$("#usernameFrom").html(res);
	            	if('<%=SuserRole%>'=='AD')
	            	{	}
	            	else 
	            	{	
	            	<%-- usertoval('<%=SuserRole%>','<%=Suser_id%>',siteIdooo); --%>
	            		$("#usernameFrom").val('<%=Suser_id%>');
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
		);	
		$("#SelectUnit1").change(
			function() {
			document.getElementById("waitingData").style.display="";
      		var reqpage="outofoffice1";
		  	var siteIdooo = $("#SelectUnit1 option:selected").val();
		 	var Params='<%="language1="+strsesLanguage+"&suserRole="+SuserRole+"&useridooo="+Suser_id%>';
            var urlParams=Params+"&reqpageooo="+reqpage+"&siteIdooo="+siteIdooo;
			$.ajax({
		            type: "post",
		            url: "AjaxMaster.jsp",
		            data: urlParams,
		            success: function(result){
					var res = jQuery.trim(result);
					$("#usernameTo").html('');
	            	if('<%=SuserRole%>'=='AD'){
	            		$("#usernameTo").html(res);
	            	}else{
	            		usertoval('<%=SuserRole%>','<%=Suser_id%>',siteIdooo);
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
		);
    });
		
	function usertoval(varSuserRole, varSuser_id, varsiteIdooo)
	{
	    var lang='<%=strsesLanguage%>';
	    var SuserRole=varSuserRole;
		var Suser_id=varSuser_id;
		var siteIdooo=varsiteIdooo;
		jQuery(document).ready(function($) {
            var reqpage1="outofoffice2";
         	var urlParams="language1="+lang+"&suserRole="+SuserRole+"&useridooo="+Suser_id+"&reqpageooo="+reqpage1+"&siteIdooo="+siteIdooo;
		   //alert(urlParams);
			$.ajax({
	            type: "post",
	            url: "AjaxMaster.jsp",
	            data: urlParams,
	            success: function(result){
	                   $("#usernameTo").html(jQuery.trim(result));
	            },
				error: function(){
					alert('<%=dbLabelBean.getLabel("label.global.jqueryerror",strsesLanguage)%>');
	            }
         	});
    	});
	}
	//JQUERY DROPDOWN FILLING IMPLEMENTAION BY KAVERI GARG ENDS 
	
	//added by manoj chand on 16 may 2012 to show message when marked user has reviewer
	function showMsg(msg){
    	if(msg!='')
			alert(msg);
	}
	
	function turnoff()
		{
			if(confirm('<%=dbLabelBean.getLabel("alert.outofoffice.areyousuretoturnoff",strsesLanguage)%>'))
					{
					return true;
					}
			else
			        {
					return false;
					}
		}
		
	function test1(obj1, length, str)
	 {	
		 
		 var obj;
			if(obj1=='comment')
				{
				obj = document.frm.comment;
				}
		charactercheck(obj,str);
	    limitlength(obj, length);
	    //zeroChecking(obj); //function for checking leading zero and spaces
		spaceChecking(obj);
	 }
	
	function checkForm()
	{  
		var dateFrom = document.frm.from.value;
		if(dateFrom == '')
		{
			alert('<%=dbLabelBean.getLabel("alert.report.pleaseselectfromdate",strsesLanguage)%>');
			document.frm.from.focus();
			return false;
		}
		var dateTo = document.frm.to.value;
		
		if(dateTo == '')
		{
			alert('<%=dbLabelBean.getLabel("alert.report.pleaseselecttodate",strsesLanguage)%>');
			document.frm.to.focus();
			return false;
		}
		
		var SelectUnit = document.frm.SelectUnit.value;
		if(SelectUnit == '-1')
		{
			alert('<%=dbLabelBean.getLabel("alert.global.unitname",strsesLanguage)%> [From]');
			document.frm.SelectUnit.focus();
			return false;
		}
		
		var travelType = document.frm.travelType.value;
		if(travelType == '-1')
		{
			alert('<%=dbLabelBean.getLabel("alert.report.pleaseselecttraveltype",strsesLanguage)%>');
			document.frm.travelType.focus();
			return false;
		}
		
		var SelectUnit1 = document.frm.SelectUnit1.value;
		if(SelectUnit1 == '-1')
		{
			alert('<%=dbLabelBean.getLabel("alert.global.unitname",strsesLanguage)%> [To]');
			document.frm.SelectUnit1.focus();
			return false;
		}
		
		var Comment = document.frm.comment.value;
		if(Comment == '')
		{
			alert('<%=dbLabelBean.getLabel("alert.approverequest.yourcomments",strsesLanguage)%>');
			document.frm.comment.focus();
			return false;
		}
	
			var usernameFrom = document.frm.usernameFrom.value;
		 
		if(usernameFrom == '-1')
		{
			alert('<%=dbLabelBean.getLabel("alert.outofoffice.pleaseselectperson",strsesLanguage)%>');
			document.frm.usernameFrom.focus();
			return false;
		}
		var usernameTo = document.frm.usernameTo.value;
	
		if(usernameTo == '-1')
		{
			alert('<%=dbLabelBean.getLabel("alert.outofoffice.pleaseselectpersontodelegate",strsesLanguage)%>');
			document.frm.usernameTo.focus();
			return false;
		}
	    var Reason = document.frm.Reason.value;
		if(Reason == '-1')
		{
			alert('<%=dbLabelBean.getLabel("alert.outofoffice.pleaseselectreasonforoutofoffice",strsesLanguage)%>');
			document.frm.Reason.focus();
			return false;
		}
	
	    var todayDate  =  frm.todayDate.value;  
	    if(checkDateme(document.frm,document.frm.todayDate.value,document.frm.from.value,document.frm.todayDate,document.frm.from,'<%=dbLabelBean.getLabel("alert.outofoffice.fromdatenotsmallerthantodaysdate",strsesLanguage)%>','')==false)
		{
	     	return false;
		}
	
	    if(checkDateme(document.frm,document.frm.from.value,document.frm.to.value,document.frm.from,document.frm.to,'<%=dbLabelBean.getLabel("alert.outofoffice.todatenotsmallerthanfromdate",strsesLanguage)%>','')==false)
		{
			return false;
		}
		
	    if(confirm('<%=dbLabelBean.getLabel("alert.outofoffice.areyousuretohandoverpendingrequisitions",strsesLanguage)%>'))
		 	document.frm.handover.value="true";
	    else
	   	 	document.frm.handover.value="false";
	
	   //else
		//{
		document.frm.submit();
		//}
	}
	
	/*function UnitValue(frm,flag_multiple,user_id,suser_role)
	{
				 	document.frm.action="T_outOfOffice.jsp"; 
					document.frm.submit();
	}*/
	
	
	function sayTurnoff(id)
	  {
	  document.frm1.action="T_outOfOfficePost.jsp"; 
	  document.frm1.submit();
	}
	function ShowPage(value)
		{
			if (value==1){
				document.frm1.flag.value="Current"; 
			}
			else{
			document.frm1.flag.value="post"; 
			} 
			document.frm1.action="T_outOfOffice.jsp?SelectUnit=<%=Site_ID%>"; 
			document.frm1.submit();
	   } 
	</script>
	</head>
	
	<body onload="showMsg('<%=strMessage %>');">
	<div id="waitingData" style="display: none;"> 	  
	 	<center>
		 	<img src="images/loading16.gif?buildstamp=2_0_0" width="50" height="51" border="0" /> 
		 	<br>      
		 	<font color="#606060" style="font-size:14px;font-weight:bold;font-family:Verdana, Arial, Helvetica, sans-serif;">
		 		<%=dbLabelBean.getLabel("label.global.pleasewait",strsesLanguage)%> 
		 	</font>
	 	</center>    
	</div>
	<FORM name="frm" action="T_outOfOfficePost.jsp" method="post">
	<table width="98%" border="0" cellspacing="0" cellpadding="0">
	  <tr>
	    <td width="70%" height="32" class="bodyline-Center">
		<ul class="pagebullet">
	      <li class="pageHead"><b><%=dbLabelBean.getLabel("label.mainmenu.outofoffice",strsesLanguage) %> >> <%=dbLabelBean.getLabel("submenu.outofoffice.markoutofoffice",strsesLanguage) %> <%=strMsg%></b></li>
	    </ul></td>
	  </tr>
	</table>
	 
	<table width="98%" align="center" border="0" cellpadding="5" cellspacing="0"  class="formborder">  
	<TR>
		<TD class="formheadNew" align="right" style="width:5%;"><%=dbLabelBean.getLabel("label.report.datefrom",strsesLanguage) %></TD>
		<td class="formheadNew"> 
			<input 	type=textbox name="from" size="17" maxlength="10" class="textboxCSS" onFocus="javascript:vDateType='DD/MM/YYYY'" 
					value="<%=strCurrDate%>" onKeyUp="DateFormat(this,this.value,event,false,'DD/MM/YYYY','Invalid Date.Please Re-Enter')" 
					onBlur="DateFormat(this,this.value,event,true,'DD/MM/YYYY','Invalid Date.Please Re-Enter')"   
					onChange="javascript:while(''+this.value.charAt(this.value.length-1)==' ')this.value=this.value.substring(0,this.value.length-1);" 
			>       
			<a 	href="javascript:show_calendar('frm.from','a','a','DD/MM/YYYY');"onMouseOver="window.status='Date Picker';return true;" 
				onMouseOut="window.status='';return true;">
				<img border="0" name="imageField" src="images/calender.png?buildstamp=2_0_0" 
				align="absmiddle">
			</a>
		</td>
	          <%
			    if (strfrom.equals("")){
					%><script language="javascript">
	 			      document.frm.from.value ="<%=strCurrDate%>";
	          		</script>
	            <%}else{%>
	
	
	          <script language="javascript">
				document.frm.from.value ="<%=strfrom%>";
			</script>
			<%}
			%>
		<TD class="formheadNew" align="right" style="width:6%;"><%=dbLabelBean.getLabel("label.report.dateto",strsesLanguage) %></TD>	
	 	<td class="formheadNew"> 
		 	<input 	type=textbox name="to" size="17" maxlength="10" class="textboxCSS" onFocus="javascript:vDateType='DD/MM/YYYY'" 
		 			value="<%=strCurrDate%>" onKeyUp="DateFormat(this,this.value,event,false,'DD/MM/YYYY','Invalid Date.Please Re-Enter')" 
		 			onBlur="DateFormat(this,this.value,event,true,'DD/MM/YYYY','Invalid Date.Please Re-Enter')"   
		 			onChange="javascript:while(''+this.value.charAt(this.value.length-1)==' ')this.value=this.value.substring(0,this.value.length-1);" 
		 	>       
			<a  href="javascript:show_calendar('frm.to','a','a','DD/MM/YYYY');"onMouseOver="window.status='Date Picker';return true;" 
				onMouseOut="window.status='';return true;">
				<img border="0" name="imageField" src="images/calender.png?buildstamp=2_0_0" 
				align="absmiddle">
			</a>
		</td>
	
         <%
		    if (strto.equals("")){
				%><script language="javascript">
 			      document.frm.from.value ="<%=strCurrDate%>";
          		</script>
            <%}else{%>


          <script language="javascript">
			document.frm.to.value ="<%=strto%>";
		</script>
		<%}
		%>
		  
		 <TD class="formheadNew" align="right" style="width:5%;"><%=dbLabelBean.getLabel("label.report.traveltype",strsesLanguage) %></TD>
		 <td class="formheadNew" style="width:10%;">
		 	<select name="travelType"  class="textboxCSS"  style="width:100%;">
				<option value="-1" selected><%=dbLabelBean.getLabel("label.report.selecttraveltype",strsesLanguage) %></option> 
				<option value="A" selected><%=dbLabelBean.getLabel("label.search.all",strsesLanguage) %></option> 
				<option value="I"><%=dbLabelBean.getLabel("label.report.international",strsesLanguage) %></option> 
				<option value="D"><%=dbLabelBean.getLabel("label.report.domestic",strsesLanguage) %></option>
			</select>
		</td>
	    <script language="javascript">
	 		document.frm.travelType.value ="<%=strTravelType%>";
		</script>
		
		<TD class="formheadNew" align="right" style="width:5%;"><%=dbLabelBean.getLabel("label.outofoffice.reason",strsesLanguage) %></TD>
		<td class="formheadNew"  style="width:15%;">
		  <%	strSql="SELECT REASON_ID AS A, TRANSFER_REASON AS B FROM TRANSFER_REASONS  WHERE STATUS_ID=10 ORDER BY 1";
	          %>
	          <select name="Reason"  class="textboxCSS"  style="width:100%;">
			   		<option value="-1" ><%=dbLabelBean.getLabel("label.outofoffice.selectreason",strsesLanguage) %></option> 
			   <%
		        rs = dbConBean.executeQuery(strSql);
	
				while(rs.next())
				{
	             
	            %>
					<option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
	            <%    
					//rs.close();
				}
				%>
	  
		</td>
	    <script language="javascript">
			document.frm.Reason.value ="<%=strReason%>";
		</script>
		
		<TD class="formheadNew" align="right" style="width:5%;"><%=dbLabelBean.getLabel("link.approverequest.comments",strsesLanguage) %></TD>	
		<TD class="formheadNew"  style="width:15%;">
			<textarea cols="18" rows="2" name="comment" maxlength="300"  style="width:90%;" onKeyUp="return test1('comment',100, 'a')">
			</textarea> 
		</TD>
		<script language="javascript">
		 		document.frm.comment.value ="<%=strcomment%>";
		</script>
	</TR>
	 
	<TR>
		<TD class="formheadNew" align="right" style="width:5%;"><%=dbLabelBean.getLabel("label.requestdetails.unit",strsesLanguage) %> From</TD> 
		<td class="formheadNew" style="width:10%;">
		 	<select name="SelectUnit" id="SelectUnit" class="textboxCSS" style="width:95%;">
		 		<option value="-1"><%=dbLabelBean.getLabel("label.report.selectunit",strsesLanguage) %></option> 
	  	<%
	      // change the for normal user  for shoiwng unit as his access  on 16 july by shiv sharma 
	       	if(SuserRole.equals("AD")) {
	  	%>
	    	   	<option value="0"><%=dbLabelBean.getLabel("label.search.all",strsesLanguage) %></option>
	  	<%  	strSql="SELECT  site_id, Site_name FROM  M_site WHERE (STATUS_ID = 10) order by 2";
			}
			else {
				strSql="select distinct site_id, dbo.sitename(site_id) as Site_Name  from USER_MULTIPLE_ACCESS where userid="+Suser_id+" and status_id=10  "+
				  " union "+
				   "select Site_id, Site_Name from M_Site where status_id=10 and application_id=1 and Site_id="+strSiteIdSS+" and Site_id Not IN (select distinct site_id from USER_MULTIPLE_ACCESS where userid="+Suser_id+" and status_id=10) order by 2";
			}
	        rs = dbConBean.executeQuery(strSql);
		    while(rs.next()) {
		%>
			    <option value="<%=rs.getString(1)%>"> <%=rs.getString(2)%></option>
		<% } 
		%> 
			</select>
	   	<%
	      if(SuserRole.equals("AD")) {
		%>
		    <script language="javascript">
			  document.frm.SelectUnit.value ="-1";
			</script>
	    <%
			}
			else {
		%>
			<script language="javascript">
				//alert(strSiteIdSS);
			    document.frm.SelectUnit.value="<%=Site_ID%>";
			</script>
	    <%	}
		%>
		</td>
		
		<TD class="formheadNew" align="right" style="width:6%;"><%=dbLabelBean.getLabel("label.outofoffice.delegatefrom",strsesLanguage) %></TD>
		<td class="formheadNew" style="width:10%;">
		  	<select name="usernameFrom" id="usernameFrom" class="textboxCSS" style="width:95%;">
			   <option value="-1" ><%=dbLabelBean.getLabel("label.outofoffice.selectperson",strsesLanguage) %></option> 
			<% 
			if(SuserRole.equals("AD")) {
			/* strSql="SELECT  USERID, FIRSTNAME, LASTNAME  FROM   M_USERINFO WHERE Site_ID="+Site_ID+" and  (STATUS_ID = 10) order by 2"; */ 
		    }
		   else{
		    	if (flagForMultiple.equals("1")){
					strSql="SELECT  USERID, FIRSTNAME, LASTNAME  FROM   M_USERINFO WHERE Site_ID="+Site_ID+" and  (STATUS_ID = 10) order by 2"; 
		    	}		
		    	else{ 
					strSql="SELECT  USERID, FIRSTNAME, LASTNAME  FROM   M_USERINFO WHERE Userid="+Suser_id+" and  (STATUS_ID = 10) order by 2"; 
		    	}
		    	rs = dbConBean.executeQuery(strSql);
	      		String strTrimnamef="";
	      		String strOrigFromName="";
				while(rs.next())
				{
		             strUserid=rs.getString("USERID");    
					 strFName=rs.getString("FIRSTNAME");  
					 strLName=rs.getString("LASTNAME");  
					 strTrimnamef=strFName+" "+strLName;
					 strOrigFromName=strTrimnamef;
					 if(strTrimnamef.length() > 30)
						 strTrimnamef = strTrimnamef.substring(0,30)+"..";
			%>
					<option title="<%=strOrigFromName%>" value="<%=strUserid%>" ><%=strTrimnamef%></option> 
			<%
		   		}
			}
	        rs.close();
			%>
	        </select> 
			<%
			if(SuserRole.equals("AD")) {
			%>
			<script language="javascript">
				document.frm.usernameFrom.value ="-1";
			</script>
			<%
			}else { 
			%>
			<script language="javascript">
				document.frm.usernameFrom.value ="<%=Suser_id%>";
			</script>
			<%
            }	
            %>
	
		</td>
		
		<TD class="formheadNew" align="right" style="width:5%;"><%=dbLabelBean.getLabel("label.requestdetails.unit",strsesLanguage) %> To</TD> 
		<td class="formheadNew" style="width:10%;">
		 	<select name="SelectUnit1" id="SelectUnit1" class="textboxCSS" style="width:100%;">
		 		<option value="-1"><%=dbLabelBean.getLabel("label.report.selectunit",strsesLanguage) %></option> 
	    	<%
	      	// change the for normal user  for shoiwng unit as his access  on 16 july by shiv sharma 
	       		if(SuserRole.equals("AD")) {
	    	%>
	    	   	<option value="0"><%=dbLabelBean.getLabel("label.search.all",strsesLanguage) %></option>
	        <%  	strSql="SELECT  site_id, Site_name FROM  M_site WHERE (STATUS_ID = 10) order by 2";
				}
				else {
					strSql=	"select distinct site_id, dbo.sitename(site_id) as Site_Name  from USER_MULTIPLE_ACCESS where userid="+Suser_id+" and status_id=10  "+
				  			" union "+
				   			"select Site_id, Site_Name from M_Site where status_id=10 and application_id=1 and Site_id="+strSiteIdSS+" and Site_id Not IN (select distinct site_id from USER_MULTIPLE_ACCESS where userid="+Suser_id+" and status_id=10) order by 2";
				}
	            rs = dbConBean.executeQuery(strSql);
		        while(rs.next()){%>
			    <option value="<%=rs.getString(1)%>"> <%=rs.getString(2)%></option>
			<% } 
			%> 
			</select>
		</td>
		
		<TD class="formheadNew" align="right" style="width:5%;"><%=dbLabelBean.getLabel("label.outofoffice.delegateto",strsesLanguage) %></TD>
		<td class="formheadNew" style="width:10%;">
		  <select name="usernameTo" id="usernameTo" class="textboxCSS" style="width:100%;">
			   <option value="-1" ><%=dbLabelBean.getLabel("label.outofoffice.selectperson",strsesLanguage) %></option> 
			   
			</select> 	  
			<script language="javascript">
				document.frm.usernameTo.value ="-1";
			</script>
		</td>
		<td class="formheadNew" align="left" colspan="2">
			&nbsp;&nbsp;&nbsp;
			<INPUT TYPE="button" class="formButton" value="<%=dbLabelBean.getLabel("label.outofoffice.activate",strsesLanguage) %>" 
				onclick="return checkForm()" style="width:57px;font-size:11px;align:right">
		</td>
	</TR>
	</TABLE>
	
	<input type="hidden"  name="handover"  >
	<input type="hidden"  name="formname" value="frm" >
	 <input type="hidden" name="todayDate" value="<%=strCurrDate%>"/>
	  <input type="hidden" name="IP_Address" value="<%=strIp_address%>"/>
	</form>
	
	
	<FORM name="frm1" METHOD=POST action="T_outOfOfficePost.jsp" >
	 
	<table width="98%" align="center" border="0" cellpadding="5" cellspacing="1"  class="formborder">  
	
	<TR  heigh="4%" class="formhead"  >
	<TD  colspan="12" align="right"> 
	<input type="button"  class="formButton"  value="<%=dbLabelBean.getLabel("button.outofoffice.currentooo",strsesLanguage) %>" onclick="return ShowPage(1);"  <%=strButtonState%>  />
	<input type="button" class="formButton" name="POST OOO"  value="<%=dbLabelBean.getLabel("button.outofoffice.pastooo",strsesLanguage) %>"  onclick="return ShowPage(2);" <%=strButtonState1%> /></TD>
	
	 	
	</TR>
	<TR><TD class="formhead" nowrap="nowrap" ><%=dbLabelBean.getLabel("label.global.sno",strsesLanguage) %></TD>

		<% if(SuserRole.equals("AD"))  { %>
		<TD class="formhead" Width="9%"><%=dbLabelBean.getLabel("label.requestdetails.unit",strsesLanguage) %></TD>
		<% }%>
		
	    <TD class="formhead" Width="11%" nowrap="nowrap"><%=dbLabelBean.getLabel("label.outofoffice.delegatefrom",strsesLanguage) %></TD>
		<TD class="formhead" Width="11%"><%=dbLabelBean.getLabel("label.outofoffice.delegateto",strsesLanguage) %></TD>
	    <TD class="formhead" Width="8%"><%=dbLabelBean.getLabel("label.report.traveltype",strsesLanguage) %></TD>
		<TD class="formhead" Width="8%"><%=dbLabelBean.getLabel("label.report.datefrom",strsesLanguage) %></TD>
		<TD class="formhead" Width="8%"><%=dbLabelBean.getLabel("label.report.dateto",strsesLanguage) %></TD>
	    <TD class="formhead" Width="11%"><%=dbLabelBean.getLabel("label.outofoffice.reason",strsesLanguage) %></TD>
		<TD class="formhead" Width="13%"><%=dbLabelBean.getLabel("link.approverequest.comments",strsesLanguage) %></TD>
		<TD class="formhead"  Width="8%"><%=dbLabelBean.getLabel("label.global.createdon",strsesLanguage) %></TD>
		<%if(!strStatusID.equals("30")){ %>
		<TD class="formhead" Width="9%" nowrap="nowrap"><%=dbLabelBean.getLabel("label.approverequest.action",strsesLanguage) %></TD>
		<%}else{ %>
			<TD class="formhead" Width="8%" ><%=dbLabelBean.getLabel("label.outofoffice.turnoffdate",strsesLanguage) %></TD>
			<TD class="formhead" Width="8%" ><%=dbLabelBean.getLabel("label.outofoffice.turnoffby",strsesLanguage) %></TD>
		  <%}%>	
	</TR>
	<%//Sql to get the the site list  from site table
		  if(SuserRole.equals("AD"))  {
			strText=""; 
		}
	    else{
	    	strText="and DELEGATE_FROM_USER_INFO_ID="+strUserid_list+""; 
	    } 
	    
	     //System.out.println(flagForMultiple);
	     //change by manoj chand on 12 nov 2012 to sort data based on c_date
	     strSqlStr="SELECT OOO_ID,dbo.CONVERTDATEDMY1(OOO_FROM_DT) as OOO_FROM_DT ,dbo.CONVERTDATEDMY1(OOO_TILL_DT) as OOO_TILL_DT,dbo.CONVERTDATEDMY1(TURN_OFF_DT) as TURN_OFF_DT, dbo.user_name(DELEGATE_FROM_USER_INFO_ID) as DELEGATE_FROM_USER_INFO_ID ,dbo.user_name(DELEGATE_TO_USER_INFO_ID) as DELEGATE_TO_USER_INFO_ID,Travel_type, REASON_ID,dbo.CONVERTDATEDMY1(C_DATE) as C_DATE,COMMENTS, dbo.SITENAME(SITE_ID) AS sitename, dbo.user_name(C_USER_ID) as TURN_OFF_BY FROM OUT_OF_OFFICE WHERE (STATUS_ID = "+strStatusID+")  "+strText+" order by CONVERT(VARCHAR(10),C_DATE,20) desc";
	     
	     if (flagForMultiple.equals("1")){
	     	 
	    	 strSqlStr=" SELECT OUT_OF_OFFICE.OOO_ID,dbo.CONVERTDATEDMY1(OUT_OF_OFFICE.OOO_FROM_DT) as OOO_FROM_DT, " + 
	    	 		   " dbo.CONVERTDATEDMY1(OUT_OF_OFFICE.OOO_TILL_DT) as OOO_TILL_DT,dbo.CONVERTDATEDMY1(OUT_OF_OFFICE.TURN_OFF_DT) as TURN_OFF_DT, "+
	    	 		   " dbo.user_name(OUT_OF_OFFICE.DELEGATE_FROM_USER_INFO_ID) as DELEGATE_FROM_USER_INFO_ID," +
				       " dbo.user_name(OUT_OF_OFFICE.DELEGATE_TO_USER_INFO_ID) as DELEGATE_TO_USER_INFO_ID,OUT_OF_OFFICE.Travel_type, " +
	    	 		   " OUT_OF_OFFICE.REASON_ID,dbo.CONVERTDATEDMY1(OUT_OF_OFFICE.C_DATE) as C_DATE,COMMENTS, " +
					   " dbo.SITENAME(SITE_ID) AS sitename, " +
	    	           " dbo.user_name(C_USER_ID) as TURN_OFF_BY " +
	    	           " FROM  OUT_OF_OFFICE INNER JOIN M_USERINFO ON OUT_OF_OFFICE.DELEGATE_TO_USER_INFO_ID = M_USERINFO.USERID " +	
					   " WHERE (OUT_OF_OFFICE.STATUS_ID = "+strStatusID+") AND (M_USERINFO.SITE_ID = "+Site_ID+") AND (M_USERINFO.STATUS_ID = 10) ";
	     	}
	     
	     objRs = dbConBean.executeQuery(strSqlStr);
	    //System.out.println("strSqlStr=====>>>>>"+strSqlStr);
		String strSiteCode	=	null;
	        if(objRs.next())
	        {  
					do//while(objRs.next())
					{
						strOOOID				= objRs.getString("OOO_ID"); 
						strDateFrom				= objRs.getString("OOO_FROM_DT");
						strDateTo				= objRs.getString("OOO_TILL_DT");
					    strTrunOffDate          = objRs.getString("TURN_OFF_DT");
						strDelegateFrom			= objRs.getString("DELEGATE_FROM_USER_INFO_ID");
						strDelegateTo			= objRs.getString("DELEGATE_TO_USER_INFO_ID");
						strTravelTypee			= objRs.getString("Travel_type"); 
						strTurnOffBy			= objRs.getString("TURN_OFF_BY");
						if(strTravelTypee.equalsIgnoreCase("i"))
						{
							strTravelTypee=dbLabelBean.getLabel("label.report.international",strsesLanguage);
						}else{
					        strTravelTypee=dbLabelBean.getLabel("label.report.domestic",strsesLanguage);
	
						}
						
						strReason_list		        = objRs.getString("REASON_ID");
						
						
						
						strSqlStr="SELECT TRANSFER_REASON FROM  TRANSFER_REASONS WHERE  REASON_ID="+strReason_list+" and (STATUS_ID = 10)";
					   // System.out.println("strSqlStr=====>>>>>"+strSqlStr);
						objRs1 = dbConBean1.executeQuery(strSqlStr);
					    
					    
					    while(objRs1.next())
					    {
					    	strReason_list=objRs1.getString(1);
					    }
					    	
					    
						strCreatDate		    = objRs.getString("C_DATE");
						strComment_list				= objRs.getString("COMMENTS");
						strSiteName				= objRs.getString("sitename");
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
	    <td width="2%" align="center"><%=intSno%>.</td>
	
		<% if(SuserRole.equals("AD"))  { %>
		<TD  Width="9%"><%=strSiteName %></TD>
		<% }%>
		
	    <td width="11%"><%=strDelegateFrom%></td>
		<td width="11%"><%=strDelegateTo%></td>
		<td width="8%"><%=strTravelTypee%></td>	
		<td width="8%"><%=strDateFrom%></td>
	    <td width="8%"><%=strDateTo%></td>
	    <td width="11%"><%=strReason_list%></td>
		<td width="13%"><%=strComment_list%></td>
		<td width="8%"><%=strCreatDate%></td>
		
		<%if(!strStatusID.equals("30")) {
			//System.out.println("Site_ID====="+Site_ID);
		
		%>
	    
		<td width="9%" align="center"><a href="T_outOfOfficePost.jsp?TurnOFFID=<%=strOOOID%>&formname=frm1&IP_Address=<%=strIp_address%>" onclick="return turnoff();"  ><%=dbLabelBean.getLabel("label.outofoffice.turnoff",strsesLanguage) %></a></td>
		<%}else{ %>
		<td width="8%" align="center"><%=strTrunOffDate%></td>
		<td width="8%" align="center"><%=strTurnOffBy%></td>
		<%} %>
		
	<% 
	intSno++;				}while(objRs.next());
	        }
	        else
	        {
	%>
	 <tr  class="formtr2"> 
	    <td width="2%" colspan="12" ><%=dbLabelBean.getLabel("label.approverequest.norecordfound",strsesLanguage) %></td>
	<%} %>
	</TABLE>
	
	 
	 
	
	 <input type="hidden"  name="flag"  >
	 <input type="hidden"  name="formname" value="frm1" >
	  
	  <input type="hidden" name="IP_Address" value="<%=strIp_address%>"/>
	 
	</form>
	
	 
	</body>
	</html>
