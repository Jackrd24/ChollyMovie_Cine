<%@page import="dao.Negocio"%>
<%@page import="java.util.*"%>
<%@page import="beans.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="style-movie.css">
        <title>Funciones | ChollyMovie</title>
    </head>
    <body>
        <%
            Negocio obj = new Negocio();
            String id = (String) request.getParameter("id");
            String titulo = (String) request.getParameter("titulo");
            String estado = (String) request.getParameter("estado");
            String archivo = (String) request.getParameter("archivo");
            List<Funcion> funciones = obj.listFuncionesPelicula(id);
            String nombre = (String) session.getAttribute("usuario_nombre");
            String apellido = (String) session.getAttribute("usuario_apellido");
            String PK = (String) session.getAttribute("usuario_PK");

            // Organizar funciones por día
            Map<String, List<Funcion>> funcionesPorDia = new HashMap<>();
            for (Funcion f : funciones) {
                String fecha = f.getFecha();
                List<Funcion> funcionesDia = funcionesPorDia.get(fecha);
                if (funcionesDia == null) {
                    funcionesDia = new ArrayList<>();
                    funcionesPorDia.put(fecha, funcionesDia);
                }
                funcionesDia.add(f);
            }
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
                    <% } %>
                <li><a href="shopping-history.jsp">COMPRAS</a></li>
                <li><a href="control?opc=2">CERRAR SESIÓN</a></li>
                    <% } else { %>
                <li><a href="login.jsp">INICIAR SESIÓN</a></li>
                    <% } %>
            </ul>
        </header>
        <video src="images/background/video_background.mp4" autoplay muted loop style="max-width: 100%"></video>
        <section class="cuerpo">
            <h2>HORARIOS DE <%=titulo%></h2>
            <% for (Map.Entry<String, List<Funcion>> entry : funcionesPorDia.entrySet()) {
                    String fecha = entry.getKey();
                    List<Funcion> funcionesDia = entry.getValue();
            %>
            <div class="funcion-block">
                <h3>Funciones para el <%= fecha%></h3>
                <div class="horas">
                    <% for (Funcion f : funcionesDia) {
                            if (session.getAttribute("logged") != null && (boolean) session.getAttribute("logged")) {
                    %>
                    <button onclick="location.href = 'buy.jsp?id=<%= f.getId()%>&titulo=<%= titulo%>&estado=<%= estado%>&archivo=<%= archivo%>'"><%= f.getHora()%></button>
                    <%
                    } else {
                    %>
                    <button onclick="location.href = 'login.jsp'"><%= f.getHora()%></button>
                    <%
                        }
                    %>
                    <% } %>
                </div>
            </div>
            <% }%>
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
    </body> 
</html>
