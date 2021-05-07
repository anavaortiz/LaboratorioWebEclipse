/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import Conector.Conector;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;


@WebServlet("/Proveedores")
//@WebServlet(name = "proveedores", urlPatterns = {"/proveedores"})
public class Proveedores extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	Statement st = null;
    ResultSet rs = null;
    
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException {

        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            Conector con = new Conector();
            Connection conn = con.conn();
            try {

                
                st = conn.createStatement();
                String strQuery = "SELECT * FROM `Proveedores`";
                String strWhere = " WHERE 1=1";
                String strNombre = request.getParameter("Nombre");

                if (strNombre != null) {
                    strNombre = this.mysql_real_scape_string(strNombre);
                    strWhere = strWhere + " and Nombre = ? "; // consulta preparada
                }
                strQuery = strQuery + strWhere;

                
                PreparedStatement Preparar = conn.prepareStatement(strQuery);
                if (strNombre != null) {
                    Preparar.setString(1, strNombre);
                }

                rs = Preparar.executeQuery();

                while (rs.next()) {

                    out.print("<tr>"
                            + "<th scope=\"row\">" + rs.getString(1) + " </th>"
                            + "<td>" + rs.getString(2) + " </td>"
                            + "<td>" + rs.getString(3) + " </td>"
                            + "<td>" + rs.getString(4) + " </td>"
                            + "<td>" + rs.getString(5) + " </td>"
                            + "<td>" + rs.getString(6) + " </td>"
                            + "<td>" + rs.getString(7) + " </td>"
                            + "<td>"
                            + " <!-- Edita el nombre, dirección\n"
                            + "                                        y teléfono de un emppleado\n"
                            + "                                    -->"
                            + "<a href=\"editar.jsp?id=" + rs.getString(1) + " \n"
                            + "          &nombre=" + rs.getString(2) + " \n"
                            + "          &telefono=" + rs.getString(3) + " \n"
                            + "          &email=" + rs.getString(4) + " \n"
                            + "          &direccion=" + rs.getString(5) + " \n"
                            + "          &ciudad=" + rs.getString(6) + " \n"
                            + "          &pais=" + rs.getString(7)
                            + "\" >"
                            + "<i class=\"fa fa-pencil\" \n"
                            + "                                           aria-hidden=\"true\"></i></a>"
                            + "<a href=\"borrar.jsp?id=" + rs.getString(1) + " \n"
                            + "          class=\"ml-3\" >\n"
                            + "          <i class=\"fa fa-trash\" \n"
                            + "          aria-hidden=\"true\"></i></a> "
                            + "</td>"
                            + "</tr>");
                   
                    
                }
            } catch (Exception e) {
                out.print("Error MySQL " + e);
            } finally {
                try {
                    st.close();
                    rs.close();
                    conn.close();
                } catch (SQLException ex) {
                    Logger.getLogger(Proveedores.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

        }
    }

    // ... Sanitiza las consultas ...
    public String mysql_real_scape_string(String texto) {
        texto = texto.replaceAll("\\\\", "\\\\`");
        texto = texto.replaceAll("\\n", "\\\\n'");
        texto = texto.replaceAll("\\r", "\\\\r'");
        texto = texto.replaceAll("\\t", "\\\\t'");
        texto = texto.replaceAll("'", "\\\\'");
        return texto;
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
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Proveedores.class.getName()).log(Level.SEVERE, null, ex);
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
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Proveedores.class.getName()).log(Level.SEVERE, null, ex);
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