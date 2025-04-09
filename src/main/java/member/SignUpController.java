package member;
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/signup.do")
public class SignUpController extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String pw = request.getParameter("password");
		String role = request.getParameter("role");

		MemberDTO mDto = new MemberDTO();
		mDto.setName(name);
		mDto.setEmail(email);
		mDto.setPassword(pw);
		mDto.setRole(role);		
		
		int insertCheck = 0;
		MemberDAO mDao = new MemberDAO();	
		if(mDao.memberInsert(mDto)) {
			insertCheck = 2;
		}else {
			insertCheck = 3;
		}
		
    	request.setAttribute("joinResult", insertCheck);
		RequestDispatcher dispatcher = request.getRequestDispatcher("/login.jsp");
		dispatcher.forward(request, response);
	}

}
