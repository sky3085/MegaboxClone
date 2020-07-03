<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
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
	SELECT mem_name, mem_birth, mem_hp, mem_email, mem_address FROM mega_member WHERE mem_id=?;  
	<sql:param value="${sessionScope.loginid}"/>
</sql:query>
<head>
<meta charset="UTF-8">
<title>라이프씨어터, 메가박스</title>
<link rel="stylesheet" href="css/userinfo_style.css?ver=2">
<link rel="stylesheet" href="css/main_js.css">
<link rel="stylesheet" href="css/other_style.css">
<link rel="stylesheet" href="css/footer.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="js/mainpage.js"></script>
<script src="js/jquery-3.4.1.min.js"></script>
<script src="js/userinfo.js"></script>
<script src="js/include.js"></script>
</head>
<body>
    <!-- //header -->
    <header include-html="header.jsp"></header>
	<div include-html="header_util.jsp"></div>

    <section id="body">
        <div class="container-userinfo">
            <div class="page-util">
            	<div class="inner-wrap">
	                <div class="location">
	                    <span><img src="image/bg-location-home.png" alt="home"> </span>
	                    <span><img src="image/bg-location-arr.png" alt="arr"></span>
	                    <a href="mypagemain.jsp" title="나의 메가박스 페이지로 이동">나의 메가박스</a>
	                    <span><img src="image/bg-location-arr.png" alt="arr"></span>
	                    <a href="userconfirm.jsp" title="비밀번호 확인 페이지로 이동">회원정보</a>
	                    <span><img src="image/bg-location-arr.png" alt="arr"></span>
	                    <a href="userconfirm.jsp" title="개인정보 수정 페이지로 이동">개인정보 수정</a>
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
	
	            <div class="modify">
	            
	            
	            <form method="post" name="loginMember" action="userinfoChange">
	                <div class="modify-notice">
	                    <h2 class="title-main">개인정보 수정</h2>
	                    <ul>
	                        <li>회원님의 정보를 정확히 입력해주세요.</li>
	                    </ul>
	                </div>
	
	                <div class="info-main">
	                    <table class="board-form">
	                        <colgroup>
	                            <col style="width:180px;">
	                            <col>
	                        </colgroup>
	                        <tbody>
	                            <tr>
	                                <th scope="row">프로필 사진</th>
	                                <td>
	                                    <div class="profile-photo">
	                                        
	                                            <input type="file" id="profileTarget" name="file" style="display: none;">
	                                        
	                                        <div class="profile-img">
	                                            <img src="image/bg-profile.png" alt="프로필 사진 샘플">
	                                        </div>
	                                       <!--  <button type="button" class="button small gray-line" id="addProfileImgBtn">이미지 등록</button> -->
	                                        <button type="button" class="button small member-out" id="memberOutBtn">회원탈퇴</button>
	                                    </div>
	                                </td>
	                            </tr>
	                            <tr>
	                                <th scope="row">아이디</th>
	                                <td><input type="text" class="loginUser" name="userid" id="userid" maxlength="12" placeholder="${sessionScope.loginid}"></td>
	                            </tr>
	                        </tbody>
	                    </table>
	                </div>
	
	                <div class="info_sub">
	                	<c:forEach var="mega_member" items="${memberDb_rs.rows }">
	                    <h3 class="title-sub">기본정보</h3>
	                        <p class="right"><em class="font-orange">* </em>필수</p>
	                   
	                    <table class="board-form">
	                        <colgroup>
	                            <col style="width:180px;">
	                            <col>
	                        </colgroup>
	                        <tbody>
	                            <tr>
	                                <th scope="row">
	                                    이름 <em class="font-orange">*</em>
	                                </th>
	                                <td>
	                                	
	                                    <span class="mbNmClass"><input type="text" class="loginUser" name="username" placeholder="${mega_member.mem_name}"></span>
	                                    
	                                    
	                                    ※ 개명으로 이름이 변경된 경우, 회원정보의 이름을 변경하실 수 있습니다.
	                                </td>
	                            </tr>
	                            <tr>
	                                <th scope="row">
	                                    생년월일 <em class="font-orange">*</em>
	                                </th>
	                                <td>
	                                    
	                                    	<input type="text" class="loginUser" name="ssn1" maxlength="6" placeholder="${mega_member.mem_birth}">
	                                    	
	                                </td>
	                            </tr>
	                            <tr>
	                                <th scope="row">
	                                    <label for="num">휴대폰</label> <em class="font-orange">*</em>
	                                </th>
	                                <td>
	                                    <div class="clearfix">
	                                    	
	                                        <input type="text" class="loginUser" name="hp" placeholder="${mega_member.mem_hp}"">
	                                        
	                                    </div>
	                                </td>
	                            </tr>
	                            <tr>
	                                <th scope="row">
	                                    <label for="email">이메일</label> <em class="font-orange">*</em>
	                                </th>
	                                <td>
	                                    <input type="text" id="email" name="email" class="loginUser input-text w500px" value="<c:forEach var="mega_member" items="${memberDb_rs.rows }"><c:out value="${mega_member.mem_email}"/></c:forEach>">
	                                </td>
	                            </tr>
	                            <tr>
	                                <th scope="row">비밀번호 <em class="font-orange">*</em></th>
	                                <td>
	                                    <input type="password" class="loginUser" name="userpw" id="userpw" maxlength="16" placeholder="  ">
	                                </td>
	                            </tr>
	                            <%-- <tr>
	                                <th scope="row">주소</th>
	                                <td>
	                                    <span>  </span>
	                                    <button type="button" class="button small gray-line change-address" id="addressChgBtn" title="우편번호 검색">우편번호 검색</button>
	                                    <c:forEach var="mega_member" items="${memberDb_rs.rows }">
	                                    <p class="reset mt10"><c:out value="${mega_member.mem_address}"/></p>
	                                    </c:forEach>
	                                </td>
	                            </tr> --%>
	                        </tbody>
	                    </table>
	                    </c:forEach>
	                </div>
	                <div class="btn-group">
	                    <a href="mypagemain.jsp" class="button large" id="cancelBtn" title="취소">취소</a>
	                    <input type="submit" class="button large purple" id="ckBtn" value="등록">
	                </div>
	                </form>
	            </div>
	            
	            <div class="modify_popup">
	                <header class="layer-header">
	                    <h3 class="tit">알림</h3>
	                    <img src="image/btn-layer-close.png" alt="닫기">
	                </header>
	                <div class="layer-con">
	                    <p class="txt-common">회원정보가 수정되었습니다.</p>
	                    <div class="btn-group">
	                        <button type="button" class="button purple confirm">확인</button>
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