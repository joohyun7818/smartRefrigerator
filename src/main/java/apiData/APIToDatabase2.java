package apiData;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;

public class APIToDatabase2 {
    public static void main(String[] args) {
    	int start = 0, end = 0;
        for (start=1; start<=6200; start += 100) {
        	end = start + 99;
	        String apiUrl = "http://211.237.50.150:7080/openapi/ceeb44594d730a64c66ee29df505351cc998fc623e95511472cad313381bdc56/xml/Grid_20150827000000000226_1/"
	        		+ Integer.toString(start) +  "/" + Integer.toString(end); // API URL
	        try {
	            // 1. API 호출
	            URL url = new URL(apiUrl);
	            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
	            connection.setRequestMethod("GET");
	            connection.setRequestProperty("Accept", "application/xml");
	
	            int responseCode = connection.getResponseCode();
	            if (responseCode != 200) {
	                throw new RuntimeException("API 응답 오류: " + responseCode);
	            }
	
	            // 2. 응답 데이터 읽기
	            BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
	            StringBuilder response = new StringBuilder();
	            String inputLine;
	
	            while ((inputLine = in.readLine()) != null) {
	                response.append(inputLine);
	            }
	            in.close();
	            connection.disconnect();
	
	            // 3. XML 파싱
	            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
	            DocumentBuilder builder = factory.newDocumentBuilder();
	            Document document = builder.parse(new java.io.ByteArrayInputStream(response.toString().getBytes("UTF-8")));
	
	            // 4. XML 데이터를 NodeList로 가져오기
	            NodeList rows = document.getElementsByTagName("row");
	
	            // 5. 데이터베이스 연결
	            Connection dbConnection = DatabaseConnect.getConnection();
	            String sql = "INSERT INTO rProcess (pid, pName, nation, cal, level) VALUES (?, ?, ?, ?, ?)";
	            PreparedStatement statement = dbConnection.prepareStatement(sql);
	
	            // 6. 각 row 노드 처리
	            for (int i = 0; i < rows.getLength(); i++) {
	                Element row = (Element) rows.item(i);
	
	                int pid = Integer.parseInt(row.getElementsByTagName("RECIPE_ID").item(0).getTextContent());
	                String pName = row.getElementsByTagName("RECIPE_NM_KO").item(0).getTextContent();
	                String nation = row.getElementsByTagName("NATION_NM").item(0).getTextContent();
	                String cal = row.getElementsByTagName("CALORIE").item(0).getTextContent();
	                String level = row.getElementsByTagName("LEVEL_NM").item(0).getTextContent();
	
	                // 데이터 삽입
	                statement.setInt(1, pid);
	                statement.setString(2, pName);
	                statement.setString(3, nation);
	                statement.setString(4, cal);
	                statement.setString(5, level);
	                statement.addBatch(); // 배치 추가
	            }
	
	            // 7. 배치 실행
	            statement.executeBatch();
	            System.out.println("데이터 삽입 완료!");
	
	            // 8. 리소스 정리
	            statement.close();
	            dbConnection.close();
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
        }
    }
}
