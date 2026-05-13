using System;
using System.Data;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebBanTraSua.BLL;

namespace WebBanTraSua.Admin
{
    public partial class Default : Page
    {
        private DonHangBLL donHangBLL = new DonHangBLL();
        private SanPhamBLL sanPhamBLL = new SanPhamBLL();
        private UserBLL userBLL = new UserBLL();

        public string DailyLabelsJson { get; set; } = "[]";
        public string DailyDataJson { get; set; } = "[]";
        public string CategoryLabelsJson { get; set; } = "[]";
        public string CategoryDataJson { get; set; } = "[]";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadDashboard();
            }
        }

        private void LoadDashboard()
        {
            // 1. Tai toan bo don hang
            DataTable dtOrders = donHangBLL.LayTatCaDonHang();
            
            // Tinh tong doanh thu (cac don hang da Hoan Thanh)
            decimal totalRevenue = dtOrders.AsEnumerable()
                                           .Where(x => x.Field<string>("TrangThai") == "Hoàn Thành")
                                           .Sum(x => Convert.ToDecimal(x["TongTien"]));
            
            lblRevenue.Text = totalRevenue.ToString("N0") + "đ";
            lblOrdersCount.Text = dtOrders.Rows.Count.ToString("N0");

            // 2. Tai tong san pham
            DataTable dtProducts = sanPhamBLL.LayDanhSachSanPhamTatCa();
            lblProductsCount.Text = dtProducts.Rows.Count.ToString("N0");

            // 3. Tai tong so khach hang
            int customersCount = userBLL.DemSoLuongKhachHang();
            lblCustomersCount.Text = customersCount.ToString("N0");

            // 4. Loc danh sach don hang cho xu ly
            var pendingOrders = dtOrders.AsEnumerable()
                                        .Where(x => x.Field<string>("TrangThai") == "Chờ Xử Lý")
                                        .ToList();

            lblPendingBadge.Text = pendingOrders.Count.ToString();

            if (pendingOrders.Count == 0)
            {
                pnlPending.Visible = false;
                lblNoPending.Visible = true;
                lblNoPending.Text = "<i class='fa-solid fa-circle-check me-2'></i>Hiện không có đơn hàng nào chờ duyệt giao hàng!";
            }
            else
            {
                pnlPending.Visible = true;
                lblNoPending.Visible = false;
                
                // Convert back to DataTable to bind
                DataTable dtPending = pendingOrders.CopyToDataTable();
                rptPendingOrders.DataSource = dtPending;
                rptPendingOrders.DataBind();
            }

            // 5. Tai du lieu bieu do Doanh thu 7 ngay
            DataTable dtDaily = donHangBLL.LayDoanhThu7NgayGanNhat();
            var dailyLabels = dtDaily.AsEnumerable().Select(x => x.Field<string>("Ngay")).ToList();
            var dailyData = dtDaily.AsEnumerable().Select(x => Convert.ToDecimal(x["DoanhThu"])).ToList();
            
            DailyLabelsJson = Newtonsoft.Json.JsonConvert.SerializeObject(dailyLabels);
            DailyDataJson = Newtonsoft.Json.JsonConvert.SerializeObject(dailyData);

            // 6. Tai du lieu bieu do Ty trong danh muc
            DataTable dtCatShare = donHangBLL.LayTrongLuongDoanhThuTheoLoai();
            var catLabels = dtCatShare.AsEnumerable().Select(x => x.Field<string>("TenLoai")).ToList();
            var catData = dtCatShare.AsEnumerable().Select(x => Convert.ToDecimal(x["DoanhThu"])).ToList();

            CategoryLabelsJson = Newtonsoft.Json.JsonConvert.SerializeObject(catLabels);
            CategoryDataJson = Newtonsoft.Json.JsonConvert.SerializeObject(catData);
        }

        protected void rptPendingOrders_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int donHangId = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "Approve")
            {
                // Chuyen trang thai sang "Đang Giao"
                if (donHangBLL.CapNhatTrangThaiDonHang(donHangId, "Đang Giao"))
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Đã duyệt giao hàng thành công cho đơn #" + donHangId + "!');", true);
                }
            }
            else if (e.CommandName == "Cancel")
            {
                // Chuyen trang thai sang "Hủy"
                if (donHangBLL.CapNhatTrangThaiDonHang(donHangId, "Hủy"))
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Đã hủy thành công đơn hàng #" + donHangId + "!');", true);
                }
            }

            // Load lai du lieu Dashboard sau khi cap nhat
            LoadDashboard();
        }
    }
}
