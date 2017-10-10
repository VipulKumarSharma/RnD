

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import src.dao.MailDaoImpl;

/**
 * Servlet implementation class SendMailServlet
 */
public class SendMailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	//MailDaoImpl mailDaoImpl = new MailDaoImpl();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SendMailServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String strPurchaseId 			= request.getParameter("purchaseId");
    	String strPurchaseRequisitionId = request.getParameter("purchaseRequisitionId");
    	String strReqTyp 				= request.getParameter("ReqTyp");
    	String Suser_id 				= request.getParameter("suserid");
    	String strsesLanguage 			= request.getParameter("sesLanguage");
    	String strCurrentYear 			= request.getParameter("currentYear");
		String strRad = "ORIGIN";
		String strComments = "";
		
		
//		ServletContext sc = getServletContext();
//		RequestDispatcher rd = sc.getRequestDispatcher("/T_requisitionMailOnOriginating.jsp?purchaseId="+strPurchaseId+"&purchaseRequisitionId="+strPurchaseRequisitionId+"&rad="+strRad+"&COMMENTS="+strComments+"&ReqTyp="+strReqTyp);
//		rd.forward(request, response);
		
		MailDaoImpl.sendRequisitionMailOnOriginating(strPurchaseId, strReqTyp, Suser_id, strsesLanguage, strCurrentYear);
	}
	

}
