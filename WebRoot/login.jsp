<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8" />
	<title>tekuma-Management system</title>
	<link rel="shortcut icon" href="../images/favicon.ico" type="image/x-icon" />
	<meta content="width=device-width, initial-scale=1.0" name="viewport" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta content="" name="description" />
	<meta content="" name="author" />
	<link href="plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
	<link href="plugins/bootstrap/css/bootstrap-responsive.min.css" rel="stylesheet" type="text/css"/>
	<link href="plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>
	<link href="themes/admin/metronic_admin/_static/css/style-metro.css" rel="stylesheet" type="text/css"/>
	<link href="themes/admin/metronic_admin/_static/css/style.css" rel="stylesheet" type="text/css"/>
	<link href="themes/admin/metronic_admin/_static/css/style-responsive.css" rel="stylesheet" type="text/css"/>
	<link href="themes/admin/metronic_admin/_static/css/themes/default.css" rel="stylesheet" type="text/css" id="style_color"/>
	<link href="plugins/uniform/css/uniform.default.css" rel="stylesheet" type="text/css"/>
	<link href="themes/admin/metronic_admin/_static/css/pages/login-soft.css" rel="stylesheet" type="text/css"/>
	
	<script src="plugins/jquery-1.10.1.min.js" type="text/javascript"></script>
	<script src="plugins/jquery-migrate-1.2.1.min.js" type="text/javascript"></script>
	<!-- IMPORTANT! Load jquery-ui-1.10.1.custom.min.js before bootstrap.min.js to fix bootstrap tooltip conflict with jquery ui tooltip -->
	<script src="plugins/jquery-ui/jquery-ui-1.10.1.custom.min.js" type="text/javascript"></script>      
	<script src="plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
	<script src="plugins/bootstrap-hover-dropdown/twitter-bootstrap-hover-dropdown.min.js" type="text/javascript" ></script>
	<!--[if lt IE 9]>
	<script src="plugins/excanvas.min.js"></script>
	<script src="plugins/respond.min.js"></script>  
	<![endif]-->   
	<script src="plugins/jquery-slimscroll/jquery.slimscroll.min.js" type="text/javascript"></script>
	<script src="plugins/jquery.blockui.min.js" type="text/javascript"></script>  
	<script src="plugins/jquery.cookie.min.js" type="text/javascript"></script>
	<script src="plugins/uniform/jquery.uniform.min.js" type="text/javascript" ></script>
	<script src="plugins/backstretch/jquery.backstretch.min.js" type="text/javascript"></script>
	<script src="plugins/jquery-validation/dist/jquery.validate.min.js" type="text/javascript"></script>
	<script src="themes/admin/metronic_admin/_static/scripts/app.js"></script>

<script type="text/javascript">

 	//登录验证
	function Validationdata(){
		var name=$("#loginname").val();
		var password=$("#password").val();
		if(name!=undefined&&name!=""){
			if(password!=undefined&&password!=""){
				$.ajax({
					url:"system/login_login.do",
					data:{"userNew.loginname":name,"userNew.loginpwd":password},
					type:"post",
					success:function(iError){
						if(iError=="1"){
							$("div.alert-error").fadeIn(1000);
				 			$("div.alert-error span").text("User does not exist, please re-enter!");
				 			$("div.alert-error").delay(5000).fadeOut(1000);
						}
						if(iError=="2"){
							$("div.alert-error").fadeIn(1000);
				 			$("div.alert-error span").text("The password is incorrect. Please re-enter.");
				 			$("div.alert-error").delay(5000).fadeOut(1000);
						}
						if(iError=="0"){
							window.location.href="system/login_longining.do";
						}
					}
				});
			}else{
				$("div.alert-error").fadeIn(1000);
	 			$("div.alert-error span").text("Password can not be empty, please re-enter!");
	 			$("div.alert-error").delay(5000).fadeOut(1000);
			}
		}else{
			$("div.alert-error").fadeIn(1000);
 			$("div.alert-error span").text("User name can not be empty, please re-enter!");
 			$("div.alert-error").delay(5000).fadeOut(1000);
		}
	}
 	
 	//点击键盘enter按钮验证登陆
	$(document).keyup(function(event){
		 switch(event.keyCode) {
			 case 13:
			 $("#sub").click();
		 }
	});	
 	
</script>
	
</head>
<body class="login">
	<div class="title">
		<h4 class="page-title">${curMeeting.name}</h4>
	</div>
	<div class="content">
		<form class="form-vertical login-form" method="post" name="forms">
			<h4 class="form-title" align="center">tekuma-Managementsystem Login</h4>
			<div class="alert alert-error hide">
				<span></span>
			</div>
			<div class="control-group">
				<!--ie8, ie9 does not support html5 placeholder, so we just show field title for that-->
				<label class="control-label visible-ie8 visible-ie9">用户名</label>
				<div class="controls">
					<div class="input-icon left">
						<i class="icon-user"></i>
						<input id="loginname" class="m-wrap placeholder-no-fix" type="text" autocomplete="off" placeholder="username" name="userNew.loginname"/>
					</div>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label visible-ie8 visible-ie9">密码</label>
				<div class="controls">
					<div class="input-icon left">
						<i class="icon-eye-open"></i>
						<input id="password" class="m-wrap placeholder-no-fix" type="password" autocomplete="off" placeholder="password" name="userNew.loginpwd"/>
					</div>
				</div>
			</div>
			<div class="form-actions">
				<button type="button" class="btn green pull-right" id="sub" onclick="Validationdata()">
				Logining... <i class="m-icon-swapright m-icon-white"></i>
				</button>            
			</div>
			<sitemesh:body/> 
		</form>
	</div>	
	<div class="copyright">
		2015 &copy; tekuma.com
	</div>

</body>
</html>