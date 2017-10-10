<%@ page pageEncoding="UTF-8" %>
<%@ include  file="importStatement.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%-- include remove cache  --%>
<%@ include  file="cacheInc.inc" %>
<%-- include header  --%>
<%@ include  file="headerIncl.inc" %>
<%-- include page with all application session variables --%>
<%@ include  file="application.jsp" %>
<!--Create the DbConnectionBean object for createConnection-->
<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>


<!--Create the DbUtilityMethods object for utility methods-->
<jsp:useBean id="dbUtility" scope="page" class="src.connection.DbUtilityMethods" />

<%-- include page styles  --%>
<%-- <%@ include  file="systemStyle.jsp" %> --%>

<%
String strUserId = "";
strUserId = Suser_id;
%>
<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
<script src="ScriptLibrary/date-picker-disable-past-date.js?buildstamp=2_0_0" type="text/javascript"></script>
<script src="ScriptLibrary/jquery-1.8.3.js?buildstamp=2_0_0" type="text/javascript"></script>
<script src="ScriptLibrary/date.js?buildstamp=2_0_0" type="text/javascript"></script>
<script src="ScriptLibrary/daterangepicker.jQuery.js?buildstamp=2_0_0" type="text/javascript"></script>
<script src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0" type="text/javascript"></script>
<script src="scripts/CommonValida.js?buildstamp=2_0_0" type="text/javascript"></script>
<script src="ScriptLibrary/jQueryMaster.js?buildstamp=2_0_0" type="text/javascript"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.4/jquery.min.js?buildstamp=2_0_0" type="text/javascript"></script>
<script src="http://maps.google.com/maps/api/js?sensor=false" type="text/javascript"></script> 
<script src="ScriptLibrary/markerwithlabel.js?buildstamp=2_0_0" type="text/javascript"></script>
<script src="ScriptLibrary/jquery.tablesorter.js?buildstamp=2_0_0" type="text/javascript"></script>
<script src="ScriptLibrary/jquery.dataTables.js?buildstamp=2_0_0" type="text/javascript"></script>
<script src="ScriptLibrary/jquery.quicksearch.js?buildstamp=2_0_0" type="text/javascript"></script>
<style type="text/css">
#map_canvas { height: 100%; }
.mapIconLabel { color: #000000; font-family: "Lucida Grande", "Arial", sans-serif; font-size: 12px; font-weight: bold; text-align: center; width: 25px; white-space: nowrap; }
.trvDetailsText th { word-wrap:break-word; font-size: 8pt; font-family: Arial, Sans-Serif; }
.trvDetailsText td { font-size: 8pt; font-family: Arial, Sans-Serif; }
.trvDetailsText .serialNo { width:28px!important; }
#goBtn { cursor: pointer; cursor: hand; }
td#travellerNameTd a { cursor: pointer; cursor: hand; font-size: 8pt; font-family: Arial, Sans-Serif; color:#3D3D3D; text-decoration: none; }
td#travellerNameTd a:hover { cursor: pointer; cursor: hand;  font-family:Arial, Sans-Serif; font-weight:normal; font-size:8pt; color:#00369B; text-decoration: underline; } 
/* tables */
table.tablesorter { font-family:arial; background-color: #CDCDCD; margin:0; font-size: 8pt; width: 100%; text-align: left; }
table.tablesorter thead tr th, table.tablesorter tfoot tr th { background-color: #dddddd; border: 1px solid #FFF; font-size: 8pt; padding: 2px; }
table.tablesorter thead tr .header { background-image: url(images/bg.gif); background-repeat: no-repeat; background-position: center right; cursor: pointer; }
table.tablesorter tbody td { color: #3D3D3D; padding: 2px; background-color: #f7f7f7; vertical-align: top; }
table.tablesorter tbody tr.odd td {	background-color:#f2f2f2; }
table.tablesorter thead tr .headerSortUp { background-image: url(images/asc.gif); }
table.tablesorter thead tr .headerSortDown { background-image: url(images/desc.gif); }
table.tablesorter thead tr .headerSortDown, table.tablesorter thead tr .headerSortUp { background-color: #dddddd; }

div.quicksearch { font-size: 8pt; font-weight: bold; color: #000000; font-family: 'Arial, Sans-Serif'; }
div.quicksearch input { width:100px; height:18px; background:#ffffff; color:#666666; font-family:'Arial, Sans-Serif'; font-size:8pt; border:#888888 1px solid; }
</style>

</head>
<body>
<form name="frm">
<div id="waitingData" style="display:none;">	    
	 <img src="images/maploading.GIF?buildstamp=2_0_0" width="80" height="80" border="0" /> 
</div>
<input type="hidden" id="userId" value="<%=strUserId%>" />
<table width="100%" align="center" border="0" cellpadding="5" cellspacing="1">
  <tr>
    <td width="77%" height="35" class="bodyline-top">
		<ul class="pagebullet">
	      	<li class="pageHead"><%=dbLabelBean.getLabel("label.report.starsreportmyteamlocation",strsesLanguage) %></li>
	    </ul>
    </td>
    <td align="right" valign="bottom" class="bodyline-top">
		<table align="right" border="0" cellspacing="0" cellpadding="3">
  			<tr align ="right">
  			  <td>
	  			<ul id="list-nav">
					<li>
						<a href="#" onClick="javascript:window.open('M_Location_MyTeam.jsp','_blank','scrollbars=yes, resizable=on,width=1000,height=500');">My Team</a>
					</li>
				</ul>
	  		  </td>
			  <td>
			     <ul id="list-nav">
			        <li><a href="#" onClick="javascript:top.window.close();" style="width:60px;"><%=dbLabelBean.getLabel("button.global.close",strsesLanguage) %></a></li>
			     </ul>
			  </td>
	  		</tr>
	  	</table>
	</td>	
  </tr>
 </table>
<table width="98%" align="center" border="0" cellpadding="1" cellspacing="0" class="formborder">
	<tr align="left">     
		<td class="formtr2" align="left" style="width:60px;">&nbsp;<%=dbLabelBean.getLabel("label.user.date",strsesLanguage) %></td>
		
		<td class="formtr1" align="left" style="width:150px;">
			<input type="textbox" name="dt_date" id="dt_date" size='10' maxlength="10" class="textBoxCss" onFocus="javascript:vDateType='DD/MM/YYYY'" onKeyUp="DateFormat(this,this.value,event,false,'DD/MM/YYYY','Invalid Date.Please Re-Enter')" onBlur="DateFormat(this,this.value,event,true,'DD/MM/YYYY','Invalid Date.Please Re-Enter')"  value="" onChange="javascript:while(''+this.value.charAt(this.value.length-1)==' ')this.value=this.value.substring(0,this.value.length-1);">
			<a href="javascript:show_calendar('frm.dt_date','a','a','DD/MM/YYYY');" onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;"><img border="0" name="imageField" src="images/calender.png?buildstamp=2_0_0" align="absmiddle"></a>
		</td>
		
		<td class="formtr2" align="left" style="width:120px;">&nbsp;<%=dbLabelBean.getLabel("label.report.showmyteam",strsesLanguage) %></td>
		
		<td class="formtr1" align="left" style="width:20px;">
			<input type="checkbox" name="chk_myteam" id="chk_myteam" value="Y" checked="checked">
		</td>
		
		<td class="formtr2" style="width:40px; text-align:right;">&nbsp;>>&nbsp;</td>
		
		<td class="formtr1" align="left">&nbsp;
			<img src="images/gobutton.png?buildstamp=2_0_0" width="23" height="23" border="0" id="goBtn" alt="Go"/>
		</td>
	</tr>	
</table>
<div style="width:98.5%; margin:5px 5px 5px 5px; clear:both; float:left;">
	<div id="map" style="float:left;"></div>
	<div id="travellerDetialTableDiv" style="float:right;">
		<div id="radioBtDiv" style="width:100%;  float:left; display:none;">
			<table width="100%" align="center" border="0" cellpadding="1" cellspacing="0" class="formborder">
				<tr>
					<td class="formtr1" align="center" style="width:20px;"><input type="radio" name="locRd" id="detailRd"/></td>
					<td valign="top" align="left" class="formtr2"><span id="searchText"><%=dbLabelBean.getLabel("label.report.detail",strsesLanguage) %></span></td>
					<td class="formtr1" align="center" style="width:20px;"><input type="radio" name="locRd" id="summaryRd" /></td>
					<td valign="top" align="left" class="formtr2"><span id="searchText"><%=dbLabelBean.getLabel("label.report.summary",strsesLanguage) %></span></td>
				</tr>
			</table>			
		</div>
		<div id="searchFilterDiv" style="margin-top:3px; width:100%; float:left; display:none;">
			<table width="100%" align="center" border="0" cellpadding="1" cellspacing="0" class="formborder">
				<tr>
					<td class="formtr2" align="left" id="searchTd"></td>
				</tr>
			</table>			
		</div>	
		<div id="travellerDataDiv" style="margin-top:3px; float:left; display:none;">
			<table width="100%" border="0" align="center" cellpadding="1" cellspacing="0" class="trvDetailsText tablesorter" id="travellerDetailTbl" style="border-top:1px solid #b1b1b1; border-left:1px solid #b1b1b1;"></table>
		</div> 
		<div id="cityDataDiv" style="margin-top:3px; float:left; display:none;">
			<table width="100%" border="0" align="center" cellpadding="1" cellspacing="0" class="trvDetailsText tablesorter" id="summaryDetailTbl" style="border-top:1px solid #b1b1b1; border-left:1px solid #b1b1b1;"></table>
		</div>
	</div>	 
</div>
</form>
<script language="javascript">
//<![CDATA[
           
var addresses = [];
var travellerDetailTable ="";
var travellerDetailTableTr = "";
var travellerSummaryTable ="";
var travellerSummaryTableTr = "";
var noDataTable1 = "";
var noDataTable2 = "";
var onPageLoad = true;
var nextAddress = 0;
var infowindow;
var latlng;
var mapOptions;
var map;
var bounds;
var markerSelected;
var infowindowSelected;
var personNameClickFlag = false;    
var online = false;
var searchDivShowFlag = false;
           
//Set Current Date
var date = Date.today().clearTime();
var currentDate = date.toString("dd/MM/yyyy");
$("input[name=dt_date]").val(currentDate);

var mapDivWidth = screen.width * 0.752;
var mapDivHeight = screen.height * 0.88;
var trvDetailDivWidth = screen.width * 0.20;
var trvDetailDivHeight = screen.height * 0.88;
$('div#map').css({'width':""+mapDivWidth+"", 'height': ""+mapDivHeight+""});
$('div#travellerDetialTableDiv').css({'width':""+trvDetailDivWidth+"", 'height': ""+trvDetailDivHeight+""});
$('div#travellerDataDiv').css({'width':""+trvDetailDivWidth+"", 'height': ""+(trvDetailDivHeight-40)+"",'overflow-x': 'auto', 'overflow-y': 'auto'});
$('div#cityDataDiv').css({'width':""+(trvDetailDivWidth-3)+"", 'height': ""+(trvDetailDivHeight-12)+"",'overflow-x': 'auto', 'overflow-y': 'auto'});


// check whether this function works (online only)
function checkInternetConnection() {
	
// 	if(window.google && typeof(window.google != 'undefined')) {
// 		var markerWithLabelScript = 'ScriptLibrary/markerwithlabel.js';
// 		$('<script />', { type : 'text/javascript', src : markerWithLabelScript}).appendTo('head');
// 		online = true;
// 	} else if(!window.google || typeof(window.google == 'undefined')) {
// 	  online = false;
// 	}	

if (typeof google === 'object' && typeof google.maps === 'object') {
	online = true;
   } else {
    online = false;
   }	
}


//Show Waiting Div
function openWaitingProcess() {
	personNameClickFlag = false;
	var dv = document.getElementById("waitingData");
	if(dv != null) {
		$('div#map').css({'z-index':"-1"});
		$('div#waitingData').css({'z-index':"1"});
		var xpos = mapDivWidth * 0.50;
		var ypos = mapDivHeight * 0.50 ;   
		
		dv.style.position="absolute";       		
		dv.style.left=(xpos-10)+"px";
		dv.style.top=(ypos)+"px";
		
		document.getElementById("waitingData").style.display="block";
	}
}

//Hide Waiting Div
function closeDivRequest() {
	personNameClickFlag = true;	
	document.getElementById("waitingData").style.display="none";
	$('div#map').css({'z-index':"1"});
	$('div#waitingData').css({'z-index':"-1"});
}
 
//$(document).ready() block Start
$(document).ready(function() {
	var userId = "";
	var dt_date = "";
	var chk_myteam = "";
	var urlParams = "";
	var lang = "";
	lang = '<%=strsesLanguage%>';
	
	if($("#chk_myteam").is(':checked')) {
		$(this).val("Y");								
	} else if($("#chk_myteam").not(':checked')) {
		$(this).val("N");
	}							
	
	
	//Show Location Data On Page Load
	if(onPageLoad) {
		checkInternetConnection();
		if(online) {
			clearMapData();	
			markerSelected = new MarkerWithLabel();
			markerSelected.setMap(null);
			userId = document.getElementById("userId").value;
			dt_date= document.getElementById("dt_date").value;
		    chk_myteam = document.getElementById("chk_myteam").value;	    
		 	urlParams = "userId="+userId+"&dt_date="+dt_date+"&chk_myteam="+chk_myteam+"&lang="+lang;
		 	showLocationData(urlParams);
		} else {
			alert("Internet connection doesn't exist!");
		}
	}	
	
	// Show Location Data Go button click event
	$("#goBtn").click(function() {
		checkInternetConnection();
		if(online) {
			clearMapData();
			onPageLoad = false;
			markerSelected = new MarkerWithLabel();
			markerSelected.setMap(null);
			userId = document.getElementById("userId").value;
			dt_date = document.getElementById("dt_date").value;
		    chk_myteam = document.getElementById("chk_myteam").value;	    
		 	urlParams = "userId="+userId+"&dt_date="+dt_date+"&chk_myteam="+chk_myteam+"&lang="+lang;
		 	showLocationData(urlParams);
		} else {
			alert("Internet connection doesn't exist!");
		}
	});	
	
	//Clear map data on Page Load and Go button click
	function clearMapData() {
		 //====== Create map objects ======
	     infowindow = new google.maps.InfoWindow({ maxWidth: 300 });
	     latlng = new google.maps.LatLng(41.87194, 11.56738);
	     mapOptions = {
				center: latlng,
				zoom: 2,
				mapTypeId: google.maps.MapTypeId.ROADMAP
	     };
	     
	     map = new google.maps.Map(document.getElementById("map"), mapOptions);
	     bounds = new google.maps.LatLngBounds();
	     
	     
	     
	     google.maps.event.addListener(infowindow, 'closeclick', function() {
         	if(this.close) {
         		map.setZoom(2);
         		map.setCenter(latlng);         		
         	}	         	
	    });
	     
	     openWaitingProcess();
	}
	
	//Start [showLocationData]
	function showLocationData(urlParams) {		
	    jQuery.ajax({
	            type: "post",
	            url: "SearchEmployeeLocation",
	            data: urlParams,
	            dataType : 'json',
	            success: function(result) {
	            	 //Start [result!=null]
	            	 if(result!=null) {
	            		 nextAddress = 0;
	            		 addresses = [];
	            		 var personCity = "";
            			 var personCount = "";
            			 var personDestinationHtml = "";
            			 var personToolTip = "";
            			 var pd ={};
            			 
            			 $("#searchTd").html('');
            			 document.getElementById("radioBtDiv").style.display="block";
            			 $('#detailRd').attr('checked', 'checked');
            			 
            			 if($('#detailRd').attr('checked')) {	            			
	            			 //document.getElementById("searchFilterDiv").style.display="block";
	            			 document.getElementById("travellerDataDiv").style.display="block";
	            			 document.getElementById("cityDataDiv").style.display="none";
	            		  } else {
	            			 //document.getElementById("searchFilterDiv").style.display="none";
	            		     document.getElementById("travellerDataDiv").style.display="none"; 
	            		     document.getElementById("cityDataDiv").style.display="block";
	            		  }
            			 
	            		 $("#travellerDetailTbl").find("thead").remove();
						 $("#travellerDetailTbl").find("tbody").remove();
						 $("#travellerDetailTbl").find("tfoot").remove();
						 travellerDetailTable = $("#travellerDetailTbl");
						 
						 $("#summaryDetailTbl").find("thead").remove();
						 $("#summaryDetailTbl").find("tbody").remove();
						 travellerSummaryTable = $("#summaryDetailTbl");
	            		 
						 //Start [$.each]
	            		 $.each(result, function(key,value) {
	            			 if(typeof(value['City']) == 'undefined' || value['City'] == null) {}
	            			 else { 
		            			 personCity = value['City'];
		            			 personCount = value['PersonCnt'];
		            			 personDestinationHtml = value['destinationHtml'];
		            			 personToolTip = value['personToolTip'];		            			 
		            			 pd ={};
		            			 pd ["place"] =  personCity;
		            			 pd ["count"] =  personCount;
		            			 pd ["destinationHtml"] =  personDestinationHtml;
		            			 pd ["pToolTip"] =  personToolTip;
		            			 addresses.push(pd);
	            			 } 
            			 if(typeof(value['travellerDetailTableTr']) == 'undefined' || value['travellerDetailTableTr'] == null) {}
            			 else { travellerDetailTableTr = $(value['travellerDetailTableTr']); }
            			 
            			 if(typeof(value['travellerSummaryTableTr']) == 'undefined' || value['travellerSummaryTableTr'] == null) {}
            			 else { travellerSummaryTableTr = $(value['travellerSummaryTableTr']); }
	            		});  //End [$.each]
	            		 
	            		 travellerDetailTableTr.appendTo(travellerDetailTable);
	            		 travellerSummaryTableTr.appendTo(travellerSummaryTable);
	            		 
	            		 if($(travellerDetailTable).find('tbody:first tr').length > 0) {
	            			 searchDivShowFlag = true;
	            			 document.getElementById("searchFilterDiv").style.display="block";
	            			 $(travellerDetailTable).dataTable({ "retrieve": true, "bPaginate": false, "bInfo": false,  "bFilter": false, "bDestroy": true});
							 $(travellerDetailTable).tablesorter({ widgets: ['zebra'] });							 
							 $(travellerDetailTable).find("tbody tr").quicksearch({
					             labelText: '<%=dbLabelBean.getLabel("label.global.search",strsesLanguage) %> : ',
					             attached: '#searchTd',
					             position: 'append',
					             delay: 100,             
					             loaderText: '',
					             onAfter: function() {
					                 if($(travellerDetailTable).find("tbody tr:visible").length != 0) {
					                     $(travellerDetailTable).find("tfoot tr").hide();					                     
					                 } else {
					                     $(travellerDetailTable).find("tfoot tr").show();
					                 }
					             }
					         });
	            		 } else {
	            			 searchDivShowFlag = false;
	            			 document.getElementById("searchFilterDiv").style.display="none";
	            			 noDataTable1 = "<tr bgcolor='#ffffff' valign='top' style='vertical-align: top;'><td colspan='3' style='border-bottom:1px solid #b1b1b1; border-right:1px solid #b1b1b1;'><%=dbLabelBean.getLabel("label.global.norecordfound",strsesLanguage) %></td></tr>";
	            			 $("#travellerDetailTbl tbody").append(noDataTable1);
	            		 }
	            		 
	            		 if($(travellerSummaryTable).find('tbody:first tr').length > 0) {
	            			 $(travellerSummaryTable).dataTable({ "retrieve": true, "bPaginate": false, "bInfo": false,  "bFilter": false, "bDestroy": true});
							 $(travellerSummaryTable).tablesorter({ widgets: ['zebra'] });							 
	            		 } else {
	            			 noDataTable2 = "<tr bgcolor='#ffffff' valign='top' style='vertical-align: top;'><td colspan='3' style='border-bottom:1px solid #b1b1b1; border-right:1px solid #b1b1b1;'><%=dbLabelBean.getLabel("label.global.norecordfound",strsesLanguage) %></td></tr>";
	            			 $("#summaryDetailTbl tbody").append(noDataTable2);
	            		 }
	            		    
	            		 
	            		 $('div#map').css({'border-color': '#b1b1b1', 'border-width':'1px', 'border-style':'solid'});
	            		 
	            		// ======= Call that function on Go button click event  =======
	            		 theNext(addresses);
	            		
	            		 $('input[type="radio"]').click(function() {
	            		       if($(this).attr('id') == 'detailRd') {
	            		    	   if(searchDivShowFlag) {
	            		    	   	document.getElementById("searchFilterDiv").style.display="block"; 
	            		    	   } else {
	            		    		  document.getElementById("searchFilterDiv").style.display="none";   
	            		    	   }
	            		    	   document.getElementById("travellerDataDiv").style.display="block";  
	            		    	   document.getElementById("cityDataDiv").style.display="none";	
	            		       } else if($(this).attr('id') == 'summaryRd') {
	            		    	   document.getElementById("searchFilterDiv").style.display="none"; 
	            		    	   document.getElementById("travellerDataDiv").style.display="none";
	            		    	   document.getElementById("cityDataDiv").style.display="block";	            		    	
	            		       }
	            		   });
	            	 } //End [result!=null]
	        	}
	      });
	} //End [showLocationData]
	
	
	//Set My Team checkbox value
	$("#chk_myteam").click(function () {
		if($(this).is(':checked')) {
			$(this).val("Y");								
		} else if($(this).not(':checked')) {
			$(this).val("N");
		}							
	});
	
	
	//Person name click event
	$("#travellerNameTd").live('click', function(e) {
		checkInternetConnection();
		if(online) {
			if(!personNameClickFlag) {			
				e.preventDefault();
			} else if(personNameClickFlag) {			
				if(infowindowSelected) {
					infowindowSelected.close();
					markerSelected.setMap(null);
				}
			
				if(infowindow) {
					infowindow.close();
				}
			
				infowindowSelected = new google.maps.InfoWindow({ maxWidth: 300 });
			
				google.maps.event.addListener(infowindowSelected, 'closeclick', function() {
		         	if(this.close) {
		         		map.setZoom(2);
		         		map.setCenter(latlng);
		         		markerSelected.setMap(null);
		         	}	         	
	         	});
			
				var placeNameOfPerson = '';
				placeNameOfPerson = $.trim($(this).next().html());		
				for(var i = 0; i < addresses.length; i++) {
					var placeName = $.trim(addresses[i].place);
					if(placeName.toLowerCase() == placeNameOfPerson.toLowerCase()) {
						getAddressPerson(addresses[i].place, addresses[i].count, addresses[i].destinationHtml, addresses[i].pToolTip);
					}
				}
			}
		} else {
			alert("Internet connection doesn't exist!");
		}
	});
	
	
});
//$(document).ready() block End
	 
//===================== Create map (Page Load and Go Button Click Event)  =====================
		 
	 // delay between geocode requests
	 var delay = 100;     
     
     // ====== Geocoding ======
     function getAddress(search, next, count, desHtml, perToolTip) {
       var geo = new google.maps.Geocoder();
       geo.geocode({address:search}, makeCallback(search, next, count, desHtml, perToolTip));
       
	   	 function makeCallback(addressIndex) {		
		    var geocodeCallBack = function(results, status) {	    	
		    	 // If successful	    	 
		           if(status == google.maps.GeocoderStatus.OK) {
		        	 // Get marker position
		             var p = results[0].geometry.location;
		             var lat=p.lat();
		             var lng=p.lng(); 
					 var title = results[0].formatted_address;
					 var prcount = count;
					 var dsHtml = desHtml;
					 var prToolTip = perToolTip;				
					// Create a marker
		            createMarker(search,lat,lng,title,prcount,dsHtml,prToolTip);
		           } 
		           // ====== Decode the error status ======
		           else { 
		        	 // === if we were sending the requests to fast, try this one again and increase the delay
		             if(status == google.maps.GeocoderStatus.OVER_QUERY_LIMIT) {
		               nextAddress--;
		               delay++;
		             } 
		           } 
		           next(addresses);
		    	};
		    return geocodeCallBack;
			}
     }

    // ======= Function to create a marker
    function createMarker(add,lat,lng,title,prcount,dsHtml,prToolTip) {
      var contentString = dsHtml;      
      var marker = new MarkerWithLabel({
        position: new google.maps.LatLng(lat,lng),
        map: map,
		icon: 'images/map-icon1.png?buildstamp=2_0_0',
		title: title+'\n'+prToolTip,
		draggable: false,
		raiseOnDrag: false,
		labelContent:prcount,
		labelAnchor: new google.maps.Point(13, 30),
		labelClass: "mapIconLabel",
		labelInBackground: false
      });

     google.maps.event.addListener(marker, 'click', function() {
    	if(infowindowSelected) {
 			infowindowSelected.close(); 
 			markerSelected.setMap(null);
 	    }
        infowindow.setContent(contentString); 
        infowindow.open(map,marker);
        var infoTableHeight = $('table#infoTable').outerHeight();
        if(infoTableHeight > 120) {
        	$('div.gm-style-iw').css({'height': "120px",'overflow-y': 'auto', 'scrollbar-arrow-color': '#000000','scrollbar-base-color': '#fae5ae','scrollbar-track-color': '#fae5ae','scrollbar-face-color': '#fae5ae','scrollbar-highlight-color': '#fae5ae'});
        } else {
        	$('div.gm-style-iw').css({'height': "auto"});
        }        
      });
      bounds.extend(marker.position);
    }
	
     // ======= Function to call the next Geocode operation when the reply comes back        
     function theNext(addresses) {     	
       if(nextAddress < addresses.length) {
    	  // openWaitingProcess();
         setTimeout('getAddress("'+addresses[nextAddress].place+'",theNext, "'+addresses[nextAddress].count+'", "'+addresses[nextAddress].destinationHtml+'", "'+addresses[nextAddress].pToolTip+'")', delay);
         nextAddress++;
       } else { 
    	   closeDivRequest();
    	// Show map bounds    	    	 
         //map.fitBounds(bounds);    	 
       }
     }
     
     
//===================== Create map (Person Name Click Event)  =====================     
    // ====== Geocoding When Click on Person Name ======
    function getAddressPerson(searchPerson, countPerson, desHtmlPerson, perToolTipPerson) {
       var geo = new google.maps.Geocoder();
       geo.geocode({address:searchPerson}, makeCallbackPerson(searchPerson, countPerson, desHtmlPerson, perToolTipPerson));
       
   	function makeCallbackPerson(addressIndex) {		
	    var geocodeCallBackPerson = function(results, status) {	    	
	    	 // If successful	    	 
	           if(status == google.maps.GeocoderStatus.OK) {
	        	 // Get marker position
	             var pPerson = results[0].geometry.location;
	             var latPerson=pPerson.lat();
	             var lngPerson=pPerson.lng(); 
				 var titlePerson = results[0].formatted_address;
				 var prcountPerson = countPerson;
				 var dsHtmlPerson = desHtmlPerson;
				 var prToolTipPerson = perToolTipPerson;				
				// Create a marker
	            createMarkerPerson(searchPerson,latPerson,lngPerson,titlePerson,prcountPerson,dsHtmlPerson,prToolTipPerson);
	           }          
	    	};
	    return geocodeCallBackPerson;
		}
     }

    // ======= Function to create a marker When Click on Person Name
    function createMarkerPerson(add,latPerson,lngPerson,titlePerson,prcountPerson,dsHtmlPerson,prToolTipPerson) {
      var contentStringPerson = dsHtmlPerson;      
        markerSelected = new MarkerWithLabel({
        position: new google.maps.LatLng(latPerson,lngPerson),
        map: map,
		icon: 'images/map-icon2.png?buildstamp=2_0_0',
		title: titlePerson+'\n'+prToolTipPerson,
		draggable: false,
		raiseOnDrag: false,
		labelContent:prcountPerson,
		labelAnchor: new google.maps.Point(13, 30),
		labelClass: "mapIconLabel",
		labelInBackground: false
      });
      
      infowindowSelected.setContent(contentStringPerson);
      infowindowSelected.open(map,markerSelected);
      
        var infoTableHeight = $('table#infoTable').outerHeight();
        if(infoTableHeight > 120) {
        	$('div.gm-style-iw').css({'height': "120px",'overflow-y': 'auto', 'scrollbar-arrow-color': '#000000','scrollbar-base-color': '#fae5ae','scrollbar-track-color': '#fae5ae','scrollbar-face-color': '#fae5ae','scrollbar-highlight-color': '#fae5ae'});
        } else {
        	$('div.gm-style-iw').css({'height': "auto"});
        } 
      bounds.extend(markerSelected.position);
    }

 //]]>
</script>
</body>
</html>