

import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.StringTokenizer;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.json.JSONArray;

import src.connection.DbConnectionBean;
import src.connection.LabelRepository;


/**
 * Servlet implementation class SearchEmployeeLocation
 */
public class SearchEmployeeLocation extends HttpServlet {
	private static final long serialVersionUID = 1L;
	LabelRepository LableMst=new LabelRepository();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SearchEmployeeLocation() {
        super();
        // TODO Auto-generated constructor stub
    }

	
    /**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String strUserId = request.getParameter("userId");
		String strDate = request.getParameter("dt_date");
		String strMyteam = request.getParameter("chk_myteam") == null ? "N" :request.getParameter("chk_myteam");
		String strLang=request.getParameter("lang")==null?"en_US":request.getParameter("lang");
		
		String strCity = "";
		String strPersonCnt = "";
		String strNameDestination = "";
		String strName = "";
		String strDestination = "";
		String strNamePipe = "";		
		String strPersonToolTip = "";	
		String strTravellerName = "";	
		String strCityName = "";	
		
		StringBuilder strDestinationHtml = new StringBuilder();	
		StringBuilder strTravellerDetailTbl = new StringBuilder();
		StringBuilder strTravellerSummaryTbl = new StringBuilder();
		
		List<String> personToolTipList = new ArrayList<String>();		
		ArrayList<HashMap<String, String>> locationList = new ArrayList<HashMap<String, String>>();		
		HashMap<String,String> locationData = new HashMap<String,String>();	
		
		DbConnectionBean objCon=new DbConnectionBean();
	 	Connection con=null;
	 	ResultSet rs1, rs2 = null;
	 	boolean result = false;
	 	String strsql = "";	 	
		con=objCon.getConnection();
		CallableStatement objCstmt=null;
		
		try{
			strsql="{?=call PROC_GET_MAP_TRAVELLER_DETAILS(?,?,?)}";
			objCstmt= con.prepareCall(strsql);
			objCstmt.registerOutParameter(1, java.sql.Types.INTEGER);			
			objCstmt.setString(2,strDate);
			objCstmt.setString(3,strMyteam);
			objCstmt.setInt(4,Integer.valueOf(strUserId));			
			rs1 = objCstmt.executeQuery();
			
			strTravellerSummaryTbl.append("<thead><tr bgcolor='#dddddd' style='height:24px;'>");
			strTravellerSummaryTbl.append("<th class='serialNo' nowrap='nowrap' align='left' style='width:28px!important; border-bottom:1px solid #b1b1b1; border-right:1px solid #b1b1b1;'>#</th><th nowrap='nowrap' align='left' style='border-bottom:1px solid #b1b1b1; border-right:1px solid #b1b1b1;'>"+LableMst.getLabel("label.report.city", strLang)+"</th><th nowrap='nowrap' align='left' style='width:100px!important; border-bottom:1px solid #b1b1b1; border-right:1px solid #b1b1b1;'>"+LableMst.getLabel("label.report.personcount", strLang)+"</th>");
			strTravellerSummaryTbl.append("</tr></thead>");
			strTravellerSummaryTbl.append("<tbody>");
			int srNo1 = 1;
			while(rs1.next()){
				strCity = rs1.getString("City");
				strPersonCnt = rs1.getString("PersonCnt");
				strNameDestination = rs1.getString("Destination");
				
				strTravellerSummaryTbl.append("<tr bgcolor='#ffffff' valign='top' style='vertical-align: top;'>");
				strTravellerSummaryTbl.append("<td style='width:28px; border-bottom:1px solid #b1b1b1; border-right:1px solid #b1b1b1;'>");
				strTravellerSummaryTbl.append(srNo1++);
				strTravellerSummaryTbl.append("</td>");
				strTravellerSummaryTbl.append("<td nowrap='nowrap' style='border-bottom:1px solid #b1b1b1; border-right:1px solid #b1b1b1;'>");
				strTravellerSummaryTbl.append(strCity);
				strTravellerSummaryTbl.append("</td>");
				strTravellerSummaryTbl.append("<td nowrap='nowrap' align='right' style='width:100px; text-align:right; border-bottom:1px solid #b1b1b1; border-right:1px solid #b1b1b1;'>");
				strTravellerSummaryTbl.append(strPersonCnt);
				strTravellerSummaryTbl.append("</td>");
				strTravellerSummaryTbl.append("</tr>");	
		       
				String [] strNamePipeArray = null;
				String [] strNameHashArray = null;
				
				personToolTipList = new ArrayList<String>();				
		       	strDestinationHtml = new StringBuilder();
		       	strDestinationHtml.append("<table width='100%' align='center' border='0' cellpadding='0' cellspacing='1' id='infoTable' style='width:280px; font-size: 8pt; font-family: Arial,verdana,sans-serif; background: #e6555c; border-top:1px solid #b1b1b1; border-left:1px solid #b1b1b1;'>");
				
		       	if(strNameDestination.contains("|")){
					strNamePipeArray = strNameDestination.split("\\|");
					for (int i = 0; i < strNamePipeArray.length; i++) {
						if(!strNamePipeArray[i].trim().equals("")){
						 strNamePipe = strNamePipeArray[i].trim();
						}
						strNameHashArray = strNamePipe.split("\\#");
						for (int j = 0; j < strNameHashArray.length; j++) {
							if(!strNameHashArray[j].trim().equals("")){
								if(j==0){
									if(!strNameHashArray[j].trim().equals("")){
										strName	= strNameHashArray[j];
										strDestinationHtml.append("<tr>");
								       	strDestinationHtml.append("<th style='font-size: 8pt; font-weight: bold; text-align:left; border-bottom:1px solid #b1b1b1; border-right:1px solid #b1b1b1; background: #db2128; color: #ffffff;'>");
								    	strDestinationHtml.append(strName);
								       	strDestinationHtml.append("</th>");
								       	strDestinationHtml.append("</tr>");	
								       	personToolTipList.add(strName);
									}							
								} else {
									if(!strNameHashArray[j].trim().equals("")){
										strDestination =strNameHashArray[j];
										StringTokenizer st = new StringTokenizer(strDestination, ",");
										while (st.hasMoreElements()) {																			        
											String strDestinationDetail  =st.nextElement().toString().trim();
											strDestinationHtml.append("<tr>");
									       	strDestinationHtml.append("<td style='font-size: 7pt; text-align:left; border-bottom:1px solid #b1b1b1; border-right:1px solid #b1b1b1; background: #ff5b5b; color: #000000;'>");
									    	strDestinationHtml.append(strDestinationDetail);
									       	strDestinationHtml.append("</td>");
									       	strDestinationHtml.append("</tr>");					
										}
									}						
								}
							}
													
						}							
					}
				} else {
					strNameHashArray = strNameDestination.split("\\#");
					for (int j = 0; j < strNameHashArray.length; j++) {
						if(!strNameHashArray[j].trim().equals("")){
							if(j==0){								
									strName	= strNameHashArray[j];
									strDestinationHtml.append("<tr>");
							       	strDestinationHtml.append("<th style='font-size: 8pt; font-weight: bold; text-align:left; border-bottom:1px solid #b1b1b1; border-right:1px solid #b1b1b1; background: #db2128; color: #ffffff;'>");
							    	strDestinationHtml.append(strName);
							       	strDestinationHtml.append("</th>");
							       	strDestinationHtml.append("</tr>");	
							       	personToolTipList.add(strName);
							} else {								
								strDestination =strNameHashArray[j];
								StringTokenizer st = new StringTokenizer(strDestination, ",");
								while (st.hasMoreElements()) {																	        
									String strDestinationDetail  =st.nextElement().toString().trim();
									strDestinationHtml.append("<tr>");
							       	strDestinationHtml.append("<td style='font-size: 7pt; text-align:left; border-bottom:1px solid #b1b1b1; border-right:1px solid #b1b1b1; background: #ff5b5b; color: #000000;'>");
							    	strDestinationHtml.append(strDestinationDetail);
							       	strDestinationHtml.append("</td>");
							       	strDestinationHtml.append("</tr>");					
								}														
							}
						}
												
					}
				}
				
				strDestinationHtml.append("</table>");				
				strPersonToolTip = StringUtils.join(personToolTipList, ",");							
				
				locationData = new HashMap<String,String>();				
				locationData.put("City", strCity.trim());
				locationData.put("PersonCnt", strPersonCnt);
				locationData.put("destinationHtml", strDestinationHtml.toString());
				locationData.put("personToolTip", strPersonToolTip);
				locationList.add(locationData);				
			}
			strTravellerSummaryTbl.append("</tbody>");			
			locationData = new HashMap<String,String>();				
			locationData.put("travellerSummaryTableTr", strTravellerSummaryTbl.toString());
			locationList.add(locationData);	
			rs1.close();
			
			result = objCstmt.getMoreResults();		
			if(result){
				rs2 = objCstmt.getResultSet();
				int srNo2 = 1;
				strTravellerDetailTbl = new StringBuilder();
				strTravellerDetailTbl.append("<thead><tr bgcolor='#dddddd' style='height:24px;'>");
				strTravellerDetailTbl.append("<th class='serialNo' nowrap='nowrap' align='left' style='width:28px!important; border-bottom:1px solid #b1b1b1; border-right:1px solid #b1b1b1;'>#</th><th nowrap='nowrap' align='left' style='border-bottom:1px solid #b1b1b1; border-right:1px solid #b1b1b1;'>"+LableMst.getLabel("label.global.traveller", strLang)+"</th><th nowrap='nowrap' align='left' style='border-bottom:1px solid #b1b1b1; border-right:1px solid #b1b1b1;'>"+LableMst.getLabel("label.report.city", strLang)+"</th>");
				strTravellerDetailTbl.append("</tr></thead>");
				strTravellerDetailTbl.append("<tbody>");
				while(rs2.next()){
					strTravellerName = rs2.getString("TravellerName");	
					strCityName = rs2.getString("CityName");
					
					strTravellerDetailTbl.append("<tr bgcolor='#ffffff' valign='top' style='vertical-align: top;'>");
					strTravellerDetailTbl.append("<td style='width:28px; border-bottom:1px solid #b1b1b1; border-right:1px solid #b1b1b1;'>");
					strTravellerDetailTbl.append(srNo2++);
					strTravellerDetailTbl.append("</td>");
					strTravellerDetailTbl.append("<td nowrap='nowrap' id='travellerNameTd' style='border-bottom:1px solid #b1b1b1; border-right:1px solid #b1b1b1;'><a href='#'>");
					strTravellerDetailTbl.append(strTravellerName);
					strTravellerDetailTbl.append("</a></td>");
					strTravellerDetailTbl.append("<td nowrap='nowrap' style='border-bottom:1px solid #b1b1b1; border-right:1px solid #b1b1b1;'>");
					strTravellerDetailTbl.append(strCityName);
					strTravellerDetailTbl.append("</td>");
					strTravellerDetailTbl.append("</tr>");	
					
				}
				strTravellerDetailTbl.append("</tbody>");
				strTravellerDetailTbl.append("<tfoot><tr bgcolor='#ffffff' style='display:none;'><td colspan='3' style='border-bottom:1px solid #b1b1b1; border-right:1px solid #b1b1b1;'>"+LableMst.getLabel("label.global.norecordfound", strLang)+"</td></tr></tfoot>");
				locationData = new HashMap<String,String>();				
				locationData.put("travellerDetailTableTr", strTravellerDetailTbl.toString());
				locationList.add(locationData);	
				rs2.close();
			}
		
		} catch (SQLException e) {
	        e.printStackTrace();
	    } catch(Exception e) {
	    	e.printStackTrace();
	    }
				
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=UTF-8");
		
		JSONArray jsArray = new JSONArray(locationList);		
		response.getWriter().print(jsArray);
	}

}
