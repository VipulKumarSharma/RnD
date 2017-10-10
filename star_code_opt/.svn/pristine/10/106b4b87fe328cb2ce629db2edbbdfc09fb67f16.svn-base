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
	<form action="SendMailServlet" method="GET" id="createReqForm" name="createReqForm">
	<div style="text-align: center;">
	<p>
		<table>
			<tr>
				<td>Travel Id</td>
				<td><input type="text" id="purchaseId" name="purchaseId"/></td>
			</tr>
			<tr>
				<td>Travel Requisition Id</td>
				<td><input type="text" id="purchaseRequisitionId" name="purchaseRequisitionId"/></td>
			</tr>
			<tr>
				<td>Travel Type</td>
				<td>
					<select id="ReqTyp" name="ReqTyp">
					    <option value="-1">Select Travel Type</option>
						<option value="Domestic Travel">Domestic</option>
						<option value="International Travel">International</option>
					</select>
				</td>
			</tr>			
			<tr>
			 <td colspan="2">
			 	<input type="button" value="Create Mail Request" onclick="javascript:validateAndSubmit();"/>
			 </td>
			</tr>
		</table>
		<input type="hidden" name="suserid" value="<%=Suser_id %>"/>
   		<input type="hidden" name="sesLanguage" value="<%=strsesLanguage%>"/>
   		<input type="hidden" name="currentYear" value="<%=strCurrentYear%>"/>
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
			if(document.getElementById('purchaseId').value == ''){
				isOkToSubmit = false;
			}
			if(document.getElementById('purchaseRequisitionId').value == ''){
				isOkToSubmit = false;
			}
			if(document.getElementById('ReqTyp').value == '-1'){
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