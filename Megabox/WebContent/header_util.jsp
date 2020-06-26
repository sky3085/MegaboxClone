
<%@page import="megaboxClass.LikeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

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

	<div>
		<section id="loginpopup">
			<div class="login_popup">
				<div class="layer-header">
					<h3 class="tit">로그인</h3>
					<img src="image/btn-layer-close.png" alt="닫기" class="close-login">
				</div>
				<div class="layer-con">

					<div class="login-con">
						<form method="post" name="loginForm">
							<input name="userid" id="ibxLoginId" maxlength="20"
								type="text" placeholder="아이디" title="아이디를 입력하세요"
								class="input-text strTrim">
							<input name="userpw" id="ibxLoginPwd" maxlength="20" type="password"
								placeholder="비밀번호" title="비밀번호를 입력하세요" class="input-text mt15">
							<div class="chk-util">
								<input id="chkIdSave" type="checkbox"> <label for="chkIdSave">아이디 저장</label>
							</div>
							<input type="submit" id="loginSubmit" value="로그인" class="button purple confirm">
						</form>
						<div class="link">
							<a href="idfind.jsp" title="ID/PW 찾기 선택">ID/PW 찾기</a>
							<span> | </span>
							<a href="megaSign.jsp" title="회원가입 선택">회원가입</a>
						</div>
					</div>

					<!-- <div class="login-add">
					<a href="lastweek.jsp" alt="광고" target="_blank"> <img
						id="pageBannerRnbImage" src="image/next-end.jpg"></a>
				</div> -->
				</div>
			</div>
		</section>

		<!-- menu js-->
		<div class="movieBtn_menu">
			<div class="container">
		<!-- 		<li><a href="boxoffice.jsp">전체영화</a></li> -->
			</div>
		</div>
		<div class="reserveBtn_menu">
			<div class="container">
	<!-- 			<li><a href="quick-reserve.jsp">빠른예매</a></li> -->
			</div>
		</div>

		<div class="menuBtn_sitemap">
			<div class="container">
				<h2 class="tit">SITEMAP</h2>

				<div class="sitemapMenuList">
					<div class="list position-1">
						<p class="tit-depth">영화</p>
						<ul class="list-depth">
							<!-- <li><a href="boxoffice.jsp" title="전체영화">전체영화</a></li> -->
						</ul>
					</div>
					<div class="list position-2">
						<p class="tit-depth">예매</p>
						<ul class="list-depth">
							<li><a href="booking.jsp" title="빠른예매">빠른예매</a></li>
						</ul>
					</div>
					<div class="list position-3">
						<p class="tit-depth">나의 메가박스</p>
						<ul class="list-depth mymage">
							<li><a href="mypagemain.jsp" title="나의 메가박스 홈">나의 메가박스 홈</a></li>
							<li><a href="bookinglist.jsp" title="예매내역">예매/구매내역</a></li>
							<li><a href="userinfo.jsp" title="회원정보">회원정보</a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>

		<!-- 검색 팝업  -->
		<div class="searchBtn_sitemap" style="display: none;">
			<div class="container"
				style="width: 1000px; margin-left: 200px; align: center;">
				<div class="searchTitle"
					style="width: 1000px; display: block; float: left;">
					<h2 class="tit">예매율 순</h2>
					<!-- <h2 class="tit">누적관객순</h2>
				<h2 class="tit">메가스코어순</h2> -->

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
					<!-- <div class="searchMovie" style="display: block; width: 360px; line-height: 50px; border-bottom: solid 1px #ffffff; margin-left: 150px; margin-top: 100px; padding-left: 0px; padding-top: 0px;">
					<input type="text" placeholder="영화를 검색하세요" title="영화 검색" class="input-text" style="display: block; float: left; width: 260px; height: 60px; font-size: 17px; color: #ffffff; background-color: transparent; border: 0; padding: 0px 20px">
					<input type="image" src="image/ico-search-white.png" class="input-img" style="display: block; float: right; line-height: 60px; margin: 0 auto; background-color: transparent; border: 0; padding: 20px;">
				</div> -->
				</div>
			</div>
		</div>

		<!-- 마이페이지 팝업  -->
		<div class="mymegaBtn_sitemap1">
			<div class="container">
				<c:choose>
					<c:when test="${not empty sessionScope.loginid}">
						<div class="login-after">
							<c:forEach var="mega_member" items="${memberDb_rs.rows }">
								<p class="txt">
									안녕하세요!
									<c:out value="${mega_member.mem_name}" />
									회원님
									<!--  <br> 마지막 접속일 : 0000년 00월 00일 00:00:00 -->
								</p>
							</c:forEach>
							<div class="moveMymega">
								<a href="mypagemain.jsp">나의 메가박스</a>
							</div>
						</div>
					</c:when>
					<c:otherwise>
						<div class="login-before">
							<p class="txt">
								로그인 하시면 나의 메가박스를 만날 수 있어요.<br> 영화를 사랑하는 당신을 위한 꼭 맞는 혜택까지
								확인해 보세요!
							</p>
							<div class="moveLogin">
								<a href="#" id="moveLogin" title="로그인" class="buttonLogin">로그인</a>
							</div>
							<div class="nonmember">
								<a href="megaSign.jsp" class="link" title="혹시 아직 회원이 아니신가요?">혹시
									아직 회원이 아니신가요?</a>
							</div>
						</div>
					</c:otherwise>
				</c:choose>
			</div>
		</div>

	</div>
