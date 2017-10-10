

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;

import src.connection.DbConnectionBean;

/**
 * Servlet implementation class AutoCompleteServlet
 */
public class AutoCompleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AutoCompleteServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String strAirPortName = request.getParameter("term");
		String travelTyep	  = request.getParameter("travelType");
		
		HttpSession hs = request.getSession();
		
		Set<JSONObject> airPortList = new LinkedHashSet<JSONObject>();
		
		Map<String, List<Map<String, String>>> airportCityMap = new HashMap<String, List<Map<String, String>>>();
		
		JSONObject json = null;
		
		try {
			Statement stmt=null;
			ResultSet rs=null;
			DbConnectionBean objCon=new DbConnectionBean();
			Connection con=objCon.getConnection();
			String sSqlStr	= "select ma.cityname+CASE WHEN COALESCE(ma.genericcode,'')='' THEN '' ELSE ' - '+ma.genericcode " 
					+" END+' - '+ma.countrycode as category, ma.cityname as city ,ma.airportname as airportname ,ma.airportcode as airportcode, ma.countrycode as countrycode, mc.country_id as countryid from M_AIRPORT_MAS ma inner join M_COUNTRY mc on mc.country_code = ma.countrycode "
					+" where ma.Status_ID=10 and (ma.airportname like '"+strAirPortName+"%' or ma.cityname "
					+" like '"+strAirPortName+"%' or ma.airportcode like '"+strAirPortName+"%')";
			
			if(hs.getValue("isMataGmbHSite") != null && "true".equals((String) hs.getValue("isMataGmbHSite"))){
				sSqlStr += " and travel_type in ('"+travelTyep+"','B') and Travel_Agency_ID=2 order by cityname";
			}

			stmt		= con.createStatement(); 
			rs			= stmt.executeQuery(sSqlStr);
			while(rs.next()){

				if(!airportCityMap.containsKey(rs.getString("category")))
					airportCityMap.put(rs.getString("category"), new ArrayList<Map<String, String>>());
				
				Map<String, String> dataMap = new HashMap<String, String>();
				dataMap.put("CITY", rs.getString("city"));
				dataMap.put("AIRPORT_NAME", rs.getString("airportname"));
				dataMap.put("AIRPORT_CODE", rs.getString("airportcode"));
				dataMap.put("COUNTRY_CODE", rs.getString("countrycode"));
				dataMap.put("COUNTRY_ID", rs.getString("countryid"));
				
				airportCityMap.get(rs.getString("category")).add(dataMap);
			}

			Set<Entry<String, List<Map<String,String>>>> entrySet =  airportCityMap.entrySet();
			Iterator<Entry<String, List<Map<String,String>>>> it = entrySet.iterator();

			while(it.hasNext()){
				Entry<String, List<Map<String,String>>> entry = it.next();
				for(int i=0; i<entry.getValue().size(); i++){
					json = new JSONObject();
					if(entry.getValue().size() > 1){
						json.put("category", entry.getKey()+" ( All Airports )");
						json.put("label", entry.getValue().get(i).get("AIRPORT_NAME").trim()+" - "+entry.getValue().get(i).get("AIRPORT_CODE").trim()+" , "+entry.getValue().get(i).get("COUNTRY_CODE").trim());
						json.put("id", entry.getValue().get(i).get("COUNTRY_ID").trim());
					}else{
						json.put("label", entry.getValue().get(i).get("CITY").trim()+" - "+entry.getValue().get(i).get("AIRPORT_CODE").trim()+" , "+entry.getValue().get(i).get("COUNTRY_CODE").trim());
						json.put("id", entry.getValue().get(i).get("COUNTRY_ID").trim());
					}
					airPortList.add(json);
				}
			}

			JSONArray jsArray = new JSONArray(airPortList);	 
			response.getWriter().print(jsArray);

		} catch(Exception e){
			e.printStackTrace();
		}
		
	}

}
