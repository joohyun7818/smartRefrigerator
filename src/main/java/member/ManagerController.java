package member;
import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/manager.do")
public class ManagerController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        String action = request.getParameter("action");
        MemberDAO userDAO = new MemberDAO(); 


        if ("list".equals(action)) {
        
            List<MemberDTO> userList = userDAO.getUserList();
            request.setAttribute("userList", userList);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/memberList.jsp");
            dispatcher.forward(request, response);

        }  else if ("delete".equals(action)) {
       
            String email = request.getParameter("email");
            userDAO.userDelete(email);
            response.sendRedirect("manager.do?action=list");
        }
    
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
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
		RequestDispatcher dispatcher = request.getRequestDispatcher("/managerPage.jsp");
		dispatcher.forward(request, response);
	}

}
