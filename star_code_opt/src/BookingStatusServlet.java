

import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import src.connection.DbConnectionBean;

public class BookingStatusServlet extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
	
    public BookingStatusServlet() 
    {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		request.getRequestDispatcher("/BookingStatusReport.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=UTF-8");
		
		String action = request.getParameter("action");
		String siteId = request.getParameter("siteId") == null ? "0" : request.getParameter("siteId");
		
		Date currentDate = new Date();
		DateFormat format = new SimpleDateFormat("dd/MM/yyyy");
		String currntDateStr = format.format(currentDate);
		try 
		{
				String reqNo = request.getParameter("reqNo") == null ? "" : request.getParameter("reqNo");
				String travelDateStr = (request.getParameter("date") != null && !"".equals(request.getParameter("date"))) ?dateFormatter(request.getParameter("date"),"dd/MM/yyyy","yyyy-MM-dd") : dateFormatter(currntDateStr,"dd/MM/yyyy","yyyy-MM-dd") ;
				String travelType = request.getParameter("travelType") == null ? "I" : request.getParameter("travelType");
				String travellerId = request.getParameter("travellerId") == null ? "0" : request.getParameter("travellerId");
				String bookingStatus = (request.getParameter("status") == null || "".equals(request.getParameter("status"))) ? "0" : request.getParameter("status");
				String bookedBy = (request.getParameter("bookedBy") == null || "".equals(request.getParameter("bookedBy"))) ? "0" : request.getParameter("bookedBy");
				String travelStatus = (request.getParameter("travelStatus") == null || "".equals(request.getParameter("travelStatus"))) ? "10" : request.getParameter("travelStatus");
				
				HttpSession hs = request.getSession();
				String travelAgency =  (hs.getValue("isMataGmbHSite") == null && "true".equals(hs.getValue("isMataGmbHSite"))) ? "2" : "1";
				String loginUser = hs.getValue("user_id") == null ? "1" : (String)hs.getValue("user_id");
				String loginUserSite = hs.getValue("user_id") == null ? "1" : (String)hs.getValue("strSiteId");
			
			if(action.equals("load")) 
			{	
				Set<JSONObject> dataList = getBookinglist(siteId, reqNo, travelDateStr, travelType, travellerId, bookingStatus,bookedBy, travelAgency, loginUser, request, travelStatus);
				JSONArray jsArray = new JSONArray(dataList);	 
				JSONObject resultJsonObj = new JSONObject();
				resultJsonObj.put("value", jsArray);
				response.getWriter().print(resultJsonObj);
				
			}else if(action.equals("bookingStatus"))
			{
				response.getWriter().print(getBookingStatuslist());

			}else if(action.equals("bookingBy"))
			{
				response.getWriter().print(getBookingBylist(loginUserSite));

			}else if(action.equals("travellerList"))
			{
				response.getWriter().print(getTravellerlist(siteId));
				
			}else if(action.equals("update"))
			{
				response.getWriter().print(updateBookedTravelRequest(request));

			}else if(action.equals("countrylist"))
			{
				response.getWriter().print(getCountrylist());

			}else if(action.equals("airLineList"))
			{
				response.getWriter().print(getAirlinelist());

			}else
			{
				JSONObject resultJsonObj = new JSONObject();
				resultJsonObj.put("value", "success");
				response.getWriter().print(resultJsonObj);		
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (JSONException e) {
			e.printStackTrace();
		} catch (ParseException e) {
			e.printStackTrace();
		}	
		catch (Exception e) 
		{
			JSONObject resultJsonObj = new JSONObject();
			try {
				resultJsonObj.put("value", "failure");
			} catch (JSONException e1) {
				e1.printStackTrace();
			}
			response.getWriter().print(resultJsonObj);		
			e.printStackTrace();
		}	
	}
	
	private String dateFormatter(String dateStr, String fromPattern, String toPattern) throws ParseException
	{
		if(dateStr != null && !"".equals(dateStr) && !dateStr.trim().startsWith("1900") && !dateStr.trim().endsWith("1900"))
		{
			String formattedDate = null;
			DateFormat srcDf = new SimpleDateFormat(fromPattern);
			Date date = srcDf.parse(dateStr);
			DateFormat destDf = new SimpleDateFormat(toPattern);
			formattedDate = destDf.format(date);
			return formattedDate;
		}else
		{
			return "";
		}
	}
	
	private Set<JSONObject> getBookinglist(String siteId, String reqNo, String travelDateStr, String travelType
			, String travellerId, String bookingStatus, String bookedBy, String travelAgency, String loginUser
			, HttpServletRequest request,String travelStatus) 
			throws SQLException, JSONException, ParseException
	{
		PreparedStatement cStmt = null;
		Statement stmt1 		= null;
		ResultSet rs,rs1		= null;
		DbConnectionBean objCon	= new DbConnectionBean();
		Connection con			= objCon.getConnection();
		stmt1					= con.createStatement();
		
		Set<JSONObject> dataList = new LinkedHashSet<JSONObject>();
		JSONObject json = null;
		HttpSession httpsession = request.getSession(false);
		
		String traveller_id = "";
		String travel_id	= "";
		String grpTrvlFlag  = "";
		String trvlAgencyId	= "";
		String sts			= "";
		String tf 			= "";
		String vf 			= "";
		String insf 		= "";
		String accf 		= "";
		String cnclf 		= "";
		
		int index = 1;
		cStmt = con.prepareStatement("{call PROC_TRAVEL_BOOKING_LIST(?,?,?,?,?,?,?,?,?,?,?)}");
		
		cStmt.setString(index++, siteId.trim());
		cStmt.setString(index++, reqNo.trim());
		cStmt.setString(index++, travelDateStr.trim());
		cStmt.setString(index++, travelType.trim());
		cStmt.setString(index++, travellerId.trim());
		cStmt.setString(index++, bookingStatus.trim());
		cStmt.setString(index++, bookedBy.trim());
		cStmt.setString(index++, travelAgency.trim());
		cStmt.setString(index++, travelStatus.trim());
		cStmt.setString(index++, loginUser.trim());
		cStmt.setInt(index++, 0);

	//	boolean result = cStmt.execute();
		rs = cStmt.executeQuery();

		int recordCount = 1;
		while(rs.next())
		{
			travel_id	=	(String)rs.getString("travel_id");
			rs1	= stmt1.executeQuery("select TTBD.Traveller_ID,TTBD.Group_Travel_Flag,MS.TRAVEL_AGENCY_ID as TRAVEL_AGENCY_ID from T_TRAVEL_BOOKING_DETAIL TTBD INNER join M_SITE MS ON TTBD.Site_ID=MS.Site_ID where Travel_ID="+travel_id);
			if(rs1.next()) 
			{	traveller_id 	= rs1.getString("Traveller_ID");
				grpTrvlFlag 	= rs1.getString("Group_Travel_Flag").trim();
				trvlAgencyId	= rs1.getString("TRAVEL_AGENCY_ID");
			}
			rs1.close();
			
			String trvlDt 	= rs.getString("TRAVEL_DATE").substring(0, 10);
			String[] parts	= trvlDt.split("-");
			trvlDt 			= parts[2]+"/"+parts[1]+"/"+parts[0];
			
			String trvltype = rs.getString("travel_type");
			String reqNum	= rs.getString("travel_req_no").trim();
			json 			= new JSONObject();
			json.put("sNo", recordCount++);
			json.put("site_id", rs.getString("site_id"));
			json.put("traveller_id", traveller_id);
			json.put("travel_id", rs.getString("travel_id"));
			json.put("travel_type", trvltype);
			json.put("travel_req_no", reqNum);
			json.put("siteName", rs.getString("site_Name"));
			json.put("travellerName", rs.getString("travellerName"));
			json.put("MOBILE_NO", rs.getString("MOBILE_NO"));
			json.put("Travel_Date", trvlDt);
			json.put("travel_booking_id", rs.getString("travel_book_id"));
			json.put("lockFlag", rs.getBoolean("LOCK_FLAG"));
			json.put("action", "UPDATE");
			json.put("locked_by_name", rs.getString("LOCKED_BY_NAME"));
			json.put("isLocked",isLocked(rs.getString("travel_book_id").trim(), httpsession.getId()));
			json.put("grpTrvlFlag", grpTrvlFlag.toUpperCase());
			json.put("trvlAgencyId", trvlAgencyId);
			
			String tif=rs.getString("TICKET_INFO_FLAG");
			String vif=rs.getString("VISA_INFO_FLAG");
			String iif=rs.getString("INSURANCE_INFO_FLAG");
			String accif=rs.getString("ACC_INFO_FLAG");
			String cif=rs.getString("CANCEL_INFO_FLAG");
			String trvlStatus	=	rs.getString("TRAVEL_STATUS");
			
			if(tif.equalsIgnoreCase("N"))
			{	tf="";
			}
			else 
			{	if(tif.equalsIgnoreCase("Y"))
				{	tf="<font color=\"green\">TKT</font>";
				}
				else if(tif.equalsIgnoreCase("R"))
				{	tf="<font color=\"red\">TKT</font>";
				}
			}
			
			if(trvltype.equalsIgnoreCase("I")) {
				if(vif.equalsIgnoreCase("N"))
				{	vf="";
				}
				else
				{	if(tf.equalsIgnoreCase(""))
					{	if(vif.equalsIgnoreCase("Y"))
						{	vf="<font color=\"green\">VISA</font>";
						}
						else if(vif.equalsIgnoreCase("R"))
						{	vf="<font color=\"red\">VISA</font>";
						}	
					}	
					else 
					{	if(vif.equalsIgnoreCase("Y"))
						{	vf="<font color=\"green\">/VISA</font>";
						}
						else if(vif.equalsIgnoreCase("R"))
						{	vf="<font color=\"red\">/VISA</font>";
						}
					}
				}
				
				if(iif.equalsIgnoreCase("N"))
				{	insf="";
				}
				else
				{	if(vf.equalsIgnoreCase("") && tf.equalsIgnoreCase(""))
					{	if(iif.equalsIgnoreCase("Y"))
						{	insf="<font color=\"green\">INS</font>";
						}
						else if(iif.equalsIgnoreCase("R"))
						{	insf="<font color=\"red\">INS</font>";
						}
					}
					else
					{	if(iif.equalsIgnoreCase("Y"))
						{	insf="<font color=\"green\">/INS</font>";
						}
						else if(iif.equalsIgnoreCase("R"))
						{	insf="<font color=\"red\">/INS</font>";
						}
					}	
				}
			} else {
				vf		= "";
				insf	= "";
			}
			
			if(accif.equalsIgnoreCase("N"))
			{	accf="";
			}
			else
			{	if(insf.equalsIgnoreCase("") && vf.equalsIgnoreCase("") && tf.equalsIgnoreCase(""))
				{	if(accif.equalsIgnoreCase("Y"))
					{	accf="<font color=\"green\">ACC</font>";
					}
					else  if(accif.equalsIgnoreCase("R"))
					{	accf="<font color=\"red\">ACC</font>";
					}
				}	
				else 
				{	if(accif.equalsIgnoreCase("Y"))
					{	accf="<font color=\"green\">/ACC</font>";
					}
					else  if(accif.equalsIgnoreCase("R"))
					{	accf="<font color=\"red\">/ACC</font>";
					}
				}	
			}
			
			if(cif.equalsIgnoreCase("N"))
			{	cnclf="";
			}
			else 
			{	if(accf.equalsIgnoreCase("") && insf.equalsIgnoreCase("") && vf.equalsIgnoreCase("") && tf.equalsIgnoreCase(""))
				{	if(cif.equalsIgnoreCase("Y"))
					{	cnclf="<font color=\"green\">CNCL</font>";
					}
					else if(cif.equalsIgnoreCase("R"))
					{	cnclf="";
					}
				}	
				else 
				{	if(cif.equalsIgnoreCase("Y"))
					{	cnclf="<font color=\"green\">/CNCL</font>";
					}
					else if(cif.equalsIgnoreCase("R"))
					{	cnclf="";
					}
				}	
			}
			
			String status = "";
			if(reqNum.indexOf("PERSONAL") == -1) {
				
				if(trvlStatus.equalsIgnoreCase("RETURN")) {
					status = "<font color=\"#f26f0d\">Returned&nbsp;</font>   ";
				}
				else if(trvlStatus.equalsIgnoreCase("CANCEL")) {
					status = "<font color=\"red\">Cancelled&nbsp;</font>  ";
				}
				else if(trvlStatus.equalsIgnoreCase("APPROVED")) {
					status = "<i><font color=\"green\">Approved&nbsp;</font></i>   ";
				}
				else if(trvlStatus.equalsIgnoreCase("REJECT")) {
					status = "<font color=\"#f26f0d\">Rejected&nbsp;</font>  ";
				} else {
					status = "<font color=\"#797979\">Pending..&nbsp;</font>   ";
				}
			
			} else {
				status = "";
			}
			sts = "<b>"+status+tf+vf+insf+accf+cnclf+"</b>";
			
			json.put("Status_Flags", sts);
			json.put("latestUpdatedDate", rs.getString("MODIFIED_ON"));
			json.put("lockedUserId", rs.getString("MODIFIED_BY"));
			json.put("isLockedByMe",isLockedByMe(rs.getString("travel_book_id").trim(), httpsession.getId()));
			dataList.add(json);
		}
		rs.close();
		cStmt.close();
		return dataList;
	}
	
	private JSONObject updateBookedTravelRequest(HttpServletRequest request) throws SQLException, JSONException, ParseException
	{
		CallableStatement cStmt = null;
		DbConnectionBean objCon=new DbConnectionBean();
		Connection con=objCon.getConnection();
		HttpSession httpsession = request.getSession(false);
		
		String jsonString = request.getParameter("item");
		String loginUser = request.getSession().getValue("user_id") == null ? "1" : (String)request.getSession().getValue("user_id");
		JSONObject jObj = new JSONObject(jsonString);

		int index = 1;
		cStmt = con.prepareCall("{call PROC_UPDATE_T_TRAVEL_BOOKING_DETAIL(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
		cStmt.setString(index++, jObj.get("travel_booking_id").toString().trim());
		cStmt.setString(index++, "");
		cStmt.setString(index++, "");
		cStmt.setString(index++, "");
		cStmt.setString(index++, "");
		cStmt.setString(index++, "");
		cStmt.setString(index++, "");
		cStmt.setString(index++, "");
		cStmt.setString(index++, "");
		cStmt.setString(index++, "");
		cStmt.setString(index++, "");
		cStmt.setString(index++, "");
		cStmt.setString(index++, "");
		cStmt.setString(index++, "");
		cStmt.setString(index++, "");
		cStmt.setString(index++, "");
		cStmt.setString(index++, "");
		cStmt.setString(index++, "");
		cStmt.setString(index++, "");
		cStmt.setString(index++, "");
		cStmt.setString(index++, loginUser);
		cStmt.setString(index++, jObj.get("latestUpdatedDate").toString().trim());
		cStmt.setString(index++, "");
		cStmt.setString(index++, jObj.get("action").toString().trim());
		cStmt.setString(index++, loginUser);
		cStmt.setString(index++, request.getRemoteAddr());
		cStmt.registerOutParameter(index, Types.INTEGER);
		cStmt.executeUpdate();
		int status = cStmt.getInt(index);
		
		if(status == 0)
		{
			Map<String, Object> sessionData = SessionListener.getUserSessionData(httpsession.getId());
			String sessionBookingRequestIds = null;
			
			if(jObj.get("action").toString().trim().equalsIgnoreCase("lock"))
			{
				if(sessionData != null && sessionData.containsKey(SessionListener.BOOKING_REQUEST_ID_KEY_VALUE))
				{
					sessionBookingRequestIds = (String) sessionData.get(SessionListener.BOOKING_REQUEST_ID_KEY_VALUE);
					sessionBookingRequestIds += ","+jObj.get("travel_booking_id").toString().trim();
				}else
				{
					sessionBookingRequestIds = jObj.get("travel_booking_id").toString().trim();
				}
				putLockBookingDataInSession(httpsession.getId(), SessionListener.BOOKING_REQUEST_ID_KEY_VALUE,sessionBookingRequestIds);
			}
			else if(jObj.get("action").toString().trim().equalsIgnoreCase("update"))
			{
				updateBookingRequestLockFlag(jObj.get("travel_booking_id").toString().trim());
				
				if(sessionData != null && sessionData.containsKey(SessionListener.BOOKING_REQUEST_ID_KEY_VALUE))
				{
					sessionBookingRequestIds = (String) sessionData.get(SessionListener.BOOKING_REQUEST_ID_KEY_VALUE);
					String[] bookingRequestIdArr = sessionBookingRequestIds.split(",");
					String updatedIdsList = null;
					for(String id : bookingRequestIdArr)
					{
						if(!id.trim().equalsIgnoreCase(jObj.get("travel_booking_id").toString().trim()))
						{
							if(updatedIdsList != null)
							{
								updatedIdsList += ","+id;
							}else
							{
								updatedIdsList = id;
							}
						}
					}
					sessionBookingRequestIds = updatedIdsList;
					putLockBookingDataInSession(httpsession.getId(), SessionListener.BOOKING_REQUEST_ID_KEY_VALUE,sessionBookingRequestIds);
				}
			}
		}
		JSONObject obj = new JSONObject();
		obj.put("STATUS", status);
		obj.put("LOCKIDS", (String) httpsession.getAttribute("lockedBookingRequestIds"));
		return obj;
	}
	
	private Set<JSONObject> getBookingStatuslist() throws SQLException, JSONException
	{
		Statement stmt=null;
		ResultSet rs=null;
		DbConnectionBean objCon=new DbConnectionBean();
		Connection con=objCon.getConnection();
		Set<JSONObject> dataList = new LinkedHashSet<JSONObject>();
		JSONObject json = null;

		stmt		= con.createStatement(); 
		rs			= stmt.executeQuery("select booking_status_id, booking_status from M_BOOKING_STATUS where STATUS_ID=10 order by booking_status asc");
		dataList.add(getDefaultJsonObj("bookingStatus"));
		while(rs.next())
		{
			json = new JSONObject();
			json.put("Id", rs.getString("booking_status_id"));
			json.put("Name", rs.getString("booking_status"));
			dataList.add(json);
		}
		return dataList;
	}
	
	private Set<JSONObject> getCountrylist() throws SQLException, JSONException
	{
		Statement stmt=null;
		ResultSet rs=null;
		DbConnectionBean objCon=new DbConnectionBean();
		Connection con=objCon.getConnection();
		Set<JSONObject> dataList = new LinkedHashSet<JSONObject>();
		JSONObject json = null;

		StringBuilder sqlStr = new StringBuilder();
		sqlStr.append("SELECT COUNTRY_ID, COUNTRY_NAME FROM M_COUNTRY ORDER BY COUNTRY_NAME ASC");
		stmt		= con.createStatement(); 
		rs			= stmt.executeQuery(sqlStr.toString());
		dataList.add(getDefaultJsonObj("visacountry"));
		while(rs.next()){
			json = new JSONObject();
			json.put("Id", rs.getString("COUNTRY_ID"));
			json.put("Name", rs.getString("COUNTRY_NAME"));
			dataList.add(json);
		}
		return dataList;
	}
	
	private Set<JSONObject> getAirlinelist() throws SQLException, JSONException
	{
		Statement stmt=null;
		ResultSet rs=null;
		DbConnectionBean objCon=new DbConnectionBean();
		Connection con=objCon.getConnection();
		Set<JSONObject> dataList = new LinkedHashSet<JSONObject>();
		JSONObject json = null;

		StringBuilder sqlStr = new StringBuilder();
		sqlStr.append("SELECT AIRLINE_ID, AIRLINE_NAME FROM M_AIRLINE_COMPANIES ORDER BY AIRLINE_NAME ASC");
		stmt		= con.createStatement(); 
		rs			= stmt.executeQuery(sqlStr.toString());
		dataList.add(getDefaultJsonObj("visacountry"));
		while(rs.next()){
			json = new JSONObject();
			json.put("Id", rs.getString("AIRLINE_NAME"));
			json.put("Name", rs.getString("AIRLINE_NAME"));
			dataList.add(json);
		}
		return dataList;
	}
	
	private Set<JSONObject> getBookingBylist(String site_id) throws SQLException, JSONException
	{
		Statement stmt=null;
		ResultSet rs=null;
		DbConnectionBean objCon=new DbConnectionBean();
		Connection con=objCon.getConnection();
		Set<JSONObject> dataList = new LinkedHashSet<JSONObject>();
		JSONObject json = null;

		StringBuilder sqlStr = new StringBuilder();
		sqlStr.append("select USERID, SHORT_NAME from M_USERINFO ")
		.append("where BOOKING_ROLE is not null and ")
		.append("booking_role <>\'\' AND (STATUS_ID = 10)");
		stmt		= con.createStatement(); 
		rs			= stmt.executeQuery(sqlStr.toString());
		dataList.add(getDefaultJsonObj("bookingBy"));
		while(rs.next())
		{
			json = new JSONObject();
			json.put("Id", rs.getString("USERID"));
			json.put("Name", rs.getString("SHORT_NAME").trim());
			dataList.add(json);
		}
		return dataList;
	}
	
	private JSONObject getTravellerlist(String strSiteId) throws SQLException, JSONException
	{
		Statement stmt=null;
		ResultSet rs=null;
		DbConnectionBean objCon=new DbConnectionBean();
		Connection con=objCon.getConnection();
		StringBuilder strTravellerHtml = new StringBuilder();
		
		stmt		= con.createStatement(); 
		String strSql = "";
		if(!strSiteId.equals("0")) 
		{   
			strSql="SELECT  USERID, FIRSTNAME, LASTNAME FROM  M_USERINFO WHERE site_id="+strSiteId+" and  (STATUS_ID = 10) order by 2";  
			rs			= stmt.executeQuery(strSql);			
			while(rs.next())
			{
				strTravellerHtml.append("<option value='"+rs.getString("USERID")+ "'>"+rs.getString("FIRSTNAME")+" "+rs.getString("LASTNAME")+"</option>");
			}
        } 
		JSONObject obj = new JSONObject();
		return obj.put("travellerHtml", strTravellerHtml.toString());
	}
	
	private boolean isLockedByMe(String travelBookingId, String loginUserSessionId)
	{
		boolean isLockByMe = false;
		Map<String, Map<String, Object>> alluserSessionData = SessionListener.getAllUserSessionData();
		Set<String> sessionIds = alluserSessionData.keySet();
		for(String sessionId : sessionIds){
			if(loginUserSessionId.trim().equalsIgnoreCase(sessionId))
			{
				Map<String, Object> sessionData = alluserSessionData.get(sessionId);
				String lockBookingRequestIds = (String) sessionData.get(SessionListener.BOOKING_REQUEST_ID_KEY_VALUE);
				if(lockBookingRequestIds != null && lockBookingRequestIds.contains(travelBookingId))
				{
					isLockByMe = true;
				}
			}
		}
		return isLockByMe;
	}
	
	private boolean isLocked(String travelBookingId, String loginUserSessionId)
	{
		boolean isLock = false;
		Map<String, Map<String, Object>> alluserSessionData = SessionListener.getAllUserSessionData();
		Set<String> sessionIds = alluserSessionData.keySet();
		for(String sessionId : sessionIds){
			if(!loginUserSessionId.trim().equalsIgnoreCase(sessionId))
			{
				Map<String, Object> sessionData = alluserSessionData.get(sessionId);
				String lockBookingRequestIds = (String) sessionData.get(SessionListener.BOOKING_REQUEST_ID_KEY_VALUE);
				if(lockBookingRequestIds != null && lockBookingRequestIds.contains(travelBookingId))
				{
					isLock = true;
				}
			}
		}
		return isLock;
	}
	
	public void putLockBookingDataInSession(String sessionId, String paramKey, String paramValue)
	{
		Map<String, Object> sessionData = new HashMap<String, Object>();
		sessionData.put(paramKey, paramValue);
		SessionListener.setUserSessionData(sessionId, sessionData);
	}
	
	public static boolean updateBookingRequestLockFlag(String bookingRequestId)
	{
		boolean result = true;
		Statement stmt=null;
		DbConnectionBean objCon=new DbConnectionBean();
		Connection con=objCon.getConnection();
		try
		{
			stmt		= con.createStatement(); 
			String strSql = "";
			strSql="UPDATE T_TRAVEL_BOOKING_DETAIL SET LOCK_FLAG = 0 WHERE Travel_BOOK_ID IN ("+bookingRequestId+")";  
			result = stmt.executeUpdate(strSql) > 0;			
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		return result;
	}
	
	private JSONObject getDefaultJsonObj(String flag) throws JSONException
	{
		JSONObject json = new JSONObject();
		json.put("Id", "0");		
		if(flag.equals("bookingBy")) 
		{
			json.put("Name", "All");
		} 
		else if(flag.equals("bookingStatus")) 
		{
			json.put("Name", "All");
		} 
		else if(flag.equals("visacountry")) 
		{
			json.put("Name", "Select Country");
		} 	
		return json;
	}

}
