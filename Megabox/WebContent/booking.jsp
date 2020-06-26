<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="javax.websocket.Session"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="megaboxClass.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<%
	MovieDAO movieDAO = new MovieDAO();
	ArrayList<MovieDTO> movieList = new ArrayList<>();
	movieList = movieDAO.selectMovid1();
	request.setAttribute("movieList", movieList);
%>

<sql:setDataSource var="db" driver="org.mariadb.jdbc.Driver"
	url="jdbc:mariadb://127.0.0.1:3306/project" user="root"
	password="1234" />
<sql:query dataSource="${db}" var="memberDb_rs">  
	SELECT mem_name FROM mega_member WHERE mem_id=?;  
	<sql:param value="${sessionScope.loginid}"/>
</sql:query>


<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>빠른 예매</title>
<link href="https://fonts.googleapis.com/css?family=Roboto&display=swap" rel="stylesheet">
<link rel="stylesheet" href="css/other_style.css">
<link rel="stylesheet" href="css/main_js.css">
<link rel="stylesheet" href="css/bookingCss.css">
<link rel="stylesheet" href="css/footer.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="js/booking.js"></script>
<script src="js/mainpage.js"></script>
<script src="js/include.js"></script>
</head>
<body>
    <header include-html="header.jsp"></header>
	<div include-html="header_util.jsp"></div>

	<div>
        <div class="page-util"><div id="inner-wrap"><div class="location"><span class="location">HOME</span><a href="booking.jsp" class="fast">예매</a><a href="booking.jsp" class="fast">빠른예매</a></div></div></div>
        <div id="main">
            <div class="tit"><h2>빠른예매</h2></div>
            <div id="pick">
                <div class="time-schedule">
                    <button class="btn-next btn-prev-date" title="이전 날짜 보기"><i class="iconset ico-cld-pre"></i></button>
                    <div class="date-list">
                        <div class="wrap-date">
                            <button class="on date-area">
                                <span class="ir">5월</span>
                                <em style="pointer-events: none;">18<span style="pointer-events: none;" class="ir">일</span></em>
                                <span class="day-kr" style="pointer-events: none; display: inline-block;">오늘</span>
                                <span class="day-en" style="pointer-events: none; display: none;">Wed</span>
                            </button>
                            <button class="date-area">
                                <span class="ir">5월</span>
                                <em style="pointer-events: none;">19<span style="pointer-events: none;" class="ir">일</span></em>
                                <span class="day-kr" style="pointer-events: none; display: inline-block;">수</span>
                                <span class="day-en" style="pointer-events: none; display: none;">Thu</span>
                            </button>
                            <button class="date-area">
                                <span class="ir">5월</span>
                                <em style="pointer-events: none;">20<span style="pointer-events: none;" class="ir">일</span></em>
                                <span class="day-kr" style="pointer-events: none; display: inline-block;">목</span>
                                <span class="day-en" style="pointer-events: none; display: none;">Fri</span>
                            </button>
                            <button class="date-area">
                                <span class="ir">5월</span>
                                <em style="pointer-events: none;">21<span style="pointer-events: none;" class="ir">일</span></em>
                                <span class="day-kr" style="pointer-events: none; display: inline-block;">금</span>
                                <span class="day-en" style="pointer-events: none; display: none;">Sat</span>
                            </button>
                            <button class="date-area">
                                <span class="ir">5월</span>
                                <em style="pointer-events: none;">22<span style="pointer-events: none;" class="ir">일</span></em>
                                <span class="day-kr" style="pointer-events: none; display: inline-block;">토</span>
                                <span class="day-en" style="pointer-events: none; display: none;">Sun</span>
                            </button>
                            <button class="date-area">
                                <span class="ir">5월</span>
                                <em style="pointer-events: none;">23<span style="pointer-events: none;" class="ir">일</span></em>
                                <span class="day-kr" style="pointer-events: none; display: inline-block;">일</span>
                                <span class="day-en" style="pointer-events: none; display: none;">Mon</span>
                            </button>
                            <button class="date-area">
                                <span class="ir">5월</span>
                                <em style="pointer-events: none;">24<span style="pointer-events: none;" class="ir">일</span></em>
                                <span class="day-kr" style="pointer-events: none; display: inline-block;">월</span>
                                <span class="day-en" style="pointer-events: none; display: none;">Tue</span>
                            </button>
                            <button class="date-area">
                                <span class="ir">2020년 5월</span>
                                <em style="pointer-events: none;">25<span style="pointer-events: none;" class="ir">일</span></em>
                                <span class="day-kr" style="pointer-events: none; display: inline-block;">화</span>
                                <span class="day-en" style="pointer-events: none; display: none;">Wed</span>
                            </button>
                            <button class="date-area">
                                <span class="ir">2020년 5월</span>
                                <em style="pointer-events: none;">26<span style="pointer-events: none;" class="ir">일</span></em>
                                <span class="day-kr" style="pointer-events: none; display: inline-block;">수</span>
                                <span class="day-en" style="pointer-events: none; display: none;">Thu</span>
                            </button>
                            <button class="date-area">
                                <span class="ir">2020년 5월</span>
                                <em style="pointer-events: none;">27<span style="pointer-events: none;" class="ir">일</span></em>
                                <span class="day-kr" style="pointer-events: none; display: inline-block;">목</span>
                                <span class="day-en" style="pointer-events: none; display: none;">Fri</span>
                            </button>
                            <button class="date-area">
                                <span class="ir">2020년 5월</span>
                                <em style="pointer-events: none;">28<span style="pointer-events: none;" class="ir">일</span></em>
                                <span class="day-kr" style="pointer-events: none; display: inline-block;">금</span>
                                <span class="day-en" style="pointer-events: none; display: none;">Sat</span>
                            </button>
                            <button class="date-area">
                                <span class="ir">2020년 5월</span>
                                <em style="pointer-events: none;">29<span style="pointer-events: none;" class="ir">일</span></em>
                                <span class="day-kr" style="pointer-events: none; display: inline-block;">토</span>
                                <span class="day-en" style="pointer-events: none; display: none;">Sun</span>
                            </button>
                            <button class="date-area">
                                <span class="ir">2020년 5월</span>
                                <em style="pointer-events: none;">30<span style="pointer-events: none;" class="ir">일</span></em>
                                <span class="day-kr" style="pointer-events: none; display: inline-block;">일</span>
                                <span class="day-en" style="pointer-events: none; display: none;">Mon</span>
                            </button>
                            <button class="date-area">
                                <span class="ir">2020년 5월</span>
                                <em style="pointer-events: none;">31<span style="pointer-events: none;" class="ir">일</span></em>
                                <span class="day-kr" style="pointer-events: none; display: inline-block;">월</span>
                                <span class="day-en" style="pointer-events: none; display: none;">Thu</span>
                            </button>
                            
                        </div>
                    </div>
                    <button class="btn-next btn-next-date" title="다음 날짜 보기"><i class="iconset ico-cld-next"></i></button>
                    <div class="bg-line"><button class="btn-calendar-large"></button></div>
                </div>
                <div class="quick-reserve-area">
                    <div class="movie-choice">
                        <p class="tit">영화</p>
                        <div class="list-area">
                            <div class="all-list">
                                <button type="button" class="btn-tab on-movie" id="movieAll">전체</button>
                                <button type="button" class="btn-tab off-movie"></button>
                                <div class="list">
                                    <div class="scroll">
                                        <ul>
                                        	<c:forEach var="movieDTO" items="${movieList}">
                                        	<c:set var="title" value="${movieDTO.movieTitle}" />
                                            <li style="height:100%;">
                                                <button type="button" class="btn-booking">
                                                    <span class="movie-grade">${movieDTO.movieAge}</span>
                                                    <%
													LikeDAO likeDAO = new LikeDAO();
													boolean ck = likeDAO.selectMovieLike((String)pageContext.getAttribute("title"), (String)session.getAttribute("loginid"));
													if(ck){
													%>
                                                    		<i class="ico-heart-small" style="background-image: url(image/heart_1.png); background-size: cover;">${movieDTO.movieLike}</i>
                                                    <%}else{ %>	
															<i class="ico-heart-small">${movieDTO.movieLike}</i>
													<%} %>
                                                    <span class="txt">${movieDTO.movieTitle }</span>
                                                </button>
                                            </li>
                                            </c:forEach>
                                            
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="view-area">
                            <div class="choice-all" id="choiceMoiveNone" style="display: block;">
                                <strong>모든영화</strong>
                                <span>목록에서 영화를 선택하세요.</span>
                            </div>
                            <div class="choice-list-movie" id="choiceMovieList" style="display: none;">
                                <div class="bg-movie" id="bg-m1" style="margin-left: 0;">
                                </div>
                                <div class="bg-movie" id="bg-m2"></div>
                                <div class="bg-movie" id="bg-m3"></div>
                            </div>
                        </div>
                    </div>
                    <div class="theater-choice">
                        <div class="tit-area">
                            <p class="tit">극장</p>
                        </div>
                        <div class="list-area">
                            <div class="all-list">
                                <button type="button" class="btn-tab on-theater" id="movieAll">전체</button>
                                <button type="button" class="btn-tab off-theater"></button>
                                <div class="list">
                                    <div class="scroll">
                                        <ul>
                                        	<sql:query dataSource="${db}" var="location">  
												SELECT DISTINCT cinema_location from mega_cinema; 
											</sql:query>
                                        	<c:forEach var="cinema_location" items="${location.rows}">
                                            <li>
                                                <button type="button" class="btn-theater">${cinema_location.cinema_location}</button>
                                                <div class="theater-list" style="display: none;">
                                                    <ul class="list-left">
                                                    	<sql:query dataSource="${db}" var="cinema">  
															SELECT cinema_cinema from mega_cinema where cinema_location=?;
															<sql:param value="${cinema_location.cinema_location}"/>
														</sql:query>
                                                    		<c:forEach var="cinema_cinema" items="${cinema.rows}">
                                                        <li>
                                                            <button type="button" class="detail-list">${cinema_cinema.cinema_cinema}</button>
                                                        </li>
                                                        	</c:forEach>
                                                    </ul>
                                                </div>
                                            </li>
                                            </c:forEach>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="view-area">
                            <div class="choice-all" id="choiceBrchNone" style="display: block;">
                                <strong>전체극장</strong>
                                <span>목록에서 극장을 선택하세요.</span>
                            </div>
                            <div class="choice-list" id="choiceBrchList" style="display: none;">
                                <div class="bg" id="bg1"></div>
                                <div class="bg" id="bg2"></div>
                                <div class="bg" id="bg3"></div>
                            </div>
                        </div>
                    </div>
                    <div class="time-choice">
                        <div class="tit-area">
                            <p class="tit-time" style="clear: both;">시간</p>
                            <div class="right legend">
                                <i class="iconset ico-sun" title="조조"></i> 조조
                                <i class="iconset ico-brunch" title="브런치"></i> 브런치
                                <i class="iconset ico-moon" title="심야"></i> 심야
                            </div>
                        </div>
                        <div class="hour-schedule">
                            <button class="btn-prev-time"></button>
                            <div class="wrap">
                                <div class="view" style="position: absolute; width: 1015px; left: 0px;">
                                    <button type="button" class="hour">00</button>
                                    <button type="button" class="hour">01</button>
                                    <button type="button" class="hour">02</button>
                                    <button type="button" class="hour">03</button>
                                    <button type="button" class="hour">04</button>
                                    <button type="button" class="hour">05</button>
                                    <button type="button" class="hour">06</button>
                                    <button type="button" class="hour">07</button>
                                    <button type="button" class="hour">08</button>
                                    <button type="button" class="hour">09</button>
                                    <button type="button" class="hour">10</button>
                                    <button type="button" class="hour">11</button>
                                    <button type="button" class="hour">12</button>
                                    <button type="button" class="hour">13</button>
                                    <button type="button" class="hour">14</button>
                                    <button type="button" class="hour">15</button>
                                    <button type="button" class="hour">16</button>
                                    <button type="button" class="hour">17</button>
                                    <button type="button" class="hour">18</button>
                                    <button type="button" class="hour">19</button>
                                    <button type="button" class="hour">20</button>
                                    <button type="button" class="hour">21</button>
                                    <button type="button" class="hour">22</button>
                                    <button type="button" class="hour">23</button>
                                    <button type="button" class="hour">24</button>
                                    <button type="button" class="hour">25</button>
                                    <button type="button" class="hour">26</button>
                                    <button type="button" class="hour">27</button>
                                    <button type="button" class="hour">28</button>
                                </div>
                            </div>
                            <button class="btn-next-time"></button>
                        </div>
                        <div class="movie-schedule-area">
                            <div class="no-result" id="playScheduleNonList" style="display: block;">
                                <i class="iconset ico-movie-time"></i>
                                <p>영화와 극장을 선택하시면<br>상영시간표를 비교하여 볼 수 있습니다.</p>
                            </div>
                            <div class="result" style="display: none;">
                                <div class="scroll">
                                    <div class="mCSB_container">
                                        <ul>
                                        	<!-- 여기다 리스 트 추가 -->
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
<!--footer -->
	<footer include-html="footer.jsp"></footer>
	<script>
		includeHTML();
	</script>

</body>
</html>