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
<jsp:useBean id="dbConBean1" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
<jsp:useBean id="dbUtility" scope="page" class="src.connection.DbUtilityMethods" />

<%
int iSno=1;
String strChkBoxFlag = "false";
String strftBtnFlag = "false";
String strNoRecordFlag = "true";
String strUserFlagSelected = "false";
String strIpAddress = "";
String strMessage = "";
strIpAddress = request.getRemoteAddr();
strMessage = request.getParameter("strMessage")==null?"":request.getParameter("strMessage");
%>

<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
<script type="text/javascript" language="text/javaScript" src="ScriptLibrary/jquery-1.8.3.js?buildstamp=2_0_0"></script>
<SCRIPT type="text/javascript" language="text/javaScript" src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<script type="text/javascript" language="text/javaScript" src="scripts/CommonValida.js?buildstamp=2_0_0"></script>
<script type="text/javascript" language="text/javaScript" src="ScriptLibrary/jQueryMaster.js?buildstamp=2_0_0"></script>
<script type="text/javascript" language="text/javaScript" src="ScriptLibrary/jquery.tablesorter.js?buildstamp=2_0_0"></script>
<script type="text/javascript" language="text/javaScript" src="ScriptLibrary/jquery.quicksearch.js?buildstamp=2_0_0"></script>

<style type="text/css">
#map_canvas { height: 100% }
/* tables */
table.tablesorter {font-family:arial;  margin:0; font-size: 8pt; width: 100%; text-align: left; }
table.tablesorter thead tr th, table.tablesorter tfoot tr th {  border: 1px solid #FFF; font-size: 8pt; padding: 2px; }
table.tablesorter thead tr .header { background-image: url(images/bg.gif); background-repeat: no-repeat; background-position: center right; cursor: pointer; }
table.tablesorter tbody td { color: #3D3D3D; padding: 2px;  vertical-align: top; }
table.tablesorter tbody tr.odd td {	 }
table.tablesorter thead tr .headerSortUp { background-image: url(images/asc.gif); }
table.tablesorter thead tr .headerSortDown { background-image: url(images/desc.gif); }
table.tablesorter thead tr .headerSortDown, table.tablesorter thead tr .headerSortUp { background-color: #8dbdd8; }
div.quicksearch { font-size: 8pt; font-weight: bold; color: #000000; font-family: 'Arial, Sans-Serif'; }
div.quicksearch input { width:100px; height:18px; background :#ffffff; color:#666666; font-family:'Arial, Sans-Serif'; font-size:8pt; border-bottom:#888888 1px solid; border-left: #888888 1px solid; border-right: #888888 1px solid; border-top: #888888 1px solid; }

</style>
<script type="text/javascript">
$(document).ready(function () {
	
    //clicking the parent checkbox should check or uncheck all child checkboxes
    $(":checkbox.parentCheckBox").click(function () {
    	if(this.checked == true){
    		$(':checkbox.childCheckBox').attr('checked','checked');
    		$(':checkbox.childCheckBox').val("Y");
    	} else if(this.checked == false){
    		$(':checkbox.childCheckBox').removeAttr("checked");
    		$(':checkbox.childCheckBox').val("N");
    	}        
    });
    
    //clicking the last unchecked or checked checkbox should check or uncheck the parent checkbox
    $(':checkbox.childCheckBox').click(function () {
    	if($(":checkbox.childCheckBox").length == $(":checkbox.childCheckBox:checked").length) {
            $(":checkbox.parentCheckBox").attr("checked", "checked");
        } else {
            $(":checkbox.parentCheckBox").removeAttr("checked");
        }
    });
    
    
    $(":button.roleType").click(function () {
    	
    	var userID = "";
    	var siteID = "";    	
    	userID = '<%=Suser_id%>';
    	siteID = $("select#selectUnit option:selected").val();
		
    	var id = $(this).attr('id');    	    	
    	if(id == "bt_MCT"){
    		$("input#userFlag").val("CT");
    	} else if(id == "bt_AU"){
    		$("input#userFlag").val("ALL");    		
    	}
    	
    	if(siteID == "-1") {
    		$(':button#bt_MCT').addClass('formButton');
    		alert("Please select unit.");
    		$("select#selectUnit").focus();
    	} else {
	    	document.frm.action="M_Location_MyTeam.jsp";
	        frm.submit();
    	}
    	
    });
    
    $(":button#bt_add").click(function () {
    	
    	var checkedChkLength = $(":checkbox.childCheckBox:checked").length;
    	if(checkedChkLength == 0){
    		alert("<%=dbLabelBean.getLabel("alert.myteam.selectatleastoneuser",strsesLanguage)%>");
    	} else {
	    	document.forms["frm"].addRemoveFlag.value ="add";
	    	document.frm.action="M_Location_MyTeamPost.jsp";
	        frm.submit();
    	}
    });
    
	$(":button#bt_remove").click(function () {
		
		var checkedChkLength = $(":checkbox.childCheckBox:checked").length;
    	if(checkedChkLength == 0){
    		alert("<%=dbLabelBean.getLabel("alert.myteam.selectatleastoneuser",strsesLanguage)%>");
    	} else {
			document.forms["frm"].addRemoveFlag.value ="remove";
			document.frm.action="M_Location_MyTeamPost.jsp";
	        frm.submit();
    	}
    });	
    
});
</script>
<script type="text/javascript">
	function openWaitingProcess() {
			var dv = document.getElementById("waitingData");
			if(dv != null) {
				var xpos = screen.width * 0.35;
				var ypos = screen.height * 0.30;   
				
				dv.style.position="absolute";       		
				dv.style.left=(xpos)+"px";
				dv.style.top=(ypos)+"px";
				
				document.getElementById("waitingData").style.visibility="";	
			}
	}
	
	function closeDivRequest() {
		document.getElementById("waitingData").style.visibility="hidden";	
	}
	
</script>
</head>
<body>

<div id="waitingData" style="visibility:hidden;">	    
	 <center><img src="images/loading16.gif?buildstamp=2_0_0" width="50" height="51" border="0" /> 
	 <br>      
	 <font color="#000080" class="pageHead"><%=dbLabelBean.getLabel("label.bookingstatus.pleasewait",strsesLanguage)%> </font>    
	 </center>
</div>
<script language="javaScript">  
	openWaitingProcess();
</script>

<form name=frm action="" method=post>
	<input type="hidden" name="userId" id="userId" value="<%=Suser_id%>" />
	<input type="hidden" name="userFlag" id="userFlag" value="" />
	<input type="hidden" name="searchFlag" value="true">
	<input type="hidden" name="addRemoveFlag" value="">
	<table width="100%" align="center" border="0" cellpadding="5" cellspacing="0">
  		<tr width="100%" valign="bottom">
    		<td width="90%" height="35" class="bodyline-top">
				<ul class="pagebullet">
      				<li class="pageHead"><%=dbLabelBean.getLabel("submenu.mylinks.myteam",strsesLanguage)%></li>
    			</ul>
    		</td>
    		<td height="35" class="bodyline-top" style="padding-left:14px;">
			    <ul id="list-nav">
			        <li><a href="#" onClick="javascript:top.window.close();" style="width:60px;"><%=dbLabelBean.getLabel("button.global.close",strsesLanguage) %></a></li>
			    </ul>
			</td>	
  		</tr>
  	</table>
  	<%
  	ResultSet  rs1, rs2, rs3 = null;
	Connection objCon =  null;    
    CallableStatement objCstmt	=  null;    
    objCon =  dbConBean1.getConnection(); 
    String strSql = "";
    
    String strUserId = "";
    String strSiteName = "";
    String strEmpName = "";
    String strMgrName = "";
    String strSiteAccess = "";
    String strCheckFlag = "";
    String strRoleId = "";
    String strUid ="";
	String strFName	="";
	String strLName	="";
	
	String site_ID = (request.getParameter("selectUnit")==null)?"0":request.getParameter("selectUnit");	
	String user_Flag = request.getParameter("userFlag")==null?"CT":request.getParameter("userFlag");
	String member_User_ID = "0";
	String p_User_ID = "";
	
  	%>
  	<table width="95%" align="center" border="0" cellpadding="3" cellspacing="0" class="formborder">
	  	<tr class="formtr2" align="right">			
			<td class="formtr2" style="width:10%;text-align:center;padding-right:0px; "><b><%=dbLabelBean.getLabel("label.requestdetails.unit",strsesLanguage) %></b></td>
			<td class="formtr1" width="30%">
				<select name="selectUnit" id="selectUnit" class="textboxCSS" style="width:100%;">
							<option value='-1'>Please select the Unit</option>
					<%  strSql = "SELECT 0,'All' UNION SELECT SITE_ID,SITE_NAME FROM VW_AUTH_REPORT_SITE_ACCESS WHERE USERID="+Suser_id+"";
						rs2   = dbConBean.executeQuery(strSql);
						while(rs2.next()) { 
			   		%>		<option value=<%=rs2.getString(1)%>> <%=rs2.getString(2)%></option>
					<%	} rs2.close();
					%>
					<script language="javascript">
						document.frm.selectUnit.value ="<%=site_ID%>";
					</script>
				</select>				
			</td>
			<td class="formtr1" style="text-align: center!important;" width="30%">
				<input type="button" name="bt_MCT" value="<%=dbLabelBean.getLabel("button.myteam.mycurrentteam",strsesLanguage)%>" id="bt_MCT" class="formButton roleType" style="width:105px;">
			</td>
			<td class="formtr1" style="text-align: center!important;" width="20%">
				<input type="button" name="bt_AU" value="<%=dbLabelBean.getLabel("button.myteam.allusers",strsesLanguage)%>" id="bt_AU" class="formButton roleType" style="width:105px;">
			</td>
			<td class="formtr1" style="text-align: center!important;" width="10%">
			</td>
		</tr>
	</table>

  	<table width="95%" align="center" border="0" cellpadding="0" cellspacing="0">
	  	<tr valign="top">
	  		<td>
	  			<div id="divSearch" style="width:100%; float:left;">
					<table width="100%" align="center" border="0" cellpadding="1" cellspacing="0" class="formborder">
						<tr>
							<td class="selectedmenubg" height="22px"><span class="dataLabel"><%=dbLabelBean.getLabel("label.myteam.selectthepersons",strsesLanguage)%>&nbsp;:</span></td>
							<td class="selectedmenubg" id="searchTd" align="right" width="150px" height="22px"></td>
						</tr>						
					</table>
				</div>
			  	<div id="divContents" style="width:100%; float:left;">
					<table width="100%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder tablesorter" id="detailTable">
						<thead>							
							<tr>							   					
								<th width="22px" class="formhead"><input type="checkbox" name="parentCheckBox" id="parentCheckBox" class="parentCheckBox"/></th>
								<th width="40px" nowrap="nowrap" class="formhead"><%=dbLabelBean.getLabel("label.global.sno",strsesLanguage)%></th>
								<th nowrap="nowrap" class="formhead"><%=dbLabelBean.getLabel("label.mail.sitename",strsesLanguage)%></th>		
								<th nowrap="nowrap" class="formhead"><%=dbLabelBean.getLabel("label.myteam.employeename",strsesLanguage)%></th>
								<th nowrap="nowrap" class="formhead" style="width:15%;"><%=dbLabelBean.getLabel("label.register.reportto",strsesLanguage)%></th>
								<th nowrap="nowrap" class="formhead"><%=dbLabelBean.getLabel("label.myteam.siteaccess",strsesLanguage)%></th>
								<th nowrap="nowrap" class="formhead"><%=dbLabelBean.getLabel("label.master.role",strsesLanguage)%></th>
							</tr>
						</thead>
						<tbody>
						<%
						int i = 0;
						
						try	{					 
							objCstmt = objCon.prepareCall("{?=call PROC_INSERT_TEAM_MEMBER(?,?,?,?,?,?,?)}"); 
							objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
							objCstmt.setInt(2, Integer.parseInt(site_ID));
							objCstmt.setInt(3, Integer.parseInt(Suser_id));
							objCstmt.setInt(4, Integer.parseInt(member_User_ID));
							objCstmt.setString(5, user_Flag);							
							objCstmt.setString(6, strIpAddress);
							objCstmt.setString(7,"SELECT");
							objCstmt.registerOutParameter(8,java.sql.Types.INTEGER);
							rs3 = objCstmt.executeQuery();
						
							while(rs3.next()){
								strChkBoxFlag = "true";
								strftBtnFlag = "true";
								strNoRecordFlag = "false";
								strUserId = rs3.getString("USERID");
							    strSiteName = rs3.getString("SITE_NAME");
							    strEmpName = rs3.getString("EMP_NAME");
							    strMgrName = rs3.getString("MGR_NAME");
							    strSiteAccess = rs3.getString("ACCESS_SITE");
							    strCheckFlag = rs3.getString("CHECK_FLAG");
							    strRoleId = rs3.getString("ROLE");
							    
							    String strChkNameSn = "childCheckBox"+iSno;
								String strUserIDSn = "userID" +iSno;								
						%>									
						<tr align="left">
							<input type=hidden name="<%=strUserIDSn%>" value="<%=strUserId%>" />													
							<td width="22px" class="formtr1"><input type="checkbox" name="<%=strChkNameSn%>" class="childCheckBox" id="childCheckBox<%=i%>" value="<%=strCheckFlag%>" onclick="return fun_setvalueMyTeam(this.id);"/></td>
							<td width="40px" nowrap="nowrap" class="formtr1"><%=iSno%></td>
							<td nowrap="nowrap" class="formtr1"><%=strSiteName.trim()%></td>		
							<td nowrap="nowrap" class="formtr1"><%=strEmpName.trim()%></td>
							<td nowrap="nowrap" class="formtr1"><%=strMgrName.trim()%></td>
							<td class="formtr1"><%=strSiteAccess.trim()%></td>
							<td nowrap="nowrap" class="formtr1"><%=strRoleId.trim()%></td>
						</tr>						
						<script type="text/javascript">
						var i = '<%=i%>';
						$("#childCheckBox"+i).click(function () {
							if($(this).is(':checked')){
								$(this).val("Y");								
							} else if($(this).not(':checked')){
								$(this).val("N");
							}							
						});
						</script>	
						<%
						i++;
						iSno++;
						}
							rs3.close();
						} catch (SQLException e) {
					        e.printStackTrace();
					    } catch(Exception e) {
					    	e.printStackTrace();
					    }
						%>
						<%
						if(strNoRecordFlag.equalsIgnoreCase("true")) { %>	
							<tr align="left" id="nodatafoundrow" class="formtr1">
								<td colspan="7" style="text-align: center;font-weight: bold;color:red;">
									<%=dbLabelBean.getLabel("label.global.norecordfound",strsesLanguage)%>
								</td>							
							</tr>
						<% } %>
						</tbody>
						 <tfoot>
			              <tr style='display:none;' class="formtr1">
			                <td colspan='7' style="text-align: center;font-weight: bold;color:red;">
			                  <%=dbLabelBean.getLabel("label.global.norecordfound",strsesLanguage)%>
			                </td>
			              </tr>
			            </tfoot>
						<input type="hidden" name="flagIndex" value = "<%=iSno %>">						
				 	</table>
				</div>
			</td>
		</tr>
	</table>
	<table width="95%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder" id="footerBtnTbl" style="display:none;">
		<tr>
			<td align="right" class="selectedmenubg">
			
		<% 	if(user_Flag.equalsIgnoreCase("ALL")) { %>
				<input type="button" name="bt_add" id="bt_add" value="<%=dbLabelBean.getLabel("button.global.add",strsesLanguage)%>" class="formButton" onClick="" style="width:80px;">
		<%	} %> &nbsp;
				<input type="button" name="bt_remove" id="bt_remove" value="<%=dbLabelBean.getLabel("button.global.remove",strsesLanguage)%>" class="formButton" onClick="" style="width:80px;">
			</td>
		</tr>
	</table>

<%
if("CT".equalsIgnoreCase(user_Flag)) {
%>	
	<script>
	$(':button#bt_AU').addClass('formButton');
	
	$(':button#bt_MCT').css('background-color','#009f50');
	$(':button#bt_MCT').css('border-top-color','#009f50');
	$(':button#bt_MCT').css('border-bottom-color','#009f50');
	$(':button#bt_MCT').css('border-left-color','#009f50');
	$(':button#bt_MCT').css('border-right-color','#009f50');
	$(':button#bt_MCT').css("filter","progid:DXImageTransform.Microsoft.Gradient(GradientType=0,StartColorStr='#009f50',EndColorStr='#009f50')");
	</script>
<%	
} else {
%>
	<script>
	$(':button#bt_MCT').addClass('formButton');
	
	$(':button#bt_AU').css('background-color','#009f50');
	$(':button#bt_AU').css('border-top-color','#009f50');
	$(':button#bt_AU').css('border-bottom-color','#009f50');
	$(':button#bt_AU').css('border-left-color','#009f50');
	$(':button#bt_AU').css('border-right-color','#009f50');
	$(':button#bt_AU').css("filter","progid:DXImageTransform.Microsoft.Gradient(GradientType=0,StartColorStr='#009f50',EndColorStr='#009f50')");
	</script>
<%} %>
	<input type="hidden" name="chkBoxFlag" id="chkBoxFlag" value="<%=strChkBoxFlag%>" />
	<input type="hidden" name="ftBtnFlag" id="ftBtnFlag" value="<%=strftBtnFlag%>" />
	<input type="hidden" name="userFlag2" id="userFlag2" value="<%=user_Flag%>" />
	<input type="hidden" name="userFlagSelected" id="userFlagSelected" value="<%=strUserFlagSelected%>" />
</form>
<script language="javaScript">  
	closeDivRequest();
</script>
<script type="text/javascript">
$(document).ready(function () {
	
	var userFlagSelected = $("#userFlagSelected").val();
	if(userFlagSelected == "true"){		
		$("select#username").attr('selectedIndex', 1); 
	} 
	
	var divContentsHeight = screen.height * 0.38;
	var detailTableHeight = $('table#detailTable').outerHeight();	
    if(detailTableHeight > divContentsHeight){
    	$('div#divContents').css({'height': ""+divContentsHeight+"", 'overflow-y': 'auto'});
    } else {
    	$('div.gm-style-iw').css({'height': "auto"});
    }
	
	var autoSelectChkFlag = $("#chkBoxFlag").val();		
	if(autoSelectChkFlag == "true"){
		for(var i=0; i < $(":checkbox.childCheckBox").length; i++) {
			var childChkVal = $(":checkbox#childCheckBox"+i).val();
	    	if(childChkVal == "Y"){    		
	    		$(":checkbox#childCheckBox"+i).attr('checked','checked');
	    	} else if(childChkVal  == "N"){    		
	    		$(":checkbox#childCheckBox"+i).removeAttr("checked");
	    	}        
	    }
		
		if($(":checkbox.childCheckBox").length == $(":checkbox.childCheckBox:checked").length) {
	        $(":checkbox.parentCheckBox").attr("checked", "checked");
	    } else {
	        $(":checkbox.parentCheckBox").removeAttr("checked");
	    }
	}
	
	var ftBtnShowFlag = $("#ftBtnFlag").val();
	if(ftBtnShowFlag == "true"){
		document.getElementById("footerBtnTbl").style.display="block";
	} else{
		document.getElementById("footerBtnTbl").style.display="none";
	}
	
	var noDataRow = "";
	noDataRow = $("table#detailTable").find('tbody:first tr').attr('id');	
	if($("table#detailTable").find('tbody:first tr').length > 0 && noDataRow != "nodatafoundrow"){		
		//var oTable  = $("table#detailTable").dataTable({ retrieve: true, bPaginate: false, bInfo: false, bDestroy: true} ).columnFilter();
		 $("table#detailTable").tablesorter({
			 sortInitialOrder : "asc",
			 widgets: ['zebra'], 
			 headers : {0: { sorter: false },
				 		1: { sorter: "digit" },
				 		2: { sorter: "text" },
				 		3: { sorter: "text" },
				 		4: { sorter: "text" },
				 		5: { sorter: "text" }
				 		},
			textExtraction : {0: function(node) {return $(node).text();},
							  1: function(node) {return $(node).text();},
							  2: function(node) {return $(node).text();},
							  3: function(node) {return $(node).text();},
							  4: function(node) {return $(node).text();},
							  5: function(node) {return $(node).text();}
							  }
				 		});	
		 
		 $("#detailTable tbody tr").quicksearch({
             labelText: '<%=dbLabelBean.getLabel("label.global.search",strsesLanguage)%> : ',
             attached: '#searchTd',
             position: 'append',
             delay: 100,             
             loaderText: '',
             onAfter: function() {
                 if ($("#detailTable tbody tr:visible").length != 0) {
                     $("#detailTable").trigger("update");
                     $("#detailTable").trigger("appendCache");
                     $("#detailTable tfoot tr").hide();
                     $("#loader").hide();
                 }
                 else {
                     $("#detailTable tfoot tr").show();
                 }
             }
         });
	}
	
	var msg='<%=strMessage%>';
	if(msg != ""){
		alert(msg);
	}
});
</script>
</body>
</html>