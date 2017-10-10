
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import src.dao.starDaoImpl;

/**
 * Servlet implementation class ApproverWorkflowServlet
 */
public class ApproverWorkflowServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ApproverWorkflowServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession hs = request.getSession();
		
		String strSiteId = request.getParameter("ID");
		String traveltype = request.getParameter("TYPE");
		
		if(request.getParameter("actionType") != null && "enableApproverLevels".equals(request.getParameter("actionType"))){
			
			String[] traveltypeArr 			= {"D", "D", "I"};
			int[] workFlowCodeArr 			= {1, 0, 1};
			int[] appLevel_1_Arr 			= new int[3];
			int[] appLevel_2_Arr 			= new int[3];
			int[] defaultAppArr 			= new int[3];
			int[] billingAppArr 			= new int[3];
			
			if(request.getParameter("domWithFlightLevel1") != null){
				appLevel_1_Arr[0] = 1;
			}else{
				appLevel_1_Arr[0] = 0;
			}
			
			if(request.getParameter("domWithFlightLevel2") != null){
				appLevel_2_Arr[0] = 1;
			}else{
				appLevel_2_Arr[0] = 0;
			}
			
			if(request.getParameter("domWithFlightDefault") != null){
				defaultAppArr[0] = 1;
			}else{
				defaultAppArr[0] = 0;
			}
			
			if(request.getParameter("domWithFlightBillingApp") != null){
				billingAppArr[0] = 1;
			}else{
				billingAppArr[0] = 0;
			}
			
			if(request.getParameter("domWithoutFlightLevel1") != null){
				appLevel_1_Arr[1] = 1;
			}else{
				appLevel_1_Arr[1] = 0;
			}
			
			if(request.getParameter("domWithoutFlightLevel2") != null){
				appLevel_2_Arr[1] = 1;
			}else{
				appLevel_2_Arr[1] = 0;
			}
			
			if(request.getParameter("domWithoutDefault") != null){
				defaultAppArr[1] = 1;
			}else{
				defaultAppArr[1] = 0;
			}
			
			if(request.getParameter("domWithoutFlightBillingApp") != null){
				billingAppArr[1] = 1;
			}else{
				billingAppArr[1] = 0;
			}
			
			if(request.getParameter("interLevel1") != null){
				appLevel_1_Arr[2] = 1;
			}else{
				appLevel_1_Arr[2] = 0;
			}
			
			if(request.getParameter("interLevel2") != null){
				appLevel_2_Arr[2] = 1;
			}else{
				appLevel_2_Arr[2] = 0;
			}
			
			if(request.getParameter("interDefault") != null){
				defaultAppArr[2] = 1;
			}else{
				defaultAppArr[2] = 0;
			}
			
			if(request.getParameter("interBillingApp") != null){
				billingAppArr[2] = 1;
			}else{
				billingAppArr[2] = 0;
			}
			
			 boolean result = new starDaoImpl().insertMataGmbH_WorkflowMatrixData(strSiteId, traveltypeArr, workFlowCodeArr, 
					 appLevel_1_Arr, appLevel_2_Arr, defaultAppArr, billingAppArr, (String)hs.getValue("user_id"), request.getRemoteAddr());
			 
			 String transactionResultMessage = null;
			 if(result){
				 transactionResultMessage = "Approval Workflow data saved successfully.";
			 }else{
				 transactionResultMessage = "Failure in Approval Workflow data saving process.";
			 }
			 request.getRequestDispatcher("/M_WorkFlowAddApprover.jsp?ID="+strSiteId+"&TYPE="+traveltype+"&message="+transactionResultMessage).forward(request, response);
		} 
	}

}
