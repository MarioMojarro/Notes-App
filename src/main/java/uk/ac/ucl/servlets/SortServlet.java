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
import java.util.Collections;
import java.util.List;

@WebServlet("/SortServlet")
public class SortServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Model model = ModelFactory.getModel();
        List<String> noteIndexes = model.getNoteIndexes();
        List<String> noteNames = model.getNoteNames();
        List<String> noteTopics = model.getNoteTopics();
        List<String> noteUrls = model.getNoteUrls();
        List<String> noteContents = model.getNoteContents();
        List<String> noteSummaries = model.getNoteSummaries();

        String sortOrder = request.getParameter("sortOrder");

        if ("alphabetical".equals(sortOrder)) {
            List<String> sortedNames = new ArrayList<>(noteNames);
            Collections.sort(sortedNames);
            List<String> sortedIndexes = new ArrayList<>();
            for (String name : sortedNames) {
                int index = noteNames.indexOf(name);
                sortedIndexes.add(noteIndexes.get(index));
            }
            noteIndexes = sortedIndexes;
            noteNames = sortedNames;
        } else if ("recency".equals(sortOrder)) {
            Collections.reverse(noteIndexes);
            Collections.reverse(noteNames);
            Collections.reverse(noteTopics);
            Collections.reverse(noteUrls);
            Collections.reverse(noteContents);
            Collections.reverse(noteSummaries);
        }

        request.setAttribute("filteredIndexes", noteIndexes);
        request.setAttribute("noteNames", noteNames);
        request.setAttribute("noteTopics", noteTopics);
        request.setAttribute("noteUrls", noteUrls);
        request.setAttribute("noteContents", noteContents);
        request.setAttribute("noteSummaries", noteSummaries);

        request.getRequestDispatcher("noteList.jsp").forward(request, response);
    }
}