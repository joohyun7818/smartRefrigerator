<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%!int info = 0; %>
<%!String infoStr = null; %>
<html lang="en">
<head>
<link rel="stylesheet" href="./css/login.css">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<jsp:include page="header.jsp"></jsp:include>
<body>
    <div class="wrapper">
        <div class="container">
          <div class="sign-up-container">
            <form method="post" action="/WebProj/signup.do">
              <h1>Sign Up</h1>
              <input type="text" placeholder="Name" name="name">
              <input type="email" placeholder="Email" name="email">
              <input type="password" placeholder="Password" name="password">
              <select name=role>
				<option value="일반">일반회원
				<option value="관리자">관리자
			  </select>
              <button class="form_btn">Sign Up</button>
            </form>
          </div>
          <div class="sign-in-container">
            <form method="post" action="/WebProj/login.do">
              <h1>Sign In</h1>
              <%
              Object jr = request.getAttribute("joinResult");
              if(jr == null){
            	  info = 1;
              }else{            	  
              	  info = (int)jr; 
              }
              switch (info){
              case 1:
            	  infoStr = "반가워요";
				  break;            	  
              case 2:
				  infoStr = "회원가입 성공";
            	  break;
              case 3:
            	  infoStr = "회원가입 실패";
            	  break;
              default:
            	  infoStr = "오류";
              }
              jr = request.getAttribute("loginResult");
              if (jr != null){
            	  infoStr = "로그인 실패";
              }
              %>
              <span><%=infoStr %></span>
              <input type="email" placeholder="Email" name="email">
              <input type="password" placeholder="Password" name="password">
              <button class="form_btn">Sign In</button>
            </form>
          </div>
          <div class="overlay-container">
            <div class="overlay-left">
                <h1>반가워요!</h1>
                <p>로그인은 여기로</p>
                <button id="signIn" class="overlay_btn">Sign In</button>
            </div>
            <div class="overlay-right">
                <h1>회원이 아니신가요?</h1>
                <p>냉장고 관리 및 레시피를 추천받으세요</p>
              <button id="signUp" class="overlay_btn">Sign Up</button>
            </div>
          </div>
        </div>
      </div>
    <script>
        const signUpBtn = document.getElementById("signUp");
        const signInBtn = document.getElementById("signIn");
        const container = document.querySelector(".container");

        signUpBtn.addEventListener("click", () => {
        container.classList.add("right-panel-active");
        });
        signInBtn.addEventListener("click", () => {
        container.classList.remove("right-panel-active");
        });
    </script>
</body>
</html>