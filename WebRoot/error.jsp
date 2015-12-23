<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="shortcut icon" href="../images/favicon.ico" type="image/x-icon" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8s">
<link href='http://fonts.googleapis.com/css?family=Courgette' rel='stylesheet' type='text/css'>
<link href="../css/error_style.css" rel="stylesheet"/>

<title>go to index</title>

<script type="text/javascript">
var t = 5;
function countDown(){
var time = document.getElementById("time");
t--;
time.innerText=t;
if (t<=0) {
location.href="http://52.2.188.227:8080/TekumaServer";
clearInterval(inter);
};
}
var inter = setInterval("countDown()",1000);
//window.onload=countDown;
</script> 

</head>
<body onload="countDown()">

	<div class="wrap">
		<div class="logo">
			<h4><img src="../images/error.jpg"></h4>
			<p>Error occured! - File not Found</p>
			<div class="sub">
				<p>
					Automatically jump to the front page after <span id="time">5</span> seconds
				</p>
			</div>
		</div>
	</div>
	<div class="footer">contact us:hello@tekuma.io</div>

</body>
</html>