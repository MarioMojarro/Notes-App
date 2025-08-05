<style>
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
</style>
<div class="header">
        <h1 onclick="location.href='index.html'">&#128218; You-Notes</h1>
        <div>
            <a href="addNote.jsp">New Note</a>
            <a href="noteList.jsp">View Notes</a>
        </div>
    </div>
