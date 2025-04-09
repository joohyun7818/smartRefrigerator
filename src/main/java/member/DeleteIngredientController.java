package member;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/deleteIngredient.do")
public class DeleteIngredientController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	request.setCharacterEncoding("UTF-8");
        String email = request.getParameter("email");
        String ingredient = request.getParameter("ingredient");
        System.out.println(email + ingredient);

        IngredientsDAO dao = new IngredientsDAO();
        boolean success = dao.deleteIngredient(email, ingredient);

        if (success) {
            request.setAttribute("message", "재료 삭제 성공!");
            System.out.println("O");
        } else {
            request.setAttribute("message", "재료 삭제 실패!");
            System.out.println("x");
        }
        RequestDispatcher rd = request.getRequestDispatcher("main.jsp");
		rd.forward(request, response);
    }
}