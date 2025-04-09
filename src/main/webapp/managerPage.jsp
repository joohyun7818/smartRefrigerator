<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>관리자 페이지</title>
   
 <style>
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
            font-family: "Montserrat", sans-serif;
            margin: 0;
            padding: 0;
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
           	width: 750px;
            min-height: 650px;
            overflow: hidden;
        }
        
        .content {
            background: #ebecf0;
            padding: 20px 50px;
        }
        .contentcontent h1 {
            font-weight: bold;
            text-align: center;
            color: #000;
            margin-bottom: 30px;
        }
        .content {
            margin: 40px 0;
        }
        .content button {
            display: block;
            width: 100%;
            padding: 15px;
            margin: 10px 0;
            border: none;
            border-radius: 10px;
            background: #eee;
            font-weight: bold;
            color: #333;
            cursor: pointer;
            box-shadow: -5px -5px 10px #fff, 5px 5px 10px #babebc;
        }
        .content button:hover {
            box-shadow: inset 2px 2px 5px #babebc, inset -2px -2px 5px #fff;
        }
        
        
        
    </style>
</head>
<body>
    <jsp:include page="header.jsp"></jsp:include>

    <div class="wrapper">
        <div class="container">
            <div class="content">
                <h2>관리자 페이지</h2><br>
      
                	<div class="options">
 
                    	<button onclick="location.href='/WebProj/manager.do?action=list'">회원 목록</button>
                    	<button onclick="location.href='/WebProj/userAdd.jsp'">회원 추가</button>
                    	<button onclick="location.href='/WebProj/recipeList.do?action=list'">레시피 관리</button>
                	</div>
               
                <button onclick="location.href='main.jsp'" value="home">홈</button>
      
           </div>
        </div>
    </div>
</body>
</html>