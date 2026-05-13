<%@ Page Title="Tổng Quan Hệ Thống" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebBanTraSua.Admin.Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Tổng Quan Hệ Thống
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Stat Cards Row -->
    <div class="row g-4 mb-5">
        <!-- Revenue Card -->
        <div class="col-xl-3 col-md-6">
            <div class="card stat-card border-0 bg-white p-3">
                <div class="card-body d-flex align-items-center gap-3">
                    <div class="rounded-circle p-3 d-flex align-items-center justify-content-center" style="background-color: #fdf5ef; width: 60px; height: 60px;">
                        <i class="fa-solid fa-money-bill-trend-up text-warning fs-3"></i>
                    </div>
                    <div>
                        <span class="text-muted small fw-semibold">Tổng Doanh Thu</span>
                        <h3 class="fw-bold mb-0 mt-1" style="color: #2C1E16;"><asp:Label ID="lblRevenue" runat="server"></asp:Label></h3>
                    </div>
                </div>
            </div>
        </div>

        <!-- Orders Card -->
        <div class="col-xl-3 col-md-6">
            <div class="card stat-card border-0 bg-white p-3">
                <div class="card-body d-flex align-items-center gap-3">
                    <div class="rounded-circle p-3 d-flex align-items-center justify-content-center" style="background-color: #eef7f6; width: 60px; height: 60px;">
                        <i class="fa-solid fa-clipboard-list text-success fs-3"></i>
                    </div>
                    <div>
                        <span class="text-muted small fw-semibold">Tổng Đơn Hàng</span>
                        <h3 class="fw-bold mb-0 mt-1" style="color: #2C1E16;"><asp:Label ID="lblOrdersCount" runat="server"></asp:Label></h3>
                    </div>
                </div>
            </div>
        </div>

        <!-- Products Card -->
        <div class="col-xl-3 col-md-6">
            <div class="card stat-card border-0 bg-white p-3">
                <div class="card-body d-flex align-items-center gap-3">
                    <div class="rounded-circle p-3 d-flex align-items-center justify-content-center" style="background-color: #fff9eb; width: 60px; height: 60px;">
                        <i class="fa-solid fa-mug-hot text-primary fs-3"></i>
                    </div>
                    <div>
                        <span class="text-muted small fw-semibold">Sản Phẩm Menu</span>
                        <h3 class="fw-bold mb-0 mt-1" style="color: #2C1E16;"><asp:Label ID="lblProductsCount" runat="server"></asp:Label></h3>
                    </div>
                </div>
            </div>
        </div>

        <!-- Customers Card -->
        <div class="col-xl-3 col-md-6">
            <div class="card stat-card border-0 bg-white p-3">
                <div class="card-body d-flex align-items-center gap-3">
                    <div class="rounded-circle p-3 d-flex align-items-center justify-content-center" style="background-color: #ebf3fc; width: 60px; height: 60px;">
                        <i class="fa-solid fa-users text-info fs-3"></i>
                    </div>
                    <div>
                        <span class="text-muted small fw-semibold">Khách Hàng</span>
                        <h3 class="fw-bold mb-0 mt-1" style="color: #2C1E16;"><asp:Label ID="lblCustomersCount" runat="server"></asp:Label></h3>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Charts Row -->
    <div class="row g-4 mb-5">
        <!-- Daily Revenue Line Chart -->
        <div class="col-lg-8">
            <div class="card border-0 shadow-sm" style="border-radius: 16px;">
                <div class="card-header border-0 bg-white pt-4 px-4 pb-0">
                    <h5 class="fw-bold m-0" style="color: #2C1E16;">
                        <i class="fa-solid fa-chart-line text-warning me-2"></i>Lịch Sử Doanh Thu (7 Ngày Gần Nhất)
                    </h5>
                </div>
                <div class="card-body px-4 pb-4">
                    <div style="position: relative; height: 320px;">
                        <canvas id="dailyRevenueChart"></canvas>
                    </div>
                </div>
            </div>
        </div>

        <!-- Category Share Pie Chart -->
        <div class="col-lg-4">
            <div class="card border-0 shadow-sm" style="border-radius: 16px;">
                <div class="card-header border-0 bg-white pt-4 px-4 pb-0">
                    <h5 class="fw-bold m-0" style="color: #2C1E16;">
                        <i class="fa-solid fa-chart-pie text-warning me-2"></i>Doanh Thu Theo Loại
                    </h5>
                </div>
                <div class="card-body px-4 pb-4">
                    <div style="position: relative; height: 320px; display: flex; align-items: center; justify-content: center;">
                        <canvas id="categoryShareChart" style="max-height: 280px;"></canvas>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- ChartJS Script -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            // 1. Data injected from C#
            const dailyLabels = <%= DailyLabelsJson %>;
            const dailyData = <%= DailyDataJson %>;
            const categoryLabels = <%= CategoryLabelsJson %>;
            const categoryData = <%= CategoryDataJson %>;

            // 2. Render Daily Revenue Chart
            const ctxDaily = document.getElementById('dailyRevenueChart').getContext('2d');
            new Chart(ctxDaily, {
                type: 'line',
                data: {
                    labels: dailyLabels.length > 0 ? dailyLabels : ['Chưa có dữ liệu'],
                    datasets: [{
                        label: 'Doanh thu (đ)',
                        data: dailyData.length > 0 ? dailyData : [0],
                        borderColor: '#C87941',
                        backgroundColor: 'rgba(200, 121, 65, 0.05)',
                        borderWidth: 3,
                        fill: true,
                        tension: 0.35,
                        pointBackgroundColor: '#874C27',
                        pointBorderColor: '#fff',
                        pointHoverRadius: 6
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: { display: false }
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            ticks: {
                                callback: function(value) {
                                    return value.toLocaleString('vi-VN') + 'đ';
                                }
                            },
                            grid: { color: 'rgba(0, 0, 0, 0.03)' }
                        },
                        x: {
                            grid: { display: false }
                        }
                    }
                }
            });

            // 3. Render Category Share Chart
            const ctxCat = document.getElementById('categoryShareChart').getContext('2d');
            new Chart(ctxCat, {
                type: 'doughnut',
                data: {
                    labels: categoryLabels.length > 0 ? categoryLabels : ['Chưa có dữ liệu'],
                    datasets: [{
                        data: categoryData.length > 0 ? categoryData : [100],
                        backgroundColor: [
                            '#C87941', // Primary brown
                            '#E2B15B', // Accent Gold
                            '#874C27', // Secondary dark brown
                            '#5B8266', // Calm green
                            '#4A5859'  // Steel grey
                        ],
                        borderWidth: 2,
                        borderColor: '#fff'
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            position: 'bottom',
                            labels: {
                                boxWidth: 12,
                                font: { size: 11, family: "'Inter', sans-serif" }
                            }
                        }
                    },
                    cutout: '65%'
                }
            });
        });
    </script>

    <!-- Main Dashboard Action Panels -->
    <div class="row">
        <div class="col-12">
            <div class="card border-0 shadow-sm" style="border-radius: 16px;">
                <div class="card-header border-0 bg-white pt-4 px-4 pb-2 d-flex justify-content-between align-items-center">
                    <h5 class="fw-bold m-0" style="color: #2C1E16;">
                        <i class="fa-solid fa-bell text-warning me-2 animate-bounce"></i>Đơn Hàng Mới Cần Xử Lý
                    </h5>
                    <span class="badge bg-danger rounded-pill px-3 py-2"><asp:Label ID="lblPendingBadge" runat="server"></asp:Label> đơn chờ duyệt</span>
                </div>
                <div class="card-body px-4 pb-4">
                    <asp:Label ID="lblNoPending" runat="server" CssClass="alert alert-success d-block py-3 text-center fw-medium mt-2" style="border-radius: 12px;" Visible="false"></asp:Label>
                    
                    <asp:Panel ID="pnlPending" runat="server">
                        <div class="table-responsive mt-2">
                            <table class="table align-middle table-hover">
                                <thead>
                                    <tr class="text-muted small text-uppercase">
                                        <th scope="col" style="width: 10%;">Mã ĐH</th>
                                        <th scope="col" style="width: 25%;">Khách hàng</th>
                                        <th scope="col" style="width: 20%;">Thời gian đặt</th>
                                        <th scope="col" style="width: 15%;">Tổng tiền</th>
                                        <th scope="col" style="width: 30%;" class="text-end">Hành động</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:Repeater ID="rptPendingOrders" runat="server" OnItemCommand="rptPendingOrders_ItemCommand">
                                        <ItemTemplate>
                                            <tr>
                                                <td class="fw-bold text-muted">#<%# Eval("ID") %></td>
                                                <td>
                                                    <div class="fw-bold" style="color: #8c5a2b;"><%# Eval("FullName") %></div>
                                                    <span class="text-muted small">@<%# Eval("Username") %></span>
                                                </td>
                                                <td><%# Convert.ToDateTime(Eval("NgayDat")).ToString("dd/MM/yyyy HH:mm") %></td>
                                                <td class="fw-bold" style="color: #C87941;"><%# Convert.ToDecimal(Eval("TongTien")).ToString("N0") %>đ</td>
                                                <td class="text-end">
                                                    <div class="d-flex gap-2 justify-content-end">
                                                        <asp:LinkButton ID="btnApprove" runat="server" CommandName="Approve" CommandArgument='<%# Eval("ID") %>' 
                                                            CssClass="btn btn-sm btn-success btn-action-admin text-white d-flex align-items-center gap-1">
                                                            <i class="fa-solid fa-truck-fast"></i> Duyệt Giao
                                                        </asp:LinkButton>
                                                        <asp:LinkButton ID="btnCancel" runat="server" CommandName="Cancel" CommandArgument='<%# Eval("ID") %>' 
                                                            CssClass="btn btn-sm btn-outline-danger btn-action-admin d-flex align-items-center gap-1"
                                                            OnClientClick="return confirm('Bạn có thực sự muốn hủy đơn hàng này không?');">
                                                            <i class="fa-solid fa-xmark"></i> Hủy Đơn
                                                        </asp:LinkButton>
                                                    </div>
                                                </td>
                                            </tr>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </tbody>
                            </table>
                        </div>
                    </asp:Panel>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
