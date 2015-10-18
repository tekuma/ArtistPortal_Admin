<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<link href="../css/index_style2.css" rel="stylesheet"/>

<script type="text/javascript">
	
	//分页查询collection信息
	function memberlist_findMemberlist(pageNo,memberid){
		var indexpageTotal=$("#memcollevtionlist_poolpageTotal").val();
		var pagnum;
		if(pageNo=='pagNo0'){
			var netxpage;
			if(document.getElementById("collection_divid_content").style.display=="none"){
				netxpage=$("#collection_inputid_govalaj").val();
			}else{
				netxpage=$("#collection_inputid_goval").val();
			}
			if(netxpage!=undefined&&netxpage!=null&&netxpage!=""&&1<=netxpage&&netxpage<=indexpageTotal){
				pagnum=netxpage;
			}else{
				return false;
			}
		}else{
			pagnum=pageNo;
		}
		var mempageNom=${pageResult.pageNo}+1;
		document.getElementById("collection_divid_content").style.display="none";
		var URL="tekuma_findCollectionlistajax.do?memberid="+memberid+"&pageNo="+pagnum;
		$.ajax({url:URL,cache:false,dataType:"json",
			success:function(pageResult){
				var memberlistHTML="";
				if(pageResult.list!=undefined){
					memberlistHTML+="<div class=\"nb\">";
					for(var i=0; i<pageResult.list.length;i++){
						memberlistHTML+="<div class=\"hehe\" onclick=\"index_menuClick('tekuma_findPoollist.do?pageNo=1&collectionid="+pageResult.list[i].id+"')\">";
						memberlistHTML+="<div class=\"jecbox\">";
						memberlistHTML+="<img src=\"../images/wenjian.png\"/></div>";
						memberlistHTML+="<p class=\"liclass_index_menu\" >"+pageResult.list[i].collectiontitle+"</p>";
						var date = new Date(pageResult.list[i].createtime);
					    var year = date.getFullYear();
					    var month = date.getMonth()+1;  
					    var date1 = date.getDate(); 
					    var hour = date.getHours(); 
					    var minutes = date.getMinutes(); 
					    var second = date.getSeconds();
					    memberlistHTML+="<p>"+year+"-"+month+"-"+date1+"</p>";  
						memberlistHTML+="</div>";
					}
						memberlistHTML+="</div>";
						memberlistHTML+="<div class=\"fenye\">";
						if((pageResult.pageNo-1)<=0){
							memberlistHTML+="<button class=\"anniu1\" style=\"cursor: pointer;\" onclick=\"memberlist_findMemberlist('"+pageResult.pageNo+"','"+memberid+"')\">previous</button>";
						}else{
							memberlistHTML+="<button class=\"anniu1\" style=\"cursor: pointer;\" onclick=\"memberlist_findMemberlist('"+(pageResult.pageNo-1)+"','"+memberid+"')\">previous</button>";
						}
						memberlistHTML+="<input type=\"text\" id=\"collection_inputid_govalaj\"/>";
						if(mempageNom<=pageResult.pageTotal){
							memberlistHTML+="<button class=\"anniu1 anniu\" style=\"cursor: pointer;\" onclick=\"memberlist_findMemberlist('"+mempageNom+"','"+memberid+"')\">next</button>";
						}else{
							memberlistHTML+="<button class=\"anniu1 anniu\" style=\"cursor: pointer;\" onclick=\"memberlist_findMemberlist('"+pageResult.pageTotal+"','"+memberid+"')\">next</button>";
						}
						memberlistHTML+="<button class=\"go\" style=\"cursor: pointer;\" onclick=\"memberlist_findMemberlist('pagNo0','"+memberid+"')\">GO</button>";
						memberlistHTML+="</div>";
				}else{
					memberlistHTML+="<p align=\"center\">No data</p>";
				}
				//alert(memberlistHTML);
				$("#collection_divid_contentaj").html(memberlistHTML);
			}
		});
	}
	
	

	
	
</script>

		<input type="hidden" id="memcollevtionlist_poolpageTotal" value="${pageResult.pageTotal}">
	    <input type="hidden" id="memcollevtionlist_pageNo" value="${pageResult.pageNo}">
        <input type="hidden" id="memcollevtionlist_memberid" value="${memberNew.id}">
        
		<div class="banxin cantent">
			<div class="wenjianxinxi">
			    <div class="wj">
				    <div class="wjleftleft">
					    <s:if test='memberNew.avatarpath!=null&&memberNew.avatarpath!=""'>
					    	<img src="${sissionFileSerURL}${memberNew.avatarpath}" width="120px" height="100px">
				    	</s:if>
				    	<s:else>
				    		<img src="../images/DefaultAvatar.gif" width="120px" height="100px">
				    	</s:else>
			    	</div>
		            <div class="wjleftright">
			            <p class="mt">Name : <span>${memberNew.firstname} ${memberNew.lastname}</span></p>
				        <p>Birthday : <span><s:date name='memberNew.birthday' format="yyyy-MM-dd"/></span></p>
				        <p>Telephone : <span>${memberNew.telephone}</span></p>
				        <p>Email : <span>${memberNew.email}</span></p>  
		            </div>
			    </div>
	            <div class="wj1">
	               <div>
	                    <div>introduction</div>
	               </div>
	               <div class="text">
	               	${memberNew.introduction}
	               </div>
	            </div>
			</div>
	      	<div class="lineny"></div>
	       	<div>Pay ment information : <span></span> <span class="jianjv">bank :</span> <span>${memberNew.bank}</span></div>
	      	<div>bankaccount payee : <span>${memberNew.bankaccount}</span> <span class="jianjv1">payee :</span> <span>${memberNew.payee}</span></div>
	      	<div class="lineny"></div>
	      	
	      	<div id="collection_divid_content">
		       	<div class="nb">
		       		<s:if test='pageResult.list.size>0'>
						<s:iterator value="pageResult.list" id="collectionlist" status="a">
							<%-- <s:if test="#a.index>0"> --%>
								<div class="hehe" style="cursor: pointer;" onclick="index_menuClick('tekuma_findPoollist.do?pageNo=1&collectionid='+${collectionlist.id})">
								 	<div class="jecbox"><img src="../images/wenjian.png"/></div>
									<p>${collectionlist.collectiontitle}</p>
									<p><s:date name="#collectionlist.createtime" format="yyyy-MM-dd"/></p>
								</div>
							<%-- </s:if> --%>
						</s:iterator>
					</s:if>
					<s:else>
						<p>No Data</p>
					</s:else>
		       </div>
		        <div class="fenye">
		        	<s:if test='pageResult.pageNo!=1'>
				        <button class="anniu1" style="cursor: pointer;" onclick="memberlist_findMemberlist('${pageResult.pageNo}','${memberNew.id}')">previous</button>
				    </s:if>
				    <s:else>
				    	 <button class="anniu1" style="cursor: pointer;">previous</button>
				    </s:else>
			       	<input type="text" id="collection_inputid_goval"/>
			       	<s:if test='pageResult.pageNo+1<=pageResult.pageTotal'>
				         <button class="anniu1 anniu" style="cursor: pointer;" onclick="memberlist_findMemberlist('${pageResult.pageNo+1}','${memberNew.id}')">next</button>
				    </s:if>
				    <s:else>
				    	  <button class="anniu1 anniu" style="cursor: pointer;">next</button>
				    </s:else>
			       	
			       <button class="go" style="cursor: pointer;" onclick="memberlist_findMemberlist('pagNo0','${memberNew.id}')">GO</button>
		        </div>
	        </div>
	        <div id="collection_divid_contentaj"></div>
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
		public_menuContentURL=contentURL;
		public_openContent(contentURL);
		document.getElementById("index_dinid_Collectionlist").style.display="none";
		
		
	}
</script>
