package com.komodo.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
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
        
        String n=request.getParameter("username");  
        String p=request.getParameter("userpass"); 
        String t = null;
        
        HttpSession session = request.getSession(false);
        if(session!=null)
        session.setAttribute("name", n);

        if(LoginBDD.validate(n, p)){  
            
            t = LoginBDD.GetType(n, p);
            if (t == "élèves"){
            	RequestDispatcher rd = request.getRequestDispatcher("student.html");
            	rd.forward(request,response);
            }
            if (t == "professeur"){
            	RequestDispatcher rd = request.getRequestDispatcher("teacher.html");
            	rd.forward(request,response);
            }
        }  
        else{  
            out.print("<p style=\"color:red\">Sorry username or password error</p>");  
            RequestDispatcher rd=request.getRequestDispatcher("connexion.jsp");  
            rd.include(request,response);  
        }  

        out.close();  
    }  
} 
