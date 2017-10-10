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
// Variables declared and initialized
Connection con					=		null;			    // Object for connection
Statement stmt					=		null;			   // Object for Statement
ResultSet rs						=		null;			  // Object for ResultSet
CallableStatement cstmt		=		null;			// Object for Callable Statement

//Create Connection
Class.forName(Sdbdriver);
con=DriverManager.getConnection(Sdburl,Sdbuser,Sdbpwd);
String	sSqlStr=""; // For sql Statements
%>


<%
String docType		= null;
byte[] buffer1			= null;
InputStream inn		= null;
String title				= null;	
String issue_id			=		null;
String state_id			=		"1";
String S_redirect_file="";
String S_stage			=	"";
String idgen				=	"";
String ext				= null;
String S_error			=	"";
String path				=	"";
String concern_id		=	null;
String sSanctionId=""; //Request parameter

try
{
	MultipartRequest multi = new MultipartRequest(request, ".",50 * 1024 * 1024); 
	Enumeration params = multi.getParameterNames(); 
	while (params.hasMoreElements())
		{ 
				String name = (String)params.nextElement();

				if(name.equalsIgnoreCase("sanctionId"))
				{
					sSanctionId=multi.getParameter(name);
				}


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
						if(!(filename== null || filename.equals("")))
							{
						
				File f = multi.getFile(name); 
				FileInputStream in = new FileInputStream(f);
				buffer1 = new byte[(int) f.length()];			
				m = in.read(buffer1);
				size=m/1048576;

					File inputFile = multi.getFile(name);
					File outputFile = new File(Sfile_path1+"\\PURCHASEATTACHMENTS\\"+sSanctionId+"\\"+multi.getFile(name));
					if (outputFile.exists())
					{
							//Delete 
					}
					else
					{

								if(m<=5000000)
								{
									
									try 
									{
										
									
										FileInputStream fis = new FileInputStream(inputFile);
										FileOutputStream fos = new FileOutputStream(inputFile);
										int cc;

										while ((cc = fis.read()) != -1) 
										{
										fos.write(cc);
										}
										fis.close();
										fos.close();
										
										try
										{
											cstmt=con.prepareCall("{?=call proc_PURCHASE_attachments(?,?,?,?,?,?,?,?)}");
											cstmt.registerOutParameter(1,java.sql.Types.VARCHAR);
											cstmt.setString(2,sSanctionId);
											cstmt.setString(3,filename);
											cstmt.setString(4,ext);
											cstmt.setInt(5,m/1024);
											cstmt.setString(6,"PURCHASEATTACHMENTS/PURCHASEATTACHMENTS/"+sSanctionId+"/"+strF);
											cstmt.setString(7,"1");
											cstmt.setString(8,docType.trim());
											cstmt.setString(9,Suser_id);
											cstmt.execute();// executing procedure
											cstmt.close(); // close procedure
										}
										catch(Exception e)
										{
													out.print(e);
										}
									}
									catch (IOException e) 
									{
									out.println("FileStreamsTest: " + e);
									}

								response.sendRedirect("requisitionAttachment.jsp?purchaseReqID="+sSanctionId+"&err=4");
								//System.out.println("sSanctionId-"+sSanctionId);
								//4= File Uploaded Successfully
								}

								else if(m>5242800)
							
								{
									//out.print( "The File Size is too Big ");
									//response.sendRedirect("sanctionAttachment.jsp?sanctionId="+sSanctionId+"&err=3");
								//System.out.println("sSanctionId-"+sSanctionId);
								}

					}
				}
				else
				{

				}
			}

		}
catch (Exception e)
	{
	out.print("hee"+e);
	S_error=e.toString();

	}
	
	//response.sendRedirect("requisitionAttachment.jsp?purchaseReqID="+sSanctionId+"&err=4");
 
%>

<form  enctype="multipart/form-data" name="myform" method="post" action="requisitionUploadData.jsp"  onSubmit="return checkData();">