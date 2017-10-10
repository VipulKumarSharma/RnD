<%@ page contentType="application/xls" language="java" import="java.util.*,java.text.*,java.io.*,java.sql.*,com.oreilly.servlet.*,javax.naming.*,java.util.*,java.sql.*,java.sql.Connection,java.sql.DriverManager,java.sql.PreparedStatement,java.sql.ResultSet,java.sql.Statement "%>


<%--
**************************************************
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
*********************************************************
--%>


<HTML>
<head>
</head>
<body bgcolor="#CCCCCC" text="#000000" leftmargin="0" marginwidth="0" topmargin="0" marginheight="0" background="images/bg_2.jpg?buildstamp=2_0_0">
<%
request.setCharacterEncoding("UTF-8");
String attached_filename="";
String file_ext="";
byte[] buffer1 = null;
String ext= null;
String fileName = null;
String str=request.getParameter("va");
//System.out.println(str);
String yourString = str;
String newString = str.replaceAll("IMG","cccc");
String newString1 = newString.replaceAll("href","cxxxxx");

//out.print(newString);

///out.print(str);
buffer1=newString1.getBytes();
try
{
//response.setContentType("application/xls; charset=utf-8");//msword
//response.setCharacterEncoding("UTF-8");

response.setCharacterEncoding("UTF-8");
response.setContentType("application/vnd.ms-excel");//msword			
attached_filename="main.xls";
response.setHeader("Content-Disposition","inline; attachment;filename="+attached_filename +";size="+buffer1.length+ "");
out.clearBuffer();

PrintWriter pw =new PrintWriter(out);
pw.print(newString1);	
pw.flush();
pw.close();
}
catch(Exception e)
{

}
%>
</body>
</HTML>
