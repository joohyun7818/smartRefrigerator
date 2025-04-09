<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="member.IngredientsDTO"%>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>재료 검색 및 추가</title>
<style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: Arial, sans-serif;
      background-color: #f4f4f9;
      padding: 20px;
    }

    .message {
      margin-bottom: 20px; /* 메시지 아래 여백 추가 */
      font-size: 18px; /* 메시지 글자 크기 */
      color: green; /* 성공 메시지 색상 */
    }

    .combobox {
      position: relative;
      width: 350px; /* 넓이를 더 넓게 설정 */
      margin-top: 20px; /* 상단 여백 추가 */
      margin-bottom: 20px; /* 하단 여백 추가 */
    }

    .combobox .group {
      display: flex;
      align-items: center;
      border-radius: 5px; /* 모서리 둥글게 */
      overflow: hidden; /* 내부 요소가 밖으로 나가지 않도록 */
      box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* 그림자 효과 추가 */
    }

    .combobox input,
    .combobox button {
      background-color: white;
      color: black;
      height: 50px; /* 높이를 더 높게 설정 */
      border: none; /* 테두리 제거 */
      padding: 10px; /* 패딩 증가 */
    }

    .combobox input {
      width: calc(100% - 50px); /* 버튼 크기만큼 너비 조정 */
    }

    .combobox button {
      width: 50px;
      cursor: pointer;
      background-color: black; /* 화살표 버튼 배경색을 검정으로 변경 */
      color: white; /* 화살표 버튼 글자색 변경 */
    }

    ul[role="listbox"] {
      display: none; 
      position: absolute;
      left: 0;
      top: 55px; /* 목록이 입력창 바로 아래에 위치하도록 */
      width: 100%; 
      max-height: 250px;
      overflow-y: auto;
      list-style: none;
      background-color: white;
      border-radius: 5px; /* 모서리 둥글게 */
      border: 1px solid #ddd; 
      box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1); /* 그림자 효과 추가 */
      z-index: 10;
    }

    ul[role="listbox"] li[role="option"] {
      padding: 10px; /* 패딩 증가 */
      cursor: pointer;
    }

    ul[role="listbox"] li[role="option"]:hover,
    ul[role="listbox"] li[role="option"].selected {
      background-color: #e1e1e1;
    }

    .combobox input:focus {
      outline: none;
    }

    .combobox button[aria-expanded="true"] {
      transform: rotate(180deg);
    }
    
    .submit-btn {
        display: block;
        margin-left: auto; 
        margin-top: 20px;
        padding: 10px 20px;
        background-color: black; 
        color: white; 
        border-radius: 5px;
        border: none;
        cursor: pointer;
        font-size: 16px; 
        text-align:center; 
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); 
    }
    
    .submit-btn:hover {
        background-color:#333333; 
    }
</style>
</head>
<body>
<%
 String inresult = (String) request.getAttribute("addIngredientResult");
 if(inresult != null){
     if(inresult.equals("success")){
 %>
     <p class="message">재료 넣기 성공!</p>
 <% 
     } else { 
 %>
     <p class="message" style="color:red;">재료 넣기 실패!</p>
 <% 
     }
 } 
%>
	<form action="/WebProj/addIngredient.do" method="get">
	    <div class="combobox">
		      <div class="group">
			        <input type="text" id="autocomplete" name="ingredient" placeholder="검색" aria-controls="listbox" aria-expanded="false" autocomplete="off">
			        <button type="button" aria-expanded="false" aria-label="Toggle listbox">&#9660;</button>
		      </div>
		      <ul role="listbox" id="listbox">
		         <%
		         List<IngredientsDTO> iList = (List<IngredientsDTO>) session.getAttribute("iList");
		         if (iList != null && !iList.isEmpty()) {
		             for (IngredientsDTO i : iList) { 
			     %> 
			    		<li id=<%=i.getIndex()%> role="option"><%= i.getiName() %></li>
			     <% 
			     	} 
			     }%>
		      </ul>
	    </div>
	    <button type="submit" class="submit-btn">제출</button> 
	</form>
    <script>
	    document.addEventListener("DOMContentLoaded", function () {
	      const combobox = document.querySelector(".combobox");
	      const input = combobox.querySelector("input");
	      const button = combobox.querySelector("button");
	      const listbox = combobox.querySelector("ul[role='listbox']");
	      
	      function updateOptions() {
	          const options = listbox.querySelectorAll("li[role='option']");
	          options.forEach(function (option) {
	              option.style.display = "none"; 
	          });

	          const query = input.value.toLowerCase();
	          let hasMatchingOptions = false;

	          options.forEach(function (option) {
	              const text = option.textContent.toLowerCase();
	              if (text.includes(query)) {
	                  option.style.display = "block";  
	                  hasMatchingOptions = true;
	              }
	          });

	          if (hasMatchingOptions) {
	              listbox.style.display = "block";
	          } else {
	              listbox.style.display = "none";
	          }
	      }

	      input.addEventListener("input", updateOptions);

	      button.addEventListener("click", function () {
	        const expanded = button.getAttribute("aria-expanded") === "true";
	        button.setAttribute("aria-expanded", !expanded);
	        listbox.style.display = expanded ? "none" : "block";  
	      });
	
	      const options = listbox.querySelectorAll("li[role='option']");
	      options.forEach(function (option) {
	        option.addEventListener("click", function () {
	          input.value = option.textContent;
	          listbox.style.display = "none";  
	        });
	      });

	      updateOptions();
	    });
	</script>
</body>
</html>