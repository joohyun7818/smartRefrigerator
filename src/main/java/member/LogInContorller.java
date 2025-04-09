package member;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/login.do")
public class LogInContorller extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		
		MemberDAO mDao = new MemberDAO();
		boolean loginUser = mDao.loginCheck(email, password);

		if (loginUser) {
            HttpSession session = request.getSession();
            session.setAttribute("userEmail", email);
            MemberDTO user = mDao.userInfo(email);

            session.setAttribute("userName", user.getName());
            session.setAttribute("userPassword", user.getPassword());
            session.setAttribute("userRole", user.getRole());
            
            IngredientsDAO iDao = new IngredientsDAO();
            List<IngredientsDTO> iList = iDao.ingredientsList();
            session.setAttribute("iList", iList);
            
            // 역할에 따라 페이지 이동
            String userRole = user.getRole();
            if ("관리자".equals(userRole)) {
                response.sendRedirect("managerPage.jsp");
            } else {
                response.sendRedirect("main.jsp");
            }
        } else {
            request.setAttribute("loginResult", loginUser);
            RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
            dispatcher.forward(request, response);
        }
	}

}
