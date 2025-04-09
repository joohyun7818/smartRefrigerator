<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="member.MemberDAO, member.MemberDTO" %>
<%@ page import="javax.servlet.http.HttpSession" %>
 
<%  

    String email = request.getParameter("email");
    if (email == null) {
 
        email = (String) session.getAttribute("userEmail");
    }


    MemberDAO dao = new MemberDAO();
    MemberDTO user = dao.userInfo(email);
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원 수정</title>
    <link rel="stylesheet" href="./css/editUser.css">
</head>
<body>
    <jsp:include page="header.jsp"></jsp:include> 

    <div class="wrapper">
        <div class="container">

            <form action="/WebProj/updateProfile.do" method="post">

                <h2>회원 수정</h2>

                <div class="form-group">
                    <label for="email">이메일:</label>
                    <input type="text" id="email" value="<%= user.getEmail() %>" disabled>
                    <input type="hidden" name="email" value="<%= user.getEmail() %>">
                </div>

                <div class="form-group">
    				<label for="name">이름:</label>
    				<input type="text" id="name" name="newName" value="<%= user.getName() %>" required>
				</div>

                <div class="form-group">
                    <label for="role">권한:</label>
                    <input type="text" id="role" name="role" value="<%= user.getRole() %>" disabled>
                </div>
       
                <div class="form-group">
                    <label for="newPassword">새 비밀번호:</label>
                    <input type="password" id="newPassword" name="newPassword" required>
                </div>

                <button type="submit">수정 완료</button>
            </form>

            <a href="/WebProj/managerPage.jsp" class="back-link">목록으로 돌아가기</a>
        </div>
    </div>
</body>
</html>