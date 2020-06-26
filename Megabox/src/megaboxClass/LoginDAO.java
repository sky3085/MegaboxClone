package megaboxClass;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/LoginDAO")
public class LoginDAO extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public LoginDAO() {
    	
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
		
		request.setCharacterEncoding("UTF-8");
		
		//세션이 없을 경우 생성
		HttpSession session = request.getSession(true);

		String userid = request.getParameter("userid");
		String userpw = request.getParameter("userpw");
		
		MemberDAO memberDAO = new MemberDAO();
		MemberDTO memberDTO = new MemberDTO();
		memberDTO.setUserid(userid);
		memberDTO.setUserpw(userpw);
		
		boolean result = memberDAO.selectMember(memberDTO);
		PrintWriter out = response.getWriter();
		
		if(result){
			session.setAttribute("loginid", memberDTO.getUserid());
			String msg = userid + "님 환영합니다.";
			msg = URLEncoder.encode(msg, "UTF-8");
			out.print(msg);
		}
		else {
			String msg = "아이디 또는 비밀번호를 확인해 주세요!";
			msg = URLEncoder.encode(msg, "UTF-8");
			out.print(msg);
		}
	}

}
