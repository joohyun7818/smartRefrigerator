package member;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/delete.do")
public class DeleteController extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String pwConfirm = request.getParameter("delConfirm");
		String userPassword = (String)session.getAttribute("userPassword");
		if(userPassword.equals(pwConfirm)) {
			String delUserEmail = (String)session.getAttribute("userEmail");
			MemberDAO mDao = new MemberDAO();
			int delResult = mDao.userDelete(delUserEmail);
			if(delResult > 0) {
				session.invalidate();
				response.sendRedirect("delComplete.jsp");
			}else {
				session.setAttribute("delResult", 1);
				response.sendRedirect("myPage.jsp");
			}
		}else {
			session.setAttribute("delResult", 0);
			response.sendRedirect("myPage.jsp");
		}
	}

}
