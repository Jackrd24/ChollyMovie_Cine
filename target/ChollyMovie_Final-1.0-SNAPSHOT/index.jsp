<%@page import="dao.Negocio"%>
<%@page import="java.util.*"%>
<%@page import="beans.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="style-index.css">
        <title>Home | ChollyMovie</title>
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
                    <% } %>
            </ul>
        </header>
        <video src="images/background/video_background.mp4" autoplay muted loop style="max-width: 100%"></video>
        <section class="semanal">
            <h2>CARTELERA SEMANAL</h2>
            <div class="carrusel">
                <%
                    for (Pelicula p : peliculas) {
                        if (p.getEstado().equals("ESTRENO") || p.getEstado().equals("EN CARTELERA")) {
                %>
                <div class="tarjeta">
                    <img src="images/poster/<%=p.getArchivo()%>"/><br>
                    <a href="movie.jsp?id=<%=p.getId()%>&titulo=<%=p.getTitulo()%>&estado=<%=p.getEstado()%>&archivo=<%=p.getArchivo()%>">VER HORARIOS</a>
                </div>
                <%
                        }
                    }
                %>  
            </div>
        </section>
        <section class="proximamente">
            <h2>PROXIMAMENTE</h2>
            <div class="carrusel">
                <%
                    for (Pelicula p : peliculas) {
                        if (p.getEstado().equals("PROXIMAMENTE")) {
                %>
                <div class="tarjeta">
                    <img src="images/poster/<%=p.getArchivo()%>"/><br>
                </div>
                <%
                        }
                    }
                %>  
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
    </body> 
</html>
