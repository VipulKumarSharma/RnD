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

<%@page import="java.net.URLEncoder"%><html>
<head>
<%-- include remove cache  --%>
<%@ include  file="cacheInc.inc" %>
<%-- include header  --%>
<%@ include  file="headerIncl.inc" %>
<%-- include page with all application session variables --%>
<%@ include  file="application.jsp" %>
<%-- include page styles  --%>
<%@ include  file="systemStyle.jsp" %>

<!--Create the DbConnectionBean object for createConnection-->
<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>

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
java.sql.Statement" pageEncoding="UTF-8"
%>
<%
request.setCharacterEncoding("UTF-8");
// Variables declared and initialized
Connection con					=		null;			    // Object for connection
CallableStatement cstmt			=		null;			// Object for Callable Statement

//Create Connection
con								= dbConBean.getConnection();

String	sSqlStr					=  ""; // For sql Statements
String strMessage				=  dbLabelBean.getLabel("message.user.filecouldnotbeuploaded",strsesLanguage); 

String docType					= null;
byte[] buffer1					= null;
InputStream inn					= null;
String title					= null;	
String issue_id					= null;
String state_id					= "1";
String S_redirect_file			= "";
String S_stage					= "";
String idgen					= "";
String ext						= null;
String S_error					= "";
String path						= "";
String concern_id				= null;
String sSanctionId				= ""; //Request parameter
try
{
	MultipartRequest multi   = new MultipartRequest(request, ".",50 * 1024 * 1024); 
	Enumeration params		 = multi.getParameterNames(); 
	while(params.hasMoreElements())
	{ 
		String name = (String)params.nextElement();
		/*if(name.equalsIgnoreCase("sanctionId"))
		{
			sSanctionId=multi.getParameter(name);
		}*/
		if(name.equalsIgnoreCase("doc_ref"))
		{
			docType=multi.getParameter(name);
		}
		if(name.equalsIgnoreCase("file"))
		{
    		path = multi.getParameter(name);
		}		
    }
     
	
    
   

    float size;
    Enumeration files = multi.getFileNames();
	int m = 0;
	while (files.hasMoreElements()) 
	{ 
     	String name = (String)files.nextElement();
		String filename = multi.getFilesystemName(name);

//System.out.println("name=="+name);
//System.out.println("filename========"+filename);

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
			//if block added by manoj chand on 04 dec 2013 to implement server side file extension check. 
			if(!ext.toLowerCase().equals("html")){
				response.sendRedirect("requisitionAttachment_Policy.jsp?message="+URLEncoder.encode(strMessage,"UTF-8"));
				return;
			}
			File f = multi.getFile(name); 
			FileInputStream in = new FileInputStream(f);
			buffer1 = new byte[(int) f.length()];			
			m = in.read(buffer1);
			size=m/1048576;

			File inputFile = multi.getFile(name);
			File outputFile = new File(SpolicyPath+"\\"+strSiteFullName+"\\"+multi.getFile(name));
			//System.out.println("SpolicyPath====="+SpolicyPath);
			
			//System.out.println("");
			//System.out.println("file name is========="+outputFile);
			/*if (outputFile.exists())
			{
		       response.sendRedirect("requisitionAttachment_Policy.jsp?err=1&message="+strMessage);
			}
			else
			{*/
				if(m<=5000000)
				{
					try 
					{
						boolean success = (new File(SpolicyPath+"\\"+strSiteFullName)).mkdir();
						if (!success) 
						{
							// Directory creation failed
							//System.out.println("Directory Creation Fail");
						}
						String strF=filename.replace(' ','_');
						File bakFile1 = new File(strF);
						outputFile.renameTo(bakFile1);
     					bakFile1=new File (SpolicyPath+"\\"+strSiteFullName+"\\"+bakFile1);
						//System.out.println("bakFile1==========="+bakFile1);

						FileInputStream fis = new FileInputStream(inputFile);
						FileOutputStream fos = new FileOutputStream(bakFile1);
						int cc;
						while ((cc = fis.read()) != -1) 
						{
							fos.write(cc);
							strMessage = dbLabelBean.getLabel("label.requestdetails.fileuploadedsuccessfully",strsesLanguage);
						}
						fis.close();
						fos.close();
						
						try
						{
							/*cstmt=con.prepareCall("{?=call PROC_TRAVEL_ATTACHMENTS(?,?,?,?,?,?,?,?,?)}");
							cstmt.registerOutParameter(1,java.sql.Types.VARCHAR);
							cstmt.setString(2,sSanctionId);
							cstmt.setString(3,filename);
							cstmt.setString(4,ext);
							cstmt.setInt(5,m/1024);
							//cstmt.setString(6,"TRAVEL_ATTACHMENTS/TRAVEL_ATTACHMENTS/"+sSanctionId+"/"+strF);
							if(strTravelType != null && strTravelType.equals("I"))
							{
							     cstmt.setString(6,"TRAVEL_ATTACHMENTS/International_TRAVEL_ATTACHMENTS/"+sSanctionId+"/"+strF);
							}
							if(strTravelType != null && strTravelType.equals("D"))
							{
								 cstmt.setString(6,"TRAVEL_ATTACHMENTS/Domestic_TRAVEL_ATTACHMENTS/"+sSanctionId+"/"+strF);
							}
							cstmt.setString(7,"1");
							cstmt.setString(8,docType.trim());
							cstmt.setString(9,Suser_id);
							cstmt.setString(10,strTravelType);
							cstmt.execute();// executing procedure
							cstmt.close(); // close procedure
							con.close();*/
						}
						catch(Exception e)
     					{
							System.out.println("Error in requisitionUploadData_Policy.jsp 1====="+e);
						}
					}
	     			catch (IOException e) 
					{
						System.out.println("Error in requisitionUploadData_Policy.jsp 2===== "+e);
					}
					response.sendRedirect("requisitionAttachment_Policy.jsp?err=4&message="+URLEncoder.encode(strMessage,"UTF-8"));
					
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
	}//End of While 
}
catch (Exception e)
{
	S_error=e.toString();
    System.out.println("Error in requisitionUploadData_Policy.jsp  3====="+e);
}
	
//response.sendRedirect("requisitionAttachment.jsp?purchaseReqID="+sSanctionId+"&err=4");

%>

 
<SCRIPT LANGUAGE="JavaScript">
function lo()
{
  window.location.href="requisitionAttachment.jsp?err=4";
  document.frm.submit();
}
</SCRIPT>
<body onLoad="lo();" >
<form name=frm action="requisitionAttachment_Policy.jsp">
  <input type="hidden" name=err value="4"/>
  <input type="hidden" name=message value="<%=strMessage%>"/>
</form>
