<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes" />
    <link rel="shortcut icon" />
    <title>빠른예매 &lt; 예매 | 라이프씨어터, 메가박스</title>
    <link rel="stylesheet" href="css/boxoffice.css">
<link rel="stylesheet" href="css/other_style.css">
<link rel="stylesheet" href="css/main_js.css">
<link rel="stylesheet" href="css/footer.css">
    <link href="https://fonts.googleapis.com/css?family=Roboto&display=swap" rel="stylesheet">
	<script src="js/mainpage.js"></script>
	<script src="js/include.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="js/quick-reserve.js"></script>
    
    <!-- <script src="js/quick-reserve_.js"></script> -->
</head>
<sql:setDataSource var="db" driver="org.mariadb.jdbc.Driver"
	url="jdbc:mariadb://127.0.0.1:3306/project" user="root"
	password="1234" />
<sql:query dataSource="${db}" var="rs">  
	SELECT time_date, time_title, time_start, time_finish, time_theater, time_sinema, time_category FROM movie_time where time_idx = ?;
	<sql:param value="${param.ck}"/>
</sql:query>
<c:forEach var="movie" items="${rs.rows}" varStatus="status">
			<c:set var="title" value="${movie.time_title}" />
			<c:set var="start" value="${movie.time_start}" />
			<c:set var="finish" value="${movie.time_finish} " />
			<c:set var="theater" value="${movie.time_theater}" />
			<c:set var="cinema" value="${movie.time_sinema}" />
			<c:set var="category" value="${movie.time_category} " />
			<c:set var="date" value="${movie.time_date} " />
</c:forEach>
<sql:query dataSource="${db}" var="rs2">  
	SELECT movie_img, movie_age, movie_release FROM mega_movie where movie_title=?;
	<sql:param value="${title}"/>
</sql:query>
<c:forEach var="movie" items="${rs2.rows}" varStatus="status">
			<c:set var="movieIMG" value="${fn:split(movie.movie_img, ',')[0]}" />
			<c:set var="age" value="${movie.movie_age}" />
</c:forEach>


<%-- <sql:query dataSource="${db}" var="rs3">  
	SELECT ticket_seat FROM mega_ticket where ticket_movieTime=?;
	<sql:param value="${param.ck}"/>
</sql:query> --%>

<body>
<div style="display : none;" id="nextParam">${param.ck}</div>
<div style="display : none;" id="userid"><%=session.getAttribute("loginid") %></div>
    <header include-html="header.jsp"></header>
	<div include-html="header_util.jsp"></div>

    <div class="page-util" style="">
        <div class="cont">
            <div class="inner-wrap">
                <div class="location" style="position: absolute; clear:both;">
                    <span>Home</span>
                    <a href="/booking" title="예매 페이지로 이동">예매</a>
                    <a href="/booking" title="빠른예매 페이지로 이동">빠른예매</a>
                </div>
            </div>
        </div>
    </div>

    <div class="body-iframe">
        <div class="container">
            <input type="hidden" id="playSchdlNo" name="playSchdlNo" value="2003301372070">
            <input type="hidden" id="brchNo" name="brchNo" value="1372">
        

            <div class="inner-wrap" style="padding-top:40px; padding-bottom:100px;">
                <div class="quick-reserve">
                    <h2 class="tit">빠른예매</h2>
                    <!-- cti 일때만 출력 -->

                    <!-- cti 일때만 출력 -->
                    <div class="cti-area" style="display:none">
                        <p>이름</p>
                        <input maxlength="20" name="riaName" type="text" title="이름 출력" class="input-text a-c w120px"
                            placeholder="이름" value="">

                        <p>생년월일</p>
                        <input maxlength="8" name="riaBirthday" type="text" title="생년월일 출력"
                            class="input-text a-c w150px" placeholder="6자리 또는 8자리" value="">

                        <p>휴대폰번호</p>
                        <input maxlength="11" name="riaMobileNo" type="text" title="휴대폰번호 출력"
                            class="input-text a-c w150px" placeholder="- 없이 입력" value="">

                        <p>회원</p>
                        <input name="riaMemberYn" type="text" title="회원여부 출력" class="input-text a-c w100px" value=""
                            readyonly="readyonly">


                        <button type="button" class="button gray ml10" login-at="N"></button>

                    </div>
                    <div class="seat-select-section">
                        <div class="seat-section">
                            <div class="tit-util">
                                <h3 class="tit small"> 관람인원선택<span class="sub">(최대 8매 선택가능)</span>
                                </h3>
                                <div class="right">
                                    <!-- input button type="reset" -->
                                    <button type="button" class="button gray-line small" id="seatMemberCntInit">
                                        <i class="iconset ico-reset-small"></i>초기화</button>
                                </div>
                            </div>
                            <div class="seat-area">
                                <div class="seat-count" style="min-height: 52px">







                                    <div class="cell">
                                        <p class="txt">성인</p>
                                        <div class="count">
                                            <button type="button" id="adult" class="down" title="성인 좌석 선택 감소">-</button>
                                            <div class="number">
                                                <button class="now adult" title="성인 현재 좌석 선택 수"
                                                    ticketgrpcd="TKA">0</button>
                                            </div>
                                            <button type="button" id="adult" class="up" title="성인 좌석 선택 증가">+</button>
                                        </div>
                                    </div>



                                    <div class="cell">
                                        <p class="txt">청소년</p>
                                        <div class="count">
                                            <button type="button" id="children" class="down"
                                                title="청소년 좌석 선택 감소">-</button>
                                            <div class="number">
                                                <button type="button" class="now children" title="청소년 현재 좌석 선택 수"
                                                    ticketgrpcd="TKY">0</button>
                                            </div>
                                            <button type="button" id="children" class="up"
                                                title="청소년 좌석 선택 증가">+</button>
                                        </div>
                                    </div>



                                    <div class="cell">
                                        <p class="txt">우대</p>
                                        <div class="count"><button type="button" id="disabled" class="down"
                                                title="우대 좌석 선택 감소">-</button>
                                            <div class="number"><button type="button" class="now disabled"
                                                    title="우대 현재 좌석 선택 수" ticketgrpcd="TKS">0</button>

                                            </div><button type="button" id="disabled" class="up"
                                                title="우대 좌석 선택 증가">+</button>
                                        </div>
                                    </div>







                                </div>

                                <div class="seat-layout">
                                    <div class="alert" style="display: none;"></div>
                                    <div class="seat-count-before" style="top: 0px">관람인원을 선택하십시요</div>
                    
                                    <div class="scroll m-scroll mCustomScrollbar _mCS_1 mCS_no_scrollbar">
                                        <div id="mCSB_1" class="mCustomScrollBox mCS-light mCSB_vertical mCSB_inside"
                                            style="max-height: none;" tabindex="0">
                                            <div id="mCSB_1_container" class="mCSB_container mCS_no_scrollbar_y"
                                                style="position: relative; top: 0px; left: 0px; height: 350px;"
                                                dir="ltr">
                                                <div id="seatLayout" style="width: 100%; height: 350px;">

                                                    <!--                                            스크린 이미지-->
                                                    <img src="image/img-theater-screen.png" alt="screen"
                                                        style="position: absolute; left: 62px; top: 10px;"
                                                        class="mCS_img_loaded">
                                                    <%--     
													<c:forEach var="seatNum" items="${rs3.rows}" varStatus="status">
													<c:set var="seatCK" value="${seatNum.ticket_seat}" />
													</c:forEach> --%>
                                                    <div>
                                                    	<sql:query dataSource="${db}" var="rs3">  
															SELECT DISTINCT seat_line, seat_top FROM mega_seat;
														</sql:query>
															
                                                    	<c:forEach var="seat_line" items="${rs3.rows}">
                                                    		<c:set var="seat_row" value="${seat_line.seat_line}"/>
                                                    		<c:set var="seat_top" value="${seat_line.seat_top}"/>
                                                    		<button type="button" class="btn-seat-row" title="${seat_row} 행"
                                                            style="position:absolute; left:106px; top:${seat_top}px;">${seat_row}</button>
                                                    		
                                                    		
                                                    		<sql:query dataSource="${db}" var="rs4">  
																SELECT seat_row, seat_kind, seat_rank, seat_left FROM mega_seat WHERE seat_line = ?;
															<sql:param value="${seat_row}"/>
															</sql:query>
															
															<c:forEach var="seat" items="${rs4.rows}">
																<c:set var="seat_row_num" value="${seat.seat_row}"/>
																<c:set var="seat_kind" value="${seat.seat_kind}"/>
																<c:set var="seat_rank" value="${seat.seat_rank}"/>
																<c:set var="seat_left" value="${seat.seat_left}"/>
																																					<!-- class="jq-tooltip seat-condition standard common" -->
																<button type="button" title="${seat_row}${seat_row_num} (${seat_kind}/${seat_rank})" class="jq-tooltip seat-condition standard common"
                                                            	style="position:absolute; left:${seat_left }px; top:${seat_top}px; width:20px;"
                                                            	seatchoigrpnm="${seat_row}${seat_row_num}" rownm="${seat_row}" seatno="${seat_row_num}">
                                                            		<span class="num">${seat_row_num}</span>
                                                            		<span class="kind">${seat_kind}</span>
                                                            		<span class="rank">${seat_rank}</span>
                                                            	</button>
															</c:forEach>
															
                                                    	</c:forEach>
                                                    
                                                   
                                                       </div>
                                                </div>
                                            </div>
                                            
                                            
                                            <div id="mCSB_1_scrollbar_vertical"
                                                class="mCSB_scrollTools mCSB_1_scrollbar mCS-light mCSB_scrollTools_vertical">
                                                <div class="mCSB_draggerContainer">
                                                    <div id="mCSB_1_dragger_vertical" class="mCSB_dragger"
                                                        style="position: absolute; min-height: 30px; display: none; height: 439px; top: 0px; max-height: 382px;">
                                                        <div class="mCSB_dragger_bar" style="line-height: 30px;"></div>
                                                    </div>
                                                    <div class="mCSB_draggerRail"></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="zone-legend" style="display: none"></div>
                            </div>
                        </div>
                        <div class="seat-result">
                     <div class="wrap">
                        <div class="tit-area" style="padding : 0 display: block; position: relative; float: left;">
                           <span class="movie-graseat-resultde age-all age-12" style="display: block; text-align: left;">${age } 관람가</span>
                           <p class="tit" style="text-align:left;">${title }</p>
                           <p class="cate" style="text-align:left;">${category }</p>
                        </div>
                        <div class="info-area" style="clear: both;">
                           <p class="theater" style="text-align:left;">${cinema }</p>
                           <p class="special" style="text-align:left;">${theater }</p>
                           <p class="date" style="text-align:left;">
                           
                              <span>${date }</span><em></em>
                           </p>
                           <div class="other-time">
                              <button type="button" class="now">
                                 ${start }~${finish }<i class="arr"></i>
                              </button>
                           </div>
                           <p class="poster">
                              <img src="${movieIMG }" onerror="noImg(this);" alt="이미지 없음">
                           </p>
                        </div>
                        <div class="choice-seat-area">
                           <div class="legend">
                              <ul class="list" style="text-align:left;">
                                 <li>
                                    <div class="seat-condition choice" title="선택한 좌석"></div> <em>선택</em>
                                 </li>
                                 <li>
                                    <div class="seat-condition finish" title="예매 완료"></div> <em>예매완료</em>
                                 </li>
                                 <li>
                                    <div class="seat-condition impossible" title="선택 불가"></div>
                                    <em>선택불가</em>
                                 </li>
                                 <li>
                                    <div class="seat-condition common" title="일반"></div> <em>
                                       일반</em>
                                 </li>
                                 <!-- <li>
                                    <div class="seat-condition disabled" title="장애인석"></div> <em>
                                       장애인석</em>
                                 </li> -->
                              </ul>
                           </div>
                           <div class="seat-num">
                              <p class="tit">선택좌석</p>
                              <div class="my-seat">
                                 <div class="seat all" title="선택한 좌석">-</div>
                                 <div class="seat all" title="구매가능 좌석">-</div>
                                 <div class="seat all" title="구매가능 좌석">-</div>
                                 <div class="seat all" title="구매가능 좌석">-</div>
                                 <div class="seat all" title="구매가능 좌석">-</div>
                                 <div class="seat all" title="구매가능 좌석">-</div>
                                 <div class="seat all" title="구매가능 좌석">-</div>
                                 <div class="seat all" title="구매가능 좌석">-</div>
                              </div>
                           </div>
                        </div>
                        <div class="pay-area">
                           <p class="count">
                              <span> <em></em>
                              </span>
                           </p>
                           <div class="pay">
                              <p class="tit">최종결제금액</p>
                              <div class="money">
                                 <em>0</em> <span>원</span>
                              </div>
                           </div>
                        </div>
                        <div class="btn-group">
                           <a href="javaScript:void(0)" class="button" id="pagePrevious"
                              title="이전">이전</a> <a href="javaScript:void(0)"
                              class="button active" id="pageNext" title="다음">다음</a>
                        </div>
                     </div>
                  </div>
               </div>
            </div>
         </div>

         <!-- 초기화 알람창 팝업-->
         <section class="alert-popup"
            style="display: none; position: fixed; background: rgb(255, 255, 255); z-index: 5006; top: 289px; left: 405px; width: 400px; opacity: 1;"
            id="layerId_030983947233653875">
            <div class="wrap">
               <header class="layer-header">
                  <h3 class="tit">알림</h3>
               </header>
               <div class="layer-con" style="height: 200px;">
                  <p class="txt-common">선택하신 좌석을 모두 취소하고 다시 선택하시겠습니까?</p>
                  <div class="btn-group">
                     <button type="button" class="button lyclose">취소</button>
                     <button type="button" class="button purple confirm">확인</button>
                  </div>
               </div>
               <button type="button" class="btn-layer-close">레이어 닫기</button>
            </div>
         </section>


         <!--인원초과 알람창 팝업-->
         <section class="alert-popup"
            style="display: none; position: fixed; background: rgb(255, 255, 255); z-index: 5006; top: 289px; left: 400px; width: 300px; opacity: 1;"
            id="layerId_08010659137218192">
            <div class="wrap">
               <header class="layer-header">
                  <h3 class="tit">알림</h3>
               </header>
               <div class="layer-con" style="height: 200px;">
                  <p class="txt-common">좌석 선택이 완료되었습니다.</p>
                  <div class="btn-group-a btn-group">
                     <button type="button" class="button purple confirm" style="width: 250px;">확인</button>
                  </div>
               </div>
            </div>

         </section>
         <div class="normalStyle"
            style="display: none; position: fixed; top: 0; left: 0; background: #000; opacity: 0.7; text-indent: -9999px; width: 100%; height: 100%; z-index: 100;">
            닫기</div>
         <div class="alertStyle"
            style="display: none; position: fixed; top: 0px; left: 0px; background: #000; opacity: 0.7; width: 100%; height: 100%; z-index: 5005;">
         </div>
      </div>
   </div>
</body>

    <footer include-html="footer.jsp"></footer>
	<script>
		includeHTML();
	</script>

</html>