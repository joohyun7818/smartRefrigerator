<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="member.IngredientsDTO"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="member.IngredientsDAO" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="./css/main.css">
    <title>냉장고 요리 추천 사이트</title>
</head>
<body>
   <jsp:include page="header.jsp"></jsp:include>

 
<div class="wrapper">
     <div class="container">
 
         <div class="fridge">
           
            <div class="ingredients-container">
                <ul id="ingredient-list">
                <%
                String userEmail = (String) session.getAttribute("userEmail");
        		IngredientsDAO iDao = new IngredientsDAO();
        		ArrayList<String> myList = iDao.myIngredientsList(userEmail);
        		request.setAttribute("myiList", myList);
				if(myList != null){
					for(String ingre : myList){
					%>
					<li>
                        <%=ingre%>
                        <form action="/WebProj/deleteIngredient.do" method="post" style="display:inline;">
                            <input type="hidden" name="ingredient" value="<%=ingre%>">
                            <input type="hidden" name="email" value="<%=userEmail%>">
                            <button type="submit">삭제</button>
                        </form>
                	</li>
                    <% 
                        }
                    }
                    %>
                </ul>
            </div>
         </div>

      <div class="search-bar" style="margin-top:20px;">
         <%@ include file="searchBar.jsp" %>
     </div>
	</div>
</div>
<!-- 
<script>
function addIngredient() {
    const input = document.getElementById('autocomplete');
    const list = document.getElementById('ingredient-list');
    
    if (input.value.trim() !== "") {
        const li = document.createElement('li');
        li.textContent = input.value;
        
        const deleteButton = document.createElement('button');
        deleteButton.textContent = '삭제';
        deleteButton.onclick = function() {
            list.removeChild(li);
        };
        
        li.appendChild(deleteButton);
        list.appendChild(li);
        
        input.value = ""; 
    }
}

document.querySelector('.submit-btn').addEventListener('click', function(event) {
    event.preventDefault(); 
    addIngredient();
});
</script>
 -->
</body>
</html>