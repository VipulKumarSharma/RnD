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



