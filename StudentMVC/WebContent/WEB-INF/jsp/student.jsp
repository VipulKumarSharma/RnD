<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
    <title>Spring MVC Form Handling</title>
</head>
<body bgcolor="#ececec">

	<input type="button" value="Static HTML Page" onclick="javascript:window.location.href='/StudentMVC/staticPage';" />
	
	<h2>Student Information</h2>
	<form:form method="POST" action="/StudentMVC/addStudent">
	   <table>
		    <tr>
		        <td><form:label path="name">Name</form:label></td>
		        <td><input type="text" name="name" required="required"/></td>
		    </tr>
		    <tr>
		        <td><form:label path="age">Age</form:label></td>
		        <td><input type="number" name="age" required="required"/></td>
		    </tr>
		    <tr>
		        <td><form:label path="id">Id</form:label></td>
		        <td><input type="number" name="id" required="required"/></td>
		    </tr>
		    <tr>
		        <td colspan="2">
		            <input type="submit" value="Submit"/>
		        </td>
		    </tr>
		</table>  
	</form:form>
</body>
</html>