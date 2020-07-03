<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="megaboxClass.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<sql:setDataSource var="db" driver="org.mariadb.jdbc.Driver"
	url="jdbc:mariadb://127.0.0.1:3306/project" user="root" password="1234" />

<sql:query dataSource="${db}" var="rs">  
	SELECT * from mega_movie;  
</sql:query>




<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>Document</title>
<link rel="stylesheet" href="css/boxoffice.css">
<link rel="stylesheet" href="css/other_style.css">
<link rel="stylesheet" href="css/main_js.css">
<link rel="stylesheet" href="css/footer.css">
<script src="js/include.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="js/boxoffice.js"></script>
<script src="js/mainpage.js"></script>
</head>
<body>

	<header include-html="header.jsp"></header>
	<div include-html="header_util.jsp"></div>

	<!-- 메뉴버튼 -->

	<div class="menuBtn_sitemap" style="display: none;">
		<div class="container">
			<h2
				style="display: block; float: left; padding-top: 30px; padding-left: 50px; padding-right: 1000px; font-size: 25px; font-weight: 800; color: #ffffff">SITEMAP</h2>

			<div class="sitemapMenuList">
				<div class="list position-1">
					<p class="tit-depth">영화</p>
					<ul class="list-depth">
						<li><a href="boxoffice.jsp" title="전체영화">전체영화</a></li>
					</ul>
				</div>
				<div class="list position-2">
					<p class="tit-depth">예매</p>
					<ul class="list-depth">
						<li><a href="#" title="빠른예매">빠른예매</a></li>
					</ul>
				</div>
				<div class="list position-3">
					<p class="tit-depth">나의 메가박스</p>
					<ul class="list-depth mymage">
						<li><a href="#" title="나의 메가박스 홈">나의 메가박스 홈</a></li>
						<li><a href="#" title="예매내역">예매/구매내역</a></li>
						<li><a href="#" title="회원정보">회원정보</a></li>
					</ul>
				</div>
			</div>
		</div>
	</div>


	<!-- 검색버튼 -->

	<div class="searchBtn_sitemap" style="display: none;">
		<div class="container"
			style="width: 1000px; margin-left: 200px; align: center;">
			<div class="searchTitle"
				style="width: 1000px; display: block; float: left;">
				<h2 class="tit">예매율 순</h2>
				<h2 class="tit">누적관객순</h2>
				<h2 class="tit">메가스코어순</h2>

			</div>
			<div class="sitemapsearchList">
				<div class="list position-1">
					<c:forEach var="movie" items="${rs.rows}" varStatus="status"
						begin="0" end="0">
						<c:set var="images" value="${movie.movie_img}" />
						<c:set var="poster" value="${fn:split(images,',')[0]} " />
						<img src="${fn:split(images,',')[0]}" alt="검색창포스터"
							style="width: 150px; height: 210px; display: block; float: left;">
					</c:forEach>
				</div>
				<div class="list position-2">
					<c:forEach var="movie" items="${rs.rows}" begin="0" end="4">
						<ul class="list-depth mymage"
							style="display: inline-block; width: 200px">
							<c:set var="title" value="${movie.movie_title}" />
							<li><em> ${movie.movie_rank } </em> <a
								href="movie_detail.jsp?movietitle=${title }"
								style="color: #ffffff; padding-left: 10px;">
									${movie.movie_title} </a></li>
						</ul>
						</br>
					</c:forEach>
				</div>
				<div class="searchMovie"
					style="display: block; width: 360px; line-height: 50px; border-bottom: solid 1px #ffffff; margin-left: 150px; margin-top: 100px; padding-left: 0px; padding-top: 0px;">
					<input type="text" placeholder="영화를 검색하세요" title="영화 검색"
						class="input-text"
						style="display: block; float: left; width: 260px; height: 60px; font-size: 17px; color: #ffffff; background-color: transparent; border: 0; padding: 0px 20px">
					<input type="image" src="image/ico-search-white.png"
						class="input-img"
						style="display: block; float: right; line-height: 60px; margin: 0 auto; background-color: transparent; border: 0; padding: 20px;">
				</div>
			</div>
		</div>
	</div>

	<div class="navigation">
		<div id="inner-wrap">
			<div class="location">
				<span class="location">HOME</span><a href="boxoffice.jsp"
					class="fast">영화</a><a href="boxoffice.jsp" class="fast">전체영화</a>
			</div>
		</div>
	</div>
	<div class="boxoffice-container"
		style="position: relative; width: 1100px; margin: 0 auto;">
		<section class="boxoffice-wrapper">
			<div class="titlebox-wrap" style="border-bottom: 2px solid #503396">
				<h2 style="margin-bottom: 10px;">박스오피스순</h2>
			</div>
			<div class="boxoffice-util">
				<input type="text" class="search-box" placeholder="영화검색">
			</div>
			<div class="movie-list">
				<ol style="width: 1125px">
					<!-- 박스오피스 순위 -->
					<c:forEach var="movie" items="${rs.rows}" varStatus="status">
						<c:set var="images" value="${movie.movie_img}" />
						<c:set var="poster" value="${fn:split(images,',')[0]} " />
						<c:set var="title" value="${movie.movie_title}" />
						<c:set var="movie_score" value="${movie.movie_score }"/>
						<!-- 영화 제목 -->
						<!--  -->
						<li class="movie-group ${movie.movie_rank }" id="test">
							<a href="movie_detail.jsp?movietitle=${title }">
									<div class="movie-post" style="background-image: url(${poster}); background-size:cover;">
										<p class="rank" style="font: Light Oblique 35px/42px Helvetica; font-size: 35px; color: white; position: absolute; padding: 20px; font-style: italic;">
											${movie.movie_rank }</p>
										<div class="movie-summ" style="line-height: 25px;">
											<div class="div-summ">${movie.movie_summary }</div>
											<div class="div-score">평점 : ${movie_score }</div>
										</div>
									</div>
							</a>
							<div class="movieinfo-wrapper">
								<div class="age age-${movie.movie_age }"
									style="display: inline-block; line-height: 33px; font-size: 14px;">${movie.movie_age}</div>
								<div class="title-box">
									<a href="movie_detail.jsp?movietitle=${title }">${movie.movie_title}</a>
								</div>
								<div class="movieinfo-number"
									style="font-size: 15px; margin-top: 15px; font-weight: bold;">
									예매율 ${movie.movie_reser} | 개봉일 ${movie.movie_release }</div>
								<div class="this-title" style="display: none">${title },<%=session.getAttribute("loginid")%></div>
								<%
									//로그인 중
								if (session.getAttribute("loginid") != null) {
								%>
								<button type="button"
									class="heart-boxoffice btn-boxoffice click">
									<%
										LikeDAO likeDAO = new LikeDAO();
									boolean ck = likeDAO.selectMovieLike((String) pageContext.getAttribute("title"),
											(String) session.getAttribute("loginid"));
									if (ck) {
									%>
									<img id="heart" src="image/heart_1.png"
										style="float: left; margin: 10px 20px 0;">
									<%
										} else {
									%>
									<img id="heart" src="image/heart_.png"
										style="float: left; margin: 10px 20px 0;">
									<%
										}
									%>
									<span class="like-number">${movie.movie_like}</span>
								</button>
								<%
									} else {//로그아웃
								%>
								<button type="button" class="heart-boxoffice btn-boxoffice">
									<img id="heart" src="image/heart_.png"
										style="float: left; margin: 10px 10px 0;"> <span
										class="like-number"
										>${movie.movie_like}</span>
								</button>
								<%
									}
								%>
								<button type="button" class="regist btn-boxoffice">예매</button>
							</div></li>
						<!--  -->
						<%-- <li class="movie-group ${movie.movie_rank }" id="test">

							<div>
								<img class="movie-post" src="${poster }" />
								<p class="rank"
									style="font: Light Oblique 35px/42px Helvetica; font-size: 35px; color: white; position: absolute; padding: 20px; font-style: italic;">
									${movie.movie_rank }</p>
								<div class="movie-summ" style="line-height: 25px;">${movie.movie_summary }</div>
							</div>

							<div class="movieinfo-wrapper">
								<div class="age age-${movie.movie_age }" name="movie-rate"
									style="display: inline-block; line-height: 33px; font-size: 14px;">${movie.movie_age }</div>
								<div class="title"
									style="font-size: 20px; position: absolute; top: 0; left: 35px; line-height: 30px;"
									name="영화제목">
									<a href="movie_detail_test.jsp?movietitle=${title }">
										${movie.movie_title}</a>
								</div>
								<div class="movieinfo-number"
									style="font-size: 15px; margin-top: 15px; font-weight: bold;">
									예매율 ${movie.movie_reser} | 개봉일 ${movie.movie_release }</div>


								<a href="#" class="heart btn"> <img id="heart"
									class="heart_2" src="image/heart_.png"
									style="float: left; margin: 10px 20px 0;"> <span
									class="like-number"
									style="font-size: 18px; color: #838383; margin-right: 30px;">0</span>
								</a>
								<button type="button" class="regist btn">예매</button>
							</div>
						</li> --%>

					</c:forEach>
				</ol>
			</div>








			<!-- <button type="button" class="show-more">더보기</button> -->
		</section>
	</div>

	<!-- //footer -->
	<footer include-html="footer.jsp"></footer>
	<script>
		includeHTML();
	</script>

</body>

</html>