<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="style-login.css">
        <title>Login | ChollyMovie</title>
    </head>
    <body>
        <form action="control" method="GET">
            <input type="hidden" name="opc" value="1">
            <h2>INICIO DE SESIÓN</h2>
            <label>Correo electrónico</label>
            <input type="email" name="correo" placeholder="Ingrese correo electrónico" required>
            <label>Contraseña</label>
            <input type="password" name="contraseña" placeholder="Ingrese contraseña" required>
            <input type="submit" value="INICIAR SESIÓN">
            <a href="index.jsp">Volver</a>
        </form>
    </body>
</html>
