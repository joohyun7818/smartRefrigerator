package member;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/recipeDetail.do")
public class RecipeDetailController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String pidStr = request.getParameter("pid");
        
        if (pidStr != null) {
            try {
                int pid = Integer.parseInt(pidStr);
                RecipeDAO recipeDAO = new RecipeDAO();
                IngredientsDAO ingredientsDAO = new IngredientsDAO();
                ProcessDAO processDAO = new ProcessDAO(JDBCUtil.getConnection());

                RecipeDTO recipe = recipeDAO.getRecipeById(pid);
                List<IngredientsDTO> ingredientsList = ingredientsDAO.getIngredientsByRecipeId(pid);
                List<ProcessDTO> processList = processDAO.getProcessByRecipeId(pid);

                if (recipe != null) {
                    request.setAttribute("recipe", recipe);
                    request.setAttribute("ingredients", ingredientsList);
                    request.setAttribute("processes", processList);

                    RequestDispatcher dispatcher = request.getRequestDispatcher("recipeDetail.jsp");
                    dispatcher.forward(request, response);
                } else {
                    request.setAttribute("errorMessage", "레시피를 찾을 수 없습니다.");
                    RequestDispatcher dispatcher = request.getRequestDispatcher("error.jsp");
                    dispatcher.forward(request, response);
                }
            } catch (NumberFormatException e) {
                request.setAttribute("errorMessage", "잘못된 레시피 ID입니다.");
                RequestDispatcher dispatcher = request.getRequestDispatcher("error.jsp");
                dispatcher.forward(request, response);
            }
        } else {
            request.setAttribute("errorMessage", "레시피 ID가 누락되었습니다.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("error.jsp");
            dispatcher.forward(request, response);
        }
    }
}