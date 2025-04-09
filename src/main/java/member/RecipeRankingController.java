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

@WebServlet("/recipeRank.do")
public class RecipeRankingController extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String userEmail = (String) session.getAttribute("userEmail");
		RecipeDAO rDao = new RecipeDAO();
		List<RecipeDTO> toprList = rDao.getRecipePrecent(userEmail);
		request.setAttribute("toprList", toprList);
		RequestDispatcher rd = request.getRequestDispatcher("recipe.jsp");
		rd.forward(request, response);
	}
}
