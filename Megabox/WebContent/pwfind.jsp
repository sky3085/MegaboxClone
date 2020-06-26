<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>라이프시어터, 메가박스</title>
<link rel="stylesheet" href="css/pwfind_style.css">
<script src="js/jquery-3.4.1.min.js"></script>
<!-- <script src="js/pwfind.js"></script> -->

<script>
	$(function() {
		$("#ibxSchIdMblpTelno").on(
				"keyup",
				function() {
					if ($("#ibxSchIdMbNm").val().length >= 1
							&& ($("#ibxSchIdBirthDe").val().length >= 8 && ($(
									"#ibxSchIdMblpTelno").val().length >= 9))) {
						$("#btnSchId").css("background-color", "#503396").css(
								"color", "#fff");
					}
				});

		function FindPw(Name, Id) {
			$.ajax({
				url : 'PwFindDAO',
				type : 'POST',
				dataType : 'text',
				data : {
					"mem_name" : Name,
					"mem_id" : Id
				},
				success : function(obj) {
					var data = JSON.parse(obj);
					if (data.SearchStatus == true) {
						alert("회원님의 비밀번호는 [" + data.mem_pw + "]입니다.");
					} else {
						alert("회원 정보가 없습니다.");
					}
				},
				error : function(request, status, error, data) {
					console.log("유감");
					console.log(data);
					alert("code:" + request.status + "\n" + "message:"
							+ request.responseText + "\n" + "error:" + error);
				}
			});
		}

		$("#btnSchPw").click(function() {
			var Name = $("#ibxSchIdMbNm").val();
			var Id = $("#ibxSchPwMbID").val();
			FindPw(Name,Id);
		});
	})
</script>
</head>
<body>
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
								<th scope="row"><label for="ibxSchPwMbID">아이디</label></th>
								<td><input id="ibxSchPwMbID" name="userid" maxlength="20"
									type="text" placeholder="아이디" class="input-text w230px">
									<div id="ibxSchPwMbID-error-text" class="alert"></div></td>
							</tr>
							<tr>
								<th scope="row"><label for="ibxSchIdMbNm">이름</label></th>
								<td><input id="ibxSchIdMbNm" name="username" maxlength="20"
									type="text" placeholder="이름" class="input-text w230px">
								<!--이름--></td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="btn-find">
					<p class="btn">
						<button id="btnSchPw" type="button">비밀번호 찾기</button>
					</p>
				</div>
			</div>
		</div>
	</div>
</body>
</html>