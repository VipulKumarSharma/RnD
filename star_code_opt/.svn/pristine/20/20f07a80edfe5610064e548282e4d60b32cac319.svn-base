import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import src.connection.DbConnectionBean;
import src.connection.LabelRepository;

/**
 * Servlet implementation class QuickTravelRequestServlet
 */
public class QuickTravelRequestServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	LabelRepository LableMst=new LabelRepository();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public QuickTravelRequestServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=UTF-8");
		
		DbConnectionBean objCon=new DbConnectionBean();
		ResultSet rs, rs1, rs2, rs3, rs4, rs5, rs6, rs7, rs8 = null;
		
		String  strSql ="", strSqlPrefSeat ="", strSqlAppLvl1 ="" , strSqlAppLvl2 ="" , strSqlAppLvl3 ="", strSqlBillSite ="", strSqlBillUser ="";
		  
		String strReqPageqtr 				= (request.getParameter("reqpage") == null) ? "":request.getParameter("reqpage");
		String strSuserId					= (request.getParameter("suserId") == null) ? "":request.getParameter("suserId");
		String strUserId					= (request.getParameter("userId") == null) ? "":request.getParameter("userId");
		String strSiteId 					= (request.getParameter("siteId") == null) ? "":request.getParameter("siteId");		
		String strSuserRole					= (request.getParameter("suserRole") == null) ? "":request.getParameter("suserRole");
		String strLanguage1					= (request.getParameter("language1") == null) ? "":request.getParameter("language1");
		String strDepartMode 				= (request.getParameter("departMode") == null) ? "":request.getParameter("departMode");
		String strTravelTypeRd 				= (request.getParameter("travelTypeRd") == null) ? "":request.getParameter("travelTypeRd");
		String strSiteIdBillSMGUser 		= (request.getParameter("siteIdBillSMGUser") == null) ? "":request.getParameter("siteIdBillSMGUser");
		String strSSflage               	= (request.getParameter("ssflage") == null) ? "":request.getParameter("ssflage");
		String strAppLvl3flg				= (request.getParameter("appLvl3flg") == null) ? "":request.getParameter("appLvl3flg");
		String strSuserRoleOther 			= (request.getParameter("suserRoleOther") == null) ? "":request.getParameter("suserRoleOther");
		String strGroupReqFlag 				= (request.getParameter("groupReqFlag") == null) ? "":request.getParameter("groupReqFlag");
		String strCarClassType 				= (request.getParameter("carClassType") == null) ? "":request.getParameter("carClassType");
		String strTravelId				    = (request.getParameter("travelId") == null) ? "":request.getParameter("travelId");
		
		StringBuilder strTrvClsHtml 		= new StringBuilder();
		StringBuilder strPrefSeatHtml 		= new StringBuilder();
		StringBuilder strAppLvl1Html 		= new StringBuilder();	
		StringBuilder strAppLvl2Html 		= new StringBuilder();
		StringBuilder strAppLvl3Html 		= new StringBuilder(); 
		StringBuilder strBillSiteHtml 		= new StringBuilder(); 
		StringBuilder strBillUserHtml 		= new StringBuilder();
		StringBuilder strTravellerHtml 		= new StringBuilder();
		StringBuilder strCancelledReqHtml 	= new StringBuilder();
		StringBuilder strCarCategoryHtml 	= new StringBuilder();
		
		String strManagerSelected 			= "";
		String strHodSelected 				= "";
		String strBoardMemberSelected 		= "";	
		String strFlag 						= "";
		String strShowCancelledRegflag 		= "n";
		String strTravelRequestStatus 		= "6";
		 
		HashMap<String,String> dataMap = new HashMap<String,String>();	
		ArrayList<HashMap<String, String>> dataList = new ArrayList<HashMap<String, String>>();
		
		try {			
			if(!strDepartMode.equals("") && strDepartMode != null && strReqPageqtr.equalsIgnoreCase("quickTravelReqClassName")) {
				strSql =   "SELECT CLASS_ID,ELIGIBILITY from dbo.M_MODE_CLASS mmc WHERE mmc.MODE_ID='"+strDepartMode+"' AND mmc.TRAVEL_AGENCY_ID = 1 AND mmc.STATUS_ID=10 ORDER BY CLASS_ID";
		   		rs = objCon.executeQuery(strSql);        	
		   		
					while(rs.next()) {					
						strTrvClsHtml.append("<option value='"+rs.getString(1)+ "'>"+rs.getString(2)+"</option>");					
						}
					rs.close();
				
				strSqlPrefSeat =   "SELECT seat_id, Seat_Name FROM M_SEAT_PREFER (NOLOCK) WHERE (MODE_ID = '"+strDepartMode+"') AND (TRAVEL_AGENCY_ID = 1) AND (STATUS_ID = 10) ORDER BY SEAT_ID";
				rs1 = objCon.executeQuery(strSqlPrefSeat);        	
		   		
					while(rs1.next()) {					
						strPrefSeatHtml.append("<option value='"+rs1.getString(1)+ "'>"+rs1.getString(2)+"</option>");					
						}
					rs1.close();
				
				
					dataMap = new HashMap<String,String>();						
					dataMap.put("trvClassHtml", strTrvClsHtml.toString());
					dataMap.put("prefSeatHtml", strPrefSeatHtml.toString());
							     	
		     	JSONObject jsObj = new JSONObject(dataMap);		
				response.getWriter().print(jsObj);	
				
			 } else if(!strSiteId.equals("") && strSiteId != null && strReqPageqtr.equalsIgnoreCase("quickTravelReqApprLvl")) {
			 	if(strTravelTypeRd.equals("D")) {
			 		strSql = "SELECT TOP 1 ISNULL(MANAGER_ID,'') AS MANAGER_ID, ISNULL(HOD_ID,'') AS HOD_ID, ISNULL(BOARD_MEMBER_ID,'') AS BOARD_MEMBER_ID FROM T_TRAVEL_DETAIL_DOM INNER JOIN T_TRAVEL_STATUS ON T_TRAVEL_DETAIL_DOM.TRAVEL_ID=T_TRAVEL_STATUS.TRAVEL_ID AND TRAVEL_TYPE='D' AND T_TRAVEL_STATUS.TRAVEL_STATUS_ID = 10 WHERE TRAVELLER_ID = "+strUserId+" ORDER BY C_DATETIME DESC";			   		
			 	} else if(strTravelTypeRd.equals("I")){
			 		strSql = "SELECT TOP 1 ISNULL(MANAGER_ID,'') AS MANAGER_ID, ISNULL(HOD_ID,'') AS HOD_ID, ISNULL(BOARD_MEMBER_ID,'') AS BOARD_MEMBER_ID FROM T_TRAVEL_DETAIL_INT INNER JOIN T_TRAVEL_STATUS ON T_TRAVEL_DETAIL_INT.TRAVEL_ID=T_TRAVEL_STATUS.TRAVEL_ID AND TRAVEL_TYPE='I' AND T_TRAVEL_STATUS.TRAVEL_STATUS_ID = 10 WHERE TRAVELLER_ID = "+strUserId+" ORDER BY C_DATETIME DESC";
			 	}		
			 	
			 	rs   =  objCon.executeQuery(strSql); 
                if(rs.next()) {
               	 strManagerSelected = rs.getString("MANAGER_ID");
               	 strHodSelected = rs.getString("HOD_ID");
               	 strBoardMemberSelected = rs.getString("BOARD_MEMBER_ID");
                }
                rs.close();    
                
                String strLoginId = (request.getParameter("sloginId") == null) ? "":request.getParameter("sloginId");
                if(strLoginId.equals(strUserId))
                	strSqlAppLvl1 =   "Select USERID, dbo.user_name(USERID) AS PM FROM M_USERINFO (NOLOCK) WHERE APPROVER_LEVEL=1 AND SITE_ID="+strSiteId+" AND USERID<>"+strUserId+" AND STATUS_ID=10 AND APPLICATION_ID=1 UNION SELECT UAM.USERID,dbo.user_name(UAM.USERID) AS PM  FROM USER_MULTIPLE_ACCESS UAM WHERE UAM.USERID<>"+strUserId+" AND SITE_ID="+strSiteId+" AND UAM.USERID<>"+strUserId+" AND APPROVAL_LVL1='Y' AND STATUS_ID=10 ORDER BY 2";
                else
                	strSqlAppLvl1 =   "Select USERID, dbo.user_name(USERID) AS PM FROM M_USERINFO (NOLOCK) WHERE APPROVER_LEVEL=1 AND SITE_ID="+strSiteId+" AND STATUS_ID=10 AND APPLICATION_ID=1 UNION SELECT UAM.USERID,dbo.user_name(UAM.USERID) AS PM  FROM USER_MULTIPLE_ACCESS UAM WHERE SITE_ID="+strSiteId+" AND APPROVAL_LVL1='Y' AND STATUS_ID=10 ORDER BY 2";
		   		
                rs2 = objCon.executeQuery(strSqlAppLvl1);        	
		   		strAppLvl1Html.append("<option value='S'>"+LableMst.getLabel("label.createrequest.selectapprovallevel1", strLanguage1)+"</option>");
					while(rs2.next()) {						 
						if(!strSiteId.equals("0") && !strManagerSelected.equals("") && strManagerSelected != null && strManagerSelected.equals(rs2.getString(1))) {
							strAppLvl1Html.append("<option value='"+rs2.getString(1)+ "' selected>"+rs2.getString(2)+"</option>");
						} else {
							strAppLvl1Html.append("<option value='"+rs2.getString(1)+ "'>"+rs2.getString(2)+"</option>");
						}						
					}
					rs2.close();
					
					dataMap = new HashMap<String,String>();						
					dataMap.put("aprLvl1Html", strAppLvl1Html.toString());
					dataList.add(dataMap);	
					
				if(strLoginId.equals(strUserId))	 
					strSqlAppLvl2 =   "Select USERID, dbo.user_name(USERID) AS HOD FROM M_USERINFO (NOLOCK) WHERE ((APPROVER_LEVEL=2 AND SITE_ID="+strSiteId+") or (APPROVER_LEVEL=3)) AND USERID<>"+strUserId+" AND STATUS_ID=10 AND APPLICATION_ID=1 UNION SELECT UAM.USERID,dbo.user_name(UAM.USERID) AS PM  FROM USER_MULTIPLE_ACCESS UAM WHERE UAM.USERID<>"+strUserId+" AND SITE_ID="+strSiteId+" AND APPROVAL_LVL2='Y' AND STATUS_ID=10 ORDER BY 2";
				else
					strSqlAppLvl2 =   "Select USERID, dbo.user_name(USERID) AS HOD FROM M_USERINFO (NOLOCK) WHERE ((APPROVER_LEVEL=2 AND SITE_ID="+strSiteId+") or (APPROVER_LEVEL=3)) AND STATUS_ID=10 AND APPLICATION_ID=1 UNION SELECT UAM.USERID,dbo.user_name(UAM.USERID) AS PM  FROM USER_MULTIPLE_ACCESS UAM WHERE SITE_ID="+strSiteId+" AND APPROVAL_LVL2='Y' AND STATUS_ID=10 ORDER BY 2";
			   	
				rs3 = objCon.executeQuery(strSqlAppLvl2);        	
			   	strAppLvl2Html.append("<option value='S'>"+LableMst.getLabel("label.createrequest.selectapprovallevel2", strLanguage1)+"</option>");
					while(rs3.next()) {							 
						if(!strSiteId.equals("0") && !strHodSelected.equals("") && strHodSelected != null && strHodSelected.equals(rs3.getString(1))) {
							strAppLvl2Html.append("<option value='"+rs3.getString(1)+ "' selected>"+rs3.getString(2)+"</option>");
						} else {
							strAppLvl2Html.append("<option value='"+rs3.getString(1)+ "'>"+rs3.getString(2)+"</option>");
						}						
					}
					rs3.close(); 
					
					dataMap = new HashMap<String,String>();						
					dataMap.put("aprLvl2Html", strAppLvl2Html.toString());
					dataList.add(dataMap);					
						 
				strSqlAppLvl3 =   "SELECT USERID, DBO.user_name(USERID) AS BM FROM M_BOARD_MEMBER WHERE M_BOARD_MEMBER.USERID<>"+strUserId+" AND M_BOARD_MEMBER.SITE_ID="+strSiteId+" AND M_BOARD_MEMBER.STATUS_ID=10";
				rs4 = objCon.executeQuery(strSqlAppLvl3);        	
				strAppLvl3Html.append("<option value='B'>"+LableMst.getLabel("label.createrequest.selectboardmember", strLanguage1)+"</option>");
				if(strTravelTypeRd.equals("D")) {
					strAppLvl3Html.append("<option value='-2'>"+LableMst.getLabel("label.global.notapplicable", strLanguage1)+"</option>");					
				}
					while(rs4.next()) {								 
						if(!strSiteId.equals("0") && !strBoardMemberSelected.equals("") && strBoardMemberSelected != null && strBoardMemberSelected.equals(rs4.getString(1))) {
							strAppLvl3Html.append("<option value='"+rs4.getString(1)+ "' selected>"+rs4.getString(2)+"</option>");
						} else {
							strAppLvl3Html.append("<option value='"+rs4.getString(1)+ "'>"+rs4.getString(2)+"</option>");
						}						
					}
					rs4.close();
					
					dataMap = new HashMap<String,String>();						
					dataMap.put("aprLvl3Html", strAppLvl3Html.toString());
					dataList.add(dataMap);					
					
				strSqlBillSite = "SELECT SITE_ID,DBO.SITENAME(SITE_ID) AS SITE_NAME FROM M_SITE WHERE STATUS_ID=10 AND APPLICATION_ID=1 AND (M_SITE.CLOSED_UNIT_FLAG is null or M_SITE.CLOSED_UNIT_FLAG='') ORDER BY 2";
				rs5 = objCon.executeQuery(strSqlBillSite); 
				
					while(rs5.next()) {
						if(!strSiteId.equals("") && strSiteId != null && strSiteId.equals(rs5.getString(1))) {
							strBillSiteHtml.append("<option value='"+rs5.getString(1)+ "' selected>"+rs5.getString(2)+"</option>");
						} else {
							strBillSiteHtml.append("<option value='"+rs5.getString(1)+ "'>"+rs5.getString(2)+"</option>");
						}						
					}
					rs5.close(); 
					
					dataMap = new HashMap<String,String>();						
					dataMap.put("billSiteHtml", strBillSiteHtml.toString());
					dataList.add(dataMap);					
				
				JSONArray jsArray = new JSONArray(dataList);		
				response.getWriter().print(jsArray);
				
			 } else if(!strSiteId.equals("") && strSiteId != null && strReqPageqtr.equalsIgnoreCase("quickTravelReqBillSMGUser")) {
				 
				 strSql = "SELECT 1 AS yes FROM USER_SITE_ACCESS WHERE (USERID = "+strUserId+") AND (SITE_ID = "+strSiteIdBillSMGUser+") AND USER_SITE_ACCESS.STATUS_ID=10";
				 rs = objCon.executeQuery(strSql); 
				 while (rs.next()) {
						strFlag = rs.getString(1);
					}
				rs.close();
				
				 if(strSiteIdBillSMGUser.equals(strSiteId) || "1".equals(strFlag)) {					 
					 strBillUserHtml.append("<option  value='-1'>"+LableMst.getLabel("label.createrequest.userfrombillingunit", strLanguage1)+"</option>");						 
				 } else if(!strSiteIdBillSMGUser.equals(strSiteId)) {
					    strBillUserHtml.append("<option  value='-1'>"+LableMst.getLabel("label.createrequest.userfrombillingunit", strLanguage1)+"</option>");
					 	strSql =   "SELECT 1 FROM M_BILLING_APPROVER BA inner join M_userInfo UI on UI.userid = BA.approver_id WHERE BA.SITE_ID= "+ strSiteIdBillSMGUser +" and status_id =10";
			   			rs = objCon.executeQuery(strSql); 
			   			if (!rs.next()) {
							rs.close();
							strSqlBillUser = "select distinct userid, dbo.user_name(userid) As UserName from M_userInfo "
										+ "where (site_id="
										+ strSiteIdBillSMGUser
										+ " and status_id=10 and  ISNULL(APPROVER_LEVEL,0) in (1,2) )"
										+ "or (status_id=10 and  ISNULL(APPROVER_LEVEL,0) in (3) )"
										+ "order by 2";
							rs6 = objCon.executeQuery(strSqlBillUser);
							while (rs6.next()) {
								strBillUserHtml.append("<option value='"+rs6.getString("UserId")+ "'>"+rs6.getString("UserName")+"</option>");
							}
							rs6.close(); 
			   			} else {
			   				strSqlBillUser = "SELECT distinct APPROVER_ID as userid, dbo.user_name(APPROVER_ID) As UserName "
										+ "FROM M_BILLING_APPROVER BA inner join M_userInfo UI on UI.userid = BA.approver_id "
										+ "WHERE BA.SITE_ID= "
										+ strSiteIdBillSMGUser
										+ " and status_id =10";
			   				rs6 = objCon.executeQuery(strSqlBillUser);
							while (rs6.next()) {
								strBillUserHtml.append("<option value='"+rs6.getString("UserId")+ "'>"+rs6.getString("UserName")+"</option>");
							}
							rs6.close(); 
			   			}					
				 }
				 
				
					
				dataMap = new HashMap<String,String>();						
				dataMap.put("billUserHtml", strBillUserHtml.toString());
				dataMap.put("multiSiteAccessFlag", strFlag);
				
		     	JSONObject jsObj = new JSONObject(dataMap);		
				response.getWriter().print(jsObj);
				 
			 } else if(!strSiteId.equals("") && strSiteId != null && strReqPageqtr.equalsIgnoreCase("quickTravelReqTravellers")) {
				 
				 if(!strSSflage.equals("") && !strAppLvl3flg.equalsIgnoreCase("") && strSSflage.equals("1") && strAppLvl3flg.equalsIgnoreCase("N")){
						if(strSuserRoleOther.equals("LA")) {
						 strSql=" SELECT     USERID, DBO.USER_NAME(USERID) AS USERNAME "+
						 "FROM         M_USERINFO WITH (NOLOCK) WHERE     (SITE_ID = "+strSiteId+") AND (STATUS_ID = 10) AND (APPLICATION_ID = 1) "+
						 " UNION SELECT USERID,DBO.USER_NAME(USERID) AS USERNAME "+
						 " FROM USER_MULTIPLE_ACCESS WHERE (SITE_ID = "+strSiteId+") AND (STATUS_ID = 10) ORDER BY USERNAME";
						} else {
							strSql =   "select userid, dbo.user_name(userid) As UserName from M_userInfo (NOLOCK) where userid="+strSuserId+" and status_id=10 and application_id=1 order by 2";
						} 
						
					} else {
						 strSql=" SELECT     USERID, DBO.USER_NAME(USERID) AS USERNAME "+
						 "FROM         M_USERINFO WITH (NOLOCK) WHERE     (SITE_ID = "+strSiteId+") AND (STATUS_ID = 10) AND (APPLICATION_ID = 1) "+
						 " UNION SELECT USERID,DBO.USER_NAME(USERID) AS USERNAME "+
						 " FROM USER_MULTIPLE_ACCESS WHERE (SITE_ID = "+strSiteId+") AND (USER_MULTIPLE_ACCESS.ROLE_ID='LA' OR  USER_MULTIPLE_ACCESS.UNIT_HEAD=1) AND (STATUS_ID = 10) ORDER BY USERNAME";
					}
				 
                  	rs =   objCon.executeQuery(strSql);  
                  	
                  	strTravellerHtml.append("<option  value='-1' selected>"+LableMst.getLabel("label.createrequest.travellername", strLanguage1)+"</option>");						 
                  while(rs.next()) {
                	  strTravellerHtml.append("<option value='"+rs.getString("UserId")+ "'>"+rs.getString("UserName")+"</option>");
				  }				 
                  rs.close();
                  
                  dataMap = new HashMap<String,String>();						
  				  dataMap.put("travellerHtml", strTravellerHtml.toString());									  
  				
  		     	  JSONObject jsObj = new JSONObject(dataMap);		
  				  response.getWriter().print(jsObj);
  				  
			 } else if(!strUserId.equals("") && strUserId != null && !strGroupReqFlag.equals("") && strGroupReqFlag != null && strReqPageqtr.equalsIgnoreCase("quickTravelReqCancelledRequest")) {
				 if(strTravelTypeRd.equals("D")) {
					 strSql = " SELECT TD.TRAVEL_ID,TD.TRAVEL_REQ_NO,TS.TRAVEL_STATUS_ID FROM T_TRAVEL_STATUS TS INNER JOIN T_TRAVEL_DETAIL_DOM TD ON TS.TRAVEL_ID=TD.TRAVEL_ID "+
							 " WHERE TS.TRAVEL_TYPE='D' AND TS.TRAVEL_STATUS_ID =6 AND TS.STATUS_ID=10 AND (TD.TRAVELLER_ID="+strUserId+" OR TD.C_USERID="+strUserId+") "+ 
							 " AND (CONVERT(DATE,TD.C_DATETIME) BETWEEN CONVERT(DATE,DATEADD(DD,-30,GETDATE())) AND CONVERT(DATE,GETDATE()) OR  TD.TRAVEL_DATE BETWEEN CONVERT(DATE,DATEADD(DD,-30,GETDATE())) AND CONVERT(DATE,GETDATE())) AND TD.Group_Travel_Flag='"+strGroupReqFlag+"' "+  
							 " UNION "+  
							 " SELECT TD.TRAVEL_ID,TD.TRAVEL_REQ_NO,TS.TRAVEL_STATUS_ID FROM T_TRAVEL_STATUS TS INNER JOIN T_TRAVEL_DETAIL_DOM TD ON TS.TRAVEL_ID=TD.TRAVEL_ID "+   
							 " INNER JOIN (SELECT TRAVEL_ID,TJDI.JOURNEY_ORDER,TRAVEL_DATE FROM T_JOURNEY_DETAILS_DOM TJDI WHERE STATUS_ID=10 "+
							 " UNION "+
							 " SELECT TRAVEL_ID,9999,TRAVEL_DATE FROM T_RET_JOURNEY_DETAILS_DOM WHERE STATUS_ID=10 AND YEAR(TRAVEL_DATE)<>1900 AND TRAVEL_DATE IS NOT NULL)DRV ON TD.TRAVEL_ID=DRV.TRAVEL_ID "+
							 " WHERE TS.TRAVEL_TYPE='D' AND TS.TRAVEL_STATUS_ID =10 AND TS.STATUS_ID=10 AND (TD.TRAVELLER_ID="+strUserId+" OR TD.C_USERID="+strUserId+") AND TD.Group_Travel_Flag='"+strGroupReqFlag+"' "+  
							 " GROUP BY TD.TRAVEL_ID,TD.TRAVEL_REQ_NO,TS.TRAVEL_STATUS_ID HAVING CONVERT(DATE,GETDATE()) BETWEEN MIN(DRV.TRAVEL_DATE) AND MAX(DRV.TRAVEL_DATE) ";
				 } else if(strTravelTypeRd.equals("I")) {
					 strSql = " SELECT TD.TRAVEL_ID,TD.TRAVEL_REQ_NO,TS.TRAVEL_STATUS_ID FROM T_TRAVEL_STATUS TS INNER JOIN T_TRAVEL_DETAIL_INT TD ON TS.TRAVEL_ID=TD.TRAVEL_ID "+
							 " WHERE TS.TRAVEL_TYPE='I' AND TS.TRAVEL_STATUS_ID =6 AND TS.STATUS_ID=10 AND (TD.TRAVELLER_ID="+strUserId+" OR TD.C_USERID="+strUserId+") "+ 
							 " AND (CONVERT(DATE,TD.C_DATETIME) BETWEEN CONVERT(DATE,DATEADD(DD,-30,GETDATE())) AND CONVERT(DATE,GETDATE()) OR  TD.TRAVEL_DATE BETWEEN CONVERT(DATE,DATEADD(DD,-30,GETDATE())) AND CONVERT(DATE,GETDATE())) AND TD.Group_Travel_Flag='"+strGroupReqFlag+"' "+  
							 " UNION "+  
							 " SELECT TD.TRAVEL_ID,TD.TRAVEL_REQ_NO,TS.TRAVEL_STATUS_ID FROM T_TRAVEL_STATUS TS INNER JOIN T_TRAVEL_DETAIL_INT TD ON TS.TRAVEL_ID=TD.TRAVEL_ID "+   
							 " INNER JOIN (SELECT TRAVEL_ID,TJDI.JOURNEY_ORDER,TRAVEL_DATE FROM T_JOURNEY_DETAILS_INT TJDI WHERE STATUS_ID=10 "+
							 " UNION "+
							 " SELECT TRAVEL_ID,9999,TRAVEL_DATE FROM T_RET_JOURNEY_DETAILS_INT WHERE YEAR(TRAVEL_DATE)<>1900 AND TRAVEL_DATE IS NOT NULL)DRV ON TD.TRAVEL_ID=DRV.TRAVEL_ID "+
							 " WHERE TS.TRAVEL_TYPE='I' AND TS.TRAVEL_STATUS_ID =10 AND TS.STATUS_ID=10 AND (TD.TRAVELLER_ID="+strUserId+" OR TD.C_USERID="+strUserId+") AND TD.Group_Travel_Flag='"+strGroupReqFlag+"' "+  
							 " GROUP BY TD.TRAVEL_ID,TD.TRAVEL_REQ_NO,TS.TRAVEL_STATUS_ID HAVING CONVERT(DATE,GETDATE()) BETWEEN MIN(DRV.TRAVEL_DATE) AND MAX(DRV.TRAVEL_DATE) "; 
				 }
					 
				 rs = objCon.executeQuery(strSql);
				 strCancelledReqHtml.append("<option value='0'>"+LableMst.getLabel("label.global.selectcancelledrequest", strLanguage1)+"</option>");
				 while(rs.next()) {	
					strShowCancelledRegflag = "y";
					
					if("6".equals(rs.getString("TRAVEL_STATUS_ID"))) {
						strCancelledReqHtml.append("<option value='"+rs.getString("TRAVEL_ID")+ "'>"+rs.getString("TRAVEL_REQ_NO")+"-("+LableMst.getLabel("label.requestdetails.cancelled", strLanguage1)+")</option>");
					} else if("10".equals(rs.getString("TRAVEL_STATUS_ID"))) {
						strCancelledReqHtml.append("<option value='"+rs.getString("TRAVEL_ID")+ "'>"+rs.getString("TRAVEL_REQ_NO")+"-("+LableMst.getLabel("label.requestdetails.onair", strLanguage1)+")</option>");
					}
				}
				rs.close(); 
				
				dataMap = new HashMap<String,String>();						
				dataMap.put("showCancelledRegflag", strShowCancelledRegflag);
				dataMap.put("cancelledReqHtml", strCancelledReqHtml.toString());
				
		     	JSONObject jsObj = new JSONObject(dataMap);		
				response.getWriter().print(jsObj);
					
			 } else if(!strUserId.equals("") && strUserId != null && strReqPageqtr.equalsIgnoreCase("quickTravelReqPersonalDetail")) {

					String FIRSTNAME			=  "";
					String MIDDLENAME			=  "";
					String LASTNAME				=  "";
					String DESIGNATION			=  "";
					String GENDER				=  "";
					String EMAIL				=  "";
					String CONTACT_NUMBER		=  "";
					String DOB					=  "";
					String ECNR					=  "";
					String ADDRESS				=  "";
					String CURRENT_ADDRESS		=  "";
					String IDENTITY_PROOF		=  "";
					String IDENTITY_PROOF_NO	=  "";
					String NOMINEE				=  "";
					String RELATION				=  "";
					String PASSPORT_NO			=  "";
					String NATIONALITY			=  "";
					String PASSPORT_ISSUE_COUNTRY   =  "";
					String PLACE_ISSUE			=  "";	
					String DATE_ISSUE			=  "";		
					String EXPIRY_DATE			=  "";	
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
					String SEX					=  "";
									
					strSql="SELECT FIRSTNAME, LASTNAME, ISNULL(MIDDLENAME ,'') AS MIDDLENAME, LTRIM(RTRIM(EMAIL)) AS" 
							+ " EMAIL, ISNULL(CONTACT_NUMBER,'') AS CONTACT_NUMBER, ISNULL(ECNR,'') AS ECNR, ISNULL(ADDRESS,'') AS" 
							+ " ADDRESS, ISNULL(CURRENT_ADDRESS,'') AS CURRENT_ADDRESS, ISNULL(IDENTITY_ID,-1) AS IDENTITY_ID," 
							+ " ISNULL(IDENTITY_NO,'') AS IDENTITY_NO, LTRIM(RTRIM(ISNULL(PASSPORT_NO,''))) AS PASSPORT_NO, ISNULL(PASSPORT_ISSUE_COUNTRY,'0') AS PASSPORT_ISSUE_COUNTRY, ISNULL(NATIONALITY ,'') AS NATIONALITY, "
							+ " ISNULL(PLACE_ISSUE,'') AS PLACE_ISSUE, ISNULL(.DBO.CONVERTDATEDMY1(DATE_ISSUE),'') AS DATE_ISSUE," 
							+ " ISNULL(.DBO.CONVERTDATEDMY1(EXPIRY_DATE),'') AS EXPIRY_DATE, ISNULL(dbo.DESIGNATIONNAME(DESIG_ID),'') AS DESIG,"
							+ " ISNULL(.DBO.CONVERTDATEDMY1(DOB),'') AS DOB, GENDER AS GENDER, ISNULL(FF_AIR_NAME,'') AS FF_AIR_NAME," 
							+ " ISNULL(FF_AIR_NAME1,'') AS FF_AIR_NAME1, ISNULL(FF_AIR_NAME2,'') AS FF_AIR_NAME2, ISNULL(FF_AIR_NAME3,'') AS FF_AIR_NAME3,"
							+ " ISNULL(FF_AIR_NAME4,'') AS FF_AIR_NAME4, ISNULL(FF_NUMBER,'') AS FF_NUMBER, ISNULL(FF_NUMBER1,'') AS FF_NUMBER1,"
							+ " ISNULL(FF_NUMBER2,'') AS FF_NUMBER2, ISNULL(FF_NUMBER3,'') AS FF_NUMBER3, ISNULL(FF_NUMBER4,'') AS FF_NUMBER4,"
							+ " ISNULL(HOTEL_NAME,'') AS HOTEL_NAME, ISNULL(HOTEL_NAME1,'') AS HOTEL_NAME1, ISNULL(HOTEL_NAME2,'') AS HOTEL_NAME2,"
							+ " ISNULL(HOTEL_NAME3,'') AS HOTEL_NAME3, ISNULL(HOTEL_NAME4,'') AS HOTEL_NAME4, ISNULL(HOTEL_NUMBER,'') AS HOTEL_NUMBER,"
							+ " ISNULL(HOTEL_NUMBER1,'') AS HOTEL_NUMBER1, ISNULL(HOTEL_NUMBER2,'') AS HOTEL_NUMBER2, ISNULL(HOTEL_NUMBER3,'') AS HOTEL_NUMBER3,"
							+ " ISNULL(HOTEL_NUMBER4,'') AS HOTEL_NUMBER4 FROM M_USERINFO WHERE USERID='"+strUserId+"' AND APPLICATION_ID=1";
					rs = objCon.executeQuery(strSql);
					
					if(rs.next()) {
						FIRSTNAME       	=  rs.getString("FIRSTNAME");
						MIDDLENAME			=  rs.getString("MIDDLENAME");
						LASTNAME        	=  rs.getString("LASTNAME");
						DESIGNATION			=  rs.getString("DESIG");
						GENDER				=  rs.getString("GENDER");
						EMAIL           	=  rs.getString("EMAIL");
						CONTACT_NUMBER  	=  rs.getString("CONTACT_NUMBER");
						DOB             	=  rs.getString("DOB");
						ECNR            	=  rs.getString("ECNR");
						ADDRESS         	=  rs.getString("ADDRESS");
						CURRENT_ADDRESS 	=  rs.getString("CURRENT_ADDRESS");
						IDENTITY_PROOF		=  rs.getString("IDENTITY_ID");
						IDENTITY_PROOF_NO	=  rs.getString("IDENTITY_NO");
						PASSPORT_NO        	=  rs.getString("PASSPORT_NO");
						NATIONALITY			=  rs.getString("NATIONALITY");
						PASSPORT_ISSUE_COUNTRY = rs.getString("PASSPORT_ISSUE_COUNTRY");
						PLACE_ISSUE   		=  rs.getString("PLACE_ISSUE");
						DATE_ISSUE    		=  rs.getString("DATE_ISSUE");
						EXPIRY_DATE			=  rs.getString("EXPIRY_DATE");
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
						
						StringBuffer FULLNAME = new StringBuffer();
						if(!FIRSTNAME.equals("") && FIRSTNAME != null) {
							FULLNAME.append(FIRSTNAME).append(" ");
						}							
						if(!MIDDLENAME.equals("") && MIDDLENAME != null) {
							FULLNAME.append(MIDDLENAME).append(" ");
						}
						if(!LASTNAME.equals("") && LASTNAME != null) {
							FULLNAME.append(LASTNAME);
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
						
						dataMap = new HashMap<String,String>();						
						dataMap.put("FULLNAME", FULLNAME.toString());
						dataMap.put("DESIGNATION", DESIGNATION);
						dataMap.put("GENDER", GENDER);
						dataMap.put("EMAIL", EMAIL);
						dataMap.put("CONTACT_NUMBER", CONTACT_NUMBER);
						dataMap.put("DOB", DOB);
						dataMap.put("ECNR", ECNR);
						dataMap.put("ADDRESS", ADDRESS);
						dataMap.put("CURRENT_ADDRESS", CURRENT_ADDRESS);
						dataMap.put("IDENTITY_PROOF", IDENTITY_PROOF);
						dataMap.put("IDENTITY_PROOF_NO", IDENTITY_PROOF_NO);
						dataMap.put("PASSPORT_NO", PASSPORT_NO);
						dataMap.put("NATIONALITY", NATIONALITY);
						dataMap.put("PASSPORT_ISSUE_COUNTRY", PASSPORT_ISSUE_COUNTRY);
						dataMap.put("PLACE_ISSUE", PLACE_ISSUE);
						dataMap.put("DATE_ISSUE", DATE_ISSUE);
						dataMap.put("EXPIRY_DATE", EXPIRY_DATE);
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
						dataMap.put("SEX", SEX);
					}	
					rs.close();

					//strSql="SELECT TOP 1 ISNULL(NOMINEE,'') AS NOMINEE, ISNULL(RELATION,'') AS RELATION FROM T_TRAVEL_DETAIL_INT INNER JOIN T_TRAVEL_STATUS ON T_TRAVEL_DETAIL_INT.TRAVEL_ID=T_TRAVEL_STATUS.TRAVEL_ID AND TRAVEL_TYPE='I' WHERE TRAVELLER_ID = "+strUserId+" ORDER BY C_DATETIME DESC";
					strSql="SELECT TOP 1 ISNULL(NOMINEE,'') AS NOMINEE, ISNULL(RELATION,'') AS RELATION FROM T_TRAVEL_DETAIL_INT INNER JOIN T_TRAVEL_STATUS ON T_TRAVEL_DETAIL_INT.TRAVEL_ID=T_TRAVEL_STATUS.TRAVEL_ID AND TRAVEL_TYPE='I' AND T_TRAVEL_STATUS.TRAVEL_STATUS_ID = 10 WHERE TRAVELLER_ID = "+strUserId+" ORDER BY C_DATETIME DESC";		
					rs = objCon.executeQuery(strSql);
							if(rs.next()) {
								NOMINEE = rs.getString("NOMINEE");
								RELATION = rs.getString("RELATION");
								dataMap.put("NOMINEE", NOMINEE);
								dataMap.put("RELATION", RELATION);
							}
							rs.close();
							
					   JSONObject jsObj = new JSONObject(dataMap);		
					   response.getWriter().print(jsObj);	
					   
				} else if(!strCarClassType.equals("") && strCarClassType != null && strReqPageqtr.equalsIgnoreCase("quickTravelReqCarClassCategory")) {
					strSql =   "SELECT CAR_CATEGORY_ID, CATEGORY_NAME FROM M_CAR_CATEGORY WHERE CLASS_ID = "+strCarClassType+" AND TRAVEL_TYPE = '"+strTravelTypeRd+"' AND TRAVEL_AGENCY_ID = 1 AND STATUS_ID = 10";
			   		rs7 = objCon.executeQuery(strSql);        	
			   		
						while(rs7.next()) {					
							strCarCategoryHtml.append("<option value='"+rs7.getString("CAR_CATEGORY_ID")+ "'>"+rs7.getString("CATEGORY_NAME")+"</option>");					
							}
						rs7.close();
					
						dataMap = new HashMap<String,String>();						
						dataMap.put("carCategoryHtml", strCarCategoryHtml.toString());
								     	
			     	JSONObject jsObj = new JSONObject(dataMap);		
					response.getWriter().print(jsObj);	
					
				 } else if(strTravelId != null && !strTravelId.equals("") && !strTravelTypeRd.equals("") && strReqPageqtr.equalsIgnoreCase("getTravelReqStatus")) {
						strSql =   "SELECT TRAVEL_STATUS_ID FROM T_TRAVEL_STATUS WHERE TRAVEL_ID="+strTravelId+" AND TRAVEL_TYPE='"+strTravelTypeRd+"' AND STATUS_ID=10";
						rs8 = objCon.executeQuery(strSql);        	
				   		
							if(rs8.next()) {					
								strTravelRequestStatus = rs8.getString("TRAVEL_STATUS_ID");
							}
						rs8.close();
						
						dataMap = new HashMap<String,String>();						
						dataMap.put("travelReqStatus", strTravelRequestStatus);
									     	
				     	JSONObject jsObj = new JSONObject(dataMap);		
						response.getWriter().print(jsObj);	
						
				}		 
		 } catch (SQLException e) {
				e.printStackTrace();
		}		
	}	
}
