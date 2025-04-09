<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원 추가</title>
    <jsp:include page="header.jsp"></jsp:include>
<link rel="stylesheet" href="./css/userAdd.css">
</head>
<body>
    <div class="content">
        <h2>회원 추가</h2>
        <form action="/WebProj/manager.do" method="post">
            <input type="hidden" name="action" value="add">

            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" placeholder="이메일 입력" required />
            </div>

            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" placeholder="비밀번호 입력" required />
            </div>

            <div class="form-group">
                <label for="name">Name:</label>
                <input type="text" id="name" name="name" placeholder="이름 입력" required />
            </div>

            <div class="form-group">
               <label for=role>Role:</label> 
               <select id="role" name="role" required >
				<option value=일반 >일반회원
				<option value=관리자 >관리자
			  </select >
            </div>

            <button type=submit >회원등록</button >
        </form >
        
      </div>
   </body>
</html>
    