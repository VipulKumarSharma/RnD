	<%@ page pageEncoding="UTF-8" %>
	<%@ include  file="importStatement.jsp" %>
	<html>
	<head>
	<%-- include page with all application session variables --%>
	<%@ include  file="application.jsp" %>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<script type="text/javascript" language="JavaScript1.2" src="scripts/div.js?buildstamp=2_0_0"></script>
	<%
		String message =  null;
	if(request.getAttribute("message") != null){
		message = (String)request.getAttribute("message");
	}
	%>
	</head>
	<body><script type="text/javascript" language="JavaScript1.2" src="menu/menu_cnt.js?buildstamp=2_0_0"></script>
	<form action="processMail" method="GET" id="createReqForm" name="createReqForm">
	<div style="text-align: center;">
	<p>
		<table>
			<tr>
				<td>Travel Id</td>
				<td><input type="text" id="travelId" name="travelId"/></td>
			</tr>
			<tr>
				<td>Travel Type</td>
				<td>
					<select id="travelType" name="travelType">
					    <option value="-1">Select Travel Type</option>
						<option value="D">Domestic</option>
						<option value="I">International</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>Travel Status</td>
				<td>
					<select id="travelStatus" name="travelStatus">
					    <option value="-1">Select Travel Status</option>
						<option value="P">Pending</option>
						<option value="A">Approved</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>Travel MATA</td>
				<td>
					<select id="travelAgencyTypeId" name="travelAgencyTypeId">
					    <option value="-1">Select Travel MATA</option>
						<option value="1">MATA INDIA</option>
						<option value="2">MATA GMBH</option>
					</select>
				</td>
			</tr>
			<tr>
			 <td colspan="2">
			 	<input type="button" value="Create Mail Request" onclick="javascript:validateAndSubmit();"/>
			 </td>
			</tr>
		</table>
		</p>
		<%if(message != null){ %>
			<p><h2><%=message %></h2></p>
		<%} %>
	</div>
	</form>
	</body>
	<script type="text/javascript">
		function validateAndSubmit(){
			var form = document.getElementById('createReqForm');
			var isOkToSubmit = true;
			if(document.getElementById('travelId').value == ''){
				isOkToSubmit = false;
			}
			if(document.getElementById('travelType').value == '-1'){
				isOkToSubmit = false;
			}
			if(document.getElementById('travelStatus').value == '-1'){
				isOkToSubmit = false;
			}
			if(document.getElementById('travelAgencyTypeId').value == '-1'){
				isOkToSubmit = false;
			}
			if(isOkToSubmit){
				document.getElementById('createReqForm').submit();
			}else{
				alert('Please fill/select all fields.');
			}
		}
	</script>
	</html>