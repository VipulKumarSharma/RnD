

import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import src.connection.DbConnectionBean;

/**
 * Servlet implementation class StatisticsCount
 */
public class StatisticsCount extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	/**
     * @see HttpServlet#HttpServlet()
     */
    public StatisticsCount() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=UTF-8");
		
		String strLanguage1				= 	(request.getParameter("language1") == null) ? "":request.getParameter("language1");
		String strSuserId				= 	(request.getParameter("suserId") == null) ? "":request.getParameter("suserId");
		String strFinYear 			    = 	(request.getParameter("finYear") == null) ? "":request.getParameter("finYear");
		String strStatus				= 	(request.getParameter("status") == null) ? "":request.getParameter("status");
	
		String strYear1 = "";
		String strYear2 = "";
		
		if(!strFinYear.equals("")){
			int indexOfDash = strFinYear.indexOf('-');
			strYear1 = strFinYear.substring(0, indexOfDash);
			strYear2 = strFinYear.substring(indexOfDash + 1);	
		}
		
		StringBuffer strFromDt = new StringBuffer();
		StringBuffer strToDt = new StringBuffer();
		
		strFromDt.append(strYear1).append("-04-01");
		
		strToDt.append(strYear2).append("-03-31");
		
		String strReqAppFlag = "";
		String strReqCount = "";	
		
		HashMap<String,String> dataMap = new HashMap<String,String>();	
		ArrayList<HashMap<String, String>> dataList = new ArrayList<HashMap<String, String>>();
		
		DbConnectionBean objCon = new DbConnectionBean();
	 	Connection con = null;
	 	ResultSet rs = null;
	 	String strsql = "";	 	
		con=objCon.getConnection();
		CallableStatement objCstmt = null;
	
		try {
			
			strsql="{?=call PROC_STARS_STATISTIC(?,?,?,?)}";
			objCstmt= con.prepareCall(strsql);
			objCstmt.registerOutParameter(1, java.sql.Types.INTEGER);			
			objCstmt.setString(2,strSuserId);
			objCstmt.setString(3,strFromDt.toString());
			objCstmt.setString(4,strToDt.toString());
			objCstmt.setString(5,strStatus);	
			rs = objCstmt.executeQuery();
			
			while(rs.next()) {
				
				strReqAppFlag	= rs.getString("RequestAppFlag");
				strReqCount  	= rs.getString("Req_Count");
				
				dataMap = new HashMap<String,String>();
				dataMap.put("reqAppFlag", strReqAppFlag);
				dataMap.put("reqCount", strReqCount);
				dataList.add(dataMap);
			}								
			
			JSONArray jsArray = new JSONArray(dataList);		
			response.getWriter().print(jsArray);
						
		} catch (SQLException e) {
	        e.printStackTrace();
	    } catch(Exception e) {
	    	e.printStackTrace();
	    }
		
		
	}

	

}
