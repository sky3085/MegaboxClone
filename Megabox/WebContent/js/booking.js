$(function() {
	//영화 목록 관람가 이미지
	for (var i = 0; i<$("span.movie-grade").length; i++) {
		if ($("span.movie-grade").eq(i).text() == '전체') {
			$("span.movie-grade").eq(i).css("background-image",
					"url(image/ageAll.png)")
		} else if ($("span.movie-grade").eq(i).text() == '12') {
			$("span.movie-grade").eq(i).css("background-image",
					"url(image/txt-age-small-12.png)")
		} else if ($("span.movie-grade").eq(i).text() == '15') {
			$("span.movie-grade").eq(i).css("background-image",
					"url(image/txt-age-small-15.png)")
		} else if ($("span.movie-grade").eq(i).text() == '청소') {
			$("span.movie-grade").eq(i).css("background-image",
					"url(image/txt-age-small-19.png)")
		}
	}
	
	
	
});
     	
        $(function(){
            // 시간 한시간씩 왼쪽으로
            $("button.btn-prev-time").click(function() {
                var check = $("div.view").css("left");
                
                if(check == '0px'){
                    return false;
                }else{
                    check = check.split('px');
                    
                    check[0] = parseInt(check[0]) + 35;
                    
                    $("div.view").css({"left" : check[0]});
                }
            });

            //시간 한시간씩 오른쪽으로
            $("button.btn-next-time").click(function() {
                nextTime();
            });
            
            function nextTime(){
            	var check1 = $("div.view").css("left");
                
                if(check1 == '-665px'){
                    return false;
                }else{
                    check1 = check1.split('px');
                    
                    check1[0] = parseInt(check1[0]) - 35;
                    
                    $("div.view").css({"left" : check1[0]});
                }
            };

           
            //맨 윗줄에 날짜 리스트 클릭시 배경과 밑줄 변경
            $("button.date-area").click(function(){
                $("div.wrap-date > button").removeClass("on");
                $(this).addClass("on");
                listChange();
            });
            
            //시간 클릭시 css 변경
            $("button.hour").click(function(){
                $("button.hour").removeClass("time-on");
                $(this).addClass("time-on");
                listChange();
            });
            
            //영화 리스트 클릭 함수
            $("button.btn-booking").click(function(){
                var check = $(this).hasClass("check1");
                var check2 = $("button.check1").length;

                if(check == false){
                    if(check2 < 3){
                    $(this).addClass("check1");
                    $("div#choiceMoiveNone").css({"display":"none"});
                    $("div#choiceMovieList").css({"display":"block"});
                    
                    imageUp($(this).children().next().next().text());
                    if($("button.check2").length != 0){
                    	listChange();
                    }
                    }
                }else if(check == true){
                    $(this).removeClass("check1");
                    var check2 = $("button.check1").length;
                    console.log(check2);
                    if(check2 == 2){
                        $("#bg-m3").empty();
                        $("#bg-m2").empty();
                        $("#bg-m1").empty();
                        $("div#bg-m1").append("<div></div>").children().addClass("img").append("<img>").parent().append("<button></button>").children().next().addClass("del-m");
                        $("div#bg-m2").append("<div></div>").children().addClass("img").append("<img>").parent().append("<button></button>").children().next().addClass("del-m");
                        for(var i=0; i<$("span.movie-grade").length; i++){
                        	if($("span.movie-grade").eq(i).next().next().text() == $("button.check1 > span").eq(1).text()){
                        		
                        		$("#bg-m1").children().children().attr("width", "63");
                        		$("#bg-m1").children().children().attr("height", "90");
                        		$("#bg-m1").children().children().attr("src", "poster/thum"+(i+1)+"_0.png");
                        	}else if($("span.movie-grade").eq(i).next().next().text() == $("button.check1 > span").eq(3).text()){
                        		
                        		$("#bg-m2").children().children().attr("width", "63");
                        		$("#bg-m2").children().children().attr("height", "90");
                        		$("#bg-m2").children().children().attr("src", "poster/thum"+(i+1)+"_0.png");
                        	}
                        }
                        listChange();
                    }else if(check2 == 1){
                        $("#bg-m2").empty();
                        $("#bg-m1").empty();
                        $("div#bg-m1").append("<div></div>").children().addClass("img").append("<img>").parent().append("<button></button>").children().next().addClass("del-m");
                        
                        for(var i=0; i<$("span.movie-grade").length; i++){
                        	if($("span.movie-grade").eq(i).next().next().text() == $("button.check1 > span").eq(1).text()){
                        		
                        		$("#bg-m1").children().children().attr("width", "63");
                        		$("#bg-m1").children().children().attr("height", "90");
                        		$("#bg-m1").children().children().attr("src", "poster/thum"+(i+1)+"_0.png");
                        	}
                        }
                        listChange();
                    }else if(check2 == 0){
                        $("#bg-m1").empty();
                        $("div#choiceMoiveNone").css({"display" : "block"});
                        $("div#choiceMovieList").css({"display" : "none"});
                        listChange();
                    }else{
                        return false;
                    }
                }else{
                    return false;
                };
            });

            //선택한 영화 아래에 이미지 추가하기 e는 클릭한 영화이름
            function imageUp(e){
                var test = $("div.bg-movie").children();
                if(test.length == 0){
                    $("div#bg-m1").append("<div></div>").children().addClass("img").append("<img>").parent().append("<button></button>").children().next().addClass("del-m");
                    
                    for(var i=0; i<$("span.movie-grade").length; i++){
                    	if($("span.movie-grade").eq(i).next().next().text() == e){
                    		$("#bg-m1").children().children().attr("width", "63");
                    		$("#bg-m1").children().children().attr("height", "90");
                    		$("#bg-m1").children().children().attr("src", "poster/thum"+(i+1)+"_0.png");
                    	}
                    }
                }else if(test.length == 2){
                    $("div#bg-m2").append("<div></div>").children().addClass("img").append("<img>").parent().append("<button></button>").children().next().addClass("del-m");
                    
                    for(var i=0; i<$("span.movie-grade").length; i++){
                    	if($("span.movie-grade").eq(i).next().next().text() == e){
                    		
                    		$("#bg-m2").children().children().attr("width", "63");
                    		$("#bg-m2").children().children().attr("height", "90");
                    		$("#bg-m2").children().children().attr("src", "poster/thum"+(i+1)+"_0.png");
                    	}
                    }
                }else if(test.length == 4){
                    $("div#bg-m3").append("<div></div>").children().addClass("img").append("<img>").parent().append("<button></button>").children().next().addClass("del-m");
                    //console.log(e);
                    for(var i=0; i<$("span.movie-grade").length; i++){
                    	if($("span.movie-grade").eq(i).next().next().text() == e){
                    		//console.log($("button.check1 > span").text());
                    		$("#bg-m3").children().children().attr("width", "63");
                    		$("#bg-m3").children().children().attr("height", "90");
                    		$("#bg-m3").children().children().attr("src", "poster/thum"+(i+1)+"_0.png");
                    	}
                    }
                }else{
                    return false;
                }
                
            };

            

            //극장 리스트 클릭 함수
            //$(document).on("click", "button.detail-list", function(){
            $("button.detail-list").click(function(){
                var check = $(this).hasClass("check2");
                var check2 = $("button.check2").length;
                var name = $(this).contents().clone();

                if(check == false){
                    if(check2 < 3){
                    $(this).addClass("check2");
                    var a = $(this).contents().clone();
                    $("div#choiceBrchNone").css({"display":"none"});
                    $("div#choiceBrchList").css({"display":"block"});
                    $("div.no-result").css({"display":"none"});
                    $("div.result").css({"display":"block"});
                    
                    listChange();
                    listUp(a[0]);
                    
                    }
                }else if(check == true){
                    $(this).removeClass("check2");
                    if(check2 == 3){
                        $("#bg3").empty();
                        var test1 = $("button.check2").contents().clone();
                        
                        $("div#bg1").children().children("p").empty().append(test1[0]);
                        $("div#bg2").children().children("p").empty().append(test1[1]);
                        
                        listChange();
                    }else if(check2 == 2){
                        $("#bg2").empty();
                        var test2 = $("button.check2").contents().clone();
                        $("div#bg1").children().children("p").empty().append(test2[0]);
                        
                        listChange();
                    }else if(check2 == 1){
                        $("#bg1").empty();
                        $("div.result").next().css({"display" : "none"});
                        $("div.no-result").css({"display" : "block"});
                        $("div#choiceBrchNone").css({"display":"block"});
                        $("div#choiceBrchList").css({"display":"none"});

                        $("button.hour").removeClass("time-on");
                        $("div.view").css({"left" : "0px"});
                    }else{
                        return false;
                    }
                }else{
                    return false;
                };
            });

            //극장 리스트 선택시 추가.
            function listUp(e){
                var test = $("div.bg").children();
                if(test.length == 0){
                    $("div#bg1").append("<div></div>").children().addClass("wrap-theater").append("<p></p>").children().addClass("txt").parent().append("<button></button>").children().next().addClass("del");
                    $("div#bg1").children().children("p").append(e);
                    $("div#bg1").addClass("ck");
                    
                    
                }else if(test.length == 1){
                    $("div#bg2").append("<div></div>").children().addClass("wrap-theater").append("<p></p>").children().addClass("txt").parent().append("<button></button>").children().next().addClass("del");
                    $("div#bg2").children().children("p").append(e);
                    $("div#bg2").addClass("ck");
                }else if(test.length == 2){
                    $("div#bg3").append("<div></div>").children().addClass("wrap-theater").append("<p></p>").children().addClass("txt").parent().append("<button></button>").children().next().addClass("del");
                    $("div#bg3").children().children("p").append(e);
                    $("div#bg3").addClass("ck");
                }else{
                    return false;
                }
                
            };
            /*function timeChange(){
            	var now = $("span.time").first().children().text();
            	time = now.split(":")[0];
            	
            	if($("button.check2").length == 0){
            	if(time > 4){
            		for(var a=4; a<time; a++){
            			nextTime();
            		}
            	}
            	for(var i=0; i<$("button.hour").length; i++){
                	if($("button.hour").eq(i).text() == time){
                		$("button.hour").eq(i).addClass("time-on");
                	}
                }
            	}
            };*/

            //극장(지역) 선택시 옆에 극장명 보여주는 함수
            $("button.btn-theater").click(function(){
                $("div.theater-list").css({"display" : "none"});
                $(this).next().css({"display" : "block"});
                $("button.btn-theater").css({"background-color" : "#fff"});
                $(this).css({"background-color" : "#ebebeb"});
                
            });
            
            function listChange(){
            	
            	var date = $("button.on").text().split('\n')[1].split('월')[0].trim() + '.' + $("button.on").text().split('\n')[2].trim();
            	date = date.split('일')[0];
            	//console.log(date);
            	//var movie = $("button.check1").text().split('\n')[3].trim();
            	//var movie = new Array();
            	//var location = new Array();
            	//var location = $("button.check2").text();
            	var time = $("button.time-on").text();
            	//console.log(time);
            	var listInfo = {"date":date, "time":time}
            	for(var i=0; i<$("button.check1").length; i++){
            		var sub = $("button.check1").eq(i).text().split('\n')[5].trim();
            		
            		var keyname = 'title'+i;
            		listInfo[keyname]=sub;
            	}
            	for(var i=0; i<$("button.check2").length; i++){
            		
            		var sub = $("button.check2").eq(i).text();
            		var keyname = 'location'+i;
            		listInfo[keyname]=sub;
            	}
            	
            	
            	$.ajax({
    				url:'/Megabox/MovieListDAO',
    				type : 'POST',
    				dataType:'text',//받아올 데이터 타입
    				data:listInfo,
    				contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
    				success:function(data){
    					data = decodeURIComponent(data);
    					data = data.substring(19).replace(/\+/gi," ");
    					$("div.mCSB_container > ul").html(data);
    					var ck = $("button.time-on").length;
    					//console.log(data);
    					if(ck ==0){
    		        		var what = $("span").hasClass("time");
    		                var now = $("span.time").first().children().text();
    		                
    		            	time = now.split(":")[0];
    		            	if(time > 4){
    		            		for(var a=4; a<time; a++){
    		            			nextTime();
    		            		}
    		            	}
    		            	for(var i=0; i<$("button.hour").length; i++){
    		                	if($("button.hour").eq(i).text() == time){
    		                		$("button.hour").eq(i).addClass("time-on");
    		                	}
    		                }
    		            	
    					}
    				},
    				error:function(request,status,error){
    					alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
    				}
    			});
            	
            };
           
            
            $(document).on("click","button.btn-time", function(){
            	var ck = $(this).children().first().text();
            	var userID = $("#logout").length;
        		console.log(userID);
            	if(userID > 0){
            		$(location).attr('href',"quick-reserve.jsp?ck="+ck);
            	}else{
            		alert("로그인 후 이용하실 수 있습니다.");
            	}
        		
        	});
            
            $(document).on("click", "button.del", function(){
                var copy = $(this).prev().text();
                console.log(copy)
                $(this).parent().parent().empty();
                for(var i=0; i<$("button.check2").length; i++){
                	if($("button.check2").eq(i).text() == copy){
                		$("button.check2").eq(i).removeClass("check2");
                	}
                }
                
                var check2 = $("button.check2").length;
                
                if(check2 == 2){
                	$("#bg1").empty();
                	$("#bg2").empty();
                    $("#bg3").empty();
                    var test1 = $("button.check2").eq(0).text();
                    var test2 = $("button.check2").eq(1).text();
                    $("div#bg1").append("<div></div>").children().addClass("wrap-theater").append("<p></p>").children().addClass("txt").parent().append("<button></button>").children().next().addClass("del");
                    $("div#bg2").append("<div></div>").children().addClass("wrap-theater").append("<p></p>").children().addClass("txt").parent().append("<button></button>").children().next().addClass("del");
                    
                    $("div#bg1").children().children("p").empty().append(test1);
                    $("div#bg2").children().children("p").empty().append(test2);
                    
                }else if(check2 == 1){
                	$("#bg1").empty();
                	$("#bg2").empty();
                    $("#bg3").empty();
                    var test = $("button.check2").eq(0).text();
                    $("div#bg1").append("<div></div>").children().addClass("wrap-theater").append("<p></p>").children().addClass("txt").parent().append("<button></button>").children().next().addClass("del");
                    $("div#bg1").children().children("p").empty().append(test);
                    
                }else if($("button.check2").length==0){
                	$("div.result").next().css({"display" : "none"});
                    $("div.no-result").css({"display" : "block"});
                    $("div#choiceBrchNone").css({"display":"block"});
                    $("div#choiceBrchList").css({"display":"none"});

                    $("button.hour").removeClass("time-on");
                    $("div.view").css({"left" : "0px"});
                }
                
                listChange();
            });
            
            $(document).on("click", "button.del-m", function(){
                var copy = $(this).prev().children().attr("src");
                copy = copy.substring(11, 12);
                $("button.btn-booking").eq(Number(copy)-1).removeClass("check1");
                $(this).parent().empty();
                
                var check2 = $("button.check1").length;
                if(check2 == 2){
                    $("#bg-m3").empty();
                    $("#bg-m2").empty();
                    $("#bg-m1").empty();
                    $("div#bg-m1").append("<div></div>").children().addClass("img").append("<img>").parent().append("<button></button>").children().next().addClass("del-m");
                    $("div#bg-m2").append("<div></div>").children().addClass("img").append("<img>").parent().append("<button></button>").children().next().addClass("del-m");
                    for(var i=0; i<$("span.movie-grade").length; i++){
                    	if($("span.movie-grade").eq(i).next().next().text() == $("button.check1 > span").eq(1).text()){
                    		
                    		$("#bg-m1").children().children().attr("width", "63");
                    		$("#bg-m1").children().children().attr("height", "90");
                    		$("#bg-m1").children().children().attr("src", "poster/thum"+(i+1)+"_0.png");
                    	}else if($("span.movie-grade").eq(i).next().next().text() == $("button.check1 > span").eq(3).text()){
                    		
                    		$("#bg-m2").children().children().attr("width", "63");
                    		$("#bg-m2").children().children().attr("height", "90");
                    		$("#bg-m2").children().children().attr("src", "poster/thum"+(i+1)+"_0.png");
                    	}
                    }
                }else if(check2 == 1){
                    $("#bg-m2").empty();
                    $("#bg-m1").empty();
                    $("div#bg-m1").append("<div></div>").children().addClass("img").append("<img>").parent().append("<button></button>").children().next().addClass("del-m");
                    
                    for(var i=0; i<$("span.movie-grade").length; i++){
                    	if($("span.movie-grade").eq(i).next().next().text() == $("button.check1 > span").eq(1).text()){
                    		//console.log($("button.check1 > span").text());
                    		$("#bg-m1").children().children().attr("width", "63");
                    		$("#bg-m1").children().children().attr("height", "90");
                    		$("#bg-m1").children().children().attr("src", "poster/thum"+(i+1)+"_0.png");
                    	}
                    }
                }else if($("button.check1").length==0){
                	 $("div#choiceMoiveNone").css({"display" : "block"});
                     $("div#choiceMovieList").css({"display" : "none"});
                }
                listChange();
            });
            
        });
        
        
