	<%/***************************************************
	 *The information contained here in is confidential and 
	 * proprietary to MIND and forms the part of the MIND 
	 *Author				:Himanshu Jain
	 *Date of Creation 		:13 September 2006
	 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
	 *Project	  			:STAR
	 *Operating environment :Tomcat, sql server 2000 
	 *Description 			:
	 *Modification 			:Display the date from the sessionwise
	 						:From date change to one month before on 14 sept 2009
	 *Reason of Modification: 1.The Date is display yearly,
	                                          2. Selection of sites in case  of LA ,when LA has multiple access of site ,on 24-Apr-07     by shiv 
	                 						  3. New code added for adding new combo when "year" option is selected  on 02-Jul-07   by shiv 
	 *Date of Modification  :     1. 14-Mar-2007,  
	                                             : 2. 24-Apr-07 by Shiv Sharma   
	 *Modified By		            	: 1.Vijay Kumar Singh,
	                                               2 .Shiv Sharma
	 *Revision History		:
	 *Editor				:Editplus
	 *******************************************************/
	%>
	<%@ page buffer="5kb" language="java"  import="java.sql.*,java.io.*,java.util.*,java.io.*,java.math.*" pageEncoding="UTF-8"%>
	<%@ include  file="importStatement.jsp" %>
	<%@ page import = "src.connection.DbConnectionBean" %>
	<!--Create the DbConnectionBean object for createConnection-->
	<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
	<jsp:useBean id="dbConBean1" scope="page" class="src.connection.DbConnectionBean" />
	<jsp:useBean id="dbConBean2" scope="page" class="src.connection.DbConnectionBean" />
	
	<jsp:useBean id="dbConBean3" scope="page" class="src.connection.DbConnectionBean" />
		<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
	
	<!--Create the DbUtilityMethods object for utility methods-->
	<jsp:useBean id="dbUtility" scope="page" class="src.connection.DbUtilityMethods" />
	<!--  errorPage="error.jsp"  -->
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
	<% DbConnectionBean bean = new DbConnectionBean(); %>
	<%
	
	SimpleDateFormat sdf=  new java.text.SimpleDateFormat("dd/MM/yyyy");
	String strCurrDate= sdf.format(new java.util.Date());
	SimpleDateFormat sdfY=  new java.text.SimpleDateFormat("yyyy");
	String strYear= sdfY.format(new java.util.Date());
	
	String strSql						="";   
	String  strCurrDatenewBefore="";
	String  strCurrDatenewAfter="";
 
	ResultSet  rs1                     =null;    
	
	  strSql="SELECT  convert(varchar(20),getdate()-30,103) as beforeDate, convert(varchar(20),getdate()+30,103) as AfterDate";
	  rs1 = dbConBean.executeQuery(strSql); 
	  while (rs1.next()) 
	      {
		  strCurrDatenewBefore     =rs1.getString(1); // date before 30 days from current date 
		  strCurrDatenewAfter        =rs1.getString(2); // date before 30 days from current date
	       }
	   rs1.close();
	
	
	
	
	%>
	<SCRIPT language=JavaScript src="scripts/CommonValida.js?buildstamp=2_0_0"></SCRIPT>
	<script type="text/javascript" src="ScriptLibrary/jquery-1.8.3.js?buildstamp=2_0_0"></script>
	
	<script language="JavaScript">
	function funcDisplay()
	{
	if(document.frm.chkData.value=='2')
		{
			document.frm.from.value="01/04/<%=strYear%>";
	        document.frm.to.value="<%=strCurrDatenewBefore%>";  
		}
		else
		{
			document.frm.from.value="";
	        document.frm.to.value="";
		}
	
	}	
	
	function MM_openBrWindow(theURL,winName,features) 
	{ 
	window.open(theURL,winName,features);
	}
	
	function checkForm()
	{
	
	 if(frm.chkData.value==1)
	 {
		if(frm.from.disabled==false)
		{
				if(document.frm.from.value=='')
				{
				alert('<%=dbLabelBean.getLabel("alert.report.pleaseselectfromdate",strsesLanguage) %>');
				document.frm.from.focus();
				return false;
				}
		}
		
		if(frm.to.disabled==false)		
		{
			if(document.frm.to.value=='')
			{
			alert('<%=dbLabelBean.getLabel("alert.report.pleaseselecttilldate",strsesLanguage) %>' );
			document.frm.to.focus();
			return false;
			}
		}
	
		if(document.frm.Category.value=="-1")
				{
					alert('<%=dbLabelBean.getLabel("alert.report.pleaseselecttraveltype",strsesLanguage) %>');
					document.frm.Category.focus();
					return false;
				}
	
	 }	
	
	 if(checkDateme(document.frm,document.frm.from.value,document.frm.to.value,document.frm.from,document.frm.to,'<%=dbLabelBean.getLabel("alert.report.tilldatecannotsmallerfromdate",strsesLanguage) %>','')==false)
		{
		return false;
		}
	
	
	//for taday's date check 
	/*
	 if(checkDateme1(document.frm,document.frm.to.value,document.frm.todayDate.value,document.frm.to,document.frm.todayDate,'Till Date Cannot be greater than Today\'s Date ','')==false)
		{
	      		return false;
		}
	*/
	
	
	if((frm.chkData.value==2) || (frm.chkData.value==3))
		{
						
		 if(document.frm.Yearly.value=="-1")
				{
					alert('<%=dbLabelBean.getLabel("alert.report.plaeaseselectyear",strsesLanguage) %>');
					document.frm.Yearly.focus();
					return false;
				}
	
		if(document.frm.Category.value=="-1")
				{
					alert('<%=dbLabelBean.getLabel("alert.report.pleaseselecttraveltype",strsesLanguage) %>');
					document.frm.Category.focus();
					return false;
				}
	
					return true;
		}
	
	   ///29-Jun-07  by shiv 
	
	   if((frm.chkData.value==4))
		{
			  
	
		if(document.frm.Category.value=="-1")
				{
					alert('<%=dbLabelBean.getLabel("alert.report.pleaseselecttraveltype",strsesLanguage) %>');
					document.frm.Category.focus();
					return false;
				}
				if(document.frm.Yearlynew.value=="-1")
				{
					alert('<%=dbLabelBean.getLabel("alert.report.plaeaseselectyearfrom",strsesLanguage) %>' );
					document.frm.Yearlynew.focus();
					return false;
				}
	
				if(document.frm.Yearlynext.value=="-1")
				{
					alert('<%=dbLabelBean.getLabel("alert.report.plaeaseselectyearto",strsesLanguage) %>' );
					document.frm.Yearlynext.focus();
					return false;
				}
	
				if (document.frm.Yearlynew.value>document.frm.Yearlynext.value)
			  {
				   alert('<%=dbLabelBean.getLabel("alert.report.fromyearnotgreaterthantoyear",strsesLanguage) %>' );
				  	document.frm.Yearlynew.focus();
					return false;
			 }
	
					return true;
		}
	
	
	 /////29-Jun-07 by shiv  
	
		if(document.frm.chkData.value=="-1")
				{
					alert('<%=dbLabelBean.getLabel("alert.report.pleaseselectreporttype",strsesLanguage) %>');
					document.frm.chkData.focus();
					return false;
				}
	
	}
	
	function EnableYearlyCombo(frm)
		{
			
	       //code modified by shiv on 02-Jul-07  open	 	 
	 	if((frm.chkData.value==2) || (frm.chkData.value==3))
		{	
		ComboBox.style.display = "";
		formToBox.style.display = "none";
		ComboBoxyearly.style.display = "none";
		}
	  
	 	if((frm.chkData.value==4))
		{	
	     ComboBox.style.display = "none";
	 	 formToBox.style.display = "none";
		ComboBoxyearly.style.display = "";
		//ComboBox.document.frm.Yearly.value=0;
		}
	
		if(frm.chkData.value==1)
		{
		ComboBox.style.display= "none";
		formToBox.style.display= "";
		ComboBoxyearly.style.display = "none";
		 
		}
		 //code modified by shiv on 02-Jul-07 close	
	
	}
	
	function YearlyValue(frm)
	{
	frm.yearlyvalue.value=frm.Yearly.value;
	
	}
	
	function openPieChart()
	{
	if(document.frm.PieChart[0].checked==true)
		{
		document.frm.PieHidden.value="PieChart";
		}
	if(document.frm.PieChart[1].checked==true)
		{
		document.frm.PieHidden.value="Manual";
		}
	
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
	</script>
	<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
	<!-- <SCRIPT language=JavaScript src="ScriptLibrary/validation.js?buildstamp=2_0_0"></SCRIPT>-->
	<script language="JavaScript" src="ScriptLibrary/date-picker.js?buildstamp=2_0_0"></script>
	
	<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
	</head>
	
	<%
	
	 Date currentDate = new Date();
	  SimpleDateFormat sdf1 = new SimpleDateFormat("dd/MM/yyyy");
	  String strCurrentDate11 = (sdf1.format(currentDate)).trim();
	  
	//System.out.println(strCurrentDate1);
	%>
	
	
	<%
	// Variables declared and initialized
	String strUserId	=null;
	Connection con,con1	=	null;			    // Object for connection
	Statement stmt,stmt1	=	null;			   // Object for Statement
	 
	ResultSet rs	=	null;
	
	con1=DriverManager.getConnection(Sdburl,Sdbuser,Sdbpwd);
	 /*int loadFlag=Integer.parseInt(request.getParameter("flag"));
	if(loadFlag==1)
	{
		strUserId="99999";
	}
	else
	{
		strUserId=Suser_id;
	}
	*/
	//Connection con2= null;
	//Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
	//con2 = DriverManager.getConnection("jdbc:odbc:star","sa","");
	//Statement stmt2 = con.createStatement();
	int intSerialNo=1;
	String	sSqlStr=""; // For sql Statements
	String	strRequisitionId	=	"";
	String	strRequisitionNo	=	"";
	String	strApproverName	=	"";
	int	intApproveStatus	=	0;
	String	strOrderId	=	"";
	int iCls = 0;
	String strStyleCls = "";
	int flag = 0;
	String strImage="";
	int count=0;
	%>
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
	      <li class="pageHead"><%=dbLabelBean.getLabel("label.report.starsreportperiodicanalysisreport",strsesLanguage) %></li>
	    </ul></td>	
	  </tr>
	  </table>
	
	

	<table width="100%" align="center" border="0" cellpadding="5" cellspacing="1"  class="formborder">
	<form method=post name=frm action="R_TravelUtilReport.jsp" target=_self onsubmit="openWaitingProcess();">  
	   <input type="hidden" name="flag" value="2">
	  <tr> 
	      <td class="formhead" colspan="2" align="Left"><%=dbLabelBean.getLabel("label.report.selectpreference",strsesLanguage) %></td> 
	  </tr>
	 </table>
	  
	  <table class="formtr3" width="100%" align="center" border="0">
	  <tr> 
		<td class="formtr3" align=center><select name="chkData" class="textboxCSS" onChange="EnableYearlyCombo(frm);">
			<option value = "-1"><%=dbLabelBean.getLabel("label.report.selectreporttype",strsesLanguage) %></OPTION>
			<option value="1">	<%=dbLabelBean.getLabel("label.report.monthly",strsesLanguage) %></option> 
			<option value="2">	<%=dbLabelBean.getLabel("label.report.quarterly",strsesLanguage) %></option>
			<option value="3">	<%=dbLabelBean.getLabel("label.report.halfyearly",strsesLanguage) %></option>
			<option value="4">	<%=dbLabelBean.getLabel("label.report.yearly",strsesLanguage) %></option>
			</select>
				<select name="Category"  class="textboxCSS" >
				<option value = "-1"><%=dbLabelBean.getLabel("label.report.selecttraveltype",strsesLanguage) %></OPTION>
				<OPTION value="2"><%=(ssflage.equals("3") ? "Domestic/Europe" : dbLabelBean.getLabel("label.report.domestic",strsesLanguage)) %></OPTION>
				<OPTION value="3"><%=(ssflage.equals("3") ? "Intercont" : dbLabelBean.getLabel("label.report.international",strsesLanguage)) %></OPTION>
			</select>
		<!--	<input type="radio" name="PieChart" value="PieChart" onClick="openPieChart();">PieChart
			<input type="radio" name="PieChart" value="Simple" checked onClick="openPieChart();">Manual Report -->	  </td>
		</tr>
	  <tr>
		 <td  class="formtr3" align=center><table width="100%" border="0" cellspacing="0" cellpadding="2">
	         <tr>
	           <th align="center" class="formtr3" scope="row">&nbsp;<%=dbLabelBean.getLabel("label.requestdetails.unit",strsesLanguage) %>
	             <select name="SelectUnit"  class="textboxCSS" onChange="UnitValue(frm);">
	   <% 
	
			  //Find Single Site or Multiple site Report Access
		/*	  String strReportAccess   = dbUtility.findReportAccessInMainMenu(SuserRole, SuserRoleOther, strSiteIdSS, Suser_id);
	
	
	
	
				  String strSql = "";
				  if(strReportAccess != null && strReportAccess.trim().equalsIgnoreCase("allSite"))
				  {
					  */
	%>
					<!-- <option value = "0">All</OPTION> -->
	<% /*
					strSql = "select distinct site_id,site_name from m_site where status_id=10 and application_id=1 ORDER BY 2";
	                rs       =   dbConBean.executeQuery(strSql);
				  }
				  else if(strReportAccess != null && strReportAccess.trim().equalsIgnoreCase("oneSite"))
				  {
	              //// code added  by Shiv Sharma on 24-Apr-07 open
				 
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
								*/ %>
	                              <!-- <option value=<%//=rs.getString(1)%>> <%//=rs.getString(2)%></option> -->
	                              <% /*
	
							 }//rs.close();
	                        ///query for unit head
							  strSql = "Select  SITE_ID,dbo.SITENAME(SITE_ID) FROM user_multiple_access  where status_id=10 and UNIT_HEAD=1  and SITE_ID NOT IN (SELECT  DISTINCT SITE_ID FROM  M_USERROLE WHERE STATUS_ID=10 AND USERID="+Suser_id+" ) ORDER BY 2";
						rs       =   dbConBean.executeQuery(strSql);
	
						 while(rs.next())
						      {  */
								 %>
	                              <!-- <option value=<%//=rs.getString(1)%>> <%//=rs.getString(2)%></option> -->
	                             <% /*
							 } 
							//rs.close();
	             				}
	     
	             /// code added by Shiv Sharma on 24-Apr-07 close
	
					/*strSql = "select distinct site_id,site_name from m_site where site_id="+strSiteIdSS+" and status_id=10 and application_id=1 ORDER BY 2";
				
				  }
				 // rs       =   dbConBean.executeQuery(strSql);
				  while(rs.next())
				  { */ 
	%>
			<!-- <option value=<%//=rs.getString(1)%>> <%//=rs.getString(2)%></option> -->
	<%  /*
				  } 
				  rs.close();
				  dbConBean.close();
				  */
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
			       <div id="ComboBox" style="display:none">	
			       <table class="formtr3" width="100%" align="left" border="0">   
				 	   <tr> 			    
					                 <td class="formtr3"   align=center>
			                            <select name="Yearly"  class="textboxCSS"  >
			                            <option value = "-1"><%=dbLabelBean.getLabel("label.report.selectyear",strsesLanguage) %></OPTION>
			                                      <% 
													String sql = "set dateformat dmy select distinct datepart(year, c_datetime) from t_travel_mst order by 1  ";
													ResultSet rs2 = dbConBean1.executeQuery(sql);
	
													while(rs2.next())
													{
													String Year = rs2.getString(1); /*@ Vijay Kumar Singh Date 14-Mar-2007  * Display the Sassion according to date */
	 
													int i=Integer.parseInt(Year)+1;
													String year=""+i;
													%>			
			                                      <option value=<%=Year%>> <%=Year%>-<%=year%></option>
			                                       <%
	 												}
													rs2.close(); dbConBean1.close();
													%>
			                               </select>
	
			           </td>
					  
					 </tr>
		            </table>
					</div>
	                   <!-- change  -->
					  <div id="ComboBoxyearly" style="display:none">	
			       <table class="formtr3" width="100%" align="left" border="0">   
				 	   <tr >  <td class="formtr3" align="right"  width="50%"><%=dbLabelBean.getLabel("label.approverrequest.from",strsesLanguage) %>
			                            <select name="Yearlynew"  class="textboxCSS"  >
			                              <option value = "-1"><%=dbLabelBean.getLabel("label.report.selectyear",strsesLanguage) %></OPTION> 
			                                      <% 
													 sql = "set dateformat dmy select distinct datepart(year, c_datetime) from t_travel_mst order by 1 ";
													  rs2 = dbConBean2.executeQuery(sql);
	
													while(rs2.next())
													{
													String Year = rs2.getString(1); /*@ Vijay Kumar Singh Date 14-Mar-2007  * Display the Sassion according to date */
													int i=Integer.parseInt(Year)+1;
													String year=""+i;
													%>			
			                                      <option value=<%=Year%>> <%=Year%>-<%=year%></option>
			                                       <%
	 
														}
														rs2.close(); 
														dbConBean1.close();
													%>
			                               </select>&nbsp; &nbsp; &nbsp;
	
			           </td>  <!--  New code added by shiv for adding new combo when "year" option is selected  on 02-Jul-07   open-->  
					   <td class="formtr3"  align="left" width="50%"> <%=dbLabelBean.getLabel("label.approverequest.to",strsesLanguage) %> 
					  
					              <select name="Yearlynext"  class="textboxCSS" >
			                            <option value = "-1"><%=dbLabelBean.getLabel("label.report.selectyear",strsesLanguage) %></OPTION>
										 <% 
													  sql = "set dateformat dmy select distinct datepart(year, c_datetime) from t_travel_mst order by 1 ";
													 rs2 = dbConBean3.executeQuery(sql);
													  
											 	while(rs2.next())
													{ 
														
													String Year = rs2.getString(1); 
													int i=Integer.parseInt(Year)+1;
													String year=""+i;
													//System.out.println("year>>>"+year);
													%>
												 <option value=<%=Year%>> <%=Year%>-<%=year%></option>
														<%
																							
												     }
														rs2.close(); 
														dbConBean3.close();
														
													%>
										</select>
					   <!--  New code added by shiv for adding new combo when "year" option is selected  on 02-Jul-07   close-->  
	
					   </td>
					 </tr>
		            </table>
					   
	               </div></th>
	          </tr>
	       </table>
		   
		   </td>
	    </tr>
	  
	  <tr>
	    <td  class="formtr3" align=center>
		<div id="formToBox" style="display:">
	
	<table class="formtr3" width="100%" align=left border="0">
		<tr>
		<td  class="formtr3" align=center>
		 <%=dbLabelBean.getLabel("label.approverrequest.from",strsesLanguage) %>       
		   <input  type=textbox  name="from"  size='10' maxlength="10" class="textboxCSS"  value="<%=strCurrDatenewBefore%>" onFocus="javascript:vDateType='DD/MM/YYYY'" onKeyUp="DateFormat(this,this.value,event,false,'DD/MM/YYYY','Invalid Date.Please Re-Enter')" onBlur="DateFormat(this,this.value,event,true,'DD/MM/YYYY','Invalid Date.Please Re-Enter')"  onChange="javascript:while(''+this.value.charAt(this.value.length-1)==' ')this.value=this.value.substring(0,this.value.length-1);" >
	        <a  href="javascript:show_calendar('frm.from','a','a','DD/MM/YYYY');"onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;"><img border="0" name="imageField" src="images/calender.png?buildstamp=2_0_0" align="absmiddle">        </a>		<%=dbLabelBean.getLabel("label.report.till",strsesLanguage) %>   
	        <input type=textbox name="to"  size='10' maxlength="10" class="textboxCSS"   value="<%=strCurrDate%>" onFocus="javascript:vDateType='DD/MM/YYYY'" onKeyUp="DateFormat(this,this.value,event,false,'DD/MM/YYYY','Invalid Date.Please Re-Enter')" onBlur="DateFormat(this,this.value,event,true,'DD/MM/YYYY','Invalid Date.Please Re-Enter')"   onChange="javascript:while(''+this.value.charAt(this.value.length-1)==' ')this.value=this.value.substring(0,this.value.length-1);" >        
	        <a  href="javascript:show_calendar('frm.to','a','a','DD/MM/YYYY');"onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;">
	        <img border="0" name="imageField" src="images/calender.png?buildstamp=2_0_0" align="absmiddle"></a>  </td>
	  </tr> 
		</table>
	</div>	</td>
	  </tr>
	  <tr>
	    <td  class="formtr3" align=center><table width="100%" border="0" cellspacing="0" cellpadding="0">
	      <tr>
	        <td  class="formtr3" align=center>
			<!--  <input type="hidden" name="yearlyvalue" value="2006">  -->
			 <input type=submit name="submit" value="<%=dbLabelBean.getLabel("label.report.viewreport",strsesLanguage) %>" class=formbutton onClick="return checkForm();"></td>
	      </tr>
	    </table></td>
	  </tr>
	  </table>
		
	  <p>
	  <!--	<a href="#" onClick="MM_openBrWindow('R_budgetUtilSummaryReport.jsp?flag=1','c','scrollbars=YES,width=800,height=500,resizable=yes')">View Budget Utilization Summary Report</a>-->
	  </p>
	  <p>
	    <input type="hidden" value="Manual" name="PieHidden">
		<input type="hidden" name="todayDate" value="<%=strCurrentDate11%>"/>
	    <input type="HIDDEN" name="UnitHidden" >
	   <!--  <input type="HIDDEN" name="UnitHidden" value="0"> -->
	    </p>
	</form>
	
	
	</body>
	</html>
