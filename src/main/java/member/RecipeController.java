package member;

import java.io.IOException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/recipeList.do")
public class RecipeController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        String action = request.getParameter("action");
        RecipeDAO recipeDAO = new RecipeDAO();

        if ("list".equals(action)) {
      
            List<RecipeDTO> recipeList = recipeDAO.getRecipeList();
            request.setAttribute("recipes", recipeList);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/recipeList.jsp");
            dispatcher.forward(request, response);

        } else if ("delete".equals(action)) {
     
            int pid = Integer.parseInt(request.getParameter("pid"));
            recipeDAO.deleteRecipe(pid);
            response.sendRedirect("recipeList.do?action=list");

        } else if ("add".equals(action)) {
   
            RequestDispatcher dispatcher = request.getRequestDispatcher("/recipeAdd.jsp");
            dispatcher.forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String action = request.getParameter("action");

        if ("add".equals(action)) {
       
            String pName = request.getParameter("pName");
            String nation = request.getParameter("nation");
            String cal = request.getParameter("cal");
            String level = request.getParameter("level");

            RecipeDTO recipeDTO = new RecipeDTO();
            recipeDTO.setpName(pName);
            recipeDTO.setNation(nation);
            recipeDTO.setCal(cal);
            recipeDTO.setLevel(level);

            RecipeDAO recipeDAO = new RecipeDAO();
            boolean insertSuccess = recipeDAO.addRecipe(recipeDTO);

            if (insertSuccess) {
                response.sendRedirect("recipeList.do?action=list");
            } else {
                request.setAttribute("errorMessage", "레시피 추가에 실패했습니다.");
                RequestDispatcher dispatcher = request.getRequestDispatcher("/recipeAdd.jsp");
                dispatcher.forward(request, response);
            }
        }
    }
}