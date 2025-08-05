<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="uk.ac.ucl.model.Model" %>
<%@ page import="uk.ac.ucl.model.ModelFactory" %>

<%
    Model model = ModelFactory.getModel();
    String noteIndex = request.getParameter("noteindex");

    int index = (noteIndex != null && !noteIndex.isEmpty()) ? Integer.parseInt(noteIndex) : -1;

    List<String> noteIndexes = model.getNoteIndexes();
    List<String> noteNames = model.getNoteNames();
    List<String> noteTopics = model.getNoteTopics();
    List<String> noteSummaries = model.getNoteSummaries();
    List<String> noteContents = model.getNoteContents();
    List<String> noteUrls = model.getNoteUrls();

    int adjustedIndex = noteIndexes.indexOf(noteIndex);

    String noteName = (adjustedIndex >= 0) ? noteNames.get(adjustedIndex) : "**ERROR: Note Name Not Found**";
    String topic = (adjustedIndex >= 0) ? noteTopics.get(adjustedIndex) : "**ERROR: Topic Not Found**";
    String summary = (adjustedIndex >= 0) ? noteSummaries.get(adjustedIndex) : "**ERROR: Summary Not Found**";
    String noteContent = (adjustedIndex >= 0) ? noteContents.get(adjustedIndex) : "**ERROR: Content Not Found**";
    String noteUrl = (adjustedIndex >= 0 && noteUrls.get(adjustedIndex) != null && !noteUrls.get(adjustedIndex).isEmpty()) ? "uploads/" + noteUrls.get(adjustedIndex) : "**ERROR: No File Attached**";
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Note</title>
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
            max-width: 600px;
            margin: 40px auto;
            padding: 25px;
            background-color: white;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            text-align: center;
        }
        h2 {
            margin-bottom: 20px;
            color: #333;
        }
        .note-content {
            text-align: left;
            background: #f9f9f9;
            padding: 15px;
            border-radius: 5px;
            box-shadow: inset 0 0 5px rgba(0, 0, 0, 0.1);
            word-wrap: break-word;
            overflow-wrap: break-word;
            white-space: normal;
            max-width: 100%;
            display: block;
            width: auto;
            max-width: 100%;
            min-width: 50%;
            height: auto;
            min-height: 50px;
        }
        .attachment {
            margin-top: 15px;
            text-align: center;
        }
        .attachment a {
            text-decoration: none;
            color: #007bff;
            font-weight: bold;
        }
        .attachment a:hover {
            text-decoration: underline;
        }
        .back-link {
            display: block;
            margin-top: 20px;
            text-decoration: none;
            color: #007bff;
            font-weight: bold;
        }
        .back-link:hover {
            text-decoration: underline;
        }
        .note-summary {
            display: none;
            margin-top: 10px;
            padding: 10px;
            background-color: #f9f9f9;
            border-left: 4px solid #007bff;
            font-style: italic;
            color: #555;
        }
        .note-item {
            cursor: pointer;
            padding-bottom: 10px;
        }
    </style>
</head>
<body>
    <div class="header">
      <h1 onclick="location.href='index.html'">&#128218; You-Notes</h1>
      <div>
        <a href="addNote.jsp">New Note</a>
        <a href="noteList.jsp">View Notes</a>
      </div>
    </div>
    <div class="container">
        <h2><%= noteName %></h2>
        <div class="note-content">
            <h3>Topic: <%= topic %></h3>
            <p><strong>Summary:</strong> <%= summary %></p>
            <h2>Content:</h2>
            <p><%= noteContent.replace("\n", "<br>") %></p>
        </div>
        <% if (noteUrl != null && !noteUrl.isEmpty() && !noteUrl.equals("**ERROR: No File Attached**")) { %>
            <div class="attachment">
                <p><a href="<%= noteUrl %>" target="_blank">📁 View Attached File</a></p>
            </div>
        <% } %>
        <a href="noteList.jsp" class="back-link">Back to Notes</a>
    </div>
</body>
</html>
