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
            <h2>LISTA DE SEDES</h2>
            <button onclick="location.href = 'add-campus.jsp'">AGREGAR NUEVA SEDE</button>
            <table border="1">
                <tr>
                    <th>CODIGO</th>
                    <th>DIRECCION</th>
                    <th>OPCIONES</th>
                </tr>
                <%
                    for (Sede s : sedes) {
                %>
                <tr>
                    <td><%=s.getId()%></td>
                    <td><%=s.getDireccion()%></td>
                    <td>
                        <button onclick="location.href = 'update-campus.jsp?id=<%= s.getId()%>'">ACTUALIZAR</button>
                        <button onclick="eliminarSede('<%= s.getId()%>')">ELIMINAR</button>
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