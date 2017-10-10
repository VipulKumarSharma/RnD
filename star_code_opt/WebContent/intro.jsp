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
	
	<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
	
	<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
	<script language="JavaScript" src="scripts/BackSpaceDisable.js?buildstamp=2_0_0"></script> 
	<script type="text/javascript" src="ScriptLibrary/jQueryMaster.js?buildstamp=2_0_0"></script>
	
	<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
	<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
	<%
	String strLangValue= request.getParameter("language")==null?strsesLanguage:request.getParameter("language");
	hs.putValue("sesLanguage",strLangValue);
	%>

	<script language="JavaScript">
	<!--
	function MM_reloadPage(init) {  //reloads the window if Nav4 resized
	  if (init==true) with (navigator) {if ((appName=="Netscape")&&(parseInt(appVersion)==4)) {
	    document.MM_pgW=innerWidth; document.MM_pgH=innerHeight; onresize=MM_reloadPage; }}
	  else if (innerWidth!=document.MM_pgW || innerHeight!=document.MM_pgH) location.reload();
	}
	MM_reloadPage(true);
	// -->
	
	//added by manoj chand on 22 may 2012
	function getLanguaeID(){
	var lang = document.getElementById("language").value;
		parent.frames['top11'].location.href='top11.jsp?id=1&language='+document.getElementById('language').value;
		parent.frames['middle'].location.href='intro.jsp?id=1&language='+document.getElementById('language').value;
		//parent.frames['bottom11'].location.href='bot2.jsp?id=1&language='+document.getElementById('language').value;
		
		if(lang=="en_US"){
			parent.bottom11.updateLanguage('<%=dbLabelBean.getLabel("label.footer.welcome","en_US")%>','<%=dbLabelBean.getLabel("label.footer.tostars","en_US")%>','<%=dbLabelBean.getLabel("label.footer.logindateandtime","en_US")%>','<%=dbLabelBean.getLabel("label.footer.starspresentation","en_US")%>','<%=dbLabelBean.getLabel("label.footer.mytasks","en_US")%>','<%=dbLabelBean.getLabel("label.footer.home","en_US")%>','<%=dbLabelBean.getLabel("label.footer.helpdesk","en_US")%>','<%=dbLabelBean.getLabel("label.footer.logout","en_US")%>');
		}else if(lang=="ja_JP"){
			parent.bottom11.updateLanguage('<%=dbLabelBean.getLabel("label.footer.welcome","ja_JP")%>','<%=dbLabelBean.getLabel("label.footer.tostars","ja_JP")%>','<%=dbLabelBean.getLabel("label.footer.logindateandtime","ja_JP")%>','<%=dbLabelBean.getLabel("label.footer.starspresentation","ja_JP")%>','<%=dbLabelBean.getLabel("label.footer.mytasks","ja_JP")%>','<%=dbLabelBean.getLabel("label.footer.home","ja_JP")%>','<%=dbLabelBean.getLabel("label.footer.helpdesk","ja_JP")%>','<%=dbLabelBean.getLabel("label.footer.logout","ja_JP")%>');
		}
		
	}
	</script>
	</head>
	<base target=middle>
	
	<%
	//System.out.println("language--->"+strsesLanguage);
	

	if(request.getParameter("id")!=null)
	{
	%>
		<body class="body" topmargin="0" marginheight="0">
	<%
	}
	else
	{
	%>
	    <body class="body" topmargin="0" marginheight="0">
	<%
	}
	%>
	
	<!--  adeed new for showing vesion  -->
	<%
	
	 
		String  sSqlStr 				=	"";
		String  stmt  					=	"";
		String strUserId    			=	null;
		ResultSet rs,rs1				=	null; 
		
		String strReleaseVersion="";

		
		sSqlStr="SELECT TOP 1 VER_REL_LOG_ID,ISNULL(RELEASE_VERSION,'') AS  RELEASE_VERSION FROM VERSION_RELEASE_LOG ORDER BY VER_REL_LOG_ID DESC";
		rs = dbConBean.executeQuery(sSqlStr);  
		while(rs.next())
		{
			strReleaseVersion=rs.getString("RELEASE_VERSION"); 

		}
		rs.close();
		
		
		
		int count		   =  0;
		int expTrvReqWeeks = 0;
		
		sSqlStr  = "SELECT CAST(FUNCTION_VALUE AS INT) FROM functional_ctl WHERE FUNCTION_KEY='@ExpTrvReqCutOffWeekForApproval'";
		rs = dbConBean.executeQuery(sSqlStr);
		if(rs.next())
		{
			expTrvReqWeeks = rs.getInt(1);
		}
		rs.close();
		
		
		
		sSqlStr="SELECT DISTINCT  TA.TRAVEL_ID "+
				" FROM   T_APPROVERS TA INNER JOIN"+
				" T_TRAVEL_STATUS TS on TA.TRAVEL_ID = TS .TRAVEL_ID INNER JOIN"+
				" T_TRAVEL_DETAIL_INT TD  on TD.TRAVEL_ID = TS .TRAVEL_ID "+
				" WHERE TS.STATUS_ID=10 AND TD.STATUS_ID=10 AND TS.TRAVEL_STATUS_ID = 2 "+
				" AND TS .TRAVEL_TYPE = 'I'"+ 
				" AND  TA.APPROVE_STATUS = 0 "+
				" AND TA.APPROVER_ID ="+Suser_id+
				" AND TA.TRAVEL_TYPE = 'I' "+
				" AND ORDER_ID = (SELECT   MIN(ORDER_ID)  FROM  T_APPROVERS"+   
				" WHERE  TRAVEL_ID = TS .TRAVEL_ID AND TRAVEL_TYPE = 'I' AND APPROVE_STATUS = 0 AND STATUS_ID = 10) AND TD.TRAVEL_DATE>=CAST(DATEADD(WK,-"+expTrvReqWeeks+",GETDATE()) AS DATE)"+   
				" AND ((TA.PAP_APPROVER = 0) OR (TA.PAP_APPROVER <> 0 AND TA.PAP_FLAG <> '' ))"+
				" union"+
				" SELECT DISTINCT   TA.TRAVEL_ID "+
				" FROM  T_APPROVERS TA inner join"+
				" T_TRAVEL_STATUS TS on TA.TRAVEL_ID = TS .TRAVEL_ID inner join"+
				" T_TRAVEL_DETAIL_INT TD on TD.TRAVEL_ID = TS .TRAVEL_ID inner join"+ 
				" PAGE_ACCESS_PERMISSION PAP on PAP.pendingwithuser =  case when TA.ORIGINAL_APPROVER =0 then TA.APPROVER_ID else TA.ORIGINAL_APPROVER end "+
				" WHERE	TS.STATUS_ID=10 AND TD.STATUS_ID=10 AND TS.TRAVEL_STATUS_ID = 2 "+
				" AND		TS.TRAVEL_TYPE = 'I' "+
				" AND		TA.APPROVE_STATUS = 0 "+
				" AND		PAP.STATUS =10"+    
				" AND		(TA.PAP_APPROVER  ="+Suser_id+" or PAP.viewtouser="+Suser_id+")"+
				" AND TA.PAP_FLAG ='' AND TA.TRAVEL_TYPE = 'I'"+  
				" AND		ORDER_ID =(SELECT     MIN(ORDER_ID) FROM  T_APPROVERS  WHERE    TRAVEL_ID = TS .TRAVEL_ID"+ 
				" AND TRAVEL_TYPE = 'I' AND  APPROVE_STATUS = 0 AND STATUS_ID = 10) AND TD.TRAVEL_DATE>=CAST(DATEADD(WK,-"+expTrvReqWeeks+",GETDATE()) AS DATE)";
				
				rs = dbConBean.executeQuery(sSqlStr);
				while(rs.next()) {
					count++;
				}
				rs.close();
				
		sSqlStr="SELECT DISTINCT  TA.TRAVEL_ID "+  
		        " FROM   T_APPROVERS TA INNER JOIN"+
		        " T_TRAVEL_STATUS TS on TA.TRAVEL_ID = TS .TRAVEL_ID INNER JOIN"+
		        " T_TRAVEL_DETAIL_DOM TD  on TD.TRAVEL_ID = TS .TRAVEL_ID"+ 
				" WHERE TS.STATUS_ID=10 AND TD.STATUS_ID=10 AND TS.TRAVEL_STATUS_ID = 2 AND TS .TRAVEL_TYPE = 'D' AND  TA.APPROVE_STATUS = 0 AND TA.APPROVER_ID ="+Suser_id+ 
				" AND TA.TRAVEL_TYPE = 'D' AND ORDER_ID = (SELECT   MIN(ORDER_ID)  FROM  T_APPROVERS"+   
				" WHERE  TRAVEL_ID = TS .TRAVEL_ID AND TRAVEL_TYPE = 'D' AND APPROVE_STATUS = 0 AND STATUS_ID = 10) AND TD.TRAVEL_DATE>=CAST(DATEADD(WK,-"+expTrvReqWeeks+",GETDATE()) AS DATE)"+   
				" AND ((TA.PAP_APPROVER = 0) OR (TA.PAP_APPROVER <> 0 AND TA.PAP_FLAG <> '' ))"+
				" union "+
				" SELECT DISTINCT   TA.TRAVEL_ID "+  
				" FROM  T_APPROVERS TA inner join"+
				" T_TRAVEL_STATUS TS on TA.TRAVEL_ID = TS .TRAVEL_ID inner join"+
				" T_TRAVEL_DETAIL_DOM TD on TD.TRAVEL_ID = TS .TRAVEL_ID inner join"+ 
				" PAGE_ACCESS_PERMISSION PAP on PAP.pendingwithuser =  case when TA.ORIGINAL_APPROVER =0 then TA.APPROVER_ID else TA.ORIGINAL_APPROVER end "+
				" WHERE TS.STATUS_ID=10 AND TD.STATUS_ID=10 AND	TS.TRAVEL_STATUS_ID = 2"+ 
				" AND		TS.TRAVEL_TYPE = 'D'"+ 
				" AND		TA.APPROVE_STATUS = 0"+ 
				" AND		PAP.STATUS =10"+
				" AND		(TA.PAP_APPROVER  ="+Suser_id+" or PAP.viewtouser="+Suser_id+")"+ 
				" AND TA.PAP_FLAG ='' AND TA.TRAVEL_TYPE = 'D'"+  
				" AND		ORDER_ID =(SELECT     MIN(ORDER_ID) FROM  T_APPROVERS  WHERE    TRAVEL_ID = TS .TRAVEL_ID"+
				" AND TRAVEL_TYPE = 'D' AND  APPROVE_STATUS = 0 AND STATUS_ID = 10) AND TD.TRAVEL_DATE>=CAST(DATEADD(WK,-"+expTrvReqWeeks+",GETDATE()) AS DATE)";
				
				rs = dbConBean.executeQuery(sSqlStr);
				while(rs.next()) {
					count++;	
				}
				rs.close();
						
						
	%>
	<form>
<%-- 	<DIV align="right" style="vertical-align: top;"><span style="color:#111111; font-family:Verdana, Arial, Helvetica, sans-serif; font-size:13px;font-weight: bold;vertical-align: top;"><%=dbLabelBean.getLabel("label.mylinks.language",strsesLanguage) %>:</span> --%>
<!-- 	<select id="language" name="language" class="textBoxCss" onchange="getLanguaeID();"> -->
<%-- 	                        <!-- <option value="-1" selected><%//=dbLabelBean.getLabel("label.global.selectlanguage",strLangValue) %></option>  -->   --%>
<%-- 							  <%  --%>
<%-- // 							  rs=null;
// 							   sSqlStr = "SELECT DISTINCT LANG_ID,LANG_VALUE,LANGUAGE_NAME FROM LANGUAGE_MST WHERE LANGUAGE_MST.STATUS_ID=10 ORDER BY LANGUAGE_MST.LANG_ID";
// 	                           rs       =   dbConBean.executeQuery(sSqlStr);  
// 							   while(rs.next())
// 	                          {
<%-- 							   %>        --%>
<%-- 	                            <option value="<%=rs.getString("LANG_VALUE")%>"><%=rs.getString("LANGUAGE_NAME")%></option> --%>
<%-- 								<% --%>
<%--// 								}
// 	                           rs.close();--%>
<%-- 	                           %> --%>
<!-- 	 </select> -->
<!-- 	 <script> -->
<%-- 	 document.getElementById('language').value='<%=strLangValue%>'; --%>
<!-- 	 </script> -->
<!-- 	</DIV> -->
	
<!-- 	<table width="100%" border="0" cellspacing="0" cellpadding="0"> -->
<!-- 	  <tr> -->
<!-- 	    <td height="350" align="center"><img src="images/bgbgbg.jpg?buildstamp=2_0_0" ></td>  -->
<!-- 	  </tr> -->
<!-- 	</table> -->
<!-- 	<div id="Layer1" style="position:absolute; width:410px; height:110px; z-index:1; left: 510px; top: 200px">    -->
<!-- 	  <table width="60%" border="0" cellspacing="0" cellpadding="0" class="logintable"> -->
<!-- 	    <tr> -->
<!-- 	      <td align="center" style="font-family:Verdana, Arial, Helvetica, sans-serif; -->
<!-- 		color:0C6AAF; font-size:12;">  -->
<%-- 	        <%=dbLabelBean.getLabel("label.homepage.clickontask",strLangValue) %> <br> <%=dbLabelBean.getLabel("label.homepage.seeimmediatetasks",strLangValue) %>  --%>
<!-- 		  </td> -->
<!-- 	    </tr> -->
	     
<!-- 	  </table>	   -->
<!-- 	 </div> -->
	 
	 
<!-- 	<div id="Layer1" style="position:absolute; width:610px; height:60px; z-index:1; left: 330px; top: 320px" >       -->
<!-- 	  <table width="60%" border="0" cellspacing="0" cellpadding="0" class="logintable"> -->
<!-- 	    <tr> -->
<!-- 	      <td align="center" style="font-family:Verdana, Arial, Helvetica, sans-serif; -->
<!-- 		color:0C6AAF; font-size:10;">  -->
<%-- 	        <%=dbLabelBean.getLabel("label.global.version",strLangValue) %>: <%=strReleaseVersion %>   --%>
<!-- 		  </td> -->
<!-- 	    </tr> -->
	     
<!-- 	  </table> -->
	  
<!-- 	 </div> -->
	
<!-- 	  <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">       -->
	 
<!-- 	  <tr> -->
<!-- 	  <td  align="center"  style="font-family:Verdana, Arial, Helvetica, sans-serif; -->
<!-- 		color:0C6AAF; font-size:11;">   -->
<%-- 	  <%=dbLabelBean.getLabel("label.homepage.viewmessage",strLangValue) %> --%>
<!-- 	  </td> -->
<!-- 	  </tr> -->
	  
<!-- 	  </table>  -->

	<table width="100%" border="0" cellspacing="0" cellpadding="0" id="blockTbl">
	<%String isMATA_GmbH = (String)hs.getValue("isMataGmbHSite"); 
	if(isMATA_GmbH != null && isMATA_GmbH.equals("true")){%>
		<tr>
			<td width="10%"></td>
			<td width="50%">
				<table width="100%" border="0" cellspacing="15" cellpadding="0">
					<tr>
						<td class="imageTD">
							<a href="javascript:onCreateRequestClick(true)" title="<%=dbLabelBean.getLabel("label.createrequest.createtravelrequest",strLangValue) %>">
								<div id="creReqDiv" class="hoverDiv">
									<div id="divMain">
										<div id="creReqDivInner"></div>																			
									</div>
									<div class="divText"><%=dbLabelBean.getLabel("label.global.createrequest",strLangValue) %></div>
								</div>
							</a>
						</td>
						<td class="imageTD">						
							<a href="javascript:onCreateRequestClick(false)" title="<%=dbLabelBean.getLabel("label.global.guestTravelRequest",strLangValue) %>">
								<div id="creGroupReqDivInt" class="hoverDiv">
									<div id="divMain">
										<div id="creGroupReqDivInner"></div>																			
									</div>
									<div class="divText"><%=dbLabelBean.getLabel("label.global.guestTravelRequest",strLangValue) %></div>	
								</div>								
							</a>
						</td>			
						<td class="imageTD">
							<%  if(SuserRole.equals("MATA")){ %>
							<a href="T_approveTravelRequisitions.jsp" title="<%=dbLabelBean.getLabel("label.global.approverequest",strLangValue) %>">
								<div id="appReqDivMain">
									<div id="appReqCountDiv">
										<div id="countText"><%=count %></div>
									</div>
									<div id="appReqDiv" class="hoverDiv">
										<div class="divText"><%=dbLabelBean.getLabel("label.global.approverequest",strLangValue) %></div>
										<div id="appReqDivInner"></div>
									</div>
								</div>				
							</a>
							<%} else { %>
							<a href="T_approveTravelRequisitions_All.jsp" title="<%=dbLabelBean.getLabel("label.global.approverequest",strLangValue) %>">
								<div id="appReqDivMain">
									<div id="appReqCountDiv">
										<div id="countText"><%=count %></div>
									</div>
									<div id="appReqDiv" class="hoverDiv">
										<div id="divMain">
											<div id="appReqDivInner"></div>																		
										</div>
										<div class="divText"><%=dbLabelBean.getLabel("label.global.approverequest",strLangValue) %></div>										
									</div>
								</div>				
							</a>
							<%} %>
						</td>
						<td class="imageTD">
							<a href="T_searchTravelRequisitions.jsp?searchType=quick&showCloseBtn=no" title="<%=dbLabelBean.getLabel("label.global.searchrequest",strLangValue) %>">
								<div id="searReqDiv" class="hoverDiv">
									<div id="divMain">
										<div id="searReqDivInner"></div>																			
									</div>
									<div class="divText"><%=dbLabelBean.getLabel("label.global.searchrequest",strLangValue) %></div>									
								</div>
							</a>
						</td>
					</tr>
				</table>
			</td>
			<td width="16%"></td>
			<td width="10%">
				<div id="statsDiv">
					<table width="100%" border="0" cellspacing="6" cellpadding="0">
						<tr><td colspan="2" height="2px"></td></tr>
						<tr>
							<td colspan="2">
								<table width="100%" border="0" cellspacing="2" cellpadding="0">
									<tr>
										<td class="statsTxt"><%=dbLabelBean.getLabel("label.global.selectfinyear",strLangValue)%></td>
										<td>
											<select class="styled-select" id="finYear">
												<option value="2015-2016">2015-2016</option>
												<option value="2014-2015">2014-2015</option>
												<option value="2013-2014">2013-2014</option>
												<option value="2012-2013">2012-2013</option>
												<option value="2011-2012">2011-2012</option>
												<option value="2010-2011">2010-2011</option>
												<option value="2009-2010">2009-2010</option>
												<option value="2008-2009">2008-2009</option>
												<option value="2007-2008">2007-2008</option>
												<option value="2006-2007">2006-2007</option>
												<option value="2005-2006">2005-2006</option>
											</select>
											<script type="text/javascript">
											    var currentYear = new Date().getFullYear();											    
											    select = document.getElementById("finYear");
												select.innerHTML = "";
												var options='';
												for(var i = currentYear; i >= 2005; i--){
												     var option = document.createElement('option');
													 var finYearHtml = i + "-" + (i+1);
													 option.value = option.text = finYearHtml;
													 select.add(option);      
												}				
													
											</script>
										</td>
									</tr>
								</table>
								
							</td>
						</tr>
						<tr><td colspan="2" class="statsTxt1">(<%=dbLabelBean.getLabel("label.global.whereyouarepartofworkflow",strLangValue) %>)</td></tr>
						<tr><td colspan="2" height="8px"></td></tr>
						<tr>
							<td width="80%" class="statsTxt2"><%=dbLabelBean.getLabel("label.global.approvedrequests",strLangValue) %></td>
							<td width="10%" class="statsTxt2">:&nbsp;<a href="#" class="searchResultByCount"><span id="approvedCount" class="countSpan"></span></a><img src="images/loading16.gif?buildstamp=2_0_0" width="14" height="14" border="0" align="top" class="preLoadImg" /><input type="hidden" id="appCountFlag" class="countFlag" /></td>
						</tr>
						<tr><td colspan="2"></td></tr>
						<tr>
							<td width="80%" class="statsTxt2"><%=dbLabelBean.getLabel("label.global.returnedrequests",strLangValue) %></td>
							<td width="10%" class="statsTxt2">:&nbsp;<a href="#" class="searchResultByCount"><span id="returnedCount" class="countSpan"></span></a><img src="images/loading16.gif?buildstamp=2_0_0" width="14" height="14" border="0" align="top" class="preLoadImg" /><input type="hidden" id="retCountFlag" class="countFlag" /></td>
						</tr>
						<tr><td colspan="2"></td></tr>
						<tr>
							<td width="80%" class="statsTxt2"><%=dbLabelBean.getLabel("label.global.rejectedrequests",strLangValue) %></td>
							<td width="10%" class="statsTxt2">:&nbsp;<a href="#" class="searchResultByCount"><span id="rejectedCount" class="countSpan"></span></a><img src="images/loading16.gif?buildstamp=2_0_0" width="14" height="14" border="0" align="top" class="preLoadImg" /><input type="hidden" id="rejCountFlag" class="countFlag" /></td>
						</tr>
						<tr><td colspan="2"></td></tr>
						<tr>
							<td width="80%" class="statsTxt2"><%=dbLabelBean.getLabel("label.global.pendingwithme",strLangValue) %><span class="asteriskTxt">*</span></td>
							<td width="10%" class="statsTxt2">:&nbsp;<a href="#" class="searchResultByCount"><span id="pendMeCount" class="countSpan"></span></a><img src="images/loading16.gif?buildstamp=2_0_0" width="14" height="14" border="0" align="top" class="preLoadImg" /><input type="hidden" id="pwmCountFlag" class="countFlag" /></td>
						</tr>
						<tr><td colspan="2"></td></tr>
						<tr>
							<td width="80%" class="statsTxt2"><%=dbLabelBean.getLabel("label.global.pendingwithothers",strLangValue) %><span class="asteriskTxt">*</span></td>
							<td width="10%" class="statsTxt2">:&nbsp;<a href="#" class="searchResultByCount"><span id="pendOthersCount" class="countSpan"></span></a><img src="images/loading16.gif?buildstamp=2_0_0" width="14" height="14" border="0" align="top" class="preLoadImg" /><input type="hidden" id="pwoCountFlag" class="countFlag" /></td>
						</tr>
						<tr><td colspan="2"></td></tr>
						<tr>
							<td width="80%" class="statsTxt2"><%=dbLabelBean.getLabel("label.global.requestsinpipeline",strLangValue) %><span class="asteriskTxt">*</span></td>
							<td width="10%" class="statsTxt2">:&nbsp;<a href="#" class="searchResultByCount"><span id="pipelineCount" class="countSpan"></span></a><img src="images/loading16.gif?buildstamp=2_0_0" width="14" height="14" border="0" align="top" class="preLoadImg" /><input type="hidden" id="ripCountFlag" class="countFlag" /></td>
						</tr>
					</table>
				</div>
				<div id="statsDivTxt"><span>*</span><%=dbLabelBean.getLabel("label.global.asondate",strLangValue)%></div>
			</td>
			<td width="10%"></td>
		</tr>
		<%}else{ %>
		<tr>
			<td width="10%"></td>
			<td width="50%">
				<table width="100%" border="0" cellspacing="15" cellpadding="0">
					<tr>
						<td class="imageTD">
						<%
							String createRequestUrl = "T_QuickTravel_Detail_MATA.jsp";
						%>
							<a href="<%=createRequestUrl %>" title="<%=dbLabelBean.getLabel("label.createrequest.createtravelrequest",strLangValue) %>">
								<div id="creReqDiv" class="hoverDiv">
									<div id="divMain">
										<div id="creReqDivInner"></div>																			
									</div>
									<div class="divText"><%=dbLabelBean.getLabel("label.global.createrequest",strLangValue) %></div>
								</div>
							</a>
						</td>
						<td class="imageTD">						
							<a href="T_Group_QuickTravel_Detail_MATA.jsp" title="<%=dbLabelBean.getLabel("label.createrequest.groupguestrequest",strLangValue) %>">
								<div id="creGroupReqDivInt" class="hoverDiv">
									<div id="divMain">
										<div id="creGroupReqDivInner"></div>																			
									</div>
									<div class="divText"><%=dbLabelBean.getLabel("label.createrequest.groupguestrequest",strLangValue) %></div>	
								</div>								
							</a>
						</td>
						<td class="imageTD">
							<%  if(SuserRole.equals("MATA")){ %>
							<a href="T_approveTravelRequisitions.jsp" title="<%=dbLabelBean.getLabel("label.global.approverequest",strLangValue) %>">
								<div id="appReqDivMain">
									<div id="appReqCountDiv">
										<div id="countText"><%=count %></div>
									</div>
									<div id="appReqDiv" class="hoverDiv">
										<div class="divText"><%=dbLabelBean.getLabel("label.global.approverequest",strLangValue) %></div>
										<div id="appReqDivInner"></div>
									</div>
								</div>				
							</a>
							<%} else { %>
							<a href="T_approveTravelRequisitions_All.jsp" title="<%=dbLabelBean.getLabel("label.global.approverequest",strLangValue) %>">
								<div id="appReqDivMain">
									<div id="appReqCountDiv">
										<div id="countText"><%=count %></div>
									</div>
									<div id="appReqDiv" class="hoverDiv">
										<div id="divMain">
											<div id="appReqDivInner"></div>																		
										</div>
										<div class="divText"><%=dbLabelBean.getLabel("label.global.approverequest",strLangValue) %></div>										
									</div>
								</div>				
							</a>
							<%} %>
						</td>
						<td class="imageTD">
							<a href="T_searchTravelRequisitions.jsp?searchType=quick&showCloseBtn=no" title="<%=dbLabelBean.getLabel("label.global.searchrequest",strLangValue) %>">
								<div id="searReqDiv" class="hoverDiv">
									<div id="divMain">
										<div id="searReqDivInner"></div>																			
									</div>
									<div class="divText"><%=dbLabelBean.getLabel("label.global.searchrequest",strLangValue) %></div>									
								</div>
							</a>
						</td>
					</tr>
				</table>
			</td>
			<td width="16%"></td>
			<td width="10%">
				<div id="statsDiv">
					<table width="100%" border="0" cellspacing="6" cellpadding="0">
						<tr><td colspan="2" height="2px"></td></tr>
						<tr>
							<td colspan="2">
								<table width="100%" border="0" cellspacing="2" cellpadding="0">
									<tr>
										<td class="statsTxt"><%=dbLabelBean.getLabel("label.global.selectfinyear",strLangValue)%></td>
										<td>
											<select class="styled-select" id="finYear">
												<option value="2015-2016">2015-2016</option>
												<option value="2014-2015">2014-2015</option>
												<option value="2013-2014">2013-2014</option>
												<option value="2012-2013">2012-2013</option>
												<option value="2011-2012">2011-2012</option>
												<option value="2010-2011">2010-2011</option>
												<option value="2009-2010">2009-2010</option>
												<option value="2008-2009">2008-2009</option>
												<option value="2007-2008">2007-2008</option>
												<option value="2006-2007">2006-2007</option>
												<option value="2005-2006">2005-2006</option>
											</select>
											<script type="text/javascript">
											    var currentYear = new Date().getFullYear();											    
											    select = document.getElementById("finYear");
												select.innerHTML = "";
												var options='';
												for(var i = currentYear; i >= 2005; i--){
												     var option = document.createElement('option');
													 var finYearHtml = i + "-" + (i+1);
													 option.value = option.text = finYearHtml;
													 select.add(option);      
												}				
													
											</script>
										</td>
									</tr>
								</table>
							</td>
						</tr>
						<tr><td colspan="2" class="statsTxt1">(<%=dbLabelBean.getLabel("label.global.whereyouarepartofworkflow",strLangValue) %>)</td></tr>
						<tr><td colspan="2" height="8px"></td></tr>
						<tr>
							<td width="80%" class="statsTxt2"><%=dbLabelBean.getLabel("label.global.approvedrequests",strLangValue) %></td>
							<td width="10%" class="statsTxt2">:&nbsp;<a href="#" class="searchResultByCount"><span id="approvedCount" class="countSpan"></span></a><img src="images/loading16.gif?buildstamp=2_0_0" width="14" height="14" border="0" align="top" class="preLoadImg" /><input type="hidden" id="appCountFlag" class="countFlag" /></td>
						</tr>
						<tr><td colspan="2"></td></tr>
						<tr>
							<td width="80%" class="statsTxt2"><%=dbLabelBean.getLabel("label.global.returnedrequests",strLangValue) %></td>
							<td width="10%" class="statsTxt2">:&nbsp;<a href="#" class="searchResultByCount"><span id="returnedCount" class="countSpan"></span></a><img src="images/loading16.gif?buildstamp=2_0_0" width="14" height="14" border="0" align="top" class="preLoadImg" /><input type="hidden" id="retCountFlag" class="countFlag" /></td>
						</tr>
						<tr><td colspan="2"></td></tr>
						<tr>
							<td width="80%" class="statsTxt2"><%=dbLabelBean.getLabel("label.global.rejectedrequests",strLangValue) %></td>
							<td width="10%" class="statsTxt2">:&nbsp;<a href="#" class="searchResultByCount"><span id="rejectedCount" class="countSpan"></span></a><img src="images/loading16.gif?buildstamp=2_0_0" width="14" height="14" border="0" align="top" class="preLoadImg" /><input type="hidden" id="rejCountFlag" class="countFlag" /></td>
						</tr>
						<tr><td colspan="2"></td></tr>
						<tr>
							<td width="80%" class="statsTxt2"><%=dbLabelBean.getLabel("label.global.pendingwithme",strLangValue) %><span class="asteriskTxt">*</span></td>
							<td width="10%" class="statsTxt2">:&nbsp;<a href="#" class="searchResultByCount"><span id="pendMeCount" class="countSpan"></span></a><img src="images/loading16.gif?buildstamp=2_0_0" width="14" height="14" border="0" align="top" class="preLoadImg" /><input type="hidden" id="pwmCountFlag" class="countFlag" /></td>
						</tr>
						<tr><td colspan="2"></td></tr>
						<tr>
							<td width="80%" class="statsTxt2"><%=dbLabelBean.getLabel("label.global.pendingwithothers",strLangValue) %><span class="asteriskTxt">*</span></td>
							<td width="10%" class="statsTxt2">:&nbsp;<a href="#" class="searchResultByCount"><span id="pendOthersCount" class="countSpan"></span></a><img src="images/loading16.gif?buildstamp=2_0_0" width="14" height="14" border="0" align="top" class="preLoadImg" /><input type="hidden" id="pwoCountFlag" class="countFlag" /></td>
						</tr>
						<tr><td colspan="2"></td></tr>
						<tr>
							<td width="80%" class="statsTxt2"><%=dbLabelBean.getLabel("label.global.requestsinpipeline",strLangValue) %><span class="asteriskTxt">*</span></td>
							<td width="10%" class="statsTxt2">:&nbsp;<a href="#" class="searchResultByCount"><span id="pipelineCount" class="countSpan"></span></a><img src="images/loading16.gif?buildstamp=2_0_0" width="14" height="14" border="0" align="top" class="preLoadImg" /><input type="hidden" id="ripCountFlag" class="countFlag" /></td>
						</tr>
					</table>
				</div>
				<div id="statsDivTxt"><span>*</span><%=dbLabelBean.getLabel("label.global.asondate",strLangValue)%></div>
			</td>
			<td width="10%"></td>
		</tr>
		<%} %>
	</table>
	<table width="100%" align="center" border="0" cellpadding="0" cellspacing="0"  style="position: absolute; left:0; bottom:5;">
		<tr>
			<td class="viewMsg"></td>
		</tr>
	</table>

	 </form>
	  
	  </body>
	</html>
	<script type="text/javascript">
	var statsBox = '<div class="overlay"><iframe id="overlay_iframe" border="0" frameborder="0" scrolling="no" noresize="noresize" src="readMe.jsp"></iframe></div>';
	
	$(document).ready(function() {
		window.parent.top11.document.location.href = "top11.jsp";
	
		clearStatsData();
		$("span#approvedCount").parents('tr').find("img.preLoadImg").show();
		$("span#returnedCount").parents('tr').find("img.preLoadImg").show();
		$("span#rejectedCount").parents('tr').find("img.preLoadImg").show();
		$("span#pendMeCount").parents('tr').find("img.preLoadImg").show();
		$("span#pendOthersCount").parents('tr').find("img.preLoadImg").show();
		$("span#pipelineCount").parents('tr').find("img.preLoadImg").show();
		loadStatsData();
		 
		var bg;
		var img;
		var url;
				
		var countVal = '<%=count%>';
		if(countVal != 0) {
			approveRequestAlert(900000, 2000);
		}
		
		
        var docHeight = $(document).height();
    	docHeight = docHeight * 0.15;	
        $("table#blockTbl").css("margin-top",docHeight);
        
		
		$('div.hoverDiv').mouseover(function() {
			bg = $(this).css('background-image');
			var cleanup = /\"|\'|\)/g;
			img = bg.split('/').pop().replace(cleanup, '');
			url = "url(images/"+img+")";
	        $(this).css("background-image", "url(images/gray_box.png)"); 	
	        $(this).find("div.divText").css("color", "#000000");
		}).mouseout(function(){
			$(this).css("background-image", url); 
			$(this).find("div.divText").css("color", "#ffffff");
	    });
	
	
		$('div#countText').mouseover(function() {
			$(this).css("color", "#000000");
			$(this).css("text-decoration", "underline");
		}).mouseout(function(){
			$(this).css("color", "#ffffff");
			$(this).css("text-decoration", "none");
	    });
		
		
		function approveRequestAlert(time, interval){
		    var timer = window.setInterval(function(){
		        $("div#appReqCountDiv").css("background-image", "url(images/yellow_circle.png)"); 
		        $("div#appReqCountDiv").find("div#countText").css("color", "#000000");
		        window.setTimeout(function(){
		        	$("div#appReqCountDiv").css("background-image", "url(images/red_circle.png)"); 
		        	$("div#appReqCountDiv").find("div#countText").css("color", "#ffffff");
		        }, 100);
		    }, interval);
		    window.setTimeout(function(){clearInterval(timer);}, time);
		}
		
		var userStartedNewRas = '<%=hs.getAttribute("strUserStartedNewStars")%>';
       if(userStartedNewRas == null || userStartedNewRas == 'N'){
            setTimeout(function() {			
            	$(top.frames['middle'].document.body).append(statsBox);
			}, 1000);
        }
		
		$("a.searchResultByCount").click(function() {
			var suserRole = '<%=SuserRole%>';
			var countVal = $(this).parents('tr').find("span.countSpan").html();
			
			if(countVal == "0") {
				return;
			} 
				var requestAppFlag = $(this).parents('tr').find("input.countFlag").val();
				var finYear = $("select#finYear option:selected").val();
				var finYearArr = finYear.split("-");
				var year1  = finYearArr[0];
				var year2 = finYearArr[1];	
				var datFrom = "01/04/"+year1;
				var datTo = "31/03/"+year2;
				
				if(requestAppFlag != "") {
					
					if(requestAppFlag == "PWM") {
						if(suserRole == "MATA") {
							$(this).attr('href', "T_approveTravelRequisitions.jsp");
						} else {
							$(this).attr('href', "T_approveTravelRequisitions_All.jsp");
						}						
					} else {
						if(requestAppFlag == "PWO" || requestAppFlag == "RIP") {
							datFrom = "";
							datTo = "";
						}
						
						var url = "T_searchTravelRequisitions.jsp?requestAppFlag="+requestAppFlag+"&fromdate="+datFrom+"&todate="+datTo+"&SelectUnit=0&travelType=A&flag=2&searchType=advance&showCloseBtn=no";
						$(this).attr('href', url);
						//var searchPageUrl = "T_TravelReqSearchResultsByStatusAndCount.jsp?requestAppFlag="+requestAppFlag+"&fromdate="+datFrom+"&todate="+datTo+"&SelectUnit=0&travelType=A&travelType=A";
						//window.open(searchPageUrl,'SEARCH','scrollbars=no,resizable=yes,top=110,left=0,width=1017,height=580');
					}
					
				} else {
					alert('<%=dbLabelBean.getLabel("label.global.pleasewait",strLangValue)%>');
				}
			
			
		});
		
	});
	
	var wto;
	$('select#finYear').change(function() {
		clearStatsData();
		$("span#approvedCount").parents('tr').find("img.preLoadImg").show();
		$("span#returnedCount").parents('tr').find("img.preLoadImg").show();
		$("span#rejectedCount").parents('tr').find("img.preLoadImg").show();
		$("span#pendMeCount").parents('tr').find("img.preLoadImg").show();
		$("span#pendOthersCount").parents('tr').find("img.preLoadImg").show();
		$("span#pipelineCount").parents('tr').find("img.preLoadImg").show();
	    clearTimeout(wto);
	    wto = setTimeout(function() {			
		  loadStatsData();
	    }, 1000);
	});
	
	function onCreateRequestClick(isIndividualRequest){
		var requestURL = 'CreateRequestTypeSelectionDialog.jsp?isIndividualRequest='+isIndividualRequest;
		var travelrequestTypeDialog = '<div class="overlay"><iframe id="travelRequest_iframe" border="0" frameborder="0" scrolling="no" '
		+'noresize="noresize" src=\"'+requestURL+'\"></iframe></div>';
		 setTimeout(function() {			
         	$(top.frames['middle'].document.body).append(travelrequestTypeDialog);
			}, 1000);
	}
	
	function forwardRequestCreationPage(forwardURL){
		 window.location.href = forwardURL;
	}
	
	
	function loadStatsData() {
		var finYear = $("select#finYear option:selected").val();
		
		var Params='<%="language1="+strsesLanguage+"&suserId="+Suser_id%>';
	    var urlParams=Params+"&finYear="+finYear+"&status="+status;
	    
		$.ajax({
           type: "get",
           url: "StatisticsCount",
           data: urlParams,
           dataType : 'json',
           async: false,
           cache: false,
           success: function(result) {
        	   if(result!=null) { 
        		   
        		  $.each(result, function(key,value) {
	   					if((typeof(value['reqAppFlag']) == 'undefined' || value['reqAppFlag'] == null) && (typeof(value['reqCount']) == 'undefined' || value['reqCount'] == null)) {}
						else { 
	       			 		
							var reqAppFlag = value['reqAppFlag'];
							var reqCount = value['reqCount'];
							
							if(reqAppFlag == "APP") {
								$("span#approvedCount").parents('tr').find("img.preLoadImg").hide();
								$("span#approvedCount").text(reqCount);
								$("input#appCountFlag").val(reqAppFlag);
								
								if(reqCount == "0") {
									$("span#approvedCount").parents('a.searchResultByCount').css({"cursor" : "not-allowed" , "text-decoration" : "none"});
								} else {
									$("span#approvedCount").parents('a.searchResultByCount').css({"cursor" : "pointer" , "text-decoration" : "underline"});
								}
							}
							
							if(reqAppFlag == "RET") {
								$("span#returnedCount").parents('tr').find("img.preLoadImg").hide();
								$("span#returnedCount").text(reqCount);
								$("input#retCountFlag").val(reqAppFlag);
								
								if(reqCount == "0") {
									$("span#returnedCount").parents('a.searchResultByCount').css({"cursor" : "not-allowed" , "text-decoration" : "none"});
								}else {
									$("span#returnedCount").parents('a.searchResultByCount').css({"cursor" : "pointer" , "text-decoration" : "underline"});
								}
							}
							
							if(reqAppFlag == "REJ") {
								$("span#rejectedCount").parents('tr').find("img.preLoadImg").hide();
								$("span#rejectedCount").text(reqCount);
								$("input#rejCountFlag").val(reqAppFlag);
								
								if(reqCount == "0") {
									$("span#rejectedCount").parents('a.searchResultByCount').css({"cursor" : "not-allowed" , "text-decoration" : "none"});
								}else {
									$("span#rejectedCount").parents('a.searchResultByCount').css({"cursor" : "pointer" , "text-decoration" : "underline"});
								}
							}
							
							if(reqAppFlag == "PWM") {
								$("span#pendMeCount").parents('tr').find("img.preLoadImg").hide();
								$("span#pendMeCount").text(reqCount);
								$("input#pwmCountFlag").val(reqAppFlag);
								
								if(reqCount == "0") {
									$("span#pendMeCount").parents('a.searchResultByCount').css({"cursor" : "not-allowed" , "text-decoration" : "none"});
								}else {
									$("span#pendMeCount").parents('a.searchResultByCount').css({"cursor" : "pointer" , "text-decoration" : "underline"});
								}
							}
							
							if(reqAppFlag == "PWO") {
								$("span#pendOthersCount").parents('tr').find("img.preLoadImg").hide();
								$("span#pendOthersCount").text(reqCount);
								$("input#pwoCountFlag").val(reqAppFlag);
								
								if(reqCount == "0") {
									$("span#pendOthersCount").parents('a.searchResultByCount').css({"cursor" : "not-allowed" , "text-decoration" : "none"});
								}else {
									$("span#pendOthersCount").parents('a.searchResultByCount').css({"cursor" : "pointer" , "text-decoration" : "underline"});
								}
							}
							
							if(reqAppFlag == "RIP") {
								$("span#pipelineCount").parents('tr').find("img.preLoadImg").hide();
								$("span#pipelineCount").text(reqCount);
								$("input#ripCountFlag").val(reqAppFlag);
								
								if(reqCount == "0") {
									$("span#pipelineCount").parents('a.searchResultByCount').css({"cursor" : "not-allowed" , "text-decoration" : "none"});
								}else {
									$("span#pipelineCount").parents('a.searchResultByCount').css({"cursor" : "pointer" , "text-decoration" : "underline"});
								}
							}							
	       			 	}		
	   				});
				}	
           }
	   });
	}
	
	function clearStatsData() {
		
		   $("span#approvedCount").text('');
		   $("span#returnedCount").text('');
		   $("span#rejectedCount").text('');
		   $("span#pendMeCount").text('');
		   $("span#pendOthersCount").text('');
		   $("span#pipelineCount").text('');
		   
		   $("input#appCountFlag").val("");
		   $("input#retCountFlag").val("");
		   $("input#rejCountFlag").val("");
		   $("input#pwmCountFlag").val("");
		   $("input#pwoCountFlag").val("");
		   $("input#ripCountFlag").val("");
	}
		
	</script>