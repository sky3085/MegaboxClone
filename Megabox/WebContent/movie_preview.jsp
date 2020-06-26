<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ page import="java.sql.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
	request.setCharacterEncoding("UTF-8");
%>

<c:set var="movie_title" value="${param.movietitle }" />
<sql:setDataSource var="db" driver="org.mariadb.jdbc.Driver"
	url="jdbc:mariadb://127.0.0.1:3306/project" user="root" password="1234" />
<sql:query dataSource="${db}" var="rs">  
	SELECT * FROM mega_movie WHERE movie_title =?;  
	<sql:param value="${movie_title}" />
</sql:query>

<c:forEach var="movie" items="${rs.rows}" varStatus="status">
	<c:set var="movie_age" value="${movie.movie_age}" />
	<c:set var="movie_num" value="${movie.movie_num}" />
	<c:set var="movie_type" value="${movie.movie_type} " />
	<c:set var="movie_genre" value="${movie.movie_genre}" />
	<c:set var="movie_director" value="${movie.movie_director}" />
	<c:set var="movie_actors" value="${movie.movie_actors} " />
	<c:set var="movie_img" value="${movie.movie_img}" />
	<c:set var="movie_rank" value="${movie.movie_rank}" />
	<c:set var="movie_score" value="${movie.movie_score} " />
	<c:set var="movie_reser" value="${movie.movie_reser}" />
	<c:set var="movie_poster" value="${fn:split(movie_img,',')[0]}" />
	<c:set var="movie_summary" value="${movie.movie_summary }" />
	<c:set var="movie_release" value="${movie.movie-release }" />
</c:forEach>

<!--  211~ 수정필요  -->

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>Document</title>
<link rel="stylesheet" href="css/movie_detail.css">
<link href="css/other_style.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="css/movie_preview.css">
<link rel="stylesheet" href="css/main_js.css">
<link rel="stylesheet" href="css/footer.css">
<script src="js/mainpage.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="js/movie_detail.js"></script>
<script src="js/include.js"></script>

</head>

<body>
	<!-- 헤더 -->
	<header include-html="header.jsp"></header>
	<div include-html="header_util.jsp"></div>
	<!-- 영화 상세 정보  -->
	<jsp:include page="movie-detail.jsp" flush="false">
		<jsp:param value="${movie_title }" name="movietitle" />
	</jsp:include>
	<!-- 탭매뉴 -->
	<div title="탭 매뉴">
		<div class="wrap-hidden">
			<div id="nav">
				<p>홈>영화>전체영화>박스오피스</p>
			</div>
			<div id="movie-detail">
				<p>${movie_title }</p>
				<div class="btn">

					<!-- <button type="button" value="heart" id="likebtn2">
						<img id="heart" src="image/heart_.png"> <span
							title="보고싶어한 명수">0</span>
					</button>
					<button type="button" class="registBtn" value="예매">예매</button> -->
				</div>
			</div>
		</div>
		<div class="wrap-tab-list-on">
			<ul>
				<li><a href="movie_detail.jsp?movietitle=${movie_title }">주요정보</a></li>
				<li><a href="movie_review.jsp?movietitle=${movie_title }">한줄평</a></li>
				<li style="border-bottom: 2px solid #6643B3;"><a
					href="movie_preview.jsp?movietitle=${movie_title }"
					style="color: #6643B3;">예고편/스틸컷</a></li>
			</ul>
		</div>
		<div class="tab-wrap">
			<div class="tab-list">
				<div class="li">
					<a href="movie_detail.jsp?movietitle=${movie_title }">주요정보</a>
				</div>
				<div class="li">
					<a href="movie_review.jsp?movietitle=${movie_title }">한줄평</a>
				</div>
				<div class="li"
					style="border: 2px solid #6643B3; border-bottom: 1px solid white;">
					<a href="movie_preview.jsp?movietitle=${movie_title }">예고편/스틸컷</a>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 썸네일 -->
	<section class="content">
		<div class="movie-list-util mt40">
			<!-- 	<div class="">예고편() | 스틸컷()</div> -->
		</div>
		<div class="stillcut-slide" style="display: inline-block;">
			<div class="subject-wrap"
				style="border-bottom: 1px solid; padding: 10px;">
				<p style="font-size: 22px;">메인예고편</p>
			</div>
			<div class="top-container">
				<!-- 	<div class="left arrow">
					<p>이전영상</p>
				</div> -->
				<video id="videoTag" src="${movie_video }" controls></video>
				<!-- <div class="right arrow">
					<p>다음영상</p>
				</div> -->
			</div>
			<!-- <div class="thums-wrap">
				<img class="thumbs-img-button"> <img class="thumbs-img-button">
				<img class="thumbs-img-button"> <img class="thumbs-img-button">
			</div> -->
		</div>

		<div class="stair-slide">
			<h2 class="tit small">
				<c:set var="imgArray" value="${fn:split(movie_img,',') }" />

				"
				<c:out value="${movie_title }" />
				"에 대한 ${fn:length(imgArray)} 개의 스틸컷이 있어요!"
			</h2>

			<div class="stair-slide-list"></div>
			<c:forEach var="img" items="${imgArray}">
				<img class="thum big" src="${img }" style="object-fit: cover;" />
			</c:forEach>
		</div>

	</section>
	<footer include-html="footer.jsp"></footer>
	<script>
		includeHTML();
	</script>

</body>

</html>