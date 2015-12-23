<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<link rel="shortcut icon" href="../images/favicon.ico" type="image/x-icon" />
<link href="../css/index_style3.css" rel="stylesheet" type="text/css">
<link href="../plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css">



<script type="text/javascript">
	
	//验证邮箱
	function Verifymailbox() {
		var email = document.getElementById("email").value;
		var code = document.getElementById("code").value;
		if(email == "") {
			document.getElementById("email_error").innerText="Email can not be empty";
			setTimeout(function(){document.getElementById("email_error").style.display="none";},3000);
			return false;
		}else {
			reg = /^([a-zA-Z0-9]+[_|\-|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\-|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/gi;
			if (!reg.test(email)) {
				document.getElementById("email_error").innerText="Illegal mailbox";
				setTimeout(function(){document.getElementById("email_error").style.display="none";},3000);
				return false;
			}else{
				document.getElementById("email_error").display ="none";
				var URL="system/fileDownload_sendMail.do?email="+email+"&code="+code;
				$.ajax({url:URL,cache:false,dataType:"json",
					success:function(success){
						alert("Send success!");
						index_menuClick("tekuma_makeCode.do");
					}
				});
			}
		}
	}

	
</script>


	<div align="center" style="margin-top: 3%;">
		<div class="form-group">
			<div class="col-sm-10">
				<p>Invite Code:</p><input type="text" readonly="readonly" id="code" value="${code}">
			</div>
			<span id="email_error" style="color: red;"></span>
			<div class="col-sm-10" style="margin-top: 1%;">
				<p>E-mail:</p><input type="email" placeholder="Please enter QQ mailbox" id="email">
			</div>
		</div>
		<div class="form-group">
			<div class="col-sm-offset-2 col-sm-10">
				<button type="submit" id="invite_btn" onclick="Verifymailbox()">Send</button>
			</div>
		</div>
	</div>
		
		
		
<script type="text/javascript" src="../plugins/select2/select2.min.js"></script>
<script type="text/javascript" src="../plugins/bootstrap-datepicker/js/bootstrap-datepicker.js"></script>
<script type="text/javascript" src="../plugins/bootstrap-datetimepicker/js/bootstrap-datetimepicker.js"></script>
<script type="text/javascript" src="../plugins/jquery-inputmask/jquery.inputmask.bundle.min.js"></script>   
<script type="text/javascript" src="../plugins/jquery.input-ip-address-control-1.0.min.js"></script>
<script type="text/javascript" src="../plugins/jquery-multi-select/js/jquery.multi-select.js"></script>
<script type="text/javascript" src="../themes/admin/metronic_admin/_static/scripts/form-components.js"></script> 
<script type="text/javascript" src="../plugins/bootstrap-fileupload/bootstrap-fileupload.js"></script>  


<script src="../js/js.js" type="text/javascript"></script>
 
    
<script>
	jQuery(document).ready(function() {          
	   // initiate layout and plugins
	   //App.init();
	   FormComponents.init();
	});
	
	function index_menuClick(contentURL){
		//alert(contentURL);
		public_menuContentURL=contentURL;
		public_openContent(contentURL);
		document.getElementById("index_dinid_Collectionlist").style.display="none";
	}
</script>
