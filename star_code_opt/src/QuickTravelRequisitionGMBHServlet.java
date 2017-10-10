

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.Map.Entry;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import src.connection.DbConnectionBean;
import src.connection.LabelRepository;
import src.dao.T_QuicktravelRequestDaoImpl;
/**
 * Servlet implementation class TravelRequisitionSearchServlet
 */
public class QuickTravelRequisitionGMBHServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	LabelRepository LableMst=new LabelRepository(); 
	T_QuicktravelRequestDaoImpl dao = new T_QuicktravelRequestDaoImpl();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public QuickTravelRequisitionGMBHServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=UTF-8");
		
		DbConnectionBean objCon=new DbConnectionBean();
		ResultSet rs, rs1, rs2, rs3, rs4, rs5, rs6 = null;
		
		String  strSql ="", strSqlBillSite ="", strSqlBillUser ="";
		
		String strFlag = "";
		  
		String strReqPageqtr 			= 	(request.getParameter("reqpage") == null) ? "":request.getParameter("reqpage");
		String strSuserId				= 	(request.getParameter("suserId") == null) ? "":request.getParameter("suserId");
		String strUserId				= 	(request.getParameter("userId") == null) ? "":request.getParameter("userId");
		String strSiteId 				= 	(request.getParameter("siteId") == null) ? "":request.getParameter("siteId");
		String strTravelType			= (request.getParameter("travelType") == null) ? "":request.getParameter("travelType");
		String strLanguage1				= 	(request.getParameter("language1") == null) ? "":request.getParameter("language1");
		String strBillingClientId 		= 	(request.getParameter("billingClientId") == null) ? "":request.getParameter("billingClientId");
		String strSuserRoleOther 		= 	(request.getParameter("suserRoleOther") == null) ? "":request.getParameter("suserRoleOther");
		String strGroupTravelFlag 		= 	(request.getParameter("groupTravelFlag") == null) ? "":request.getParameter("groupTravelFlag");
		
		StringBuilder strBillSiteHtml = new StringBuilder(); 
		StringBuilder strBillUserHtml = new StringBuilder();
		StringBuilder strTravellerHtml = new StringBuilder();
		StringBuilder strTrvClsFltHtml = new StringBuilder();
		StringBuilder strCarTimeListHtml = new StringBuilder();
		 
		HashMap<String,Object> dataMap = new HashMap<String,Object>();	
		ArrayList<HashMap<String, Object>> dataList = new ArrayList<HashMap<String, Object>>();
		
		try {			
			 if(!strSiteId.equals("") && strSiteId != null && strReqPageqtr.equalsIgnoreCase("quickTravelReqApprLvl")) {						
					
				strSqlBillSite = "SELECT SITE_ID,DBO.SITENAME(SITE_ID) AS SITE_NAME FROM M_SITE WHERE STATUS_ID=10 AND APPLICATION_ID=1 AND (M_SITE.CLOSED_UNIT_FLAG is null or M_SITE.CLOSED_UNIT_FLAG='') ORDER BY 2";
				rs3 = objCon.executeQuery(strSqlBillSite); 
				
					while(rs3.next()) {
						if(!strSiteId.equals("") && strSiteId != null && strSiteId.equals(rs3.getString(1))) {
							strBillSiteHtml.append("<option value='"+rs3.getString(1)+ "' selected>"+rs3.getString(2)+"</option>");
						} else {
							strBillSiteHtml.append("<option value='"+rs3.getString(1)+ "'>"+rs3.getString(2)+"</option>");
						}						
					}
					rs3.close(); 
					
					dataMap = new HashMap<String,Object>();						
					dataMap.put("billSiteHtml", strBillSiteHtml.toString());
					dataList.add(dataMap);					
				
				JSONArray jsArray = new JSONArray(dataList);		
				response.getWriter().print(jsArray);
				
			 } else if(!strSiteId.equals("") && strSiteId != null && strReqPageqtr.equalsIgnoreCase("quickTravelReqBillSMGUser")) {
				 
				 strSql = "SELECT 1 AS yes FROM USER_SITE_ACCESS WHERE (USERID = "+strUserId+") AND (SITE_ID = "+strBillingClientId+") AND USER_SITE_ACCESS.STATUS_ID=10";
				 rs = objCon.executeQuery(strSql); 
				 while (rs.next()) {
						strFlag = rs.getString(1);
					}
				rs.close();
				
				 if(strBillingClientId.equals(strSiteId) || "1".equals(strFlag)) {					 
					 strBillUserHtml.append("<option  value='-1'>"+LableMst.getLabel("label.createrequest.userfrombillingunit", strLanguage1)+"</option>");						 
				 } else if(!strBillingClientId.equals(strSiteId)) {
					    strBillUserHtml.append("<option  value='-1'>"+LableMst.getLabel("label.createrequest.userfrombillingunit", strLanguage1)+"</option>");
					 	strSql =   "SELECT 1 FROM M_BILLING_APPROVER BA inner join M_userInfo UI on UI.userid = BA.approver_id WHERE BA.SITE_ID= "+ strBillingClientId +" and status_id =10";
			   			rs = objCon.executeQuery(strSql); 
			   			if (!rs.next()) {
							rs.close();
							strSqlBillUser = "select distinct userid, dbo.USER_NAME_MATA(userid) As UserName from M_userInfo "
										+ "where (site_id="
										+ strBillingClientId
										+ " and status_id=10 and  ISNULL(APPROVER_LEVEL,0) in (1,2) )"
										+ "or (status_id=10 and  ISNULL(APPROVER_LEVEL,0) in (3) )"
										+ "order by 2";
							rs4 = objCon.executeQuery(strSqlBillUser);
							while (rs4.next()) {
								strBillUserHtml.append("<option value='"+rs4.getString("UserId")+ "'>"+rs4.getString("UserName")+"</option>");
							}
							rs4.close(); 
			   			} else {
			   				strSqlBillUser = "SELECT distinct APPROVER_ID as userid, dbo.USER_NAME_MATA(APPROVER_ID) As UserName "
										+ "FROM M_BILLING_APPROVER BA inner join M_userInfo UI on UI.userid = BA.approver_id "
										+ "WHERE BA.SITE_ID= "
										+ strBillingClientId
										+ " and status_id =10";
			   				rs4 = objCon.executeQuery(strSqlBillUser);
							while (rs4.next()) {
								strBillUserHtml.append("<option value='"+rs4.getString("UserId")+ "'>"+rs4.getString("UserName")+"</option>");
							}
							rs4.close(); 
			   			}					
				 }
				 
				dataMap = new HashMap<String,Object>();						
				dataMap.put("billUserHtml", strBillUserHtml.toString());									  
				dataMap.put("multiSiteAccessFlag", strFlag);
				
		     	JSONObject jsObj = new JSONObject(dataMap);		
				response.getWriter().print(jsObj);
				 
			 } else if(!strSiteId.equals("") && strSiteId != null && strReqPageqtr.equalsIgnoreCase("quickTravelReqTravellers")) {				 
				   
				  strTravellerHtml.append("<option  value='-1' selected>"+LableMst.getLabel("label.createrequest.travellername", strLanguage1)+"</option>");
				 	
				  if(!strSiteId.equals("0")) {
						if(strSuserRoleOther.equals("LA") || strSuserRoleOther.equals("TC")) {
						 strSql=" SELECT     USERID, DBO.USER_NAME_MATA(USERID) AS USERNAME "+
						 "FROM         M_USERINFO WITH (NOLOCK) WHERE     (SITE_ID = "+strSiteId+") AND (STATUS_ID = 10) AND (APPLICATION_ID = 1) "+
						 " UNION SELECT USERID,DBO.USER_NAME_MATA(USERID) AS USERNAME "+
						 " FROM USER_MULTIPLE_ACCESS WHERE (SITE_ID = "+strSiteId+") AND (STATUS_ID = 10) ORDER BY USERNAME";
						} else {
							strSql =   "select userid, dbo.user_name(userid) As UserName from M_userInfo (NOLOCK) where userid="+strSuserId+" and status_id=10 and application_id=1 order by 2";
						} 
				 
						rs =   objCon.executeQuery(strSql);
                  							 
	                  while(rs.next()) {
	                	  strTravellerHtml.append("<option value='"+rs.getString("UserId")+ "'>"+rs.getString("UserName")+"</option>");
					  }				 
	                  rs.close();
				  }
                  dataMap = new HashMap<String,Object>();						
  				  dataMap.put("travellerHtml", strTravellerHtml.toString());									  
  				
  		     	  JSONObject jsObj = new JSONObject(dataMap);		
  				  response.getWriter().print(jsObj);
				 
			 } else if(!strUserId.equals("") && strUserId != null && strReqPageqtr.equalsIgnoreCase("quickTravelReqPersonalDetail")) {

				 	String TRAVELLERSITEID			=  "";
					String SITENAME					=  "";
					String TRAVELLERUSERID			=  "";
					String FIRSTNAME                =  "";
					String MIDDLENAME               =  "";
					String LASTNAME                 =  "";
					String FNAMEPASSPORT            =  "";
					String LNAMEPASSPORT            =  "";
					String DESIGNATION				=  "";
					String GENDER					=  "";
					String EMAIL                    =  "";
					String CONTACT_NUMBER           =  "";
					String DOB                      =  "";					
					String PASSPORT_NO              =  "";
					String NATIONALITY				=  "";
					String PASSPORT_ISSUE_COUNTRY   =  "";
					String PLACE_ISSUE              =  "";	
					String DATE_ISSUE               =  "";		
					String EXPIRY_DATE              =  "";
					String ADDRESS                  =  "";
					String CURRENT_ADDRESS			=  "";	
					String AIRLINE_NAME1			=  "";
					String AIRLINE_NAME2			=  "";
					String AIRLINE_NAME3			=  "";
					String AIRLINE_NAME4			=  "";
					String AIRLINE_NAME5			=  "";
					String AIRLINE_NO1				=  "";
					String AIRLINE_NO2				=  "";
					String AIRLINE_NO3				=  "";
					String AIRLINE_NO4				=  "";
					String AIRLINE_NO5				=  "";
					String HOTEL_NAME1				=  "";
					String HOTEL_NAME2				=  "";
					String HOTEL_NAME3				=  "";
					String HOTEL_NAME4				=  "";
					String HOTEL_NAME5				=  "";
					String HOTEL_NO1				=  "";
					String HOTEL_NO2				=  "";
					String HOTEL_NO3				=  "";
					String HOTEL_NO4				=  "";
					String HOTEL_NO5				=  "";
					String COST_CENTER				=  "0";
					String COST_CENTER_NAME			=  "";
					String SEX						=  "";
					
					String strShowflag = "n";
									
					strSql  =  " SELECT USERID,SITE_ID,dbo.SITENAME(SITE_ID) AS SITENAME, FIRSTNAME, LASTNAME, ISNULL(MIDDLENAME ,'') AS MIDDLENAME, " +
							   " LTRIM(RTRIM(EMAIL)) AS EMAIL, ISNULL(CONTACT_NUMBER,'') AS CONTACT_NUMBER, ISNULL(ADDRESS,'') AS ADDRESS, " +
							   " ISNULL(CURRENT_ADDRESS,'') AS CURRENT_ADDRESS, ISNULL(IDENTITY_ID,-1) AS IDENTITY_ID, ISNULL(IDENTITY_NO,'') AS IDENTITY_NO, " + 
							   " LTRIM(RTRIM(ISNULL(PASSPORT_NO,''))) AS PASSPORT_NO, ISNULL(PLACE_ISSUE,'') AS PLACE_ISSUE, ISNULL(.DBO.CONVERTDATEDMY1(DATE_ISSUE),'') AS DATE_ISSUE, " +
							   " ISNULL(.DBO.CONVERTDATEDMY1(EXPIRY_DATE),'') AS EXPIRY_DATE, ISNULL(dbo.DESIGNATIONNAME(DESIG_ID),'') AS DESIG,  ISNULL(.DBO.CONVERTDATEDMY1(DOB),'') AS DOB, " +
							   " GENDER AS GENDER, ISNULL(FF_AIR_NAME,'') AS FF_AIR_NAME, ISNULL(FF_AIR_NAME1,'') AS FF_AIR_NAME1, ISNULL(FF_AIR_NAME2,'') AS FF_AIR_NAME2, " +
							   " ISNULL(FF_AIR_NAME3,'') AS FF_AIR_NAME3, ISNULL(FF_AIR_NAME4,'') AS FF_AIR_NAME4, ISNULL(FF_NUMBER,'') AS FF_NUMBER, ISNULL(FF_NUMBER1,'') AS FF_NUMBER1, " +
							   " ISNULL(FF_NUMBER2,'') AS FF_NUMBER2, ISNULL(FF_NUMBER3,'') AS FF_NUMBER3, ISNULL(FF_NUMBER4,'') AS FF_NUMBER4,   ISNULL(HOTEL_NAME,'') AS HOTEL_NAME, " +
							   " ISNULL(HOTEL_NAME1,'') AS HOTEL_NAME1, ISNULL(HOTEL_NAME2,'') AS HOTEL_NAME2,ISNULL(HOTEL_NAME3,'') AS HOTEL_NAME3, ISNULL(HOTEL_NAME4,'') AS HOTEL_NAME4, " +
							   " ISNULL(HOTEL_NUMBER,'') AS HOTEL_NUMBER, ISNULL(HOTEL_NUMBER1,'') AS HOTEL_NUMBER1, ISNULL(HOTEL_NUMBER2,'') AS HOTEL_NUMBER2, " + 
							   " ISNULL(HOTEL_NUMBER3,'') AS HOTEL_NUMBER3, ISNULL(HOTEL_NUMBER4,'') AS HOTEL_NUMBER4, ISNULL(NATIONALITY,'') AS NATIONALITY, " +
							   " ISNULL(FULL_NAME,'') AS FULL_NAME, ISNULL(PASSPORT_F_NAME,'') AS PASSPORT_F_NAME, ISNULL(PASSPORT_L_NAME,'') AS PASSPORT_L_NAME, " +
							   " DEPT_ID AS COST_CENTER, DBO.DEPARTMENTNAME(DEPT_ID) AS COST_CENTER_NAME, REPORT_TO AS MANAGER, DEPT_HEAD AS HOD, ISNULL(PASSPORT_ISSUE_COUNTRY,'0') AS PASSPORT_ISSUE_COUNTRY FROM M_USERINFO WHERE USERID = '"+strUserId+"' AND APPLICATION_ID = 1 ";
					rs = objCon.executeQuery(strSql);
					
					if(rs.next()) {
						TRAVELLERSITEID		=  rs.getString("SITE_ID");
						SITENAME			=  rs.getString("SITENAME");
						TRAVELLERUSERID		=  rs.getString("USERID");
						FIRSTNAME       	=  rs.getString("FIRSTNAME");
						MIDDLENAME			=  rs.getString("MIDDLENAME");
						LASTNAME        	=  rs.getString("LASTNAME");
						DESIGNATION			=  rs.getString("DESIG");
						GENDER				=  rs.getString("GENDER");
						EMAIL           	=  rs.getString("EMAIL");
						CONTACT_NUMBER  	=  rs.getString("CONTACT_NUMBER");
						DOB             	=  rs.getString("DOB");				
						PASSPORT_NO        	=  rs.getString("PASSPORT_NO");
						FNAMEPASSPORT		=  rs.getString("PASSPORT_F_NAME");
						LNAMEPASSPORT		=  rs.getString("PASSPORT_L_NAME");
						NATIONALITY			=  rs.getString("NATIONALITY");
						PASSPORT_ISSUE_COUNTRY = rs.getString("PASSPORT_ISSUE_COUNTRY");
						PLACE_ISSUE   		=  rs.getString("PLACE_ISSUE");
						DATE_ISSUE    		=  rs.getString("DATE_ISSUE");
						EXPIRY_DATE			=  rs.getString("EXPIRY_DATE");
						ADDRESS         	=  rs.getString("ADDRESS");
						CURRENT_ADDRESS 	=  rs.getString("CURRENT_ADDRESS");
						AIRLINE_NAME1		=  rs.getString("FF_AIR_NAME");
						AIRLINE_NAME2		=  rs.getString("FF_AIR_NAME1");
						AIRLINE_NAME3		=  rs.getString("FF_AIR_NAME2");
						AIRLINE_NAME4		=  rs.getString("FF_AIR_NAME3");
						AIRLINE_NAME5		=  rs.getString("FF_AIR_NAME4");
						AIRLINE_NO1			=  rs.getString("FF_NUMBER");
						AIRLINE_NO2			=  rs.getString("FF_NUMBER1");
						AIRLINE_NO3			=  rs.getString("FF_NUMBER2");
						AIRLINE_NO4			=  rs.getString("FF_NUMBER3");
						AIRLINE_NO5			=  rs.getString("FF_NUMBER4");
						HOTEL_NAME1			=  rs.getString("HOTEL_NAME");
						HOTEL_NAME2			=  rs.getString("HOTEL_NAME1");
						HOTEL_NAME3			=  rs.getString("HOTEL_NAME2");
						HOTEL_NAME4			=  rs.getString("HOTEL_NAME3");
						HOTEL_NAME5			=  rs.getString("HOTEL_NAME4");
						HOTEL_NO1			=  rs.getString("HOTEL_NUMBER");
						HOTEL_NO2			=  rs.getString("HOTEL_NUMBER1");
						HOTEL_NO3			=  rs.getString("HOTEL_NUMBER2");
						HOTEL_NO4			=  rs.getString("HOTEL_NUMBER3");
						HOTEL_NO5			=  rs.getString("HOTEL_NUMBER4");
						COST_CENTER			=  rs.getString("COST_CENTER");
						COST_CENTER_NAME	=  rs.getString("COST_CENTER_NAME");
						
						if(COST_CENTER==null) {
							COST_CENTER="0";
						}
						if(COST_CENTER_NAME==null || COST_CENTER_NAME.trim().equals("-")) {
							COST_CENTER_NAME="";
						}
						
						StringBuffer FULLFIRSTNAME = new StringBuffer();
						if(!FIRSTNAME.equals("") && FIRSTNAME != null) {
							FULLFIRSTNAME.append(FIRSTNAME.trim());
						}							
						if(!MIDDLENAME.equals("") && MIDDLENAME != null) {
							FULLFIRSTNAME.append(" ").append(MIDDLENAME.trim());
						}
						
						
						if(GENDER!=null) {
							if(GENDER.equals("Male")) {
								SEX = "1";
							} else {
								SEX = "2";
							}
						} else {
							SEX = "1";
						}
						
						dataMap = new HashMap<String,Object>();
						dataMap.put("TRAVELLERSITEID", TRAVELLERSITEID);
						dataMap.put("SITENAME", SITENAME.trim());
						dataMap.put("TRAVELLERUSERID", TRAVELLERUSERID);
						dataMap.put("FIRSTNAME", FULLFIRSTNAME.toString());
						dataMap.put("LASTNAME", LASTNAME.trim());
						dataMap.put("DESIGNATION", DESIGNATION);
						dataMap.put("GENDER", GENDER);
						dataMap.put("EMAIL", EMAIL);
						dataMap.put("CONTACT_NUMBER", CONTACT_NUMBER);
						dataMap.put("DOB", DOB);
						dataMap.put("PASSPORT_NO", PASSPORT_NO);
						dataMap.put("FNAMEPASSPORT", FNAMEPASSPORT);
						dataMap.put("LNAMEPASSPORT", LNAMEPASSPORT);
						dataMap.put("NATIONALITY", NATIONALITY);
						dataMap.put("PASSPORT_ISSUE_COUNTRY", PASSPORT_ISSUE_COUNTRY);
						dataMap.put("PLACE_ISSUE", PLACE_ISSUE);
						dataMap.put("DATE_ISSUE", DATE_ISSUE);
						dataMap.put("EXPIRY_DATE", EXPIRY_DATE);
						dataMap.put("ADDRESS", ADDRESS);
						dataMap.put("CURRENT_ADDRESS", CURRENT_ADDRESS);
						dataMap.put("AIRLINE_NAME1", AIRLINE_NAME1);
						dataMap.put("AIRLINE_NAME2", AIRLINE_NAME2);
						dataMap.put("AIRLINE_NAME3", AIRLINE_NAME3);
						dataMap.put("AIRLINE_NAME4", AIRLINE_NAME4);
						dataMap.put("AIRLINE_NAME5", AIRLINE_NAME5);
						dataMap.put("AIRLINE_NO1", AIRLINE_NO1);
						dataMap.put("AIRLINE_NO2", AIRLINE_NO2);
						dataMap.put("AIRLINE_NO3", AIRLINE_NO3);
						dataMap.put("AIRLINE_NO4", AIRLINE_NO4);
						dataMap.put("AIRLINE_NO5", AIRLINE_NO5);
						dataMap.put("HOTEL_NAME1", HOTEL_NAME1);
						dataMap.put("HOTEL_NAME2", HOTEL_NAME2);
						dataMap.put("HOTEL_NAME3", HOTEL_NAME3);
						dataMap.put("HOTEL_NAME4", HOTEL_NAME4);
						dataMap.put("HOTEL_NAME5", HOTEL_NAME5);
						dataMap.put("HOTEL_NO1", HOTEL_NO1);
						dataMap.put("HOTEL_NO2", HOTEL_NO2);
						dataMap.put("HOTEL_NO3", HOTEL_NO3);
						dataMap.put("HOTEL_NO4", HOTEL_NO4);
						dataMap.put("HOTEL_NO5", HOTEL_NO5);
						dataMap.put("COST_CENTER", COST_CENTER);	
						dataMap.put("SEX", SEX);
					}	
					rs.close();
					

					String strShowflagFromDB = dao.getCostCentreFlag(strSiteId);
					if(strShowflagFromDB!=null){
						strShowflag = strShowflagFromDB;
					}
				    
//				    if(strShowflag.equalsIgnoreCase("n")) {
//						COST_CENTER_NAME = "Not Applicable";
//					}
				    
				    dataMap.put("COST_CENTER_NAME", COST_CENTER_NAME);				    
				    dataMap.put("SHOWFLAG", strShowflag);
				    
				    
				    Map<String, String> flightClassList = new LinkedHashMap<String, String>();
				    flightClassList = dao.getFlightClassList("2", strUserId, strTravelType, strGroupTravelFlag);
				    
				    Set<Entry<String, String>> entrySet =  flightClassList.entrySet();
				    Iterator<Entry<String, String>> it = entrySet.iterator();
				    
				    while(it.hasNext()) {
						Entry<String, String> entry = it.next();
						if(entry.getKey().equals("24")) {
							strTrvClsFltHtml.append("<option value='"+entry.getKey()+ "' selected>"+entry.getValue()+"</option>");	
						} else {
							strTrvClsFltHtml.append("<option value='"+entry.getKey()+ "'>"+entry.getValue()+"</option>");	
						}
						
					}
				    
				    dataMap.put("trvClassFltHtml", strTrvClsFltHtml.toString());
				    
				    JSONObject jsObj = new JSONObject(dataMap);		
				    response.getWriter().print(jsObj);	
				    
				} else if("quickTravelRequestGmbhCarTimeList".equalsIgnoreCase(strReqPageqtr)) {
					
					String location 	= 	(request.getParameter("carLocation") == null) ? "1":request.getParameter("carLocation");
					
					List<String> excludeCarTimeList = new ArrayList<String>();
					excludeCarTimeList.add("1");
				    excludeCarTimeList.add("102");
				    
					Map<String, String> preferredTimeList = new LinkedHashMap<String, String>();
					preferredTimeList = dao.getPreferredTimeList();
					
					Set<Entry<String, String>> entrySet =  preferredTimeList.entrySet();
				    Iterator<Entry<String, String>> it = entrySet.iterator();
				    
				    if("1".equals(location)) {
						strCarTimeListHtml.append("<option value='-1'>"+LableMst.getLabel("label.createrequest.selectTime", strLanguage1)+"</option>");
				    } else {
						strCarTimeListHtml.append("<option value='-1' selected>"+LableMst.getLabel("label.createrequest.selectTime", strLanguage1)+"</option>");	
				    }
				    
				    while(it.hasNext()) {
						Entry<String, String> entry = it.next();
						if("1".equals(location)) {					
								if(entry.getKey().equals("102")) {
									strCarTimeListHtml.append("<option value='"+entry.getKey()+ "' selected>"+entry.getValue()+"</option>");	
								} else if(entry.getKey().equals("1")) {
										
								} else {
									strCarTimeListHtml.append("<option value='"+entry.getKey()+ "'>"+entry.getValue()+"</option>");	
								}							
						} else {
							if(!excludeCarTimeList.contains(entry.getKey())) {
								strCarTimeListHtml.append("<option value='"+entry.getKey()+ "'>"+entry.getValue()+"</option>");	
							}
						}
					}
				    dataMap.put("carTimeListHtml", strCarTimeListHtml.toString());
				  
				    JSONObject jsObj = new JSONObject(dataMap);		
				    response.getWriter().print(jsObj);
				}
		 } catch (SQLException e) {
				e.printStackTrace();
		}		
	}	
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String workFlow = req.getParameter("workflow");
		
		if(workFlow != null && workFlow.equals("TRAVELER_LAST_TRAVEL_DETAIL")){
			String travelerId = req.getParameter("travelerId");
			String travelType = req.getParameter("travelType");
			Map<String ,Object> dataMap = new HashMap<String,Object>();	
			dataMap.put("LAST__TRAVEL_DETAIL", new T_QuicktravelRequestDaoImpl().getTravellerLastTravelDetail(travelerId, travelType));
			JSONObject jsObj = new JSONObject(dataMap);		
			resp.getWriter().print(jsObj);	
		}
		
		
	}
}
