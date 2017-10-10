<%
/*************************************************** 
 *The information contained here in is confidential and 
 *proprietary to MIND and forms the part of the MIND 
 *Author				:Manoj Chand
 *Date of Creation 		:03 May 2013
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STARS
 *Operating environment :Tomcat 6.0, sql server 2008 
 *Description 			:for getting ad user sync data to page.
 *******************************************************/
%>
<%@ page pageEncoding="UTF-8" %>
<%@ include  file="importStatement.jsp" %>

<%@page import="java.net.URLEncoder"%>

<%@page import="src.connection.DbConnectionBean"%>
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

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!--Create the DbConnectionBean object for createConnection-->
<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
<jsp:useBean id="dbUtility" scope="page" class="src.connection.DbUtilityMethods" />
</head>

<%!
private String updateSID(String strSId, String dateFrom, String process)
{
	DbConnectionBean conn = new DbConnectionBean(); 
	Connection objCon = null;
	CallableStatement cStmt = null;
	int iSuccess1 = 0;
	String strSuccess = "";	
	try
	{
			objCon    = conn.getConnection();
			cStmt  = objCon.prepareCall("{?=call PROC_UPDATE_AD_SYNC_MST(?,?,?,?)}");			
			cStmt.registerOutParameter(1,java.sql.Types.INTEGER);
			cStmt.setString(2,strSId);   
			cStmt.setString(3,dateFrom); 
			cStmt.setString(4,process);			
			cStmt.registerOutParameter(5,java.sql.Types.INTEGER);												
			cStmt.executeUpdate();
			iSuccess1 = cStmt.getInt(5);
			objCon.close();				
			strSuccess = new Integer(iSuccess1).toString();
			//System.out.println("strSuccess-->"+strSuccess);
	}
	catch(Exception e)
	{	
		System.out.println("Error in M_ADUSERSYNC_POST.JSP transferPendingRequest()==="+e);
	}
	finally
	{
         try
         { 
         }
         catch(Exception ee)
           {
        	 System.out.println("Connection closed in M_ADUSERSYNC_POST.JSP====="+ee); 
        	}
	}		
	return strSuccess;
}	
%>


<%
	request.setCharacterEncoding("UTF-8");
	Connection objCon				    = null;			    // Object for connection
	Connection objCon2				    = null;	
    ResultSet objRs,rs		            = null;			    // Object for ResultSet
    CallableStatement objCstmt		    = null;			    // Object for Callable Statement
    String strSuccess            	= "";
    String strUpdateSidNo = "",strMessage="";
    //String dateFrom=(request.getParameter("dateFromFetch")==null?"":request.getParameter("dateFromFetch").trim());
	//String process=(request.getParameter("processId")==null?"":request.getParameter("processId").trim());
	String actionType=(request.getParameter("actionType")==null?"":request.getParameter("actionType").trim());
	String strdateFrom = request.getParameter("dateFrom")==null?"":request.getParameter("dateFrom");
	String processselected=(request.getParameter("process")==null?"":request.getParameter("process").trim());
	String recordCount = (request.getParameter("recordcount")==null?"":request.getParameter("recordcount").trim());
	try{	
		
		String strSIDNo="";
		
		//if(!dateFrom.equals("") && !process.equals("")){
		if(!recordCount.equals("0")){	
		String strSIds1[] = request.getParameterValues("reqCheck");
		String dateFetchFrom[] = request.getParameterValues("dateFromFetch");
		String processid[] = request.getParameterValues("processId");
		String[] strSIds = strSIds1[0].split(",");
		String[] strDates = dateFetchFrom[0].split(",");
		String[] strPid = processid[0].split(",");
		for(int i=0;i<strSIds.length;i++)
		{
			String strSId = strSIds[i];
			String dateFrom = strDates[i];
			String process = strPid[i];
			strSuccess = updateSID(strSId,  dateFrom,  process);
			if(strSuccess.equalsIgnoreCase("0"))
			{						
				//request.setAttribute("updateSIDStatus", "UpdateSuccessfully");
				strMessage = "UpdateSuccessfully";
			}
			else if(strSuccess.equalsIgnoreCase("1"))
			{
				String strUpdateSID = "";
				String strSql = "select WIN_USER_ID,DOMAIN_NAME from AD_USER_INFO_MST where CONVERT(NVARCHAR(MAX),SID)='"+strSId+"' and PROCESS_ID = "+process;
				Connection objCon1 = null;
				objCon  		= dbConBean.getConnection();
				PreparedStatement ps = objCon.prepareStatement(strSql);
				ResultSet rs1 = ps.executeQuery();
				String windowID="";
				String domainName="";
				if(rs1.next())
			    {
				      if(rs1.getRow()==1)
				      {
				    	  windowID=rs1.getString("WIN_USER_ID");
				      	  domainName=rs1.getString("DOMAIN_NAME");
				    	  strUpdateSID = domainName+"\\"+windowID;
				      }
				}	
				rs1.close();
				//request.setAttribute("updateSIDStatus", "UpdateNotSuccessfull");
				strMessage = "UpdateNotSuccessfull";
				if(strSIDNo.equals(""))
				{
					strSIDNo=strUpdateSID;
				}
				else
				{
					strSIDNo=strSIDNo+", "+ strUpdateSID;
				}
				strUpdateSidNo = strSIDNo;
			}
		}
		}
		else
		{
			strUpdateSidNo = strSIDNo;
		}
	}catch (Exception e) {
		System.out.println("error in M_ADUserSync.jsp---> "+e);
	}
      String strUrl = "M_ADUserSync.jsp?updatedsidno="+strUpdateSidNo+"&message="+strMessage+"&dateFrom="+strdateFrom+"&process="+processselected+"&actionType="+actionType;
      response.sendRedirect(strUrl);	
	  dbConBean.close();
%>