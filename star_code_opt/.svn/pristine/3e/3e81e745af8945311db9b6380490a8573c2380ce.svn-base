<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:Himanshu Jain
 *Date of Creation 		:04 September 2006
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This jsp list the name of the person whom the user wants to report to.
 *Modification 			: 
 *Reason of Modification: 
 *Date of Modification  : 
 *Revision History		:
 *Editor				:Editplus
 
 *Modification 			:Done alphabatical sorting for select site dropdown in report to across the unit.
 *Date of modification	:16 sept 2011
 *Modified by			:Manoj Chand
 
 *Modification 			:Resolve issue of not refreshing model dialog on site change.
 *Date of modification	:23 Aug 2012
 *Modified by			:Manoj Chand
*******************************************************/%>
<%@ page import = "src.connection.DbConnectionBean" pageEncoding="UTF-8" %>
<%@ include file="importStatement.jsp" %>

<html>
<head>
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
<script type="text/javascript" language="text/javaScript" src="ScriptLibrary/jquery-1.8.3.js?buildstamp=2_0_0"></script>
<SCRIPT type="text/javascript" language="text/javaScript" src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<script type="text/javascript" language="text/javaScript" src="scripts/CommonValida.js?buildstamp=2_0_0"></script>
<script type="text/javascript" language="text/javaScript" src="ScriptLibrary/jQueryMaster.js?buildstamp=2_0_0"></script>
<script type="text/javascript" language="text/javaScript" src="ScriptLibrary/jquery.quicksearch.js?buildstamp=2_0_0"></script>

<style type="text/css">

div.quicksearch { font-size: 8pt; font-weight: bold; color: #000000; font-family: 'Arial, Sans-Serif'; }
div.quicksearch input { width:100px; height:18px; background :#ffffff; color:#666666; font-family:'Arial, Sans-Serif'; font-size:8pt; border-bottom:#888888 1px solid; border-left: #888888 1px solid; border-right: #888888 1px solid; border-top: #888888 1px solid; }
</style>

<%
DbConnectionBean bean = new DbConnectionBean();
String strsesLanguage=request.getParameter("lang")==null?"en_US":request.getParameter("lang");

String pageHeadingText = dbLabelBean.getLabel("label.mylinks.selectthepersonreportto",strsesLanguage)+"("+dbLabelBean.getLabel("label.global.approverlevel1",strsesLanguage)+")";
if(request.getParameter("selectHod") != null && "Y".equals(request.getParameter("selectHod"))){
	pageHeadingText = dbLabelBean.getLabel("label.mylinks.selectthepersondepthead",strsesLanguage)+"("+dbLabelBean.getLabel("label.global.approverlevel2",strsesLanguage)+")";
}
%>
<title> REPORT TO</title>
<base target='_self'>
</head>
<SCRIPT language=javascript>
	 
// function to return value from radio button and userid	
	function testResults(k,userid,strFlag)
	{
		var o = new Object();
		if(strFlag!=null && strFlag == 'y')
		{
			o.flag=document.myform.names.value;
		}
		else
		{		  
		   o.flag=document.myform.names[k].value;		   
		}
		   o.userid=userid;
		   window.returnValue = o;
		   window.close();
		
	}


function  getSiteID()
 		{
			   var language='<%=strsesLanguage%>';
 		       var o = new Object();
               var i=document.myform.strradioselected.value;    
               var filename="report_to.jsp";//i="+i;
               document.myform.action="report_to.jsp?lang="+language; 
			   document.myform.submit();
	 }

</SCRIPT>

<body>
<FORM NAME="myform" ACTION="../star/M_UserRegister.jsp" method="post">

 <link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
<table width="100%" border="0" cellspacing="0" cellpadding="10">
  <tr>
    <td width="77%" class="bodyline-top">
	<ul class="pagebullet">
      <li class="pageHead"><%=pageHeadingText%></li>
    </ul></td>	
  </tr>
  </table>
<%
	ArrayList nameList			= new ArrayList();
	ArrayList namereportList	= new ArrayList();
	ArrayList useridList		= new ArrayList();
	String strsite_id			= request.getParameter("site_id");
	 
	String  strradioselected	= request.getParameter("i");
	 
	int report_to =0;
	int [] useridArray			= new int[1];
	String[] namereportArray	= new String[1];
	String[] nameArray			= new String[1];
	ResultSet rs=null;
	String strFlag = "n";
	
	if (strradioselected==null)
	{
		strradioselected="0";
		
	}
%>
<input type="hidden" name="i" value="<%=strradioselected%>" />
<input type="hidden" name="strradioselected" value="<%=strradioselected%>" />
<% //if (strradioselected.equals("0")) { 
	
//change the code for open occros the unit report to person on shiv sharma on 6-11-2008    	
String sSqlStr = "select firstname as Firstname ,lastname as lastname,isnull(dbo.user_name(report_to),'-') as reportTo,userid as userid from m_userinfo where site_id='"+strsite_id+"' AND STATUS_ID=10 AND APPLICATION_ID=1 order by 1";

 rs = bean.executeQuery(sSqlStr);
//}
//else
//{
	// String sSqlStr = "select firstname as Firstname,lastname as lastname,isnull(dbo.user_name(report_to),'-') as reportTo,userid as userid from m_userinfo where Boss='B' AND STATUS_ID=10 AND APPLICATION_ID=1 order by 1";
	// rs = bean.executeQuery(sSqlStr);
//}

 
 while(rs.next())
	{
		String temp = rs.getString("Firstname") +" "+ rs.getString("lastname");
		String tempreport = rs.getString("reportTo");
		report_to = rs.getInt("userid");
		nameList.add(temp); //store the name isn an ArrayList
		namereportList.add(tempreport);
		useridList.add(new Integer(report_to));
	}
 //System.out.println("+++++++++dsfgdfg+++++++++++++++++++++++++");
nameArray= new String[nameList.size()]; //create a String Array of the same size as of ArrayList
namereportArray = new String[namereportList.size()]; 
useridArray = new int[useridList.size()]; 

for(int i=0;i<nameList.size();i++)
{
	nameArray[i]		= (String)nameList.get(i); //store the value in StringArray in Full name Coloumn
	namereportArray[i]  = (String)namereportList.get(i); //create a String Array of the same size as of ArrayList
	useridArray[i]		= ((Integer)useridList.get(i)).intValue(); //create a int Array of the same size as of ArrayList
}

%>

	<% if(nameArray.length == 1)
	{
		strFlag = "y";
	}
	 //System.out.println("+++++++++dsfgdfg+++++++++xv+++++++++rrrrrr+++++++"+strradioselected);
%>

 <% if(strradioselected.equals("1"))
 {
 %>
<table width="90%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder" >
	 <tr>	
     <td  lass="selectedmenubg"><span class="dataLabel"><%=dbLabelBean.getLabel("label.handover.selectsite",strsesLanguage)%> </span> </td>
     <td ><span class="dataLabel">
       <select name="site_id" class="textBoxCss" onChange="getSiteID();"> <option value="-1"><%=dbLabelBean.getLabel("label.handover.selectsite",strsesLanguage)%> </option>
        <% 
            sSqlStr = "select SITE_ID,SITE_NAME from m_site where STATUS_ID=10 AND APPLICATION_ID=1 order by 2";
          rs = bean.executeQuery(sSqlStr);
          //System.out.println("sSqlStr==33333333333333=="+sSqlStr);
          while(rs.next()){
                  %>
                <option value="<%=rs.getString(1)%>" ><%=rs.getString(2)%></option>     
	       
	       <%} %>
	       </td>
    </tr>
	 <script> 
	  document.myform.site_id.value='<%=strsite_id%>'
	 
	 </script>

</table>
<%} %>
<div id = "modalContents">
	<table width="90%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder" id="detailTable">
		<thead>
		<%  if(nameList.size() > 0) {
		%>	<tr>
				<th class="selectedmenubg" id="searchTd" align="right" height="22px" colspan="4"></th>
			</tr>
		<%	} %>	
			<tr>	
				<th width="10%" class="formhead"><%=dbLabelBean.getLabel("label.global.sno",strsesLanguage)%> </th>
				<th width="10%" class="formhead"><%=dbLabelBean.getLabel("label.handover.select",strsesLanguage)%> </th>		
				<th width="40%" class="formhead"><%=dbLabelBean.getLabel("label.mylinks.fullname",strsesLanguage)%> </th>
				<th width="40%" class="formhead"><%=dbLabelBean.getLabel("label.mylinks.reportsto",strsesLanguage)%> </th>
			</tr>	
		</thead>
		<tbody>	  
			<!-- <tr align="left"> -->
			<%  for (int i=0;i<nameList.size();i++){ %>
				<% int serialno =i+1; %>
			<tr align="left">
				<td  class="formtr1"><%=serialno%>
				 
				 <% if(i==0)
					{ %>
				<td width="57" class="formtr1">
					<input type=radio class="formtr1" name="names"  value="<%=nameArray[i]%>" onClick="return 	testResults('<%=i%>','<%=useridArray[i]%>','<%=strFlag%>');">
				<%	} else { %>
				<td width="57" class="formtr1">
					<input type=radio class="formtr1" name="names"  value="<%=nameArray[i]%>" onClick="return testResults('<%=i%>','<%=useridArray[i]%>','<%=strFlag%>');">
				<% }%>		
				<td  class="formtr1"><%=nameArray[i] %>
				<td  class="formtr1"><%=namereportArray[i] %>
				</tr>		
			<% 	}
				if(nameList.size() == 0) {
			%>	<tr class="formtr1">
					<td colspan="7" style="text-align: center;font-weight: bold;color:red;">
						<%=dbLabelBean.getLabel("label.global.norecordfound",strsesLanguage)%>
					</td>							
				</tr>
				<script>
					$('table#detailTable thead').hide();
				</script
			<%	}%>
			</td>
		 	</tr>
		</tbody>
		<tfoot class="formtr1" style="text-align: center;font-weight: bold;color:red;">
        	<tr style='display:none;'>
	            <td colspan='7'>
	            	<%=dbLabelBean.getLabel("label.global.norecordfound",strsesLanguage)%>
	            </td>
          	</tr>
		</tfoot> 
	</table>
</div>
  <input type="hidden" name="lang" value="<%=strsesLanguage %>">
  <script type="text/javascript">
  $(document).ready(function () {
	  if($("table#detailTable").find('tbody:first tr').length > 0) {
		  $("#detailTable tbody tr").quicksearch({
	             labelText: '<%=dbLabelBean.getLabel("label.global.search",strsesLanguage)%> : ',
	             attached: '#searchTd',
	             position: 'append',
	             delay: 100,             
	             loaderText: '',
	             onAfter: function() {
	                 if ($("#detailTable tbody tr:visible").length != 0) {
	                     $("#detailTable").trigger("update");
	                     $("#detailTable").trigger("appendCache");
	                     $("#detailTable tfoot tr").hide();
	                     $("#loader").hide();
	                 }
	                 else {
	                     $("#detailTable tfoot tr").show();
	                 }
	             }
	  		});
	  }
  });
  </script>
</FORM>
</body>
</html>