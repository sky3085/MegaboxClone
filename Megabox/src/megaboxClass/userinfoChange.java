package megaboxClass;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class userinfoChange
 */
@WebServlet("/userinfoChange")
public class userinfoChange extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public userinfoChange() {
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
		doGet(request, response);
		
		MemberDTO memberDTO = new MemberDTO();
		HttpSession session = request.getSession(true);
		
		String userid = (String)session.getAttribute("loginid");
		
		memberDTO.setUsername(request.getParameter("username"));
		memberDTO.setSsn1(request.getParameter("ssn1"));
		memberDTO.setHp(request.getParameter("hp"));
		memberDTO.setUserid(request.getParameter("userid"));
		memberDTO.setUserpw(request.getParameter("userpw"));
		memberDTO.setUserpw_re(request.getParameter("userpw_re"));
		memberDTO.setEmail(request.getParameter("email"));
		
		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			String url="jdbc:mariadb://127.0.0.1:3306/project";
			String user = "root";
			String pw = "1234";
			Class.forName("org.mariadb.jdbc.Driver");
			conn = DriverManager.getConnection(url, user, pw);
			
			
			String sql = "UPDATE mega_member SET mem_id=?, mem_pw=?, mem_birth=?, mem_hp=?, mem_email=?, mem_name=? WHERE mem_id='"+userid+"';";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberDTO.getUserid());
			pstmt.setString(2, memberDTO.getUserpw());
			pstmt.setString(3, memberDTO.getSsn1());
			pstmt.setString(4, memberDTO.getHp());
			pstmt.setString(5, memberDTO.getEmail());
			pstmt.setString(6, memberDTO.getUsername());
			
			pstmt.executeUpdate();
			
						
			pstmt.close();
			conn.close();
			
			session.invalidate();
			response.sendRedirect("mainpage.jsp");
		} catch (Exception e) {
			e.printStackTrace();
			
		}
		
	}

}
