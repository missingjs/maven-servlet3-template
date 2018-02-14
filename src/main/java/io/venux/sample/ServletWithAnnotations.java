package io.venux.sample;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "simple-servlet", urlPatterns = { "/hello" }, loadOnStartup = 1)
public class ServletWithAnnotations extends HttpServlet {
	private static final long serialVersionUID = -3462096228274971485L;
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		String ip = request.getRemoteAddr();
		String message = String.format("The real fans from %s? Excited!", ip);
		response.getWriter().println(message);
	}
}
