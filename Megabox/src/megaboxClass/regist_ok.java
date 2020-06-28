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

/**
 * Servlet implementation class regist_ok
 */
@WebServlet("/regist_ok")
public class regist_ok extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public regist_ok() {
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
		
		MemberDTO memberDTO = new MemberDTO();
		MemberDAO memberDAO = new MemberDAO();
		
		memberDTO.setUsername(request.getParameter("username"));
		memberDTO.setSsn1(request.getParameter("ssn1"));
		memberDTO.setHp(request.getParameter("hp"));
		memberDTO.setUserid(request.getParameter("userid"));
		memberDTO.setUserpw(request.getParameter("userpw"));
		memberDTO.setUserpw_re(request.getParameter("userpw_re"));
		memberDTO.setEmail(request.getParameter("email"));
		
		boolean result = memberDAO.insertMember(memberDTO);
		
		if(result) {
			response.sendRedirect("mainpage.jsp");
		}
	}

}
