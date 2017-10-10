<% 
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:Himanshu Jain
 *Date of Creation 		:07 SEPTEMBER 2006
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This is jsp file  works as upper frame for search the Travel Requisition in the STAR Database
 *Modification 			:    
 *Reason of Modification:1: code added for search Criteria on 01-Oct-2008 by Shiv Sharma  
						 2: improved code added for search Criteria on 31-Aug-09 by Shiv Sharma 
 *Date of Modification  : 
 *Revision History		:
 *Editor				:Editplus
 
 *Modified By			:Manoj Chand
 *Date of Modification	:13 feb 2011
 *Modification			:Multiple Search options added.
 
 *Modified By			:Manoj Chand
 *Date of Modification	:22 feb 2011
 *Modification			:change the view of Search
 
 *Modified By			:Manoj Chand
 *Date of Modification	:12 May 2011
 *Modification			:implement special character entering not allowed check for requisition number field.
 
 *Modified By			:Manoj Chand
 *Date of Modification	:11 May 2012
 *Modification			:Resolve Scripting error coming while searching request.
 
 *Modified By	        :MANOJ CHAND
 *Date of Modification  :12 Feb 2013
 *Description			:IE Compatibility Issue resolved.
 
 *Modified By			:Manoj Chand
 *Date of Modification	:22 Oct 2013
 *Modification			:javascript validation to stop from typing --,'  symbol is added.
 *******************************************************/
%>
<%@ include file="importStatement.jsp" %> 
<%@ page pageEncoding="UTF-8" %>
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
<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<script language="JavaScript" src="scripts/CommonValida.js?buildstamp=2_0_0"></script>
<SCRIPT language="JavaScript" src="ScriptLibrary/date-picker_search.js?buildstamp=2_0_0"></SCRIPT>

<% 
String strTravelType = (String)session.getAttribute("strTravelType");
%>

<!--Create the DbConnectionBean object for createConnection-->
<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbConBean1" scope="page" class="src.connection.DbConnectionBean" />
<!--Create the DbUtilityMethods object for utility methods-->
<jsp:useBean id="dbUtility" scope="page" class="src.connection.DbUtilityMethods" />
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
<%
ArrayList aList = dbUtility.findSearchSiteListForUser(SuserRole, SuserRoleOther, strSiteIdSS, Suser_id,strsesLanguage);
Iterator itr = aList.iterator();
%>


<SCRIPT LANGUAGE="JavaScript">

function statusOnClick(f1)
{
	//alert(f1.status.value);
	var statusValue = f1.status.value;
	//alert(statusValue);
	if(statusValue != null && statusValue == "9")
	{
		f1.fromdate1.value="";
		f1.todate1.value="";
		f1.fromdate1.disabled=true;
		f1.todate1.disabled=true;
		document.getElementById("imageField1").style.display="none";
		document.getElementById("imageField2").style.display="none";
	}
	else
	{
		f1.fromdate1.disabled=false;
		f1.todate1.disabled=false;
		document.getElementById("imageField1").style.display="";
		document.getElementById("imageField2").style.display="";
	}	
}


function charactercheck1(val, type) 
{
 //  alert("type is=="+type);
 //  var mikExp='';
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


function test1(obj1, length, str)
		{	
			 
			var obj;

			//alert(obj1);
			if(obj1=='reqno')
			{
				//alert("inside "+obj1);
				obj = document.frm.reqno;
			}

		if(obj1=='originatedby')
			{
				//alert("inside "+obj1);
				obj = document.frm.originatedby;
			}
		if(obj1=='traveller')
		{
			obj = document.frm.username;
		}
		if(obj1=='papprover')
		{
			obj = document.frm.papprover;
		}
		
			 
	 	if(obj1=='destination')
			{
				//alert("inside "+obj1);
				obj = document.frm.destination; 
			}
			 
			///var obj11 = document.frm.obj1.value;  
			spaceChecking(obj);  
			//alert("obj====="+obj);
			charactercheck1(obj,str);
			limitlength(obj, length);
			//zeroChecking(obj); //function for checking leading zero and spaces

			//alert("ddd");
			
		}





function checkFrm()
{
	var a1= document.frm.reqno.value;
	var a2= document.frm.originatedby.value;
	var a3= document.frm.destination.value;
	var a4= document.frm.deptdate.value;

 

	if(a1==''  &&  a2==''  && a3=='' && a4=='' )
	{
		alert('<%=dbLabelBean.getLabel("alert.search.enteranykewordforsearch",strsesLanguage)%>');
 return false;
	}
	else
	{
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
		/* if(searchType == 'QUICK'){
			document.getElementByName('fromdate').value = '';
			document.getElementByName('todate').value = '';
		}else{
			document.getElementByName('Qfromdate').value = '';
			document.getElementByName('Qtodate').value = '';
		} */
}

function hideshow(searchType)
{
	resetFieldsOnSearchTypeChange(searchType);
	if(searchType == 'ADVANCE'){
		document.getElementById('advanceSearchDiv').style.display='block';
		document.getElementById('quickSearchDiv').style.display='none';
	}else{
		document.getElementById('quickSearchDiv').style.display='block';
		document.getElementById('advanceSearchDiv').style.display='none';
	}
	var x=findPos(document.getElementById('showhide'));
	x=x+19;
 	if(document.getElementById('showhide').value == '<%=dbLabelBean.getLabel("button.search.hidecriteria",strsesLanguage)%>'){
 	parent.document.getElementById('fset').rows = '180,*';
 	parent.document.getElementById("fset").frameSpacing = 5;
 	var ele=top.footer_11.document.getElementById("dv");
			if(ele!=null)
			{
 			ele.style.width="99%";
 			ele.style.height="90%";
 			}
 			document.getElementById('showhide').value = '<%=dbLabelBean.getLabel("label.search.showadvancesearch",strsesLanguage)%>';
 			
 	}else{
 			
		if(searchType == 'ADVANCE'){
				document.getElementById('searchType').value = 'ADVANCE';
				document.getElementById('showhide').value = '<%=dbLabelBean.getLabel("label.search.showquicksearch",strsesLanguage)%>';
				parent.document.getElementById('fset').rows = '238,*';
		}else{
				document.getElementById('searchType').value = 'QUICK';
				document.getElementById('showhide').value = '<%=dbLabelBean.getLabel("label.search.showadvancesearch",strsesLanguage)%>';
				parent.document.getElementById('fset').rows = '90,*';
 		}
		
 		parent.document.getElementById("fset").frameSpacing = 5;
 		var ele=top.footer_11.document.getElementById("dv");
 			if(ele!=null)
 			{
 	 		ele.style.width="99%";
 	 		ele.style.height="92%";
 			}
 	}
	
}

function checkDate1() {
  
  if(document.frm.travelType.value=="-1") {
		alert('<%=dbLabelBean.getLabel("alert.report.pleaseselecttraveltype",strsesLanguage) %>');
		document.frm.travelType.focus();
		return false;
	}
 	return true;
}
//-->
</SCRIPT>
</head>      
<body >    
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="40" class="bodyline-top">
	<ul class="pagebullet">
      <li class="pageHead"><%=dbLabelBean.getLabel("label.search.searchtravelrequisitions",strsesLanguage)%></li>
    </ul></td>
    <td height="40" align="right" valign="bottom" class="bodyline-top"  ></td>
  </tr> 
</table>
  
<form method=post name=frm action="T_TravelReqSearchResultsAll.jsp" target="footer_11">

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
		<tr valign="top" id="quickSearchDiv">
			<td>
			    <table width="99%" align="center" border="0" cellpadding="3" cellspacing="1"  class="formborder">
			 	 	<tr align="left" valign="top"> 	 
			   			<td class="formtr2" align="center" ><%=dbLabelBean.getLabel("label.global.unitname",strsesLanguage)%></td>
				 		<td class="formtr2" align="center" width="220px">
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
				 	 <td class="formtr2" align="center" colspan="3">
				 	 	<input type="text" name="keyWordParamVal" id="keyWordParamVal" size=20 maxlength=30 class="textBoxCss" onKeyUp="return test1('originatedby', 29, 'cn')"/>
				 	 </td>
<%-- 				 	 <td class="formtr2" align="center" > <%=dbLabelBean.getLabel("label.search.createdbetween",strsesLanguage)%></td> --%>
<!-- 				 	 <td class="formtr2" align="center">  -->
<!-- 						<input name="Qfromdate" type="text" class="textBoxCss" id="test223" size="10" onFocus="javascript:vDateType='DD/MM/YYYY'" -->
<!-- 													onKeyUp="DateFormat(this,this.value,event,false,'DD/MM/YYYY','Invalid Date.Please Re-Enter')" -->
<!-- 													onBlur="DateFormat(this,this.value,event,true,'DD/MM/YYYY','Invalid Date.Please Re-Enter')" -->
<!-- 													onChange="javascript:while(''+this.value.charAt(this.value.length-1)==' ')this.value=this.value.substring(0,this.value.length-1);"><a href="javascript:show_calendar('frm.Qfromdate','a','a','DD/MM/YYYY');" -->
<!-- 													onMouseOver="window.status='Date Picker';return true;" -->
<!-- 													onMouseOut="window.status='';return true;"><img border="0" name="imageField" src="images/calender.png?buildstamp=2_0_0" align="absmiddle"></a> -->
<%-- 						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.search.and",strsesLanguage)%>&nbsp;&nbsp;&nbsp;&nbsp; --%>
<!-- 								<input name="Qtodate" type="text" class="textBoxCss" id="test223" size="10" onFocus="javascript:vDateType='DD/MM/YYYY'" -->
<!-- 						onKeyUp="DateFormat(this,this.value,event,false,'DD/MM/YYYY','Invalid Date.Please Re-Enter')" -->
<!-- 						onBlur="DateFormat(this,this.value,event,true,'DD/MM/YYYY','Invalid Date.Please Re-Enter')" -->
<!-- 						onChange="javascript:while(''+this.value.charAt(this.value.length-1)==' ')this.value=this.value.substring(0,this.value.length-1);"><a href="javascript:show_calendar('frm.Qtodate','a','a','DD/MM/YYYY');" -->
<!-- 						onMouseOver="window.status='Date Picker';return true;" -->
<!-- 						onMouseOut="window.status='';return true;"><img border="0" name="imageField" src="images/calender.png?buildstamp=2_0_0" align="absmiddle"></a>									 -->
<!-- 					</td>   -->
					<td class="formtr2" align="right" style="width:160px; text-align: right;">
			        	<input type=submit value=" <%=dbLabelBean.getLabel("button.search.go",strsesLanguage)%>  " class="formbutton" onClick="return checkDate1();"> <!-- onClick="return checkFrm();"  onClick="alert('You have not given any search criteria,result may take some time to display');"-->  
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
		        	<input type=submit value=" <%=dbLabelBean.getLabel("button.search.go",strsesLanguage)%>  " class="formbutton" onClick="return checkDate1();"> <!-- onClick="return checkFrm();"  onClick="alert('You have not given any search criteria,result may take some time to display');"-->  
		        	<input type=button value="<%=dbLabelBean.getLabel("label.search.showquicksearch",strsesLanguage)%>" id="showhide" 
		 	 		class="formbutton" onclick="hideshow('QUICK')"  style="width:110px;">
			    </td> 
			</tr>
		</table>
			</td>
		</tr>
	</table>
	
	
	
        <input  type="hidden"  name="rad">  
        <input type="hidden" name="searchType" value="QUICK"/>
   </form>
        </body>

</html>
