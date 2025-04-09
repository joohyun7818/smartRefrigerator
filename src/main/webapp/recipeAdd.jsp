<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>레시피 추가</title>
    <link rel="stylesheet" href="./css/recipeAdd.css">
</head>
<body><jsp:include page="header.jsp"></jsp:include>
<div class="wrapper">
    <div class="content">
        <h2>레시피 추가</h2>
        <form method="post" action="recipeList.do?action=add">
            <div class="form-group">
                <label for="pName">레시피 이름:</label>
                <input type="text" id="pName" name="pName" required>
            </div>

            <div class="form-group">
                <label for="nation">분류:</label>
                <input type="text" id="nation" name="nation" required>
            </div>

            <div class="form-group">
                <label for="cal">칼로리: (기본단위 : Kcal)</label>
                <input type="text" id="cal" name="cal">
            </div>

            <div class="form-group">
                <label for="level">난이도:</label>
                <input type="text" id="level" name="level">
            </div>
            <div class="form-group">
    			<label for="step">과정:</label>
    			<textarea id="step" name="step" rows="4" required></textarea>
			</div>

            <button type="submit">추가</button>
        </form>

        <% if (request.getAttribute("errorMessage") != null) { %>
            <p style="color:red;"><%= request.getAttribute("errorMessage") %></p>
        <% } %>
    </div>
    </div>
</body>
</html>