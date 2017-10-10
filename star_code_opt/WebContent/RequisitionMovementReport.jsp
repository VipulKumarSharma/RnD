	<%
	/***************************************************
	 *The information contained here in is confidential and 
	 * proprietary to MIND and forms the part of the MIND 
	 *Author				                :Rohit Ganjoo
	 *Date of Creation 		       :07/09/2006
	 *Copyright Notice 		       :Copyright(C)2000 MIND.All rights reserved
	 *Project	  						   :STAR
	 *Operating environment    :Tomcat, sql server 2000 
	 *Description 			           : This is first jsp file  for Showing reports of Requisitions 
	 *Modification 			           : 1.Selection of sites in case  of LA ,when LA  has multiple access of site ,on 24-Apr-07   
	                                     2. Added a new code for showing "from date"  as seven days before date as current Date  on 22-May-07 by shiv 
										 3.From date change to one month before on 14 sept 2009				
	 *Reason of Modification    :  New functionality added
	 *Date of Modification         :  24-Apr-07 by shiv ,22-May-07 by shiv 
	 *Revision History		       :
	 *Editor				               :Editplus
	 *******************************************************/
	%>
	<%@ page pageEncoding="UTF-8" %>
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
	<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
	
	
	<!--Create the DbUtilityMethods object for utility methods-->
	<jsp:useBean id="dbUtility" scope="page" class="src.connection.DbUtilityMethods" />
	
	<%
	SimpleDateFormat sdf=  new java.text.SimpleDateFormat("dd/MM/yyyy");
	String strCurrDate= sdf.format(new java.util.Date());
	String  strSql="";
	ResultSet rs			=		null;	
		 
	
	 //code added by shiv on 22-May-07 open--  
		 
	String  strCurrDatenew="";
	
		  strSql="SELECT  convert(varchar(20),getdate()-30,103) as date"; 
		  rs = dbConBean.executeQuery(strSql); 
		  while (rs.next())
		      {
			  strCurrDatenew=rs.getString(1); 
		       }
		   rs.close();
	     
	//code added by shiv on 22-May-07 closed--
	String strSelectUnit	="";
	String strSiteid="";
	%>
	
	<script language="JavaScript" src="ScriptLibrary/date-picker.js?buildstamp=2_0_0"></script>
	<SCRIPT language=JavaScript src="scripts/CommonValida.js?buildstamp=2_0_0"></SCRIPT>
	<script type="text/javascript" src="ScriptLibrary/jquery-1.8.3.js?buildstamp=2_0_0"></script>	
	<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
	
	<script language="JavaScript">
	function funcDisplay()
	{
	if(document.frm.chkData.value=='2')
		{
			document.frm.from.value="<%=strCurrDatenew%>";
	        document.frm.to.value="<%=strCurrDate%>";
		}
		else
		{
			document.frm.from.value="";
	        document.frm.to.value="";
		}
	
	}	
	
	
	function checkForm()
	{
	
		var travelType = document.frm.travelType.value;
		if(travelType == '-1')
		{
			alert('<%=dbLabelBean.getLabel("alert.report.pleaseselecttraveltype",strsesLanguage) %>');
			document.frm.travelType.focus();
			return false;
		}
	
	
	    if(checkDateme(document.frm,document.frm.from.value,document.frm.to.value,document.frm.from,document.frm.to,'<%=dbLabelBean.getLabel("alert.report.tilldatecannotsmallerfromdate",strsesLanguage) %>','')==false)
		{
		return false;
		}
	
		var a= document.frm.chkData.value;
		if(document.frm.chkData.value=='2')
		{
				if(document.frm.from.value=='')
				{
				alert('<%=dbLabelBean.getLabel("alert.report.pleaseselectfromdate",strsesLanguage) %>');
				document.frm.from.focus();
				return false;
				}
	
				if(document.frm.to.value=='')
				{
				alert('<%=dbLabelBean.getLabel("alert.report.pleaseselecttilldate",strsesLanguage) %>');
				document.frm.to.focus();
				return false;
				}
		}
		else if(document.frm.chkData.value=='1')
	
			{
					if(confirm(' <%=dbLabelBean.getLabel("label.report.youhaveoptedviewallrequisitionstaketime",strsesLanguage) %>' ))
					{	
						//document.frm.submit();
						return true;
					}
					else
					{
						return false;
					}
			}
		openWaitingProcess();
		return true;
	}
	
	function UnitValue(frm)
	{
	frm.UnitHidden.value=frm.SelectUnit.value;
	
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

	function confirmData() {
		var flag = checkForm();
		if (flag) {
			document.frm.action="RequisitionMovementReport_Post.jsp";
			openWaitingProcess();
			frm.submit();
		}
	}
	</script>
	</head>
	
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
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	  <tr>
	    <td width="70%" height="35" class="bodyline-top">
		<ul class="pagebullet">
	      <li class="pageHead"> <b><%=dbLabelBean.getLabel("label.report.starsreportrequisitionmovementreport",strsesLanguage) %></b></li>
	    </ul></td>
		<td width="23%" height="35" align="right" valign="bottom" class="bodyline-top">
		<table width="39%" align="right" border="0" cellspacing="0" cellpadding="0">
	      <!--<tr align="right">
	         <td width="48%" align="right"><a href="#" onClick="javascript:top.window.close();"><img src="images/IconClose.gif?buildstamp=2_0_0" width="49" height="24" border="0" /></a></td>
	        <td width="48%" align="right"><a href="#" onClick="window.print();"><img src="images/IconPrint.gif?buildstamp=2_0_0" width="49" height="24" border="0" /></a></td>
	      </tr>-->
	    </table>
		</td>
	  </tr>
	</table>
	
	<table width="100%" align="center" border="0" cellpadding="5" cellspacing="1"  class="formborder">  
	   <form method=post name=frm action="RequisitionMovementReport_Post.jsp" onSubmit="confirmData();">
	   <input type="hidden" name="flag" value="2">
	  <tr> 
	      <td class="formhead" width="8%" align="Left"><%=dbLabelBean.getLabel("label.report.selectpreference",strsesLanguage) %></td>
	  </tr>
	    <tr> 
	    <td class="formtr3" align=center>
		<select name="travelType"  class="textboxCSS">
		<option value="-1" selected><%=dbLabelBean.getLabel("label.report.selecttraveltype",strsesLanguage) %></option> 
		<OPTION value="I"><%=(ssflage.equals("3") ? "Intercont" : dbLabelBean.getLabel("label.report.international",strsesLanguage)) %></OPTION>
			<OPTION value="D"><%=(ssflage.equals("3") ? "Domestic/Europe" : dbLabelBean.getLabel("label.report.domestic",strsesLanguage)) %></OPTION>
		</select>&nbsp;&nbsp;
	
	<select name="SelectUnit"  class="textboxCSS" onChange="UnitValue(frm);">
	<%  //// 
	
	
	//Find Single Site or Multiple site Report Access
	
	/*String strReportAccess   = dbUtility.findReportAccessInMainMenu(SuserRole, SuserRoleOther, strSiteIdSS, Suser_id);
	
	ResultSet rs = null;
	String strSql = "";
	
	 
	
	if(strReportAccess != null && strReportAccess.trim().equalsIgnoreCase("allSite"))
	{*/
	%>
		<!--<option value = "0">All</OPTION>-->
	<%
		/*strSql = "select distinct site_id,site_name from m_site where status_id=10 and application_id=1 ORDER BY 2";
	
	 rs = dbConBean.executeQuery(strSql); 
	}
	else if(strReportAccess != null && strReportAccess.trim().equalsIgnoreCase("oneSite"))
	{
	
	 ///// code added on 24-Apr-07 open
	  
				  strSql="SELECT  SITE_ID FROM M_USERROLE  WHERE STATUS_ID=10 AND USERID="+Suser_id+" order by 1";
	              rs = dbConBean.executeQuery(strSql);    
	
		           if(!rs.next())
					{
			        strSql = "select distinct site_id,site_name from m_site where site_id="+strSiteIdSS+" and status_id=10 and application_id=1 ORDER BY 2"; 
					rs       =   dbConBean.executeQuery(strSql);
	                }
					else 
		            {
						 strSql="SELECT  SITE_ID,dbo.SITENAME(SITE_ID) FROM  M_USERROLE WHERE STATUS_ID=10 AND USERID="+Suser_id+" ORDER BY 1";
	
						 						 rs = dbConBean.executeQuery(strSql); 
							 while(rs.next())
						      {
								  strSiteid=rs.getString(1);*/
								 %>
	                              <!--<option value=<%//=strSiteid%>> <%//=rs.getString(2)%></option>-->
	                              <% 
							  
							  //}  //rs.close();
	                          
	                         //query for unit head   
							  /*strSql = "Select  SITE_ID,dbo.SITENAME(SITE_ID) FROM user_multiple_access  where status_id=10 and UNIT_HEAD=1  and SITE_ID NOT IN (SELECT  DISTINCT SITE_ID FROM  M_USERROLE WHERE STATUS_ID=10 AND USERID="+Suser_id+" ) ORDER BY 2";
	
							 	   
	
						      rs       =   dbConBean.executeQuery(strSql);
	 				          while(rs.next())
						      {*/
								 %>
	                              <!--<option value=<%//=rs.getString(1)%>> <%//=rs.getString(2)%></option>-->
	                             <% 
							  //} 
	
							  
							//rs.close();
	                      
							 
	
					//}
	     
	
	 ///// code added on 24-Apr-07 close  
	 
	/*
		strSql = "select distinct site_id,site_name from m_site where site_id="+strSiteIdSS+" and status_id=10 and application_id=1 ORDER BY 2";
	*/
	//}
	//rs       =   dbConBean.executeQuery(strSql);
	/*while(rs.next())
	{*/
	
		 	 %>
		<!--<option value=<%//=rs.getString(1)%>> <%//=rs.getString(2)%></option>-->
	<% 
	/*}
	rs.close();
	dbConBean.close();*/
	
	%>
	<%
	//Added by Sachin 5/7/2007 Start
	ArrayList aList = dbUtility.findReportSiteListForUser(SuserRole, SuserRoleOther, strSiteIdSS, Suser_id,strsesLanguage);
	Iterator itr = aList.iterator();
	while(itr.hasNext())
	{
	%>
	<option value=<%=itr.next()%>> <%=itr.next()%></option>
	<%
	}
	//Added by Sachin 5/7/2007 End
	
	%>
	</select>
	
		<select name="chkData"  class="textboxCSS" onChange="funcDisplay();">
		<option value="1"><%=dbLabelBean.getLabel("label.search.all",strsesLanguage) %></option> 
		<option value="2" selected><%=dbLabelBean.getLabel("label.report.selectedperiod",strsesLanguage) %></option>
		</select>
	
		<%=dbLabelBean.getLabel("label.approverrequest.from",strsesLanguage) %> <input type=textbox name="from"  size='10' maxlength="10" class="textboxCSS" onFocus="javascript:vDateType='DD/MM/YYYY'" value="<%=strCurrDatenew%>" onKeyUp="DateFormat(this,this.value,event,false,'DD/MM/YYYY','Invalid Date.Please Re-Enter')" onBlur="DateFormat(this,this.value,event,true,'DD/MM/YYYY','Invalid Date.Please Re-Enter')"  onChange="javascript:while(''+this.value.charAt(this.value.length-1)==' ')this.value=this.value.substring(0,this.value.length-1);" >
	       
		<a href="javascript:show_calendar('frm.from','a','a','DD/MM/YYYY');"onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;"><img border="0" name="imageField" src="images/calender.png?buildstamp=2_0_0" align="absmiddle"> 
	    </a>		
			
		<%=dbLabelBean.getLabel("label.report.till",strsesLanguage) %>   <input type=textbox name="to"  size='10' maxlength="10" class="textboxCSS" onFocus="javascript:vDateType='DD/MM/YYYY'" value="<%=strCurrDate%>" onKeyUp="DateFormat(this,this.value,event,false,'DD/MM/YYYY','Invalid Date.Please Re-Enter')" onBlur="DateFormat(this,this.value,event,true,'DD/MM/YYYY','Invalid Date.Please Re-Enter')"   onChange="javascript:while(''+this.value.charAt(this.value.length-1)==' ')this.value=this.value.substring(0,this.value.length-1);" >       
		<a href="javascript:show_calendar('frm.to','a','a','DD/MM/YYYY');"onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;"><img border="0" name="imageField" src="images/calender.png?buildstamp=2_0_0" align="absmiddle"></a> 
		
		<input type="submit" name="submit" value="<%=dbLabelBean.getLabel("label.report.generatereport",strsesLanguage) %>" class=formbutton>
	</td> 
	  </tr>
	  <% if(SuserRole.equals("AD")) { 
	  %>
	  
	  <tr>
	    <td class="formtr3" width="8%" align="center"><%=dbLabelBean.getLabel("label.report.nonexpiredrequisition",strsesLanguage) %> &nbsp; 
	    <input type="radio" name="REQ_STATUS" value="NON_EXP" checked>  &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp;   <%=dbLabelBean.getLabel("label.report.expiredrequisition",strsesLanguage) %> &nbsp; &nbsp;  
	    <input type="radio" name="REQ_STATUS" value="EXP" > &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<%=dbLabelBean.getLabel("label.report.temporaryrequisition",strsesLanguage) %> &nbsp; &nbsp;  
	    <input type="radio" name="REQ_STATUS" value="TEMP" > </td>
	  </tr>
	  <%}%>
	  <input type="HIDDEN" name="UnitHidden" value="0">

	</table>
	<br>
	</body>
	</html>