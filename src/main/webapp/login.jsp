
<%@page import="java.sql.*"%>
<%@page import="Conector.Conector"%>
<%@page import="Utils.Encriptar"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" 
              rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" 
              crossorigin="anonymous">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" 
              integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" 
              crossorigin="anonymous">
        <title>Login</title>
    </head>
    <body>
        <div class="container mt-5">
            <div class="row">
                <div class="col-sm">

                    <form method="post" action="login.jsp">
                        <div class="form-group">
                            <label>Usuario</label>
                            <input type="text" class="form-control"
                                   name="Usuario"
                                   placeholder="Introduzca su usuario">
                        </div>
                        <div class="form-group">
                            <label>Password</label>
                            <input type="password" class="form-control"
                                   name="Password"
                                   placeholder="Introduzca su contraseña">
                        </div>

                        <button type="submit" class="btn btn-primary"
                                name="Login">Login</button>
                    </form>
                    <%
                        Conector con = new Conector();
                        Connection conn = con.conn();
                        Statement st = null;
                        ResultSet rs = null;
                        Encriptar enc = new Encriptar();
                        

                        if (request.getParameter("Login") != null) {
                            String strUsuario = request.getParameter("Usuario");
                            String strPassword = request.getParameter("Password");

                            HttpSession Session = request.getSession();

                            try {
                                st = conn.createStatement();
                                
                                String strQuery = "SELECT * FROM Usuarios "
                                        + "WHERE Usuario = '" + strUsuario + "' "
                                        + "AND Password = '" + enc.getMD5(strPassword)
                                        + "';";
                                rs = st.executeQuery(strQuery);
                                while (rs.next()) {
                                    Session.setAttribute("logueado", "1");
                                    Session.setAttribute("Usuario",
                                            rs.getString("Usuario"));

                                    Session.setAttribute("id",
                                            rs.getString("IDUsuario"));

                                    response.sendRedirect("index.jsp");
                                }

                                out.print("Usuario no válido");

                            } catch (Exception e) {
                                out.print(e);
                            }finally{
                                try{
                                    rs.close();
                                    st.close();
                                    conn.close();
                                }catch(SQLException e){
                                    out.print(e.getMessage());
                                }
                            }
                        }
                    %>


                </div>
            </div>
        </div>
    </body>
</html>
