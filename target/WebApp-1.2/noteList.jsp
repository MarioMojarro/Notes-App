<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
  <jsp:include page="/meta.jsp"/>
  <title>Patient Data App</title>
</head>
<body>
<jsp:include page="/header.jsp"/>
<div class="main">
  <h2>Notes:</h2>
  <ul>
    <%
      List<String> notes = (List<String>) request.getAttribute("noteNames");
      for (String note : notes)
      {
          String href = "dummypage.html";
    %>
    <li><a href="<%=href%>"><%=note%></a>
    </li>
    <% } %>
  </ul>
</div>
<jsp:include page="/footer.jsp"/>
</body>
</html>
