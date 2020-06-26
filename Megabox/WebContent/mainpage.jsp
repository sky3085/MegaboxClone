
<%@page import="megaboxClass.LikeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="ko">

<!-- mega_movie 쿼리문  -->
<sql:setDataSource var="db" driver="org.mariadb.jdbc.Driver"
	url="jdbc:mariadb://127.0.0.1:3306/project" user="root" password="1234" />
<sql:query dataSource="${db}" var="rs">  
	SELECT * from mega_movie;
</sql:query>
<!-- mega_member 쿼리문  -->


<sql:query dataSource="${db}" var="memberDb_rs">  
	SELECT mem_name FROM mega_member WHERE mem_id=?;  
	<sql:param value="${sessionScope.loginid}" />
</sql:query>


<!--  c tag로 수정했습니다. -->
<!-- 243줄 loginpopup 수정필요 -->

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>라이프시어터, 메가박스</title>
<link rel="stylesheet" href="css/main_style.css">

<link rel="stylesheet" href="css/other_style.css?ver=1">
<link rel="stylesheet" href="css/footer.css">
<link rel="stylesheet" href="css/main_js.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="js/mainpage.js?ver=5"></script>
<script src="js/include.js"></script>

</head>
<body>
	<!-- //header -->
	<header id="header">
		<div class="container">
			<div class="row">
				<div class="header">
					<h5>
						<c:choose>
							<c:when test="${not empty sessionScope.loginid}">
								<li><a href="#" id="logout" style="color:#FFF">로그아웃</a></li>
								<li><a href="booking.jsp" style="color:#FFF">빠른예매</a></li>
							</c:when>
							<c:otherwise>
								<li><a href="#" id="loginbringPopup" style="color:#FFF">로그인</a></li>
								<li><a href="megaSign.jsp" style="color:#FFF">회원가입</a></li>
							</c:otherwise>
						</c:choose>

					</h5>
					<br>
					<nav class="nav">
						<ul class="nav_left">
							<li><a href="#"><img src="image/menu_white.svg" alt="메뉴"
									class="menuBtn"><img
									src="image/btn-header-layer-close.png" class="menuClose"></a></li>
							<li><a href="#"><img src="image/search_white.svg"
									alt="검색" class="searchBtn"><img
									src="image/btn-header-layer-close.png" class="searchClose"></a></li>
							<li><a href="boxoffice.jsp"><img
									src="image/gnb-txt-movie-white.png" alt="영화" class="movieBtn"></a></li>
							<li><a href="booking.jsp"><img
									src="image/gnb-txt-reserve-white.png" alt="예매"
									class="reserveBtn"></a></li>
						</ul>
						<ul class="nav_middle">
							<li><a href="mainpage.jsp"><img
									src="image/logo_white.png" alt="메인로고"transparent 0% 0% no-repeatpadding-box;></a></li>
						</ul>
						<ul class="nav_right">
							<li><a href="#"><img src="image/ico-mymega.png"
									alt="마이메가박스" class="mymegaBtn"><img
									src="image/btn-header-layer-close.png" class="mymegaClose"></a></li>
						</ul>
					</nav>
				</div>
			</div>
		</div>
	</header>
	<!-- //header -->
	<div include-html="header_util.jsp"></div>

	<!--movie-->
	<section id="movie">
		<div class="container">
			<div class="row">
				<div class="movie">
					<div class="movie_title" id="movie_title">
						<ul>
							<li><a href="boxoffice.jsp">박스오피스순</a></li>
							<li><a href="#">누적관객순</a></li>
							<li><a href="#">메가스코어순</a></li>
						</ul>
					</div>

					<div class="movie_chart">
						<div class="container">
							<c:forEach var="movie" items="${rs.rows}" begin="0" end="3">
								<c:set var="images" value="${movie.movie_img}" />
								<c:set var="poster" value="${fn:split(images,',')[0]} " />
								<c:set var="title" value="${movie.movie_title}" />
								<!-- 영화 제목 -->
								<ol class="movie-group ${movie.movie_rank }" id="test">
									<a href="movie_detail.jsp?movietitle=${title }">
										<div class="movieWapper"
											style="width: 245px; height: 410px; float: left; padding: 0 15px 10px 15px;">
											<div class="movie-post"
												style="background-image: url(${poster}); background-size:cover; border-radius: 10px; border:1px solid #474747; ">
												<p class="rank"
													style="font: Light Oblique s35px/42px Helvetica; font-size: 35px; color: white; position: absolute; padding: 20px; font-style: italic;">
													${movie.movie_rank }</p>

												<div class="movie-summ" style="line-height: 25px;">
													<div style="height: 300px; overflow: hidden;">${movie.movie_summary }</div>
												</div>
											</div>

											<div>
												<div class="this-title" style="display: none">${title },<%=session.getAttribute("loginid")%></div>
												<%
													//로그인 중
												if (session.getAttribute("loginid") != null) {
												%>
												<%-- <sql:query dataSource="${db}" var="like">  
												SELECT like_boolean from movie_like where like_title = '${movie.movie_title}' and like_member = '<%=session.getAttribute("loginid") %>';  
											</sql:query> --%>
												<button type="button" class="heart btn click"
													style="float: left; width: 37%;">
													<%-- 
												//<c:forEach var="idCheck" items="${like }">
												//<%if(session.getAttribute("loginid") == ${idCheck ) %> --%>
													<%
														LikeDAO likeDAO = new LikeDAO();
													boolean ck = likeDAO.selectMovieLike((String) pageContext.getAttribute("title"),
															(String) session.getAttribute("loginid"));
													if (ck) {
													%>
													<img id="heart" src="image/heart_1.png"
														style="float: left; margin: 10px 10px 0;"> <span
														class="like-number"
														style="font-size: 18px; color: #838383; margin-right: 15px;">${movie.movie_like}</span>
													<%
														} else {
													%>
													<img id="heart" src="image/heart_.png"
														style="float: left; margin: 10px 10px 0;"> <span
														class="like-number"
														style="font-size: 18px; color: #838383; margin-right: 15px;">${movie.movie_like}</span>
													<%
														}
													%>
													<%-- </c:forEach> --%>
												</button>
												<%
													} else {//로그아웃
												%>
												<button type="button" class="heart btn"
													style="float: left; width: 37%;">
													<img id="heart" src="image/heart_.png"
														style="float: left; margin: 10px 10px 0;"> <span
														class="like-number"
														style="font-size: 18px; color: #838383; margin-right: 15px;">${movie.movie_like}</span>
												</button>
												<%
													}
												%>
												<button type="button" class="regist btn"
													style="float: right; width: 60%; line-height: 40px; background-color: #503396; color: #fff;">예매</button>
											</div>
										</div>
									</a>
								</ol>
							</c:forEach>
						</div>
					</div>
					<div class="shortcut_search">
						<div class="searchMovie">
							<input type="text" placeholder="영화명을 입력해 주세요" title="영화 검색"
								class="input-text" id="movieName"> <input type="image"
								src="image/ico-search-white.png">
						</div>
						<div class="shortcut">
							<a href="boxoffice.jsp" title="박스오피스"><img
								src="image/ico-boxoffice-main.png"> 박스오피스</a>
						</div>
						<div class="shortcut">
							<a href="booking.jsp" title="빠른예매"><img
								src="image/ico-quick-reserve-main.png"> 빠른예매</a>
						</div>
					</div>

				</div>
			</div>
		</div>
	</section>
	<footer include-html="footer.jsp"></footer>
	<script>
		includeHTML();
	</script>
</body>
</html>