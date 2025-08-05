package uk.ac.ucl.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import uk.ac.ucl.model.Model;
import uk.ac.ucl.model.ModelFactory;

import java.io.IOException;

@WebServlet("/DeleteServlet")
public class DeleteServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Model model = ModelFactory.getModel();
        int index;
        try {
            index = Integer.parseInt(request.getParameter("noteindex"));
        } catch (NumberFormatException e) {
            response.sendRedirect("noteList.html?error=invalidIndex");
            return;
        }

        model.deleteNote(index);
        response.sendRedirect("noteList.html?success=deleted");
    }
}