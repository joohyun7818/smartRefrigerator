package member;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/addIngredient.do")
public class AddIngredientController extends HttpServlet {
	 protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 HttpSession session = request.getSession();
		 String iName = request.getParameter("ingredient");
		 String email = (String) session.getAttribute("userEmail");
		 IngredientsDAO iDao = new IngredientsDAO();
		 boolean reslut = iDao.addIngredients(email, iName);
		 if(reslut) {
			 request.setAttribute("addIngredientResult", "success");
		 }else {
			 request.setAttribute("addIngredientResult", "fail");
		 }
		 RequestDispatcher rd = request.getRequestDispatcher("main.jsp");
		 rd.forward(request, response);
	}

}
