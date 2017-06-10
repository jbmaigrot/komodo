package com.komodo.servlets;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.sql.ResultSet;

import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
//import java.util.Arrays;
//import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.komodo.bdd.ConnectBDD;

@WebServlet("/PlanningEleve")
public class PlanningServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public static final String VUE = "/planning_eleve.jsp";
	
	 /**
     * @see HttpServlet#HttpServlet()
     */
    public PlanningServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	int numero_groupe = 1;
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		ConnectBDD conn = new ConnectBDD();
	    conn.getConnection();
	    conn.affichagePlanningEleve(numero_groupe, true, request);
        this.getServletContext().getRequestDispatcher(VUE).forward( request, response );
    }
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}
}
