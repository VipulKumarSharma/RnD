	<%@ include file="importStatement.jsp"%>
	<html>
	<head>
	<%@ page pageEncoding="UTF-8" %>
	<%-- include remove cache  --%>
	<%@ include file="cacheInc.inc"%>
	<%-- include header  --%>
	<%@ include file="headerIncl.inc"%>
	
	<%-- include page with all application session variables --%>
	<%@ include file="application.jsp"%>
	<%-- include page styles  --%>
	<%-- <%@ include  file="systemStyle.jsp" %> --%>
	<!--Create the DbConnectionBean object for createConnection-->
	<jsp:useBean id="dbConBean" scope="page"
		class="src.connection.DbConnectionBean" />
	<jsp:useBean id="dbConBean1" scope="page" 
		class="src.connection.DbConnectionBean" />
	<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
	<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
	<script language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></script>
	<script language=JavaScript src="ScriptLibrary/jQueryMaster.js?buildstamp=2_0_0"></script>
	
	<%
	request.setCharacterEncoding("UTF-8");
	
	Connection objCon					=		null;	
	CallableStatement objCstmt			=		null;	
	ResultSet  rs                     	=		null;
	objCon = dbConBean1.getConnection();	
	
	String isMATA_GmbH = (String)hs.getValue("isMataGmbHSite");
	
	%>
	
	<script>
	
	function closeDivRequest() {
		document.getElementById("waitingData").style.display="none";
	}

	function openWaitingProcess() {
			var dv = document.getElementById("waitingData");
			if(dv != null)
			{
				var xpos = screen.availHeight/2+90;
				var ypos = screen.availWidth/2-450;   
				dv.style.position="absolute";       		
				dv.style.left=(xpos+10)+"px";
				dv.style.top=(ypos)+"px";
				document.getElementById("waitingData").style.display="";
			}
	}
	</script>
	</head>
	<body>
	<script type="text/javascript" language="JavaScript1.2"
		src="menu/menu_cnt.js?buildstamp=2_0_0"></script>
		<div id="waitingData" style="display: none;z-index: 1;"> 	  
		 	<img src="images/loading16.gif?buildstamp=2_0_0" width="50" height="51" border="0" /> 
		 	<br>      
		 	<center><font color="#000080" class="pageHead">
		 	<%=dbLabelBean.getLabel("label.global.pleasewait",strsesLanguage)%> </font></center>    
		</div>
		<script>
		openWaitingProcess();
		</script>
	<%
	  int iCls = 0;
	  int countflag = 0; 
	  
	  String strStyleCls = "";
	  String strGroupTravelFlag="";
	  String strTravelAgencyTypeId="";
	  String strRadValue	="";
	  
	  String strRequstionNo       =  request.getParameter("reqno"); 
	  String  strOrigenation      =  request.getParameter("originatedby"); 
	  String strDeptdate          =  request.getParameter("deptdate"); 
	  String strDestination       =  request.getParameter("destination"); 	  
	  String strUnitNo            =  request.getParameter("SelectUnit"); 
	  String strTravler           =  request.getParameter("username"); 
	  String strCreateFromdate    =  request.getParameter("fromdate");
	  String strCreateTodate      =  request.getParameter("todate");
	  String strStatus1           =  request.getParameter("status");
	  String strPendingApprover   =  request.getParameter("papprover");
	  String strApproveFromdate   =  request.getParameter("fromdate1");
	  String strApproveTodate     =  request.getParameter("todate1");
	  String strTravelType 		  =  request.getParameter("travelType"); 
	  String searchType			  =	 request.getParameter("searchType"); 
	  String keyWordSearchVal	  =	 request.getParameter("keyWordParamVal");	  
	  String requestAppFlag	      =	 request.getParameter("requestAppFlag");
	 
	 if(searchType != null && searchType.equalsIgnoreCase("quick")){
		  strCreateFromdate    =  request.getParameter("Qfromdate");
		  strCreateTodate      =  request.getParameter("Qtodate");
		  strUnitNo            =  request.getParameter("QSelectUnit"); 
	  }
	
	%>
	

	<SCRIPT LANGUAGE="JavaScript">
				function write1()
				{
				var txt='';
				txt=  document.getElementById("main").innerHTML	;
				document.frm.va.value='';
				document.frm.va.value=txt;
				}
				
				
	//function created by manoj chand on 01-oct-2013 to call erp or mata can cancel request web service
	function fun_callwebservice(erpwsurl,matawsurl,cid,reqno,travelid,siteid,traveltype){
		document.getElementById("waitingData").style.display="";
	 	var Params='requestnumber='+reqno+'&erpurl='+erpwsurl+'&mataurl='+matawsurl+'&cid='+cid+'&actionflag=cancancelrequest&travel_id='+travelid+'&site_id='+siteid;
        var urlParams=Params;
		$.ajax({
	            type: "post",
	            url: "CancelTrip",
	            data: urlParams,
	            success: function(result){
				var res = jQuery.trim(result);
				if(res == 'yes'){
					if(confirm('<%=dbLabelBean.getLabel("alert.search.areyousure",strsesLanguage)%>')){
						var finalresult = fun_callwebservice1(erpwsurl,matawsurl,cid,reqno,travelid,siteid,traveltype);
						if(finalresult == 'TT'){
							alert('<%=dbLabelBean.getLabel("alert.search.requesthasbeencancelled",strsesLanguage)%>');
							top.main_11.frm.submit();
						}else if(finalresult == 'Error'){
							alert('Error!');
						}else{
							alert(finalresult);
						}
					}
				}else{
					alert(res);
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
	//function created by manoj chand on 01-oct-2013 to call erp or mata cancel request web service 
	function fun_callwebservice1(erpwsurl,matawsurl,cid,reqno,travelid,siteid,traveltype){
		document.getElementById("waitingData").style.display="";
		var flag = '';
	 	var Params='requestnumber='+reqno+'&erpurl='+erpwsurl+'&mataurl='+matawsurl+'&cid='+cid+'&actionflag=cancelrequest&travel_id='+travelid+'&site_id='+siteid+'&travel_type='+traveltype;
        var urlParams=Params;
		$.ajax({
	            type: "post",
	            url: "CancelTrip",
	            data: urlParams,
	            async: false,
	            success: function(result){
				var res = jQuery.trim(result);
				flag = res;
            },
            complete: function(){
            	document.getElementById("waitingData").style.display="none";
            	},
			error: function(){
				alert('<%=dbLabelBean.getLabel("label.global.jqueryerror",strsesLanguage)%>');
            }
          });
        return flag;
	}		

	</script>
	
	
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	  <tr>
	    <td height="40" class="bodyline-top">
		<ul class="pagebullet">
	      <li class="pageHead"><%=dbLabelBean.getLabel("label.search.searchtravelrequisitions",strsesLanguage)%></li>
	    </ul></td>
	    <td align="right" valign="bottom" class="bodyline-top">
		<table align="right" border="0" cellspacing="0" cellpadding="0">
	  <tr align ="right">
	  <td>
	     <ul id="list-nav">
	      <li><a href="#" onClick="javascript:top.window.close();"><%=dbLabelBean.getLabel("button.global.close",strsesLanguage) %></a></li>
	     </ul>
	       </td>
	  </tr>
	  </table>
	</td>
	</tr>
	</table>

	<form method=post action="issue_exlWrite.jsp" name="frm">
		
	<table width="99%" align="center" border="0" cellspacing="1" border=0
		cellpadding="5" class="formborder">
		<tr align="right" class="formhead" height="16">
			<td colspan="12" align="right"><input type=submit
				value='<%=dbLabelBean.getLabel("button.search.exporttoexcel",strsesLanguage)%>' class="formButton" onClick="write1();">
			<input type=button Value="<%=dbLabelBean.getLabel("button.search.print",strsesLanguage)%>" class="formButton"
				onClick="window.print();"></td>
		</tr>
	</table>

	<div id="dv" style="width:99%; left:5px; top:90px; bottom:5px; height:80%; border-color:red; position: absolute; overflow: auto;" >
	<span id=main>	
	<table width="100%" align="left" border="0" cellpadding="5" 
		cellspacing="1" class="formborder">  
		<tr align="center" class="formhead"> 
			<td width="4%" align="left" nowrap="nowrap"><%=dbLabelBean.getLabel("label.global.sno",strsesLanguage)%></td>
			<td width="13%" align="left"><%=dbLabelBean.getLabel("label.global.requisitionnumber",strsesLanguage)%></td>
			<td width="10%" align="left"><%=dbLabelBean.getLabel("label.global.unitname",strsesLanguage)%></td>
			<td width="13%" align="left"><%=dbLabelBean.getLabel("label.search.originatorname",strsesLanguage)%></td>
			<td width="13%" align="left"><%=dbLabelBean.getLabel("label.global.travelername",strsesLanguage)%></td>
			<td width="12%" align="left"><%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%></td>
			<td width="10%" align="left"><%=dbLabelBean.getLabel("label.global.travelfrom",strsesLanguage)%></td>
			<td width="8%" align="left"><%=dbLabelBean.getLabel("label.global.travelto",strsesLanguage)%></td>
			<td width="10%" align="left"><%=dbLabelBean.getLabel("label.global.totalamount",strsesLanguage)%></td>
			<td width="6%" align="left"><%=dbLabelBean.getLabel("label.requestdetails.status",strsesLanguage)%></td>
		</tr>

		<%
					int iSno=1;
					String OriginatorName		="";
					String sRequisitionNo		="";
					String NAME					="";
					String TRAVEL_DATE			="";
					String DERPARTMENT_NAME	 	="";
					String DIVISIONNAME			="";
					String SITENAME				="";
					String TRAVELFROM			="";
					String TRAVELTO				="";
					String TOTALAMOUNT			="";
					String TACURRENCY			="";
					String TCHEQUE				="";
					String TCURRENCY			="";
					String APPROVEDBY			="";
					String APPROVE_STATUS		="";
					String Traveller_id			="";
					String TRAVEL_REQ_ID		="";
					String ORIGINATED_BY		="";
					String TRAVEL_ID			="";
					String C_DATETIME			="";
					String strPageUrl           ="";
	
					String strERPWS_URL = "",strMATAWS_URL="",strCID="",strSiteId="";
					
					objCstmt=objCon.prepareCall("{call SEARCH_TRAVEL_REQUEST(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
					objCstmt.setString(1,strUnitNo);
					objCstmt.setString(2,strOrigenation);
					objCstmt.setString(3,strTravler);
					objCstmt.setString(4,strDeptdate);
					objCstmt.setString(5,strRequstionNo);
					objCstmt.setString(6,strDestination);
					objCstmt.setString(7,strCreateFromdate);
					objCstmt.setString(8,strCreateTodate);
					objCstmt.setString(9,strPendingApprover);
					objCstmt.setString(10,strStatus1);
					objCstmt.setString(11,strApproveFromdate);
					objCstmt.setString(12,strApproveTodate);
					objCstmt.setString(13,strTravelType);
					objCstmt.setInt(14,Integer.parseInt(Suser_id));
					objCstmt.setString(15,keyWordSearchVal);
					objCstmt.setString(16,requestAppFlag);
					rs=objCstmt.executeQuery();
					
					while(rs.next()) {					
						 countflag=1;
						 OriginatorName					=	rs.getString("Originator_Name");
						 TRAVEL_REQ_ID					=	rs.getString("TRAVEL_REQ_ID");
						 TRAVEL_ID						=	rs.getString("TRAVEL_ID");
						 Traveller_id					=	rs.getString("TRAVELLER_ID");
						 sRequisitionNo					=	rs.getString("TRAVEL_REQ_NO");
						 ORIGINATED_BY					=	rs.getString("ORIGINATED_BY");
						 C_DATETIME						=	rs.getString("C_DATETIME");
						 DIVISIONNAME					=	rs.getString("DIVISION");
						 SITENAME						=	rs.getString("UNIT");
						 DERPARTMENT_NAME				=	rs.getString("DEPT_name");
						 NAME							=	rs.getString("CURRENT_TRAVELLER");
						 TRAVELFROM						=	rs.getString("TRAVEL_FROM");
						 TRAVELTO						=	rs.getString("TRAVEL_TO");
						 TOTALAMOUNT					=	rs.getString("TOTAL_AMOUNT");
						 String  tRAVEL_DATE			=	rs.getString("TRAVEL_DATE");
						 strTravelType					=   rs.getString("TRAVEL_TYPE");
							
						 TRAVEL_DATE=tRAVEL_DATE;  //  code added by shiv on 17-May-07
		   
		            //  Added by shiv for showing Group Travel in case of group travel inspite of traveller Name on  21-Feb-08 ;      
		                 if(strTravelType.equals("INT"))
					         {
									strGroupTravelFlag       =   rs.getString("GROUP_TRAVEL_FLAG"); 
									strTravelAgencyTypeId			=	rs.getString("travel_agency_id");
									if(strGroupTravelFlag==null) 
									{
										strGroupTravelFlag="N";
									}
									if(strGroupTravelFlag!=null  &&  (strGroupTravelFlag.trim().equals("Y")))   
									{		
										NAME="Group/Guest Travel ";
										strPageUrl = "Group_T_TravelRequisitionDetails.jsp";
										if(strTravelAgencyTypeId != null && strTravelAgencyTypeId.equals("2")){
											strPageUrl = "Group_T_TravelRequisitionDetails_GmbH.jsp";
											}
	  							    }
									else {
										strPageUrl = "T_TravelRequisitionDetails.jsp";
										if(strTravelAgencyTypeId != null && strTravelAgencyTypeId.equals("2")){
											strPageUrl = "T_TravelRequisitionDetails_INT_GmbH.jsp";
										}
									}
							}  
		 	            else //// Added by shiv for showing Group Travel_DOM in case of group travel inspite of traveller Name on 02-Jul-08 ;      
					     {
									strGroupTravelFlag       =   rs.getString("GROUP_TRAVEL_FLAG");
									strTravelAgencyTypeId			=	rs.getString("travel_agency_id");
									if(strGroupTravelFlag==null) 
									{
										strGroupTravelFlag="N";
									}
									if(strGroupTravelFlag!=null  &&  (strGroupTravelFlag.trim().equals("Y")))   
									{		
										NAME="Group/Guest Travel ";
										strPageUrl = "Group_T_TravelRequisitionDetails_D.jsp";
										if(strTravelAgencyTypeId != null && strTravelAgencyTypeId.equals("2")){
											strPageUrl = "Group_T_TravelRequisitionDetails_GmbH.jsp";
											}
	  							    }
									else {
										strPageUrl = "T_TravelRequisitionDetails_D.jsp";
										if(strTravelAgencyTypeId != null && strTravelAgencyTypeId.equals("2")){
											strPageUrl = "T_TravelRequisitionDetails_INT_GmbH.jsp";
										}
									}
							}  
					    strCID = rs.getString("CID");
						strERPWS_URL = rs.getString("ERP_WS_URL");
						strMATAWS_URL = rs.getString("MATA_WS_URL");
						strSiteId = rs.getString("SITE_ID");
				
				if (iCls % 2 == 0) {
					strStyleCls = "formtr2";
				} else {
					strStyleCls = "formtr1";
				}
	
				iCls++;
		%>
		<tr valign=top class="<%=strStyleCls%>">
			<!-- T_TravelRequisitionDetails.jsp -->
			<td width="4%" class="rep-head"><%=iSno%><br>
			<td width="13%" class="rep-txt">
			<%
			if (strTravelType.equals("INT")) {
			%> <a href="#"
				onClick="MM_openBrWindow('<%=strPageUrl%>?purchaseRequisitionId=<%=TRAVEL_ID%>&traveller_Id=<%=Traveller_id%>&travelType=I','SEARCH1','scrollbars=yes,resizable=yes,width=975,height=550')">
			<%=sRequisitionNo%></a> <%
	 }
	 %>
			<%
			if (strTravelType.equals("DOM")) {
			%> <a href="#"
				onClick="MM_openBrWindow('<%=strPageUrl%>?purchaseRequisitionId=<%=TRAVEL_ID%>&traveller_Id=<%=Traveller_id%>&travelType=D','SEARCH1','scrollbars=yes,resizable=yes,width=975,height=550')">
			<%=sRequisitionNo%></a> <%
	 }
	 %>
			</td>
			<td width="10%" class="rep-txt"><%=SITENAME%></td>
			<td width="13%" class="rep-txt"><%=OriginatorName%></td>
			<td width="13%" class="rep-txt"><%=NAME%></td>
			<td width="12%" class="rep-txt"><%=TRAVEL_DATE%></td>
			
			
			<td width="10%" class="rep-txt"><%=TRAVELFROM%></td>
			<td width="8%" class="rep-txt"><%=TRAVELTO%></td>
			<td width="10%" class="rep-txt"><%=TOTALAMOUNT%></td>
			<%
			if (strTravelType.equals("INT")) {
			%>
			<td class="listdata" width="7%" align="center"><a href="#"
				onClick="MM_openBrWindow('T_TravelRequisitionWorkFlowDiagram.jsp?travelRequisitionId=<%=TRAVEL_ID%>&strTravellerId=<%=Traveller_id%>&strTravelRequestNo=<%=sRequisitionNo%>&travelType=I','SEARCH1','scrollbars=yes,resizable=yes,width=775,height=250')"><%=dbLabelBean.getLabel("link.search.approvers",strsesLanguage)%></a>
			<%
				
					if((strERPWS_URL!=null && !strERPWS_URL.equals("")) && (strMATAWS_URL!=null && !strMATAWS_URL.equals(""))){
					%>
					<a href="#"	onClick="fun_callwebservice('<%=strERPWS_URL %>','<%=strMATAWS_URL %>','<%=strCID %>','<%=sRequisitionNo %>','<%=TRAVEL_ID %>','<%=strSiteId %>','I')">Cancel</a>
				<%	}
				%>
				</td>
			<%}
			%>
			<%
			if (strTravelType.equals("DOM")) { //System.out.println("in else of approver window");
			%>
			<td class="listdata" width="13%" align="center"><a href="#"
				onClick="MM_openBrWindow('T_TravelRequisitionWorkFlowDiagram.jsp?travelRequisitionId=<%=TRAVEL_ID%>&strTravellerId=<%=Traveller_id%>&strTravelRequestNo=<%=sRequisitionNo%>&travelType=D','SEARCH1','scrollbars=yes,resizable=yes,width=775,height=250')"><%=dbLabelBean.getLabel("link.search.approvers",strsesLanguage)%></a>
			
			<%
				if((strERPWS_URL!=null && !strERPWS_URL.equals("")) && (strMATAWS_URL!=null && !strMATAWS_URL.equals(""))){
					%>
					<a href="#"	onClick="fun_callwebservice('<%=strERPWS_URL %>','<%=strMATAWS_URL %>','<%=strCID %>','<%=sRequisitionNo %>','<%=TRAVEL_ID %>','<%=strSiteId %>','D')">Cancel</a>
				<%	}
				%>
				</td>
				
			<%}	%>
			</tr>
			<%
					iSno++;
					}
					rs.close();
					if(countflag == 0){%>
					<tr class="formtr2">
					<td colspan="10"><%=dbLabelBean.getLabel("label.approverequest.norecordfound",strsesLanguage) %>
					</td>
					</tr>
					</table>
				<%	}
				dbConBean.close(); //Close All Connection
				%>
	
	
	   </span>
	</div>
	<input type=hidden name=va>	
	 </form>
	 <script>
	 closeDivRequest();
	 </script>
	</body>
	</html>
