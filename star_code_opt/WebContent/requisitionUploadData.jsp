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
 
 *Modified By			: Manoj Chand
 *Date of modification	: 07 sept 2011
 *Modification 			: preventing attachment of same file multiple times.
 
 *Modified By			: Manoj Chand
 *Date of modification	: 21 Oct 2011
 *Modification 			: Save file in table travel_attachments for demostars application
 
 *Modified By			: Manoj Chand
 *Date of modification	: 09 Nov 2011
 *Modification 			: implement validation for file size exceeding and duplicate file uploading.
 						  and stop creating of folder for attachment in application server. 
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
<jsp:useBean id="securityUtilityBean" scope="page" class="src.connection.SecurityUtilityMethods" />

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
CallableStatement cstmt			=		null;			// Object for Callable Statement
Statement stmt					=		null;
ResultSet rs					=		null;
//Create Connection
con								= dbConBean.getConnection();
request.setCharacterEncoding("UTF-8");
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
try
{
	MultipartRequest multi   = new MultipartRequest(request, ".",50 * 1024 * 1024,"UTf-8"); 
	Enumeration params		 = multi.getParameterNames(); 
	
	while(params.hasMoreElements())
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
		if(name.equalsIgnoreCase("travel_type"))
		{
    		strTravelType = multi.getParameter(name);
		}
		if(name.equalsIgnoreCase("whichPage"))
		{
    		strWhichPage = multi.getParameter(name);
		}
		if(name.equalsIgnoreCase("targetFrame"))
		{
    		strTargetFlag = multi.getParameter(name);
		}
    }
	
	//Added By Gurmeet Singh
		String strUserAccessCheckFlag = "";
		strUserAccessCheckFlag = securityUtilityBean.validateAuthCommentsTravelReq(sSanctionId, strTravelType, Suser_id);

		if(strUserAccessCheckFlag.equals("420")){	
			dbConBean.close();
			securityUtilityBean.registerUnauthAccessLog(Suser_id, request.getRemoteAddr(), "requisitionUploadData.jsp", "Unauthorized Access");
			response.sendRedirect("UnauthorizedAccess.jsp");	
			return;
		}
     
	if(strTravelType.equals("I"))
	{
		strPth	=	"International";
	}
	else
	{
		strPth	=	"Domestic";
	}

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

		//System.out.println("name---->"+name);
		//System.out.println("filename---->"+filename);
		//System.out.println("Sfile_path1---->"+Sfile_path1);

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
			ext = ext.toLowerCase();
			if(ext.equals("pdf") || ext.equals("doc") || ext.equals("docx") || ext.equals("xls") || ext.equals("xlsx") || ext.equals("ppt") || ext.equals("pptx") || ext.equals("txt") || ext.equals("gif") || ext.equals("jpeg") || ext.equals("jpg") || ext.equals("html") || ext.equals("zip")){
				
			}else{
				response.sendRedirect("requisitionAttachment.jsp?purchaseReqID="+sSanctionId+"&err=5&travel_type="+strTravelType+"&whichPage="+strWhichPage+"&targetFrame="+strTargetFlag+"");
				return;	
			}
			
			
			File f = multi.getFile(name); 
			
			FileInputStream in = new FileInputStream(f);
			buffer1 = new byte[(int) f.length()];			
			m = in.read(buffer1);
			size=m/1048576;
			//System.out.println("m------------->"+m);
			//System.out.println("buffer1------------->"+buffer1);			
			
			File inputFile = multi.getFile(name);
			//System.out.println("inputFile----->"+inputFile);			
			//File outputFile = new File(Sfile_path1+"\\"+strPth+"_TRAVEL_ATTACHMENTS\\"+sSanctionId+"\\"+multi.getFile(name).toString().replaceAll(" ","_"));
			//System.out.println("Sfile_path1====="+Sfile_path1);
			//System.out.println("strPth========="+strPth);
			//System.out.println("out put file name is========="+outputFile);
			/*if (outputFile.exists())
			{
		       response.sendRedirect("requisitionAttachment.jsp?purchaseReqID="+sSanctionId+"&err=1&travel_type="+strTravelType+"&whichPage="+strWhichPage+"&targetFrame="+strTargetFlag+"");
			}*/
			
			
			
			//added by manoj on 02 nov 2011 to check for file existence.
			sSqlStr= "select count(*) as count from TRAVEL_ATTACHMENTS where TRAVEL_ATTACHMENTS.TRAVEL_ID ='"+sSanctionId+"' and TRAVEL_ATTACHMENTS.TRAVEL_TYPE='"+strTravelType+"' and TRAVEL_ATTACHMENTS.FILES_NAME='"+inputFile.toString().replace(".\\","").trim()+"'";
			//System.out.println("sSqlStr---->"+sSqlStr);
			stmt=con.createStatement();
			rs=stmt.executeQuery(sSqlStr);
			int intcount=0;
			if(rs.next()){
				intcount=rs.getInt("count");
				//System.out.println("intcount------->"+intcount);
			}
			
			if (intcount==1)
			{
		       response.sendRedirect("requisitionAttachment.jsp?purchaseReqID="+sSanctionId+"&err=1&travel_type="+strTravelType+"&whichPage="+strWhichPage+"&targetFrame="+strTargetFlag+"");
			}
			else
			{
				if(m<=5242880)//before 5000000
				{
					try 
					{
						//commented by manoj chand on 09 nov 2011 to stop dir created on server to save file.
						
				//		boolean success = (new File(Sfile_path1+"\\"+strPth+"_TRAVEL_ATTACHMENTS\\"+sSanctionId)).mkdir();
					//	if (!success) 
						//{
							// Directory creation failed
						//}
						String strF=filename.replace(' ','_');
						//File bakFile1 = new File(strF);
						//outputFile.renameTo(bakFile1);
     					//bakFile1=new File (Sfile_path1+"\\"+strPth+"_TRAVEL_ATTACHMENTS\\"+sSanctionId+"\\"+bakFile1);
		

						//FileInputStream fis = new FileInputStream(inputFile);
						//FileOutputStream fos = new FileOutputStream(bakFile1);
						//int cc;
					//	while ((cc = fis.read()) != -1) 
						//{
							//fos.write(cc);
						//}
						//fis.close();
						//fos.close();
						
						try
						{
							cstmt=con.prepareCall("{?=call PROC_TRAVEL_ATTACHMENTS(?,?,?,?,?,?,?,?,?,?)}");
							cstmt.registerOutParameter(1,java.sql.Types.VARCHAR);					
							cstmt.setString(2,sSanctionId);
							cstmt.setString(3,filename);
							cstmt.setString(4,ext);
							cstmt.setFloat(5,m/1024);
							//cstmt.setString(6,"TRAVEL_ATTACHMENTS/TRAVEL_ATTACHMENTS/"+sSanctionId+"/"+strF);
							if(strTravelType != null && strTravelType.equals("I"))
							{
							    //cstmt.setString(6,"TRAVEL_ATTACHMENTS/International_TRAVEL_ATTACHMENTS/"+sSanctionId+"/"+strF);
							    cstmt.setString(6,"");
							}
							if(strTravelType != null && strTravelType.equals("D"))
							{
								 //cstmt.setString(6,"TRAVEL_ATTACHMENTS/Domestic_TRAVEL_ATTACHMENTS/"+sSanctionId+"/"+strF);
								cstmt.setString(6,"");
							}
							cstmt.setString(7,"1");
							cstmt.setString(8,docType.trim());
							cstmt.setString(9,Suser_id);
							cstmt.setString(10,strTravelType);
							//added by manoj chand on 21 oct 2011 to save file in db.
							cstmt.setBytes(11, buffer1);
							//end here
							cstmt.execute();// executing procedure
							cstmt.close(); // close procedure
							con.close();
						}
						catch(Exception e)
     					{
							System.out.println("Error in requisitionUploadData.jsp 1====="+e);
						}
					}
	     			catch (Exception e)
					{
						System.out.println("Error in requisitionUploadData.jsp 2===== "+e);
					}
					response.sendRedirect("requisitionAttachment.jsp?purchaseReqID="+sSanctionId+"&err=4&travel_type="+strTravelType+"&whichPage="+strWhichPage+"&targetFrame="+strTargetFlag+"");
					
				}
				else if(m>5242800)
				{
					//added by manoj on 09 nov 2011 to show correct message when file size is greater than 5 mb
					response.sendRedirect("requisitionAttachment.jsp?purchaseReqID="+sSanctionId+"&err=3&travel_type="+strTravelType+"&whichPage="+strWhichPage+"&targetFrame="+strTargetFlag+"");
					
					//response.sendRedirect("sanctionAttachment.jsp?sanctionId="+sSanctionId+"&err=3");
				}
			}
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
	
//response.sendRedirect("requisitionAttachment.jsp?purchaseReqID="+sSanctionId+"&err=4&travel_type="+strTravelType+"");

%>

 
<SCRIPT LANGUAGE="JavaScript">
function lo()
{
  window.location.href="requisitionAttachment.jsp?purchaseReqID=<%=sSanctionId%>&err=4&travel_type=<%=strTravelType%>&whichPage=<%=strWhichPage%>&targetFrame=<%=strTargetFlag%>";
  document.frm.submit();
}
</SCRIPT>
<body onLoad="lo();" >
<form name=frm action="requisitionAttachment.jsp">
  <input type=hidden name=purchaseReqID value=<%=sSanctionId%>>
  <input type="hidden" name=travel_type value="<%=strTravelType%>"/>
  <input type="hidden" name=err value="4"/>
</form>
