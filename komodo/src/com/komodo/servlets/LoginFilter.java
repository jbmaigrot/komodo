package com.komodo.servlets;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebFilter("/CreationGrille")
public class LoginFilter implements Filter {
	
	private ServletContext context;
	
	@Override
	public void init(FilterConfig fConfig) throws ServletException {
		this.context = fConfig.getServletContext();
		this.context.log("AuthenticationFilter initialized");
	}

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws ServletException, IOException {    
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;
        HttpSession session = request.getSession();
        String uri = request.getRequestURI();

        boolean loggedIn = session != null && session.getAttribute("userName") != null;
        boolean loginRequest = request.getRequestURI().equals("connexion.jsp");

        if (loggedIn) {
            chain.doFilter(request, response);
        } else {
            response.sendRedirect("connexion.jsp");
        }
    }

	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		
	}

    // ...
}