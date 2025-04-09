package member;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class MemberDAO {

    public boolean loginCheck(String email, String password) {
    	Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        boolean loginCon = false;
        try {
			conn = JDBCUtil.getConnection();
            String strQuery = "select email, password from users where email = ? and password = ?";

            pstmt = conn.prepareStatement(strQuery);
            pstmt.setString(1, email);
            pstmt.setString(2, password);
            rs = pstmt.executeQuery();
            loginCon = rs.next();
        } catch (Exception ex) {
            System.out.println("Exception" + ex);
        } finally {
        	JDBCUtil.close(rs, pstmt, conn);
        }
        return loginCon;
    }	
    
	
	
    public boolean memberInsert(MemberDTO mDTO) {
    	Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        boolean flag = false;
        try {
        	conn = JDBCUtil.getConnection();
            String strQuery = "insert into users values(?,?,?,?)";
            pstmt = conn.prepareStatement(strQuery);
            pstmt.setString(1, mDTO.getEmail());
            pstmt.setString(2, mDTO.getPassword());
            pstmt.setString(3, mDTO.getName());
            pstmt.setString(4, mDTO.getRole());

            int count = pstmt.executeUpdate();

            if (count == 1) {
                flag = true;
            }

        } catch (Exception ex) {
            System.out.println("Exception" + ex);
            ex.printStackTrace();
        } finally {
        	JDBCUtil.close(rs, pstmt, conn);
        }
        return flag;
    }		
    
    public MemberDTO userInfo(String userEmail) {
    	Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        MemberDTO info = new MemberDTO();
        try {
        	conn = JDBCUtil.getConnection();
            String strQuery = "select * from users where email = ?";
            pstmt = conn.prepareStatement(strQuery);
            pstmt.setString(1, userEmail);
            rs = pstmt.executeQuery();
            rs.next();
            info.setEmail(userEmail);
            info.setName(rs.getString("name"));
            info.setPassword(rs.getString("password"));
            info.setRole(rs.getString("role"));
        } catch (Exception ex) {
            System.out.println("Exception" + ex);
            ex.printStackTrace();
        } finally {
        	JDBCUtil.close(rs, pstmt, conn);
        }
        return info;
    }
    
    public int pwUpdate(String email, String password) {
    	int result = 0;
    	Connection conn = null;
        PreparedStatement pstmt = null;
        try {
			conn = JDBCUtil.getConnection();
            String strQuery = "update users set password = ? where email = ?";

            pstmt = conn.prepareStatement(strQuery);
            pstmt.setString(1, password);
            pstmt.setString(2, email);
            result = pstmt.executeUpdate();
        } catch (Exception ex) {
            System.out.println("Exception" + ex);
        } finally {
        	JDBCUtil.close(pstmt, conn);
        }
    	
    	return result;
    }
    public int updateProfile(String email, String newPassword, String newName) {
        int result = 0;
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = JDBCUtil.getConnection();
            String strQuery = "UPDATE users SET password = ?, name = ? WHERE email = ?";
            
            pstmt = conn.prepareStatement(strQuery);
            pstmt.setString(1, newPassword);
            pstmt.setString(2, newName);
            pstmt.setString(3, email);
            result = pstmt.executeUpdate();
        } catch (Exception ex) {
            System.out.println("Exception" + ex);
        } finally {
            JDBCUtil.close(pstmt, conn);
        }
        
        return result;
    }
    
    public int userDelete(String email) {
    	int result = 0;
    	Connection conn = null;
        PreparedStatement pstmt = null;
        try {
			conn = JDBCUtil.getConnection();
            String strQuery = "delete from users where email = ?";

            pstmt = conn.prepareStatement(strQuery);
            pstmt.setString(1, email);
            result = pstmt.executeUpdate();
        } catch (Exception ex) {
            System.out.println("Exception" + ex);
        } finally {
        	JDBCUtil.close(pstmt, conn);
        }
    	
    	return result;
    }
    
    public List<MemberDTO> getUserList() {
        List<MemberDTO> userList = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = JDBCUtil.getConnection();
            String query = "SELECT email, password, name, role FROM users";
            pstmt = conn.prepareStatement(query);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                MemberDTO user = new MemberDTO();
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setName(rs.getString("name"));
                user.setRole(rs.getString("role"));
                userList.add(user);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCUtil.close(rs, pstmt, conn);
        }
        return userList;
    }
}
