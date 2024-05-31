<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="beans.ReservasHora, dao.Negocio" %>
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

        <form method="get" id="myForm" onsubmit="return showChart()">
            Ingrese código de película: <input name="in" type="text" required>
            <input type="submit" value="Submit">
        </form>


        <%
            Negocio obj = new Negocio();
            String pel = null;
            pel = request.getParameter("in");

            String label = "";
            String data = "";
            String color = "['rgba(153,205,1,0.6)','orange','lightblue','lightred','lightgreen','red', 'yellow', 'gray','blue', 'beige', 'brown', 'purple']";
            List<ReservasHora> a = obj.lisReservasPorHoraDeFuncion(pel);

            if (!a.isEmpty()) {  // Verificar si la lista no está vacía
                for (ReservasHora x : a) {
                    label += "'" + x.getHoraFuncion() + "',";
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
            function showChart() {
                var input = document.getElementsByName("in")[0];
                var peli = input.value.trim(); // Eliminar espacios en blanco al principio y al final

                // Verificar si el valor no está vacío
                if (peli !== "") {
                    document.getElementById("myForm").style.display = "none";
                    document.getElementById("chartContainer").style.display = "block";

                    var ctx = document.getElementById("myChart").getContext("2d");
                    var myChart = new Chart(ctx, {
                        type: "bar",
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

                    // Devolver false para evitar el envío del formulario
                    return false;
                } else {
                    alert("Por favor, ingrese un valor válido.");
                    // Devolver true para permitir el envío del formulario
                    return true;
                }
            }

        </script>
    </body>
</html>
