<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="beans.ReservasSede, dao.Negocio" %>
<html>
    <head>
        <title>Estadísticas de Usuarios Registrados</title>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.2.2/Chart.min.js"></script>
        <style>
            .container {
                width: 70%;
                margin: 15px auto;
                padding: 10px;
            }

            canvas {
                display: block;
                margin: 0 auto;
            }

            body {
                text-align: center;
                color: green;
            }

            h2 {
                text-align: center;
                font-family: "Verdana", sans-serif;
                font-size: 30px;
            }
        </style>
    </head>
    <body>

        <form method="get" id="myForm" onsubmit="return showChart(event)">
            Ingrese año: <input name="tan" type="number" required>
            <input type="submit" value="Submit">
        </form>


        <%
            Negocio obj = new Negocio();
            int an = 0;
            try {
                an = Integer.parseInt(request.getParameter("tan"));
            } catch (NumberFormatException e) {
                an = 0;
            }

            String label = "";
            String data = "";
            String color = "['lightblue']";
            List<ReservasSede> a = obj.lisReservasTotalesPorSede(an);

            if (!a.isEmpty()) {
                for (ReservasSede x : a) {
                    label += "'" + x.getSede() + "',";
                    data += x.getTotalReservas() + ",";
                }
                label = label.substring(0, label.length() - 1);
                data = data.substring(0, data.length() - 1);
            }
        %>

        <div class="container" id="chartContainer" style="display:none;">
            <div>
                <canvas id="myChart"></canvas>
            </div>
        </div>

        <script>
            function showChart(event) {
                event.preventDefault();

                var yearInput = document.getElementsByName("tan")[0];
                var year = parseInt(yearInput.value);

                if (!isNaN(year)) {
                    document.getElementById("myForm").style.display = "none";
                    document.getElementById("chartContainer").style.display = "block";

                    var ctx = document.getElementById("myChart").getContext("2d");
                    var myChart = new Chart(ctx, {
                        type: "line",
                        data: {
                            labels: [<%=label%>],
                            datasets: [
                                {
                                    label: "Reservas",
                                    data: [<%=data%>],
                                    backgroundColor: <%=color%>,
                                },
                            ],
                        },
                    });
                } else {
                    alert("Por favor, ingrese un año válido.");
                }
            }
        </script>

    </body>
</html>
