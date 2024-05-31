<%@page import="dao.Negocio"%>
<%@page import="java.util.*"%>
<%@page import="beans.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="style-movies.css">
        <title>Películas | ChollyMovie</title>
    </head>
    <body>
        <%
            Negocio obj = new Negocio();
            String id_sede = (String) request.getParameter("sede");
            String id_pelicula = (String) request.getParameter("pelicula");
            List<Pelicula> peliculas = obj.listPeliculas();
            List<Sede> sedes = obj.listSedes();
            List<Funcion> funcionesFiltradas = obj.listFuncionesFiltradas(id_pelicula, id_sede);
            String nombre = (String) session.getAttribute("usuario_nombre");
            String apellido = (String) session.getAttribute("usuario_apellido");
        %>
        <header>
            <a href="index.jsp">LOGO</a>
            <%
                if (session.getAttribute("logged") != null && (boolean) session.getAttribute("logged")) {
            %>
            <label style="color: white">Bienvenido, <%=nombre%> <%=apellido%></label>
            <%
                }
            %>
            <ul>
                <li><a href="movies.jsp">PELICULAS</a></li>
                    <%
                        if (session.getAttribute("logged") != null && (boolean) session.getAttribute("logged")) {
                    %>
                <li><a href="shopping-history.jsp">HISTORIAL DE COMPRAS</a></li>
                <li><a href="control?opc=2">CERRAR SESIÓN</a></li>
                    <%
                    } else {
                    %>
                <li><a href="login.jsp">INICIAR SESIÓN</a></li>
                    <%
                        }
                    %>
            </ul>
        </header>
        <video src="images/background/video_background.mp4" autoplay muted loop style="max-width: 100%"></video>
        <section class="peliculas">
            <form action="control" method="GET">
                <div class="combobox">
                    <input type="hidden" name="opc" value="4">
                    <select name="sede" id="sede">
                        <option value="null">* Seleccione una sede</option>
                        <%
                            for (Sede s : sedes) {
                        %>
                        <option value="<%=s.getId()%>"><%=s.getDireccion()%></option>
                        <%
                            }
                        %>
                    </select>
                    <select name="pelicula" id="pelicula">
                        <option value="null">* Seleccione una película</option>
                        <%
                            for (Pelicula p : peliculas) {
                        %>
                        <option value="<%=p.getId()%>"><%=p.getTitulo()%></option>
                        <%
                            }
                        %>
                    </select>
                    <input type="submit" value="Filtrar">
                </div>
            </form>
            <div class="funcion-block" id="funcionesFiltradasContainer">
                <h3>Funciones</h3>
                <div class="horas">
                    <% if (funcionesFiltradas != null) {
                            for (Funcion f : funcionesFiltradas) { %>
                    <% if (session.getAttribute("logged") != null && (boolean) session.getAttribute("logged")) {%>
                    <button onclick="location.href = 'buy.jsp?id=<%= f.getId()%>'"><%= f.getHora()%></button>
                    <% } else {%>
                    <button onclick="location.href = 'login.jsp'"><%= f.getHora()%></button>
                    <% } %>
                    <% }
                        }%>
                </div>
            </div>
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
        <script src="jquery.min.js"></script>
        <script>
                        function filtrar(sede, pelicula) {
                            // Crear una instancia de XMLHttpRequest
                            var xhr = new XMLHttpRequest();

                            // Configurar la solicitud
                            xhr.open("GET", "control?opc=4&sede=" + sede + "&pelicula=" + pelicula, true);

                            // Configurar la función de devolución de llamada
                            xhr.onreadystatechange = function () {
                                if (xhr.readyState == 4 && xhr.status == 200) {
                                    // Manejar la respuesta del servidor
                                    var response = JSON.parse(xhr.responseText);
                                    if (response.success) {
                                        // Actualizar la lista de funciones filtradas en el DOM
                                        var funcionesContainer = document.getElementById('funcionesFiltradasContainer');
                                        funcionesContainer.innerHTML = response.html; // Suponiendo que el servidor envía el HTML actualizado

                                    } else {
                                        alert("Error al filtrar");
                                    }
                                }
                            };

                            // Enviar la solicitud
                            xhr.send();
                        }

        </script>
    </body>
</html>
