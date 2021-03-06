package it.unisa.wlb.controller;

import java.io.IOException;
import java.util.List;

import javax.ejb.EJB;
import javax.interceptor.Interceptors;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import it.unisa.wlb.model.bean.Employee;
import it.unisa.wlb.model.dao.IEmployeeDao;
import it.unisa.wlb.utils.LoggerSingleton;

/**
 * This servlet is used to retrieve employee suggestions.
 * 
 * @author Simranjit Singh
 */
@WebServlet(name = "SearchEmployeeServlet", urlPatterns = "/SearchEmployeeServlet")
@Interceptors({ LoggerSingleton.class })
public class SearchEmployeeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @EJB
    private IEmployeeDao employeeDao;

    /**
     * Default constructor
     */
    public SearchEmployeeServlet() {
        super();
    }

    /**
     * This contructor is used during the testing to simulate the behaviour of the dao class
     * 
     * @param employeeDao
     */
    public SearchEmployeeServlet(IEmployeeDao employeeDao) {
        this.employeeDao = employeeDao;
    }

    /**
     * @param request
     *            Object that identifies an HTTP request
     * @param response
     *            Object that identifies an HTTP response
     * @pre request != null
     * @pre response != null
     * @pre request.getParameter("email")!=null
     * @post employeeEmailList.toString()!=null
     * @throws ServletException
     * @throws IOException
     */
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String employeeEmail;
        employeeEmail = (String) request.getParameter("email");
        List<Employee> list = null;

        if (employeeEmail.length() > 37) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("Il parametro email non rispetta la lunghezza");
            response.getWriter().flush();
        }

        JSONArray employeeEmailList = new JSONArray();

        if (employeeEmail != null) {

            if (employeeEmail.equals(""))
                list = employeeDao.retrieveAll();
            else
                list = employeeDao.suggestByEmail(employeeEmail);

            for (int i = 0; i < list.size(); i++) {
                JSONObject object = new JSONObject();
                object.put("email", list.get(i).getEmail());
                object.put("name", list.get(i).getName());
                object.put("surname", list.get(i).getSurname());
                employeeEmailList.put(object);
            }

            response.setContentType("application/json");
            response.getWriter().append(employeeEmailList.toString());
        }
    }

    /**
     * @param request
     *            Object that identifies an HTTP request
     * @param response
     *            Object that identifies an HTTP response
     * @pre request != null
     * @pre response != null
     * @throws ServletException
     * @throws IOException
     */
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

}
