package megaboxClass;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

@WebServlet("/PwFindDAO")
public class PwFindDAO extends HttpServlet {
	  @SuppressWarnings("unchecked")
	  protected void  doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		  System.out.println("ㅎ2");
	  }
		protected void  doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
			// TODO Auto-generated method stub
			request.setCharacterEncoding("UTF-8");
			response.setContentType("text/html;charset=UTF-8");
			String mem_name=request.getParameter("mem_name");
			String mem_id=request.getParameter("mem_id");
			String mem_pw="";
			JSONObject data= new JSONObject();
			boolean SearchStatus=false;
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			
			try {
			
				String url="jdbc:mariadb://127.0.0.1:3306/project";
				String user = "root";
				String pw = "1234";
				Class.forName("org.mariadb.jdbc.Driver");
				conn = DriverManager.getConnection(url, user, pw);
				System.out.println("db connect");
				
				//작성한 데이터 insert
				String sql = "select * from mega_member WHERE(mem_name=? and mem_id=?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1,mem_name); pstmt.setString(2, mem_id); 
				rs = pstmt.executeQuery();
				if(rs.next()) {
					mem_pw=rs.getString("mem_pw");
					SearchStatus=true;
				}
		        
			}catch(Exception e) {
				e.printStackTrace();
			}
			data.put("SearchStatus",SearchStatus);
			data.put("mem_pw", mem_pw);
			String object = data.toJSONString();
			PrintWriter out = response.getWriter();
			out.print(object);
		}

}
