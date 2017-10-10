<%
/****************************************************************************************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:SACHIN GUPTA
 *Date of Creation 		:04 September 2006
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STARs
 *Operating environment	:Tomcat, sql server 2000 
 *Description 			:This is first jsp file  for attach the document in TRAVEL_ATTACHMENT in the STAR Database
 *Modification 			: 1.code changed by shiv on 06-Jul-07 by shiv
 *Reason of Modification: 
 *Date of Modification	: 
 *Revision History		:
 *Editor				:Editplus
 
 *Modified by 			: Manoj Chand
 *Date of Modification	: 07 sept 2011
 *Modification			: delete file from server folder
 ***********************************************************************************************************************************/
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
<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<base target="middle">
</head>
<%
// Variables declared and initialized
Connection con					=		null;			    // Object for connection
Statement stmt					=		null;			   // Object for Statement
ResultSet rs					=		null;			  // Object for ResultSet
CallableStatement cstmt			=		null;			// Object for Callable Statement

//Create Connection
Class.forName(Sdbdriver);
con=DriverManager.getConnection(Sdburl,Sdbuser,Sdbpwd);
String	sSqlStr=""; // For sql Statements
String TRvType	 ="";
String strTravel	 =	 "";
%>
<%

    String strWhichPage    =  "";
    String strTargetFrame  =  "";
	String strTargetFlag   =  "";
	//code changed by shiv on 06-Jul-07 by shiv
    strWhichPage    =  request.getParameter("whichPage")==null ? "":request.getParameter("whichPage"); 
	//System.out.println("strWhichPage=========i  delete attatchment==========="+strWhichPage);


	
	if(strWhichPage == null)
       strWhichPage = "#";
    
    strTargetFlag    =  request.getParameter("targetFrame"); 
	if(strTargetFlag !=null && strTargetFlag.equals("yes"))
    {
       strTargetFrame="middle";  
    }
	else
	   strTargetFrame="";   



	    String strAttachmentId	=""; // Object to store Sanction ID
		strAttachmentId				=	request.getParameter("attId");
		 String sSanctionId=""; // Object to store Sanction ID
		 sSanctionId=request.getParameter("sanctionId");
		 strTravel	=	request.getParameter("TravelType");
		 if(strTravel.equals("I"))
		 {
TRvType	 =	 "International";
		 }
else
{
TRvType	 =	 "Domestic";
}

cstmt=con.prepareCall("{?=call PROC_SANCTIONDELETEATTACHMENTS(?)}");
cstmt.registerOutParameter(1,java.sql.Types.INTEGER);
cstmt.setString(2, strAttachmentId);
cstmt.execute();
cstmt.close();


//File outputFile = new File(Sfile_path+"\\sanctionattachments\\"+request.getParameter("path").trim());
//commented by manoj chand no 07 jan 2013
//String strF= request.getParameter("path").trim().replace(' ','_');

/*File outputFile = new File(Sfile_path1+"\\"+TRvType+"_TRAVEL_ATTACHMENTS\\"+sSanctionId+"\\"+strF.trim());

out.println(outputFile);
if (outputFile.exists())
{
	outputFile.delete();
}*/
//System.out.println("strWhichPage===================="+strWhichPage);

response.sendRedirect("requisitionAttachment.jsp?purchaseReqID="+sSanctionId+"&err=99&travel_type="+strTravel+"&whichPage="+strWhichPage+"&targetFrame=yes");
	
%>

