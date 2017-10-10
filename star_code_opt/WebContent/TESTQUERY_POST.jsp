<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:Sachin Gupta
 *Date of Creation 		:08 DEC 2006
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:.
 *Modification 			: 
 *Reason of Modification: 
 *Date of Modification  : 
 *Revision History		:
 *Editor				:Editplus
*******************************************************/%>
<html>
<head>
<%@ include  file="importStatement.jsp" %>
<%-- include remove cache  --%>
<%@ include  file="cacheInc.inc" %>
<%-- include header  --%>
<%@ include  file="headerIncl.inc" %>
<%-- include page with all application session variables --%>
<%--<%@ include  file="application.jsp" %>--%>
<%-- include page styles  --%>
<%-- <%@ include  file="systemStyle.jsp" %> --%>
<!--Create the DbConnectionBean object for createConnection-->
<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbConBean1" scope="page" class="src.connection.DbConnectionBean" />


<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />

<%
// Variables declared and initialized
Connection conn         =    null;
conn       = dbConBean1.getConnection();           //GET Connection
ResultSet objRs			=		null;			  // Object for ResultSet
String	strSqlStr	=	""; // For sql Statements
int iCls = 0;
String strStyleCls = "";
String strNoOfColumn = "";
String strTableName  = "";
strSqlStr			= request.getParameter("inputQuery");
strNoOfColumn		= request.getParameter("noOfColumn");
strTableName		= request.getParameter("inputTableName");
int intNoOfColumn	= Integer.parseInt(strNoOfColumn);


%>
<base target="middle">
</head>
<body><script type="text/javascript" language="JavaScript1.2" src="menu/menu_cnt.js?buildstamp=2_0_0"></script>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="77%" height="45" class="bodyline-top">
	<ul class="pagebullet">
      <li class="pageHead">QUERY RESULTS</li>
    </ul></td>
    <td width="23%" align="right" valign="bottom" class="bodyline-top">
	<table width="39%" align="right" border="0" cellspacing="0" cellpadding="0">
      <tr align="right">
		
		<td width="52%" align="right"><a href="TESTQUERY.jsp" title="Back">Back</a></td>

        <td width="52%" align="right"><a href="M_desigAdd.jsp"><img src="images/IconNew.gif?buildstamp=2_0_0" width="49" height="24" border="0" /></a></td>
        <td width="48%" align="right"><a href="#" onClick="window.print();"><img src="images/IconPrint.gif?buildstamp=2_0_0" width="49" height="24" border="0" /></a></td>
      </tr>
    </table>
	</td>
  </tr>
</table>
<br>
<table width="100%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder">
<tr align="left" class="formhead"> 
<%
try
{
	int j = 1;
	String strColumnDetails  =  "";
	ResultSet rsColumns = null;
	DatabaseMetaData meta = conn.getMetaData();
    rsColumns = meta.getColumns(null, null, strTableName, null);
    while (rsColumns.next()) 
	{
      String columnName = rsColumns.getString("COLUMN_NAME");
      //System.out.println("column name=" + columnName);
      String columnType = rsColumns.getString("TYPE_NAME");
      //System.out.println("type:" + columnType);
      int size = rsColumns.getInt("COLUMN_SIZE");
      //System.out.println("size:" + size);
      int nullable = rsColumns.getInt("NULLABLE");
      if (nullable == DatabaseMetaData.columnNullable) {
        //System.out.println("nullable true");
      } else {
        //System.out.println("nullable false");
      }
      int position = rsColumns.getInt("ORDINAL_POSITION");
      //System.out.println("position:" + position);
      strColumnDetails = columnName+"("+columnType+")("+size+")";		
	  if(j <= intNoOfColumn)
	  {
%>
	  		<td width="8%"><%=strColumnDetails%></td>
<%
	  }
	  j++;

	  //System.out.println("Column Details is====="+columnName+"("+columnType+")("+size+")");
    }
	rsColumns.close();
%>
</tr>

<tr align="left" class="formhead"> 
<%
	for(int i=1; i<=intNoOfColumn; i++)
	{
%>
		
		<td width="8%"><%=i%></td>
<%
	}
%>

</tr>
<%
	String strDesigName = "";
	String strDesigDesc = "";
	String strCreatedDate = "";
	String strDesigId	=	"";
	
	objRs				= dbConBean.executeQuery(strSqlStr);
	while(objRs.next())
	{	
		if (iCls%2 == 0) { 
		strStyleCls="formtr2";
	    } else { 
		strStyleCls="formtr1";
		} 
	    iCls++;
%>
    <tr class="<%=strStyleCls%>"> 

<%
	for(int k=1; k<=intNoOfColumn; k++)
	{
	//System.out.println("k is======="+k);
%>
    <td width="8%"><%=objRs.getString(k)%></td>
<%  
	}
%>
  
  </tr>
  <%
				
	}
	objRs.close();

}
catch(Exception e)
{
	System.out.println("Error in TESTQUERY_POST.jsp"+e);
}
dbConBean.close();   //Close All Connection
dbConBean1.close();   //Close All Connection
%>
 <tr>
    <td height="1" colspan="2" align="center" class="bodyline-bottom"></td>
  </tr>
</table>
<br>
</body>
</html>
