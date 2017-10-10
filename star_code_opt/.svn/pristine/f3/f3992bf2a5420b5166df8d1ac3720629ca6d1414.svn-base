<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:MANOJ CHAND
 *Date of Creation 		:03 May 2013
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STARS
 *Operating environment :Tomcat 6.0, sql server 2008 
 *Description 			:To show AD USER Sync data 
 
 *Modified By			:Manoj Chand
 *Date of Modification	:24 Oct 2013
 *Modification			:javascript validation to stop from typing --,'  symbol is added.
 *******************************************************/
%>

<%@ page pageEncoding="UTF-8" %>
<%@ include  file="importStatement.jsp" %>
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
<jsp:useBean id="dbUtilityBean" scope="page" class="src.connection.DbUtilityMethods" />
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>

<%
ResultSet rs			=		null;			  // Object for ResultSet
String	sSqlStr         =       "";                         // For sql Statements
int iCls                =       0;
String strStyleCls      =       "";
String strDateFrom = request.getParameter("dateFrom")==null?"":request.getParameter("dateFrom");
String strActionType = request.getParameter("actionType")==null?"":request.getParameter("actionType");
String strProcess = request.getParameter("process")==null?"":request.getParameter("process");
String strUpdatedSIDNo = request.getParameter("updatedsidno")==null?"":request.getParameter("updatedsidno");
String strMessage = request.getParameter("message")==null?"":request.getParameter("message");

//System.out.println("strDateFrom-->"+strDateFrom);
//System.out.println("strProcess-->"+strProcess);
String strSql = null;
//session.setAttribute("dateFrom",strDateFrom); 
//session.setAttribute("actionType",strActionType);
//session.setAttribute("process",strProcess);
%>

<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" media="screen" href="jqGrid/themes/sand/grid.css?buildstamp=2_0_0" />
<link rel="stylesheet" type="text/css" media="screen" href="jqGrid/css/jquery-ui.css?buildstamp=2_0_0" />
<link rel="stylesheet" type="text/css" media="screen" href="jqGrid/themes/jqModal.css?buildstamp=2_0_0" />

<script language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></script>
<script language="JavaScript" src="ScriptLibrary/date-picker-adSync.js?buildstamp=2_0_0"></script>
<script src="jqGrid/commonresources/sortable.js?buildstamp=2_0_0" type="text/javascript"></script>
<script src="jquery.js?buildstamp=2_0_0" type="text/javascript"></script>
<script src="jquery.jqGrid.js?buildstamp=2_0_0" type="text/javascript"></script>
<script src="js/jqModal.js?buildstamp=2_0_0" type="text/javascript"></script>
<script src="js/jqDnR.js?buildstamp=2_0_0" type="text/javascript"></script>
		
<script type="text/javascript">

	//charactercheck function is added by manoj chand on 22 oct 2013
	function test1(obj1, length, str)
	{	
		var obj;
		if(obj1=='search_SITE_NAME1')
		{
			obj = document.frm.search_SITE_NAME1;
		}
		charactercheck(obj,str);
		spaceChecking(obj);
	}

	function getProcess(){
		var var_date=document.frm.dateFrom.value;
		document.frm.process.value = '';
		window.document.frm.action="M_ADUserSync.jsp?dateFrom="+var_date;
		document.frm.submit();
		}
	
	function searchFunActionTaken(f1){		
		var dateFrom=f1.dateFrom.value;
		var process=f1.process.value;
		var actionType=f1.actionType.value;	
		if(dateFrom == ""){
			alert('<%=dbLabelBean.getLabel("alert.user.pleaseselectdate",strsesLanguage)%>');
			document.forms[0].dateFrom.focus();
			return false;
			}	
		else if(process == ""){
			alert('<%=dbLabelBean.getLabel("alert.user.pleaseselectprocess",strsesLanguage)%>');
			document.forms[0].process.focus();
			return false;
			}
		else{
		f1.action="M_ADUserSync.jsp?dateFrom="+dateFrom+"&process="+process+"&actionType="+actionType;
		f1.submit();
		return true;
		}
		
		}
	var BrowserDetect = {
			init: function () {
				this.browser = this.searchString(this.dataBrowser) || "An unknown browser";
				this.version = this.searchVersion(navigator.userAgent)
					|| this.searchVersion(navigator.appVersion)
					|| "an unknown version";
				this.OS = this.searchString(this.dataOS) || "an unknown OS";
			},
			searchString: function (data) {
				for (var i=0;i<data.length;i++)	{
					var dataString = data[i].string;
					var dataProp = data[i].prop;
					this.versionSearchString = data[i].versionSearch || data[i].identity;
					if (dataString) {
						if (dataString.indexOf(data[i].subString) != -1)
							return data[i].identity;
					}
					else if (dataProp)
						return data[i].identity;
				}
			},
			searchVersion: function (dataString) {
				var index = dataString.indexOf(this.versionSearchString);
				if (index == -1) return;
				return parseFloat(dataString.substring(index+this.versionSearchString.length+1));
			},
			dataBrowser: [
				{
					string: navigator.userAgent,
					subString: "Chrome",
					identity: "Chrome"
				},
				{ 	string: navigator.userAgent,
					subString: "OmniWeb",
					versionSearch: "OmniWeb/",
					identity: "OmniWeb"
				},
				{
					string: navigator.vendor,
					subString: "Apple",
					identity: "Safari",
					versionSearch: "Version"
				},
				{
					prop: window.opera,
					identity: "Opera",
					versionSearch: "Version"
				},
				{
					string: navigator.vendor,
					subString: "iCab",
					identity: "iCab"
				},
				{
					string: navigator.vendor,
					subString: "KDE",
					identity: "Konqueror"
				},
				{
					string: navigator.userAgent,
					subString: "Firefox",
					identity: "Firefox"
				},
				{
					string: navigator.vendor,
					subString: "Camino",
					identity: "Camino"
				},
				{		// for newer Netscapes (6+)
					string: navigator.userAgent,
					subString: "Netscape",
					identity: "Netscape"
				},
				{
					string: navigator.userAgent,
					subString: "MSIE",
					identity: "Explorer",
					versionSearch: "MSIE"
				},
				{
					string: navigator.userAgent,
					subString: "Gecko",
					identity: "Mozilla",
					versionSearch: "rv"
				},
				{ 		// for older Netscapes (4-)
					string: navigator.userAgent,
					subString: "Mozilla",
					identity: "Netscape",
					versionSearch: "Mozilla"
				}
			],
			dataOS : [
				{
					string: navigator.platform,
					subString: "Win",
					identity: "Windows"
				},
				{
					string: navigator.platform,
					subString: "Mac",
					identity: "Mac"
				},
				{
					   string: navigator.userAgent,
					   subString: "iPhone",
					   identity: "iPhone/iPod"
			    },
				{
					string: navigator.platform,
					subString: "Linux",
					identity: "Linux"
				}
			]

		};
		BrowserDetect.init();

		jQuery(document).ready(
				function(){ jQuery("#list").jqGrid({ 
					url:'JqGridAdSync?dateFrom=<%=strDateFrom%>&process=<%=strProcess%>&actionType=<%=strActionType%>', 
					datatype: 'json', 
					//datastr :  jsonstr,
					mtype: 'GET', 
					colNames:['#','<%=dbLabelBean.getLabel("label.approverequest.action",strsesLanguage)%>',
							  'AD FETCH DATE',
					          '<%=dbLabelBean.getLabel("label.user.sid",strsesLanguage)%>',
					          '<%=dbLabelBean.getLabel("label.mylinks.windowsuserid",strsesLanguage)%>',
					          '<%=dbLabelBean.getLabel("label.master.domainname",strsesLanguage)%>',
					          '<%=dbLabelBean.getLabel("label.global.firstname",strsesLanguage)%>',
					    '<%=dbLabelBean.getLabel("label.mylinks.middlename",strsesLanguage)%>',
					          '<%=dbLabelBean.getLabel("label.global.lastname",strsesLanguage)%>',
					          '<%=dbLabelBean.getLabel("label.mylinks.employeecode",strsesLanguage)%>',
					          '<%=dbLabelBean.getLabel("label.user.loginname",strsesLanguage)%>', 
					          '<%=dbLabelBean.getLabel("label.global.emailid",strsesLanguage)%>',
					          '<%=dbLabelBean.getLabel("label.global.gender",strsesLanguage)%>',
					          '<%=dbLabelBean.getLabel("label.global.dob",strsesLanguage)%>',
					          '<%=dbLabelBean.getLabel("label.user.residentialaddress",strsesLanguage)%>',
					          '<%=dbLabelBean.getLabel("label.user.officialaddress",strsesLanguage)%>',
					          '<%=dbLabelBean.getLabel("label.user.phoneno",strsesLanguage)%>',
					          '<%=dbLabelBean.getLabel("label.global.mobileno",strsesLanguage)%>',
					          '<%=dbLabelBean.getLabel("label.user.faxno",strsesLanguage)%>',
				          '<%=dbLabelBean.getLabel("label.global.passportnumber",strsesLanguage)%>',
				          '<%=dbLabelBean.getLabel("label.global.dateofissue",strsesLanguage)%>',
				          '<%=dbLabelBean.getLabel("label.global.expirydate",strsesLanguage)%>',
				          '<%=dbLabelBean.getLabel("label.createrequest.placeofissue",strsesLanguage)%>',
				          '<%=dbLabelBean.getLabel("label.register.reportto",strsesLanguage)%>',
					          '<%=dbLabelBean.getLabel("submenu.master.company",strsesLanguage)%>',
					          '<%=dbLabelBean.getLabel("label.user.country",strsesLanguage)%>',
					          '<%=dbLabelBean.getLabel("label.requestdetails.department",strsesLanguage)%>',
					          '<%=dbLabelBean.getLabel("label.global.designation",strsesLanguage)%>',
					          '<%=dbLabelBean.getLabel("label.user.actionmode",strsesLanguage)%>',
					          '<%=dbLabelBean.getLabel("label.requestdetails.status",strsesLanguage)%>',
					          '',
					          '',
					          ''], 
					colModel :[ 
								{name:'sno', index:'sno', width:30,search:false,sortable:false}, 
								{name:'ACTION_TYPE', index:'ACTION_TYPE', width:55, sortable:false,search:false},
								{name:'FETCH_DATE', index:'FETCH_DATE', width:95,search:false},
								{name:'SID', index:'SID', width:130,search:false},
								{name:'WIN_USER_ID', index:'WIN_USER_ID', width:110,search:false}, 
								{name:'DOMAIN_NAME', index:'DOMAIN_NAME', width:110,search:false}, 
								{name:'FIRST_NAME', index:'FIRST_NAME', width:130},
								{name:'MIDDLE_NAME', index:'MIDDLE_NAME', width:130}, 
								{name:'LAST_NAME', index:'LAST_NAME', width:100} ,
								{name:'EMP_CODE', index:'EMP_CODE', width:100},
								{name:'LOGIN_NAME', index:'LOGIN_NAME', width:100}, 
								{name:'EMAIL', index:'EMAIL', width:130, search:false},
								{name:'GENDER', index:'GENDER', width:60, search:false}, 
								{name:'DATE_OF_BIRTH', index:'DATE_OF_BIRTH', width:100,search:false}, 
								{name:'EMP_RES_ADDRESS', index:'EMP_RES_ADDRESS', width:130,search:false}, 
								{name:'EMP_OFF_ADDRESS', index:'EMP_OFF_ADDRESS', width:130,search:false}, 
								{name:'PHONE_NO', index:'PHONE_NO', width:110,search:false}, 
								{name:'MOBILE_NO', index:'MOBILE_NO', width:110,search:false}, 
								{name:'FAX_NO', index:'FAX_NO', width:110,search:false}, 
						{name:'PASSPORT_NO', index:'PASSPORT_NO', width:110,search:false}, 
						{name:'DATE_ISSUE', index:'DATE_ISSUE', width:100,search:false},
						{name:'EXPIRY_DATE', index:'EXPIRY_DATE', width:100,search:false}, 
						{name:'PLACE_ISSUE', index:'PLACE_ISSUE', width:100,search:false},
						{name:'REPORT_TO', index:'REPORT_TO', width:110,search:false}, 
								{name:'COMPANY', index:'COMPANY', width:130,search:false}, 
								{name:'COUNTRY', index:'COUNTRY', width:80,search:false}, 
								{name:'DEPT_NAME', index:'DEPT_NAME', width:110,search:false}, 
								{name:'DESI_NAME', index:'DESI_NAME', width:110,search:false}, 
								{name:'ACTION_MODE', index:'ACTION_MODE', width:90,search:false}, 
								{name:'STATUS', index:'STATUS', width:50,search:false}, 
								{name:'PROCESS_ID', index:'PROCESS_ID', width:0,search:false},
								{name:'AD_FETCH_DATE', index:'AD_FETCH_DATE', width:0,search:false},
								{name:'', index:'', width:0, sortable:false}
		   					   ],
		   		pager: jQuery('#pager'), 
		   			rowNum:30, 
		   			sortname: 'id', 
		   		 	altRows:true,
					recordpos: 'left', 
					rowList:[10,20,30],
					viewrecords: true,
					sortorder: "desc",
					rownumbers: true,
					multiselect:true,
					multiboxonly:true,
					shrinkToFit:false,
					//celledit:true,
					onSelectAll: function(){
		            	var checkBox;
		            	var len = $('.cbox').length;
					for(loop=0;loop<len;loop++){
						checkBox = $('.cbox')[loop];
		                if(checkBox.disabled){
		                    checkBox.checked = false ;
		                }
					}			   
		            }, 
					height:373,
					width:getWidth(),
					imgpath: 'jqGrid/themes/sand/images'
					}); 
				jQuery("#list").navGrid('#pager',{edit:false,add:false,del:false,search:false,refresh:false,view:false});
				setTimeout('updatePending()',0);
				
				});

		function getWidth(){
			var tabrtele = document.getElementById("actionType");
			//var xy = getXYpos(tabrtele);
			var var_off = $('#actionType').offset().left;
			//alert('test-->'+(xy.x + 157)) 
			return (var_off + 157);//841
			}

		function getXYpos(elem) {
			   if (!elem) {
			      return {"x":0,"y":0};
			   }
			   var xy={"x":elem.offsetLeft,"y":elem.offsetTop}
			   var par=getXYpos(elem.offsetParent);
			   for (var key in par) {
			      xy[key]+=par[key];
			   }
			   return xy;
				}
				formatesno = function(el, cellval, opts){ 
				$(el).html(snoFormat(cellval,opts)); 
				} 
				function snoFormat(value,option) {
				return ("<img id ='load"+option.rowId+"' style='display:none' src='<c:out value='${images}' />gridloading.gif?buildstamp=2_0_0' border='0' alt='<bean:message key='comments.display'/>' /><DIV id='data"+option.rowId+"' style='display:block'>"+value+"</DIV>");
				}

				function check1(frm)
				{	
				var ss = null;
				var s= []; 
				ss = jQuery("#list").getGridParam('selarrrow');
				var k = 0;
				for(var ii=0;ii<ss.length;ii++){
					if(!($('#jqg_'+ss[ii]).attr('disabled'))){
						s[k] = ss[ii];
						k++;
					}
				}	
				if(s.length==0){
					 alert('<%=dbLabelBean.getLabel("label.user.pleaseselectatleast",strsesLanguage)%>');
				   	 return false;
					}

					var recordCount = 0; 
					recordCount = s.length;
					var reqChk=new Array(recordCount);
					var fetchDate = new Array(recordCount);
					var processId = new Array(recordCount);
					
					for (i = 0; i < recordCount; i++)
					{
						var rowdata = jQuery("#list").getRowData(s[i]);
						//added by manoj chand on 11 july 2013 to fetch sid
						fetchDate[i] = rowdata['AD_FETCH_DATE'];
						processId[i] = rowdata['PROCESS_ID'];
						var n = s[i].split("$");
						//reqChk[i] =s[i];
						reqChk[i] =n[0];
					}
					document.forms[0].tempdataholder.value = new Array(reqChk);
					var reqChk1 = (document.forms[0].tempdataholder.value).split(",");
					document.forms[0].reqCheck.value = new Array(reqChk);
					//frm.action="M_ADUserSync_Post.jsp?dateFromFetch="+rowdata.AD_FETCH_DATE+"&processId="+rowdata.PROCESS_ID+"&reqCheck="+document.forms[0].reqCheck.value+"&dateFrom=<%=strDateFrom%>&process="+document.forms[0].process.value;
					frm.action="M_ADUserSync_Post.jsp?dateFromFetch="+fetchDate+"&processId="+processId+"&reqCheck="+document.forms[0].reqCheck.value+"&dateFrom=<%=strDateFrom%>&process="+document.forms[0].process.value+"&recordcount="+recordCount;
			    	frm.submit();
			}

	function searchInGrid(){
		var siteName_mask = jQuery("#search_SITE_NAME1").val();
		var From = jQuery("#dateFrom").val();
		var processid = jQuery("#process").val();
		if(siteName_mask == '<%=dbLabelBean.getLabel("label.user.entertextforsearch",strsesLanguage)%>'){
		siteName_mask="";
		}
		var parameters  = {search1:'true',site:'',siteName_mask1:escape(siteName_mask),dateFrom:From,process:processid};
		//alert(parameters)
		jQuery("#list").setGridParam(
		    {
				url:'JqGridAdSync',
		    	postData:parameters,
		    	mtype: 'POST'
			   ,page:1
			   }
			   ).trigger("reloadGrid");

		setTimeout('updatePending()',200);
	}
	function processSelected(){
		var e = document.getElementById("process");
		var strUser = e.selectedIndex;
		if (strUser!=1 && strUser!=2){
		alert('<%=dbLabelBean.getLabel("alert.user.pleaseselectleast",strsesLanguage)%>');
		e.value ="";
		}
	}
	function updatePending(){
		var container = document.getElementById("preq1");
		var grid = $("#list");
		var ids = grid.getDataIDs();
		if(ids.length <= 0){
			container.innerHTML = "<%=dbLabelBean.getLabel("label.user.norecordfoundinad",strsesLanguage)%>";
		}
	}	

</script>

</head>
<body scroll="no" >
<form name="frm" method="post">
<script type="text/javascript" language="JavaScript1.2" src="menu/menu_cnt.js?buildstamp=2_0_0"></script>
<input type="hidden" name="reqCheck" />
<input type="hidden" name="tempdataholder" />

<table width="99%" height="80%" border="0" cellspacing="0" align="center" cellpadding="0">
   <tr>
   	<td valign="top">

  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td width="20%" height="38" class="bodyline-top">
	    <ul class="pagebullet"><li class="pageHead"><%=dbLabelBean.getLabel("label.user.adusersync",strsesLanguage)%> </li>
	    </ul>
	  </td>
      <td width="80%" align="right" valign="middle" class="bodyline-top">
   	    <table width="100%" align="right" border="0" cellspacing="0" cellpadding="0">
          <tr>
          <% 
          if(strMessage.equals("UpdateSuccessfully")){
          %>
          			<td><font color="red" size="3" style="font-style: normal;font-family: monospace;font-weight: bold"><%=dbLabelBean.getLabel("message.user.recordupdated",strsesLanguage)%></font></td>
          <%} %>
           <% 
          if(strMessage.equals("UpdateNotSuccessfull")){
          %>
					<input type="hidden" id="updatedSIDNo" value="<%=strUpdatedSIDNo %>" />
          <%} %>
					<script type="text/javascript">
					if('<%=strUpdatedSIDNo%>' != ''){
					var updatedSIDNo= document.getElementById("updatedSIDNo").value;
					alert('<%=dbLabelBean.getLabel("alert.user.adminhadnotupdated",strsesLanguage)%> '+updatedSIDNo+' <%=dbLabelBean.getLabel("alert.user.intheuserprofile",strsesLanguage)%>');
					}
					</script>  
          </tr>
        </table>
	  </td> 
    </tr>
  </table>
 
    	 
  <table width="100%" align="center" border="0" cellpadding="1" cellspacing="1">
  <tr> 
    <td width="8%" class="formtr2"><%=dbLabelBean.getLabel("label.user.date",strsesLanguage)%></td>
    <td width="16%" class="formtr2">
    <input type="text" name="dateFrom" id="dateFrom" size='10' maxlength="10" class="textboxCSS" onFocus="javascript:vDateType='DD/MM/YYYY'" onKeyUp="DateFormat(this,this.value,event,false,'DD/MM/YYYY','Invalid Date.Please Re-Enter')" onBlur="DateFormat(this,this.value,event,true,'DD/MM/YYYY','Invalid Date.Please Re-Enter')"  value="<%=strDateFrom %>" onChange="javascript:while(''+this.value.charAt(this.value.length-1)==' ')this.value=this.value.substring(0,this.value.length-1);">
        <a id="datepickfrom" href="javascript:show_calendar('frm.dateFrom','a','a','DD/MM/YYYY');" onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;"><img border="0" name="imageField" src="images/calender.png?buildstamp=2_0_0" align="absmiddle"></a>
    </td>
    <td width="10%" class="formtr2"><%=dbLabelBean.getLabel("label.user.process",strsesLanguage)%></td>
    <td width="14%" class="formtr2">
    <select name="process" id="process"  class="textboxCSS" onChange="processSelected();">
			<option value="" ><%=dbLabelBean.getLabel("label.user.selectyouroption",strsesLanguage) %></option>
			
   <% if(!strDateFrom.equals("")){
			strSql="select distinct process_id from AD_USER_INFO_MST where STATUS='N' AND ACTION_MODE='MANUAL' AND convert(varchar(10),AD_FETCH_DATE,20) <= CONVERT(VARCHAR(10),CONVERT(DATETIME,'"+strDateFrom+"',103),20) ";
			//System.out.println("strSql----menu action--->"+strSql);
			rs   = dbConBean.executeQuery(strSql);
			int x=0;
			while(rs.next())
			{
				if(x==0){%>
					<option value="-1">All</option>
		<%		
			x++;
				}
				%>
			<option value="<%=rs.getString(1)%>"> <%=rs.getString(1)%></option>	
		<%	}
		}
   %> 
   </select>
   <script type="text/javascript">
		var var_val = '<%=strProcess%>';
		var flag = false;
		$("#process option").each(function()
		{
		    var x = $(this).val();
			if(x==var_val)
			{
				flag =  true;
			}
		});
		if(flag == true){
			document.frm.process.value=var_val;
		}else{
    	document.frm.process.value="";
		}
   </script>
    </td>
	<td width="10%" class="formtr2"><%=dbLabelBean.getLabel("label.approverequest.action",strsesLanguage)%></td>
    <td width="14%" class="formtr2">
    <select name="actionType" class="textboxCSS" id="actionType">
    <option value=""><%=dbLabelBean.getLabel("label.search.all",strsesLanguage) %></option>
    <option value="N"><%=dbLabelBean.getLabel("button.global.new",strsesLanguage) %></option>
    <option value="U"><%=dbLabelBean.getLabel("label.suggestions.update",strsesLanguage) %></option>
    <option value="D"><%=dbLabelBean.getLabel("link.createeditlist.delete",strsesLanguage) %></option>
    </select>
    <script type="text/javascript">
				document.frm.actionType.value="<%=strActionType%>";
				</script>
    </td>
    <td width="14%" class="formtr2">
    <input type="button" id="go" size="20" class=formbutton value="&nbsp;&nbsp;<%=dbLabelBean.getLabel("button.search.go",strsesLanguage) %>&nbsp;&nbsp;" width="30" onclick="return searchFunActionTaken(this.form);"></input>
    </td>   
  </tr> 
  </table>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
		    <td class="formtr2" colspan="3"><span id="preq1"></span></td>
   		 	<td class="formtr2" valign="top" style="text-align: right;" colspan="4">
			<input type="text" class="textBoxCss" size="40" name="search_SITE_NAME1" id="search_SITE_NAME1" value='<%=dbLabelBean.getLabel("label.user.entertextforsearch",strsesLanguage)%>' onfocus="javascript:if(this.value=='<%=dbLabelBean.getLabel("label.user.entertextforsearch",strsesLanguage)%>'){this.value=''};" onblur="javascript:if(this.value==''){this.value='<%=dbLabelBean.getLabel("label.user.entertextforsearch",strsesLanguage)%>'};" onkeypress="if(event.keyCode == 13){searchInGrid();}" onkeyup="return test1('search_SITE_NAME1',200,'cn')"/> &nbsp;<input type="button" id="searchlink"  style="height: 17px;" onclick="searchInGrid();" class="formButton" value="<%=dbLabelBean.getLabel("button.global.search",strsesLanguage) %>"/>
			</td>
	  </tr>
    </table>
     <table id="list" class="scroll" width="100%"></table>
     <div id="pager" class="scroll" style="height: 30px;"></div>  
  </td>
 </tr>
<tr>
<td align="center" class="formbottom"> 
<input type="button"  name="Submit" id="subbutton" class="formButton" onclick="return check1(this.form);" value='<%=dbLabelBean.getLabel("button.approverequest.submit",strsesLanguage)%>'/>
</td>
</tr>
 </table> 
</form>
</body>
</html>
