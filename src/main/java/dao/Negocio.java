package dao;

import beans.*;
import java.sql.*;
import java.util.*;
import util.MySQLConexion;

public class Negocio {

    public Cliente login(String correo, String contrasena) {
        Connection cn = null;
        Cliente c = null;

        try {
            cn = MySQLConexion.getConexion();
            String sql = "SELECT * FROM Clientes WHERE correo=? AND contraseña=?";
            PreparedStatement st = cn.prepareStatement(sql);
            st.setString(1, correo);
            st.setString(2, contrasena);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                c = new Cliente();
                c.setId(rs.getString(1));
                c.setNombre(rs.getString(2));
                c.setApellido(rs.getString(3));
                c.setCorreo(rs.getString(4));
                c.setTelefono(rs.getInt(5));
                c.setDni(rs.getString(6));
                c.setContraseña(rs.getString(7));
                c.setNivel(rs.getString(8));
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (Exception e2) {
            }
        }

        return c;
    }

    public boolean register(Cliente c) {
        Connection cn = null;
        boolean status = false;

        try {
            cn = MySQLConexion.getConexion();
            String id = generarIdCliente();
            String sql = "INSERT INTO Clientes (id_cliente, nombre, apellido, correo, telefono, dni, contraseña, nivel) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement st = cn.prepareStatement(sql);
            st.setString(1, id);
            st.setString(2, c.getNombre());
            st.setString(3, c.getApellido());
            st.setString(4, c.getCorreo());
            st.setInt(5, c.getTelefono());
            st.setString(6, c.getDni());
            st.setString(7, c.getContraseña());
            st.setString(8, c.getNivel());

            int filasAfectadas = st.executeUpdate();
            if (filasAfectadas > 0) {
                status = true;
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (Exception e2) {
            }
        }

        return status;
    }

    public String purchase(String id_funcion, String id_cliente, String asientos, double precio) {
        Connection cn = null;
        String id = null;

        try {
            cn = MySQLConexion.getConexion();
            id = generarIdReserva();
            String sql = "INSERT INTO Reservas (id_reserva, id_funcion, id_cliente, asientos, precio) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement st = cn.prepareStatement(sql);
            st.setString(1, id);
            st.setString(2, id_funcion);
            st.setString(3, id_cliente);
            st.setString(4, asientos);
            st.setDouble(5, precio);

            int filasAfectadas = st.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (Exception e2) {
            }
        }

        return id;
    }

    public List<Pelicula> listPeliculas() {
        Connection cn = null;
        Pelicula p = null;
        List<Pelicula> lista = new ArrayList<>();

        try {
            cn = MySQLConexion.getConexion();
            String sql = "SELECT * FROM Peliculas";
            PreparedStatement st = cn.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {  // Cambia de 'if' a 'while' para recorrer todas las filas
                p = new Pelicula();
                p.setId(rs.getString(1));
                p.setTitulo(rs.getString(2));
                p.setDescripcion(rs.getString(3));
                p.setDuracion(rs.getInt(4));
                p.setClasificacion(rs.getString(5));
                p.setArchivo(rs.getString(6));
                p.setEstado(rs.getString(7));
                lista.add(p);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (Exception e2) {
            }
        }

        return lista;
    }

    public List<Sede> listSedes() {
        Connection cn = null;
        Sede s = null;
        List<Sede> lista = new ArrayList<>();

        try {
            cn = MySQLConexion.getConexion();
            String sql = "SELECT * FROM Sedes";
            PreparedStatement st = cn.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {  // Cambia de 'if' a 'while' para recorrer todas las filas
                s = new Sede();
                s.setId(rs.getString(1));
                s.setDireccion(rs.getString(2));
                lista.add(s);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (Exception e2) {
            }
        }

        return lista;
    }

    public boolean agregarSede(String direccion) {
        Connection cn = null;
        boolean status = false;

        try {
            cn = MySQLConexion.getConexion();
            String id = generarIdSede();
            String sql = "INSERT INTO Sedes (id_sede, direccion) VALUES (?,?)";
            PreparedStatement st = cn.prepareStatement(sql);
            st.setString(1, id);
            st.setString(2, direccion);

            int filasAfectadas = st.executeUpdate();
            if (filasAfectadas > 0) {
                status = true;
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (Exception e2) {
            }
        }

        return status;
    }

    public boolean actualizarSede(String id, String direccion) {
        Connection cn = null;
        boolean status = false;

        try {
            cn = MySQLConexion.getConexion();
            String sql = "UPDATE Sedes SET direccion=? WHERE id_sede=?";
            PreparedStatement st = cn.prepareStatement(sql);
            st.setString(1, direccion);
            st.setString(2, id);

            int filasAfectadas = st.executeUpdate();
            if (filasAfectadas > 0) {
                status = true;
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (Exception e2) {
            }
        }

        return status;
    }

    public boolean eliminarSede(String id) {
        Connection cn = null;
        boolean status = false;

        try {
            cn = MySQLConexion.getConexion();
            String sql = "DELETE FROM Sedes WHERE id_sede=?";
            PreparedStatement st = cn.prepareStatement(sql);
            st.setString(1, id);

            int filasAfectadas = st.executeUpdate();
            if (filasAfectadas > 0) {
                status = true;
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (Exception e2) {
            }
        }

        return status;
    }

    public boolean agregarPelicula(String titulo, String descripcion, int duracion, String clasificacion, String archivo, String estado) {
        Connection cn = null;
        boolean status = false;

        try {
            cn = MySQLConexion.getConexion();
            String id = generarIdPelicula();
            String sql = "INSERT INTO Peliculas (id_pelicula, titulo, descripcion, duracion, clasificacion, archivo, estado) VALUES (?,?,?,?,?,?,?)";
            PreparedStatement st = cn.prepareStatement(sql);
            st.setString(1, id);
            st.setString(2, titulo);
            st.setString(3, descripcion);
            st.setInt(4, duracion);
            st.setString(5, clasificacion);
            st.setString(6, archivo);
            st.setString(7, estado);

            int filasAfectadas = st.executeUpdate();
            if (filasAfectadas > 0) {
                status = true;
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (Exception e2) {
            }
        }

        return status;
    }

    public boolean actualizarPelicula(String id, String direccion) {
        Connection cn = null;
        boolean status = false;

        try {
            cn = MySQLConexion.getConexion();
            String sql = "UPDATE Sedes SET direccion=? WHERE id_sede=?";
            PreparedStatement st = cn.prepareStatement(sql);
            st.setString(1, direccion);
            st.setString(2, id);

            int filasAfectadas = st.executeUpdate();
            if (filasAfectadas > 0) {
                status = true;
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (Exception e2) {
            }
        }

        return status;
    }

    public boolean eliminarPelicula(String id) {
        Connection cn = null;
        boolean status = false;

        try {
            cn = MySQLConexion.getConexion();
            String sql = "DELETE FROM Sedes WHERE id_sede=?";
            PreparedStatement st = cn.prepareStatement(sql);
            st.setString(1, id);

            int filasAfectadas = st.executeUpdate();
            if (filasAfectadas > 0) {
                status = true;
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (Exception e2) {
            }
        }

        return status;
    }

    public List<Sala> listSalas(String id_sede) {
        Connection cn = null;
        Sala s = null;
        List<Sala> lista = new ArrayList<>();

        try {
            cn = MySQLConexion.getConexion();
            String sql = "SELECT * FROM Salas";
            PreparedStatement st = cn.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {  // Cambia de 'if' a 'while' para recorrer todas las filas
                s = new Sala();
                s.setId(rs.getString(1));
                s.setNombre(rs.getString(2));
                s.setCapacidad(rs.getInt(3));
                lista.add(s);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (Exception e2) {
            }
        }

        return lista;
    }

    public List<Funcion> listFuncionesPelicula(String id_pelicula) {
        Connection cn = null;
        Funcion f = null;
        List<Funcion> lista = new ArrayList<>();

        try {
            cn = MySQLConexion.getConexion();
            String sql = "SELECT * FROM Funciones WHERE id_pelicula=?";
            PreparedStatement st = cn.prepareStatement(sql);
            st.setString(1, id_pelicula);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {  // Cambia de 'if' a 'while' para recorrer todas las filas
                f = new Funcion();
                f.setId(rs.getString(1));
                f.setFecha(rs.getString(4));
                f.setHora(rs.getString(5));
                lista.add(f);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (Exception e2) {
            }
        }

        return lista;
    }

    public List<Reserva> listReserva(String id_cliente) {
        Connection cn = null;
        Reserva r = null;
        List<Reserva> lista = new ArrayList<>();

        try {
            cn = MySQLConexion.getConexion();
            String sql = "SELECT * FROM Reservas WHERE id_cliente=?";
            PreparedStatement st = cn.prepareStatement(sql);
            st.setString(1, id_cliente);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {  // Cambia de 'if' a 'while' para recorrer todas las filas
                r = new Reserva();
                r.setId(rs.getString(1));
                r.setId_funcion(rs.getString(2));
                r.setId_cliente(rs.getString(3));
                r.setAsientos(rs.getString(4));
                r.setPrecio(rs.getDouble(5));
                lista.add(r);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (Exception e2) {
            }
        }

        return lista;
    }

    public List<Reserva> listReservaFuncion(String id_funcion) {
        Connection cn = null;
        Reserva r = null;
        List<Reserva> lista = new ArrayList<>();

        try {
            cn = MySQLConexion.getConexion();
            String sql = "SELECT * FROM Reservas WHERE id_funcion=?";
            PreparedStatement st = cn.prepareStatement(sql);
            st.setString(1, id_funcion);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                r = new Reserva();
                r.setId(rs.getString(1));
                r.setId_funcion(rs.getString(2));
                r.setId_cliente(rs.getString(3));
                r.setAsientos(rs.getString(4));
                lista.add(r);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (Exception e2) {
                e2.printStackTrace();
            }
        }

        return lista;
    }

    public List<Funcion> listFuncionesFiltradas(String id_pelicula, String id_sed) {
        Connection cn = null;
        Funcion f = null;
        List<Funcion> lista = new ArrayList<>();

        try {
            cn = MySQLConexion.getConexion();
            String sql = "SELECT f.* FROM Funciones f INNER JOIN Salas s ON f.id_sala=s.id_sala WHERE f.id_pelicula=? AND s.id_sede";
            PreparedStatement st = cn.prepareStatement(sql);
            st.setString(1, id_pelicula);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {  // Cambia de 'if' a 'while' para recorrer todas las filas
                f = new Funcion();
                f.setId(rs.getString(1));
                f.setFecha(rs.getString(4));
                f.setHora(rs.getString(5));
                lista.add(f);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (Exception e2) {
            }
        }

        return lista;
    }

    public String generarIdCliente() {
        Connection cn = null;
        String nuevoId = null;

        try {
            cn = MySQLConexion.getConexion();
            String sql = "SELECT MAX(SUBSTRING(id_cliente, 2) + 1) AS nuevo_id FROM Clientes";
            PreparedStatement st = cn.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                int siguienteNumero = rs.getInt("nuevo_id");
                nuevoId = "U" + String.format("%04d", siguienteNumero);
            } else {
                nuevoId = "U0001";
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (Exception e2) {
            }
        }
        return nuevoId;
    }

    public String generarIdReserva() {
        Connection cn = null;
        String nuevoId = null;

        try {
            cn = MySQLConexion.getConexion();
            String sql = "SELECT MAX(SUBSTRING(id_reserva, 2) + 1) AS nuevo_id FROM Reservas";
            PreparedStatement st = cn.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                int siguienteNumero = rs.getInt("nuevo_id");
                nuevoId = "R" + String.format("%04d", siguienteNumero);
            } else {
                nuevoId = "R0001";
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (Exception e2) {
            }
        }
        return nuevoId;
    }

    public String generarIdPelicula() {
        Connection cn = null;
        String nuevoId = null;

        try {
            cn = MySQLConexion.getConexion();
            String sql = "SELECT MAX(SUBSTRING(id_pelicula, 2) + 1) AS nuevo_id FROM Peliculas";
            PreparedStatement st = cn.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                int siguienteNumero = rs.getInt("nuevo_id");
                nuevoId = "P" + String.format("%04d", siguienteNumero);
            } else {
                nuevoId = "P0001";
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (Exception e2) {
            }
        }
        return nuevoId;
    }

    public String generarIdSede() {
        Connection cn = null;
        String nuevoId = null;

        try {
            cn = MySQLConexion.getConexion();
            String sql = "SELECT MAX(CAST(SUBSTRING(id_sede, 3) AS UNSIGNED)) + 1 AS nuevo_id FROM Sedes";
            PreparedStatement st = cn.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                int siguienteNumero = rs.getInt("nuevo_id");
                nuevoId = "SE" + String.format("%03d", siguienteNumero);
            } else {
                nuevoId = "SE001";
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (Exception e2) {
                e2.printStackTrace();
            }
        }
        return nuevoId;
    }

    // Método para obtener reservas totales por sede en un año específico
    public List<ReservasSede> lisReservasTotalesPorSede(int an) {
        List<ReservasSede> lis = new ArrayList<>();
        Connection conn = null;
        try {
            conn = MySQLConexion.getConexion();
            String sql = "{call spReservasTotalesPorSedeEnAnio(?)}";

            CallableStatement st = conn.prepareCall(sql);
            st.setInt(1, an);

            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                ReservasSede reserva = new ReservasSede();
                reserva.setSede(rs.getString(1));
                reserva.setTotalReservas(rs.getInt(2));
                lis.add(reserva);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            try {
                if (conn != null) {
                    conn.close();
                }
            } catch (Exception e2) {
            }
        }
        return lis;
    }

// Método para obtener reservas totales por película en un año específico
    public List<ReservasPelicula> lisReservasTotalesPorPelicula(int an) {
        List<ReservasPelicula> lis = new ArrayList<>();
        Connection conn = null;
        try {
            conn = MySQLConexion.getConexion();
            String sql = "{call spReservasTotalesPorPeliculaEnAnio(?)}";

            CallableStatement st = conn.prepareCall(sql);
            st.setInt(1, an);

            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                ReservasPelicula reserva = new ReservasPelicula();
                reserva.setPelicula(rs.getString(1));
                reserva.setTotalReservas(rs.getInt(2));
                lis.add(reserva);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            try {
                if (conn != null) {
                    conn.close();
                }
            } catch (Exception e2) {
            }
        }
        return lis;
    }

// Método para obtener reservas por hora de la función (se debe ingresar el código de la película)
    public List<ReservasHora> lisReservasPorHoraDeFuncion(String idPelicula) {
        List<ReservasHora> lis = new ArrayList<>();
        Connection conn = null;
        try {
            conn = MySQLConexion.getConexion();
            String sql = "{call spReservasPorHoraDeFuncion(?)}";

            CallableStatement st = conn.prepareCall(sql);
            st.setString(1, idPelicula);

            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                ReservasHora reserva = new ReservasHora();
                reserva.setHoraFuncion(rs.getString(1));
                reserva.setTotalReservas(rs.getInt(2));
                lis.add(reserva);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            try {
                if (conn != null) {
                    conn.close();
                }
            } catch (Exception e2) {
            }
        }
        return lis;
    }
}
