// change these settings
	//var img=document.getElementById("submit");
	//img.style.visibility='hidden';
jQuery('#checkbox-1').prettyCheckboxes();
var AdSpeed_TopMargin =340; // how many pixels from the top
var AdSpeed_LeftMargin = (Math.round((.75)*(window.screen.availWidth)))-67; // how many pixels from the left
var AdSpeed_SlideTime = 1000; // how fast for the sliding into the page (zero for no-animation)
var AdSpeed_AdContainer = document.getElementById('AdSpeed_AdBody'); // the container of ad content
var AdSpeed_SlidingTimer = null;
function startAdSpeedFloatingAd() 
{ 
	this.currentY = parseInt(AdSpeed_AdContainer.style.top); 
	this.scrollTop = typeof(scrollY)!='undefined' ? scrollY : document.body.scrollTop;
	AdSpeed_AdContainer.style.left = AdSpeed_LeftMargin + "px";
	if (AdSpeed_SlideTime==0) { // no animation
		AdSpeed_AdContainer.style.top = AdSpeed_TopMargin + "px";
		clearInterval(AdSpeed_SlidingTimer);
		return;
	} // fi
	
	// begin the animation
	var newTargetY = this.scrollTop + this.AdSpeed_TopMargin;
	if ( this.currentY != newTargetY ) { 
		var now = new Date();
		if ( newTargetY != this.targetY ) { 
			this.targetY = newTargetY;
			// begin the floating
			this.A = this.targetY - this.currentY;
			this.B = Math.PI / ( 2 * this.AdSpeed_SlideTime );
			this.C = now.getTime();
			if (Math.abs(this.A) > this.findHt) { 
				this.D = this.A > 0 ? this.targetY - this.findHt : this.targetY + this.findHt;
				this.A = this.A > 0 ? this.findHt : -this.findHt;
			} else { 
				this.D = this.currentY;
			} 
		} 
		
		var newY = this.A * Math.sin( this.B * ( now.getTime() - this.C ) ) + this.D;
		newY = Math.round(newY);
		if (( this.A > 0 && newY > this.currentY ) || ( this.A < 0 && newY < this.currentY )) { 
			AdSpeed_AdContainer.style.top = newY + "px";
		} // fi
	} else { // finished, don't loop over again
		clearInterval(AdSpeed_SlidingTimer);
	} // fi
} 

/* call by the external link/button to close this floating ad */
function closeAdSpeedFloatingAd()
{
	AdSpeed_AdContainer.style.visibility = "hidden";
}

// begin to run the ad
AdSpeed_SlidingTimer = window.setInterval("startAdSpeedFloatingAd()",10);
function start_anim()
{
	AdSpeed_SlidingTimer = window.setInterval("startAdSpeedFloatingAd()",10);
	document.getElementById('fdbk').style.display = "none";
}
