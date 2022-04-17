<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Your Expanditure</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
              crossorigin="anonymous">
    </head>

    <body>
        <c:if test="${cookie.uid.value==null or cookie.uid.value==''}">
            <c:redirect url="index.html" />
        </c:if>
        <sql:setDataSource var="db" driver="${initParam.Driver}" url="jdbc:mysql://localhost/new" user="root"
                           password="" scope="session" />

        <sql:transaction dataSource="${db}" >
            <sql:update var="borrow">
                create or replace view borrows as select type_user_id,sum(type_cost) as 'borrowd' from records where user_id=? and type='borrow' GROUP by type_user_id;
                <sql:param value="${cookie.uid.value}" />
            </sql:update>
            <sql:update var="lend">
                create or replace view lends as select type_user_id,sum(type_cost) as 'lended' from records where user_id=? and type='lend' GROUP by type_user_id;
                <sql:param value="${cookie.uid.value}" />
            </sql:update>
            <sql:query var="rs">
                SELECT * from borrows NATURAL join lends;
            </sql:query>
        </sql:transaction>

        <div class="container-fluid">
            <br>
            <nav class="navbar navbar-expand-lg navbar-light bg-dark">
                <div class="container-fluid">
                    <a class="navbar-brand text-light" href="home.jsp">Cost Management</a>
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                            data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                            aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarSupportedContent">
                        <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                            <li class="nav-item" hidden>
                                <a class="nav-link active" aria-current="page" href="#">Home</a>
                            </li>
                        </ul>
                        <form action="update.jsp" class="d-flex">
                            <button type="submit" class="btn btn-light btn-lg">Profile</button>
                        </form>
                        <form action="logout" class="d-flex">
                            <button type="submit" class="btn btn-primary btn-lg">Logout</button>
                        </form>
                    </div>
                </div>
            </nav>
            <br>

            <p class="h2 text-center">Your Active Transactions</p>
            <br>
            <table class="table table-striped border">
                <thead class="table-dark ">
                    <tr>
                        <th>User ID</th>
                        <th>Borrow</th>
                        <th>Lend</th>
                        <th>Total</th>                        
                        <th>Details</th>
                        <th>Request Payment</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${rs.rows}" var="row">
                        <tr>
                            <td>${row.type_user_id}</td>
                            <td>         
                                <c:set var="b" value="${row.borrowd}" />
                                ${b}
                            </td>
                            <td>
                                <c:set var="l" value="${row.lended}" />
                                ${l}
                            </td>
                            <td>
                                <%
                                    int b = Integer.parseInt(pageContext.getAttribute("b").toString());
                                    int l = Integer.parseInt(pageContext.getAttribute("l").toString());
                                    int total = l - b;
                                %>
                                <%= total%>
                            </td>                            
                            <td>
                                <a class="btn btn-primary" href="details.jsp?other_user=${row.type_user_id}">Details</a>
                            </td>
                            <td>
                                <c:if test="<%= total > 0%>">
                                    <a class="btn btn-primary" href="requestPayment.jsp?other_user_id=${row.type_user_id}&cost=<%= total %>">Request</a>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </body>
</html>