<%@page import="dao.Negocio"%>
<%@page import="beans.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="style-ticket.css">
        <script src="jquery.min.js"></script>
        <script src="qrcode.min.js"></script>
        <title>Ticket de compra | ChollyMovie</title>
    </head>
    <body>
        <%
            Negocio obj = new Negocio();
            String reserva = (String) request.getParameter("reserva");
            String funcion = (String) request.getParameter("funcion");
            String cliente = (String) request.getParameter("cliente");
            String asientos = (String) request.getParameter("asientos");
            double precio = Double.parseDouble(request.getParameter("precio"));
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
            <h2>TICKET DE COMPRA</h2>
            <div id="ticket-info">
                <p>Número de reserva: <%=reserva%></p>
                <p>Número de función: <%=funcion%></p>
                <p>Asientos: <%=asientos%></p>
            </div>
            <div id="qrcode"></div>
            <script>
                // Obtén el elemento div donde se mostrará el código QR
                var qrCodeDiv = document.getElementById('qrcode');

                // Genera un número aleatorio (en este caso, puedes obtener el dato desde tu base de datos)
                var qrData = "<%=reserva%>";

                // Crea el código QR
                var qrcode = new QRCode(qrCodeDiv, {
                    text: qrData,
                    width: 128,
                    height: 128
                });
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
    </body> 
</html>
