package com.komodo.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.komodo.bdd.LoginBDD;

@WebServlet("/LoginServelt")
public class LoginServlet extends HttpServlet{

    private static final long serialVersionUID = 1L;

    public void doPost(HttpServletRequest request, HttpServletResponse response)  
            throws ServletException, IOException {  

        response.setContentType("text/html");  
        PrintWriter out = response.getWriter();  
        
        String n=request.getParameter("userName");  
        String p=request.getParameter("motdepasse"); 
        String t = null;
        
        
        t = LoginBDD.validate(n, p);
        if(t != null){ 
        	HttpSession session = request.getSession();
        	session.setAttribute("userName", n);
        	session.setAttribute("Type", t);
			session.setMaxInactiveInterval(30*60);
			Cookie userName = new Cookie("userName", n);
			response.addCookie(userName);
            if (t.equals("élèves")){
            	this.getServletContext().getRequestDispatcher("/connexion.jsp").forward(request, response);
            }
            else if (t.equals("professeur") || t.equals("responsable")){
            	this.getServletContext().getRequestDispatcher("/connexion.jsp").forward(request, response);
            }
            
        }  
        else{  
            out.print("<p style=\"color:red\">Sorry username or password error</p>");  
            RequestDispatcher rd=request.getRequestDispatcher("/connexion.jsp");  
            rd.include(request,response);  
        }  

        out.close();  
    }  
} 
