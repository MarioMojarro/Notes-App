package uk.ac.ucl.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import uk.ac.ucl.model.Model;
import uk.ac.ucl.model.ModelFactory;

import java.io.IOException;

@WebServlet("/RenameServlet")
public class RenameServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String noteIndex = request.getParameter("noteindex");

        if (noteIndex == null || noteIndex.trim().isEmpty()) {
            response.sendRedirect("noteList.jsp?error=missingIndex");
            return;
        }
        request.setAttribute("noteIndex", noteIndex);
        request.getRequestDispatcher("renameNote.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Model model = ModelFactory.getModel();
        int index;
        String newName = request.getParameter("newName");

        try {
            index = Integer.parseInt(request.getParameter("noteindex"));
        } catch (NumberFormatException e) {
            response.sendRedirect("noteList.jsp?error=invalidIndex");
            return;
        }

        model.renameNote(index, newName);
        response.sendRedirect("noteList.jsp?success=renamed");
    }
}

