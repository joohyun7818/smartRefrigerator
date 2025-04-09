package member;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mysql.cj.Session;

@WebServlet("/updateProfile.do")
public class UpdateController extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String email = request.getParameter("email");
        String newPassword = request.getParameter("newPassword");
        String newName = request.getParameter("newName");

        MemberDAO mDao = new MemberDAO();
        int updateResult = mDao.updateProfile(email, newPassword, newName);

        HttpSession session = request.getSession();
        if(updateResult == 0) {
            session.setAttribute("updateResult", updateResult);
            response.sendRedirect("myPage.jsp");
        } else {
            session.setAttribute("userPassword", newPassword);
            session.setAttribute("userName", newName);
            response.sendRedirect("main.jsp");
        }
    }
}