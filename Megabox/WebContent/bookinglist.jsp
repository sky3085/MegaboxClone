<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<sql:setDataSource var="memberDb" driver="org.mariadb.jdbc.Driver"
	url="jdbc:mariadb://127.0.0.1:3306/project" user="root"
	password="1234" />
	
<!-- 예매 취소 내역 주석  -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예매내역 &lt; 나의메가박스 | 라이프씨어터, 메가박스</title>
<link rel="stylesheet" href="css/bookinglist_style.css">
<link rel="stylesheet" href="css/main_js.css">
<link rel="stylesheet" href="css/other_style.css?ver=1">
<link rel="stylesheet" href="css/footer.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="js/mainpage.js"></script>
<script src="js/include.js"></script>
</head>
<body>
<header include-html="header.jsp"></header>
<div include-html="header_util.jsp"></div>
        
<div class="container-main">
        <section id="body">
            <div class="container-booking">
                <div class="page-util">
                	<div class="inner-wrap">
	                    <div class="location">
	                        <span><img src="image/bg-location-home.png" alt="home"> </span>
	                        <span><img src="image/bg-location-arr.png" alt="arr"></span>
	                        <a href="mypagemain.jsp" title="나의 메가박스 페이지로 이동">나의 메가박스</a>
	                        <span><img src="image/bg-location-arr.png" alt="arr"></span>
	                        <a href="bookinglist.jsp" title="예매내역 페이지로 이동">예매내역</a>
	                    </div>
	            	</div>
                </div>
				
				<div class="row">
	                <div class="nav">
	                    <nav id="lnb">
	                        <ul>
	                            <li class="nav-title"><a href="mypagemain.jsp" title="나의 메가박스 페이지로 이동">나의 메가박스</a></li>
	                            <li class="nav-sub"><a href="bookinglist.jsp" title="예매내역 페이지로 이동">예매/구매내역</a></li>
	                            <li class="nav-sub"><a href="userconfirm.jsp" title="회원정보 페이지로 이동">회원정보</a></li>
	                            <li class="nav-depth"><a href="userconfirm.jsp" title="개인정보수정 페이지로 이동">개인정보 수정</a></li>
	                        </ul>
	                    </nav>
	                </div>
	
	                <div class="info">
	                    <div class="reserhistory">
	                        <h2 class="title-reser">예매내역</h2>
	                        <div class="tab">
	                            <ul>
	                                <li class="tab-reser">예매</li>
	                            </ul>
	                        </div>   
	
	                        <%-- <div class="search">
	                            <table class="searchchk" summary="예매 조회 조건">
	                                <colgroup>
	                                    <col style="width:75px;">
	                                    <col>
	                                </colgroup>
	                                <tbody>
	                                    <tr>
	                                        <th scope="row">구분 </th>
	                                        <td>
	                                            <input type="radio" id="radBokd01" name="radBokd" value="B" checked="checked">
	                                            <label for="radBokd01">예매내역 </label>
	                                            <input type="radio" id="radBokd02" name="radBokd" value="E">
	                                            <label for="radBokd02">지난내역 </label>
	            
	                                            <div class="dropdown bootstrap-select disabled small bs3">
	                                                <select name="selYM" class="selectpicker small" disabled="disabled" tabindex="-98">
	                                                
	                                                    <option value="202004">2020년 4월</option>
	                                                
	                                                    <option value="202003">2020년 3월</option>
	                                                
	                                                    <option value="202002">2020년 2월</option>
	                                                
	                                                    <option value="202001">2020년 1월</option>
	                                                
	                                                    <option value="201912">2019년 12월</option>
	                                                
	                                                    <option value="201911">2019년 11월</option>
	                                                
	                                                    <option value="201910">2019년 10월</option>
	                                                
	                                                    <option value="201909">2019년 9월</option>
	                                                
	                                                    <option value="201908">2019년 8월</option>
	                                                
	                                                    <option value="201907">2019년 7월</option>
	                                                
	                                                    <option value="201906">2019년 6월</option>
	                                                
	                                                    <option value="201905">2019년 5월</option>
	                                                
	                                                </select>
	                                            </div>
	                                            <button type="button" class="button gray-line small ml05" name="search">
	                                                <img src="image/ico-search-gray.png" alt="search"> 조회 
	                                            </button>
	                                        </td>
	                                    </tr>
	                                </tbody>
	                            </table>
	                        </div> --%>
	
	                        <div class="reserInfo" style="height : auto;">
	                            <div class="history">
	                            <table class="ticket_table">
	                        	<tr>
	                        		<th>영화 제목</th>
	                        		<th>시작 시간</th>
	                        		<th>좌석</th>
	                        		<th>지역</th>
	                        		<th>상영관</th>
	                        		<th>날짜</th>
	                        	</tr>
								<sql:query dataSource="${memberDb}" var="seat">  
								SELECT ticket_movieTime, ticket_seat FROM mega_ticket WHERE ticket_id=?;  
									<sql:param value="${sessionScope.loginid}"/>
								</sql:query>
							<c:forEach var="seatNum" items="${seat.rows}">
								<c:set var="ticket_seat" value="${seatNum.ticket_seat}" />
	                        	<c:set var="ticket_movieTime" value="${seatNum.ticket_movieTime}" />
	                        		<sql:query dataSource="${memberDb}" var="movieInfo">  
										SELECT time_title, time_start, time_sinema, time_theater, time_date FROM movie_time WHERE time_idx=?;  
										<sql:param value="${ticket_movieTime}"/>
									</sql:query>
									<c:forEach var="movie" items="${movieInfo.rows}">
										<c:set var="time_title" value="${movie.time_title}" />
										<c:set var="time_start" value="${movie.time_start}" />
										<c:set var="time_sinema" value="${movie.time_sinema}" />
										<c:set var="time_theater" value="${movie.time_theater}" />
										<c:set var="time_date" value="${movie.time_date}" />
									</c:forEach>
	                        
	                        	<tr>
	                        		<td>${time_title }</td>
	                        		<td>${time_start }</td>
	                        		<td>${ticket_seat }</td>
	                        		<td>${time_sinema }</td>
	                        		<td>${time_theater }</td>
	                        		<td>${time_date }</td>
	                        	</tr>
	                        
	                        
	                        </c:forEach>
	                        </table>
								</div>
	                        </div>                    
	                    </div>
	
	
	                   <%-- 
	                    <div class="canclehistory" style="display : none;">
	                        <h2 class="title-cancle">예매취소내역</h2>
	                        <ul>
	                            <li>상영일 기준 7일간 취소내역을 확인하실 수 있습니다.</li>
	                        </ul>
	
	                        
	                        <table class="board-list" summary="취소일시, 영화명, 극장, 상영일시, 취소금액 항목을 가진 취소내역 목록 표">
	                            <colgroup>
	                                <col style="width:160px;">
	                                <col>
	                                <col style="width:130px;">
	                                <col style="width:188px;">
	                                <col style="width:105px;">
	                            </colgroup>
	                            <thead>
	                                <tr height="45px">
	                                    <th scope="col">취소일시</th>
	                                    <th scope="col">영화명</th>
	                                    <th scope="col">극장</th>
	                                    <th scope="col">상영일시</th>
	                                    <th scope="col">취소금액</th>
	                                </tr>
	                            </thead>
	                            <tbody><tr><td colspan="5" class="a-c">취소내역이 없습니다.</td></tr></tbody>
	                        </table>
	                    </div> --%>
	
	                    <div class="box">
	                        	이용안내
	                        <!-- <img src="image/ico-arr-toggle-down.png" alt="toggle-down"> -->
	                    </div>
	                    <div class="cont">
	                        <strong>[예매 안내]</strong>
	                        <ul class="dot-list mb30">
	                            <li>만 4세(48개월) 이상부터는 영화티켓을 반드시 구매하셔야 입장 가능합니다.</li>
	                            <li>예매 변경은 불가능하며, 취소 후 재 예매를 하셔야만 합니다.</li>
	                            <li>메가박스 모바일앱을 이용할 경우 티켓출력없이 모바일티켓을 통해 바로 입장하실 수 있습니다.</li>
	                        </ul>
	    
	                        <strong>[티켓교환 안내]</strong>
	                        <ul class="dot-list mb30">
	                            <li>극장의 무인발권기(KIOSK)를 통해 예매번호 또는 고객확인번호(생년월일+휴대폰번호)를 입력하여 편리하게 티켓을 발권하실 수 있습니다.</li>
	                            <li>무인발권기 이용이 어려우신경우, 티켓교환권을 출력하여 매표소에 방문하시면 티켓을 발권하실 수 있습니다.</li>
	                            <li>(티켓교환권 출력이 어려운경우 예매번호와 신분증을 지참하여 매표소에 방문하시면 티켓을 발권하실 수 있습니다)</li>
	                        </ul>
	    
	                        <strong>[예매취소 안내]</strong>
	                        <ul class="dot-list">
	                            <li>온라인(홈페이지/모바일) 예매 취소는 상영시간 20분전까지 입니다.</li>
	                            <li>위탁 예매 사이트 이용 시 취소 및 환불 규정은 해당 사이트 규정을 따릅니다.</li>
	                            <li>LIVE 공연 콘텐트는 취소 기준은 아래와 같습니다.
	                                <ul class="dash-list">
	                                    <li>관람 4일전 : 취소 가능</li>
	                                    <li>관람 3일 ~ 1일전 : 취소 수수료 부담 후 취소 가능</li>
	                                    <li>관람 당일 : 취소 및 환불 불가</li>
	                                </ul>
	                            </li>
	                            <li>공연 관람시 시작 시간 이후에는 입장이 제한 됩니다.</li>
	                            <li>발권된 티켓은 상영시간 전까지 현장 방문 시에만 취소가 가능합니다.</li>
	                        </ul>
	                    </div>
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
 
</body>
</html>