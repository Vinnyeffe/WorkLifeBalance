package it.unisa.wlb.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import it.unisa.wlb.model.bean.Project;
import it.unisa.wlb.model.dao.IProjectDAO;

/**
 * Servlet implementation class ShowProjectServlet
 */
@WebServlet("/ShowProjectServlet")
public class ShowProjectServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	@EJB
	private IProjectDAO projectDao;
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ShowProjectServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session=request.getSession();
		if(session.getAttribute("userRole").equals("Admin"))
		{
			String name=request.getParameter("name");
			if(name!=null && name!="")
			{
				try
				{
					String startDateString;
					String endDateString;;
					
					Project project=projectDao.retrieveByName(name);
					//System.out.println("Fine: " + project.getEndDate());
					//System.out.println("Inizio: " + project.getStartDate());
					SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
					Calendar calendar = Calendar.getInstance();
					
					calendar.setTime(project.getStartDate());
					calendar.add(Calendar.DAY_OF_MONTH, 1);
					startDateString = formatter.format(calendar.getTime());
					//System.out.println("Str: " + startDateString);
					
					calendar.setTime(project.getEndDate());
					calendar.add(Calendar.DAY_OF_MONTH, 1);
					endDateString = formatter.format(calendar.getTime());
					
					session.setAttribute("startDate", startDateString);
					session.setAttribute("endDate", endDateString);
					session.setAttribute("oldProject",project);
					request.setAttribute("result", "ok");
					request.getRequestDispatcher("WEB-INF/Project.jsp").forward(request, response);
				}
			
				catch(Exception ex)
				{
					request.setAttribute("result", "error");
					request.removeAttribute("projectList");
					request.getRequestDispatcher("/ProjectsListPage").forward(request, response);
				}
			}
			
			else
			{
				request.setAttribute("result", "error");
				request.removeAttribute("projectList");
				request.getRequestDispatcher("/ProjectsListPage").forward(request, response);
			}
		}
		
		else
		{
			request.setAttribute("result", "error");
			request.removeAttribute("projectList");
			request.getRequestDispatcher("/ProjectsListPage").forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
