<%
/***************************************************
 *The information contained here in is confidential and 
 *proprietary to MIND and forms the part of the MIND 
 *Author				:MANOJ CHAND
 *Date of Creation 		:23 JAN 2012
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This is second jsp file  for attach the document in Circulars

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
java.sql.Statement,
java.net.URLEncoder" pageEncoding="UTF-8"
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

strTravelType					=  request.getParameter("travel_type"); 
strWhichPage					=  request.getParameter("whichPage"); 

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
String strMsg				= dbLabelBean.getLabel("message.user.filecouldnotbeuploaded",strsesLanguage); 
String strGroupName				= "";
String strcirculatedBy			= "";
int intSuccess=10;
try
{
	com.oreilly.servlet.MultipartRequest multi   = new com.oreilly.servlet.MultipartRequest(request, ".",50 * 1024 * 1024,"UTF-8"); 
	Enumeration params		 = multi.getParameterNames(); 
	
	while(params.hasMoreElements())
	{ 
		String name = (String)params.nextElement();
		
		if(name.equalsIgnoreCase("doc_ref"))
		{
			docType=multi.getParameter(name);
			//System.out.println("docType--->"+docType);
		}
		if(name.equalsIgnoreCase("file"))
		{
    		path = multi.getParameter(name);
		}
		if(name.equalsIgnoreCase("circulatedby"))
		{
    		strcirculatedBy = multi.getParameter(name);
		}
    }
	//System.out.println(docType);
	//System.out.println(strcirculatedBy);
     
    if(strWhichPage == null)
        strWhichPage = "#";

    if(strTargetFlag !=null && strTargetFlag.equals("yes"))
    {
		strTargetFlag = "yes";
    } 

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
			if(ext.equals("pdf") || ext.equals("doc") || ext.equals("docx") || ext.equals("xls") || ext.equals("xlsx") || ext.equals("ppt") || ext.equals("pptx") || ext.equals("txt") || ext.equals("gif") || ext.equals("jpeg") || ext.equals("jpg") || ext.equals("html")){
				
			}else{
				response.sendRedirect("M_CircularAdd.jsp?message="+URLEncoder.encode(strMsg,"UTF-8"));
				return;	
			}
			File f = multi.getFile(name); 
			FileInputStream in = new FileInputStream(f);
			buffer1 = new byte[(int) f.length()];			
			m = in.read(buffer1);
			size=m/1048576;	
			in.close();
			//File inputFile = multi.getFile(name);
			//System.out.println("buffer1---->"+buffer1);
			//System.out.println("M-->"+m);
		//	sSqlStr= "select count(*)// as count from TRAVEL_ATTACHMENTS where TRAVEL_ATTACHMENTS.TRAVEL_ID ='"+sSanctionId+"' and TRAVEL_ATTACHMENTS.TRAVEL_TYPE='"+strTravelType+"' and TRAVEL_ATTACHMENTS.FILES_NAME='"+inputFile.toString().replace(".\\","").trim()+"'";
		//	stmt=con.createStatement();
		//	rs=stmt.executeQuery(sSqlStr);
		////	int intcount=0;
		//	if(rs.next()){
		//		intcount=rs.getInt("count");
		//		System.out.println("intcount------->"+intcount);
		//	}
			
		//	if (intcount==1)
		//	{
		       //response.sendRedirect("requisitionAttachment.jsp?purchaseReqID="+sSanctionId+"&err=1&travel_type="+strTravelType+"&whichPage="+strWhichPage+"&targetFrame="+strTargetFlag+"");
		//       response.sendRedirect("M_CircularAdd.jsp?message="+strMsg);
		//	}
			//else
			//{
				if(m<=5242880.0)//before 5000000
				{
					try 
					{
						String strF=filename.replace(' ','_');
						try
						{
							cstmt=con.prepareCall("{?=call PROC_ADD_CIRCULARS(?,?,?,?,?,?,?)}");
							cstmt.registerOutParameter(1,java.sql.Types.INTEGER);					
							cstmt.setString(2,docType.trim());
							cstmt.setString(3,strcirculatedBy.trim());
							cstmt.setBytes(4, buffer1);
							cstmt.setString(5,filename);
							cstmt.setString(6,ext);
							cstmt.setFloat(7,m/1024);
							cstmt.setString(8,Suser_id);
							cstmt.execute();
							intSuccess=cstmt.getInt(1);
							cstmt.close();
							//con.close();
							if(intSuccess==0){
								boolean success=f.delete();
								if (!success){
									  System.out.println("Deletion failed.");
									 }
									else{
									//System.out.println("File deleted successfully");
									}
							
			     			response.sendRedirect("M_CircularAdd.jsp?message="+URLEncoder.encode(strMsg1,"UTF-8"));
							}
						}
						catch(Exception e)
     					{
							System.out.println("Error in m_circularpost.jsp 1====="+e);
						}
					}
	     			catch (Exception e)
					{
						System.out.println("Error in m_circularpost.jsp 2===== "+e);
					}
					
				}
				else if(m>5242800)
				{
					response.sendRedirect("M_CircularAdd.jsp?message="+URLEncoder.encode(strMsg2,"UTF-8"));	
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
    System.out.println("Error in requisitionUploadData.jsp  3====="+e);
}
finally{
	try {
		if(con!=null)
			con.close();
	} catch (SQLException e) {
		e.printStackTrace();
	}
}
//response.sendRedirect("requisitionAttachment.jsp?purchaseReqID="+sSanctionId+"&err=4&travel_type="+strTravelType+"");

%>

