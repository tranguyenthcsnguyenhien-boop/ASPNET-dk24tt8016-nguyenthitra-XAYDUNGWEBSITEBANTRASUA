using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web.UI;
using WebBanTraSua.BLL;
using WebBanTraSua.DTO;

namespace WebBanTraSua
{
    public partial class ThanhToan : Page
    {
        private GioHangBLL gioHangBLL = new GioHangBLL();
        private DonHangBLL donHangBLL = new DonHangBLL();
        private UserBLL userBLL = new UserBLL();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["User"] == null)
            {
                string returnUrl = Request.RawUrl;
                Response.Redirect("DangNhap.aspx?ReturnUrl=" + Server.UrlEncode(returnUrl));
                return;
            }

            if (string.IsNullOrEmpty(Request.QueryString["items"]))
            {
                Response.Redirect("GioHang.aspx");
                return;
            }

            if (!IsPostBack)
            {
                UserDTO sessionUser = (UserDTO)Session["User"];
                
                // Lay thong tin chi tiet hon tu DB de dam bao co SDT (neu co)
                UserDTO fullUser = userBLL.LayThongTinNguoiDung(sessionUser.ID);
                if (fullUser != null)
                {
                    txtFullName.Text = fullUser.FullName;
                    txtPhone.Text = fullUser.Phone;
                }
                else
                {
                    txtFullName.Text = sessionUser.FullName;
                }

                LoadSummary(sessionUser.ID);
            }
        }

        private List<int> GetSelectedProductIds()
        {
            string itemsStr = Request.QueryString["items"];
            if (string.IsNullOrEmpty(itemsStr)) return new List<int>();

            return itemsStr.Split(',')
                           .Select(x => { int id; return int.TryParse(x, out id) ? id : 0; })
                           .Where(x => x > 0)
                           .ToList();
        }

        private void LoadSummary(int userId)
        {
            List<int> selectedIds = GetSelectedProductIds();
            if (selectedIds.Count == 0)
            {
                Response.Redirect("GioHang.aspx");
                return;
            }

            var allCartItems = gioHangBLL.LayGioHang(userId);
            var selectedCartItems = allCartItems.Where(x => selectedIds.Contains(x.ID)).ToList();

            if (selectedCartItems.Count == 0)
            {
                Response.Redirect("GioHang.aspx");
                return;
            }

            rptSummary.DataSource = selectedCartItems;
            rptSummary.DataBind();

            decimal total = selectedCartItems.Sum(x => x.ThanhTien);
            lblTongTienPhu.Text = total.ToString("N0") + "đ";
            lblTongTien.Text = total.ToString("N0") + "đ";
        }

        protected void btnOrder_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            UserDTO sessionUser = (UserDTO)Session["User"];
            if (sessionUser == null) return;

            List<int> selectedIds = GetSelectedProductIds();
            var allCartItems = gioHangBLL.LayGioHang(sessionUser.ID);
            var selectedCartItems = allCartItems.Where(x => selectedIds.Contains(x.ID)).ToList();

            if (selectedCartItems.Count == 0)
            {
                Response.Redirect("GioHang.aspx");
                return;
            }

            decimal total = selectedCartItems.Sum(x => x.ThanhTien);
            string deliveryAddress = $"{txtFullName.Text.Trim()} | {txtPhone.Text.Trim()} | {txtAddress.Text.Trim()}";

            // 1. Tao DonHangDTO
            DonHangDTO donHang = new DonHangDTO
            {
                UserID = sessionUser.ID,
                NgayDat = DateTime.Now,
                TongTien = total,
                TrangThai = "Chờ Xử Lý",
                DiaChiGiao = deliveryAddress
            };

            // 2. Tao danh sach ChiTietDonHangDTO
            List<ChiTietDonHangDTO> dsChiTiet = new List<ChiTietDonHangDTO>();
            foreach (var item in selectedCartItems)
            {
                dsChiTiet.Add(new ChiTietDonHangDTO
                {
                    SanPhamID = item.ID,
                    SoLuong = item.SoLuong,
                    DonGia = item.Gia
                });
            }

            // 3. Luu vao database qua BLL (su dung SqlTransaction)
            if (donHangBLL.LuuDonHang(donHang, dsChiTiet))
            {
                // Thong bao thanh cong va hien panel success
                pnlThanhToan.Visible = false;
                pnlSuccess.Visible = true;

                lblOrderCode.Text = donHang.ID.ToString();
                lblSuccessName.Text = txtFullName.Text.Trim();
                lblSuccessPhone.Text = txtPhone.Text.Trim();
                lblSuccessAddress.Text = txtAddress.Text.Trim();
                lblSuccessTotal.Text = total.ToString("N0") + "đ";
            }
            else
            {
                // Hien thong bao loi qua Alert script
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Có lỗi xảy ra khi xử lý đơn hàng. Vui lòng thử lại sau!');", true);
            }
        }
    }
}
