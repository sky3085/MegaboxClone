<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
      <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<!-- mega_member 쿼리문  -->
<sql:setDataSource var="memberDb" driver="org.mariadb.jdbc.Driver"
	url="jdbc:mariadb://127.0.0.1:3306/project" user="root"
	password="1234" />
<sql:query dataSource="${memberDb}" var="memberDb_rs">  
	SELECT mem_name FROM mega_member WHERE mem_id=?;  
	<sql:param value="${sessionScope.loginid}"/>
</sql:query>

<head>
<meta charset="UTF-8">
<title>나의메가박스 | 라이프씨어터, 메가박스</title>
<link rel="stylesheet" href="css/main_js.css">
<link rel="stylesheet" href="css/other_style.css">
<link rel="stylesheet" href="css/footer.css">
<link rel="stylesheet" href="css/mypagemain_style.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="js/mainpage.js"></script>
<script src="js/include.js"></script>
</head>
<body>
<!-- //header -->
<header include-html="header.jsp"></header>
<div include-html="header_util.jsp"></div>

	<div class="container-main">
        <section id="body">
            <div class="container-mypage">
                <div class="page-util">
                	<div class="inner-wrap"> 
	                    <div class="location" style="bottom: 12px; position: relative;">
	                        <span><img src="image/bg-location-home.png" alt="home"> </span>
	                        <span><img src="image/bg-location-arr.png" alt="arr"></span>
	                        <a href="mypagemain.jsp" title="나의 메가박스 페이지로 이동">나의 메가박스</a>
	                    </div>
	            	</div>        
                </div>
				
				<div class="row">
	                <div class="nav">
	                    <nav id="lnb">
	                        <ul>
	                            <li class="nav-title"><a href="mypagemain.jsp" title="나의 메가박스 페이지로 이동">나의 메가박스</a></li>
	                            <li class="nav-sub"><a href="bookinglist.jsp" title="예매내역 페이지로 이동">예매내역</a></li>
	                            <li class="nav-sub"><a href="userconfirm.jsp" title="회원정보 페이지로 이동">회원정보</a></li>
	                            <li class="nav-depth"><a href="userconfirm.jsp" title="개인정보수정 페이지로 이동">개인정보 수정</a></li>
	                        </ul>
	                    </nav>
	                </div>
	
	                <div class="info">
	                    <div class="userInfo">
	                        <div class="img">
	                            <form name="fileForm" style="display: none;">
	                                <input type="file" name="file">
	                                <input type="hidden" name="fileMbNo" value="84913">
	                            </form>    
	                            <i class="iconset ico-add-photo"></i>
	                            <button type="button" class="img">
	                                <img src="image/bg-photo.png" alt="이미지" onerror="noImg(this, 'human')">
	                            </button>
	                        </div>
	                        <c:forEach var="mega_member" items="${memberDb_rs.rows }">
	                        <p class="welcome"><c:out value="${mega_member.mem_name}"/>님<br>환영합니다.</p>
	                        </c:forEach>
	                        <div class="link">
	                            <a href="userconfirm.jsp" title="개인정보수정">개인정보수정</a>
	                        </div>    
	                    </div>
	                    <div class="reserInfo">
	                        <h2 class="title">나의 예매내역</h2>
	                        <a href="bookinglist.jsp" class="more" title="나의 예매내역 더보기">더보기</a>
	                        <hr>
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
							<c:forEach var="seatNum" items="${seat.rows}" begin="0" end="2" step="1">
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