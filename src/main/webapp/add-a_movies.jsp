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
            <h2>REGISTRO DE SEDE</h2>
            <form action="control" method="GET" enctype="multipart/form-data">
                <input type="hidden" name="opc" value="8">
                <table border="1">
                    <tr>
                        <td>TITULO</td>
                        <td><input name="titulo" placeholder="Ingrese una dirección"></td>
                    </tr>
                    <tr>
                        <td>DESCRIPCION</td>
                        <td><input name="descripcion" placeholder="Ingrese una dirección"></td>
                    </tr>
                    <tr>
                        <td>DURACION</td>
                        <td><input name="duracion" placeholder="Ingrese una dirección"></td>
                    </tr>
                    <tr>
                        <td>CLASIFICACION</td>
                        <td><input name="clasificacion" placeholder="Ingrese una dirección"></td>
                    </tr>
                    <tr>
                        <td>ARCHIVO</td>
                        <td><input type="file" name="archivo" placeholder="Seleccione un archivo"></td>
                    </tr>
                    <tr>
                        <td>ESTADO</td>
                        <td>
                            <select name="estado" id="estado">
                                <option value="ESTRENO">ESTRENO</option>
                                <option value="EN CARTELERA">EN CARTELERA</option>
                                <option value="PROXIMAMENTE">PROXIMAMENTE</option>
                            </select>
                        </td>
                    </tr>
                </table>
                <input type="submit" value="REGISTRAR">
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