<%@page import="dao.Negocio"%>
<%@page import="java.util.*"%>
<%@page import="beans.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="style-buy.css">
        <title>Seleccionar asientos | ChollyMovie</title>
    </head>
    <body>
        <%
            Negocio obj = new Negocio();
            String id = (String) request.getParameter("id");
            String titulo = (String) request.getParameter("titulo");
            String archivo = (String) request.getParameter("archivo");
            String estadoPelicula = (String) request.getParameter("estado");
            List<String> asientos = new ArrayList<>();
            String nombre = (String) session.getAttribute("usuario_nombre");
            String apellido = (String) session.getAttribute("usuario_apellido");
            String PK = (String) session.getAttribute("usuario_PK");
            double precioEstreno = 21.0;
            double precioCartelera = 15.0;
            double precioTicket = estadoPelicula.equals("ESTRENO") ? precioEstreno : precioCartelera;
            List<String> asientosOcupados = new ArrayList<>();

            // Obtener las reservas para la función seleccionada
            List<Reserva> reservasFuncion = obj.listReservaFuncion(id);
            for (Reserva reserva : reservasFuncion) {
                // Dividir la cadena de asientos y agregarlos a la lista
                String[] asientosReserva = reserva.getAsientos().split(",");
                asientosOcupados.addAll(Arrays.asList(asientosReserva));
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
                    <% }%>
            </ul>
        </header>
        <div class="video"></div>
        <section class="cuerpo">
            <div class="movie-container">
                <label>Función seleccionada: <%=titulo%></label>
            </div>
            <ul class="showcase">
                <li>
                    <div class="seat"></div>
                    <small>Disponible</small>
                </li>
                <li>
                    <div class="seat selected"></div>
                    <small>Seleccionado</small>
                </li>
                <li>
                    <div class="seat sold"></div>
                    <small>Ocupado</small>
                </li>
            </ul>
            <div class="container">
                <div class="screen"></div>
                <form>
                    <% for (char rowLetter = 'A'; rowLetter <= 'N'; rowLetter++) { %>
                    <div class="row">
                        <% for (int i = 1; i <= 14; i++) {
                                // Verificar si el asiento está ocupado y marcarlo en consecuencia
                                String seatName = rowLetter + String.valueOf(i);
                                boolean isOccupied = asientosOcupados.contains(seatName);
                        %>
                        <div class="seat <%= isOccupied ? "sold" : ""%> seat-text" onclick="<%= isOccupied ? "" : "toggleSeat(this)"%>">
                            <%= seatName%>
                        </div>
                        <% } %>
                    </div>
                    <% }%>
                </form>
            </div>
            <p class="text">
                Has seleccionado <span id="count">0</span> asiento(s) por un precio de S/.<span id="total">0</span>
            </p>
            <a id="continueButton" href="#">CONTINUAR COMPRA</a>
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
        <script src="script-buy.js"></script>
        <script>
            var movieId = '<%=id%>';
            var ticketPrice = <%= precioTicket%>;
        </script>
    </body> 
</html>
