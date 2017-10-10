	<%
	/***************************************************
	 *The information contained here in is confidential and 
	 * proprietary to MIND and forms the part of the MIND 
	 *Author				:Himanshu Jain
	 *Date of Creation 		:28 August 2006
	 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
	 *Project	  			:STAR
	 *Operating environment :Tomcat, sql server 2000 
	 *Description 			:This is first jsp file  for edit the SITE in M_SITE table of STAR database
	 *Modification 			: 
	 *Reason of Modification: 
	 *Date of Modification  : make site name editable  by shv sharma on 12-Aug-09
	 						:Added new flag for  showing MATA for Ticket is optional on 02 dec-2009 by shiv sharma 
	 *Revision History		:
	 *Editor				:Editplus
	 :By vaibhav on oct 16 2010 to add mailid of reporting person in cc
	 
	 *Modified By			: MANOJ CHAND
	 *Modification			: Adding checkbox for closing unit
	 *Date of Modification	: 08 feb 2012
	 
	 *Modified By 			:Manoj Chand
	 *Modification Date		:17 Dec 2012
	 *Modification			:web service url textbox and site currency combo box updated.
	 
	 *Modified By 			:Manoj Chand
	 *Modification Date		:06 Mar 2013
	 *Modification			:add company combobox and remove web service url textbox.
	 
	 *Modified By 			:Manoj Chand
	 *Modification Date		:29 Apr 2013
	 *Modification			:To update tes request thresold count in site master.
	 
	 *Modified By 			:Manoj Chand
	 *Modification Date		:29 May 2013
	 *Modification			:add two field REMINDER INTERVAL & REMINDER FREQUENCY
	 
	 *Modified By 			:Manoj Chand
	 *Modification Date		:11 July 2013
	 *Modification			:TES related caption changed
	 
	 *Modified By	        :MANOJ CHAND
	 *Date of Modification  :22 October 2013
	 *Description			:uptotwohyphen function is added.
	*******************************************************/%>
	<%-- Import Statements  --%>
	<%@ include  file="importStatement.jsp" %>
	<%@ page import = "src.connection.DbConnectionBean" pageEncoding="UTF-8" %>
	
	<html>
	<head>
	<%-- include remove cache  --%>
	<%@ include  file="cacheInc.inc" %>
	<%-- include header  --%>
	<%@ include  file="headerIncl.inc" %>
	<%-- include page with all application session variables --%>
	<%@ include  file="application.jsp" %>
	<%-- include page styles  --%>
	<%-- <%@ include  file="systemStyle.jsp" %> --%>
	<!--Create the DbConnectionBean object for createConnection-->
	<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
	<jsp:useBean id="dbConBean1" scope="page" class="src.connection.DbConnectionBean" />
	<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
	
	<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
	<script language="JavaScript" src="ScriptLibrary/date-picker.js?buildstamp=2_0_0"></script>
	<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
	<script language=JavaScript src="ScriptLibrary/jQueryMaster.js?buildstamp=2_0_0"></script>
	<%
	// Variables declared and initialized
	ResultSet objRs			=		null;			  // Object for ResultSet
	String		strDivName			=	null;	//	Variable for storing division id
	String		strSiteName			=	null;	// Variable for storing site name
	String		strSiteDesc			=	null;	//Variable for storing site description
	String	strSqlStr	=	""; // For sql Statements
	String strSiteId				="";
	
	String strSMRSite		="";
	String strPriceInt			="";
	String strPriceDom			="";
	String strMailToR			="";
	String strClosedUnitFlag	="";
	strSiteId	 	 				=	request.getParameter("stId"); // GET SITE ID
	String strClosedRemark		= "";
	String strImplDate = "";
	String strBaseCur			= "";
	String strCompanyId			= "0";
	String strAgencyId			= "0";
	String mailToMATA			= "N";
	String strTESReqCount = null;
	String strReminderInterval = null;
	String strReminderFrequency = null;
	%>
	
<script>	
function fun_fillremark(){
	var x=document.getElementById("CheckUnit").checked;
	if(x)
	{
		document.getElementById("trr1").style.display='';
		document.getElementById("astrik").style.display='';
		document.getElementById("Closed_remark").focus();
	}else{
		document.getElementById("Closed_remark").value='';
		document.getElementById("trr1").style.display='none';
		document.getElementById("astrik").style.display='none';
	}
}
	
	function checkData()
	{
	
		var strDesc		= document.frm.Description.value;
		var strAgencyid = document.frm.agencyId.value;
		
		if(strAgencyid == '-1') {
			alert('Select Travel Site Agency');
			document.frm.agencyId.focus();
			return false;
		}
		else if(strDesc=='') {
			alert('<%=dbLabelBean.getLabel("alert.unit.pleaseenterunitdesc",strsesLanguage)%>');
			document.frm.Description.focus();
			return false;
		}
		else if(document.getElementById("CheckUnit").checked && document.frm.Closed_remark.value=='') {
			//var strRemark= document.frm.Closed_remark.value;
			//if(strRemark==''){
				alert('<%=dbLabelBean.getLabel("alert.unit.pleaseenterremarkbeforeclosingunit",strsesLanguage)%>');
				document.frm.Closed_remark.focus();
				return false;
			//}
		} else {
			return true;
		}
		
	}
	//function adde by manoj chand on 05 feb 2013 to test web service status
	function checkWS(flagval)
	{
		var path='';
		if(flagval=='MATA'){
			path=document.frm.wsurl.value;
		}else{
			path=document.frm.erpwsurl.value;	
		}
		if(path.trim()==''){
			//alert('Please enter web service url before test');
		}else{
		var urlAjax = "AjaxMaster.jsp";
		var param = 'strFlag=testWS&path='+path.trim()+'?wsdl';
		 jQuery.ajax({  
	         type: "post",           
	         url:  urlAjax,    
	         data: param,
	         success: function(result){
	        	 var rslt = result.replace(/^\s+|\s+$/g,"");
	        	 if(rslt == "Y")
	        	 {
	        		 alert('Web Service working properly.'); 
	        	 }
	        	 else
	        	 {
	        		 alert('Web Service not working.');
	        	 }
	         },    
		    error: function(result){  
		     	alert("Error ...");
		     }
		 });
		}
	}
	String.prototype.trim = function() {
		return this.replace(/^\s+|\s+$/g,"");
	};

	//function added by manoj chand on 29 april 2013 to make integer check on tesreqcount textbox
	//upToTwoHyphen function is added by manoj chand on 22 oct 2013
	function test2(obj1, length, str)
	{	
		
				var obj;
				if(obj1=='Sitename')
				{
					obj = document.frm.Sitename;
					upToTwoHyphen(obj);
				}
				if(obj1=='Description')
				{
					obj = document.frm.Description;
					upToTwoHyphen(obj);
				}
				if(obj1=='TESreqcount')
				{
					obj = document.frm.TESreqcount;
				}
				if(obj1=='ReminderInterval')
				{
					obj = document.frm.ReminderInterval;
				}
				if(obj1=='ReminderFrequency')
				{
					obj = document.frm.ReminderFrequency;
				}
				charactercheck(obj,str);
				limitlength(obj, length);
				spaceChecking(obj);
	}
	</script>
	
	</head>
	
	<%
	//ONE COLUMN CLOSED_UNIT_FLAG ADDED BY MANOJ CHAND ON 08 FEB 2012
		strSqlStr="SELECT   dbo.DIVISIONNAME(DIV_ID) AS DIV, SITE_NAME, SITE_DESC, ISNULL(SMR_SITE_FLAG,'N') AS SMR_SITE_FLAG, ISNULL(INT_LOCAL_AGENT,'N') AS INT_LOCAL_AGENT, iSNULL(DOM_LOCAL_AGENT,'N') AS DOM_LOCAL_AGENT , MAIL_TO_REPORTING,ISNULL(CLOSED_UNIT_FLAG,'') AS CLOSED_UNIT_FLAG,ISNULL(CLOSED_REMARK,'') AS CLOSED_REMARK,ISNULL(convert(varchar(10),IMPL_DATE,103),'') AS IMPL_DATE,CURRENCY,ISNULL(COMPANY_ID,'') AS COMPANY_ID,isnull(TES_COUNT,'0') as TES_COUNT,ISNULL(REMINDER_INTVL,'0') AS REMINDER_INTVL,ISNULL(REMINDER_FRQ,'0') AS REMINDER_FRQ"+
				  ",TRAVEL_AGENCY_ID,MAIL_TO_MATA FROM M_SITE WHERE STATUS_ID=10 AND SITE_ID='"+strSiteId+"'";
	//System.out.println("strSqlStr--->"+strSqlStr);
		objRs	 = dbConBean.executeQuery(strSqlStr);
	
		while(objRs.next())
		{
	
						strDivName	 			= objRs.getString(1);
						strSiteName	 			= objRs.getString(2);
						strSiteDesc   			= objRs.getString(3);
						
						strSMRSite				= objRs.getString(4).toLowerCase();
						strPriceInt				= objRs.getString(5).toLowerCase().trim();
						strPriceDom				= objRs.getString(6).toLowerCase().trim();
						strMailToR				= objRs.getString(7).toLowerCase();
						strClosedUnitFlag		= objRs.getString("CLOSED_UNIT_FLAG").toLowerCase();
						strClosedRemark			= objRs.getString("CLOSED_REMARK").trim();
						strImplDate				= objRs.getString("IMPL_DATE");
						//System.out.println("strImplDate--edit->"+strImplDate);
						if(strImplDate.equals("01/01/1900"))
							strImplDate	="";
						
						strBaseCur				= objRs.getString("CURRENCY");
						strCompanyId			= objRs.getString("COMPANY_ID");
						strTESReqCount			= objRs.getString("TES_COUNT");
						strReminderInterval		= objRs.getString("REMINDER_INTVL");
						strReminderFrequency	= objRs.getString("REMINDER_FRQ");
						strAgencyId				= objRs.getString("TRAVEL_AGENCY_ID");
						mailToMATA				= objRs.getString("MAIL_TO_MATA");
		}
	objRs.close();
	//dbConBean.close();
	
	%>
	<!-- Start of body -->
	
	<body><script type="text/javascript" language="JavaScript1.2" src="menu/menu_cnt.js?buildstamp=2_0_0"></script>
	
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	  <tr>
	    <td width="77%" height="38" class="bodyline-top">
		<ul class="pagebullet">
	      <li class="pageHead"><%=dbLabelBean.getLabel("label.unit.unit",strsesLanguage)%></li>
	    </ul></td>	
		<td width="23%" height="38" align="right" valign="bottom" class="bodyline-top">
		<table align="right" border="0" cellspacing="0" cellpadding="0">
	      <tr align="right">
	      <td>
	      <ul id="list-nav">
	      <li><a href="M_siteList.jsp"><%=dbLabelBean.getLabel("label.global.list",strsesLanguage)%></a></li>
	      </ul>
	      </td>
	               
	      </tr>
	    </table>
		</td>
	  </tr>
	</table>
	<!-- Start of Form -->
	<form method=post name=frm action="M_siteEditPost.jsp" onSubmit="javascript:return checkData();">
	<table width="70%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder">
	<tr align="left"> 
		<td class="formtr2" width="35%"><%=dbLabelBean.getLabel("label.requestdetails.division",strsesLanguage)%></td>	<!-- DIVISION -->
		<td width="65%" class="formtr1"><input type="text" maxlength=50 name=Division value="<%=strDivName%>" class="textBoxCss" style="width:170px;" READONLY> </td>
	</tr>
	
	<tr align="left"> 
		<td class="formtr2" width="35%"><%=dbLabelBean.getLabel("label.sitemaster.travelsiteagency",strsesLanguage)%></td>	<!-- Travel Site Agency -->
		<td width="65%" class="formtr1">
			<select name="agencyId" class="textBoxCss" style="width:170px;">
		      	<option value="-1" 	<% 	if (strAgencyId.equals("") || strAgencyId == null){ %>
										selected="selected"
					      			<%	} %> 
		      	><%=dbLabelBean.getLabel("label.sitemaster.selectagency",strsesLanguage)%></option>
		      	
		        <option value="1" 	<% 	if (strAgencyId.equals("1")){ %>
										selected="selected"
					      			<%	} %>
		        ><%=dbLabelBean.getLabel("label.sitemaster.mataindia",strsesLanguage)%></option>
		        
		        <option value="2" 	<% 	if (strAgencyId.equals("2")){ %>
										selected="selected"
					      			<%	} %>
		        ><%=dbLabelBean.getLabel("label.sitemaster.matagmbh",strsesLanguage)%></option>
		        
		        <option value="0" 	<% 	if (strAgencyId.equals("0")){ %>
										selected="selected"
					      			<%	} %>
		        ><%=dbLabelBean.getLabel("label.mylinks.others",strsesLanguage)%></option>
	      	</select>
		</td>
	</tr>
	
	<tr align="left"> 
	<td class="formtr2" width="35%"><%=dbLabelBean.getLabel("label.global.unitname",strsesLanguage)%></td>	<!-- SITE NAME -->
	<td width="65%"class="formtr1"><input type="text" size=20 maxlength=50 name=Sitename value="<%=strSiteName%>" class="textBoxCss" onKeyUp="return test2('Sitename', 12, 'all')"> </td>
	</tr>
	
	<tr align="left"> 
	<td class="formtr2" width="35%"><%=dbLabelBean.getLabel("label.unit.unitdescription",strsesLanguage)%></td>	<!-- TO MODIFY THE SITE DESCRIPTION --> 
	<td width="65%" class="formtr1"><input type="text" size=30 maxlength=50 name=Description value="<%=strSiteDesc%>" class="textBoxCss" onKeyUp="return test2('Description', 50, 'all')"> </td> 
	</tr>
	<tr align="left">  
	<td class="formtr2" width="35%"><%=dbLabelBean.getLabel("label.unit.smrunit",strsesLanguage)%></td>	<!-- TO MODIFY THE SITE DESCRIPTION --> 
	<td width="65%" class="formtr1"><input type="radio" name="SMRSITE" value="y" >&nbsp;<%=dbLabelBean.getLabel("label.global.yes",strsesLanguage)%>  &nbsp; &nbsp;<input type="radio" name="SMRSITE" value="n" checked="checked">&nbsp;<%=dbLabelBean.getLabel("label.global.no",strsesLanguage)%></td> 
	
	<script language=JavaScript >  
	 
	if('<%=strSMRSite%>'=='y'){ 
	    
		document.frm.SMRSITE[0].checked="true";   
	}	
	else{
	 
    	document.frm.SMRSITE[0].checked ="";        
    }	
	 	
	</script>
	
	</tr>
	<tr align="left">    
	<td class="formtr2" width="35%"><%=dbLabelBean.getLabel("label.unit.ticketpricefromalternatesource",strsesLanguage)%></td>	<!-- TO MODIFY THE SITE DESCRIPTION -->
	<td width="65%" class="formtr1"><input type="checkbox" name="PriceforInt" value="I" ><%=dbLabelBean.getLabel("label.report.international",strsesLanguage)%> 
	
	<script language=JavaScript >
	var x='<%=strPriceInt%>';
	   
	if(x=='y'){ 
		document.frm.PriceforInt.checked=true;      
	}	
	else{
		document.frm.PriceforInt.checked ="";        
    }	
	 	
	</script>&nbsp;
	&nbsp;
	<input type="checkbox" name="PriceforDom" value="D" ><%=dbLabelBean.getLabel("label.report.domestic",strsesLanguage)%>
		<script language=JavaScript >
		var x='<%=strPriceDom%>';
		  
	if(x=='y'){ 
		document.frm.PriceforDom.checked=true;  
	}	
	else{
    	document.frm.PriceforDom.checked ="";   
    }	
	 	
	</script></td>
	</tr>
	<!-- tr added by vaibhav  on oct 16 2010 to add mailid of reporting person in cc -->
	<tr align="left">  
		<td class="formtr2" width="35%"><%=dbLabelBean.getLabel("label.unit.mailtoreportingperson",strsesLanguage)%></td>	<!-- TO MODIFY THE SITE DESCRIPTION --> 
		<td width="65%" class="formtr1"><input type="radio" name="MailToR" value="y" >&nbsp;<%=dbLabelBean.getLabel("label.global.yes",strsesLanguage)%>  &nbsp; &nbsp;<input type="radio" name="MailToR" value="n" checked="checked">&nbsp;<%=dbLabelBean.getLabel("label.global.no",strsesLanguage)%></td> 
		
		<script language=JavaScript >  
			if('<%=strMailToR%>'=='y'){ 
				document.frm.MailToR[0].checked="true";   
			} else {
		    	document.frm.MailToR[0].checked ="";        
		    }	
		</script>
	</tr>
	
	<tr align="left">  
		<td class="formtr2" width="35%"><%=dbLabelBean.getLabel("label.sitemaster.mailtomata",strsesLanguage)%></td>
		<td width="65%" class="formtr1">
		
			<input type="radio" name="mailToMATA" id="mailToMATA_Y" value="Y" 
		<%		if(strAgencyId.equals("0")) { %>
					disabled="disabled"
		<%		} %>
			>&nbsp;<%=dbLabelBean.getLabel("label.global.yes",strsesLanguage)%>&nbsp; &nbsp;
			<input type="radio" name="mailToMATA" id="mailToMATA_N" value="N" checked="checked"
		<%		if(strAgencyId.equals("0")) { %>
					disabled="disabled"
		<%		} %>	
			>&nbsp;<%=dbLabelBean.getLabel("label.global.no",strsesLanguage)%>
		</td> 
		
		<script language=JavaScript >  
			if('<%=mailToMATA%>'=='Y'){ 
				document.frm.mailToMATA[0].checked="true";   
			} else {
		    	document.frm.mailToMATA[0].checked ="";        
		    }	
		</script>
	</tr>
	
	<tr>
	<td class="formtr2" width="35%"><%=dbLabelBean.getLabel("label.unit.implementationdate",strsesLanguage)%></td>
	<td width="65%" class="formtr1"><input type="text" name="impldate" id="impldate" size='10' maxlength="10" class="textboxCSS" onFocus="javascript:vDateType='DD/MM/YYYY'" onKeyUp="DateFormat(this,this.value,event,false,'DD/MM/YYYY','Invalid Date.Please Re-Enter')" onBlur="DateFormat(this,this.value,event,true,'DD/MM/YYYY','Invalid Date.Please Re-Enter')"  value="<%=strImplDate %>" onChange="javascript:while(''+this.value.charAt(this.value.length-1)==' ')this.value=this.value.substring(0,this.value.length-1);" >
        <a id="datepickfrom" href="javascript:show_calendar('frm.impldate','a','a','DD/MM/YYYY');"onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;"><img border="0" name="imageField" src="images/calender.png?buildstamp=2_0_0" align="absmiddle"></a></td>
	</tr>
	
	
	<!-- tr added by manojchand  on 08 feb 2012 to closed unit-->
	<tr align="left">  
		<td class="formtr2" width="35%"><%=dbLabelBean.getLabel("label.unit.unitclosed",strsesLanguage)%></td>
		<td width="65%" class="formtr1"><input type="checkbox" name="CheckUnit" value="y" onclick="return fun_fillremark();" ></td> 
		
		<script language=JavaScript >  
		 
			if('<%=strClosedUnitFlag.trim()%>'=='y'){ 
				document.frm.CheckUnit.checked=true;      
			}	
			else{
				document.frm.CheckUnit.checked ="";        
		    }	
		</script>
	</tr>
		
	<!-- added by manoj chand on 14 dec 2012 to add Base Currency and Web Service Url -->
    <tr align="left">
      <td class="formtr2" width="35%"><%=dbLabelBean.getLabel("label.currency.basecurrency",strsesLanguage)%></td>
      <td width="65%" class="formtr1">
      	<select name="baseCurrency" id="baseCurrency" class="textBoxCss">
	     <option value=""><%=dbLabelBean.getLabel("label.createrequest.selectcurrency",strsesLanguage) %></option>
			<%
			objRs=null;
			strSqlStr = "Select rtrim(Currency), rtrim(Currency) from m_currency where status_id=10";
			objRs       =   dbConBean.executeQuery(strSqlStr); 
				while (objRs.next()) {
			%>
                         <option value="<%=objRs.getString(1)%>"><%=objRs.getString(2)%></option>  
			<%}
				objRs.close();
					%>
        </select>
        <script type="text/javascript">
        	document.getElementById("baseCurrency").value="<%=strBaseCur%>";
        </script>
      </td>
    </tr>
    <!-- added by manoj chand on 07 Mar 2013 to add company-->
    <tr align="left">
      <td class="formtr2" width="35%"><%=dbLabelBean.getLabel("submenu.master.company",strsesLanguage)%></td>
      <td width="65%" class="formtr1">
      	<select name="company" id="Company" class="textBoxCss">
	     <option value="0"><%=dbLabelBean.getLabel("label.global.notapplicable",strsesLanguage) %></option>
			<%
			objRs=null;
			strSqlStr = "Select CID, ltrim(rtrim(COMPANY_NAME)) from m_company where status_id=10";
			objRs       =   dbConBean.executeQuery(strSqlStr); 
				while (objRs.next()) {
			%>
                         <option value="<%=objRs.getString(1)%>"><%=objRs.getString(2)%></option>  
			<%}
				objRs.close();
				dbConBean.close();    // close all the connections
		%>
        </select>
        <script type="text/javascript">
        	document.getElementById("Company").value="<%=strCompanyId%>";
        </script>
        <span style="color: red">*</span>&nbsp;<%=dbLabelBean.getLabel("label.company.applicableincas",strsesLanguage) %>
      </td>
    </tr>
	<!-- end here -->
	<!--  ADDED BY MANOJ CHAND ON 29 APR 2013 TO UPDATE TES REQUEST THRESOLD LIMIT -->
	<tr align="left"> 
	<td class="formtr2" width="35%"><%=dbLabelBean.getLabel("alert.site.reqlimitwithouttes",strsesLanguage) %></td>
	<td width="65%"class="formtr1"><input type="text" size="3" maxlength="2" name="TESreqcount" value="<%=strTESReqCount%>" class="textBoxCss" onKeyUp="return test2('TESreqcount', 2, 'n')"> 
	<span style="color: red">*</span>&nbsp;<%=dbLabelBean.getLabel("label.unit.numberofrequestallowed",strsesLanguage) %>
	</td>
	</tr>
	
	<!--  ADDED BY MANOJ CHAND ON 29 MAY 2013 TO UPDATE REMINDER INTERVAL AND REMINDER FREQUENCY -->
	<tr align="left"> 
	<td class="formtr2" width="35%"><%=dbLabelBean.getLabel("label.site.reminderinterval",strsesLanguage) %></td>	
	<td width="65%"class="formtr1"><input type="text" size="3" maxlength="2" name="ReminderInterval" value="<%=strReminderInterval%>" class="textBoxCss" onKeyUp="return test2('ReminderInterval', 2, 'n')"> 
	<span style="color: red">*</span>&nbsp;<%=dbLabelBean.getLabel("label.unit.daysafterapproved",strsesLanguage) %>
	</td>
	</tr>
	<tr align="left"> 
	<td class="formtr2" width="35%"><%=dbLabelBean.getLabel("label.site.reminderfrequency",strsesLanguage) %></td>	
	<td width="65%"class="formtr1"><input type="text" size="3" maxlength="2" name="ReminderFrequency" value="<%=strReminderFrequency%>" class="textBoxCss" onKeyUp="return test2('ReminderFrequency', 2, 'n')">
	<span style="color: red">*</span>&nbsp;<%=dbLabelBean.getLabel("label.unit.daysafterfirstreminder",strsesLanguage) %>
	 </td>
	</tr>
	
	<tr align="left" id="trr1" style="display: none;">  
	<td class="formtr2" width="35%"><%=dbLabelBean.getLabel("label.createrequest.remarks",strsesLanguage)%><span id="astrik" style="color: red;display: none;">*</span></td>
	<td width="65%" class="formtr1">
	<textarea cols=25 rows=3 name="Closed_remark" class=textBoxCss ></textarea>
	</td> 	
	<script language=JavaScript >  
	 
	if('<%=!strClosedRemark.equalsIgnoreCase("")%>'){ 
		document.frm.Closed_remark.value='<%=strClosedRemark%>';
	}	
	else{
		document.frm.Closed_remark.value="";        
    }	
	 	
	</script>
	</tr>
	
	  <tr align="center"> 
	    <td class="formBottom" colspan="2">
	      <input type="submit" name="Submit" value="<%=dbLabelBean.getLabel("label.suggestions.update",strsesLanguage)%>" class="formButton" >
	      <input type="Reset" name="Submit2" value="<%=dbLabelBean.getLabel("button.global.reset",strsesLanguage)%>" class="formButton" >
	    </td>
	  </tr>
	        <input type="hidden" name="status_id" value="10" >
			<input type="hidden" name="strSiteId" value="<%=strSiteId%>">
	
	</table>
	<script>
	//fun_fillremark();
	//added by manoj chand on 14 feb 2012 to show remark textarea if closed unit checkbox is checked.
	var x=document.getElementById("CheckUnit").checked;
	if(x)
	{
		document.getElementById("trr1").style.display='';
		document.getElementById("astrik").style.display='';
		//document.getElementById("Closed_remark").focus(); 
	}
	
	$('[name=agencyId]').change(function() {
		var agencyId = $("[name=agencyId] option:selected").val();
		
		if (agencyId == "0") {	
			$('#mailToMATA_Y').attr("checked",false);
			$('#mailToMATA_N').attr("checked",true);
			$('[name=mailToMATA]').attr("disabled",true);
		
		} else {	
			$('[name=mailToMATA]').attr("disabled",false);
		}
	});
	</script>
	
	</form>
	<!-- End of Form -->
	</body>
	</html>
