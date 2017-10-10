function test() {
	alert("test successfull")
}
function limitlength(e, t) {
	var n = t;
	if (e.value.length > n)
		e.value = e.value.substring(0, n)
}
function charactercheck(e, t) {
	if (t == "c") {
		mikExp = /[$\\@\\\#%\^\&\*\(\)\[\]\+\_\{\}\`\~\=\.\|\,\'\"\?\/\>\<\!\-\:\;\\0\\1\\2\\3\\4\\5\\6\\7\\8\\9]/
	} else if (t == "n") {
		mikExp = /[$\\@\\\#%\^\&\ \*\(\)\[\]\+\_\{\}\`\~\=\.\|\,\'\"\?\/\>\<\!\-\:\;\\a\\b\\c\\d\\e\\f\\g\\h\\i\\j\\k\\l\\m\\n\\o\\p\\q\\r\\s\\t\\u\\v\\w\\x\\y\\z\\A\\B\\C\\D\\E\\F\\G\\H\\I\\J\\K\\L\\M\\N\\O\\P\\Q\\R\\S\\T\\U\\V\\W\\X\\Y\\Z]/
	} else if (t == "n.") {
		mikExp = /[$\\@\\\#%\^\&\*\(\)\[\]\+\_\{\}\`\~\=\|\,\'\"\?\/\>\<\!\-\:\;\\a\\b\\c\\d\\e\\f\\g\\h\\i\\j\\k\\l\\m\\n\\o\\p\\q\\r\\s\\t\\u\\v\\w\\x\\y\\z\\A\\B\\C\\D\\E\\F\\G\\H\\I\\J\\K\\L\\M\\N\\O\\P\\Q\\R\\S\\T\\U\\V\\W\\X\\Y\\Z]/
	} else if (t == "cn") {
		mikExp = /[$\\@\\\#%\^\&\*\(\)\[\]\+\_\{\}\`\~\=\.\|\,\'\"\?\/\>\<\!\-\:\;]/
	} else if (t == "cn,") {
		mikExp = /[$\\@\\\#%\^\&\*\(\)\[\]\+\_\{\}\`\~\=\.\|\'\"\?\/\>\<\!\-\:\;]/
	} else if (t == "sector") {
		mikExp = /[$\\@\\\#%\^\&\*\(\)\[\]\+\_\{\}\`\~\=\.\|\'\"\?\/\>\<\!\:\;\\0\\1\\2\\3\\4\\5\\6\\7\\8\\9]/
	} else if (t == "cn:") {
		mikExp = /[$\\@\\\#%\^\&\*\(\)\[\]\+\_\{\}\`\~\=\.\|\,\'\"\?\/\>\<\!\-\;]/
	} else if (t == "phone") {
		mikExp = /[$\\@\\\#%\^\&\*\[\]\+\_\{\}\`\~\=\.\|\,\'\"\?\/\>\<\!\:\;\\a\\b\\c\\d\\e\\f\\g\\h\\i\\j\\k\\l\\m\\n\\o\\p\\q\\r\\s\\t\\u\\v\\w\\x\\y\\z\\A\\B\\C\\D\\E\\F\\G\\H\\I\\J\\K\\L\\M\\N\\O\\P\\Q\\R\\S\\T\\U\\V\\W\\X\\Y\\Z]/
	} else if (t == "pwd") {
		mikExp = /[=\'\"\\\-]/
	} else if (t == "an") {
		mikExp = /[\'\"\;\\\>\<\&]/
	} else if (t == "sitename") {
		mikExp = /[\&\'\"\;\%]/
	} else if (t == "txt") {
		mikExp = /[\'\<\>\&]/
	} else if (t == "cur") {
		mikExp = /[$\\@\\\#%\^\&\*\[\]\+\_\{\}\`\~\=\.\|\,\'\"\?\/\>\<\!\-\:\;\\0\\1\\2\\3\\4\\5\\6\\7\\8\\9]/
	} else if (t == "xml") {
		mikExp = /[\'\&]/
	} else {
		mikExp = /[\`\'\<\>\&]/
	}
	var n = e.value;
	var r = n.length;
	if (r > 0) {
		for (var i = 0; i < r; i++) {
			var s = e.value.charAt(i);
			if (s.search(mikExp) != -1) {
				var o = e.value.substring(0, i);
				var u = e.value.substring(i + 1, r);
				e.value = o + u;
				i--
			}
		}
	}
}
function zeroChecking(e) {
	var t = e.value;
	var n = t.length;
	var r = "y";
	var i = 0;
	if (n > 0) {
		for (var s = 0; s < n; s++) {
			var o = t.charAt(s);
			if ((o == "0" || o == " " || o == "	") && r == "y") {
				i++
			}
			if (o != "0" || o != " ")
				r = "n"
		}
		if (i > 0) {
			var u = e.value.substring(i, n);
			e.value = u
		}
	}
}
function spaceChecking(e) {
	var t = e.value;
	var n = t.length;
	var r = "y";
	var i = 0;
	if (n > 0) {
		for (var s = 0; s < n; s++) {
			var o = t.charAt(s);
			if (o == " " && r == "y") {
				i++
			}
			if (o != " ")
				r = "n"
		}
		if (i > 0) {
			var u = e.value.substring(i, n);
			e.value = u
		}
	}
}
function restrictChar(e, t) {
	if (t == "noJapChar") {
		mikExp = /[$\\@\\\#%\^\&\*\ \(\)\[\]\+\_\{\}\`\~\=\.\|\,\'\"\?\/\>\<\!\-\:\;\\a\\b\\c\\d\\e\\f\\g\\h\\i\\j\\k\\l\\m\\n\\o\\p\\q\\r\\s\\t\\u\\v\\w\\x\\y\\z\\A\\B\\C\\D\\E\\F\\G\\H\\I\\J\\K\\L\\M\\N\\O\\P\\Q\\R\\S\\T\\U\\V\\W\\X\\Y\\Z\\0\\1\\2\\3\\4\\5\\6\\7\\8\\9]/
	} else if (t == "c") {
		mikExp = /[\ \\a\\b\\c\\d\\e\\f\\g\\h\\i\\j\\k\\l\\m\\n\\o\\p\\q\\r\\s\\t\\u\\v\\w\\x\\y\\z\\A\\B\\C\\D\\E\\F\\G\\H\\I\\J\\K\\L\\M\\N\\O\\P\\Q\\R\\S\\T\\U\\V\\W\\X\\Y\\Z]/
	} else if (t == "userName") {
		mikExp = /[$\\@\\\#%\^\&\*\ \(\)\[\]\+\_\{\}\`\~\=\.\|\,\"\?\/\>\<\!\-\:\;\\a\\b\\c\\d\\e\\f\\g\\h\\i\\j\\k\\l\\m\\n\\o\\p\\q\\r\\s\\t\\u\\v\\w\\x\\y\\z\\A\\B\\C\\D\\E\\F\\G\\H\\I\\J\\K\\L\\M\\N\\O\\P\\Q\\R\\S\\T\\U\\V\\W\\X\\Y\\Z\\0\\1\\2\\3\\4\\5\\6\\7\\8\\9]/
	} else {
		mikExp = /[\`]/
	}
	var n = e.value;
	var r = n.length;
	if (r > 0) {
		for (var i = 0; i < r; i++) {
			var s = e.value.charAt(i);
			if (s == "") {
				o = ""
			} else {
				var o = s.search(mikExp)
			}
			if (o == "-1") {
				var u = e.value.substring(0, i);
				var a = e.value.substring(i + 1, r);
				e.value = u + a;
				i--
			}
		}
	}
}
function TrimString(e) {
	e.value = e.value.replace(/^\s+/, "");
	e.value = e.value.replace(/\s+$/, "")
}
function check_alph_only(e) {
	var t = e.value;
	var n = new RegExp(
			"[*,&,%,$,#,@,!,~,?,<,>,>,:,;,=,',-,1,2,3,4,5,6,7,8,9,0]");
	var r = n.test(t);
	if (r == true) {
		alert(" valid");
		return true
	} else {
		alert("not valid");
		e.value = "";
		e.focus();
		return false
	}
}
function echeck(e) {
	var t = "@";
	var n = ".";
	var r = e.indexOf(t);
	var i = e.length;
	var s = e.indexOf(n);
	if (e.indexOf(t) == -1) {
		alert("Invalid E-mail ID");
		return false
	}
	if (e.indexOf(t) == -1 || e.indexOf(t) == 0 || e.indexOf(t) == i) {
		alert("Invalid E-mail ID");
		return false
	}
	if (e.indexOf(n) == -1 || e.indexOf(n) == 0 || e.indexOf(n) == i) {
		alert("Invalid E-mail ID");
		return false
	}
	if (e.indexOf(t, r + 1) != -1) {
		alert("Invalid E-mail ID");
		return false
	}
	if (e.substring(r - 1, r) == n || e.substring(r + 1, r + 2) == n) {
		alert("Invalid E-mail ID");
		return false
	}
	if (e.indexOf(n, r + 2) == -1) {
		alert("Invalid E-mail ID");
		return false
	}
	if (e.indexOf(" ") != -1) {
		alert("Invalid E-mail ID");
		return false
	}
	return true
}
function echeckMultple(e) {
	var t = "@";
	var n = ".";
	var r = e.indexOf(t);
	var i = e.length;
	var s = e.indexOf(n);
	var o = "Invalid E-mail ID! \nFor Multiple E-mail ID use ; as a Separator";
	if (e.indexOf(t) == -1) {
		alert(o);
		return false
	}
	if (e.indexOf(t) == -1 || e.indexOf(t) == 0 || e.indexOf(t) == i) {
		alert(o);
		return false
	}
	if (e.indexOf(n) == -1 || e.indexOf(n) == 0 || e.indexOf(n) == i) {
		alert(o);
		return false
	}
	if (e.indexOf(t, r + 1) != -1) {
		alert(o);
		return false
	}
	if (e.substring(r - 1, r) == n || e.substring(r + 1, r + 2) == n) {
		alert(o);
		return false
	}
	if (e.indexOf(n, r + 2) == -1) {
		alert(o);
		return false
	}
	if (e.indexOf(" ") != -1) {
		alert(o);
		return false
	}
	return true
}
function isInteger(e) {
	var t;
	for (t = 0; t < e.length; t++) {
		var n = e.charAt(t);
		if (n < "0" || n > "9")
			return false
	}
	return true
}
function stripCharsInBag(e, t) {
	var n;
	var r = "";
	for (n = 0; n < e.length; n++) {
		var i = e.charAt(n);
		if (t.indexOf(i) == -1)
			r += i
	}
	return r
}
function checkInternationalPhone(e) {
	s = stripCharsInBag(e, validWorldPhoneChars);
	return isInteger(s) && s.length >= minDigitsInIPhoneNumber
}
function ValidatePhoneNo(e) {
	var t = e;
	if (t.value == null || t.value == "") {
		alert("Please Enter your Phone Number");
		t.focus();
		return false
	}
	if (checkInternationalPhone(t.value) == false) {
		alert("Please Enter a Valid Phone Number");
		t.value = "";
		t.focus();
		return false
	}
	return true
}
function moneyFormat(e) {
	var t = e.value;
	var n = "";
	var r = "";
	var s = false;
	var o = "";
	for (i = 0; i < t.length; i++) {
		o = t.substring(i, i + 1);
		if (o >= "0" && o <= "9") {
			if (s) {
				n = "" + n + o
			} else {
				r = "" + r + o
			}
		}
		if (o == ".") {
			if (s) {
				r = "";
				break
			}
			s = true
		}
	}
	if (r == "") {
		r = "0"
	}
	if (r.length > 1) {
		while (r.length > 1 && r.substring(0, 1) == "0") {
			r = r.substring(1, r.length)
		}
	}
	if (n.length > 2) {
		if (n.substring(2, 3) > "4") {
			n = parseInt(n.substring(0, 2)) + 1;
			if (n < 10) {
				n = "0" + n
			} else {
				n = "" + n
			}
		} else {
			n = n.substring(0, 2)
		}
		if (n == 100) {
			n = "00";
			r = parseInt(r) + 1
		}
	}
	if (n.length == 1) {
		n = n + "0"
	}
	if (n.length == 0) {
		n = n + "00"
	}
	if (t.substring(0, 1) != "-" || r == "0" && n == "00") {
		e.value = r + "." + n
	} else {
		e.value = "-" + r + "." + n
	}
}
function checkDate(e, t, n, r, i, s, o) {
	var u = t;
	var a = n;
	var f = u.substr(6, 4);
	var l = parseInt(f, 10);
	var c = u.substr(3, 2);
	var h = parseInt(c, 10);
	var p = u.substr(0, 2);
	var d = parseInt(p, 10);
	var v = a.substr(6, 4);
	var m = parseInt(v, 10);
	var g = a.substr(3, 2);
	var y = parseInt(g, 10);
	var b = a.substr(0, 2);
	var w = parseInt(b, 10);
	if (l > m) {
		alert(s);
		i.value = "";
		i.focus();
		return false
	}
	if (l == m && h > y) {
		alert(s);
		i.value = "";
		i.focus();
		return false
	}
	if (l == m && h == y && d > w) {
		alert(s);
		i.value = "";
		i.focus();
		return false
	}
}
function checkDateme(e, t, n, r, i, s, o) {
	var u = t;
	var a = n;
	var f = u.substr(6, 4);
	var l = parseInt(f, 10);
	var c = u.substr(3, 2);
	var h = parseInt(c, 10);
	var p = u.substr(0, 2);
	var d = parseInt(p, 10);
	var v = a.substr(6, 4);
	var m = parseInt(v, 10);
	var g = a.substr(3, 2);
	var y = parseInt(g, 10);
	var b = a.substr(0, 2);
	var w = parseInt(b, 10);
	if (l > m) {
		alert(s);
		r.value = "";
		i.value = "";
		r.focus();
		return false
	}
	if (l == m && h > y) {
		alert(s);
		r.value = "";
		i.value = "";
		r.focus();
		return false
	}
	if (l == m && h == y && d > w) {
		alert(s);
		r.value = "";
		i.value = "";
		return false
	}
}
function checkDateme1(e, t, n, r, i, s, o) {
	var u = t;
	var a = n;
	var f = u.substr(6, 4);
	var l = parseInt(f, 10);
	var c = u.substr(3, 2);
	var h = parseInt(c, 10);
	var p = u.substr(0, 2);
	var d = parseInt(p, 10);
	var v = a.substr(6, 4);
	var m = parseInt(v, 10);
	var g = a.substr(3, 2);
	var y = parseInt(g, 10);
	var b = a.substr(0, 2);
	var w = parseInt(b, 10);
	if (l > m) {
		alert(s);
		r.value = "";
		r.focus();
		return false
	}
	if (l == m && h > y) {
		alert(s);
		r.value = "";
		r.focus();
		return false
	}
	if (l == m && h == y && d > w) {
		alert(s);
		r.value = "";
		r.focus();
		return false
	}
}
function checkDateGrater(e, t, n, r, i, s, o) {
	var u = t;
	var a = n;
	var f = u.substr(6, 4);
	var l = parseInt(f, 10);
	var c = u.substr(3, 2);
	var h = parseInt(c, 10);
	var p = u.substr(0, 2);
	var d = parseInt(p, 10);
	var v = a.substr(6, 4);
	var m = parseInt(v, 10);
	var g = a.substr(3, 2);
	var y = parseInt(g, 10);
	var b = a.substr(0, 2);
	var w = parseInt(b, 10);
	if (l > m) {
		alert(s);
		i.value = "";
		i.focus();
		return false
	}
	if (l == m && h > y) {
		alert(s);
		i.value = "";
		i.focus();
		return false
	}
	if (l == m && h == y && d >= w) {
		alert(s);
		i.value = "";
		i.focus();
		return false
	}
}
function upToTwoDecimal(e) {
	var t = e.value;
	var n = t.length;
	var r = t.indexOf(".");
	if (r == "-1") {
	} else {
		var i = t.substring(0, r + 1);
		if (r + 1 < n) {
			var s = t.substring(r + 1, n);
			if (s.length > 2) {
				s = s.substring(0, 2);
				e.value = i + s
			}
		}
	}
	var o = 0;
	for (var u = 0; u < n; u++) {
		var a = e.value.charAt(u);
		if (a == ".") {
			o++
		}
		if (o > 1) {
			var f = e.value.substring(0, u);
			e.value = f;
			break
		}
		if (a == "\\") {
			var f = e.value.substring(0, u);
			e.value = f;
			break
		}
	}
}
function upToTwoHyphen(e) {
	var t = e.value;
	var n = t.length;
	var r = 0;
	for (var i = 0; i < n; i++) {
		var s = e.value.charAt(i);
		if (s == "-") {
			i++;
			var o = e.value.charAt(i);
			if (s == o) {
				var u = e.value.substring(0, i);
				e.value = u;
				break
			}
		}
	}
}
var digits = "0123456789";
var phoneNumberDelimiters = "()- ";
var validWorldPhoneChars = phoneNumberDelimiters + "+";
var minDigitsInIPhoneNumber = 10;
if (typeof window.event != "undefined")
	document.onkeydown = function() {
		if (event.keyCode == 122) {
			event.cancelBubble = true;
			event.keyCode = 0;
			return false
		}
		if (event.srcElement.tagName.toUpperCase() != "INPUT"
				&& event.srcElement.tagName.toUpperCase() != "TEXTAREA")
			return event.keyCode != 8
	};
else
	document.onkeypress = function(e) {
		if (e.target.nodeName.toUpperCase() != "INPUT"
				&& e.target.nodeName.toUpperCase() != "TEXTAREA")
			return e.keyCode != 8
	}