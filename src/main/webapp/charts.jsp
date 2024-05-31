<%@page import="dao.Negocio"%>
<%@page import="java.util.*"%>
<%@page import="beans.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="style-campus.css">
        <title>Gráficos | ChollyMovie</title>
    </head>
    <body>
        <%
            Negocio obj = new Negocio();
            List<Sede> sedes = obj.listSedes();
            String nombre = (String) session.getAttribute("usuario_nombre");
            String apellido = (String) session.getAttribute("usuario_apellido");
            String PK = (String) session.getAttribute("usuario_PK");
        %>
        <header>
            <a href="index.jsp">LOGO</a>
            <% if (session.getAttribute("logged") != null && (boolean) session.getAttribute("logged")) {%>
            <label style="color: white">Bienvenido, <%=nombre%> <%=apellido%></label>
            <% } %>
            <ul>
                <li><a href="movies.jsp">PELICULAS</a></li>
                <li><a href="cinemas.jsp">CINES</a></li>
                    <% if (session.getAttribute("logged") != null && (boolean) session.getAttribute("logged")) {
                            if (PK.equals("U0001")) {
                    %>
                <li><a href="administrate.jsp">ADMINISTRAR</a></li>
                    <%
                        }
                    %>

                <li><a href="shopping-history.jsp">COMPRAS</a></li>
                <li><a href="control?opc=2">CERRAR SESIÓN</a></li>
                    <% } else { %>
                <li><a href="login.jsp">INICIAR SESIÓN</a></li>
                    <% }%>
            </ul>
        </header>
        <div class="video"></div>
        <section class="cuerpo">
            <br>
            <center>
                <h2>Graficos estadísticos</h2>
                <input type="radio" name="tipo" value="chart1.jsp" onclick="cambiarFuente(this.value)">Cantidad de reservas por hora por función
                <input type="radio" name="tipo" value="chart2.jsp" onclick="cambiarFuente(this.value)">Cantidad de reservas por película
                <input type="radio" name="tipo" value="chart3.jsp" onclick="cambiarFuente(this.value)">Cantidad de reservas por sede
                <iframe id="zona" width="100%" height="700" name="zona"></iframe>
            </center>

            <script type="text/javascript">
                function cambiarFuente(valor) {
                    var iframe = document.getElementById("zona");
                    iframe.src = valor;
                }
            </script>

        </section>
        <footer>
            <ul>
                <li>
                    <h2>NOSOTROS</h2>
                </li>
                <li><a href="#">Lorem</a></li>
                <li><a href="#">Lorem</a></li>
                <li><a href="#">Lorem</a></li>
                <li><a href="#">Lorem</a></li>
            </ul>
            <ul>
                <li>
                    <h2>ATENCIÓN AL CLIENTE</h2>
                </li>
                <li><a href="#">Lorem</a></li>
                <li><a href="#">Lorem</a></li>
                <li><a href="#">Lorem</a></li>
                <li><a href="#">Lorem</a></li>
            </ul>
            <ul>
                <li>
                    <h2>POLÍTICAS</h2>
                </li>
                <li><a href="#">Lorem</a></li>
                <li><a href="#">Lorem</a></li>
                <li><a href="#">Lorem</a></li>
                <li><a href="#">Lorem</a></li>
            </ul>
        </footer>
        <script>
            function eliminarSede(id) {
                if (confirm("¿Estás seguro de que deseas eliminar esta sede?")) {
                    // Crear una instancia de XMLHttpRequest
                    var xhr = new XMLHttpRequest();

                    // Configurar la solicitud
                    xhr.open("GET", "control?opc=7&id=" + id, true);

                    // Configurar la función de devolución de llamada
                    xhr.onreadystatechange = function () {
                        if (xhr.readyState == 4 && xhr.status == 200) {
                            // Manejar la respuesta del servidor
                            var response = JSON.parse(xhr.responseText);
                            if (response.success) {
                                // Actualizar la lista de sedes
                                location.reload();
                            } else {
                                alert("Error al eliminar la sede.");
                            }
                        }
                    };

                    // Enviar la solicitud
                    xhr.send();
                }
            }
        </script>

    </body> 
</html>