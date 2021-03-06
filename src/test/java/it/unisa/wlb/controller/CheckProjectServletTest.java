package it.unisa.wlb.controller;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpServletResponse;
import static org.mockito.Mockito.when;

import java.io.IOException;

import javax.servlet.ServletException;
import it.unisa.wlb.controller.CheckProjectServlet;
import it.unisa.wlb.model.bean.Project;
import it.unisa.wlb.model.dao.IProjectDao;

/**
 * The aim of this class is testing CheckProjectServlet.java
 * 
 * @author Vincenzo Fabiano
 *
 */
class CheckProjectServletTest {

    @Mock
    private IProjectDao projectDao;

    private CheckProjectServlet servlet;
    private MockHttpServletRequest request;
    private MockHttpServletResponse response;
    private Project project;
    private String name;

    @BeforeEach
    void setUp() throws Exception {
        MockitoAnnotations.initMocks(this);
        servlet = new CheckProjectServlet();
        request = new MockHttpServletRequest();
        response = new MockHttpServletResponse();
        project = new Project();
        name = "WLBG13";
        project.setName(name);
    }

    @Test
    void projectNotAvailable() throws ServletException, IOException {
        request.setParameter("name", name);
        when(projectDao.retrieveByName(name)).thenReturn(project);
        String json = "{\"available\":\"no\"}";
        servlet.setProjectDao(projectDao);
        servlet.doPost(request, response);
        assertEquals(json, response.getContentAsString());
    }

    @SuppressWarnings("unchecked")
    @Test
    void projectAvailable() throws ServletException, IOException {
        request.setParameter("name", name);
        when(projectDao.retrieveByName(name)).thenThrow(Exception.class);
        String json = "{\"available\":\"yes\"}";
        servlet.setProjectDao(projectDao);
        servlet.doPost(request, response);
        assertEquals(json, response.getContentAsString());
    }

    @Test
    void projectNotCorrectFormat() throws ServletException, IOException {
        request.setParameter("name", "");
        String json = "{\"available\":\"no\"}";
        servlet.doPost(request, response);
        assertEquals(json, response.getContentAsString());
    }

    @Test
    void projectNotCorrectFormat2() throws ServletException, IOException {
        String tmp = null;
        request.setParameter("name", tmp);
        String json = "{\"available\":\"no\"}";
        servlet.doPost(request, response);
        assertEquals(json, response.getContentAsString());
    }

    @Test
    void projectNotCorrectFormat3() throws ServletException, IOException {
        request.setParameter("name", "a");
        String json = "{\"available\":\"no\"}";
        servlet.doPost(request, response);
        assertEquals(json, response.getContentAsString());
    }

    @Test
    void projectNotCorrectFormat4() throws ServletException, IOException {
        request.setParameter("name", "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
        String json = "{\"available\":\"no\"}";
        servlet.doPost(request, response);
        assertEquals(json, response.getContentAsString());
    }

    @Test
    void projectNotCorrectFormat5() throws ServletException, IOException {
        request.setParameter("name", "ProjectN_.*");
        String json = "{\"available\":\"no\"}";
        servlet.doPost(request, response);
        assertEquals(json, response.getContentAsString());
    }
}
