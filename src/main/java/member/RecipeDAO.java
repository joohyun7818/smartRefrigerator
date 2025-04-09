package member;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import apiData.*;

public class RecipeDAO {

	public List<RecipeDTO> getRecipeList() {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs= null;
        List<RecipeDTO> recipes = new ArrayList<>();

        try {
        	conn = JDBCUtil.getConnection();
            String query = "SELECT pid,pName,nation,cal,level,image FROM rProcess";
            pstmt = conn.prepareStatement(query);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                RecipeDTO recipe = new RecipeDTO();
                recipe.setPid(rs.getInt("pid"));
                recipe.setpName(rs.getString("pName"));
                recipe.setNation(rs.getString("nation"));
                recipe.setCal(rs.getString("cal"));
                recipe.setLevel(rs.getString("level"));
                recipe.setImage(rs.getString("image"));
                recipes.add(recipe);
            }

        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            JDBCUtil.close(rs, pstmt, conn);
        }

        return recipes;
    }
	
	public boolean addRecipe(RecipeDTO recipe) {
	    Connection conn= null;
	    PreparedStatement pstmt = null;
	    boolean isInserted = false;

	    try {
	    	conn = JDBCUtil.getConnection();
	        String sql = "INSERT INTO rProcess (pName, nation, cal, level) VALUES (?, ?, ?, ?)";
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, recipe.getpName());
	        pstmt.setString(2, recipe.getNation());
	        pstmt.setString(3, recipe.getCal());
	        pstmt.setString(4, recipe.getLevel());

	        int rowsAffected = pstmt.executeUpdate();
	        if (rowsAffected > 0) {
	            isInserted = true;
	        }
	    } catch (Exception ex) {
	        ex.printStackTrace();
	    } finally {
	        JDBCUtil.close(pstmt, conn);
	    }

	    return isInserted;
	}
	public boolean deleteRecipe(int pid) {
	    Connection connection = null;
	    PreparedStatement pstmt = null;
	    boolean isDeleted = false;

	    try {
	        connection = JDBCUtil.getConnection();
	        String sql = "DELETE FROM rProcess WHERE pid = ?";
	        pstmt = connection.prepareStatement(sql);
	        pstmt.setInt(1, pid);

	        int rowsAffected = pstmt.executeUpdate();
	        if (rowsAffected > 0) {
	            isDeleted = true;
	        }
	    } catch (Exception ex) {
	        ex.printStackTrace();
	    } finally {
	        JDBCUtil.close(pstmt, connection);
	    }

	    return isDeleted;
	}
	
	public RecipeDTO getRecipeById(int pid) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        RecipeDTO recipe = null;

        try {
            conn = JDBCUtil.getConnection();
            String query = "SELECT pid, pName, nation, cal, level, image FROM rProcess WHERE pid = ?";
            pstmt = conn.prepareStatement(query);
            pstmt.setInt(1, pid);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                recipe = new RecipeDTO();
                recipe.setPid(rs.getInt("pid"));
                recipe.setpName(rs.getString("pName"));
                recipe.setNation(rs.getString("nation"));
                recipe.setCal(rs.getString("cal"));
                recipe.setLevel(rs.getString("level"));
                recipe.setImage(rs.getString("image"));
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            JDBCUtil.close(rs, pstmt, conn);
        }

        return recipe;
    }


    public List<RecipeDTO> getRecipePrecent(String email){
    	List<RecipeDTO> rList = new ArrayList<>();
    	Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
			conn = JDBCUtil.getConnection();
			String strDropView = "drop view if exists userView";
			pstmt = conn.prepareStatement(strDropView);
			pstmt.execute();
			pstmt.close();

			String strCreateView = "create view userView as select * from myFridge where email = ?";
			pstmt = conn.prepareStatement(strCreateView);
			pstmt.setString(1, email);
			pstmt.execute();
			pstmt.close();
           	
        	String strQuery2 =  "select rid, count(u.email)/nullif(count(gr.iName), 0)*100 as p, Max(rp.image) as image, Max(rp.pName) as pName " +
			        			"from rProcess as rp "  +
			        			"LEFT OUTER JOIN good_recipe as gr "  +
			        			"on rp.pid = gr.rid "  +
			        			"LEFT OUTER JOIN userView as u "  +
			        			"on gr.iName = u.iName "  +
			        			"group by gr.rid "  +
			        			"order by p desc;"; 
        	pstmt = conn.prepareStatement(strQuery2);
        	rs = pstmt.executeQuery();
        	int i = 0;
        	while(rs.next()) {
        		RecipeDTO rDto = new RecipeDTO();
        		rDto.setMyPercent(rs.getString("p"));
        		rDto.setPid(Integer.parseInt(rs.getString("rid")));
        		rDto.setImage(rs.getString("image"));
        		rDto.setpName(rs.getString("pName"));
        		System.out.println(rs.getString("p"));
        		rList.add(rDto);
        		if(i++ > 10) break; 
        	}
        } catch (Exception ex) {
            System.out.println("Exception" + ex);
        } finally {
        	JDBCUtil.close(rs, pstmt, conn);
        }
    	return rList;
    }
}
