/* Project		 	: STARS
 * Created By		: Manoj Chand
 * Created On		: 06 May 2013
 * Description		: This class is used to load data to the grid of ad sync page.
  */

package jqGrid.servlet;

import src.connection.Bn_date_utility;
import src.connection.DbConnectionBean;
import src.connection.DbUtilityMethods;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Properties;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringEscapeUtils;

/**
 * Servlet implementation class ApprovalListData
 */
public class AdSyncData extends HttpServlet {
	String  target="";
	DbConnectionBean conn = null;
	DbUtilityMethods dbUtility = new DbUtilityMethods();
	Bn_date_utility dateFormat = new Bn_date_utility();
		
	ResultSet rs,rs1;
	Statement st=null;
	String strSql=""; // for common sql string
	Bn_date_utility db_date=new Bn_date_utility();
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//System.out.println("IN SERVLET  ");
		conn = new DbConnectionBean();
		response.setContentType("text/html; charset=UTF-8");
		HttpSession session		=		request.getSession(false);
		Bn_date_utility db_date=new Bn_date_utility();
		
		String dateFrom=request.getParameter("dateFrom")==null?"":request.getParameter("dateFrom");
		String process=request.getParameter("process")==null?"":request.getParameter("process");
		String actionType=request.getParameter("actionType")==null?"":request.getParameter("actionType");
		//System.out.println("dateFrom-->"+dateFrom);
		//System.out.println("process-->"+process);
		try
		{		
			
			if(!dateFrom.equals("") && !process.equals("")){
				String page = request.getParameter("page"); // get the requested page 
				String limit = request.getParameter("rows"); // get how many rows we want to have into the grid 
				int pageInt = Integer.parseInt(page);
				int limitInt = Integer.parseInt(limit);
			ArrayList AdSyncList;
			AdSyncList=new ArrayList();
			int intCount=1;
			rs=null;
			String actionSearch=" ";
			if(!actionType.equals("")){
				actionSearch="AND ACTION_TYPE='"+actionType+"' ";
			}
			//System.out.println("process in adsynchdata ---->"+process);
			if(process.equals("-1")){
				strSql="select * from (select ROW_NUMBER() OVER (ORDER BY PROCESS_ID,FIRST_NAME,LAST_NAME,EMAIL) AS rownum, PROCESS_ID,convert(nvarchar(max),SID) as SID,EMP_CODE,LOGIN_NAME,FIRST_NAME,MIDDLE_NAME,LAST_NAME,EMAIL,GENDER, CASE WHEN YEAR(DATE_OF_BIRTH)=1900 THEN '' ELSE CONVERT(VARCHAR(10),DATE_OF_BIRTH,20) END AS DATE_OF_BIRTH,  REPLACE(REPLACE(EMP_RES_ADDRESS,CHAR(13),' '),CHAR(10),' ') AS EMP_RES_ADDRESS, REPLACE(REPLACE(EMP_OFF_ADDRESS,CHAR(13),' '),CHAR(10),' ') EMP_OFF_ADDRESS,PHONE_NO, MOBILE_NO,PASSPORT_NO, CASE WHEN YEAR(DATE_ISSUE)=1900 THEN '' ELSE CONVERT(VARCHAR(10),DATE_ISSUE,20) end as DATE_ISSUE, CASE WHEN YEAR(EXPIRY_DATE)=1900 THEN '' ELSE CONVERT(VARCHAR(10),EXPIRY_DATE,20) end as EXPIRY_DATE, PLACE_ISSUE,FAX_NO,REPORT_TO,COMPANY,COUNTRY, DEPT_NAME,DESI_NAME,  WIN_USER_ID,DOMAIN_NAME,	ACTION_TYPE,ACTION_MODE,CONVERT(VARCHAR(10),AD_FETCH_DATE,20)AD_FETCH_DATE,CONVERT(VARCHAR(10),AD_FETCH_DATE,103)AD_FETCH_DATE1, STATUS from AD_USER_INFO_MST WHERE STATUS='N' AND ACTION_MODE='MANUAL' AND convert(varchar(10),AD_FETCH_DATE,20)<= CONVERT(VARCHAR(10),CONVERT(DATETIME,'"+dateFrom+"',103),20)"+actionSearch;
			}else{
				strSql= "select * from (select ROW_NUMBER() OVER (ORDER BY PROCESS_ID,FIRST_NAME,LAST_NAME,EMAIL) AS rownum,"+
				" PROCESS_ID,convert(nvarchar(max),SID) as SID,EMP_CODE,LOGIN_NAME,FIRST_NAME,MIDDLE_NAME,LAST_NAME,EMAIL,GENDER,"+
				" CASE WHEN YEAR(DATE_OF_BIRTH)=1900 THEN '' ELSE CONVERT(VARCHAR(10),DATE_OF_BIRTH,20) END AS DATE_OF_BIRTH, "+
				" REPLACE(REPLACE(EMP_RES_ADDRESS,CHAR(13),' '),CHAR(10),' ') AS EMP_RES_ADDRESS,"+
				" REPLACE(REPLACE(EMP_OFF_ADDRESS,CHAR(13),' '),CHAR(10),' ') EMP_OFF_ADDRESS,PHONE_NO,"+
				" MOBILE_NO,PASSPORT_NO,"+
				" CASE WHEN YEAR(DATE_ISSUE)=1900 THEN '' ELSE CONVERT(VARCHAR(10),DATE_ISSUE,20) end as DATE_ISSUE,"+
				" CASE WHEN YEAR(EXPIRY_DATE)=1900 THEN '' ELSE CONVERT(VARCHAR(10),EXPIRY_DATE,20) end as EXPIRY_DATE,"+
				" PLACE_ISSUE,FAX_NO,REPORT_TO,COMPANY,COUNTRY, DEPT_NAME,DESI_NAME, "+
				" WIN_USER_ID,DOMAIN_NAME,	ACTION_TYPE,ACTION_MODE,AD_FETCH_DATE,CONVERT(VARCHAR(10),AD_FETCH_DATE,103)AD_FETCH_DATE1, STATUS from AD_USER_INFO_MST"+ 
				" WHERE STATUS='N' AND ACTION_MODE='MANUAL' AND convert(varchar(10),AD_FETCH_DATE,20) <= CONVERT(VARCHAR(10),CONVERT(DATETIME,'"+dateFrom+"',103),20) "+   
				""+actionSearch+""+
				" AND PROCESS_ID = "+process;
			}
			String searchStr=" ";
			String siteName_mask1 = request.getParameter("siteName_mask1"); 
			//System.out.println("siteName_mask1-->"+siteName_mask1);
			if(siteName_mask1 != null && !siteName_mask1.equals("")){
			siteName_mask1 = siteName_mask1.replaceAll("%u", "\\\\u");
			siteName_mask1 = StringEscapeUtils.unescapeJava(siteName_mask1);
			}
			
			String searchFlag1 = request.getParameter("search1");
			if(searchFlag1 != null && !searchFlag1.equals("")&& searchFlag1.equals("true")){
				searchStr += " AND (WIN_USER_ID LIKE N'%"+siteName_mask1+"%' "; 
				searchStr += " OR DOMAIN_NAME LIKE N'%"+siteName_mask1+"%' ";
				searchStr += " OR FIRST_NAME LIKE N'%"+siteName_mask1+"%' "; 
				searchStr += " OR LAST_NAME LIKE N'%"+siteName_mask1+"%' ";
				searchStr += " OR EMAIL LIKE N'%"+siteName_mask1+"%' )"; 
			 
			}
			String orderClause = " ORDER BY SID,drvtbl.AD_FETCH_DATE";
			strSql = strSql + searchStr+")drvtbl ";
			String strSerialNo="0";
			rs=conn.executeQuery(strSql);
			int setSize=0;
			while(rs.next()){
				setSize++;
			}
			rs.close();
			
			int totalPage=0;
			if( setSize >0 ) { 
				totalPage = (int)(Math.ceil((float)setSize/limitInt)); 
				if(totalPage == 0){
					totalPage = 1;
				}
			} else { 
				totalPage = 0; 
			} 
			if (pageInt > totalPage) 
				pageInt=totalPage; 
			int start = limitInt*pageInt - limitInt; // do not put $limit*($page - 1) 
			String whereClauseOuter = " WHERE rownum > "+start+" and rownum <="+(start+limitInt);
			strSql = strSql + whereClauseOuter + orderClause;
			//+ orderClause;
			//System.out.println("strSql--f----AD SYNC--->"+strSql);
			rs1=null;
			rs1=conn.executeQuery(strSql);
			
			response.setCharacterEncoding("UTF-8");
			response.setContentType("application/json;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.print("{'page':'"+pageInt+"', " +
					"'total':"+totalPage+"," +
					"'records':'"+setSize+"'," +
					"'rows':[");
		//	out.println("{'id':'-1','cell':['','_search','_search','_search','_search','_search','','_search','_search','_search','','','','','','','','','','','','','']}");

			
			while(rs1.next())
			{
				strSerialNo= new Integer(intCount++).toString();   
				String PROCESS_ID=rs1.getString("PROCESS_ID");
				String SID=rs1.getString("SID");
				String EMP_CODE=rs1.getString("EMP_CODE");
				String LOGIN_NAME=rs1.getString("LOGIN_NAME");
				
				String FIRST_NAME=rs1.getString("FIRST_NAME");
			String MIDDLE_NAME=rs1.getString("MIDDLE_NAME");
				String LAST_NAME=rs1.getString("LAST_NAME");
				String EMAIL=rs1.getString("EMAIL");
				String GENDER=rs1.getString("GENDER");
				String DATE_OF_BIRTH=rs1.getString("DATE_OF_BIRTH");
				//DATE_OF_BIRTH=db_date.formatDate(DATE_OF_BIRTH,strDBDateFormat,strCountryDateFormat);
				String EMP_RES_ADDRESS=rs1.getString("EMP_RES_ADDRESS").trim();
				String EMP_OFF_ADDRESS=rs1.getString("EMP_OFF_ADDRESS").trim();
				String PHONE_NO=rs1.getString("PHONE_NO");
				String MOBILE_NO=rs1.getString("MOBILE_NO");
			String PASSPORT_NO = rs1.getString("PASSPORT_NO");
			String DATE_ISSUE = rs1.getString("DATE_ISSUE");
			String EXPIRY_DATE = rs1.getString("EXPIRY_DATE");
			String PLACE_ISSUE = rs1.getString("PLACE_ISSUE");
				String FAX_NO=rs1.getString("FAX_NO");
						//String ADMIN_BOSS_NAME=rs1.getString("ADMIN_BOSS_NAME");
						//String TECH_BOSS_NAME=rs1.getString("TECH_BOSS_NAME");
			String REPORT_TO = rs1.getString("REPORT_TO");
				String COMPANY=rs1.getString("COMPANY");
				String COUNTRY=rs1.getString("COUNTRY");
				String DEPT_NAME=rs1.getString("DEPT_NAME");
				String DESI_NAME=rs1.getString("DESI_NAME");
				String WIN_USER_ID=rs1.getString("WIN_USER_ID");
				String DOMAIN_NAME=rs1.getString("DOMAIN_NAME");
				String ACTION_TYPE=rs1.getString("ACTION_TYPE");
				if(ACTION_TYPE.equals("U")){
					ACTION_TYPE="UPDATE";
				}else if(ACTION_TYPE.equals("D")){
					ACTION_TYPE="DELETE";
				}else if(ACTION_TYPE.equals("N")){
					ACTION_TYPE="NEW";
				}
				String ACTION_MODE=rs1.getString("ACTION_MODE");
				
				String AD_FETCH_DATE=rs1.getString("AD_FETCH_DATE");
				String AD_FETCH_DATE1=rs1.getString("AD_FETCH_DATE1");
				String STATUS=rs1.getString("STATUS");
				if(strSerialNo.equals("1")){
					out.println("{'id':'"+SID+"$"+strSerialNo+"','cell':['"+strSerialNo+"','"+ACTION_TYPE+"','"+AD_FETCH_DATE1+"','"+SID+"','"+WIN_USER_ID+"','"+DOMAIN_NAME+"','"+FIRST_NAME+"','"+MIDDLE_NAME+"','"+LAST_NAME+"','"+EMP_CODE+"','"+LOGIN_NAME+"','"+EMAIL+"','"+GENDER+"','"+DATE_OF_BIRTH+"','"+EMP_RES_ADDRESS+"','"+EMP_OFF_ADDRESS+"','"+PHONE_NO+"','"+MOBILE_NO+"','"+FAX_NO+"','"+PASSPORT_NO+"','"+DATE_ISSUE+"','"+EXPIRY_DATE+"','"+PLACE_ISSUE+"','"+REPORT_TO+"','"+COMPANY+"','"+COUNTRY+"','"+DEPT_NAME+"','"+DESI_NAME+"','"+ACTION_MODE+"','"+STATUS+"','"+PROCESS_ID+"','"+AD_FETCH_DATE+"','']}");
				}else{
					out.println(",{'id':'"+SID+"$"+strSerialNo+"','cell':['"+strSerialNo+"','"+ACTION_TYPE+"','"+AD_FETCH_DATE1+"','"+SID+"','"+WIN_USER_ID+"','"+DOMAIN_NAME+"','"+FIRST_NAME+"','"+MIDDLE_NAME+"','"+LAST_NAME+"','"+EMP_CODE+"','"+LOGIN_NAME+"','"+EMAIL+"','"+GENDER+"','"+DATE_OF_BIRTH+"','"+EMP_RES_ADDRESS+"','"+EMP_OFF_ADDRESS+"','"+PHONE_NO+"','"+MOBILE_NO+"','"+FAX_NO+"','"+PASSPORT_NO+"','"+DATE_ISSUE+"','"+EXPIRY_DATE+"','"+PLACE_ISSUE+"','"+REPORT_TO+"','"+COMPANY+"','"+COUNTRY+"','"+DEPT_NAME+"','"+DESI_NAME+"','"+ACTION_MODE+"','"+STATUS+"','"+PROCESS_ID+"','"+AD_FETCH_DATE+"','']}");
					}
			}
			out.println("]}");
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
			System.out.println("error in AdSyncData.java---->"+e);
		}finally{
			
			try{
				//rs1.close();
				conn.close();
			}catch(Exception e){
				System.out.println("error in AdSyncData.java while closing connection---->"+e);
			}
		}
	}
}
