<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>개인정보 수정 &lt; 나의메가박스 | 라이프씨어터, 메가박스</title>
<link rel="stylesheet" href="css/userconfirm_style.css">
<link rel="stylesheet" href="css/main_js.css">
<link rel="stylesheet" href="css/other_style.css">
<link rel="stylesheet" href="css/footer.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="js/include.js"></script>
<script src="js/mainpage.js"></script>
</head>
<body>
    <header include-html="header.jsp"></header>
	<div include-html="header_util.jsp"></div>

        <div class="container-main">
        <section id="body">
            <div class="container-userconfirm">
                <div class="page-util">
                	<div class="inner-wrap">
	                    <div class="location">
	                        <span><img src="image/bg-location-home.png" alt="home"> </span>
	                        <span><img src="image/bg-location-arr.png" alt="arr"></span>
	                        <a href="mypagemain.jsp" title="나의 메가박스 페이지로 이동">나의 메가박스</a>
	                        <span><img src="image/bg-location-arr.png" alt="arr"></span>
	                        <a href="userconfirm.jsp" title="회원정보 페이지로 이동">회원정보</a>
	                    </div>
	            	</div>
                </div>
				<div class="container-row">
	                <div class="nav">
	                    <nav id="lnb">
	                        <ul>
	                            <li class="nav-title"><a href="mypagemain.jsp" title="나의 메가박스 페이지로 이동">나의 메가박스</a></li>
	                            <li class="nav-sub"><a href="bookinglist.jsp" title="예매내역 페이지로 이동">예매내역</a></li>
	                            <li class="nav-sub"><a href="userconfirm.jsp" title="회원정보 페이지로 이동">회원정보</a></li>
	                            <li class="nav-depth"><a href="userconfirm.jsp" title="개인정보수정 페이지로 이동">개인정보 수정</a></li>
	                        </ul>
	                    </nav>
	                </div>
	
	                <div class="userconfirm">
	                    <h2 class="title">회원정보</h2>
	                    <hr>
	                    <form method="post" action="userconfirm_ok">
	                    <div class="intro-pwd">
	                        <strong>회원님의 개인정보 보호를 위해 비밀번호를 입력하셔야 합니다.</strong>
	                        <p>메가박스 로그인 시 사용하시는 비밀번호를 입력해 주세요.</p>
	                        <input type="password" title="비밀번호 입력" class="input-text large w380px" id="pwd" name="pwd" maxlength="20" autocomplete="new-password">
	                    </div>
	                    <hr>
	                    <div class="btn-group">
	                        <input type="button" onclick="location.href='mypagemain.jsp'" class="button large" id="cancelBtn" value="취소">
	                        <input type="submit" class="button large purple" id="ckBtn" value="확인">
	                    </div>
	                    </form>
	                </div>
	        	</div>
            </div>
        </section>

        </div>
        <!-- //footer --> 
    <footer include-html="footer.jsp"></footer>
	<script>
		includeHTML();
	</script>
        <!-- //footer -->
    
</body>
</html>