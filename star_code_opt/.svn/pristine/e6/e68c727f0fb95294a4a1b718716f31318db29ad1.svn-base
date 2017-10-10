<%@ include  file="importStatement.jsp" %>
<html>
<head>
<%-- include remove cache  --%>
<%@ include  file="cacheInc.inc" %>
<%-- include header  --%>
<%@ include  file="headerIncl.inc" %>
<%-- include page with all application session variables --%>
<%@ include  file="application.jsp" %>
<%-- include page styles  --%>
<%-- <%@ include  file="systemStyle.jsp" %> --%>
<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>

<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
<%

Connection con	=		null;			    // Object for connection
Statement stmt	=		null;			    // Object for Statement
ResultSet rs	=		null;				// Object for ResultSet
String	strSqlStr	=	""; 				// For sql Statements

%>

<script language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></script>
<script type="text/javascript" src="ScriptLibrary/jQueryMaster.js?buildstamp=2_0_0"></script>

<style type="text/css">
a.searchResultStats{
cursor: pointer;
text-decoration: none;
}
</style>

</head>


<body>
	<div id="helpManualMainBlockDivInner">
		<div id="helpManualLangBlockDiv">
			<table width="60px" border="0" cellspacing="0" cellpadding="0" align="center">
				<!-- <tr><td class="statisticsTxt">Select Language</td></tr>
				<tr><td height="2px"></td></tr> -->
				<tr>
					<td>
						<table width="60px" border="0" cellspacing="0" cellpadding="0" align="center">
							<tr>
								<td width="40%" style="padding:0 4px 0 0px;">
									<a href="#" title="English" onClick="window.open('STAR_Manuals.jsp?lang=en','STAR','location=no,scrollbars=yes,resizable=yes,width=850,height=500')">
			            				<div class="">
											<img src="images/flag-english-70.png?buildstamp=2_0_0" border=0 width="40px" height="40px">
										</div>
			            			</a>
								</td>
								<td width="40%" style="padding:0 0px 0 4px;">
									<a href="#" title="German" onClick="window.open('STAR_Manuals.jsp?lang=gr','STAR','location=no,scrollbars=yes,resizable=yes,width=850,height=500')">
			            				<div class="">
											<img src="images/flag-german-70.png?buildstamp=2_0_0" border=0  width="40px" height="40px">
										</div>
			            			</a>
								</td>
							</tr>
							<tr>
								<td colspan="3" height="5px"></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</div>
	</div>	
</body>
</html>
<script type="text/javascript">

	$(document).ready(function() {
		
		$("div#closeDiv").live('click', function() {
			$('div.helpManualcontainer_div',top.frames['middle'].document).css("display", "none");
			$('div.helpManualcontainer_div',top.frames['middle'].frames['footer_11'].document).css("display", "none");
		});
		
		$('body',top.frames['middle'].document).live('click', function() {
			$('div.helpManualcontainer_div',top.frames['middle'].document).css("display", "none");
		});
		
		$('body',top.frames['bottom11'].document).live('click', function() {
			$('div.helpManualcontainer_div',top.frames['middle'].document).css("display", "none");
		});		
	
	});
	
</script>