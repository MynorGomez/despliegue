<%@ include file="../includes/menu.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Reporte de Ventas</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-light">

<!-- 🔹 CONTENIDO PRINCIPAL (respeta el menú lateral) -->
<div class="main-content">
    <div class="container-fluid mt-4">

        <!-- 🔹 Barra superior -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h3 class="fw-bold text-dark mb-0">📊 Reporte de Ventas</h3>
            <div>
                <a href="<%= request.getContextPath() %>/index.jsp" class="btn btn-secondary me-2">
                    <i class="bi bi-arrow-left-circle"></i> Volver al Menú
                </a>
                <a href="<%= request.getContextPath() %>/ReporteVentasPDF" target="_blank" class="btn btn-danger">
                    <i class="bi bi-file-earmark-pdf"></i> Exportar a PDF
                </a>
            </div>
        </div>

        <!-- 🔹 Tabla de ventas -->
        <div class="card shadow-sm border-0 mb-4">
            <div class="card-body">
                <table class="table table-bordered table-striped align-middle mb-0">
                    <thead class="table-dark text-center">
                        <tr>
                            <th>ID Venta</th>
                            <th>No. Factura</th>
                            <th>Serie</th>
                            <th>Fecha Venta</th>
                            <th>Cliente</th>
                            <th>Total (Q)</th>
                        </tr>
                    </thead>
                    <tbody>
                    <%
                        List<Map<String, Object>> ventas = (List<Map<String, Object>>) request.getAttribute("ventas");
                        if (ventas != null && !ventas.isEmpty()) {
                            for (Map<String, Object> v : ventas) {
                    %>
                        <tr>
                            <td class="text-center"><%= v.get("id_venta") %></td>
                            <td class="text-center"><%= v.get("no_factura") %></td>
                            <td class="text-center"><%= v.get("serie") %></td>
                            <td class="text-center"><%= v.get("fecha_venta") %></td>
                            <td><%= v.get("cliente") %></td>
                            <td class="text-end">Q <%= String.format("%.2f", v.get("total")) %></td>
                        </tr>
                    <%
                            }
                        } else {
                    %>
                        <tr><td colspan="6" class="text-center text-muted py-3">No hay registros disponibles</td></tr>
                    <%
                        }
                    %>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- 🔹 Mensaje informativo -->
        <%
            String alerta = (String) request.getAttribute("alerta");
            if (alerta != null) {
        %>
            <div class="alert alert-info text-center mt-3 fs-6">
                <%= alerta %>
            </div>
        <%
            }
        %>

        <!-- 🔹 Gráfico de ventas por cliente -->
        <div class="card shadow-sm border-0 mt-5 mb-5">
            <div class="card-body">
                <h5 class="card-title text-center mb-4">Gráfico de Ventas por Cliente</h5>
                <canvas id="graficoVentas" height="120"></canvas>
            </div>
        </div>

    </div>
</div> <!-- Cierre de main-content -->

<!-- 🔹 Script del gráfico -->
<script>
const ctx = document.getElementById('graficoVentas').getContext('2d');
const datos = [
    <% if (ventas != null) {
           for (Map<String, Object> v : ventas) { %>
               { cliente: "<%= v.get("cliente") %>", total: <%= v.get("total") %> },
    <%     }
       } %>
];

const clientes = datos.map(d => d.cliente);
const totales = datos.map(d => d.total);

if (clientes.length > 0) {
    new Chart(ctx, {
        type: 'bar',
        data: {
            labels: clientes,
            datasets: [{
                label: 'Total de Ventas (Q)',
                data: totales,
                backgroundColor: 'rgba(54, 162, 235, 0.8)',
                borderRadius: 6,
                barThickness: 30
            }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: { display: false },
                title: { display: true, text: 'Ventas por Cliente', font: { size: 18 } }
            },
            scales: { y: { beginAtZero: true } }
        }
    });
}
</script>

</body>
</html>
