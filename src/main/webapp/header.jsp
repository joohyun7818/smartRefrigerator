<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Header</title>
    <link rel="stylesheet" href="css/header.css">
    
    <script>
   
       function toggleMenu() {
           var menuBar = document.getElementById("menu-bar");
        
         
           if (menuBar.classList.contains("active")) {
               menuBar.classList.remove("active"); 
           } else {
               menuBar.classList.add("active"); 
           }
       }
    </script>
</head>
<header>
   <div class="header-left">

       <img src="images/menu.png" alt="메뉴" class="menu-button" onclick="toggleMenu()"
           width="40px" height="80px">
    
        <a href="/WebProj/main.jsp">
            <img src="images/home_icon.png" alt="홈 아이콘">
        </a>
    </div>

  
    <div class="header-right">
        <div class="dropdown">
            <img src="images/profile_icon.png" alt="프로필 아이콘">
            <div class="dropdown-content">
                <% 
                String userEmail = (String) session.getAttribute("userEmail");
                if (userEmail != null) {
            %>
            
                <a href="/WebProj/myPage.jsp">마이페이지</a>
                <%
                    String userRole = (String) session.getAttribute("userRole");
                    if (userRole != null && userRole.equals("관리자")) {
                %>
                    <a href="/WebProj/managerPage.jsp">관리자페이지</a>
                <%
                    }
                %>
                <a href="/WebProj/logout.do">로그아웃</a>
            <%
                } else {
            %>
             
                <a href="/WebProj/login.jsp">로그인</a>
            <%
                }
            %>
            </div>
        </div>
    </div>
    
    
     <div id="menu-bar" class="menu-bar">
         <ul><br>
         	<li>
	         	<form action="/WebProj/myFride.do" method="get">
				  	<button type="submit">냉장고 관리</button>
				</form>
			</li>
            <li>
            	<form action="/WebProj/recipeRank.do" method="get">
				  	<button type="submit">레시피</button>
				</form>
            </li>

         </ul>
     </div>
</header>

</html>

