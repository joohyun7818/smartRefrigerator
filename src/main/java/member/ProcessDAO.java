package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProcessDAO {

    private Connection conn;

    public ProcessDAO(Connection conn) {
        this.conn = conn;
    }

    public void insertRecipeProcess(ProcessDTO recipeProcess) throws SQLException {
        String sql = "INSERT INTO cooking (rpid, cookNum, step) VALUES (?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
        	stmt.setInt(1, recipeProcess.getRpid());
        	stmt.setInt(2, recipeProcess.getCookNum());
        	stmt.setString(3, recipeProcess.getStep());
        	stmt.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error inserting recipe process: " + e.getMessage());
            throw e;
        }
    }
  //재료와 레시피..
    public List<IngredientsDTO> getIngredientsByRecipeId(int recipeId) {
        List<IngredientsDTO> ingredientsList = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = JDBCUtil.getConnection();
            String query = "SELECT iName FROM ingredients WHERE recipe_id = ?";
            pstmt = conn.prepareStatement(query);
            pstmt.setInt(1, recipeId);
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                IngredientsDTO ingredient = new IngredientsDTO();
                ingredient.setiName(rs.getString("iName"));
                ingredientsList.add(ingredient);
            }
        } catch (Exception ex) {
            System.out.println("Exception: " + ex);
        } finally {
            JDBCUtil.close(rs, pstmt, conn);
        }
        return ingredientsList;
    }
    public List<ProcessDTO> getProcessByRecipeId(int recipeId) {
        List<ProcessDTO> processList = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = JDBCUtil.getConnection();
            String query = "SELECT cookNum, step FROM cooking WHERE rpid = ?";
            pstmt = conn.prepareStatement(query);
            pstmt.setInt(1, recipeId);
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                ProcessDTO process = new ProcessDTO();
                process.setCookNum(rs.getInt("cookNum"));
                process.setStep(rs.getString("step"));
                processList.add(process);
            }
        } catch (Exception ex) {
            System.out.println("Exception: " + ex);
        } finally {
            JDBCUtil.close(rs, pstmt, conn);
        }
        return processList;
    }
}