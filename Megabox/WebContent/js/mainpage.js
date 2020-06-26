
	$(function(){
		/*왼쪽 상단 메뉴 출력 */
		$(document).on("click", ".menuBtn", function(){
	        $('.menuBtn_sitemap').show();
	        $('.menuClose').show();
	    });
		
		/*왼쪽 상당 메뉴 닫기*/
	    $(document).on("click", ".menuClose", function(){
	    	$('.menuBtn_sitemap').hide();
	        $('.menuClose').hide();
	    });
	    
	    /*영화 줄거리*/
        $('ol').hover(function () {
            var idx = $(this).index() + 1;
            console.log
            $('ol.movie-group.' + idx + ' .movie-post>.movie-summ').show();
        }, function () {
            var idx = $(this).index() + 1;
            $('ol.movie-group.' + idx + ' .movie-post>.movie-summ').hide();
        });
        
        /*영화 검색 창 출력*/
        $(document).on("click", ".searchBtn", function(){
        	$('.searchBtn_sitemap').show();
	        $('.searchClose').show();
	    });
        
        /*영화 검색창 닫기*/
	    $(document).on("click", ".searchBtn", function(){
	    	$('.searchBtn_sitemap').hide();
	        $('.searchClose').hide();
	    });
	    
	    /*마이페이지 클릭시 보이는 팝업창*/
	    $(document).on("click", ".mymegaBtn", function(){
	    	$('.mymegaBtn_sitemap1').show();
	        $('.mymegaClose').show();
	    });
	    
	    /*마이페이지 팝업창 닫기*/
	    $(document).on("click", ".mymegaClose", function(){
	        $('.mymegaBtn_sitemap1').hide();
	        $('.mymegaClose').hide();
	    });
	    
	    
	    /*$('.movieBtn').hover(function(){
	        $('.movieBtn_menu').show();}
	        , function(){$('.movieBtn_menu').hide();
	    }); */
	    
	    /*$('.reserveBtn').hover(function(){
	        $('.reserveBtn_menu').show();}
	        , function(){$('.reserveBtn_menu').hide();
	    }); */
	    
	    /*마이페이지 팝업창에서 로그인*/
	    $(document).on("click", "#moveLogin", function(){
	    	$("#loginpopup").show();
	    });
	    
	    /*로그인 팝업창 가져오기*/
	    $(document).on("click", "#loginbringPopup", function(){
	    	$("#loginpopup").show();
	    });
	    
	    /*로그인 버튼 클릭시 로그인 팝업창 닫기*/
	    $(document).on("click", ".confirm", function(){
	    	$("#loginpopup").hide();
	    });
	    
	    /*로그인 팝업창 닫기*/
	    $(document).on("click", ".close-login", function(){
	    	$("#loginpopup").hide();
	    });
	    
		/*패스워드 클릭하면 로그인 버튼이 보라색으로 변경*/
	    $(document).on("click", "#ibxLoginPwd", function(){
			$(".button").css("background-color", "#503396").css("color", "#fff");
		});
		
		$(document).on("click", "#logout", function(){
			
			$.ajax({
				type : 'post',
				url : '/Megabox/Logout',
				success : function(){
					alert("로그아웃 성공");
					location.replace('mainpage.jsp');
				},
				error:function(request,status,error){
					alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			});
			
		});
		
		$(document).on("click", "#loginSubmit", function(){
			
			var formData = $("form[name=loginForm]").serialize();
			
			$.ajax({
				type : 'post',
				url : '/Megabox/LoginDAO',
				data : formData,
				success : function(data){
					data = decodeURIComponent(data);
					data = data.substring(19).replace(/\+/gi," ");
					alert(data);
				},
				error:function(request,status,error){
					alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			});
			
		});
		
		
		$("button.heart").click(function(){
	    	if($(this).hasClass("click")){
	    		if($(this).children().attr("src")=='image/heart_1.png'){
	    			var title = $(this).prev().text().split(",")[0];
	    			var userid = $(this).prev().text().split(",")[1];
	    			var parameters = {"userid" : userid, "title" : title};
	    		
	    			$.ajax({
	    				url:'/Megabox/MinusLikeDAO',
	    				type : 'POST',
	    				dataType:'text',//받아올 데이터 타입
	    				data:{"userid" : userid, "title" : title},
	    				context : this,
	    				success:function(data){
	    					var num = data.split('x')[1];
	    					$(this).children().attr("src",'image/heart_.png');
	    					$(this).children().next().text(num);
	    				},
	    				error:function(request,status,error){
	    					console.log("유감");
	    					alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	    				}
	    			});
	    		}else if($(this).children().attr("src")=='image/heart_.png'){
	    			var title = $(this).prev().text().split(",")[0];
	    			var userid = $(this).prev().text().split(",")[1];
	    			var parameters = {"userid" : userid, "title" : title};
	    		
	    			$.ajax({
	    				url:'/Megabox/AddLikeDAO',
	    				type : 'POST',
	    				dataType:'text',//받아올 데이터 타입
	    				data:{"userid" : userid, "title" : title},
	    				context : this,
	    				success:function(data){
	    					var num = data.split('x')[1];
	    					$(this).children().attr("src",'image/heart_1.png');
	    					//총 하트 수도 변경해 줘야함.
	    					$(this).children().next().text(num);
	    					
	    				},
	    				error:function(request,status,error){
	    					console.log("유감");
	    					alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	    				}
	    			});
	    		}
	    	}else{
	    		return false;
	    	}
	    });
		
	});
	 