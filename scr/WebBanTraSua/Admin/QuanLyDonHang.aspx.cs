using System;
using System.Data;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebBanTraSua.BLL;

namespace WebBanTraSua.Admin
{
    public partial class QuanLyDonHang : Page
    {
        private DonHangBLL donHangBLL = new DonHangBLL();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadOrders();
            }
        }

        private void LoadOrders()
        {
            DataTable dt = donHangBLL.LayTatCaDonHang();
            gvOrders.DataSource = dt;
            gvOrders.DataBind();
        }

        public string FormatAddress(string rawAddress)
        {
            if (string.IsNullOrEmpty(rawAddress)) return "";
            string[] parts = rawAddress.Split('|');
            if (parts.Length >= 3)
            {
                return parts[2].Trim();
            }
            return rawAddress;
        }

        public string GetStatusBadge(string status)
        {
            switch (status)
            {
                case "Chờ Xử Lý":
                    return "<span class='badge bg-warning text-dark px-2.5 py-1.5 small fw-bold' style='border-radius:30px;'><i class='fa-solid fa-clock me-1'></i> Chờ Xử Lý</span>";
                case "Đang Giao":
                    return "<span class='badge bg-info text-white px-2.5 py-1.5 small fw-bold' style='border-radius:30px;'><i class='fa-solid fa-truck me-1'></i> Đang Giao</span>";
                case "Hoàn Thành":
                    return "<span class='badge bg-success text-white px-2.5 py-1.5 small fw-bold' style='border-radius:30px;'><i class='fa-solid fa-circle-check me-1'></i> Hoàn Thành</span>";
                case "Hủy":
                    return "<span class='badge bg-danger text-white px-2.5 py-1.5 small fw-bold' style='border-radius:30px;'><i class='fa-solid fa-circle-xmark me-1'></i> Đã Hủy</span>";
                default:
                    return "<span class='badge bg-secondary text-white px-2.5 py-1.5 small fw-bold' style='border-radius:30px;'>" + status + "</span>";
            }
        }

        protected void gvOrders_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int orderId = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "ViewDetails")
            {
                DataTable dtDetails = donHangBLL.LayChiTietDonHang(orderId);
                DataTable dtOrders = donHangBLL.LayTatCaDonHang();
                DataRow orderRow = dtOrders.AsEnumerable().FirstOrDefault(x => x.Field<int>("ID") == orderId);

                if (orderRow != null && dtDetails != null)
                {
                    lblModalOrderID.Text = orderId.ToString();
                    
                    rptOrderDetails.DataSource = dtDetails;
                    rptOrderDetails.DataBind();

                    decimal tongTien = Convert.ToDecimal(orderRow["TongTien"]);
                    lblModalSubtotal.Text = tongTien.ToString("N0") + "đ";
                    lblModalTotal.Text = tongTien.ToString("N0") + "đ";

                    string rawAddress = orderRow["DiaChiGiao"].ToString();
                    string[] parts = rawAddress.Split('|');
                    if (parts.Length >= 3)
                    {
                        litModalAddress.Text = $"<strong>Họ tên:</strong> {parts[0].Trim()}<br/><strong>SĐT:</strong> {parts[1].Trim()}<br/><strong>Địa chỉ:</strong> {parts[2].Trim()}";
                    }
                    else
                    {
                        litModalAddress.Text = rawAddress;
                    }

                    pnlModal.Visible = true;
                }
            }
            else if (e.CommandName == "Approve")
            {
                if (donHangBLL.CapNhatTrangThaiDonHang(orderId, "Đang Giao"))
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Đã duyệt đơn hàng #" + orderId + " sang trạng thái Đang Giao!');", true);
                    LoadOrders();
                }
            }
            else if (e.CommandName == "Complete")
            {
                if (donHangBLL.CapNhatTrangThaiDonHang(orderId, "Hoàn Thành"))
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Đã duyệt đơn hàng #" + orderId + " sang trạng thái Hoàn Thành!');", true);
                    LoadOrders();
                }
            }
            else if (e.CommandName == "Cancel")
            {
                if (donHangBLL.CapNhatTrangThaiDonHang(orderId, "Hủy"))
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Đã hủy đơn hàng #" + orderId + " thành công!');", true);
                    LoadOrders();
                }
            }
        }

        protected void btnCloseModal_Click(object sender, EventArgs e)
        {
            pnlModal.Visible = false;
        }
    }
}
