package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class IngredientsDAO {

    public List<IngredientsDTO> ingredientsList() {
    	List<IngredientsDTO> iList = new ArrayList<>();
    	Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
			conn = JDBCUtil.getConnection();
            String strQuery = "select * from ingredients";
            pstmt = conn.prepareStatement(strQuery);
            rs = pstmt.executeQuery();
            
            while(rs.next()) {
            	IngredientsDTO iDto = new IngredientsDTO();
            	iDto.setiName(rs.getString("iName"));
            	iDto.setIndex(rs.getString("index"));
            	iList.add(iDto);
            }
            
        } catch (Exception ex) {
            System.out.println("Exception" + ex);
        } finally {
        	JDBCUtil.close(rs, pstmt, conn);
        }
        return iList;
    }	
	
    public ArrayList<String> myIngredientsList(String email) {
    	ArrayList<String> myiList = new ArrayList<>();
    	Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
			conn = JDBCUtil.getConnection();
            String strQuery = "select iName from myFridge where email = ?";

            pstmt = conn.prepareStatement(strQuery);
            pstmt.setString(1, email);
            rs = pstmt.executeQuery();
            while(rs.next()) {
            	myiList.add(rs.getString("iName"));
            }
            
        } catch (Exception ex) {
            System.out.println("Exception" + ex);
        } finally {
        	JDBCUtil.close(rs, pstmt, conn);
        }
        return myiList;
    }	
    
    public boolean addIngredients(String email, String iName) {
    	boolean b = false;
    	Connection conn = null;
        PreparedStatement pstmt = null;
        try {
			conn = JDBCUtil.getConnection();
            String strQuery = "insert into myFridge values(?, ?)";
            pstmt = conn.prepareStatement(strQuery);
            pstmt.setString(1, email);
            pstmt.setString(2, iName);
            int result = pstmt.executeUpdate();
            if(result == 1) {
            	b = true;
            }
        } catch (Exception ex) {
            System.out.println("Exception" + ex);
        } finally {
        	JDBCUtil.close(pstmt, conn);
        }
    	return b;
    }
    public boolean deleteIngredient(String email, String iName) {
        boolean isDeleted = false;
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = JDBCUtil.getConnection();
          
            String sql = "DELETE FROM myFridge WHERE email = ? AND iName = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, email);
            pstmt.setString(2, iName);
            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                isDeleted = true;
            }
        } catch (Exception ex) {
            System.out.println("Exception: " + ex);
        } finally {
            JDBCUtil.close(pstmt, conn);
        }
        return isDeleted;
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
}