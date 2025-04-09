<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="member.*" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>레시피 상세 정보</title>
    <style>
        @charset "UTF-8";
        @import url("https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css");

        * {
            box-sizing: border-box;
        }
        header {
            width: 100%;
            height: 50px;
            position: fixed;
            top: 0;
            left: 0;
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #ebecf0; 
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            z-index: 10; 
        }
        
        body {
            font-family: "Montserrat", sans-serif;
            margin: 0;
            padding: 0;
            background-color: #ebecf0;
            color: #333;
        }
        h2 {
            padding-top: 100px; 
            text-align: center;
            margin: 20px 0;
            font-size: 24px;
            color: #000;
        }
        .wrapper {
            width: 100%;
            min-height: 100vh; 
            display: flex;
            justify-content: center;
            align-items: flex-start; 
            background-color: #ebecf0; 
            overflow: auto; 
            position: relative; 
        }
        
        .table-container {
            width: 80%;
            margin: 0 auto;
            overflow-x: auto;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            padding: 20px;
        }

        .content-flex {
            display: flex; /* 플렉스 박스 사용 */
            justify-content: center; /* 가운데 정렬 */
        }

        .content-flex img {
            max-width: 300px; /* 이미지 크기 조정 */
            margin-right: 70px; /* 이미지와 테이블 사이의 간격 */
        }

        table {
            width: auto; /* 테이블 너비 자동 조정 */
            border-collapse: collapse; 
        }
        
        th, td {
            padding: 12px 15px;
            text-align: center;
        }
        
        th {
            text-transform: uppercase;
            font-weight: bold;
        }

        a {
            color: #000;
            text-decoration: none;
            font-weight: bold;
        }

        a:hover {
            color: #555;
        }
    </style>
</head>
<body>

<jsp:include page="header.jsp"></jsp:include>

<div class="wrapper">
    <div class="table-container">
<%
    RecipeDTO recipe = (RecipeDTO) request.getAttribute("recipe");
    List<IngredientsDTO> ingredients = (List<IngredientsDTO>) request.getAttribute("ingredients");
    List<ProcessDTO> processes = (List<ProcessDTO>) request.getAttribute("processes");

    if (recipe != null) {
%>
    <h2>레시피 상세 정보</h2><br><br>
    <div class="content-flex">
      <img alt="" src="<%= recipe.getImage() %>">
      
      <table>
          <tr><th>이름</th><td><%= recipe.getpName() %></td></tr>
          <tr><th>분류</th><td><%= recipe.getNation() %></td></tr>
          <tr><th>칼로리</th><td><%= recipe.getCal() %></td></tr>
          <tr><th>난이도</th><td><%= recipe.getLevel() %></td></tr>
      </table>
    </div>

<br><br><br>

    <h3>재료</h3>
<table>
  <% if (ingredients != null && !ingredients.isEmpty()) { %>
    <% for (IngredientsDTO ingredient : ingredients) { %>
        <tr><td><%= ingredient.getiName() %></td></tr>
    <% } %>
  <% } else { %>
    <tr><td>재료 정보를 불러올 수 없습니다.</td></tr>
  <% } %>
</table>

<h3>과정</h3>
<table>
  <% if (processes != null && !processes.isEmpty()) { %>
    <% for (ProcessDTO process : processes) { %>
        <tr><th><%= process.getCookNum() %>.</th><td><%= process.getStep() %></td></tr>
    <% } %>
  <% } else { %>
    <tr><td>과정 정보를 불러올 수 없습니다.</td></tr>
  <% } %>
</table>

<br><br><br>

    <h3>과정</h3>
<table>
  <% if (processes != null) { %>
    <% for (ProcessDTO process : processes) { %>
        <tr><th><%= process.getCookNum() %>.</th><td><%= process.getStep() %></td></tr>
    <% } %>
  <% } else { %>
    <tr><td>과정 정보를 불러올 수 없습니다.</td></tr>
  <% } %>
</table>

<%
    } else {
%>
    <li>레시피 목록을 불러올 수 없습니다.</li>
<%
    }
%>

    </div>
</div>

</body>
</html>