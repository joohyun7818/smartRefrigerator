<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%! String errMsg = ""; int updateResult;%>
<%
  
    if (session.getAttribute("updateResult") != null) {        
        updateResult = (int) session.getAttribute("updateResult");
        if (updateResult == 0) errMsg = "수정에 실패하였습니다";
        session.removeAttribute("updateResult");
    }
%>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Page</title>
    <link rel="stylesheet" href="./css/myPage.css"><jsp:include page="header.jsp"></jsp:include>
</head>

<body>
    <div class="wrapper">
        <div class="container">
            <form id="updateForm" method="post" action="/WebProj/updateProfile.do" onsubmit="return validateUpdate()">
    		<h2>My Page</h2>
    		<span id="updateError" class="error-message"><%= errMsg %></span>

    		<div class="form-group">
        		<label for="originalName">이름:</label>
        		<input type="text" id="newName" name="newName"> 
    		</div>

    		<div class="form-group">
        		<label for="email">이메일:</label>
        		<input type="email" id="email" name="email" value="<%= (String) session.getAttribute("userEmail") %>" readonly>
        		<input type="hidden" name="email" value="<%= (String) session.getAttribute("userEmail") %>">
    		</div>

                <div class="form-group">
                    <label for="originalPassword">비밀번호:</label>
                    <div class="password-container">
                        <input type="password" id="originalPassword" value="<%= (String) session.getAttribute("userPassword") %>" >
                        <i class="fa fa-eye toggle-password" onclick="togglePassword('originalPassword')"></i>
                    </div>
                </div>

                 <div class="form-group">
        			<label for="newPassword">비밀번호 변경:</label>
        			<input type="password" id="newPassword" name="newPassword">
    			</div>

    			<div class="form-group">
        			<label for="confirmPassword">비밀번호 확인:</label>
        			<input type="password" id="confirmPassword" name="confirmPassword">
        			<span id="passwordError" class="error-message"></span> 
    			</div>

                <div class="form-group">
                    <label for="role">권한:</label>
                    <select id="role" disabled>
                        <option value="일반" <%= "일반".equals(request.getAttribute("role")) ? "selected" : "" %>>일반회원</option>
                        <option value="관리자" <%= "관리자".equals(request.getAttribute("role")) ? "selected" : "" %>>관리자</option>
                    </select>
                </div>

                <% 
                Object result = request.getAttribute("updateResult");
                if (result != null) {
                    String message = (String) result;
                %>
                <span><%= message %></span>
                <% } %>

                <button type="submit">Update</button>
            </form>

      
            <form method="post" action="/WebProj/delete.do" onsubmit="return delCheck()">
            	<h3>회원탈퇴</h3>
            	<div class="form-group">
                    <label for="confirmPassword">비밀번호 확인:</label>
                    <input type="password" id="delConfirm" name="delConfirm">
                    <span id="delError" className.error-message"></span> 
                </div>

                <% 
                Object delResult = session.getAttribute("delResult");
                if (delResult != null) {
	                System.out.println((int)delResult);
                    String delError = "탈퇴에 실패했습니다.";
                %>
                <span> <%= delError %></span>
                <% } %>

                <button type="submit">Delete</button>
            </form>

          
            <form method="get" action="/WebProj/main.jsp">
                <button type="submit">Home</button>
            </form>
        </div>
    </div>


    <script>
        function togglePassword(fieldId) {
            const passwordField = document.getElementById(fieldId);
            const type = passwordField.type === "password" ? "text" : "password";
            passwordField.type = type;
        }

     
        function validateUpdate() {
            const newPassword = document.getElementById("newPassword").value;
            const confirmPassword = document.getElementById("confirmPassword").value;
            const pwErrorMessage = document.getElementById("passwordError");

			if (newPassword.replace(" ", "") === "") {
				pwErrorMessage.textContent = "변경할 비밀번호를 입력해주세요.";
				return false;
			}
       
            if (newPassword !== confirmPassword) {
                pwErrorMessage.textContent = "비밀번호가 일치하지 않습니다.";
                return false;
            }
          
            pwErrorMessage.textContent = "";
            return true;
        }
        
       
        function delCheck() {
        	const confirmPassword = document.getElementById("delConfirm").value;
        	const delErrorMessage = document.getElementById("delError");
        	if(confirmPassword.trim() === ""){
        		delErrorMessage.textContent = "비밀번호를 입력해 주세요.";
        		return false;
        	}
        	return true;
        }
    </script>
</body>
</html>
