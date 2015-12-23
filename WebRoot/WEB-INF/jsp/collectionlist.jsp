<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<link rel="shortcut icon" href="../images/favicon.ico" type="image/x-icon" />
<link href="../css/index_style2.css" rel="stylesheet"/>

<script type="text/javascript">

		//分页及查询
		function collectionlist_findMemberlist(pageNo,color){
			document.getElementById("index_dinid_Collectionlist").style.display="none";
			var collectionpageTotal=$("#collectionlist_poolpageTotal").val();
			
			var collcategories=$("#collectionlist_cCategories").val();
     		var collstyles=$("#collectionlist_Stylescool").val();
     		var collsubjects=$("#collectionlist_Subjects").val();

     		var coolsissionfileSerURL=$("#coolsissionFileSerURL").val();

			var pagnum;
			if(pageNo=='pagNo0'){
				var netxpage;
				if(document.getElementById("divid_collist").style.display=="none"){
					netxpage=$("#collectionlist_inputid_govalaj").val();
				}else{
					netxpage=$("#collectionlist_inputid_goval").val();
				}
				if(netxpage!=undefined&&netxpage!=null&&netxpage!=""&&1<=netxpage&&netxpage<=collectionpageTotal){
					pagnum=netxpage;
				}else{
					return false;
				}
			}else{
				pagnum=pageNo;
			}
			var pageNon=${pageResult.pageNo}+1;
			document.getElementById("divid_collist").style.display="none";
			var URL="tekuma_findcollwnlistajax.do?pageNo="+pagnum+"&collcategories="+collcategories+"&collstyles="+collstyles+"&collsubjects="+collsubjects+"&color="+color;
			$.ajax({url:URL,cache:false,dataType:"json",
				success:function(pageResult){
					var memberlistHTML="";
					if(pageResult.list!=undefined){
						memberlistHTML+="<div class=\"nb\">";
						for(var i=0; i<pageResult.list.length;i++){
							var collthumpath=$("#coll_thumpath"+i).val();
							memberlistHTML+="<div class=\"hehe\" style=\"cursor: pointer;\"onclick=\"index_menuClick('tekuma_findPoollist.do?pageNo=1&collectionid="+pageResult.list[i].id+"')\">";
							memberlistHTML+="<div class=\"jecbox\"><img src=\""+coolsissionfileSerURL+""+collthumpath+"\"/></div>";
							memberlistHTML+="<p>";
							if(pageResult.list[i].firstname!=undefined){
								memberlistHTML+=""+pageResult.list[i].firstname+"";
							}
							if(pageResult.list[i].lastname!=undefined){
								memberlistHTML+="-"+pageResult.list[i].lastname+"";
							}
							memberlistHTML+="</p>"
							memberlistHTML+="<p>"+pageResult.list[i].collectiontitle+"</p>";
							var date = new Date(pageResult.list[i].createtime);
						    var year = date.getFullYear();
						    var month = date.getMonth()+1;  
						    var date1 = date.getDate(); 
						    memberlistHTML+="<p>"+year+"-"+month+"-"+date1+"</span></p>";  
							memberlistHTML+="</div>";
						}
							memberlistHTML+="</div>";
							memberlistHTML+="<div class=\"fenye\">";
							if((pageResult.pageNo-1)<=0){
								memberlistHTML+="<button class=\"anniu1\" style=\"cursor: pointer;\" onclick=\"collectionlist_findMemberlist('"+pageResult.pageNo+"','')\">previous</button>";
							}else{
								memberlistHTML+="<button class=\"anniu1\" style=\"cursor: pointer;\" onclick=\"collectionlist_findMemberlist('"+(pageResult.pageNo-1)+"','')\">previous</button>";
							}
							memberlistHTML+="<input type=\"text\" id=\"collectionlist_inputid_govalaj\"/>";
							if(pageNon<=collectionpageTotal){
								memberlistHTML+="<button class=\"anniu1 anniu\" style=\"cursor: pointer;\" onclick=\"collectionlist_findMemberlist('"+pageNon+"','')\">next</button>";
							}else{
								memberlistHTML+="<button class=\"anniu1 anniu\" style=\"cursor: pointer;\" onclick=\"collectionlist_findMemberlist('"+pageResult.pageNo+"','')\">next</button>";
							}
							memberlistHTML+="<button class=\"go\" style=\"cursor: pointer;\" onclick=\"collectionlist_findMemberlist('pagNo0','')\">GO</button>";
							memberlistHTML+="</div>";
							memberlistHTML+="</div>";
					}else{
						memberlistHTML+="<p align=\"center\">No data! Please re search!</p>";
					}
					//alert(memberlistHTML);
					$("#divid_collist_aj").html(memberlistHTML);
				}
			});
		}
	
	
	
</script>

	<input type="hidden" id="collectionlist_poolpageTotal" value="${pageResult.pageTotal}">
	<input type="hidden" id="collectionlist_poolpageNo" value="${pageResult.pageNo}">
	<input type="hidden" id="coolsissionFileSerURL" value="${sissionFileSerURL}" />
		
	<div class="banxin cantent" id="coolbanxin">
		<p class="pp">All Collectio</p>
      	<div class="line"></div>
      	<div class="dds">
           <%-- <p>genre：
				<s:iterator value="membertypelist" id="mtypelist">
					<a onclick="collectionlist_findMemberlist('${pageResult.pageNo}','','','${mtypelist.membertype}')" style="cursor: pointer;margin-top: 20px;color: blue;">${mtypelist.membertype}</a>&nbsp;&nbsp;
				</s:iterator>
				<button class="lm">more</button>
			</p>
           <p class="pz" id="pz">cinitial：&nbsp;&nbsp;<a href="#">A</a><a href="#">B</a><a href="#">C</a><a href="#">D</a><a href="#">E</a><a href="#">F</a><a href="#">G</a><a href="#">H</a><a href="#">I</a><a href="#">J</a><a href="#">K</a><a href="#">L</a><a href="#">M</a><a href="#">N</a><a href="#">O</a><a href="#">P</a><a href="#">Q</a><a href="#">R</a><a href="#">S</a><a href="#">T</a><a href="#">U</a><a href="#">V</a><a href="#">W</a><a href="#">S</a><a href="#">Y</a><a href="#">Z</a></p>
           <div class="ps"><span>search：&nbsp;</span>
          		<input type="text" class="tex1" id="coolectionlist_inputid_search"/>
				<input class="btn" type="button" style="cursor: pointer;" onclick="collectionlist_findMemberlist('${pageResult.pageNo}','search','','')"/>
      	   </div> --%>
      	   
      	   <select id="collectionlist_cCategories" onchange="collectionlist_findMemberlist('${pageResult.pageNo}','')">
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
			<select id="collectionlist_Stylescool" onchange="collectionlist_findMemberlist('${pageResult.pageNo}','')">
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
			<select id="collectionlist_Subjects" onchange="collectionlist_findMemberlist('${pageResult.pageNo}','')">
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

           <div class="fk" style="cursor: pointer;">
                <p>Reset Colors</p>
                <div onclick="collectionlist_findMemberlist('${pageResult.pageNo}','')" id="divid_cool_color"> 
                      <div class="mm ll lx c1"></div>
                      <div class="mm lx c2"></div>
                      <div class="mm ll c3"></div>
                      <div class="mm c4"></div>
                </div>
				<div class="b1" onclick="collectionlist_findMemberlist('${pageResult.pageNo}','ffffff')" id="divid_cool_color"></div>
				<div class="b2" onclick="collectionlist_findMemberlist('${pageResult.pageNo}','cccccc')" id="divid_cool_color"></div>
                <div class="b3" onclick="collectionlist_findMemberlist('${pageResult.pageNo}','666666')" id="divid_cool_color"></div>
                <div class="b4" onclick="collectionlist_findMemberlist('${pageResult.pageNo}','000000')" id="divid_cool_color"></div>
                <div class="b5" onclick="collectionlist_findMemberlist('${pageResult.pageNo}','a26103')" id="divid_cool_color"></div>
                <div class="b6" onclick="collectionlist_findMemberlist('${pageResult.pageNo}','f69f00')" id="divid_cool_color"></div>
                <div class="b7" onclick="collectionlist_findMemberlist('${pageResult.pageNo}','fecb9c')" id="divid_cool_color"></div>
                <div class="b8" onclick="collectionlist_findMemberlist('${pageResult.pageNo}','fffe00')" id="divid_cool_color"></div>
                <div class="b9" onclick="collectionlist_findMemberlist('${pageResult.pageNo}','cefd00')" id="divid_cool_color"></div>
                <div class="b10" onclick="collectionlist_findMemberlist('${pageResult.pageNo}','94d12c')" id="divid_cool_color"></div>
                <div class="b11" onclick="collectionlist_findMemberlist('${pageResult.pageNo}','06c808')" id="divid_cool_color"></div>
                <div class="b12" onclick="collectionlist_findMemberlist('${pageResult.pageNo}','22ffc5')" id="divid_cool_color"></div>
                <div class="b13" onclick="collectionlist_findMemberlist('${pageResult.pageNo}','06c4f6')" id="divid_cool_color"></div>
                <div class="b14" onclick="collectionlist_findMemberlist('${pageResult.pageNo}','0282f0')" id="divid_cool_color"></div>
                <div class="b15" onclick="collectionlist_findMemberlist('${pageResult.pageNo}','8500f9')" id="divid_cool_color"></div>
                <div class="b16" onclick="collectionlist_findMemberlist('${pageResult.pageNo}','d600ff')" id="divid_cool_color"></div>
                <div class="b17" onclick="collectionlist_findMemberlist('${pageResult.pageNo}','ff009a')" id="divid_cool_color"></div>
                <div class="b18" onclick="collectionlist_findMemberlist('${pageResult.pageNo}','0fa0202')" id="divid_cool_color"></div>
           		<!-- <input class="color" id="myColor" value="red" size="10px"  onclick=""> -->
           </div>	  
      	 </div>
      	<div class="line1"></div>
      	<div id="divid_collist">
	      	<div class="nb">
	        	<s:iterator value="pageResult.list" id="collectionlist" status="a">
	        		<div class="hehe" style="cursor: pointer;"onclick="index_menuClick('tekuma_findPoollist.do?pageNo=1&collectionid='+${collectionlist.id})">
			          	<!-- <div class="jecbox"><img src="../images/wenjian.png"/></div> --> 
			          	<input type="hidden" id="coll_thumpath<s:property value="#a.index"/>" value="${collectionlist.thumbnailpath}">
			          	<div class="jecbox"><img src="${sissionFileSerURL}${collectionlist.thumbnailpath}"/></div>
			          	<p>${collectionlist.firstname} ${collectionlist.lastname}</p>
			          	<p>${collectionlist.collectiontitle}</p>
			          	<p><s:date name="#collectionlist.createtime" format="yyyy-MM-dd"/></p>        
		            </div>
		        </s:iterator>
	        </div>
		    <div class="fenye kill">
			   <button class="anniu1" style="cursor: pointer;" onclick="collectionlist_findMemberlist('${pageResult.pageNo}','')">previous</button>
			   <input type="text" id="collectionlist_inputid_goval"/>
			   <button class="anniu1 anniu" style="cursor: pointer;" onclick="collectionlist_findMemberlist('${pageResult.pageNo+1}','')">next</button>
			   <button class="go" style="cursor: pointer;" onclick="collectionlist_findMemberlist('pagNo0','')">GO</button>
			</div>
		</div>
		<div id="divid_collist_aj"></div>
	
</div>
		
<script type="text/javascript" src="../plugins/select2/select2.min.js"></script>
<script type="text/javascript" src="../plugins/bootstrap-datepicker/js/bootstrap-datepicker.js"></script>
<script type="text/javascript" src="../plugins/bootstrap-datetimepicker/js/bootstrap-datetimepicker.js"></script>
<script type="text/javascript" src="../plugins/jquery-inputmask/jquery.inputmask.bundle.min.js"></script>   
<script type="text/javascript" src="../plugins/jquery.input-ip-address-control-1.0.min.js"></script>
<script type="text/javascript" src="../plugins/jquery-multi-select/js/jquery.multi-select.js"></script>
<script type="text/javascript" src="../themes/admin/metronic_admin/_static/scripts/form-components.js"></script> 
<script type="text/javascript" src="../plugins/bootstrap-fileupload/bootstrap-fileupload.js"></script> 


<script>
	jQuery(document).ready(function() {          
	   // initiate layout and plugins
	   //App.init();
	   FormComponents.init();
	});
	function index_menuClick(contentURL){
		//alert(contentURL);
		document.getElementById("index_dinid_Collectionlist").style.display="none";
		public_menuContentURL=contentURL;
		public_openContent(contentURL);
		
		
	}
	
	
</script>
