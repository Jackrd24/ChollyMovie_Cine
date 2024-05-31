<%@page import="dao.Negocio"%>
<%@page import="java.util.*"%>
<%@page import="beans.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="style-confirm_purchase.css">
        <title>Confirmar Compra | ChollyMovie</title>
    </head>
    <body>
        <%
            Negocio obj = new Negocio();
            String id = (String) request.getParameter("id");
            String asientos = (String) request.getParameter("asientos");
            String precioParameter = request.getParameter("precio");
            double precio = (precioParameter != null && !precioParameter.trim().isEmpty())
                    ? Double.parseDouble(precioParameter) : 0.0;
            String nombre = (String) session.getAttribute("usuario_nombre");
            String apellido = (String) session.getAttribute("usuario_apellido");
            String correo = (String) session.getAttribute("usuario_correo");
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
                    <% } %>
                <li><a href="shopping-history.jsp">COMPRAS</a></li>
                <li><a href="control?opc=2">CERRAR SESIÓN</a></li>
                    <% } else { %>
                <li><a href="login.jsp">INICIAR SESIÓN</a></li>
                    <% }%>
            </ul>
        </header>
        <div class="video"></div>
        <section class="cuerpo">
            <h2>CONFIRMAR DATOS</h2>
            <form action="control" method="GET">
                <input type="hidden" name="opc" value="3">
                <input type="hidden" name="funcion" value="<%=id%>">
                <input type="hidden" name="cliente" value="<%=PK%>">
                <input type="hidden" name="asientos" value="<%=asientos%>">
                <input type="hidden" name="precio" value="<%=precio%>">
                <label>Función: <%=id%></label>
                <label>Asientos: <%=asientos%></label>
                <label>Precio: S/. <%=precio%></label>
                <input type="submit" value="COMPRAR">
            </form>
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
