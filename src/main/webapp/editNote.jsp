<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="uk.ac.ucl.model.Model" %>
<%@ page import="uk.ac.ucl.model.ModelFactory" %>

<%
    Model model = ModelFactory.getModel();
    String noteIndex = request.getParameter("noteindex");

    List<String> noteIndexes = model.getNoteIndexes();
    List<String> noteTopics = model.getNoteTopics();
    List<String> noteSummaries = model.getNoteSummaries();
    List<String> noteContents = model.getNoteContents();

    int adjustedIndex = (noteIndex != null && !noteIndex.isEmpty() && noteIndexes.contains(noteIndex)) ? noteIndexes.indexOf(noteIndex) : -1;

    String topic = (adjustedIndex >= 0) ? noteTopics.get(adjustedIndex) : "**ERROR: Topic Not Found**";
    String summary = (adjustedIndex >= 0) ? noteSummaries.get(adjustedIndex) : "**ERROR: Summary Not Found**";
    String noteContent = (adjustedIndex >= 0) ? noteContents.get(adjustedIndex) : "**ERROR: Content Not Found**";
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Note</title>
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
            max-width: 500px;
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
        label {
            font-weight: bold;
            display: block;
            margin-top: 15px;
            text-align: left;
        }
        input[type="text"], textarea {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border-radius: 5px;
            border: 1px solid #ccc;
            font-size: 14px;
        }
        button {
            background-color: #007bff;
            color: white;
            padding: 12px;
            border: none;
            cursor: pointer;
            border-radius: 5px;
            width: 100%;
            font-size: 16px;
            margin-top: 15px;
            transition: background 0.3s;
        }
        button:hover {
            background-color: #0056b3;
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
    </style>
</head>
<body>
    <div class="header">
        <h1 onclick="location.href='index.html'">&#128221; Edit Note</h1>
        <div>
            <a href="addNote.jsp">New Note</a>
            <a href="noteList.jsp">View Notes</a>
        </div>
    </div>
    <div class="container">
        <h2>Edit Note</h2>
        <form action="EditServlet" method="POST">
            <input type="hidden" name="noteindex" value="<%= noteIndex %>">
            <label for="newTopic">New Topic:</label>
            <input type="text" name="newTopic" id="newTopic" value="<%= topic %>" placeholder="Enter new topic">
            <label for="newSummary">New Summary:</label>
            <textarea name="newSummary" id="newSummary" rows="2"><%= summary %></textarea>
            <label for="newContent">New Content:</label>
            <textarea name="newContent" id="newContent" rows="6"><%= noteContent.replace("\n", "&#10;") %></textarea>
            <button type="submit">💾 Save Changes</button>
        </form>
        <a href="noteList.jsp" class="back-link">Back to Notes</a>
    </div>
</body>
</html>
