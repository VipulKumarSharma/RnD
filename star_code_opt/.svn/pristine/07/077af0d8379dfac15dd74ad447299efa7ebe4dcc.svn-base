<%
/***************************************************
 * Project		 	: Generic
 * Created By		: Jitendra Singh
 * Created On		: 22 Mar 2012
 * Description		: For Ajax Combo Population of Mobile Survey Component 
 ****************************************************/
 %>
 

<%@page import="java.util.*,java.sql.*,Mobile_Connection.*,java.io.FileInputStream"%>
<%@ include  file="/application.jsp" %>
<jsp:useBean id="dbConBean" scope="page" class="Mobile_Connection.Mobile_survey_Connnection" />
<jsp:useBean id="dbConBean1" scope="page" class="src.connection.DbConnectionBean" />
<% 
  response.setHeader("Pragma","no-cache");
  response.setDateHeader("Expires",0);
  response.setHeader("Cache-Control","no-cache");
  response.setContentType("text/html; charset=UTF-8");
%>
<%!
String email="";
Mobile_survey_Connnection conn;

Connection objCon,objCon1;
String strUserInfoId;
ResultSet rs;
Statement stmt;
String strReportFlag;
String model_name;
%>
<%
strReportFlag= request.getParameter("reportFlag")==null?"no":request.getParameter("reportFlag");
//System.out.println("strReportFlag---->"+strReportFlag);
%>
<%


objCon1=dbConBean1.getConnection();	
try
{
	String sqlStr="select email from m_userinfo where userid="+Suser_id;
	stmt 	= 	objCon1.createStatement();
	rs=stmt.executeQuery(sqlStr);
	while(rs.next())
	{
		email=rs.getString(1);
	}
	rs.close();
	stmt.close();
	objCon1.close();

}
catch(Exception e)
{
	System.out.println("First time code--->>"+e);
}
%>

<%
//To update table in case of "Don't show this again"
if(strReportFlag.contains("**"))
{
	//System.out.println("Inside **");
	/////////////////////////////////////
	try
	{
		objCon=dbConBean.getConnection();
		String model_name="";
		//String sqlStr=" update user_mobile_info set flag_show="+"'Y'"+"where email='"+email+"'";
		String sqlStr="insert into user_mobile_info values('"+email+"','','','Y')";
		//System.out.println("sqlStr---->"+sqlStr);
		stmt 	= 	objCon.createStatement();
		stmt.executeUpdate(sqlStr);
		stmt.close();
		objCon.close();

	}
	catch(Exception e)
	{
		System.out.println("Error in To update table in case of Don't show this again-->>> "+e);
	}
}
//To see whether to popup or not
if(strReportFlag.contains("@@@@"))
{
	String flag_show="";
	String emailcheck="";
	objCon=dbConBean.getConnection();
	//////////////////////////////////////
	try
	{
		String sqlStr="select email from user_mobile_info where email='"+email+"'";
		//System.out.println("sqlStr---->"+sqlStr);
		stmt 	= 	objCon.createStatement();
		rs=stmt.executeQuery(sqlStr);
		if(rs.next())
		{
			emailcheck=rs.getString(1);
		}
		else
		 	emailcheck="";
		rs.close();
		stmt.close();
	}
	catch(Exception e)
	{
		System.out.println("Exception is----->>>"+e);
	}
	if(emailcheck.equals(""))
	{
		flag_show="yes";
		response.getWriter().write(flag_show.trim());
	}
	else
	{
	/////////////////////////////////////
	try
	{
		String model_name="";
		String sqlStr="select flag_show from user_mobile_info where  email='"+emailcheck+"'";
		stmt 	= 	objCon.createStatement();
		//System.out.println("now iss--->>"+sqlStr);
		rs=stmt.executeQuery(sqlStr);
		while(rs.next())
		{
		flag_show=rs.getString(1);
		}
		rs.close();
		stmt.close();
		objCon.close();
	}
	catch(Exception e)
	{
		System.out.println("error in Ajax Master 1  -->>> "+e);
	}
	//System.out.println("flag_show is--->>"+flag_show);
	if(flag_show.equalsIgnoreCase("y"))
	{
		flag_show="no";
	}
	else
	{
		//System.out.println("in else with flag_show--->>"+flag_show);
		flag_show="yes";
	}
	response.getWriter().write(flag_show);
	}
}
//To update information of Mobile in case of user submit the information
if(strReportFlag.contains("##"))
{
	String mobile_make="";
	String handset="";
	StringTokenizer st = new StringTokenizer(strReportFlag,"##"); 
	while(st.hasMoreTokens()) 
	{
		mobile_make=st.nextToken(); 
		handset=st.nextToken();
	}
	objCon=dbConBean.getConnection();
	try
	{
		String model_name="";
		//String sqlStr="update user_mobile_info set MBL_Make="+"'"+mobile_make+"'"+",Mbl_Model="+"'"+handset+"',flag_show="+"'Y'"+"where email='"+email+"'";
		String sqlStr="insert into user_mobile_info values('"+email+"','"+mobile_make+"','"+handset+"','Y')";
		stmt 	= 	objCon.createStatement();
		stmt.executeUpdate(sqlStr);
		stmt.close();
		objCon.close();
	}
	catch(Exception e)
	{
		System.out.println("Error in insert information of Mobile in case of user submit the information-->>"+e);
	}
}
//Method for getting Handset makes from DB
if(strReportFlag.contains("make"))
{
	//System.out.println("Inside make");
	String genHtml=" ";
	if(strReportFlag.length()>4)
	{
		String make_id = strReportFlag.substring(4);
		//conn=new Mobile_survey_Connnection();
		objCon=dbConBean.getConnection();
		//objCon=conn.getConnection();	
		try
		{
			String model_name="";
			String sqlStr="select model_name from MOBILE_OS_MODEL_MST where MOBILE_OS_MODEL_MST.MBL_OS_ID="+Integer.parseInt(make_id);
			stmt 	= 	objCon.createStatement();
			rs	=	stmt.executeQuery(sqlStr);
			genHtml=genHtml+"<option value=-2>Select Your Handset</option>";
			while(rs.next())
			{
			model_name=rs.getString(1);
			genHtml=genHtml+"<option value='"+model_name+"'>"+model_name+"</option>";
			}
			rs.close();
			stmt.close();
			objCon.close();

		}
		catch(Exception e)
		{
			System.out.println("error in Ajax Master  3 -->>> "+e);
		}
	}
	else
	{
	objCon=dbConBean.getConnection();
	try
	{
		String sqlStr="select mbl_os_id,mbl_display_name from MOBILE_OS_MST";
		stmt 	= 	objCon.createStatement();
		rs	=	stmt.executeQuery(sqlStr);
		genHtml=genHtml+"<option value='-1'>Select Company</option>";
		while(rs.next())
		{
		genHtml=genHtml+"<option value='"+rs.getInt(1)+"'>"+rs.getString(2)+"</option>";
		}
		rs.close();
		stmt.close();
		objCon.close();
		genHtml=genHtml+"<option value='0'>Others</option>";
	}
	catch(Exception e)
	{
		System.out.println("error in Ajax Master 4  -->>> "+e);
	}finally{
		dbConBean1.closeCon();
	}

}
	response.getWriter().write(genHtml);
}
%>