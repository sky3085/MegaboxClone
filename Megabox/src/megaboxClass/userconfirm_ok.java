package megaboxClass;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class userconfirm_ok
 */
@WebServlet("/userconfirm_ok")
public class userconfirm_ok extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public userconfirm_ok() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
		HttpSession session = request.getSession(true);
		
		String userid = (String)session.getAttribute("loginid");
		String userpw = request.getParameter("pwd");
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		
		try {

			String url = "jdbc:mariadb://127.0.0.1:3306/project";
			String user = "root";
			String pw = "1234";
			Class.forName("org.mariadb.jdbc.Driver");
			conn = DriverManager.getConnection(url, user, pw);
			
			String sql = "SELECT mem_idx FROM mega_member WHERE mem_id=? AND mem_pw=?";
			
			if(conn != null){
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, userid);
				pstmt.setString(2, userpw);
				rs = pstmt.executeQuery();
				
				if(rs.next()){
					response.sendRedirect("userinfo.jsp");
				}else {
					response.sendRedirect("userconfirm.jsp");
				}
				
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
	}

}
