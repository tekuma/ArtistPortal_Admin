<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>tekuma-Management system</title>
	<link href="../css/index_style.css" rel="stylesheet"/>
	
	<script type="text/javascript">

		//禁用ALT+方向键后退网页
		function KeyDown() 
		 { 
		  if((window.event.keyCode==37)&&(window.event.altKey)) 
		   {    
		    event.returnValue=false;
		   } 
		 }
		document.onkeydown = KeyDown;
	
	
		//分页及查询
     	function index_findMemberlist(pageNo,letters){
     		document.getElementById("index_dinid_Collectionlist").style.display="";
     		var indexpageTotal=$("#index_pageTotal").val();
     		var sissionFileSerURL=$("#sissionFileSerURL").val();
     		
     		var indexcategories=$("#index_categories").val();
     		var indexstyles=$("#index_styles").val();
     		var indexsubjects=$("#index_subjects").val();
     		//alert(categories);
     		//alert(styles);
     		//alert(subjects);
     		
    		var pagnum;
    		if(pageNo=='pagNo0'){
    			var netxpage;
    			if(document.getElementById("index_divid_content").style.display=="none"){
    				netxpage=$("#index_inputid_govalaj").val();
    			}else{
    				netxpage=$("#index_inputid_goval").val();
    			}
    			if(netxpage!=undefined&&netxpage!=null&&netxpage!=""&&1<=netxpage&&netxpage<=indexpageTotal){
    				pagnum=netxpage;
    			}else{
    				return false;
    			}
    		}else{
    			pagnum=pageNo;
    		}
    		var pageNom=${pageResult.pageNo}+1;
    		document.getElementById("index_divid_content").style.display="none";
    		var URL="tekuma_findMemberlistajax.do?pageNo="+pagnum+"&letters="+letters+"&categories="+indexcategories+"&styles="+indexstyles+"&subjects="+indexsubjects;
    		$.ajax({url:URL,cache:false,dataType:"json",
    			success:function(pageResult){
    				var memberlistHTML="";
    				if(pageResult.list!=undefined){
    					memberlistHTML+="<div class=\"banxin cantent\">";
    					memberlistHTML+="<div class=\"nb\">";
    					for(var i=0; i<pageResult.list.length;i++){
    						memberlistHTML+="<div class=\"divbox\" onclick=\"index_menuClick('tekuma_findCollectionlist.do?pageNo=1&memberid='+"+pageResult.list[i].id+")\">";
							memberlistHTML+="<div class=\"imgbox\">";
    						if(pageResult.list[i].avatarpath!=undefined&&pageResult.list[i].avatarpath!=null&&pageResult.list[i].avatarpath!=""){
    							memberlistHTML+="<img src=\""+sissionFileSerURL+""+pageResult.list[i].avatarpath+"\" style=\"cursor: pointer;\" width=\"105px\" height=\"100px\"><br/>";
    						}else{
    							memberlistHTML+="<img src=\"../images/Default Avatar .gif\" style=\"cursor: pointer;\" width=\"105px\" height=\"100px\"><br/>";
    						}
    						memberlistHTML+="</div>";
    						memberlistHTML+="<p style=\"cursor: pointer;\">"
    						if(pageResult.list[i].firstname!=undefined){
    							memberlistHTML+=""+pageResult.list[i].firstname+"&nbsp;";
    						}
    						if(pageResult.list[i].lastname!=undefined){
    							memberlistHTML+=""+pageResult.list[i].firstname+"";
    						}
    						memberlistHTML+="</p>";
    						memberlistHTML+="</div>";
    					}
    						memberlistHTML+="</div>";
    						memberlistHTML+="<div class=\"fenye\">";
    						if((pageResult.pageNo-1)<=0){
    							memberlistHTML+="<button class=\"anniu1\" style=\"cursor: pointer;\" onclick=\"index_findMemberlist('"+pageResult.pageNo+"','"+letters+"')\">previous</button>";
    						}else{
    							memberlistHTML+="<button class=\"anniu1\" style=\"cursor: pointer;\" onclick=\"index_findMemberlist('"+(pageResult.pageNo-1)+"','"+letters+"')\">previous</button>";
    						}
    						memberlistHTML+="<input type=\"text\" id=\"index_inputid_govalaj\"/>";
    						if(pageNom<=pageResult.pageTotal){
    							memberlistHTML+="<button class=\"anniu1 anniu\" style=\"cursor: pointer;\" onclick=\"index_findMemberlist('"+(pageResult.pageTotal+1)+"','"+letters+"')\">next</button>";
    						}else{
    							memberlistHTML+="<button class=\"anniu1 anniu\" style=\"cursor: pointer;\" onclick=\"index_findMemberlist('"+pageResult.pageTotal+"','"+letters+"')\">next</button>";
    						}
    						memberlistHTML+="<button class=\"go\" style=\"cursor: pointer;\" onclick=\"index_findMemberlist('pagNo0','"+letters+"')\">GO</button>";
    						memberlistHTML+="</div>";
    						memberlistHTML+="</div>";
    				}else{
    					memberlistHTML+="<p align=\"center\">No data please reload</p>";
    				}
    				//alert(memberlistHTML);
    				$(".divclass_index_content").html(memberlistHTML);
    			}
    		});
    	}

		
		//为字母绑定事件
		function lettersbind(){
			var indexpageNo=$("#index_pageNo").val();
			$("#index_pid_letters a").each(function(){ //由于复选框一般选中的是多个,所以可以循环输出
	 			var chk=$(this).text();
	 			//alert(chk);
	 			$(this).click(function(event) {
	 				index_findMemberlist(indexpageNo,chk);
	 			});
			})
			//alert("ok");
		}
		setTimeout("lettersbind();",1000);
		
		//点击artists
		function onclickartists(){
			document.getElementById("index_artists").style.backgroundColor = "#D17600";
			document.getElementById("index_collections").style.backgroundColor = "";
			document.getElementById("index_invite").style.backgroundColor = "";
			var coolbanxin=document.getElementById("coolbanxin");
			$("#type").val("mem1");
			if(coolbanxin!=null){
				document.getElementById("coolbanxin").style.display="none";
			}
			var ul=document.getElementById("poollist_li");
			if(ul!=null){
				ul.remove();
			}
			index_findMemberlist('1','');
		}
		//点击collections
		function onclickcollections(){
			document.getElementById("index_artists").style.backgroundColor = "";
			document.getElementById("index_collections").style.backgroundColor = "#D17600";
			document.getElementById("index_invite").style.backgroundColor = "";
			var ul=document.getElementById("poollist_li");
			$("#type").val("coll1");
			if(ul!=null){
				ul.remove();
			}
			index_menuClick("tekuma_findcollwnlist.do?pageNo=1");
		}
		//点击invite
		function onclickinvite(){
			document.getElementById("index_artists").style.backgroundColor = "";
			document.getElementById("index_collections").style.backgroundColor = "";
			document.getElementById("index_invite").style.backgroundColor = "#D17600";
			var ul=document.getElementById("poollist_li");
			if(ul!=null){
				ul.remove();
			}
			index_menuClick("tekuma_makeCode.do");
		}
		

		<!-- 加载等待图 -->
		 //显示和隐藏加载图片
    	 function showdiv() {
    		document.getElementById("bg").style.display ="block";
    	 }
    	 function hidediv() {
    		document.getElementById("bg").style.display ="none";
    	 }
    	 setTimeout("showdiv();",1000);
    	 setTimeout("hidediv();",2000);
		
		
    </script>

<!-- 加载等待图 -->
<style type="text/css">
 	#bg{ display: none;text-align:center; position: absolute; top: 0%; left: 0%; width: 100%; height: 100%; background-color: white; z-index:1000; -moz-opacity: 0.7; opacity:.70; filter: alpha(opacity=70);}
</style>

</head>


<body oncontextmenu="self.event.returnValue=false" onselectstart="return false" >

		<!-- BEGIN SIDEBAR -->
		<!-- END SIDEBAR --  onclick="index_menuClick('tekuma_findMemberlist.do?pageNo=1')"   
		<a href="download.do?fileName=E:\psychologydb原版.sql">下载</a> >
		<!-- BEGIN PAGE -->
		<input type="hidden" id="index_pageTotal" value="${pageResult.pageTotal}" />
		<input type="hidden" id="index_pageNo" value="${pageResult.pageNo}" />
		<input type="hidden" id="sissionFileSerURL" value="${sissionFileSerURL}" />
		<input type="hidden" id="type" value="mem1" />
		
		<!-- 加载等待图 -->
		<div id="bg">
	 		<img src="../images/jz2.gif" alt="" style="margin-top: 15%;"/>
	 		<p style="font-size: 25px;margin-top: 20px;">Loading  Please wait......</p>
 		</div>
		
		<div class="header">
			<div class="banxin tool">
				<span href="#" id="logo"></span>
			  	<span class="span1">TEKUMA</span>
				<span class="span2">&nbsp;&nbsp;</span>
			  	<div class="div2">
			  		<div class="div11 div222"></div>
			  		<div style="margin-top: 25px;"><a href="javascript:void(0)" onclick="location.href='http://127.0.0.1:8080/tekumaServer/'" style="color:green;">Sign out</a></div>
			  	</div>
			   	<div class="div1">
			        <div class="div11 div111"></div>
			        <div style="margin-left: 5px;margin-top: 24px;">Welcome:${yhxm}</div>
			  	</div>
			</div>
		</div>
        <div class="nav">
         	<ul class="banxin" id="index_ul">
              <li><a href="#" id="index_artists" style="background-color: #D17600;" onclick="onclickartists()">Artists</a></li>
              <li><a href="#" id="index_collections" onclick="onclickcollections()">Collections</a></li>
              <li><a href="#" id="index_invite" onclick="onclickinvite()">invite</a></li>
         	</ul> 							
      	</div>
		<div class="banxin cantent" id="index_dinid_Collectionlist">
			<p class="pp">All Artists</p>
			<div class="line"></div>
			<div class="dds">
				<%-- <p>
					genre：&nbsp;&nbsp;
					<s:iterator value="membertypelist" id="mtypelist">
						<a onclick="index_findMemberlist('${pageResult.pageNo}','${mtypelist.membertype}','')" style="cursor: pointer;margin-top: 20px;color: blue;">${mtypelist.membertype}</a>&nbsp;&nbsp;
					</s:iterator>
					<button class="lm">Load more</button>
				</p> --%>
			<p>Search:
			<select id="index_categories" onchange="index_findMemberlist('${pageResult.pageNo}','')">
				<option value="">All Categories</option>
				<option value="Collage">Collage</option>
				<option value="Drawing">Drawing</option>
				<option value="Installation">Installation</option>
				<option value="New Media">New Media</option>
				<option value="Painting">Painting</option>
				<option value="Photography">Photography</option>
				<option value="Printmaking">Printmaking</option>
				<option value="Sculpture">Sculpture</option>
				<option value="Video">Video</option>
			</select> 
			<select id="index_styles" onchange="index_findMemberlist('${pageResult.pageNo}','')">
				<option value="">All Styles</option>
				<option value="Abstract">Abstract</option>
				<option value="Abstract Expressionism">Abstract Expressionism</option>
				<option value="Art Deco">Art Deco</option>
				<option value="Conceptual">Conceptual</option>
				<option value="Cubism">Cubism</option>
				<option value="Dada">Dada</option>
				<option value="Documentary">Documentary</option>
				<option value="Expressionism">Expressionism</option>
				<option value="Figurative">Figurative</option>
				<option value="Fine Art">Fine Art</option>
				<option value="Folk">Folk</option>
				<option value="Illustration">Illustration</option>
				<option value="Impressionism">Impressionism</option>
				<option value="Minimalism">Minimalism</option>
				<option value="Modern">Modern</option>
				<option value="Photorealism">Photorealism</option>
				<option value="Pop Art">Pop Art</option>
				<option value="Portraiture">Portraiture</option>
				<option value="Realism">Realism</option>
				<option value="Street Art">Street Art</option>
				<option value="Surrealism">Surrealism</option>
			</select> 
			<select id="index_subjects" onchange="index_findMemberlist('${pageResult.pageNo}','')">
				<option value="">All Subjects</option>
				<option value="Abstract">Abstract</option>
				<option value="Aerial">Aerial</option>
				<option value="Aeroplane">Aeroplane</option>
				<option value="Airplane">Airplane</option>
				<option value="Animal">Animal</option>
				<option value="Architecture">Architecture</option>
				<option value="Automobile">Automobile</option>
				<option value="Beach">Beach</option>
				<option value="Bicycle">Bicycle</option>
				<option value="Bike">Bike</option>
				<option value="Boat">Boat</option>
				<option value="Body">Body</option>
				<option value="Botanic">Botanic</option>
				<option value="Business">Business</option>
				<option value="Calligraphy">Calligraphy</option>
				<option value="Car">Car</option>
				<option value="Cartoon">Cartoon</option>
				<option value="Cats">Cats</option>
				<option value="Celebrity">Celebrity</option>
				<option value="Children">Children</option>
				<option value="Cinema">Cinema</option>
				<option value="Cities">Cities</option>
				<option value="Classical mythology">Classical mythology</option>
				<option value="Comics">Comics</option>
				<option value="Cows">Cows</option>
				<option value="Cuisine">Cuisine</option>
				<option value="Culture">Culture</option>
				<option value="Dogs">Dogs</option>
				<option value="Education">Education</option>
				<option value="Erotic">Erotic</option>
				<option value="Family">Family</option>
				<option value="Fantasy">Fantasy</option>
				<option value="Fashion">Fashion</option>
				<option value="Fish">Fish</option>
				<option value="Floral">Floral</option>
				<option value="Food">Food</option>
				<option value="Food &amp; Drink">Food &amp; Drink</option>
				<option value="Garden">Garden</option>
				<option value="Geometric">Geometric</option>
				<option value="Graffiti">Graffiti</option>
				<option value="Health &amp; Beauty">Health &amp; Beauty</option>
				<option value="Home">Home</option>
				<option value="Horse">Horse</option>
				<option value="Humor">Humor</option>
				<option value="Interiors">Interiors</option>
				<option value="Kids">Kids</option>
				<option value="Kitchen">Kitchen</option>
				<option value="Landscape">Landscape</option>
				<option value="Language">Language</option>
				<option value="Light">Light</option>
				<option value="Love">Love</option>
				<option value="Men">Men</option>
				<option value="Mortality">Mortality</option>
				<option value="Motor">Motor</option>
				<option value="Motorbike">Motorbike</option>
				<option value="Motorcycle">Motorcycle</option>
				<option value="Music">Music</option>
				<option value="Nature">Nature</option>
				<option value="Nude">Nude</option>
				<option value="Outer Space">Outer Space</option>
				<option value="Patterns">Patterns</option>
				<option value="People">People</option>
				<option value="Performing Arts">Performing Arts</option>
				<option value="Places">Places</option>
				<option value="Political">Political</option>
				<option value="Politics">Politics</option>
				<option value="Pop Culture/Celebrity">Pop Culture/Celebrity</option>
				<option value="Popular culture">Popular culture</option>
				<option value="Portrait">Portrait</option>
				<option value="Religion">Religion</option>
				<option value="Religious">Religious</option>
				<option value="Rural life">Rural life</option>
				<option value="Sailboat">Sailboat</option>
				<option value="Science">Science</option>
				<option value="Science/Technology">Science/Technology</option>
				<option value="Seascape">Seascape</option>
				<option value="Seasons">Seasons</option>
				<option value="Ship">Ship</option>
				<option value="Sport">Sport</option>
				<option value="Sports">Sports</option>
				<option value="Still Life">Still Life</option>
				<option value="Technology">Technology</option>
				<option value="Time">Time</option>
				<option value="Train">Train</option>
				<option value="Transportation">Transportation</option>
				<option value="Travel">Travel</option>
				<option value="Tree">Tree</option>
				<option value="Typography">Typography</option>
				<option value="Wall">Wall</option>
				<option value="Water">Water</option>
				<option value="Women">Women</option>
				<option value="World Culture">World Culture</option>
				<option value="Yacht">Yacht</option>
			</select>
			</p>
			
			<p class="pz" id="index_pid_letters">cinitial：
					<a href="#">A</a><a href="#">B</a><a href="#">C</a><a href="#">D</a><a href="#">E</a>
					<a href="#">F</a><a href="#">G</a><a href="#">H</a><a href="#">I</a><a href="#">J</a><a href="#">K</a>
					<a href="#">L</a><a href="#">M</a><a href="#">N</a><a href="#">O</a><a href="#">P</a><a href="#">Q</a>
					<a href="#">R</a><a href="#">S</a><a href="#">T</a><a href="#">U</a><a href="#">V</a><a href="#">W</a>
					<a href="#">X</a><a href="#">Y</a><a href="#">Z</a>
			</p>
				<%-- <div class="ps">
					<span>search：</span>
					<input type="text" class="tex1" id="index_inputid_search"/>
					<input class="btn" type="button" style="cursor: pointer;" onclick="index_findMemberlist('${pageResult.pageNo}','search','')"/>
				</div> --%>
			</div>
			<div class="line1"></div>
			
			<div id="index_divid_content">
				<div class="nb">
					<s:iterator value="pageResult.list" id="imemberlist">
						<div class="divbox">
							<div class="imgbox">
								<s:if test='#imemberlist.avatarpath!=null&&#imemberlist.avatarpath!=""'>
									<img src="${sissionFileSerURL}${imemberlist.avatarpath}" style="cursor: pointer;" width="105px" height="100px" onclick="index_menuClick('tekuma_findCollectionlist.do?pageNo=1&memberid='+${imemberlist.id})" />	
								</s:if>
								<s:else>
									<img src="../images/DefaultAvatar.gif" style="cursor: pointer;" width="105px" height="100px" onclick="index_menuClick('tekuma_findCollectionlist.do?pageNo=1&memberid='+${imemberlist.id})" />
								</s:else>
							</div>
							<p style="cursor: pointer;" onclick="index_menuClick('tekuma_findCollectionlist.do?pageNo=1&memberid='+${imemberlist.id})">
							<s:if test='#imemberlist.firstname!=null'>
								${imemberlist.firstname}
							</s:if>
							<s:if test='#imemberlist.lastname!=null'>
								${imemberlist.lastname}
							</s:if>
							</p>
						</div>
					</s:iterator>
				</div>
				
				<div class="fenye">
					<s:if test='pageResult.pageNo!=1'>
				        <button class="anniu1" style="cursor: pointer;" onclick="index_findMemberlist('${pageResult.pageNo}','')">previous</button>
				    </s:if>
				    <s:else>
				    	<button class="anniu1" style="cursor: pointer;">previous</button>
				    </s:else>
			        <input type="text" id="index_inputid_goval"/>
			        <s:if test='pageResult.pageNo+1<=pageResult.pageTotal'>
				         <button class="anniu1 anniu" style="cursor: pointer;" onclick="index_findMemberlist('${pageResult.pageNo+1}','')">next</button>
				    </s:if>
				    <s:else>
				    	 <button class="anniu1 anniu" style="cursor: pointer;">next</button>
				    </s:else>
			        <button class="go" style="cursor: pointer;" onclick="index_findMemberlist('pagNo0','')">GO</button>
		        </div>
	        </div>
		</div>

		<!-- 动态加载文本部分 -->
		<div class="divclass_index_content" ></div>
		<!-- END PAGE -->
		
	<!-- END CONTAINER -->

	<!-- 首页加载的js -->
	<script src="../plugins/jq.js" type="text/javascript"></script>
	<script src="../plugins/jquery-migrate-1.2.1.min.js" type="text/javascript"></script>
	<script src="../plugins/jquery-ui/jquery-ui-1.10.1.custom.min.js" type="text/javascript"></script>      
	<script src="../plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
	<script src="../plugins/bootstrap-hover-dropdown/twitter-bootstrap-hover-dropdown.min.js" type="text/javascript" ></script>
	<!--[if lt IE 9]>
	<script src="../plugins/excanvas.min.js"></script>
	<script src="../plugins/respond.min.js"></script>  
	<![endif]-->   
	<script src="../plugins/jquery-slimscroll/jquery.slimscroll.min.js" type="text/javascript"></script>
	<script src="../plugins/jqvmap/jqvmap/jquery.vmap.js" type="text/javascript"></script>   
	<script src="../plugins/flot/jquery.flot.js" type="text/javascript"></script>
	<script src="../themes/admin/metronic_admin/_static/scripts/app.js" type="text/javascript"></script>
	
	<script src="../js/ajaxfileupload.js" type="text/javascript"></script>
	<script src="../js/zhhb.public.js" type="text/javascript"></script>


	<script>
		/* jQuery(document).ready(function() {    
		   App.init(); // initlayout and core plugins
		   $(".page-container").css("min-height",($(window).height()-46)+"px");
		   $(".page-content").css("min-height",($(window).height()-46)+"px");
		   
		}); */
		//菜单栏点击
		function index_menuClick(contentURL){
			//alert(contentURL);
			public_menuContentURL=contentURL;
			public_openContent(contentURL);
			document.getElementById("index_dinid_Collectionlist").style.display="none";
		}
			
	</script>
</body>
<!-- END BODY -->
</html>