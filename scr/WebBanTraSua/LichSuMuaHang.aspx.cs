using System;
using System.Data;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebBanTraSua.BLL;
using WebBanTraSua.DTO;

namespace WebBanTraSua
{
    public partial class LichSuMuaHang : Page
    {
        private DonHangBLL donHangBLL = new DonHangBLL();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["User"] == null)
            {
                string returnUrl = Request.RawUrl;
                Response.Redirect("DangNhap.aspx?ReturnUrl=" + Server.UrlEncode(returnUrl));
                return;
            }

            if (!IsPostBack)
            {
                UserDTO user = (UserDTO)Session["User"];
                LoadOrders(user.ID);
            }
        }

        private void LoadOrders(int userId)
        {
            DataTable dt = donHangBLL.LayLichSuDonHang(userId);

            if (dt == null || dt.Rows.Count == 0)
            {
                pnlOrders.Visible = false;
                lblThongBao.Visible = true;
                lblThongBao.Text = "Bạn chưa thực hiện đơn hàng nào! Quay lại <a href='SanPham.aspx' class='fw-bold' style='color:#C87941; text-decoration:none;'>Thực Đơn</a> để chọn món nhé.";
            }
            else
            {
                pnlOrders.Visible = true;
                lblThongBao.Visible = false;

                rptOrders.DataSource = dt;
                rptOrders.DataBind();
            }
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
                    return "<span class='badge bg-warning text-dark px-3 py-2 small fw-bold' style='border-radius:30px;'>Chờ Xử Lý</span>";
                case "Đang Giao":
                    return "<span class='badge bg-info text-white px-3 py-2 small fw-bold' style='border-radius:30px;'>Đang Giao</span>";
                case "Hoàn Thành":
                    return "<span class='badge bg-success text-white px-3 py-2 small fw-bold' style='border-radius:30px;'>Hoàn Thành</span>";
                case "Hủy":
                    return "<span class='badge bg-danger text-white px-3 py-2 small fw-bold' style='border-radius:30px;'>Đã Hủy</span>";
                default:
                    return "<span class='badge bg-secondary text-white px-3 py-2 small fw-bold' style='border-radius:30px;'>" + status + "</span>";
            }
        }

        protected void rptOrders_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Details")
            {
                int donHangId = Convert.ToInt32(e.CommandArgument);

                // Fetch details
                DataTable dtDetails = donHangBLL.LayChiTietDonHang(donHangId);
                
                // Fetch main order info to display in modal
                UserDTO user = (UserDTO)Session["User"];
                DataTable dtOrders = donHangBLL.LayLichSuDonHang(user.ID);
                DataRow orderRow = dtOrders.AsEnumerable().FirstOrDefault(x => x.Field<int>("ID") == donHangId);

                if (orderRow != null && dtDetails != null)
                {
                    lblModalOrderID.Text = donHangId.ToString();
                    
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
        }

        protected void btnCloseModal_Click(object sender, EventArgs e)
        {
            pnlModal.Visible = false;
        }
    }
}
