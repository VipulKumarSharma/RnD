// Developed by: Mr. Luxmi Nagda

function convertToDecimal(strbooleancode)
{
   var i=0;
   var result=0;
   var base=2;
   var temp="";
   
   for(i=0,j=8;i<9;i++,j--)
   {
    temp=strbooleancode.charAt(i);
    result += Math.pow(base,j)*parseInt(temp);
   }     
   
   return result;
}

function convertToBoolean(intcode)
{
    //alert("intcode"+intcode);
    var num=intcode;
    var quot;
    var div=2;
    var rem;
    var temp=new Array(9);
    var len=temp.length;
    var k;
    var i;
    var str="";
    
    for(k=0;num!=0;k++)
    {
     quot=parseInt(num/div);
     rem=num%div;
     temp[k]=rem;
     num=quot;     
    }
    
    for(i=k;i<len;i++)
    temp[i]=0;
    
    temp=temp.reverse();
    
    for(i=0;i<len;i++)
    str +=temp[i];
    
    return str;       
}

function encrypt(oldPassword)
{
  //alert("Inside Encrypt");
  var len=oldPassword.length;
  var newPassword="";
  var temp=new Array();
  var i=0;
  var ran=(Math.floor(Math.random()*256)+1);
  //alert("Random No. is "+ran);
  
 for(i=0;i<len;i++)
 {
  temp[i]=oldPassword.charCodeAt(i);
  if((temp[i]>=0) && (temp[i]<64)) temp[i] +=128;
  else if((temp[i]>=64) && (temp[i]<128)) temp[i] +=128;
  else if((temp[i]>=128) && (temp[i]<192)) temp[i] -=128;
  else if((temp[i]>=192) && (temp[i]<256)) temp[i] -=128;
  else ;
   
  temp[i] +=ran;
  newPassword +=convertToBoolean(temp[i]);   
 }
 newPassword +=convertToBoolean(ran);
 //alert("New Password After Encryption is::"+newPassword);
 //alert("New Password length After Encryption is::"+newPassword.length);
 return newPassword;
}
