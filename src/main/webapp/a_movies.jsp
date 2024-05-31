<%@page import="dao.Negocio"%>
<%@page import="java.util.*"%>
<%@page import="beans.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="style-campus.css">
        <title>Sedes | ChollyMovie</title>
    </head>
    <body>
        <%
            Negocio obj = new Negocio();
            List<Pelicula> peliculas = obj.listPeliculas();
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
            <h2>LISTA DE PELICULAS</h2>
            <button onclick="location.href = 'add-a_movies.jsp'">AGREGAR NUEVA SEDE</button>
            <table border="1">
                <tr>
                    <th>CODIGO</th>
                    <th>TITULO</th>
                    <th>DESCRIPCION</th>
                    <th>DURACION</th>
                    <th>CLASIFICACION</th>
                    <th>ESTADO</th>
                </tr>
                <%
                    for (Pelicula p : peliculas) {
                %>
                <tr>
                    <td><%=p.getId()%></td>
                    <td><%=p.getTitulo()%></td>
                    <td><%=p.getDescripcion()%></td>
                    <td><%=p.getDuracion()%></td>
                    <td><%=p.getClasificacion()%></td>
                    <td><%=p.getEstado()%></td>
                    <td>
                        <button onclick="location.href = 'update-a_movies.jsp?id=<%= p.getId()%>'">ACTUALIZAR</button>
                        <button onclick="eliminarPelicula('<%= p.getId()%>')">ELIMINAR</button>
                    </td>
                </tr>
                <%
                    }
                %>
            </table>
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
            function eliminarPelicula(id) {
                if (confirm("¿Estás seguro de que deseas eliminar esta película? (Si hay tickets comprados, ya no se puede eliminar")) {
                    // Crear una instancia de XMLHttpRequest
                    var xhr = new XMLHttpRequest();

                    // Configurar la solicitud
                    xhr.open("GET", "control?opc=10&id=" + id, true);

                    // Configurar la función de devolución de llamada
                    xhr.onreadystatechange = function () {
                        if (xhr.readyState == 4 && xhr.status == 200) {
                            // Manejar la respuesta del servidor
                            var response = JSON.parse(xhr.responseText);
                            if (response.success) {
                                // Actualizar la lista de sedes
                                location.reload();
                            } else {
                                alert("Error al eliminar la pelicula.");
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