
<%@page import="java.sql.*"%>
<%@page import="Conector.Conector"%>
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
        <title>Lista de proveedores</title>
    </head>
    <body>
        <%
            HttpSession Session = request.getSession();
            if (Session.getAttribute("logueado") == null || Session.getAttribute("logueado").equals("0")) {
                response.sendRedirect("login.jsp");
            }

            Conector con = new Conector();
            Connection conn = con.conn();

            Statement st = null;
            ResultSet rs = null;
        %>

        <div class = "container mt-5">
            <!-- Se agrega para el logout -->
            <nav class="navbar navbar-light bg-light">
                <a class="navbar-brand">Laboratorio Web Eclipse</a>
                <form class="form-inline" action="logout.jsp">

                    <!-- se agrega el href en el ancla que apunta a datosusuario -->
                    <a href="datosusuario.jsp"><i class="fa fa-user-circle-o" 
                                                  aria-hidden="true"></i>
                        <%= Session.getAttribute("Usuario")%>
                    </a>

                    <button class="btn btn-danger my-2 my-sm-0 ml-2" 
                            type="submit">Log out</button>
                </form>
            </nav>
            
            <div class="row mt-2"> <!-- se agreega el mt-2 -->
                <div class="col-sm">
                    <form action="index.jsp" method="get">
                        <table class="table table-striped">
                            <thead>
                                <tr>

                                    <!-- Se modifica el th -->
                                    <th scope="col" colspan="4" 
                                        class="text-center">
                                        <h3>Proveedores</h3>
                                    </th> 

                                    <th scope="col" class="text-center"></th>
                                    <th scope="col" class="text-center">
                                        
                                        <input type="text" name="Nombre" 
                                               class="form-control"
                                               placeholder="Buscar por nombre"/>
                                        
                                        
                                    </th>
                                    <th>
                                        <input type="submit" value="Buscar" 
                                               name = "Buscar" 
                                               class="form-control btn btn-primary" />    
                                    </th>

                                    <th></th>
                                    <th scope="col">
                                        <a href="crear.jsp" 
                                           title="Agrega un nuevo cliente">
                                            <i class="fa fa-user-plus" 
                                               aria-hidden="true"></i>
                                        </a>
                                    </th>
                                </tr>

                                <tr>
                                    <th scope="col">Id</th>
                                    <th scope="col">Nombre</th>
                                    <th scope="col">Teléfono</th>
                                    <th scope="col">Email</th>
                                    <th scope="col">Dirección</th>
                                    <th scope="col">Ciudad</th>
                                    <th scope="col">País</th>
                                    <th scope="col">Acciones</th> <!-- lo acabo de agregar -->
                                </tr>
                            </thead>
                            <tbody>
                                <!-- <jsp:include page="Proveedores" /> -->
                                <jsp:forward page="Proveedores" />
                                
                            </tbody>
                        </table>
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>