<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Request Payment</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
              crossorigin="anonymous">
    </head>
    <body>
        <%
            String msg = "Hey " + request.getParameter("other_user_id") + ",I have landed you " + request.getParameter("cost") + " rupees,So I request you to give me back within a 3 days";
        %>
        <div class="container-fluid">
            <br>
            <div class="alert alert-primary" role="alert">

                <h4 class="alert-heading">To be added very soon</h4>

            </div>
            <p>Clear your pending transactions</p>
            <hr>
            <br>
            
            <div class="row">
                <div class="col text-start">
                    <a class="btn btn-primary" href="calculateCost.jsp">Back</a>
                </div>
            </div>        
        </div>
    </body>
</html>