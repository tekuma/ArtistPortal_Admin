var public_menuContentURL;

//打开中间文本部分
function public_openContent(contentURL){
	var public_ajaxPara={type:"post",cache:false};
	public_ajaxPara.url=contentURL;
	public_ajaxPara.dataType="html";
	public_ajaxPara.success=function(contentHTML){
		//alert(contentHTML);
		$("#index_dinid_Collectionlist").fadeOut();
		//$("#index_dinid_Collectionlist").attr("display","none");
		$(".divclass_index_content").html(contentHTML);
		//
	};
	public_ajaxPara.beforeSend=function(){
		if(contentURL.indexOf("findcollwnlist")){
			$("#index_dinid_Collectionlist").fadeIn();
		}
		//$(".divclass_index_content").html("");
	};
	public_ajaxPara.complete=function(){
		//$("#bodyid_index_body").css("cursor","default");
		public_ajaxPara={type:"post",cache:false};
	};
	$.ajax(public_ajaxPara);
}

//表单提交
function public_formSubmit(formE,returnFunction){
	
	//alert(formE.serialize());
	$(".help-public-error").remove();
	var formISSubmit=0;
	formE.find("input").each(function(i){
		if($(this).attr("required")!=undefined&&$(this).attr("required")!=""){
			if($(this).val()!=undefined&&$(this).val()!=""){
				formISSubmit+=0;
			}else{
				$(this).after("<span class=\"help-inline help-public-error\" style=\"color:red\">必填项</span>");
				formISSubmit+=1;
			}
			
		}else{
			formISSubmit+=0;
		}
	});
	formE.find("select").each(function(i){
		if($(this).attr("required")!=undefined&&$(this).attr("required")!=""){
			if($(this).val()!=undefined&&$(this).val()!=""){
				formISSubmit+=0;
			}else{
				$(this).after("<span class=\"help-inline help-public-error\" style=\"color:red\">必填项</span>");
				formISSubmit+=1;
			}
			
		}else{
			formISSubmit+=0;
		}
	});
	formE.find("textarea").each(function(i){
		if($(this).attr("required")!=undefined&&$(this).attr("required")!=""){
			if($(this).val()!=undefined&&$(this).val()!=""){
				formISSubmit+=0;
			}else{
				$(this).after("<span class=\"help-inline help-public-error\" style=\"color:red\">必填项</span>");
				formISSubmit+=1;
			}
			
		}else{
			formISSubmit+=0;
		}
	});
	if(formISSubmit!=0){
		alert("有必填项未填写")
	}else{
		var formURL=formE.attr("action");
		var public_ajaxPara={type:"post",cache:false};
		public_ajaxPara.url=formE.attr("action");
		public_ajaxPara.data=formE.serialize()
		public_ajaxPara.dataType="json";
		public_ajaxPara.success=returnFunction;
		$.ajax(public_ajaxPara);
	}
}
//文件上传
var public_fileIDARRAY;
var public_uploadURL;
function public_fileUpload(formE,uploadURL){
	public_fileIDARRAY=new Array();
	public_uploadURL=uploadURL;
	public_uploadINDEX=0;
	formE.find("input").each(function(i){
		if($(this).attr("type")=="file"&&$(this).val()!=""){
			public_fileIDARRAY.push($(this).attr("id"));
		}
	});
	public_ajaxFileUpload();
	
}
//ajax文件上传
function public_ajaxFileUpload(){
	//alert($("#inputid_addauthor_txlj").val()+"   "+$("#inputid_addauthor_bjtxlj").val());
	if(public_uploadINDEX<public_fileIDARRAY.length){
		$.ajaxFileUpload({
			type: "post",  //提交方式
            url:public_uploadURL, //上传文件的服务端
            secureuri:false,  //是否启用安全提交
            dataType:'text/html',
            fileElementId:public_fileIDARRAY, //表示文件域ID

            //提交成功后处理函数      html为返回值，status为执行的状态
            success: function(html,status){
            	//public_fileUpload(public_uploadURL);
            	//public_uploadINDEX++;
            	//public_ajaxFileUpload();
            },
            //提交失败处理函数
            error: function (html,status,e){
            	alert("error");
            }
        });
	}
}
//弹出提示框
function public_openAlert(title,content,type){
	if(type==0){
		$("#divid_index_alert_title").css("color","#000000");
		$("#divid_index_alert_button").attr("class","btn green");
		$("#divid_index_alert_title").html(title);
		$("#divid_index_alert_content").html(content);
		$("#aid_index_alert").click();
	}else{
		$("#divid_index_alert_title").css("color","red");
		$("#divid_index_alert_button").attr("class","btn red");
		$("#divid_index_alert_title").html(title);
		$("#divid_index_alert_content").html(content);
		$("#aid_index_alert").click();
	}
	
	
}
//弹出询问提示框
function public_openConfirm(title,content,confirmFunction){
	$("#divid_index_alertConfirm_title").html(title);
	$("#divid_index_alertConfirm_content").html(content);
	$("#aid_index_alertConfirm").click();
	$("#divid_index_alertConfirm_saveButton").attr("onclick",confirmFunction);
}
//打开窗体
var public_windowHTML;
var public_windowREL;
function public_openWindow(windowTITLE,windowURL,windowREL,windowWIDTH,windowICON,windowFORMBUTTON){
	public_windowHTML="";
	public_windowREL=windowREL;
	public_windowHTML+="<div class=\"divclass_index_window\" id=\"divid_index_windowmain"+public_windowREL+"\" "+
		"style=\"position:absolute;width:100%;height:"+(parseInt($(".page-container").css("height"))+45)+"px;top:0px;"+
		"left:0px;z-index:9999;background-image:url('../images/windowbackground.png')\">";
	public_windowHTML+="<div class=\"span6\" id=\"divid_index_window"+public_windowREL+"\" style=\"margin-left:"+(($(window).width()-parseFloat(windowWIDTH))/2)+"px;"+
		"width:"+windowWIDTH+"px;margin-bottom:0px\">";
	public_windowHTML+="<div class=\"portlet box green tasks-widget\" style=\"margin-bottom:0px;\">";
	public_windowHTML+="<div class=\"portlet-title\">";
	public_windowHTML+="<div class=\"caption\"><i class=\""+windowICON+"\"></i>"+windowTITLE+"</div>";
	public_windowHTML+="<div class=\"tools\"><div class=\"caption\">";
	for(var i=0;i<windowFORMBUTTON.length;i++){
		public_windowHTML+="<i class=\""+windowFORMBUTTON[i].icon+"\" onclick=\""+windowFORMBUTTON[i].func+"()\"></i>&ensp;&ensp;&ensp;";
	}
	
	public_windowHTML+="<i class=\"icon-remove\" onclick=\"public_closeWindow('"+public_windowREL+"')\"></i></div></div>";

	public_windowHTML+="</div>";
	public_windowHTML+="<div class=\"portlet-body\">";
	public_windowHTML+="<div class=\"task-content\" id=\"divid_index_window_content"+public_windowREL+"\">";
	
	var public_ajaxPara={type:"post",cache:false};
	public_ajaxPara.url=windowURL;
	public_ajaxPara.dataType="html";
	public_ajaxPara.success=function(windowHTML){//alert(windowHTML);
		public_windowHTML+=windowHTML+"</div></div></div></div></div> ";
		$("#bodyid_index_body").append(public_windowHTML);
		var windowH=parseFloat($("#divid_index_window"+public_windowREL).css("height"));
		var windowMainH=parseFloat($("#divid_index_windowmain"+public_windowREL).css("height"));
		if(windowH>$(window).height()){
			$("#divid_index_window"+public_windowREL).css({"margin-top":"7px","overflow":"auto"});
			$("#divid_index_window_content"+public_windowREL).css({"height":(windowMainH-70)+"px","overflow":"auto"});
		}else{
			$("#divid_index_window"+public_windowREL).css({"margin-top":((windowMainH-windowH)/2)+"px"});
		}
	};
	$.ajax(public_ajaxPara);
}
//关闭窗体
function public_closeWindow(windowREL){
	$("#divid_index_windowmain"+windowREL).remove();
}



