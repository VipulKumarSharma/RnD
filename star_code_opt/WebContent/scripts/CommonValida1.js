//function for disable the right mouse click
function right(e)
{
  if(navigator.appName == 'Netscape' && (e.which == 3 || e.which == 2))
    return false;
  else if(navigator.appName == 'Microsoft Internet Explorer' && (event.button == 2 || event.button == 3))
  {
    alert("Right click is not available.");
    return false;
  }
  return true;
}
document.onmousedown=right;
document.onmouseup=right;
if (document.layers)
  window.captureEvents(Event.MOUSEDOWN);
if (document.layers) 
  window.captureEvents(Event.MOUSEUP);
window.onmousedown=right;
window.onmouseup=right;


//code for disable the backspace button(but allow text correction) and F11 Key
if (typeof window.event != 'undefined')
     document.onkeydown = function()
                          {
                             if(event.keyCode == 122)
							 {
								event.cancelBubble = true;
								event.keyCode = 0;
								return false;
							 }
                             if (event.srcElement.tagName.toUpperCase() != 'INPUT' && event.srcElement.tagName.toUpperCase() !='TEXTAREA')
                                return (event.keyCode != 8);
                           }
   else
     document.onkeypress = function(e)
                           {
                             if (e.target.nodeName.toUpperCase() != 'INPUT' && e.target.nodeName.toUpperCase() != 'TEXTAREA')
                               return (e.keyCode != 8);
                           }


