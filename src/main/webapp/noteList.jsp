<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="uk.ac.ucl.model.Model" %>
<%@ page import="uk.ac.ucl.model.ModelFactory" %>

<%
    Model model = ModelFactory.getModel();
    List<String> noteIndexes = (List<String>) request.getAttribute("filteredIndexes");
    List<String> noteNames = (List<String>) request.getAttribute("noteNames");
    List<String> noteTopics = (List<String>) request.getAttribute("noteTopics");
    List<String> noteUrls = (List<String>) request.getAttribute("noteUrls");
    List<String> noteSummaries = (List<String>) request.getAttribute("noteSummaries");

    if (noteIndexes == null) {
        noteIndexes = model.getNoteIndexes();
        noteNames = model.getNoteNames();
        noteTopics = model.getNoteTopics();
        noteUrls = model.getNoteUrls();
        noteSummaries = model.getNoteSummaries();
    }

    if (noteSummaries == null) {
        noteSummaries = new java.util.ArrayList<>();
        for (int i = 0; i < noteIndexes.size(); i++) {
            noteSummaries.add("No summary available");
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Note List</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #007bff;
            color: white;
            padding: 15px 20px;
        }
        .header h1 {
            margin: 0;
            cursor: pointer;
        }
        .header a {
            text-decoration: none;
            color: white;
            margin: 0 10px;
            padding: 10px;
            background-color: #0056b3;
            border-radius: 5px;
        }
        .header a:hover {
            background-color: #003f7f;
        }
        .container {
            width: 80%;
            margin: 20px auto;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        h1 {
            text-align: center;
        }
        .controls {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-bottom: 20px;
        }
        .controls select, .controls input, .controls button {
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #bbb;
            font-size: 14px;
            background-color: #e3f2fd;
            cursor: pointer;
            transition: background 0.3s;
        }
        .controls button:hover {
            background-color: #bbdefb;
        }
        .note-item {
            background-color: #ffffff;
            padding: 15px;
            margin: 10px 0;
            border-radius: 5px;
            box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .note-summary {
            display: none;
            margin-top: 10px;
            color: #555;
            font-style: italic;
        }
        .action-buttons button {
            margin-left: 5px;
            padding: 5px 10px;
            border: none;
            border-radius: 5px;
            color: white;
            cursor: pointer;
        }
        .rename-button { background-color: #28a745; }
        .delete-button { background-color: #dc3545; }
        .edit-button { background-color: #ffc107; }
        .index-button {
            background-color: #66b3ff;
            border: none;
            padding: 8px 15px;
            border-radius: 5px;
            font-size: 14px;
            color: white;
            cursor: pointer;
        }
        .index-button:hover {
            background-color: #5599dd;
        }
    </style>
</head>
<body>
    <script>
        function toggleSummary(index) {
            let summary = document.getElementById("summary-" + index);
            summary.style.display = (summary.style.display === "none" || summary.style.display === "") ? "block" : "none";
        }
    </script>
    <div class="header">
            <h1 onclick="location.href='index.html'">&#128218; You-Notes</h1>
            <div>
                <a href="addNote.jsp">New Note</a>
                <a href="noteList.jsp">View Notes</a>
            </div>
    </div>
    <div class="container">
        <h1>Note List</h1>
        <div class="controls">
            <div style="text-align: center; font-weight: bold;">Sort</div>
            <form action="SortServlet" method="GET">
                <select name="sortOrder">
                    <option value="recency">Recency</option>
                    <option value="normal">Reversed Recency</option>
                    <option value="alphabetical">Alphabetically</option>
                </select>
                <button type="submit">🔽</button>
            </form>
            <div style="text-align: center; font-weight: bold;">Filter</div>
            <form action="FilterServlet" method="GET">
                <input type="text" name="filterTopic" placeholder="Enter topic to filter..." />
                <button type="submit">🛠️</button>
            </form>
            <div style="text-align: center; font-weight: bold;">Search</div>
            <form action="SearchServlet" method="GET">
                <input type="text" name="searchQuery" placeholder="Search notes..." />
                <button type="submit">&#128269;</button>
            </form>
            <form action="noteList.jsp" method="GET">
                <button type="submit">&#128257;</button>
            </form>
        </div>
        <ul>
            <% for (int i = 0; i < noteIndexes.size(); i++) { %>
                <li class="note-item" onclick="toggleSummary(<%= i %>)">
                    <div class="note-header">
                        <button class="index-button" onclick="window.location.href='viewNote.jsp?noteindex=<%= noteIndexes.get(i) %>'">
                            <%= i + 1 %>
                        </button>
                        <span><%= noteNames.get(i) %> <span style='color: grey;'>- <%= noteTopics.get(i) %> -</span></span>
                    </div>
                    <div class="action-buttons">
                        <form action="RenameServlet" method="GET" style="display:inline;">
                            <input type="hidden" name="noteindex" value="<%= noteIndexes.get(i) %>" />
                            <button type="submit" class="rename-button">✒️ Rename</button>
                        </form>
                        <form action="DeleteServlet" method="POST" style="display:inline;">
                            <input type="hidden" name="noteindex" value="<%= noteIndexes.get(i) %>" />
                            <button type="submit" class="delete-button">🗑️</button>
                        </form>
                        <form action="EditServlet" method="GET" style="display:inline;">
                            <input type="hidden" name="noteindex" value="<%= noteIndexes.get(i) %>" />
                            <button type="submit" class="edit-button">&#9999;️</button>
                        </form>
                    </div>
                </li>
                <div id="summary-<%= i %>" class="note-summary"><%= noteSummaries.get(i) %></div>
            <% } %>
        </ul>
    </div>
</body>
</html>
