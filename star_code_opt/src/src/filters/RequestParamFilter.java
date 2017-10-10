package src.filters;

/***************************************************
*Copyright (C) 2001 MIND
*All rights reserved.
*The information contained here in is confidential and
*proprietary to MIND and forms the part of the MIND

*CREATED BY		:Anjali Kumari
*Date			:30-10-2013
*Project 		:RAS
*DESCRIPTION 	:This class is used to for special character check and page access check as per the role.
*Description 1	:Modified by Pulkit Agarwal on 12-Nov-2013 to stop filtering pages having special characters in there parameter values.
**********************************************************/
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;
import java.util.Properties;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import src.connection.Roles_Resource;



/**
 * Servlet implementation class RequestParamFilter
 */
public class RequestParamFilter implements Filter {

	 protected FilterConfig filterConfig;		
	 static int count=0;
	 String contextPathURL="";
	 Roles_Resource	roleBean=null;
	 List<String> listPagesNotToFilter	=	null;
	  
	   public void destroy() {
	      this.filterConfig = null;	   
	      this.roleBean=null;
	   }


	public void doFilter(ServletRequest sReq, ServletResponse sRes,
			FilterChain chain) throws IOException, ServletException {
		// SET CHARACTERENCODING IN REQUEST OBJECT BEFORE REACHING TO CONTAINER.
		sReq.setCharacterEncoding("UTF-8");
		
		HttpServletRequest req 	=	(HttpServletRequest)sReq;
		HttpServletResponse res = 	(HttpServletResponse)sRes;
		String SuserRole		=	"",SuserRole1="";
		String strRequestURI	=	req.getRequestURI();
		String pageToCheck		=	strRequestURI.substring(strRequestURI.lastIndexOf("/")+1,strRequestURI.length());
		//System.out.println("pageToCheck--->"+pageToCheck);
		SuserRole				=	(String) req.getSession().getAttribute("userRole")==null?"":req.getSession().getAttribute("userRole").toString().trim();
		SuserRole1				=	(String) req.getSession().getAttribute("userRoleOther")==null?"":req.getSession().getAttribute("userRoleOther").toString().trim();
		String rolesExist		=	"";
		String strReturnType	=	"Y";
		String strPageLowercase	=	pageToCheck.toLowerCase();
		int check=0;
		String paramName		=	"";
		String[] paramValues 	= 	null;
		String paramValue		=	"";

		// By Pass this URl "BookingStatusReport" for Booking Status Report
		
		if(pageToCheck.equals("")||strPageLowercase.contains(".jpeg")||strPageLowercase.contains(".jpg")||strPageLowercase.contains(".gif")
				||strPageLowercase.contains(".css") || strPageLowercase.equalsIgnoreCase("processMail")
				|| strPageLowercase.substring(strPageLowercase.lastIndexOf(".")+1, strPageLowercase.length()).equalsIgnoreCase("js")
				|| strPageLowercase.equals("BookingStatusReport".toLowerCase())){
			
		}else{
			roleBean = new Roles_Resource();
			rolesExist=roleBean.getRolesList(pageToCheck).toString().trim();			
			String strUserRole = SuserRole.trim();
			String strUserRole1 = SuserRole1.trim();
			if(rolesExist!=""){
				rolesExist=","+rolesExist+",";				
				
				if(rolesExist.contains(","+strUserRole+",") || rolesExist.contains(","+strUserRole1+",")){	
					strReturnType="Y";
				}else{
					strReturnType="N";
				}
			}
			else{
				strReturnType="Y";
			}
		}
	
 		contextPathURL=req.getContextPath();
		//System.out.println("contextPathURL--->"+contextPathURL);
		if(strReturnType=="N"){
			res.sendRedirect(contextPathURL+"/UnauthorizedAccess.jsp");
		}		
				
		//System.out.println("-----IF Condition------>>>"+listPagesNotFiltered.contains(strPageLowercase));
	
	if(pageToCheck.equals("")||strPageLowercase.contains(".jpeg")||strPageLowercase.contains(".jpg")||strPageLowercase.contains(".gif")
			||strPageLowercase.contains(".css") || strPageLowercase.equalsIgnoreCase("processMail")
			|| strPageLowercase.substring(strPageLowercase.lastIndexOf(".")+1, strPageLowercase.length()).equalsIgnoreCase("js")
			|| strPageLowercase.equals("BookingStatusReport".toLowerCase())){
		
	}else{
		if(!listPagesNotToFilter.contains(strPageLowercase)){
			//System.out.println("strPageLowercase>>>"+strPageLowercase);
			Enumeration<Object> paramEnumertor=req.getParameterNames();
			while(paramEnumertor.hasMoreElements()){		
				check=0;
				paramName=paramEnumertor.nextElement().toString().trim();
				paramValues = req.getParameterValues(paramName);			
				 for (int paramIndex = 0; paramIndex < paramValues.length; paramIndex++)
				 {    
					 paramValue= paramValues[paramIndex].toString().trim();		
					 if(paramValue.contains("'") || paramValue.contains("--")|| paramValue.contains("<") || paramValue.contains(">") || paramValue.contains("&lt;") || paramValue.contains("&gt;")){
						 check=1;
						 break;
					 }else{			
						 
					 }
				 }
				 if(check==1){				
					 break;
				 }
			}
		}
	}//end of else	
		
			if(check==1){
				System.out.println("in requestParamFilter.java session expired due to paramValue===>>"+paramValue);
				res.sendRedirect(contextPathURL+"/error.jsp");
			}
			else{	
				chain.doFilter(req, res);
			}	
	}
	
	public void init(FilterConfig filterConfig) throws ServletException {		 
		this.filterConfig = filterConfig;	
		roleBean=new Roles_Resource();	
		
		String strPagesNotToFilter	=	"";
		String strReplaced			=	"";	
		listPagesNotToFilter 		= 	new ArrayList<String>(); 
		String  Path				=	new String(getClass().getResource("../connection/STAR.properties").getPath());
     	 for(int index=0;index<Path.length();index++)
		 {
           strReplaced =Path.replace("%20"," ");
		 }
		 FileInputStream propfile;
		try {
			propfile = new FileInputStream(strReplaced);
			 if ( propfile != null){
				 Properties starsprop = new Properties();
				 starsprop.load(propfile);
				 strPagesNotToFilter	=	starsprop.getProperty("pagesNotToFiltered");
				 //System.out.println("strPagesNotToFilter======>>>>>"+strPagesNotToFilter);
				}
		}
			 catch (FileNotFoundException fnfE) {
				 System.out.println("FileNotFoundException in init of requestParamFilter===>>>"+fnfE);
				}
			catch (Exception e) {
				 System.out.println("Exception in init of requestParamFilter===>>>"+e);
			}
			 String[] arrPagesNotToFilter = strPagesNotToFilter.split(",");
		for(int index=0;index<arrPagesNotToFilter.length;index++){
			listPagesNotToFilter.add(arrPagesNotToFilter[index].toLowerCase());
		}
	}
}