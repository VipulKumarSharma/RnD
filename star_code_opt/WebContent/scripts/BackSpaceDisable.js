


//code for disable the backspace button(but allow text correction)
if (typeof window.event != 'undefined')
     document.onkeydown = function()
                          {
                             //alert(event.srcElement.tagName.toUpperCase());
							 //code for disable the F11 key
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


