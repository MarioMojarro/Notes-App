<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String noteIndex = request.getParameter("noteindex");
    if (noteIndex == null) {
        noteIndex = ""; // Ensures noteIndex is not null
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Rename Note</title>
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
            max-width: 400px;
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
        input[type="text"] {
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
      <h1 onclick="location.href='index.html'">&#128218; You-Notes</h1>
      <div>
        <a href="addNote.jsp">New Note</a>
        <a href="noteList.jsp">View Notes</a>
      </div>
    </div>
    <div class="container">
        <h2>Rename Note</h2>
        <form action="RenameServlet" method="POST">
            <input type="hidden" name="noteindex" value="<%= noteIndex %>">
            <label for="newName">New Name:</label>
            <input type="text" name="newName" id="newName" placeholder="Enter new name" required>
            <button type="submit">Rename</button>
        </form>
        <a href="noteList.jsp" class="back-link">Back to Notes</a>
    </div>
</body>
</html>
