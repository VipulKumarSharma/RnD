<%
	/***************************************************
	 *The information contained here in is confidential and 
	 * proprietary to MIND and forms the part of the MIND 
	 *Author						:Manoj Chand	
	 *Date of Creation 		       	:17/01/2011
	 *Copyright Notice 		       	:Copyright(C)2000 MIND.All rights reserved
	 *Project	  					:STAR
	 *Operating environment    		:Tomcat, sql server 2000 
	 *Description 			        :Jsp file for Hand over request
	 *Modified By					:Manoj Chand
	 *Date of Modification			:02 march 2011
	 
	 *Description 			        :SET TRAVEL TYPE TO ALL IN DEFAULT
	 *Modified By					:Manoj Chand
	 *Date of Modification			:19 march 2011
	 *******************************************************/
	%>
	<%@page import="java.net.URLDecoder"%>
	
	<%@ include  file="importStatement.jsp" %>
	<HTML>
	<HEAD>
	<%@ page pageEncoding="UTF-8" %>
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
	
	<!--Create the DbUtilityMethods object for utility methods-->
	<jsp:useBean id="dbUtility" scope="page" class="src.connection.DbUtilityMethods" />
	
	<%
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
	Site_ID	     			 = (request.getParameter("SelectUnit")==null)?"-1":request.getParameter("SelectUnit");
	//System.out.println("Site_ID----->"+Site_ID);
	String strto		     = (request.getParameter("to")==null)?"":request.getParameter("to");
	 
	String strfrom 		     = (request.getParameter("from")==null)?"":request.getParameter("from");
	String strTravelType     = (request.getParameter("travelType")==null)?"A":request.getParameter("travelType");
	String strcomment 	     = (request.getParameter("comment")==null)?"":request.getParameter("comment");
	String strReason 	     = (request.getParameter("Reason")==null)?"-1":request.getParameter("Reason");
	String strPageFlag       = (request.getParameter("flag")==null)?"Current":request.getParameter("flag");
	String strMsg 		     = URLDecoder.decode((request.getParameter("strMsg")==null)?"":request.getParameter("strMsg"), "UTF-8");
	 //System.out.println("strMsg====is=refresh==>"+strMsg);
	String strUserid_list 		     = (request.getParameter("userid")==null)?Suser_id:request.getParameter("userid");
	
	String strStatusID 		 ="10"; 
	String strButtonState	 ="";
	String strButtonState1	 ="";
	String strIp_address	  ="";
	String strSiteName		  ="";
	
	//System.out.println("strSiteIdSS------------------->"+strSiteIdSS);
	
	
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
	<script language=JavaScript src="ScriptLibrary/jQueryMaster.js?buildstamp=2_0_0"></script>
	<script language="JavaScript">
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
		
		$("#SelectUnit").change(
				function() {
				document.getElementById("waitingData").style.display="";
	      		var reqpage="handoverReq";
			  	var siteId = $("#SelectUnit option:selected").val();
			 	var Params='<%="language1="+strsesLanguage+"&suserRole="+SuserRole+"&useridooo="+Suser_id%>';
	            var urlParams=Params+"&reqpageooo="+reqpage+"&siteIdooo="+siteId;
	            jQuery.ajax({
			            type: "post",
			            url: "AjaxMaster.jsp",
			            data: urlParams,
			            success: function(result){
						var res = jQuery.trim(result);
						$("#usernameFrom").html('');
		            	$("#usernameFrom").html(res);
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
		var SelectUnit = document.frm.SelectUnit.value;
		
		if(SelectUnit == '-1')
		{
			alert('<%=dbLabelBean.getLabel("alert.global.unitname",strsesLanguage)%>');
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
	
		
		var usernameFrom = document.frm.usernameFrom.value;
		 
		if(usernameFrom == '-1')
		{
			alert('<%=dbLabelBean.getLabel("alert.outofoffice.pleaseselectperson",strsesLanguage)%>');
			document.frm.usernameFrom.focus();
			return false;
		}
		//added by manoj chand on 26 august 2013 to check whether user has the reviewer or not.
		var res = 'N';
		var lang = '<%=strsesLanguage%>';
		var urlParams2 = '&reqpage=handoverrequest&language1='+lang+'&handoverfrom='+usernameFrom;
		var urlParams = "siteId="+SelectUnit+urlParams2;
		if(SelectUnit!='-1'){
			jQuery.ajax({
            type: "post",
            url: "AjaxMaster.jsp",
            data: urlParams,
            async: false,
            success: function(result){
				res = jQuery.trim(result);
				if(res == 'Y'){
					alert('<%=dbLabelBean.getLabel("alert.handover.useralreadyhavereviewer",strsesLanguage)%>');
					return false;
				}
            },
			error: function(){
				alert('<%=dbLabelBean.getLabel("label.global.jqueryerror",strsesLanguage)%>');
            }
          });
		}
		if(res=='Y')
			return false;
   /*if(confirm('Are you want to handover Pending requisition also.'))
		 	document.frm.handover.value="true";
	      else
	   	 	document.frm.handover.value="false"; */
	   	 document.frm.handover.value="true";
		document.frm.submit();	
	}
	
	function UnitValue(frm)
	{
	 
				 
				 	document.frm.action="T_handOver.jsp"; 
					document.frm.submit();
				 
	
	}
	
	
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
	
	<body>
	<div id="waitingData" style="display: none;"> 	  
	 	<img src="images/loading16.gif?buildstamp=2_0_0" width="50" height="51" border="0" /> 
	 	<br>      
	 	<center><font color="#000080" class="pageHead">
	 	<%=dbLabelBean.getLabel("label.global.pleasewait",strsesLanguage)%> </font></center>    
	</div>
	<FORM name="frm" action="T_handOverReqPost.jsp" method="post">
	<table width="98%" border="0" cellspacing="0" cellpadding="0">
	  <tr>
	    <td width="70%" height="25" class="bodyline-Center">
		<ul class="pagebullet">
	      <li class="pageHead"><b><%=dbLabelBean.getLabel("label.mainmenu.outofoffice",strsesLanguage) %> >><%=dbLabelBean.getLabel("submenu.outofoffice.handoverrequest",strsesLanguage) %><%=strMsg%></b></li>
	    </ul></td>
	  </tr>
	</table>
	 
	<table width="98%" align="center" border="0" cellpadding="5" cellspacing="0"  class="formborder">  
	<TR >
		
		<TD class="formhead" width="7%" align="Left"><%=dbLabelBean.getLabel("label.requestdetails.unit",strsesLanguage) %></TD> 
		<TD class="formhead"  width="8%" align="Left"><%=dbLabelBean.getLabel("label.report.traveltype",strsesLanguage) %></TD>
		<TD class="formhead" width="9%" align="Left" colspan="2" ><%=dbLabelBean.getLabel("label.outofoffice.delegatefrom",strsesLanguage) %></TD>
		
	</TR>
	<TR>
		
	 
		 <td class="formhead" width="7%" align="Left">
		  <select name="SelectUnit" id="SelectUnit"  class="textboxCSS">
		  <option value="-1" ><%=dbLabelBean.getLabel("label.report.selectunit",strsesLanguage) %></option> 
		    
		  <%
	      // change the for normal user  for shoiwng unit as his access  on 16 july by shiv sharma 
	       if(SuserRole.equals("AD")) {
	          strSql="SELECT  site_id, Site_name FROM  M_site WHERE (STATUS_ID = 10) order by 2";
			  }
			  else{
				   strSql="select distinct site_id, dbo.sitename(site_id) as Site_Name  from USER_MULTIPLE_ACCESS where userid="+Suser_id+" and status_id=10  "+
				   " union "+
				   "select Site_id, Site_Name from M_Site where status_id=10 and application_id=1 and Site_id="+strSiteIdSS+" and Site_id Not IN (select distinct site_id from USER_MULTIPLE_ACCESS where userid="+Suser_id+" and status_id=10) order by 2";
			  }
			   	rs = dbConBean.executeQuery(strSql);
	              
				   while(rs.next())			
				   { 
					   if(!SuserRole.equals("AD")) {
					     ///flagForMultiple="1";  
					   }
					%>
					<option value="<%=rs.getString(1)%>"> <%=rs.getString(2)%></option>
					<% 
					}
					 
				   
	%> 
	</select>
	   <%
	      if(SuserRole.equals("AD")) {
		   %>
		    <script language="javascript">
		    
				document.frm.SelectUnit.value ="<%=Site_ID%>";
			</script>
	      <%
			}
			else{
				//System.out.println("Site_ID= =ELSE==>"+Site_ID);
			%>
			<script language="javascript">
				document.frm.SelectUnit.value ="<%=strSiteIdSS%>";
			</script>
	       <%}
			%>
		  </td>
		 <td class="formhead" width="8%" align="Left">
		 <select name="travelType"  class="textboxCSS">
		<option value="-1" selected="selected"><%=dbLabelBean.getLabel("label.report.selecttraveltype",strsesLanguage) %></option> 
			<option value="A" selected="selected"><%=dbLabelBean.getLabel("label.search.all",strsesLanguage) %></option> 
		<option value="I"><%=dbLabelBean.getLabel("label.report.international",strsesLanguage) %></option> 
		<option value="D"><%=dbLabelBean.getLabel("label.report.domestic",strsesLanguage) %></option>
		</select></td>
	
		<%--    <script language="javascript">
		 		document.frm.travelType.value ="<%=//strTravelType%>";
		</script>--%> 
			
			
			
			
			
			
		<%
	      if(SuserRole.equals("AD")) {
		   %>
		    <script language="javascript">
		    
				document.frm.travelType.value ="<%=strTravelType%>";
			</script>
	      <%
			}
			else{
			%>
			<script language="javascript">
				document.frm.travelType.value ="A";
			</script>
	       <%}
			%>	
					
	 <td class="formhead" width="9%"align="Left" colspan=1>
		  <select name="usernameFrom"  id="usernameFrom" class="textboxCSS" >
			   <option value="-1" ><%=dbLabelBean.getLabel("label.outofoffice.selectperson",strsesLanguage) %></option> 
			   <% 
			   
			 
			   
	          if(SuserRole.equals("AD")) {
				strSql="SELECT  USERID, FIRSTNAME, LASTNAME  FROM   M_USERINFO WHERE Site_ID="+Site_ID+" and  (STATUS_ID = 10) order by 2"; 

				 
		           }
				   else{
					    
					    	if (flagForMultiple.equals("1")){
								strSql="SELECT  USERID, FIRSTNAME, LASTNAME  FROM   M_USERINFO WHERE Site_ID="+Site_ID+" and  (STATUS_ID = 10) order by 2"; 
								 
					    	}		
					    	else{ 
								 
							strSql="SELECT  USERID, FIRSTNAME, LASTNAME  FROM   M_USERINFO WHERE Userid="+Suser_id+" and  (STATUS_ID = 10) order by 2"; 
					    	}
				   }
			   
			   
			  
	      	  rs = dbConBean.executeQuery(strSql);
	
				while(rs.next())
				{
	             strUserid=rs.getString("USERID");    
				 strFName=rs.getString("FIRSTNAME");  
				 strLName=rs.getString("LASTNAME");  
				 
	            %>
				<option value="<%=strUserid%>" ><%=strFName%> <%=strLName%></option> 
				<%
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
			  }else
			  { 
				if (flagForMultiple.equals("1"))
				{  
									%>
									  <script language="javascript">
										document.frm.usernameFrom.value ="-1";
									  </script>
									<%
				}	
				
				else{
					//System.out.println("Suser_id-->"+Suser_id);
					%>
					  <script language="javascript">
						document.frm.usernameFrom.value ="<%=Suser_id%>";
					  </script>
					<%
				}
					
			  }	
			
					
			   %>
	
			  </td>
		
		<TD class="formhead" width="7%" align="left" colspan="1" >
		<INPUT TYPE="button" class="formbutton" value="<%=dbLabelBean.getLabel("button.search.go",strsesLanguage) %>" onclick="return checkForm()" >
		
		</TD>
		
	  </TR> 

	</table>
	<input type="hidden"  name="handover"  >
	<input type="hidden"  name="formname" value="frm" >
	 <input type="hidden" name="todayDate" value="<%=strCurrDate%>"/>
	  <input type="hidden" name="IP_Address" value="<%=strIp_address%>"/>
	  
	</form>
	</body>
	</html>