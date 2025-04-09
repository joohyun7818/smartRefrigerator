<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="member.RecipeDTO" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>레시피 목록</title>
    <style>
        @charset "UTF-8";
        @import url("https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css");

        * {
            box-sizing: border-box;
        }
        header {
            width: 100%;
            height: 60px;
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
            background-color: #ebecf0;
            margin: 0;
            padding-top: 70px; 
            font-family: 'Arial', sans-serif;
        }
        
        h2 {
            text-align: center;
            margin: 20px 0;
            font-size: 24px;
            color: #000;
        }
        
        .wrapper {
            width: 100%;
            min-height: calc(100vh - 70px); /* 패딩을 뺀 최소 높이 설정 */
            display: flex;
            justify-content: center;
            align-items: flex-start; 
            background-color: #ebecf0; 
            overflow: auto; 
            position: relative; 
        }
        
        .table-container {
            width: 80%;
            margin: 20px auto;
            overflow-x: auto;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            padding: 20px;
        }
        
        table {
            width: 100%;
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

        .add-btn, .action-btn {
          display:inline-block;
          margin-top:10px; 
          padding:5px 10px; 
          background-color:#000000; 
          color:white; 
          text-decoration:none; 
          border-radius:5px;
          text-align:center; 
          box-shadow:0 2px 4px rgba(0,0,0,0.1); 
      }

      .add-btn:hover, .action-btn:hover {
          background-color:#grey; /* 호버 시 색상 변경 */
      }

    </style>
</head>
<body>

<jsp:include page="header.jsp"></jsp:include>

<div class="wrapper">
    <div class="table-container">
		<a href="/WebProj/recipeAdd.jsp" class="add-btn">레시피 등록</a><br>
        <table>
            <thead>
                <tr>
                    <th>레시피 번호</th>
                    <th>레시피 이름</th>
                    <th>분류</th>
                    <th>칼로리</th>
                    <th>난이도</th>
                    <th>Update/Delete</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    List<RecipeDTO> recipes = (List<RecipeDTO>) request.getAttribute("recipes");
                    if (recipes != null && !recipes.isEmpty()) {
                        for (RecipeDTO recipe : recipes) { 
                %>
                <tr>
                    <td><%= recipe.getPid() %></td>
                    <td><%= recipe.getpName() %></td>
                    <td><%= recipe.getNation() %></td>
                    <td><%= recipe.getCal() %></td>
                    <td><%= recipe.getLevel() %></td>
                    <td><a class="action-btn" href="recipeDetail.do?pid=<%= recipe.getPid() %>">상세 정보</a>
    					<a class="action-btn" href="recipeList.do?action=delete&pid=<%= recipe.getPid() %>">삭제</a>	
                    </td>
                </tr>
                <% 
                        }
                    } else { 
                %>
                <tr>
                    <td colspan="6">레시피 정보가 없습니다.</td>
                </tr>
                <% } %>
            </tbody>
        </table>

    </div>

</div>

</body>
</html>