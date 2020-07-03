<%@page import="megaboxClass.LikeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>


		<div class="container">
			<div class="row">
				<div class="header">
					<h5>
						<c:choose>
							<c:when test="${not empty sessionScope.loginid}">
								<li><a href="#" id="logout">로그아웃</a></li>
								<li><a href="booking.jsp">빠른예매</a></li>
							</c:when>
							<c:otherwise>
								<li><a href="#" id="loginbringPopup">로그인</a></li>
								<li><a href="megaSign.jsp">회원가입</a></li>
							</c:otherwise>
						</c:choose>
					</h5>
					<br>
					<nav class="nav">
						<ul class="nav_left">
							<li><a href="#"><img src="image/ico-sitemap_b.png"
									alt="메뉴" class="menuBtn"><img
									src="image/btn-header-layer-close.png" class="menuClose">
							</a></li>
							<li><a href="#"><img src="image/ico-search_b.png"
									alt="검색" class="searchBtn"><img
                                    src="image/btn-header-layer-close.png" class="searchClose"></a></li>
							
							<li><a href="boxoffice.jsp"><img
									src="image/gnb-txt-movie.png"></a></li>
							<li><a href="booking.jsp"><img
									src="image/gnb-txt-reserve.png" class="reserveBtn"></a></li>
						</ul>
						<ul class="nav_middle">
							<li><a href="mainpage.jsp"><img src="image/logo.png"
									alt="메인로고"transparent 0% 0% no-repeatpadding-box;></a></li>
						</ul>
						<ul class="nav_right">
							<li><a href="#"><img src="image/ico-mymega_b.png"
									alt="마이메가박스" class="mymegaBtn"><img
                                    src="image/btn-header-layer-close.png" class="mymegaClose"></a></li>
						</ul>
					</nav>
				</div>
			</div>
		</div>
