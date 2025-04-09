<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="member.*" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Top Recipe</title>
<style>
    @charset "UTF-8";
    @import url("https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css");

    * {
        box-sizing: border-box;
    }
    body {
        font-family: "Montserrat", sans-serif;
        margin: 0;
        padding: 0;
        background-color: #ebecf0;
    }
    header {
		    width: 100%;
		    height: 60px;
		    position: fixed; /* 화면 상단에 고정 */
		    top: 0;
		    left: 0;
		    display: flex;
		    justify-content: space-between;
	    	align-items: center;
		    background-color: #ebecf0; /* 헤더 배경색을 body와 동일하게 설정 */
		    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
		    z-index: 10; /* 다른 요소들보다 위에 오도록 설정 */
		}
    .wrapper {
            width: 100%;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: flex-start;
            background: #ebecf0;
            padding-top: 120px;
            overflow: auto;
            position: relative;
        }
    .container {
        border-radius: 10px;
        box-shadow: -5px -5px 10px #fff, 5px 5px 10px #babebc;
        position: absolute;
        width: 768px;
        min-height: 600px;
        overflow: hidden;
    }
    h2 {
        text-align: center;
        color: #333;
    }
    .container ul {
        list-style-type: none;
        padding-left: 0;
    }
    .container li {
        background-color: #fff;
        margin-bottom: 10px;
        padding: 15px;
        border-radius: 5px;
        box-shadow: -3px -3px 7px #fff, 3px 3px 7px #babebc;
    }
    .container a {
    text-decoration: none;
    color: #007BFF; 
    font-weight: bold;
	}

	.container li a {
    	color: #000; 
	}
</style>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
<div class="wrapper">
    <div class="container"><br>
    <h2>Top Recipe</h2><br><br>
      <ul>
		<%
		List<RecipeDTO> toprList = (List<RecipeDTO>)request.getAttribute("toprList");
		if (toprList != null) {
    		for (RecipeDTO d : toprList) {
		%>
			<li>
			<img alt="" src="<%= d.getImage()%>"></li>
    		<li><a href="recipeDetail.do?pid=<%=d.getPid()%>"><%=d.getpName()%> | 적합률 <%=d.getMyPercent() %></a></li>
		<%
    		}
		} else {
    		out.println("<li>레시피 목록을 불러올 수 없습니다.</li>");
		}
		%>
		</ul>
      <br><br>
    </div>
</div>
</body>
</html>