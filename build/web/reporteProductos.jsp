<%@ include file="../includes/menu.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="modelo.ProductoReporte" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Reporte de Productos</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-light">

<!-- 📦 CONTENIDO PRINCIPAL -->
<div class="main-content">
    <div class="container-fluid mt-4">

        <!-- 🔹 Barra de navegación -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h3 class="fw-bold text-dark mb-0">
                <i class="bi bi-graph-up-arrow"></i> 
                <%= request.getAttribute("titulo") %>
            </h3>

            <div>
                <a href="<%= request.getContextPath() %>/index.jsp" class="btn btn-secondary me-2">
                    <i class="bi bi-arrow-left-circle"></i> Volver al Menú
                </a>
                <a href="<%= request.getContextPath() %>/ReporteProductosPDF?tipo=<%= request.getParameter("tipo") != null ? request.getParameter("tipo") : "venta" %>"
                   target="_blank" class="btn btn-danger">
                    <i class="bi bi-file-earmark-pdf"></i> Exportar a PDF
                </a>
            </div>
        </div>

        <%
            List<ProductoReporte> productos = (List<ProductoReporte>) request.getAttribute("productos");
        %>

        <!-- 🔹 Tabla de productos -->
        <div class="card shadow-sm border-0 mb-4">
            <div class="card-body">
                <table class="table table-bordered table-striped align-middle mb-0">
                    <thead class="table-dark text-center">
                        <tr>
                            <th>Producto</th>
                            <th>Cantidad</th>
                            <th>Total (Q)</th>
                        </tr>
                    </thead>
                    <tbody>
                    <% if (productos != null && !productos.isEmpty()) {
                           for (ProductoReporte p : productos) { %>
                        <tr>
                            <td><%= p.getNombre() %></td>
                            <td class="text-center"><%= p.getCantidad() %></td>
                            <td class="text-end">Q <%= String.format("%.2f", p.getTotal()) %></td>
                        </tr>
                    <% } } else { %>
                        <tr><td colspan="3" class="text-center text-muted py-3">No hay datos disponibles</td></tr>
                    <% } %>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- 🔹 Gráfico de productos -->
        <div class="card shadow-sm border-0 mt-5 mb-5">
            <div class="card-body">
                <h5 class="card-title text-center mb-4">Gráfico de Productos</h5>
                <canvas id="graficoProductos" height="120"></canvas>
            </div>
        </div>

    </div>
</div> <!-- 🧩 Cierre de main-content -->

<!-- 🔹 Script del gráfico -->
<script>
const ctx = document.getElementById('graficoProductos').getContext('2d');

const datos = [
    <% if (productos != null) {
           for (ProductoReporte p : productos) { %>
               { nombre: "<%= p.getNombre() %>", cantidad: <%= p.getCantidad() %> },
    <%     }
       } %>
];

const nombres = datos.map(d => d.nombre);
const cantidades = datos.map(d => d.cantidad);

if (nombres.length > 0) {
    new Chart(ctx, {
        type: 'bar',
        data: {
            labels: nombres,
            datasets: [{
                label: 'Cantidad',
                data: cantidades,
                backgroundColor: 'rgba(54, 162, 235, 0.8)',
                borderRadius: 6,
                barThickness: 25
            }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: { display: false },
                title: { 
                    display: true, 
                    text: '<%= request.getAttribute("titulo") %>', 
                    font: { size: 18 } 
                }
            },
            scales: {
                x: { ticks: { autoSkip: false, maxRotation: 45, font: { size: 11 } } },
                y: { beginAtZero: true }
            }
        }
    });
}
</script>

</body>
</html>
