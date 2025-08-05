package uk.ac.ucl.servlets;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import uk.ac.ucl.model.Model;
import uk.ac.ucl.model.ModelFactory;


import java.io.IOException;
import java.util.List;

@WebServlet("/noteList.html")
public class ViewNoteListServlet extends HttpServlet
{
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException
    {

        Model model = ModelFactory.getModel();
        List<String> noteIndexes = model.getNoteIndexes();
        List<String> noteNames = model.getNoteNames();
        List<String> noteUrls = model.getNoteUrls();
        if (noteUrls == null || noteUrls.isEmpty()) {
            noteUrls = null;
        }

        List<String> noteTopics = model.getNoteTopics();

        request.setAttribute("noteIndexes", noteIndexes);
        request.setAttribute("noteNames", noteNames);
        request.setAttribute("noteUrls", noteUrls);

        request.setAttribute("noteTopics", noteTopics);

        ServletContext context = getServletContext();
        RequestDispatcher dispatch = context.getRequestDispatcher("/noteList.jsp");
        dispatch.forward(request, response);
    }
}