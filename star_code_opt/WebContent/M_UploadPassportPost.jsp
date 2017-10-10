<%
/***************************************************
 *The information contained here in is confidential and 
 *proprietary to MIND and forms the part of the MIND 
 *Author				:MANOJ CHAND
 *Date of Creation 		:20 June 2012
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This is second jsp file upload scanned copy of passport

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
Statement stmt					=		null;
ResultSet rs					=		null;
//Create Connection
con								= dbConBean.getConnection();
String	sSqlStr					=  ""; // For sql Statements
String strTravelType			=  "";
String strTravelTypeFlag		=  ""; 
String strWhichPage				=  "";
String strTargetFlag			=  ""; 
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
String	strPth					= "";
String strMsg1					= dbLabelBean.getLabel("label.requestdetails.fileuploadedsuccessfully",strsesLanguage);
String strMsg2					= dbLabelBean.getLabel("label.requestdetails.filesizeshouldnotmorethan5mb",strsesLanguage);
String strMsg					=  dbLabelBean.getLabel("message.user.filecouldnotbeuploaded",strsesLanguage); 
String strGroupName				= "";
String strcirculatedBy			= "";
int intSuccess=10;
String strflag="no";
//String strUserId                           =  request.getParameter("userid")==null?Suser_id:request.getParameter("userid");
String strUserId                           =  request.getParameter("userid");
//System.out.println("strUserId---m_uploadpassportPost--->"+strUserId);
try
{
	com.oreilly.servlet.MultipartRequest multi   = new com.oreilly.servlet.MultipartRequest(request, ".",50 * 1024 * 1024,"UTF-8"); 
	Enumeration params		 = multi.getParameterNames(); 
	while(params.hasMoreElements())
	{ 
		String name = (String)params.nextElement();
		if(name.equalsIgnoreCase("file"))
		{
    		path = multi.getParameter(name);
		}
    }
 
    if(strWhichPage == null)
        strWhichPage = "#";

    float size;
    Enumeration files = multi.getFileNames();
	float m = 0.0f;
	while (files.hasMoreElements()) 
	{ 
     	String name = (String)files.nextElement();
		String filename = multi.getFilesystemName(name);
		
		if(!(filename== null || filename.equals("")))
		{
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
			ext = ext.toLowerCase();
			if(ext.equals("pdf") || ext.equals("doc") || ext.equals("docx") || ext.equals("xls") || ext.equals("xlsx") || ext.equals("ppt") || ext.equals("pptx") || ext.equals("txt") || ext.equals("gif") || ext.equals("jpeg") || ext.equals("jpg") || ext.equals("html") || ext.equals("zip")){
				
			}else{
				response.sendRedirect("M_UploadPassport.jsp?message="+URLEncoder.encode(strMsg,"UTF-8") +"&flag="+strflag+"&userid="+strUserId);
				return;	
			}
			File f = multi.getFile(name);
			FileInputStream in = new FileInputStream(f);
			buffer1 = new byte[(int) f.length()];			
			m = in.read(buffer1);
			size=m/1048576;	
			in.close();
			
			//System.out.println("filename---->"+filename);
			//System.out.println("buffer1---->"+buffer1);
			//System.out.println("strUserId--->"+strUserId);
				if(m<=5242880.0)//before 5000000
				{
					try 
					{
						String strF=filename.replace(' ','_');
						try
						{

							cstmt=con.prepareCall("{?=call PROC_UPLOAD_PASSPORT(?,?,?)}");
							cstmt.registerOutParameter(1,java.sql.Types.INTEGER);
							cstmt.setString(2,strUserId);
							cstmt.setString(3,filename);
							cstmt.setBytes(4,buffer1);
							cstmt.execute();
							intSuccess=cstmt.getInt(1);
							cstmt.close();
							if(intSuccess==0){
								boolean success=f.delete();
								if (!success){
									  System.out.println("Deletion failed.");
									 }
									else{
									System.out.println("File deleted Successfully.");
									}
							strflag="yes";
			     			response.sendRedirect("M_UploadPassport.jsp?message="+URLEncoder.encode(strMsg1,"UTF-8") +"&flag="+strflag+"&userid="+strUserId);
							}
						}
						catch(Exception e)
     					{
							System.out.println("Error in m_uploadpassportpost.jsp 1====="+e);
						}
					}
	     			catch (Exception e)
					{
						System.out.println("Error in m_uploadpassportpost.jsp 2===== "+e);
					}
					
				}
				else if(m>5242800)
				{
					response.sendRedirect("M_UploadPassport.jsp?message="+URLEncoder.encode(strMsg2,"UTF-8")+"&userid="+strUserId);	
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
    System.out.println("Error in m_uploadpassportpost.jsp  3====="+e);
}
finally{
	try {
		if(con!=null)
			con.close();
	} catch (SQLException e) {
		e.printStackTrace();
	}
}

%>

