<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="member.MemberDTO" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원 목록</title>
    <link rel="stylesheet" href="./css/memberList.css">
</head>
<body>
    <jsp:include page="header.jsp"></jsp:include>
<h2>MemberList</h2>
<div class="wrapper">

    <div class="table-container">
        <table>
            <thead>
                <tr>
                
                    <th>Email</th>
                    <th>Name</th>
                    <th>Password</th>
                    <th>Role</th>
                    <th>Update/delete</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    List<MemberDTO> userList = (List<MemberDTO>) request.getAttribute("userList");
                    if (userList != null && !userList.isEmpty()) {
                        for (MemberDTO user : userList) { 
                %>
                <tr>
                    <td><%= user.getEmail() %></td>
                    <td><%= user.getName() %></td>
                    <td><%= user.getPassword() %></td>
                    <td><%= user.getRole() %></td>
                    <td>
                    <a class="action-btn" href="/WebProj/editUser.jsp?email=<%= user.getEmail() %>">수정</a>
                    <a class="action-btn" href="/WebProj/manager.do?action=delete&email=<%= user.getEmail() %>">삭제</a>
                    </td>
                </tr>
                <% 
                        }
                    } else { 
                %>
                <tr>
                    <td colspan="4">회원 정보가 없습니다.</td>
                </tr>
                <% } %>
            </tbody>
        </table>

        
        <a href="/WebProj/userAdd.jsp" class="add-btn">회원 등록</a>
        
    </div>
</div>
</body>
</html>