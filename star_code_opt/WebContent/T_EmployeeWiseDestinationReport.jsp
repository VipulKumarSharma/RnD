<%/***********************************************************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author									:Shiv Sharma 
 *Date of Creation 				:14 Jan 2008
 *Copyright Notice 				:Copyright(C)2000 MIND.All rights reserved
 *Project	  								:STAR
 *Operating environment	:Tomcat, sql server 2000 
 *Description 						:     This is first jsp file  for Showing reports of Requisitions Person wise  destination Report   
 *Modification 						: 
 *Reason of Modification	:   From date change to one month before on 14 sept 2009
 *Date of Modification			:
 *Revision History				:
 *Editor									
 ******************************************************************************************************/
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
<!--Create the DbConnectionBean object for createConnection-->
<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>

<!--Create the DbUtilityMethods object for utility methods-->
<jsp:useBean id="dbUtility" scope="page" class="src.connection.DbUtilityMethods" />

<%-- include page styles  --%>
<%-- <%@ include  file="systemStyle.jsp" %> --%>


<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
<script language="JavaScript" src="ScriptLibrary/date-picker.js?buildstamp=2_0_0"></script>
<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<script language="JavaScript" src="scripts/CommonValida.js?buildstamp=2_0_0"></script>
<script language=JavaScript src="ScriptLibrary/jQueryMaster.js?buildstamp=2_0_0"></script>
<script type="text/javascript" src="ScriptLibrary/jquery-1.8.3.js?buildstamp=2_0_0"></script>

<script language="javascript">
$.noConflict();
jQuery(document).ready(function($) {

	var dv = document.getElementById("waitingData");
	if(dv != null)
	{
		var xpos = screen.availHeight/2+90;
		var ypos = screen.availWidth/2-280;   
		
		dv.style.position="absolute";       		
		dv.style.left=(xpos+10)+"px";
		dv.style.top=(ypos)+"px";
	}
	
	$("#SelectUnit").change(
			function() {
			document.getElementById("waitingData").style.display="";
      		var reqpage="showReportData";
		  	var siteId = $("#SelectUnit option:selected").val();
		 	var Params='<%="language1="+strsesLanguage+"&suserRole="+SuserRole+"&useridooo="+Suser_id%>';
            var urlParams=Params+"&reqpageooo="+reqpage+"&siteIdooo="+siteId;
			$.ajax({
		            type: "post",
		            url: "AjaxMaster.jsp",
		            data: urlParams,
		            success: function(result){
					var res = jQuery.trim(result);
					$("#username").html('');
	            	$("#username").html(res);
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
      
function checkDate1()
{	
    if(document.frm.SelectUnit.value=="-1")
	{
		alert('<%=dbLabelBean.getLabel("alert.global.unitname",strsesLanguage) %>');
		document.frm.SelectUnit.focus();
		return false;
	}

  if(document.frm.travelType.value=="-1")
	{
		alert('<%=dbLabelBean.getLabel("alert.report.pleaseselecttraveltype",strsesLanguage) %>');
		document.frm.travelType.focus();
		return false;
	}

	if(document.frm.from.value=="")
	{
		alert('<%=dbLabelBean.getLabel("alert.report.pleaseselectfromdate",strsesLanguage) %>');
		document.frm.from.focus();
		return false;
	}
	if(document.frm.to.value=="")
	{
		alert('<%=dbLabelBean.getLabel("alert.report.pleaseselecttodate",strsesLanguage) %>');
		document.frm.to.focus();
		return false;
	}
	
    
	
	if(checkDateme1(document.frm,document.frm.to.value,document.frm.todayDate.value,document.frm.to,document.frm.todayDate,'<%=dbLabelBean.getLabel("message.report.todatecannotbegreaterthantoday",strsesLanguage) %> ','')==false)
	{
      		return false;
	}
     

   if(checkDateme(document.frm,document.frm.from.value,document.frm.to.value,document.frm.from,document.frm.to,'<%=dbLabelBean.getLabel("message.report.fromdatecannotbegreaterthantodate",strsesLanguage) %>','')==false)
	{
     	return false;
	}
   
   return true;
}
/*
function UnitValue(frm)
{
frm.UnitHidden.value=frm.SelectUnit.value;
}
*/

	function getDivisonID() {
	 	document.frm.action="T_EmployeeWiseDestinationReport.jsp"; 
		document.frm.submit();
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
		var flag = checkDate1();
		if (flag) {
			document.frm.action="T_EmployeeWiseDestinationReportPost.jsp";
			openWaitingProcess();
			frm.submit();
		}
	}
</script>
</head>
<body><script type="text/javascript" language="JavaScript1.2" src="menu/menu_cnt.js?buildstamp=2_0_0"></script>
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
<table width="100%" align="center" border="0" cellpadding="5" cellspacing="1">
  <tr>
    <td width="77%" height="35" class="bodyline-top">
	<ul class="pagebullet">
      <li class="pageHead"> <%=dbLabelBean.getLabel("label.report.starsreportpersonwisedesination",strsesLanguage) %></li>
    </ul></td>	
  </tr>
  </table>
<%
	SimpleDateFormat sdf=  new java.text.SimpleDateFormat("dd/MM/yyyy");
	String strCurrDate= sdf.format(new java.util.Date()); 
	SimpleDateFormat sdfY=  new java.text.SimpleDateFormat("yyyy");
	String strYear= sdfY.format(new java.util.Date());

	Date currentDate = new Date();
	SimpleDateFormat sdfnew = new SimpleDateFormat("dd/MM/yyyy");
	String strCurrentDatenew = (sdfnew.format(currentDate)).trim();

	String strSql="";
	ResultSet  rs=null;
	String strUserid="";
	String strFName="";
	String strLName="";
	String Site_ID 				= (request.getParameter("SelectUnit")==null)?"-1":request.getParameter("SelectUnit");
	
	
	
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
<!--  -->
<table width="95%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder">
	<div id="waitingData" style="display:none;"> 	    
		<center>
			<img src="images/loading16.gif?buildstamp=2_0_0" width="50" height="51" border="0" /> 
			<br>   
			<font color="#606060" style="font-size:14px;font-weight:bold;font-family:Verdana, Arial, Helvetica, sans-serif;">   
			<span id="pleaseWait">Please Wait  
			</span>
			</font>  
		</center>
	</div>
<form name="frm" method=post action="T_EmployeeWiseDestinationReportPost.jsp">

<tr class="formtr2">
<td class="formtr2"><%=dbLabelBean.getLabel("label.requestdetails.unit",strsesLanguage) %></td>
<td class="formtr1">
<select name="SelectUnit"  class="textboxCSS" id="SelectUnit">
<option  value="-1"><%=dbLabelBean.getLabel("label.report.selectunit",strsesLanguage) %></option>
<%
		ArrayList aList = dbUtility.findReportSiteListForUser(SuserRole, SuserRoleOther, strSiteIdSS, Suser_id,strsesLanguage);
		Iterator itr = aList.iterator();
		while(itr.hasNext())
				{
				%>
				<option value=<%=itr.next()%>> <%=itr.next()%></option>
				<%
				}

%>
</select>
           <script language="javascript">
			document.frm.SelectUnit.value ="<%=Site_ID%>";
		</script>
        

		</td>
</tr>

<tr align="left">
    <td class="formtr2"><%=dbLabelBean.getLabel("label.report.personname",strsesLanguage) %></td>
	<td class="formtr1">
		<select name="username"  class="textboxCSS" id="username">
		   <option value="0" ><%=dbLabelBean.getLabel("label.report.allperson",strsesLanguage) %></option> 
		   <%
		     /*
			if(SuserRole.equals("AD")){   //for all  site 
				strSql="SELECT  USERID, FIRSTNAME, LASTNAME  FROM   M_USERINFO WHERE  (STATUS_ID = 10) order by 2"; 

			}else{  			 //by this query user will show only those recodes who belonge to user logged site  
				strSql="SELECT  USERID, FIRSTNAME, LASTNAME  FROM   M_USERINFO WHERE site_id="+Site_ID+" and  (STATUS_ID = 10) order by 2";  
			}*/

          if(!Site_ID.equals("0"))            
		  {   
			strSql="SELECT  USERID, FIRSTNAME, LASTNAME  FROM   M_USERINFO WHERE site_id="+Site_ID+" and  (STATUS_ID = 10) order by 2";  
          }else{
		  strSql="SELECT  USERID, FIRSTNAME, LASTNAME  FROM   M_USERINFO WHERE   (STATUS_ID = 10) order by 2";  
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

</tr> 
<tr align="left"> 
<td class="formtr2"><%=dbLabelBean.getLabel("label.report.traveltype",strsesLanguage) %></td>
<td class="formtr1">
	<SELECT name="travelType" class="textBoxCss" > 
			<OPTION value = "-1"><%=dbLabelBean.getLabel("label.report.selecttraveltype",strsesLanguage) %></OPTION>
			<OPTION value="I"><%=(ssflage.equals("3") ? "Intercont" : dbLabelBean.getLabel("label.report.international",strsesLanguage)) %></OPTION>
			<OPTION value="D"><%=(ssflage.equals("3") ? "Domestic/Europe" : dbLabelBean.getLabel("label.report.domestic",strsesLanguage)) %></OPTION>
	</SELECT>
</td>
</tr>

<tr align="left"> 
    
	<td class="formtr2"><%=dbLabelBean.getLabel("label.report.datefrom",strsesLanguage) %></td>
	<td class="formtr1">  <input type=textbox name="from"  size='10' maxlength="10" class="textBoxCss" onFocus="javascript:vDateType='DD/MM/YYYY'" onKeyUp="DateFormat(this,this.value,event,false,'DD/MM/YYYY','Invalid Date.Please Re-Enter')" onBlur="DateFormat(this,this.value,event,true,'DD/MM/YYYY','Invalid Date.Please Re-Enter')"  value="<%=strCurrDatenewBefore%>" onChange="javascript:while(''+this.value.charAt(this.value.length-1)==' ')this.value=this.value.substring(0,this.value.length-1);" >
           <a href="javascript:show_calendar('frm.from','a','a','DD/MM/YYYY');"
                onMouseOver="window.status='Date Picker';return true;" 
               onMouseOut="window.status='';return true;"><img border="0" name="imageField" src="images/calender.png?buildstamp=2_0_0" align="absmiddle"> 
        </a>
</td>
</tr>
<tr align="left"> 
<td class="formtr2"><%=dbLabelBean.getLabel("label.report.dateto",strsesLanguage) %></td>
<td class="formtr1">
	<input type=textbox name="to"  size='10' maxlength="10" class="textBoxCss" onFocus="javascript:vDateType='DD/MM/YYYY'" onKeyUp="DateFormat(this,this.value,event,false,'DD/MM/YYYY','Invalid Date.Please Re-Enter')" onBlur="DateFormat(this,this.value,event,true,'DD/MM/YYYY','Invalid Date.Please Re-Enter')"  value="<%=strCurrDate%>" onChange="javascript:while(''+this.value.charAt(this.value.length-1)==' ')this.value=this.value.substring(0,this.value.length-1);" >
	<a href="javascript:show_calendar('frm.to','a','a','DD/MM/YYYY');"
	             onMouseOver="window.status='Date Picker';return true;" 
	             onMouseOut="window.status='';return true;"><img border="0" name="imageField" src="images/calender.png?buildstamp=2_0_0" align="absmiddle"> 
	</a>
</td>
</tr>
<%-- Code added --%>
 
<%-- End --%>
<tr align="left"> 
	<td class="formtr3" colspan=2 align="center"><input class=formbutton  type="button" value="<%=dbLabelBean.getLabel("label.report.viewreport",strsesLanguage) %>" onClick="confirmData();" ></td>
</tr>
	<input type="HIDDEN" name="UnitHidden"  >
<input type="hidden" name="todayDate" value="<%=strCurrentDatenew%>"/>
</form>
</table>