<!-- 
	영화평점
	영화 포스터
 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>

<c:set var="movie_title" value="${param.movietitle }" />
<!-- movie info database -->
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

<html>
<head>
<meta charset="UTF-8">

<script src="js/mainpage.js"></script>
</head>
<body>
	<div class="movie-detail-page">
		<section class="movie">
			<div class="bg-img"></div>
			<div class="bg-pattern" style="background-image: url(${movie_poster}); background-repeat:none"></div>
			<div class="bg-mask"></div>

			<!-- movie-detail-cont -->
			<div class="movie-detail-cont">

				<!-- 개봉 예매가능-->
				<p class="title">
					<c:out value="${movie_title}" />
				</p>
				<div class="btn-util">
					<button type="button" title="보고싶어 안함" class="btn btn-like"
						rpst-movie-no="20003900">
						<i class="iconset ico-heart-line"></i> <span title="보고싶어 한 명수"
							id="intrstCnt">  </span>
					</button>

				</div>

				<!-- info -->
				<div class="info">
					<div class="score">
						<p class="tit">실관람 평점</p>
						<div class="number gt" id="mainMegaScore">
							<!--  <div class="number gt" id="mainMegaScore">
					<p title="관람 전 점수" class="before"><em>9.6</em><span class="ir">점</span></p>
					<p title="관람 후 점수" class="after"><em>0</em><span class="ir">점</span></p> -->
							<p title="실관람 평점" class="before">
								<em>${movie_score }</em><span class="ir"></span>
							</p>
						</div>
					</div>

					<div class="rate">
						<p class="tit">예매율</p>
						<p class="cont">
							<em>${movie_rank }</em>위 (0&#37;)
						</p>
					</div>

					<div class="audience ">
						<div class="tit ">
							<span class="m-tooltip-wrap ">누적관객수 <em
								class="m-tooltip ml05"> <i class="iconset ico-tooltip-gray">툴팁보기</i>
									<div class="m-detail-tooltip">
										<div class="bg-arr bottom"></div>
										<div class="cont-area"></div>
									</div>
							</em>
							</span>
						</div>
						<p class="cont">
							<em>${movie_num}</em> 명
						</p>
					</div>

				</div>
				<!--// info -->

				<div class="poster">
					<div class="wrap">

						<p class="movie-grade age-all">전체 관람가</p>

						<img src="${movie_poster }" onerror="noImg(this)" />
					</div>
				</div>

				<div class="reserve screen-type col-2">
					<div class="reserve">
						<a href="javascript:fn_bookingForm('20003900','basic');"
							class="btn reserve" title="영화 예매하기">예매</a>
					</div>
				</div>
			</div>
			<!--// movie-detail-cont -->
		</section>

	</div>

</body>
</html>