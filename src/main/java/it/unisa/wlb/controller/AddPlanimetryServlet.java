package it.unisa.wlb.controller;

import java.io.IOException;

import javax.ejb.EJB;
import javax.interceptor.Interceptors;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import it.unisa.wlb.model.bean.Admin;
import it.unisa.wlb.model.bean.Floor;
import it.unisa.wlb.model.bean.Room;
import it.unisa.wlb.model.bean.RoomPK;
import it.unisa.wlb.model.bean.Workstation;
import it.unisa.wlb.model.bean.WorkstationPK;
import it.unisa.wlb.model.dao.IWorkstationDao;
import it.unisa.wlb.utils.LoggerSingleton;

/**
 * The aim of this Servlet is to insert the planimetry into the database
 * 
 * @author Sabato Nocera, Michele Montano
 *
 */
@WebServlet(name = "AddPlanimetryServlet", urlPatterns = "/AddPlanimetryServlet")
@Interceptors({ LoggerSingleton.class })
public class AddPlanimetryServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final static String JSON_STRING = "jsonObject";
    private final static String FLOOR = "floor";
    private final static String ROOM = "room";
    private final static String WORKSTATIONS = "workstation";
    private final static int MAX_FLOOR = 200;
    private final static int MAX_ROOM = 20;
    private final static int MAX_WORKSTATIONS = 100;
    private final static int MIN = 1;

    @EJB
    private IWorkstationDao workstationDao;

    public AddPlanimetryServlet() {
        super();
    }

    /**
     * This set method is used during testing in order to simulate the behaviour of the dao class
     * 
     * @param workstationDao
     */
    public void setWorkstationDao(IWorkstationDao workstationDao) {
        this.workstationDao = workstationDao;
    }

    /**
     * @param request
     *            Object that identifies an HTTP request
     * @param response
     *            Object that identifies an HTTP response
     * @pre request != null
     * @pre response != null
     * @pre request.getSession().getAttribute("user") != null
     * @pre request.getParameter("jsonObject") != null
     * @post floor.countMax() &gt; 0
     * @post room.countMaxByFloor(floor) &gt; 0
     * @post workstation.countMaxByFloorAndRoom(floor, room) &gt; 0
     * @throws ServletException
     * @throws IOException
     */
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        Admin admin = (Admin) request.getSession().getAttribute("user");

        /**
         * Retrieving of the parameters from a string like this one: [{"floor"=1,"room"=1,"workstation"=50},
         * {"floor"=1,"room"=2,"workstation"=40}, {"floor"=1,"room"=3,"workstation"=40},
         * {"floor"=1,"room"=4,"workstation"=40}, {"floor"=1,"room"=5,"workstation"=40},
         * {"floor"=2,"room"=1,"workstation"=30}, {"floor"=2,"room"=2,"workstation"=40},
         * {"floor"=2,"room"=3,"workstation"=40}, {"floor"=2,"room"=4,"workstation"=40},
         * {"floor"=2,"room"=5,"workstation"=40}, ...]
         */
        String jsonString = request.getParameter(JSON_STRING);
        if (jsonString == null) {
            request.getRequestDispatcher("WEB-INF/PlanimetryInsertion.jsp").forward(request, response);
            throw new IllegalArgumentException();
        }
        JSONArray jsonArray = new JSONArray(jsonString);

        /**
         * floorsNumber mantains the number of floors currently inserted
         */
        int floorsNumber = 0;

        Floor floor = null;
        Room room = null;
        Workstation workstation = null;

        /**
         * Insertion of workstations of each room and each floor
         */
        for (int i = 0; i < jsonArray.length(); i++) {
            JSONObject jsonObject = jsonArray.getJSONObject(i);

            int floorNumber = 0;
            int roomNumber = 0;
            int workstationsNumber = 0;

            /**
             * Retrieving the elements of the object
             */
            try {
                floorNumber = jsonObject.getInt(FLOOR);
                roomNumber = jsonObject.getInt(ROOM);
                workstationsNumber = jsonObject.getInt(WORKSTATIONS);
            } catch (JSONException e) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("\nErrore nel recupero della planimetia inserita");
                response.getWriter().flush();
            }

            /**
             * Checking for the correctness of the parameters inserted
             */
            if (floorNumber < MIN || floorNumber > MAX_FLOOR || roomNumber < MIN || roomNumber > MAX_ROOM
                    || workstationsNumber < MIN || workstationsNumber > MAX_WORKSTATIONS) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("\nI parametri inseriti non rispettano il formato/lunghezza");
                response.getWriter().flush();
                throw new IllegalArgumentException("I parametri inseriti non rispettano il formato/lugnhezza");
            }

            /**
             * This branch checks if the floor is already inserted into the database; if it would not exist, it will be
             * inserted
             */
            if (floorNumber > floorsNumber) {
                floor = new Floor();
                floor.setNumFloor(floorNumber);
                floor.setAdmin(admin);
                floorsNumber = floorNumber;
            }

            /**
             * Room insertions into the database
             */
            room = new Room();
            room.setFloor(floor);
            RoomPK roomPk = new RoomPK();
            roomPk.setNumFloor(floor.getNumFloor());
            roomPk.setNumRoom(roomNumber);
            room.setId(roomPk);

            /**
             * Workstations insertion into the database
             */
            for (int j = 0; j < workstationsNumber; j++) {
                workstation = new Workstation();
                WorkstationPK workstationPK = new WorkstationPK();
                workstationPK.setFloor(room.getId().getNumFloor());
                workstationPK.setRoom(room.getId().getNumRoom());
                workstationPK.setWorkstation(j + 1);
                workstation.setId(workstationPK);
                workstation.setRoom(room);
                try {
                    workstation = workstationDao.create(workstation);
                } catch (Exception e) {
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    response.getWriter()
                            .write("\nErrore nell'inserimento della postazione " + workstationPK.getWorkstation()
                                    + " per la stanza " + workstationPK.getRoom() + " del piano "
                                    + workstationPK.getFloor());
                    response.getWriter().flush();
                }
            }

        }

        request.setAttribute("result", "success");
        request.getRequestDispatcher("PlanimetryInsertionPage").forward(request, response);
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

}