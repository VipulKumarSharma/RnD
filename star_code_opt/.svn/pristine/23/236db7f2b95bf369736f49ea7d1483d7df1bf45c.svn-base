<%@ page contentType="application/csv" language="java" import="java.util.*,java.text.*,java.io.*,java.sql.*,com.oreilly.servlet.*,javax.naming.*,java.util.*,java.sql.*,java.sql.Connection,java.sql.DriverManager,java.sql.PreparedStatement,java.sql.ResultSet,java.sql.Statement "%>


<%
/***************************************************
*Copyright (C) 2001 MIND
*All rights reserved.
*The information contained here in is confidential and
*proprietary to MIND and forms the part of the MIND

*CREATED BY	:Rajesh Francis
*Date				:20/02/2003
*Project 			:CIReS
*Operating environment	:Websphere, SQL Server 2000

*DESCRIPTION :
*This file displays the list of customers
**********************************************************/
%>

<html>

<head>

</head>



<body  leftmargin="0" topmargin="10" marginwidth="0" marginheight="10">
<HTML>
<head>
</head>
<body bgcolor="#CCCCCC" text="#000000" leftmargin="0" marginwidth="0" topmargin="0" marginheight="0" background="images/bg_2.jpg?buildstamp=2_0_0">
<%
Connection con = null;  
PreparedStatement check = null;
ResultSet rs = null;
String attached_filename="";
String file_ext="";

	

byte[] buffer1 = null;
String ext= null;
String fileName = null;
String str=request.getParameter("va");
//out.print(str);
buffer1=str.getBytes();
try
{
response.setContentType("application/x-msdownload");//msword
attached_filename="main.xls";
response.setHeader("Content-Disposition", "attachment;filename=" + attached_filename + ";size=" + buffer1.length + "");
out.clearBuffer();
PrintWriter pw =new PrintWriter(out);
pw.print(str);	
pw.flush();
pw.close();
}
catch(Exception e)
{

}
///out.print("kkkk---------"+buffer1);
/**
try
{


	attached_filename="main.xls";

//fileName=attached_filename+"."+file_ext;
			response.setContentType("application/x-msdownload");//msword
			response.setHeader("Content-Disposition", "attachment;filename=" + attached_filename + ";size=" + buffer1.length + "");
			ServletOutputStream outStream = response.getOutputStream();
			out.write(buffer1);
			//out.write(bytes);
			outStream.close();
			out.println("<p class=heada>Document Downloaded Successfuly.</p>");


} catch (Exception e) {
out.println("<p class=heada>Sorry! There was an Error.</p>"+e);
out.println("Exception is : " + e);
}
**/



%>
</body>
</HTML>
