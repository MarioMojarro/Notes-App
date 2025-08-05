package uk.ac.ucl.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import uk.ac.ucl.model.Model;
import uk.ac.ucl.model.ModelFactory;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/FilterServlet")
public class FilterServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Model model = ModelFactory.getModel();
        String topic = request.getParameter("filterTopic");
        String action = request.getParameter("action");

        if ("undo".equals(action)) {
            request.setAttribute("noteIndexes", model.getNoteIndexes());
            request.setAttribute("noteNames", model.getNoteNames());
            request.setAttribute("noteTopics", model.getNoteTopics());
            request.setAttribute("noteContents", model.getNoteContents());
            request.setAttribute("noteSummaries", model.getNoteSummaries());
            request.getRequestDispatcher("noteList.jsp").forward(request, response);
            return;
        }
        if (topic == null || topic.trim().isEmpty()) {
            response.sendRedirect("noteList.jsp?error=missingTopic");
            return;
        }
        List<String> noteIndexes = model.getNoteIndexes();
        List<String> noteNames = model.getNoteNames();
        List<String> noteTopics = model.getNoteTopics();
        List<String> noteContents = model.getNoteContents();
        List<String> noteSummaries = model.getNoteSummaries();
        List<String> filteredIndexes = new ArrayList<>();
        List<String> filteredNames = new ArrayList<>();
        List<String> filteredTopics = new ArrayList<>();
        List<String> filteredContents = new ArrayList<>();
        List<String> filteredSummaries = new ArrayList<>();

        for (int i = 0; i < noteTopics.size(); i++) {
            if (noteTopics.get(i).equalsIgnoreCase(topic)) {
                filteredIndexes.add(noteIndexes.get(i));
                filteredNames.add(noteNames.get(i));
                filteredTopics.add(noteTopics.get(i));
                filteredContents.add(noteContents.get(i));
                filteredSummaries.add(noteSummaries.get(i));
            }
        }
        request.setAttribute("filteredIndexes", filteredIndexes);
        request.setAttribute("noteNames", filteredNames);
        request.setAttribute("noteTopics", filteredTopics);
        request.setAttribute("noteContents", filteredContents);
        request.setAttribute("noteSummaries", filteredSummaries);

        request.getRequestDispatcher("noteList.jsp").forward(request, response);
    }
}
