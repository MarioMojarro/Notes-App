package uk.ac.ucl.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import uk.ac.ucl.model.Model;
import uk.ac.ucl.model.ModelFactory;

import java.io.IOException;

@WebServlet("/EditServlet")
public class EditServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String noteIndex = request.getParameter("noteindex");

        if (noteIndex == null || noteIndex.trim().isEmpty()) {
            response.sendRedirect("noteList.jsp?error=missingIndex");
            return;
        }

        request.setAttribute("noteIndex", noteIndex);
        request.getRequestDispatcher("editNote.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Model model = ModelFactory.getModel();
        int index;
        String newContent = request.getParameter("newContent");
        String newTopic = request.getParameter("newTopic");
        String newSummary = request.getParameter("newSummary");

        try {
            index = Integer.parseInt(request.getParameter("noteindex"));
        } catch (NumberFormatException e) {
            response.sendRedirect("noteList.jsp?error=invalidIndex");
            return;
        }

        model.updateNoteContent(index, newContent);
        model.updateNoteTopic(index, newTopic);
        model.updateNoteSummary(index, newSummary);

        response.sendRedirect("noteList.jsp?success=edited");
    }
}