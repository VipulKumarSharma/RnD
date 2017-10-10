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
<%
	String strSql      	= null;              // String for Sql String
	ResultSet objRs    	= null;              // Object for ResultSet
	ResultSet rs1      	= null;   
	String strStyleCls 	= "";
	String strsiteid   	= "";
	int iCls 			= 0;
	int iLoop			= 0;
%>
	<!--Create the DbConnectionBean object for createConnection-->
	<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
	<jsp:useBean id="dbConBean1" scope="page" class="src.connection.DbConnectionBean" />
	<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
	
	<script language="JavaScript" src="scripts/CommonValida.js?buildstamp=2_0_0"></script>
	<SCRIPT language=JavaScript src="ScriptLibrary/validation.js?buildstamp=2_0_0"></SCRIPT>
	<SCRIPT language="JavaScript" src="ScriptLibrary/date-picker.js?buildstamp=2_0_0"></SCRIPT>
	<script type="text/javascript" src="ScriptLibrary/jquery-1.8.3.js?buildstamp=2_0_0"></script>
	<script type="text/javascript" language="text/javaScript" src="ScriptLibrary/jquery.quicksearch.js?buildstamp=2_0_0"></script>
	
	<style type="text/css">
		div.quicksearch { font-size: 8pt; font-weight: bold; color: #373737; font-family: 'Arial, Sans-Serif'; }
		div.quicksearch input { width:200px; background :#ffffff; color:#666666; font-family:'Arial, Sans-Serif'; 
			font-size:9pt; border-bottom:#888888 1px solid; border-left: #888888 1px solid; border-right: #888888 1px solid; 
			border-top: #888888 1px solid; margin-right: 3px; }
	</style>

	<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
	<base target="middle"> 
	<script type="text/javascript">
	$(document).ready(function () {
		if($("table#detailTable").find('tbody:first tr').length > 0) {
			
			$("#detailTable tbody tr").quicksearch({
		    	labelText: '<%=dbLabelBean.getLabel("label.global.search",strsesLanguage)%> : ',
	            attached: '#searchTd',
	            position: 'append',
	            delay: 100,             
	            loaderText: '',
	            onAfter: function() {
	                if ($("#detailTable tbody tr:visible").length != 0) {
		               	
		               	var rowLength = $("#detailTable tbody tr:visible").length ;
		               	if(rowLength < 10) {
		               		rowLength = 33 * rowLength;
		               		$("#tabSearch").css("height",rowLength+"px");
		               	} else {
		               		$("#tabSearch").css("height","320px");
		               	}
	                    
		               	$("#detailTable").trigger("update");
	                    $("#detailTable").trigger("appendCache");
	                    $("#detailTable tfoot tr").hide();
	                    $("#loader").hide();
	                    $('[name="parentCheckBox"]').attr("disabled",false);
	                    
		          	} else {
		               	$("#tabSearch").css("height","33px");
		               	$("#detailTable tfoot tr").show();
		               	$(':checkbox.parentCheckBox').attr("disabled",true);    
		            }
		      	}
			});
		}
		
		$(":checkbox.parentCheckBox").click(function () {
			if(this.checked == true) {
				$('input[type=checkbox]').each(function() {
			   		if ($(this).parents("tr#dataRow").is(':visible')){
			   			this.checked = true;
			   		}
				});
			} else if(this.checked == false) {
				$(':checkbox.parentCheckBox').removeAttr("checked");
				$('input[type=checkbox]').each(function() {
			   		if ($(this).parents("tr#dataRow").is(':visible')){
			   			this.checked = false;
			   		} 
				});
			}
		});
		
		$('[name="selectAll"]').click(function () {
	    	$(':checkbox.childCheckBox').attr('checked','checked');
	    	$(':checkbox.parentCheckBox').attr('checked','checked');
	    });
		$('[name="unSelectAll"]').click(function () {
			$(':checkbox.childCheckBox').removeAttr("checked");    
			$(':checkbox.parentCheckBox').removeAttr("checked");    
	    });
	});
	
	var siteIds = '';
	function exportToExcel() {
	   	var checkSiteFlag	= false;
		
	   	$('input[type=checkbox]').each(function() {
	   		if(this.checked && $(this).hasClass("childCheckBox")){
	   			checkSiteFlag = true;
	   			siteIds = siteIds +'_'+this.value;
	   		}
		});
		
	    if (!checkSiteFlag) {	
	    	alert("Please select atleast one unit to generate Workflow Report.");
	    	return false;
	    } else {	
	    	/* alert('siteIds='+siteIds); */
	    	window.open('./ExportWorkflowReport?siteIds='+siteIds,'_self','scrollbars=yes, resizable=yes,top=280,left=350,width=1,height=1');
	    }
	    siteIds = '';
	}
	</script>
</head>

<body>
<script type="text/javascript" language="JavaScript1.2" src="menu/menu_cnt.js?buildstamp=2_0_0"></script>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="70%" height="35" class="bodyline-top">
	<ul class="pagebullet">
      <li class="pageHead"><%=dbLabelBean.getLabel("label.administration.administratorproductionworkflow",strsesLanguage)%></li>
    </ul></td>
    <td width="30%" align="right" valign="bottom" class="bodyline-top">
	<table align="right" border="0" cellspacing="0" cellpadding="0">
      <tr align="right">
      <td>
      <ul id="list-nav">
		<li><a href="#" onClick="window.print();"><%=dbLabelBean.getLabel("button.search.print",strsesLanguage)%></a></li>
	  </ul>
      </td>
		
      </tr>
    </table>
	</td></tr>
</table>
<div id="divSearch" style="width:97%; float:left;margin-top: 5px;margin-left: 14px;" align="center">
	<table width="100%" align="center" border="0" cellpadding="1" cellspacing="0" class="formborder">
		<tr>
			<td class="selectedmenubg" height="25px" style="font-size: 13px;">
				<input type="button" name="selectAll" value="Select All" class="formButton-gray" style="width:60px;margin-left: 5px;">
				<input type="button" name="unSelectAll" value="Unselect All" class="formButton-gray" style="width:70px;margin-left: 5px;">
				<input type="button" name="etx_wr" value="Generate Workflow Report" class="formButton-green" 
					style="width:160px;margin-left: 5px;" onclick="javascript:exportToExcel();">
			</td>
			<td class="selectedmenubg" id="searchTd" align="right" width="300px" height="25px"></td>
		</tr>						
	</table>
</div>

<div style="width:98%;margin-left: 14px;background-color: #fdfdfd;" align="center" class="formborder">
<table width="100%" align="center" border="0" cellpadding="5" cellspacing="1" class="">
	<thead>	
	  	<tr>
		  	<th class="formhead" width="30px"><input type="checkbox" name="parentCheckBox" id="parentCheckBox" class="parentCheckBox"/></th>
		    <th class="formhead" width="30px"><%=dbLabelBean.getLabel("label.global.sno",strsesLanguage)%></th>
		    <th class="formhead" width="250px"><%=dbLabelBean.getLabel("label.requestdetails.division",strsesLanguage)%></th>
		    <th class="formhead" width="250px"><%=dbLabelBean.getLabel("label.administration.site",strsesLanguage)%></th>
		    <th class="formhead"><%=dbLabelBean.getLabel("label.administration.sitedesc",strsesLanguage)%></th>
		    <th class="formhead" width="30px"><%=dbLabelBean.getLabel("label.approverequest.action",strsesLanguage)%></th>  
	  	</tr>
	</thead> 
</table>	
</div>

<div id="tabSearch" style="width:98%;height:320px;overflow-y: auto;margin-left: 14px;background-color: #fdfdfd;" align="center" class="formborder">
<table width="100%" align="center" border="0" cellpadding="5" cellspacing="1" class="" id="detailTable">
	<tbody>
	<%
		strSql = "SELECT .DBO.DIVISIONNAME(DIV_ID) AS DIV,SITE_NAME ,SITE_DESC,.DBO.CONVERTDATE(C_DATE) AS CREATEDDATE,SITE_ID FROM M_SITE WHERE STATUS_ID=10 AND APPLICATION_ID=1 ORDER BY 1,2";
	      objRs  = dbConBean.executeQuery(strSql);
	//New Check for local administrator
		if((SuserRoleOther.trim().equals("LA")))
		{
	
			 strSql="SELECT  SITE_ID FROM M_USERROLE  WHERE STATUS_ID=10 AND USERID="+Suser_id+" order by 1";
	         objRs = dbConBean.executeQuery(strSql);
			 if (!objRs.next())
			{
				 strSql = "SELECT .DBO.DIVISIONNAME(DIV_ID) AS DIV,SITE_NAME ,SITE_DESC,.DBO.CONVERTDATE(C_DATE) AS CREATEDDATE,SITE_ID FROM M_SITE WHERE SITE_ID="+objRs.getString("SITE_ID")+" AND STATUS_ID=10 AND APPLICATION_ID=1 ORDER BY 1,2";
				  objRs = dbConBean.executeQuery(strSql);
	     	 }
			 else
			{
	            strSql="SELECT  SITE_ID FROM M_USERROLE  WHERE STATUS_ID=10 AND USERID="+Suser_id+" order by 1";
	            objRs = dbConBean.executeQuery(strSql); 
	               while(objRs.next()) 
						  {
	                   
	                       strsiteid= objRs.getString("SITE_ID");
	strSql = "SELECT .DBO.DIVISIONNAME(DIV_ID) AS DIV,SITE_NAME ,SITE_DESC,.DBO.CONVERTDATE(C_DATE) AS CREATEDDATE,SITE_ID FROM M_SITE WHERE SITE_ID="+strsiteid+" AND STATUS_ID=10 AND APPLICATION_ID=1 ORDER BY 1,2";
	
					/*	 strSql="SELECT dbo.DIVISIONNAME(DIV_ID), dbo.SITENAME(SITE_ID), ISNULL(DEPT_NAME,''), dbo.CONVERTDATE(C_DATE), DEPT_ID FROM M_DEPARTMENT WHERE dbo.SITESTATUS(SITE_ID)='10' AND SITE_ID="+strsiteid+" AND STATUS_ID=10 ORDER BY 1,2,3";
	*/
						 rs1 = dbConBean1.executeQuery(strSql);
	                  while(rs1.next())
							  {
								if (iCls%2 == 0) 
										{ 
											strStyleCls="formtr2";
										} 
										else 
										{ 
										strStyleCls="formtr1";
										} 
									  iCls++;
									  iLoop++;
								%>
									  <tr class="<%=strStyleCls%>" id="dataRow"> 
									  	<td class="<%=strStyleCls%>" style="text-align: center;width: 30px;">
									  		<input type="checkbox" name="chk<%=iLoop%>" id="chk<%=iLoop%>" value="<%=rs1.getString("SITE_ID").trim()%>" class="childCheckBox">
									  	</td>
										<td class="datacell" style="width: 30px;text-align: center;"><%=iLoop%></td>
										<td class="<%=strStyleCls%>" style="width: 250px;"><%=rs1.getString("DIV")%></td>
										<td class="<%=strStyleCls%>" style="width: 250px;"><%=rs1.getString("SITE_NAME")%></td>
										<td class="<%=strStyleCls%>"><%=rs1.getString("SITE_DESC")%></td>
										<td class="<%=strStyleCls%>"style="width: 30px;text-align: center;">
										
										<%
										//SHOWING VIEW LINK TO LA, CHANGED BY KAVERI GARG ON 14 AUGUST 2012
										if((SuserRoleOther.trim().equals("LA"))){%>
										&nbsp;&nbsp;&nbsp;<a href="M_WorkFlowViewApprover.jsp?TYPE=1&ID= <%=rs1.getString("SITE_ID") %>">View</a>
										 <% }
										 else
										 {%>
										  <A HREF="M_WorkFlowAddApprover.jsp?TYPE=1&ID= <%=rs1.getString("SITE_ID") %>" Title="Click to View"><img src="images/View_All.png?buildstamp=2_0_0" border=0></A>
										<% }%>
								
										</td>
									  </tr>
								<%
					           }
	                       rs1.close();   
	
			 }
	   		}
		}
	//
	
	
		//objRs  = dbConBean.executeQuery(strSql);
		while(objRs.next())
		{
	    	if (iCls%2 == 0) 
			{ 
		    	strStyleCls="formtr2";
	        } 
			else 
			{ 
			strStyleCls="formtr1";
	        } 
		  iCls++;
		  iLoop++;
	%>
		  <tr class="<%=strStyleCls%>" id="dataRow"> 
		  	<td class="<%=strStyleCls%>" style="text-align: center;width: 30px;">
		  		<input type="checkbox" name="chk" id="chk<%=iLoop%>" value="<%=objRs.getString("SITE_ID").trim()%>" class="childCheckBox">
		  	</td>
			<td  class="datacell" style="text-align: center;width: 30px;"><%=iLoop%></td>
			<td  class="<%=strStyleCls%>" style="width: 250px;"><%=objRs.getString("DIV")%></td>
			<td  class="<%=strStyleCls%>" style="width: 250px;"><%=objRs.getString("SITE_NAME")%></td>
			<td  class="<%=strStyleCls%>"><%=objRs.getString("SITE_DESC")%></td>
			<td  class="<%=strStyleCls%>"style="width: 30px;text-align: center;">
			
		      <A HREF="M_WorkFlowAddApprover.jsp?TYPE=1&ID= <%=objRs.getString("SITE_ID") %>" Title="<%=dbLabelBean.getLabel("label.administration.clicktoview",strsesLanguage)%>"><img src="images/View_All.png?buildstamp=2_0_0" border=0></A>
			</td>
		  </tr>
	<%
		}
	%>
	</tbody>	
	<tfoot class="formtr2" style="text-align: center;font-weight: bold;color:red;">
		<tr style='display:none;'>
	    	<td colspan='6'><%=dbLabelBean.getLabel("label.global.norecordfound",strsesLanguage)%></td>
	    </tr>
	</tfoot> 
</table> 
</div>
<p>&nbsp;</p>
</body>
</html>
