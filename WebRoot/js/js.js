// JavaScript Document
	   $(".xb").each(function(index, element) {
           $(this).mouseover(function(){
			     $(this).children().css("top","0px");
			   })
    });
	 $(".xb").each(function(index, element) {
		 
           $(this).mouseout(function(){
			   if($(this).first().find("input").is(':checked')){
				   
			     $(this).children().css("top","0px");
			    }else{
					$(this).children().css("top","160px");
					}
			   });
    });