

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import src.beans.Approver;
import src.beans.WorkflowApprovalMatrix;
import src.dao.starDaoImpl;

/**
 * Servlet implementation class GetApproversListGMBHServlet
 */
public class GetApproversListGMBHServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	starDaoImpl dao = new starDaoImpl();   
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetApproversListGMBHServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=UTF-8");
		
		String strSiteId 		= (request.getParameter("siteId")==null)?"-1":request.getParameter("siteId"); 
		String strTravellerId 	= (request.getParameter("travellerId")==null)?"":request.getParameter("travellerId");
		String strTravelType 	= (request.getParameter("traveltype")==null)?"":request.getParameter("traveltype");
		String strWorkFlowCode	= (request.getParameter("workFlowCode")==null)?"":request.getParameter("workFlowCode");
		
		String strManager 			= "S";
		String strHod				= "S";
		String strBtnDisable		= "false";
		
		List<Approver> approverList = new ArrayList<Approver>();
		HashMap<String,String> approverData = new HashMap<String,String>();
		WorkflowApprovalMatrix matrix = null;
		
		if(strSiteId != null && !"0".equals(strSiteId)) {
			
			matrix = dao.getTravelApprovalMatrix(strSiteId, strTravelType, strWorkFlowCode);		
			if(strTravellerId != null && !"-1".equals(strTravellerId)) {
			 	approverList = dao.getApproverList(matrix, strTravellerId, strWorkFlowCode);			 	
			}
		}
		
		if(approverList != null && approverList.size() != 0) {
			for(Approver approver : approverList) {
				if(approver.getApproverLevel().equalsIgnoreCase("One")) {
					strManager	= approver.getApproverId().toString();
				} else if(approver.getApproverLevel().equalsIgnoreCase("Two")) {
					strHod		= approver.getApproverId().toString();
				} 			
			}
		}

		boolean result = true;
	 	if(matrix != null){
			if(matrix.isApproverLevel_1_Enable() && matrix.isApproverLevel_2_Enable() && matrix.isDefaultApproversEnable()) {
				result = validateLevel(new String[] {"One","Two","Default"}, approverList);
			} else if(matrix.isApproverLevel_1_Enable() && matrix.isApproverLevel_2_Enable() && !matrix.isDefaultApproversEnable()) {
				result = validateLevel(new String[] {"One","Two"}, approverList);
			} else if(matrix.isApproverLevel_1_Enable() && !matrix.isApproverLevel_2_Enable() && !matrix.isDefaultApproversEnable()) {
				result = validateLevel(new String[] {"One"}, approverList);
			} else if(!matrix.isApproverLevel_1_Enable() && matrix.isApproverLevel_2_Enable() && matrix.isDefaultApproversEnable()) {
				result = validateLevel(new String[] {"Two","Default"}, approverList);
			} else if(!matrix.isApproverLevel_1_Enable() && !matrix.isApproverLevel_2_Enable() && matrix.isDefaultApproversEnable()) {
				result = validateLevel(new String[] {"Default"}, approverList);
			} else if(matrix.isApproverLevel_1_Enable() && !matrix.isApproverLevel_2_Enable() && matrix.isDefaultApproversEnable()) {
				result = validateLevel(new String[] {"One","Default"}, approverList);
			}
		}
	 	
	 	if(result){
	 		strBtnDisable = "true";
	 	}
		
		approverData.put("manager", strManager);
		approverData.put("hod", strHod);
		approverData.put("btnDisable", strBtnDisable);
		
		
		JSONObject jsObj = new JSONObject(approverData);		
		response.getWriter().print(jsObj);
	}
	
	private boolean validateLevel(String[] approverLevels, List<Approver> approverList){
		boolean result = true;

		for(String approverLevel : approverLevels){
			if(!result){
				break;
			}
			if(!approverList.isEmpty()){
				for(Approver app : approverList){
					if("One".equals(approverLevel) && "One".equals(app.getApproverLevel())){
						result = true;
						approverList.remove(app);
						break;
					}else if("Two".equals(approverLevel)  && "Two".equals(app.getApproverLevel())){
						result = true;
						approverList.remove(app);
						break;
					}else if("Default".equals(approverLevel)  && "Default".equals(app.getApproverLevel())){
						result = true;
						approverList.remove(app);
						break;
					}else{
						result = false;
						break;
					}
				}
			}else{
				result = false;
				break;
			}
		}
		return result;
	}
}
