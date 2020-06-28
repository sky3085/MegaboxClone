<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>라이프시어터, 메가박스</title>
<link rel="stylesheet" href="css/idfind_style.css">
<script src="js/jquery-3.4.1.min.js"></script>
<!-- <script src="js/idfind.js"></script> -->
</head>
<body>
<script>
$(function(){
    $("#ibxSchIdMblpTelno").on("keyup", function(){
        if($("#ibxSchIdMbNm").val().length >= 1 && ($("#ibxSchIdBirthDe").val().length >= 8 && ($("#ibxSchIdMblpTelno").val().length >= 9))){
            $("#btnSchId").css("background-color", "#503396").css("color", "#fff");
        }
    });
    
    function IsIdExist(Name, Birth, Telno){
    	$.ajax({
			url:'/Megabox/IdFindDAO',
			type:'POST',
			dataType:'text',
			data:{
				"mem_name" : Name,
				"mem_birth" : Birth,
				"mem_hp"	   : Telno
			}, 
		 	success: function(obj) {
		 		var data = JSON.parse(obj);
		 		if(data.SearchStatus==true){
		 			alert("회원님의 id는 아이디는 ["+data.mem_id+"]입니다.");
		 		}else{
		 			alert("회원 정보가 없습니다.");
		 		}
	        },
            error:function(request,status,error,data){
                console.log("유감");
                console.log(data);
                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
            }
		});
    }
    
    $("#btnSchId").click(function(){
    	var Name=$("#ibxSchIdMbNm").val();
    	var Birth=$("#ibxSchIdBirthDe").val();
    	var Telno=$("#ibxSchIdMblpTelno").val();
    	IsIdExist(Name,Birth,Telno);
    });
})

</script>
	<div class="container">
		<div class="content">
			<div class="ci">
				<a href="mainpage.jsp" title="메인 페이지로 이동"></a>
			</div>
			<div class="col">
				<p class="tit-member">아이디/비밀번호 찾기</p>
				<div class="tab-list">
					<ul>
						<li class="tab-id"><a href="idfind.jsp" title="아이디 찾기">아이디
								찾기</a></li>
						<li class="tab-pw"><a href="pwfind.jsp" title="비밀번호 찾기">비밀번호
								찾기</a></li>
					</ul>
				</div>
				<div class="tit-mt40">
					<p>간편찾기</p>
				</div>
				<div class="table">
					<table class="board-form">
						<colgroup>
							<col style="width: 130px;">
							<col>
						</colgroup>
						<tbody>
								<tr>
									<th class="row"><label for="ibxSchIdMbNm">이름</label></th>
									<td><input id="ibxSchIdMbNm" name="username" maxlength="20"
										type="text" placeholder="이름" class="input-text w230px">
									<!--이름--></td>
								</tr>
								<tr>
									<th class="row"><label for="ibxSchIdBirthDe">생년월일</label></th>
									<td><input id="ibxSchIdBirthDe" name="userbirth"
										maxlength="8" type="text" placeholder="생년월일 앞8자리"
										class="input-text w230px">
									<!--생년월일 8자리-->
										<div id="schIdBirthDe-error-text" class="alert"></div></td>
								</tr>
								<tr>
									<th class="row"><label for="ibxSchIdMblpTelno">휴대폰
											번호</label></th>
									<td><input id="ibxSchIdMblpTelno" name="userhp"
										maxlength="15" type="text" placeholder="'-' 없이 입력"
										class="input-text w230px">
									<!--'-' 없이 입력-->
										<div id="schIdMblpNo-error-text" class="alert"></div></td>
								</tr>
						</tbody>
					</table>
				</div>
				<div class="btn-find">
					<p class="btn">
						<button id="btnSchId" type="button">아이디 찾기</button>
					</p>
				</div>
			</div>
		</div>


	</div>
</body>
</html>