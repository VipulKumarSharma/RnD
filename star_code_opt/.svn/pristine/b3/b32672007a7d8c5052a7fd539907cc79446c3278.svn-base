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
<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>

<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
<%

Connection con	=		null;			    // Object for connection
Statement stmt	=		null;			    // Object for Statement
ResultSet rs	=		null;				// Object for ResultSet
String	strSqlStr	=	""; 				// For sql Statements

%>

<script language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></script>
<script type="text/javascript" src="ScriptLibrary/jQueryMaster.js?buildstamp=2_0_0"></script>

<style type="text/css">
a.searchResultStats{
cursor: pointer;
text-decoration: none;
}
</style>

</head>


<body>
	<div id="mainBlockDivInner">
		<div id="closeDiv"><img src="images/closepopup.gif?buildstamp=2_0_0" width="12" height="12" align="middle" /></div>
		<div id="statsBlockDiv">
			<table width="342px" border="0" cellspacing="0" cellpadding="0" align="center">
				<tr><td class="statisticsTxt"><%=dbLabelBean.getLabel("label.global.statisticsforcurrentfinancialyear",strsesLanguage)%></td></tr>
				<tr><td height="10px"></td></tr>
				<tr>
					<td>
						<table width="342px" border="0" cellspacing="0" cellpadding="0" align="center">
							<tr>
								<td width="20%" style="padding:0 7px 0 7px;">
									<a href="#" class="searchResultStats">
										<div id="approvedBlock" class="hoverDiv">
											<div class="statusTxt"><%=dbLabelBean.getLabel("label.reports.approved",strsesLanguage)%></div>
											<div class="countTxt"><span id="approvedCount" class="countSpan"></span><img src="images/preloader.gif?buildstamp=2_0_0" align="middle" class="preLoadImg" /><input type="hidden" id="appCountFlag" class="countFlag" /></div>
										</div>
									</a>
								</td>
								<td width="20%" style="padding:0 7px 0 7px;">
									<a href="#" class="searchResultStats">
										<div id="returnedBlock" class="hoverDiv">
											<div class="statusTxt"><%=dbLabelBean.getLabel("label.requestdetails.returned",strsesLanguage)%></div>
											<div class="countTxt"><span id="returnedCount" class="countSpan"></span><img src="images/preloader.gif?buildstamp=2_0_0" align="middle" class="preLoadImg" /><input type="hidden" id="retCountFlag" class="countFlag" /></div>
										</div>
									</a>
								</td>
								<td width="20%" style="padding:0 7px 0 7px;">
									<a href="#" class="searchResultStats">
										<div id="rejectedBlock"  class="hoverDiv">
											<div class="statusTxt"><%=dbLabelBean.getLabel("label.requestdetails.rejected",strsesLanguage)%></div>
											<div class="countTxt"><span id="rejectedCount" class="countSpan"></span><img src="images/preloader.gif?buildstamp=2_0_0" align="middle" class="preLoadImg" /><input type="hidden" id="rejCountFlag" class="countFlag" /></div>
										</div>
									</a>
								</td>
							</tr>
							
							<tr>
								<td colspan="3" height="10px"></td>
							</tr>
							
							<tr>
								<td width="20%" style="padding:0 7px 0 7px;">
									<a href="#" class="searchResultStats">
										<div id="pendingMeBlock" class="hoverDiv">
											<div class="statusTxt"><%=dbLabelBean.getLabel("label.global.pendingwithme",strsesLanguage)%><span>*</span></div>
											<div class="countTxt"><span id="pendMeCount" class="countSpan"></span><img src="images/preloader.gif?buildstamp=2_0_0" align="middle" class="preLoadImg" /><input type="hidden" id="pwmCountFlag" class="countFlag" /></div>
										</div>
									</a>
								</td>
								<td width="20%" style="padding:0 7px 0 7px;">
									<a href="#" class="searchResultStats">
										<div id="pendingOtherBlock"  class="hoverDiv">
											<div class="statusTxt"><%=dbLabelBean.getLabel("label.global.pendingwithothers",strsesLanguage)%><span>*</span></div>
											<div class="countTxt"><span id="pendOthersCount" class="countSpan"></span><img src="images/preloader.gif?buildstamp=2_0_0" align="middle" class="preLoadImg" /><input type="hidden" id="pwoCountFlag" class="countFlag" /></div>
										</div>
									</a>
								</td>
								<td width="20%" style="padding:0 7px 0 7px;">
									<a href="#" class="searchResultStats">
										<div id="inPipelineBlock"  class="hoverDiv">
											<div class="statusTxt"><%=dbLabelBean.getLabel("label.global.requestsinpipeline",strsesLanguage)%><span>*</span></div>
											<div class="countTxt"><span id="pipelineCount" class="countSpan"></span><img src="images/preloader.gif?buildstamp=2_0_0" align="middle" class="preLoadImg" /><input type="hidden" id="ripCountFlag" class="countFlag" /></div>
										</div>
									</a>
								</td>
							</tr>
							
							<tr>
								<td colspan="3" height="2px"></td>
							</tr>
							
							<tr>
								<td colspan="3" class="noteTxt">
									<span>*</span><%=dbLabelBean.getLabel("label.global.asondate",strsesLanguage)%>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</div>
	</div>	
</body>
</html>
<script type="text/javascript">

	$(document).ready(function() {
		var bg;
		
		// load stats data on statistics link click event
		loadStatsDataOnPageLoad();
		
		
		$("div#closeDiv").live('click', function() {
			$('div.statscontainer_div',top.frames['middle'].document).css("display", "none");
			$('div.statscontainer_div',top.frames['middle'].frames['footer_11'].document).css("display", "none");
		});
		
		$('body',top.frames['middle'].document).live('click', function() {
			$('div.statscontainer_div',top.frames['middle'].document).css("display", "none");
		});
		
		$('body',top.frames['bottom11'].document).live('click', function() {
			$('div.statscontainer_div',top.frames['middle'].document).css("display", "none");
		});		
		
		
		$('div.hoverDiv').mouseover(function() {
			bg = $(this).css('background-color');
			$(this).css("background-color", "#cccccc"); 	
			$(this).find("div.statusTxt").css("color", "#000000");
	        $(this).find("div.countTxt").css("color", "#000000");
		}).mouseout(function(){
			$(this).css("background-color", bg); 	
			$(this).find("div.statusTxt").css("color", "#ffffff");
	        $(this).find("div.countTxt").css("color", "#ffffff");
	    });
		
		$("a.searchResultStats").click(function() {
			var countVal = $(this).parents('td').find("span.countSpan").html();
			
			if(countVal == "0") {
				return;
			} 
			
			var requestAppFlag = $(this).parents('td').find("input.countFlag").val();
			var currentYear = new Date().getFullYear();
			var finYear = currentYear + "-" + (currentYear+1);
			var finYearArr = finYear.split("-");
			var year1  = finYearArr[0];
			var year2 = finYearArr[1];	
			var datFrom = "01/04/"+year1;
			var datTo = "31/03/"+year2;
			
					
			if(requestAppFlag != "") {
				
				if(requestAppFlag == "PWM") {
					$(this).attr('href', "T_approveTravelRequisitions_All.jsp");
					$(this).attr('target', "middle");
				} else {
					if(requestAppFlag == "PWO" || requestAppFlag == "RIP") {
						datFrom = "";
						datTo = "";
					}
					
					var url = "T_searchTravelRequisitions.jsp?requestAppFlag="+requestAppFlag+"&fromdate="+datFrom+"&todate="+datTo+"&SelectUnit=0&travelType=A&flag=2&searchType=advance&showCloseBtn=no";
					$(this).attr('href', url);
					$(this).attr('target', "middle");
					//var searchPageUrl = "T_TravelReqSearchResultsByStatusAndCount.jsp?requestAppFlag="+requestAppFlag+"&fromdate="+datFrom+"&todate="+datTo+"&SelectUnit=0&travelType=A&travelType=A";
					//window.open(searchPageUrl,'SEARCH','scrollbars=no,resizable=yes,top=110,left=0,width=1017,height=580');
				}
				
			} else {
				alert('<%=dbLabelBean.getLabel("label.global.pleasewait",strsesLanguage)%>');
			}			
		});
	
	
	});
	
	function loadStatsDataOnPageLoad() {
		clearStatsData();
		$("span#approvedCount").parents("td").find("img.preLoadImg").show();
		$("span#returnedCount").parents("td").find("img.preLoadImg").show();
		$("span#rejectedCount").parents("td").find("img.preLoadImg").show();
		$("span#pendMeCount").parents("td").find("img.preLoadImg").show();
		$("span#pendOthersCount").parents("td").find("img.preLoadImg").show();
		$("span#pipelineCount").parents("td").find("img.preLoadImg").show();
		setTimeout(function() {
		  loadStatsData();
		 }, 500);
	}
	
	function loadStatsData() {
		var currentYear = new Date().getFullYear();
		var finYear = currentYear + "-" + (currentYear+1);
		
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
								$("span#approvedCount").parents("td").find("img.preLoadImg").hide();
								$("span#approvedCount").text(reqCount);
								$("input#appCountFlag").val(reqAppFlag);
								
								if(reqCount == "0") {
									$("span#approvedCount").parents('a.searchResultStats').css({"cursor" : "not-allowed"});
								} else {
									$("span#approvedCount").parents('a.searchResultStats').css({"cursor" : "pointer"});
								}
							}
							
							if(reqAppFlag == "RET") {
								$("span#returnedCount").parents("td").find("img.preLoadImg").hide();
								$("span#returnedCount").text(reqCount);
								$("input#retCountFlag").val(reqAppFlag);
								
								if(reqCount == "0") {
									$("span#returnedCount").parents('a.searchResultStats').css({"cursor" : "not-allowed"});
								} else {
									$("span#returnedCount").parents('a.searchResultStats').css({"cursor" : "pointer"});
								}
							}
							
							if(reqAppFlag == "REJ") {
								$("span#rejectedCount").parents("td").find("img.preLoadImg").hide();
								$("span#rejectedCount").text(reqCount);
								$("input#rejCountFlag").val(reqAppFlag);
								
								if(reqCount == "0") {
									$("span#rejectedCount").parents('a.searchResultStats').css({"cursor" : "not-allowed"});
								} else {
									$("span#rejectedCount").parents('a.searchResultStats').css({"cursor" : "pointer"});
								}
							}
							
							if(reqAppFlag == "PWM") {
								$("span#pendMeCount").parents("td").find("img.preLoadImg").hide();
								$("span#pendMeCount").text(reqCount);
								$("input#pwmCountFlag").val(reqAppFlag);
								
								if(reqCount == "0") {
									$("span#pendMeCount").parents('a.searchResultStats').css({"cursor" : "not-allowed"});
								} else {
									$("span#pendMeCount").parents('a.searchResultStats').css({"cursor" : "pointer"});
								}
							}
							
							if(reqAppFlag == "PWO") {
								$("span#pendOthersCount").parents("td").find("img.preLoadImg").hide();
								$("span#pendOthersCount").text(reqCount);
								$("input#pwoCountFlag").val(reqAppFlag);
								
								if(reqCount == "0") {
									$("span#pendOthersCount").parents('a.searchResultStats').css({"cursor" : "not-allowed"});
								} else {
									$("span#pendOthersCount").parents('a.searchResultStats').css({"cursor" : "pointer"});
								}
							}
							
							if(reqAppFlag == "RIP") {
								$("span#pipelineCount").parents("td").find("img.preLoadImg").hide();
								$("span#pipelineCount").text(reqCount);
								$("input#ripCountFlag").val(reqAppFlag);
								
								if(reqCount == "0") {
									$("span#pipelineCount").parents('a.searchResultStats').css({"cursor" : "not-allowed"});
								} else {
									$("span#pipelineCount").parents('a.searchResultStats').css({"cursor" : "pointer"});
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