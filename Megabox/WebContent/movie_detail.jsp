<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
	request.setCharacterEncoding("UTF-8");
%>

<!-- 
	- 리뷰 좋아요,
	- 최신순, 곰감순 나열,
	- 예고편 수, 썸네일 수 
	주석처리
 -->

<c:set var="movie_title" value="${param.movietitle }" />
<!-- movie info database -->
<sql:setDataSource var="db" driver="org.mariadb.jdbc.Driver"
	url="jdbc:mariadb://127.0.0.1:3306/project" user="root" password="1234" />
<sql:query dataSource="${db}" var="rs">  
	SELECT * FROM mega_movie WHERE movie_title =?;  
	<sql:param value="${movie_title}" />
</sql:query>
<c:forEach var="movie" items="${rs.rows}" varStatus="status">
	<c:set var="movie_summary" value="${movie.movie_summary }" />
</c:forEach>
<!DOCTYPE html>


<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>주요정보 < 영화 | 라이프시터, 메가박스</title>
<link href="css/movie_detail.css" rel="stylesheet" type="text/css">

<link rel="stylesheet" href="css/main_js.css">
<link rel="stylesheet" href="css/other_style.css">
<link rel="stylesheet" href="css/footer.css">
<link href="css/review.css" rel="stylesheet" type="text/css">
<script src="js/jquery-3.4.1.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="js/movie_detail.js"></script>
<script src="js/mainpage.js"></script>
<script src="js/include.js"></script>
<style>
</style>
</head>
<body>
	<header include-html="header.jsp"></header>
	<div include-html="header_util.jsp"></div>
	<!-- 영화 상세 정보  -->
	<jsp:include page="movie-detail.jsp" flush="false">
		<jsp:param value="${movie_title }" name="movietitle" />
	</jsp:include>
	<!-- 탭 메뉴 -->
	<div title="탭 매뉴">
		<div class="wrap-hidden">
			<div id="nav">
				<p>홈>영화>전체영화>박스오피스</p>
			</div>
			<div id="movie-detail">
				<p>${movie_title }</p>
				<div class="btn">
				<!-- 	<button type="button" id="likebtn2" class="likebtn2">
						<img id="heart" src="image/heart_.png"> <span
							title="보고싶어한 명수">0</span>
					</button> -->
					<!-- <button type="button" class="registBtn" value="예매">예매</button> -->
				</div>
			</div>
		</div>
		<div class="wrap-tab-list-on">
			<ul>
				<li style="border-bottom: 2px solid #6643B3;"><a
					href="movie_detail.jsp?movietitle=${movie_title }"
					style="color: #6643B3;">주요정보</a></li>
				<li><a href="movie_review.jsp?movietitle=${movie_title }">한줄평</a></li>
				<li><a href="movie_preview.jsp?movietitle=${movie_title }">예고편/스틸컷</a></li>
			</ul>
		</div>
		<div class="tab-wrap">

			<div class="tab-list">
				<div class="li"
					style="border: 2px solid #6643B3; border-bottom: 1px solid white;">
					<a href="movie_detail.jsp?movietitle=${movie_title }">주요정보</a>
				</div>
				<div class="li">
					<a href="movie_review.jsp?movietitle=${movie_title }">한줄평</a>
				</div>
				<div class="li">
					<a href="movie_preview.jsp?movietitle=${movie_title }">예고편/스틸컷</a>
				</div>
			</div>
		</div>
	</div>
	<!-- 영화 줄거리 -->
	<section class="content">
		<div class="summary" style="width: 1100px">
			<div class="summary-wrapper">
				<div id="txt">
					<p>${movie_summary }</p>
				</div>
				<div id="etc" class="etc"></div>
			</div>
		</div>
	</section>
	<!-- 영화 리뷰 -->
	<jsp:include page="review.jsp" flush="false">
		<jsp:param value="${movie_title }" name="movietitle" />
	</jsp:include>
	<!-- footer -->
	<footer include-html="footer.jsp"></footer>
	<script>
		includeHTML();
	</script>
</body>
</html>
