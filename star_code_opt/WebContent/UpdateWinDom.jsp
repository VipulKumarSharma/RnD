	<%
	/***************************************************
	 *The information contained here in is confidential and 
	 * proprietary to MIND and forms the part of the MIND 
	 *Author				:Shiv sharma 
	 *Date of Creation 		:04 Feb 2010
	 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
	 *Project	  			:STAR
	 *Operating environment :Tomcat, sql server 2000 
	 *Description 			:Updation of Windows user id & Domain Name
	 *Modification 			: 
	 *Reason of Modification:
	 *Date of Modification  : 
	 *Revision History		:
	 *Editor				:Editplus
	 *******************************************************/
	%>  
	
	<%@ include  file="importStatement.jsp" %>
	<%@ include  file="cacheInc.inc" %>
	<%@ include  file="headerIncl.inc" %>
	<!--Create Conneciton by useBean-->
	<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
	
	<!--Create the DbUtilityMethods object for utility methods-->
	<jsp:useBean id="dbUtility" scope="page" class="src.connection.DbUtilityMethods" />
	<HTML><head>
	 <script>
	 
	  
	 function checkfield()   
	 {
		var strDomain		=document.user.domain.value;
		var strWinuserid	=document.user.winuserid.value;
		  
	 
		if(strDomain=='')
		{
			alert('Please enter your Network Domain Name');
			document.user.domain.value="";
			document.user.domain.focus();
			flag=true;
			return false;
		}	
		if(strDomain.length>0)
			{
			var i= strDomain.indexOf(" "); 
			 
			if(i>0)
				{
				alert("Space is not allowed in Network Domain Name.");  
				document.user.domain.focus();
				return false;	 
			} 
		} 
		
		if(strWinuserid=='') 
		{
			alert('Please enter your Windows User Name');  
			document.user.winuserid.focus(); 
			flag=true;
			return false;
		}
		  
		
		if(strWinuserid.length>0) 
			{
			var i= strWinuserid.indexOf(" ");  
			if(i>0)
				{
				alert("Space is not allowed in Windows User Name.");    
				document.user.winuserid.focus(); 
				return false;  	 
			} 
		} 
		    
		    
		    //spacecheck(strDomain);
	 }
	 
	  
	 function test1(obj1, length, str)
	 {	
				var obj;
				if(obj1=='domain')
				{
					 obj = document.user.domain;
				}	
	
				if(obj1=='winuserid')
				{
					 obj = document.user.winuserid;
				}	
				 
				charactercheck(obj,str);    
				limitlength(obj, length);
				spaceChecking(obj);
	 }
	function clearfield(){    
		document.user.domain.value=""; 
		document.user.winuserid.value="";   
		flag=true;
	}
	
	function buttonPressed(){
	flag = false;
	}
	 
	function closeDivRequest()
		{
			document.getElementById("segmentInfo").style.visibility="hidden";	
			document.getElementById("segmentInfoTable").style.display="none";	
		}
	 function openSegmentDescription()
		{
				var dv = document.getElementById("segmentInfo"); 
				if(dv != null)
				{
					var xpos = screen.availHeight/2+90;
					var ypos = screen.availWidth/2-240;       
					
					dv.style.position="absolute";       		
					dv.style.backgroundColor ='#FFFFFF';
					dv.style.left=(xpos+20)+"px"; 
					dv.style.top=(ypos)+"px";
					dv.className='TabHd';
					
					document.getElementById("segmentInfo").style.visibility="";	
					document.getElementById("segmentInfoTable").style.display="";	
				}
		}
		
		 </script>
	<head>
	<%
	String strUser=request.getParameter("Userid"); 
	String strPage=request.getParameter("pageflag");
	%>
	
	 <link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
	<body onLoad="document.user.domain.focus();"  > 
	<script type="text/javascript" language="JavaScript1.2" src="menu/menu_cnt.js?buildstamp=2_0_0"></script>
	<br> 
	<form method="post" name="user" action="UpdateWinDomPost.jsp"  onSubmit="return checkfield();" >
	      <input type="hidden" name="user" value="<%=strUser%>">
         <input type="hidden" name="page" value="<%=strPage%>">  
 		  <table width="100%" border="0" align=center>  
	                <tr align=center> 
	                  <td class=bodyline-top align=left><li class="pageHead">Kindly update your  <FONT COLOR="#33CC00">Network Domain name</FONT> & <FONT COLOR="#33CC00">Windows User Name</FONT> to enable your Single Sign On for STARS</li></td>
	                </tr> 
					</table>   
					<br>
		  <table width="80%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder">
			<tr> 
				<td width="27%" class="formtr2">Enter Your Network Domain Name </td> 
				<td width="53%" class="formtr1"><input type=text name="domain" class="textBoxCss" size=30 onKeyUp="return test1('domain', 50, 'a')" maxlength="50" ></td> 
			</tr>
			<tr>  
				<td width="27%" class="formtr2">Enter Your Windows User Name </td>  
				<td width="53%" class="formtr1"><input type=text name="winuserid" class="textBoxCss" size=30 onKeyUp="return test1('winuserid', 50, 'cn')" maxlength="50"> </td>
			</tr>
			<tr class="formbottom" align=center>  
				<td width="40%" colspan=2>   
						<input type="Submit" name="Submit" value="Submit" class="formButton" onclick="return checkfield();" onkeypress="buttonPressed();" >  
						<input type="button"  value="Reset" class="formButton" onclick="clearfield()">  
				</td>
			</tr>
		</table> 
		<br> 
		 
		 <table width="80%" align="center" border="0" cellpadding="5" cellspacing="1"  > 
		 <tr> <td   width="20%" class="pageHead"><font size="2">Note :    
			</td>
			</tr>
			<tr>
			<td class="formtr2" > <FONT  COLOR="#FF3300">To check your Network Domain Name & Windows User Name, press keys (Ctlr + alt + del) Simultaneously.</FONT> &nbsp; &nbsp;&nbsp; &nbsp;     
			<a href="#" onclick="openSegmentDescription();"> Show Example </a> 
			</td> 
		 	</tr>   
		</table>    
		 
		<div id="segmentInfo" style="visibility: hidden;overflow:auto; width:367; height:314; vertical-align:top;border-style:solid; border-color: #d6eaf3;border-width:2px;">  	 
									<table border="1" id="segmentInfoTable" width="100%" cellpadding="0" cellspacing="0" bordercolor="#d6eaf3" style="display: none;border-collapse:collapse;">
								 	 
								 	  <tr style="height: 8px;">  
								 	  	    <td  align="center" class="formtr2"  width="90%" style="height: 8px;">            
								 	  		Windows Username & Domain name           
								 	  		</td> <td align="right" class="formtr2">&nbsp; &nbsp; <a href ="#" onclick="closeDivRequest();" style="text-decoration: none" ><font size="2">[X]</font></td> 
								 	  </tr>   
								 	  <tr> 
								 	  	<td   class="TabData" colspan="2">  
								 	  		<img src="images/WinIDDomId.jpg?buildstamp=2_0_0" width="360" height="280" border="0"> 
								 	  	</td>
								 	 </table>
								 </div>
	    </form>
	    </body>
	    </HTML>  
	<%
	
	 /*
	out.println("1=strUser====="+strUser);
	 out.println("1==strPage===="+strPage);
	 */
	
	%>