<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 재료</title>

<style>
        @import url("https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css");

        * {
            box-sizing: border-box;
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
        body {
   	 		font-family: "Montserrat", sans-serif;
    		margin: 0;
    		padding: 0;
    		background: #ebecf0;
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
        </style>
</head>
<body><jsp:include page="header.jsp"></jsp:include>

<div class="wrapper">
<ul>
<%
ArrayList<String> myiList = (ArrayList<String>) request.getAttribute("myiList");
String email = (String) session.getAttribute("email"); 
if(myiList != null){
	for(String ingre : myiList){
		%>
		<li>

			<%=ingre%>
			<form action="/WebProj/deleteIngredient.do" method="post" style="display:inline;">
				<input type="hidden" name="ingredient" value="<%=ingre%>">
				<input type="hidden" name="email" value="<%=email%>">
				<button type="submit">삭제</button>
			</form>
		</li>
		<%
	}
}
%>
</ul>
</div>
</body>
</html>