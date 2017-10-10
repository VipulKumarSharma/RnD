<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:SACHIN GUPTA
 *Date of Creation 		:04 September 2006
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This is second jsp file  for attach the document in TRAVEL_ATTACHMENT in the STAR Database
 *Modification 			: 
 *Reason of Modification: 
 *Date of Modification  : 
 *Revision History		:
 *Editor				:Editplus
 *******************************************************/
%>
<%@ include  file="importStatement.jsp" %>
<html>
<head>
<%-- include remove cache  --%>
<%@ include  file="cacheInc.inc" %>
<%-- include header  --%>
<%@ include  file="headerIncl.inc" %>
<%-- include page with all application session variables --%>
<%-- @ include  file="application.jsp" --%>
<%-- include page styles  --%>
<%-- @ include  file="systemStyle.jsp" --%>

<!--Create the DbConnectionBean object for createConnection-->
<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />

<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>

<% // import statements %>

<%@ page import="java.util.*,
java.text.*,
java.io.*,
java.sql.*,
javax.mail.*,
com.oreilly.servlet.*,
javax.mail.internet.*,
javax.activation.* ,
javax.naming.*,
java.util.*,
java.sql.*,
java.sql.Connection,
java.sql.DriverManager,
java.sql.PreparedStatement,
java.sql.ResultSet,
java.sql.Statement"
%>
<%
String docType			=  null;
byte[] buffer1			=  null;
String ext				=  null;
String S_error			=  "";
String path				=  "";
String strLocation		=  "";
String strMessage       =  ""; 
try
{
	MultipartRequest multi = new MultipartRequest(request, ".",50 * 1024 * 1024); 
	Enumeration params = multi.getParameterNames(); 
	while (params.hasMoreElements())
	{ 
		String name = (String)params.nextElement();
		if(name.equalsIgnoreCase("doc_ref"))
		{
			docType=multi.getParameter(name);
		}
		if(name.equalsIgnoreCase("file"))
		{
    		path = multi.getParameter(name);
		}
		if(name.equalsIgnoreCase("location"))
		{
    		strLocation = multi.getParameter(name);
		}
     }
     
	if(docType != null && docType.equals("0"))
	{
		docType = strLocation;
	}
	//System.out.println("docType is=========="+docType);
	//System.out.println("strLocation is=========="+strLocation);



     float size;
     Enumeration files = multi.getFileNames();
	 int m = 0;
	 while (files.hasMoreElements()) 
	 { 
     	String name = (String)files.nextElement();
		String filename = multi.getFilesystemName(name);
				
		if(!(filename== null || filename.equals("")))
		{
			//path = multi.getContentType(name);
			if(filename.charAt(filename.length() - 4) == '.'){
				ext = filename.substring(filename.length() - 3);
			}else if(filename.charAt(filename.length() - 5) == '.'){
				ext = filename.substring(filename.length() - 4);
			}else if(filename.charAt(filename.length() - 3) == '.'){
				ext = filename.substring(filename.length() - 2);
			}else{
				ext = "xxx";
			}
			File f = multi.getFile(name); 
			//System.out.println("-------1---------------"+f);
			FileInputStream in = new FileInputStream(f);
			buffer1 = new byte[(int) f.length()];			
			m = in.read(buffer1);
			size=m/1048576;
			File inputFile = multi.getFile(name);
			File outputFile = new File(docType+filename);
			//System.out.println("outputFile is======="+outputFile);
			/*if (outputFile.exists())
			{
		       response.sendRedirect("requisitionAttachmentTest.jsp");
			}
			else
			{*/
				if(m<=5000000)
				{
					try 
					{
						//boolean success = (new File(Sfile_path1+"\\Domestic_TRAVEL_ATTACHMENTS\\")).mkdir();
						//if (!success) 
						//{
							// Directory creation failed
						//}
						String strF=filename.replace(' ','_');
						File bakFile1 = new File(strF);
						outputFile.renameTo(bakFile1);
     					//bakFile1=new File (Sfile_path1+"\\Domestic_TRAVEL_ATTACHMENTS\\"+bakFile1);
						bakFile1=new File (docType+bakFile1);
		                //System.out.println("inputFile is========"+inputFile);  
		                //System.out.println("inputFile is========"+bakFile1);  

						FileInputStream fis = new FileInputStream(inputFile);
						FileOutputStream fos = new FileOutputStream(bakFile1);
						int cc;
						while ((cc = fis.read()) != -1) 
						{
							fos.write(cc);
						}
						fis.close();
						fos.close();
						
						strMessage = "save";
					}
	     			catch (Exception e) 
					{
						strMessage = "notSave";
						System.out.println("Error in requisitionAttachmentTestPost.jsp 2===== "+e);
					}
					response.sendRedirect("requisitionAttachmentTest.jsp?message="+strMessage);
					
				}
				else if(m>5242800)
				{
					//response.sendRedirect("sanctionAttachment.jsp?sanctionId="+sSanctionId+"&err=3");
				}
			//}
		}
		else
		{
		}
	}
}
catch (Exception e)
{
	strMessage = "notSave";
	S_error=e.toString();
    System.out.println("Error in requisitionAttachmentTestPost.jsp  3====="+e);
}
	
%>

 
<SCRIPT LANGUAGE="JavaScript">
function lo()
{
  window.location.href="requisitionAttachment.jsp";
  document.frm.submit();
}
</SCRIPT>
<body onLoad="lo();" >
<form name=frm action="requisitionAttachment.jsp">
  <input type="hidden" name=message value="<%=strMessage%>"/>
</form>
