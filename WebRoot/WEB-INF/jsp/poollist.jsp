<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<link rel="shortcut icon" href="../images/favicon.ico" type="image/x-icon" />
<link href="../css/index_style3.css" rel="stylesheet" type="text/css">
<link href="../plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css">



<script type="text/javascript">
	
	//返回
	function poolist_goback(){
		var poollistli=document.getElementById("poollist_li");
		if(poollistli!=null){
			return true;
		}else{
			$("#index_ul").append("<li style='cursor: pointer;' onclick='poolist_goup()' id='poollist_li'><a class='cjn' >Return on a page</a></li>");
		}
	}
	setTimeout("poolist_goback();",1000);
	function poolist_goup(){
		document.getElementById("poollist_li").remove();
		var poollistmemberid=$("#poollistmemberid").val();
		var pooltype=$("#type").val();
		if(pooltype=="mem1"){
			index_menuClick("tekuma_findCollectionlist.do?pageNo=1&memberid="+poollistmemberid+"");
		}else{
			index_menuClick("tekuma_findcollwnlist.do?pageNo=1");
		}
	}
	
	//全选
    function poollist_checkFile(){
        if($("#all").attr("checked")){
        	$("#notall").removeAttr("checked");
            $("input[name='fileName']").attr("checked",true);
        }else {
            $("input[name='fileName']").attr("checked",false);
        }
    }
	
	//获取图片路径
 	function poollist_download(){
		var path=new Array();
 		$("input[name='fileName']").each(function(){ //由于复选框一般选中的是多个,所以可以循环输出
 			var url= $(this).val();
 			path.push(url);
 		}); 
 		$("#pool_dowln").attr('href','system/fileDownload_downloadlist.do?urlString='+path+'');
}
	
	
	//打开添加窗口
	function poollist_addexhibition(){
		$("#input_displayid").val("");
		$("#input_address").val("");
		$("#input_site").val("");
		var myDate = new Date();
	    var n=myDate.getFullYear();
		var yy=myDate.getMonth()+1; 
		if(yy>=10){
			var y=yy;
		}else{
			var y="0"+yy
		}
		var r=myDate.getDate();
		var dqsj=n+"-"+y+"-"+r;
 		$("#input_time").val(dqsj);
 		document.getElementById("pool_save").style.display = "block";
 		document.getElementById("pool_update").style.display = "none";
	}
 	//展览信息添加操作
 	function poollist_saveexhibition(){
 		var pageNo=$("#pageNo").val();
		var displayNewcid=$("#pool_hide_inputcid").val();
		var displayNewaddress=$("#input_address").val();
		var displayNewsite=$("#input_site").val();
 		var displayNewtime=$("#input_time").val();
 		var URL="tekuma_updatedispaly.do?displayNew.address="+displayNewaddress+"&displayNew.time="+displayNewtime+"&displayNew.site="+displayNewsite+"&displayNew.cid="+displayNewcid;
 		$.ajax({url:URL,cache:false,dataType:"json",
			success:function(pageResult){
				//alert(pageResult);
				index_menuClick("tekuma_findPoollist.do?pageNo="+pageNo+"&collectionid="+displayNewcid+"");
				
			}
		});
 	}
 	
 	
 	//根据displayid查询出其展览信息
 	function poollist_finddisplayid(displayid){
 		var URL="tekuma_finddisplayidd.do?displayNew.id="+displayid;
 		$.ajax({url:URL,cache:false,dataType:"json",
			success:function(pageResult){
				$("#input_displayid").val(pageResult.id);
				$("#input_address").val(pageResult.address);
				$("#input_site").val(pageResult.site);
				var myDate = new Date(pageResult.time);
			    var n=myDate.getFullYear();
				var y=myDate.getMonth()+1; 
				var r=myDate.getDate();
				var psj=n+"-"+y+"-"+r;
		 		$("#input_time").val(psj);
		 		document.getElementById("pool_save").style.display = "none";
		 		document.getElementById("pool_update").style.display = "block";
			}
		});
 	}
 	//展览信息修改操作
 	function poollist_updateexhibition(){
 		var pageNo=$("#pageNo").val();
		var displayNewid=$("#input_displayid").val();
		var displayNewcid=$("#pool_hide_inputcid").val();
		var displayNewaddress=$("#input_address").val();
		var displayNewsite=$("#input_site").val();
 		var displayNewtime=$("#input_time").val();
 		var URL="tekuma_updatedispaly.do?displayNew.id="+displayNewid+"&displayNew.address="+displayNewaddress+"&displayNew.time="+displayNewtime+"&displayNew.site="+displayNewsite+"&displayNew.cid="+displayNewcid;
 		$.ajax({url:URL,cache:false,dataType:"json",
			success:function(pageResult){
				//alert(pageResult);
				index_menuClick("tekuma_findPoollist.do?pageNo="+pageNo+"&collectionid="+displayNewcid+"");
				
			}
		});
 	}
 	
 	//展览信息删除操作
 	function poollist_deleteexhibition(id){
 		var result =confirm("Are you sure you want to delete it?");
 		if(result ==true){
	 		var pageNo=$("#pageNo").val();
			var displayNewcid=$("#pool_hide_inputcid").val();
	 		var URL="tekuma_deletedispaly.do?displayNew.id="+id;
	 		$.ajax({url:URL,cache:false,dataType:"json",
				success:function(pageResult){
					//alert(pageResult);
					index_menuClick("tekuma_findPoollist.do?pageNo="+pageNo+"&collectionid="+displayNewcid+"");
					
				}
			});
 		}
 	}
 	
 	//输入不能为空
 	function pool_verify(){
 		var displayNewaddress=$("#input_address").val();
		var displayNewsite=$("#input_site").val();
 		if(displayNewaddress!=null&&displayNewaddress!=""&&displayNewsite!=null&&displayNewsite!="")
		{
 			return true;
		}else{
			alert("The text box required!");
		}
 	}
 	
 	
 	//根据id查询Collection第二个之后的所有展览信息
 	function poollist_finddisplaylist(){
 		document.getElementById("pool_more").style.display = "";
 			var displayNewcid=$("#pool_hide_inputcid").val();
	 		var URL="tekuma_finddisplaylist.do?displayNew.cid="+displayNewcid;
	 		$.ajax({url:URL,cache:false,dataType:"json",
				success:function(displaylist){
					//alert(displaylist.length);
					if(displaylist.length>0){
						MorepoolHTML="";
						MorepoolHTML+="<div id=\"pool_shrink\" style=\"width: 100%;height: 100%;\">";
						for(var i=0;i<displaylist.length;i++){						
							MorepoolHTML+="<div class=\"jb\" style=\"width: 100%;\">";
							MorepoolHTML+="<div style=\"white-space:nowrap; overflow:hidden;text-overflow: ellipsis;width: 80%;height: 80%;\">";
							MorepoolHTML+=""+(i+3)+".&nbsp;";
							MorepoolHTML+="<span>Venue ："+displaylist[i].address+"&nbsp;";
							MorepoolHTML+="<span>URL："+displaylist[i].site+"&nbsp;";
							var myDate = new Date(displaylist[i].time);
						    var n=myDate.getFullYear();
							var y=myDate.getMonth()+1; 
							var r=myDate.getDate();
							var sj=n+"-"+y+"-"+r;
							MorepoolHTML+="<span>time ："+sj+"</span><br>";
							MorepoolHTML+="</div>";
							MorepoolHTML+="<div class=\"jc\" onclick=\"poollist_deleteexhibition('"+displaylist[i].id+"')\" style=\"cursor: pointer;\"></div>";
							MorepoolHTML+="<div class=\"jj\" onclick=\"poollist_finddisplayid('"+displaylist[i].id+"')\" data-toggle=\"modal\"  data-target=\"#myModal\"  style=\"cursor: pointer;\"></div>";
							MorepoolHTML+="</div>";
						}
						MorepoolHTML+="</div>";
						document.getElementById("load_more").style.display = "none";
				 		document.getElementById("shrink").style.display = "";
						$("#pool_more").append(MorepoolHTML);
					}else{
						alert("No Data!");
					}
				}
			});
 	}
 	
 	
 	
 	//收起展览信息
 	function poollist_shrinkdisplaylist(){
 		document.getElementById("shrink").style.display = "none";
 		document.getElementById("load_more").style.display = "";
 		document.getElementById("pool_shrink").remove();
 	}
 	
 	//放大pool图片
 	 $(function(){
         var x = 10;
         var y = 230;
		$(".tooltip").mouseover(function(e){
			this.myTitle = this.title;
		   	this.title = "";
			var imgTitle = this.myTitle?"<br>"+ this.myTitle : "";
			var tooltip = "<div id='tooltip'><img src='"+ this.id +"' width='400px' height='400px' />"+imgTitle+"<\/div>"; //创建 div 元素
			  $("body").append(tooltip);        //把它追加到文档中
			  $("#tooltip").css({
			            "top": (e.pageY-y) + "px",
			            "left":  (e.pageX+x)  + "px"
			           
			    }).fadeIn(500);          //设置x坐标和y坐标，并且显示
			}).mouseout(function(){
			  this.title = this.myTitle;
			  $("#tooltip").remove();         //移除
			}).mousemove(function(e){
			   $("#tooltip").css({
			         "top": (e.pageY-y) + "px",
			         "left":  (e.pageX+x)  + "px"
			  });
		});
				
	})
 	
</script>

<style type="text/css">
img {
	border: none;
}
/*tooltip*/
#tooltip {
	position: absolute;
	display: none;
	color: #FFF;
	background: #333;
}
</style>



	<input type="hidden" id="poolpageTotal" value="${pageResult.pageTotal}">
    <input type="hidden" id="pageNo" value="${pageResult.pageNo}">

		<div class="banxin cantent">
			<div class="wenjianxinxi">
				<div class="wj">
					<div class="wjleftleft1">
						<img src="../images/wenjian.png">
					</div>
					<div class="wjleftright">
						<s:iterator value="pageResult.list" id="poolcolllist" status="a">
							<s:if test="#a.last==true">
								<input type="hidden" id="pool_hide_inputcid" value="${poolcolllist.id}">
								<p class="mt">
									collectiontitle : <span>${poolcolllist.collectiontitle}</span>
								</p>
								<p>
									printquantity : <span>${poolcolllist.printquantity}</span>
								</p>
								<p>
									description : <span>${poolcolllist.description0f}</span>
								</p>
							</s:if>
						</s:iterator>
					</div>
				</div>
				<div class="wj1">
					<div>
						<div>Exhibition Information</div>
						<a class="cf" href="#" data-toggle="modal"  data-target="#myModal" onclick="poollist_addexhibition()"></a>
					</div>
					<s:if test='displaylist.size>0'>
					<div id="pool_more" style="width: 100%;">
		            	<s:iterator value="displaylist" id="dislist" status="a">
		            		<input type="hidden" id="pool_hide_input" value="${dislist.id}">
		            		<div class="jb" style="width: 100%;">
			            		<div style="white-space:nowrap; overflow:hidden;text-overflow: ellipsis;width: 80%;height: 80%;">
				            		<s:property value="%{#a.index+1}"/>.
				            		<span>Venue ：${dislist.address}</span>&nbsp;
				            		<span>URL：${dislist.site}</span>&nbsp;
				            		<span>time：<s:date name="#dislist.time" format="yyyy-MM-dd" /></span>
				            	</div>
				            	<span class="jc" onclick="poollist_deleteexhibition('${dislist.id}')" style="cursor: pointer;"></span>
								<span class="jj" onclick="poollist_finddisplayid('${dislist.id}')" data-toggle="modal"  data-target="#myModal"  style="cursor: pointer;"></span>
				            </div>
		            	</s:iterator>
	            	</div>
	       			
	            	<button class="jiazai" onclick="poollist_finddisplaylist()" id="load_more">Load more</button>
	            	<button class="jiazai" style="display: none;" onclick="poollist_shrinkdisplaylist()" id="shrink">shrink</button>
	            	</s:if>
	            	<s:else>
	            		<span>No data</span>
	            	</s:else>
				</div>
			</div>
			<div>
				<div class="lineny"></div>
			</div>
			<div class="Works">
				<s:if test='pageResult.list.size>0'>	
					<s:iterator value="pageResult.list" id="poollist">
					<input type="hidden" id="poollistmemberid" value="${poollist.memberid}">
						<div class="xb">
							<div class="nmd">
								<div class="cg">
									<div class="divp" style="width: 100%;">
										<a class="tooltip" title="${poollist.title}"  id="${sissionFileSerURL}${poollist.storeaddress}">
											<p>Title：${poollist.title}</p>
											<p>Time：<s:date name="#poollist.uploadtime" format="yyyy-MM-dd" /></p>
										</a>
										<p>Title：${poollist.title}</p>
										<p>Time：<s:date name="#poollist.uploadtime" format="yyyy-MM-dd" /></p>
									</div>
									<input type="checkbox" class="inp" style="display: none;" name="fileName" value="${sissionFileSerURL}${poollist.storeaddress}"/>
									<span></span>
									<div class="divxz">
										<a class="xiazaio" href="fileDownload_download.do?urlString=${sissionFileSerURL}${poollist.storeaddress}&filename=${poollist.storeaddress}" ></a>
										
										<%-- href="fileDownload_download.do?urlString='+${sissionFileSerURL}${poollist.storeaddress}+'&filename='+${poollist.storeaddress}+'"
										onclick="pool_download('${poollist.title}')" --%>
										
										<input type="hidden" id="pool_url${poollist.id}" value="${sissionFileSerURL}${poollist.storeaddress}">
										<input type="hidden" id="pool_mc${poollist.id}" value="${poollist.storeaddress}">
									</div>
								</div>
								<div class="shen"></div>
							</div>
								<img src="${sissionFileSerURL}${poollist.thumbnailurl}">
						</div>
					</s:iterator>	
						<button onclick="poollist_download()"><a id="pool_dowln">Download All</a></button>
				</s:if>
				<s:else>
					<div>No data</div>
				</s:else>
			</div>
		</div>
		<!-- 模态框（Modal） -->
			<div class="modal fade" id="myModal" tabindex="-1" role="dialog" 
			   aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static" hidden="">
			   <div class="modal-dialog">
			      <div class="modal-content">
			         <div class="modal-header">
			            <button type="button" class="close" 
			               data-dismiss="modal" aria-hidden="true">
			                  &times;
			            </button>
			            <h4 class="modal-title" id="myModalLabel">
			              ADD Exhibition Information
			            </h4>
			         </div>
			         <div class="modal-body">
			         		<input type="hidden" id="input_displayid" value=""  />
			           		Venue：&nbsp;<input type="text" id="input_address" value="" required="required"/><br>
			           		URL：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input  type="text" id="input_site" value="" required /><br>
			           		time：&nbsp;&nbsp;&nbsp;&nbsp;<input class="m-wrap m-ctrl-medium date-picker" id="input_time" readonly size="16" type="text" name="demoFormNew.form3" />
			         </div>
			         <div class="modal-footer">
			            <button type="button" style="width: 70px;" data-dismiss="modal">
			            	Close
			            </button>
			            <button type="button" onmousemove="pool_verify()" style="float: left;width: 70px;" id="pool_save" data-dismiss="modal" onclick="poollist_saveexhibition()">
			              	Save
			            </button>
			             <button type="button" onmousemove="pool_verify()" style="float: left;width: 70px;" id="pool_update" data-dismiss="modal" onclick="poollist_updateexhibition()">
			              	Update
			            </button>
			         </div>
			      </div><!-- /.modal-content -->
				</div><!-- /.modal -->
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
