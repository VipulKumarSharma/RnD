<!doctype html>
<!-------------------------------------------------------
*Copyright (C) 2000 MIND 
*All rights reserved.
*The information contained here in is confidential and 
*proprietary to MIND and forms the part of the MIND 
*CREATED BY		:	Sandeep Malik
*Date			:	27-MAY-2015
*Description	:	Page for showing getting started guide
*Project		:	STARS(REQUISITION APPROVAL SYSTEM )
-------------------------------------------------------->
<html>
<head>
<%@ include file="application.jsp"%>
<link href="style/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="ScriptLibrary/jQueryMaster.js?buildstamp=2_0_0"></script>
<%
String isIndividualRequest = request.getParameter("isIndividualRequest");
%>
		<script>
			function go(travelType){
				var isIndividualRequest = '<%=isIndividualRequest%>';
				var forwardURL = "T_QuickTravel_Detail_GmbH.jsp?travel_type="+travelType+"&srcFlag=homepage";
				if(isIndividualRequest != 'true'){
					forwardURL =  "T_Group_QuickTravel_Detail_GmbH.jsp?travel_type="+travelType+"&srcFlag=homepage";
				}
				
				$('#travelReq-overlay').css('display','none');
				 $(window.parent.document).find(".overlay").css('display','none');
				 parent.forwardRequestCreationPage(forwardURL);
				self.close();
			}
			
			function closeReadme(){
				$('#travelReq-overlay').css('display','none');
				 $(window.parent.document).find(".overlay").css('display','none');
				// parent.forwardRequestCreationPage(forwardURL);
				self.close();
			}
		</script>
</head>
<body>
	<div id="travelReq-overlay">
		<div class="travelReq-window">
			<div class="travelReq-heading">
			<%if(isIndividualRequest != null && isIndividualRequest.equals("true")){ %>
				<label style="float: left;margin-left: -22px;">Select Travel Request Type</label>
			<%}else{ %>
				<label style="float: left;margin-left: -22px;">Select Guest Travel Request Type</label>
			<%} %>
				<img src="images/delete.png?buildstamp=2_0_0" style="float: right;cursor: pointer;margin-right: -25px;margin-top: -8px" width="24px" height="20px" border="0" title="Click to close" onclick="javascript:closeReadme();">
			</div>
			<div class="travelReq-container">
				<div class="travelReq-content">
					<table>
						<tr>
							<td style="width: 30%">
								<input name="traveltype" type="radio" onclick="javscript:go('I');"></input>
								<label>Intercont</label>
							</td>
							<td style="width: 40%">
							
								<input name="traveltype" type="radio" onclick="javscript:go('D');"></input>
								<label>Domestic/Europe</label>
							</td>
						</tr>
					</table>
					
				</div>
			</div>
			<!-- <div class="travelReq-footer">
				<button class="formButton" onclick="go()">
					<label style="vertical-align: middle;">Go</label>
				</button>
			</div> -->
		</div>
	</div>
</body>
</html>