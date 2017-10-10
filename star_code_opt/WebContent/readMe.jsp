<!doctype html>
<!-------------------------------------------------------
*Copyright (C) 2000 MIND 
*All rights reserved.
*The information contained here in is confidential and 
*proprietary to MIND and forms the part of the MIND 
*CREATED BY		:	Sandeep Malik
*Date			:	27-MAY-2015
*Description	:	Page for showing getting started guide
*Project		:	STARS(REQUISITION APPROVAL SYSTEM )
-------------------------------------------------------->
<html>
<head>
<%@ include file="application.jsp"%>
<link href="style/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="ScriptLibrary/jQueryMaster.js?buildstamp=2_0_0"></script>
		<script>
			function closeReadme(){
				$.ajax({
		            type: "post",
		            url: "updateUserFlashMessage.jsp",
		            data: '',
		            success: function(result){
					var res = jQuery.trim(result);
					$('#read-overlay').css('display','none');
	            },
	            complete: function(){
	            	},
				error: function(){
	            }
	          });
				 $(window.parent.document).find(".overlay").css('display','none');
				self.close();
			}
		</script>
</head>
<body>
	<div id="read-overlay">
		<div class="read-window">
			<div class="readme-heading">
				<label>What's New</label>
			</div>
			<div class="readme-container">
				<div class="read-me-content">
					<label class="read-me-date"><i>Release Date :
							28-MAY-2015</i></label>
							<br/>
					<h3 style="padding-left: 10px;">Following features have been added along with new theme in
						STARS:</h3>
					<h4>
						<u>Options at Home Page:</u>
					</h4>
					<ol>
						<li>Quick Links on Home Page for frequently used options like
							– Create Request, Approve Request and Search Request.</li>
						<li>A new option “Statistics” added on application header to
							view statistics of requests for current financial year.</li>
						<li>Useful Statistics of the requests where you are part of
							workflow. Default Statistics for current financial year and you
							can change the financial year.</li>
						<li>Quick links to view the “Returned” & “Rejected” requests
							which were created by you.</li>
						<br>
						<img class="read-me-content-img" src="images/slide1.png?buildstamp=2_0_0" />
					</ol>
					<div class="read-me-separator"></div>
					<h4>
						<u>Simplified & Single user interface for International &
							domestic request creation:</u>
					</h4>
					<p style="padding-left: 20px; text-align: justify;">Provision
						for Creating & Editing International/domestic travel request
						through single screen for individual traveler.</p>
					<ol>
						<li>With selection of Travel Type user can switch between
							International and Domestic Request.</li>
						<li>Global Airports are now mapped with destinations which
							will appear automatically while typing.</li>
						<li>Placement of important information on non-collapsible
							section for quick request creation: Billing client, Level 1 & 2
							Approver selections are shown with list of default approver(s)
							for complete view of Approval workflow.
						<li>Expand/Collapse feature in forex and personal detail
							section.</li>
						</li>
						<br>
						<img class="read-me-content-img" src="images/slide2.png?buildstamp=2_0_0" />
					</ol>
					<div class="read-me-separator"></div>
					<h4>
						<u>Enhanced Search Option:</u>
					</h4>
					<p style="padding-left: 20px; text-align: justify;">
						New search screen for searching International or Domestic Travel
						Request(s) through <b>Quick</b> and <b>Advance</b> Search Options.
					</p>
					<ol>
						<li><b>Quick Search:-</b> New Search option has been added
							which will provide wild search on some predefined fields of
							advance search.</li>
						<li><b>Advance Search:-</b> Various searchable parameters
							would be displayed where user can enter values for searching
							requests. New parameters have been added in the searchable
							fields.</li>
						<li>You can toggle between Quick & Advance Search option as
							per your choice.</li>
						<br>
						<img class="read-me-content-img" src="images/slide3.png?buildstamp=2_0_0" />
					</ol>
					<div class="read-me-separator"></div>
					<h4>
						<u>Requisition List Page:</u>
					</h4>
					<p
						style="padding-left: 20px; text-align: justify; padding-top: 0px;">
						Expand/Collapse feature on requisition list page to make it more
						user friendly.<br /> 
						<ol>
						<li>
						Count of requests are displayed against each
						section as per request status.
						</li>
						<li>One can expand the desired
						section to view the list of requests depending upon the
						requisition status.
						</li>
						</ol>
					</p>
					<span style="padding-left: 40px;"><img class="read-me-content-img"
						src="images/slide4.png?buildstamp=2_0_0" /></span>
					<div class="read-me-separator"></div>
					<h4><span style="color: red;"><b>*</b>Important Note</span></h4>
						<p style="padding-left: 10px;">You may get old content of STARS, so we recommend you to reset Internet Explorer settings to clean the browser cache.</p>
						<h4>Steps to reset browser setting:</h4>
					<ol>
						<li>Open Internet Explorer by clicking the Start button
						<img src="images/start_window.png?buildstamp=2_0_0"/>
						 . In the search box, type Internet Explorer, and then, in the list of results, click Internet Explorer.</li>
						<li>Click the Tools button<img src="images/tool.png?buildstamp=2_0_0"/> , and then click Internet options.</li>
						<li>Click the Advanced tab, and then click Reset.
						<br/>
						<p>Select the Delete personal settings check box if you would also like to remove browsing history, search providers, Accelerators, home pages, Tracking Protection, and ActiveX Filtering data.</p>
						</li>
						<li>In the Reset Internet Explorer Settings dialog box, click Reset.</li>
						<li>When Internet Explorer finishes applying default settings, click Close, and then click OK.</li>
						<li>Close Internet Explorer.<br/>
						<br/>Your changes will take effect the next time you open Internet Explorer.</li>
					</ol>
				</div>
			</div>
			<div class="readme-footer">
				<button class="formButton" onclick="closeReadme()">
					<label style="vertical-align: middle;">Close</label>
				</button>
			</div>
		</div>
	</div>
</body>
</html>