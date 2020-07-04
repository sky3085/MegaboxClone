<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
	request.setCharacterEncoding("UTF-8");
%>


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

<!-- review database 최신순으로  -->
<sql:setDataSource var="reviewDb" driver="org.mariadb.jdbc.Driver"
	url="jdbc:mariadb://127.0.0.1:3306/project" user="root" password="1234" />
<sql:query dataSource="${reviewDb}" var="reviewRs">  
	SELECT * FROM  movie_review  WHERE review_title =? ORDER BY review_date DESC;  
	<sql:param value="${movie_title}" />
</sql:query>
<!-- review 중복 작성 방지  -->
<sql:query dataSource="${reviewDb}" var="wrote_review">  
	SELECT review_title FROM  movie_review  WHERE review_title =(?) AND review_id=(?);  
	<sql:param value="${movie_title}" />
	<sql:param value="${loginid}" />
</sql:query>
<!--  review 작성 수  -->
<sql:query dataSource="${reviewDb}" var="reviews">  
	SELECT review_title FROM  movie_review  WHERE review_title =(?);  
	<sql:param value="${movie_title}" />
</sql:query>



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
	
	<section class="content">
		<div class="review">
			<p style="font-size: 26px;">
				"${movie_title }"에대한
				<c:out value="${reviews.rowCount }" />
				개의이야기가있어요!
			</p>
			<!-- 			<ul class="review-util 1">
				<li>전체 |</li>
				<li><a href="#">기대평 999건 |</a></li>
				<li><a href="#">관람평 999건</a></li>
			</ul>
			<ul class="review-util two"
				style="position: absolute; top: 188px; right: 0;">
				<li><a href="#">최신순 |</a></li>
				<li><a href="#">공감순</a></li>
			</ul> -->
			<li class="write-review">
				<div class="storyArea">
					<div class="user-wrapper">
						<div class="user"></div>
						<p>
							<c:out value="${loginid }" />
						</p>
					</div>
					<div class="storyBox">
						<div class="wrap-WriteReview">
							<span class="default" style="font-size: 15px;">${movie_title }의
								어떤 점이 기대되세요? 기대되는 점을 한줄평으로 남겨주세요!</span> <a href="#"
								user-id="${loginid }" check_wrote="${wrote_review.rowCount }"
								class="writeBtn" style="font-size: 15px;"><img
								src="image/review@2x.png" width="18px"
								style="padding-right: 10px;">한줄평쓰기</a>
						</div>
					</div>
					<!-- action="ReviewDAO" -->
					<form name="review" method="post" accept-charset="utf-8"
						id="review_form">
						<input type="hidden" name="review_title" value="${movie_title }" />
						<input type="hidden" name="review_id" value="${loginid }" />
						<div class="write_popup_wrapper">
							<header class="layer-header">
								<p style="color: white; font-size: 22px;">관람평 작성하기</p>
								<button type="button" class="close"
									style="font-size: 22px; color: white; position: absolute; right: 24px; top: 13px; background-color: rgba(0, 0, 0, 0); border: none;">✕</button>
							</header>
							<div class="layer-content">

								<p
									style="padding: 0 20px; margin: 0; color: #353535; padding: 25px 0;">
									"
									<c:out value="${movie_title }" />
									"<br>관람평을 남겨보세요!
								</p>
							</div>

							<div class="popup_score-box">
								<div class="box-star" style="margin: 0 150px;">
									
									<span class="star star_left"><img src="image/odd.png"><span
										hidden id="score">1</span></span> <span class="star star_right"><img
										src="image/even.png"><span hidden id="score">2</span></span> <span
										class="star star_left"><img src="image/odd.png"><span
										hidden id="score">3</span></span> <span class="star star_right"><img
										src="image/even.png"><span hidden id="score">4</span></span> <span
										class="star star_left"><img src="image/odd.png"><span
										hidden id="score">5</span></span> <span class="star star_right"><img
										src="image/even.png"><span hidden id="score">6</span></span> <span
										class="star star_left"><img src="image/odd.png"><span
										hidden id="score">7</span></span> <span class="star star_right"><img
										src="image/even.png"><span hidden id="score">8</span></span> <span
										class="star star_left"><img src="image/odd.png"><span
										hidden id="score">9</span></span> <span class="star star_right"><img
										src="image/even.png"><span hidden id="score">10</span></span> <input
										type="hidden" class="review_score" name="review_score"
										style="border: none;" value="0"> <span
										id="score-count">0</span>점
								</div>

								<div class="text-area">
									<textarea id="text-area" name="review_text"
										style="color: #353535; border: solid 1px #AFAFB0; resize: none; font-size: 18px; border-bottom: none; outline: none;"
										placeholder="영화에 대한 후기를 남겨주세요" rows="5" cols="50"
										class="input-textarea"></textarea>
									<div class="count-util"
										style="font-size: 18px; margin-top: -20px;">
										<span id="text_count">0</span>/100
									</div>

								</div>

							</div>
							<div style="padding: 0 208px;" class="btn-wrapper">
								<button type="button" class="wcancel wbtn">취소</button>
								<button type="button" class="wregist wbtn">등록</button>
							</div>
						</div>
					</form>
			</li>
			<c:forEach var="review" items="${reviewRs.rows }" varStatus="status">
				<c:set var="review_id" value="${review.review_id }" />
				<c:set var="review_text" value="${review.review_text }" />
				<c:set var="review_score" value="${review.review_score }" />
				<c:set var="review_date" value="${review.review_date }" />
				<li class="ContentTag">
					<div class="storyArea">
						<div class="user-wrapper">
							<div class="user"></div>
							<p>
								<c:out value="${review_id}" />
							</p>
						</div>
						<div class="storyBox">
							<div class="tit">관람평</div>
							<div class="story-point">${review_score}</div>
							<div class="reviewBox">${review_text }</div>
							<!-- <div class="story-like">
								<button type="button" class="LikeBtn">
										<img src="image/good@2x.png"> <span>
											<p>0</p>
										</span>
									</button>
							</div> -->
							<div class="story-util">
								<div class="circle-wrap">
									<div class="circle"></div>
									<div class="circle"></div>
									<div class="circle"></div>
								</div>
								<!-- 수적, 삭제  -->
								<div class="story-util-wrapper" title="수정,삭제">
									<div class="writer">
										<a href="#" title="수정" class="btn-modal-open updateOne"
											w-data="500" h-data="680" data-score="${review_score }"
											data-id="${review_id }" data-title="${movie_title }"
											data-text="${review_text }">수정 <i
											class="iconset ico-arr-right-green"></i>
										</a>
										<button type="button" class="deleteOne"
											data-id="${review_id }" data-title="${movie_title }"
											data-cd="PREV">
											삭제 <i class="iconset ico-arr-right-green"></i>
										</button>
									</div>
									<div class="btn-close">
										<a href="#" title="닫기"><img
											src="image/btn-balloon-close.png"
											alt="닫기"></a>
									</div>
								</div>
								<!-- 신고 -->
								<div class="story-report-wrapper" title="수정,삭제">
									<div class="btn-close">
										<a href="#" title="닫기"><img
											src="image/btn-balloon-close.png"
											alt="닫기"></a>
									</div>
									<p>신고하시겠습니까?</p>
								</div>
							</div>
							<script>
									/*아이디 일치함에 따라 관람평 수정,삭제 또는 신고*/
									$(function(){
										$(".story-util").click(function(){
											var loginid="<%=session.getAttribute("loginid")%>";
														var review_id = $(this)
																.children(
																		".story-util-wrapper")
																.children(
																		".writer")
																.children(
																		"button")
																.attr("data-id");
														if (loginid === "null") {
															console
																	.log("loginid?: "
																			+ loginid);
															alert("로그인을 해주세요");
															return false;
														}
														if (loginid === review_id) {
															$(this)
																	.children(
																			".story-util-wrapper")
																	.show();
														} else {
															$(this)
																	.children(
																			".story-report-wrapper")
																	.show();
															return false;
														}
														/* 닫기 */
														$(this)
																.children(
																		".story-util-wrapper")
																.children(
																		".btn-close")
																.click(
																		function() {
																			console
																					.log("닫기");
																			$(
																					this)
																					.children(
																							".story-util-wrapper")
																					.hide();
																		})
													});
								})
							</script>


						</div>
					</div>
					<div class="wrote-date">${review_date }</div>
				</li>
			</c:forEach>
			</ul>
		</div>
		<dib class="page-tab-wrap">
		<div class="page-tab">
			<!-- <ul>
				<li><a href="#">1</a></li>
				<li><a href="#">2</a></li>
				<li><a href="#">3</a></li>
				<li><a href="#">4</a></li>
				<li><a href="#">5</a></li>
				<li><a href="#">6</a></li>
				<li><a href="#">7</a></li>
				<li><a href="#">8</a></li>
				<li><a href="#">9</a></li>
				<li><a href="#">10</a></li>
				<li><a href="#">></a></li>
				<li><a href="#">>></a></li>
			</ul> -->
		</div>
		</dib>
	</section>
	<!-- footer -->
	<footer include-html="footer.jsp"></footer>
	<script>
		includeHTML();
	</script>
</body>
</html>
