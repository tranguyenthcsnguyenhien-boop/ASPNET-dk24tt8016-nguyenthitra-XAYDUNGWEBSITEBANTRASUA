using System;
using System.Collections.Generic;
using System.Web.UI.WebControls;
using WebBanTraSua.BLL;
using WebBanTraSua.DTO;
using System.Linq;

namespace WebBanTraSua
{
    public partial class GioHang : System.Web.UI.Page
    {
        GioHangBLL gioHangBLL = new GioHangBLL();

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

                if (Request.QueryString["action"] == "add" && Request.QueryString["id"] != null)
                {
                    int sanPhamId;
                    if (int.TryParse(Request.QueryString["id"], out sanPhamId))
                    {
                        gioHangBLL.ThemVaoGio(user.ID, sanPhamId, 1);
                        Response.Redirect("GioHang.aspx");
                    }
                }
                
                LoadGioHang(user.ID);
            }
        }

        private void LoadGioHang(int userId)
        {
            var gioHang = gioHangBLL.LayGioHang(userId);
            
            if (gioHang == null || gioHang.Count == 0)
            {
                pnlGioHang.Visible = false;
                lblThongBao.Visible = true;
                lblThongBao.Text = "Giỏ hàng của bạn đang trống! Hãy quay lại <a href='SanPham.aspx' class='fw-bold' style='color:#C87941; text-decoration:none;'>Thực Đơn</a> để chọn món nhé.";
            }
            else
            {
                pnlGioHang.Visible = true;
                lblThongBao.Visible = false;
                
                rptGioHang.DataSource = gioHang;
                rptGioHang.DataBind();
                
                TinhToanTongTien();
            }
        }

        protected void rptGioHang_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            UserDTO user = (UserDTO)Session["User"];
            if (user == null) return;

            int sanPhamId = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "Tang")
            {
                gioHangBLL.ThemVaoGio(user.ID, sanPhamId, 1);
            }
            else if (e.CommandName == "Giam")
            {
                gioHangBLL.ThemVaoGio(user.ID, sanPhamId, -1);
            }
            else if (e.CommandName == "Xoa")
            {
                gioHangBLL.XoaKhoiGio(user.ID, sanPhamId);
            }

            LoadGioHang(user.ID);
        }

        protected void chkChon_CheckedChanged(object sender, EventArgs e)
        {
            TinhToanTongTien();
        }

        private void TinhToanTongTien()
        {
            decimal tongTien = 0;
            foreach (RepeaterItem item in rptGioHang.Items)
            {
                if (item.ItemType == ListItemType.Item || item.ItemType == ListItemType.AlternatingItem)
                {
                    CheckBox chk = (CheckBox)item.FindControl("chkChon");
                    HiddenField hdnThanhTien = (HiddenField)item.FindControl("hdnThanhTien");
                    
                    if (chk != null && chk.Checked && hdnThanhTien != null)
                    {
                        tongTien += Convert.ToDecimal(hdnThanhTien.Value);
                    }
                }
            }
            
            lblTongTienPhu.Text = tongTien.ToString("N0") + "đ";
            lblTongTien.Text = tongTien.ToString("N0") + "đ";
        }

        protected void btnThanhToan_Click(object sender, EventArgs e)
        {
            List<string> selectedItems = new List<string>();
            foreach (RepeaterItem item in rptGioHang.Items)
            {
                if (item.ItemType == ListItemType.Item || item.ItemType == ListItemType.AlternatingItem)
                {
                    CheckBox chk = (CheckBox)item.FindControl("chkChon");
                    HiddenField hdnID = (HiddenField)item.FindControl("hdnID");
                    
                    if (chk != null && chk.Checked && hdnID != null)
                    {
                        selectedItems.Add(hdnID.Value);
                    }
                }
            }

            if (selectedItems.Count > 0)
            {
                string ids = string.Join(",", selectedItems);
                Response.Redirect("ThanhToan.aspx?items=" + ids);
            }
            else
            {
                // JavaScript alert nếu không chọn gì
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Vui lòng chọn ít nhất 1 sản phẩm để thanh toán!');", true);
            }
        }
    }
}