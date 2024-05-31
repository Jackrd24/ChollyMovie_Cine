<%@page import="dao.Negocio"%>
<%@page import="java.util.*"%>
<%@page import="beans.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="style-shopping_history.css">
        <script src="jquery.min.js"></script>
        <script src="qrcode.min.js"></script>
        <title>Compras | ChollyMovie</title>
    </head>
    <body>
        <%
            Negocio obj = new Negocio();
            String nombre = (String) session.getAttribute("usuario_nombre");
            String apellido = (String) session.getAttribute("usuario_apellido");
            String PK = (String) session.getAttribute("usuario_PK");
            List<Reserva> reservas = obj.listReserva(PK);
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
        <video src="images/background/video_background.mp4" autoplay muted loop style="max-width: 100%"></video>
        <section class="cuerpo">
            <h2>TICKET DE COMPRA</h2>
            <div class="tarjetas-container">
                <%
                    for (Reserva r : reservas) {
                        String qrDivId = "qrcode_" + r.getId();
                %>
                <div class="tarjeta">
                    <div class="tarjeta-info">
                        <p><strong>CÓDIGO DE RESERVA:</strong> <%=r.getId()%></p>
                        <p><strong>FUNCIÓN:</strong> <%=r.getId_funcion()%></p>
                        <p><strong>ASIENTOS:</strong> <%=r.getAsientos()%></p>
                        <p><strong>PRECIO TOTAL:</strong> S/. <%=r.getPrecio()%></p>
                    </div>
                    <div class="tarjeta-qr" id="<%=qrDivId%>"></div>
                    <script>
                        // Obtén el elemento div donde se mostrará el código QR
                        var qrCodeDiv_<%=r.getId()%> = document.getElementById('<%=qrDivId%>');

                        // Usa el ID único de la reserva como dato para generar el código QR
                        var qrData_<%=r.getId()%> = "<%=r.getId()%>";

                        // Crea el código QR
                        var qrcode_<%=r.getId()%> = new QRCode(qrCodeDiv_<%=r.getId()%>, {
                            text: qrData_<%=r.getId()%>,
                            width: 128,
                            height: 128
                        });
                    </script>
                </div>
                <%
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
