package controlador;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import beans.*;
import dao.Negocio;
import java.io.File;
import java.io.PrintWriter;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import org.primefaces.json.JSONException;
import org.primefaces.json.JSONObject;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

public class control extends HttpServlet {

    Negocio obj = new Negocio();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, JSONException {
        int op = Integer.parseInt(request.getParameter("opc"));
        switch (op) {
            case 1:
                login(request, response);
                break;
            case 2:
                logout(request, response);
                break;
            case 3:
                purchase(request, response);
                break;
            case 4:
                movies(request, response);
                break;
            case 5:
                addCampus(request, response);
                break;
            case 6:
                updateCampus(request, response);
                break;
            case 7:
                deleteCampus(request, response);
                break;
            case 8:
                addMovie(request, response);
                break;
            case 9:
                updateMovie(request, response);
                break;
            case 10:
                deleteMovie(request, response);
                break;
            default:
                break;
        }
    }

    protected void purchase(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String funcion = request.getParameter("funcion");
        String cliente = request.getParameter("cliente");
        String asientos = request.getParameter("asientos");
        double precio = Double.parseDouble(request.getParameter("precio"));
        String id = obj.purchase(funcion, cliente, asientos, precio);
        if (id != null) {
            String pag = "/ticket.jsp?reserva=" + id + "&funcion=" + funcion + "&cliente=" + cliente + "&asientos=" + asientos + "&precio=" + precio;
            response.sendRedirect(request.getContextPath() + pag);
        } else {
            String pag = "/index.jsp";
            response.sendRedirect(request.getContextPath() + pag);
        }
    }

    protected void logout(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getSession().removeAttribute("logged");
        response.sendRedirect("index.jsp");
    }

    protected void login(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String correo = request.getParameter("correo");
        String contraseña = request.getParameter("contraseña");
        Cliente c = obj.login(correo, contraseña);
        if (c != null) {
            String nombre = c.getNombre();
            String apellido = c.getApellido();
            String PK = c.getId();
            String pag = "/index.jsp";
            request.getSession().setAttribute("usuario_nombre", nombre);
            request.getSession().setAttribute("usuario_apellido", apellido);
            request.getSession().setAttribute("usuario_correo", correo);
            request.getSession().setAttribute("usuario_PK", PK);
            request.getSession().setAttribute("logged", true);
            response.sendRedirect(request.getContextPath() + pag);
        } else {
            String pag = "/login.jsp";
            response.sendRedirect(request.getContextPath() + pag);
        }
    }

    private void movies(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, JSONException {
        String sede = request.getParameter("sede");
        String pelicula = request.getParameter("pelicula");
        List<Funcion> funcionesFiltradas = null;
        funcionesFiltradas = obj.listFuncionesFiltradas(pelicula, sede);

        // Crear un objeto JSON para enviar la respuesta al cliente
        JSONObject jsonResponse = new JSONObject();
        if (funcionesFiltradas != null) {
            request.getSession().setAttribute("list_funciones", funcionesFiltradas);
            jsonResponse.put("success", true);
        } else {
            jsonResponse.put("success", false);
        }

        // Configurar la respuesta del servlet
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsonResponse.toString());
    }

    private void addCampus(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String direccion = request.getParameter("direccion");
        obj.agregarSede(direccion);
        String pag = "/campus.jsp";
        response.sendRedirect(request.getContextPath() + pag);
    }

    private void updateCampus(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        String direccion = request.getParameter("direccion");
        obj.actualizarSede(id, direccion);
        String pag = "/campus.jsp";
        response.sendRedirect(request.getContextPath() + pag);
    }

    private void deleteCampus(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, JSONException {
        String id = request.getParameter("id");
        boolean eliminacionExitosa = obj.eliminarSede(id);

        // Crear un objeto JSON para enviar la respuesta al cliente
        JSONObject jsonResponse = new JSONObject();
        jsonResponse.put("success", eliminacionExitosa);

        // Configurar la respuesta del servlet
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsonResponse.toString());
    }

    private void addMovie(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String titulo = request.getParameter("titulo");
        String descripcion = request.getParameter("descripcion");
        int duracion = Integer.parseInt(request.getParameter("duracion"));
        String clasificacion = request.getParameter("clasificacion");
        String archivo = null;
        String estado = request.getParameter("estado");

        if (ServletFileUpload.isMultipartContent(request)) {
            try {
                List<FileItem> items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);

                for (FileItem item : items) {
                    if (!item.isFormField()) {
                        archivo = new File(item.getName()).getName();  // Obtener solo el nombre del archivo
                        String filePath = "D:\\UTP\\CICLO VI\\DESARROLLO WEB INTEGRADO\\ChollyMovie_Final\\src\\main\\webapp\\images\\poster\\" + archivo;  // Ruta donde deseas guardar el archivo

                        try {
                            item.write(new File(filePath));  // Guardar el archivo
                            System.out.println("Archivo guardado con éxito en: " + filePath);
                        } catch (Exception e) {
                            System.out.println("Error al guardar el archivo: " + e.getMessage());
                            e.printStackTrace();
                        }
                    }
                }
            } catch (Exception e) {
                System.out.println("Error al procesar la carga del archivo: " + e.getMessage());
                e.printStackTrace();
            }
        }

        obj.agregarPelicula(titulo, descripcion, duracion, clasificacion, archivo, estado);
        String pag = "/a_movies.jsp";
        response.sendRedirect(request.getContextPath() + pag);
    }

    private void updateMovie(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        String direccion = request.getParameter("direccion");
        obj.actualizarSede(id, direccion);
        String pag = "/a_movies.jsp";
        response.sendRedirect(request.getContextPath() + pag);
    }

    private void deleteMovie(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, JSONException {
        String id = request.getParameter("id");
        boolean eliminacionExitosa = obj.eliminarSede(id);

        // Crear un objeto JSON para enviar la respuesta al cliente
        JSONObject jsonResponse = new JSONObject();
        jsonResponse.put("success", eliminacionExitosa);

        // Configurar la respuesta del servlet
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsonResponse.toString());
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (JSONException ex) {
            Logger.getLogger(control.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (JSONException ex) {
            Logger.getLogger(control.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
