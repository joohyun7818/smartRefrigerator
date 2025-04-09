package member;

import java.io.IOException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/topRecipes.do")
public class TopRecipesController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        RecipeDAO recipeDAO = new RecipeDAO();
        List<RecipeDTO> toprList = recipeDAO.getRecipeList(); 

        if (toprList != null) {
            request.setAttribute("toprList", toprList);
            RequestDispatcher dispatcher = request.getRequestDispatcher("topRecipes.jsp");
            dispatcher.forward(request, response);
        } else {
            request.setAttribute("errorMessage", "레시피 목록을 불러올 수 없습니다.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("error.jsp");
            dispatcher.forward(request, response);
        }
    }
}